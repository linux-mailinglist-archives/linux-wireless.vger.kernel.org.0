Return-Path: <linux-wireless+bounces-27759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE3BAE499
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 20:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DA34A0F21
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118D222580;
	Tue, 30 Sep 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ie9g2CzP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15B175A5
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256356; cv=none; b=fAMme0IEJHNFhhFu6kW6z/cJScClhdn4DGBht8GCVuGjGsMHFSZfYW97EyRia33ZIBo/Y/MsPfFf/Q5oStPmAMOIHxEPKHuSBtRPkGG0eTFRgcKLaH4Ka3KhvchCMqMFdk/SZ3rVqmPFuB+qK/0nenE/YvPr+HyxwBUwE2/URlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256356; c=relaxed/simple;
	bh=+lwZQk5jrzlINwGn4iA8sCDxCNPKOHCerr/NrcV3OQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7yRya9Lsc/ln9wO+FEOcllk6wW0VYfs9N5ySXLqwh1sXucZHGLPfed46ZmNBnojPbgtZuty0PhhwjqX+Klqdx05+o86X+n6pEjr5IYs5RP4yJHplxGoOV/OLdTGj9BgLvHdOMNdrONX/uEHApRgthcSenNl7Wf91a2BhYn0Ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ie9g2CzP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBj4oV023782;
	Tue, 30 Sep 2025 18:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMykSx4grN3TgnfFy3/3qDurGprRUPv4MVtj5H3UtAY=; b=ie9g2CzPvavP9IKg
	UhPAjeX7KV8anbGdQ5bp3H4vEIUyMztFJO8POECZLEDe82abVeYmFoLh/+UAenL+
	s3wVNPAeTcY8aZ8yY0dAuyQG6Rsp/V+ucl7YMG3jc8qUCDC4G7DXNz/YSGhalSKl
	2g2jfWUAke4HRnSrZllP5EOsns3rj+KwRZz8SVfjV2aUxfq5F0Gb8Ihliukwgfyk
	2em7SXiXo5h8rZ6c2FZ194YpyqJkdc/ysdmRD3hgvSfohZ33ozOJy9XlQ8Fj0n+P
	hKMlVxf31o5AgoLf1CMS+vQWTLVCAF8ay2d+5ZB0NDOiRp1Njqzjhekwg6mWwP7M
	QHHLeA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n2cuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 18:19:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58UIJ8n3011827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 18:19:08 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 30 Sep 2025 11:19:07 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 2/2] wifi: ath12k: Rearrange PPDU radio stats
Date: Tue, 30 Sep 2025 23:48:48 +0530
Message-ID: <20250930181848.3386271-3-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930181848.3386271-1-quic_rdeuri@quicinc.com>
References: <20250930181848.3386271-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bn_lSRwVPojjTuVEYASaBGQebmFUeQEK
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68dc1f1d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=39Ji4y11uKvlwzC5M-IA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Bn_lSRwVPojjTuVEYASaBGQebmFUeQEK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX2OGebPIuNvr9
 WukzvnKm4S9st9BhiBEVIOxBHOYD3GnERaunAPtdSZHhmu9k0xuWY/KBhK0h+HJKxmXcdkqkueq
 FrR37w/TXWWeIx9fqLITS7n2Bof71Gn7hSdJmnbSVIhyhs0nc1ms8cB5eA5YVs+N2/I1+BBDaaP
 yaurnYO4susPfNiwuIhdVej3Kb3KCAVV+2L7dT99Ou4cf8rv9DbkBthWF2cJGQwABIQuduLDGLv
 mifKl6e8/BQHtvrKld9kK0qAkaN4gy/i3XU3oZhjkS58i5AqVOVKUywKoCXIxlX0RI2iko+blLl
 fdws8vGroXAvBBKzrficU7xJ+e6wL6kQyC31eid/Qi8f9UmmtzyPeHTMd/oLZwngyOERxY+ae84
 5AhL8MVGipLjh3PC+H8TEYkj3V7stg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

Encapsulate PPDU stats in dp_pdev as these stats are related to data path
out-of-band operations. This reorganization improves the structuring of
data path stats and enhances the efficiency of data path operations by
consolidating both in-band (per packet) fields and out-of-band data path
stats within the same ath12k_pdev_dp object.

ppdu_list_lock is used to protect HTT pdev stats update.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   | 20 --------
 drivers/net/wireless/ath/ath12k/dp.h     |  6 +++
 drivers/net/wireless/ath/ath12k/dp_cmn.h | 18 ++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.c | 59 ++++++++++++++----------
 drivers/net/wireless/ath/ath12k/mac.c    | 11 +++--
 5 files changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2d4b470f4935..618e5c0bcaad 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -654,23 +654,6 @@ struct ath12k_debug {
 	bool extd_rx_stats;
 };
 
-struct ath12k_per_peer_tx_stats {
-	u32 succ_bytes;
-	u32 retry_bytes;
-	u32 failed_bytes;
-	u32 duration;
-	u16 succ_pkts;
-	u16 retry_pkts;
-	u16 failed_pkts;
-	u16 ru_start;
-	u16 ru_tones;
-	u8 ba_fails;
-	u8 ppdu_type;
-	u32 mu_grpid;
-	u32 mu_pos;
-	bool is_ampdu;
-};
-
 struct ath12k_pdev_rssi_offsets {
 	s32 temp_offset;
 	s8 min_nf_dbm;
@@ -795,9 +778,6 @@ struct ath12k {
 	struct ath12k_wow wow;
 	struct completion target_suspend;
 	bool target_suspend_ack;
-	struct ath12k_per_peer_tx_stats peer_tx_stats;
-	struct list_head ppdu_stats_info;
-	u32 ppdu_stat_list_depth;
 
 	struct ath12k_per_peer_tx_stats cached_stats;
 	u32 last_ppdu_id;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 084e0a3c1bbb..de5a7e0e4fe6 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -156,6 +156,12 @@ struct ath12k_pdev_dp {
 	struct ieee80211_hw *hw;
 	u8 hw_link_id;
 
+	/* Protects ppdu stats */
+	spinlock_t ppdu_list_lock;
+	struct ath12k_per_peer_tx_stats peer_tx_stats;
+	struct list_head ppdu_stats_info;
+	u32 ppdu_stat_list_depth;
+
 	struct dp_srng rxdma_mon_dst_ring[MAX_RXDMA_PER_PDEV];
 	struct dp_srng tx_mon_dst_ring[MAX_RXDMA_PER_PDEV];
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_cmn.h b/drivers/net/wireless/ath/ath12k/dp_cmn.h
index 3dc61d1a4162..243fb5a68016 100644
--- a/drivers/net/wireless/ath/ath12k/dp_cmn.h
+++ b/drivers/net/wireless/ath/ath12k/dp_cmn.h
@@ -34,6 +34,24 @@ struct ath12k_dp_vif {
 	struct ath12k_dp_link_vif dp_link_vif[ATH12K_NUM_MAX_LINKS];
 };
 
+/* TODO: Move this to a separate dp_stats file */
+struct ath12k_per_peer_tx_stats {
+	u32 succ_bytes;
+	u32 retry_bytes;
+	u32 failed_bytes;
+	u32 duration;
+	u16 succ_pkts;
+	u16 retry_pkts;
+	u16 failed_pkts;
+	u16 ru_start;
+	u16 ru_tones;
+	u8 ba_fails;
+	u8 ppdu_type;
+	u32 mu_grpid;
+	u32 mu_pos;
+	bool is_ampdu;
+};
+
 static inline struct ath12k_dp_link_vif *
 ath12k_dp_vif_to_dp_link_vif(struct ath12k_dp_vif *dp_vif, u8 link_id)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 267220f43fd2..1a0d3e4ac8bb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -183,14 +183,15 @@ int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 }
 
 static void
-ath12k_update_per_peer_tx_stats(struct ath12k *ar,
+ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 				struct htt_ppdu_stats *ppdu_stats, u8 user)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_peer *peer;
 	struct ath12k_link_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
-	struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
+	struct ath12k_per_peer_tx_stats *peer_stats = &dp_pdev->peer_tx_stats;
 	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
 	struct htt_ppdu_stats_common *common = &ppdu_stats->common;
 	int ret;
@@ -360,34 +361,34 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	rcu_read_unlock();
 }
 
-static void ath12k_htt_update_ppdu_stats(struct ath12k *ar,
+static void ath12k_htt_update_ppdu_stats(struct ath12k_pdev_dp *dp_pdev,
 					 struct htt_ppdu_stats *ppdu_stats)
 {
 	u8 user;
 
 	for (user = 0; user < HTT_PPDU_STATS_MAX_USERS - 1; user++)
-		ath12k_update_per_peer_tx_stats(ar, ppdu_stats, user);
+		ath12k_update_per_peer_tx_stats(dp_pdev, ppdu_stats, user);
 }
 
 static
-struct htt_ppdu_stats_info *ath12k_dp_htt_get_ppdu_desc(struct ath12k *ar,
+struct htt_ppdu_stats_info *ath12k_dp_htt_get_ppdu_desc(struct ath12k_pdev_dp *dp_pdev,
 							u32 ppdu_id)
 {
 	struct htt_ppdu_stats_info *ppdu_info;
 
-	lockdep_assert_held(&ar->data_lock);
-	if (!list_empty(&ar->ppdu_stats_info)) {
-		list_for_each_entry(ppdu_info, &ar->ppdu_stats_info, list) {
+	lockdep_assert_held(&dp_pdev->ppdu_list_lock);
+	if (!list_empty(&dp_pdev->ppdu_stats_info)) {
+		list_for_each_entry(ppdu_info, &dp_pdev->ppdu_stats_info, list) {
 			if (ppdu_info->ppdu_id == ppdu_id)
 				return ppdu_info;
 		}
 
-		if (ar->ppdu_stat_list_depth > HTT_PPDU_DESC_MAX_DEPTH) {
-			ppdu_info = list_first_entry(&ar->ppdu_stats_info,
+		if (dp_pdev->ppdu_stat_list_depth > HTT_PPDU_DESC_MAX_DEPTH) {
+			ppdu_info = list_first_entry(&dp_pdev->ppdu_stats_info,
 						     typeof(*ppdu_info), list);
 			list_del(&ppdu_info->list);
-			ar->ppdu_stat_list_depth--;
-			ath12k_htt_update_ppdu_stats(ar, &ppdu_info->ppdu_stats);
+			dp_pdev->ppdu_stat_list_depth--;
+			ath12k_htt_update_ppdu_stats(dp_pdev, &ppdu_info->ppdu_stats);
 			kfree(ppdu_info);
 		}
 	}
@@ -396,8 +397,8 @@ struct htt_ppdu_stats_info *ath12k_dp_htt_get_ppdu_desc(struct ath12k *ar,
 	if (!ppdu_info)
 		return NULL;
 
-	list_add_tail(&ppdu_info->list, &ar->ppdu_stats_info);
-	ar->ppdu_stat_list_depth++;
+	list_add_tail(&ppdu_info->list, &dp_pdev->ppdu_stats_info);
+	dp_pdev->ppdu_stat_list_depth++;
 
 	return ppdu_info;
 }
@@ -435,14 +436,15 @@ static void ath12k_copy_to_bar(struct ath12k_peer *peer,
 static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 				      struct sk_buff *skb)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_htt_ppdu_stats_msg *msg;
 	struct htt_ppdu_stats_info *ppdu_info;
 	struct ath12k_peer *peer = NULL;
 	struct htt_ppdu_user_stats *usr_stats = NULL;
 	u32 peer_id = 0;
-	struct ath12k *ar;
+	struct ath12k_pdev_dp *dp_pdev;
 	int ret, i;
-	u8 pdev_id;
+	u8 pdev_id, pdev_idx;
 	u32 ppdu_id, len;
 
 	msg = (struct ath12k_htt_ppdu_stats_msg *)skb->data;
@@ -457,17 +459,24 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 	pdev_id = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PDEV_ID);
 	ppdu_id = le32_to_cpu(msg->ppdu_id);
 
+	pdev_idx = DP_HW2SW_MACID(pdev_id);
+	if (pdev_idx >= MAX_RADIOS) {
+		ath12k_warn(ab, "HTT PPDU STATS invalid pdev id %u", pdev_id);
+		return -EINVAL;
+	}
+
 	rcu_read_lock();
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
-	if (!ar) {
+
+	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
+	if (!dp_pdev) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	spin_lock_bh(&ar->data_lock);
-	ppdu_info = ath12k_dp_htt_get_ppdu_desc(ar, ppdu_id);
+	spin_lock_bh(&dp_pdev->ppdu_list_lock);
+	ppdu_info = ath12k_dp_htt_get_ppdu_desc(dp_pdev, ppdu_id);
 	if (!ppdu_info) {
-		spin_unlock_bh(&ar->data_lock);
+		spin_unlock_bh(&dp_pdev->ppdu_list_lock);
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -477,13 +486,13 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 				     ath12k_htt_tlv_ppdu_stats_parse,
 				     (void *)ppdu_info);
 	if (ret) {
-		spin_unlock_bh(&ar->data_lock);
+		spin_unlock_bh(&dp_pdev->ppdu_list_lock);
 		ath12k_warn(ab, "Failed to parse tlv %d\n", ret);
 		goto exit;
 	}
 
 	if (ppdu_info->ppdu_stats.common.num_users >= HTT_PPDU_STATS_MAX_USERS) {
-		spin_unlock_bh(&ar->data_lock);
+		spin_unlock_bh(&dp_pdev->ppdu_list_lock);
 		ath12k_warn(ab,
 			    "HTT PPDU STATS event has unexpected num_users %u, should be smaller than %u\n",
 			    ppdu_info->ppdu_stats.common.num_users,
@@ -531,7 +540,7 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 		}
 	}
 
-	spin_unlock_bh(&ar->data_lock);
+	spin_unlock_bh(&dp_pdev->ppdu_list_lock);
 
 exit:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 692a88f25b5c..ebe7aba92ecc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9306,6 +9306,7 @@ int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable)
 
 static void ath12k_mac_stop(struct ath12k *ar)
 {
+	struct ath12k_pdev_dp *dp_pdev = &ar->dp;
 	struct ath12k_hw *ah = ar->ah;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
 	struct ath12k_wmi_scan_chan_list_arg *arg;
@@ -9330,13 +9331,14 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	ar->state_11d = ATH12K_11D_IDLE;
 	complete(&ar->completed_11d_scan);
 
-	spin_lock_bh(&ar->data_lock);
-
-	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
+	spin_lock_bh(&dp_pdev->ppdu_list_lock);
+	list_for_each_entry_safe(ppdu_stats, tmp, &dp_pdev->ppdu_stats_info, list) {
 		list_del(&ppdu_stats->list);
 		kfree(ppdu_stats);
 	}
+	spin_unlock_bh(&dp_pdev->ppdu_list_lock);
 
+	spin_lock_bh(&ar->data_lock);
 	while ((arg = list_first_entry_or_null(&ar->regd_channel_update_queue,
 					       struct ath12k_wmi_scan_chan_list_arg,
 					       list))) {
@@ -13998,8 +14000,9 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
 
 	spin_lock_init(&ar->data_lock);
+	spin_lock_init(&ar->dp.ppdu_list_lock);
 	INIT_LIST_HEAD(&ar->arvifs);
-	INIT_LIST_HEAD(&ar->ppdu_stats_info);
+	INIT_LIST_HEAD(&ar->dp.ppdu_stats_info);
 
 	init_completion(&ar->vdev_setup_done);
 	init_completion(&ar->vdev_delete_done);
-- 
2.34.1


