Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3A4AB581
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiBGHDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357063AbiBGGnQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 01:43:16 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE5EC043187
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 22:43:14 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2176e1toD024561, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2176e1toD024561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Feb 2022 14:40:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 14:40:01 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Feb
 2022 14:40:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] rtw89: add addr_cam field to sta to support AP mode
Date:   Mon, 7 Feb 2022 14:38:55 +0800
Message-ID: <20220207063900.43643-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207063900.43643-1-pkshih@realtek.com>
References: <20220207063900.43643-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/07/2022 06:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvNyCkV6TIIDAzOjUyOjAw?=
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

In AP mode, each connected station needs an entry of address CAM. The
address CAM of vif is still needed to assit in AP itself.

For station mode, it still uses vif's address CAM.

Add a help macro rtw89_get_addr_cam_of() to get addr_cam from vif or sta
for all use cases.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c  |  6 +--
 drivers/net/wireless/realtek/rtw89/core.c |  5 +-
 drivers/net/wireless/realtek/rtw89/core.h | 62 +++++++++++++----------
 3 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 2114d117b603d..305dbbebff6bb 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -231,7 +231,7 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	}
 
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	addr_cam = &rtwvif->addr_cam;
+	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
 	ret = rtw89_cam_get_addr_cam_key_idx(addr_cam, sec_cam, key, &key_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to get addr cam key idx %d, %d\n",
@@ -387,7 +387,7 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 	}
 
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	addr_cam = &rtwvif->addr_cam;
+	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
 	sec_cam = addr_cam->sec_entries[key_idx];
 	if (!sec_cam)
 		return -EINVAL;
@@ -617,7 +617,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  u8 *cmd)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
 	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta);
 	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 490f5d86eeb2e..81575463a833f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4,6 +4,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 
+#include "cam.h"
 #include "coex.h"
 #include "core.h"
 #include "efuse.h"
@@ -399,9 +400,11 @@ rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
 			     struct rtw89_core_tx_request *tx_req)
 {
 	struct ieee80211_vif *vif = tx_req->vif;
+	struct ieee80211_sta *sta = tx_req->sta;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_key_conf *key;
 	struct rtw89_vif *rtwvif;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_addr_cam_entry *addr_cam;
 	struct rtw89_sec_cam_entry *sec_cam;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
@@ -414,7 +417,7 @@ rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
 	}
 
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	addr_cam = &rtwvif->addr_cam;
+	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
 
 	info = IEEE80211_SKB_CB(skb);
 	key = info->control.hw_key;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cb71dfca9341c..deb91f6b67375 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1842,32 +1842,6 @@ struct rtw89_ba_cam_entry {
 	u8 tid;
 };
 
-struct rtw89_sta {
-	u8 mac_id;
-	bool disassoc;
-	struct rtw89_vif *rtwvif;
-	struct rtw89_ra_info ra;
-	struct rtw89_ra_report ra_report;
-	int max_agg_wait;
-	u8 prev_rssi;
-	struct ewma_rssi avg_rssi;
-	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
-	struct ieee80211_rx_status rx_status;
-	u16 rx_hw_rate;
-	__le32 htc_template;
-
-	bool use_cfg_mask;
-	struct cfg80211_bitrate_mask mask;
-
-	bool cctl_tx_time;
-	u32 ampdu_max_time:4;
-	bool cctl_tx_retry_limit;
-	u32 data_tx_cnt_lmt:6;
-
-	DECLARE_BITMAP(ba_cam_map, RTW89_BA_CAM_NUM);
-	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_BA_CAM_NUM];
-};
-
 #define RTW89_MAX_ADDR_CAM_NUM		128
 #define RTW89_MAX_BSSID_CAM_NUM		20
 #define RTW89_MAX_SEC_CAM_NUM		128
@@ -1911,6 +1885,33 @@ struct rtw89_sec_cam_entry {
 	u8 key[32];
 };
 
+struct rtw89_sta {
+	u8 mac_id;
+	bool disassoc;
+	struct rtw89_vif *rtwvif;
+	struct rtw89_ra_info ra;
+	struct rtw89_ra_report ra_report;
+	int max_agg_wait;
+	u8 prev_rssi;
+	struct ewma_rssi avg_rssi;
+	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
+	struct ieee80211_rx_status rx_status;
+	u16 rx_hw_rate;
+	__le32 htc_template;
+	struct rtw89_addr_cam_entry addr_cam; /* AP mode only */
+
+	bool use_cfg_mask;
+	struct cfg80211_bitrate_mask mask;
+
+	bool cctl_tx_time;
+	u32 ampdu_max_time:4;
+	bool cctl_tx_retry_limit;
+	u32 data_tx_cnt_lmt:6;
+
+	DECLARE_BITMAP(ba_cam_map, RTW89_BA_CAM_NUM);
+	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_BA_CAM_NUM];
+};
+
 struct rtw89_efuse {
 	bool valid;
 	u8 xtal_cap;
@@ -3149,6 +3150,15 @@ static inline struct rtw89_sta *sta_to_rtwsta_safe(struct ieee80211_sta *sta)
 	return sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
 }
 
+static inline
+struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
+						   struct rtw89_sta *rtwsta)
+{
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE && rtwsta)
+		return &rtwsta->addr_cam;
+	return &rtwvif->addr_cam;
+}
+
 static inline
 void rtw89_chip_set_channel_prepare(struct rtw89_dev *rtwdev,
 				    struct rtw89_channel_help_params *p)
-- 
2.25.1

