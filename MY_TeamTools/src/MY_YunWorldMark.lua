--------------------------------------------------------------------------------
-- This file is part of the JX3 Mingyi Plugin.
-- @link     : https://jx3.zhaiyiming.com/
-- @desc     : 云世界标记
-- @author   : 茗伊 @双梦镇 @追风蹑影
-- @modifier : Emil Zhai (root@zhaiyiming.com)
-- @copyright: Emil Zhai <root@zhaiyiming.com>
--------------------------------------------------------------------------------
local X = MY
--------------------------------------------------------------------------------
local MODULE_PATH = 'MY_TeamTools/MY_YunWorldMark'
local PLUGIN_NAME = 'MY_TeamTools'
local PLUGIN_ROOT = X.PACKET_INFO.ROOT .. PLUGIN_NAME
local MODULE_NAME = 'MY_YunWorldMark'
local _L = X.LoadLangPack(PLUGIN_ROOT .. '/lang/')
--------------------------------------------------------------------------
if not X.AssertVersion(MODULE_NAME, _L[MODULE_NAME], '^28.0.4') then
	return
end
--[[#DEBUG BEGIN]]X.ReportModuleLoading(MODULE_PATH, 'START')--[[#DEBUG END]]
--------------------------------------------------------------------------

local FRAME_NAME = 'MY_YunWorldMark'
local D = {}

function D.OpenPanel(szModule)
	local ui = X.UI.CreateFrame(FRAME_NAME, {
		w = 760,
		h = 520,
		close = true,
		resize = true,
		minWidth = 760,
		minHeight = 520,
		text = X.PACKET_INFO.NAME .. _L.SPLIT_DOT .. _L[MODULE_NAME],
		anchor = { s = 'CENTER', r = 'CENTER', x = 0, y = -100 },
	})
	ui:Append('WndPageSet', {
		name = 'PageSet_All',
		x = 0, y = 48, w = 1000, h = 700 - 48,
	})
	local frame = ui:Raw()
	frame:BringToTop()
	D.PageSetModule.DrawUI(frame)
	D.PageSetModule.ActivePage(frame, szModule or 1, true)
end

function D.ClosePanel()
	X.UI.CloseFrame(FRAME_NAME)
end

function D.IsPanelOpened()
	return Station.Lookup('Normal/' .. FRAME_NAME)
end

function D.TogglePanel()
	if D.IsPanelOpened() then
		D.ClosePanel()
	else
		D.OpenPanel()
	end
end

-- 注册子模块
function D.RegisterModule(szKey, szName, tModule)
	if not D.PageSetModule or not szName or not tModule then
		return
	end
	D.PageSetModule.RegisterModule(szKey, szName, tModule)
	if D.IsPanelOpened() then
		D.ClosePanel()
		D.OpenPanel()
	end
end

D.PageSetModule = X.UI.CreatePageSetModule(D, 'Wnd_Total/PageSet_All')

--------------------------------------------------------------------------------
-- 全局导出
--------------------------------------------------------------------------------
do
local settings = {
	name = 'MY_YunWorldMark',
	exports = {
		{
			preset = 'UIEvent',
			fields = {
				'OpenPanel',
				'ClosePanel',
				'TogglePanel',
				'IsPanelOpened',
				'RegisterModule',
			},
			root = D,
		},
	},
}
MY_YunWorldMark = X.CreateModule(settings)
end

--[[#DEBUG BEGIN]]X.ReportModuleLoading(MODULE_PATH, 'FINISH')--[[#DEBUG END]]
