Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB7F2D32
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 12:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbfKGLQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 06:16:14 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43301 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKGLQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 06:16:14 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA7BG8nU012869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA7BG8nU012869
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 7 Nov 2019 19:16:08 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 7 Nov 2019 19:16:08 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 2/4] rtw88: pci: use for loop instead of while loop for DBI/MDIO
Date:   Thu, 7 Nov 2019 19:16:01 +0800
Message-ID: <20191107111603.12317-3-yhchuang@realtek.com>
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

Use a for loop to polling DBI/MDIO read/write flags to avoid
infinite loop happens

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 26 +++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index b158ef8ded17..6d1aa6f41e84 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1062,7 +1062,7 @@ static void rtw_dbi_write8(struct rtw_dev *rtwdev, u16 addr, u8 data)
 	u16 write_addr;
 	u16 remainder = addr & ~(BITS_DBI_WREN | BITS_DBI_ADDR_MASK);
 	u8 flag;
-	u8 cnt = RTW_PCI_WR_RETRY_CNT;
+	u8 cnt;
 
 	write_addr = addr & BITS_DBI_ADDR_MASK;
 	write_addr |= u16_encode_bits(BIT(remainder), BITS_DBI_WREN);
@@ -1070,21 +1070,22 @@ static void rtw_dbi_write8(struct rtw_dev *rtwdev, u16 addr, u8 data)
 	rtw_write16(rtwdev, REG_DBI_FLAG_V1, write_addr);
 	rtw_write8(rtwdev, REG_DBI_FLAG_V1 + 2, BIT_DBI_WFLAG >> 16);
 
-	flag = rtw_read8(rtwdev, REG_DBI_FLAG_V1 + 2);
-	while (flag && (cnt != 0)) {
-		udelay(10);
+	for (cnt = 0; cnt < RTW_PCI_WR_RETRY_CNT; cnt++) {
 		flag = rtw_read8(rtwdev, REG_DBI_FLAG_V1 + 2);
-		cnt--;
+		if (flag == 0)
+			return;
+
+		udelay(10);
 	}
 
-	WARN(flag, "DBI write fail\n");
+	WARN(flag, "failed to write to DBI register, addr=0x%04x\n", addr);
 }
 
 static void rtw_mdio_write(struct rtw_dev *rtwdev, u8 addr, u16 data, bool g1)
 {
 	u8 page;
 	u8 wflag;
-	u8 cnt = RTW_PCI_WR_RETRY_CNT;
+	u8 cnt;
 
 	rtw_write16(rtwdev, REG_MDIO_V1, data);
 
@@ -1094,15 +1095,16 @@ static void rtw_mdio_write(struct rtw_dev *rtwdev, u8 addr, u16 data, bool g1)
 	rtw_write8(rtwdev, REG_PCIE_MIX_CFG + 3, page);
 	rtw_write32_mask(rtwdev, REG_PCIE_MIX_CFG, BIT_MDIO_WFLAG_V1, 1);
 
-	wflag = rtw_read32_mask(rtwdev, REG_PCIE_MIX_CFG, BIT_MDIO_WFLAG_V1);
-	while (wflag && (cnt != 0)) {
-		udelay(10);
+	for (cnt = 0; cnt < RTW_PCI_WR_RETRY_CNT; cnt++) {
 		wflag = rtw_read32_mask(rtwdev, REG_PCIE_MIX_CFG,
 					BIT_MDIO_WFLAG_V1);
-		cnt--;
+		if (wflag == 0)
+			return;
+
+		udelay(10);
 	}
 
-	WARN(wflag, "MDIO write fail\n");
+	WARN(wflag, "failed to write to MDIO register, addr=0x%02x\n", addr);
 }
 
 static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
-- 
2.17.1

