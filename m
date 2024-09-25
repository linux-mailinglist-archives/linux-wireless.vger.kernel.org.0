Return-Path: <linux-wireless+bounces-13134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00379850AE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600942812AE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60656147C9B;
	Wed, 25 Sep 2024 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y3AbuIMR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474D136672
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228405; cv=none; b=TkdQ0TelsXpMnj8TuMVmWOzrVTLGCbi9QiFpV0CkLL8bx76ruvfyvIuwvvy35eN4/IQNna9moyi9FHNxNe6/Vb+N6F1zKeic2OOU2qlQypTRuNYAFSNWnA+t37u7iM1Uc6LU/XR2g2DbLxAaged4FcAzY0UXGYyifube0ddvOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228405; c=relaxed/simple;
	bh=fZUrwrSRQogHxlnYyy0OY/MZmqoO+LKtROozuZr7UO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXSE3EZU2K1vQepePAL5kW5kHGDiwiV7vkmu4EtTk973DMhT9fIQmaY0rgbbF1pxPk1N+8klFLd77XGV4lNvavS1Y2WRqEdODo7zNLRJLkdR+//VdBpHJaAb7Q5AT712PR3SrTGeKZE21RSVIakUji02nHfN7yX5qEr7JIV+AsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y3AbuIMR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P1e13Q13834832, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727228401; bh=fZUrwrSRQogHxlnYyy0OY/MZmqoO+LKtROozuZr7UO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Y3AbuIMRIICjvSpWmqkaEIGIuGRv+dmkAv7KRrE6ZKByeaKgbsoKomXlQfe5jwh1w
	 1IT9OYf6OZEBO0Amdmz74e2HXZX1iDfqpnC2bm9OMlMb4Z82wZwrf1EWdhpu2kjVcK
	 hp5TLhtX36Am4U7FoECZa3DNXLxpLq3pZ5Zi+D78F0MQ/z49PmgpnH7Gm9vSnKMFUx
	 A6rRzmrVCi9DzSjGFq0mmmvTlYICiqJ8XYAy4HFW35i/UBCKqOxTD2gxdpN8QLu1Ms
	 wuOYasLZKpXs7R1HG+PBFyhfAs9maQ61WlR4s0BO8SlTGT3M0hNMSpO7wkiJeAQ1jW
	 +P7Ui71Gc8kkQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P1e13Q13834832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 09:40:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:40:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 09:40:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: 8852ce: set offset K of PCI PHY EQ to manual mode to improve compatibility
Date: Wed, 25 Sep 2024 09:39:01 +0800
Message-ID: <20240925013901.9835-5-pkshih@realtek.com>
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

Read calibration value of PCI RX offset, and set to manual mode as the
value at PCI probe to prevent abnormal calibration results at runtime.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 45d536b818e9..5ed7eaa18c85 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2363,8 +2363,10 @@ static void rtw89_pci_disable_eq_ax(struct rtw89_dev *rtwdev)
 	u16 g1_oobs, g2_oobs;
 	u32 backup_aspm;
 	u32 phy_offset;
+	u16 offset_cal;
 	u16 oobs_val;
 	int ret;
+	u8 gen;
 
 	if (rtwdev->chip->chip_id != RTL8852C)
 		return;
@@ -2400,6 +2402,28 @@ static void rtw89_pci_disable_eq_ax(struct rtw89_dev *rtwdev)
 	rtw89_write16_set(rtwdev, R_RAC_DIRECT_OFFSET_G2 + RAC_ANA09 * RAC_MULT,
 			  BAC_OOBS_SEL);
 
+	/* offset K */
+	for (gen = 1; gen <= 2; gen++) {
+		phy_offset = gen == 1 ? R_RAC_DIRECT_OFFSET_G1 :
+					R_RAC_DIRECT_OFFSET_G2;
+
+		rtw89_write16_clr(rtwdev, phy_offset + RAC_ANA19 * RAC_MULT,
+				  B_PCIE_BIT_RD_SEL);
+	}
+
+	offset_cal = rtw89_read16_mask(rtwdev, R_RAC_DIRECT_OFFSET_G1 +
+					       RAC_ANA1F * RAC_MULT, OFFSET_CAL_MASK);
+
+	for (gen = 1; gen <= 2; gen++) {
+		phy_offset = gen == 1 ? R_RAC_DIRECT_OFFSET_G1 :
+					R_RAC_DIRECT_OFFSET_G2;
+
+		rtw89_write16_mask(rtwdev, phy_offset + RAC_ANA0B * RAC_MULT,
+				   MANUAL_LVL_MASK, offset_cal);
+		rtw89_write16_clr(rtwdev, phy_offset + RAC_ANA0D * RAC_MULT,
+				  OFFSET_CAL_MODE);
+	}
+
 out:
 	rtw89_write32(rtwdev, R_AX_PCIE_MIX_CFG_V1, backup_aspm);
 }
-- 
2.25.1


