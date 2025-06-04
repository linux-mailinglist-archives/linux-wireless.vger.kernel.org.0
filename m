Return-Path: <linux-wireless+bounces-23622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B40ACD2AC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A633A27F4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7691C84C5;
	Wed,  4 Jun 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbi/adP2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D8146D6A;
	Wed,  4 Jun 2025 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998739; cv=none; b=Fu3VAvXq+LcIEK+pSMI/KjCt4gMxGtNPsg08k5pwOwLVhGOe1Bb23f9KDFk2eZK4ur/wlW1b1teEkZYPBxNoG9BF6jjWFbP6RccBNe907wAgLQmPay+SZH5YPoMf4wosdYYr61sCOcp2j7MU5z2x/7NTIEPASQDQSvs2QnVtpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998739; c=relaxed/simple;
	bh=R4AXArGgkBB6bm9OCbCAf1hTi+Y225WLUU2GgmWqtC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQYH517lJTsUExPDBbk2xGLyK0ygMiV9TXLfKa3Hl/NwoMzAbE/NVihJyYeXiIQuvAyRiPgL9Csl7N5Vl3L0Np+iyzUbr16nrxAtMryBtlTi3UyyjNAcfJOYN629iUiyM4DObaH0xNIZzMVOQ8oAMhT/vZ+/T5/t60vPlIxME6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbi/adP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59B8C4CEED;
	Wed,  4 Jun 2025 00:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998738;
	bh=R4AXArGgkBB6bm9OCbCAf1hTi+Y225WLUU2GgmWqtC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbi/adP2gqTsCVSekyqfkjTrbQzFXN4JJE20pEyH6G6ADyiu9V37415EvcWJLk1Zn
	 YTj2+woicr2xZIyadvNLb3G0SsqFQyANYMzuAn8KWm4f/QQbU0uZmNaMFhA2Y3GMgk
	 /kpX2V16wAdf2GsnX1+41LPx3Odx4yzS24Rj2BsgfdlCL/iMQDFrBqAD3OZhKga2LX
	 uwfwT2yKBAYHKQjFwbyxlDoUpmARTwCkIksYuimwvHr0OunlZmskdhIUqwD4HwvPun
	 cfhjLrpFXXF27YCFZjk7WS5p3wbDqAdZwjziKUkBf7anOmY6d6TnJLtruUQt4RLjKs
	 NNYsAf6dAiMeQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sriram R <quic_srirrama@quicinc.com>,
	Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 102/108] wifi: ath12k: Fix the enabling of REO queue lookup table feature
Date: Tue,  3 Jun 2025 20:55:25 -0400
Message-Id: <20250604005531.4178547-102-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

[ Upstream commit 0bbcd42b15fa730f393a01bc818802d9f0b04197 ]

Instead of storing the REO queue address inside peer entries, REO
hardware module prefers them to be stored in SRAM which could be
directly accessed by REO using peer_ID/TID based lookup table
mechanism.

Fix the enabling of the REO queue lookup table(LUT) feature by
configuring the LUT address information in the REO hardware register
and setting the host service flags.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250402152529.1649402-2-quic_nithp@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## This is a Clear Bug Fix, Not a Feature
Implementation ### Evidence from Code Analysis: **1. Infrastructure
Already Existed:** - The `reoq_lut_support` field was already defined
and set to `true` for QCN9274 hardware in `hw.c` - Data structures for
`dp->reoq_lut` and `dp->ml_reoq_lut` were already present in `dp.h` -
Register definitions like `HAL_REO1_QDESC_LUT_BASE0/1` and
`HAL_REO_QDESC_ADDR_READ_LUT_ENABLE` were already defined - Memory
allocation code for these structures already existed **2. Specific
Issues Being Fixed:** **Missing Hardware Register Programming:** The key
fix is in `ath12k_dp_reoq_lut_setup()` where it adds proper register
configuration: ```c ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
HAL_REO1_QDESC_LUT_BASE0(ab), dp->reoq_lut.paddr >> 8);
ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
HAL_REO1_QDESC_ADDR(ab), val | HAL_REO_QDESC_ADDR_READ_LUT_ENABLE); ```
**Missing Host Service Flag:** The WMI initialization was missing the
flag to inform firmware: ```c if (ab->hw_params->reoq_lut_support)
wmi_cfg->host_service_flags |= cpu_to_le32(1 <<
WMI_RSRC_CFG_HOST_SVC_FLAG_REO_QREF_SUPPORT_BIT); ``` **3. Memory
Alignment Fix:** The changes to use `vaddr_unaligned`/`paddr_unaligned`
with `PTR_ALIGN()` fix a critical hardware requirement where the LUT
must be 256-byte aligned (`HAL_REO_QLUT_ADDR_ALIGN`). **4. Runtime Logic
Fix:** In `dp_rx.c`, the code now correctly chooses between peer
metadata and physical address based on `reoq_lut_support`: ```c if
(ab->hw_params->reoq_lut_support) { reo_ent_ring->queue_addr_lo =
reo_dest_ring->rx_mpdu_info.peer_meta_data; } else {
reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
} ``` ### Why This Qualifies for Backporting: 1. **Important Bugfix:**
The REO lookup table feature is critical for WiFi performance - it
allows hardware to directly access queue descriptors instead of storing
them in peer entries 2. **Small and Contained:** The changes are
localized to the ath12k driver and follow established patterns 3. **No
Architectural Changes:** This doesn't introduce new APIs or change
driver architecture 4. **Hardware-Specific:** Fixes functionality that
was supposed to work on QCN9274 hardware but was silently broken 5.
**Minimal Risk:** The changes only affect the specific code path when
`reoq_lut_support` is enabled ### Comparison to Similar Commits: This is
very similar to the "YES" example (#2: "wifi: ath12k: fix firmware crash
during reo reinject") which also fixed REO-related functionality. Both
address hardware register programming issues in the REO subsystem that
could cause silent failures or crashes. The commit properly fixes broken
functionality that users of QCN9274 hardware would expect to work,
making it an excellent candidate for stable tree backporting.

 drivers/net/wireless/ath/ath12k/dp.c    | 77 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h    |  5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 10 +++-
 drivers/net/wireless/ath/ath12k/hal.h   |  6 ++
 drivers/net/wireless/ath/ath12k/hw.c    |  2 +
 drivers/net/wireless/ath/ath12k/hw.h    |  3 +
 drivers/net/wireless/ath/ath12k/wmi.c   |  8 ++-
 drivers/net/wireless/ath/ath12k/wmi.h   |  1 +
 8 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9e5a4e75f2f62..e4778bc1e32ae 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1261,22 +1261,24 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	if (!ab->hw_params->reoq_lut_support)
 		return;
 
-	if (dp->reoq_lut.vaddr) {
+	if (dp->reoq_lut.vaddr_unaligned) {
 		ath12k_hif_write32(ab,
 				   HAL_SEQ_WCSS_UMAC_REO_REG +
 				   HAL_REO1_QDESC_LUT_BASE0(ab), 0);
-		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
-				  dp->reoq_lut.vaddr, dp->reoq_lut.paddr);
-		dp->reoq_lut.vaddr = NULL;
+		dma_free_coherent(ab->dev, dp->reoq_lut.size,
+				  dp->reoq_lut.vaddr_unaligned,
+				  dp->reoq_lut.paddr_unaligned);
+		dp->reoq_lut.vaddr_unaligned = NULL;
 	}
 
-	if (dp->ml_reoq_lut.vaddr) {
+	if (dp->ml_reoq_lut.vaddr_unaligned) {
 		ath12k_hif_write32(ab,
 				   HAL_SEQ_WCSS_UMAC_REO_REG +
 				   HAL_REO1_QDESC_LUT_BASE1(ab), 0);
-		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
-				  dp->ml_reoq_lut.vaddr, dp->ml_reoq_lut.paddr);
-		dp->ml_reoq_lut.vaddr = NULL;
+		dma_free_coherent(ab->dev, dp->ml_reoq_lut.size,
+				  dp->ml_reoq_lut.vaddr_unaligned,
+				  dp->ml_reoq_lut.paddr_unaligned);
+		dp->ml_reoq_lut.vaddr_unaligned = NULL;
 	}
 }
 
@@ -1605,39 +1607,66 @@ static int ath12k_dp_cc_init(struct ath12k_base *ab)
 	return ret;
 }
 
+static int ath12k_dp_alloc_reoq_lut(struct ath12k_base *ab,
+				    struct ath12k_reo_q_addr_lut *lut)
+{
+	lut->size =  DP_REOQ_LUT_SIZE + HAL_REO_QLUT_ADDR_ALIGN - 1;
+	lut->vaddr_unaligned = dma_alloc_coherent(ab->dev, lut->size,
+						  &lut->paddr_unaligned,
+						  GFP_KERNEL | __GFP_ZERO);
+	if (!lut->vaddr_unaligned)
+		return -ENOMEM;
+
+	lut->vaddr = PTR_ALIGN(lut->vaddr_unaligned, HAL_REO_QLUT_ADDR_ALIGN);
+	lut->paddr = lut->paddr_unaligned +
+		     ((unsigned long)lut->vaddr - (unsigned long)lut->vaddr_unaligned);
+	return 0;
+}
+
 static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
+	u32 val;
+	int ret;
 
 	if (!ab->hw_params->reoq_lut_support)
 		return 0;
 
-	dp->reoq_lut.vaddr = dma_alloc_coherent(ab->dev,
-						DP_REOQ_LUT_SIZE,
-						&dp->reoq_lut.paddr,
-						GFP_KERNEL | __GFP_ZERO);
-	if (!dp->reoq_lut.vaddr) {
+	ret = ath12k_dp_alloc_reoq_lut(ab, &dp->reoq_lut);
+	if (ret) {
 		ath12k_warn(ab, "failed to allocate memory for reoq table");
-		return -ENOMEM;
+		return ret;
 	}
 
-	dp->ml_reoq_lut.vaddr = dma_alloc_coherent(ab->dev,
-						   DP_REOQ_LUT_SIZE,
-						   &dp->ml_reoq_lut.paddr,
-						   GFP_KERNEL | __GFP_ZERO);
-	if (!dp->ml_reoq_lut.vaddr) {
+	ret = ath12k_dp_alloc_reoq_lut(ab, &dp->ml_reoq_lut);
+	if (ret) {
 		ath12k_warn(ab, "failed to allocate memory for ML reoq table");
-		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
-				  dp->reoq_lut.vaddr, dp->reoq_lut.paddr);
-		dp->reoq_lut.vaddr = NULL;
-		return -ENOMEM;
+		dma_free_coherent(ab->dev, dp->reoq_lut.size,
+				  dp->reoq_lut.vaddr_unaligned,
+				  dp->reoq_lut.paddr_unaligned);
+		dp->reoq_lut.vaddr_unaligned = NULL;
+		return ret;
 	}
 
+	/* Bits in the register have address [39:8] LUT base address to be
+	 * allocated such that LSBs are assumed to be zero. Also, current
+	 * design supports paddr upto 4 GB max hence it fits in 32 bit register only
+	 */
+
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab),
-			   dp->reoq_lut.paddr);
+			   dp->reoq_lut.paddr >> 8);
+
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE1(ab),
 			   dp->ml_reoq_lut.paddr >> 8);
 
+	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab));
+
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab),
+			   val | HAL_REO_QDESC_ADDR_READ_LUT_ENABLE);
+
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_MAX_PEERID(ab),
+			   HAL_REO_QDESC_MAX_PEERID);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7ac3143de0168..e8950a23ad4ab 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -310,8 +310,11 @@ struct ath12k_reo_queue_ref {
 } __packed;
 
 struct ath12k_reo_q_addr_lut {
-	dma_addr_t paddr;
+	u32 *vaddr_unaligned;
 	u32 *vaddr;
+	dma_addr_t paddr_unaligned;
+	dma_addr_t paddr;
+	u32 size;
 };
 
 struct ath12k_dp {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index cfa96c6216177..3ba603e06816b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3247,8 +3247,14 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	reo_ent_ring->rx_mpdu_info.peer_meta_data =
 		reo_dest_ring->rx_mpdu_info.peer_meta_data;
 
-	reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
-	queue_addr_hi = upper_32_bits(rx_tid->paddr);
+	if (ab->hw_params->reoq_lut_support) {
+		reo_ent_ring->queue_addr_lo = reo_dest_ring->rx_mpdu_info.peer_meta_data;
+		queue_addr_hi = 0;
+	} else {
+		reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
+		queue_addr_hi = upper_32_bits(rx_tid->paddr);
+	}
+
 	reo_ent_ring->info0 = le32_encode_bits(queue_addr_hi,
 					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
 			      le32_encode_bits(dst_ind,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 94e2e87359583..54a248d252415 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -21,6 +21,7 @@ struct ath12k_base;
 #define HAL_MAX_AVAIL_BLK_RES			3
 
 #define HAL_RING_BASE_ALIGN	8
+#define HAL_REO_QLUT_ADDR_ALIGN 256
 
 #define HAL_WBM_IDLE_SCATTER_BUF_SIZE_MAX	32704
 /* TODO: Check with hw team on the supported scatter buf size */
@@ -39,6 +40,7 @@ struct ath12k_base;
 #define HAL_OFFSET_FROM_HP_TO_TP		4
 
 #define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
+#define HAL_REO_QDESC_MAX_PEERID		8191
 
 /* WCSS Relative address */
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
@@ -132,6 +134,8 @@ struct ath12k_base;
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
+#define HAL_REO1_QDESC_ADDR(ab)		((ab)->hw_params->regs->hal_reo1_qdesc_addr)
+#define HAL_REO1_QDESC_MAX_PEERID(ab)	((ab)->hw_params->regs->hal_reo1_qdesc_max_peerid)
 #define HAL_REO1_SW_COOKIE_CFG0(ab)	((ab)->hw_params->regs->hal_reo1_sw_cookie_cfg0)
 #define HAL_REO1_SW_COOKIE_CFG1(ab)	((ab)->hw_params->regs->hal_reo1_sw_cookie_cfg1)
 #define HAL_REO1_QDESC_LUT_BASE0(ab)	((ab)->hw_params->regs->hal_reo1_qdesc_lut_base0)
@@ -319,6 +323,8 @@ struct ath12k_base;
 #define HAL_REO1_SW_COOKIE_CFG_ALIGN			BIT(18)
 #define HAL_REO1_SW_COOKIE_CFG_ENABLE			BIT(19)
 #define HAL_REO1_SW_COOKIE_CFG_GLOBAL_ENABLE		BIT(20)
+#define HAL_REO_QDESC_ADDR_READ_LUT_ENABLE		BIT(7)
+#define HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY	BIT(6)
 
 /* CE ring bit field mask and shift */
 #define HAL_CE_DST_R0_DEST_CTRL_MAX_LEN			GENMASK(15, 0)
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index b7b583fadb5ac..115635cdacc8a 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -730,6 +730,8 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
 	.hal_reo1_qdesc_lut_base0 = 0x00000074,
 	.hal_reo1_qdesc_lut_base1 = 0x00000078,
+	.hal_reo1_qdesc_addr = 0x0000007c,
+	.hal_reo1_qdesc_max_peerid = 0x00000088,
 	.hal_reo1_ring_base_lsb = 0x00000500,
 	.hal_reo1_ring_base_msb = 0x00000504,
 	.hal_reo1_ring_id = 0x00000508,
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 8d52182e28aef..7122cab2864ad 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -296,6 +296,9 @@ struct ath12k_hw_regs {
 
 	u32 hal_tcl_status_ring_base_lsb;
 
+	u32 hal_reo1_qdesc_addr;
+	u32 hal_reo1_qdesc_max_peerid;
+
 	u32 hal_wbm_idle_ring_base_lsb;
 	u32 hal_wbm_idle_ring_misc_addr;
 	u32 hal_wbm_r0_idle_list_cntl_addr;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d9ad70e46f7d8..de7e3e74d8c26 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3605,7 +3605,8 @@ ath12k_fill_band_to_mac_param(struct ath12k_base  *soc,
 }
 
 static void
-ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cfg,
+ath12k_wmi_copy_resource_config(struct ath12k_base *ab,
+				struct ath12k_wmi_resource_config_params *wmi_cfg,
 				struct ath12k_wmi_resource_config_arg *tg_cfg)
 {
 	wmi_cfg->num_vdevs = cpu_to_le32(tg_cfg->num_vdevs);
@@ -3672,6 +3673,9 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 					   WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION);
 	wmi_cfg->host_service_flags = cpu_to_le32(tg_cfg->is_reg_cc_ext_event_supported <<
 				WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT);
+	if (ab->hw_params->reoq_lut_support)
+		wmi_cfg->host_service_flags |=
+			cpu_to_le32(1 << WMI_RSRC_CFG_HOST_SVC_FLAG_REO_QREF_SUPPORT_BIT);
 	wmi_cfg->ema_max_vap_cnt = cpu_to_le32(tg_cfg->ema_max_vap_cnt);
 	wmi_cfg->ema_max_profile_period = cpu_to_le32(tg_cfg->ema_max_profile_period);
 	wmi_cfg->flags2 |= cpu_to_le32(WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET);
@@ -3712,7 +3716,7 @@ static int ath12k_init_cmd_send(struct ath12k_wmi_pdev *wmi,
 	ptr = skb->data + sizeof(*cmd);
 	cfg = ptr;
 
-	ath12k_wmi_copy_resource_config(cfg, &arg->res_cfg);
+	ath12k_wmi_copy_resource_config(ab, cfg, &arg->res_cfg);
 
 	cfg->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_RESOURCE_CONFIG,
 						 sizeof(*cfg));
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 45fe699ce8a5d..c6036b978f135 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2445,6 +2445,7 @@ struct wmi_init_cmd {
 } __packed;
 
 #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
+#define WMI_RSRC_CFG_HOST_SVC_FLAG_REO_QREF_SUPPORT_BIT   12
 #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
 #define WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET      BIT(9)
-- 
2.39.5


