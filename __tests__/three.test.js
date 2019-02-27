/* eslint-env jest */

import React from 'react'
import { render } from 'react-testing-library'

import App from '../pages/three.js'

describe('Page Three', () => {
  const { getByText } = render(<App />)

  it('shows "Page Three"', () => {
    expect(getByText('Page Three')).not.toBeNull()
  })

  it('links to "Page Two"', () => {
    expect(getByText('Back to Page Two', { selector: 'a' })).not.toBeNull()
  })
})
