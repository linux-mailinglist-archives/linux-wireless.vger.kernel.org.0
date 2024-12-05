Return-Path: <linux-wireless+bounces-15936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F210F9E5F6F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 21:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD5D2860B1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4551C0DF3;
	Thu,  5 Dec 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln1WEEgi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2A1C07C8;
	Thu,  5 Dec 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430653; cv=none; b=t0q0G2DpvAgzHlUgDxdb8LTNhsRzq596RWN0Z14u3WGNpl0+RqXRv/5S3JiH8bf0jf3DpMiWMXynBjW96FrsJvrNWf0hxmjSV+5umCPZB6sKfg1Arcu8PhmKVJUZPikDozkaTEMwr40yL0gjk5c+PDQUi0fTrP83oXnREnKF8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430653; c=relaxed/simple;
	bh=STfKckyL0TMpxsYw5pn1QelzJf/9pGSJYyWVqtZs/DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBg6avJMiAgmtxN9Ns6QbwDQiflf8Mt+IJBNqqOrX6wzDKLK4ei5PUQcae2N15xujw/pVKn+LF1dZGHabtU7DAcr/2CNa55EHfOydjj7TBi4FA5eha20LnBRdoHtLNxJDqOvdK18Cq/ysdSVIH4OKSKA7WHiSdecy37zPT3hx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln1WEEgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E8CC4CEDC;
	Thu,  5 Dec 2024 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733430652;
	bh=STfKckyL0TMpxsYw5pn1QelzJf/9pGSJYyWVqtZs/DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ln1WEEgi5AwNjjG1Al06I5Rl17ncLg9m1Uy4VjqF8VXU8I0bmchqFmbNEuPQ/aAKC
	 7sa3Z8Tqw+/FibkRcJ652RAkeZqlbwlgXn5hGh5sTLnqxp0OXok8VmmFdtoqeaA3en
	 WbcaC8Bq/RSEhorU6XhWF6hJivUCwa3rpp1nfsU4a1RAvZb4A4+dQkAXIlnFVUh/tu
	 Cb0lNDY5Aq5KUc4jpUlva+37JNBFUg6vDDesoTKjdwySPUGytmAAUHj0+ma+zyadII
	 DWUqwBAQscOjftwjD/uOjYl2SlErtcxrP/ZEIkYQoR/vDkzduF6RyeXar37lj9yHm1
	 UsU8zvL61jzzg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/8] wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
Date: Thu,  5 Dec 2024 22:30:40 +0200
Message-Id: <20241205203044.589499-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205203044.589499-1-kvalo@kernel.org>
References: <20241205203044.589499-1-kvalo@kernel.org>
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


