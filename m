Return-Path: <linux-wireless+bounces-7861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46D8CA72F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 06:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCCE281BAF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 04:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1F4C66;
	Tue, 21 May 2024 04:02:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAA3233
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264124; cv=none; b=sUvKj8O4GsOe8JEZJzRa0DD/XgpVhD3nYWQWclvm8cof1FToZfc546ePPuvLAumJq/DuBUuILdoVEOhoEDP2QamAlIjbd1F8FV1Sp9I0Raqkhw6LGk+MkSX0PoktRDVp3SKJELD/ZwK2DmiZZrzfhhwhz8D8WItkr6VJF6CE5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264124; c=relaxed/simple;
	bh=UsDN9c+BxVtFRUoJAvheuNb9zm8lZ3HzobwO4R33N5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSBpKUoxExum31fU32mePVwummRpfPTfPOucZJx6yb7E5jrsL/PoOlRyOtNVpN6qGR+lwytwZ3oNBGfVyNO6Zh5uKMxsFWZLuPdD5UWnMxbVVnzee7p2Nq7QQeSjdem5plePgRoj5wIbfS7+X+/AUmIuOfF/9OeHsmAS9yfbxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44L41wpJ62141806, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44L41wpJ62141806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 12:01:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 12:01:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 21 May
 2024 12:01:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: 8852c: correct logic and restore PCI PHY EQ after device resume
Date: Tue, 21 May 2024 12:01:39 +0800
Message-ID: <20240521040139.20311-1-pkshih@realtek.com>
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
 RTEXMBS04.realtek.com.tw (172.21.6.97)

PCI PHY EQ value is missing after card off/on, so update the value after
device resume. The original commit only updates once at probe stage, which
could lead problem after suspend/resume.

The logic should be read a value from one register and write to another
register with a mask to avoid affecting unrelated bits.

Fixes: a78d33a1286c ("wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index f93385cc20cd..dbbb2f6500e2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2330,21 +2330,20 @@ static void rtw89_pci_disable_eq(struct rtw89_dev *rtwdev)
 	u32 backup_aspm;
 	u32 phy_offset;
 	u16 oobs_val;
-	u16 val16;
 	int ret;
 
 	if (rtwdev->chip->chip_id != RTL8852C)
 		return;
 
-	backup_aspm = rtw89_read32(rtwdev, R_AX_PCIE_MIX_CFG_V1);
-	rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1, B_AX_ASPM_CTRL_MASK);
-
 	g1_oobs = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_G1 +
 					    RAC_ANA09 * RAC_MULT, BAC_OOBS_SEL);
 	g2_oobs = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_G2 +
 					    RAC_ANA09 * RAC_MULT, BAC_OOBS_SEL);
 	if (g1_oobs && g2_oobs)
-		goto out;
+		return;
+
+	backup_aspm = rtw89_read32(rtwdev, R_AX_PCIE_MIX_CFG_V1);
+	rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1, B_AX_ASPM_CTRL_MASK);
 
 	ret = rtw89_pci_get_phy_offset_by_link_speed(rtwdev, &phy_offset);
 	if (ret)
@@ -2354,15 +2353,16 @@ static void rtw89_pci_disable_eq(struct rtw89_dev *rtwdev)
 	rtw89_write16(rtwdev, phy_offset + RAC_ANA10 * RAC_MULT, ADDR_SEL_PINOUT_DIS_VAL);
 	rtw89_write16_set(rtwdev, phy_offset + RAC_ANA19 * RAC_MULT, B_PCIE_BIT_RD_SEL);
 
-	val16 = rtw89_read16_mask(rtwdev, phy_offset + RAC_ANA1F * RAC_MULT,
-				  OOBS_LEVEL_MASK);
-	oobs_val = u16_encode_bits(val16, OOBS_SEN_MASK);
+	oobs_val = rtw89_read16_mask(rtwdev, phy_offset + RAC_ANA1F * RAC_MULT,
+				     OOBS_LEVEL_MASK);
 
-	rtw89_write16(rtwdev, R_RAC_DIRECT_OFFSET_G1 + RAC_ANA03 * RAC_MULT, oobs_val);
+	rtw89_write16_mask(rtwdev, R_RAC_DIRECT_OFFSET_G1 + RAC_ANA03 * RAC_MULT,
+			   OOBS_SEN_MASK, oobs_val);
 	rtw89_write16_set(rtwdev, R_RAC_DIRECT_OFFSET_G1 + RAC_ANA09 * RAC_MULT,
 			  BAC_OOBS_SEL);
 
-	rtw89_write16(rtwdev, R_RAC_DIRECT_OFFSET_G2 + RAC_ANA03 * RAC_MULT, oobs_val);
+	rtw89_write16_mask(rtwdev, R_RAC_DIRECT_OFFSET_G2 + RAC_ANA03 * RAC_MULT,
+			   OOBS_SEN_MASK, oobs_val);
 	rtw89_write16_set(rtwdev, R_RAC_DIRECT_OFFSET_G2 + RAC_ANA09 * RAC_MULT,
 			  BAC_OOBS_SEL);
 
@@ -2783,7 +2783,6 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int ret;
 
-	rtw89_pci_disable_eq(rtwdev);
 	rtw89_pci_ber(rtwdev);
 	rtw89_pci_rxdma_prefth(rtwdev);
 	rtw89_pci_l1off_pwroff(rtwdev);
@@ -4155,6 +4154,7 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 				  B_AX_SEL_REQ_ENTR_L1);
 	}
 	rtw89_pci_l2_hci_ldo(rtwdev);
+	rtw89_pci_disable_eq(rtwdev);
 	rtw89_pci_filter_out(rtwdev);
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
@@ -4289,6 +4289,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_clear_resource;
 	}
 
+	rtw89_pci_disable_eq(rtwdev);
 	rtw89_pci_filter_out(rtwdev);
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
-- 
2.25.1


