Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0335F2D33
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 12:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfKGLQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 06:16:15 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43300 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388339AbfKGLQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 06:16:14 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA7BG7Wi012865, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA7BG7Wi012865
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 7 Nov 2019 19:16:08 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 7 Nov 2019 19:16:07 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 1/4] rtw88: pci: use macros to access PCI DBI/MDIO registers
Date:   Thu, 7 Nov 2019 19:16:00 +0800
Message-ID: <20191107111603.12317-2-yhchuang@realtek.com>
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

Add some register and bit macros to access DBI/MDIO register. This
should not change the logic.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 21 ++++++++++-----------
 drivers/net/wireless/realtek/rtw88/pci.h | 10 ++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 17b9cdf9cb05..b158ef8ded17 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1060,14 +1060,15 @@ static void rtw_pci_io_unmapping(struct rtw_dev *rtwdev,
 static void rtw_dbi_write8(struct rtw_dev *rtwdev, u16 addr, u8 data)
 {
 	u16 write_addr;
-	u16 remainder = addr & 0x3;
+	u16 remainder = addr & ~(BITS_DBI_WREN | BITS_DBI_ADDR_MASK);
 	u8 flag;
-	u8 cnt = 20;
+	u8 cnt = RTW_PCI_WR_RETRY_CNT;
 
-	write_addr = ((addr & 0x0ffc) | (BIT(0) << (remainder + 12)));
+	write_addr = addr & BITS_DBI_ADDR_MASK;
+	write_addr |= u16_encode_bits(BIT(remainder), BITS_DBI_WREN);
 	rtw_write8(rtwdev, REG_DBI_WDATA_V1 + remainder, data);
 	rtw_write16(rtwdev, REG_DBI_FLAG_V1, write_addr);
-	rtw_write8(rtwdev, REG_DBI_FLAG_V1 + 2, 0x01);
+	rtw_write8(rtwdev, REG_DBI_FLAG_V1 + 2, BIT_DBI_WFLAG >> 16);
 
 	flag = rtw_read8(rtwdev, REG_DBI_FLAG_V1 + 2);
 	while (flag && (cnt != 0)) {
@@ -1083,19 +1084,17 @@ static void rtw_mdio_write(struct rtw_dev *rtwdev, u8 addr, u16 data, bool g1)
 {
 	u8 page;
 	u8 wflag;
-	u8 cnt;
+	u8 cnt = RTW_PCI_WR_RETRY_CNT;
 
 	rtw_write16(rtwdev, REG_MDIO_V1, data);
 
-	page = addr < 0x20 ? 0 : 1;
-	page += g1 ? 0 : 2;
-	rtw_write8(rtwdev, REG_PCIE_MIX_CFG, addr & 0x1f);
+	page = addr < RTW_PCI_MDIO_PG_SZ ? 0 : 1;
+	page += g1 ? RTW_PCI_MDIO_PG_OFFS_G1 : RTW_PCI_MDIO_PG_OFFS_G2;
+	rtw_write8(rtwdev, REG_PCIE_MIX_CFG, addr & BITS_MDIO_ADDR_MASK);
 	rtw_write8(rtwdev, REG_PCIE_MIX_CFG + 3, page);
-
 	rtw_write32_mask(rtwdev, REG_PCIE_MIX_CFG, BIT_MDIO_WFLAG_V1, 1);
-	wflag = rtw_read32_mask(rtwdev, REG_PCIE_MIX_CFG, BIT_MDIO_WFLAG_V1);
 
-	cnt = 20;
+	wflag = rtw_read32_mask(rtwdev, REG_PCIE_MIX_CFG, BIT_MDIO_WFLAG_V1);
 	while (wflag && (cnt != 0)) {
 		udelay(10);
 		wflag = rtw_read32_mask(rtwdev, REG_PCIE_MIX_CFG,
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 87824a4caba9..50aff49738d4 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -21,9 +21,19 @@
 #define BIT_RX_TAG_EN		BIT(15)
 #define REG_DBI_WDATA_V1	0x03E8
 #define REG_DBI_FLAG_V1		0x03F0
+#define BIT_DBI_RFLAG		BIT(17)
+#define BIT_DBI_WFLAG		BIT(16)
+#define BITS_DBI_WREN		GENMASK(15, 12)
+#define BITS_DBI_ADDR_MASK	GENMASK(11, 2)
+
 #define REG_MDIO_V1		0x03F4
 #define REG_PCIE_MIX_CFG	0x03F8
+#define BITS_MDIO_ADDR_MASK	GENMASK(4, 0)
 #define BIT_MDIO_WFLAG_V1	BIT(5)
+#define RTW_PCI_MDIO_PG_SZ	BIT(5)
+#define RTW_PCI_MDIO_PG_OFFS_G1	0
+#define RTW_PCI_MDIO_PG_OFFS_G2	2
+#define RTW_PCI_WR_RETRY_CNT	20
 
 #define BIT_PCI_BCNQ_FLAG	BIT(4)
 #define RTK_PCI_TXBD_DESA_BCNQ	0x308
-- 
2.17.1

