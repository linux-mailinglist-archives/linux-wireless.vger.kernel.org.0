Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD47B7AA9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbjJDIvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbjJDIva (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 04:51:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90DA6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 01:51:26 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3948pHefD3164845, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3948pHefD3164845
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 16:51:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 4 Oct 2023 16:51:17 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 4 Oct 2023
 16:51:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw88: 8821c: tweak CCK TX filter setting for SRRC regulation
Date:   Wed, 4 Oct 2023 16:50:51 +0800
Message-ID: <20231004085051.205683-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004085051.205683-1-pkshih@realtek.com>
References: <20231004085051.205683-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Since new criterion released by SRRC (State Radio Regulatory Commission,
China) is stricter, we have adjusted TX power limit tables for it. But,
due to RTL8821C HW characteristic, we still need to use specific parameter
in CCK TX filter when set channel to avoid violations in some corner cases.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/regd.c     |  8 +++
 drivers/net/wireless/realtek/rtw88/regd.h     |  2 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 67 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  1 +
 4 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 124fc7ae6a14..7f3b2ea3f2a5 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -502,6 +502,14 @@ u8 rtw_regd_get(struct rtw_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw_regd_get);
 
+bool rtw_regd_srrc(struct rtw_dev *rtwdev)
+{
+	struct rtw_regd *regd = &rtwdev->regd;
+
+	return rtw_reg_match(regd->regulatory, "CN");
+}
+EXPORT_SYMBOL(rtw_regd_srrc);
+
 struct rtw_regd_alternative_t {
 	bool set;
 	u8 alt;
diff --git a/drivers/net/wireless/realtek/rtw88/regd.h b/drivers/net/wireless/realtek/rtw88/regd.h
index 34cb13d0cd9e..3c5a6fd8e6dd 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.h
+++ b/drivers/net/wireless/realtek/rtw88/regd.h
@@ -68,4 +68,6 @@ int rtw_regd_init(struct rtw_dev *rtwdev);
 int rtw_regd_hint(struct rtw_dev *rtwdev);
 u8 rtw_regd_get(struct rtw_dev *rtwdev);
 bool rtw_regd_has_alt(u8 regd, u8 *regd_alt);
+bool rtw_regd_srrc(struct rtw_dev *rtwdev);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index adf224618a2a..429bb420b056 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -381,6 +381,65 @@ static void rtw8821c_set_channel_rxdfir(struct rtw_dev *rtwdev, u8 bw)
 	}
 }
 
+static void rtw8821c_cck_tx_filter_srrc(struct rtw_dev *rtwdev, u8 channel, u8 bw)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+
+	if (channel == 14) {
+		rtw_write32_mask(rtwdev, REG_CCA_FLTR, MASKHWORD, 0xe82c);
+		rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD, 0x0000b81c);
+		rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD, 0x0000);
+		rtw_write32_mask(rtwdev, REG_TXFILTER, MASKDWORD, 0x00003667);
+
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, RFREG_MASK, 0x00002);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0001e);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0001c);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0000e);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0000c);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, RFREG_MASK, 0x00000);
+	} else if (channel == 13 ||
+		   (channel == 11 && bw == RTW_CHANNEL_WIDTH_40)) {
+		rtw_write32_mask(rtwdev, REG_CCA_FLTR, MASKHWORD, 0xf8fe);
+		rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD, 0x64b80c1c);
+		rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD, 0x8810);
+		rtw_write32_mask(rtwdev, REG_TXFILTER, MASKDWORD, 0x01235667);
+
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, RFREG_MASK, 0x00002);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0001e);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00027);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0001c);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00027);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0000e);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00029);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0000c);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00026);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, RFREG_MASK, 0x00000);
+	} else {
+		rtw_write32_mask(rtwdev, REG_CCA_FLTR, MASKHWORD, 0xe82c);
+		rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD,
+				 hal->ch_param[0]);
+		rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD,
+				 hal->ch_param[1] & MASKLWORD);
+		rtw_write32_mask(rtwdev, REG_TXFILTER, MASKDWORD,
+				 hal->ch_param[2]);
+
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, RFREG_MASK, 0x00002);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0001e);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0001c);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0000e);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x0000c);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, RFREG_MASK, 0x00000);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, RFREG_MASK, 0x00000);
+	}
+}
+
 static void rtw8821c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 				    u8 primary_ch_idx)
 {
@@ -395,6 +454,13 @@ static void rtw8821c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 
 		rtw_write32_mask(rtwdev, REG_TXSCALE_A, 0xf00, 0x0);
 		rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x96a);
+
+		if (rtw_regd_srrc(rtwdev)) {
+			rtw8821c_cck_tx_filter_srrc(rtwdev, channel, bw);
+			goto set_bw;
+		}
+
+		/* CCK TX filter parameters for default case */
 		if (channel == 14) {
 			rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD, 0x0000b81c);
 			rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD, 0x0000);
@@ -430,6 +496,7 @@ static void rtw8821c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x412);
 	}
 
+set_bw:
 	switch (bw) {
 	case RTW_CHANNEL_WIDTH_20:
 	default:
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index fcff31688c45..91ed921407bb 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -238,6 +238,7 @@ extern const struct rtw_chip_info rtw8821c_hw_spec;
 #define REG_RXSB	0xa00
 #define REG_ADCINI	0xa04
 #define REG_PWRTH	0xa08
+#define REG_CCA_FLTR	0xa20
 #define REG_TXSF2	0xa24
 #define REG_TXSF6	0xa28
 #define REG_FA_CCK	0xa5c
-- 
2.25.1

