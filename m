Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA375F8B5E
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJIMyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiJIMym (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED8FCBA4
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299CrsWnB029508, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299CrsWnB029508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:53:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 20:54:23 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/9] wifi: rtw89: 8852b: add chip_ops::set_channel_help
Date:   Sun, 9 Oct 2022 20:53:55 +0800
Message-ID: <20221009125403.19662-2-pkshih@realtek.com>
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

This chip_ops is to assist set_channel, because we need setup and restore
hardware before and after set_channel.

Before set_channel, we stop transmitting, reset PPDU status, disable TSSI,
and disable ADC. After set_channel, do opposite things in reverse order.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b50fff00b1393..af04a0284b560 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -854,6 +854,30 @@ static void rtw8852b_bb_reset_all(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
 }
 
+static void rtw8852b_bb_reset_en(struct rtw89_dev *rtwdev, enum rtw89_band band,
+				 enum rtw89_phy_idx phy_idx, bool en)
+{
+	if (en) {
+		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
+				      B_S0_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS,
+				      B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+		if (band == RTW89_BAND_2G)
+			rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x1);
+		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
+				      B_S0_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS,
+				      B_S1_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+		fsleep(1);
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, phy_idx);
+	}
+}
+
 static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
 {
@@ -897,6 +921,65 @@ static void rtw8852b_set_channel(struct rtw89_dev *rtwdev,
 	rtw8852b_set_channel_rf(rtwdev, chan, phy_idx);
 }
 
+static void rtw8852b_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
+				  enum rtw89_rf_path path)
+{
+	static const u32 tssi_trk[2] = {R_P0_TSSI_TRK, R_P1_TSSI_TRK};
+	static const u32 ctrl_bbrst[2] = {R_P0_TXPW_RSTB, R_P1_TXPW_RSTB};
+
+	if (en) {
+		rtw89_phy_write32_mask(rtwdev, ctrl_bbrst[path], B_P0_TXPW_RSTB_MANON, 0x0);
+		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], B_P0_TSSI_TRK_EN, 0x0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, ctrl_bbrst[path], B_P0_TXPW_RSTB_MANON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], B_P0_TSSI_TRK_EN, 0x1);
+	}
+}
+
+static void rtw8852b_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en,
+					 u8 phy_idx)
+{
+	if (!rtwdev->dbcc_en) {
+		rtw8852b_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		rtw8852b_tssi_cont_en(rtwdev, en, RF_PATH_B);
+	} else {
+		if (phy_idx == RTW89_PHY_0)
+			rtw8852b_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		else
+			rtw8852b_tssi_cont_en(rtwdev, en, RF_PATH_B);
+	}
+}
+
+static void rtw8852b_adc_en(struct rtw89_dev *rtwdev, bool en)
+{
+	if (en)
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0x0);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0xf);
+}
+
+static void rtw8852b_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
+				      struct rtw89_channel_help_params *p,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_mac_idx mac_idx,
+				      enum rtw89_phy_idx phy_idx)
+{
+	if (enter) {
+		rtw89_chip_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+		rtw8852b_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
+		rtw8852b_adc_en(rtwdev, false);
+		fsleep(40);
+		rtw8852b_bb_reset_en(rtwdev, chan->band_type, phy_idx, false);
+	} else {
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+		rtw8852b_adc_en(rtwdev, true);
+		rtw8852b_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0);
+		rtw8852b_bb_reset_en(rtwdev, chan->band_type, phy_idx, true);
+		rtw89_chip_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
+	}
+}
+
 static u32 rtw8852b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx, s16 ref)
 {
@@ -1143,6 +1226,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
 	.set_channel		= rtw8852b_set_channel,
+	.set_channel_help	= rtw8852b_set_channel_help,
 	.read_efuse		= rtw8852b_read_efuse,
 	.read_phycap		= rtw8852b_read_phycap,
 	.power_trim		= rtw8852b_power_trim,
-- 
2.25.1

