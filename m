Return-Path: <linux-wireless+bounces-33812-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEFpIHGNw2lVrgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33812-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:23:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439DF320A51
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59788305A0FF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A683644D1;
	Wed, 25 Mar 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LEXx1aUi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1579366562
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423341; cv=none; b=bLeRySK/bnjIfRSh3UYkSOWT2buDaECLUgGq0XbLsgwornSEX0L6d+uBLwWe/FbfO8ijrferv2xQm2e50zCdccHkw7Y7patkfV1r5/xc/gzVeCwnbWfIsZHYbHKnVVzdbbEHhQByv+y5cUNpu4Ryi4ktKFAHTcFM/8M2k3HfMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423341; c=relaxed/simple;
	bh=a05MCZ2ps/HeVFYh+m2FbVwOLy7CBufYpDjcQrSiDz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4x5TiQZxsXtsueOmxZ6VQXMAmY3K+HdUcz77868FccvZKQHHGWGKn8RiEotDWDqXtp6q7Nl0iY988F8Q5YH59z3ZoAD8C7UfDhhc2/3+qD7+G+lpqjD8Bhk/SZu8JPH+s9Y7s6YbO6mDvlEAF6TVuqQtoQbsseyV2TNbTeQYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LEXx1aUi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P7MGKT02939442, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774423336; bh=c/UQUnOBf7QQokU9v7FiX2nCTLK2sguUJfRVZOSoonM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LEXx1aUi1Mwqf46sfvIrRyw0dDznkXNExedYHvkdvOFCt+sGnq4ynF1cQ4Mkh7X0J
	 bJL3jB7wQpMPNVqzTQLuQilUx+af5ZGh7lWcHbfKEoYs2+KJGxY08CZXS3U3X7piJk
	 aXU8Baemq74ouj7DAtSaTyEdGKHhgUDBPls016ps/nWeBYn0BmAiYDQagfvYmI9eGO
	 7dPBiGGUvOoHIfTH9LrW5qmvAyCxutPtTyQ5eKxIsiz6i5OYU8f5u7pZQaoBhdCtN7
	 yNcdAOtRYHYgdcohU6+Fff4nHPXHDYoGbZ7+ofauNxp6u29gJlyEn3SpzPGExgPFZu
	 L+XXYXrphpscQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62P7MGKT02939442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:22:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:17 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:16 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Mar 2026 15:22:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/8] wifi: rtw89: pci: clear SER ISR when initial and leaving WoWLAN for WiFi 7 chips
Date: Wed, 25 Mar 2026 15:21:25 +0800
Message-ID: <20260325072130.41751-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325072130.41751-1-pkshih@realtek.com>
References: <20260325072130.41751-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33812-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 439DF320A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PCIE SER is to diagnose PCIE becomes abnormal, relying on IMR settings
to trigger interrupt when status is weird. Update settings to disable
PHY error flag 9, and clear ISR when initial and leaving WoWLAN.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h    |  3 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 52 +++++++++++++++++----
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index dc488d9a8884..c7cd34e99349 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -55,6 +55,8 @@
 #define B_AX_CALIB_EN			BIT(13)
 #define B_AX_DIV			GENMASK(15, 14)
 #define RAC_SET_PPR_V1			0x31
+#define RAC_ANA40			0x40
+#define PHY_ERR_IMR_DIS			(BIT(9) | BIT(0))
 #define RAC_ANA41			0x41
 #define PHY_ERR_FLAG_EN		        BIT(6)
 
@@ -1029,6 +1031,7 @@
 #define B_BE_SER_PMU_IMR BIT(0)
 
 #define R_BE_REG_PL1_ISR 0x34B4
+#define B_PCIE_SER_ALL_ISR 0x7F
 
 #define R_BE_RX_APPEND_MODE 0x8920
 #define B_BE_APPEND_OFFSET_MASK GENMASK(23, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index dea01d9e57fd..dfffec1ff3c7 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -351,14 +351,41 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 		return;
 
 	rtw89_write32(rtwdev, R_BE_PL1_DBG_INFO, 0x0);
-	rtw89_write32_set(rtwdev, R_BE_FWS1IMR, B_BE_PCIE_SER_TIMEOUT_INDIC_EN);
-	rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
-	rtw89_write32_mask(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_TIMER_UNIT_MASK, 1);
 
-	val32 = rtw89_read32(rtwdev, R_BE_REG_PL1_MASK);
-	val32 |= B_BE_SER_PMU_IMR | B_BE_SER_L1SUB_IMR | B_BE_SER_PM_MASTER_IMR |
-		 B_BE_SER_LTSSM_IMR | B_BE_SER_PM_CLK_MASK | B_BE_SER_PCLKREQ_ACK_MASK;
-	rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
+	switch (hal->cv) {
+	case CHIP_CAV:
+	case CHIP_CBV:
+		rtw89_write32_clr(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+		rtw89_write32_mask(rtwdev, R_BE_SER_PL1_CTRL,
+				   B_BE_PL1_TIMER_UNIT_MASK, PCIE_SER_TIMER_UNIT);
+
+		val32 = rtw89_read32(rtwdev, R_BE_REG_PL1_MASK);
+		val32 &= ~(B_BE_SER_PMU_IMR | B_BE_SER_L1SUB_IMR |
+			   B_BE_SER_PM_MASTER_IMR | B_BE_SER_LTSSM_IMR |
+			   B_BE_SER_PM_CLK_MASK | B_BE_SER_PCLKREQ_ACK_MASK);
+		rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
+		break;
+	case CHIP_CCV:
+	default:
+		rtw89_write32_clr(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+
+		ret = read_poll_timeout_atomic(rtw89_read32, val32, !val32,
+					       1, 1000, false, rtwdev, R_BE_REG_PL1_ISR);
+		if (ret)
+			rtw89_warn(rtwdev, "[ERR] PCIE SER clear poll fail\n");
+
+		rtw89_write32_mask(rtwdev, R_BE_SER_PL1_CTRL,
+				   B_BE_PL1_TIMER_UNIT_MASK, PCIE_SER_TIMER_UNIT);
+		rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+
+		val32 = rtw89_read32(rtwdev, R_BE_REG_PL1_MASK);
+		val32 |= (B_BE_SER_PMU_IMR | B_BE_SER_PM_MASTER_IMR |
+			  B_BE_SER_LTSSM_IMR | B_BE_SER_PM_CLK_MASK |
+			  B_BE_SER_PCLKREQ_ACK_MASK);
+		val32 &= ~B_BE_SER_L1SUB_IMR;
+		rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
+		break;
+	}
 
 	return;
 
@@ -366,6 +393,11 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 	rtw89_write32_clr(rtwdev, R_BE_PCIE_SER_DBG, B_BE_PCIE_SER_FLUSH_RSTB);
 	rtw89_write32_set(rtwdev, R_BE_PCIE_SER_DBG, B_BE_PCIE_SER_FLUSH_RSTB);
 
+	rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
+				  RAC_ANA40 * RAC_MULT, PHY_ERR_IMR_DIS);
+	rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G2 +
+				  RAC_ANA40 * RAC_MULT, PHY_ERR_IMR_DIS);
+
 	rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
 				  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
 	rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G2 +
@@ -378,6 +410,7 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 	val32 = rtw89_read32(rtwdev, R_BE_SER_PL1_CTRL);
 	val32 &= ~B_BE_PL1_SER_PL1_EN;
 	rtw89_write32(rtwdev, R_BE_SER_PL1_CTRL, val32);
+	rtw89_write32(rtwdev, R_BE_REG_PL1_ISR, B_PCIE_SER_ALL_ISR);
 
 	ret = read_poll_timeout_atomic(rtw89_read32, val32, !val32,
 				       1, 1000, false, rtwdev, R_BE_REG_PL1_ISR);
@@ -385,9 +418,10 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 		rtw89_warn(rtwdev, "[ERR] PCIE SER clear poll fail\n");
 
 	val32 = rtw89_read32(rtwdev, R_BE_REG_PL1_MASK);
-	val32 |= B_BE_SER_PMU_IMR | B_BE_SER_L1SUB_IMR | B_BE_SER_PM_MASTER_IMR |
+	val32 |= B_BE_SER_PMU_IMR | B_BE_SER_PM_MASTER_IMR |
 		 B_BE_SER_LTSSM_IMR | B_BE_SER_PM_CLK_MASK | B_BE_SER_PCLKREQ_ACK_MASK |
 		 B_BE_SER_LTSSM_UNSTABLE_MASK;
+	val32 &= ~B_BE_SER_L1SUB_IMR;
 	rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
 
 	rtw89_write32_mask(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_TIMER_UNIT_MASK,
@@ -761,6 +795,8 @@ static int __maybe_unused rtw89_pci_resume_be(struct device *dev)
 		goto clear_phy_isr;
 
 	rtw89_write32_clr(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+	if (rtwdev->chip->chip_id == RTL8922D)
+		rtw89_write32(rtwdev, R_BE_REG_PL1_ISR, B_PCIE_SER_ALL_ISR);
 
 	ret = read_poll_timeout_atomic(rtw89_read32, polling, !polling, 1, 1000,
 				       false, rtwdev, R_BE_REG_PL1_ISR);
-- 
2.25.1


