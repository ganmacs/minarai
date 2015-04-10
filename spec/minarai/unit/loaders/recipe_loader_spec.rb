require 'minarai/loaders/recipe_loader'
require 'minarai/recipe'

describe Minarai::Loaders::RecipeLoader do
  subject { loader.load }

  let!(:loader) { described_class.new(*option) }

  describe 'loading recipe and variable ' do
    context 'with recipe file' do
      context 'when valid path received' do
        let(:option) { 'examples/recipe_git.yml' }
        it { is_expected.to be_a Minarai::Recipe }
      end

      context 'when valid path received' do
        let(:option) { 'examples/invalid' }
        it { expect { loader.load }.to raise_error }
      end

      context 'when excpept yml or erb file received' do
        let(:option) { 'examples/recipe.invalid' }
        it { expect { loader.load }.to raise_error }
      end
    end

    context 'with recipe file and variables files' do
      context 'when valid path received' do
        let(:option) do
          ['examples/recipe_erb.yml.erb', { variable_path: 'examples/recipe_variable.yml' }]
        end
        it { is_expected.to be_a Minarai::Recipe }
      end
    end
  end
end
