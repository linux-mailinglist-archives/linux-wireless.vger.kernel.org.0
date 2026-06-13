Return-Path: <linux-wireless+bounces-37768-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w7ZbM9/cLWrFlgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37768-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB567FF19
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37768-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37768-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AD21300D457
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28EE223DCE;
	Sat, 13 Jun 2026 22:42:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC9342509
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:42:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390557; cv=none; b=RvaCVoIsLC/tR8wOi75HccfB8obvXhZ5Pn6RT6G+U8oFqSDJ/YcQlm98JSzQ4u4tpnnSPC3KDGs7OCSBuNF3asnzpSsNZfOb7Um+hWm/ht7xlZLcfkAHlwX7bwnYeOWiTBu+EgemiWwhk+2SeVSPA5k2/mqs9MaqoePUeYqj+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390557; c=relaxed/simple;
	bh=nvZH3lgarO/c/ai4/m2742JXh4z+qUaWwij0cqvN62w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfjCuUvtd0t1aOjHu9tjPh/IUA74TIHOM8nDZyx/yCiuQvwHD4tvyI6Nl9RnGEe0OvraMK37+5VG7prV7zvY73Ce524tJgF7UD3mOpie+2PRYKzmXuA9t/qP5WBSqiLmX6L+Vlb3cDWlcB/ipjLMfIbyWMOc3fzq/d0Lzq7R7+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.172
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso4688402eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390556; x=1781995356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JzYLemSnfpa43nsfLDikr6xBCtsyqtawVe9WOQngZw=;
        b=Tp0HiafiZKYh+74jDFce0nA9o78iV2Bzg+t0QeAp5cwsN6FPnh9zcXoLLAFzPHXSAu
         btXZwFauRc+uwFJaCz76KtQEOCiwpKI6VrF/14rIIX7xocevDiyvDxsuhPmeN0JfouaL
         j5RsK27hQbgYlH2oDYbxHxhEaTYBPGgE/2Mpn20cBch2xXFjykmmLwio4eFKxWuZXHhG
         sRsk5mLi3yIBr0U/PYBlvxTlfEk7QrYB1DYg2OMqjAhG3Le35dov/St2hcddNqcZQUez
         9KOVpQXvQC7A6f4rKcI1d7BlOLUWsNft0geSRW81NcXToHVU2d+V7diUad7KPMO4z1Uo
         c/JQ==
X-Gm-Message-State: AOJu0Yy6qNLtIbkZlPWTfnhcGn4oTTkPysP5WWET5SptsmTN4KiBkfU9
	DTdinQXdGQxg3NWaI8YPnlx2lKHozjgQa7hgLyfaNFsIkifrr9E7ZL4H
X-Gm-Gg: Acq92OGvKqPZLLgtDW9O5EI8HVdrBlUAtyUCr1ubiOtryAwMhUmT6G8j0xP7kCnmU92
	+5wceRcjTdieeQn3dlpl4sUEiAscc6JOYjlRooc5RR01lZoIo5wKo4yOIkoik9+oAjwP1z7afe4
	x++Kf2s8GeSfmX+0uC+E70/kTcLJ/siZBRjM6jSIhStdx6yB8fGeg1r7KEfP1rJhDZPV9scMvFU
	/ksA+yNnx25XSC2NSO2/z7adF+oWNGPJTba/2OfvLtpA4kjm4wlpZWaykuY7vhUJ/d/TSqanHRi
	YB9KW7UeX9cg+HnfQdzhp3ScDuz8l4usPPrMlLXRdvwqbc7D/L4LBU/5zu3weK/AVTxtbfOwSKp
	GWI6FGQ1+mgss99+v7JlcCM7l/yoeZUoiYm0hWVzAnLoi07NWpDmuTWem9VpWGOnA+ckaDlbV2y
	UsUZcLCQAD3rmAvLTMcMm8ZN6+Q2Zwhie+Ag8GEuYO8hgLEF5Fc6Yt2UM8PoKUN6czQuxAhTxrl
	Hcec6n+3/8n0CuJUzkRDVGbfoc+R5fs8lnCGijn
X-Received: by 2002:a05:693c:65d1:b0:30a:e52f:9bcf with SMTP id 5a478bee46e88-30ae52fa5d4mr1028861eec.10.1781390555746;
        Sat, 13 Jun 2026 15:42:35 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm11104825eec.28.2026.06.13.15.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:42:35 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4/6] wifi: mt76: mt792x: drain USB UDMA before WFSYS reset
Date: Sat, 13 Jun 2026 17:41:29 -0500
Message-ID: <20260613224131.2396026-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613224131.2396026-1-sean.wang@kernel.org>
References: <20260613224131.2396026-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37768-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67DB567FF19

From: Sean Wang <sean.wang@mediatek.com>

Stop USB UDMA RX/TX and wait for idle before WFSYS reset.
Warn if the engine remains busy.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index d86b0918c2f8..43191a8a9ea4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -11,6 +11,8 @@
 #include "mt792x.h"
 #include "mt76_connac2_mac.h"
 
+#define MT792X_USB_UDMA_IDLE_TIMEOUT	1000
+
 static int mt792xu_read32(struct mt76_dev *dev, u32 addr, void *buf)
 {
 	return __mt76u_vendor_request(dev, MT_VEND_READ_EXT,
@@ -339,6 +341,23 @@ static void mt792xu_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
 	mt792xu_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
 }
 
+static void mt792xu_wait_udma_idle(struct mt792x_dev *dev)
+{
+	u32 mask = MT_WL_RX_BUSY | MT_WL_TX_BUSY;
+	u32 val;
+
+	mt76_set(dev, MT_UDMA_WLCFG_0, MT_WL_RX_FLUSH);
+
+	if (mt76_poll_msec(dev, MT_UDMA_WLCFG_0, mask, 0,
+			   MT792X_USB_UDMA_IDLE_TIMEOUT))
+		return;
+
+	val = mt76_rr(dev, MT_UDMA_WLCFG_0);
+
+	dev_warn(dev->mt76.dev,
+		 "UDMA busy before WFSYS reset: WLCFG0=0x%08x\n", val);
+}
+
 struct mt792xu_wfsys_desc {
 	u32 rst_reg;
 	u32 done_reg;
@@ -405,6 +424,7 @@ int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 	if (atomic_read(&dev->mt76.bus_hung))
 		return -EIO;
 
+	mt792xu_wait_udma_idle(dev);
 	mt792xu_epctl_rst_opt(dev, false);
 
 	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
-- 
2.43.0


