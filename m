Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69A36E5675
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 03:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDRB3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 21:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjDRB27 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 21:28:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC785B97
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 18:28:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33I1SeET2015069, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33I1SeET2015069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 09:28:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 18 Apr 2023 09:28:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 18 Apr
 2023 09:28:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/7] wifi: rtw89: add RSSI statistics for the case of antenna diversity to debugfs
Date:   Tue, 18 Apr 2023 09:28:16 +0800
Message-ID: <20230418012820.5139-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418012820.5139-1-pkshih@realtek.com>
References: <20230418012820.5139-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

RSSI strength is only from PHY path A, but there are two antenna for the
module which supports antenna diversity. So, set RSSI value to index 1 of
RSSI array if current antenna is on antenna B. Then, debugfs can show
two RSSI values with a asterisk mark on selected antenna.

  RSSI: -23 dBm (raw=174, prev=173) [-26, -23*]

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 20 +++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/debug.c |  8 +++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 42e68ec150757..5271d596b04d7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1244,10 +1244,22 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = (struct rtw89_rx_phy_ppdu *)data;
 	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
+	u8 ant_pos = U8_MAX;
 	int i;
 
-	if (rtwsta->mac_id == phy_ppdu->mac_id && phy_ppdu->to_self) {
-		ewma_rssi_add(&rtwsta->avg_rssi, phy_ppdu->rssi_avg);
+	if (rtwsta->mac_id != phy_ppdu->mac_id || !phy_ppdu->to_self)
+		return;
+
+	if (hal->ant_diversity && hal->antenna_rx)
+		ant_pos = __ffs(hal->antenna_rx);
+
+	ewma_rssi_add(&rtwsta->avg_rssi, phy_ppdu->rssi_avg);
+
+	if (ant_pos < ant_num) {
+		ewma_rssi_add(&rtwsta->rssi[ant_pos], phy_ppdu->rssi[0]);
+	} else {
 		for (i = 0; i < rtwdev->chip->rf_path_num; i++)
 			ewma_rssi_add(&rtwsta->rssi[i], phy_ppdu->rssi[i]);
 	}
@@ -2764,6 +2776,8 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	int i;
 	int ret;
 
@@ -2777,7 +2791,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
 
 	ewma_rssi_init(&rtwsta->avg_rssi);
-	for (i = 0; i < rtwdev->chip->rf_path_num; i++)
+	for (i = 0; i < ant_num; i++)
 		ewma_rssi_init(&rtwsta->rssi[i]);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 0e0e1483c099b..73206376f0bf0 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3211,6 +3211,8 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	struct seq_file *m = (struct seq_file *)data;
 	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
+	bool ant_asterisk = hal->tx_path_diversity || hal->ant_diversity;
 	u8 rssi;
 	int i;
 
@@ -3261,11 +3263,11 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	rssi = ewma_rssi_read(&rtwsta->avg_rssi);
 	seq_printf(m, "RSSI: %d dBm (raw=%d, prev=%d) [",
 		   RTW89_RSSI_RAW_TO_DBM(rssi), rssi, rtwsta->prev_rssi);
-	for (i = 0; i < rtwdev->chip->rf_path_num; i++) {
+	for (i = 0; i < ant_num; i++) {
 		rssi = ewma_rssi_read(&rtwsta->rssi[i]);
 		seq_printf(m, "%d%s%s", RTW89_RSSI_RAW_TO_DBM(rssi),
-			   hal->tx_path_diversity && (hal->antenna_tx & BIT(i)) ? "*" : "",
-			   i + 1 == rtwdev->chip->rf_path_num ? "" : ", ");
+			   ant_asterisk && (hal->antenna_tx & BIT(i)) ? "*" : "",
+			   i + 1 == ant_num ? "" : ", ");
 	}
 	seq_puts(m, "]\n");
 }
-- 
2.25.1

