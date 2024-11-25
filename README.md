<h1 align="center">
  Home Brewing App
</h1>

I initially built this Rails app for my brother to help him manage the inventory for his home brewing initiative. This app allows him to efficiently track and manage the key ingredients in his home brewing process, organized into three main categories: Hops, Malts, and Yeasts. Each category allows him to add, view, update, and delete items, while ensuring actions are based on brewing-specific restrictions, such as Hops' alpha acid levels (ranging between 1-22%) or Yeasts' attenuation (ranging between 60-90%), between others.

After using the app for a while, he requested additional features, which were subsequently implemented. These include:

- A Hops substitutes search bar that provides detailed information about specific hops, such as substitutes, aroma/taste profiles, alpha acid levels, and usage (bitterness, aroma, or dual-purpose).
- Two calculators:
    - One to calculate the alcohol percentage by volume (ABV) of a beer.
    - Another to adjust density based on the current temperature.

The app also features a **visual indicator** for brewing items. In the index view, card images dynamically change color based on specific values like the alpha acid levels for Hops or the type of Malts.

He can also **sort items** based on quantity or origin with the toggle button.

- **Tailwind CSS**
- **JavaScript**
- **PostgreSQL** supported by [**rapidapp.io**](https://rapidapp.io/).
- **Progressive Web App (PWA)** that integrates [**a2hs.js**](https://github.com/koddr/a2hs.js/).

Overall, the Home Brewing App is tailored to my brother's brewing needs, ensuring simplicity and functionality while keeping it adaptable for future updates.

The app is hosted by [**Render.com**](https://render.com/).

<p float="left">
  <img src="/github.com/user-attachments/assets/bc2db380-61b1-4fc0-8a84-b2731c37fed6" width="100" />
  <img src="/github.com/user-attachments/assets/962d0449-b634-4239-bec7-a1ea9e016bac" width="100" /> 
  <img src="/github.com/user-attachments/assets/edf2ea2d-3890-45eb-a91c-0a537320e75e" width="100" />
</p>

# ![hops index toggle](https://github.com/user-attachments/assets/bc2db380-61b1-4fc0-8a84-b2731c37fed6)

# ![malts index toggle](https://github.com/user-attachments/assets/962d0449-b634-4239-bec7-a1ea9e016bac)

# ![hops search](https://github.com/user-attachments/assets/edf2ea2d-3890-45eb-a91c-0a537320e75e)

# ![Item Edit](https://github.com/user-attachments/assets/0207e118-2bb2-4a94-8c4d-5bc3178e04b4)

# ![Item New](https://github.com/user-attachments/assets/20cfb121-431b-43e0-bd92-31242774d93d)

# ![Delete Item](https://github.com/user-attachments/assets/75cbfaea-8344-4e3c-8bc3-8adef754cd62)

# ![abv](https://github.com/user-attachments/assets/2015b201-9f0b-4cb8-8c88-d0779983ff41)

# ![density](https://github.com/user-attachments/assets/a57b45bc-6361-4fdf-9767-137d9fd45528)
