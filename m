Return-Path: <linux-wireless+bounces-16251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337F29ECFD5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0978F188A7EC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ECD1D6DB5;
	Wed, 11 Dec 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC/A+1Yv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293C1D6DA4;
	Wed, 11 Dec 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931282; cv=none; b=FkmOWBMX4A3IEVn+/Stck8eUjPDimC+Nm/sr4omLlrOLHGlx8sFolCi8kSPUkj8f4sEdYPvGafAd8yFMBanS5/I1K/wtMiyjfIjd3l3JfMppj7mOV9gc3ewsLW/2QUz+rU5I3lczydOYjrWjVLW+GXeIi5rpv32si7F8DphhRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931282; c=relaxed/simple;
	bh=0MpnDzEdOw00/eEu1dedSOMrvM8zY0rTM/h1/lkQtCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glsc+XYqJHVxc88t+0Aa6AZHMXyYZaKj8uW2NJ7/+tTi8kD51iyG76CFJ4+XIFqtZqo7KKLPX5xpTSLhv2tj+jtDA9hJKXPUXZKHH5BbQZt/BxvWGCYVwFXxTV4cbLSvbXgOVktaEEa1R1pBzgIwZJ0//+KD0Oc5jvJtBO3FGgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC/A+1Yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8648CC4CED7;
	Wed, 11 Dec 2024 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931282;
	bh=0MpnDzEdOw00/eEu1dedSOMrvM8zY0rTM/h1/lkQtCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GC/A+1YvP3zzzZOR+YHGSVVxsJkfQ1k/Q/F9GU2bI7Zg+ee1EUYyJ2dCsUuj/VqIH
	 O/GZBS+d2m4oG0qUfzeR++IpnqOuN8GPbnQJvQ5at7097oLMKJrl8nopZoNGhXze5y
	 zCHbjQ37scr9Kq5Hn0wbw1gGWYCFO30KU3b7sAiXKMBmux/6LDnllmYUgZ7tiz9bjN
	 O5nRT2/h+Z2U2nEBW1W7JOoicjmCjptdYnbUUdfbNHB+fA+bpap0GfDqBL4cD37QXa
	 HTCgX4FEz3hksBZpb44e611Ho9wtnPY57bw09R+hSEjwbqk9BS5DTgWn4BILRLJP+Z
	 QiuXv0RKNTYGg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 5/8] wifi: ath12k: add support to allocate MLO global memory region
Date: Wed, 11 Dec 2024 17:34:29 +0200
Message-Id: <20241211153432.775335-6-kvalo@kernel.org>
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

To enable Multi-Link Operation (MLO), QCN9274 firmware requests MLO global
memory (MLO_GLOBAL_MEM_REGION_TYPE). This memory region is shared across all
the firmware (SoC) that are participation in the MLO.

Hence, add support to allocate and free MLO global memory region.  Allocate one
MLO global memory per struct ath12k_hw_group and assign the same memory to all
firmware in the same struct ath12k_hw_group. WCN7850 firmware does not request
this memory type, therefore this change will have no impact on WCN7850 device.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   7 ++
 drivers/net/wireless/ath/ath12k/qmi.c  | 127 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h  |   1 +
 3 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d0e466819036..bf310df3d8f7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -822,6 +822,12 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+struct ath12k_mlo_memory {
+	struct target_mem_chunk chunk[ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
+	int mlo_mem_size;
+	bool init_done;
+};
+
 /* Holds info on the group of devices that are registered as a single
  * wiphy, protected with struct ath12k_hw_group::mutex.
  */
@@ -847,6 +853,7 @@ struct ath12k_hw_group {
 	u8 num_hw;
 	bool mlo_capable;
 	struct device_node *wsi_node[ATH12K_MAX_SOCS];
+	struct ath12k_mlo_memory mlo_mem;
 };
 
 /* Holds WSI info specific to each device, excluding WSI group info */
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7f3d5b269b9e..e7846aaca10a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2407,19 +2407,64 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 	return ret;
 }
 
+static void ath12k_qmi_free_mlo_mem_chunk(struct ath12k_base *ab,
+					  struct target_mem_chunk *chunk,
+					  int idx)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	struct target_mem_chunk *mlo_chunk;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (!ag->mlo_mem.init_done || ag->num_started)
+		return;
+
+	if (idx >= ARRAY_SIZE(ag->mlo_mem.chunk)) {
+		ath12k_warn(ab, "invalid index for MLO memory chunk free: %d\n", idx);
+		return;
+	}
+
+	mlo_chunk = &ag->mlo_mem.chunk[idx];
+	if (mlo_chunk->v.addr) {
+		dma_free_coherent(ab->dev,
+				  mlo_chunk->size,
+				  mlo_chunk->v.addr,
+				  mlo_chunk->paddr);
+		mlo_chunk->v.addr = NULL;
+	}
+
+	mlo_chunk->paddr = 0;
+	mlo_chunk->size = 0;
+	chunk->v.addr = NULL;
+	chunk->paddr = 0;
+	chunk->size = 0;
+}
+
 static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
 {
-	int i;
+	struct ath12k_hw_group *ag = ab->ag;
+	int i, mlo_idx;
 
-	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+	for (i = 0, mlo_idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		if (!ab->qmi.target_mem[i].v.addr)
 			continue;
 
-		dma_free_coherent(ab->dev,
-				  ab->qmi.target_mem[i].prev_size,
-				  ab->qmi.target_mem[i].v.addr,
-				  ab->qmi.target_mem[i].paddr);
-		ab->qmi.target_mem[i].v.addr = NULL;
+		if (ab->qmi.target_mem[i].type == MLO_GLOBAL_MEM_REGION_TYPE) {
+			ath12k_qmi_free_mlo_mem_chunk(ab,
+						      &ab->qmi.target_mem[i],
+						      mlo_idx++);
+		} else {
+			dma_free_coherent(ab->dev,
+					  ab->qmi.target_mem[i].prev_size,
+					  ab->qmi.target_mem[i].v.addr,
+					  ab->qmi.target_mem[i].paddr);
+			ab->qmi.target_mem[i].v.addr = NULL;
+		}
+	}
+
+	if (!ag->num_started && ag->mlo_mem.init_done) {
+		ag->mlo_mem.init_done = false;
+		ag->mlo_mem.mlo_mem_size = 0;
 	}
 }
 
@@ -2466,12 +2511,21 @@ static int ath12k_qmi_alloc_chunk(struct ath12k_base *ab,
 
 static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 {
-	int i, ret = 0;
-	struct target_mem_chunk *chunk;
+	struct target_mem_chunk *chunk, *mlo_chunk;
+	struct ath12k_hw_group *ag = ab->ag;
+	int i, mlo_idx, ret;
+	int mlo_size = 0;
+
+	mutex_lock(&ag->mutex);
+
+	if (!ag->mlo_mem.init_done) {
+		memset(ag->mlo_mem.chunk, 0, sizeof(ag->mlo_mem.chunk));
+		ag->mlo_mem.init_done = true;
+	}
 
 	ab->qmi.target_mem_delayed = false;
 
-	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+	for (i = 0, mlo_idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		chunk = &ab->qmi.target_mem[i];
 
 		/* Allocate memory for the region and the functionality supported
@@ -2484,6 +2538,40 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 		case PAGEABLE_MEM_REGION_TYPE:
 		case CALDB_MEM_REGION_TYPE:
 			ret = ath12k_qmi_alloc_chunk(ab, chunk);
+			if (ret)
+				goto err;
+			break;
+		case MLO_GLOBAL_MEM_REGION_TYPE:
+			mlo_size += chunk->size;
+			if (ag->mlo_mem.mlo_mem_size &&
+			    mlo_size > ag->mlo_mem.mlo_mem_size) {
+				ath12k_err(ab, "QMI MLO memory allocation failure, requested size %d is more than allocated size %d",
+					   mlo_size, ag->mlo_mem.mlo_mem_size);
+				ret = -EINVAL;
+				goto err;
+			}
+
+			mlo_chunk = &ag->mlo_mem.chunk[mlo_idx];
+			if (mlo_chunk->paddr) {
+				if (chunk->size != mlo_chunk->size) {
+					ath12k_err(ab, "QMI MLO chunk memory allocation failure for index %d, requested size %d is more than allocated size %d",
+						   mlo_idx, chunk->size, mlo_chunk->size);
+					ret = -EINVAL;
+					goto err;
+				}
+			} else {
+				mlo_chunk->size = chunk->size;
+				mlo_chunk->type = chunk->type;
+				ret = ath12k_qmi_alloc_chunk(ab, mlo_chunk);
+				if (ret)
+					goto err;
+				memset(mlo_chunk->v.addr, 0, mlo_chunk->size);
+			}
+
+			chunk->paddr = mlo_chunk->paddr;
+			chunk->v.addr = mlo_chunk->v.addr;
+			mlo_idx++;
+
 			break;
 		default:
 			ath12k_warn(ab, "memory type %u not supported\n",
@@ -2493,6 +2581,25 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 			break;
 		}
 	}
+
+	if (!ag->mlo_mem.mlo_mem_size) {
+		ag->mlo_mem.mlo_mem_size = mlo_size;
+	} else if (ag->mlo_mem.mlo_mem_size != mlo_size) {
+		ath12k_err(ab, "QMI MLO memory size error, expected size is %d but requestted size is %d",
+			   ag->mlo_mem.mlo_mem_size, mlo_size);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mutex_unlock(&ag->mutex);
+
+	return 0;
+
+err:
+	ath12k_qmi_free_target_mem_chunk(ab);
+
+	mutex_unlock(&ag->mutex);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 98f6009ab21e..45d7c3fcafdd 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -172,6 +172,7 @@ enum ath12k_qmi_target_mem {
 	BDF_MEM_REGION_TYPE = 0x2,
 	M3_DUMP_REGION_TYPE = 0x3,
 	CALDB_MEM_REGION_TYPE = 0x4,
+	MLO_GLOBAL_MEM_REGION_TYPE = 0x8,
 	PAGEABLE_MEM_REGION_TYPE = 0x9,
 };
 
-- 
2.39.5


