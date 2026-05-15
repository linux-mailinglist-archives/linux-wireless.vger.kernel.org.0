Return-Path: <linux-wireless+bounces-36445-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK1yI696BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36445-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37144548818
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A209B30087E3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9B1FDE31;
	Fri, 15 May 2026 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XAHrPiWV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D1235C01
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809516; cv=none; b=McM09C+jePA5kxDW2yEtneAglsPazNFmbX/iOJGVDkxZCgG9b7qTJE7mld9tZbTnXVK6lZrifX+gq2tB8F8n+7Ri/Gaxmb/1a7O95G6jPsMQ4s+CJXkMo3GFOU/R5vCKXLPADo1jNkRK4GCd8Bl/MpN14d1OXQ4EBh2SELkbkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809516; c=relaxed/simple;
	bh=QLv+Qzj0Tq3NwatD3iCacIE40Cy34q8obwC9453qDZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgnXcLe5WdpRKOlUKXzaf4wF+dwqBhjsNQhixR75PCK4csPiQkdDAwt6o2Ml+8L3rQ8TEM4lasvGc5WVEI+VUnTJYVJfBTo6q2jsJBsX6rzurhXv0/yjKC8oqRmsNPNSlUrcHTKXzrDM1CnGQN7NA4nWnOAv5VThnz1h25SH9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XAHrPiWV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1jDU312587167, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809513; bh=c11AMY8xZpWQ+eahwIzn1EL5UgoiraME13xLLCrKa4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XAHrPiWVOHyeyiRysJf48WhT/CmzW47nHfX99TujAWfwFXa4cdPrn4PDQVDVt3Ei1
	 MSa/kF9WdjawYkCchA/hkNn7mebSPRQxPRD0Trxv/cBC45eLqQgIUAlHEZdyJgyYHa
	 lh/HAbaq19haDTICgapu86n/KDII4PqXGzhLIPmQbjdGvspo7dtl4QbLnb4lJn/Rdj
	 mnXYpFV5LA+a5bkpO2B4Cl4jsGWTzU6rg2z1Pf4ViaM478XN+QZ36fuAbp40IJFk3W
	 MiBIllmtQESMHD+qIuPDqV+h5vmVgIfbk9hzU97bxHA8PDBpAeLPxwrK91rUXNdyXz
	 SXkue2CdvMolA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1jDU312587167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:13 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/13] wifi: rtw89: pci: disable PCI PHY error flag 8
Date: Fri, 15 May 2026 09:44:26 +0800
Message-ID: <20260515014433.16168-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 37144548818
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36445-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

As the PHY error flag 8 works improperly, disable it to prevent false
alarm causing SER.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h    | 4 +++-
 drivers/net/wireless/realtek/rtw89/pci_be.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index d0d1e2b99698..c3f2d0df5846 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -58,7 +58,7 @@
 #define B_AX_DIV			GENMASK(15, 14)
 #define RAC_SET_PPR_V1			0x31
 #define RAC_ANA40			0x40
-#define PHY_ERR_IMR_DIS			(BIT(9) | BIT(0))
+#define PHY_ERR_IMR_DIS			(BIT(9) | BIT(8) | BIT(0))
 #define RAC_ANA41			0x41
 #define PHY_ERR_FLAG_EN		        BIT(6)
 
@@ -963,6 +963,8 @@
 #define R_BE_PCIE_HRPWM 0x30C0
 #define R_BE_PCIE_CRPWM 0x30C4
 
+#define R_BE_PCIE_HCI2FW_ISR 0x30CC
+
 #define R_BE_L1_2_CTRL_HCILDO 0x3110
 #define B_BE_PM_CLKREQ_EXT_RB BIT(11)
 #define B_BE_PCIE_DIS_RTK_PRST_N_L1_2 BIT(10)
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 473d491eb3f4..6390980b8ee0 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -347,6 +347,7 @@ static void rtw89_pci_pcie_setting_be(struct rtw89_dev *rtwdev)
 
 	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_R_SYM_PRST_CPHY_RST);
 	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_USUS_OFFCAPC_EN);
+	rtw89_write32(rtwdev, R_BE_PCIE_HCI2FW_ISR, 0xFFFFFFFF);
 }
 
 static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
@@ -843,6 +844,8 @@ static int __maybe_unused rtw89_pci_resume_be(struct device *dev)
 			rtw89_write16_set(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
 						  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
 		}
+
+		rtw89_write32(rtwdev, R_BE_PCIE_HCI2FW_ISR, 0xFFFFFFFF);
 	}
 
 	rtw89_pci_basic_cfg(rtwdev, true);
-- 
2.25.1


