Return-Path: <linux-wireless+bounces-19733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06DCA4D0B0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 02:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1767A05D4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E839C2D1;
	Tue,  4 Mar 2025 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="gRRi2PDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BF33D8
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051344; cv=none; b=H0HO1/xQtA28e99/WYnq6CJbQP8or96bIGBe2lIe4bdHgYY2s+ujFA/QlSeZ4dml6/5emUAXmPRS+aoFLEfZCbdKb97S6kcoG53LqLp7aV6IU9X7DWWVyixZdjRBM3yCfB4jGThnle0UEOQL2VUgSNiouWg6Uk4E/V1bAQ7hLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051344; c=relaxed/simple;
	bh=mLhj81vlIEwFWncn3e9o4Uci5lS9oGNLWnya803hnSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlhnbE5Aaxc9DeM51Jq5nb23j/qmx7k2KMNri5eZk4Z2CpCIuuLsBB4K83OqfCeH4He7kCuqNG9v2QA4r+KZymfrsVML+6xYHkraE1K/f88ILtEcRHXabS8kl20zYiXudN6qR1slsIoy0T0Ll1s3cG049siodPI12UDMU/hCXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=gRRi2PDw; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:40640 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1tpGzC-000000007vD-24Db
	for linux-wireless@vger.kernel.org;
	Tue, 04 Mar 2025 02:22:19 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
	BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
	CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
	HTML_00_01 0.050000, HTML_00_10 0.050000, IN_REP_TO 0.000000,
	LEGITIMATE_SIGNS 0.000000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_REAL_NAME 0.000000,
	NO_URI_HTTPS 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	REFERENCES 0.000000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000,
	__CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CTE 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FROM_DOMAIN_IN_ANY_CC1 0.000000,
	__FROM_DOMAIN_IN_RCPT 0.000000, __FROM_NAME_NOT_IN_ADDR 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HAS_X_MAILER 0.000000,
	__IN_REP_TO 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
	__MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_SUBJ_TEAM 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SUBJ_ALPHA_END 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
	__URI_NO_WWW 0.000000, __URI_NS 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 7%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2025.3.4.2728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=9sxp9U+dzW7OeUOHNwxhZq8nfGGENFrrlflsGmnQzVU=;
	b=gRRi2PDw5usLuI+tXtVR71PqRNqNvcXTvj8B/B1EfbCAq5S4ltSZlBD/iHl5IkFdJLyWpCQNHp2crDYADF+cvCKoyS+SeN/2HQxXJ0+KwZJC4WGR/eE73xA39raeEODLz3inxJltLO0TladNcVXxQM7NRIQUlSBTDWptrUKHajI=;
From: s.gottschall@dd-wrt.com
To: linux-wireless@vger.kernel.org
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: [PATCH 1/1] wil6210: fix support for sparrow chipsets
Date: Tue,  4 Mar 2025 08:21:31 +0700
Message-Id: <20250304012131.25970-2-s.gottschall@dd-wrt.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250304012131.25970-1-s.gottschall@dd-wrt.com>
References: <20250304012131.25970-1-s.gottschall@dd-wrt.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1tpGys-000C4T-K3
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1tpGys-000C4T-K3; Tue, 04 Mar 2025 02:21:58 +0100

From: Sebastian Gottschall <s.gottschall@dd-wrt.com>

the wil6210 driver irq handling code is unconditionally writing
edma irq registers which are supposed to be only used on Talyn chipsets.
This however leade to a chipset hang on the older sparrow chipset
generation and firmware will not even boot.
Fix that by simply checking for edma support before handling these
registers.

Tested on Netgear R9000

Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
---
 drivers/net/wireless/ath/wil6210/interrupt.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index 67172385a5d6..89d4394cedcf 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -179,9 +179,11 @@ void wil_mask_irq(struct wil6210_priv *wil)
 	wil_dbg_irq(wil, "mask_irq\n");
 
 	wil6210_mask_irq_tx(wil);
-	wil6210_mask_irq_tx_edma(wil);
+	if (wil->use_enhanced_dma_hw)
+		wil6210_mask_irq_tx_edma(wil);
 	wil6210_mask_irq_rx(wil);
-	wil6210_mask_irq_rx_edma(wil);
+	if (wil->use_enhanced_dma_hw)
+		wil6210_mask_irq_rx_edma(wil);
 	wil6210_mask_irq_misc(wil, true);
 	wil6210_mask_irq_pseudo(wil);
 }
@@ -190,10 +192,12 @@ void wil_unmask_irq(struct wil6210_priv *wil)
 {
 	wil_dbg_irq(wil, "unmask_irq\n");
 
-	wil_w(wil, RGF_DMA_EP_RX_ICR + offsetof(struct RGF_ICR, ICC),
-	      WIL_ICR_ICC_VALUE);
-	wil_w(wil, RGF_DMA_EP_TX_ICR + offsetof(struct RGF_ICR, ICC),
-	      WIL_ICR_ICC_VALUE);
+	if (wil->use_enhanced_dma_hw) {
+		wil_w(wil, RGF_DMA_EP_RX_ICR + offsetof(struct RGF_ICR, ICC),
+		      WIL_ICR_ICC_VALUE);
+		wil_w(wil, RGF_DMA_EP_TX_ICR + offsetof(struct RGF_ICR, ICC),
+		      WIL_ICR_ICC_VALUE);
+	}
 	wil_w(wil, RGF_DMA_EP_MISC_ICR + offsetof(struct RGF_ICR, ICC),
 	      WIL_ICR_ICC_MISC_VALUE);
 	wil_w(wil, RGF_INT_GEN_TX_ICR + offsetof(struct RGF_ICR, ICC),
@@ -845,10 +849,12 @@ void wil6210_clear_irq(struct wil6210_priv *wil)
 		    offsetof(struct RGF_ICR, ICR));
 	wil_clear32(wil->csr + HOSTADDR(RGF_DMA_EP_TX_ICR) +
 		    offsetof(struct RGF_ICR, ICR));
-	wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_RX_ICR) +
-		    offsetof(struct RGF_ICR, ICR));
-	wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_TX_ICR) +
-		    offsetof(struct RGF_ICR, ICR));
+	if (wil->use_enhanced_dma_hw) {
+		wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_RX_ICR) +
+			    offsetof(struct RGF_ICR, ICR));
+		wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_TX_ICR) +
+			    offsetof(struct RGF_ICR, ICR));
+	}
 	wil_clear32(wil->csr + HOSTADDR(RGF_DMA_EP_MISC_ICR) +
 		    offsetof(struct RGF_ICR, ICR));
 	wmb(); /* make sure write completed */
-- 
2.35.3


