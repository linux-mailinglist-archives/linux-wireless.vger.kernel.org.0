Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6BF2D34
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbfKGLQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 06:16:15 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43302 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbfKGLQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 06:16:14 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA7BG9Wu012877, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA7BG9Wu012877
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 7 Nov 2019 19:16:09 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 7 Nov 2019 19:16:09 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 3/4] rtw88: pci: enable CLKREQ function if host supports it
Date:   Thu, 7 Nov 2019 19:16:02 +0800
Message-ID: <20191107111603.12317-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107111603.12317-1-yhchuang@realtek.com>
References: <20191107111603.12317-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

By Realtek's design, there are two HW modules associated for CLKREQ,
one is responsible to follow the PCIE host settings, and another
is to actually working on it. But the module that is actually working
on it is default disabled, and driver should enable that module if
host and device have successfully sync'ed with each other.

The module is default disabled because sometimes the host does not
support it, and if there is any incorrect settings (ex. CLKREQ# is
not Bi-Direction), device can be lost and disconnected to the host.

So driver should first check after host and device are sync'ed, and
the host does support the function and set it in configuration
space, then driver can turn on the HW module to working on it.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 83 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/pci.h |  5 ++
 2 files changed, 88 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 6d1aa6f41e84..4fcef8a6fc42 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1081,6 +1081,33 @@ static void rtw_dbi_write8(struct rtw_dev *rtwdev, u16 addr, u8 data)
 	WARN(flag, "failed to write to DBI register, addr=0x%04x\n", addr);
 }
 
+static int rtw_dbi_read8(struct rtw_dev *rtwdev, u16 addr, u8 *value)
+{
+	u16 read_addr = addr & BITS_DBI_ADDR_MASK;
+	u8 flag;
+	u8 cnt;
+
+	rtw_write16(rtwdev, REG_DBI_FLAG_V1, read_addr);
+	rtw_write8(rtwdev, REG_DBI_FLAG_V1 + 2, BIT_DBI_RFLAG >> 16);
+
+	for (cnt = 0; cnt < RTW_PCI_WR_RETRY_CNT; cnt++) {
+		flag = rtw_read8(rtwdev, REG_DBI_FLAG_V1 + 2);
+		if (flag == 0)
+			break;
+
+		udelay(10);
+	}
+
+	if (flag != 0) {
+		WARN(1, "failed to read DBI register, addr=0x%04x\n", addr);
+		return -EIO;
+	}
+
+	read_addr = REG_DBI_RDATA_V1 + (addr & 3);
+	*value = rtw_read8(rtwdev, read_addr);
+	return 0;
+}
+
 static void rtw_mdio_write(struct rtw_dev *rtwdev, u8 addr, u16 data, bool g1)
 {
 	u8 page;
@@ -1107,6 +1134,60 @@ static void rtw_mdio_write(struct rtw_dev *rtwdev, u8 addr, u16 data, bool g1)
 	WARN(wflag, "failed to write to MDIO register, addr=0x%02x\n", addr);
 }
 
+static void rtw_pci_clkreq_set(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 value;
+	int ret;
+
+	ret = rtw_dbi_read8(rtwdev, RTK_PCIE_LINK_CFG, &value);
+	if (ret) {
+		rtw_err(rtwdev, "failed to read CLKREQ_L1, ret=%d", ret);
+		return;
+	}
+
+	if (enable)
+		value |= BIT_CLKREQ_SW_EN;
+	else
+		value &= ~BIT_CLKREQ_SW_EN;
+
+	rtw_dbi_write8(rtwdev, RTK_PCIE_LINK_CFG, value);
+}
+
+static void rtw_pci_link_cfg(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+	u16 link_ctrl;
+	int ret;
+
+	/* Though there is standard PCIE configuration space to set the
+	 * link control register, but by Realtek's design, driver should
+	 * check if host supports CLKREQ/ASPM to enable the HW module.
+	 *
+	 * These functions are implemented by two HW modules associated,
+	 * one is responsible to access PCIE configuration space to
+	 * follow the host settings, and another is in charge of doing
+	 * CLKREQ/ASPM mechanisms, it is default disabled. Because sometimes
+	 * the host does not support it, and due to some reasons or wrong
+	 * settings (ex. CLKREQ# not Bi-Direction), it could lead to device
+	 * loss if HW misbehaves on the link.
+	 *
+	 * Hence it's designed that driver should first check the PCIE
+	 * configuration space is sync'ed and enabled, then driver can turn
+	 * on the other module that is actually working on the mechanism.
+	 */
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &link_ctrl);
+	if (ret) {
+		rtw_err(rtwdev, "failed to read PCI cap, ret=%d\n", ret);
+		return;
+	}
+
+	if (link_ctrl & PCI_EXP_LNKCTL_CLKREQ_EN)
+		rtw_pci_clkreq_set(rtwdev, true);
+
+	rtwpci->link_ctrl = link_ctrl;
+}
+
 static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -1145,6 +1226,8 @@ static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 		else
 			rtw_dbi_write8(rtwdev, offset, value);
 	}
+
+	rtw_pci_link_cfg(rtwdev);
 }
 
 static int rtw_pci_claim(struct rtw_dev *rtwdev, struct pci_dev *pdev)
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 50aff49738d4..90efb73c607e 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -20,6 +20,7 @@
 #define BIT_RST_TRXDMA_INTF	BIT(20)
 #define BIT_RX_TAG_EN		BIT(15)
 #define REG_DBI_WDATA_V1	0x03E8
+#define REG_DBI_RDATA_V1	0x03EC
 #define REG_DBI_FLAG_V1		0x03F0
 #define BIT_DBI_RFLAG		BIT(17)
 #define BIT_DBI_WFLAG		BIT(16)
@@ -35,6 +36,9 @@
 #define RTW_PCI_MDIO_PG_OFFS_G2	2
 #define RTW_PCI_WR_RETRY_CNT	20
 
+#define RTK_PCIE_LINK_CFG	0x0719
+#define BIT_CLKREQ_SW_EN	BIT(4)
+
 #define BIT_PCI_BCNQ_FLAG	BIT(4)
 #define RTK_PCI_TXBD_DESA_BCNQ	0x308
 #define RTK_PCI_TXBD_DESA_H2CQ	0x1320
@@ -200,6 +204,7 @@ struct rtw_pci {
 	u16 rx_tag;
 	struct rtw_pci_tx_ring tx_rings[RTK_MAX_TX_QUEUE_NUM];
 	struct rtw_pci_rx_ring rx_rings[RTK_MAX_RX_QUEUE_NUM];
+	u16 link_ctrl;
 
 	void __iomem *mmap;
 };
-- 
2.17.1

