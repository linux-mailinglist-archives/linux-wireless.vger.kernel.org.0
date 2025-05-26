Return-Path: <linux-wireless+bounces-23425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15670AC3EDB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 13:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FA2177C25
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50201FA14E;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0Yv09b1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586D1F429C;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260104; cv=none; b=HGHIaz5NYcPA0u/S7Zx83EBQlHFTxnZoJwzs1OXFnl9CjWAC96oL9xDmRJhJf1pHGEt2Zl0XEnljHZ5Mbrf3xbYa/lnZeghUWO5EYfF92302PirQPYE263PrPYyfdWb998pTkIyTq6PU7iUJtUVT4rcgt3jD2q0JUIkozNL3nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260104; c=relaxed/simple;
	bh=QrLLMqTyR7YAQGK5tv4IbrNqrw7xUDpHrWfnkyxz8Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/ANxR8o6bXB1LpiWpBdMULT8q6f7XDiw3ObPpr5uSI8PuadK3DmwXx72ZvbJv5772h9XBr1bDXWD58HHVCinYhiJLC7z/0z8ZJOKNZAYd74aA/bIrnL9v5FnFDISdd0GSVW1EfXVYxS6EG7GbwG1HllDX10FmbXTnm6P8r9oIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0Yv09b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A2BC4CEF2;
	Mon, 26 May 2025 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748260103;
	bh=QrLLMqTyR7YAQGK5tv4IbrNqrw7xUDpHrWfnkyxz8Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0Yv09b1t3/ZqYFbSGFyWxqb4yX1hzYNHC6UhOKAH0c8RoDKbXWE88Rx5pbWmGjWf
	 WhvmkZCFNUsyr6AjaVxxi/SmlASjcdk/Zog4xv2na2waXB6kMHGcrISziYu1xvdC2x
	 nu/PtKEJ7sAXCAREZSWoQoQBzS+Ea2dExfKJdxJNOBIYb8KzRdC0Oz+5H6Lwo5NN/V
	 3shvvaiJ0eZmGhFVbw/T4KmlqjZr6EboW+ouyVzDGoqKWLa9P/vzEX73MHRDl8Wu+4
	 scIvfvLn+duOjrB/beWDW7I1mkDn+GGsESp4adlsjzCfW80OAQTA+Nd916TUW7VTuL
	 Mld4ZEL+Axdnw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uJWJd-000000000Ys-1KI0;
	Mon, 26 May 2025 13:48:25 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Date: Mon, 26 May 2025 13:48:01 +0200
Message-ID: <20250526114803.2122-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526114803.2122-1-johan+linaro@kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing memory barriers to make sure that destination ring
descriptors are read after the head pointers to avoid using stale data
on weakly ordered architectures like aarch64.

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org	# 5.6
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 19 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp_tx.c |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index ea2959305dec..dfe2d889c20f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3851,6 +3851,9 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 
 	ath11k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (budget &&
 	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
 		struct hal_reo_dest_ring *reo_desc = (struct hal_reo_dest_ring *)desc;
@@ -4154,6 +4157,9 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
 
 	ath11k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (budget) {
 		rx_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
 		if (!rx_desc)
@@ -4280,6 +4286,9 @@ int ath11k_dp_process_rxdma_err(struct ath11k_base *ab, int mac_id, int budget)
 
 	ath11k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (quota-- &&
 	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
 		ath11k_hal_rx_reo_ent_paddr_get(ab, desc, &paddr, &desc_bank);
@@ -4353,6 +4362,9 @@ void ath11k_dp_process_reo_status(struct ath11k_base *ab)
 
 	ath11k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while ((reo_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
 		tag = FIELD_GET(HAL_SRNG_TLV_HDR_TAG, *reo_desc);
 
@@ -5168,6 +5180,9 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 	rx_bufs_used = 0;
 	rx_mon_stats = &pmon->rx_mon_stats;
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
 		struct sk_buff *head_msdu, *tail_msdu;
 
@@ -5630,6 +5645,10 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 	spin_lock_bh(&mon_dst_srng->lock);
 
 	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
+
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
 		head_msdu = NULL;
 		tail_msdu = NULL;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8522c67baabf..549d17d90503 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -700,6 +700,9 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 
 	ath11k_hal_srng_access_begin(ab, status_ring);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while ((ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) !=
 		tx_ring->tx_status_tail) &&
 	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, status_ring))) {
-- 
2.49.0


