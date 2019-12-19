Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65613125D17
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSI6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 03:58:41 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59559 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLSI6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 03:58:41 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBJ8wX9p024868, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBJ8wX9p024868
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Dec 2019 16:58:33 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 19 Dec 2019 16:58:33 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <chiu@endlessm.com>
Subject: [PATCH v4 3/7] rtw88: add interface config for 8822c
Date:   Thu, 19 Dec 2019 16:58:12 +0800
Message-ID: <20191219085816.20709-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219085816.20709-1-yhchuang@realtek.com>
References: <20191219085816.20709-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Some devices need to configure interface/HCI related reigsters
in power on flow. Add interface_cfg for HCI for the settings.

The driver only supports RTL8822BE/RTL8822CE now, and since
RTL8822BE does not need to configure PCIE, the configuration
is only added for RTL8822CE. Without it, some of the RTL8822CE
device can crash and disconnected to host in suspend/wowlan mode.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v3
 * new patch

v3 -> v4
 * no change

 drivers/net/wireless/realtek/rtw88/hci.h |  6 ++++++
 drivers/net/wireless/realtek/rtw88/mac.c |  2 ++
 drivers/net/wireless/realtek/rtw88/pci.c | 17 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/reg.h |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 3d91aea942c3..85a81a578fd5 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -15,6 +15,7 @@ struct rtw_hci_ops {
 	void (*stop)(struct rtw_dev *rtwdev);
 	void (*deep_ps)(struct rtw_dev *rtwdev, bool enter);
 	void (*link_ps)(struct rtw_dev *rtwdev, bool enter);
+	void (*interface_cfg)(struct rtw_dev *rtwdev);
 
 	int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
 	int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
@@ -59,6 +60,11 @@ static inline void rtw_hci_link_ps(struct rtw_dev *rtwdev, bool enter)
 	rtwdev->hci.ops->link_ps(rtwdev, enter);
 }
 
+static inline void rtw_hci_interface_cfg(struct rtw_dev *rtwdev)
+{
+	rtwdev->hci.ops->interface_cfg(rtwdev);
+}
+
 static inline int
 rtw_hci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 507970387b2a..03a82de053ea 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1034,5 +1034,7 @@ int rtw_mac_init(struct rtw_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	rtw_hci_interface_cfg(rtwdev);
+
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index c394df494c95..a60d9b107006 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include "main.h"
 #include "pci.h"
+#include "reg.h"
 #include "tx.h"
 #include "rx.h"
 #include "fw.h"
@@ -1224,6 +1225,21 @@ static void rtw_pci_link_cfg(struct rtw_dev *rtwdev)
 	rtwpci->link_ctrl = link_ctrl;
 }
 
+static void rtw_pci_interface_cfg(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	switch (chip->id) {
+	case RTW_CHIP_TYPE_8822C:
+		if (rtwdev->hal.cut_version >= RTW_CHIP_VER_CUT_D)
+			rtw_write32_mask(rtwdev, REG_HCI_MIX_CFG,
+					 BIT_PCIE_EMAC_PDN_AUX_TO_FAST_CLK, 1);
+		break;
+	default:
+		break;
+	}
+}
+
 static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -1332,6 +1348,7 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.stop = rtw_pci_stop,
 	.deep_ps = rtw_pci_deep_ps,
 	.link_ps = rtw_pci_link_ps,
+	.interface_cfg = rtw_pci_interface_cfg,
 
 	.read8 = rtw_pci_read8,
 	.read16 = rtw_pci_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 7e817bc997eb..cd6b14c379ba 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -194,6 +194,8 @@
 #define REG_H2C_INFO		0x0254
 
 #define REG_INT_MIG		0x0304
+#define REG_HCI_MIX_CFG		0x03FC
+#define BIT_PCIE_EMAC_PDN_AUX_TO_FAST_CLK BIT(26)
 
 #define REG_FWHW_TXQ_CTRL	0x0420
 #define BIT_EN_BCNQ_DL		BIT(22)
-- 
2.17.1

