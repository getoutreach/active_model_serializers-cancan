require 'spec_helper'

describe ActiveModel::Serializer::Associations do

  let(:user) { User.find(1) }

  let(:category) { Category.first }

  context 'when authorize is not set' do
    before do
      Object.send(:remove_const, :CategorySerializer) if defined?(CategorySerializer)
      Object.send(:remove_const, :ProjectSerializer) if defined?(ProjectSerializer)
      Object.send(:remove_const, :Ability) if defined?(Ability)

      CategorySerializer = Class.new(ActiveModel::Serializer) do
        attributes :id
        has_many :projects
        has_one :project
      end

      ProjectSerializer = Class.new(ActiveModel::Serializer) do
        attributes :id
      end

      Ability = Class.new do
        include CanCan::Ability
        def initialize(user)
          cannot :read, :project
        end
      end
    end

    it 'should serialize forbidden has_many records' do
      expect(CategorySerializer.new(category, scope: user).serializable_hash[:projects].length).to eq(2)
    end

    it 'should serialize forbidden has_one records' do
      expect(CategorySerializer.new(category, scope: user).serializable_hash[:project]).to_not be_nil
    end
  end

  context 'when authorize is set to false' do
    before do
      Object.send(:remove_const, :CategorySerializer) if defined?(CategorySerializer)
      Object.send(:remove_const, :ProjectSerializer) if defined?(ProjectSerializer)
      Object.send(:remove_const, :Ability) if defined?(Ability)

      CategorySerializer = Class.new(ActiveModel::Serializer) do
        attributes :id
        has_many :projects, authorize: false
        has_one :project, authorize: false
      end

      ProjectSerializer = Class.new(ActiveModel::Serializer) do
        attributes :id
      end

      Ability = Class.new do
        include CanCan::Ability
        def initialize(user)
          cannot :read, :project
        end
      end
    end

    it 'should serialize forbidden has_many records' do
      expect(CategorySerializer.new(category, scope: user).serializable_hash[:projects].length).to eq(2)
    end

    it 'should serialize forbidden has_one records' do
      expect(CategorySerializer.new(category, scope: user).serializable_hash[:project]).to_not be_nil
      expect(CategorySerializer.new(category, scope: user).serializable_hash[:project]).to_not be_nil
    end
  end

  context 'when authorize set to true' do
    before do
      Object.send(:remove_const, :CategorySerializer) if defined?(CategorySerializer)
      Object.send(:remove_const, :ProjectSerializer) if defined?(ProjectSerializer)
      Object.send(:remove_const, :Ability) if defined?(Ability)

      CategorySerializer = Class.new(ActiveModel::Serializer) do
        attributes :id
        has_many :projects, authorize: true
        has_one :project, authorize: true
      end

      ProjectSerializer = Class.new(ActiveModel::Serializer) do
        attributes :id
      end

      Ability = Class.new do
        include CanCan::Ability
        def initialize(user)
          can :read, Category
          can :read, Project do |pr|
            pr.user == user
          end
        end
      end
    end

    it 'should filter unauthorized records', focus: true do
      expect(CategorySerializer.new(category, scope: user).serializable_hash[:projects].length).to eq(1)
    end

    it 'should nil out unauthorized has_one records' do
      expect(CategorySerializer.new(category, scope: user).serializable_hash[:project]).to be_nil
    end

    it 'should serialize authorized has_one records' do
      expect(CategorySerializer.new(category, scope: User.find(2)).serializable_hash[:project]).to_not be_nil
    end
  end

end
