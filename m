Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407F11C80CA
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 06:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgEGEWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 00:22:17 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34096 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgEGEWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 00:22:17 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0474Lv512027277, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0474Lv512027277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 May 2020 12:21:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:57 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:56 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v2 4/9] rtw88: 8723d: Add shutdown callback to disable BT USB suspend
Date:   Thu, 7 May 2020 12:21:46 +0800
Message-ID: <20200507042151.15634-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507042151.15634-1-yhchuang@realtek.com>
References: <20200507042151.15634-1-yhchuang@realtek.com>
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

Without this patch, wifi card can't initialize properly due to BT in USB
suspend state. So, we disable BT USB suspend (wakeup) in shutdown callback
that is the moment before rebooting. To save BT USB power, we can't do this
in 'remove' callback.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/pci.c      | 17 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  6 ++++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index bfdc27c187f6..592b28ed9376 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -795,6 +795,7 @@ struct rtw_regulatory {
 
 struct rtw_chip_ops {
 	int (*mac_init)(struct rtw_dev *rtwdev);
+	void (*shutdown)(struct rtw_dev *rtwdev);
 	int (*read_efuse)(struct rtw_dev *rtwdev, u8 *map);
 	void (*phy_set_param)(struct rtw_dev *rtwdev);
 	void (*set_channel)(struct rtw_dev *rtwdev, u8 channel,
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index b9a5868a5da0..493903e0562e 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1578,6 +1578,22 @@ static void rtw_pci_remove(struct pci_dev *pdev)
 	ieee80211_free_hw(hw);
 }
 
+static void rtw_pci_shutdown(struct pci_dev *pdev)
+{
+	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
+	struct rtw_dev *rtwdev;
+	struct rtw_chip_info *chip;
+
+	if (!hw)
+		return;
+
+	rtwdev = hw->priv;
+	chip = rtwdev->chip;
+
+	if (chip->ops->shutdown)
+		chip->ops->shutdown(rtwdev);
+}
+
 static const struct pci_device_id rtw_pci_id_table[] = {
 #ifdef CONFIG_RTW88_8822BE
 	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB822, rtw8822b_hw_spec) },
@@ -1598,6 +1614,7 @@ static struct pci_driver rtw_pci_driver = {
 	.probe = rtw_pci_probe,
 	.remove = rtw_pci_remove,
 	.driver.pm = RTW_PM_OPS,
+	.shutdown = rtw_pci_shutdown,
 };
 module_pci_driver(rtw_pci_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index d57de1a6cdcc..5a3e9cc7c400 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -83,6 +83,7 @@
 #define BIT_DBG_GNT_WL_BT	BIT(27)
 #define BIT_LTE_MUX_CTRL_PATH	BIT(26)
 #define REG_HCI_OPT_CTRL	0x0074
+#define BIT_USB_SUS_DIS		BIT(8)
 
 #define REG_AFE_CTRL_4		0x0078
 #define BIT_CK320M_AFE_EN	BIT(4)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 4fc2d0bb2704..bfad27d10c40 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -549,6 +549,11 @@ static int rtw8723d_mac_init(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static void rtw8723d_shutdown(struct rtw_dev *rtwdev)
+{
+	rtw_write16_set(rtwdev, REG_HCI_OPT_CTRL, BIT_USB_SUS_DIS);
+}
+
 static void rtw8723d_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 	u8 ldo_pwr;
@@ -1790,6 +1795,7 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.query_rx_desc		= rtw8723d_query_rx_desc,
 	.set_channel		= rtw8723d_set_channel,
 	.mac_init		= rtw8723d_mac_init,
+	.shutdown		= rtw8723d_shutdown,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_tx_power_index	= rtw8723d_set_tx_power_index,
-- 
2.17.1

