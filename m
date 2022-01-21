Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072F5495B4D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 08:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379283AbiAUH4n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 02:56:43 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49854 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379298AbiAUH4W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:22 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20L7uFnbD032216, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20L7uFnbD032216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 15:56:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 15:56:14 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 21 Jan
 2022 15:56:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <johnson.lin@realtek.com>
Subject: [PATCH] rtw89: use pci_read/write_config instead of dbi read/write
Date:   Fri, 21 Jan 2022 15:55:55 +0800
Message-ID: <20220121075555.12457-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121075555.12457-1-pkshih@realtek.com>
References: <20220121075555.12457-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/21/2022 07:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMjEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

In the past we use dbi function of wifi mac to read/write
pci config space, but the function will be remove in new
chip. So use kernel api pci_read/write_config_byte instead.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 128 ++++++++++-------------
 1 file changed, 53 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 2c94762e4f930..8ca88134aa67c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1413,79 +1413,52 @@ static int rtw89_write16_mdio_clr(struct rtw89_dev *rtwdev, u8 addr, u16 mask, u
 	return 0;
 }
 
-static int rtw89_dbi_write8(struct rtw89_dev *rtwdev, u16 addr, u8 data)
+static int rtw89_pci_write_config_byte(struct rtw89_dev *rtwdev, u16 addr,
+				       u8 data)
 {
-	u16 write_addr;
-	u16 remainder = addr & ~(B_AX_DBI_ADDR_MSK | B_AX_DBI_WREN_MSK);
-	u8 flag;
-	int ret;
-
-	write_addr = addr & B_AX_DBI_ADDR_MSK;
-	write_addr |= u16_encode_bits(BIT(remainder), B_AX_DBI_WREN_MSK);
-	rtw89_write8(rtwdev, R_AX_DBI_WDATA + remainder, data);
-	rtw89_write16(rtwdev, R_AX_DBI_FLAG, write_addr);
-	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_WFLAG >> 16);
-
-	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
-				       10 * RTW89_PCI_WR_RETRY_CNT, false,
-				       rtwdev, R_AX_DBI_FLAG + 2);
-	if (ret)
-		WARN(flag, "failed to write to DBI register, addr=0x%04x\n",
-		     addr);
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
 
-	return ret;
+	return pci_write_config_byte(pdev, addr, data);
 }
 
-static int rtw89_dbi_read8(struct rtw89_dev *rtwdev, u16 addr, u8 *value)
+static int rtw89_pci_read_config_byte(struct rtw89_dev *rtwdev, u16 addr,
+				      u8 *value)
 {
-	u16 read_addr = addr & B_AX_DBI_ADDR_MSK;
-	u8 flag;
-	int ret;
-
-	rtw89_write16(rtwdev, R_AX_DBI_FLAG, read_addr);
-	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_RFLAG >> 16);
-
-	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
-				       10 * RTW89_PCI_WR_RETRY_CNT, false,
-				       rtwdev, R_AX_DBI_FLAG + 2);
-
-	if (!ret) {
-		read_addr = R_AX_DBI_RDATA + (addr & 3);
-		*value = rtw89_read8(rtwdev, read_addr);
-	} else {
-		WARN(1, "failed to read DBI register, addr=0x%04x\n", addr);
-		ret = -EIO;
-	}
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
 
-	return ret;
+	return pci_read_config_byte(pdev, addr, value);
 }
 
-static int rtw89_dbi_write8_set(struct rtw89_dev *rtwdev, u16 addr, u8 bit)
+static int rtw89_pci_config_byte_set(struct rtw89_dev *rtwdev, u16 addr,
+				     u8 bit)
 {
 	u8 value;
 	int ret;
 
-	ret = rtw89_dbi_read8(rtwdev, addr, &value);
+	ret = rtw89_pci_read_config_byte(rtwdev, addr, &value);
 	if (ret)
 		return ret;
 
 	value |= bit;
-	ret = rtw89_dbi_write8(rtwdev, addr, value);
+	ret = rtw89_pci_write_config_byte(rtwdev, addr, value);
 
 	return ret;
 }
 
-static int rtw89_dbi_write8_clr(struct rtw89_dev *rtwdev, u16 addr, u8 bit)
+static int rtw89_pci_config_byte_clr(struct rtw89_dev *rtwdev, u16 addr,
+				     u8 bit)
 {
 	u8 value;
 	int ret;
 
-	ret = rtw89_dbi_read8(rtwdev, addr, &value);
+	ret = rtw89_pci_read_config_byte(rtwdev, addr, &value);
 	if (ret)
 		return ret;
 
 	value &= ~bit;
-	ret = rtw89_dbi_write8(rtwdev, addr, value);
+	ret = rtw89_pci_write_config_byte(rtwdev, addr, value);
 
 	return ret;
 }
@@ -1542,9 +1515,10 @@ static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
 	    rtwdev->chip->chip_id == RTL8852C)
 		return 0;
 
-	ret = rtw89_dbi_read8(rtwdev, RTW89_PCIE_PHY_RATE, &val8);
+	ret = rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_PHY_RATE, &val8);
 	if (ret) {
-		rtw89_err(rtwdev, "[ERR]dbi_r8_pcie %X\n", RTW89_PCIE_PHY_RATE);
+		rtw89_err(rtwdev, "[ERR]pci config read %X\n",
+			  RTW89_PCIE_PHY_RATE);
 		return ret;
 	}
 
@@ -1557,17 +1531,18 @@ static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
 		return -EOPNOTSUPP;
 	}
 	/* Disable L1BD */
-	ret = rtw89_dbi_read8(rtwdev, RTW89_PCIE_L1_CTRL, &bdr_ori);
+	ret = rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_L1_CTRL, &bdr_ori);
 	if (ret) {
-		rtw89_err(rtwdev, "[ERR]dbi_r8_pcie %X\n", RTW89_PCIE_L1_CTRL);
+		rtw89_err(rtwdev, "[ERR]pci config read %X\n", RTW89_PCIE_L1_CTRL);
 		return ret;
 	}
 
 	if (bdr_ori & RTW89_PCIE_BIT_L1) {
-		ret = rtw89_dbi_write8(rtwdev, RTW89_PCIE_L1_CTRL,
-				       bdr_ori & ~RTW89_PCIE_BIT_L1);
+		ret = rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_L1_CTRL,
+						  bdr_ori & ~RTW89_PCIE_BIT_L1);
 		if (ret) {
-			rtw89_err(rtwdev, "[ERR]dbi_w8_pcie %X\n", RTW89_PCIE_L1_CTRL);
+			rtw89_err(rtwdev, "[ERR]pci config write %X\n",
+				  RTW89_PCIE_L1_CTRL);
 			return ret;
 		}
 		l1_flag = true;
@@ -1662,14 +1637,17 @@ static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
 	}
 
 	/* CLK delay = 0 */
-	ret = rtw89_dbi_write8(rtwdev, RTW89_PCIE_CLK_CTRL, PCIE_CLKDLY_HW_0);
+	ret = rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_CLK_CTRL,
+					  PCIE_CLKDLY_HW_0);
 
 end:
 	/* Set L1BD to ori */
 	if (l1_flag) {
-		ret = rtw89_dbi_write8(rtwdev, RTW89_PCIE_L1_CTRL, bdr_ori);
+		ret = rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_L1_CTRL,
+						  bdr_ori);
 		if (ret) {
-			rtw89_err(rtwdev, "[ERR]dbi_w8_pcie %X\n", RTW89_PCIE_L1_CTRL);
+			rtw89_err(rtwdev, "[ERR]pci config write %X\n",
+				  RTW89_PCIE_L1_CTRL);
 			return ret;
 		}
 	}
@@ -2552,17 +2530,17 @@ static void rtw89_pci_clkreq_set(struct rtw89_dev *rtwdev, bool enable)
 	if (rtw89_pci_disable_clkreq)
 		return;
 
-	ret = rtw89_dbi_write8(rtwdev, RTW89_PCIE_CLK_CTRL,
-			       PCIE_CLKDLY_HW_30US);
+	ret = rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_CLK_CTRL,
+					  PCIE_CLKDLY_HW_30US);
 	if (ret)
 		rtw89_err(rtwdev, "failed to set CLKREQ Delay\n");
 
 	if (enable)
-		ret = rtw89_dbi_write8_set(rtwdev, RTW89_PCIE_L1_CTRL,
-					   RTW89_PCIE_BIT_CLK);
+		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_L1_CTRL,
+						RTW89_PCIE_BIT_CLK);
 	else
-		ret = rtw89_dbi_write8_clr(rtwdev, RTW89_PCIE_L1_CTRL,
-					   RTW89_PCIE_BIT_CLK);
+		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_L1_CTRL,
+						RTW89_PCIE_BIT_CLK);
 	if (ret)
 		rtw89_err(rtwdev, "failed to %s CLKREQ_L1, ret=%d",
 			  enable ? "set" : "unset", ret);
@@ -2576,7 +2554,7 @@ static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 	if (rtw89_pci_disable_aspm_l1)
 		return;
 
-	ret = rtw89_dbi_read8(rtwdev, RTW89_PCIE_ASPM_CTRL, &value);
+	ret = rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_ASPM_CTRL, &value);
 	if (ret)
 		rtw89_err(rtwdev, "failed to read ASPM Delay\n");
 
@@ -2584,16 +2562,16 @@ static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 	value |= FIELD_PREP(RTW89_L1DLY_MASK, PCIE_L1DLY_16US) |
 		 FIELD_PREP(RTW89_L0DLY_MASK, PCIE_L0SDLY_4US);
 
-	ret = rtw89_dbi_write8(rtwdev, RTW89_PCIE_ASPM_CTRL, value);
+	ret = rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_ASPM_CTRL, value);
 	if (ret)
 		rtw89_err(rtwdev, "failed to read ASPM Delay\n");
 
 	if (enable)
-		ret = rtw89_dbi_write8_set(rtwdev, RTW89_PCIE_L1_CTRL,
-					   RTW89_PCIE_BIT_L1);
+		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_L1_CTRL,
+						RTW89_PCIE_BIT_L1);
 	else
-		ret = rtw89_dbi_write8_clr(rtwdev, RTW89_PCIE_L1_CTRL,
-					   RTW89_PCIE_BIT_L1);
+		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_L1_CTRL,
+						RTW89_PCIE_BIT_L1);
 	if (ret)
 		rtw89_err(rtwdev, "failed to %s ASPM L1, ret=%d",
 			  enable ? "set" : "unset", ret);
@@ -2657,11 +2635,11 @@ static void rtw89_pci_l1ss_set(struct rtw89_dev *rtwdev, bool enable)
 	int ret;
 
 	if (enable)
-		ret = rtw89_dbi_write8_set(rtwdev, RTW89_PCIE_TIMER_CTRL,
-					   RTW89_PCIE_BIT_L1SUB);
+		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_TIMER_CTRL,
+						RTW89_PCIE_BIT_L1SUB);
 	else
-		ret = rtw89_dbi_write8_clr(rtwdev, RTW89_PCIE_TIMER_CTRL,
-					   RTW89_PCIE_BIT_L1SUB);
+		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_TIMER_CTRL,
+						RTW89_PCIE_BIT_L1SUB);
 	if (ret)
 		rtw89_err(rtwdev, "failed to %s L1SS, ret=%d",
 			  enable ? "set" : "unset", ret);
@@ -2878,10 +2856,10 @@ static void rtw89_pci_l2_hci_ldo(struct rtw89_dev *rtwdev)
 		return;
 
 	/* Hardware need write the reg twice to ensure the setting work */
-	rtw89_dbi_write8_set(rtwdev, RTW89_PCIE_RST_MSTATE,
-			     RTW89_PCIE_BIT_CFG_RST_MSTATE);
-	rtw89_dbi_write8_set(rtwdev, RTW89_PCIE_RST_MSTATE,
-			     RTW89_PCIE_BIT_CFG_RST_MSTATE);
+	rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_RST_MSTATE,
+				    RTW89_PCIE_BIT_CFG_RST_MSTATE);
+	rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_RST_MSTATE,
+				    RTW89_PCIE_BIT_CFG_RST_MSTATE);
 }
 
 static int __maybe_unused rtw89_pci_resume(struct device *dev)
-- 
2.25.1

