Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C33701488
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 07:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjEMFpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEMFpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 01:45:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA3B2D72
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 22:44:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34D5id7B3026705, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34D5id7B3026705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 13 May 2023 13:44:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 13 May 2023 13:44:47 +0800
Received: from [127.0.1.1] (172.16.17.85) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 13 May
 2023 13:44:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: 8851b: rfk: add RX DCK
Date:   Sat, 13 May 2023 13:44:23 +0800
Message-ID: <20230513054425.9689-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230513054425.9689-1-pkshih@realtek.com>
References: <20230513054425.9689-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.85]
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

RX DCK is receiver DC calibration. With this calibration, we have proper
DC offset to reflect correct received signal strength indicator. Do this
calibration when bringing up interface and going to run on AP channel.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   1 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 111 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |   1 +
 3 files changed, 113 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 21f68787ff109..34f3c86abdad5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3821,6 +3821,7 @@
 #define RR_CAL_RW BIT(19)
 #define RR_LUTWE2 0xee
 #define RR_LUTWE2_RTXBW BIT(2)
+#define RR_LUTWE2_DIS BIT(6)
 #define RR_LUTWE 0xef
 #define RR_LUTWE_LOK BIT(2)
 #define RR_RFC 0xf0
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 6eb47ed820102..b12f985b01259 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -35,6 +35,17 @@ enum rtw8851b_iqk_type {
 	ID_IQK_RESTORE = 0x10,
 };
 
+enum rf_mode {
+	RF_SHUT_DOWN = 0x0,
+	RF_STANDBY = 0x1,
+	RF_TX = 0x2,
+	RF_RX = 0x3,
+	RF_TXIQK = 0x4,
+	RF_DPK = 0x5,
+	RF_RXK1 = 0x6,
+	RF_RXK2 = 0x7,
+};
+
 static const u32 g_idxrxgain[RTW8851B_RXK_GROUP_NR] = {0x10e, 0x116, 0x28e, 0x296};
 static const u32 g_idxattc2[RTW8851B_RXK_GROUP_NR] = {0x0, 0xf, 0x0, 0xf};
 static const u32 g_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x0, 0x1, 0x2, 0x3};
@@ -427,6 +438,91 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
 }
 
+static void _rx_dck_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 enum rtw89_rf_path path, bool is_afe)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RX_DCK] ==== S%d RX DCK (%s / CH%d / %s / by %s)====\n", path,
+		    chan->band_type == RTW89_BAND_2G ? "2G" :
+		    chan->band_type == RTW89_BAND_5G ? "5G" : "6G",
+		    chan->channel,
+		    chan->band_width == RTW89_CHANNEL_WIDTH_20 ? "20M" :
+		    chan->band_width == RTW89_CHANNEL_WIDTH_40 ? "40M" : "80M",
+		    is_afe ? "AFE" : "RFC");
+}
+
+static void _rxbb_ofst_swap(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 rf_mode)
+{
+	u32 val, val_i, val_q;
+
+	val_i = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_S1);
+	val_q = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_S1);
+
+	val = val_q << 4 | val_i;
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_DIS, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, rf_mode);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, val);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_DIS, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RX_DCK] val_i = 0x%x, val_q = 0x%x, 0x3F = 0x%x\n",
+		    val_i, val_q, val);
+}
+
+static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 rf_mode)
+{
+	u32 val;
+	int ret;
+
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, val, val,
+				       2, 2000, false,
+				       rtwdev, path, RR_DCK, BIT(8));
+
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RX_DCK] S%d RXDCK finish (ret = %d)\n",
+		    path, ret);
+
+	_rxbb_ofst_swap(rtwdev, path, rf_mode);
+}
+
+static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe)
+{
+	u32 rf_reg5;
+	u8 path;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RX_DCK] ****** RXDCK Start (Ver: 0x%x, Cv: %d) ******\n",
+		    0x2, rtwdev->hal.cv);
+
+	for (path = 0; path < RF_PATH_NUM_8851B; path++) {
+		_rx_dck_info(rtwdev, phy, path, is_afe);
+
+		rf_reg5 = rtw89_read_rf(rtwdev, path, RR_RSV1, RFREG_MASK);
+
+		if (rtwdev->is_tssi_mode[path])
+			rtw89_phy_write32_mask(rtwdev,
+					       R_P0_TSSI_TRK + (path << 13),
+					       B_P0_TSSI_TRK_EN, 0x1);
+
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RF_RX);
+		_set_rx_dck(rtwdev, path, RF_RX);
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
+
+		if (rtwdev->is_tssi_mode[path])
+			rtw89_phy_write32_mask(rtwdev,
+					       R_P0_TSSI_TRK + (path << 13),
+					       B_P0_TSSI_TRK_EN, 0x0);
+	}
+}
+
 static void _iqk_sram(struct rtw89_dev *rtwdev, u8 path)
 {
 	u32 i;
@@ -1553,6 +1649,21 @@ void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
+void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u32 tx_en;
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
+
+	_rx_dck(rtwdev, phy_idx, false);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
+}
+
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			enum rtw89_bandwidth bw, bool dav)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
index d86c630ff47ec..a77b3fd7f58a1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
@@ -11,6 +11,7 @@ void rtw8851b_aack(struct rtw89_dev *rtwdev);
 void rtw8851b_rck(struct rtw89_dev *rtwdev);
 void rtw8851b_dack(struct rtw89_dev *rtwdev);
 void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8851b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1

