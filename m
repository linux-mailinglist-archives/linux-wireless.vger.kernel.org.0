Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5441547FB0D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Dec 2021 09:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhL0Iby (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Dec 2021 03:31:54 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34097 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhL0Ibx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Dec 2021 03:31:53 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BR8Vj8zA020769, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BR8Vj8zA020769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Dec 2021 16:31:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 27 Dec 2021 16:31:45 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 27 Dec
 2021 16:31:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw89: remove duplicate definition of hardware port number
Date:   Mon, 27 Dec 2021 16:31:34 +0800
Message-ID: <20211227083134.35248-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 12/27/2021 08:14:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzI3IKRXpMggMDY6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RTW89_MAX_HW_PORT_NUM and RTW89_PORT_NUM refer to the same thing, so remove
the one of them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 10 +++++-----
 drivers/net/wireless/realtek/rtw89/core.h     |  7 +++----
 drivers/net/wireless/realtek/rtw89/fw.c       |  4 ++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 ++--
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 9f7d4f8d0c56f..516d0bc34526e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -594,7 +594,7 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 		memset(&btc->dm, 0, sizeof(btc->dm));
 		memset(bt_linfo->rssi_state, 0, sizeof(bt_linfo->rssi_state));
 
-		for (i = 0; i < RTW89_MAX_HW_PORT_NUM; i++)
+		for (i = 0; i < RTW89_PORT_NUM; i++)
 			memset(wl_linfo[i].rssi_state, 0,
 			       sizeof(wl_linfo[i].rssi_state));
 
@@ -1698,7 +1698,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 		   wl_rinfo->link_mode == BTC_WLINK_2G_SCC) {
 		en = true;
 		/* get p2p channel */
-		for (i = 0; i < RTW89_MAX_HW_PORT_NUM; i++) {
+		for (i = 0; i < RTW89_PORT_NUM; i++) {
 			if (wl_rinfo->active_role[i].role ==
 			    RTW89_WIFI_ROLE_P2P_GO ||
 			    wl_rinfo->active_role[i].role ==
@@ -1711,7 +1711,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	} else {
 		en = true;
 		/* get 2g channel  */
-		for (i = 0; i < RTW89_MAX_HW_PORT_NUM; i++) {
+		for (i = 0; i < RTW89_PORT_NUM; i++) {
 			if (wl_rinfo->active_role[i].connected &&
 			    wl_rinfo->active_role[i].band == RTW89_BAND_2G) {
 				ch = wl_rinfo->active_role[i].ch;
@@ -3287,7 +3287,7 @@ static void _update_wl_info(struct rtw89_dev *rtwdev)
 
 	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
 
-	for (i = 0; i < RTW89_MAX_HW_PORT_NUM; i++) {
+	for (i = 0; i < RTW89_PORT_NUM; i++) {
 		/* check if role active? */
 		if (!wl_linfo[i].active)
 			continue;
@@ -4676,7 +4676,7 @@ static void _show_wl_role_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 			   wl_dinfo->real_band[RTW89_PHY_1]);
 	}
 
-	for (i = 0; i < RTW89_MAX_HW_PORT_NUM; i++) {
+	for (i = 0; i < RTW89_PORT_NUM; i++) {
 		plink = &btc->cx.wl.link_info[i];
 
 		if (!plink->active)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7c84556ec4ada..44fe596485725 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -33,7 +33,6 @@ extern const struct rtw89_chip_info rtw8852a_chip_info;
 #define MAX_RSSI 110
 #define RSSI_FACTOR 1
 #define RTW89_RSSI_RAW_TO_DBM(rssi) ((s8)((rssi) >> RSSI_FACTOR) - MAX_RSSI)
-#define RTW89_MAX_HW_PORT_NUM 5
 
 #define RTW89_HTC_MASK_VARIANT GENMASK(1, 0)
 #define RTW89_HTC_VARIANT_HE 3
@@ -1048,7 +1047,7 @@ struct rtw89_btc_wl_role_info { /* struct size must be n*4 bytes */
 	u8 connect_cnt;
 	u8 link_mode;
 	union rtw89_btc_wl_role_info_map role_map;
-	struct rtw89_btc_wl_active_role active_role[RTW89_MAX_HW_PORT_NUM];
+	struct rtw89_btc_wl_active_role active_role[RTW89_PORT_NUM];
 };
 
 struct rtw89_btc_wl_ver_info {
@@ -1151,7 +1150,7 @@ struct rtw89_btc_rf_para {
 };
 
 struct rtw89_btc_wl_info {
-	struct rtw89_btc_wl_link_info link_info[RTW89_MAX_HW_PORT_NUM];
+	struct rtw89_btc_wl_link_info link_info[RTW89_PORT_NUM];
 	struct rtw89_btc_wl_rfk_info rfk_info;
 	struct rtw89_btc_wl_ver_info  ver_info;
 	struct rtw89_btc_wl_afh_info afh_info;
@@ -2805,7 +2804,7 @@ struct rtw89_dev {
 
 	struct rtw89_ser ser;
 
-	DECLARE_BITMAP(hw_port, RTW89_MAX_HW_PORT_NUM);
+	DECLARE_BITMAP(hw_port, RTW89_PORT_NUM);
 	DECLARE_BITMAP(mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW89_FLAGS);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d4b59fbe73659..3aef95bd3bf06 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1212,7 +1212,7 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 	return -EBUSY;
 }
 
-#define H2C_LEN_CXDRVINFO_ROLE (4 + 12 * RTW89_MAX_HW_PORT_NUM + H2C_LEN_CXDRVHDR)
+#define H2C_LEN_CXDRVINFO_ROLE (4 + 12 * RTW89_PORT_NUM + H2C_LEN_CXDRVHDR)
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -1251,7 +1251,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, bpos->p2p_go);
 	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, bpos->nan);
 
-	for (i = 0; i < RTW89_MAX_HW_PORT_NUM; i++, active++) {
+	for (i = 0; i < RTW89_PORT_NUM; i++, active++) {
 		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED(cmd, active->connected, i);
 		RTW89_SET_FWCMD_CXROLE_ACT_PID(cmd, active->pid, i);
 		RTW89_SET_FWCMD_CXROLE_ACT_PHY(cmd, active->phy, i);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a322259f4cc4a..2ff6d33c178d7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -108,8 +108,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtw89_traffic_stats_init(rtwdev, &rtwvif->stats);
 	rtw89_vif_type_mapping(vif, false);
 	rtwvif->port = rtw89_core_acquire_bit_map(rtwdev->hw_port,
-						  RTW89_MAX_HW_PORT_NUM);
-	if (rtwvif->port == RTW89_MAX_HW_PORT_NUM) {
+						  RTW89_PORT_NUM);
+	if (rtwvif->port == RTW89_PORT_NUM) {
 		ret = -ENOSPC;
 		goto out;
 	}
-- 
2.25.1

