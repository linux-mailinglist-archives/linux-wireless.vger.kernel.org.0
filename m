Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3B5AB2E2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiIBOFV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiIBOEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:04:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55CC816D14B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:33:16 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 282CiWtiD014099, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 282CiWtiD014099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Sep 2022 20:44:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Sep 2022 20:44:50 +0800
Received: from localhost (172.16.17.75) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Sep 2022
 20:44:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: record signal strength per RF path
Date:   Fri, 2 Sep 2022 20:44:21 +0800
Message-ID: <20220902124422.13610-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902124422.13610-1-pkshih@realtek.com>
References: <20220902124422.13610-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.75]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/02/2022 12:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMiCkV6TIIDA3OjQ1OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Originally, we show average signal strength. To support TX diversity, this
patch prepares strength per path, then we can decide TX path.

  RSSI: -54 dBm (raw=112, prev=110) [-57, -52]

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 20 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h     |  4 +++-
 drivers/net/wireless/realtek/rtw89/debug.c    | 10 +++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 +++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 +++---
 5 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 71ee237a7c286..0f474b50b161e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1143,9 +1143,14 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = (struct rtw89_rx_phy_ppdu *)data;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	int i;
 
-	if (rtwsta->mac_id == phy_ppdu->mac_id && phy_ppdu->to_self)
+	if (rtwsta->mac_id == phy_ppdu->mac_id && phy_ppdu->to_self) {
 		ewma_rssi_add(&rtwsta->avg_rssi, phy_ppdu->rssi_avg);
+		for (i = 0; i < rtwdev->chip->rf_path_num; i++)
+			ewma_rssi_add(&rtwsta->rssi[i], phy_ppdu->rssi[i]);
+	}
 }
 
 #define VAR_LEN 0xff
@@ -1201,15 +1206,15 @@ static int rtw89_core_process_phy_status_ie(struct rtw89_dev *rtwdev, u8 *addr,
 
 static void rtw89_core_update_phy_ppdu(struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
-	s8 *rssi = phy_ppdu->rssi;
+	u8 *rssi = phy_ppdu->rssi;
 	u8 *buf = phy_ppdu->buf;
 
 	phy_ppdu->ie = RTW89_GET_PHY_STS_IE_MAP(buf);
 	phy_ppdu->rssi_avg = RTW89_GET_PHY_STS_RSSI_AVG(buf);
-	rssi[RF_PATH_A] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_A(buf));
-	rssi[RF_PATH_B] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_B(buf));
-	rssi[RF_PATH_C] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_C(buf));
-	rssi[RF_PATH_D] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_D(buf));
+	rssi[RF_PATH_A] = RTW89_GET_PHY_STS_RSSI_A(buf);
+	rssi[RF_PATH_B] = RTW89_GET_PHY_STS_RSSI_B(buf);
+	rssi[RF_PATH_C] = RTW89_GET_PHY_STS_RSSI_C(buf);
+	rssi[RF_PATH_D] = RTW89_GET_PHY_STS_RSSI_D(buf);
 }
 
 static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
@@ -2365,6 +2370,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int i;
 
+	rtwsta->rtwdev = rtwdev;
 	rtwsta->rtwvif = rtwvif;
 	rtwsta->prev_rssi = 0;
 	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
@@ -2373,6 +2379,8 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
 
 	ewma_rssi_init(&rtwsta->avg_rssi);
+	for (i = 0; i < rtwdev->chip->rf_path_num; i++)
+		ewma_rssi_init(&rtwsta->rssi[i]);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3f944e631ee23..392a8bf4372e8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -522,7 +522,7 @@ struct rtw89_rx_phy_ppdu {
 	u8 *buf;
 	u32 len;
 	u8 rssi_avg;
-	s8 rssi[RF_PATH_MAX];
+	u8 rssi[RF_PATH_MAX];
 	u8 mac_id;
 	u8 chan_idx;
 	u8 ie;
@@ -2136,12 +2136,14 @@ struct rtw89_sec_cam_entry {
 struct rtw89_sta {
 	u8 mac_id;
 	bool disassoc;
+	struct rtw89_dev *rtwdev;
 	struct rtw89_vif *rtwvif;
 	struct rtw89_ra_info ra;
 	struct rtw89_ra_report ra_report;
 	int max_agg_wait;
 	u8 prev_rssi;
 	struct ewma_rssi avg_rssi;
+	struct ewma_rssi rssi[RF_PATH_MAX];
 	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
 	struct ieee80211_rx_status rx_status;
 	u16 rx_hw_rate;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 738cfcd6fd328..5cce542b77652 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2290,7 +2290,9 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	struct rate_info *rate = &rtwsta->ra_report.txrate;
 	struct ieee80211_rx_status *status = &rtwsta->rx_status;
 	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
 	u8 rssi;
+	int i;
 
 	seq_printf(m, "TX rate [%d]: ", rtwsta->mac_id);
 
@@ -2335,8 +2337,14 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	seq_printf(m, "\t(hw_rate=0x%x)\n", rtwsta->rx_hw_rate);
 
 	rssi = ewma_rssi_read(&rtwsta->avg_rssi);
-	seq_printf(m, "RSSI: %d dBm (raw=%d, prev=%d)\n",
+	seq_printf(m, "RSSI: %d dBm (raw=%d, prev=%d) [",
 		   RTW89_RSSI_RAW_TO_DBM(rssi), rssi, rtwsta->prev_rssi);
+	for (i = 0; i < rtwdev->chip->rf_path_num; i++) {
+		rssi = ewma_rssi_read(&rtwsta->rssi[i]);
+		seq_printf(m, "%d%s", RTW89_RSSI_RAW_TO_DBM(rssi),
+			   i + 1 == rtwdev->chip->rf_path_num ? "" : ", ");
+	}
+	seq_puts(m, "]\n");
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c872c8bfb33df..d25fe3f14b303 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2051,12 +2051,12 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 				struct ieee80211_rx_status *status)
 {
 	u8 path;
-	s8 *rx_power = phy_ppdu->rssi;
+	u8 *rx_power = phy_ppdu->rssi;
 
-	status->signal = max_t(s8, rx_power[RF_PATH_A], rx_power[RF_PATH_B]);
+	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
-		status->chain_signal[path] = rx_power[path];
+		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
 	}
 	if (phy_ppdu->valid)
 		rtw8852a_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ac025618374f3..0e5461b02660b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2837,12 +2837,12 @@ static void rtw8852c_query_ppdu(struct rtw89_dev *rtwdev,
 				struct ieee80211_rx_status *status)
 {
 	u8 path;
-	s8 *rx_power = phy_ppdu->rssi;
+	u8 *rx_power = phy_ppdu->rssi;
 
-	status->signal = max_t(s8, rx_power[RF_PATH_A], rx_power[RF_PATH_B]);
+	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
-		status->chain_signal[path] = rx_power[path];
+		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
 	}
 	if (phy_ppdu->valid)
 		rtw8852c_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
-- 
2.25.1

