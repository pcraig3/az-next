/* eslint-env jest */

import React from 'react'
import { render } from 'react-testing-library'

import App from '../pages/index.js'

describe('Index page', () => {
  const { getByText } = render(<App />)

  it('shows "Page One"', () => {
    expect(getByText('Page One')).not.toBeNull()
  })

  it('links to "Page Two"', () => {
    expect(getByText('Page Two', { selector: 'a' })).not.toBeNull()
  })
})
