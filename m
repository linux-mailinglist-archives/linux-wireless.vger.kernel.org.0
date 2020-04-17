Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50111AD7C0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgDQHrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:11 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36998 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgDQHrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l1Ol9020020, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l1Ol9020020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:01 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:01 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 06/40] rtw88: 8723d: Add cfg_ldo25 to control LDO25
Date:   Fri, 17 Apr 2020 15:46:19 +0800
Message-ID: <20200417074653.15591-7-yhchuang@realtek.com>
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

Implement rtw_chip_ops::cfg_ldo25 to enable/disable LDO25 with proper
voltage.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/reg.h      |  5 +++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 9d94534c9674..2afd547ebcc9 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -37,6 +37,11 @@
 #define REG_LDO_EFUSE_CTRL	0x0034
 #define BIT_MASK_EFUSE_BANK_SEL	(BIT(8) | BIT(9))
 
+#define BIT_LDO25_VOLTAGE_V25	0x03
+#define BIT_MASK_LDO25_VOLTAGE	GENMASK(6, 4)
+#define BIT_SHIFT_LDO25_VOLTAGE	4
+#define BIT_LDO25_EN		BIT(7)
+
 #define REG_GPIO_MUXCFG		0x0040
 #define BIT_FSPI_EN		BIT(19)
 #define BIT_BT_AOD_GPIO3	BIT(9)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 4fe433549285..04f8d73e4e6c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -14,10 +14,25 @@
 #include "reg.h"
 #include "debug.h"
 
+static void rtw8723d_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 ldo_pwr;
+
+	ldo_pwr = rtw_read8(rtwdev, REG_LDO_EFUSE_CTRL + 3);
+	if (enable) {
+		ldo_pwr &= ~BIT_MASK_LDO25_VOLTAGE;
+		ldo_pwr = (BIT_LDO25_VOLTAGE_V25 << 4) | BIT_LDO25_EN;
+	} else {
+		ldo_pwr &= ~BIT_LDO25_EN;
+	}
+	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
+}
+
 static struct rtw_chip_ops rtw8723d_ops = {
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
+	.cfg_ldo25		= rtw8723d_cfg_ldo25,
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index c02f3a730369..9a2e18e7624f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1030,7 +1030,7 @@ static void rtw8822b_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	u8 ldo_pwr;
 
 	ldo_pwr = rtw_read8(rtwdev, REG_LDO_EFUSE_CTRL + 3);
-	ldo_pwr = enable ? ldo_pwr | BIT(7) : ldo_pwr & ~BIT(7);
+	ldo_pwr = enable ? ldo_pwr | BIT_LDO25_EN : ldo_pwr & ~BIT_LDO25_EN;
 	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
 }
 
-- 
2.17.1

