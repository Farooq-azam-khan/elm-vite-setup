import type { Config } from 'tailwindcss'
import typography from '@tailwindcss/typography'
import tw_animated from 'tailwindcss-animated'

export default {
  content: [
    "./src/**/*.{html,ts,js,elm}", 
  ],
  darkMode: 'class', 
  theme: {
    extend: { 
      fontFamily: {
      'sans': ['Poppins'], 
    }, 
    colors: {  }
    },
  },
  plugins: [
    typography, tw_animated
  ],
} satisfies Config
