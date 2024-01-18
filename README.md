# MovieSearch

MovieSearch is a dynamic movie search app that seamlessly blends top-rated listings, search functionality, and user favorites. It employs Node.js JWT authentication and leverages the TMDB API for enriched movie data.

Here is the doumentation link for more info : [Documentation URL](https://docs.google.com/document/d/1ZQ7ktsxByOzBTDhkNE7llv4BxUSUL_tlJmCVE35vd-k/edit?usp=sharing)

## Features

### Home Page & Infinite Scrolling

- Displays a list of top-rated movies.
- Shows movie name, poster, year, and rating.
- Utilizes lazy loading for seamless exploration, dynamically loading more movies upon scrolling.

### Search Page & Sort/Filter

- Provides a search bar for users to search for movies by titles.
- Offers options to sort movies by year, popularity.

### Favourites

- Allows users to mark movies as favorites.
- Leveraging local storage for a consistent and delightful user experience.

### User Authentication

- Ensures a secure and user-friendly experience with Node.js JWT authentication.
- Robust backend implementation using Node.js with MongoDB for user data storage.
- Implements JWT token expiration, automatically logging out users after the token expires.
- Incorporates validations for usernames and email addresses.

## Implementation Details

- Utilizes Provider for effective state management.
- Leverages the `http` package for API calls, ensuring smooth communication with external resources.
- Enhances user experience through persistent authentication using `shared_preferences`.
- Implements MongoDB with Node.js to efficiently manage user details.

## Future Enhancements

- Enriches the user experience with a more detailed view of individual movies.
- Optimizes login functionality for enhanced efficiency.
- Expands search capabilities with advanced filters.
- Introduces user settings and profile pages for personalization.
- Integrates an API for movie trailers to provide an immersive experience.

## Conclusion

MovieSearch offers a seamless user experience, combining top-rated listings, efficient search, and secure authentication. Its user-centric features make it a comprehensive movie exploration platform, adhering to best coding practices.

For a hands-on experience with the backend, check out the deployed version on Vercel: [Backend URL](https://mittarv-backend.vercel.app/).
