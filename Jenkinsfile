node("jnlp-slave-with-aws") {
  stage('Checkout') {
    checkout scm
  }
  stage('Build') {
    app = docker.build("ruprict/vanilla-rails:pipeline")
  }
  stage('Test image') {
    /* Ideally, we would run a test framework against our image.
     * For this example, we're using a Volkswagen-type approach ;-) */

    app.inside {
      rails test
    }
  }
}
