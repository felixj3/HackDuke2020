# Personal Notes

If I have model fields like course1, course2, etc. (kind of lame to have variables like that when you could do an array relation), I can access them without having to hardcode those values. First make the string with an index for the loop like: “course#{num}” and then with the model, do model.attributes[string] so basically use the string as the key. Doing it like model.(string.to_sym) doesn’t work because it thinks it’s a method name, but that’s very powerful as a method name

HTML form option for dropdown only has options that can’t have a string. I don’t know how other people do it but I couldn’t pass over the string (through params that rails automatically does for you) with spaces mostly due to network issues, so I passed over the index into the array or hash map and then later got it back. Used @hash.each_with_index

POST request can’t access session or CSRF stuff because it was disabled on our project since we didn’t want to mess with security. However, GET requests can, but we can’t pass an instance variable between different methods in a controller directly. So I just passed over the ID we needed of the current user (got with the GET) as another field in the form and then params can pick it up. I didn’t want to it display on the view so had this syntax: 

<input type="hidden" style="display: none" name="user_id" value= <%= "#{@curr_user_id}" %> />

That style is invisible and doesn’t affect anything I believe 

redirect_to some_prefix_url can be used in the controllers to redirect to another url, very powerful

Db:rollback STEP=7
