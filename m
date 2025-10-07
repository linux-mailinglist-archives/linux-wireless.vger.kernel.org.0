Return-Path: <linux-wireless+bounces-27858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C546BC1126
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD4824E2B66
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CF1A2398;
	Tue,  7 Oct 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T+5gjADj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664F199934
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834950; cv=none; b=SCxY7DrUQxjYVx9hX40M32quGsYEBvRWWllvXE4XKQmWhCdvkau0SjBYK2jOnd08xd8alASHpCbZk2XTFycpVBkrUl3lCuGUgMXnkBtH98UrDy2uSAuDER7thqD+6pNQtwf4d9frl5XOm50vtC6j7eeAUyZM5A6VeDyMJ0yCTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834950; c=relaxed/simple;
	bh=ra1tP85i+fjWG1g5+Tk4MBdSahkXEwSII0XOGEehhXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU/mNsDGpT8c0quJewOWz9dyOedN0kkmiEYjM2quOG29k4NZHWwYnFAX7DAl3LFPQnKUL1vV9R8u25CrtyH8k3Yln4pvk+fh19fHaSwHX+iogwv1oEr3bdOANLgpKiJo4180GjEwiSgZRn2KTBEqoqftgI1zyofbrjRTTR9RvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T+5gjADj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972vWYa025014;
	Tue, 7 Oct 2025 11:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PKkgv8dFfYws4xLHHohOJmGC0coiU/lm82nzq4/nW7o=; b=T+5gjADjXuk9fFEJ
	HTpr8481OYg8a1qr/UVgopbd27pvHKbXA9YAq/5htkUVYTdyL22kZuE/fsZ3zGJa
	BTin/qBw6aFEoTlDOeLc2lsSozFiZ4FG56Ln8yGZsaH1QI3b7Dbeone2z/nX3wKR
	BdcYqwTL9caGVOggA1yi8fCcfKuThwIhPCvwPv+t54W1cWyyZza9qIyuzJ43mixl
	9UYZtxl51MuM+UepRzKeM2hSXrJ/l/5hUxAfyYlNVEFgzS7Nnkt7BP9wXQLAsjuB
	wLnv9GJRPekwXu+8ByX2DSmQI5gtycKWkrISSarNX6zw1170jN4bPYr3UoxE7zOA
	gDqK/w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn797v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 11:02:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 597B2LOS030429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Oct 2025 11:02:21 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 7 Oct 2025 04:02:19 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v2 1/2] wifi: ath12k: Refactor data path pdev struct
Date: Tue, 7 Oct 2025 16:32:02 +0530
Message-ID: <20251007110203.1541167-2-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007110203.1541167-1-quic_rdeuri@quicinc.com>
References: <20251007110203.1541167-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX0bHyKSLtk84Z
 aG8O/yNbEfenTYa0uRKHZ0ZQC7E9o2Grg/8uzQU5zIjYfRX/4lI+cZMGnuOyIYBbeEoP/RqDIfv
 RUGsIfNw68Ze+RaUjhB7J1NMuPbIBNCdI77NFqvCPoQs2DJmABdzZJjVj+LBRupd5Hvs6BBYHCl
 /H/qdRth+ist7h8mpHeAlNOIii+4W1zN3Iun5aBk2r8SZ43jbLRFOdUyKgU0HcBT3IrFCpMOYNk
 p0zHD7haNUQ1otXHF56Tz9ys+YZGDOSJ1lrodE7//z9gYdDhbtB2XtRG4lDT5oTWtFirw3Qg2wa
 BLd3mRTqBAt4t0GyPdumBflLAAqFAxLOMhAtkNhd4EjUBDmKiCC2V+qcoFHEI7RBIzVELzBk2yk
 hKxAXEefSF+2+W4uKA+Mw1IsDSxnbQ==
X-Proofpoint-GUID: BqknAm8Y6_4PmzsRSoV285oxyGq5G-Yu
X-Proofpoint-ORIG-GUID: BqknAm8Y6_4PmzsRSoV285oxyGq5G-Yu
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e4f33e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=v7vh4aqi8rnXKMMUt_sA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

Refactor struct ath12k_pdev_dp to encapsulate all DP related fields of
radio (ar) and rely on this single pdev object in per packet DP
operations to optimize cache usage.

Introduce an array of RCU-protected ath12k_pdev_dp in DP device object
to find DP pdev directly from the DP device object.

RCU on dp_pdevs[] provides a teardown synchronization mechanism by
ensuring all in-flight access to dp_pdev pointers complete before reclaim.
Once a dp_pdev pointer is obtained, its internal fields can be accessed
as follows:

- Writers update internal fields using their own synchronization.
- Readers may perform lockless reads if occasional inconsistency is
  acceptable, or use additional synchronization (e.g., spin_lock,
  atomic_t) for a coherent view between readers and writers.

Please note that RCU is used for dp_pdevs[] at this stage to align
with ab->pdevs_active[]. However, if the teardown paths ensure quiescence,
both dp_pdevs[] and pdevs_active[] can be converted to plain pointers,
removing RCU synchronization overhead. This will be evaluated separately.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |   4 +
 drivers/net/wireless/ath/ath12k/dp.c          |  23 ++
 drivers/net/wireless/ath/ath12k/dp.h          |  35 +++
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 183 ++++++++-------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |   9 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  99 ++++----
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  13 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  23 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 216 ++++++++++--------
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  66 +++---
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +-
 11 files changed, 423 insertions(+), 250 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2d4b470f4935..d5c702789673 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1525,4 +1525,8 @@ static inline struct ath12k_dp *ath12k_ab_to_dp(struct ath12k_base *ab)
 	return ab->dp;
 }
 
+static inline struct ath12k *ath12k_pdev_dp_to_ar(struct ath12k_pdev_dp *dp)
+{
+	return container_of(dp, struct ath12k, dp);
+}
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1bca998117b7..1dcf421240e5 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -888,8 +888,17 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 
 void ath12k_dp_pdev_free(struct ath12k_base *ab)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k *ar;
 	int i;
 
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		rcu_assign_pointer(dp->dp_pdevs[ar->pdev_idx], NULL);
+	}
+
+	synchronize_rcu();
+
 	for (i = 0; i < ab->num_radios; i++)
 		ath12k_dp_rx_pdev_free(ab, i);
 }
@@ -911,6 +920,8 @@ void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
 
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_pdev_dp *dp_pdev;
 	struct ath12k *ar;
 	int ret;
 	int i;
@@ -922,6 +933,13 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 	/* TODO: Per-pdev rx ring unlike tx ring which is mapped to different AC's */
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
+
+		dp_pdev = &ar->dp;
+
+		dp_pdev->hw = ar->ah->hw;
+		dp_pdev->dp = dp;
+		dp_pdev->hw_link_id = ar->hw_link_id;
+
 		ret = ath12k_dp_rx_pdev_alloc(ab, i);
 		if (ret) {
 			ath12k_warn(ab, "failed to allocate pdev rx for pdev_id :%d\n",
@@ -935,6 +953,11 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 		}
 	}
 
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		rcu_assign_pointer(dp->dp_pdevs[ar->pdev_idx], &ar->dp);
+	}
+
 	return 0;
 err:
 	ath12k_dp_pdev_free(ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 546f73e46c41..6de93f481d99 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -151,6 +151,11 @@ struct ath12k_pdev_dp {
 	u32 mac_id;
 	atomic_t num_tx_pending;
 	wait_queue_head_t tx_empty_waitq;
+
+	struct ath12k_dp *dp;
+	struct ieee80211_hw *hw;
+	u8 hw_link_id;
+
 	struct dp_srng rxdma_mon_dst_ring[MAX_RXDMA_PER_PDEV];
 	struct dp_srng tx_mon_dst_ring[MAX_RXDMA_PER_PDEV];
 
@@ -437,6 +442,21 @@ struct ath12k_dp {
 	const struct ath12k_hw_params *hw_params;
 	struct device *dev;
 
+	/* RCU on dp_pdevs[] provides a teardown synchronization mechanism,
+	 * ensuring in-flight data path readers complete before reclaim. Writers
+	 * update internal fields under their own synchronization, while readers of
+	 * internal fields may perform lockless read if occasional inconsistency
+	 * is acceptable or use additional synchronization for a coherent view.
+	 *
+	 * RCU is used for dp_pdevs[] at this stage to align with
+	 * ab->pdevs_active[]. However, if the teardown paths ensure quiescence,
+	 * both dp_pdevs[] and pdevs_active[] can be converted to plain pointers,
+	 * removing RCU synchronize overhead.
+	 *
+	 * TODO: evaluate removal of RCU from dp_pdevs in the future
+	 */
+	struct ath12k_pdev_dp __rcu *dp_pdevs[MAX_RADIOS];
+
 	struct ath12k_hw_group *ag;
 	u8 device_id;
 
@@ -462,6 +482,21 @@ ath12k_dp_service_srng(struct ath12k_dp *dp, struct ath12k_ext_irq_grp *irq_grp,
 	return dp->ops->service_srng(dp, irq_grp, budget);
 }
 
+static inline struct ieee80211_hw *
+ath12k_pdev_dp_to_hw(struct ath12k_pdev_dp *pdev)
+{
+	return pdev->hw;
+}
+
+static inline struct ath12k_pdev_dp *
+ath12k_dp_to_pdev_dp(struct ath12k_dp *dp, u8 pdev_idx)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "ath12k dp to dp pdev called without rcu lock");
+
+	return rcu_dereference(dp->dp_pdevs[pdev_idx]);
+}
+
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
 void ath12k_dp_cc_config(struct ath12k_base *ab);
 void ath12k_dp_partner_cc_init(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 5b5d4800370e..d2924fe46b4f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1452,7 +1452,7 @@ ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 }
 
 static enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
+ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 				  struct ath12k_mon_data *pmon,
 				  const struct hal_tlv_64_hdr *tlv)
 {
@@ -1725,8 +1725,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 }
 
 static void
-ath12k_dp_mon_fill_rx_stats_info(struct ath12k *ar,
-				 struct hal_rx_mon_ppdu_info *ppdu_info,
+ath12k_dp_mon_fill_rx_stats_info(struct hal_rx_mon_ppdu_info *ppdu_info,
 				 struct ieee80211_rx_status *rx_status)
 {
 	u32 center_freq = ppdu_info->freq;
@@ -1871,10 +1870,12 @@ void ath12k_dp_mon_next_link_desc_get(struct hal_rx_msdu_link *msdu_link,
 }
 
 static void
-ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
+ath12k_dp_mon_fill_rx_rate(struct ath12k_pdev_dp *dp_pdev,
 			   struct hal_rx_mon_ppdu_info *ppdu_info,
 			   struct ieee80211_rx_status *rx_status)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ieee80211_supported_band *sband;
 	enum rx_msdu_start_pkt_type pkt_type;
 	u8 rate_mcs, nss, sgi;
@@ -1890,6 +1891,8 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 	case RX_MSDU_START_PKT_TYPE_11B:
 		is_cck = (pkt_type == RX_MSDU_START_PKT_TYPE_11B);
 		if (rx_status->band < NUM_NL80211_BANDS) {
+			struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+
 			sband = &ar->mac.sbands[rx_status->band];
 			rx_status->rate_idx = ath12k_mac_hw_rate_to_idx(sband, rate_mcs,
 									is_cck);
@@ -1898,7 +1901,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 	case RX_MSDU_START_PKT_TYPE_11N:
 		rx_status->encoding = RX_ENC_HT;
 		if (rate_mcs > ATH12K_HT_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(ab,
 				    "Received with invalid mcs in HT mode %d\n",
 				     rate_mcs);
 			break;
@@ -1911,7 +1914,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(ab,
 				    "Received with invalid mcs in VHT mode %d\n",
 				     rate_mcs);
 			break;
@@ -1922,7 +1925,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 	case RX_MSDU_START_PKT_TYPE_11AX:
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_HE_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(ab,
 				    "Received with invalid mcs in HE mode %d\n",
 				    rate_mcs);
 			break;
@@ -1933,7 +1936,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 	case RX_MSDU_START_PKT_TYPE_11BE:
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(ab,
 				    "Received with invalid mcs in EHT mode %d\n",
 				    rate_mcs);
 			break;
@@ -1942,24 +1945,24 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
 		break;
 	default:
-		ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
 			   "monitor receives invalid preamble type %d",
 			    pkt_type);
 		break;
 	}
 }
 
-static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
+static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k_base *ab,
 					       struct sk_buff *head_msdu,
 					       struct sk_buff *tail_msdu)
 {
 	u32 rx_pkt_offset, l2_hdr_offset, total_offset;
 
-	rx_pkt_offset = ar->ab->hal.hal_desc_sz;
+	rx_pkt_offset = ab->hal.hal_desc_sz;
 	l2_hdr_offset =
-		ath12k_dp_rx_h_l3pad(ar->ab, (struct hal_rx_desc *)tail_msdu->data);
+		ath12k_dp_rx_h_l3pad(ab, (struct hal_rx_desc *)tail_msdu->data);
 
-	if (ar->ab->hw_params->rxdma1_enable)
+	if (ab->hw_params->rxdma1_enable)
 		total_offset = ATH12K_MON_RX_PKT_OFFSET;
 	else
 		total_offset = rx_pkt_offset + l2_hdr_offset;
@@ -1968,12 +1971,13 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
 }
 
 static struct sk_buff *
-ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
+ath12k_dp_mon_rx_merg_msdus(struct ath12k_pdev_dp *dp_pdev,
 			    struct dp_mon_mpdu *mon_mpdu,
 			    struct hal_rx_mon_ppdu_info *ppdu_info,
 			    struct ieee80211_rx_status *rxs)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
 	struct sk_buff *head_msdu, *tail_msdu;
 	struct hal_rx_desc *rx_desc;
@@ -1990,11 +1994,13 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 	if (!head_msdu || !tail_msdu)
 		goto err_merge_fail;
 
-	ath12k_dp_mon_fill_rx_stats_info(ar, ppdu_info, rxs);
+	ath12k_dp_mon_fill_rx_stats_info(ppdu_info, rxs);
 
 	if (unlikely(rxs->band == NUM_NL80211_BANDS ||
-		     !ath12k_ar_to_hw(ar)->wiphy->bands[rxs->band])) {
-		ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+		     !ath12k_pdev_dp_to_hw(dp_pdev)->wiphy->bands[rxs->band])) {
+		struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
 			   "sband is NULL for status band %d channel_num %d center_freq %d pdev_id %d\n",
 			   rxs->band, channel_num, ppdu_info->freq, ar->pdev_idx);
 
@@ -2012,17 +2018,17 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		rxs->freq = ieee80211_channel_to_frequency(channel_num,
 							   rxs->band);
 
-	ath12k_dp_mon_fill_rx_rate(ar, ppdu_info, rxs);
+	ath12k_dp_mon_fill_rx_rate(dp_pdev, ppdu_info, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
-		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
+		ath12k_dp_mon_rx_msdus_set_payload(ab, head_msdu, tail_msdu);
 
 		prev_buf = head_msdu;
 		msdu = head_msdu->next;
 		head_frag_list = NULL;
 
 		while (msdu) {
-			ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
+			ath12k_dp_mon_rx_msdus_set_payload(ab, head_msdu, tail_msdu);
 
 			if (!head_frag_list)
 				head_frag_list = msdu;
@@ -2057,7 +2063,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		msdu = head_msdu;
 
 		while (msdu) {
-			ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
+			ath12k_dp_mon_rx_msdus_set_payload(ab, head_msdu, tail_msdu);
 			if (qos_pkt) {
 				dest = skb_push(msdu, sizeof(__le16));
 				if (!dest)
@@ -2141,11 +2147,12 @@ ath12k_dp_mon_rx_update_radiotap_he_mu(struct hal_rx_mon_ppdu_info *rx_status,
 	rtap_buf[rtap_len] = rx_status->he_RU[3];
 }
 
-static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
+static void ath12k_dp_mon_update_radiotap(struct ath12k_pdev_dp *dp_pdev,
 					  struct hal_rx_mon_ppdu_info *ppduinfo,
 					  struct sk_buff *mon_skb,
 					  struct ieee80211_rx_status *rxs)
 {
+	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
 	struct ieee80211_supported_band *sband;
 	s32 noise_floor;
 	u8 *ptr = NULL;
@@ -2234,6 +2241,9 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 		rxs->encoding = RX_ENC_HT;
 		rxs->rate_idx = ppduinfo->rate;
 	} else {
+		struct ath12k *ar;
+
+		ar = ath12k_pdev_dp_to_ar(dp_pdev);
 		rxs->encoding = RX_ENC_LEGACY;
 		sband = &ar->mac.sbands[rxs->band];
 		rxs->rate_idx = ath12k_mac_hw_rate_to_idx(sband, ppduinfo->rate,
@@ -2243,11 +2253,14 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 	rxs->mactime = ppduinfo->tsft;
 }
 
-static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
+static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
+					  struct napi_struct *napi,
 					  struct sk_buff *msdu,
 					  struct ieee80211_rx_status *status,
 					  u8 decap)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
 				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
@@ -2272,11 +2285,11 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
-	ath12k_wifi7_dp_extract_rx_desc_data(ar->ab, &rx_info, rx_desc, rx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(ab, &rx_info, rx_desc, rx_desc);
 
-	spin_lock_bh(&ar->ab->base_lock);
+	spin_lock_bh(&ab->base_lock);
 	rx_info.addr2_present = false;
-	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, &rx_info);
+	peer = ath12k_dp_rx_h_find_peer(ab, msdu, &rx_info);
 	if (peer && peer->sta) {
 		pubsta = peer->sta;
 		if (pubsta->valid_links) {
@@ -2285,9 +2298,9 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		}
 	}
 
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&ab->base_lock);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+	ath12k_dbg(ab, ATH12K_DBG_DATA,
 		   "rx skb %p len %u peer %pM %u %s %s%s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
@@ -2311,7 +2324,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		   !!(status->flag & RX_FLAG_MMIC_ERROR),
 		   !!(status->flag & RX_FLAG_AMSDU_MORE));
 
-	ath12k_dbg_dump(ar->ab, ATH12K_DBG_DP_RX, NULL, "dp rx msdu: ",
+	ath12k_dbg_dump(ab, ATH12K_DBG_DP_RX, NULL, "dp rx msdu: ",
 			msdu->data, msdu->len);
 	rx_status = IEEE80211_SKB_RXCB(msdu);
 	*rx_status = *status;
@@ -2327,20 +2340,19 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
+	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
 }
 
-static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
+static int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
 				    struct dp_mon_mpdu *mon_mpdu,
 				    struct hal_rx_mon_ppdu_info *ppduinfo,
 				    struct napi_struct *napi)
 {
-	struct ath12k_pdev_dp *dp = &ar->dp;
 	struct sk_buff *mon_skb, *skb_next, *header;
-	struct ieee80211_rx_status *rxs = &dp->rx_status;
+	struct ieee80211_rx_status *rxs = &dp_pdev->rx_status;
 	u8 decap = DP_RX_DECAP_TYPE_RAW;
 
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mon_mpdu, ppduinfo, rxs);
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(dp_pdev, mon_mpdu, ppduinfo, rxs);
 	if (!mon_skb)
 		goto mon_deliver_fail;
 
@@ -2368,8 +2380,8 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 		if (!(rxs->flag & RX_FLAG_ONLY_MONITOR))
 			decap = mon_mpdu->decap_format;
 
-		ath12k_dp_mon_update_radiotap(ar, ppduinfo, mon_skb, rxs);
-		ath12k_dp_mon_rx_deliver_msdu(ar, napi, mon_skb, rxs, decap);
+		ath12k_dp_mon_update_radiotap(dp_pdev, ppduinfo, mon_skb, rxs);
+		ath12k_dp_mon_rx_deliver_msdu(dp_pdev, napi, mon_skb, rxs, decap);
 		mon_skb = skb_next;
 	} while (mon_skb);
 	rxs->flag = 0;
@@ -2431,12 +2443,12 @@ ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
 }
 
 static int
-ath12k_dp_mon_parse_status_buf(struct ath12k *ar,
+ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 			       struct ath12k_mon_data *pmon,
 			       const struct dp_mon_packet_info *packet_info)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct dp_rxdma_mon_ring *buf_ring = &dp->rxdma_mon_buf_ring;
 	struct sk_buff *msdu;
 	int buf_id;
@@ -2477,7 +2489,7 @@ ath12k_dp_mon_parse_status_buf(struct ath12k *ar,
 }
 
 static int
-ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k *ar,
+ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
 				struct ath12k_mon_data *pmon,
 				enum hal_rx_mon_status hal_status,
 				const void *tlv_data)
@@ -2492,7 +2504,7 @@ ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k *ar,
 			return -ENOMEM;
 		break;
 	case HAL_RX_MON_STATUS_BUF_ADDR:
-		return ath12k_dp_mon_parse_status_buf(ar, pmon, tlv_data);
+		return ath12k_dp_mon_parse_status_buf(dp_pdev, pmon, tlv_data);
 	case HAL_RX_MON_STATUS_MPDU_END:
 		/* If no MSDU then free empty MPDU */
 		if (pmon->mon_mpdu->tail) {
@@ -2515,9 +2527,10 @@ ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k *ar,
 }
 
 static enum hal_rx_mon_status
-ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
+ath12k_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev, struct ath12k_mon_data *pmon,
 			    struct sk_buff *skb)
 {
+	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
 	struct hal_tlv_64_hdr *tlv;
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_rx_mon_status hal_status;
@@ -2539,10 +2552,11 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 		else
 			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
 
-		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon, tlv);
+		hal_status = ath12k_dp_mon_rx_parse_status_tlv(dp_pdev, pmon, tlv);
 
 		if (ar->monitor_started && ar->ab->hw_params->rxdma1_enable &&
-		    ath12k_dp_mon_parse_rx_dest_tlv(ar, pmon, hal_status, tlv->value))
+		    ath12k_dp_mon_parse_rx_dest_tlv(dp_pdev, pmon, hal_status,
+						    tlv->value))
 			return HAL_RX_MON_STATUS_PPDU_DONE;
 
 		ptr += sizeof(*tlv) + tlv_len;
@@ -2565,7 +2579,7 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 }
 
 enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
+ath12k_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 				  struct ath12k_mon_data *pmon,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi)
@@ -2575,7 +2589,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
 	enum hal_rx_mon_status hal_status;
 
-	hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
+	hal_status = ath12k_dp_mon_parse_rx_dest(dp_pdev, pmon, skb);
 	if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE)
 		return hal_status;
 
@@ -2583,7 +2597,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 		list_del(&mon_mpdu->list);
 
 		if (mon_mpdu->head && mon_mpdu->tail)
-			ath12k_dp_mon_rx_deliver(ar, mon_mpdu, ppdu_info, napi);
+			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu, ppdu_info, napi);
 
 		kfree(mon_mpdu);
 	}
@@ -3351,7 +3365,7 @@ ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
 }
 
 static void
-ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar,
+ath12k_dp_mon_tx_process_ppdu_info(struct ath12k_pdev_dp *dp_pdev,
 				   struct napi_struct *napi,
 				   struct dp_mon_tx_ppdu_info *tx_ppdu_info)
 {
@@ -3362,7 +3376,7 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar,
 		list_del(&mon_mpdu->list);
 
 		if (mon_mpdu->head)
-			ath12k_dp_mon_rx_deliver(ar, mon_mpdu,
+			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu,
 						 &tx_ppdu_info->rx_status, napi);
 
 		kfree(mon_mpdu);
@@ -3370,13 +3384,14 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar,
 }
 
 enum hal_rx_mon_status
-ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
+ath12k_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 				  struct ath12k_mon_data *pmon,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi,
 				  u32 ppdu_id)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct dp_mon_tx_ppdu_info *tx_prot_ppdu_info, *tx_data_ppdu_info;
 	struct hal_tlv_hdr *tlv;
 	u8 *ptr = skb->data;
@@ -3418,8 +3433,8 @@ ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
 			break;
 	} while (tlv_status != DP_MON_TX_FES_STATUS_END);
 
-	ath12k_dp_mon_tx_process_ppdu_info(ar, napi, tx_data_ppdu_info);
-	ath12k_dp_mon_tx_process_ppdu_info(ar, napi, tx_prot_ppdu_info);
+	ath12k_dp_mon_tx_process_ppdu_info(dp_pdev, napi, tx_data_ppdu_info);
+	ath12k_dp_mon_tx_process_ppdu_info(dp_pdev, napi, tx_prot_ppdu_info);
 
 	return tlv_status;
 }
@@ -3457,8 +3472,7 @@ ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_st
 	stats->rx_rate[bw_idx][gi_idx][nss_idx][mcs_idx] += len;
 }
 
-static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
-						  struct ath12k_link_sta *arsta,
+static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_link_sta *arsta,
 						  struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	struct ath12k_rx_peer_stats *rx_stats = arsta->rx_stats;
@@ -3616,7 +3630,7 @@ void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info)
 }
 
 static void
-ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
+ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
 				   u32 uid)
 {
@@ -3629,17 +3643,17 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 	if (user_stats->ast_index == 0 || user_stats->ast_index == 0xFFFF)
 		return;
 
-	peer = ath12k_peer_find_by_ast(ar->ab, user_stats->ast_index);
+	peer = ath12k_peer_find_by_ast(ab, user_stats->ast_index);
 
 	if (!peer) {
-		ath12k_warn(ar->ab, "peer ast idx %d can't be found\n",
+		ath12k_warn(ab, "peer ast idx %d can't be found\n",
 			    user_stats->ast_index);
 		return;
 	}
 
-	arsta = ath12k_peer_get_link_sta(ar->ab, peer);
+	arsta = ath12k_peer_get_link_sta(ab, peer);
 	if (!arsta) {
-		ath12k_warn(ar->ab, "link sta not found on peer %pM id %d\n",
+		ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
 			    peer->addr, peer->peer_id);
 		return;
 	}
@@ -3722,7 +3736,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 }
 
 static void
-ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k *ar,
+ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 				      struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	u32 num_users, i;
@@ -3732,7 +3746,7 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k *ar,
 		num_users = HAL_MAX_UL_MU_USERS;
 
 	for (i = 0; i < num_users; i++)
-		ath12k_dp_mon_rx_update_user_stats(ar, ppdu_info, i);
+		ath12k_dp_mon_rx_update_user_stats(ab, ppdu_info, i);
 }
 
 static void
@@ -3742,14 +3756,13 @@ ath12k_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
 
-int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
+int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 			       struct napi_struct *napi)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_pdev_dp *pdev_dp = &ar->dp;
+	struct ath12k_dp *dp = pdev_dp->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&pdev_dp->mon_data;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_mon_dest_desc *mon_dst_desc;
 	struct sk_buff *skb;
 	struct ath12k_skb_rxcb *rxcb;
@@ -3762,7 +3775,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	u64 cookie;
 	int num_buffs_reaped = 0, srng_id, buf_id;
 	u32 hal_status, end_offset, info0, end_reason;
-	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, ar->pdev_idx);
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, pdev_dp->mac_id);
 
 	__skb_queue_head_init(&skb_list);
 	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, pdev_idx);
@@ -3860,7 +3873,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
 
 	while ((skb = __skb_dequeue(&skb_list))) {
-		hal_status = ath12k_dp_mon_rx_parse_mon_status(ar, pmon, skb, napi);
+		hal_status = ath12k_dp_mon_rx_parse_mon_status(pdev_dp, pmon, skb, napi);
 		if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
 			ppdu_info->ppdu_continuation = true;
 			dev_kfree_skb_any(skb);
@@ -3881,21 +3894,21 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		}
 
 		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-			arsta = ath12k_peer_get_link_sta(ar->ab, peer);
+			arsta = ath12k_peer_get_link_sta(ab, peer);
 			if (!arsta) {
-				ath12k_warn(ar->ab, "link sta not found on peer %pM id %d\n",
+				ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
 					    peer->addr, peer->peer_id);
 				spin_unlock_bh(&ab->base_lock);
 				rcu_read_unlock();
 				dev_kfree_skb_any(skb);
 				continue;
 			}
-			ath12k_dp_mon_rx_update_peer_su_stats(ar, arsta,
+			ath12k_dp_mon_rx_update_peer_su_stats(arsta,
 							      ppdu_info);
 		} else if ((ppdu_info->fc_valid) &&
 			   (ppdu_info->ast_index != HAL_AST_IDX_INVALID)) {
 			ath12k_dp_mon_rx_process_ulofdma(ppdu_info);
-			ath12k_dp_mon_rx_update_peer_mu_stats(ar, ppdu_info);
+			ath12k_dp_mon_rx_update_peer_mu_stats(ab, ppdu_info);
 		}
 
 next_skb:
@@ -4329,7 +4342,7 @@ static void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
 			tmp_mpdu->tail = tail_msdu;
 			tmp_mpdu->err_bitmap = pmon->err_bitmap;
 			tmp_mpdu->decap_format = pmon->decap_format;
-			ath12k_dp_mon_rx_deliver(ar, tmp_mpdu,
+			ath12k_dp_mon_rx_deliver(&ar->dp, tmp_mpdu,
 						 &pmon->mon_ppdu_info, napi);
 			rx_mon_stats->dest_mpdu_done++;
 			kfree(tmp_mpdu);
@@ -4374,7 +4387,7 @@ __ath12k_dp_mon_process_ring(struct ath12k *ar, int mac_id,
 		memset(ppdu_info, 0, sizeof(*ppdu_info));
 		ppdu_info->peer_id = HAL_INVALID_PEERID;
 
-		hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
+		hal_status = ath12k_dp_mon_parse_rx_dest(&ar->dp, pmon, skb);
 
 		if (ar->monitor_started &&
 		    pmon->mon_ppdu_status == DP_PPDU_STATUS_START &&
@@ -4396,17 +4409,33 @@ int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 			       struct napi_struct *napi, int budget,
 			       enum dp_monitor_mode monitor_mode)
 {
-	struct ath12k *ar = ath12k_ab_to_ar(ab, mac_id);
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_pdev_dp *dp_pdev;
+	struct ath12k *ar;
 	int num_buffs_reaped = 0;
 
+	rcu_read_lock();
+
+	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
+	if (!dp_pdev) {
+		rcu_read_unlock();
+		return 0;
+	}
+
 	if (ab->hw_params->rxdma1_enable) {
 		if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
-			num_buffs_reaped = ath12k_dp_mon_srng_process(ar, &budget, napi);
+			num_buffs_reaped = ath12k_dp_mon_srng_process(dp_pdev, &budget,
+								      napi);
 	} else {
+		ar = ath12k_pdev_dp_to_ar(dp_pdev);
+
 		if (ar->monitor_started)
 			num_buffs_reaped =
 				__ath12k_dp_mon_process_ring(ar, mac_id, napi, &budget);
 	}
 
+	rcu_read_unlock();
+
 	return num_buffs_reaped;
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index e25595cbdcf3..068df7400345 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_DP_MON_H
@@ -78,7 +78,7 @@ struct dp_mon_tx_ppdu_info {
 };
 
 enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
+ath12k_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 				  struct ath12k_mon_data *pmon,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi);
@@ -97,11 +97,12 @@ ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
 				     struct hal_tlv_hdr *tx_tlv,
 				     u8 *num_users);
 enum hal_rx_mon_status
-ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
+ath12k_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 				  struct ath12k_mon_data *pmon,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi,
 				  u32 ppdu_id);
 void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info);
-int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget, struct napi_struct *napi);
+int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
+			       struct napi_struct *napi);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index daf78b7d56cf..a81859b25bd2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -740,7 +740,7 @@ struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
 	return NULL;
 }
 
-int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype)
+int ath12k_dp_rx_crypto_mic_len(struct ath12k_dp *dp, enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
 	case HAL_ENCRYPT_TYPE_OPEN:
@@ -762,11 +762,11 @@ int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype
 		break;
 	}
 
-	ath12k_warn(ar->ab, "unsupported encryption type %d for mic len\n", enctype);
+	ath12k_warn(dp->ab, "unsupported encryption type %d for mic len\n", enctype);
 	return 0;
 }
 
-static int ath12k_dp_rx_crypto_param_len(struct ath12k *ar,
+static int ath12k_dp_rx_crypto_param_len(struct ath12k_pdev_dp *dp_pdev,
 					 enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
@@ -790,11 +790,11 @@ static int ath12k_dp_rx_crypto_param_len(struct ath12k *ar,
 		break;
 	}
 
-	ath12k_warn(ar->ab, "unsupported encryption type %d\n", enctype);
+	ath12k_warn(dp_pdev->dp->ab, "unsupported encryption type %d\n", enctype);
 	return 0;
 }
 
-static int ath12k_dp_rx_crypto_icv_len(struct ath12k *ar,
+static int ath12k_dp_rx_crypto_icv_len(struct ath12k_pdev_dp *dp_pdev,
 				       enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
@@ -815,15 +815,17 @@ static int ath12k_dp_rx_crypto_icv_len(struct ath12k *ar,
 		break;
 	}
 
-	ath12k_warn(ar->ab, "unsupported encryption type %d\n", enctype);
+	ath12k_warn(dp_pdev->dp->ab, "unsupported encryption type %d\n", enctype);
 	return 0;
 }
 
-static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
+static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k_pdev_dp *dp_pdev,
 					 struct sk_buff *msdu,
 					 enum hal_encrypt_type enctype,
 					 struct hal_rx_desc_data *rx_info)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u8 decap_hdr[DP_MAX_NWIFI_HDR_LEN];
 	struct ieee80211_hdr *hdr;
@@ -854,8 +856,9 @@ static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
 
 	/* Rebuild crypto header for mac80211 use */
 	if (!(rx_info->rx_status->flag & RX_FLAG_IV_STRIPPED)) {
-		crypto_hdr = skb_push(msdu, ath12k_dp_rx_crypto_param_len(ar, enctype));
-		ath12k_dp_rx_desc_get_crypto_header(ar->ab,
+		crypto_hdr = skb_push(msdu,
+				      ath12k_dp_rx_crypto_param_len(dp_pdev, enctype));
+		ath12k_dp_rx_desc_get_crypto_header(ab,
 						    rxcb->rx_desc, crypto_hdr,
 						    enctype);
 	}
@@ -866,11 +869,13 @@ static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
 	memcpy(skb_push(msdu, hdr_len), decap_hdr, hdr_len);
 }
 
-static void ath12k_dp_rx_h_undecap_raw(struct ath12k *ar, struct sk_buff *msdu,
+static void ath12k_dp_rx_h_undecap_raw(struct ath12k_pdev_dp *dp_pdev,
+				       struct sk_buff *msdu,
 				       enum hal_encrypt_type enctype,
 				       struct ieee80211_rx_status *status,
 				       bool decrypted)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
@@ -892,20 +897,20 @@ static void ath12k_dp_rx_h_undecap_raw(struct ath12k *ar, struct sk_buff *msdu,
 	/* Tail */
 	if (status->flag & RX_FLAG_IV_STRIPPED) {
 		skb_trim(msdu, msdu->len -
-			 ath12k_dp_rx_crypto_mic_len(ar, enctype));
+			 ath12k_dp_rx_crypto_mic_len(dp, enctype));
 
 		skb_trim(msdu, msdu->len -
-			 ath12k_dp_rx_crypto_icv_len(ar, enctype));
+			 ath12k_dp_rx_crypto_icv_len(dp_pdev, enctype));
 	} else {
 		/* MIC */
 		if (status->flag & RX_FLAG_MIC_STRIPPED)
 			skb_trim(msdu, msdu->len -
-				 ath12k_dp_rx_crypto_mic_len(ar, enctype));
+				 ath12k_dp_rx_crypto_mic_len(dp, enctype));
 
 		/* ICV */
 		if (status->flag & RX_FLAG_ICV_STRIPPED)
 			skb_trim(msdu, msdu->len -
-				 ath12k_dp_rx_crypto_icv_len(ar, enctype));
+				 ath12k_dp_rx_crypto_icv_len(dp_pdev, enctype));
 	}
 
 	/* MMIC */
@@ -917,21 +922,22 @@ static void ath12k_dp_rx_h_undecap_raw(struct ath12k *ar, struct sk_buff *msdu,
 	/* Head */
 	if (status->flag & RX_FLAG_IV_STRIPPED) {
 		hdr_len = ieee80211_hdrlen(hdr->frame_control);
-		crypto_len = ath12k_dp_rx_crypto_param_len(ar, enctype);
+		crypto_len = ath12k_dp_rx_crypto_param_len(dp_pdev, enctype);
 
 		memmove(msdu->data + crypto_len, msdu->data, hdr_len);
 		skb_pull(msdu, crypto_len);
 	}
 }
 
-static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
+static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k_pdev_dp *dp_pdev,
 					      struct sk_buff *msdu,
 					      struct ath12k_skb_rxcb *rxcb,
 					      enum hal_encrypt_type enctype,
 					      struct hal_rx_desc_data *rx_info)
 {
 	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	size_t hdr_len, crypto_len;
 	struct ieee80211_hdr hdr;
 	__le16 qos_ctl;
@@ -941,7 +947,7 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 	hdr_len = ieee80211_hdrlen(hdr.frame_control);
 
 	if (!(rx_info->rx_status->flag & RX_FLAG_IV_STRIPPED)) {
-		crypto_len = ath12k_dp_rx_crypto_param_len(ar, enctype);
+		crypto_len = ath12k_dp_rx_crypto_param_len(dp_pdev, enctype);
 		crypto_hdr = skb_push(msdu, crypto_len);
 		ath12k_dp_rx_desc_get_crypto_header(ab, rx_desc, crypto_hdr, enctype);
 	}
@@ -964,7 +970,7 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 	}
 }
 
-static void ath12k_dp_rx_h_undecap_eth(struct ath12k *ar,
+static void ath12k_dp_rx_h_undecap_eth(struct ath12k_pdev_dp *dp_pdev,
 				       struct sk_buff *msdu,
 				       enum hal_encrypt_type enctype,
 				       struct hal_rx_desc_data *rx_info)
@@ -983,7 +989,7 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k *ar,
 	skb_pull(msdu, sizeof(*eth));
 	memcpy(skb_push(msdu, sizeof(rfc)), &rfc,
 	       sizeof(rfc));
-	ath12k_get_dot11_hdr_from_rx_desc(ar, msdu, rxcb, enctype, rx_info);
+	ath12k_get_dot11_hdr_from_rx_desc(dp_pdev, msdu, rxcb, enctype, rx_info);
 
 	/* original 802.11 header has a different DA and in
 	 * case of 4addr it may also have different SA
@@ -993,7 +999,7 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k *ar,
 	ether_addr_copy(ieee80211_get_SA(hdr), sa);
 }
 
-void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
+void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 			    struct hal_rx_desc *rx_desc,
 			    enum hal_encrypt_type enctype,
 			    bool decrypted,
@@ -1003,10 +1009,10 @@ void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 
 	switch (rx_info->decap_type) {
 	case DP_RX_DECAP_TYPE_NATIVE_WIFI:
-		ath12k_dp_rx_h_undecap_nwifi(ar, msdu, enctype, rx_info);
+		ath12k_dp_rx_h_undecap_nwifi(dp_pdev, msdu, enctype, rx_info);
 		break;
 	case DP_RX_DECAP_TYPE_RAW:
-		ath12k_dp_rx_h_undecap_raw(ar, msdu, enctype, rx_info->rx_status,
+		ath12k_dp_rx_h_undecap_raw(dp_pdev, msdu, enctype, rx_info->rx_status,
 					   decrypted);
 		break;
 	case DP_RX_DECAP_TYPE_ETHERNET2_DIX:
@@ -1015,7 +1021,7 @@ void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 		/* mac80211 allows fast path only for authorized STA */
 		if (ehdr->h_proto == cpu_to_be16(ETH_P_PAE)) {
 			ATH12K_SKB_RXCB(msdu)->is_eapol = true;
-			ath12k_dp_rx_h_undecap_eth(ar, msdu, enctype, rx_info);
+			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info);
 			break;
 		}
 
@@ -1023,7 +1029,7 @@ void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 		 * remove eth header and add 802.11 header.
 		 */
 		if (ATH12K_SKB_RXCB(msdu)->is_mcbc && decrypted)
-			ath12k_dp_rx_h_undecap_eth(ar, msdu, enctype, rx_info);
+			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info);
 		break;
 	case DP_RX_DECAP_TYPE_8023:
 		/* TODO: Handle undecap for these formats */
@@ -1052,18 +1058,22 @@ ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
 	return peer;
 }
 
-static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc_data *rx_info)
+static void ath12k_dp_rx_h_rate(struct ath12k_pdev_dp *dp_pdev,
+				struct hal_rx_desc_data *rx_info)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	enum rx_msdu_start_pkt_type pkt_type = rx_info->pkt_type;
 	u8 bw = rx_info->bw, sgi = rx_info->sgi;
 	u8 rate_mcs = rx_info->rate_mcs, nss = rx_info->nss;
 	bool is_cck;
+	struct ath12k *ar;
 
 	switch (pkt_type) {
 	case RX_MSDU_START_PKT_TYPE_11A:
 	case RX_MSDU_START_PKT_TYPE_11B:
+		ar = ath12k_pdev_dp_to_ar(dp_pdev);
 		is_cck = (pkt_type == RX_MSDU_START_PKT_TYPE_11B);
 		sband = &ar->mac.sbands[rx_status->band];
 		rx_status->rate_idx = ath12k_mac_hw_rate_to_idx(sband, rate_mcs,
@@ -1072,7 +1082,7 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc_data *rx_i
 	case RX_MSDU_START_PKT_TYPE_11N:
 		rx_status->encoding = RX_ENC_HT;
 		if (rate_mcs > ATH12K_HT_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(dp->ab,
 				    "Received with invalid mcs in HT mode %d\n",
 				     rate_mcs);
 			break;
@@ -1086,7 +1096,7 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc_data *rx_i
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(dp->ab,
 				    "Received with invalid mcs in VHT mode %d\n",
 				     rate_mcs);
 			break;
@@ -1099,7 +1109,7 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc_data *rx_i
 	case RX_MSDU_START_PKT_TYPE_11AX:
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_HE_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(dp->ab,
 				    "Received with invalid mcs in HE mode %d\n",
 				    rate_mcs);
 			break;
@@ -1113,7 +1123,7 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc_data *rx_i
 		rx_status->rate_idx = rate_mcs;
 
 		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
+			ath12k_warn(dp->ab,
 				    "Received with invalid mcs in EHT mode %d\n",
 				    rate_mcs);
 			break;
@@ -1129,7 +1139,8 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc_data *rx_i
 	}
 }
 
-void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc_data *rx_info)
+void ath12k_dp_rx_h_ppdu(struct ath12k_pdev_dp *dp_pdev,
+			 struct hal_rx_desc_data *rx_info)
 {
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	u8 channel_num;
@@ -1158,6 +1169,8 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc_data *rx_info)
 	} else if (channel_num >= 36 && channel_num <= 173) {
 		rx_status->band = NL80211_BAND_5GHZ;
 	} else {
+		struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+
 		spin_lock_bh(&ar->data_lock);
 		channel = ar->rx_channel;
 		if (channel) {
@@ -1172,14 +1185,15 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc_data *rx_info)
 		rx_status->freq = ieee80211_channel_to_frequency(channel_num,
 								 rx_status->band);
 
-	ath12k_dp_rx_h_rate(ar, rx_info);
+	ath12k_dp_rx_h_rate(dp_pdev, rx_info);
 }
 
-void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
+void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struct *napi,
 			       struct sk_buff *msdu,
 			       struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_sta *pubsta;
 	struct ath12k_peer *peer;
@@ -1244,7 +1258,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
+	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
 }
 
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
@@ -1390,13 +1404,14 @@ int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
 	return ret;
 }
 
-void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
+void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 				 enum hal_encrypt_type enctype, u32 flags)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
 	size_t crypto_len;
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = dp->ab->hal.hal_desc_sz;
 
 	if (!flags)
 		return;
@@ -1405,15 +1420,15 @@ void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
 
 	if (flags & RX_FLAG_MIC_STRIPPED)
 		skb_trim(msdu, msdu->len -
-			 ath12k_dp_rx_crypto_mic_len(ar, enctype));
+			 ath12k_dp_rx_crypto_mic_len(dp, enctype));
 
 	if (flags & RX_FLAG_ICV_STRIPPED)
 		skb_trim(msdu, msdu->len -
-			 ath12k_dp_rx_crypto_icv_len(ar, enctype));
+			 ath12k_dp_rx_crypto_icv_len(dp_pdev, enctype));
 
 	if (flags & RX_FLAG_IV_STRIPPED) {
 		hdr_len = ieee80211_hdrlen(hdr->frame_control);
-		crypto_len = ath12k_dp_rx_crypto_param_len(ar, enctype);
+		crypto_len = ath12k_dp_rx_crypto_param_len(dp_pdev, enctype);
 
 		memmove(msdu->data + hal_rx_desc_sz + crypto_len,
 			msdu->data + hal_rx_desc_sz, hdr_len);
@@ -1449,12 +1464,12 @@ void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
 	__skb_queue_tail(frag_list, cur_frag);
 }
 
-u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
+u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 	u64 pn = 0;
 	u8 *ehdr;
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = dp->ab->hal.hal_desc_sz;
 
 	hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
 	ehdr = skb->data + hal_rx_desc_sz + ieee80211_hdrlen(hdr->frame_control);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index ff214bff389b..716623f83adc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -171,23 +171,23 @@ static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
 		dev_kfree_skb_any(skb);
 }
 
-void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
+void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 			    struct hal_rx_desc *rx_desc,
 			    enum hal_encrypt_type enctype,
 			    bool decrypted,
 			    struct hal_rx_desc_data *rx_info);
-void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
+void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struct *napi,
 			       struct sk_buff *msdu,
 			       struct hal_rx_desc_data *rx_info);
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 					    struct hal_rx_desc *rx_desc,
 					    struct sk_buff *msdu,
 					    struct hal_rx_desc_data *rx_info);
-u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb);
+u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb);
 void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
 			       struct sk_buff_head *frag_list,
 			       struct sk_buff *cur_frag);
-void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
+void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 				 enum hal_encrypt_type enctype, u32 flags);
 void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 				bool rel_link_desc);
@@ -237,14 +237,15 @@ u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc);
-int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype);
+int ath12k_dp_rx_crypto_mic_len(struct ath12k_dp *dp, enum hal_encrypt_type enctype);
 u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 				struct hal_rx_desc *rx_desc);
 bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
 bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
-void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc_data *rx_info);
+void ath12k_dp_rx_h_ppdu(struct ath12k_pdev_dp *dp_pdev,
+			 struct hal_rx_desc_data *rx_info);
 struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
 					       struct sk_buff *first);
 void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1f585fb50021..692a88f25b5c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -22,6 +22,7 @@
 #include "hif.h"
 #include "wow.h"
 #include "debugfs_sta.h"
+#include "dp.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -8378,7 +8379,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 		     ieee80211_is_disassoc(hdr->frame_control)) &&
 		     ieee80211_has_protected(hdr->frame_control)) {
 			enctype = ath12k_dp_tx_get_encrypt_type(skb_cb->cipher);
-			mic_len = ath12k_dp_rx_crypto_mic_len(ar, enctype);
+			mic_len = ath12k_dp_rx_crypto_mic_len(ab->dp, enctype);
 			skb_put(skb, mic_len);
 		}
 	}
@@ -8833,6 +8834,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	u32 info_flags = info->flags;
 	struct sk_buff *msdu_copied;
 	struct ath12k *ar, *tmp_ar;
+	struct ath12k_pdev_dp *dp_pdev, *tmp_dp_pdev;
 	struct ath12k_peer *peer;
 	unsigned long links_map;
 	bool is_mcast = false;
@@ -8878,6 +8880,10 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 
 	ar = arvif->ar;
 	skb_cb->link_id = link_id;
+	/* as skb_cb is common currently for dp and mgmt tx processing
+	 * set this in the common mac op tx function.
+	 */
+	skb_cb->ar = ar;
 	is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
 
 	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
@@ -8905,6 +8911,12 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
 		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
 
+	dp_pdev = ath12k_dp_to_pdev_dp(ar->ab->dp, ar->pdev_idx);
+	if (!dp_pdev) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+
 	/* Checking if it is a DVLAN frame */
 	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
 	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
@@ -8915,7 +8927,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	if (!vif->valid_links || !is_mcast || is_dvlan ||
 	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
-		ret = ath12k_wifi7_dp_tx(ar, arvif, skb, false, 0, is_mcast);
+		ret = ath12k_wifi7_dp_tx(dp_pdev, arvif, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
 			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 			ieee80211_free_txskb(ar->ah->hw, skb);
@@ -8932,6 +8944,10 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 				continue;
 
 			tmp_ar = tmp_arvif->ar;
+			tmp_dp_pdev = ath12k_dp_to_pdev_dp(tmp_ar->ab->dp,
+							   tmp_ar->pdev_idx);
+			if (!tmp_dp_pdev)
+				continue;
 			msdu_copied = skb_copy(skb, GFP_ATOMIC);
 			if (!msdu_copied) {
 				ath12k_err(ar->ab,
@@ -8947,6 +8963,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			skb_cb = ATH12K_SKB_CB(msdu_copied);
 			skb_cb->link_id = link_id;
 			skb_cb->vif = vif;
+			skb_cb->ar = tmp_ar;
 
 			/* For open mode, skip peer find logic */
 			if (unlikely(!ahvif->dp_vif.key_cipher))
@@ -8977,7 +8994,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			spin_unlock_bh(&tmp_ar->ab->base_lock);
 
 skip_peer_find:
-			ret = ath12k_wifi7_dp_tx(tmp_ar, tmp_arvif,
+			ret = ath12k_wifi7_dp_tx(tmp_dp_pdev, tmp_arvif,
 						 msdu_copied, true, mcbc_gsn, is_mcast);
 			if (unlikely(ret)) {
 				if (ret == -ENOMEM) {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 04c64b904693..d6ce6b9bb4d7 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -310,11 +310,13 @@ static void ath12k_wifi7_dp_rx_h_csum_offload(struct sk_buff *msdu,
 			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k *ar,
+static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 				      struct sk_buff *msdu,
 				      struct hal_rx_desc *rx_desc,
 				      struct hal_rx_desc_data *rx_info)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
@@ -330,8 +332,8 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k *ar,
 	if (rxcb->is_mcbc)
 		rxcb->peer_id = rx_info->peer_id;
 
-	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, rx_info);
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_dp_rx_h_find_peer(ab, msdu, rx_info);
 	if (peer) {
 		/* resetting mcbc bit because mcbc packets are unicast
 		 * packets only for AP as STA sends unicast packets.
@@ -345,7 +347,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k *ar,
 	} else {
 		enctype = HAL_ENCRYPT_TYPE_OPEN;
 	}
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&ab->base_lock);
 
 	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
 		is_decrypted = rx_info->is_decrypted;
@@ -374,7 +376,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k *ar,
 	}
 
 	ath12k_wifi7_dp_rx_h_csum_offload(msdu, rx_info);
-	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
+	ath12k_dp_rx_h_undecap(dp_pdev, msdu, rx_desc,
 			       enctype, is_decrypted, rx_info);
 
 	if (!is_decrypted || rx_info->is_mcbc)
@@ -386,19 +388,19 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k *ar,
 	}
 }
 
-static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k *ar,
+static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k_dp *dp,
 					    struct sk_buff_head *msdu_list,
 					    struct sk_buff *first, struct sk_buff *last,
 					    u8 l3pad_bytes, int msdu_len,
 					    struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_base *ab = dp->ab;
 	struct sk_buff *skb;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(first);
 	int buf_first_hdr_len, buf_first_len;
 	struct hal_rx_desc *ldesc;
 	int space_extra, rem_len, buf_len;
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	bool is_continuation;
 
 	/* As the msdu is spread across multiple rx buffers,
@@ -474,19 +476,20 @@ static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k *ar,
+static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 					   struct sk_buff *msdu,
 					   struct sk_buff_head *msdu_list,
 					   struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
 	struct ath12k_skb_rxcb *rxcb;
 	struct sk_buff *last_buf;
 	u8 l3_pad_bytes;
 	u16 msdu_len;
 	int ret;
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 
 	last_buf = ath12k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
 	if (!last_buf) {
@@ -524,7 +527,7 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k *ar,
 		skb_put(msdu, hal_rx_desc_sz + l3_pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3_pad_bytes);
 	} else {
-		ret = ath12k_wifi7_dp_rx_msdu_coalesce(ar, msdu_list,
+		ret = ath12k_wifi7_dp_rx_msdu_coalesce(dp, msdu_list,
 						       msdu, last_buf,
 						       l3_pad_bytes, msdu_len,
 						       rx_info);
@@ -541,8 +544,8 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k *ar,
 		goto free_out;
 	}
 
-	ath12k_dp_rx_h_ppdu(ar, rx_info);
-	ath12k_wifi7_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info);
+	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
+	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_desc, rx_info);
 
 	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
@@ -565,11 +568,12 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 	struct ath12k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
 	struct ath12k *ar;
+	struct ath12k_pdev_dp *dp_pdev;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	struct ath12k_base *partner_ab;
 	struct hal_rx_desc_data rx_info;
 	struct ath12k_dp *partner_dp;
-	u8 hw_link_id, pdev_id;
+	u8 hw_link_id, pdev_idx;
 	int ret;
 
 	if (skb_queue_empty(msdu_list))
@@ -585,11 +589,11 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 		hw_link_id = rxcb->hw_link_id;
 		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp,
 						    hw_links[hw_link_id].device_id);
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_dp->hw_params,
-						      hw_links[hw_link_id].pdev_idx);
+		pdev_idx = ath12k_hw_mac_id_to_pdev_id(partner_dp->hw_params,
+						       hw_links[hw_link_id].pdev_idx);
 		partner_ab = partner_dp->ab;
-		ar = partner_ab->pdevs[pdev_id].ar;
-		if (!rcu_dereference(partner_ab->pdevs_active[pdev_id])) {
+		ar = partner_ab->pdevs[pdev_idx].ar;
+		if (!rcu_dereference(partner_ab->pdevs_active[pdev_idx])) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
@@ -599,7 +603,13 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 			continue;
 		}
 
-		ret = ath12k_wifi7_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_info);
+		dp_pdev = ath12k_dp_to_pdev_dp(partner_dp, pdev_idx);
+		if (!dp_pdev) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		ret = ath12k_wifi7_dp_rx_process_msdu(dp_pdev, msdu, msdu_list, &rx_info);
 		if (ret) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
@@ -607,7 +617,7 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 			continue;
 		}
 
-		ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
+		ath12k_dp_rx_deliver_msdu(dp_pdev, napi, msdu, &rx_info);
 	}
 
 	rcu_read_unlock();
@@ -778,10 +788,11 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 }
 
 static bool
-ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar,
+ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(struct ath12k_pdev_dp *dp_pdev,
 					     struct ath12k_dp_rx_tid *rx_tid,
 					     enum hal_encrypt_type encrypt_type)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
 	struct sk_buff *first_frag, *skb;
 	u64 last_pn;
 	u64 cur_pn;
@@ -794,12 +805,12 @@ ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar,
 	    encrypt_type != HAL_ENCRYPT_TYPE_AES_GCMP_256)
 		return true;
 
-	last_pn = ath12k_dp_rx_h_get_pn(ar, first_frag);
+	last_pn = ath12k_dp_rx_h_get_pn(dp, first_frag);
 	skb_queue_walk(&rx_tid->rx_frags, skb) {
 		if (skb == first_frag)
 			continue;
 
-		cur_pn = ath12k_dp_rx_h_get_pn(ar, skb);
+		cur_pn = ath12k_dp_rx_h_get_pn(dp, skb);
 		if (cur_pn != last_pn + 1)
 			return false;
 		last_pn = cur_pn;
@@ -807,12 +818,11 @@ ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar,
 	return true;
 }
 
-static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
+static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 						    struct ath12k_dp_rx_tid *rx_tid,
 						    struct sk_buff *defrag_skb)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_base *ab = dp->ab;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)defrag_skb->data;
 	struct hal_reo_entrance_ring *reo_ent_ring;
 	struct hal_reo_dest_ring *reo_dest_ring;
@@ -953,13 +963,14 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	return ret;
 }
 
-static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k *ar,
+static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 						struct ath12k_peer *peer,
 						enum hal_encrypt_type enctype,
 						struct sk_buff *msdu,
 						struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
 	struct ieee80211_key_conf *key_conf;
@@ -1014,26 +1025,28 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k *ar,
 							     rx_info)))
 		return -EINVAL;
 
-	ath12k_dp_rx_h_ppdu(ar, rx_info);
-	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
+	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
+	ath12k_dp_rx_h_undecap(dp_pdev, msdu, rx_desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, true, rx_info);
-	ieee80211_rx(ath12k_ar_to_hw(ar), msdu);
+	ieee80211_rx(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 	return -EINVAL;
 }
 
-static int ath12k_wifi7_dp_rx_h_defrag(struct ath12k *ar,
+static int ath12k_wifi7_dp_rx_h_defrag(struct ath12k_pdev_dp *dp_pdev,
 				       struct ath12k_peer *peer,
 				       struct ath12k_dp_rx_tid *rx_tid,
 				       struct sk_buff **defrag_skb,
 				       enum hal_encrypt_type enctype,
 				       struct hal_rx_desc_data *rx_info)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct sk_buff *skb, *first_frag, *last_frag;
 	struct ieee80211_hdr *hdr;
 	bool is_decrypted = false;
 	int msdu_len = 0;
 	int extra_space;
-	u32 flags, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 flags, hal_rx_desc_sz = ab->hal.hal_desc_sz;
 
 	first_frag = skb_peek(&rx_tid->rx_frags);
 	last_frag = skb_peek_tail(&rx_tid->rx_frags);
@@ -1056,7 +1069,7 @@ static int ath12k_wifi7_dp_rx_h_defrag(struct ath12k *ar,
 		/* RX fragments are always raw packets */
 		if (skb != last_frag)
 			skb_trim(skb, skb->len - FCS_LEN);
-		ath12k_dp_rx_h_undecap_frag(ar, skb, enctype, flags);
+		ath12k_dp_rx_h_undecap_frag(dp_pdev, skb, enctype, flags);
 
 		if (skb != first_frag)
 			skb_pull(skb, hal_rx_desc_sz +
@@ -1079,19 +1092,21 @@ static int ath12k_wifi7_dp_rx_h_defrag(struct ath12k *ar,
 	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_MOREFRAGS);
 	ATH12K_SKB_RXCB(first_frag)->is_frag = 1;
 
-	if (ath12k_wifi7_dp_rx_h_verify_tkip_mic(ar, peer, enctype, first_frag, rx_info))
+	if (ath12k_wifi7_dp_rx_h_verify_tkip_mic(dp_pdev, peer, enctype, first_frag,
+						 rx_info))
 		first_frag = NULL;
 
 	*defrag_skb = first_frag;
 	return 0;
 }
 
-static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k *ar,
+static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 					  struct sk_buff *msdu,
 					  struct hal_reo_dest_ring *ring_desc,
 					  struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	struct sk_buff *defrag_skb = NULL;
@@ -1186,17 +1201,17 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k *ar,
 	if (!peer)
 		goto err_frags_cleanup;
 
-	if (!ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid, enctype))
+	if (!ath12k_wifi7_dp_rx_h_defrag_validate_incr_pn(dp_pdev, rx_tid, enctype))
 		goto err_frags_cleanup;
 
-	if (ath12k_wifi7_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb,
+	if (ath12k_wifi7_dp_rx_h_defrag(dp_pdev, peer, rx_tid, &defrag_skb,
 					enctype, rx_info))
 		goto err_frags_cleanup;
 
 	if (!defrag_skb)
 		goto err_frags_cleanup;
 
-	if (ath12k_wifi7_dp_rx_h_defrag_reo_reinject(ar, rx_tid, defrag_skb))
+	if (ath12k_wifi7_dp_rx_h_defrag_reo_reinject(dp, rx_tid, defrag_skb))
 		goto err_frags_cleanup;
 
 	ath12k_dp_rx_frags_cleanup(rx_tid, false);
@@ -1211,12 +1226,14 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k *ar,
 }
 
 static int
-ath12k_wifi7_dp_process_rx_err_buf(struct ath12k *ar,
+ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 				   struct hal_reo_dest_ring *desc,
 				   struct list_head *used_list,
 				   bool drop, u32 cookie)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct sk_buff *msdu;
 	struct ath12k_skb_rxcb *rxcb;
 	struct hal_rx_desc_data rx_info;
@@ -1249,7 +1266,7 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k *ar,
 	list_add_tail(&desc_info->list, used_list);
 
 	rxcb = ATH12K_SKB_RXCB(msdu);
-	dma_unmap_single(ar->ab->dev, rxcb->paddr,
+	dma_unmap_single(ab->dev, rxcb->paddr,
 			 msdu->len + skb_tailroom(msdu),
 			 DMA_FROM_DEVICE);
 
@@ -1274,8 +1291,8 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k *ar,
 
 	msdu_len = rx_info.msdu_len;
 	if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
-		ath12k_warn(ar->ab, "invalid msdu leng %u", msdu_len);
-		ath12k_dbg_dump(ar->ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
+		ath12k_warn(ab, "invalid msdu leng %u", msdu_len);
+		ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
 				sizeof(*rx_desc));
 		dev_kfree_skb_any(msdu);
 		goto exit;
@@ -1283,7 +1300,7 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k *ar,
 
 	skb_put(msdu, hal_rx_desc_sz + msdu_len);
 
-	if (ath12k_wifi7_dp_rx_frag_h_mpdu(ar, msdu, desc, &rx_info)) {
+	if (ath12k_wifi7_dp_rx_frag_h_mpdu(dp_pdev, msdu, desc, &rx_info)) {
 		dev_kfree_skb_any(msdu);
 		ath12k_wifi7_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
 						    HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
@@ -1312,14 +1329,14 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 	struct dp_srng *reo_except;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	struct ath12k_base *partner_ab;
+	struct ath12k_pdev_dp *dp_pdev;
 	u8 hw_link_id, device_id;
 	u32 desc_bank, num_msdus;
 	struct hal_srng *srng;
-	struct ath12k *ar;
 	dma_addr_t paddr;
 	bool is_frag;
 	bool drop;
-	int pdev_id;
+	int pdev_idx;
 	struct list_head *used_list;
 	enum hal_wbm_rel_bm_act act;
 
@@ -1356,9 +1373,8 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
 		partner_ab = partner_dp->ab;
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
-						      hw_links[hw_link_id].pdev_idx);
-		ar = partner_ab->pdevs[pdev_id].ar;
+		pdev_idx = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
+						       hw_links[hw_link_id].pdev_idx);
 
 		link_desc_banks = partner_dp->link_desc_banks;
 		link_desc_va = link_desc_banks[desc_bank].vaddr +
@@ -1396,10 +1412,18 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 							    act);
 		}
 
+		rcu_read_lock();
+
+		dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
+		if (!dp_pdev) {
+			rcu_read_unlock();
+			continue;
+		}
+
 		for (i = 0; i < num_msdus; i++) {
 			used_list = &rx_desc_used_list[device_id];
 
-			if (!ath12k_wifi7_dp_process_rx_err_buf(ar, reo_desc,
+			if (!ath12k_wifi7_dp_process_rx_err_buf(dp_pdev, reo_desc,
 								used_list,
 								drop,
 								msdu_cookies[i])) {
@@ -1408,6 +1432,8 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 			}
 		}
 
+		rcu_read_unlock();
+
 		if (tot_n_bufs_reaped >= quota) {
 			tot_n_bufs_reaped = quota;
 			goto exit;
@@ -1438,7 +1464,7 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 }
 
 static void
-ath12k_wifi7_dp_rx_null_q_desc_sg_drop(struct ath12k *ar, int msdu_len,
+ath12k_wifi7_dp_rx_null_q_desc_sg_drop(struct ath12k_dp *dp, int msdu_len,
 				       struct sk_buff_head *msdu_list)
 {
 	struct sk_buff *skb, *tmp;
@@ -1446,7 +1472,7 @@ ath12k_wifi7_dp_rx_null_q_desc_sg_drop(struct ath12k *ar, int msdu_len,
 	int n_buffs;
 
 	n_buffs = DIV_ROUND_UP(msdu_len,
-			       (DP_RX_BUFFER_SIZE - ar->ab->hal.hal_desc_sz));
+			       (DP_RX_BUFFER_SIZE - dp->ab->hal.hal_desc_sz));
 
 	skb_queue_walk_safe(msdu_list, skb, tmp) {
 		rxcb = ATH12K_SKB_RXCB(skb);
@@ -1461,21 +1487,23 @@ ath12k_wifi7_dp_rx_null_q_desc_sg_drop(struct ath12k *ar, int msdu_len,
 	}
 }
 
-static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
+static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
+					    struct sk_buff *msdu,
 					    struct hal_rx_desc_data *rx_info,
 					    struct sk_buff_head *msdu_list)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	u16 msdu_len = rx_info->msdu_len;
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes = rx_info->l3_pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = dp->ab->hal.hal_desc_sz;
 
 	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
 		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - hal_rx_desc_sz);
-		ath12k_wifi7_dp_rx_null_q_desc_sg_drop(ar, msdu_len, msdu_list);
+		ath12k_wifi7_dp_rx_null_q_desc_sg_drop(dp, msdu_len, msdu_list);
 		return -EINVAL;
 	}
 
@@ -1487,7 +1515,7 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *m
 		return -EINVAL;
 
 	if (!rx_info->msdu_done) {
-		ath12k_warn(ar->ab,
+		ath12k_warn(ab,
 			    "msdu_done bit not set in null_q_des processing\n");
 		__skb_queue_purge(msdu_list);
 		return -EIO;
@@ -1514,8 +1542,8 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *m
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu, rx_info)))
 		return -EINVAL;
 
-	ath12k_dp_rx_h_ppdu(ar, rx_info);
-	ath12k_wifi7_dp_rx_h_mpdu(ar, msdu, desc, rx_info);
+	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
+	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, desc, rx_info);
 
 	rxcb->tid = rx_info->tid;
 
@@ -1526,15 +1554,17 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *m
 	return 0;
 }
 
-static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
+static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
+					      struct sk_buff *msdu,
 					      struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	u16 msdu_len = rx_info->msdu_len;
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes = rx_info->l3_pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 
 	rxcb->is_first_msdu = rx_info->is_first_msdu;
 	rxcb->is_last_msdu = rx_info->is_last_msdu;
@@ -1553,29 +1583,31 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu, rx_info)))
 		return true;
 
-	ath12k_dp_rx_h_ppdu(ar, rx_info);
+	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
 
 	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
 				     RX_FLAG_DECRYPTED);
 
-	ath12k_dp_rx_h_undecap(ar, msdu, desc,
+	ath12k_dp_rx_h_undecap(dp_pdev, msdu, desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, false, rx_info);
 	return false;
 }
 
-static bool ath12k_wifi7_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
+static bool ath12k_wifi7_dp_rx_h_rxdma_err(struct ath12k_pdev_dp *dp_pdev,
+					   struct sk_buff *msdu,
 					   struct hal_rx_desc_data *rx_info)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	bool drop = false;
 
-	ar->ab->device_stats.rxdma_error[rxcb->err_code]++;
+	dp->ab->device_stats.rxdma_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
 		if (rx_info->err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			drop = ath12k_wifi7_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
+			drop = ath12k_wifi7_dp_rx_h_tkip_mic_err(dp_pdev, msdu, rx_info);
 			break;
 		}
 		fallthrough;
@@ -1590,18 +1622,20 @@ static bool ath12k_wifi7_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *m
 	return drop;
 }
 
-static bool ath12k_wifi7_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
+static bool ath12k_wifi7_dp_rx_h_reo_err(struct ath12k_pdev_dp *dp_pdev,
+					 struct sk_buff *msdu,
 					 struct hal_rx_desc_data *rx_info,
 					 struct sk_buff_head *msdu_list)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	bool drop = false;
 
-	ar->ab->device_stats.reo_error[rxcb->err_code]++;
+	dp->ab->device_stats.reo_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
-		if (ath12k_wifi7_dp_rx_h_null_q_desc(ar, msdu, rx_info, msdu_list))
+		if (ath12k_wifi7_dp_rx_h_null_q_desc(dp_pdev, msdu, rx_info, msdu_list))
 			drop = true;
 		break;
 	case HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED:
@@ -1621,11 +1655,12 @@ static bool ath12k_wifi7_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu
 	return drop;
 }
 
-static void ath12k_wifi7_dp_rx_wbm_err(struct ath12k *ar,
+static void ath12k_wifi7_dp_rx_wbm_err(struct ath12k_pdev_dp *dp_pdev,
 				       struct napi_struct *napi,
 				       struct sk_buff *msdu,
 				       struct sk_buff_head *msdu_list)
 {
+	struct ath12k_dp *dp = dp_pdev->dp;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status rxs = {};
@@ -1635,14 +1670,14 @@ static void ath12k_wifi7_dp_rx_wbm_err(struct ath12k *ar,
 	rx_info.addr2_present = false;
 	rx_info.rx_status = &rxs;
 
-	ath12k_wifi7_dp_extract_rx_desc_data(ar->ab, &rx_info, rx_desc, rx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(dp->ab, &rx_info, rx_desc, rx_desc);
 
 	switch (rxcb->err_rel_src) {
 	case HAL_WBM_REL_SRC_MODULE_REO:
-		drop = ath12k_wifi7_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
+		drop = ath12k_wifi7_dp_rx_h_reo_err(dp_pdev, msdu, &rx_info, msdu_list);
 		break;
 	case HAL_WBM_REL_SRC_MODULE_RXDMA:
-		drop = ath12k_wifi7_dp_rx_h_rxdma_err(ar, msdu, &rx_info);
+		drop = ath12k_wifi7_dp_rx_h_rxdma_err(dp_pdev, msdu, &rx_info);
 		break;
 	default:
 		/* msdu will get freed */
@@ -1656,7 +1691,7 @@ static void ath12k_wifi7_dp_rx_wbm_err(struct ath12k *ar,
 
 	rx_info.rx_status->flag |= RX_FLAG_SKIP_MONITOR;
 
-	ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
+	ath12k_dp_rx_deliver_msdu(dp_pdev, napi, msdu, &rx_info);
 }
 
 void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
@@ -1694,6 +1729,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 {
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	struct ath12k *ar;
+	struct ath12k_pdev_dp *dp_pdev;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_hw_group *ag = dp->ag;
 	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
@@ -1710,9 +1746,8 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
-	struct ath12k_base *partner_ab;
 	u8 hw_link_id, device_id;
-	int ret, pdev_id;
+	int ret, pdev_idx;
 	struct hal_rx_desc *msdu_data;
 
 	__skb_queue_head_init(&msdu_list);
@@ -1770,8 +1805,6 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		partner_ab = partner_dp->ab;
-
 		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
@@ -1804,7 +1837,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		hw_link_id = ath12k_dp_rx_get_msdu_src_link(partner_ab,
+		hw_link_id = ath12k_dp_rx_get_msdu_src_link(partner_dp->ab,
 							    msdu_data);
 		if (hw_link_id >= ATH12K_GROUP_MAX_RADIO) {
 			dev_kfree_skb_any(msdu);
@@ -1872,12 +1905,17 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_dp->hw_params,
-						      hw_links[hw_link_id].pdev_idx);
-		partner_ab = partner_dp->ab;
-		ar = partner_ab->pdevs[pdev_id].ar;
+		pdev_idx = ath12k_hw_mac_id_to_pdev_id(partner_dp->hw_params,
+						       hw_links[hw_link_id].pdev_idx);
+
+		dp_pdev = ath12k_dp_to_pdev_dp(partner_dp, pdev_idx);
+		if (!dp_pdev) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+		ar = ath12k_pdev_dp_to_ar(dp_pdev);
 
-		if (!ar || !rcu_dereference(ar->ab->pdevs_active[pdev_id])) {
+		if (!ar || !rcu_dereference(ar->ab->pdevs_active[pdev_idx])) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
@@ -1892,7 +1930,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			device_stats->rx_wbm_rel_source[rxcb->err_rel_src][device_id]++;
 		}
 
-		ath12k_wifi7_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
+		ath12k_wifi7_dp_rx_wbm_err(dp_pdev, napi, msdu, &msdu_list);
 	}
 	rcu_read_unlock();
 done:
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index b94b14bda39b..ab5824abfe75 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -54,12 +54,12 @@ static int ath12k_wifi7_dp_prepare_htt_metadata(struct sk_buff *skb)
 	return 0;
 }
 
-int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
+int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *arvif,
 		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
 		       bool is_mcast)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct hal_tx_info ti = {};
 	struct ath12k_tx_desc_info *tx_desc;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -84,7 +84,7 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	bool is_diff_encap = false;
 	bool is_null_frame = false;
 
-	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		return -ESHUTDOWN;
 
 	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
@@ -121,7 +121,7 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	ti.meta_data_flags = dp_link_vif->tcl_metadata;
 
 	if (dp_vif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
-	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
+	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags)) {
 		if (skb_cb->flags & ATH12K_SKB_CIPHER_SET) {
 			ti.encrypt_type =
 				ath12k_dp_tx_get_encrypt_type(skb_cb->cipher);
@@ -231,7 +231,7 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		goto fail_remove_tx_buf;
 	}
 
-	if ((!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	if ((!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags) &&
 	     !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
 	     !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
 	     ieee80211_has_protected(hdr->frame_control)) ||
@@ -259,7 +259,6 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	ti.desc_id = tx_desc->desc_id;
 	ti.data_len = skb->len;
 	skb_cb->paddr = ti.paddr;
-	skb_cb->ar = ar;
 
 	if (msdu_ext_desc) {
 		skb_ext_desc = dev_alloc_skb(sizeof(struct hal_tx_msdu_ext_desc));
@@ -349,7 +348,7 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	ath12k_dbg_dump(ab, ATH12K_DBG_DP_TX, NULL, "dp tx msdu: ",
 			skb->data, skb->len);
 
-	atomic_inc(&ar->dp.num_tx_pending);
+	atomic_inc(&dp_pdev->num_tx_pending);
 
 	return 0;
 
@@ -511,10 +510,11 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 	}
 }
 
-static void
-ath12k_wifi7_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
+static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
+					      struct hal_tx_status *ts)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_peer *peer;
 	struct ieee80211_sta *sta;
 	struct ath12k_sta *ahsta;
@@ -630,13 +630,13 @@ ath12k_wifi7_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
 	spin_unlock_bh(&ab->base_lock);
 }
 
-static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
+static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 					     struct ath12k_tx_desc_params *desc_params,
 					     struct hal_tx_status *ts,
 					     int ring)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_hw *ah = ar->ah;
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
 	struct ieee80211_tx_info *info;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_skb_cb *skb_cb;
@@ -668,13 +668,13 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
 
 	rcu_read_lock();
 
-	if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
-		ieee80211_free_txskb(ah->hw, msdu);
+	if (!rcu_dereference(ab->pdevs_active[dp_pdev->mac_id])) {
+		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	}
 
 	if (!skb_cb->vif) {
-		ieee80211_free_txskb(ah->hw, msdu);
+		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	}
 
@@ -703,6 +703,8 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
 
 			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 				      ab->wmi_ab.svc_map)) {
+				struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+
 				spin_lock_bh(&ar->data_lock);
 				noise_floor = ath12k_pdev_get_noise_floor(ar);
 				spin_unlock_bh(&ar->data_lock);
@@ -726,7 +728,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
 		 * hence drop the frame; do not update the status of frame to
 		 * the upper layer
 		 */
-		ieee80211_free_txskb(ah->hw, msdu);
+		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_DP_TX, "tx frame is not acked status %d\n",
@@ -739,7 +741,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
-	ath12k_wifi7_dp_tx_update_txcompl(ar, ts);
+	ath12k_wifi7_dp_tx_update_txcompl(dp_pdev, ts);
 
 	spin_lock_bh(&ab->base_lock);
 	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
@@ -748,7 +750,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			   ts->peer_id);
 		spin_unlock_bh(&ab->base_lock);
-		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
+		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	}
 	ahsta = ath12k_sta_to_ahsta(peer->sta);
@@ -766,7 +768,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k *ar,
 
 	status.rates = &status_rate;
 	status.n_rates = 1;
-	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
+	ieee80211_tx_status_ext(ath12k_pdev_dp_to_hw(dp_pdev), &status);
 
 exit:
 	rcu_read_unlock();
@@ -811,7 +813,7 @@ ath12k_wifi7_dp_tx_status_parse(struct ath12k_base *ab,
 
 void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 {
-	struct ath12k *ar;
+	struct ath12k_pdev_dp *dp_pdev;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
@@ -820,7 +822,7 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 	struct ath12k_tx_desc_params desc_params;
 	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
 	struct hal_wbm_release_ring *desc;
-	u8 pdev_id;
+	u8 pdev_idx;
 	u64 desc_va;
 	enum hal_wbm_rel_src_module buf_rel_source;
 	enum hal_wbm_tqm_rel_reason rel_status;
@@ -902,13 +904,21 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 			continue;
 		}
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params.mac_id);
-		ar = ab->pdevs[pdev_id].ar;
+		pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params.mac_id);
 
-		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
-			wake_up(&ar->dp.tx_empty_waitq);
+		rcu_read_lock();
+
+		dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
+		if (!dp_pdev) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		if (atomic_dec_and_test(&dp_pdev->num_tx_pending))
+			wake_up(&dp_pdev->tx_empty_waitq);
 
-		ath12k_wifi7_dp_tx_complete_msdu(ar, &desc_params, &ts,
+		ath12k_wifi7_dp_tx_complete_msdu(dp_pdev, &desc_params, &ts,
 						 tx_ring->tcl_data_ring_id);
+		rcu_read_unlock();
 	}
 }
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
index 061c4de4d4e6..524e23b8ed80 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
@@ -7,7 +7,7 @@
 #ifndef ATH12K_DP_TX_WIFI7_H
 #define ATH12K_DP_TX_WIFI7_H
 
-int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
+int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *arvif,
 		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
 		       bool is_mcast);
 void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
-- 
2.34.1


