Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B701D1D72A3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgERIPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 04:15:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36408 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgERIPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 04:15:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04I8EnVV2005063, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04I8EnVV2005063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 May 2020 16:14:49 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 May 2020 16:14:49 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 May 2020 16:14:49 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kai.heng.feng@canonical.com>
Subject: [PATCH 1/3] rtw88: coex: 8723d: set antanna control owner
Date:   Mon, 18 May 2020 16:14:42 +0800
Message-ID: <20200518081444.7664-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518081444.7664-1-yhchuang@realtek.com>
References: <20200518081444.7664-1-yhchuang@realtek.com>
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

Without setting antenna control owner, the WiFi could be disconnected if
the BT has traffic. Because the antenna is switched to BT side for its
traffic, and the WiFi will have no chance to transfer data. Set control
owner to prevent WiFi disconnect issue.

Fixes: f5df1a8b4376 ("rtw88: 8723d: Add 8723DE to Kconfig and Makefile")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 12 ++++++++++--
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  5 +++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  1 +
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 567372fb4e12..5391516616b3 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -748,10 +748,18 @@ void rtw_coex_write_indirect_reg(struct rtw_dev *rtwdev, u16 addr,
 
 static void rtw_coex_coex_ctrl_owner(struct rtw_dev *rtwdev, bool wifi_control)
 {
-	if (wifi_control)
+	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_hw_reg *btg_reg = chip->btg_reg;
+
+	if (wifi_control) {
 		rtw_write32_set(rtwdev, REG_SYS_SDIO_CTRL, BIT_LTE_MUX_CTRL_PATH);
-	else
+		if (btg_reg)
+			rtw_write8_set(rtwdev, btg_reg->addr, btg_reg->mask);
+	} else {
 		rtw_write32_clr(rtwdev, REG_SYS_SDIO_CTRL, BIT_LTE_MUX_CTRL_PATH);
+		if (btg_reg)
+			rtw_write8_clr(rtwdev, btg_reg->addr, btg_reg->mask);
+	}
 }
 
 static void rtw_coex_set_gnt_bt(struct rtw_dev *rtwdev, u8 state)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c9156b9b532c..e62a4bceac94 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1177,6 +1177,7 @@ struct rtw_chip_info {
 	const struct coex_rf_para *wl_rf_para_tx;
 	const struct coex_rf_para *wl_rf_para_rx;
 	const struct coex_5g_afh_map *afh_5g;
+	const struct rtw_hw_reg *btg_reg;
 	const struct rtw_reg_domain *coex_info_hw_regs;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index b517af417e0e..671e2c9b20ea 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2067,6 +2067,10 @@ static const u8 wl_rssi_step_8723d[] = {60, 50, 44, 30};
 static const u8 bt_rssi_step_8723d[] = {30, 30, 30, 30};
 static const struct coex_5g_afh_map afh_5g_8723d[] = { {0, 0, 0} };
 
+static const struct rtw_hw_reg btg_reg_8723d = {
+	.addr = REG_BTG_SEL, .mask = BIT_MASK_BTG_WL,
+};
+
 /* wl_tx_dec_power, bt_tx_dec_power, wl_rx_gain, bt_rx_lna_constrain */
 static const struct coex_rf_para rf_para_tx_8723d[] = {
 	{0, 0, false, 7},  /* for normal */
@@ -2733,6 +2737,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.bt_afh_span_bw40 = 0x30,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8723d),
 	.afh_5g = afh_5g_8723d,
+	.btg_reg = &btg_reg_8723d,
 
 	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8723d),
 	.coex_info_hw_regs = coex_info_hw_regs_8723d,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 31b8ed9ee652..7894d321cd7e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -145,6 +145,7 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 
 #define REG_GPIO_INTM		0x0048
 #define REG_BTG_SEL		0x0067
+#define BIT_MASK_BTG_WL		BIT(7)
 #define REG_LTECOEX_PATH_CONTROL	0x0070
 #define REG_LTECOEX_CTRL	0x07c0
 #define REG_LTECOEX_WRITE_DATA	0x07c4
-- 
2.17.1

