export default {
  linterOptions: {
    reportUnusedDisableDirectives: true,
  },
  languageOptions: {
    ecmaVersion: 2024,
    sourceType: 'module',
  },
  plugins: {
    '@typescript-eslint': {},
  },
  rules: {
    'no-unused-vars': 'warn',
    'no-console': 'off',
  },
};
