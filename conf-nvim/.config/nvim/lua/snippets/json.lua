local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function uuid()
local random = math.random
local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
return string.gsub(template, "[xy]", function(c)
  local v = (c == "x") and random(0, 15) or random(8, 11)
  return string.format("%x", v)
  end)
end

return {
  s("uuid", f(function() return uuid() end)),

  s("schManifest", t({
    '"$schema": "https://raw.githubusercontent.com/DZombies45/mcbe-manifest-schemas/refs/heads/main/mc-manifest.json",',
    ''
  })),

-- behavior=== stdout ===
  s("schBpAnimation_controllers", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/animation_controllers/animation_controllers.json",',
    ''
  })),
  s("schBpAnimations", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/animations/animations.json",',
    ''
  })),
  s("schBpBiomes", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/biomes/biomes.json",',
    ''
  })),
  s("schBpBlocks", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/blocks/blocks.json",',
    ''
  })),
  s("schBpCameras", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/cameras/presets/cameras.json",',
    ''
  })),
  s("schBpDialogue", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/dialogue/dialogue.json",',
    ''
  })),
  s("schBpEntities", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/entities/entities.json",',
    ''
  })),
  s("schBpFeature_rules", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/feature_rules/feature_rules.json",',
    ''
  })),
  s("schBpFeatures", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/features/features.json",',
    ''
  })),
  s("schBpFunctions", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/functions/tick.json",',
    ''
  })),
  s("schBpItem_catalog", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/item_catalog/crafting_item_catalog.json",',
    ''
  })),
  s("schBpItems", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/items/items.json",',
    ''
  })),
  s("schBpLoot_tables", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/loot_tables/loot_tables.json",',
    ''
  })),
  s("schBpRecipes", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/recipes/recipes.json",',
    ''
  })),
  s("schBpSpawn_rules", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/spawn_rules/spawn_rules.json",',
    ''
  })),
  s("schBpTrading", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/trading/trading.json",',
    ''
  })),
  s("schBpWorldgenJigsaw_structures", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/worldgen/jigsaw_structures/jigsaw.json",',
    ''
  })),
  s("schBpWorldgenProcessors", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/worldgen/processors/processor_list.json",',
    ''
  })),
  s("schBpWorldgenStructure_sets", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/worldgen/structure_sets/structure_sets.json",',
    ''
  })),
  s("schBpWorldgenTemplate_pools", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/behavior/worldgen/template_pools/template_pools.json",',
    ''
  })),


-- resource
  s("schRpAnimation_controllers", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/animation_controllers/animation_controllers.json",',
    ''
  })),
  s("schRpAnimations", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/animations/actor_animation.json",',
    ''
  })),
  s("schRpAtmospherics", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/atmospherics/atmospherics.json",',
    ''
  })),
  s("schRpAttachables", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/attachables/attachables.json",',
    ''
  })),
  s("schRpBiomes", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/biomes/biomes.json",',
    ''
  })),
  s("schRpBlock_culling", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/block_culling/block_culling.json",',
    ''
  })),
  s("schRpColor_grading", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/color_grading/color_grading.json",',
    ''
  })),
  s("schRpEntity", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/entity/entity.json",',
    ''
  })),
  s("schRpFog", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/fog/fog.json",',
    ''
  })),
  s("schRpItems", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/items/items.json",',
    ''
  })),
  s("schRpLighting", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/lighting/lighting.json",',
    ''
  })),
  s("schRpMaterials", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/materials/materials.json",',
    ''
  })),
  s("schRpModel_entity", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/models/entity/model_entity.json",',
    ''
  })),
  s("schRpParticles", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/particles/particles.json",',
    ''
  })),
  s("schRpPbr", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/pbr/pbr.json",',
    ''
  })),
  s("schRpPoint_lights", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/point_lights/point_lights.json",',
    ''
  })),
  s("schRpRender_controllers", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/render_controllers/render_controllers.json",',
    ''
  })),
  s("schRpShadows", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/shadows/shadows.json",',
    ''
  })),
  s("schRpMusic_definitions", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/sounds/music_definitions.json",',
    ''
  })),
  s("schRpSound_definitions", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/sounds/sound_definitions.json",',
    ''
  })),
  s("schRpFlipbook_textures", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/textures/flipbook_textures.json",',
    ''
  })),
  s("schRpItem_texture", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/textures/item_texture.json",',
    ''
  })),
  s("schRpTerrain_texture", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/textures/terrain_texture.json",',
    ''
  })),
  s("schRpTexture_set", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/textures/texture_set.json",',
    ''
  })),
  s("schRpTextures_list", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/textures/textures_list.json",',
    ''
  })),
  s("schRpUi_texture_definition", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/textures/ui_texture_definition.json",',
    ''
  })),
  s("schRpUi", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/ui/ui.json",',
    ''
  })),
  s("schRpUi_global_variables", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/ui/_global_variables.json",',
    ''
  })),
  s("schRpUi_ui_defs", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/ui/_ui_defs.json",',
    ''
  })),
  s("schRpWater", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/water/water.json",',
    ''
  })),
  s("schRpBiomes_client", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/biomes_client.json",',
    ''
  })),
  s("schRpBlocks", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/blocks.json",',
    ''
  })),
  s("schRpSounds", t({
    '"$schema": "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/refs/heads/main/resource/sounds.json",',
    ''
  })),






}