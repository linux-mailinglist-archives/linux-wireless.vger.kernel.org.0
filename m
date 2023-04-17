Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE06E3D5B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 04:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDQCRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 22:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDQCRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 22:17:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187EB213A
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 19:17:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H2HFhZ4029099, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H2HFhZ4029099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 10:17:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 10:17:38 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 17 Apr
 2023 10:17:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: use struct rtw89_phy_sts_ie0 insted of macro to access PHY IE0 status
Date:   Mon, 17 Apr 2023 10:17:01 +0800
Message-ID: <20230417021707.16369-2-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To be more clear to know where it gets information from PHY IE0 data,
change to use struct and standard le32_get_bits() to access. This doesn't
change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 15 ++++++++++-----
 drivers/net/wireless/realtek/rtw89/txrx.h | 16 ++++++++++------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d144903c60b3d..157287ea86b46 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1246,9 +1246,11 @@ static u16 rtw89_core_get_phy_status_ie_len(struct rtw89_dev *rtwdev, u8 *addr)
 static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev, u8 *addr,
 					     struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
+	const struct rtw89_phy_sts_ie0 *ie = (const struct rtw89_phy_sts_ie0 *)addr;
 	s16 cfo;
+	u32 t;
 
-	phy_ppdu->chan_idx = RTW89_GET_PHY_STS_IE01_CH_IDX(addr);
+	phy_ppdu->chan_idx = le32_get_bits(ie->w0, RTW89_PHY_STS_IE01_W0_CH_IDX);
 	if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6)
 		return;
 
@@ -1256,10 +1258,13 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev, u8 *addr,
 		return;
 
 	/* sign conversion for S(12,2) */
-	if (rtwdev->chip->cfo_src_fd)
-		cfo = sign_extend32(RTW89_GET_PHY_STS_IE01_FD_CFO(addr), 11);
-	else
-		cfo = sign_extend32(RTW89_GET_PHY_STS_IE01_PREMB_CFO(addr), 11);
+	if (rtwdev->chip->cfo_src_fd) {
+		t = le32_get_bits(ie->w1, RTW89_PHY_STS_IE01_W1_FD_CFO);
+		cfo = sign_extend32(t, 11);
+	} else {
+		t = le32_get_bits(ie->w1, RTW89_PHY_STS_IE01_W1_PREMB_CFO);
+		cfo = sign_extend32(t, 11);
+	}
 
 	rtw89_phy_cfo_parse(rtwdev, cfo, phy_ppdu);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 98eb9607cd218..5c050278fd468 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -298,12 +298,16 @@
 	le32_get_bits(*((const __le32 *)ie), GENMASK(4, 0))
 #define RTW89_GET_PHY_STS_IE_LEN(ie) \
 	le32_get_bits(*((const __le32 *)ie), GENMASK(11, 5))
-#define RTW89_GET_PHY_STS_IE01_CH_IDX(ie) \
-	le32_get_bits(*((const __le32 *)ie), GENMASK(23, 16))
-#define RTW89_GET_PHY_STS_IE01_FD_CFO(ie) \
-	le32_get_bits(*((const __le32 *)(ie) + 1), GENMASK(19, 8))
-#define RTW89_GET_PHY_STS_IE01_PREMB_CFO(ie) \
-	le32_get_bits(*((const __le32 *)(ie) + 1), GENMASK(31, 20))
+
+struct rtw89_phy_sts_ie0 {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+} __packed;
+
+#define RTW89_PHY_STS_IE01_W0_CH_IDX GENMASK(23, 16)
+#define RTW89_PHY_STS_IE01_W1_FD_CFO GENMASK(19, 8)
+#define RTW89_PHY_STS_IE01_W1_PREMB_CFO GENMASK(31, 20)
 
 enum rtw89_tx_channel {
 	RTW89_TXCH_ACH0	= 0,
-- 
2.25.1

