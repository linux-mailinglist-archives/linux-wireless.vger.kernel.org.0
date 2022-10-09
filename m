Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E995F8B5F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJIMyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJIMyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 432D8C38
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299CruniF029516, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299CruniF029516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:53:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 20:54:25 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/9] wifi: rtw89: 8852b: add basic baseband chip_ops
Date:   Sun, 9 Oct 2022 20:53:57 +0800
Message-ID: <20221009125403.19662-4-pkshih@realtek.com>
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

chip_ops::bb_reset is to reset baseband state after loading parameters,
because its state could be unpredictable at that moment. The other is
chip_ops::bb_sethw that is to set some baseband settings not including in
parameter tables.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f54a4ea3c6b53..f13c657f4d68d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1066,6 +1066,46 @@ static void rtw8852b_bb_reset_en(struct rtw89_dev *rtwdev, enum rtw89_band band,
 	}
 }
 
+static void rtw8852b_bb_reset(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_write32_set(rtwdev, R_P0_TXPW_RSTB, B_P0_TXPW_RSTB_MANON);
+	rtw89_phy_write32_set(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_TRK_EN);
+	rtw89_phy_write32_set(rtwdev, R_P1_TXPW_RSTB, B_P1_TXPW_RSTB_MANON);
+	rtw89_phy_write32_set(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_TRK_EN);
+	rtw8852b_bb_reset_all(rtwdev, phy_idx);
+	rtw89_phy_write32_clr(rtwdev, R_P0_TXPW_RSTB, B_P0_TXPW_RSTB_MANON);
+	rtw89_phy_write32_clr(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_TRK_EN);
+	rtw89_phy_write32_clr(rtwdev, R_P1_TXPW_RSTB, B_P1_TXPW_RSTB_MANON);
+	rtw89_phy_write32_clr(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_TRK_EN);
+}
+
+static void rtw8852b_bb_macid_ctrl_init(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_idx phy_idx)
+{
+	u32 addr;
+
+	for (addr = R_AX_PWR_MACID_LMT_TABLE0;
+	     addr <= R_AX_PWR_MACID_LMT_TABLE127; addr += 4)
+		rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, 0);
+}
+
+static void rtw8852b_bb_sethw(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+
+	rtw89_phy_write32_clr(rtwdev, R_P0_EN_SOUND_WO_NDP, B_P0_EN_SOUND_WO_NDP);
+	rtw89_phy_write32_clr(rtwdev, R_P1_EN_SOUND_WO_NDP, B_P1_EN_SOUND_WO_NDP);
+
+	rtw8852b_bb_macid_ctrl_init(rtwdev, RTW89_PHY_0);
+
+	/* read these registers after loading BB parameters */
+	gain->offset_base[RTW89_PHY_0] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_RPL1, B_P0_RPL1_BIAS_MASK);
+	gain->rssi_base[RTW89_PHY_0] =
+		rtw89_phy_read32_mask(rtwdev, R_P1_RPL1, B_P0_RPL1_BIAS_MASK);
+}
+
 static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
 {
@@ -1413,6 +1453,8 @@ static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
+	.bb_reset		= rtw8852b_bb_reset,
+	.bb_sethw		= rtw8852b_bb_sethw,
 	.set_channel		= rtw8852b_set_channel,
 	.set_channel_help	= rtw8852b_set_channel_help,
 	.read_efuse		= rtw8852b_read_efuse,
-- 
2.25.1

