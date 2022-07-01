import GlimmerComponent from "discourse/components/glimmer";
import { customSections } from "discourse/lib/sidebar/custom-sections";

export default class Sidebar extends GlimmerComponent {
  get computedCustomSections() {
    return customSections.map((customSection) => {
      return new customSection();
    });
  }
}
