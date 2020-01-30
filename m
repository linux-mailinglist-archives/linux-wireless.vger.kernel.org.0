Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6D14D62E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 06:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgA3Fb0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 00:31:26 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:57770 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgA3Fb0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 00:31:26 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00U5VGoJ004151, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00U5VGoJ004151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 13:31:17 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jan 2020 13:31:16 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jan 2020 13:31:16 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Thu, 30 Jan 2020 13:31:16 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 30 Jan 2020 13:31:15 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <chiu@endlessm.com>
Subject: [PATCH v2 2/2] rtw88: 8822c: modify rf protection setting
Date:   Thu, 30 Jan 2020 13:31:12 +0800
Message-ID: <20200130053112.28162-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130053112.28162-1-yhchuang@realtek.com>
References: <20200130053112.28162-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chien-Hsun Liao <ben.liao@realtek.com>

According to some experiments, the original RF register protection
setting of 8822c cannot perfectly make sure that there is no hardware
PI write (direct) during direct write. Modify the setting so that the
hardware block of PI would be turned off via rtw8822c_rstb_3wire()
during the direct write, to avoid RF register racing.

Note that 8822b uses SIPI write (indirect), so 8822b does not
have such problem.

Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
 * Add more descriptions

 drivers/net/wireless/realtek/rtw88/phy.c      | 10 ----------
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  5 +++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index eea9d888fbf1..8793dd22188f 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -749,20 +749,10 @@ bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 	direct_addr = base_addr[rf_path] + (addr << 2);
 	mask &= RFREG_MASK;
 
-	if (addr == RF_CFGCH) {
-		rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, DISABLE_PI);
-		rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, DISABLE_PI);
-	}
-
 	rtw_write32_mask(rtwdev, direct_addr, mask, data);
 
 	udelay(1);
 
-	if (addr == RF_CFGCH) {
-		rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, ENABLE_PI);
-		rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, ENABLE_PI);
-	}
-
 	return true;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 4c416d603b33..fb621881fbd1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1289,6 +1289,17 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static void rtw8822c_rstb_3wire(struct rtw_dev *rtwdev, bool enable)
+{
+	if (enable) {
+		rtw_write32_mask(rtwdev, REG_RSTB, BIT_RSTB_3WIRE, 0x1);
+		rtw_write32_mask(rtwdev, REG_ANAPAR_A, BIT_ANAPAR_UPDATE, 0x1);
+		rtw_write32_mask(rtwdev, REG_ANAPAR_B, BIT_ANAPAR_UPDATE, 0x1);
+	} else {
+		rtw_write32_mask(rtwdev, REG_RSTB, BIT_RSTB_3WIRE, 0x0);
+	}
+}
+
 static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 {
 #define RF18_BAND_MASK		(BIT(16) | BIT(9) | BIT(8))
@@ -1337,6 +1348,8 @@ static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 		break;
 	}
 
+	rtw8822c_rstb_3wire(rtwdev, false);
+
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, 0x04, 0x01);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, 0x1f, 0x12);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, 0xfffff, rf_rxbb);
@@ -1349,6 +1362,8 @@ static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, rf_reg18);
 	rtw_write_rf(rtwdev, RF_PATH_B, RF_CFGCH, RFREG_MASK, rf_reg18);
+
+	rtw8822c_rstb_3wire(rtwdev, true);
 }
 
 static void rtw8822c_toggle_igi(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index abd9f300bedd..dfd8662a0c0e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -190,6 +190,8 @@ const struct rtw_table name ## _tbl = {			\
 #define BIT_3WIRE_TX_EN		BIT(0)
 #define BIT_3WIRE_RX_EN		BIT(1)
 #define BIT_3WIRE_PI_ON		BIT(28)
+#define REG_ANAPAR_A	0x1830
+#define BIT_ANAPAR_UPDATE	BIT(29)
 #define REG_RXAGCCTL0	0x18ac
 #define BITS_RXAGC_CCK		GENMASK(15, 12)
 #define BITS_RXAGC_OFDM		GENMASK(8, 4)
@@ -223,6 +225,8 @@ const struct rtw_table name ## _tbl = {			\
 #define BIT_CCK_BLK_EN		BIT(1)
 #define BIT_CCK_OFDM_BLK_EN	(BIT(0) | BIT(1))
 #define REG_CCAMSK	0x1c80
+#define REG_RSTB	0x1c90
+#define BIT_RSTB_3WIRE		BIT(8)
 #define REG_RX_BREAK	0x1d2c
 #define BIT_COM_RX_GCK_EN	BIT(31)
 #define REG_RXFNCTL	0x1d30
@@ -243,6 +247,7 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_OFDM_TXCNT	0x2de0
 #define REG_ORITXCODE2	0x4100
 #define REG_3WIRE2	0x410c
+#define REG_ANAPAR_B	0x4130
 #define REG_RXAGCCTL	0x41ac
 #define REG_DCKB_I_0	0x41bc
 #define REG_DCKB_I_1	0x41c0
-- 
2.17.1

