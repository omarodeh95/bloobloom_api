Two APIs were developed to server admin and users needs regarding interacting with store items.

The admin is allowed to manage the store through performing CRUD operations for frames lenses and their prices. While the customer is allowed to list them per his preferred currency.

The authentication of a user will be by using a token. This token must be sent in each request to identify the user. for easy of use, the token expiry was left without expiration date.

For simplicity, The first user registration will be considered as Admin. Admin has access to manage all inventory details in addition to users management. The following registration will be considered as customers. Only a user with Admin role can change the type of user (Admin/User) and do implement CRUD operations. A user with customer type is only allowed to manage his account.

As the items will be shown by the customer preferred currency, the currency is set to USD by default. However, the customer is able to change his preferred currency, note that changing a currency will affect the new frames and lenses and basket data.

The customer is able to list all ACTIVE frames, in addition to all lenses. He/She can interact with the frames by "creating a glass" and adding it his/her basket. The basket maintain user's items through his/her current session.

Checking out a basket will only subtract the frame stock by 1 and the lens by 2. This is not the proper way to handle such request. However, there must be payment in addition to store and track this purchase process.

This application is not configured to work on production environment.

For more details about the api supported endpoints you can find more in the following link
https://documenter.getpostman.com/view/22681728/2s8YmPsgWy
