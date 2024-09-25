Return-Path: <linux-wireless+bounces-13132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2479850AC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 03:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8FA2849A7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 01:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FC42A9D;
	Wed, 25 Sep 2024 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XTc/g6F9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23354136672
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228397; cv=none; b=b7FUMz/zj3NUeL6+58Emh183hCqlkD6+4yQ9PMY65CgTkWtnLi6bU/K/0AnWM3yrEfL+SAaUbBI7Qz2RfRemL7xLvSCqnYE1S+9E2ZFX2HVlsiLGM5GF2X2G/uDpoRGkl15OTDbkAvlfJes/V4oUxiBE52AdmOdsb8ze0flBnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228397; c=relaxed/simple;
	bh=uifrNpZHzvu7kJD4q9HPKuRqd/TI2XQzIzEqmQzZlB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwLxkKLOQSrAvkPhijbHVQL8/Skew+F5CzZzVTmq8CcJExZWoxy6x6jCa4ThhmvgrIO8RzlkyG+YaYO0Clo8yIvDsSZGA8hoJTa+HJE4yDugdUeopbqYrg/J2ov0TgfTkmkRtRnn/qYU+IzZYF6KLdzNrXqs1YwniFR1kk7vcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XTc/g6F9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P1drj973834589, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727228393; bh=uifrNpZHzvu7kJD4q9HPKuRqd/TI2XQzIzEqmQzZlB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XTc/g6F9soiisfOxL5H0gPeB63O7AQmfodvPNGTg12T4BMbOYEWGiM6b3bMvpWMD0
	 qV+7XVdDZAqEzbrNh+YdZ4wzCrVooEgZ2Ax08ZL67bcrOdmZ1QaR7Whb3aBsa1ew6Z
	 /FQAjusStKpl0/f2bsoTOBlohuP0C8Z1JnYkMqN7E0OxKVm+1ZjC0vPgubWboUen6u
	 LOTg/roUj+jTYVQCcGEU041XaXlWOLSZ1q8qgkH8NS4yVxDP8RW4vWIAtd/7UkEsaS
	 tMv+f9Js+OVS/CJW4HDY94CNmyl+iS8jDAMWseI9NEl29cDnnrlScXkB7E8ntI0d2E
	 MzPVdwfaupotg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P1drj973834589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 09:39:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:39:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 09:39:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: 8922ae: disable PCI PHY EQ to improve compatibility
Date: Wed, 25 Sep 2024 09:38:59 +0800
Message-ID: <20240925013901.9835-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925013901.9835-1-pkshih@realtek.com>
References: <20240925013901.9835-1-pkshih@realtek.com>
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
 drivers/net/wireless/realtek/rtw89/pci.c    |  4 +-
 drivers/net/wireless/realtek/rtw89/pci.h    | 23 +++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 75 +++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5733192cf380..c1e0861b7b3f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2358,7 +2358,7 @@ static int rtw89_pci_deglitch_setting(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw89_pci_disable_eq(struct rtw89_dev *rtwdev)
+static void rtw89_pci_disable_eq_ax(struct rtw89_dev *rtwdev)
 {
 	u16 g1_oobs, g2_oobs;
 	u32 backup_aspm;
@@ -4254,6 +4254,8 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.aspm_set = rtw89_pci_aspm_set_ax,
 	.clkreq_set = rtw89_pci_clkreq_set_ax,
 	.l1ss_set = rtw89_pci_l1ss_set_ax,
+
+	.disable_eq = rtw89_pci_disable_eq_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index f101bd932f62..796f6cd3c965 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -18,11 +18,16 @@
 #define BAC_OOBS_SEL			BIT(4)
 #define RAC_ANA0A			0x0A
 #define B_BAC_EQ_SEL			BIT(5)
+#define RAC_ANA0B			0x0B
+#define MANUAL_LVL_MASK			GENMASK(8, 5)
 #define RAC_ANA0C			0x0C
 #define B_PCIE_BIT_PSAVE		BIT(15)
 #define RAC_ANA0D			0x0D
+#define OFFSET_CAL_MODE			BIT(13)
 #define BAC_RX_TEST_EN			BIT(6)
 #define RAC_ANA10			0x10
+#define ADDR_SEL_MASK		        GENMASK(9, 4)
+#define ADDR_SEL_VAL		        0x3C
 #define ADDR_SEL_PINOUT_DIS_VAL		0x3C4
 #define B_PCIE_BIT_PINOUT_DIS		BIT(3)
 #define RAC_REG_REV2			0x1B
@@ -38,6 +43,7 @@
 #define RAC_ANA1E_G2_VAL		0x6EEA
 #define RAC_ANA1F			0x1F
 #define OOBS_LEVEL_MASK			GENMASK(12, 8)
+#define OFFSET_CAL_MASK		        GENMASK(7, 4)
 #define RAC_ANA24			0x24
 #define B_AX_DEGLITCH			GENMASK(11, 8)
 #define RAC_ANA26			0x26
@@ -134,6 +140,11 @@
 #define REG_FILTER_OUT_MASK GENMASK(6, 2)
 #define RAC_MULT 2
 
+#define R_RAC_DIRECT_OFFSET_BE_LANE0_G1 0x3800
+#define R_RAC_DIRECT_OFFSET_BE_LANE1_G1 0x3880
+#define R_RAC_DIRECT_OFFSET_BE_LANE0_G2 0x3900
+#define R_RAC_DIRECT_OFFSET_BE_LANE1_G2 0x3980
+
 #define RTW89_PCI_WR_RETRY_CNT		20
 
 /* Interrupts */
@@ -299,6 +310,7 @@
 #define B_BE_L1SS_TIMEOUT_CTRL BIT(18)
 #define B_BE_ASPM_CTRL_L1 BIT(17)
 #define B_BE_ASPM_CTRL_L0 BIT(16)
+#define B_BE_RTK_ASPM_CTRL_MASK GENMASK(17, 16)
 #define B_BE_XFER_PENDING_FW BIT(11)
 #define B_BE_XFER_PENDING BIT(10)
 #define B_BE_REQ_EXIT_L1 BIT(9)
@@ -1276,6 +1288,8 @@ struct rtw89_pci_gen_def {
 	void (*aspm_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*clkreq_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*l1ss_set)(struct rtw89_dev *rtwdev, bool enable);
+
+	void (*disable_eq)(struct rtw89_dev *rtwdev);
 };
 
 struct rtw89_pci_info {
@@ -1767,4 +1781,13 @@ static inline int rtw89_pci_poll_txdma_ch_idle(struct rtw89_dev *rtwdev)
 
 	return gen_def->poll_txdma_ch_idle(rtwdev);
 }
+
+static inline void rtw89_pci_disable_eq(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	gen_def->disable_eq(rtwdev);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index c1415a7b18ff..34154506f5d4 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -550,6 +550,79 @@ static int rtw89_pci_lv1rst_start_dma_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_pci_disable_eq_be(struct rtw89_dev *rtwdev)
+{
+	u32 backup_aspm, phy_offset;
+	u16 oobs_val, offset_cal;
+	u16 g1_oobs, g2_oobs;
+	u8 gen;
+
+	if (rtwdev->chip->chip_id != RTL8922A)
+		return;
+
+	g1_oobs = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_BE_LANE0_G1 +
+					    RAC_ANA09 * RAC_MULT, BAC_OOBS_SEL);
+	g2_oobs = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_BE_LANE0_G2 +
+					    RAC_ANA09 * RAC_MULT, BAC_OOBS_SEL);
+	if (g1_oobs && g2_oobs)
+		return;
+
+	backup_aspm = rtw89_read32(rtwdev, R_BE_PCIE_MIX_CFG);
+	rtw89_write32_clr(rtwdev, R_BE_PCIE_MIX_CFG, B_BE_RTK_ASPM_CTRL_MASK);
+
+	/* offset K */
+	for (gen = 1; gen <= 2; gen++) {
+		phy_offset = gen == 1 ? R_RAC_DIRECT_OFFSET_BE_LANE0_G1 :
+					R_RAC_DIRECT_OFFSET_BE_LANE0_G2;
+
+		rtw89_write16_clr(rtwdev, phy_offset + RAC_ANA19 * RAC_MULT,
+				  B_PCIE_BIT_RD_SEL);
+	}
+
+	offset_cal = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_BE_LANE0_G1 +
+					       RAC_ANA1F * RAC_MULT, OFFSET_CAL_MASK);
+
+	for (gen = 1; gen <= 2; gen++) {
+		phy_offset = gen == 1 ? R_RAC_DIRECT_OFFSET_BE_LANE0_G1 :
+					R_RAC_DIRECT_OFFSET_BE_LANE0_G2;
+
+		rtw89_write16_mask(rtwdev, phy_offset + RAC_ANA0B * RAC_MULT,
+				   MANUAL_LVL_MASK, offset_cal);
+		rtw89_write16_clr(rtwdev, phy_offset + RAC_ANA0D * RAC_MULT,
+				  OFFSET_CAL_MODE);
+	}
+
+	/* OOBS */
+	for (gen = 1; gen <= 2; gen++) {
+		phy_offset = gen == 1 ? R_RAC_DIRECT_OFFSET_BE_LANE0_G1 :
+					R_RAC_DIRECT_OFFSET_BE_LANE0_G2;
+
+		rtw89_write16_set(rtwdev, phy_offset + RAC_ANA0D * RAC_MULT,
+				  BAC_RX_TEST_EN);
+		rtw89_write16_mask(rtwdev, phy_offset + RAC_ANA10 * RAC_MULT,
+				   ADDR_SEL_MASK, ADDR_SEL_VAL);
+		rtw89_write16_clr(rtwdev, phy_offset + RAC_ANA10 * RAC_MULT,
+				  B_PCIE_BIT_PINOUT_DIS);
+		rtw89_write16_set(rtwdev, phy_offset + RAC_ANA19 * RAC_MULT,
+				  B_PCIE_BIT_RD_SEL);
+	}
+
+	oobs_val = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_BE_LANE0_G1 +
+					     RAC_ANA1F * RAC_MULT, OOBS_LEVEL_MASK);
+
+	for (gen = 1; gen <= 2; gen++) {
+		phy_offset = gen == 1 ? R_RAC_DIRECT_OFFSET_BE_LANE0_G1 :
+					R_RAC_DIRECT_OFFSET_BE_LANE0_G2;
+
+		rtw89_write16_mask(rtwdev, phy_offset + RAC_ANA03 * RAC_MULT,
+				   OOBS_SEN_MASK, oobs_val);
+		rtw89_write16_set(rtwdev, phy_offset + RAC_ANA09 * RAC_MULT,
+				  BAC_OOBS_SEL);
+	}
+
+	rtw89_write32(rtwdev, R_BE_PCIE_MIX_CFG, backup_aspm);
+}
+
 static int __maybe_unused rtw89_pci_suspend_be(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
@@ -616,5 +689,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.aspm_set = rtw89_pci_aspm_set_be,
 	.clkreq_set = rtw89_pci_clkreq_set_be,
 	.l1ss_set = rtw89_pci_l1ss_set_be,
+
+	.disable_eq = rtw89_pci_disable_eq_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
-- 
2.25.1


