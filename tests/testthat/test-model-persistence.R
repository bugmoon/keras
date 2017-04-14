
context("model persistence")

source("utils.R")

test_succeeds("model can be saved and loaded", {
  
  if (!keras:::have_h5py())
    skip("h5py not available for testing")
  
  model <- define_and_compile_model()
  tmp <- tempfile("model", fileext = ".hdf5")
  save_model(model, tmp)
  model <- load_model(tmp)
})

test_succeeds("model weights can be saved and loaded", {
  
  if (!keras:::have_h5py())
    skip("h5py not available for testing")
  
  model <- define_and_compile_model()
  tmp <- tempfile("model", fileext = ".hdf5")
  save_model_weights(model, tmp)
  load_model_weights(model, tmp)
})

test_succeeds("model can be saved and loaded from json", {
  model <- define_model()
  json <- model_to_json(model)
  model_from <- model_from_json(json)
  expect_equal(json, model_to_json(model_from))
})

test_succeeds("model can be saved and loaded from yaml", {
  
  if (!keras:::have_pyyaml())
    skip("yaml not available for testing")
  
  model <- define_model()
  yaml <- model_to_yaml(model)
  model_from <- model_from_yaml(yaml)
  expect_equal(yaml, model_to_yaml(model_from))
})



