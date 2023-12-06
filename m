Return-Path: <linux-wireless+bounces-448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB03806537
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AA51F20FDA
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 02:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303EEC9;
	Wed,  6 Dec 2023 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McuL+LZu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1D1AA
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 18:43:46 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 6a1803df08f44-677fba00a49so3576286d6.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 Dec 2023 18:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701830625; x=1702435425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHKQqyZy+g524fgsbEY/VwWQxSo6h1c/KOycwt/arPo=;
        b=McuL+LZu4skcCn2SfTVF58xZdqER4VPJWNUe06dbLBgZRALJlOsyXI2JqiEJDAiFp2
         eVTUghAdoJsPP43I0orlUTwV32sKGfkEVsaMrh2gLfH1ypvNpJwYwtgRDWEdKWm0yeQq
         b5pck0Lw930J34f80745M0ABDS4tlqD8PLRiK+dHg4Yf7tFB93POrlEiGGVrwECk3pOE
         A0cJyqUg4bzCSfhT9ndDEXbDE23nyYhSPjLk1XGkvxNKC4AJVyNbvMp7oNCu95lEgKnq
         ct5XIXGFrHSxr2FvtqiW77qa8XKIIJEfK4/O+UI3QGISkRjNUV4wmyCoFsTiknpvWXX0
         JOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701830625; x=1702435425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHKQqyZy+g524fgsbEY/VwWQxSo6h1c/KOycwt/arPo=;
        b=YJvCd7HZpmAV+lNa6hrjkuseFNp0np5tNFiRCje/+IdWAaE5cV83JL/Vg8vbDZfP+h
         wxIUY2Jj6AComPWPL3VaUasIGSewSQZm0Psb9SvajC0ZP40yNRWhrt5oCBTD2+ZqAs2U
         UCgQC59EX423iVdmxjNgbDsLtZIZL4afQRqOxzhHzrN5vP1gbx11LTXFTHbqc9oOslDt
         89HD3pi5dHLj7WVnwX6IeeaoyiaaVntE4UaWMA4kMa9ZmuK/4W0bKuO5YnVliWbgUDlj
         Jzyqpl+pZrylWgmHIwPxyDu3E4SiMsDQPoidSH5XfCPnh1ok4XJrL+omlXWqTkhfcyNA
         XPhg==
X-Gm-Message-State: AOJu0Yx4LoskVd7FFpbjh3OcFT+5ST68gD8GdlRNR0+mot8m9oFH/988
	XP68pGFgWD2yMdW7minGwY8=
X-Google-Smtp-Source: AGHT+IGIaQYxmKovTvb6RA2ApPZOvr488kuKkXz5uSLu+X8THLgukkQscvjv1FJ0krvV6wp3T+2a4g==
X-Received: by 2002:a05:6214:f2c:b0:67a:a532:d33a with SMTP id iw12-20020a0562140f2c00b0067aa532d33amr4168215qvb.0.1701830625143;
        Tue, 05 Dec 2023 18:43:45 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:9850:b60:48c0:d784:7e4c:676])
        by smtp.gmail.com with ESMTPSA id b16-20020a0ccd10000000b0067acbd864e0sm2015561qvm.69.2023.12.05.18.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 18:43:42 -0800 (PST)
From: Zhenghao Gu <imguzh@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	Zhenghao Gu <imguzh@gmail.com>
Subject: [PATCH] wifi: ath11k: fix IOMMU errors on buffer rings
Date: Tue,  5 Dec 2023 20:43:25 -0600
Message-ID: <20231206024325.27283-1-imguzh@gmail.com>
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
 drivers/net/wireless/ath/ath11k/dp.c  | 19 ++++++++++++++++---
 drivers/net/wireless/ath/ath11k/hal.c | 20 ++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hal.h |  2 ++
 3 files changed, 36 insertions(+), 5 deletions(-)

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
index 0a99aa7dd..bd4cccdba 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -628,15 +628,31 @@ u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng)
 	return NULL;
 }
 
+u32 *ath11k_hal_srng_dst_peek_with_dma(struct ath11k_base *ab,
+				       struct hal_srng *srng, dma_addr_t *paddr)
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
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 1942d41d6..facaf8fe0 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -943,6 +943,8 @@ void ath11k_hal_srng_get_params(struct ath11k_base *ab, struct hal_srng *srng,
 u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
 					struct hal_srng *srng);
 u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng);
+u32 *ath11k_hal_srng_dst_peek_with_dma(struct ath11k_base *ab,
+				       struct hal_srng *srng, dma_addr_t *paddr);
 int ath11k_hal_srng_dst_num_free(struct ath11k_base *ab, struct hal_srng *srng,
 				 bool sync_hw_ptr);
 u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng);

