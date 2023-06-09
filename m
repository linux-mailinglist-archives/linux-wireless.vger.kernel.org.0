Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDA729CC5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbjFIOZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbjFIOY5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1195430CB
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4186612DC
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE7AC433D2;
        Fri,  9 Jun 2023 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320695;
        bh=5i99cUkq1B4SGCP8fEXbgGBI5XY6g3CdaJyGemCE0UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjOW/rG8vT9TqHPUuRSOftFBa7OyA99Ik2YVych61dD8r39HRnyg5r9+JHIEMPoGI
         S7umkhxZg/0j3YKyafPpz9hkN60Ti64LGFT0rrTLlf/HDxwU1AjeGetBgjEVimbbML
         dBP4yDsGT+JVfX6LLTol4hFzjW/Y/EuGjdBOJOKB56JDn6HuIt6zwXSa/UrNhmZwu7
         Fr1IZUlRNviSd33S++pSv7BAu87nXlKjSwLuwoAs5BjJn2qJvIjx7O2uCBCpUnRtHd
         dUZEhhxlRSn5ne2j5HXDwaFcRW9tKZkTwDNzlPJSHtmQfPv8wMO6TlwV9AGsMKKKXz
         EuP2tw0anTk4w==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 11/15] wifi: ath11k: debug: use all upper case in ATH11k_DBG_HAL
Date:   Fri,  9 Jun 2023 17:24:36 +0300
Message-Id: <20230609142440.24643-12-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Somehow the character 'k' in ATH11k_DBG_HAL was in lower case. Change it to
upper case.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debug.h  |  4 ++--
 drivers/net/wireless/ath/ath11k/hal.c    |  6 +++---
 drivers/net/wireless/ath/ath11k/hal_rx.c | 24 ++++++++++++------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 2dd84d8ed5a5..f0dddd188ef0 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -22,7 +22,7 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_MGMT		= 0x00000100,
 	ATH11K_DBG_REG		= 0x00000200,
 	ATH11K_DBG_TESTMODE	= 0x00000400,
-	ATH11k_DBG_HAL		= 0x00000800,
+	ATH11K_DBG_HAL		= 0x00000800,
 	ATH11K_DBG_PCI		= 0x00001000,
 	ATH11K_DBG_DP_TX	= 0x00002000,
 	ATH11K_DBG_DP_RX	= 0x00004000,
@@ -53,7 +53,7 @@ static inline const char *ath11k_dbg_str(enum ath11k_debug_mask mask)
 		return "reg";
 	case ATH11K_DBG_TESTMODE:
 		return "testmode";
-	case ATH11k_DBG_HAL:
+	case ATH11K_DBG_HAL:
 		return "hal";
 	case ATH11K_DBG_PCI:
 		return "pci";
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 2cdc8478d253..148eeb06a906 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1009,7 +1009,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 				srng->u.src_ring.hp_addr =
 				(u32 *)((unsigned long)ab->mem + reg_base);
 			else
-				ath11k_dbg(ab, ATH11k_DBG_HAL,
+				ath11k_dbg(ab, ATH11K_DBG_HAL,
 					   "type %d ring_num %d reg_base 0x%x shadow 0x%lx\n",
 					   type, ring_num,
 					   reg_base,
@@ -1043,7 +1043,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 				(u32 *)((unsigned long)ab->mem + reg_base +
 					(HAL_REO1_RING_TP(ab) - HAL_REO1_RING_HP(ab)));
 			else
-				ath11k_dbg(ab, ATH11k_DBG_HAL,
+				ath11k_dbg(ab, ATH11K_DBG_HAL,
 					   "type %d ring_num %d target_reg 0x%x shadow 0x%lx\n",
 					   type, ring_num,
 					   reg_base + (HAL_REO1_RING_TP(ab) -
@@ -1118,7 +1118,7 @@ int ath11k_hal_srng_update_shadow_config(struct ath11k_base *ab,
 	ath11k_hal_srng_update_hp_tp_addr(ab, shadow_cfg_idx, ring_type,
 					  ring_num);
 
-	ath11k_dbg(ab, ATH11k_DBG_HAL,
+	ath11k_dbg(ab, ATH11K_DBG_HAL,
 		   "target_reg %x, shadow reg 0x%x shadow_idx 0x%x, ring_type %d, ring num %d",
 		  target_reg,
 		  HAL_SHADOW_REG(ab, shadow_cfg_idx),
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index bb1d40034aa8..e5ed5efb139e 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -442,54 +442,54 @@ void ath11k_hal_reo_status_queue_stats(struct ath11k_base *ab, u32 *reo_desc,
 				FIELD_GET(HAL_REO_STATUS_HDR_INFO0_EXEC_STATUS,
 					  desc->hdr.info0);
 
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "Queue stats status:\n");
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "header: cmd_num %d status %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "Queue stats status:\n");
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "header: cmd_num %d status %d\n",
 		   status->uniform_hdr.cmd_num,
 		   status->uniform_hdr.cmd_status);
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "ssn %ld cur_idx %ld\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "ssn %ld cur_idx %ld\n",
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO0_SSN,
 			     desc->info0),
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO0_CUR_IDX,
 			     desc->info0));
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "pn = [%08x, %08x, %08x, %08x]\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "pn = [%08x, %08x, %08x, %08x]\n",
 		   desc->pn[0], desc->pn[1], desc->pn[2], desc->pn[3]);
-	ath11k_dbg(ab, ATH11k_DBG_HAL,
+	ath11k_dbg(ab, ATH11K_DBG_HAL,
 		   "last_rx: enqueue_tstamp %08x dequeue_tstamp %08x\n",
 		   desc->last_rx_enqueue_timestamp,
 		   desc->last_rx_dequeue_timestamp);
-	ath11k_dbg(ab, ATH11k_DBG_HAL,
+	ath11k_dbg(ab, ATH11K_DBG_HAL,
 		   "rx_bitmap [%08x %08x %08x %08x %08x %08x %08x %08x]\n",
 		   desc->rx_bitmap[0], desc->rx_bitmap[1], desc->rx_bitmap[2],
 		   desc->rx_bitmap[3], desc->rx_bitmap[4], desc->rx_bitmap[5],
 		   desc->rx_bitmap[6], desc->rx_bitmap[7]);
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "count: cur_mpdu %ld cur_msdu %ld\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "count: cur_mpdu %ld cur_msdu %ld\n",
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO1_MPDU_COUNT,
 			     desc->info1),
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO1_MSDU_COUNT,
 			     desc->info1));
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "fwd_timeout %ld fwd_bar %ld dup_count %ld\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "fwd_timeout %ld fwd_bar %ld dup_count %ld\n",
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO2_TIMEOUT_COUNT,
 			     desc->info2),
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO2_FDTB_COUNT,
 			     desc->info2),
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO2_DUPLICATE_COUNT,
 			     desc->info2));
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "frames_in_order %ld bar_rcvd %ld\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "frames_in_order %ld bar_rcvd %ld\n",
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO3_FIO_COUNT,
 			     desc->info3),
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO3_BAR_RCVD_CNT,
 			     desc->info3));
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "num_mpdus %d num_msdus %d total_bytes %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "num_mpdus %d num_msdus %d total_bytes %d\n",
 		   desc->num_mpdu_frames, desc->num_msdu_frames,
 		   desc->total_bytes);
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "late_rcvd %ld win_jump_2k %ld hole_cnt %ld\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "late_rcvd %ld win_jump_2k %ld hole_cnt %ld\n",
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO4_LATE_RX_MPDU,
 			     desc->info4),
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO4_WINDOW_JMP2K,
 			     desc->info4),
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO4_HOLE_COUNT,
 			     desc->info4));
-	ath11k_dbg(ab, ATH11k_DBG_HAL, "looping count %ld\n",
+	ath11k_dbg(ab, ATH11K_DBG_HAL, "looping count %ld\n",
 		   FIELD_GET(HAL_REO_GET_QUEUE_STATS_STATUS_INFO5_LOOPING_CNT,
 			     desc->info5));
 }
-- 
2.30.2

