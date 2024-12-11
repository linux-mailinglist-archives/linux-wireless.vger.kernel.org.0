Return-Path: <linux-wireless+bounces-16250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B129ECFD2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74744188A1FC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC261D63DE;
	Wed, 11 Dec 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWKRadtZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F91CF7C3;
	Wed, 11 Dec 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931281; cv=none; b=WlLuUrVYqfR/S6Tan+l6fUSLETebuzQrxFEnR0lL/3ANufH0Dld8/qwimoOwBIjdFcWXG8PzJOjL0pxSeR2/L7Q2++lNBqKknFwfkLTsBgu3cUSZ+w1Xem0cLZgGF95CftfNlph16uEcs+7GaC/KQ/S2CeecJ94ZRk44eOuL/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931281; c=relaxed/simple;
	bh=STfKckyL0TMpxsYw5pn1QelzJf/9pGSJYyWVqtZs/DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DEBmKyga+/YOgeASl11S4ywVTQX8XM2wHAVReLctYkj2SfnpRmCn8klWxS/b1JAFibLaOwjRSLGIwuPP+yo9B/VQdilHEppr3ueMHyBfMg/BWxcVlDvvPQxfxo32VyZg/CuxNX0OCNBWXpp6tABIQ5QhZMQmUAHH1igtswmTq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWKRadtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50486C4CED2;
	Wed, 11 Dec 2024 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931281;
	bh=STfKckyL0TMpxsYw5pn1QelzJf/9pGSJYyWVqtZs/DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWKRadtZjptrSNbANkPIl8auh1MwkBsuWxwytuc4JZIJozeDb0VQ0U2pU1xR0jnlw
	 WcPvdSgxgon+Qdgfh5wWrd60b3hVLh/Y77S2gWsCA83mPlVwc+J3+my7ghI6nZv8zP
	 u6frTWXkCpcYAcCCHDiMBEUBy/KEksXZb4qIofLeb7GvGZ1bwT46i3s5RZYkPVWXd3
	 jhmuo9vR9s2Z4GA/DHFQ0eAlhTlgMBKKs6FlXr02R+dIe3Hp6zBdNrelJXhNXPBtgU
	 knuPb6Vr8Hq6x6rV/KijCdPDcUP4A+W1cW2HbQckSOVQPk521VyV3IicVfai4kkPaD
	 7ItDII2JxlElw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 4/8] wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
Date: Wed, 11 Dec 2024 17:34:28 +0200
Message-Id: <20241211153432.775335-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211153432.775335-1-kvalo@kernel.org>
References: <20241211153432.775335-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, all QMI target memory types share the same allocation logic within
ath12k_qmi_alloc_target_mem_chunk(). However, for Multi-Link Operation (MLO),
the firmware requests a new MLO global memory region. This memory is shared
across different firmware (SoC) participating in the MLO. To accommodate this
logic change, refactor ath12k_qmi_alloc_target_mem_chunk() and introduce a
helper function ath12k_qmi_alloc_chunk() for memory chunk allocation.
Subsequent patch will add MLO global memory allocation logic.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 82 ++++++++++++++-------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 2f10c83ef54a..7f3d5b269b9e 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2423,9 +2423,50 @@ static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
 	}
 }
 
+static int ath12k_qmi_alloc_chunk(struct ath12k_base *ab,
+				  struct target_mem_chunk *chunk)
+{
+	/* Firmware reloads in recovery/resume.
+	 * In such cases, no need to allocate memory for FW again.
+	 */
+	if (chunk->v.addr) {
+		if (chunk->prev_type == chunk->type &&
+		    chunk->prev_size == chunk->size)
+			goto this_chunk_done;
+
+		/* cannot reuse the existing chunk */
+		dma_free_coherent(ab->dev, chunk->prev_size,
+				  chunk->v.addr, chunk->paddr);
+		chunk->v.addr = NULL;
+	}
+
+	chunk->v.addr = dma_alloc_coherent(ab->dev,
+					   chunk->size,
+					   &chunk->paddr,
+					   GFP_KERNEL | __GFP_NOWARN);
+	if (!chunk->v.addr) {
+		if (chunk->size > ATH12K_QMI_MAX_CHUNK_SIZE) {
+			ab->qmi.target_mem_delayed = true;
+			ath12k_warn(ab,
+				    "qmi dma allocation failed (%d B type %u), will try later with small size\n",
+				    chunk->size,
+				    chunk->type);
+			ath12k_qmi_free_target_mem_chunk(ab);
+			return 0;
+		}
+		ath12k_warn(ab, "memory allocation failure for %u size: %d\n",
+			    chunk->type, chunk->size);
+		return -ENOMEM;
+	}
+	chunk->prev_type = chunk->type;
+	chunk->prev_size = chunk->size;
+this_chunk_done:
+	return 0;
+}
+
 static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 {
-	int i;
+	int i, ret = 0;
 	struct target_mem_chunk *chunk;
 
 	ab->qmi.target_mem_delayed = false;
@@ -2442,42 +2483,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 		case M3_DUMP_REGION_TYPE:
 		case PAGEABLE_MEM_REGION_TYPE:
 		case CALDB_MEM_REGION_TYPE:
-			/* Firmware reloads in recovery/resume.
-			 * In such cases, no need to allocate memory for FW again.
-			 */
-			if (chunk->v.addr) {
-				if (chunk->prev_type == chunk->type &&
-				    chunk->prev_size == chunk->size)
-					goto this_chunk_done;
-
-				/* cannot reuse the existing chunk */
-				dma_free_coherent(ab->dev, chunk->prev_size,
-						  chunk->v.addr, chunk->paddr);
-				chunk->v.addr = NULL;
-			}
-
-			chunk->v.addr = dma_alloc_coherent(ab->dev,
-							   chunk->size,
-							   &chunk->paddr,
-							   GFP_KERNEL | __GFP_NOWARN);
-			if (!chunk->v.addr) {
-				if (chunk->size > ATH12K_QMI_MAX_CHUNK_SIZE) {
-					ab->qmi.target_mem_delayed = true;
-					ath12k_warn(ab,
-						    "qmi dma allocation failed (%d B type %u), will try later with small size\n",
-						    chunk->size,
-						    chunk->type);
-					ath12k_qmi_free_target_mem_chunk(ab);
-					return 0;
-				}
-				ath12k_warn(ab, "memory allocation failure for %u size: %d\n",
-					    chunk->type, chunk->size);
-				return -ENOMEM;
-			}
-
-			chunk->prev_type = chunk->type;
-			chunk->prev_size = chunk->size;
-this_chunk_done:
+			ret = ath12k_qmi_alloc_chunk(ab, chunk);
 			break;
 		default:
 			ath12k_warn(ab, "memory type %u not supported\n",
@@ -2487,7 +2493,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 			break;
 		}
 	}
-	return 0;
+	return ret;
 }
 
 /* clang stack usage explodes if this is inlined */
-- 
2.39.5


