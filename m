Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352240B50C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhINQjd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 12:39:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11370 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhINQjc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 12:39:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631637495; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AjZNeG4oyZL3KsTyL0XmdkrRRy3JrzKv2gwNejDOtCQ=; b=LeJn2pQ8TUVFuZ5n835KD1Dh3E2g5PfwC5uldgPsWoO6EZ6roGvSYBNcQAbezELNsAejU049
 Ch7glDN5TaNSFKiheoVdC7ZCO0hv1xF59cxKcnP2YVsyRNAczt24lF5434ktymQlq9iKPcTf
 kBjqBTRXbU31o11kBfXZY7D8RTo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6140cfd1bd6681d8edd06e6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 16:37:37
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07487C43619; Tue, 14 Sep 2021 16:37:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3501C4361A;
        Tue, 14 Sep 2021 16:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B3501C4361A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/3] ath11k: change return buffer manager for QCA6390
Date:   Tue, 14 Sep 2021 19:37:25 +0300
Message-Id: <20210914163726.38604-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914163726.38604-1-jouni@codeaurora.org>
References: <20210914163726.38604-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

QCA6390 firmware uses HAL_RX_BUF_RBM_SW1_BM, not HAL_RX_BUF_RBM_SW3_BM.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c   |  5 +++++
 drivers/net/wireless/ath/ath11k/dp.c     |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 22 +++++++++++-----------
 drivers/net/wireless/ath/ath11k/hal.c    |  8 ++++++++
 drivers/net/wireless/ath/ath11k/hal.h    |  7 +++++++
 drivers/net/wireless/ath/ath11k/hal_rx.c |  2 +-
 drivers/net/wireless/ath/ath11k/hw.c     |  3 ++-
 drivers/net/wireless/ath/ath11k/hw.h     |  1 +
 8 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index af76e37d11ae..265ff225bd81 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -82,6 +82,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fix_l1ss = true,
 		.sram_dump = NULL,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
+		.hal_params = &ath11k_hal_params_ipq8074,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -131,6 +132,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fix_l1ss = true,
 		.sram_dump = NULL,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
+		.hal_params = &ath11k_hal_params_ipq8074,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -179,6 +181,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fix_l1ss = true,
 		.sram_dump = &sram_dump_qca6390,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
+		.hal_params = &ath11k_hal_params_qca6390,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -227,6 +230,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fix_l1ss = true,
 		.sram_dump = NULL,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
+		.hal_params = &ath11k_hal_params_ipq8074,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -274,6 +278,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fix_l1ss = false,
 		.sram_dump = &sram_dump_wcn6855,
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
+		.hal_params = &ath11k_hal_params_qca6390,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f7049a13973d..4a4f30e933a3 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -822,7 +822,7 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 				struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 
 				ath11k_dp_rxbufs_replenish(ab, id, rx_ring, 0,
-							   HAL_RX_BUF_RBM_SW3_BM);
+							   ab->hw_params.hal_params->rx_buf_rbm);
 			}
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c50f70913583..913e8a9878eb 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -499,7 +499,7 @@ static int ath11k_dp_rxdma_ring_buf_setup(struct ath11k *ar,
 
 	rx_ring->bufs_max = num_entries;
 	ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id, rx_ring, num_entries,
-				   HAL_RX_BUF_RBM_SW3_BM);
+				   ar->ab->hw_params.hal_params->rx_buf_rbm);
 	return 0;
 }
 
@@ -2756,7 +2756,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 
 		ath11k_dp_rxbufs_replenish(ab, i, rx_ring, num_buffs_reaped[i],
-					   HAL_RX_BUF_RBM_SW3_BM);
+					   ab->hw_params.hal_params->rx_buf_rbm);
 	}
 
 	ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list,
@@ -3070,7 +3070,7 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 
 		if (!skb) {
 			ath11k_hal_rx_buf_addr_info_set(rx_mon_status_desc, 0, 0,
-							HAL_RX_BUF_RBM_SW3_BM);
+							ab->hw_params.hal_params->rx_buf_rbm);
 			num_buffs_reaped++;
 			break;
 		}
@@ -3080,7 +3080,7 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 			 FIELD_PREP(DP_RXDMA_BUF_COOKIE_BUF_ID, buf_id);
 
 		ath11k_hal_rx_buf_addr_info_set(rx_mon_status_desc, rxcb->paddr,
-						cookie, HAL_RX_BUF_RBM_SW3_BM);
+						cookie, ab->hw_params.hal_params->rx_buf_rbm);
 		ath11k_hal_srng_src_get_next_entry(ab, srng);
 		num_buffs_reaped++;
 	}
@@ -3469,7 +3469,7 @@ static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_ti
 	cookie = FIELD_PREP(DP_RXDMA_BUF_COOKIE_PDEV_ID, dp->mac_id) |
 		 FIELD_PREP(DP_RXDMA_BUF_COOKIE_BUF_ID, buf_id);
 
-	ath11k_hal_rx_buf_addr_info_set(msdu0, paddr, cookie, HAL_RX_BUF_RBM_SW3_BM);
+	ath11k_hal_rx_buf_addr_info_set(msdu0, paddr, cookie, ab->hw_params.hal_params->rx_buf_rbm);
 
 	/* Fill mpdu details into reo entrace ring */
 	srng = &ab->hal.srng_list[ab->dp.reo_reinject_ring.ring_id];
@@ -3846,7 +3846,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 		ath11k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
 		if (rbm != HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST &&
-		    rbm != HAL_RX_BUF_RBM_SW3_BM) {
+		    rbm != ab->hw_params.hal_params->rx_buf_rbm) {
 			ab->soc_stats.invalid_rbm++;
 			ath11k_warn(ab, "invalid return buffer manager %d\n", rbm);
 			ath11k_dp_rx_link_desc_return(ab, desc,
@@ -3902,7 +3902,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 
 		ath11k_dp_rxbufs_replenish(ab, i, rx_ring, n_bufs_reaped[i],
-					   HAL_RX_BUF_RBM_SW3_BM);
+					   ab->hw_params.hal_params->rx_buf_rbm);
 	}
 
 	return tot_n_bufs_reaped;
@@ -4198,7 +4198,7 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 
 		ath11k_dp_rxbufs_replenish(ab, i, rx_ring, num_buffs_reaped[i],
-					   HAL_RX_BUF_RBM_SW3_BM);
+					   ab->hw_params.hal_params->rx_buf_rbm);
 	}
 
 	rcu_read_lock();
@@ -4307,7 +4307,7 @@ int ath11k_dp_process_rxdma_err(struct ath11k_base *ab, int mac_id, int budget)
 
 	if (num_buf_freed)
 		ath11k_dp_rxbufs_replenish(ab, mac_id, rx_ring, num_buf_freed,
-					   HAL_RX_BUF_RBM_SW3_BM);
+					   ab->hw_params.hal_params->rx_buf_rbm);
 
 	return budget - quota;
 }
@@ -5101,12 +5101,12 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 			ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id,
 						   &dp->rxdma_mon_buf_ring,
 						   rx_bufs_used,
-						   HAL_RX_BUF_RBM_SW3_BM);
+						   ar->ab->hw_params.hal_params->rx_buf_rbm);
 		else
 			ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id,
 						   &dp->rx_refill_buf_ring,
 						   rx_bufs_used,
-						   HAL_RX_BUF_RBM_SW3_BM);
+						   ar->ab->hw_params.hal_params->rx_buf_rbm);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index eaa0edca5576..f1492cde84ed 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -189,6 +189,14 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 	},
 };
 
+const struct hal_param ath11k_hal_params_ipq8074 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
+};
+
+const struct hal_param ath11k_hal_params_qca6390 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
+};
+
 static int ath11k_hal_alloc_cont_rdp(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 35ed3a14e200..1bf6e040120f 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -903,6 +903,13 @@ struct ath11k_hal {
 	int num_shadow_reg_configured;
 };
 
+struct hal_param {
+	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
+};
+
+extern const struct hal_param ath11k_hal_params_ipq8074;
+extern const struct hal_param ath11k_hal_params_qca6390;
+
 u32 ath11k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
 				u32 start_seq, enum hal_pn_type type);
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index f072c95e7434..d4d1c4a9785f 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -372,7 +372,7 @@ int ath11k_hal_wbm_desc_parse_err(struct ath11k_base *ab, void *desc,
 		return -EINVAL;
 
 	if (FIELD_GET(BUFFER_ADDR_INFO1_RET_BUF_MGR,
-		      wbm_desc->buf_addr_info.info1) != HAL_RX_BUF_RBM_SW3_BM) {
+		      wbm_desc->buf_addr_info.info1) != ab->hw_params.hal_params->rx_buf_rbm) {
 		ab->soc_stats.invalid_rbm++;
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 57fab9d085d0..fdfb379b4d08 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -7,10 +7,11 @@
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 
-#include "hw.h"
 #include "core.h"
 #include "ce.h"
 #include "hif.h"
+#include "hal.h"
+#include "hw.h"
 
 /* Map from pdev index to hw mac index */
 static u8 ath11k_hw_ipq8074_mac_from_pdev_id(int pdev_idx)
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 6e68c5b60eaa..c6831fb110ba 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -179,6 +179,7 @@ struct ath11k_hw_params {
 	bool fix_l1ss;
 	const struct ath11k_hw_sram_dump *sram_dump;
 	u8 max_tx_ring;
+	const struct hal_param *hal_params;
 };
 
 struct ath11k_hw_ops {
-- 
2.25.1

