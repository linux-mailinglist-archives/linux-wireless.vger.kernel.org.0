Return-Path: <linux-wireless+bounces-1413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06FC822684
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 02:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094001F23032
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B37F1100;
	Wed,  3 Jan 2024 01:25:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5C10EE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4031PBNQ0616638, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4031PBNQ0616638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 09:25:11 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 3 Jan 2024 09:25:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 3 Jan 2024
 09:25:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: pci: use DBI function for 8852AE/8852BE/8851BE
Date: Wed, 3 Jan 2024 09:23:46 +0800
Message-ID: <20240103012346.6822-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chin-Yen Lee <timlee@realtek.com>

Sometimes driver can't use kernel API pci_read/write_config_byte
to access the PCI config space of above address 0x100 due to
the negotiated PCI setting. 8852AE/8852BE/8851BE provide another
way called DBI function, which belongs to WiFi mac and could
access all PCI config space for this case.

Link: https://lore.kernel.org/linux-wireless/79fe81b7db7148b9a7da2353c16d70fb@realtek.com/T/#t
Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 69 +++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.h |  1 +
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 769f1ce62ebc..9943ed856248 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1907,22 +1907,87 @@ static int rtw89_write16_mdio_clr(struct rtw89_dev *rtwdev, u8 addr, u16 mask, u
 	return 0;
 }
 
+static int rtw89_dbi_write8(struct rtw89_dev *rtwdev, u16 addr, u8 data)
+{
+	u16 addr_2lsb = addr & B_AX_DBI_2LSB;
+	u16 write_addr;
+	u8 flag;
+	int ret;
+
+	write_addr = addr & B_AX_DBI_ADDR_MSK;
+	write_addr |= u16_encode_bits(BIT(addr_2lsb), B_AX_DBI_WREN_MSK);
+	rtw89_write8(rtwdev, R_AX_DBI_WDATA + addr_2lsb, data);
+	rtw89_write16(rtwdev, R_AX_DBI_FLAG, write_addr);
+	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_WFLAG >> 16);
+
+	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
+				       10 * RTW89_PCI_WR_RETRY_CNT, false,
+				       rtwdev, R_AX_DBI_FLAG + 2);
+	if (ret)
+		rtw89_err(rtwdev, "failed to write DBI register, addr=0x%X\n",
+			  addr);
+
+	return ret;
+}
+
+static int rtw89_dbi_read8(struct rtw89_dev *rtwdev, u16 addr, u8 *value)
+{
+	u16 read_addr = addr & B_AX_DBI_ADDR_MSK;
+	u8 flag;
+	int ret;
+
+	rtw89_write16(rtwdev, R_AX_DBI_FLAG, read_addr);
+	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_RFLAG >> 16);
+
+	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
+				       10 * RTW89_PCI_WR_RETRY_CNT, false,
+				       rtwdev, R_AX_DBI_FLAG + 2);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to read DBI register, addr=0x%X\n",
+			  addr);
+		return ret;
+	}
+
+	read_addr = R_AX_DBI_RDATA + (addr & 3);
+	*value = rtw89_read8(rtwdev, read_addr);
+
+	return 0;
+}
+
 static int rtw89_pci_write_config_byte(struct rtw89_dev *rtwdev, u16 addr,
 				       u8 data)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	struct pci_dev *pdev = rtwpci->pdev;
+	int ret;
+
+	ret = pci_write_config_byte(pdev, addr, data);
+	if (!ret)
+		return 0;
 
-	return pci_write_config_byte(pdev, addr, data);
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
+		ret = rtw89_dbi_write8(rtwdev, addr, data);
+
+	return ret;
 }
 
 static int rtw89_pci_read_config_byte(struct rtw89_dev *rtwdev, u16 addr,
 				      u8 *value)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	struct pci_dev *pdev = rtwpci->pdev;
+	int ret;
 
-	return pci_read_config_byte(pdev, addr, value);
+	ret = pci_read_config_byte(pdev, addr, value);
+	if (!ret)
+		return 0;
+
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
+		ret = rtw89_dbi_read8(rtwdev, addr, value);
+
+	return ret;
 }
 
 static int rtw89_pci_config_byte_set(struct rtw89_dev *rtwdev, u16 addr,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index ca5de77fee90..1fb7c209fa0d 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -42,6 +42,7 @@
 #define B_AX_DBI_WFLAG			BIT(16)
 #define B_AX_DBI_WREN_MSK		GENMASK(15, 12)
 #define B_AX_DBI_ADDR_MSK		GENMASK(11, 2)
+#define B_AX_DBI_2LSB			GENMASK(1, 0)
 #define R_AX_DBI_WDATA			0x1094
 #define R_AX_DBI_RDATA			0x1098
 
-- 
2.25.1


