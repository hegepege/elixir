defmodule StoreTest do
  use ExUnit.Case, async: true


  setup do
  	{:ok, bucket} = Store.Bucket.start_link
  	{:ok, bucket: bucket}
  end		

  test "store values by key", %{bucket: bucket} do
  
  	assert Store.Bucket.get(bucket, "milk") == nil
  
  	Store.Bucket.put(bucket, "milk", 3)
  	assert Store.Bucket.get(bucket, "milk") == 3
  end



  test "delete a value by key", %{bucket: bucket} do
    Store.Bucket.put(bucket, "touti", "Marie")
    assert Store.Bucket.get(bucket, "touti") == "Marie"
    assert Store.Bucket.delete(bucket, "touti") == "Marie"
    assert Store.Bucket.get(bucket, "touti") == nil
  end
end
