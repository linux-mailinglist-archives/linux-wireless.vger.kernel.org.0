Return-Path: <linux-wireless+bounces-884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554481665D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8421F2267A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F364279E1;
	Mon, 18 Dec 2023 06:15:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC87461
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6F7pS43224844, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6F7pS43224844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Dec 2023 14:15:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/11] wifi: rtw89: coex: Add Pre-AGC control to enhance Wi-Fi RX performance
Date: Mon, 18 Dec 2023 14:13:33 +0800
Message-ID: <20231218061341.51255-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218061341.51255-1-pkshih@realtek.com>
References: <20231218061341.51255-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

Pre-AGC(Auto gain control) is a hardware mechanism, it will auto adjust
the RX gain for every packet, it can help to keep Wi-Fi signal on a well
RX quality. The coexistence will give advice to control the API and
monitor the settings by firmware report.
Also add function to check register, these registers were monitoring
by Wi-Fi firmware and report to coexistence driver periodically. This
can help to track whether these settings were taking effect or not.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 169 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h |  38 +++++
 drivers/net/wireless/realtek/rtw89/core.h |   2 +
 3 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index cc204783ea8d..895f57d019ba 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6,6 +6,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "phy.h"
 #include "ps.h"
 #include "reg.h"
 
@@ -739,12 +740,114 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 		btc->dm.coex_info_map = BTC_COEX_INFO_ALL;
 		btc->dm.wl_tx_limit.tx_time = BTC_MAX_TX_TIME_DEF;
 		btc->dm.wl_tx_limit.tx_retry = BTC_MAX_TX_RETRY_DEF;
+		btc->dm.wl_pre_agc_rb = BTC_PREAGC_NOTFOUND;
 	}
 
 	if (type & BTC_RESET_MDINFO)
 		memset(&btc->mdinfo, 0, sizeof(btc->mdinfo));
 }
 
+static u8 _search_reg_index(struct rtw89_dev *rtwdev, u8 mreg_num, u16 reg_type, u32 target)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 i;
+
+	for (i = 0; i < mreg_num; i++)
+		if (le16_to_cpu(chip->mon_reg[i].type) == reg_type &&
+		    le32_to_cpu(chip->mon_reg[i].offset) == target) {
+			return i;
+	}
+	return BTC_REG_NOTFOUND;
+}
+
+static void _get_reg_status(struct rtw89_dev *rtwdev, u8 type, u8 *val)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_module *md = &btc->mdinfo;
+	union rtw89_btc_fbtc_mreg_val *pmreg;
+	u32 pre_agc_addr = R_BTC_BB_PRE_AGC_S1;
+	u32 reg_val;
+	u8 idx;
+
+	if (md->ant.btg_pos == RF_PATH_A)
+		pre_agc_addr = R_BTC_BB_PRE_AGC_S0;
+
+	switch (type) {
+	case BTC_CSTATUS_TXDIV_POS:
+		if (md->switch_type == BTC_SWITCH_INTERNAL)
+			*val = BTC_ANT_DIV_MAIN;
+		break;
+	case BTC_CSTATUS_RXDIV_POS:
+		if (md->switch_type == BTC_SWITCH_INTERNAL)
+			*val = BTC_ANT_DIV_MAIN;
+		break;
+	case BTC_CSTATUS_BB_GNT_MUX:
+		reg_val = rtw89_phy_read32(rtwdev, R_BTC_BB_BTG_RX);
+		*val = !(reg_val & B_BTC_BB_GNT_MUX);
+		break;
+	case BTC_CSTATUS_BB_GNT_MUX_MON:
+		if (!btc->fwinfo.rpt_fbtc_mregval.cinfo.valid)
+			return;
+
+		pmreg = &btc->fwinfo.rpt_fbtc_mregval.finfo;
+		if (ver->fcxmreg == 1) {
+			idx = _search_reg_index(rtwdev, pmreg->v1.reg_num,
+						REG_BB, R_BTC_BB_BTG_RX);
+			if (idx == BTC_REG_NOTFOUND) {
+				*val = BTC_BTGCTRL_BB_GNT_NOTFOUND;
+			} else {
+				reg_val = le32_to_cpu(pmreg->v1.mreg_val[idx]);
+				*val = !(reg_val & B_BTC_BB_GNT_MUX);
+			}
+		} else if (ver->fcxmreg == 2) {
+			idx = _search_reg_index(rtwdev, pmreg->v2.reg_num,
+						REG_BB, R_BTC_BB_BTG_RX);
+			if (idx == BTC_REG_NOTFOUND) {
+				*val = BTC_BTGCTRL_BB_GNT_NOTFOUND;
+			} else {
+				reg_val = le32_to_cpu(pmreg->v2.mreg_val[idx]);
+				*val = !(reg_val & B_BTC_BB_GNT_MUX);
+			}
+		}
+		break;
+	case BTC_CSTATUS_BB_PRE_AGC:
+		reg_val = rtw89_phy_read32(rtwdev, pre_agc_addr);
+		reg_val &= B_BTC_BB_PRE_AGC_MASK;
+		*val = (reg_val == B_BTC_BB_PRE_AGC_VAL);
+		break;
+	case BTC_CSTATUS_BB_PRE_AGC_MON:
+		if (!btc->fwinfo.rpt_fbtc_mregval.cinfo.valid)
+			return;
+
+		pmreg = &btc->fwinfo.rpt_fbtc_mregval.finfo;
+		if (ver->fcxmreg == 1) {
+			idx = _search_reg_index(rtwdev, pmreg->v1.reg_num,
+						REG_BB, pre_agc_addr);
+			if (idx == BTC_REG_NOTFOUND) {
+				*val = BTC_PREAGC_NOTFOUND;
+			} else {
+				reg_val = le32_to_cpu(pmreg->v1.mreg_val[idx]) &
+					  B_BTC_BB_PRE_AGC_MASK;
+				*val = (reg_val == B_BTC_BB_PRE_AGC_VAL);
+			}
+		} else if (ver->fcxmreg == 2) {
+			idx = _search_reg_index(rtwdev, pmreg->v2.reg_num,
+						REG_BB, pre_agc_addr);
+			if (idx == BTC_REG_NOTFOUND) {
+				*val = BTC_PREAGC_NOTFOUND;
+			} else {
+				reg_val = le32_to_cpu(pmreg->v2.mreg_val[idx]) &
+					  B_BTC_BB_PRE_AGC_MASK;
+				*val = (reg_val == B_BTC_BB_PRE_AGC_VAL);
+			}
+		}
+		break;
+	default:
+		break;
+	}
+}
+
 #define BTC_RPT_HDR_SIZE 3
 #define BTC_CHK_WLSLOT_DRIFT_MAX 15
 #define BTC_CHK_BTSLOT_DRIFT_MAX 15
@@ -1003,7 +1106,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	u16 wl_slot_set = 0, wl_slot_real = 0;
 	u32 trace_step = btc->ctrl.trace_step, rpt_len = 0, diff_t = 0;
 	u32 cnt_leak_slot, bt_slot_real, bt_slot_set, cnt_rx_imr;
-	u8 i;
+	u8 i, val = 0;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): index:%d\n",
@@ -1508,6 +1611,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			goto err;
 		}
 		break;
+	case BTC_RPT_TYPE_MREG:
+		_get_reg_status(rtwdev, BTC_CSTATUS_BB_PRE_AGC_MON, &val);
+		if (dm->wl_pre_agc == BTC_PREAGC_BB_FWCTRL)
+			dm->wl_pre_agc_rb = BTC_PREAGC_BB_FWCTRL;
+		else
+			dm->wl_pre_agc_rb = val;
+		break;
 	case BTC_RPT_TYPE_BT_VER:
 	case BTC_RPT_TYPE_BT_SCAN:
 	case BTC_RPT_TYPE_BT_AFH:
@@ -3840,6 +3950,62 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	rtw89_ctrl_btg_bt_rx(rtwdev, is_btg, RTW89_PHY_0);
 }
 
+static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo = &wl->role_info_v2;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 is_preagc, val;
+
+	if (btc->ctrl.manual)
+		return;
+
+	if (wl_rinfo->link_mode == BTC_WLINK_25G_MCC)
+		is_preagc = BTC_PREAGC_BB_FWCTRL;
+	else if (!(bt->run_patch_code && bt->enable.now))
+		is_preagc = BTC_PREAGC_DISABLE;
+	else if (wl_rinfo->link_mode == BTC_WLINK_5G)
+		is_preagc = BTC_PREAGC_DISABLE;
+	else if (wl_rinfo->link_mode == BTC_WLINK_NOLINK ||
+		 btc->cx.bt.link_info.profile_cnt.now == 0)
+		is_preagc = BTC_PREAGC_DISABLE;
+	else if (dm->tdma_now.type != CXTDMA_OFF &&
+		 !bt_linfo->hfp_desc.exist &&
+		 !bt_linfo->hid_desc.exist &&
+		 dm->fddt_train == BTC_FDDT_DISABLE)
+		is_preagc = BTC_PREAGC_DISABLE;
+	else if (ver->fwlrole == 2 && wl_rinfo->dbcc_en &&
+		 wl_rinfo->dbcc_2g_phy != RTW89_PHY_1)
+		is_preagc = BTC_PREAGC_DISABLE;
+	else if (btc->mdinfo.ant.type == BTC_ANT_SHARED)
+		is_preagc = BTC_PREAGC_DISABLE;
+	else
+		is_preagc = BTC_PREAGC_ENABLE;
+
+	if (dm->wl_pre_agc_rb != dm->wl_pre_agc &&
+	    dm->wl_pre_agc_rb != BTC_PREAGC_NOTFOUND) {
+		_get_reg_status(rtwdev, BTC_CSTATUS_BB_PRE_AGC, &val);
+		dm->wl_pre_agc_rb = val;
+	}
+
+	if ((wl->coex_mode == BTC_MODE_NORMAL &&
+	     (dm->run_reason == BTC_RSN_NTFY_INIT ||
+	      dm->run_reason == BTC_RSN_NTFY_SWBAND ||
+	      dm->wl_pre_agc_rb != dm->wl_pre_agc)) ||
+	    is_preagc != dm->wl_pre_agc) {
+		dm->wl_pre_agc = is_preagc;
+
+		if (is_preagc > BTC_PREAGC_ENABLE)
+			return;
+		chip->ops->ctrl_nbtg_bt_tx(rtwdev, dm->wl_pre_agc, RTW89_PHY_0);
+	}
+}
+
 struct rtw89_txtime_data {
 	struct rtw89_dev *rtwdev;
 	int type;
@@ -4024,6 +4190,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
 	_set_btg_ctrl(rtwdev);
+	_set_wl_preagc_ctrl(rtwdev);
 	_set_wl_tx_limit(rtwdev);
 	_set_bt_afh_info(rtwdev);
 	_set_bt_rx_agc(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index e76153709793..46e25c6f88a6 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -142,6 +142,44 @@ enum btc_lps_state {
 	BTC_LPS_RF_ON = 2
 };
 
+#define R_BTC_BB_BTG_RX 0x980
+#define R_BTC_BB_PRE_AGC_S1 0x476C
+#define R_BTC_BB_PRE_AGC_S0 0x4688
+
+#define B_BTC_BB_GNT_MUX GENMASK(20, 17)
+#define B_BTC_BB_PRE_AGC_MASK GENMASK(31, 24)
+#define B_BTC_BB_PRE_AGC_VAL BIT(31)
+
+#define BTC_REG_NOTFOUND 0xff
+
+enum btc_ant_div_pos {
+	BTC_ANT_DIV_MAIN = 0,
+	BTC_ANT_DIV_AUX = 1,
+};
+
+enum btc_get_reg_status {
+	BTC_CSTATUS_TXDIV_POS = 0,
+	BTC_CSTATUS_RXDIV_POS = 1,
+	BTC_CSTATUS_BB_GNT_MUX = 2,
+	BTC_CSTATUS_BB_GNT_MUX_MON = 3,
+	BTC_CSTATUS_BB_PRE_AGC = 4,
+	BTC_CSTATUS_BB_PRE_AGC_MON = 5,
+};
+
+enum btc_preagc_type {
+	BTC_PREAGC_DISABLE,
+	BTC_PREAGC_ENABLE,
+	BTC_PREAGC_BB_FWCTRL,
+	BTC_PREAGC_NOTFOUND,
+};
+
+enum btc_btgctrl_type {
+	BTC_BTGCTRL_DISABLE,
+	BTC_BTGCTRL_ENABLE,
+	BTC_BTGCTRL_BB_GNT_FWCTRL,
+	BTC_BTGCTRL_BB_GNT_NOTFOUND,
+};
+
 void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e72cf1866d1e..cf7708742632 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2517,7 +2517,9 @@ struct rtw89_btc_dm {
 	u8 run_reason;
 	u8 run_action;
 
+	u8 wl_pre_agc: 2;
 	u8 wl_lna2: 1;
+	u8 wl_pre_agc_rb: 2;
 };
 
 struct rtw89_btc_ctrl {
-- 
2.25.1


