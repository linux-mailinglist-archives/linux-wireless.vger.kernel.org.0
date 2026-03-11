Return-Path: <linux-wireless+bounces-32939-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKLWEc67sGlXmgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32939-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:48:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3125A262
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 105EB3009085
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54936308D;
	Wed, 11 Mar 2026 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkOlvtzz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024536C9FC
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190078; cv=none; b=XBj7NdsBTZW67QMiHmJrdt76n3SMVfUy7NdYm9T7K5XojiswSF6uotLXG+SblwLIAJdwe1havoDDdgpT5Ik3s7u2cnLfBzS8EowWqcx5IGibW7IvJFLRg/Ohv9lKQPMQ0qPIoF2sV/QDw3xclvY31rB8Fn7QuV2Pck7HwktRyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190078; c=relaxed/simple;
	bh=GWfHWHTWEkbHmL8A2Gp09obkBBjV5/TvZpLBOriax/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7altDOYGxAqhc4Tcu9dwP+UWZr6oQjAdeert+evqVU7NDTP28us9GCPJuGGsFVWXCv3hu9I3Y5Yvice08ABdnclWq/r4NxqSZqPtjpLpFp7yZxWizQ8zVEG31qyAvUJ2LTRG8Gbj1g5swbaWy1T4YgvQPBqT56HE5SaIGKOPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkOlvtzz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so916249a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773190075; x=1773794875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O664dCsdWRRkRc+ofehgmpux+USEDU3vAot0X1wBxCI=;
        b=MkOlvtzzcoTpwf+ItKIB/2Y058rm/pZhOR2QTeeIt69Xesn97FOj66T3+NYKFZITJ7
         XLo05pYknDTr/WWj2r6ceuJs9YS385+HUaM8+mruWgroVkRtwK0wzk8uw+hv3pK7akMp
         Z7IIO6PXHEggl5u2mqprFEk8dtAyegMqrw8pkAReIHupTB1+kQ/PFdfIq49iyBrDyiyv
         dYlvftUxyhS/B1te8Bjqf5WEJ7pJrD8NLYXARidapcx65Wca1pE/XMapbXQaWdRHVo/E
         Hofh4KGWQyTxQWn9liRC65fGFkhh5+SBlASCF3jcEHqlm+WT0EyKs3bWkFQWu4Sm9iCV
         CeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773190075; x=1773794875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O664dCsdWRRkRc+ofehgmpux+USEDU3vAot0X1wBxCI=;
        b=CxthoR2A/XgPKmwBLpQSohyokEH3897QSnxZCY2fvABdX0eHVuhiYMWa1d3brNRkI8
         2K0dTYKTXPEe+L8ZRSKnlHgeTl2uIFC9pCY210+sd5hkQej+yJ80l4cHS/Cx0UOu2570
         lTfFZtWutSihRt/atZPS6UzYjbf50pcWAr+URd90X6ZTYZzvCA5/1U31VvmdYaRdMCMw
         9vA9ho/kYiJ6hJ2EQXpiyGa3Wfy3IS/qQmZ3PjHPtTetNCqF5l8CqjxOSH2OiXi9n9mt
         d8KL0WVANDPqwYt23NtIUt+JKoHGrgTZqVcC2d/0kZaZhXYoKseTECjZuMYyN9AD6b+V
         oh9g==
X-Gm-Message-State: AOJu0YxSnc+nyeaS/VD0plPvb314HpyOl81fA06C++VpscvS2NZWpeCJ
	49ZJwYt5poywJe13FVlGye1df8TOYSdLJkEE9WPc52itv7P/JDF6GHgDmJkZGmBx
X-Gm-Gg: ATEYQzw8BcVNIZEz27g/Sv3RXtYfxjOZfbsgYMNmOKpBnCJIItU0jP48brOa1kg/kGi
	SZgQp+1ljV0TNHQzBW7OyQxvo1xSRBXLOhHP2spqgtL3t3E8fvsRf6Wt6E/HrFonrans4ZwXUbP
	/AChJhCSTxWGGVC6CSOXc6kHmHUDXkHgMgNgEe9mrwMz1Zw7SogsoBpBM3QP2NV+RuAMldjU7vm
	v1rAh34yloVyTk3NUkJ+6Ti1ExU0TniQYkpABf/ohFp/157FUtNGM4xrf0ecMRICWUBgYhjpAaR
	eb6e7udLkyOsXbT2rNNQPEUgSTiX3uXw46/HOIIoHJ/ZSrmyug7wyFCogmYmd+qYtc+dqTk2uvS
	pv0ZtQsTxt9hz/S11LlziQsCCDEwLsC5xfp+o5ZPuwuEXcxFE7+vcUteH46qlidDUNt/qDtC2ss
	n1tVjoX5fv+h6OmBdPHIq2Y2nNT1JqJYl0lc4h0VDxn6JWiyKuUSWsvg==
X-Received: by 2002:a17:90b:3dcd:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-35a019e88camr707120a91.33.1773190074956;
        Tue, 10 Mar 2026 17:47:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cde37ffesm373842a12.0.2026.03.10.17.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:47:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b43-dev@lists.infradead.org (open list:B43 WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] wifi: b43: kzalloc + kcalloc to kzalloc_flex
Date: Tue, 10 Mar 2026 17:47:36 -0700
Message-ID: <20260311004736.32730-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2E3125A262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-32939-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Simplifies allocation and allows using __counted_by for extra runtime
analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/broadcom/b43/dma.c | 18 ++++++++----------
 drivers/net/wireless/broadcom/b43/dma.h |  4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 3a8df7a18042..05da6987a845 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -837,18 +837,19 @@ struct b43_dmaring *b43_setup_dmaring(struct b43_wldev *dev,
 	struct b43_dmaring *ring;
 	int i, err;
 	dma_addr_t dma_test;
+	size_t nr_slots;
 
-	ring = kzalloc_obj(*ring);
+	if (for_tx)
+		nr_slots = B43_TXRING_SLOTS;
+	else
+		nr_slots = B43_RXRING_SLOTS;
+
+	ring = kzalloc_flex(*ring, meta, nr_slots);
 	if (!ring)
 		goto out;
 
-	ring->nr_slots = B43_RXRING_SLOTS;
-	if (for_tx)
-		ring->nr_slots = B43_TXRING_SLOTS;
+	ring->nr_slots = nr_slots;
 
-	ring->meta = kzalloc_objs(struct b43_dmadesc_meta, ring->nr_slots);
-	if (!ring->meta)
-		goto err_kfree_ring;
 	for (i = 0; i < ring->nr_slots; i++)
 		ring->meta->skb = B43_DMA_PTR_POISON;
 
@@ -943,8 +944,6 @@ struct b43_dmaring *b43_setup_dmaring(struct b43_wldev *dev,
       err_kfree_txhdr_cache:
 	kfree(ring->txhdr_cache);
       err_kfree_meta:
-	kfree(ring->meta);
-      err_kfree_ring:
 	kfree(ring);
 	ring = NULL;
 	goto out;
@@ -1004,7 +1003,6 @@ static void b43_destroy_dmaring(struct b43_dmaring *ring,
 	free_ringmemory(ring);
 
 	kfree(ring->txhdr_cache);
-	kfree(ring->meta);
 	kfree(ring);
 }
 
diff --git a/drivers/net/wireless/broadcom/b43/dma.h b/drivers/net/wireless/broadcom/b43/dma.h
index c2a357219d4b..f9f65bbe2d76 100644
--- a/drivers/net/wireless/broadcom/b43/dma.h
+++ b/drivers/net/wireless/broadcom/b43/dma.h
@@ -228,8 +228,6 @@ struct b43_dmaring {
 	const struct b43_dma_ops *ops;
 	/* Kernel virtual base address of the ring memory. */
 	void *descbase;
-	/* Meta data about all descriptors. */
-	struct b43_dmadesc_meta *meta;
 	/* Cache of TX headers for each TX frame.
 	 * This is to avoid an allocation on each TX.
 	 * This is NULL for an RX ring.
@@ -273,6 +271,8 @@ struct b43_dmaring {
 	/* Statistics: Total number of TX plus all retries. */
 	u64 nr_total_packet_tries;
 #endif /* CONFIG_B43_DEBUG */
+	/* Meta data about all descriptors. */
+	struct b43_dmadesc_meta meta[] __counted_by(nr_slots);
 };
 
 static inline u32 b43_dma_read(struct b43_dmaring *ring, u16 offset)
-- 
2.53.0


