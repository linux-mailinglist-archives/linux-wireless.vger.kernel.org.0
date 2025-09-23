Return-Path: <linux-wireless+bounces-27608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA3B95580
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 11:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BA816CD10
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB83320CB9;
	Tue, 23 Sep 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CdHBh66L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A318027
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621409; cv=none; b=baS9zSkfB2IlSZ7ZcUV7IYFXbnOl+tOJTgnEmii/GC9JGY4umZzQkxI7cV5KwpRC/8nuxThs6MnGyh3+lGFE6zPRiGD4JDJWI0aqjGMwPzn6y4uJq3OKORyozM/wKYcO0OxYENOveFGF+XLeT8TMSzchtydSqR2zezdbY7YJX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621409; c=relaxed/simple;
	bh=tADz2PUBvnw4YcCp1GTbR+jbQQiS2Kfgrj+yYP7X1hY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeTQjwGvGkBtDp8m6AVXQgWBjYBo1FIfO1InNBv9jgdikd4BC+lTPBlFJvy12vY9/55yLGAoNA9VThCQBoNwuGo9HY5wcf3HC8ZQEWRYAV99lnTA78Pg9Xpq1oiXj5JEW31xsF4JcS+fgAOn2YwUpNxLfK6gYFPd4X4VNwsR6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CdHBh66L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H8Ku027258;
	Tue, 23 Sep 2025 09:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/IZMNTxmyCAQlkaY1yoxkJNbebv56PLIM3pI97MirI=; b=CdHBh66Lo6BKbsez
	vKdslLEljXG/wjrobCE68aLO91aa8DKiJI+q0APtBjB+yUmVbUnYGsCbwIXQ22S8
	HHzmOfj6L66mlvtFexwQBjO5eD+JEkdVmZxwEKNXBtRgvEkMQi8K8G9G9UWM8xxp
	wzeECW93G27Hq/TAmpgfJIO257E193qZhXXaM65kr+GyxBfv7l3PIf4iQOQ1GPKL
	MAE3DSw5+KiOM6zddeQ5RSHgmXKKi8CykC7FtF6TBxumCrTTLjEZF7RF3CVQ8YqB
	5IEjwGJUHfTpESFdko2JsmcsxudVlgVVRUZNbq9uz8knrMY2Mizl2WbH1LdGldC8
	bTFn1Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajethpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 09:56:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58N9uhHQ009862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 09:56:43 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 23 Sep 2025 02:56:41 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 1/6] wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
Date: Tue, 23 Sep 2025 15:26:23 +0530
Message-ID: <20250923095628.2438280-2-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923095628.2438280-1-quic_rdeuri@quicinc.com>
References: <20250923095628.2438280-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: F72jPLWUHJic8GrY2sABU1R4jhwvZBZv
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d26edc cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=39hVWAWuQyq32A1VTTcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX+g00xjbQq9WW
 VnzECYE5xO08yYApeqbumPCES44Z+aq21cnXVup4GianIwbwGc3AK1nq0lK6aca30gaoOyHz1vN
 BiliszgeR3WuieGRfbPeeREkVZKl8D4Fep5J8kK7LtFzr14ZclEfuG5RBTda8vt/nUCJaCt+NYA
 E3DjX2ICkq1U5PrUQITTUct0186hUVyhTgqHwGfxv6Wcgm7/UbUHoyWcP3uBwyZXNc37wolhGM0
 eKH3VGojWCZ70JKuKf7F6Rr4ye+iPzN/WifVW08P4wHr3qjelBwD7vEit+qYezQyd/rDcvv7LXx
 3hpUjsvdUP7jNY9yITwijBp6816TPqJV5/i5FpCXQMXzyGaQjG/vBcogK9s6RJApCCsH9VZRwgl
 phGN8PV+
X-Proofpoint-ORIG-GUID: F72jPLWUHJic8GrY2sABU1R4jhwvZBZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Currently, the Data Path (DP) specific device object (ath12k_dp) is
embedded directly within the ath12k_base structure. The DP object cannot
be extended with architecture-specific fields within a contiguous memory
block with this design.

To address this, convert ath12k_dp into a dynamically allocated object
and store it as a pointer in ath12k_base. This change allows allocation
and initialization of ath12k_dp based on the underlying hardware
architecture. Architecture-specific fields can now be maintained as
private data within a contiguous memory block of ath12k_dp.

This patch (and the forthcoming patches) are intended to serve the purpose
of refactoring different DP objects for the Next Generation ath12k
driver.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c        |  2 +-
 drivers/net/wireless/ath/ath12k/core.h        | 13 ++++-
 drivers/net/wireless/ath/ath12k/dp.c          | 58 +++++++++++--------
 drivers/net/wireless/ath/ath12k/dp_htt.c      | 22 ++++---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 15 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 20 +++----
 drivers/net/wireless/ath/ath12k/mac.c         |  4 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 40 ++++++++-----
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  4 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  5 +-
 11 files changed, 112 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0956d39c7b95..1534efe35887 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -896,7 +896,7 @@ static int ath12k_core_start(struct ath12k_base *ab)
 		goto err_hif_stop;
 	}
 
-	ret = ath12k_dp_htt_connect(&ab->dp);
+	ret = ath12k_dp_htt_connect(ath12k_ab_to_dp(ab));
 	if (ret) {
 		ath12k_err(ab, "failed to connect to HTT: %d\n", ret);
 		goto err_hif_stop;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9ae98556dd94..55d421595f0e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1053,7 +1053,7 @@ struct ath12k_base {
 
 	struct ath12k_htc htc;
 
-	struct ath12k_dp dp;
+	struct ath12k_dp *dp;
 
 	void __iomem *mem;
 	unsigned long mem_len;
@@ -1514,4 +1514,15 @@ static inline s32 ath12k_pdev_get_noise_floor(struct ath12k *ar)
 	return ar->rssi_info.noise_floor;
 }
 
+/**
+ * The @ab->dp NULL check or assertion is intentionally omitted because
+ * @ab->dp is guaranteed to be non-NULL after a successful probe and
+ * remains valid until teardown. Invoking this before allocation or
+ * after teardown is considered invalid usage.
+ */
+static inline struct ath12k_dp *ath12k_ab_to_dp(struct ath12k_base *ab)
+{
+	return ab->dp;
+}
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 986896c3bfeb..9a97eb868542 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -437,7 +437,7 @@ void ath12k_dp_tx_put_bank_profile(struct ath12k_dp *dp, u8 bank_id)
 
 static void ath12k_dp_deinit_bank_profiles(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	kfree(dp->bank_profiles);
 	dp->bank_profiles = NULL;
@@ -445,7 +445,7 @@ static void ath12k_dp_deinit_bank_profiles(struct ath12k_base *ab)
 
 static int ath12k_dp_init_bank_profiles(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u32 num_tcl_banks = ab->hw_params->num_tcl_banks;
 	int i;
 
@@ -468,7 +468,7 @@ static int ath12k_dp_init_bank_profiles(struct ath12k_base *ab)
 
 static void ath12k_dp_srng_common_cleanup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i;
 
 	ath12k_dp_srng_cleanup(ab, &dp->reo_status_ring);
@@ -485,7 +485,7 @@ static void ath12k_dp_srng_common_cleanup(struct ath12k_base *ab)
 
 static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *map;
 	struct hal_srng *srng;
 	int i, ret, tx_comp_ring_num;
@@ -591,7 +591,7 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 
 static void ath12k_dp_scatter_idle_link_desc_cleanup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_wbm_idle_scatter_list *slist = dp->scatter_list;
 	int i;
 
@@ -611,7 +611,7 @@ static int ath12k_dp_scatter_idle_link_desc_setup(struct ath12k_base *ab,
 						  u32 n_link_desc,
 						  u32 last_bank_sz)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct dp_link_desc_bank *link_desc_banks = dp->link_desc_banks;
 	struct hal_wbm_idle_scatter_list *slist = dp->scatter_list;
 	u32 n_entries_per_buf;
@@ -705,7 +705,7 @@ static int ath12k_dp_link_desc_bank_alloc(struct ath12k_base *ab,
 					  int n_link_desc_bank,
 					  int last_bank_sz)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i;
 	int ret = 0;
 	int desc_sz = DP_LINK_DESC_ALLOC_SIZE_THRESH;
@@ -753,7 +753,7 @@ void ath12k_dp_link_desc_cleanup(struct ath12k_base *ab,
 
 static int ath12k_wbm_idle_ring_setup(struct ath12k_base *ab, u32 *n_link_desc)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u32 n_mpdu_link_desc, n_mpdu_queue_desc;
 	u32 n_tx_msdu_link_desc, n_rx_msdu_link_desc;
 	int ret = 0;
@@ -792,6 +792,7 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 			      u32 ring_type, struct hal_srng *srng,
 			      u32 n_link_desc)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u32 tot_mem_sz;
 	u32 n_link_desc_bank, last_bank_sz;
 	u32 entry_sz, align_bytes, n_entries;
@@ -799,7 +800,7 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 	u32 paddr;
 	int i, ret;
 	u32 cookie;
-	enum hal_rx_buf_return_buf_manager rbm = ab->dp.idle_link_rbm;
+	enum hal_rx_buf_return_buf_manager rbm = dp->idle_link_rbm;
 
 	tot_mem_sz = n_link_desc * HAL_LINK_DESC_SIZE;
 	tot_mem_sz += HAL_LINK_DESC_ALIGN;
@@ -967,7 +968,7 @@ void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 	ath12k_dp_update_vdev_search(arvif);
 	arvif->vdev_id_check_en = true;
-	arvif->bank_id = ath12k_dp_tx_get_bank_profile(ab, arvif, &ab->dp);
+	arvif->bank_id = ath12k_dp_tx_get_bank_profile(ab, arvif, ath12k_ab_to_dp(ab));
 
 	/* TODO: error path for bank id failure */
 	if (arvif->bank_id == DP_INVALID_BANK_ID) {
@@ -980,7 +981,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 {
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_tx_desc_info *tx_desc_info, *tmp1;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_skb_cb *skb_cb;
 	struct sk_buff *skb;
 	struct ath12k *ar;
@@ -1103,7 +1104,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 
 static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	if (!ab->hw_params->reoq_lut_support)
 		return;
@@ -1131,7 +1132,7 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 
 void ath12k_dp_free(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i;
 
 	if (!dp->ab)
@@ -1154,7 +1155,8 @@ void ath12k_dp_free(struct ath12k_base *ab)
 
 	ath12k_dp_rx_free(ab);
 	/* Deinit any SOC level resource */
-	dp->ab = NULL;
+	kfree(ab->dp);
+	ab->dp = NULL;
 }
 
 void ath12k_dp_cc_config(struct ath12k_base *ab)
@@ -1218,7 +1220,7 @@ static u32 ath12k_dp_cc_cookie_gen(u16 ppt_idx, u16 spt_idx)
 static inline void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_base *ab,
 						   u16 ppt_idx, u16 spt_idx)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	return dp->spt_info[ppt_idx].vaddr + spt_idx;
 }
@@ -1226,7 +1228,7 @@ static inline void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_base *ab,
 struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_rx_desc_info **desc_addr_ptr;
 	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
 
@@ -1272,7 +1274,7 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 
 static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_rx_desc_info *rx_descs, **rx_desc_addr;
 	struct ath12k_tx_desc_info *tx_descs, **tx_desc_addr;
 	u32 num_rx_spt_pages = ATH12K_NUM_RX_SPT_PAGES(ab);
@@ -1401,7 +1403,7 @@ void ath12k_dp_partner_cc_init(struct ath12k_base *ab)
 		if (ag->ab[i] == ab)
 			continue;
 
-		ath12k_dp_cmem_init(ab, &ag->ab[i]->dp, ATH12K_DP_RX_DESC);
+		ath12k_dp_cmem_init(ab, ath12k_ab_to_dp(ag->ab[i]), ATH12K_DP_RX_DESC);
 	}
 }
 
@@ -1412,7 +1414,7 @@ static u32 ath12k_dp_get_num_spt_pages(struct ath12k_base *ab)
 
 static int ath12k_dp_cc_init(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i, ret = 0;
 
 	INIT_LIST_HEAD(&dp->rx_desc_free_list);
@@ -1498,7 +1500,7 @@ static int ath12k_dp_alloc_reoq_lut(struct ath12k_base *ab,
 
 static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u32 val;
 	int ret;
 
@@ -1564,13 +1566,19 @@ ath12k_dp_get_idle_link_rbm(struct ath12k_base *ab)
 
 int ath12k_dp_alloc(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp;
 	struct hal_srng *srng = NULL;
 	size_t size = 0;
 	u32 n_link_desc = 0;
 	int ret;
 	int i;
 
+	/* TODO: align dp later if cache alignment becomes a bottleneck */
+	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
+	if (!dp)
+		return -ENOMEM;
+
+	ab->dp = dp;
 	dp->ab = ab;
 
 	INIT_LIST_HEAD(&dp->reo_cmd_list);
@@ -1583,7 +1591,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup wbm_idle_ring: %d\n", ret);
-		return ret;
+		goto fail_dp_free;
 	}
 
 	srng = &ab->hal.srng_list[dp->wbm_idle_ring.ring_id];
@@ -1592,7 +1600,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 					HAL_WBM_IDLE_LINK, srng, n_link_desc);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup link desc: %d\n", ret);
-		return ret;
+		goto fail_dp_free;
 	}
 
 	ret = ath12k_dp_cc_init(ab);
@@ -1665,5 +1673,9 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	ath12k_dp_link_desc_cleanup(ab, dp->link_desc_banks,
 				    HAL_WBM_IDLE_LINK, &dp->wbm_idle_ring);
 
+fail_dp_free:
+	kfree(ab->dp);
+	ab->dp = NULL;
+
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 6ab5b2d8aac9..267220f43fd2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -582,7 +582,7 @@ static void ath12k_htt_mlo_offset_event_handler(struct ath12k_base *ab,
 void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 				       struct sk_buff *skb)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct htt_resp_msg *resp = (struct htt_resp_msg *)skb->data;
 	enum htt_t2h_msg_type type;
 	u16 peer_id;
@@ -734,6 +734,7 @@ ath12k_dp_tx_get_ring_id_type(struct ath12k_base *ab,
 int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
 				int mac_id, enum hal_ring_type ring_type)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct htt_srng_setup_cmd *cmd;
 	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
 	struct hal_srng_params params;
@@ -835,7 +836,7 @@ int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
 		   "ring_id:%d, ring_type:%d, intr_info:0x%x, flags:0x%x\n",
 		   ring_id, ring_type, cmd->intr_info, cmd->info2);
 
-	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
+	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
 	if (ret)
 		goto err_free;
 
@@ -849,7 +850,7 @@ int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
 
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct sk_buff *skb;
 	struct htt_ver_req_cmd *cmd;
 	int len = sizeof(*cmd);
@@ -901,7 +902,7 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct sk_buff *skb;
 	struct htt_ppdu_stats_cfg_cmd *cmd;
 	int len = sizeof(*cmd);
@@ -938,6 +939,7 @@ int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 				     int rx_buf_size,
 				     struct htt_rx_ring_tlv_filter *tlv_filter)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct htt_rx_ring_selection_cfg_cmd *cmd;
 	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
 	struct hal_srng_params params;
@@ -1070,7 +1072,7 @@ int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 					 HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_MASK);
 	}
 
-	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
+	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
 	if (ret)
 		goto err_free;
 
@@ -1088,7 +1090,7 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
 				   u64 cookie)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct sk_buff *skb;
 	struct htt_ext_stats_cfg_cmd *cmd;
 	int len = sizeof(*cmd);
@@ -1144,6 +1146,7 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 {
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	int ret, ring_id, i;
 
@@ -1207,7 +1210,7 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 
 	if (!reset) {
 		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
-			ring_id = ab->dp.rx_mac_buf_ring[i].ring_id;
+			ring_id = dp->rx_mac_buf_ring[i].ring_id;
 			ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
 							       i,
 							       HAL_RXDMA_BUF,
@@ -1223,7 +1226,7 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 	}
 
 	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
-		ring_id = ab->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ring_id = dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
 		if (!reset) {
 			tlv_filter.rx_filter =
 				HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
@@ -1250,6 +1253,7 @@ int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 				     int tx_buf_size,
 				     struct htt_tx_ring_tlv_filter *htt_tlv_filter)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct htt_tx_ring_selection_cfg_cmd *cmd;
 	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
 	struct hal_srng_params params;
@@ -1342,7 +1346,7 @@ int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 	cmd->tlv_filter_mask_in3 =
 		cpu_to_le32(htt_tlv_filter->tx_mon_upstream_tlv_flags2);
 
-	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
+	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
 	if (ret)
 		goto err_free;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 10d868059bad..5b5d4800370e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2436,7 +2436,8 @@ ath12k_dp_mon_parse_status_buf(struct ath12k *ar,
 			       const struct dp_mon_packet_info *packet_info)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct dp_rxdma_mon_ring *buf_ring = &ab->dp.rxdma_mon_buf_ring;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct dp_rxdma_mon_ring *buf_ring = &dp->rxdma_mon_buf_ring;
 	struct sk_buff *msdu;
 	int buf_id;
 	u32 offset;
@@ -3748,7 +3749,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	struct ath12k_pdev_dp *pdev_dp = &ar->dp;
 	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&pdev_dp->mon_data;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_mon_dest_desc *mon_dst_desc;
 	struct sk_buff *skb;
 	struct ath12k_skb_rxcb *rxcb;
@@ -3928,7 +3929,7 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 	u8 rbm;
 
 	ar = ab->pdevs[ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id)].ar;
-	dp = &ab->dp;
+	dp = ath12k_ab_to_dp(ab);
 	pmon = &ar->dp.mon_data;
 	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, mac_id);
 	rx_ring = &dp->rx_mon_status_refill_ring[srng_id];
@@ -4062,6 +4063,8 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 			  u32 *npackets, u32 *ppdu_id)
 {
 	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_buffer_addr *p_buf_addr_info, *p_last_buf_addr_info;
 	u32 msdu_ppdu_id = 0, msdu_cnt = 0, total_len = 0, frag_len = 0;
 	u32 rx_buf_size, rx_pkt_offset, sw_cookie;
@@ -4113,8 +4116,8 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 
 		desc_bank = u32_get_bits(sw_cookie, DP_LINK_DESC_BANK_MASK);
 		msdu_link_desc =
-			ar->ab->dp.link_desc_banks[desc_bank].vaddr +
-			(paddr - ar->ab->dp.link_desc_banks[desc_bank].paddr);
+			dp->link_desc_banks[desc_bank].vaddr +
+			(paddr - dp->link_desc_banks[desc_bank].paddr);
 
 		ath12k_hal_rx_msdu_list_get(ar, msdu_link_desc, &msdu_list,
 					    &num_msdus);
@@ -4252,8 +4255,8 @@ static void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
 	struct ath12k_pdev_mon_stats *rx_mon_stats;
 	u32 ppdu_id, rx_bufs_used = 0, ring_id;
 	u32 mpdu_rx_bufs_used, npackets = 0;
-	struct ath12k_dp *dp = &ar->ab->dp;
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	void *ring_entry, *mon_dst_srng;
 	struct dp_mon_mpdu *tmp_mpdu;
 	LIST_HEAD(rx_desc_used_list);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index f5bb82cdce11..daf78b7d56cf 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -76,7 +76,7 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	int num_remain;
 	u32 cookie;
 	dma_addr_t paddr;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_rx_desc_info *rx_desc;
 	enum hal_rx_buf_return_buf_manager mgr = ab->hw_params->hal_params->rx_buf_rbm;
 
@@ -191,7 +191,7 @@ static int ath12k_dp_rxdma_mon_buf_ring_free(struct ath12k_base *ab,
 
 static int ath12k_dp_rxdma_buf_free(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i;
 
 	ath12k_dp_rxdma_mon_buf_ring_free(ab, &dp->rxdma_mon_buf_ring);
@@ -241,7 +241,7 @@ static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 
 static int ath12k_dp_rxdma_buf_setup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct dp_rxdma_mon_ring *mon_ring;
 	int ret, i;
 
@@ -288,7 +288,7 @@ static void ath12k_dp_rx_pdev_srng_free(struct ath12k *ar)
 
 void ath12k_dp_rx_pdev_reo_cleanup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i;
 
 	for (i = 0; i < DP_REO_DST_RING_MAX; i++)
@@ -297,7 +297,7 @@ void ath12k_dp_rx_pdev_reo_cleanup(struct ath12k_base *ab)
 
 int ath12k_dp_rx_pdev_reo_setup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int ret;
 	int i;
 
@@ -345,7 +345,7 @@ static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
 
 void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_dp_rx_reo_cmd *cmd, *tmp;
 	struct ath12k_dp_rx_reo_cache_flush_elem *cmd_cache, *tmp_cache;
 
@@ -496,7 +496,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 				enum hal_pn_type pn_type)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_peer *peer;
 	struct ath12k_sta *ahsta;
 	struct ath12k_dp_rx_tid *rx_tid;
@@ -1471,7 +1471,7 @@ u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
 
 void ath12k_dp_rx_free(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct dp_srng *srng;
 	int i;
 
@@ -1503,7 +1503,7 @@ void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int mac_id)
 
 int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u32 ring_id;
 	int i, ret;
 
@@ -1575,7 +1575,7 @@ int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 
 int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct dp_srng *srng;
 	int i, ret;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 23a33003a9d8..449e6a2a9041 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10203,8 +10203,8 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 	idr_for_each(&ar->txmgmt_idr,
 		     ath12k_mac_vif_txmgmt_idr_remove, vif);
 
-	ath12k_mac_vif_unref(&ab->dp, vif);
-	ath12k_dp_tx_put_bank_profile(&ab->dp, arvif->bank_id);
+	ath12k_mac_vif_unref(ath12k_ab_to_dp(ab), vif);
+	ath12k_dp_tx_put_bank_profile(ath12k_ab_to_dp(ab), arvif->bank_id);
 
 	/* Recalc txpower for remaining vdev */
 	ath12k_mac_txpower_recalc(ar);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 05c278467cb3..4310f06163c9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -120,7 +120,7 @@ int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
 		ath12k_wifi7_dp_rx_process_reo_status(ab);
 
 	if (ab->hw_params->ring_mask->host2rxdma[grp_id]) {
-		struct ath12k_dp *dp = &ab->dp;
+		struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 		LIST_HEAD(list);
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 76bfa33120f3..6353c2f1f709 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -14,7 +14,7 @@ void ath12k_wifi7_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u1
 					 dma_addr_t paddr)
 {
 	struct ath12k_reo_queue_ref *qref;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	bool ml_peer = false;
 
 	if (!ab->hw_params->reoq_lut_support)
@@ -44,7 +44,7 @@ static void ath12k_wifi7_peer_rx_tid_qref_reset(struct ath12k_base *ab,
 						u16 peer_id, u16 tid)
 {
 	struct ath12k_reo_queue_ref *qref;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	bool ml_peer = false;
 
 	if (!ab->hw_params->reoq_lut_support)
@@ -106,7 +106,7 @@ int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
 					enum hal_wbm_rel_bm_act action)
 {
 	struct hal_wbm_release_ring *desc;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_srng *srng;
 	int ret = 0;
 
@@ -139,7 +139,7 @@ int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab,
 				 void (*cb)(struct ath12k_dp *dp, void *ctx,
 					    enum hal_reo_cmd_status status))
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_dp_rx_reo_cmd *dp_cmd;
 	struct hal_srng *cmd_ring;
 	int cmd_num;
@@ -617,9 +617,10 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
 	struct ath12k_rx_desc_info *desc_info;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 	struct hal_reo_dest_ring *desc;
+	struct ath12k_dp *partner_dp;
 	struct ath12k_base *partner_ab;
 	struct sk_buff_head msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
@@ -755,7 +756,8 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 			continue;
 
 		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+		partner_dp = ath12k_ab_to_dp(partner_ab);
+		rx_ring = &partner_dp->rx_refill_buf_ring;
 
 		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
 					    &rx_desc_used_list[device_id],
@@ -804,7 +806,7 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 						    struct sk_buff *defrag_skb)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)defrag_skb->data;
 	struct hal_reo_entrance_ring *reo_ent_ring;
 	struct hal_reo_dest_ring *reo_dest_ring;
@@ -1289,6 +1291,8 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 				   int budget)
 {
 	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_dp *partner_dp;
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
 	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
@@ -1318,7 +1322,7 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
 		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
 
-	reo_except = &ab->dp.reo_except_ring;
+	reo_except = &dp->reo_except_ring;
 
 	srng = &ab->hal.srng_list[reo_except->ring_id];
 
@@ -1343,17 +1347,18 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
 		device_id = hw_links[hw_link_id].device_id;
 		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		partner_dp = ath12k_ab_to_dp(partner_ab);
 
 		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
 		ar = partner_ab->pdevs[pdev_id].ar;
 
-		link_desc_banks = partner_ab->dp.link_desc_banks;
+		link_desc_banks = partner_dp->link_desc_banks;
 		link_desc_va = link_desc_banks[desc_bank].vaddr +
 			       (paddr - link_desc_banks[desc_bank].paddr);
 		ath12k_wifi7_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus,
 						       msdu_cookies, &rbm);
-		if (rbm != partner_ab->dp.idle_link_rbm &&
+		if (rbm != partner_dp->idle_link_rbm &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
 		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
 			act = HAL_WBM_REL_BM_ACT_REL_MSDU;
@@ -1414,7 +1419,8 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 			continue;
 
 		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+		partner_dp = ath12k_ab_to_dp(partner_ab);
+		rx_ring = &partner_dp->rx_refill_buf_ring;
 
 		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
 					    &rx_desc_used_list[device_id],
@@ -1682,7 +1688,8 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k *ar;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_dp *partner_dp;
 	struct dp_rxdma_ring *rx_ring;
 	struct hal_rx_wbm_rel_info err_info;
 	struct hal_srng *srng;
@@ -1833,7 +1840,8 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 
 		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+		partner_dp = ath12k_ab_to_dp(partner_ab);
+		rx_ring = &partner_dp->rx_refill_buf_ring;
 
 		ath12k_dp_rx_bufs_replenish(ab, rx_ring,
 					    &rx_desc_used_list[device_id],
@@ -1883,7 +1891,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 ring_id;
 	int ret;
@@ -1921,7 +1929,7 @@ EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_qcn9274);
 
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 ring_id;
 	int ret = 0;
@@ -1964,7 +1972,7 @@ EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_wcn7850);
 
 void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_base *ab)
 {
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_tlv_64_hdr *hdr;
 	struct hal_srng *srng;
 	struct ath12k_dp_rx_reo_cmd *cmd, *tmp;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index b3928c3d007d..6a5d6f525951 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -59,7 +59,7 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       bool is_mcast)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_tx_info ti = {};
 	struct ath12k_tx_desc_info *tx_desc;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -809,7 +809,7 @@ ath12k_wifi7_dp_tx_status_parse(struct ath12k_base *ab,
 void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 {
 	struct ath12k *ar;
-	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
 	struct ath12k_tx_desc_info *tx_desc = NULL;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9869c935aee7..d84a3762ca95 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -4056,6 +4056,7 @@ int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 
 int ath12k_wmi_cmd_init(struct ath12k_base *ab)
 {
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
 	struct ath12k_wmi_init_cmd_arg arg = {};
 
@@ -4076,7 +4077,7 @@ int ath12k_wmi_cmd_init(struct ath12k_base *ab)
 	arg.num_band_to_mac = ab->num_radios;
 	ath12k_fill_band_to_mac_param(ab, arg.band_to_mac);
 
-	ab->dp.peer_metadata_ver = arg.res_cfg.peer_metadata_ver;
+	dp->peer_metadata_ver = arg.res_cfg.peer_metadata_ver;
 
 	return ath12k_init_cmd_send(&wmi_ab->wmi[0], &arg);
 }
-- 
2.34.1


