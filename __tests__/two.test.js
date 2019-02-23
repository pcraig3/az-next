/* eslint-env jest */

import React from 'react'
import { render } from 'react-testing-library'

import App from '../pages/two.js'

describe('Page Two', () => {
  const { getByText } = render(<App />)

  it('shows "Page Two"', () => {
    expect(getByText('Page Two')).not.toBeNull()
  })

  it('links to "Page One"', () => {
    expect(getByText('Back to Page One', { selector: 'a' })).not.toBeNull()
  })
})
