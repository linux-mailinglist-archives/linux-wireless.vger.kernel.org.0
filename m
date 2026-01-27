Return-Path: <linux-wireless+bounces-31211-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ec5DrN8eGkFqQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31211-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:52:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540ED914C4
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C95E3002D3C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC0229B2A;
	Tue, 27 Jan 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TFAtASed"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F42D3A7B
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503917; cv=none; b=SuHH0InIxC2LHxSCkDIjDBm3Dsa8rBwXFk1WAEuGPuQPMZJ7U/3rqVD8bGYtrDvqF2swLv1DJHJxpY5Azxq/s6o2SaJwfTFmvvntAxytB1vpgkyNEkEV9eCgohiFRVCaaitg+oYB93lt5Y2Fexn46G85Jf78jmuUOSdEGgBN5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503917; c=relaxed/simple;
	bh=PcP+iVQMPzRjYc2l/vtjxZ8RWU+bD7Hg/VGZtQjcBUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuGlg1BmrOgx4jxfSbRTi0vaWAHCwcpbj+7yis7o08OWupVRoAl/W+Rp6wEkvDgtZvAJ5RyscaG7pWSKM4ZKX62FDGWZXSjzGhgGPSG4TAsNXWLKm531eN2Ng4M4k5/gz0n7dkdwy8RVe+fwplyj9WMdfp9acvM694cKfSfDoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TFAtASed; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60R8prRyB2655533, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769503913; bh=RlktVedcH88ElHQjPPVMgsjfPBgnGXNPis5nUS5ha5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TFAtASedPfzwwhj1K4Xm4MEQPTEHzmID+9QZ7YgPeGFtkZmZDpVNN4ymb8qKLMkI7
	 1lu1twREpY+eReGrEzT8vjnMFjb2m73iY4Z+EJurU/Jf9VvAY49HWcbpIWQk8NDA5e
	 a8HA5FldrVlEhiOaD2HGOaRxin+OR6biIiyZDAY5k7ZLGhtTmkq9+VkmZGmFTub+A6
	 qnrV1uMdC9RaH3P5rG+QYAX8BFeOdaqRd5G1MtjaLcYShOkb6wahquuBaRQ2vaVBH1
	 IBCvtQmep91XRJ8jShL5ZBo+sT3+0hMZe/9rWoCOaobo/RUSExBpJaYwlhulE2mfID
	 bgYqSOY6SJz6A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60R8prRyB2655533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:51:53 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 27 Jan 2026 16:51:53 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 27 Jan 2026 16:51:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 16:51:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 6/6] wifi: rtw89: pci: warn if SPS OCP happens for RTL8922DE
Date: Tue, 27 Jan 2026 16:50:36 +0800
Message-ID: <20260127085036.44060-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260127085036.44060-1-pkshih@realtek.com>
References: <20260127085036.44060-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31211-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 540ED914C4
X-Rspamd-Action: no action

SPS OCP (over current protection) is a mechanism to cut off power to
protect hardware. When this happens, raise an interrupt to signal driver,
which prints out a message to note hardware status.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/pci.h    |  1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 9f3445fa55a9..e5efc1c989ff 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -968,6 +968,9 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	if (unlikely(isrs.halt_c2h_isrs & isr_def->isr_wdt_timeout))
 		rtw89_ser_notify(rtwdev, MAC_AX_ERR_L2_ERR_WDT_TIMEOUT_INT);
 
+	if (unlikely(isrs.halt_c2h_isrs & isr_def->isr_sps_ocp))
+		rtw89_warn(rtwdev, "SPS OCP alarm 0x%x\n", isrs.halt_c2h_isrs);
+
 	if (unlikely(rtwpci->under_recovery))
 		goto enable_intr;
 
@@ -4003,7 +4006,8 @@ static void rtw89_pci_recovery_intr_mask_v3(struct rtw89_dev *rtwdev)
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 
 	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0;
-	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
+	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN |
+				 B_BE_SPSANA_OCP_INT_EN | B_BE_SPS_OCP_INT_EN;
 	rtwpci->intrs[0] = 0;
 	rtwpci->intrs[1] = 0;
 }
@@ -4013,7 +4017,8 @@ static void rtw89_pci_default_intr_mask_v3(struct rtw89_dev *rtwdev)
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 
 	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0;
-	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
+	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN |
+				 B_BE_SPSANA_OCP_INT_EN | B_BE_SPS_OCP_INT_EN;
 	rtwpci->intrs[0] = 0;
 	rtwpci->intrs[1] = B_BE_PCIE_RDU_CH1_IMR |
 			   B_BE_PCIE_RDU_CH0_IMR |
@@ -4655,6 +4660,7 @@ const struct rtw89_pci_isr_def rtw89_pci_isr_ax = {
 	.isr_rdu = B_AX_RDU_INT,
 	.isr_halt_c2h = B_AX_HALT_C2H_INT_EN,
 	.isr_wdt_timeout = B_AX_WDT_TIMEOUT_INT_EN,
+	.isr_sps_ocp = 0,
 	.isr_clear_rpq = {R_AX_PCIE_HISR00, B_AX_RPQDMA_INT | B_AX_RPQBD_FULL_INT},
 	.isr_clear_rxq = {R_AX_PCIE_HISR00, B_AX_RXP1DMA_INT | B_AX_RXDMA_INT |
 					    B_AX_RDU_INT},
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index b0081b694046..ccfa6d33623a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1331,6 +1331,7 @@ struct rtw89_pci_isr_def {
 	u32 isr_rdu;
 	u32 isr_halt_c2h;
 	u32 isr_wdt_timeout;
+	u32 isr_sps_ocp;
 	struct rtw89_reg2_def isr_clear_rpq;
 	struct rtw89_reg2_def isr_clear_rxq;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 33bdd3e66bf6..114f40c6c31b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -763,6 +763,7 @@ const struct rtw89_pci_isr_def rtw89_pci_isr_be = {
 	.isr_rdu = B_BE_RDU_CH1_INT_V1 | B_BE_RDU_CH0_INT_V1,
 	.isr_halt_c2h = B_BE_HALT_C2H_INT,
 	.isr_wdt_timeout = B_BE_WDT_TIMEOUT_INT,
+	.isr_sps_ocp = 0,
 	.isr_clear_rpq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RPQ0_ISR_V1},
 	.isr_clear_rxq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RX0P2_ISR_V1},
 };
@@ -772,6 +773,7 @@ const struct rtw89_pci_isr_def rtw89_pci_isr_be_v1 = {
 	.isr_rdu = B_BE_PCIE_RDU_CH1_INT | B_BE_PCIE_RDU_CH0_INT,
 	.isr_halt_c2h = B_BE_HALT_C2H_INT,
 	.isr_wdt_timeout = B_BE_WDT_TIMEOUT_INT,
+	.isr_sps_ocp = B_BE_SPS_OCP_INT | B_BE_SPSANA_OCP_INT,
 	.isr_clear_rpq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RPQ0_ISR_V1},
 	.isr_clear_rxq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RX0P2_ISR_V1},
 };
-- 
2.25.1


