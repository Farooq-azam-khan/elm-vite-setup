import type { Config } from 'tailwindcss'
import typography from '@tailwindcss/typography'
import tw_animated from 'tailwindcss-animated'

export default {
  content: [
    "./src/**/*.{html,ts,js,elm}", 
    "./node_modules/flowbite/**/*.js"
  ],
  darkMode: 'class', 
  theme: {
    extend: { 
      backgroundImage: {
        'grid': "url('/assets/grid.png')"
        // /bdo_logo_rgb.png
      },  
      fontFamily: {
      'sans': ['Poppins'], 
      'logo-font': ['Major Mono Display', 'mono'] 
    }, 
    colors: {
      'bdo-red-focus': '#f29baf', 
      'bdo-red-light': '#f56284',
      'bdo-red': '#ed1a4b', 
      'bdo-red-darker': '#f0053b', 
      'bdo-blue': '#1c4f9c', 
      'bdo-blue-darker': '#134a9e',
    }
  },
  },
  plugins: [
    typography, tw_animated
  ],
} satisfies Config
