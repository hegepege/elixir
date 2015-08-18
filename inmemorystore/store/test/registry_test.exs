defmodule Store.RegistryTest do
	use ExUnit.Case, async: true

	setup do
		{:ok, registry} = Store.Registry.start_link 
		{:ok, registry: registry}
	end

	test "no buckets present", %{registry: registry} do
		assert Store.Registry.lookup(registry, "shopping") == :error
	end

	test "create bucket", %{registry: registry} do
		Store.Registry.create(registry, "shopping")
		assert {:ok, bucket} = Store.Registry.lookup(registry, "shopping")
	end

	test "put bucket", %{registry: registry} do
		Store.Registry.create(registry, "shopping")
		{:ok, bucket} = Store.Registry.lookup(registry, "shopping")
		Store.Bucket.put(bucket, "milk", 1)
		assert Store.Bucket.get(bucket, "milk") == 1
	end

	test "removes bucket on exit", %{registry: registry} do
		Store.Registry.create(registry, "shopping")
		{:ok, bucket} = Store.Registry.lookup(registry, "shopping")
		Agent.stop(bucket)
		assert Store.Registry.lookup(registry, "shopping") == :error
	end

end
