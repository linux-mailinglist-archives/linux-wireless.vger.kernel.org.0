Return-Path: <linux-wireless+bounces-27108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600EB4953D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DAA1B257ED
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29C30E84B;
	Mon,  8 Sep 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GQ+DglWz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59B30E0C8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348922; cv=none; b=IM6uvRM2DZLFuY/Zw9uWF1GwPUr9MigpeDzkA/ZPVLsb1e6yaXImK58kcZ7LQOdRjmEs1vPV4vTIcNOtEkU2CG8R92rCF9biA4HoMhKfrb5y76Z21NG/Gu3G7eCQPcDqcJFZHU29Jn6E8AoI5X9aKzKpk40hI72cSlw7+b4QbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348922; c=relaxed/simple;
	bh=CwmfrfPpz+MTw7Eju7W0l30hJZB55dEL9/ZkFEEa3Qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsLMM5zFP++tT+0MN+3z31/ps/+ZHZOnlVI9UaLgUILFItho46jDmjFHyuB23oczGdGmqdKmLBIZGXhKM/2bOupC3Hmc+IU9SbpTFIScVdykQUv6G9xPx9Us+zdXy0YoWzsUzavk1VUOVHGurgusr5rtFJqwJXROh4HcVmIu1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GQ+DglWz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GReoH023845;
	Mon, 8 Sep 2025 16:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ted5nPW6Cblv0ATTYjuZxWFnkSc52ScDZvfZjRC40tM=; b=GQ+DglWztQTizJ9R
	eTl5iC8XKGX8wWhd1txGH/WLn0XpwzlN1JMD9Lv8Xg5wzfOMIVp/7h3jhvT/0NcU
	AWS6ayZdl32oORBWua5ortHISwzfHEq2yXeRkdwZyr03+hdvMJY9xbPw7tQTK7bu
	jN9Y5Xo8Z5D2/Z6HgpvEYDJeMEZ8bRHEDi9nDl5H9ZlqYziCefaE9yg/MYEwgpG/
	d3wT5zTv84KrIbrsCXXls+qDrDIH5N3fgivDOJybcV/nPTDz9dT8/PHzz3gw9Aal
	k30SAVIvtinogQTsH4NjEmgQOF3iuNAuf9aIbm04gUDriTYzeJLEDLdRc/RhCnGR
	zcUXOg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0n8s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:28:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588GSW43004709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 16:28:32 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 09:28:31 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 8/8] wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx
Date: Mon, 8 Sep 2025 21:57:57 +0530
Message-ID: <20250908162757.2938849-9-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908162757.2938849-1-quic_rdeuri@quicinc.com>
References: <20250908162757.2938849-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xdscMzPJWGYsDr_woMXWwWQ8efssgTZQ
X-Proofpoint-GUID: xdscMzPJWGYsDr_woMXWwWQ8efssgTZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX6VI1eI3p8iLf
 kh1KEH6k/8tQ4U/UpjCYe1PVfzyZhZwfQnZ3xyTend8s1aHZUQcWRPFZEOTmzoEVWO+FxH0YGNU
 xksNYIqLWLCecTjRzunvyJO6TZdSSC0WFoVgyFyQ8Ry2exOzGGSxchef4WRlLptsLhMMqQgonON
 5fNkh/kHD4IChY4+vD8uEux1YSJU4rjtg3jk3t4b0JiBjsWTZXpzvoNB/cU4OTm+picrDSn73bt
 4SEOaZVI7aP+NFe+ifBqJ8mmOy+W4KquoinVB6RmlNr/6f6nu8b62xhYGOz/a+fMUUhwrFcQKL6
 laLHgh7OUiTbNcUP53TMPpFR6lTR1vlgYQ52xHIELG5FIOQzME4hbzo9tO/VKoElLBIKJAMCHmk
 HvAWX2zN
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bf0431 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=FLr-2qPtnkwHCMKYjdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Change the API prefixes to ath12k_wifi7_ from ath12k_ in all the tx
and rx related files within wifi7 directory.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c         |   2 +-
 drivers/net/wireless/ath/ath12k/dbring.c      |   5 +-
 drivers/net/wireless/ath/ath12k/dp.c          |  11 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |  28 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  43 +-
 drivers/net/wireless/ath/ath12k/hal.h         |  15 +-
 drivers/net/wireless/ath/ath12k/mac.c         |   6 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  19 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   5 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 372 +++++++++---------
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  66 ++--
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  49 +--
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   8 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    | 161 ++++----
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |  82 ++--
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |  13 +-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |  18 +-
 18 files changed, 469 insertions(+), 436 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index ed61dc7ffa68..168d588604a1 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -527,7 +527,7 @@ static int ath12k_ahb_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 	struct ath12k_base *ab = irq_grp->ab;
 	int work_done;
 
-	work_done = ath12k_dp_service_srng(ab, irq_grp, budget);
+	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 		ath12k_ahb_ext_grp_enable(irq_grp);
diff --git a/drivers/net/wireless/ath/ath12k/dbring.c b/drivers/net/wireless/ath/ath12k/dbring.c
index 6604dacea2ae..093298f8acab 100644
--- a/drivers/net/wireless/ath/ath12k/dbring.c
+++ b/drivers/net/wireless/ath/ath12k/dbring.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -55,7 +54,7 @@ static int ath12k_dbring_bufs_replenish(struct ath12k *ar,
 	cookie = u32_encode_bits(ar->pdev_idx, DP_RXDMA_BUF_COOKIE_PDEV_ID) |
 		 u32_encode_bits(buf_id, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
-	ath12k_hal_rx_buf_addr_info_set(desc, paddr, cookie, 0);
+	ath12k_wifi7_hal_rx_buf_addr_info_set(desc, paddr, cookie, 0);
 
 	ath12k_hal_srng_access_end(ab, srng);
 
@@ -298,7 +297,7 @@ int ath12k_dbring_buffer_release_event(struct ath12k_base *ab,
 
 		num_buff_reaped++;
 
-		ath12k_hal_rx_buf_addr_info_get(&desc, &paddr, &cookie, &rbm);
+		ath12k_wifi7_hal_rx_buf_addr_info_get(&desc, &paddr, &cookie, &rbm);
 
 		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9dd602311433..986896c3bfeb 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -96,7 +96,7 @@ int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
 	}
 
 	for (tid--; tid >= 0; tid--)
-		ath12k_dp_rx_peer_tid_delete(ar, peer, tid);
+		ath12k_wifi7_dp_rx_peer_tid_delete(ar, peer, tid);
 
 	spin_unlock_bh(&ab->base_lock);
 
@@ -418,7 +418,8 @@ static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab,
 	spin_unlock_bh(&dp->tx_bank_lock);
 
 	if (configure_register)
-		ath12k_hal_tx_configure_bank_register(ab, bank_config, bank_id);
+		ath12k_wifi7_hal_tx_configure_bank_register(ab, bank_config,
+							    bank_id);
 
 	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt tcl bank_id %d input 0x%x match 0x%x num_users %u",
 		   bank_id, bank_config, dp->bank_profiles[bank_id].bank_config,
@@ -554,7 +555,7 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 	}
 
 	srng = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
-	ath12k_hal_reo_init_cmd_ring(ab, srng);
+	ath12k_wifi7_hal_reo_init_cmd_ring(ab, srng);
 
 	ret = ath12k_dp_srng_setup(ab, &dp->reo_status_ring, HAL_REO_STATUS,
 				   0, 0, DP_REO_STATUS_RING_SIZE);
@@ -578,7 +579,7 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 			HAL_HASH_ROUTING_RING_SW3 << 24 |
 			HAL_HASH_ROUTING_RING_SW4 << 28;
 
-	ath12k_hal_reo_hw_setup(ab, ring_hash_map);
+	ath12k_wifi7_hal_reo_hw_setup(ab, ring_hash_map);
 
 	return 0;
 
@@ -1635,7 +1636,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < HAL_DSCP_TID_MAP_TBL_NUM_ENTRIES_MAX; i++)
-		ath12k_hal_tx_set_dscp_tid_map(ab, i);
+		ath12k_wifi7_hal_tx_set_dscp_tid_map(ab, i);
 
 	ret = ath12k_dp_rx_alloc(ab);
 	if (ret)
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 3315a9e3d40a..10d868059bad 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1813,7 +1813,7 @@ ath12k_dp_rx_mon_buf_done(struct ath12k_base *ab, struct hal_srng *srng,
 	if (!status_desc)
 		return DP_MON_STATUS_NO_DMA;
 
-	ath12k_hal_rx_buf_addr_info_get(status_desc, &paddr, &cookie, &rbm);
+	ath12k_wifi7_hal_rx_buf_addr_info_get(status_desc, &paddr, &cookie, &rbm);
 
 	buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
@@ -1865,7 +1865,7 @@ void ath12k_dp_mon_next_link_desc_get(struct hal_rx_msdu_link *msdu_link,
 
 	buf_addr_info = &msdu_link->buf_addr_info;
 
-	ath12k_hal_rx_buf_addr_info_get(buf_addr_info, paddr, sw_cookie, rbm);
+	ath12k_wifi7_hal_rx_buf_addr_info_get(buf_addr_info, paddr, sw_cookie, rbm);
 
 	*pp_buf_addr_info = buf_addr_info;
 }
@@ -2727,7 +2727,7 @@ int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 
 		num_remain--;
 
-		ath12k_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
+		ath12k_wifi7_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
 	}
 
 	ath12k_hal_srng_access_end(ab, srng);
@@ -3946,8 +3946,8 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 			pmon->buf_state = DP_MON_STATUS_REPLINISH;
 			break;
 		}
-		ath12k_hal_rx_buf_addr_info_get(rx_mon_status_desc, &paddr,
-						&cookie, &rbm);
+		ath12k_wifi7_hal_rx_buf_addr_info_get(rx_mon_status_desc, &paddr,
+						      &cookie, &rbm);
 		if (paddr) {
 			buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
@@ -4028,12 +4028,12 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 move_next:
 		skb = ath12k_dp_rx_alloc_mon_status_buf(ab, rx_ring,
 							&buf_id);
+		hal_params = ab->hw_params->hal_params;
 
 		if (!skb) {
 			ath12k_warn(ab, "failed to alloc buffer for status ring\n");
-			hal_params = ab->hw_params->hal_params;
-			ath12k_hal_rx_buf_addr_info_set(rx_mon_status_desc, 0, 0,
-							hal_params->rx_buf_rbm);
+			ath12k_wifi7_hal_rx_buf_addr_info_set(rx_mon_status_desc, 0, 0,
+							      hal_params->rx_buf_rbm);
 			num_buffs_reaped++;
 			break;
 		}
@@ -4042,9 +4042,9 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 		cookie = u32_encode_bits(mac_id, DP_RXDMA_BUF_COOKIE_PDEV_ID) |
 			 u32_encode_bits(buf_id, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
-		ath12k_hal_rx_buf_addr_info_set(rx_mon_status_desc, rxcb->paddr,
-						cookie,
-						ab->hw_params->hal_params->rx_buf_rbm);
+		ath12k_wifi7_hal_rx_buf_addr_info_set(rx_mon_status_desc, rxcb->paddr,
+						      cookie,
+						      hal_params->rx_buf_rbm);
 		ath12k_hal_srng_src_get_next_entry(ab, srng);
 		num_buffs_reaped++;
 	}
@@ -4213,14 +4213,14 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 			list_add_tail(&desc_info->list, used_list);
 		}
 
-		ath12k_hal_rx_buf_addr_info_set(&buf_info, paddr, sw_cookie, rbm);
+		ath12k_wifi7_hal_rx_buf_addr_info_set(&buf_info, paddr, sw_cookie, rbm);
 
 		ath12k_dp_mon_next_link_desc_get(msdu_link_desc, &paddr,
 						 &sw_cookie, &rbm,
 						 &p_buf_addr_info);
 
-		ath12k_dp_rx_link_desc_return(ar->ab, &buf_info,
-					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		ath12k_wifi7_dp_rx_link_desc_return(ar->ab, &buf_info,
+						    HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 
 		p_last_buf_addr_info = p_buf_addr_info;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 4197c6d4d562..f5bb82cdce11 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -145,7 +145,7 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 
 		num_remain--;
 
-		ath12k_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
+		ath12k_wifi7_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
 	}
 
 	goto out;
@@ -422,16 +422,17 @@ void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 			dp->reo_cmd_cache_flush_count--;
 
 			/* Unlock the reo_cmd_lock before using ath12k_dp_reo_cmd_send()
-			 * within ath12k_dp_reo_cache_flush. The reo_cmd_cache_flush_list
-			 * is used in only two contexts, one is in this function called
-			 * from napi and the other in ath12k_dp_free during core destroy.
+			 * within ath12k_wifi7_dp_reo_cache_flush.
+			 * The reo_cmd_cache_flush_list is used in only two contexts,
+			 * one is in this function called from napi and the other in
+			 * ath12k_dp_free during core destroy.
 			 * Before dp_free, the irqs would be disabled and would wait to
 			 * synchronize. Hence there wouldn’t be any race against add or
 			 * delete to this list. Hence unlock-lock is safe here.
 			 */
 			spin_unlock_bh(&dp->reo_cmd_lock);
 
-			ath12k_dp_reo_cache_flush(ab, &elem->data);
+			ath12k_wifi7_dp_reo_cache_flush(ab, &elem->data);
 			kfree(elem);
 			spin_lock_bh(&dp->reo_cmd_lock);
 		}
@@ -457,8 +458,9 @@ void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 	if (rx_tid->dst_ring_desc) {
 		if (rel_link_desc) {
 			buf_addr_info = &rx_tid->dst_ring_desc->buf_addr_info;
-			ath12k_dp_rx_link_desc_return(ab, buf_addr_info,
-						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+			ath12k_wifi7_dp_rx_link_desc_return
+				(ab, buf_addr_info,
+				 HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 		}
 		kfree(rx_tid->dst_ring_desc);
 		rx_tid->dst_ring_desc = NULL;
@@ -480,7 +482,7 @@ void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_peer *peer)
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 		rx_tid = &peer->rx_tid[i];
 
-		ath12k_dp_rx_peer_tid_delete(ar, peer, i);
+		ath12k_wifi7_dp_rx_peer_tid_delete(ar, peer, i);
 		ath12k_dp_rx_frags_cleanup(rx_tid, true);
 
 		spin_unlock_bh(&ar->ab->base_lock);
@@ -533,8 +535,8 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	rx_tid = &peer->rx_tid[tid];
 	/* Update the tid queue if it is already setup */
 	if (rx_tid->active) {
-		ret = ath12k_peer_rx_tid_reo_update(ar, peer, rx_tid,
-						    ba_win_sz, ssn, true);
+		ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, rx_tid,
+							  ba_win_sz, ssn, true);
 		spin_unlock_bh(&ab->base_lock);
 		if (ret) {
 			ath12k_warn(ab, "failed to update reo for rx tid %d\n", tid);
@@ -562,7 +564,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	rx_tid->ba_win_sz = ba_win_sz;
 
 	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	ret = ath12k_dp_rx_assign_reoq(ab, ahsta, rx_tid, ssn, pn_type);
+	ret = ath12k_wifi7_dp_rx_assign_reoq(ab, ahsta, rx_tid, ssn, pn_type);
 	if (ret) {
 		spin_unlock_bh(&ab->base_lock);
 		ath12k_warn(ab, "failed to assign reoq buf for rx tid %u\n", tid);
@@ -575,11 +577,11 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		 * and tid with qaddr.
 		 */
 		if (peer->mlo)
-			ath12k_peer_rx_tid_qref_setup(ab, peer->ml_id, tid,
-						      paddr_aligned);
+			ath12k_wifi7_peer_rx_tid_qref_setup(ab, peer->ml_id, tid,
+							    paddr_aligned);
 		else
-			ath12k_peer_rx_tid_qref_setup(ab, peer->peer_id, tid,
-						      paddr_aligned);
+			ath12k_wifi7_peer_rx_tid_qref_setup(ab, peer->peer_id, tid,
+							    paddr_aligned);
 
 		spin_unlock_bh(&ab->base_lock);
 	} else {
@@ -657,7 +659,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 		return 0;
 	}
 
-	ret = ath12k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
+	ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
 	spin_unlock_bh(&ab->base_lock);
 	if (ret) {
 		ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",
@@ -703,10 +705,11 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 		if (!rx_tid->active)
 			continue;
 
-		ath12k_dp_setup_pn_check_reo_cmd(&cmd, rx_tid, key->cipher, key_cmd);
-		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
-					     HAL_REO_CMD_UPDATE_RX_QUEUE,
-					     &cmd, NULL);
+		ath12k_wifi7_dp_setup_pn_check_reo_cmd(&cmd, rx_tid, key->cipher,
+						       key_cmd);
+		ret = ath12k_wifi7_dp_reo_cmd_send(ab, rx_tid,
+						   HAL_REO_CMD_UPDATE_RX_QUEUE,
+						   &cmd, NULL);
 		if (ret) {
 			ath12k_warn(ab, "failed to configure rx tid %d queue of peer %pM for pn replay detection %d\n",
 				    tid, peer_addr, ret);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 692d495d01c9..e3e1fe1809fe 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1603,13 +1603,14 @@ struct hal_ops {
 extern const struct hal_ops hal_qcn9274_ops;
 extern const struct hal_ops hal_wcn7850_ops;
 
-u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
-void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
-				int tid, u32 ba_window_size,
-				u32 start_seq, enum hal_pn_type type);
-void ath12k_hal_reo_init_cmd_ring(struct ath12k_base *ab,
-				  struct hal_srng *srng);
-void ath12k_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
+u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
+void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
+				      int tid, u32 ba_window_size,
+				      u32 start_seq, enum hal_pn_type type);
+void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
+					struct hal_srng *srng);
+void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
+
 void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 				     struct hal_wbm_idle_scatter_list *sbuf,
 				     u32 nsbufs, u32 tot_link_desc,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 996d0b425c10..23a33003a9d8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8901,7 +8901,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	if (!vif->valid_links || !is_mcast || is_dvlan ||
 	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
-		ret = ath12k_dp_tx(ar, arvif, skb, false, 0, is_mcast);
+		ret = ath12k_wifi7_dp_tx(ar, arvif, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
 			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 			ieee80211_free_txskb(ar->ah->hw, skb);
@@ -8962,8 +8962,8 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			spin_unlock_bh(&tmp_ar->ab->base_lock);
 
 skip_peer_find:
-			ret = ath12k_dp_tx(tmp_ar, tmp_arvif,
-					   msdu_copied, true, mcbc_gsn, is_mcast);
+			ret = ath12k_wifi7_dp_tx(tmp_ar, tmp_arvif,
+						 msdu_copied, true, mcbc_gsn, is_mcast);
 			if (unlikely(ret)) {
 				if (ret == -ENOMEM) {
 					/* Drops are expected during heavy multicast
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 2de566444719..53f564ff5afa 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -482,7 +482,7 @@ static int ath12k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 	int work_done;
 	int i;
 
-	work_done = ath12k_dp_service_srng(ab, irq_grp, budget);
+	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 		for (i = 0; i < irq_grp->num_irq; i++)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index afe791394e6b..05c278467cb3 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -12,9 +12,9 @@
 #include "dp.h"
 #include "dp_tx.h"
 
-int ath12k_dp_service_srng(struct ath12k_base *ab,
-			   struct ath12k_ext_irq_grp *irq_grp,
-			   int budget)
+int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
+				 struct ath12k_ext_irq_grp *irq_grp,
+				 int budget)
 {
 	struct napi_struct *napi = &irq_grp->napi;
 	int grp_id = irq_grp->grp_id;
@@ -26,11 +26,11 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 
 	if (ab->hw_params->ring_mask->tx[grp_id]) {
 		i = fls(ab->hw_params->ring_mask->tx[grp_id]) - 1;
-		ath12k_dp_tx_completion_handler(ab, i);
+		ath12k_wifi7_dp_tx_completion_handler(ab, i);
 	}
 
 	if (ab->hw_params->ring_mask->rx_err[grp_id]) {
-		work_done = ath12k_dp_rx_process_err(ab, napi, budget);
+		work_done = ath12k_wifi7_dp_rx_process_err(ab, napi, budget);
 		budget -= work_done;
 		tot_work_done += work_done;
 		if (budget <= 0)
@@ -38,9 +38,7 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 	}
 
 	if (ab->hw_params->ring_mask->rx_wbm_rel[grp_id]) {
-		work_done = ath12k_dp_rx_process_wbm_err(ab,
-							 napi,
-							 budget);
+		work_done = ath12k_wifi7_dp_rx_process_wbm_err(ab, napi, budget);
 		budget -= work_done;
 		tot_work_done += work_done;
 
@@ -50,8 +48,7 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 
 	if (ab->hw_params->ring_mask->rx[grp_id]) {
 		i = fls(ab->hw_params->ring_mask->rx[grp_id]) - 1;
-		work_done = ath12k_dp_rx_process(ab, i, napi,
-						 budget);
+		work_done = ath12k_wifi7_dp_rx_process(ab, i, napi, budget);
 		budget -= work_done;
 		tot_work_done += work_done;
 		if (budget <= 0)
@@ -120,7 +117,7 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 	}
 
 	if (ab->hw_params->ring_mask->reo_status[grp_id])
-		ath12k_dp_rx_process_reo_status(ab);
+		ath12k_wifi7_dp_rx_process_reo_status(ab);
 
 	if (ab->hw_params->ring_mask->host2rxdma[grp_id]) {
 		struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.h b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
index 17255a5671d7..9332b9401bbf 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
@@ -9,7 +9,6 @@
 
 #include "hw.h"
 
-int ath12k_dp_service_srng(struct ath12k_base *ab,
-			   struct ath12k_ext_irq_grp *irq_grp,
-			   int budget);
+int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
+				 struct ath12k_ext_irq_grp *irq_grp, int budget);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index f19c5612bb7c..76bfa33120f3 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -10,8 +10,8 @@
 #include "hal_qcn9274.h"
 #include "hal_wcn7850.h"
 
-void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
-				   dma_addr_t paddr)
+void ath12k_wifi7_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
+					 dma_addr_t paddr)
 {
 	struct ath12k_reo_queue_ref *qref;
 	struct ath12k_dp *dp = &ab->dp;
@@ -40,7 +40,8 @@ void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
 	ath12k_hal_reo_shared_qaddr_cache_clear(ab);
 }
 
-static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u16 tid)
+static void ath12k_wifi7_peer_rx_tid_qref_reset(struct ath12k_base *ab,
+						u16 peer_id, u16 tid)
 {
 	struct ath12k_reo_queue_ref *qref;
 	struct ath12k_dp *dp = &ab->dp;
@@ -66,8 +67,8 @@ static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u
 		      u32_encode_bits(tid, DP_REO_QREF_NUM);
 }
 
-void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
-				  struct ath12k_peer *peer, u8 tid)
+void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
+					struct ath12k_peer *peer, u8 tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
 	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
@@ -80,9 +81,9 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.upd0 = HAL_REO_CMD_UPD0_VLD;
-	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
-				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
-				     ath12k_dp_rx_tid_del_func);
+	ret = ath12k_wifi7_dp_reo_cmd_send(ar->ab, rx_tid,
+					   HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
+					   ath12k_dp_rx_tid_del_func);
 	if (ret) {
 		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
 			   tid, ret);
@@ -93,16 +94,16 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 	}
 
 	if (peer->mlo)
-		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->ml_id, tid);
+		ath12k_wifi7_peer_rx_tid_qref_reset(ar->ab, peer->ml_id, tid);
 	else
-		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
+		ath12k_wifi7_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
 
 	rx_tid->active = false;
 }
 
-int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
-				  struct ath12k_buffer_addr *buf_addr_info,
-				  enum hal_wbm_rel_bm_act action)
+int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
+					struct ath12k_buffer_addr *buf_addr_info,
+					enum hal_wbm_rel_bm_act action)
 {
 	struct hal_wbm_release_ring *desc;
 	struct ath12k_dp *dp = &ab->dp;
@@ -121,7 +122,7 @@ int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
 		goto exit;
 	}
 
-	ath12k_hal_rx_msdu_link_desc_set(ab, desc, buf_addr_info, action);
+	ath12k_wifi7_hal_rx_msdu_link_desc_set(ab, desc, buf_addr_info, action);
 
 exit:
 	ath12k_hal_srng_access_end(ab, srng);
@@ -131,11 +132,12 @@ int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
 	return ret;
 }
 
-int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
-			   enum hal_reo_cmd_type type,
-			   struct ath12k_hal_reo_cmd *cmd,
-			   void (*cb)(struct ath12k_dp *dp, void *ctx,
-				      enum hal_reo_cmd_status status))
+int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab,
+				 struct ath12k_dp_rx_tid *rx_tid,
+				 enum hal_reo_cmd_type type,
+				 struct ath12k_hal_reo_cmd *cmd,
+				 void (*cb)(struct ath12k_dp *dp, void *ctx,
+					    enum hal_reo_cmd_status status))
 {
 	struct ath12k_dp *dp = &ab->dp;
 	struct ath12k_dp_rx_reo_cmd *dp_cmd;
@@ -143,7 +145,7 @@ int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_t
 	int cmd_num;
 
 	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
-	cmd_num = ath12k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
+	cmd_num = ath12k_wifi7_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
 
 	/* cmd_num should start from 1, during failure return the error code */
 	if (cmd_num < 0)
@@ -176,11 +178,11 @@ int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_t
 	return 0;
 }
 
-int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
-				  struct ath12k_peer *peer,
-				  struct ath12k_dp_rx_tid *rx_tid,
-				  u32 ba_win_sz, u16 ssn,
-				  bool update_ssn)
+int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k *ar,
+					struct ath12k_peer *peer,
+					struct ath12k_dp_rx_tid *rx_tid,
+					u32 ba_win_sz, u16 ssn,
+					bool update_ssn)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
 	int ret;
@@ -196,9 +198,9 @@ int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 		cmd.upd2 = u32_encode_bits(ssn, HAL_REO_CMD_UPD2_SSN);
 	}
 
-	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
-				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
-				     NULL);
+	ret = ath12k_wifi7_dp_reo_cmd_send(ar->ab, rx_tid,
+					   HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
+					   NULL);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to update rx tid queue, tid %d (%d)\n",
 			    rx_tid->tid, ret);
@@ -210,23 +212,23 @@ int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 	return 0;
 }
 
-void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
-			       struct ath12k_dp_rx_tid *rx_tid)
+void ath12k_wifi7_dp_reo_cache_flush(struct ath12k_base *ab,
+				     struct ath12k_dp_rx_tid *rx_tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
 	unsigned long tot_desc_sz, desc_sz;
 	int ret;
 
 	tot_desc_sz = rx_tid->qbuf.size;
-	desc_sz = ath12k_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
+	desc_sz = ath12k_wifi7_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
 
 	while (tot_desc_sz > desc_sz) {
 		tot_desc_sz -= desc_sz;
 		cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned + tot_desc_sz);
 		cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
-					     HAL_REO_CMD_FLUSH_CACHE, &cmd,
-					     NULL);
+		ret = ath12k_wifi7_dp_reo_cmd_send(ab, rx_tid,
+						   HAL_REO_CMD_FLUSH_CACHE, &cmd,
+						   NULL);
 		if (ret)
 			ath12k_warn(ab,
 				    "failed to send HAL_REO_CMD_FLUSH_CACHE, tid %d (%d)\n",
@@ -237,9 +239,9 @@ void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
 	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
-	ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
-				     HAL_REO_CMD_FLUSH_CACHE,
-				     &cmd, ath12k_dp_reo_cmd_free);
+	ret = ath12k_wifi7_dp_reo_cmd_send(ab, rx_tid,
+					   HAL_REO_CMD_FLUSH_CACHE,
+					   &cmd, ath12k_dp_reo_cmd_free);
 	if (ret) {
 		ath12k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d (%d)\n",
 			   rx_tid->tid, ret);
@@ -250,9 +252,9 @@ void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
 	}
 }
 
-int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
-			     struct ath12k_dp_rx_tid *rx_tid,
-			     u16 ssn, enum hal_pn_type pn_type)
+int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
+				   struct ath12k_dp_rx_tid *rx_tid,
+				   u16 ssn, enum hal_pn_type pn_type)
 {
 	u32 ba_win_sz = rx_tid->ba_win_sz;
 	struct ath12k_reoq_buf *buf;
@@ -268,9 +270,10 @@ int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
 		 * the actual BA window size in REO tid update path.
 		 */
 		if (tid == HAL_DESC_REO_NON_QOS_TID)
-			hw_desc_sz = ath12k_hal_reo_qdesc_size(ba_win_sz, tid);
+			hw_desc_sz = ath12k_wifi7_hal_reo_qdesc_size(ba_win_sz, tid);
 		else
-			hw_desc_sz = ath12k_hal_reo_qdesc_size(DP_BA_WIN_SZ_MAX, tid);
+			hw_desc_sz = ath12k_wifi7_hal_reo_qdesc_size(DP_BA_WIN_SZ_MAX,
+								     tid);
 
 		vaddr = kzalloc(hw_desc_sz + HAL_LINK_DESC_ALIGN - 1, GFP_ATOMIC);
 		if (!vaddr)
@@ -278,8 +281,8 @@ int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
 
 		vaddr_aligned = PTR_ALIGN(vaddr, HAL_LINK_DESC_ALIGN);
 
-		ath12k_hal_reo_qdesc_setup(vaddr_aligned, tid, ba_win_sz,
-					   ssn, pn_type);
+		ath12k_wifi7_hal_reo_qdesc_setup(vaddr_aligned, tid, ba_win_sz,
+						 ssn, pn_type);
 
 		paddr_aligned = dma_map_single(ab->dev, vaddr_aligned, hw_desc_sz,
 					       DMA_BIDIRECTIONAL);
@@ -300,17 +303,17 @@ int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
 	return 0;
 }
 
-static void ath12k_dp_rx_h_csum_offload(struct sk_buff *msdu,
-					struct hal_rx_desc_data *rx_info)
+static void ath12k_wifi7_dp_rx_h_csum_offload(struct sk_buff *msdu,
+					      struct hal_rx_desc_data *rx_info)
 {
 	msdu->ip_summed = (rx_info->ip_csum_fail || rx_info->l4_csum_fail) ?
 			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
-				struct sk_buff *msdu,
-				struct hal_rx_desc *rx_desc,
-				struct hal_rx_desc_data *rx_info)
+static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k *ar,
+				      struct sk_buff *msdu,
+				      struct hal_rx_desc *rx_desc,
+				      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_encrypt_type enctype;
@@ -364,13 +367,13 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 
 		if (rx_info->is_mcbc)
 			rx_status->flag |= RX_FLAG_MIC_STRIPPED |
-					RX_FLAG_ICV_STRIPPED;
+					   RX_FLAG_ICV_STRIPPED;
 		else
 			rx_status->flag |= RX_FLAG_IV_STRIPPED |
 					   RX_FLAG_PN_VALIDATED;
 	}
 
-	ath12k_dp_rx_h_csum_offload(msdu, rx_info);
+	ath12k_wifi7_dp_rx_h_csum_offload(msdu, rx_info);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       enctype, is_decrypted, rx_info);
 
@@ -383,11 +386,11 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 	}
 }
 
-static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
-				      struct sk_buff_head *msdu_list,
-				      struct sk_buff *first, struct sk_buff *last,
-				      u8 l3pad_bytes, int msdu_len,
-				      struct hal_rx_desc_data *rx_info)
+static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k *ar,
+					    struct sk_buff_head *msdu_list,
+					    struct sk_buff *first, struct sk_buff *last,
+					    u8 l3pad_bytes, int msdu_len,
+					    struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *skb;
@@ -471,10 +474,10 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
-				     struct sk_buff *msdu,
-				     struct sk_buff_head *msdu_list,
-				     struct hal_rx_desc_data *rx_info)
+static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k *ar,
+					   struct sk_buff *msdu,
+					   struct sk_buff_head *msdu_list,
+					   struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
@@ -521,10 +524,10 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 		skb_put(msdu, hal_rx_desc_sz + l3_pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3_pad_bytes);
 	} else {
-		ret = ath12k_dp_rx_msdu_coalesce(ar, msdu_list,
-						 msdu, last_buf,
-						 l3_pad_bytes, msdu_len,
-						 rx_info);
+		ret = ath12k_wifi7_dp_rx_msdu_coalesce(ar, msdu_list,
+						       msdu, last_buf,
+						       l3_pad_bytes, msdu_len,
+						       rx_info);
 		if (ret) {
 			ath12k_warn(ab,
 				    "failed to coalesce msdu rx buffer%d\n", ret);
@@ -539,7 +542,7 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 	}
 
 	ath12k_dp_rx_h_ppdu(ar, rx_info);
-	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info);
+	ath12k_wifi7_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info);
 
 	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
@@ -549,10 +552,11 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 	return ret;
 }
 
-static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
-						  struct napi_struct *napi,
-						  struct sk_buff_head *msdu_list,
-						  int ring_id)
+static void
+ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
+					    struct napi_struct *napi,
+					    struct sk_buff_head *msdu_list,
+					    int ring_id)
 {
 	struct ath12k_hw_group *ag = ab->ag;
 	struct ieee80211_rx_status rx_status = {};
@@ -591,7 +595,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 			continue;
 		}
 
-		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_info);
+		ret = ath12k_wifi7_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_info);
 		if (ret) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
@@ -605,8 +609,8 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 	rcu_read_unlock();
 }
 
-int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
-			 struct napi_struct *napi, int budget)
+int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
+			       struct napi_struct *napi, int budget)
 {
 	struct ath12k_hw_group *ag = ab->ag;
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
@@ -758,17 +762,17 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 					    num_buffs_reaped[device_id]);
 	}
 
-	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
-					      ring_id);
+	ath12k_wifi7_dp_rx_process_received_packets(ab, napi, &msdu_list,
+						    ring_id);
 
 exit:
 	return total_msdu_reaped;
 }
 
 static bool
-ath12k_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar,
-				       struct ath12k_dp_rx_tid *rx_tid,
-				       enum hal_encrypt_type encrypt_type)
+ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar,
+					     struct ath12k_dp_rx_tid *rx_tid,
+					     enum hal_encrypt_type encrypt_type)
 {
 	struct sk_buff *first_frag, *skb;
 	u64 last_pn;
@@ -795,9 +799,9 @@ ath12k_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar,
 	return true;
 }
 
-static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
-					      struct ath12k_dp_rx_tid *rx_tid,
-					      struct sk_buff *defrag_skb)
+static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
+						    struct ath12k_dp_rx_tid *rx_tid,
+						    struct sk_buff *defrag_skb)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
@@ -820,8 +824,8 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	link_desc_banks = dp->link_desc_banks;
 	reo_dest_ring = rx_tid->dst_ring_desc;
 
-	ath12k_hal_rx_reo_ent_paddr_get(ab, &reo_dest_ring->buf_addr_info,
-					&link_paddr, &cookie);
+	ath12k_wifi7_hal_rx_reo_ent_paddr_get(ab, &reo_dest_ring->buf_addr_info,
+					      &link_paddr, &cookie);
 	desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
 
 	msdu_link = (struct hal_rx_msdu_link *)(link_desc_banks[desc_bank].vaddr +
@@ -870,9 +874,9 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 
 	ATH12K_SKB_RXCB(defrag_skb)->paddr = buf_paddr;
 
-	ath12k_hal_rx_buf_addr_info_set(&msdu0->buf_addr_info, buf_paddr,
-					desc_info->cookie,
-					HAL_RX_BUF_RBM_SW3_BM);
+	ath12k_wifi7_hal_rx_buf_addr_info_set(&msdu0->buf_addr_info, buf_paddr,
+					      desc_info->cookie,
+					      HAL_RX_BUF_RBM_SW3_BM);
 
 	/* Fill mpdu details into reo entrance ring */
 	srng = &ab->hal.srng_list[dp->reo_reinject_ring.ring_id];
@@ -889,9 +893,8 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	}
 	memset(reo_ent_ring, 0, sizeof(*reo_ent_ring));
 
-	ath12k_hal_rx_buf_addr_info_set(&reo_ent_ring->buf_addr_info, link_paddr,
-					cookie,
-					idle_link_rbm);
+	ath12k_wifi7_hal_rx_buf_addr_info_set(&reo_ent_ring->buf_addr_info, link_paddr,
+					      cookie, idle_link_rbm);
 
 	mpdu_info = u32_encode_bits(1, RX_MPDU_DESC_INFO0_MSDU_COUNT) |
 		    u32_encode_bits(0, RX_MPDU_DESC_INFO0_FRAG_FLAG) |
@@ -942,11 +945,11 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	return ret;
 }
 
-static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar,
-					  struct ath12k_peer *peer,
-					  enum hal_encrypt_type enctype,
-					  struct sk_buff *msdu,
-					  struct hal_rx_desc_data *rx_info)
+static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k *ar,
+						struct ath12k_peer *peer,
+						enum hal_encrypt_type enctype,
+						struct sk_buff *msdu,
+						struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
@@ -982,7 +985,8 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar,
 	data_len = msdu->len - head_len - tail_len;
 	key = &key_conf->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY];
 
-	ret = ath12k_dp_rx_h_michael_mic(peer->tfm_mmic, key, hdr, data, data_len, mic);
+	ret = ath12k_dp_rx_h_michael_mic(peer->tfm_mmic, key, hdr, data,
+					 data_len, mic);
 	if (ret || memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
 		goto mic_fail;
 
@@ -1009,12 +1013,12 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar,
 	return -EINVAL;
 }
 
-static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
-				 struct ath12k_peer *peer,
-				 struct ath12k_dp_rx_tid *rx_tid,
-				 struct sk_buff **defrag_skb,
-				 enum hal_encrypt_type enctype,
-				 struct hal_rx_desc_data *rx_info)
+static int ath12k_wifi7_dp_rx_h_defrag(struct ath12k *ar,
+				       struct ath12k_peer *peer,
+				       struct ath12k_dp_rx_tid *rx_tid,
+				       struct sk_buff **defrag_skb,
+				       enum hal_encrypt_type enctype,
+				       struct hal_rx_desc_data *rx_info)
 {
 	struct sk_buff *skb, *first_frag, *last_frag;
 	struct ieee80211_hdr *hdr;
@@ -1038,7 +1042,7 @@ static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 				flags |= RX_FLAG_IV_STRIPPED;
 			if (skb != last_frag)
 				flags |= RX_FLAG_ICV_STRIPPED |
-					 RX_FLAG_MIC_STRIPPED;
+					RX_FLAG_MIC_STRIPPED;
 		}
 
 		/* RX fragments are always raw packets */
@@ -1067,17 +1071,17 @@ static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_MOREFRAGS);
 	ATH12K_SKB_RXCB(first_frag)->is_frag = 1;
 
-	if (ath12k_dp_rx_h_verify_tkip_mic(ar, peer, enctype, first_frag, rx_info))
+	if (ath12k_wifi7_dp_rx_h_verify_tkip_mic(ar, peer, enctype, first_frag, rx_info))
 		first_frag = NULL;
 
 	*defrag_skb = first_frag;
 	return 0;
 }
 
-static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
-				    struct sk_buff *msdu,
-				    struct hal_reo_dest_ring *ring_desc,
-				    struct hal_rx_desc_data *rx_info)
+static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k *ar,
+					  struct sk_buff *msdu,
+					  struct hal_reo_dest_ring *ring_desc,
+					  struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
@@ -1155,8 +1159,8 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 			goto out_unlock;
 		}
 	} else {
-		ath12k_dp_rx_link_desc_return(ab, &ring_desc->buf_addr_info,
-					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		ath12k_wifi7_dp_rx_link_desc_return(ab, &ring_desc->buf_addr_info,
+						    HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 	}
 
 	if (!rx_tid->last_frag_no ||
@@ -1174,17 +1178,17 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 	if (!peer)
 		goto err_frags_cleanup;
 
-	if (!ath12k_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid, enctype))
+	if (!ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid, enctype))
 		goto err_frags_cleanup;
 
-	if (ath12k_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb,
-				  enctype, rx_info))
+	if (ath12k_wifi7_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb,
+					enctype, rx_info))
 		goto err_frags_cleanup;
 
 	if (!defrag_skb)
 		goto err_frags_cleanup;
 
-	if (ath12k_dp_rx_h_defrag_reo_reinject(ar, rx_tid, defrag_skb))
+	if (ath12k_wifi7_dp_rx_h_defrag_reo_reinject(ar, rx_tid, defrag_skb))
 		goto err_frags_cleanup;
 
 	ath12k_dp_rx_frags_cleanup(rx_tid, false);
@@ -1199,9 +1203,10 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 }
 
 static int
-ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
-			     struct list_head *used_list,
-			     bool drop, u32 cookie)
+ath12k_wifi7_dp_process_rx_err_buf(struct ath12k *ar,
+				   struct hal_reo_dest_ring *desc,
+				   struct list_head *used_list,
+				   bool drop, u32 cookie)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu;
@@ -1270,18 +1275,18 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 
 	skb_put(msdu, hal_rx_desc_sz + msdu_len);
 
-	if (ath12k_dp_rx_frag_h_mpdu(ar, msdu, desc, &rx_info)) {
+	if (ath12k_wifi7_dp_rx_frag_h_mpdu(ar, msdu, desc, &rx_info)) {
 		dev_kfree_skb_any(msdu);
-		ath12k_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
-					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		ath12k_wifi7_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
+						    HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 	}
 exit:
 	rcu_read_unlock();
 	return 0;
 }
 
-int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
-			     int budget)
+int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
+				   int budget)
 {
 	struct ath12k_hw_group *ag = ab->ag;
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
@@ -1304,6 +1309,8 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	bool is_frag;
 	bool drop;
 	int pdev_id;
+	struct list_head *used_list;
+	enum hal_wbm_rel_bm_act act;
 
 	tot_n_bufs_reaped = 0;
 	quota = budget;
@@ -1324,8 +1331,8 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		drop = false;
 		ab->device_stats.err_ring_pkts++;
 
-		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
-						    &desc_bank);
+		ret = ath12k_wifi7_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
+							  &desc_bank);
 		if (ret) {
 			ath12k_warn(ab, "failed to parse error reo desc %d\n",
 				    ret);
@@ -1344,16 +1351,17 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		link_desc_banks = partner_ab->dp.link_desc_banks;
 		link_desc_va = link_desc_banks[desc_bank].vaddr +
 			       (paddr - link_desc_banks[desc_bank].paddr);
-		ath12k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
-						 &rbm);
+		ath12k_wifi7_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus,
+						       msdu_cookies, &rbm);
 		if (rbm != partner_ab->dp.idle_link_rbm &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
 		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
+			act = HAL_WBM_REL_BM_ACT_REL_MSDU;
 			ab->device_stats.invalid_rbm++;
 			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
-			ath12k_dp_rx_link_desc_return(partner_ab,
-						      &reo_desc->buf_addr_info,
-						      HAL_WBM_REL_BM_ACT_REL_MSDU);
+			ath12k_wifi7_dp_rx_link_desc_return(partner_ab,
+							    &reo_desc->buf_addr_info,
+							    act);
 			continue;
 		}
 
@@ -1368,18 +1376,21 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		if (!is_frag || num_msdus > 1 ||
 		    partner_ab->device_id != ab->device_id) {
 			drop = true;
+			act = HAL_WBM_REL_BM_ACT_PUT_IN_IDLE;
 
 			/* Return the link desc back to wbm idle list */
-			ath12k_dp_rx_link_desc_return(partner_ab,
-						      &reo_desc->buf_addr_info,
-						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+			ath12k_wifi7_dp_rx_link_desc_return(partner_ab,
+							    &reo_desc->buf_addr_info,
+							    act);
 		}
 
 		for (i = 0; i < num_msdus; i++) {
-			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc,
-							  &rx_desc_used_list[device_id],
-							  drop,
-							  msdu_cookies[i])) {
+			used_list = &rx_desc_used_list[device_id];
+
+			if (!ath12k_wifi7_dp_process_rx_err_buf(ar, reo_desc,
+								used_list,
+								drop,
+								msdu_cookies[i])) {
 				num_buffs_reaped[device_id]++;
 				tot_n_bufs_reaped++;
 			}
@@ -1413,9 +1424,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	return tot_n_bufs_reaped;
 }
 
-static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
-					     int msdu_len,
-					     struct sk_buff_head *msdu_list)
+static void
+ath12k_wifi7_dp_rx_null_q_desc_sg_drop(struct ath12k *ar, int msdu_len,
+				       struct sk_buff_head *msdu_list)
 {
 	struct sk_buff *skb, *tmp;
 	struct ath12k_skb_rxcb *rxcb;
@@ -1437,9 +1448,9 @@ static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
 	}
 }
 
-static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
-				      struct hal_rx_desc_data *rx_info,
-				      struct sk_buff_head *msdu_list)
+static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
+					    struct hal_rx_desc_data *rx_info,
+					    struct sk_buff_head *msdu_list)
 {
 	struct ath12k_base *ab = ar->ab;
 	u16 msdu_len = rx_info->msdu_len;
@@ -1451,7 +1462,7 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
 		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - hal_rx_desc_sz);
-		ath12k_dp_rx_null_q_desc_sg_drop(ar, msdu_len, msdu_list);
+		ath12k_wifi7_dp_rx_null_q_desc_sg_drop(ar, msdu_len, msdu_list);
 		return -EINVAL;
 	}
 
@@ -1491,7 +1502,7 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 		return -EINVAL;
 
 	ath12k_dp_rx_h_ppdu(ar, rx_info);
-	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info);
+	ath12k_wifi7_dp_rx_h_mpdu(ar, msdu, desc, rx_info);
 
 	rxcb->tid = rx_info->tid;
 
@@ -1502,8 +1513,8 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	return 0;
 }
 
-static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
-					struct hal_rx_desc_data *rx_info)
+static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
+					      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	u16 msdu_len = rx_info->msdu_len;
@@ -1539,8 +1550,8 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	return false;
 }
 
-static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
-				     struct hal_rx_desc_data *rx_info)
+static bool ath12k_wifi7_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
+					   struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	bool drop = false;
@@ -1551,7 +1562,7 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
 		if (rx_info->err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
+			drop = ath12k_wifi7_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
 			break;
 		}
 		fallthrough;
@@ -1566,9 +1577,9 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 	return drop;
 }
 
-static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
-				   struct hal_rx_desc_data *rx_info,
-				   struct sk_buff_head *msdu_list)
+static bool ath12k_wifi7_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
+					 struct hal_rx_desc_data *rx_info,
+					 struct sk_buff_head *msdu_list)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	bool drop = false;
@@ -1577,7 +1588,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	switch (rxcb->err_code) {
 	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
-		if (ath12k_dp_rx_h_null_q_desc(ar, msdu, rx_info, msdu_list))
+		if (ath12k_wifi7_dp_rx_h_null_q_desc(ar, msdu, rx_info, msdu_list))
 			drop = true;
 		break;
 	case HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED:
@@ -1597,10 +1608,10 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 	return drop;
 }
 
-static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
-				 struct napi_struct *napi,
-				 struct sk_buff *msdu,
-				 struct sk_buff_head *msdu_list)
+static void ath12k_wifi7_dp_rx_wbm_err(struct ath12k *ar,
+				       struct napi_struct *napi,
+				       struct sk_buff *msdu,
+				       struct sk_buff_head *msdu_list)
 {
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
@@ -1615,10 +1626,10 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 
 	switch (rxcb->err_rel_src) {
 	case HAL_WBM_REL_SRC_MODULE_REO:
-		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
+		drop = ath12k_wifi7_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
 		break;
 	case HAL_WBM_REL_SRC_MODULE_RXDMA:
-		drop = ath12k_dp_rx_h_rxdma_err(ar, msdu, &rx_info);
+		drop = ath12k_wifi7_dp_rx_h_rxdma_err(ar, msdu, &rx_info);
 		break;
 	default:
 		/* msdu will get freed */
@@ -1635,9 +1646,9 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 	ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
 }
 
-void ath12k_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
-				      struct ath12k_dp_rx_tid *rx_tid,
-				      u32 cipher, enum set_key_cmd key_cmd)
+void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
+					    struct ath12k_dp_rx_tid *rx_tid,
+					    u32 cipher, enum set_key_cmd key_cmd)
 {
 	cmd->flag = HAL_REO_CMD_FLG_NEED_STATUS;
 	cmd->upd0 = HAL_REO_CMD_UPD0_PN |
@@ -1665,8 +1676,8 @@ void ath12k_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
 	cmd->addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 }
 
-int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
-				 struct napi_struct *napi, int budget)
+int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
+				       struct napi_struct *napi, int budget)
 {
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	struct ath12k_hw_group *ag = ab->ag;
@@ -1705,7 +1716,8 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		if (!rx_desc)
 			break;
 
-		ret = ath12k_hal_wbm_desc_parse_err(ab, rx_desc, &err_info);
+		ret = ath12k_wifi7_hal_wbm_desc_parse_err(ab, rx_desc,
+							  &err_info);
 		if (ret) {
 			ath12k_warn(ab,
 				    "failed to parse rx error in wbm_rel ring desc %d\n",
@@ -1862,7 +1874,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			device_stats->rx_wbm_rel_source[rxcb->err_rel_src][device_id]++;
 		}
 
-		ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
+		ath12k_wifi7_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
 	}
 	rcu_read_unlock();
 done:
@@ -1950,7 +1962,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 }
 EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_wcn7850);
 
-void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
+void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
 	struct hal_tlv_64_hdr *hdr;
@@ -1973,32 +1985,32 @@ void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
 
 		switch (tag) {
 		case HAL_REO_GET_QUEUE_STATS_STATUS:
-			ath12k_hal_reo_status_queue_stats(ab, hdr,
-							  &reo_status);
+			ath12k_wifi7_hal_reo_status_queue_stats(ab, hdr,
+								&reo_status);
 			break;
 		case HAL_REO_FLUSH_QUEUE_STATUS:
-			ath12k_hal_reo_flush_queue_status(ab, hdr,
-							  &reo_status);
+			ath12k_wifi7_hal_reo_flush_queue_status(ab, hdr,
+								&reo_status);
 			break;
 		case HAL_REO_FLUSH_CACHE_STATUS:
-			ath12k_hal_reo_flush_cache_status(ab, hdr,
-							  &reo_status);
+			ath12k_wifi7_hal_reo_flush_cache_status(ab, hdr,
+								&reo_status);
 			break;
 		case HAL_REO_UNBLOCK_CACHE_STATUS:
-			ath12k_hal_reo_unblk_cache_status(ab, hdr,
-							  &reo_status);
+			ath12k_wifi7_hal_reo_unblk_cache_status(ab, hdr,
+								&reo_status);
 			break;
 		case HAL_REO_FLUSH_TIMEOUT_LIST_STATUS:
-			ath12k_hal_reo_flush_timeout_list_status(ab, hdr,
-								 &reo_status);
+			ath12k_wifi7_hal_reo_flush_timeout_list_status(ab, hdr,
+								       &reo_status);
 			break;
 		case HAL_REO_DESCRIPTOR_THRESHOLD_REACHED_STATUS:
-			ath12k_hal_reo_desc_thresh_reached_status(ab, hdr,
-								  &reo_status);
+			ath12k_wifi7_hal_reo_desc_thresh_reached_status(ab, hdr,
+									&reo_status);
 			break;
 		case HAL_REO_UPDATE_RX_REO_QUEUE_STATUS:
-			ath12k_hal_reo_update_rx_reo_queue_status(ab, hdr,
-								  &reo_status);
+			ath12k_wifi7_hal_reo_update_rx_reo_queue_status(ab, hdr,
+									&reo_status);
 			break;
 		default:
 			ath12k_warn(ab, "Unknown reo status type %d\n", tag);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index f258472bc1fc..35709dfccbcf 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -9,41 +9,41 @@
 #include "../core.h"
 #include "../dp_rx.h"
 
-int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
-				 struct napi_struct *napi, int budget);
-int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
-			     int budget);
-int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
-			 struct napi_struct *napi,
-			 int budget);
-void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab);
+int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
+				       struct napi_struct *napi, int budget);
+int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
+				   int budget);
+int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int mac_id,
+			       struct napi_struct *napi,
+			       int budget);
+void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
-void ath12k_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
-				      struct ath12k_dp_rx_tid *rx_tid,
-				      u32 cipher, enum set_key_cmd key_cmd);
-int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
-			     struct ath12k_dp_rx_tid *rx_tid,
-			     u16 ssn, enum hal_pn_type pn_type);
-int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
-				  struct ath12k_buffer_addr *buf_addr_info,
-				  enum hal_wbm_rel_bm_act action);
-void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
-				   dma_addr_t paddr);
-void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
-				  struct ath12k_peer *peer, u8 tid);
-int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
-			   enum hal_reo_cmd_type type,
-			   struct ath12k_hal_reo_cmd *cmd,
-			   void (*cb)(struct ath12k_dp *dp, void *ctx,
-				      enum hal_reo_cmd_status status));
-void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
-			       struct ath12k_dp_rx_tid *rx_tid);
-int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
-				  struct ath12k_peer *peer,
-				  struct ath12k_dp_rx_tid *rx_tid,
-				  u32 ba_win_sz, u16 ssn,
-				  bool update_ssn);
+void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
+					    struct ath12k_dp_rx_tid *rx_tid,
+					    u32 cipher, enum set_key_cmd key_cmd);
+int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
+				   struct ath12k_dp_rx_tid *rx_tid,
+				   u16 ssn, enum hal_pn_type pn_type);
+int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
+					struct ath12k_buffer_addr *buf_addr_info,
+					enum hal_wbm_rel_bm_act action);
+void ath12k_wifi7_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
+					 dma_addr_t paddr);
+void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
+					struct ath12k_peer *peer, u8 tid);
+int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
+				 enum hal_reo_cmd_type type,
+				 struct ath12k_hal_reo_cmd *cmd,
+				 void (*cb)(struct ath12k_dp *dp, void *ctx,
+					    enum hal_reo_cmd_status status));
+void ath12k_wifi7_dp_reo_cache_flush(struct ath12k_base *ab,
+				     struct ath12k_dp_rx_tid *rx_tid);
+int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k *ar,
+					struct ath12k_peer *peer,
+					struct ath12k_dp_rx_tid *rx_tid,
+					u32 ba_win_sz, u16 ssn,
+					bool update_ssn);
 static inline
 void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_base *ab,
 					  struct hal_rx_desc_data *rx_info,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 49d219a195c5..b3928c3d007d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -10,9 +10,10 @@
 #include "../peer.h"
 #include "dp_tx.h"
 
-static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
-					     struct hal_tx_msdu_ext_desc *tcl_ext_cmd,
-					     struct hal_tx_info *ti)
+static void
+ath12k_wifi7_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
+				       struct hal_tx_msdu_ext_desc *tcl_ext_cmd,
+				       struct hal_tx_info *ti)
 {
 	tcl_ext_cmd->info0 = le32_encode_bits(ti->paddr,
 					      HAL_TX_MSDU_EXT_INFO0_BUF_PTR_LO);
@@ -31,7 +32,7 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
 #define HTT_META_DATA_ALIGNMENT 0x8
 
 /* Preparing HTT Metadata when utilized with ext MSDU */
-static int ath12k_dp_prepare_htt_metadata(struct sk_buff *skb)
+static int ath12k_wifi7_dp_prepare_htt_metadata(struct sk_buff *skb)
 {
 	struct hal_tx_msdu_metadata *desc_ext;
 	u8 htt_desc_size;
@@ -53,9 +54,9 @@ static int ath12k_dp_prepare_htt_metadata(struct sk_buff *skb)
 	return 0;
 }
 
-int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
-		 bool is_mcast)
+int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
+		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
+		       bool is_mcast)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
@@ -268,10 +269,10 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		memset(skb_ext_desc->data, 0, skb_ext_desc->len);
 
 		msg = (struct hal_tx_msdu_ext_desc *)skb_ext_desc->data;
-		ath12k_hal_tx_cmd_ext_desc_setup(ab, msg, &ti);
+		ath12k_wifi7_hal_tx_cmd_ext_desc_setup(ab, msg, &ti);
 
 		if (add_htt_metadata) {
-			ret = ath12k_dp_prepare_htt_metadata(skb_ext_desc);
+			ret = ath12k_wifi7_dp_prepare_htt_metadata(skb_ext_desc);
 			if (ret < 0) {
 				ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 					   "Failed to add HTT meta data, dropping packet\n");
@@ -336,7 +337,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	ab->device_stats.tx_enqueued[ti.ring_id]++;
 
-	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
+	ath12k_wifi7_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
 
 	ath12k_hal_srng_access_end(ab, tcl_ring);
 
@@ -507,7 +508,8 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 	}
 }
 
-static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
+static void
+ath12k_wifi7_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
@@ -625,10 +627,10 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
 	spin_unlock_bh(&ab->base_lock);
 }
 
-static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
-				       struct ath12k_tx_desc_params *desc_params,
-				       struct hal_tx_status *ts,
-				       int ring)
+static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
+					     struct ath12k_tx_desc_params *desc_params,
+					     struct hal_tx_status *ts,
+					     int ring)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ar->ah;
@@ -734,7 +736,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
-	ath12k_dp_tx_update_txcompl(ar, ts);
+	ath12k_wifi7_dp_tx_update_txcompl(ar, ts);
 
 	spin_lock_bh(&ab->base_lock);
 	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
@@ -767,9 +769,10 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	rcu_read_unlock();
 }
 
-static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
-				      struct hal_wbm_completion_ring_tx *desc,
-				      struct hal_tx_status *ts)
+static void
+ath12k_wifi7_dp_tx_status_parse(struct ath12k_base *ab,
+				struct hal_wbm_completion_ring_tx *desc,
+				struct hal_tx_status *ts)
 {
 	u32 info0 = le32_to_cpu(desc->rate_stats.info0);
 
@@ -803,7 +806,7 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 	}
 }
 
-void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
+void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 {
 	struct ath12k *ar;
 	struct ath12k_dp *dp = &ab->dp;
@@ -854,7 +857,7 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		tx_ring->tx_status_tail =
 			ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_tail);
 		tx_status = &tx_ring->tx_status[tx_ring->tx_status_tail];
-		ath12k_dp_tx_status_parse(ab, tx_status, &ts);
+		ath12k_wifi7_dp_tx_status_parse(ab, tx_status, &ts);
 
 		if (le32_get_bits(tx_status->info0, HAL_WBM_COMPL_TX_INFO0_CC_DONE)) {
 			/* HW done cookie conversion */
@@ -902,7 +905,7 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 			wake_up(&ar->dp.tx_empty_waitq);
 
-		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts,
-					   tx_ring->tcl_data_ring_id);
+		ath12k_wifi7_dp_tx_complete_msdu(ar, &desc_params, &ts,
+						 tx_ring->tcl_data_ring_id);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
index 42faf664f8f8..061c4de4d4e6 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
@@ -7,8 +7,8 @@
 #ifndef ATH12K_DP_TX_WIFI7_H
 #define ATH12K_DP_TX_WIFI7_H
 
-int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
-		 bool is_mcast);
-void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
+int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
+		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
+		       bool is_mcast);
+void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 801dde62e4ed..240083a7c962 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -11,8 +11,9 @@
 #include "hal_rx.h"
 #include "hal_desc.h"
 
-static void ath12k_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
-					u8 owner, u8 buffer_type, u32 magic)
+static
+void ath12k_wifi7_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
+				       u8 owner, u8 buffer_type, u32 magic)
 {
 	hdr->info0 = le32_encode_bits(owner, HAL_DESC_HDR_INFO0_OWNER) |
 		     le32_encode_bits(buffer_type, HAL_DESC_HDR_INFO0_BUF_TYPE);
@@ -21,8 +22,8 @@ static void ath12k_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
 	hdr->info0 |= le32_encode_bits(magic, HAL_DESC_HDR_INFO0_DBG_RESERVED);
 }
 
-static int ath12k_hal_reo_cmd_queue_stats(struct hal_tlv_64_hdr *tlv,
-					  struct ath12k_hal_reo_cmd *cmd)
+static int ath12k_wifi7_hal_reo_cmd_queue_stats(struct hal_tlv_64_hdr *tlv,
+						struct ath12k_hal_reo_cmd *cmd)
 {
 	struct hal_reo_get_queue_stats *desc;
 
@@ -45,9 +46,9 @@ static int ath12k_hal_reo_cmd_queue_stats(struct hal_tlv_64_hdr *tlv,
 	return le32_get_bits(desc->cmd.info0, HAL_REO_CMD_HDR_INFO0_CMD_NUMBER);
 }
 
-static int ath12k_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
-					  struct hal_tlv_64_hdr *tlv,
-					  struct ath12k_hal_reo_cmd *cmd)
+static int ath12k_wifi7_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
+						struct hal_tlv_64_hdr *tlv,
+						struct ath12k_hal_reo_cmd *cmd)
 {
 	struct hal_reo_flush_cache *desc;
 	u8 avail_slot = ffz(hal->avail_blk_resource);
@@ -92,8 +93,9 @@ static int ath12k_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
 	return le32_get_bits(desc->cmd.info0, HAL_REO_CMD_HDR_INFO0_CMD_NUMBER);
 }
 
-static int ath12k_hal_reo_cmd_update_rx_queue(struct hal_tlv_64_hdr *tlv,
-					      struct ath12k_hal_reo_cmd *cmd)
+static int
+ath12k_wifi7_hal_reo_cmd_update_rx_queue(struct hal_tlv_64_hdr *tlv,
+					 struct ath12k_hal_reo_cmd *cmd)
 {
 	struct hal_reo_update_rx_queue *desc;
 
@@ -217,9 +219,9 @@ static int ath12k_hal_reo_cmd_update_rx_queue(struct hal_tlv_64_hdr *tlv,
 	return le32_get_bits(desc->cmd.info0, HAL_REO_CMD_HDR_INFO0_CMD_NUMBER);
 }
 
-int ath12k_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
-			    enum hal_reo_cmd_type type,
-			    struct ath12k_hal_reo_cmd *cmd)
+int ath12k_wifi7_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
+				  enum hal_reo_cmd_type type,
+				  struct ath12k_hal_reo_cmd *cmd)
 {
 	struct hal_tlv_64_hdr *reo_desc;
 	int ret;
@@ -235,13 +237,14 @@ int ath12k_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
 
 	switch (type) {
 	case HAL_REO_CMD_GET_QUEUE_STATS:
-		ret = ath12k_hal_reo_cmd_queue_stats(reo_desc, cmd);
+		ret = ath12k_wifi7_hal_reo_cmd_queue_stats(reo_desc, cmd);
 		break;
 	case HAL_REO_CMD_FLUSH_CACHE:
-		ret = ath12k_hal_reo_cmd_flush_cache(&ab->hal, reo_desc, cmd);
+		ret = ath12k_wifi7_hal_reo_cmd_flush_cache(&ab->hal, reo_desc,
+							   cmd);
 		break;
 	case HAL_REO_CMD_UPDATE_RX_QUEUE:
-		ret = ath12k_hal_reo_cmd_update_rx_queue(reo_desc, cmd);
+		ret = ath12k_wifi7_hal_reo_cmd_update_rx_queue(reo_desc, cmd);
 		break;
 	case HAL_REO_CMD_FLUSH_QUEUE:
 	case HAL_REO_CMD_UNBLOCK_CACHE:
@@ -262,8 +265,9 @@ int ath12k_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
 	return ret;
 }
 
-void ath12k_hal_rx_buf_addr_info_set(struct ath12k_buffer_addr *binfo,
-				     dma_addr_t paddr, u32 cookie, u8 manager)
+void ath12k_wifi7_hal_rx_buf_addr_info_set(struct ath12k_buffer_addr *binfo,
+					   dma_addr_t paddr, u32 cookie,
+					   u8 manager)
 {
 	u32 paddr_lo, paddr_hi;
 
@@ -275,9 +279,9 @@ void ath12k_hal_rx_buf_addr_info_set(struct ath12k_buffer_addr *binfo,
 		       le32_encode_bits(manager, BUFFER_ADDR_INFO1_RET_BUF_MGR);
 }
 
-void ath12k_hal_rx_buf_addr_info_get(struct ath12k_buffer_addr *binfo,
-				     dma_addr_t *paddr,
-				     u32 *cookie, u8 *rbm)
+void ath12k_wifi7_hal_rx_buf_addr_info_get(struct ath12k_buffer_addr *binfo,
+					   dma_addr_t *paddr,
+					   u32 *cookie, u8 *rbm)
 {
 	*paddr = (((u64)le32_get_bits(binfo->info1, BUFFER_ADDR_INFO1_ADDR)) << 32) |
 		le32_get_bits(binfo->info0, BUFFER_ADDR_INFO0_ADDR);
@@ -285,9 +289,10 @@ void ath12k_hal_rx_buf_addr_info_get(struct ath12k_buffer_addr *binfo,
 	*rbm = le32_get_bits(binfo->info1, BUFFER_ADDR_INFO1_RET_BUF_MGR);
 }
 
-void ath12k_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link, u32 *num_msdus,
-				      u32 *msdu_cookies,
-				      enum hal_rx_buf_return_buf_manager *rbm)
+void
+ath12k_wifi7_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link,
+				       u32 *num_msdus, u32 *msdu_cookies,
+				       enum hal_rx_buf_return_buf_manager *rbm)
 {
 	struct hal_rx_msdu_details *msdu;
 	u32 val;
@@ -314,9 +319,9 @@ void ath12k_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link, u32 *num_ms
 	}
 }
 
-int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
-				  struct hal_reo_dest_ring *desc,
-				  dma_addr_t *paddr, u32 *desc_bank)
+int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_base *ab,
+					struct hal_reo_dest_ring *desc,
+					dma_addr_t *paddr, u32 *desc_bank)
 {
 	enum hal_reo_dest_ring_push_reason push_reason;
 	enum hal_reo_dest_ring_error_code err_code;
@@ -341,14 +346,15 @@ int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
 		return -EINVAL;
 	}
 
-	ath12k_hal_rx_reo_ent_paddr_get(ab, &desc->buf_addr_info, paddr, &cookie);
+	ath12k_wifi7_hal_rx_reo_ent_paddr_get(ab, &desc->buf_addr_info, paddr,
+					      &cookie);
 	*desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
 
 	return 0;
 }
 
-int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
-				  struct hal_rx_wbm_rel_info *rel_info)
+int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
+					struct hal_rx_wbm_rel_info *rel_info)
 {
 	struct hal_wbm_release_ring *wbm_desc = desc;
 	struct hal_wbm_release_ring_cc_rx *wbm_cc_desc = desc;
@@ -435,9 +441,9 @@ int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 	return 0;
 }
 
-void ath12k_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
-				     struct ath12k_buffer_addr *buff_addr,
-				     dma_addr_t *paddr, u32 *cookie)
+void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
+					   struct ath12k_buffer_addr *buff_addr,
+					   dma_addr_t *paddr, u32 *cookie)
 {
 	*paddr = ((u64)(le32_get_bits(buff_addr->info1,
 				      BUFFER_ADDR_INFO1_ADDR)) << 32) |
@@ -526,10 +532,11 @@ void ath12k_hal_rx_msdu_list_get(struct ath12k *ar,
 	*num_msdus = i;
 }
 
-void ath12k_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
-				      struct hal_wbm_release_ring *desc,
-				      struct ath12k_buffer_addr *buf_addr_info,
-				      enum hal_wbm_rel_bm_act action)
+void
+ath12k_wifi7_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
+				       struct hal_wbm_release_ring *desc,
+				       struct ath12k_buffer_addr *buf_addr_info,
+				       enum hal_wbm_rel_bm_act action)
 {
 	desc->buf_addr_info = *buf_addr_info;
 	desc->info0 |= le32_encode_bits(HAL_WBM_REL_SRC_MODULE_SW,
@@ -539,8 +546,9 @@ void ath12k_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
 				     HAL_WBM_RELEASE_INFO0_DESC_TYPE);
 }
 
-void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab, struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status)
+void ath12k_wifi7_hal_reo_status_queue_stats(struct ath12k_base *ab,
+					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_status *status)
 {
 	struct hal_reo_get_queue_stats_status *desc =
 		(struct hal_reo_get_queue_stats_status *)tlv->value;
@@ -602,8 +610,9 @@ void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab, struct hal_tlv_64
 				 HAL_REO_GET_QUEUE_STATS_STATUS_INFO5_LOOPING_CNT));
 }
 
-void ath12k_hal_reo_flush_queue_status(struct ath12k_base *ab, struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status)
+void ath12k_wifi7_hal_reo_flush_queue_status(struct ath12k_base *ab,
+					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_status *status)
 {
 	struct hal_reo_flush_queue_status *desc =
 		(struct hal_reo_flush_queue_status *)tlv->value;
@@ -619,8 +628,10 @@ void ath12k_hal_reo_flush_queue_status(struct ath12k_base *ab, struct hal_tlv_64
 				      HAL_REO_FLUSH_QUEUE_INFO0_ERR_DETECTED);
 }
 
-void ath12k_hal_reo_flush_cache_status(struct ath12k_base *ab, struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status)
+void
+ath12k_wifi7_hal_reo_flush_cache_status(struct ath12k_base *ab,
+					struct hal_tlv_64_hdr *tlv,
+					struct hal_reo_status *status)
 {
 	struct ath12k_hal *hal = &ab->hal;
 	struct hal_reo_flush_cache_status *desc =
@@ -660,8 +671,9 @@ void ath12k_hal_reo_flush_cache_status(struct ath12k_base *ab, struct hal_tlv_64
 			      HAL_REO_FLUSH_CACHE_STATUS_INFO0_FLUSH_COUNT);
 }
 
-void ath12k_hal_reo_unblk_cache_status(struct ath12k_base *ab, struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status)
+void ath12k_wifi7_hal_reo_unblk_cache_status(struct ath12k_base *ab,
+					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_status *status)
 {
 	struct ath12k_hal *hal = &ab->hal;
 	struct hal_reo_unblock_cache_status *desc =
@@ -687,9 +699,10 @@ void ath12k_hal_reo_unblk_cache_status(struct ath12k_base *ab, struct hal_tlv_64
 		hal->avail_blk_resource &= ~BIT(hal->current_blk_index);
 }
 
-void ath12k_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
-					      struct hal_tlv_64_hdr *tlv,
-					      struct hal_reo_status *status)
+void
+ath12k_wifi7_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
+					       struct hal_tlv_64_hdr *tlv,
+					       struct hal_reo_status *status)
 {
 	struct hal_reo_flush_timeout_list_status *desc =
 		(struct hal_reo_flush_timeout_list_status *)tlv->value;
@@ -716,9 +729,10 @@ void ath12k_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
 			      HAL_REO_FLUSH_TIMEOUT_STATUS_INFO1_FWD_BUF_COUNT);
 }
 
-void ath12k_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
-					       struct hal_tlv_64_hdr *tlv,
-					       struct hal_reo_status *status)
+void
+ath12k_wifi7_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
+						struct hal_tlv_64_hdr *tlv,
+						struct hal_reo_status *status)
 {
 	struct hal_reo_desc_thresh_reached_status *desc =
 		(struct hal_reo_desc_thresh_reached_status *)tlv->value;
@@ -751,9 +765,9 @@ void ath12k_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
 			      HAL_REO_DESC_THRESH_STATUS_INFO4_LINK_DESC_COUNTER_SUM);
 }
 
-void ath12k_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
-					       struct hal_tlv_64_hdr *tlv,
-					       struct hal_reo_status *status)
+void ath12k_wifi7_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
+						     struct hal_tlv_64_hdr *tlv,
+						     struct hal_reo_status *status)
 {
 	struct hal_reo_status_hdr *desc =
 		(struct hal_reo_status_hdr *)tlv->value;
@@ -766,7 +780,7 @@ void ath12k_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
 				      HAL_REO_STATUS_HDR_INFO0_EXEC_STATUS);
 }
 
-u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid)
+u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid)
 {
 	u32 num_ext_desc, num_1k_desc = 0;
 
@@ -792,15 +806,15 @@ u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid)
 		(num_1k_desc * sizeof(struct hal_rx_reo_queue_1k));
 }
 
-void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
-				int tid, u32 ba_window_size,
-				u32 start_seq, enum hal_pn_type type)
+void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
+				      int tid, u32 ba_window_size,
+				      u32 start_seq, enum hal_pn_type type)
 {
 	struct hal_rx_reo_queue_ext *ext_desc;
 
-	ath12k_hal_reo_set_desc_hdr(&qdesc->desc_hdr, HAL_DESC_REO_OWNED,
-				    HAL_DESC_REO_QUEUE_DESC,
-				    REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_0);
+	ath12k_wifi7_hal_reo_set_desc_hdr(&qdesc->desc_hdr, HAL_DESC_REO_OWNED,
+					  HAL_DESC_REO_QUEUE_DESC,
+					  REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_0);
 
 	qdesc->rx_queue_num = le32_encode_bits(tid, HAL_RX_REO_QUEUE_RX_QUEUE_NUMBER);
 
@@ -858,21 +872,24 @@ void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 	 * queue descriptor in Rx peer entry as part of dp_rx_tid_update.
 	 */
 	memset(ext_desc, 0, 3 * sizeof(*ext_desc));
-	ath12k_hal_reo_set_desc_hdr(&ext_desc->desc_hdr, HAL_DESC_REO_OWNED,
-				    HAL_DESC_REO_QUEUE_EXT_DESC,
-				    REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_1);
+	ath12k_wifi7_hal_reo_set_desc_hdr(&ext_desc->desc_hdr,
+					  HAL_DESC_REO_OWNED,
+					  HAL_DESC_REO_QUEUE_EXT_DESC,
+					  REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_1);
 	ext_desc++;
-	ath12k_hal_reo_set_desc_hdr(&ext_desc->desc_hdr, HAL_DESC_REO_OWNED,
-				    HAL_DESC_REO_QUEUE_EXT_DESC,
-				    REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_2);
+	ath12k_wifi7_hal_reo_set_desc_hdr(&ext_desc->desc_hdr,
+					  HAL_DESC_REO_OWNED,
+					  HAL_DESC_REO_QUEUE_EXT_DESC,
+					  REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_2);
 	ext_desc++;
-	ath12k_hal_reo_set_desc_hdr(&ext_desc->desc_hdr, HAL_DESC_REO_OWNED,
-				    HAL_DESC_REO_QUEUE_EXT_DESC,
-				    REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_3);
+	ath12k_wifi7_hal_reo_set_desc_hdr(&ext_desc->desc_hdr,
+					  HAL_DESC_REO_OWNED,
+					  HAL_DESC_REO_QUEUE_EXT_DESC,
+					  REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_3);
 }
 
-void ath12k_hal_reo_init_cmd_ring(struct ath12k_base *ab,
-				  struct hal_srng *srng)
+void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
+					struct hal_srng *srng)
 {
 	struct hal_srng_params params;
 	struct hal_tlv_64_hdr *tlv;
@@ -896,7 +913,7 @@ void ath12k_hal_reo_init_cmd_ring(struct ath12k_base *ab,
 	}
 }
 
-void ath12k_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
+void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 {
 	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
 	u32 val;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index a4ecc65b8b5d..821b63914f64 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -820,47 +820,47 @@ enum hal_mon_reception_type {
 #define HAL_RU_PER80(ru_per80, num_80mhz, ru_idx_per80mhz) \
 			(HAL_RU(ru_per80, num_80mhz, ru_idx_per80mhz))
 
-void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab,
-				       struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status);
-void ath12k_hal_reo_flush_queue_status(struct ath12k_base *ab,
-				       struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status);
-void ath12k_hal_reo_flush_cache_status(struct ath12k_base *ab,
-				       struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status);
-void ath12k_hal_reo_unblk_cache_status(struct ath12k_base *ab,
-				       struct hal_tlv_64_hdr *tlv,
-				       struct hal_reo_status *status);
-void ath12k_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
-					      struct hal_tlv_64_hdr *tlv,
-					      struct hal_reo_status *status);
-void ath12k_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
-					       struct hal_tlv_64_hdr *tlv,
-					       struct hal_reo_status *status);
-void ath12k_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
-					       struct hal_tlv_64_hdr *tlv,
-					       struct hal_reo_status *status);
-void ath12k_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link, u32 *num_msdus,
-				      u32 *msdu_cookies,
-				      enum hal_rx_buf_return_buf_manager *rbm);
-void ath12k_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
-				      struct hal_wbm_release_ring *desc,
-				      struct ath12k_buffer_addr *buf_addr_info,
-				      enum hal_wbm_rel_bm_act action);
-void ath12k_hal_rx_buf_addr_info_set(struct ath12k_buffer_addr *binfo,
-				     dma_addr_t paddr, u32 cookie, u8 manager);
-void ath12k_hal_rx_buf_addr_info_get(struct ath12k_buffer_addr *binfo,
-				     dma_addr_t *paddr,
-				     u32 *cookie, u8 *rbm);
-int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
-				  struct hal_reo_dest_ring *desc,
-				  dma_addr_t *paddr, u32 *desc_bank);
-int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
-				  struct hal_rx_wbm_rel_info *rel_info);
-void ath12k_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
-				     struct ath12k_buffer_addr *buff_addr,
-				     dma_addr_t *paddr, u32 *cookie);
+void ath12k_wifi7_hal_reo_status_queue_stats(struct ath12k_base *ab,
+					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_status *status);
+void ath12k_wifi7_hal_reo_flush_queue_status(struct ath12k_base *ab,
+					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_status *status);
+void ath12k_wifi7_hal_reo_flush_cache_status(struct ath12k_base *ab,
+					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_status *status);
+void ath12k_wifi7_hal_reo_unblk_cache_status(struct ath12k_base *ab,
+					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_status *status);
+void ath12k_wifi7_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
+						    struct hal_tlv_64_hdr *tlv,
+						    struct hal_reo_status *status);
+void ath12k_wifi7_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
+						     struct hal_tlv_64_hdr *tlv,
+						     struct hal_reo_status *status);
+void ath12k_wifi7_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
+						     struct hal_tlv_64_hdr *tlv,
+						     struct hal_reo_status *status);
+void ath12k_wifi7_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link, u32 *num_msdus,
+					    u32 *msdu_cookies,
+					    enum hal_rx_buf_return_buf_manager *rbm);
+void ath12k_wifi7_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
+					    struct hal_wbm_release_ring *desc,
+					    struct ath12k_buffer_addr *buf_addr_info,
+					    enum hal_wbm_rel_bm_act action);
+void ath12k_wifi7_hal_rx_buf_addr_info_set(struct ath12k_buffer_addr *binfo,
+					   dma_addr_t paddr, u32 cookie, u8 manager);
+void ath12k_wifi7_hal_rx_buf_addr_info_get(struct ath12k_buffer_addr *binfo,
+					   dma_addr_t *paddr,
+					   u32 *cookie, u8 *rbm);
+int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_base *ab,
+					struct hal_reo_dest_ring *desc,
+					dma_addr_t *paddr, u32 *desc_bank);
+int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
+					struct hal_rx_wbm_rel_info *rel_info);
+void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
+					   struct ath12k_buffer_addr *buff_addr,
+					   dma_addr_t *paddr, u32 *cookie);
 void ath12k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr, u32 *sw_cookie,
 					 struct ath12k_buffer_addr **pp_buf_addr,
 					 u8 *rbm, u32 *msdu_cnt);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
index 3a7d3163b1a5..027e02141ec2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
@@ -29,9 +29,9 @@ static inline u8 dscp2tid(u8 dscp)
 	return dscp >> 3;
 }
 
-void ath12k_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
-				  struct hal_tcl_data_cmd *tcl_cmd,
-				  struct hal_tx_info *ti)
+void ath12k_wifi7_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
+					struct hal_tcl_data_cmd *tcl_cmd,
+					struct hal_tx_info *ti)
 {
 	tcl_cmd->buf_addr_info.info0 =
 		le32_encode_bits(ti->paddr, BUFFER_ADDR_INFO0_ADDR);
@@ -66,7 +66,7 @@ void ath12k_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
 	tcl_cmd->info5 = 0;
 }
 
-void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
+void ath12k_wifi7_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
 {
 	u32 ctrl_reg_val;
 	u32 addr;
@@ -137,8 +137,9 @@ void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
 			   ctrl_reg_val);
 }
 
-void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab, u32 bank_config,
-					   u8 bank_id)
+void ath12k_wifi7_hal_tx_configure_bank_register(struct ath12k_base *ab,
+						 u32 bank_config,
+						 u8 bank_id)
 {
 	ath12k_hif_write32(ab, HAL_TCL_SW_CONFIG_BANK_ADDR + 4 * bank_id,
 			   bank_config);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
index 412fe1ba22dc..d0f6a174f347 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
@@ -181,13 +181,13 @@ struct hal_tx_fes_status_end {
 /* STA mode will have MCAST_PKT_CTRL instead of DSCP_TID_MAP bitfield */
 #define HAL_TX_BANK_CONFIG_DSCP_TIP_MAP_ID	GENMASK(22, 17)
 
-void ath12k_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
-				  struct hal_tcl_data_cmd *tcl_cmd,
-				  struct hal_tx_info *ti);
-void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id);
-int ath12k_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
-			    enum hal_reo_cmd_type type,
-			    struct ath12k_hal_reo_cmd *cmd);
-void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab, u32 bank_config,
-					   u8 bank_id);
+void ath12k_wifi7_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
+					struct hal_tcl_data_cmd *tcl_cmd,
+					struct hal_tx_info *ti);
+void ath12k_wifi7_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id);
+int ath12k_wifi7_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
+				  enum hal_reo_cmd_type type,
+				  struct ath12k_hal_reo_cmd *cmd);
+void ath12k_wifi7_hal_tx_configure_bank_register(struct ath12k_base *ab,
+						 u32 bank_config, u8 bank_id);
 #endif
-- 
2.34.1


