Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF5685DE2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 04:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBADVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 22:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBADVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 22:21:50 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F29E3433E
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 19:21:36 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3113LGAA0029704, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3113LGAA0029704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 1 Feb 2023 11:21:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 1 Feb 2023 11:21:21 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 1 Feb 2023
 11:21:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: use passed channel in set_tx_shape_dfir()
Date:   Wed, 1 Feb 2023 11:20:57 +0800
Message-ID: <20230201032057.7349-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In path of setting channel and setting TX power, the rtw89_chan instance
to be used is controlled by top and passed down. The set_tx_shape_dfir()
is in path of setting TX power, so it should use the passed rtw89_chan
instead of querying it itself. Otherwise, it might encounter mismatch
between parameters if multi-channel.

For example,
rtw89_8852ce 0000:04:00.0: set tx shape dfir by unknown ch: 155 on 2GHz

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index c6345228d049f..8c543a6551209 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1618,6 +1618,7 @@ static void rtw8852b_set_txpwr_ref(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852b_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan,
 					  u8 tx_shape_idx,
 					  enum rtw89_phy_idx phy_idx)
 {
@@ -1637,7 +1638,6 @@ static void rtw8852b_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
 	__DECL_DFIR_PARAM(sharp_14,
 			  0x023B13FF, 0x001C42DE, 0x00FDB0AD, 0x00F60F6E,
 			  0x00FD8F92, 0x0602D011, 0x0001C02C, 0x00FFF00A);
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 ch = chan->channel;
 	const u32 *param;
 	u32 addr;
@@ -1678,7 +1678,7 @@ static void rtw8852b_set_tx_shape(struct rtw89_dev *rtwdev,
 	u8 tx_shape_ofdm = rtw89_8852b_tx_shape[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
-		rtw8852b_bb_set_tx_shape_dfir(rtwdev, tx_shape_cck, phy_idx);
+		rtw8852b_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
 
 	rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT, B_TXSHAPE_TRIANGULAR_CFG,
 			       tx_shape_ofdm);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 00fbb65355061..c51943919da5a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1968,6 +1968,7 @@ static void rtw8852c_set_txpwr_ref(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan,
 					  u8 tx_shape_idx,
 					  enum rtw89_phy_idx phy_idx)
 {
@@ -1991,7 +1992,6 @@ static void rtw8852c_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
 	__DECL_DFIR_ADDR(filter,
 			 0x45BC, 0x45CC, 0x45D0, 0x45D4, 0x45D8, 0x45C0,
 			 0x45C4, 0x45C8);
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 ch = chan->channel;
 	const u32 *param;
 	int i;
@@ -2032,7 +2032,7 @@ static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 	u8 tx_shape_ofdm = rtw89_8852c_tx_shape[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
-		rtw8852c_bb_set_tx_shape_dfir(rtwdev, tx_shape_cck, phy_idx);
+		rtw8852c_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
 
 	rtw89_phy_tssi_ctrl_set_bandedge_cfg(rtwdev,
 					     (enum rtw89_mac_idx)phy_idx,
-- 
2.25.1

