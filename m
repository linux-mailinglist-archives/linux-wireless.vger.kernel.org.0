Return-Path: <linux-wireless+bounces-38157-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kQ4ELfdMPmrTCwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38157-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:57:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3316CBDF4
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:57:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=o5TdWrKL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38157-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38157-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88810303688F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341273EA953;
	Fri, 26 Jun 2026 09:57:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676B3E9C3C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 09:57:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467824; cv=none; b=O2+tXv34L5BGhRFBO+TDoh7NXmtPkFDTFwISVerykFFzKqHlBFh7yoWi5yALbbdszjfSAE6T6IJYxXJ2y2rHq0RFWcygsHtckXT0d9FadtpzEDLHz2tWzVlLesCM/YZHC2Lr9SIewOjIKnvYj/S4CTK//26LE3YPtFG0KVtkSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467824; c=relaxed/simple;
	bh=FeFNZCmtT+T/xrLBjl1uesmEU0VInlD8jZwriwm7Xas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBr6z66h4YX0rY4u6Szp/ORyuVtUigo+vJwla2XejM/c2OJeOpJe3AQf/tozEXI36I743ErDMOV1i1KIIdBy/xocohlJgrKt2bQbAYh3j9M2C1F92+N7JDm05LaS7Yn0spK5TVEw9xPKljaCX02kqWPtli3Q3tlxOL/BownoRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5TdWrKL; arc=none smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c0be5e548a4so100461166b.3
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782467821; x=1783072621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bZ1u6m7Vf6sIYA8BIUsz5HaLdKBAiYXcGxrCJ5307M=;
        b=o5TdWrKL6mcBZhh1a725Tyt4eyQJVAWenWFC6Edv6ZMaEgs//0cBcO5AVZznwao62w
         dhQus/uLM2jxm1kZ+GN+it2/+o7y9R2p5wo5zYxaH7jt27XLXEUBcJTkqFaoUceYVcN0
         zlDDT1IHcY1P8BzKO10VGAHME5ZssDAiodsXv6FiYvh4svLZ4eLN3HEea1JeQ400f/Vr
         vgALjpY2HEGGM8aGirgYXcrO8Y9DBc37935RX/Wov9JVMMZOHdfU5sd7S47FDbZU1AeP
         cqU3HaiX013vakK/ATCGZitmYNJFyuhyphP/57IoGUZfAJST+2kc6CdW6qu5vxw0/GfU
         HfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467821; x=1783072621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0bZ1u6m7Vf6sIYA8BIUsz5HaLdKBAiYXcGxrCJ5307M=;
        b=XLtYupJ6h0yqi2PGhvoMniPukuMpQeFcO9p8K8oSXOax8PFYmAFO2S4dD0Ak2fyTRl
         JPiUK7SWwDknQQKJxZ1PGe101HR5YZFXySV395rhyX74G11wBffonUlUEPOvIpCXAh3r
         ySZWwKH4lpQFqYF8DR/9FknIMoCYWQAyRyqglk+3DwofBoZsNH5WNEE0nu4XnCGG//D6
         0EX3JhJ0vTpmR1Njz0QF93ti/mjudPH8V2XVcCA5o3zD3wi8y+fLFB8012znmVKqUkaX
         ++eEWLe2Cy0FS6ZyntKs2lTXfTs1V/oYKvgond2ZcICShMwkvlEym2Md72ktVObQKTd6
         KO1w==
X-Gm-Message-State: AOJu0YwqXc7vw0v9NUAakrAD7181akuopRzo8tt2xzhH/kJGDW7vrKHx
	T5xX6MhyeSWBy5RoBB5nFQkr75TyRf0zADKgIQwSuJ7M9CdPaxK85lKV
X-Gm-Gg: AfdE7cklqXRNy2MQX2rdKDKbxO0G2E4N6kiC86E435eFYrIqncjmgvhwbCB3/l7GPpa
	UH14Ep1lyZwfhXm33qp1NpEYcL+zvT0b95u7l4/jvjsnDDtcJASlMK9bJsvn/i07OM2yxZjdVQ0
	5ZPyZ94QZEvIpVCyH5PBN9yPs/ysswY776e1j2+A9LJmYJsSxM4oD9ABz/V3NBisvjXImSx34iO
	Siz44bYc3qACTopNWaU4K7Nao6n2ltLT1iTuGNWcrNGjk8/dZHDvriwWPAy/3HVHSsqvReBSX33
	RyI1eAkGLPtBrLDaZ51dFkAlw8yCF1Ahd2N8CsQaXrbsX2qG4EM3bfxz8e+9M9dryuA+u01cBzS
	62m81+nyZNmlOzpIzWwYE4qyNJjZeAQQONjho05/8l3FZ20mFmbMt4uufCJ+02LtHsOg5sGjdA5
	pDVJpiz3Bo+9u4hGIm1MtbX+k=
X-Received: by 2002:a17:907:1c93:b0:c0e:4007:8d9a with SMTP id a640c23a62f3a-c1205d8f6c7mr472178266b.2.1782467820820;
        Fri, 26 Jun 2026 02:57:00 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05ed6sm301555066b.30.2026.06.26.02.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:56:59 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v3 2/3] wifi: rtlwifi: convert pci if-statement to ID table
Date: Fri, 26 Jun 2026 11:56:47 +0200
Message-ID: <20260626095648.1124924-3-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
References: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38157-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E3316CBDF4

Refactor the ASUSTek quirk logic from an if-statement to a standard
rtl_aspm_quirks pci_device_id table. This allows future devices with
the same quirk to be added more easily while avoiding a large if-chain.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 38eca8d91581..44121203671c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -31,6 +31,12 @@ static const u8 ac_to_hwq[] = {
 	BK_QUEUE
 };
 
+static const struct pci_device_id rtl_aspm_quirks[] = {
+	/* ASUSTek F441U/X555UQ */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x11ad, 0x1723) },
+	{ }
+};
+
 static u8 _rtl_mac_to_hwqueue(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
@@ -330,19 +336,15 @@ static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
 {
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	_rtl_pci_update_default_setting(hw);
 
 	/* 
-	 * RTL8723BE found on some ASUSTek laptops, such as F441U and
-	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	 * Certain pci devices are known to output large
 	 * amounts of PCIe AER errors during and after boot up, causing
 	 * heavy lags, poor network throughput, and occasional lock-ups.
 	 */
-	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
-	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
-	     rtlpci->pdev->subsystem_device == 0x1723)) {
+	if (pci_match_id(rtl_aspm_quirks, rtlpci->pdev)) {
 		__rtl_pci_disable_aspm(hw);
 		ppsc->support_aspm = false;
 	}
-- 
2.54.0


