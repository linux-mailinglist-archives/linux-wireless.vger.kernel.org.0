Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8611CF24C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgELK1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:27:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36526 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgELK0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:26:42 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAQO9M0009501, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAQO9M0009501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:26:24 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:24 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v3 1/9] rtw88: 8723d: Add LC calibration
Date:   Tue, 12 May 2020 18:26:13 +0800
Message-ID: <20200512102621.5148-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512102621.5148-1-yhchuang@realtek.com>
References: <20200512102621.5148-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

LC calibration is done by hardware circuit. Driver sets the LCK bit to kick
start, and then poll the bit to check if it's done.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 31 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  3 ++
 3 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e0365a70c6f7..c5046986f9af 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -11,6 +11,7 @@
 #include <linux/average.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/iopoll.h>
 #include <linux/interrupt.h>
 
 #include "util.h"
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 92c742d1ce6d..0f5ddd41b019 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -64,6 +64,34 @@ static const struct rtw_hw_reg rtw8723d_txagc[] = {
 #define WLAN_LTR_CTRL1		0xCB004010
 #define WLAN_LTR_CTRL2		0x01233425
 
+static void rtw8723d_lck(struct rtw_dev *rtwdev)
+{
+	u32 lc_cal;
+	u8 val_ctx, rf_val;
+	int ret;
+
+	val_ctx = rtw_read8(rtwdev, REG_CTX);
+	if ((val_ctx & BIT_MASK_CTX_TYPE) != 0)
+		rtw_write8(rtwdev, REG_CTX, val_ctx & ~BIT_MASK_CTX_TYPE);
+	else
+		rtw_write8(rtwdev, REG_TXPAUSE, 0xFF);
+	lc_cal = rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK);
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal | BIT_LCK);
+
+	ret = read_poll_timeout(rtw_read_rf, rf_val, rf_val != 0x1,
+				10000, 1000000, false,
+				rtwdev, RF_PATH_A, RF_CFGCH, BIT_LCK);
+	if (ret)
+		rtw_warn(rtwdev, "failed to poll LCK status bit\n");
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal);
+	if ((val_ctx & BIT_MASK_CTX_TYPE) != 0)
+		rtw_write8(rtwdev, REG_CTX, val_ctx);
+	else
+		rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
+}
+
 static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
 {
 	u8 xtal_cap;
@@ -125,6 +153,9 @@ static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
 	rtw_phy_init(rtwdev);
 
 	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
+
+	rtw8723d_lck(rtwdev);
+
 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x20);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index ac66f672bec8..6a7d58992df5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -78,6 +78,7 @@ struct rtw8723d_efuse {
 #define RFCFGCH_BW_20M		(BIT(11) | BIT(10))
 #define RFCFGCH_BW_40M		BIT(10)
 #define BIT_MASK_RFMOD		BIT(0)
+#define BIT_LCK			BIT(15)
 
 #define REG_PSDFN		0x0808
 #define REG_ANALOG_P4		0x088c
@@ -115,6 +116,8 @@ struct rtw8723d_efuse {
 #define REG_OFDM_FA_RSTD_11N	0x0d00
 #define BIT_MASK_OFDM_FA_RST1	BIT(27)
 #define BIT_MASK_OFDM_FA_KEEP1	BIT(31)
+#define REG_CTX			0x0d03
+#define BIT_MASK_CTX_TYPE	GENMASK(6, 4)
 #define REG_OFDM1_CFOTRK	0x0d2c
 #define BIT_EN_CFOTRK		BIT(28)
 #define REG_OFDM1_CSI1		0x0d40
-- 
2.17.1

