Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27E6D06DE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjC3Nev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC3Nes (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:34:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9373B74F
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:34:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32UDYHg74015759, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32UDYHg74015759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 30 Mar 2023 21:34:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 30 Mar 2023 21:34:35 +0800
Received: from localhost (172.16.16.62) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Mar
 2023 21:34:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: read version of analog hardware
Date:   Thu, 30 Mar 2023 21:33:21 +0800
Message-ID: <20230330133324.19538-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330133324.19538-1-pkshih@realtek.com>
References: <20230330133324.19538-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.62]
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The chip contains digital and analog parts, and each of them has its own
version number. This is used by BT coexistence mechanism to make strategy
decision for different analog version.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 10 ++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 489fa7a86160d..323e9088611b3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3272,6 +3272,8 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	int ret;
+	u8 val;
 	u8 cv;
 
 	cv = rtw89_read32_mask(rtwdev, R_AX_SYS_CFG1, B_AX_CHIP_VER_MASK);
@@ -3283,6 +3285,14 @@ static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 	}
 
 	rtwdev->hal.cv = cv;
+
+	if (chip->chip_id == RTL8852B || chip->chip_id == RTL8851B) {
+		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_CV, &val);
+		if (!ret)
+			return;
+
+		rtwdev->hal.acv = u8_get_bits(val, XTAL_SI_ACV_MASK);
+	}
 }
 
 static void rtw89_core_setup_phycap(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e447bfec508b8..323b0ece90183 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -108,6 +108,7 @@ enum rtw89_core_chip_id {
 	RTL8852A,
 	RTL8852B,
 	RTL8852C,
+	RTL8851B,
 };
 
 enum rtw89_cv {
@@ -3321,6 +3322,7 @@ struct rtw89_sub_entity {
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
+	u8 acv;
 	u32 sw_amsdu_max_size;
 	u32 antenna_tx;
 	u32 antenna_rx;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8064d3953d7f2..ce07469e684ad 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1116,6 +1116,7 @@ enum rtw89_mac_xtal_si_offset {
 	XTAL_SI_XTAL_XMD_4 = 0x26,
 #define XTAL_SI_LPS_CAP		GENMASK(3, 0)
 	XTAL_SI_CV = 0x41,
+#define XTAL_SI_ACV_MASK	GENMASK(3, 0)
 	XTAL_SI_LOW_ADDR = 0x62,
 #define XTAL_SI_LOW_ADDR_MASK	GENMASK(7, 0)
 	XTAL_SI_CTRL = 0x63,
-- 
2.25.1

