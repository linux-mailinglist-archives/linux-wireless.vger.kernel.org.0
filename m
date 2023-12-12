Return-Path: <linux-wireless+bounces-683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E36180E29D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 04:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89091F21B8B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2875D63D5;
	Tue, 12 Dec 2023 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hve6RkVX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD535CB
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 19:19:21 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id d75a77b69052e-4259c7dfb63so25593861cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702351161; x=1702955961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAckxPqjIrdFZFrGXJnExxD4gp1JEUGn4xQyRliaGg0=;
        b=hve6RkVX3wUOx9XuxhYaCQ8KIzXVwpcRT7oHkcjvbJr0cFTBfbRQJxsh0ptGHn+msf
         9/UYnGUrEJjY8wBAtfM1h93UMpp0z75/PITX1iGg0b+S4DUAByFAezu3xOVQeJf13sUQ
         sFTRinw7Z9ASJdd4Io3LDwdkskvtRqirNjWkkU23bY1tvLgfTA7u04aOcC5UIbuNDUqw
         TV9xvrTWivXaoOlKIGIMXx69M7NLDQOY6ka97ofYiTI6V1IBwtjGJYofDAfUCS6JSZ6t
         kTk/xmhaASc6YCAKJqKREm4yHDnhK/J7O1+9+8F+FuercMjN4x3rah6LFOJBFRAcP039
         /phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702351161; x=1702955961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAckxPqjIrdFZFrGXJnExxD4gp1JEUGn4xQyRliaGg0=;
        b=PFU4SbTebqb2dIMj07h5oCEp3GbNQVZOblRgdNyna3/NvC4tSU/facdlh+TvOPU60F
         9oqvgeHDSUcTQbO5nS0Kr17mPxdkpNW0SS9xoH67Gi1u9/i4/T5Y09Ahkru5mizjilg0
         WHg8rHbQQQk1ivuDcpcetY6E7qUOAkpBbpqCUojOtL2doi3I72o74ZaZsPVnDdKwoT3N
         sywwwqIy3LzgzmFVE5QPxxfD8dDIReetMlxMgYKMkdxZor931x2JwBdM3AeWqz/f4Q3R
         Vjt/ZjfXHkHzweHHZzr+YDcSn/3HXOauPQRdvxXUzgcIPt6kHJQgd2S3l8r+6XEY/sjk
         JxSA==
X-Gm-Message-State: AOJu0YwKZPN2Bb6goTsYnz5KtUbY5DK57KSmmPVKjylP1J79fgzZ57tM
	3QE/aTTf+5VJ0CjkUiTR7XE=
X-Google-Smtp-Source: AGHT+IH2q+mXo52zkWaMEIyKZ41K8oBqKAXUH+p2t4Gqqye4TNl89owV8H1G3ZaaebJiYU4Vd0DB6w==
X-Received: by 2002:a05:622a:54c:b0:425:8856:36e with SMTP id m12-20020a05622a054c00b004258856036emr7282988qtx.124.1702351160730;
        Mon, 11 Dec 2023 19:19:20 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:9850:b60:6f2b:256b:f6ec:b44b])
        by smtp.gmail.com with ESMTPSA id ca25-20020a05622a1f1900b004259ba7bc08sm3688769qtb.42.2023.12.11.19.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 19:19:20 -0800 (PST)
From: Zhenghao Gu <imguzh@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	Zhenghao Gu <imguzh@gmail.com>
Subject: [PATCH v2] wifi: ath11k: fix IOMMU errors on buffer rings
Date: Mon, 11 Dec 2023 21:19:14 -0600
Message-ID: <20231212031914.47339-1-imguzh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virt_to_phys doesn't work on systems with IOMMU enabled,
which have non-identity physical-to-IOVA mappings.
It leads to IO_PAGE_FAULTs like this:
[IO_PAGE_FAULT domain=0x0023 address=0x1cce00000 flags=0x0020]
and no link can be established.

This patch changes that to dma_map_single(), which works correctly.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Zhenghao Gu <imguzh@gmail.com>
---
Changes in v2:
- ath11k_hal_srng_dst_peek_with_dma() is made static
---
 drivers/net/wireless/ath/ath11k/dp.c  | 19 ++++++++++++++++---
 drivers/net/wireless/ath/ath11k/hal.c | 20 ++++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index d070bcb3f..c74230e4c 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -104,11 +104,14 @@ void ath11k_dp_srng_cleanup(struct ath11k_base *ab, struct dp_srng *ring)
 	if (!ring->vaddr_unaligned)
 		return;
 
-	if (ring->cached)
+	if (ring->cached) {
+		dma_unmap_single(ab->dev, ring->paddr_unaligned, ring->size,
+				 DMA_FROM_DEVICE);
 		kfree(ring->vaddr_unaligned);
-	else
+	} else {
 		dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligned,
 				  ring->paddr_unaligned);
+	}
 
 	ring->vaddr_unaligned = NULL;
 }
@@ -249,7 +252,17 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 
 		if (cached) {
 			ring->vaddr_unaligned = kzalloc(ring->size, GFP_KERNEL);
-			ring->paddr_unaligned = virt_to_phys(ring->vaddr_unaligned);
+			if (!ring->vaddr_unaligned)
+				return -ENOMEM;
+
+			ring->paddr_unaligned =
+				dma_map_single(ab->dev, ring->vaddr_unaligned,
+					       ring->size, DMA_FROM_DEVICE);
+			if (dma_mapping_error(ab->dev, ring->paddr_unaligned)) {
+				kfree(ring->vaddr_unaligned);
+				ring->vaddr_unaligned = NULL;
+				return -ENOMEM;
+			}
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 0a99aa7dd..7e4a8c820 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -628,15 +628,31 @@ u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng)
 	return NULL;
 }
 
+static u32 *ath11k_hal_srng_dst_peek_with_dma(struct ath11k_base *ab,
+					      struct hal_srng *srng, dma_addr_t *paddr)
+{
+	lockdep_assert_held(&srng->lock);
+
+	if (srng->u.dst_ring.tp != srng->u.dst_ring.cached_hp) {
+		*paddr = (srng->ring_base_paddr +
+			  sizeof(*srng->ring_base_vaddr) * srng->u.dst_ring.tp);
+		return (srng->ring_base_vaddr + srng->u.dst_ring.tp);
+	}
+
+	return NULL;
+}
+
 static void ath11k_hal_srng_prefetch_desc(struct ath11k_base *ab,
 					  struct hal_srng *srng)
 {
 	u32 *desc;
+	dma_addr_t desc_paddr;
+
 
 	/* prefetch only if desc is available */
-	desc = ath11k_hal_srng_dst_peek(ab, srng);
+	desc = ath11k_hal_srng_dst_peek_with_dma(ab, srng, &desc_paddr);
 	if (likely(desc)) {
-		dma_sync_single_for_cpu(ab->dev, virt_to_phys(desc),
+		dma_sync_single_for_cpu(ab->dev, desc_paddr,
 					(srng->entry_size * sizeof(u32)),
 					DMA_FROM_DEVICE);
 		prefetch(desc);

