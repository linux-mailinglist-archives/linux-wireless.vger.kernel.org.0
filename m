Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D26E3D67
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 04:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDQCTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 22:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDQCTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 22:19:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D035A4
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 19:19:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H2IZnbC031126, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H2IZnbC031126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 10:18:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 17 Apr 2023 10:18:30 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 17 Apr
 2023 10:18:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: add EVM and SNR statistics to debugfs
Date:   Mon, 17 Apr 2023 10:17:04 +0800
Message-ID: <20230417021707.16369-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417021707.16369-1-pkshih@realtek.com>
References: <20230417021707.16369-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

To help debug performance problem, add EVM and SNR statistics to debugfs
that shows

  EVM: [(26.75, 26.75) (25.75, 25.75)]    SNR: 40

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 29 ++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h  | 11 ++++++++
 drivers/net/wireless/realtek/rtw89/debug.c | 16 ++++++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h  |  3 +++
 4 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 9a2464ac954e8..d2bd3dfa31078 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1216,13 +1216,16 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	u8 ant_pos = U8_MAX;
+	u8 evm_pos = 0;
 	int i;
 
 	if (rtwsta->mac_id != phy_ppdu->mac_id || !phy_ppdu->to_self)
 		return;
 
-	if (hal->ant_diversity && hal->antenna_rx)
+	if (hal->ant_diversity && hal->antenna_rx) {
 		ant_pos = __ffs(hal->antenna_rx);
+		evm_pos = ant_pos;
+	}
 
 	ewma_rssi_add(&rtwsta->avg_rssi, phy_ppdu->rssi_avg);
 
@@ -1232,6 +1235,12 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 		for (i = 0; i < rtwdev->chip->rf_path_num; i++)
 			ewma_rssi_add(&rtwsta->rssi[i], phy_ppdu->rssi[i]);
 	}
+
+	if (phy_ppdu->ofdm.has) {
+		ewma_snr_add(&rtwsta->avg_snr, phy_ppdu->ofdm.avg_snr);
+		ewma_evm_add(&rtwsta->evm_min[evm_pos], phy_ppdu->ofdm.evm_min);
+		ewma_evm_add(&rtwsta->evm_max[evm_pos], phy_ppdu->ofdm.evm_max);
+	}
 }
 
 #define VAR_LEN 0xff
@@ -1269,6 +1278,11 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev, u8 *addr,
 	if (!phy_ppdu->to_self)
 		return;
 
+	phy_ppdu->ofdm.avg_snr = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_AVG_SNR);
+	phy_ppdu->ofdm.evm_max = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MAX);
+	phy_ppdu->ofdm.evm_min = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MIN);
+	phy_ppdu->ofdm.has = true;
+
 	/* sign conversion for S(12,2) */
 	if (rtwdev->chip->cfo_src_fd) {
 		t = le32_get_bits(ie->w1, RTW89_PHY_STS_IE01_W1_FD_CFO);
@@ -1319,9 +1333,6 @@ static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 	}
 	rtw89_core_update_phy_ppdu(phy_ppdu);
-	ieee80211_iterate_stations_atomic(rtwdev->hw,
-					  rtw89_core_rx_process_phy_ppdu_iter,
-					  phy_ppdu);
 
 	return 0;
 }
@@ -1362,6 +1373,10 @@ static void rtw89_core_rx_process_phy_sts(struct rtw89_dev *rtwdev,
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "parse phy sts failed\n");
 	else
 		phy_ppdu->valid = true;
+
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  rtw89_core_rx_process_phy_ppdu_iter,
+					  phy_ppdu);
 }
 
 static u8 rtw89_rxdesc_to_nl_he_gi(struct rtw89_dev *rtwdev,
@@ -2755,8 +2770,12 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
 
 	ewma_rssi_init(&rtwsta->avg_rssi);
-	for (i = 0; i < ant_num; i++)
+	ewma_snr_init(&rtwsta->avg_snr);
+	for (i = 0; i < ant_num; i++) {
 		ewma_rssi_init(&rtwsta->rssi[i]);
+		ewma_evm_init(&rtwsta->evm_min[i]);
+		ewma_evm_init(&rtwsta->evm_max[i]);
+	}
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 35413101a15ef..217355d2ee50f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -551,6 +551,12 @@ struct rtw89_rx_phy_ppdu {
 	u8 chan_idx;
 	u8 ie;
 	u16 rate;
+	struct {
+		bool has;
+		u8 avg_snr;
+		u8 evm_max;
+		u8 evm_min;
+	} ofdm;
 	bool to_self;
 	bool valid;
 };
@@ -2530,6 +2536,8 @@ struct rtw89_ra_report {
 };
 
 DECLARE_EWMA(rssi, 10, 16);
+DECLARE_EWMA(evm, 10, 16);
+DECLARE_EWMA(snr, 10, 16);
 
 struct rtw89_ba_cam_entry {
 	struct list_head list;
@@ -2592,6 +2600,9 @@ struct rtw89_sta {
 	u8 prev_rssi;
 	struct ewma_rssi avg_rssi;
 	struct ewma_rssi rssi[RF_PATH_MAX];
+	struct ewma_snr avg_snr;
+	struct ewma_evm evm_min[RF_PATH_MAX];
+	struct ewma_evm evm_max[RF_PATH_MAX];
 	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
 	struct ieee80211_rx_status rx_status;
 	u16 rx_hw_rate;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 73206376f0bf0..171e38ce1deea 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3213,7 +3213,9 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	bool ant_asterisk = hal->tx_path_diversity || hal->ant_diversity;
+	u8 evm_min, evm_max;
 	u8 rssi;
+	u8 snr;
 	int i;
 
 	seq_printf(m, "TX rate [%d]: ", rtwsta->mac_id);
@@ -3270,6 +3272,20 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 			   i + 1 == ant_num ? "" : ", ");
 	}
 	seq_puts(m, "]\n");
+
+	seq_puts(m, "EVM: [");
+	for (i = 0; i < (hal->ant_diversity ? 2 : 1); i++) {
+		evm_min = ewma_evm_read(&rtwsta->evm_min[i]);
+		evm_max = ewma_evm_read(&rtwsta->evm_max[i]);
+
+		seq_printf(m, "%s(%2u.%02u, %2u.%02u)", i == 0 ? "" : " ",
+			   evm_min >> 2, (evm_min & 0x3) * 25,
+			   evm_max >> 2, (evm_max & 0x3) * 25);
+	}
+	seq_puts(m, "]\t");
+
+	snr = ewma_snr_read(&rtwsta->avg_snr);
+	seq_printf(m, "SNR: %u\n", snr);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 5c050278fd468..d880ecb879ca8 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -308,6 +308,9 @@ struct rtw89_phy_sts_ie0 {
 #define RTW89_PHY_STS_IE01_W0_CH_IDX GENMASK(23, 16)
 #define RTW89_PHY_STS_IE01_W1_FD_CFO GENMASK(19, 8)
 #define RTW89_PHY_STS_IE01_W1_PREMB_CFO GENMASK(31, 20)
+#define RTW89_PHY_STS_IE01_W2_AVG_SNR GENMASK(5, 0)
+#define RTW89_PHY_STS_IE01_W2_EVM_MAX GENMASK(15, 8)
+#define RTW89_PHY_STS_IE01_W2_EVM_MIN GENMASK(23, 16)
 
 enum rtw89_tx_channel {
 	RTW89_TXCH_ACH0	= 0,
-- 
2.25.1

