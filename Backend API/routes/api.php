<?php
use App\Models\Cateogry;
use App\Models\Gift;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Hash;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


// Register
Route::post('/register', function (Request $request) {
    $user = User::where("name", $request->name)->first();
    if ($user) {
        return response()->json(['message' => 'Username already exists', "status" => 400]);
    }
    $user = new User();
    $user->name = $request->name;
    $user->email = $request->email;
    $user->password = bcrypt($request->password);
    $user->save();
    return response()->json(['message' => 'User registered successfully', "status" => 200]);
});
// Login
Route::post('/login', function (Request $request) {
    $user = User::where('name', $request->name)->first();
    if ($user && Hash::check($request->password, $user->password)) {
        return response()->json(['status' => 200, 'message' => 'the Login was successfully','user_id' => $user->id ]);
    }
    return response()->json(['message' => 'Invalid credentials']);
});



Route::get('/getgifts', function (Request $request) {
    if ($request->has('category_id')) {
        $gifts = Gift::where('cat_id', $request->category_id)->get();
    } else {

        $gifts = Gift::all();
    }

    $categories = Cateogry::all();
    $favorites = [];
    if ($request->has('user_id')) {
        $user = User::find($request->user_id);
        if ($user) {
            $favorites = $user->favorites->pluck('id');
        }
    }

    return response()->json([
        "status" => 200,
        "gifts" => $gifts,
        "categories" => $categories,
        "favorites" => $favorites,
    ]);
});



Route::post('/addcateogry', function (Request $request) {
    $cat = Cateogry::where("name", $request->name)->first();
    if ($cat) {
        return response()->json(['message' => 'Cateogry already exists', "status" => 400]);
    }
    $cat = new Cateogry();
    $cat->name = $request->name;
    $cat->save();
    return response()->json(['message' => 'Cateogry registered successfully', "status" => 200]);
});



Route::get('/cateogrys', function () {
    $cat = Cateogry::all();
    return response()->json([
        "status" => 200,
        "categories" => $cat
    ]);
});

Route::post('/addgift', function (Request $request) {
    $validated = $request->validate([
        'name' => 'required|string|max:255',
        'price' => 'required|numeric',
        'cat_id' => 'required|integer',
        'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
    ]);

    $gift = Gift::where("name", $request->name)->first();
    if ($gift) {
        return response()->json(['message' => 'Gift already exists', "status" => 400]);
    }

    $gift = new Gift();
    $gift->name = $request->name;
    $gift->price = $request->price;
    $gift->cat_id = $request->cat_id;
    
    if ($request->hasFile('image') && $request->file('image')->isValid()) {
        $image = $request->file('image');
        $imagePath = $image->store('gifts', 'public');
        $gift->image = asset('storage/gifts/' . basename($imagePath));
    } else {
        return response()->json([
            'message' => 'No image file found or file is invalid',
            'status' => 400
        ]);
    }

    try {
        $gift->save();
        return response()->json(['message' => 'Gift registered successfully', "status" => 200]);
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Error saving gift: ' . $e->getMessage(),
            'status' => 500
        ]);
    }
});




Route::post('/add-to-favorites', function (Request $request) {
    $request->validate([
        'gift_id' => 'required|exists:gifts,id',
        'user_id' => 'required|exists:users,id',
    ]);

    $user = User::find($request->user_id);  
    $giftId = $request->gift_id;
    $user->favorites()->toggle($giftId);
    return response()->json(['message' => 'تم تحديث المفضلة']);
});



Route::get('/favorites/{userId}', function ($userId) {
    $user = User::findOrFail($userId);
    $favorites = $user->favorites; 
    return response()->json(["favorites" => $favorites]);
});