Return-Path: <linux-wireless+bounces-5517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA478910DD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 03:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFB728BE3C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5838748787;
	Fri, 29 Mar 2024 01:54:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7844C9D
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677275; cv=none; b=q3wZ6exjB6VyuPF/KyrM7RfXde/VdLZDV8caZrILhSwAMAy0i9PKHs4+Vt6V1ZtbMR/cMROwPSsujCGBpEEE0jJ2VRflXJXGxkBW8GC3kg/5gDZlJdhIizN586WT1nvVwBROcf03kpnK62WW3C5T9UsZhxq9yhfdPByYfNyKm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677275; c=relaxed/simple;
	bh=VUJe0t/cGcKlNycZKcTtdweLrZB5r4KXwTVWhPnFYK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVBS5wbIRut59U2Afbd1BdINo3hz/mAO3lIFP/k8M3tsroLTZj9N2ZY8nHbpDjN9wniGWmfrG6C6bAtwh2y0aBUdvlN0cREG5D/9zS70vEY4QOWXjT5AUnnqWz5tR/23YXdmRi+SCqHruZtVBeRSF13cn6mlJVEJZ7Q71MyTlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T1sU0S13183280, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T1sU0S13183280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 09:54:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:54:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 09:54:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 4/4] wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility
Date: Fri, 29 Mar 2024 09:52:51 +0800
Message-ID: <20240329015251.22762-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329015251.22762-1-pkshih@realtek.com>
References: <20240329015251.22762-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

For adaption EQ circuit, this HW design and affected by EIEOS (Electrical
Idle Exit Order Set) amplitude from platform and process from IC, so
disable EQ to improve that.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 72 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h |  8 +++
 2 files changed, 80 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 46e24b3d807f..c734f6702546 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -19,6 +19,31 @@ MODULE_PARM_DESC(disable_clkreq, "Set Y to disable PCI clkreq support");
 MODULE_PARM_DESC(disable_aspm_l1, "Set Y to disable PCI ASPM L1 support");
 MODULE_PARM_DESC(disable_aspm_l1ss, "Set Y to disable PCI L1SS support");
 
+static int rtw89_pci_get_phy_offset_by_link_speed(struct rtw89_dev *rtwdev,
+						  u32 *phy_offset)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+	u32 val;
+	int ret;
+
+	ret = pci_read_config_dword(pdev, RTW89_PCIE_L1_STS_V1, &val);
+	if (ret)
+		return ret;
+
+	val = u32_get_bits(val, RTW89_BCFG_LINK_SPEED_MASK);
+	if (val == RTW89_PCIE_GEN1_SPEED) {
+		*phy_offset = R_RAC_DIRECT_OFFSET_G1;
+	} else if (val == RTW89_PCIE_GEN2_SPEED) {
+		*phy_offset = R_RAC_DIRECT_OFFSET_G2;
+	} else {
+		rtw89_warn(rtwdev, "Unknown PCI link speed %d\n", val);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int rtw89_pci_rst_bdram_ax(struct rtw89_dev *rtwdev)
 {
 	u32 val;
@@ -2298,6 +2323,52 @@ static int rtw89_pci_deglitch_setting(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_pci_disable_eq(struct rtw89_dev *rtwdev)
+{
+	u16 g1_oobs, g2_oobs;
+	u32 backup_aspm;
+	u32 phy_offset;
+	u16 oobs_val;
+	u16 val16;
+	int ret;
+
+	if (rtwdev->chip->chip_id != RTL8852C)
+		return;
+
+	backup_aspm = rtw89_read32(rtwdev, R_AX_PCIE_MIX_CFG_V1);
+	rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1, B_AX_ASPM_CTRL_MASK);
+
+	g1_oobs = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_G1 +
+					    RAC_ANA09 * RAC_MULT, BAC_OOBS_SEL);
+	g2_oobs = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_G2 +
+					    RAC_ANA09 * RAC_MULT, BAC_OOBS_SEL);
+	if (g1_oobs && g2_oobs)
+		goto out;
+
+	ret = rtw89_pci_get_phy_offset_by_link_speed(rtwdev, &phy_offset);
+	if (ret)
+		goto out;
+
+	rtw89_write16_set(rtwdev, phy_offset + RAC_ANA0D * RAC_MULT, BAC_RX_TEST_EN);
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA10 * RAC_MULT, ADDR_SEL_PINOUT_DIS_VAL);
+	rtw89_write16_set(rtwdev, phy_offset + RAC_ANA19 * RAC_MULT, B_PCIE_BIT_RD_SEL);
+
+	val16 = rtw89_read16_mask(rtwdev, phy_offset + RAC_ANA1F * RAC_MULT,
+				  OOBS_LEVEL_MASK);
+	oobs_val = u16_encode_bits(val16, OOBS_SEN_MASK);
+
+	rtw89_write16(rtwdev, R_RAC_DIRECT_OFFSET_G1 + RAC_ANA03 * RAC_MULT, oobs_val);
+	rtw89_write16_set(rtwdev, R_RAC_DIRECT_OFFSET_G1 + RAC_ANA09 * RAC_MULT,
+			  BAC_OOBS_SEL);
+
+	rtw89_write16(rtwdev, R_RAC_DIRECT_OFFSET_G2 + RAC_ANA03 * RAC_MULT, oobs_val);
+	rtw89_write16_set(rtwdev, R_RAC_DIRECT_OFFSET_G2 + RAC_ANA09 * RAC_MULT,
+			  BAC_OOBS_SEL);
+
+out:
+	rtw89_write32(rtwdev, R_AX_PCIE_MIX_CFG_V1, backup_aspm);
+}
+
 static void rtw89_pci_ber(struct rtw89_dev *rtwdev)
 {
 	u32 phy_offset;
@@ -2711,6 +2782,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int ret;
 
+	rtw89_pci_disable_eq(rtwdev);
 	rtw89_pci_ber(rtwdev);
 	rtw89_pci_rxdma_prefth(rtwdev);
 	rtw89_pci_l1off_pwroff(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 87e7081664c1..7666753ae983 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -12,11 +12,18 @@
 #define MDIO_PG0_G2 2
 #define MDIO_PG1_G2 3
 #define RAC_CTRL_PPR			0x00
+#define RAC_ANA03			0x03
+#define OOBS_SEN_MASK			GENMASK(5, 1)
+#define RAC_ANA09			0x09
+#define BAC_OOBS_SEL			BIT(4)
 #define RAC_ANA0A			0x0A
 #define B_BAC_EQ_SEL			BIT(5)
 #define RAC_ANA0C			0x0C
 #define B_PCIE_BIT_PSAVE		BIT(15)
+#define RAC_ANA0D			0x0D
+#define BAC_RX_TEST_EN			BIT(6)
 #define RAC_ANA10			0x10
+#define ADDR_SEL_PINOUT_DIS_VAL		0x3C4
 #define B_PCIE_BIT_PINOUT_DIS		BIT(3)
 #define RAC_REG_REV2			0x1B
 #define BAC_CMU_EN_DLY_MASK		GENMASK(15, 12)
@@ -30,6 +37,7 @@
 #define RAC_ANA1E_G1_VAL		0x66EA
 #define RAC_ANA1E_G2_VAL		0x6EEA
 #define RAC_ANA1F			0x1F
+#define OOBS_LEVEL_MASK			GENMASK(12, 8)
 #define RAC_ANA24			0x24
 #define B_AX_DEGLITCH			GENMASK(11, 8)
 #define RAC_ANA26			0x26
-- 
2.25.1


