Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192A7708E31
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 05:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjESDPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 23:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjESDPX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 23:15:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5134410CF
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 20:15:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J3F65F0004516, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J3F65F0004516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 11:15:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 19 May 2023 11:15:15 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 May
 2023 11:15:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: 8851b: add RF configurations
Date:   Fri, 19 May 2023 11:14:57 +0800
Message-ID: <20230519031500.21087-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519031500.21087-1-pkshih@realtek.com>
References: <20230519031500.21087-1-pkshih@realtek.com>
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

RF configurations include RF calibrations and getting thermal value.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 148cf00744120..eb98d4adc306b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1542,6 +1542,44 @@ static void rtw8851b_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	}
 }
 
+static void rtw8851b_rfk_init(struct rtw89_dev *rtwdev)
+{
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+
+	rtw8851b_dpk_init(rtwdev);
+	rtw8851b_aack(rtwdev);
+	rtw8851b_rck(rtwdev);
+	rtw8851b_dack(rtwdev);
+	rtw8851b_rx_dck(rtwdev, RTW89_PHY_0);
+}
+
+static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+
+	rtw8851b_rx_dck(rtwdev, phy_idx);
+	rtw8851b_iqk(rtwdev, phy_idx);
+	rtw8851b_tssi(rtwdev, phy_idx, true);
+	rtw8851b_dpk(rtwdev, phy_idx);
+}
+
+static void rtw8851b_rfk_band_changed(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
+{
+	rtw8851b_tssi_scan(rtwdev, phy_idx);
+}
+
+static void rtw8851b_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+{
+	rtw8851b_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+}
+
+static void rtw8851b_rfk_track(struct rtw89_dev *rtwdev)
+{
+	rtw8851b_dpk_track(rtwdev);
+}
+
 static u32 rtw8851b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx, s16 ref)
 {
@@ -1837,6 +1875,23 @@ static void rtw8851b_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0x0, RTW89_PHY_0);
 }
 
+static u8 rtw8851b_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
+{
+	if (rtwdev->is_tssi_mode[rf_path]) {
+		u32 addr = R_TSSI_THER + (rf_path << 13);
+
+		return rtw89_phy_read32_mask(rtwdev, addr, B_TSSI_THER);
+	}
+
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x0);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+
+	fsleep(200);
+
+	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
+}
+
 static void rtw8851b_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -2226,10 +2281,16 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.read_phycap		= rtw8851b_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= rtw8851b_rfe_gpio,
+	.rfk_init		= rtw8851b_rfk_init,
+	.rfk_channel		= rtw8851b_rfk_channel,
+	.rfk_band_changed	= rtw8851b_rfk_band_changed,
+	.rfk_scan		= rtw8851b_rfk_scan,
+	.rfk_track		= rtw8851b_rfk_track,
 	.power_trim		= rtw8851b_power_trim,
 	.set_txpwr		= rtw8851b_set_txpwr,
 	.set_txpwr_ctrl		= rtw8851b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8851b_init_txpwr_unit,
+	.get_thermal		= rtw8851b_get_thermal,
 	.ctrl_btg		= rtw8851b_ctrl_btg,
 	.query_ppdu		= rtw8851b_query_ppdu,
 	.bb_ctrl_btc_preagc	= rtw8851b_bb_ctrl_btc_preagc,
-- 
2.25.1

