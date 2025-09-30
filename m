Return-Path: <linux-wireless+bounces-27744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D1BACFA6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C36192838A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C6A303A14;
	Tue, 30 Sep 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LVEGYgcI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCF302CB8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237830; cv=none; b=Ie4soDDTPNtQtruQk27+lVFvRiM2xv9I5b8TUbuNky8pRVt2YLFGA1Qi0fEpHOXxg3M5IGiJ6fW412xL6UjyFVF9tZ0kHZJjBgRV8yQRnXfIalPz8tOGUvfMPio3Iywv0R0TasWzTwSRBmbhrEC399Ix1Bl81CSNobe3Qkgmd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237830; c=relaxed/simple;
	bh=FhZtDFfmeKitFV90cVor4OirmKAABWMPXhsRV54hNVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r31fuCtOWv/OPSISQF+Gdpo9ZrA1628QGZQ3bY4Gw46Ln/rNGKRVgScjM/2vQhitQbevvCNY/ojItyM+Js9KJFMc6q57VCBobchqrvUi0DHT9q86TUbF+tPOGfrZQeAdE1PGl+WLi7n/RaMGIvO0QU8ScUfitmO7WfJK0bz86gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LVEGYgcI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBPUgg027898;
	Tue, 30 Sep 2025 13:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vUUvbyZNkWLlHa83AoU+L7JEIaoGluCbFyg8ntSYYzM=; b=LVEGYgcIyVxdRX4m
	Xn9D78y7nK1DwIcv8NzqbnLL+rc18Z/o3LEE8eOJWREsCL06n6Zx+Tcz814b3QJc
	D4ttnz9Ro5fKyLPC2Qn+gMA3vUmuvu010yUIxqG5dPVybDbF5coJvUdtLJekYuCC
	bq/Ez6aBG6c/cro1OWysO8WSDpsK8umKRJfop09FvBnd2wOPNIgwk7iJEBxzIYhD
	DAZoIa+o9cvgY+0YDPydA6B/wje16V7Y2Lwhn7B6bb3kqzYSiOCaFSAIVDnpeeGW
	KN+w+5Y7VJOH/bjgjyJ6RNxaj1A8/5GnZHSObCVGmL5EdkUgzNhxza6C2RH466Bs
	ybwpoA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf2k2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:10:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58UDAO8T007672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:10:24 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 30 Sep 2025 06:10:23 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v4 3/6] wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
Date: Tue, 30 Sep 2025 18:40:02 +0530
Message-ID: <20250930131005.2884253-4-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
References: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LFQF4Md_3GqHP8qpdyPf2dnJMcach9Zo
X-Proofpoint-GUID: LFQF4Md_3GqHP8qpdyPf2dnJMcach9Zo
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dbd6c1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=7sIEUb9Th27A_HrKIYsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX7ow4uBQwF7kB
 6cpwYZpkjjYL5szt3kudu9EIpv/XMnrQ/vc91eudj2SCU09M3xYiv/j5Y+ZLOdHGvaDRzvBiKuv
 lrmlOE0gjq4RygUu3yH/RatI1mgnTY3OyA/BJ6MO/52v+6HlajHi09O7wkMuHA1Ilj1CONak+iY
 1TTAOARyvOQFd7mSiS6dPl8MlmYFnq+C3t3aI0o3JIAy+tOnM1zsojUOZtwQBx4OP3mxXqVPI7P
 YPmUMmeaRackVdAbzEgoOr1h2aNRAKPlGtMpr4niKWdp318rcUm+yritOkFM2sYDmSM0oS8dsE3
 e0SMFhestdS6RDJuVTBkf4Q+X06jiRTp01U9QOfGLaFoblr7LPhRgQ46ZmeE/5cv40rn0gA9rk+
 CzaCY/ko0f8OA1ukOBZsvt/SuBwUrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

Introduce the ath12k_dp_hw_group struct within ath12k_hw_group to
encapsulate all Data Path fields, providing a baseline for future
extensions. Add this struct to the top of ath12k_hw_group to allow
optimal usage of cache lines for data path fields, as it is accessed
in multiple tight loops in the per-packet path.

Add cmn_def.h to define common macros shared between DP and other
modules.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/cmn_defs.h    | 13 +++++
 drivers/net/wireless/ath/ath12k/core.c        |  4 ++
 drivers/net/wireless/ath/ath12k/core.h        |  9 ++-
 drivers/net/wireless/ath/ath12k/dp.c          | 24 ++++++++
 drivers/net/wireless/ath/ath12k/dp.h          | 10 ++++
 drivers/net/wireless/ath/ath12k/dp_cmn.h      | 12 ++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 58 +++++++++++--------
 drivers/net/wireless/ath/ath12k/wmi.h         |  5 +-
 8 files changed, 105 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h

diff --git a/drivers/net/wireless/ath/ath12k/cmn_defs.h b/drivers/net/wireless/ath/ath12k/cmn_defs.h
new file mode 100644
index 000000000000..e1f1f50341ff
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/cmn_defs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_CMN_DEFS_H
+#define ATH12K_CMN_DEFS_H
+
+#define MAX_RADIOS 2
+#define ATH12K_MAX_DEVICES 3
+#define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_DEVICES * MAX_RADIOS)
+
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index e5b358f5e703..84ac706fed20 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1993,6 +1993,8 @@ static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *a
 	ag->ab[ab->device_id] = ab;
 	ab->ag = ag;
 
+	ath12k_dp_cmn_hw_group_assign(ath12k_ab_to_dp(ab), ag);
+
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "wsi group-id %d num-devices %d index %d",
 		   ag->id, ag->num_devices, wsi->index);
 
@@ -2020,6 +2022,8 @@ void ath12k_core_hw_group_unassign(struct ath12k_base *ab)
 		return;
 	}
 
+	ath12k_dp_cmn_hw_group_unassign(ath12k_ab_to_dp(ab), ag);
+
 	ag->ab[device_id] = NULL;
 	ab->ag = NULL;
 	ab->device_id = ATH12K_INVALID_DEVICE_ID;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index f882cf4590f6..40bd1df1cda5 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -34,6 +34,7 @@
 #include "wow.h"
 #include "debugfs_htt_stats.h"
 #include "coredump.h"
+#include "cmn_defs.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -64,8 +65,6 @@
 #define ATH12K_RECONFIGURE_TIMEOUT_HZ		(10 * HZ)
 #define ATH12K_RECOVER_START_TIMEOUT_HZ		(20 * HZ)
 
-#define ATH12K_MAX_DEVICES 3
-#define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_DEVICES * MAX_RADIOS)
 #define ATH12K_INVALID_GROUP_ID  0xFF
 #define ATH12K_INVALID_DEVICE_ID 0xFF
 
@@ -980,6 +979,11 @@ struct ath12k_hw_link {
  * wiphy, protected with struct ath12k_hw_group::mutex.
  */
 struct ath12k_hw_group {
+	/* Keep dp_hw_grp as the first member to allow efficient
+	 * usage of cache lines for DP fields
+	 */
+	struct ath12k_dp_hw_group dp_hw_grp;
+	struct ath12k_hw_link hw_links[ATH12K_GROUP_MAX_RADIO];
 	struct list_head list;
 	u8 id;
 	u8 num_devices;
@@ -1002,7 +1006,6 @@ struct ath12k_hw_group {
 	bool mlo_capable;
 	struct device_node *wsi_node[ATH12K_MAX_DEVICES];
 	struct ath12k_mlo_memory mlo_mem;
-	struct ath12k_hw_link hw_links[ATH12K_GROUP_MAX_RADIO];
 	bool hw_link_id_init_done;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index f8d38562fc7f..39d6bd41b4ef 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1685,3 +1685,27 @@ int ath12k_dp_cmn_device_init(struct ath12k_dp *dp)
 
 	return 0;
 }
+
+void ath12k_dp_cmn_hw_group_unassign(struct ath12k_dp *dp,
+				     struct ath12k_hw_group *ag)
+{
+	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
+
+	lockdep_assert_held(&ag->mutex);
+
+	dp_hw_grp->dp[dp->device_id] = NULL;
+
+	dp->ag = NULL;
+	dp->device_id = ATH12K_INVALID_DEVICE_ID;
+}
+
+void ath12k_dp_cmn_hw_group_assign(struct ath12k_dp *dp,
+				   struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab = dp->ab;
+	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
+
+	dp->ag = ag;
+	dp->device_id = ab->device_id;
+	dp_hw_grp->dp[dp->device_id] = dp;
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 8b3973e0e676..05f48b461774 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -11,6 +11,7 @@
 #include "wifi7/hal_rx.h"
 #include "hw.h"
 #include "dp_htt.h"
+#include "dp_cmn.h"
 
 #define MAX_RXDMA_PER_PDEV     2
 
@@ -426,6 +427,9 @@ struct ath12k_dp {
 	struct ath12k_reo_q_addr_lut ml_reoq_lut;
 	const struct ath12k_hw_params *hw_params;
 	struct device *dev;
+
+	struct ath12k_hw_group *ag;
+	u8 device_id;
 };
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
@@ -434,6 +438,12 @@ static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
 }
 
+static inline struct ath12k_dp *
+ath12k_dp_hw_grp_to_dp(struct ath12k_dp_hw_group *dp_hw_grp, u8 device_id)
+{
+	return dp_hw_grp->dp[device_id];
+}
+
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
 void ath12k_dp_cc_config(struct ath12k_base *ab);
 void ath12k_dp_partner_cc_init(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_cmn.h b/drivers/net/wireless/ath/ath12k/dp_cmn.h
index acc0782ad309..70c92f6d33d6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_cmn.h
+++ b/drivers/net/wireless/ath/ath12k/dp_cmn.h
@@ -6,7 +6,19 @@
 #ifndef ATH12K_DP_CMN_H
 #define ATH12K_DP_CMN_H
 
+#include "cmn_defs.h"
+
+struct ath12k_hw_group;
+
+struct ath12k_dp_hw_group {
+	struct ath12k_dp *dp[ATH12K_MAX_DEVICES];
+};
+
 void ath12k_dp_cmn_device_deinit(struct ath12k_dp *dp);
 int ath12k_dp_cmn_device_init(struct ath12k_dp *dp);
+void ath12k_dp_cmn_hw_group_unassign(struct ath12k_dp *dp,
+				     struct ath12k_hw_group *ag);
+void ath12k_dp_cmn_hw_group_assign(struct ath12k_dp *dp,
+				   struct ath12k_hw_group *ag);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 6353c2f1f709..04c64b904693 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -558,7 +558,9 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 					    struct sk_buff_head *msdu_list,
 					    int ring_id)
 {
-	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_hw_group *ag = dp->ag;
+	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct ieee80211_rx_status rx_status = {};
 	struct ath12k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
@@ -566,6 +568,7 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	struct ath12k_base *partner_ab;
 	struct hal_rx_desc_data rx_info;
+	struct ath12k_dp *partner_dp;
 	u8 hw_link_id, pdev_id;
 	int ret;
 
@@ -580,10 +583,11 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 	while ((msdu = __skb_dequeue(msdu_list))) {
 		rxcb = ATH12K_SKB_RXCB(msdu);
 		hw_link_id = rxcb->hw_link_id;
-		partner_ab = ath12k_ag_to_ab(ag,
-					     hw_links[hw_link_id].device_id);
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp,
+						    hw_links[hw_link_id].device_id);
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_dp->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
+		partner_ab = partner_dp->ab;
 		ar = partner_ab->pdevs[pdev_id].ar;
 		if (!rcu_dereference(partner_ab->pdevs_active[pdev_id])) {
 			dev_kfree_skb_any(msdu);
@@ -612,12 +616,13 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 			       struct napi_struct *napi, int budget)
 {
-	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_hw_group *ag = dp->ag;
+	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
 	struct ath12k_rx_desc_info *desc_info;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 	struct hal_reo_dest_ring *desc;
 	struct ath12k_dp *partner_dp;
@@ -660,8 +665,8 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
 
 		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		if (unlikely(!partner_ab)) {
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
+		if (unlikely(!partner_dp)) {
 			if (desc_info->skb) {
 				dev_kfree_skb_any(desc_info->skb);
 				desc_info->skb = NULL;
@@ -669,6 +674,7 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 
 			continue;
 		}
+		partner_ab = partner_dp->ab;
 
 		/* retry manual desc retrieval */
 		if (!desc_info) {
@@ -755,8 +761,8 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		if (!num_buffs_reaped[device_id])
 			continue;
 
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		partner_dp = ath12k_ab_to_dp(partner_ab);
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
+		partner_ab = partner_dp->ab;
 		rx_ring = &partner_dp->rx_refill_buf_ring;
 
 		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
@@ -1290,8 +1296,9 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k *ar,
 int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 				   int budget)
 {
-	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_hw_group *ag = dp->ag;
+	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct ath12k_dp *partner_dp;
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
@@ -1346,8 +1353,8 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 		hw_link_id = le32_get_bits(reo_desc->info0,
 					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
 		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		partner_dp = ath12k_ab_to_dp(partner_ab);
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
+		partner_ab = partner_dp->ab;
 
 		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
@@ -1418,8 +1425,8 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 		if (!num_buffs_reaped[device_id])
 			continue;
 
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		partner_dp = ath12k_ab_to_dp(partner_ab);
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
+		partner_ab = partner_dp->ab;
 		rx_ring = &partner_dp->rx_refill_buf_ring;
 
 		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
@@ -1686,9 +1693,10 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				       struct napi_struct *napi, int budget)
 {
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
-	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k *ar;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_hw_group *ag = dp->ag;
+	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct ath12k_dp *partner_dp;
 	struct dp_rxdma_ring *rx_ring;
 	struct hal_rx_wbm_rel_info err_info;
@@ -1751,8 +1759,8 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		desc_info->skb = NULL;
 
 		device_id = desc_info->device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		if (unlikely(!partner_ab)) {
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
+		if (unlikely(!partner_dp)) {
 			dev_kfree_skb_any(msdu);
 
 			/* In any case continuation bit is set
@@ -1762,10 +1770,12 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
+		partner_ab = partner_dp->ab;
+
 		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(partner_ab->dev, rxcb->paddr,
+		dma_unmap_single(partner_dp->dev, rxcb->paddr,
 				 msdu->len + skb_tailroom(msdu),
 				 DMA_FROM_DEVICE);
 
@@ -1839,8 +1849,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		if (!num_buffs_reaped[device_id])
 			continue;
 
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		partner_dp = ath12k_ab_to_dp(partner_ab);
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
 		rx_ring = &partner_dp->rx_refill_buf_ring;
 
 		ath12k_dp_rx_bufs_replenish(ab, rx_ring,
@@ -1854,8 +1863,8 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		hw_link_id = rxcb->hw_link_id;
 
 		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		if (unlikely(!partner_ab)) {
+		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
+		if (unlikely(!partner_dp)) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "Unable to process WBM error msdu due to invalid hw link id %d device id %d\n",
 				   hw_link_id, device_id);
@@ -1863,8 +1872,9 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_dp->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
+		partner_ab = partner_dp->ab;
 		ar = partner_ab->pdevs[pdev_id].ar;
 
 		if (!ar || !rcu_dereference(ar->ab->pdevs_active[pdev_id])) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 833f42e6b826..6dcab9fceb1e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_WMI_H
@@ -9,6 +9,7 @@
 
 #include <net/mac80211.h>
 #include "htc.h"
+#include "cmn_defs.h"
 
 /* Naming conventions for structures:
  *
@@ -5123,8 +5124,6 @@ struct wmi_probe_tmpl_cmd {
 	__le32 buf_len;
 } __packed;
 
-#define MAX_RADIOS 2
-
 #define WMI_MLO_CMD_TIMEOUT_HZ (5 * HZ)
 #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)
 #define WMI_SEND_TIMEOUT_HZ (3 * HZ)
-- 
2.34.1


