Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A90D63846F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 08:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKYHZc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 02:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKYHZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 02:25:29 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7872DAAB
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 23:25:26 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AP7OWblC004912, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AP7OWblC004912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Nov 2022 15:24:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 25 Nov 2022 15:25:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 25 Nov
 2022 15:25:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: 8852b: turn off PoP function in monitor mode
Date:   Fri, 25 Nov 2022 15:24:16 +0800
Message-ID: <20221125072416.94752-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125072416.94752-1-pkshih@realtek.com>
References: <20221125072416.94752-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/25/2022 07:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI1IKRXpMggMDQ6MTA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PoP stands for Packet on Packet that can improve performance in noisy
environment, but it could get RX stuck suddenly. In normal mode, firmware
can help to resolve the stuck, but firmware doesn't work in monitor mode.
Therefore, turn off PoP to avoid RX stuck.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index dbe06542f443f..f2634062f377d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4236,6 +4236,8 @@
 #define R_P1_NBIIDX 0x4770
 #define B_P1_NBIIDX_VAL GENMASK(11, 0)
 #define B_P1_NBIIDX_NOTCH_EN BIT(12)
+#define R_PKT_CTRL 0x47D4
+#define B_PKT_POP_EN BIT(8)
 #define R_SEG0R_PD 0x481C
 #define R_SEG0R_PD_V1 0x4860
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1 BIT(30)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 2d4d572dc601f..b635ac1d1ca2f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1411,6 +1411,12 @@ static void rtw8852b_bb_sethw(struct rtw89_dev *rtwdev)
 		rtw89_phy_read32_mask(rtwdev, R_P1_RPL1, B_P0_RPL1_BIAS_MASK);
 }
 
+static void rtw8852b_bb_set_pop(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR)
+		rtw89_phy_write32_clr(rtwdev, R_PKT_CTRL, B_PKT_POP_EN);
+}
+
 static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
 {
@@ -1441,6 +1447,7 @@ static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89
 	rtw89_phy_write32_mask(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0,
 			       chan->primary_channel);
 	rtw8852b_5m_mask(rtwdev, chan, phy_idx);
+	rtw8852b_bb_set_pop(rtwdev);
 	rtw8852b_bb_reset_all(rtwdev, phy_idx);
 }
 
-- 
2.25.1

