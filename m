Return-Path: <linux-wireless+bounces-37873-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K7HKB6cVM2oj9QUAu9opvQ
	(envelope-from <linux-wireless+bounces-37873-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B069C8FF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mythread.it header.s=a1 header.b=mPvSAITu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37873-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37873-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=mythread.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA0BB3056C1C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BDE3B841F;
	Wed, 17 Jun 2026 21:46:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C84399CE2
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 21:46:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732765; cv=none; b=JWqUK9fJQ3v8pKQ9d3tMn0uU2yCS4coSWEBd2xhuGh8DxtONAFdSdRRi+H1hPYRWR0jTPl2PL096g5ATO+A+z845Rfjkk0WX2J/Sr7jVSiWCWHZ9pKllUmZECONDAufBx27VEga9mNtH5P3kGVwQPLODLuYQdTCdbrKKaKkMiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732765; c=relaxed/simple;
	bh=KoRl5cszPxC+nYwDhbgWi7ztNx3gYmQoEoOAcZ/bQpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEvOT+VN4B5FzDYi5kN8gV+7icWV8mOOUU9CtfbG/AKVBi1PffdOfEuUvAUhaYqs0DPLBntvlzTXur5Gj4jRP+xWxqsvE6DHR3a4PC5gyA091b7qBn3fEsVDnLGvsVtCWWPNEfW3h/PUVJGrYJ64tYi5g1bGe3NhWxD5GmqJAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=mPvSAITu; arc=none smtp.client-ip=62.149.156.162
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Zy28wJnjp4OeoZy29w46A1; Wed, 17 Jun 2026 23:42:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1781732573; bh=KoRl5cszPxC+nYwDhbgWi7ztNx3gYmQoEoOAcZ/bQpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=mPvSAITuz0XW8/pB4hcUgpPKmoKNBsgDIfCiKUzhDAiGM5OFPFs7InDpBnQFiuYyY
	 UNiLOn9EVKpNeSL0ZSLKBoHstKr4mlAi35z07VkCXeSIO4Of7UdibFYAlJlEcZY5g/
	 5UC35tTeWQ8Gcb63jhQ1AFvjt0jf3EehObpgXD5m6nG81As5K4YXZOjPjkuRjJUxHW
	 0gPeMPgfO7vXA8jqPzVrqCXQU8KmXcEBAN6vZawQJvv2SlVPEHmy7TREMf2BEW3yh/
	 RfNaTv2U/33zHI+Ydlm8V6flp5LJVstEC0dKLaNQyn9vk+1sw4P/GcVZoK43X/RYAh
	 RxPYpp5nqalGg==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Wed, 17 Jun 2026 23:42:11 +0200
Subject: [PATCH 4/4] b43: align DMA64 descriptor ring to 64K on AC cores
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-b43-add-4352-wip-v1-4-c81323496720@gmail.com>
References: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
In-Reply-To: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 b43-dev@lists.infradead.org, Alessio Ferri <alessio.ferri@mythread.it>, 
 Alessio Ferri <alessio.ferri.3012@gmail.com>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfPga/+jcvE7OuVVkZZs2F7agCubGjDhtcpV1hH4MibJtEXcWFUoXf4T1Rcg46b/cSooFJI1uB+/CcAr/9DA2GnTTvr//ENtbOm4ZlZw14Hbjw+y03/8N
 i44DKnR74un2GonNyUEQSXpwwq/KsP0PseoIwO0fk9zgo2Y9wNj5nojY1FVIJ9Ib6fRVKLYs9RwK8D3eYFjibOy5IqEA6ec+2lisEMwSiQwiwWjH2/zN87eW
 pJYLaqmC4TX4aKJKhW2DnSD9+Qx5bCTexrywcCV81yUW0vva/8k/WRabCymJEErXpUPCB4SGuhMH9JhqKLdoZThVJi5iGOAeYeNaj5ar55WytF6pCt6C9vOf
 IFxNgFy2C4Vhx+LQbfeqHKI7f/Due0rsxajeRDiqdC4loLp7fhhxNHhS8H/OrJgZGypV1R8i
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37873-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:b43-dev@lists.infradead.org,m:alessio.ferri@mythread.it,m:alessio.ferri.3012@gmail.com,m:alessioferri3012@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mythread.it,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 839B069C8FF

From: Alessio Ferri <alessio.ferri.3012@gmail.com>

The AC d11 core (core_rev 40/42, BCM4352) exposes a 16-bit DMA descriptor
pointer (wrap mask 0xffff, not the 0x1fff b43 assumes). With an 8K-aligned
ring the engine wraps the pointer outside the ring and raises I_DE on RX.
Allocate the 64-bit ring with 64K size on these cores so the base is
64K-aligned and (base & 0xffff) == 0; dma_alloc_coherent() aligns to the
allocation size. ring_mem_size widens to u32 to hold 0x10000. N-PHY cores
report 0x1fff and keep the 8K allocation.

Assisted-by: claude:claude-Opus-4.8
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/dma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 05da6987a845..cb308080312b 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -404,6 +404,18 @@ static inline
 	}
 }
 
+static u32 b43_dma64_ringmem_size(struct b43_dmaring *ring)
+{
+	/* AC d11 cores (core_rev 40/42) expose a 16-bit descriptor pointer
+	 * (mask 0xffff) and need a 64K-aligned ring; dma_alloc_coherent()
+	 * aligns to the (power-of-2) allocation size. Smaller cores use the
+	 * 0x1fff mask and are fine with 8K.
+	 */
+	if (ring->dev->dev->core_rev == 40 || ring->dev->dev->core_rev == 42)
+		return 0x10000;
+	return B43_DMA64_RINGMEMSIZE;
+}
+
 static int alloc_ringmemory(struct b43_dmaring *ring)
 {
 	/* The specs call for 4K buffers for 30- and 32-bit DMA with 4K
@@ -415,8 +427,8 @@ static int alloc_ringmemory(struct b43_dmaring *ring)
 	 * B43_DMA64_RXSTATDPTR. Let's just use 8K buffers even if we don't use
 	 * more than 256 slots for ring.
 	 */
-	u16 ring_mem_size = (ring->type == B43_DMA_64BIT) ?
-				B43_DMA64_RINGMEMSIZE : B43_DMA32_RINGMEMSIZE;
+	u32 ring_mem_size = (ring->type == B43_DMA_64BIT) ?
+			b43_dma64_ringmem_size(ring) : B43_DMA32_RINGMEMSIZE;
 
 	ring->descbase = dma_alloc_coherent(ring->dev->dev->dma_dev,
 					    ring_mem_size, &(ring->dmabase),
@@ -429,8 +441,8 @@ static int alloc_ringmemory(struct b43_dmaring *ring)
 
 static void free_ringmemory(struct b43_dmaring *ring)
 {
-	u16 ring_mem_size = (ring->type == B43_DMA_64BIT) ?
-				B43_DMA64_RINGMEMSIZE : B43_DMA32_RINGMEMSIZE;
+	u32 ring_mem_size = (ring->type == B43_DMA_64BIT) ?
+			b43_dma64_ringmem_size(ring) : B43_DMA32_RINGMEMSIZE;
 	dma_free_coherent(ring->dev->dev->dma_dev, ring_mem_size,
 			  ring->descbase, ring->dmabase);
 }

-- 
2.54.0


