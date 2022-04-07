Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45D54F7C44
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbiDGKBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiDGKB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 06:01:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897C75608
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 02:59:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2379xJoH5006102, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2379xJoH5006102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 17:59:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 17:59:18 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 7 Apr
 2022 17:59:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH 1/6] rtw88: add ieee80211:sta_rc_update ops
Date:   Thu, 7 Apr 2022 17:58:53 +0800
Message-ID: <20220407095858.46807-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407095858.46807-1-pkshih@realtek.com>
References: <20220407095858.46807-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 09:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkV6TIIDA4OjExOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Adding this allows us to get notification when bitrate configuration
of the station changes. Update according parameters to firmware so
the rate control algorithm can work properly.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  7 +++----
 drivers/net/wireless/realtek/rtw88/fw.h       |  3 ++-
 drivers/net/wireless/realtek/rtw88/mac80211.c | 14 +++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.c     |  7 ++++---
 drivers/net/wireless/realtek/rtw88/main.h     |  4 ++--
 drivers/net/wireless/realtek/rtw88/phy.c      |  2 +-
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index aa2aeb5fb2ccd..941df27f0b692 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -585,10 +585,10 @@ void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
-void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
+void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
+			 bool reset_ra_mask)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
-	bool no_update = si->updated;
 	bool disable_pt = true;
 
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
@@ -599,7 +599,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	SET_RA_INFO_SGI_EN(h2c_pkt, si->sgi_enable);
 	SET_RA_INFO_BW_MODE(h2c_pkt, si->bw_mode);
 	SET_RA_INFO_LDPC(h2c_pkt, !!si->ldpc_en);
-	SET_RA_INFO_NO_UPDATE(h2c_pkt, no_update);
+	SET_RA_INFO_NO_UPDATE(h2c_pkt, !reset_ra_mask);
 	SET_RA_INFO_VHT_EN(h2c_pkt, si->vht_enable);
 	SET_RA_INFO_DIS_PT(h2c_pkt, disable_pt);
 	SET_RA_INFO_RA_MASK0(h2c_pkt, (si->ra_mask & 0xff));
@@ -608,7 +608,6 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	SET_RA_INFO_RA_MASK3(h2c_pkt, (si->ra_mask & 0xff000000) >> 24);
 
 	si->init_ra_lv = 0;
-	si->updated = true;
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index b59d2cbad5d73..3486eb9585def 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -791,7 +791,8 @@ void rtw_fw_coex_query_hid_info(struct rtw_dev *rtwdev, u8 sub_id, u8 data);
 
 void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data);
 void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
-void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
+void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
+			 bool reset_ra_mask);
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool conn);
 void rtw_fw_update_wl_phy_info(struct rtw_dev *rtwdev);
 void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 5cdc54c9a9aae..c9341af493645 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -694,7 +694,7 @@ static void rtw_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta)
 	}
 
 	si->use_cfg_mask = true;
-	rtw_update_sta_info(br_data->rtwdev, si);
+	rtw_update_sta_info(br_data->rtwdev, si, true);
 }
 
 static void rtw_ra_mask_info_update(struct rtw_dev *rtwdev,
@@ -850,6 +850,17 @@ static int rtw_ops_set_sar_specs(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static void rtw_ops_sta_rc_update(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta, u32 changed)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+
+	if (changed & IEEE80211_RC_BW_CHANGED)
+		rtw_update_sta_info(rtwdev, si, true);
+}
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
@@ -879,6 +890,7 @@ const struct ieee80211_ops rtw_ops = {
 	.reconfig_complete	= rtw_reconfig_complete,
 	.hw_scan		= rtw_ops_hw_scan,
 	.cancel_hw_scan		= rtw_ops_cancel_hw_scan,
+	.sta_rc_update		= rtw_ops_sta_rc_update,
 	.set_sar_specs          = rtw_ops_set_sar_specs,
 #ifdef CONFIG_PM
 	.suspend		= rtw_ops_suspend,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b57f9262f5909..9a0a4babf1b60 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -313,7 +313,7 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw_txq_init(rtwdev, sta->txq[i]);
 
-	rtw_update_sta_info(rtwdev, si);
+	rtw_update_sta_info(rtwdev, si, true);
 	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
 
 	rtwdev->sta_cnt++;
@@ -1105,7 +1105,8 @@ static u64 rtw_rate_mask_cfg(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	return ra_mask;
 }
 
-void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
+void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
+			 bool reset_ra_mask)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	struct ieee80211_sta *sta = si->sta;
@@ -1223,7 +1224,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	si->ra_mask = ra_mask;
 	si->rate_id = rate_id;
 
-	rtw_fw_send_ra_info(rtwdev, si);
+	rtw_fw_send_ra_info(rtwdev, si, reset_ra_mask);
 }
 
 static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 17815af9dd4ea..f694a2d86e0b2 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -753,7 +753,6 @@ struct rtw_sta_info {
 	u8 ldpc_en:2;
 	bool sgi_enable;
 	bool vht_enable;
-	bool updated;
 	u8 init_ra_lv;
 	u64 ra_mask;
 
@@ -2145,7 +2144,8 @@ void rtw_chip_prepare_tx(struct rtw_dev *rtwdev);
 void rtw_vif_port_config(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 			 u32 config);
 void rtw_tx_report_purge_timer(struct timer_list *t);
-void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
+void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
+			 bool reset_ra_mask);
 void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 			 const u8 *mac_addr, bool hw_scan);
 void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e505d17f107e4..8982e0c98dac9 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -536,7 +536,7 @@ static void rtw_phy_ra_info_update_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw_dev *rtwdev = data;
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 
-	rtw_update_sta_info(rtwdev, si);
+	rtw_update_sta_info(rtwdev, si, false);
 }
 
 static void rtw_phy_ra_info_update(struct rtw_dev *rtwdev)
-- 
2.25.1

