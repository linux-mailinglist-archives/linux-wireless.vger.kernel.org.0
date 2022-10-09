Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF035F8B5D
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJIMyt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiJIMym (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA88B63
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299CrxXL3029528, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299CrxXL3029528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:53:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sun, 9 Oct 2022 20:54:28 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/9] wifi: rtw89: 8852b: add chip_ops to query PPDU
Date:   Sun, 9 Oct 2022 20:54:00 +0800
Message-ID: <20221009125403.19662-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009125403.19662-1-pkshih@realtek.com>
References: <20221009125403.19662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.215]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/09/2022 12:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzkgpFekyCAwOTowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add to parse PPDU to get frequency and RSSI of received packets.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index ee5a29f35db25..abb35553a2b04 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1707,6 +1707,37 @@ static void rtw8852b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 {
 }
 
+static void rtw8852b_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu,
+					 struct ieee80211_rx_status *status)
+{
+	u16 chan = phy_ppdu->chan_idx;
+	u8 band;
+
+	if (chan == 0)
+		return;
+
+	band = chan <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+	status->freq = ieee80211_channel_to_frequency(chan, band);
+	status->band = band;
+}
+
+static void rtw8852b_query_ppdu(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_phy_ppdu *phy_ppdu,
+				struct ieee80211_rx_status *status)
+{
+	u8 path;
+	u8 *rx_power = phy_ppdu->rssi;
+
+	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		status->chains |= BIT(path);
+		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
+	}
+	if (phy_ppdu->valid)
+		rtw8852b_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
+}
+
 static int rtw8852b_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -1775,6 +1806,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
 	.get_thermal		= rtw8852b_get_thermal,
 	.ctrl_btg		= rtw8852b_ctrl_btg,
+	.query_ppdu		= rtw8852b_query_ppdu,
 	.bb_ctrl_btc_preagc	= rtw8852b_bb_ctrl_btc_preagc,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
-- 
2.25.1

