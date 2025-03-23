# APP Shared Pref

we'll see how you can store data to and read data from your local mobile device using SharedPreferences. SharedPreferences gives you a very simple store for your locally persisted data. If the data that you want to store in the local device is fairly simple and can be expressed in the form of key-value pairs, SharedPreferences is the right local persistence for you. As the name implies, SharedPreferences is often used to store preference data for your application, such as the theme of your application, the font size of your application. Each user can set his or her own preference that can be applied throughout the app. In order to use **SharedPreferences**, let's open pubspec.yaml and add in the right dependency. 

Note the UI simply has three text fields, one for Key, one for Value, and one for the Type of the value. And of course, there are the Set and Get buttons at the very bottom of the screen. I have an import statement for preferences_util.dart, that is the utility helper class that I'll be using to work with SharedPreferences.
PreferencesUtil, you'll see is a singleton class, so there is just a single instance of PreferencesUtil that we'll use across all of the pages of any app that we build.
These are the TextEditingControllers for the three text fields  that we see in the preferences_page.dart, the Key, Value, and Type controllers. In the initState method, I call preferencesUtil.init to initialize my preferencesUtil helper class. This will access and set up the single instance of the SharedPreferences plugin.

The SharedPreferences plugin allows you to store only primitive values as key-value pairs. So, you can store integers, booleans, strings, and list of strings, but you can't store complex data types.

And then I have the third TextField, which is where we'll specify the Type of the value that we want to store using SharedPreferences. This is important because based on the type of data that we want to store, we need to invoke a different API on the SharedPreferences plugin.

The first one is to be able to set a new key-value pair using SharedPreferences. Observe that it's onPressed handler is empty. The second button, the Get button is to be able to retrieve the value of a preference given a key. Again, its onPressed handler is currently empty. We'll fill those in in a little bit, but meanwhile, let's take a look at the more interesting file preferences_util.dart. This is a wrapper helper class that I have defined in the utils package. I have a reference to the SharedPreferences plugin. It has the late modifier because I'll initialize it in the init method. The _currentInstance variable holds a reference to the singleton instance of this class, the PreferencesUtil class, so this is the only object that we'll create and use across our app. Observe the question mark. The _currentInstance is a nullable object. I have an _internal constructor for PreferencesUtil and I have a factory constructor. the factory constructor , if I already have an object of the PreferencesUtil class defined, that is what I'm going to return from the factory constructor. If no _currentInstance is present, I'll use the internal constructor to create a _currentInstance. When we first use the PreferencesUtil, you can invoke the init method. Within the init method, I call await on SharedPreferences.getInstance to asynchronously retrieve an instance of the SharedPreferences plugin that we'll use to access and set key-value pairs. you'll see I have a number of setter methods. Notice that in order to set a key-value pair using SharedPreferences, you need to use the await keyword because setting of a preference is an asynchronous operation. This is because the SharedPreference plugin initially writes out the key-value pair to memory and then asynchronously persists it to disk, just as we have defined setters for the different primitive value types that we can set using SharedPreferences. We have getters to retrieve different primitive value types given a key. Here I have getter functions and each of these getter functions retrieve a value of a different type. They take a String key as an input argument and the return value is always different. Notice in the function definition, the return values all have question marks indicating that each get invocation on the SharedPreferences plugin can return a null value.  This is possible because it's possible that a particular key-value pair hasn't been set. In that case, if you try to get using a particular key, the return value will be null. Another thing to note in the body of these methods, notice there is no await keyword. That's because retrieving a value given a key is not an asynchronous operation. It's a synchronous operation. If you want to know what keys have been stored using SharedPreferences, you can invoke the getKeys function. This is my helper method, which invokes _sharedPreferences.getKeys to retrieve a set of all keys stored using SharedPreferences.

## Retrieving Key Value Pairs Using SharedPreferences 
Now that you've seen what the basic structure of the app looks like, let's wire up our onPressed handlers so that we can set preferences and we can retrieve the preferences that we previously set. I'm currently in the preferences_page.dart file and within the build method of our PreferencesPageState. you can see that I check to see whether the text is empty for any of the text fields, so if any of the text fields are empty, then we do nothing. All of the text fields need to be specified before we can use the Set button. Now, because we are using a text field, the value is initially available in the form of a string, we'll need to convert it to the right type before we actually set the SharedPreferences. You can see then I switch on the valueType that is the type of the value that we want to set whether it's an integer, boolean, and so on then I have case statements for the various types.

I handle the case where the type we're setting is an integer. In this case, I call int.parse valueString into an integer value, and then we call preferencesUtil.setInt key and value. I check to see if the valueString is equal to the string true, if yes, we accept that as the boolean true, all other strings will be considered false. Now, let's scroll down and wire up the onPressed handler of the getter as well. This is the onPressed handler, While retrieving preferences using our app, you only need to specify the key and the value type.  I have a switch statement switching on the type of value that we want to retrieve from SharedPreferences. With SharedPreferences, you want the data to persist even after the app is restarted and we can check this. 

## Storing the Last Search Term in SharedPreferences
Now that you know how to use SharedPreferences, we can use it for something useful. In this demo, we'll see how you can use SharedPreferences to store the most recently searched for term in your app. So, let's say the user can perform a number of searches and you always want to ensure that you store the last search term. 

I have a TextEditingController, the _searchController, that is associated with the Search text field that you can see in the my_home_page.dart, I have a variable that stores the last _searchTerm which is initialized to No searches yet, and if you look on the app at the very bottom, you see displayed No searches yet. Also in the init method, I call preferencesUtil.init to initilize the plugin and get an instance of the SharedPreferences plugin.

This is the Search text field that you see at the very top of the app. Now, the suffix of the text field has an IconButton that is the search button and its onPressed handler. Now, we won't actually be performing any searches. But when we press the search button, we check to see whether the text in the Search text field isNotEmpty. If it's not empty, that is there is some text. I invoke preferencesUtil.setSearchTerm and set the last search term in SharedPreferences,  Now, below that, I have an ElevatedButton that is for Recent searches.

In the onPressed handler for this ElevatedButton, I call setState and get the last search term from SharedPreferences, preferencesUtil. getSearchTerm. If it's null, I just set it to empty. Here I've retrieved the last search term and we'll display this in our page. Scroll a little further down and you'll see a ListTile. You can see the title of this ListTile which displays the last term that we searched for, stored in search term. There is also a delete Icon. Tapping on the delete Icon will basically call preferencesUtil.removeSearchTerm which does deletes the key entirely from SharedPreferences. Now, let's take a look at preferences_util.dart. This is where we interact with the SharedPreferences plugin. Now, the basic structure of PreferencesUtil is what we have seen before. It's set up as a singleton class. 
