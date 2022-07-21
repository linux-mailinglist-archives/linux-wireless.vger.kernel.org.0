Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7967557C629
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jul 2022 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiGUIWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jul 2022 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiGUIWc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jul 2022 04:22:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2BC27E036
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jul 2022 01:22:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26L8MJGz8010431, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26L8MJGz8010431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 21 Jul 2022 16:22:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 16:22:24 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Jul
 2022 16:22:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/9] rtw89: coex: Add v1 Wi-Fi SCC coexistence policy
Date:   Thu, 21 Jul 2022 16:21:47 +0800
Message-ID: <20220721082148.29682-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721082148.29682-1-pkshih@realtek.com>
References: <20220721082148.29682-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/21/2022 08:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjEgpFekyCAwNzoxODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Because the later firmware had patched some new feature, it can control
the Wi-Fi/BT slots more efficiently. This patch enhance it for better
Wi-Fi SCC mode performance.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 107 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |   7 ++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e16667eddf7e4..ca39c4a716d12 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -273,6 +273,21 @@ enum btc_cx_poicy_type {
 	/* TDMA off + Ext-Ctrl + pri: E2G-slot block all BT */
 	BTC_CXP_OFFE_DEF2 = (BTC_CXP_OFFE << 8) | 1,
 
+	/* TDMA off + Ext-Ctrl + pri: default */
+	BTC_CXP_OFFE_2GBWISOB = (BTC_CXP_OFFE << 8) | 2,
+
+	/* TDMA off + Ext-Ctrl + pri: E2G-slot block all BT */
+	BTC_CXP_OFFE_2GISOB = (BTC_CXP_OFFE << 8) | 3,
+
+	/* TDMA off + Ext-Ctrl + pri: E2G-slot WL > BT */
+	BTC_CXP_OFFE_2GBWMIXB = (BTC_CXP_OFFE << 8) | 4,
+
+	/* TDMA off + Ext-Ctrl + pri: E2G/EBT-slot WL > BT */
+	BTC_CXP_OFFE_WL = (BTC_CXP_OFFE << 8) | 5,
+
+	/* TDMA off + Ext-Ctrl + pri: default */
+	BTC_CXP_OFFE_2GBWMIXB2 = (BTC_CXP_OFFE << 8) | 6,
+
 	/* TDMA Fix slot-0: W1:B1 = 30:30 */
 	BTC_CXP_FIX_TD3030 = (BTC_CXP_FIX << 8) | 0,
 
@@ -440,6 +455,16 @@ enum btc_wl_link_mode {
 	BTC_WLINK_MAX
 };
 
+enum btc_wl_mrole_type {
+	BTC_WLMROLE_NONE = 0x0,
+	BTC_WLMROLE_STA_GC,
+	BTC_WLMROLE_STA_GC_NOA,
+	BTC_WLMROLE_STA_GO,
+	BTC_WLMROLE_STA_GO_NOA,
+	BTC_WLMROLE_STA_STA,
+	BTC_WLMROLE_MAX
+};
+
 enum btc_bt_hid_type {
 	BTC_HID_218 = BIT(0),
 	BTC_HID_418 = BIT(1),
@@ -1947,6 +1972,7 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 }
 
 #define _tdma_set_flctrl(btc, flc) ({(btc)->dm.tdma.rxflctrl = flc; })
+#define _tdma_set_flctrl_role(btc, role) ({(btc)->dm.tdma.rxflctrl_role = role; })
 #define _tdma_set_tog(btc, wtg) ({(btc)->dm.tdma.wtgle_n = wtg; })
 #define _tdma_set_lek(btc, lek) ({(btc)->dm.tdma.leak_n = lek; })
 
@@ -2338,9 +2364,10 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_tdma *t = &dm->tdma;
 	struct rtw89_btc_fbtc_slot *s = dm->slot;
+	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &btc->cx.wl.role_info_v1;
 	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt.link_info.hid_desc;
 	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt.link_info.hfp_desc;
-	u8 type;
+	u8 type, null_role;
 	u32 tbl_w1, tbl_b1, tbl_b4;
 
 	type = FIELD_GET(BTC_CXP_MASK, policy_type);
@@ -2685,6 +2712,12 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		break;
 	}
 
+	if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC && dm->tdma.rxflctrl) {
+		null_role = FIELD_PREP(0x0f, dm->wl_scc.null_role1) |
+			    FIELD_PREP(0xf0, dm->wl_scc.null_role2);
+		_tdma_set_flctrl_role(btc, null_role);
+	}
+
 	/* enter leak_slot after each null-1 */
 	if (dm->leak_ap && dm->tdma.leak_n > 1)
 		_tdma_set_lek(btc, 1);
@@ -3661,6 +3694,68 @@ static void _action_wl_2g_scc(struct rtw89_dev *rtwdev)
 	}
 }
 
+static void _action_wl_2g_scc_v1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &wl->role_info_v1;
+	u16 policy_type = BTC_CXP_OFF_BT;
+	u32 dur;
+
+	if (btc->mdinfo.ant.type == BTC_ANT_DEDICATED) {
+		policy_type = BTC_CXP_OFF_EQ0;
+	} else {
+		/* shared-antenna */
+		switch (wl_rinfo->mrole_type) {
+		case BTC_WLMROLE_STA_GC:
+			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_P2P_CLIENT;
+			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
+			_action_by_bt(rtwdev);
+			return;
+		case BTC_WLMROLE_STA_STA:
+			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
+			_action_by_bt(rtwdev);
+			return;
+		case BTC_WLMROLE_STA_GC_NOA:
+		case BTC_WLMROLE_STA_GO:
+		case BTC_WLMROLE_STA_GO_NOA:
+			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_NONE;
+			dur = wl_rinfo->mrole_noa_duration;
+
+			if (wl->status.map._4way) {
+				dm->wl_scc.ebt_null = 0;
+				policy_type = BTC_CXP_OFFE_WL;
+			} else if (bt->link_info.status.map.connect == 0) {
+				dm->wl_scc.ebt_null = 0;
+				policy_type = BTC_CXP_OFFE_2GISOB;
+			} else if (bt->link_info.a2dp_desc.exist &&
+				   dur < btc->bt_req_len) {
+				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
+				policy_type = BTC_CXP_OFFE_2GBWMIXB2;
+			} else if (bt->link_info.a2dp_desc.exist ||
+				   bt->link_info.pan_desc.exist) {
+				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
+				policy_type = BTC_CXP_OFFE_2GBWISOB;
+			} else {
+				dm->wl_scc.ebt_null = 0;
+				policy_type = BTC_CXP_OFFE_2GBWISOB;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
+	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
+}
+
 static void _action_wl_2g_ap(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -4382,7 +4477,10 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		_action_wl_2g_gc(rtwdev);
 		break;
 	case BTC_WLINK_2G_SCC:
-		_action_wl_2g_scc(rtwdev);
+		if (chip->chip_id == RTL8852A)
+			_action_wl_2g_scc(rtwdev);
+		else if (chip->chip_id == RTL8852C)
+			_action_wl_2g_scc_v1(rtwdev);
 		break;
 	case BTC_WLINK_2G_MCC:
 		_action_wl_2g_mcc(rtwdev);
@@ -5665,6 +5763,11 @@ static const char *steps_to_str(u16 step)
 	CASE_BTC_POLICY_STR(OFFB_BWB0);
 	CASE_BTC_POLICY_STR(OFFE_DEF);
 	CASE_BTC_POLICY_STR(OFFE_DEF2);
+	CASE_BTC_POLICY_STR(OFFE_2GBWISOB);
+	CASE_BTC_POLICY_STR(OFFE_2GISOB);
+	CASE_BTC_POLICY_STR(OFFE_2GBWMIXB);
+	CASE_BTC_POLICY_STR(OFFE_WL);
+	CASE_BTC_POLICY_STR(OFFE_2GBWMIXB2);
 	CASE_BTC_POLICY_STR(FIX_TD3030);
 	CASE_BTC_POLICY_STR(FIX_TD5050);
 	CASE_BTC_POLICY_STR(FIX_TD2030);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 99c9d162d9520..d62e19cc3da52 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1160,6 +1160,12 @@ struct rtw89_btc_wl_role_info_bpos {
 	u16 nan: 1;
 };
 
+struct rtw89_btc_wl_scc_ctrl {
+	u8 null_role1;
+	u8 null_role2;
+	u8 ebt_null; /* if tx null at EBT slot */
+};
+
 union rtw89_btc_wl_role_info_map {
 	u16 val;
 	struct rtw89_btc_wl_role_info_bpos role;
@@ -1708,6 +1714,7 @@ struct rtw89_btc_dm {
 	struct rtw89_btc_rf_trx_para rf_trx_para;
 	struct rtw89_btc_wl_tx_limit_para wl_tx_limit;
 	struct rtw89_btc_dm_step dm_step;
+	struct rtw89_btc_wl_scc_ctrl wl_scc;
 	union rtw89_btc_dm_error_map error;
 	u32 cnt_dm[BTC_DCNT_NUM];
 	u32 cnt_notify[BTC_NCNT_NUM];
-- 
2.25.1

