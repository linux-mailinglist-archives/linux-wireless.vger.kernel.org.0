Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5022C647B4A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 02:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLIBW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 20:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLIBWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 20:22:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E0FFAC6F5
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 17:22:24 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B91LMvfC002912, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B91LMvfC002912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 09:21:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 9 Dec 2022 09:22:09 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 9 Dec 2022
 09:22:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: consider ER SU as a TX capability
Date:   Fri, 9 Dec 2022 09:21:10 +0800
Message-ID: <20221209012110.7242-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/09/2022 00:53:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzggpFWkyCAwNzoyOTowMA==?=
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

ER (Extended Range) SU is to have a larger coverage. We set this as a RA
capability, and then firmware can choose ER SU to transmit packets to
reception at cell edge. For 8852C, it needs to fill this capability in
TXWD, so update rtw89_build_txwd_info0_v1().

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 13 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/phy.c  |  1 +
 drivers/net/wireless/realtek/rtw89/txrx.h |  2 ++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 931aff8b5dc95..adc961752a291 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -689,7 +689,9 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
 {
 	struct ieee80211_vif *vif = tx_req->vif;
+	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
@@ -707,6 +709,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	desc_info->qsel = qsel;
 	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
 	desc_info->port = desc_info->hiq ? rtwvif->port : 0;
+	desc_info->er_cap = rtwsta ? rtwsta->er_cap : false;
 
 	/* enable wd_info for AMPDU */
 	desc_info->en_wd_info = true;
@@ -1006,7 +1009,9 @@ static __le32 rtw89_build_txwd_info0(struct rtw89_tx_desc_info *desc_info)
 static __le32 rtw89_build_txwd_info0_v1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
-		    FIELD_PREP(RTW89_TXWD_INFO0_MULTIPORT_ID, desc_info->port);
+		    FIELD_PREP(RTW89_TXWD_INFO0_MULTIPORT_ID, desc_info->port) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_ER, desc_info->er_cap) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_BW_ER, 0);
 
 	return cpu_to_le32(dword);
 }
@@ -2585,6 +2590,12 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, false);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+		struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+
+		if (bss_conf->he_support &&
+		    !(bss_conf->he_oper.params & IEEE80211_HE_OPERATION_ER_SU_DISABLE))
+			rtwsta->er_cap = true;
+
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_END);
 		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2badb96d2ae35..800ede1d69c75 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -816,6 +816,7 @@ struct rtw89_tx_desc_info {
 #define RTW89_MGMT_HW_SEQ_MODE	1
 	bool hiq;
 	u8 port;
+	bool er_cap;
 };
 
 struct rtw89_core_tx_request {
@@ -2194,6 +2195,7 @@ struct rtw89_sec_cam_entry {
 struct rtw89_sta {
 	u8 mac_id;
 	bool disassoc;
+	bool er_cap;
 	struct rtw89_dev *rtwdev;
 	struct rtw89_vif *rtwvif;
 	struct rtw89_ra_info ra;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 017710c580c72..5dc617a0a47a7 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -367,6 +367,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	}
 
 	ra->bw_cap = bw_mode;
+	ra->er_cap = rtwsta->er_cap;
 	ra->mode_ctrl = mode;
 	ra->macid = rtwsta->mac_id;
 	ra->stbc_cap = stbc_en;
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 9d4c6b6fa1250..98eb9607cd218 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -75,7 +75,9 @@
 #define RTW89_TXWD_INFO0_DATA_BW GENMASK(29, 28)
 #define RTW89_TXWD_INFO0_GI_LTF GENMASK(27, 25)
 #define RTW89_TXWD_INFO0_DATA_RATE GENMASK(24, 16)
+#define RTW89_TXWD_INFO0_DATA_ER BIT(15)
 #define RTW89_TXWD_INFO0_DISDATAFB BIT(10)
+#define RTW89_TXWD_INFO0_DATA_BW_ER BIT(8)
 #define RTW89_TXWD_INFO0_MULTIPORT_ID GENMASK(6, 4)
 
 /* TX WD INFO DWORD 1 */
-- 
2.25.1

