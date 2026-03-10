Return-Path: <linux-wireless+bounces-32811-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FjWOgPQr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32811-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:02:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D66246DAD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A5393028EBF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56E3ECBF7;
	Tue, 10 Mar 2026 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UCmoZQM/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042428640C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129728; cv=none; b=nmBG2J7g3DqcM6ngxP0dxv6N5pq935ziYZd7pDxYFQtnPxOLwNQc95Wv+YIFV+BQpgHlRswJhGJSUQSIDeJzKzzCZJqjIIdwlfTfCX5gHvuqcG0daWWs8yLPITapMUtg8CUzMc9EFzwOV6fxvNnJeJoYzB/UVjbHmZy1mCsmjds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129728; c=relaxed/simple;
	bh=vWVg89ZfClvK3G/7Maui1NTcuvZ/KRRZwdAcwK8Z8QE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVIKBfWwdtPHX+8tqJ0h54O7C/VY4tJdfNGPLZffuSVcM9m2RG7pHNlVw4rv0byhfMJ3GBBeGFM8PzmNWEoGl4TB0rCcGtTxKQYN+qYdN4qB0k0L2LHSg810VDZ8C60/E7VGYA9t479nZO11+muDSdprj7n9bCBd2jHVQgAKEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UCmoZQM/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A825XD02208423, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129725; bh=9R0F5Ze6GioNgU36TTJIApR/pAMYth5dTs3CJAjsdp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UCmoZQM/jrW+HGZSak5x2LhKUGGmwp1OU0MynGNjHnnoaH94OwgGbI5tRmzL6EkLj
	 lm2uyaW6BMHmURC9kig/FDPUe1PG2WkYm5PZM3wX+Nj9KBCet3jcKjxoqVAWQTBCGK
	 bt/dHgzhACJSW2EdXxeBNxTcjIT2AEHuaKd2Lvy1CNpZ5ep6byyzdWFdDeYMSKKcxi
	 1mqgmWRxPFNMWni7GTCsfLAkNatdsb7L8GQF3WAgbDoUHbHFGoHU2vtfo1Y0MQPKC1
	 HLfZUNeY6U9xA45t9sKBrLm3nL4ca5lsOr2pdOJGqqWI99znD8dkQkN5pAFJkqgKqg
	 nsW9KuMlU9hGg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A825XD02208423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/13] wifi: rtw89: pci: update SER parameters for suspend/resume
Date: Tue, 10 Mar 2026 16:01:35 +0800
Message-ID: <20260310080146.31113-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 32D66246DAD
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32811-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

In suspend mode, SER timer unit is different from normal mode. Set proper
value to prevent expected SER happened during suspend.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h    |  1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c | 52 +++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index ccfa6d33623a..dc488d9a8884 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1016,6 +1016,7 @@
 #define B_BE_PL1_IGNORE_HOT_RST BIT(30)
 #define B_BE_PL1_TIMER_UNIT_MASK GENMASK(19, 17)
 #define PCIE_SER_TIMER_UNIT 0x2
+#define PCIE_SER_WOW_TIMER_UNIT 0x4
 #define B_BE_PL1_TIMER_CLEAR BIT(0)
 
 #define R_BE_REG_PL1_MASK 0x34B0
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 114f40c6c31b..dea01d9e57fd 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -721,12 +721,24 @@ static int __maybe_unused rtw89_pci_suspend_be(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
 	struct rtw89_dev *rtwdev = hw->priv;
+	u32 val32;
 
 	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
 	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
 	rtw89_write32_set(rtwdev, R_BE_PCIE_FRZ_CLK, B_BE_PCIE_FRZ_REG_RST);
-	rtw89_write32_clr(rtwdev, R_BE_REG_PL1_MASK, B_BE_SER_PM_MASTER_IMR);
+
+	val32 = rtw89_read32(rtwdev, R_BE_SER_PL1_CTRL);
+	if (val32 & B_BE_PL1_SER_PL1_EN) {
+		val32 = u32_replace_bits(val32, PCIE_SER_WOW_TIMER_UNIT,
+					 B_BE_PL1_TIMER_UNIT_MASK);
+		rtw89_write32(rtwdev, R_BE_SER_PL1_CTRL, val32);
+
+		if (rtwdev->chip->chip_id == RTL8922A)
+			rtw89_write32_clr(rtwdev, R_BE_REG_PL1_MASK,
+					  B_BE_SER_PM_MASTER_IMR);
+	}
+
 	return 0;
 }
 
@@ -735,12 +747,19 @@ static int __maybe_unused rtw89_pci_resume_be(struct device *dev)
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
 	struct rtw89_dev *rtwdev = hw->priv;
 	u32 polling;
+	u32 val32;
+	u16 val16;
 	int ret;
 
 	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
 	rtw89_write32_clr(rtwdev, R_BE_RSV_CTRL, B_BE_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
 	rtw89_write32_clr(rtwdev, R_BE_PCIE_FRZ_CLK, B_BE_PCIE_FRZ_REG_RST);
+
+	val32 = rtw89_read32(rtwdev, R_BE_SER_PL1_CTRL);
+	if (!(val32 & B_BE_PL1_SER_PL1_EN))
+		goto clear_phy_isr;
+
 	rtw89_write32_clr(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
 
 	ret = read_poll_timeout_atomic(rtw89_read32, polling, !polling, 1, 1000,
@@ -748,8 +767,35 @@ static int __maybe_unused rtw89_pci_resume_be(struct device *dev)
 	if (ret)
 		rtw89_warn(rtwdev, "[ERR] PCIE SER clear polling fail\n");
 
-	rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
-	rtw89_write32_set(rtwdev, R_BE_REG_PL1_MASK, B_BE_SER_PM_MASTER_IMR);
+	if (rtwdev->chip->chip_id == RTL8922A)
+		rtw89_write32_set(rtwdev, R_BE_REG_PL1_MASK,
+				  B_BE_SER_PM_MASTER_IMR | B_BE_SER_PCLKREQ_ACK_MASK);
+
+	val32 = rtw89_read32(rtwdev, R_BE_SER_PL1_CTRL);
+	val32 = u32_replace_bits(val32, PCIE_SER_TIMER_UNIT, B_BE_PL1_TIMER_UNIT_MASK);
+	val32 |= B_BE_PL1_SER_PL1_EN;
+	rtw89_write32(rtwdev, R_BE_SER_PL1_CTRL, val32);
+
+clear_phy_isr:
+	if (rtwdev->chip->chip_id == RTL8922D) {
+		val16 = rtw89_read16(rtwdev, RAC_DIRECT_OFFESET_L0_G2 +
+					     RAC_ANA41 * RAC_MULT);
+		if (val16 & PHY_ERR_FLAG_EN) {
+			rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G2 +
+						  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+			rtw89_write16_set(rtwdev, RAC_DIRECT_OFFESET_L0_G2 +
+						  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+		}
+
+		val16 = rtw89_read16(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
+					     RAC_ANA41 * RAC_MULT);
+		if (val16 & PHY_ERR_FLAG_EN) {
+			rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
+						  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+			rtw89_write16_set(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
+						  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+		}
+	}
 
 	rtw89_pci_basic_cfg(rtwdev, true);
 
-- 
2.25.1


