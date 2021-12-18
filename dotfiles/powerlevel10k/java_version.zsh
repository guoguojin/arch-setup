prompt_java_version() {
  local java_version

  # Stupid: Java prints its version on STDERR.
  # The first version ouput will print nothing, we just
  # use it to transport whether the command was successful.
  # If yes, we parse the version string (and need to
  # redirect the stderr to stdout to make the pipe work).
  java_version=$(java -version 2>/dev/null && java -fullversion 2>&1 | cut -d '"' -f 2)

  if [[ -n "$java_version" && (-f "build.sbt" || -f "pom.xml" || -f "build.gradle") ]]; then
    # "$1_prompt_segment" "$0" "$2" "red" "white" "$java_version" "JAVA_ICON"
    _p9k_prompt_segment "$0" "red" "cornsilk1" "JAVA_ICON" 0 '' "${java_version}"
  fi
}
