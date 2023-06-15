Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4F73198B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 15:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbjFONFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243272AbjFONFf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 09:05:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BEB269D
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 06:05:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35FD58deC032343, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35FD58deC032343
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 15 Jun 2023 21:05:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 15 Jun 2023 21:05:27 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 15 Jun
 2023 21:05:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: 8851b: configure to force 1 TX power value
Date:   Thu, 15 Jun 2023 21:04:42 +0800
Message-ID: <20230615130442.18116-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615130442.18116-1-pkshih@realtek.com>
References: <20230615130442.18116-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.227]
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

RTL8851B is a chip with only single RF path, and it must use 1 TX power
value for transmission, so force 1 TX power value to prevent hardware
logic gets wrong TX power values randomly in certain samples.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 22 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c515bc2a10afd..55595fde74949 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3333,6 +3333,28 @@
 #define R_AX_PWR_UL_CTRL2 0xD248
 #define B_AX_PWR_UL_CFO_MASK GENMASK(2, 0)
 #define B_AX_PWR_UL_CTRL2_MASK 0x07700007
+
+#define R_AX_PWR_NORM_FORCE1 0xD260
+#define R_AX_PWR_NORM_FORCE1_C1 0xF260
+#define B_AX_TXAGC_BF_PWR_BOOST_FORCE_VAL_EN BIT(29)
+#define B_AX_TXAGC_BF_PWR_BOOST_FORCE_VAL_MASK GENMASK(28, 24)
+#define B_AX_FORCE_HE_ER_SU_EN_EN BIT(23)
+#define B_AX_FORCE_HE_ER_SU_EN_VALUE BIT(22)
+#define B_AX_FORCE_MACID_CCA_TH_EN_EN BIT(21)
+#define B_AX_FORCE_MACID_CCA_TH_EN_VALUE BIT(20)
+#define B_AX_FORCE_BT_GRANT_EN BIT(19)
+#define B_AX_FORCE_BT_GRANT_VALUE BIT(18)
+#define B_AX_FORCE_RX_LTE_EN BIT(17)
+#define B_AX_FORCE_RX_LTE_VALUE BIT(16)
+#define B_AX_FORCE_TXBF_EN_EN BIT(15)
+#define B_AX_FORCE_TXBF_EN_VALUE BIT(14)
+#define B_AX_FORCE_TXSC_EN BIT(13)
+#define B_AX_FORCE_TXSC_VALUE_MASK GENMASK(12, 9)
+#define B_AX_FORCE_NTX_EN BIT(6)
+#define B_AX_FORCE_NTX_VALUE BIT(5)
+#define B_AX_FORCE_PWR_MODE_EN BIT(3)
+#define B_AX_FORCE_PWR_MODE_VALUE_MASK GENMASK(2, 0)
+
 #define R_AX_PWR_UL_TB_CTRL 0xD288
 #define B_AX_PWR_UL_TB_CTRL_EN BIT(31)
 #define R_AX_PWR_UL_TB_1T 0xD28C
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 3a912896031c0..c3ffcb645ebf7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1442,6 +1442,9 @@ static void rtw8851b_bb_sethw(struct rtw89_dev *rtwdev)
 	rtw8851b_bb_macid_ctrl_init(rtwdev, RTW89_PHY_0);
 	rtw8851b_bb_gpio_init(rtwdev);
 
+	rtw89_write32_clr(rtwdev, R_AX_PWR_NORM_FORCE1, B_AX_FORCE_NTX_VALUE);
+	rtw89_write32_set(rtwdev, R_AX_PWR_NORM_FORCE1, B_AX_FORCE_NTX_EN);
+
 	/* read these registers after loading BB parameters */
 	gain->offset_base[RTW89_PHY_0] =
 		rtw89_phy_read32_mask(rtwdev, R_P0_RPL1, B_P0_RPL1_BIAS_MASK);
-- 
2.25.1

