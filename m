Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F181B35B7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 05:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDVDqU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 23:46:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36997 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgDVDqT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:19 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M3kAzE5004569, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M3kAzE5004569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 11:46:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 3/8] rtw88: 8723d: Add mac power-on/-off function
Date:   Wed, 22 Apr 2020 11:46:02 +0800
Message-ID: <20200422034607.28747-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422034607.28747-1-yhchuang@realtek.com>
References: <20200422034607.28747-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The mac power-on flow consists of three steps:
1. pre_sys_cfg  (Before switching power state)
2. power_switch (Switching power state)
3. init_sys_cfg (Settings after swtiching power state)

When switching power state, driver will load and parse the power sequence
tables. For 8723D devices, the logics for parsing are most same except for
the polling function. 8723D devices need to toggle BIT_PFM_WOWL twice.

The settings after power state is switched for 8723D devices are quite
different with other devices, extract a legacy function for them.

For power-off flow, 8723D devices have the same logic with existing chips.
But warning printed if we run power-off sequence in power-off state:

   rtw_pci 0000:03:00.0: failed to poll offset=0x5f8 mask=0xff value=0x0

The scenario is user do 'ifconfig up' that will run power-on sequence to
bring up and then run power-off sequence to enter idle
(IEEE80211_CONF_IDLE). Then, user do 'ifconfig down' that will run
power-off sequence again, and the warning is shown. Original code check
power-on state to avoid to run power-on sequence twice, and this commit
extends to check both power-on and power-off states.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 60 ++++++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/reg.h | 10 ++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 6092604abfb9..21b5c7173f0f 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -61,6 +61,14 @@ static int rtw_mac_pre_system_cfg(struct rtw_dev *rtwdev)
 
 	rtw_write8(rtwdev, REG_RSV_CTRL, 0);
 
+	if (rtw_chip_wcpu_11n(rtwdev)) {
+		if (rtw_read32(rtwdev, REG_SYS_CFG1) & BIT_LDO)
+			rtw_write8(rtwdev, REG_LDO_SWR_CTRL, LDO_SEL);
+		else
+			rtw_write8(rtwdev, REG_LDO_SWR_CTRL, SPS_SEL);
+		return 0;
+	}
+
 	switch (rtw_hci_type(rtwdev)) {
 	case RTW_HCI_TYPE_PCIE:
 		rtw_write32_set(rtwdev, REG_HCI_OPT_CTRL, BIT_BT_DIG_CLK_EN);
@@ -123,10 +131,19 @@ static int rtw_pwr_cmd_polling(struct rtw_dev *rtwdev,
 			if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE &&
 			    flag == 0) {
 				value = rtw_read8(rtwdev, REG_SYS_PW_CTRL);
-				value |= BIT(3);
+				if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D) {
+					value &= ~BIT_PFM_WOWL;
+					rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
+				}
+				value |= BIT_PFM_WOWL;
 				rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
-				value &= ~BIT(3);
+				value &= ~BIT_PFM_WOWL;
 				rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
+				if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D) {
+					value |= BIT_PFM_WOWL;
+					rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
+				}
+
 				cnt = RTW_PWR_POLLING_CNT;
 				flag = 1;
 			} else {
@@ -228,12 +245,14 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	u8 rpwm;
 	bool cur_pwr;
 
-	rpwm = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
+	if (rtw_chip_wcpu_11ac(rtwdev)) {
+		rpwm = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
 
-	/* Check FW still exist or not */
-	if (rtw_read16(rtwdev, REG_MCUFW_CTRL) == 0xC078) {
-		rpwm = (rpwm ^ BIT_RPWM_TOGGLE) & BIT_RPWM_TOGGLE;
-		rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, rpwm);
+		/* Check FW still exist or not */
+		if (rtw_read16(rtwdev, REG_MCUFW_CTRL) == 0xC078) {
+			rpwm = (rpwm ^ BIT_RPWM_TOGGLE) & BIT_RPWM_TOGGLE;
+			rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, rpwm);
+		}
 	}
 
 	if (rtw_read8(rtwdev, REG_CR) == 0xea)
@@ -244,7 +263,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	else
 		cur_pwr = true;
 
-	if (pwr_on && cur_pwr)
+	if (pwr_on == cur_pwr)
 		return -EALREADY;
 
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
@@ -254,7 +273,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	return 0;
 }
 
-static int rtw_mac_init_system_cfg(struct rtw_dev *rtwdev)
+static int __rtw_mac_init_system_cfg(struct rtw_dev *rtwdev)
 {
 	u8 sys_func_en = rtwdev->chip->sys_func_en;
 	u8 value8;
@@ -279,6 +298,29 @@ static int rtw_mac_init_system_cfg(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static int __rtw_mac_init_system_cfg_legacy(struct rtw_dev *rtwdev)
+{
+	rtw_write8(rtwdev, REG_CR, 0xff);
+	mdelay(2);
+	rtw_write8(rtwdev, REG_HWSEQ_CTRL, 0x7f);
+	mdelay(2);
+
+	rtw_write8_set(rtwdev, REG_SYS_CLKR, BIT_WAKEPAD_EN);
+	rtw_write16_clr(rtwdev, REG_GPIO_MUXCFG, BIT_EN_SIC);
+
+	rtw_write16(rtwdev, REG_CR, 0x2ff);
+
+	return 0;
+}
+
+static int rtw_mac_init_system_cfg(struct rtw_dev *rtwdev)
+{
+	if (rtw_chip_wcpu_11n(rtwdev))
+		return __rtw_mac_init_system_cfg_legacy(rtwdev);
+
+	return __rtw_mac_init_system_cfg(rtwdev);
+}
+
 int rtw_mac_power_on(struct rtw_dev *rtwdev)
 {
 	int ret = 0;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 89868ac0748f..c1e66d656307 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -13,11 +13,13 @@
 #define BIT_R_DIS_PRST		BIT(6)
 #define BIT_WLOCK_1C_B6		BIT(5)
 #define REG_SYS_PW_CTRL		0x0004
+#define BIT_PFM_WOWL		BIT(3)
 #define REG_SYS_CLK_CTRL	0x0008
 #define BIT_CPU_CLK_EN		BIT(14)
 
 #define REG_SYS_CLKR		0x0008
 #define BIT_ANA8M		BIT(1)
+#define BIT_WAKEPAD_EN		BIT(3)
 #define BIT_LOADER_CLK_EN	BIT(5)
 
 #define REG_RSV_CTRL		0x001C
@@ -49,6 +51,7 @@
 
 #define REG_GPIO_MUXCFG		0x0040
 #define BIT_FSPI_EN		BIT(19)
+#define BIT_EN_SIC		BIT(12)
 #define BIT_BT_AOD_GPIO3	BIT(9)
 #define BIT_BT_PTA_EN		BIT(5)
 #define BIT_WLRFE_4_5_EN	BIT(2)
@@ -73,6 +76,10 @@
 #define BIT_LTE_MUX_CTRL_PATH	BIT(26)
 #define REG_HCI_OPT_CTRL	0x0074
 
+#define REG_LDO_SWR_CTRL	0x007C
+#define LDO_SEL			0xC3
+#define SPS_SEL			0x83
+
 #define REG_MCUFW_CTRL		0x0080
 #define BIT_ANA_PORT_EN		BIT(22)
 #define BIT_MAC_PORT_EN		BIT(21)
@@ -110,6 +117,7 @@
 #define BIT_BT_INT_EN		BIT(15)
 #define REG_SYS_CFG1		0x00F0
 #define	BIT_RTL_ID		BIT(23)
+#define BIT_LDO			BIT(24)
 #define BIT_RF_TYPE_ID		BIT(27)
 #define BIT_SHIFT_VENDOR_ID	16
 #define BIT_MASK_VENDOR_ID	0xf
@@ -238,6 +246,8 @@
 #define REG_FWHW_TXQ_CTRL	0x0420
 #define BIT_EN_BCNQ_DL		BIT(22)
 #define BIT_EN_WR_FREE_TAIL	BIT(20)
+#define REG_HWSEQ_CTRL		0x0423
+
 #define REG_BCNQ_BDNY_V1	0x0424
 #define REG_LIFETIME_EN		0x0426
 #define BIT_BA_PARSER_EN	BIT(5)
-- 
2.17.1

