import React, { Component } from 'react'
import { connect } from 'react-redux'

import Waiting from './Waiting'
import Experiment from './Experiment'
import Result from './Result'

const mapStateToProps = ({ page }) => ({
  page
})

const Pages = ({ page }) => (() => {
  switch (page) {
    case "waiting":
      return <Waiting />
    case "experiment":
      return <Experiment />
    case "result":
      return <Result />
    default:
      return <span></span>
  }
})()

export default connect(mapStateToProps)(Pages)
