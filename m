Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED801AD7DF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgDQHrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37047 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgDQHrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l6hE5020159, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l6hE5020159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:06 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:03 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:03 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 25/40] rtw88: 8723d: Add LC calibration
Date:   Fri, 17 Apr 2020 15:46:38 +0800
Message-ID: <20200417074653.15591-26-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
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
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 30 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index cf897af380c1..94784c7f0743 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -64,6 +64,33 @@ static const struct rtw_hw_reg rtw8723d_txagc[] = {
 #define WLAN_LTR_CTRL1		0xCB004010
 #define WLAN_LTR_CTRL2		0x01233425
 
+static void rtw8723d_lck(struct rtw_dev *rtwdev)
+{
+#define BIT_LCK		BIT(15)
+	u8 val_ctx;
+	u32 lc_cal, cnt;
+
+	val_ctx = rtw_read8(rtwdev, REG_CTX);
+	if ((val_ctx & BIT_MASK_CTX_TYPE) != 0)
+		rtw_write8(rtwdev, REG_CTX, val_ctx & ~BIT_MASK_CTX_TYPE);
+	else
+		rtw_write8(rtwdev, REG_TXPAUSE, 0xFF);
+	lc_cal = rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK);
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal | BIT_LCK);
+	for (cnt = 0; cnt < 100; cnt++) {
+		if (rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, BIT_LCK) != 0x1)
+			break;
+		mdelay(10);
+	}
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
@@ -125,6 +152,9 @@ static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
 	rtw_phy_init(rtwdev);
 
 	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
+
+	rtw8723d_lck(rtwdev);
+
 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x20);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index b5b7fc9cd1c8..64a1f2359c23 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -97,6 +97,8 @@ struct rtw8723d_efuse {
 #define REG_OFDM_FA_RSTD_11N	0x0d00
 #define BIT_MASK_OFDM_FA_RST1	BIT(27)
 #define BIT_MASK_OFDM_FA_KEEP1	BIT(31)
+#define REG_CTX			0x0d03
+#define BIT_MASK_CTX_TYPE	GENMASK(6, 4)
 #define REG_OFDM1_CFOTRK	0x0d2c
 #define REG_OFDM1_CSI1		0x0d40
 #define REG_OFDM1_CSI2		0x0d44
-- 
2.17.1

