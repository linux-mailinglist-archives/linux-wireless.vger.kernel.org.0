Return-Path: <linux-wireless+bounces-23703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B95ACE06A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EBD3A7E99
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC14290DA9;
	Wed,  4 Jun 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lysf+n/a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367B290D92;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047772; cv=none; b=Zw4Nma7bEJct46p38RK0mxBSIZx2LYSVESnmBJtBmM+HlI3ZfvPVB0xF8GRevYTAHU6OqXbj4WTwMAsScK2ZDGdZqs7mDodfne+QA5bfHjdQVBOT/mUGoqNRlc2FhL2okakYrMAYX0OkrGECW502lGjkYWIGZFnEQDDbjcQn9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047772; c=relaxed/simple;
	bh=DW6mEbuQyQES+wh95ZJKakXUt1S6KLMtCRzsr6ZDdtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhPkdiUQOAaDhjM4uZwt9pV6Q06swj15WFNGTGQCCSsTqbcE/ojczcWQClGsqLVuymJ6xP3j0bqppitKyGwS4sBKv0PXRcp/sjDueYTFHLBXsPJZ49QQODKwu4b+zki1l1hGee2Rk6FhrHFcJOn7oOOpCpUntvzmkk1fzNymi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lysf+n/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDFBC4CEEF;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047771;
	bh=DW6mEbuQyQES+wh95ZJKakXUt1S6KLMtCRzsr6ZDdtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lysf+n/azHWgbuQ9uSkAK1Ifb5SCGPn0sQRiTUEsGntJDK+/eR/FK+4ryOoOv8nF5
	 W2LwOSRVIVOTcBh15tVq9WbKcZpPs5T52PzF2jURQEa7BQv3qtrSO6bjtmahKRKKxT
	 HW/ZIejZ5o3qUM6q/W4gokOA+fZ/+7fqqhpKT+iBFIrOYJKmCngyiQOc0fuB0g8Nug
	 OXZ/WlBw9KUMdM5d1Sb0AHa7U8QWbOeoifl1K1qohgJhb5vrvYwAOaF1Y63tC2RXg5
	 bkk30pDpznPgDj9O2xbskVOoicVLeT9akWs7Vl2BMamTTZyp6i1u3YjY+tNQSWCCym
	 UEb76AQbavP4w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpDt-000000006nM-38jX;
	Wed, 04 Jun 2025 16:36:09 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 3/5] wifi: ath11k: use plain accesses for monitor descriptor
Date: Wed,  4 Jun 2025 16:34:55 +0200
Message-ID: <20250604143457.26032-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604143457.26032-1-johan+linaro@kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
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

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index d8dab182a9af..218ab41c0f3c 100644
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
@@ -2654,7 +2654,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
 		cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
-				   READ_ONCE(desc->buf_addr_info.info1));
+				   desc->buf_addr_info.info1);
 		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
@@ -2683,9 +2683,8 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		num_buffs_reaped[mac_id]++;
 
-		info0 = READ_ONCE(desc->info0);
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
-					info0);
+					desc->info0);
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
@@ -2693,21 +2692,18 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
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


