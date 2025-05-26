Return-Path: <linux-wireless+bounces-23426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A058AC3EDC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 13:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033DB177C29
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814B1FBC94;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR4tx5/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B31F7580;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260104; cv=none; b=J2MUx9iExj774LZjP1PLfI3uuBLnS4SSQKaVufJb7DETqjN5yRBdYs0LYijPbJeMgIjhHT4e9pxe3ofRKgo9oXT1Asy2gubUs8zCiTLazQN7OBMcQJn/FO0uaKKbhBR4h2oj9/4lxBHI9gcf1eHJzcinnqWsTA/it7ttO2xVweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260104; c=relaxed/simple;
	bh=GjZfpYND9lP/NheppZ2lHvUCIf1VyizdpRiD68UpiOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e228Wl/wyY+CLpRcAY50TYbo9sDKpeNADyE8FAoPUo71OscX1Cl1GfF8ZYRVEOAmxeYIjjKgE4k3TFbIqVh02uGDa9Chduofz/imHQbPpjH5zhyNqoSNWzJPPxdhPDgVTjlyS7ppCzT0GkSxAP9A7f5/HWYd6pbWspRN2zgFjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR4tx5/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16835C4CEFE;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748260104;
	bh=GjZfpYND9lP/NheppZ2lHvUCIf1VyizdpRiD68UpiOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XR4tx5/2x0yVOR3cjvylsRGD7k6Q8GxVxFExDUx+6osaICv6NL6PoaEEw9QeCmUqi
	 31dOHd1Q2vN0P8Wz1NaGGeu3JxBpAqaEyeHMVu+ueQ/dJK+Qm1CkKDWpyC+ZL8gxQX
	 HauUfCoxha2Q4FRxfrhwoS3gLN/I6ID65pibWoJK35I7hc8WKrrCkrM6FhF7/IzcTO
	 tqHm7+11nM1hVb+M9Nf6Blj+Ce2OrTm2CepLIaoOi93hWKgjekKCLnC2ZtuYRpg2/u
	 VE1ALIbicFD6M2IOK3hYeV496k+it1TbgK4Zw1sOFOqLKEi1mhMNJeuzWUydCsSkHZ
	 t0TjOOsIp5NHQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uJWJd-000000000Yx-252S;
	Mon, 26 May 2025 13:48:25 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] wifi: ath11k: use plain accesses for monitor descriptor
Date: Mon, 26 May 2025 13:48:03 +0200
Message-ID: <20250526114803.2122-4-johan+linaro@kernel.org>
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

The read memory barrier added by commit ab52e3e44fe9 ("wifi: ath11k: fix
rx completion meta data corruption") is enough to guarantee ordering
also for plain descriptor accesses so drop the unnecessary READ_ONCE().

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index dfe2d889c20f..37deb78044c8 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2637,7 +2637,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	struct ath11k *ar;
 	struct hal_reo_dest_ring *desc;
 	enum hal_reo_dest_ring_push_reason push_reason;
-	u32 cookie, info0, rx_msdu_info0, rx_mpdu_info0;
+	u32 cookie;
 	int i;
 
 	for (i = 0; i < MAX_RADIOS; i++)
@@ -2657,7 +2657,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
 		cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
-				   READ_ONCE(desc->buf_addr_info.info1));
+				   desc->buf_addr_info.info1);
 		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
@@ -2686,9 +2686,8 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		num_buffs_reaped[mac_id]++;
 
-		info0 = READ_ONCE(desc->info0);
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
-					info0);
+					desc->info0);
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
@@ -2696,21 +2695,18 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 			continue;
 		}
 
-		rx_msdu_info0 = READ_ONCE(desc->rx_msdu_info.info0);
-		rx_mpdu_info0 = READ_ONCE(desc->rx_mpdu_info.info0);
-
-		rxcb->is_first_msdu = !!(rx_msdu_info0 &
+		rxcb->is_first_msdu = !!(desc->rx_msdu_info.info0 &
 					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
-		rxcb->is_last_msdu = !!(rx_msdu_info0 &
+		rxcb->is_last_msdu = !!(desc->rx_msdu_info.info0 &
 					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
-		rxcb->is_continuation = !!(rx_msdu_info0 &
+		rxcb->is_continuation = !!(desc->rx_msdu_info.info0 &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
 		rxcb->peer_id = FIELD_GET(RX_MPDU_DESC_META_DATA_PEER_ID,
-					  READ_ONCE(desc->rx_mpdu_info.meta_data));
+					  desc->rx_mpdu_info.meta_data);
 		rxcb->seq_no = FIELD_GET(RX_MPDU_DESC_INFO0_SEQ_NUM,
-					 rx_mpdu_info0);
+					 desc->rx_mpdu_info.info0);
 		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
-				      info0);
+				      desc->info0);
 
 		rxcb->mac_id = mac_id;
 		__skb_queue_tail(&msdu_list[mac_id], msdu);
-- 
2.49.0


