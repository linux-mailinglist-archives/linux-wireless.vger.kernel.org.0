Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F415545D57
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346355AbiFJH1R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346804AbiFJH0y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:26:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DBC54026
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:26:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7QkAL2010133, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7QkAL2010133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 15:26:46 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 03/11] rtw89: allocate BSSID CAM per TDLS peer
Date:   Fri, 10 Jun 2022 15:26:02 +0800
Message-ID: <20220610072610.27095-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072610.27095-1-pkshih@realtek.com>
References: <20220610072610.27095-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/10/2022 07:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In STA mode, if peer is TDLS. Allocate a BSSID CAM entry with peer's
address to match address properly, and then hardware can ACK peer's
packets and receive packets to driver.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c   |  5 +++--
 drivers/net/wireless/realtek/rtw89/cam.h   |  3 ++-
 drivers/net/wireless/realtek/rtw89/core.c  | 13 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h  | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/debug.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/fw.c    |  2 +-
 drivers/net/wireless/realtek/rtw89/ser.c   |  2 ++
 7 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index d82a77c74b1b1..652f0fb79bfae 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -605,10 +605,11 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 }
 
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif, u8 *cmd)
+				  struct rtw89_vif *rtwvif,
+				  struct rtw89_sta *rtwsta, u8 *cmd)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif, rtwsta);
 	u8 bss_color = vif->bss_conf.he_bss_color.color;
 	u8 bss_mask;
 
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index affc50d680d1e..83c160a614e6b 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -374,7 +374,8 @@ void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_sta *rtwsta,
 					 u8 *cmd);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *vif, u8 *cmd);
+				  struct rtw89_vif *rtwvif,
+				  struct rtw89_sta *rtwsta, u8 *cmd);
 int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5c4805fd5aa3a..b372e863f28f8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2277,6 +2277,8 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
+	if (sta->tdls)
+		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta->bssid_cam);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		rtw89_vif_type_mapping(vif, false);
@@ -2317,6 +2319,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif, rtwsta);
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
@@ -2332,7 +2335,15 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 			return ret;
 		}
 
-		ret = rtw89_cam_init_addr_cam(rtwdev, &rtwsta->addr_cam, &rtwvif->bssid_cam);
+		if (sta->tdls) {
+			ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif, bssid_cam, sta->addr);
+			if (ret) {
+				rtw89_warn(rtwdev, "failed to send h2c init bssid cam for TDLS\n");
+				return ret;
+			}
+		}
+
+		ret = rtw89_cam_init_addr_cam(rtwdev, &rtwsta->addr_cam, bssid_cam);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c init addr cam\n");
 			return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b8bd8b8f1bb74..c87c2173f05c4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1962,6 +1962,7 @@ struct rtw89_sta {
 	u16 rx_hw_rate;
 	__le32 htc_template;
 	struct rtw89_addr_cam_entry addr_cam; /* AP mode or TDLS peer only */
+	struct rtw89_bssid_cam_entry bssid_cam; /* TDLS peer only */
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask mask;
@@ -3546,6 +3547,19 @@ struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
 	return &rtwvif->addr_cam;
 }
 
+static inline
+struct rtw89_bssid_cam_entry *rtw89_get_bssid_cam_of(struct rtw89_vif *rtwvif,
+						     struct rtw89_sta *rtwsta)
+{
+	if (rtwsta) {
+		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
+
+		if (sta->tdls)
+			return &rtwsta->bssid_cam;
+	}
+	return &rtwvif->bssid_cam;
+}
+
 static inline
 void rtw89_chip_set_channel_prepare(struct rtw89_dev *rtwdev,
 				    struct rtw89_channel_help_params *p)
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 7820bc3ab3b47..2fdb4a64848e4 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2437,7 +2437,8 @@ static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct seq_file *m = (struct seq_file *)data;
 
-	seq_printf(m, "STA [%d] %pM\n", rtwsta->mac_id, sta->addr);
+	seq_printf(m, "STA [%d] %pM %s\n", rtwsta->mac_id, sta->addr,
+		   sta->tdls ? "(TDLS)" : "");
 	rtw89_dump_addr_cam(m, &rtwsta->addr_cam);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2d9c3157d878c..1ec81dc36f9d9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -579,7 +579,7 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	}
 	skb_put(skb, H2C_CAM_LEN);
 	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif, rtwsta, scan_mac_addr, skb->data);
-	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif, skb->data);
+	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif, rtwsta, skb->data);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index a5d530b042226..726223f25dc69 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -306,6 +306,8 @@ static void ser_sta_deinit_addr_cam_iter(void *data, struct ieee80211_sta *sta)
 
 	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
+	if (sta->tdls)
+		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta->bssid_cam);
 }
 
 static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
-- 
2.25.1

