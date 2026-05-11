Return-Path: <linux-wireless+bounces-36188-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFqLK/FYAWqSVwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36188-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:20:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE37507CC2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E59793009B1B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEF21E098;
	Mon, 11 May 2026 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq6pa+pM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00D255F52
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473194; cv=none; b=e12jIWuHZMffY1M49XnVUlCXJzrsAy2tKvDCKPAgS8F9k/4d/hg7I++HgaATYS++12fjRxvt7xEOX0WW61BG0vr5mhslIQ6mxBxOsM0mtKaPb8cKACCK5SO1+KzsO2u20KUKRBu7BhOzeul392vrnekfATGa8i3cUX9gp4kal50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473194; c=relaxed/simple;
	bh=l9r0k9O845xmFH49LN0SvAE9g5m1PdtjkXkKvP0Tdwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rj5XOzgDdvHD1mNHkk5SPklcIvLavtDGSmuKX9VuvDEa5vJ78S4SaQFMQnIYZ3yAToqy01/lZPQqs3NFgBlY5fRGjYzPSPxZoZTg86UrFBDm+CGoxaHgono5QdzxldKCD/qOCEoEvzHlxnuFO2Mta1cnT2ZN/+N8li2J8+kFAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq6pa+pM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso1588422a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473192; x=1779077992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuGDf9iNAynlSPvBXud+v9E3yiQ53OcQ/UBsB/xF9OA=;
        b=Bq6pa+pMaeQ6MDDQkvze95i95EGTsiP1FgnEWMej1kItue/bfaDEUpGc4+pgho/TJZ
         tIaoDcyXUiLccLncam/3JFKkZLduyqZP6Cd1EQidcHa8XV1I25VWOW+z5h8cLwVTVA3p
         5wqw9lwm4X6FcwOze0ybtdu+W4U7wuG9sheFdHxIpvask/0nzin7N6zrNZUjrbidTGel
         Auri7mvp87Vm7dDUA4y7jUi1lpdN4sg2P79hI2pU/AGspQh6oFKCHNa7kdTVLmz8lGaH
         0Vm2Js5d0ZVCDzSOBsEs+aLjM0X369HN1LZ3bj/Jq0TIS8m3CNAc+j9suMg7v+1Y+JdK
         GEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473192; x=1779077992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuGDf9iNAynlSPvBXud+v9E3yiQ53OcQ/UBsB/xF9OA=;
        b=rRm/vv9XCBYlRp2uYB65m/gGMZSgVHVLyYFF6GAzkcmWLsivXZPdK/eenR0RcBWnyg
         PbuJuscKVxCd/9F02Q7CObYpHHJziuFYTHCpkJTUjYRwO5shsZt+4BE3D9RN3X0pjNcj
         hGvEEu0U6JDSUa726C3OPrOQQpXUfnFMm6CID4BcQETjdlzaOWnN3B72nSIEP9txR10l
         lbvBG/6MlcvU1KheNLAX0V3UFehjuIEUDGdhuooHacafuP2W8aZaWN63f7TqzM31Ui3e
         nP4qXioYLlzTH8/r4Nc05ly6cdP1G4QNqiluzl9ei0JJSjEeQsmtEKMeZJbVWsMTRp/I
         kIgQ==
X-Gm-Message-State: AOJu0YxHgTRlWoxADETMJo5E7IxzatSMWiekXtesFEl5I2O5Qwd/Thy/
	qhN/rhd30sWWmO94WKIfv+HsF+BCpgyqgBOirASeHOTQ650a2OWb7muTzNRjtXYd
X-Gm-Gg: Acq92OH6DG16MXlmvx7WxcxBmkTEBJR4EdaESYMvKxKQWf/dw9AdPo+EVx2/cKfxs2G
	bQHS9AFQncF535+xTJ5EWk4fDQ+anqisnyBr2mgtLZ8TUC/wef9kB72eDZJYZPfgxZum6oNkniA
	pw6uNbAJIMVYAh+q/nLJPmRuzShhwKbHo4rBPNfiCJQQxgaUmQhy1HzmCIuEAKEFy1AZpKghnQA
	MEbPzGudv3HhG2Cj52Ddy+gsj+aPa6eG88+k0b721UVHnd84fmig23Ov2z8VgurCl/nDqLCfH0a
	27T7SW9LFo/ZURj5ZxMTD3dsSVFMRBhURAa9noyeqJOsMRyfILtc20uuB5H37Y0W5do7bMWS5IW
	VDl7RZ7GPTgIYms3enHgbJHyqvfCBuJ8XhrK1T1nJ352shTKe+8MvxT6Ro8N3QQmwtQVVUe60+c
	F+DGJ8Njt6fSN7/uZlU3UdXuJOdJRF4hKOpyHs46RGDT/DkpEtLOP4knfzQiPSd4EEkDUShM+tg
	CCx/FCho35ewetjzvs30/obfBT/FP5hqVMQiWKoAgbG5A==
X-Received: by 2002:a05:6a00:2e90:b0:831:7f71:c810 with SMTP id d2e1a72fcca58-83a5d96fa9dmr22809905b3a.35.1778473192058;
        Sun, 10 May 2026 21:19:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659498f1sm23736106b3a.17.2026.05.10.21.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:19:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b43-dev@lists.infradead.org (open list:B43LEGACY WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH wireless-next] wifi: b43legacy: Use flexible array for DMA metadata
Date: Sun, 10 May 2026 21:19:34 -0700
Message-ID: <20260511041934.378209-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2EE37507CC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36188-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Store the per-descriptor metadata in the DMA ring allocation instead of
allocating it separately.

This ties the metadata lifetime directly to the ring, removes a separate
allocation failure path, and keeps the descriptor count available for
__counted_by() bounds checking.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/broadcom/b43legacy/dma.c | 24 ++++++++-----------
 drivers/net/wireless/broadcom/b43legacy/dma.h |  4 ++--
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.c b/drivers/net/wireless/broadcom/b43legacy/dma.c
index a9557356c9ab..6c3d847242bb 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.c
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.c
@@ -610,25 +610,25 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 	int nr_slots;
 	dma_addr_t dma_test;
 
-	ring = kzalloc_obj(*ring);
+	if (for_tx)
+		nr_slots = B43legacy_TXRING_SLOTS;
+	else
+		nr_slots = B43legacy_RXRING_SLOTS;
+
+	ring = kzalloc_flex(*ring, meta, nr_slots);
 	if (!ring)
 		goto out;
+
+	ring->nr_slots = nr_slots;
 	ring->type = type;
 	ring->dev = dev;
 
-	nr_slots = B43legacy_RXRING_SLOTS;
-	if (for_tx)
-		nr_slots = B43legacy_TXRING_SLOTS;
-
-	ring->meta = kzalloc_objs(struct b43legacy_dmadesc_meta, nr_slots);
-	if (!ring->meta)
-		goto err_kfree_ring;
 	if (for_tx) {
 		ring->txhdr_cache = kcalloc(nr_slots,
 					sizeof(struct b43legacy_txhdr_fw3),
 					GFP_KERNEL);
 		if (!ring->txhdr_cache)
-			goto err_kfree_meta;
+			goto err_kfree_ring;
 
 		/* test for ability to dma to txhdr_cache */
 		dma_test = dma_map_single(dev->dev->dma_dev, ring->txhdr_cache,
@@ -643,7 +643,7 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 					sizeof(struct b43legacy_txhdr_fw3),
 					GFP_KERNEL | GFP_DMA);
 			if (!ring->txhdr_cache)
-				goto err_kfree_meta;
+				goto err_kfree_txhdr_cache;
 
 			dma_test = dma_map_single(dev->dev->dma_dev,
 					ring->txhdr_cache,
@@ -660,7 +660,6 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 				 DMA_TO_DEVICE);
 	}
 
-	ring->nr_slots = nr_slots;
 	ring->mmio_base = b43legacy_dmacontroller_base(type, controller_index);
 	ring->index = controller_index;
 	if (for_tx) {
@@ -694,8 +693,6 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 	free_ringmemory(ring);
 err_kfree_txhdr_cache:
 	kfree(ring->txhdr_cache);
-err_kfree_meta:
-	kfree(ring->meta);
 err_kfree_ring:
 	kfree(ring);
 	ring = NULL;
@@ -720,7 +717,6 @@ static void b43legacy_destroy_dmaring(struct b43legacy_dmaring *ring)
 	free_ringmemory(ring);
 
 	kfree(ring->txhdr_cache);
-	kfree(ring->meta);
 	kfree(ring);
 }
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.h b/drivers/net/wireless/broadcom/b43legacy/dma.h
index b5c1a51db2a4..edd06225b64f 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.h
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.h
@@ -122,8 +122,6 @@ enum b43legacy_dmatype {
 struct b43legacy_dmaring {
 	/* Kernel virtual base address of the ring memory. */
 	void *descbase;
-	/* Meta data about all descriptors. */
-	struct b43legacy_dmadesc_meta *meta;
 	/* Cache of TX headers for each slot.
 	 * This is to avoid an allocation on each TX.
 	 * This is NULL for an RX ring.
@@ -161,6 +159,8 @@ struct b43legacy_dmaring {
 	/* Last time we injected a ring overflow. */
 	unsigned long last_injected_overflow;
 #endif /* CONFIG_B43LEGACY_DEBUG*/
+	/* Meta data about all descriptors. */
+	struct b43legacy_dmadesc_meta meta[] __counted_by(nr_slots);
 };
 
 
-- 
2.54.0


