Return-Path: <linux-wireless+bounces-28504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20110C2B4D4
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CCCD4F3537
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAFB302CBF;
	Mon,  3 Nov 2025 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kXEjwklE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F613016E4
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168924; cv=none; b=rqxmFBmoantBfdznWwm6iDqqBFzL7yjIgJ3U9oOrGF2MAqGvltdub24eKJaaAa8M6lYMpxqNBzMxLSrxoVIh0gtPHVxWGXP7uzRwjwRP0huor+fqcaBNMVbzsSjkcL/FSyjoGspactIsKsC/nOMMQtIecJ/tXNze0dtHRzl1cfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168924; c=relaxed/simple;
	bh=59/+aqnuRzPoxYlcughFxSuWgTvVaAn1j2f8uiNlRkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpAbP4dBx3TY3yQP+qNF3cU4XrvlJS9iaVX39fVFTC4ZbLQVmlWRuxuleOIUCZYPAE4gS0gv5vd3IQCs3NTYmmPKVXYBjh8QRLLS7Fp3VnzSxFNKHtZ1jlSQKSMDeygIOcqtPZvopMd87GnQMahdx6p7oWHCPhVNIdhikqx3hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kXEjwklE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A39AHe91507187;
	Mon, 3 Nov 2025 11:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3/cTVMv9r0MXUlynYmzAweATqOLtf5MB3b7A+KgemKw=; b=kXEjwklEJ81yagda
	e3OoLD4rUlkJPgea4KL8Uvl7i5gVrvRa1M3MsyXsK1tPtoyAuaKK+h91W9fh9fZH
	d8A/F+I+IiCI4bR4UHblvWzJivGTEKgut+DzvRrvaSqLArhAQ1vojBit/utJMVzY
	UtSmQts/DT08iv7MTPIDAAk8VTuHv22qvHjvNMMqt9QJi0tKQ5MukNwCIkuU75Dy
	fezic/X8k0+sHxnExu8Y2MOBZQJZy+Nm+KuSYi2n6LJzk4tCEuTLxb0SeH135Y42
	3iQgHtdSOYuzGhrePg0F5sfpaJL0ipQjOGoiV19hoKWUBzL9u4jkEopmAWtYPthc
	73nx3w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ak8me2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLs8G005217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:54 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:52 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 11/12] wifi: ath12k: Use dp objects in performance critical paths
Date: Mon, 3 Nov 2025 16:51:10 +0530
Message-ID: <20251103112111.2260639-12-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-ORIG-GUID: i5lvSN2vZBHd-hr1Ch9grlU6eDVXu06L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMyBTYWx0ZWRfXwU1+m47ZKuH3
 qpgkivcuDHLKAzzcFFJZlpLFfVuOTC2H7VOgZxwJdWeUqGPfzsiXqPHbcEYdft9NFNzgP5Ui6Et
 k8bwxWEdaKbY5MdpAADVaxCkcjUkq/emXLdXXf2PZ66jRrdWf7vvDb1Hw1c0VKc2qj2dzhSQaFF
 E4MZanEs/1Wkz5kbTbeDDTO8B03UbR9Ig9hZIm6+BtoxAmxX5rCRj/CpxgedQlL8kWTmHrsTz0z
 16gQ4M/74YwH9+bYwTnNcjqapUwEEBS+m+C0UY0k0a7t3eZ1qYLUUy49xcO+CDlhx+y8Oi+C03P
 HjQCIw1pveHmmf5jb2wdaaO1VUO89Xbr02337dYgOa39vY16b4pTLrXy14AM8VEN2jHBlB9vUPz
 Bz6Hp5lrUeIpWnrXjrmdPNL/Lt1h1Q==
X-Authority-Analysis: v=2.4 cv=ZZEQ98VA c=1 sm=1 tr=0 ts=69089053 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=5RRWBY4WAAAA:8 a=M11KmEh98J6PxdIWqMEA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=drtMOSl5Q_Tsf-UZi3mY:22 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-GUID: i5lvSN2vZBHd-hr1Ch9grlU6eDVXu06L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030103

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Use dp objects in tx and rx data paths in place of other objects to minimize
pointer indirections and increase the cache efficiency in the data paths.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c          |  25 ++-
 drivers/net/wireless/ath/ath12k/dp.h          |   9 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |  15 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h      |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  44 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  32 ++--
 drivers/net/wireless/ath/ath12k/dp_tx.c       |  24 +--
 drivers/net/wireless/ath/ath12k/dp_tx.h       |   5 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  66 ++++---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 166 +++++++++---------
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  14 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 109 ++++++------
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  12 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   7 +-
 15 files changed, 262 insertions(+), 270 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 647c2fa7ea1b..bb3b65dea02f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1150,26 +1150,23 @@ static u32 ath12k_dp_cc_cookie_gen(u16 ppt_idx, u16 spt_idx)
 	return (u32)ppt_idx << ATH12K_CC_PPT_SHIFT | spt_idx;
 }
 
-static inline void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_base *ab,
-						   u16 ppt_idx, u16 spt_idx)
+static void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_dp *dp,
+					    u16 ppt_idx, u16 spt_idx)
 {
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-
 	return dp->spt_info[ppt_idx].vaddr + spt_idx;
 }
 
-struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
+struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_dp *dp,
 						  u32 cookie)
 {
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_rx_desc_info **desc_addr_ptr;
 	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
 
-	start_ppt_idx = dp->rx_ppt_base + ATH12K_RX_SPT_PAGE_OFFSET(ab);
-	end_ppt_idx = start_ppt_idx + ATH12K_NUM_RX_SPT_PAGES(ab);
+	start_ppt_idx = dp->rx_ppt_base + ATH12K_RX_SPT_PAGE_OFFSET(dp->ab);
+	end_ppt_idx = start_ppt_idx + ATH12K_NUM_RX_SPT_PAGES(dp->ab);
 
 	if (ppt_idx < start_ppt_idx ||
 	    ppt_idx >= end_ppt_idx ||
@@ -1177,13 +1174,13 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 		return NULL;
 
 	ppt_idx = ppt_idx - dp->rx_ppt_base;
-	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(ab, ppt_idx, spt_idx);
+	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, spt_idx);
 
 	return *desc_addr_ptr;
 }
 EXPORT_SYMBOL(ath12k_dp_get_rx_desc);
 
-struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
+struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
 						  u32 cookie)
 {
 	struct ath12k_tx_desc_info **desc_addr_ptr;
@@ -1194,14 +1191,14 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 
 	start_ppt_idx = ATH12K_TX_SPT_PAGE_OFFSET;
 	end_ppt_idx = start_ppt_idx +
-		      (ATH12K_TX_SPT_PAGES_PER_POOL(ab) * ATH12K_HW_MAX_QUEUES);
+		      (ATH12K_TX_SPT_PAGES_PER_POOL(dp->ab) * ATH12K_HW_MAX_QUEUES);
 
 	if (ppt_idx < start_ppt_idx ||
 	    ppt_idx >= end_ppt_idx ||
 	    spt_idx > ATH12K_MAX_SPT_ENTRIES)
 		return NULL;
 
-	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(ab, ppt_idx, spt_idx);
+	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, spt_idx);
 
 	return *desc_addr_ptr;
 }
@@ -1249,7 +1246,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			list_add_tail(&rx_descs[j].list, &dp->rx_desc_free_list);
 
 			/* Update descriptor VA in SPT */
-			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(ab, ppt_idx, j);
+			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
 			*rx_desc_addr = &rx_descs[j];
 		}
 	}
@@ -1288,7 +1285,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 
 				/* Update descriptor VA in SPT */
 				tx_desc_addr =
-					ath12k_dp_cc_get_desc_addr_ptr(ab, ppt_idx, j);
+					ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
 				*tx_desc_addr = &tx_descs[j];
 			}
 		}
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 74801055e2f0..4bb6457b0d81 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -19,7 +19,6 @@ struct ath12k_dp_link_peer;
 struct ath12k_dp;
 struct ath12k_vif;
 struct ath12k_link_vif;
-struct hal_tcl_status_ring;
 struct ath12k_ext_irq_grp;
 struct ath12k_dp_rx_tid;
 
@@ -405,7 +404,7 @@ struct ath12k_dp_arch_ops {
 				   struct ath12k_dp_link_peer *peer, u8 tid);
 	void (*reo_cache_flush)(struct ath12k_base *ab,
 				struct ath12k_dp_rx_tid *rx_tid);
-	int (*rx_link_desc_return)(struct ath12k_base *ab,
+	int (*rx_link_desc_return)(struct ath12k_dp *dp,
 				   struct ath12k_buffer_addr *buf_addr_info,
 				   enum hal_wbm_rel_bm_act action);
 	void (*rx_frags_cleanup)(struct ath12k_dp_rx_tid *rx_tid,
@@ -587,7 +586,7 @@ int ath12k_dp_arch_rx_link_desc_return(struct ath12k_dp *dp,
 				       struct ath12k_buffer_addr *buf_addr_info,
 				       enum hal_wbm_rel_bm_act action)
 {
-	return dp->ops->rx_link_desc_return(dp->ab, buf_addr_info, action);
+	return dp->ops->rx_link_desc_return(dp, buf_addr_info, action);
 }
 
 static inline
@@ -675,8 +674,8 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 			      struct dp_link_desc_bank *link_desc_banks,
 			      u32 ring_type, struct hal_srng *srng,
 			      u32 n_link_desc);
-struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
+struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_dp *dp,
 						  u32 cookie);
-struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
+struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
 						  u32 desc_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 3b73b5501898..0533d8bf9c1c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2297,7 +2297,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
-	ath12k_wifi7_dp_extract_rx_desc_data(ab, &rx_info, rx_desc, rx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(dp->hal, &rx_info, rx_desc, rx_desc);
 
 	rcu_read_lock();
 	spin_lock_bh(&dp->dp_lock);
@@ -4131,7 +4131,7 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 
 		ath12k_hal_rx_msdu_list_get(&ar->ab->hal, ar, msdu_link_desc, &msdu_list,
 					    &num_msdus);
-		desc_info = ath12k_dp_get_rx_desc(ar->ab,
+		desc_info = ath12k_dp_get_rx_desc(ar->ab->dp,
 						  msdu_list.sw_cookie[num_msdus - 1]);
 		tail_rx_desc = (struct hal_rx_desc *)(desc_info->skb)->data;
 
@@ -4148,7 +4148,7 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 			}
 
 			desc_info =
-				ath12k_dp_get_rx_desc(ar->ab, msdu_list.sw_cookie[i]);
+				ath12k_dp_get_rx_desc(ar->ab->dp, msdu_list.sw_cookie[i]);
 			msdu = desc_info->skb;
 
 			if (!msdu) {
@@ -4355,7 +4355,7 @@ static void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
 
 	if (rx_bufs_used) {
 		rx_mon_stats->dest_ppdu_done++;
-		ath12k_dp_rx_bufs_replenish(ar->ab,
+		ath12k_dp_rx_bufs_replenish(ar->ab->dp,
 					    &dp->rx_refill_buf_ring,
 					    &rx_desc_used_list,
 					    rx_bufs_used);
@@ -4403,12 +4403,11 @@ __ath12k_dp_mon_process_ring(struct ath12k *ar, int mac_id,
 	return num_buffs_reaped;
 }
 
-int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
+int ath12k_dp_mon_process_ring(struct ath12k_dp *dp, int mac_id,
 			       struct napi_struct *napi, int budget,
 			       enum dp_monitor_mode monitor_mode)
 {
-	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(dp->hw_params, mac_id);
 	struct ath12k_pdev_dp *dp_pdev;
 	struct ath12k *ar;
 	int num_buffs_reaped = 0;
@@ -4421,7 +4420,7 @@ int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 		return 0;
 	}
 
-	if (ab->hw_params->rxdma1_enable) {
+	if (dp->hw_params->rxdma1_enable) {
 		if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
 			num_buffs_reaped = ath12k_dp_mon_srng_process(dp_pdev, &budget,
 								      napi);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 6110227a40dd..3e6ff4b0a6d9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -89,7 +89,7 @@ int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 					struct dp_rxdma_mon_ring *rx_ring,
 					int req_entries);
-int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
+int ath12k_dp_mon_process_ring(struct ath12k_dp *dp, int mac_id,
 			       struct napi_struct *napi, int budget,
 			       enum dp_monitor_mode monitor_mode);
 struct sk_buff *ath12k_dp_mon_tx_alloc_skb(void);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index ff9335955682..ef0369dafbc7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -61,11 +61,12 @@ static void ath12k_dp_rx_enqueue_free(struct ath12k_dp *dp,
 }
 
 /* Returns number of Rx buffers replenished */
-int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
+int ath12k_dp_rx_bufs_replenish(struct ath12k_dp *dp,
 				struct dp_rxdma_ring *rx_ring,
 				struct list_head *used_list,
 				int req_entries)
 {
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_buffer_addr *desc;
 	struct hal_srng *srng;
 	struct sk_buff *skb;
@@ -73,13 +74,12 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	int num_remain;
 	u32 cookie;
 	dma_addr_t paddr;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_rx_desc_info *rx_desc;
-	enum hal_rx_buf_return_buf_manager mgr = ab->hal.hal_params->rx_buf_rbm;
+	enum hal_rx_buf_return_buf_manager mgr = dp->hal->hal_params->rx_buf_rbm;
 
 	req_entries = min(req_entries, rx_ring->bufs_max);
 
-	srng = &ab->hal.srng_list[rx_ring->refill_buf_ring.ring_id];
+	srng = &dp->hal->srng_list[rx_ring->refill_buf_ring.ring_id];
 
 	spin_lock_bh(&srng->lock);
 
@@ -118,10 +118,10 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				 skb->data);
 		}
 
-		paddr = dma_map_single(ab->dev, skb->data,
+		paddr = dma_map_single(dp->dev, skb->data,
 				       skb->len + skb_tailroom(skb),
 				       DMA_FROM_DEVICE);
-		if (dma_mapping_error(ab->dev, paddr))
+		if (dma_mapping_error(dp->dev, paddr))
 			goto fail_free_skb;
 
 		rx_desc = list_first_entry_or_null(used_list,
@@ -142,14 +142,14 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 
 		num_remain--;
 
-		ath12k_hal_rx_buf_addr_info_set(&ab->hal, desc, paddr, cookie,
+		ath12k_hal_rx_buf_addr_info_set(dp->hal, desc, paddr, cookie,
 						mgr);
 	}
 
 	goto out;
 
 fail_dma_unmap:
-	dma_unmap_single(ab->dev, paddr, skb->len + skb_tailroom(skb),
+	dma_unmap_single(dp->dev, paddr, skb->len + skb_tailroom(skb),
 			 DMA_FROM_DEVICE);
 fail_free_skb:
 	dev_kfree_skb_any(skb);
@@ -233,7 +233,7 @@ static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 	rx_ring->bufs_max = rx_ring->refill_buf_ring.size /
 			ath12k_hal_srng_get_entrysize(ab, HAL_RXDMA_BUF);
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &list, 0);
+	ath12k_dp_rx_bufs_replenish(ath12k_ab_to_dp(ab), rx_ring, &list, 0);
 
 	return 0;
 }
@@ -816,8 +816,6 @@ static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k_pdev_dp *dp_pdev,
 					 enum hal_encrypt_type enctype,
 					 struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u8 decap_hdr[DP_MAX_NWIFI_HDR_LEN];
 	struct ieee80211_hdr *hdr;
@@ -850,7 +848,7 @@ static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k_pdev_dp *dp_pdev,
 	if (!(rx_info->rx_status->flag & RX_FLAG_IV_STRIPPED)) {
 		crypto_hdr = skb_push(msdu,
 				      ath12k_dp_rx_crypto_param_len(dp_pdev, enctype));
-		ath12k_dp_rx_desc_get_crypto_header(ab,
+		ath12k_dp_rx_desc_get_crypto_header(dp_pdev->dp->hal,
 						    rxcb->rx_desc, crypto_hdr,
 						    enctype);
 	}
@@ -929,19 +927,20 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
 	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	size_t hdr_len, crypto_len;
 	struct ieee80211_hdr hdr;
 	__le16 qos_ctl;
 	u8 *crypto_hdr;
 
-	ath12k_dp_rx_desc_get_dot11_hdr(ab, rx_desc, &hdr);
+	ath12k_dp_rx_desc_get_dot11_hdr(hal, rx_desc, &hdr);
 	hdr_len = ieee80211_hdrlen(hdr.frame_control);
 
 	if (!(rx_info->rx_status->flag & RX_FLAG_IV_STRIPPED)) {
 		crypto_len = ath12k_dp_rx_crypto_param_len(dp_pdev, enctype);
 		crypto_hdr = skb_push(msdu, crypto_len);
-		ath12k_dp_rx_desc_get_crypto_header(ab, rx_desc, crypto_hdr, enctype);
+		ath12k_dp_rx_desc_get_crypto_header(dp->hal, rx_desc, crypto_hdr,
+						    enctype);
 	}
 
 	skb_push(msdu, hdr_len);
@@ -1188,7 +1187,6 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 			       struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_sta *pubsta;
 	struct ath12k_dp_peer *peer;
@@ -1207,7 +1205,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 		status->link_id = peer->hw_links[rxcb->hw_link_id];
 	}
 
-	ath12k_dbg(ab, ATH12K_DBG_DATA,
+	ath12k_dbg(dp->ab, ATH12K_DBG_DATA,
 		   "rx skb %p len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s%s%s%s rate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
@@ -1233,7 +1231,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 		   !!(status->flag & RX_FLAG_MMIC_ERROR),
 		   !!(status->flag & RX_FLAG_AMSDU_MORE));
 
-	ath12k_dbg_dump(ab, ATH12K_DBG_DP_RX, NULL, "dp rx msdu: ",
+	ath12k_dbg_dump(dp->ab, ATH12K_DBG_DP_RX, NULL, "dp rx msdu: ",
 			msdu->data, msdu->len);
 
 	rx_status = IEEE80211_SKB_RXCB(msdu);
@@ -1410,18 +1408,18 @@ void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff
 }
 EXPORT_SYMBOL(ath12k_dp_rx_h_undecap_frag);
 
-static int ath12k_dp_rx_h_cmp_frags(struct ath12k_base *ab,
+static int ath12k_dp_rx_h_cmp_frags(struct ath12k_hal *hal,
 				    struct sk_buff *a, struct sk_buff *b)
 {
 	int frag1, frag2;
 
-	frag1 = ath12k_dp_rx_h_frag_no(ab, a);
-	frag2 = ath12k_dp_rx_h_frag_no(ab, b);
+	frag1 = ath12k_dp_rx_h_frag_no(hal, a);
+	frag2 = ath12k_dp_rx_h_frag_no(hal, b);
 
 	return frag1 - frag2;
 }
 
-void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
+void ath12k_dp_rx_h_sort_frags(struct ath12k_hal *hal,
 			       struct sk_buff_head *frag_list,
 			       struct sk_buff *cur_frag)
 {
@@ -1429,7 +1427,7 @@ void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
 	int cmp;
 
 	skb_queue_walk(frag_list, skb) {
-		cmp = ath12k_dp_rx_h_cmp_frags(ab, skb, cur_frag);
+		cmp = ath12k_dp_rx_h_cmp_frags(hal, skb, cur_frag);
 		if (cmp < 0)
 			continue;
 		__skb_queue_before(frag_list, skb, cur_frag);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 8a1dc5d15341..a4ac67eb91d1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -92,21 +92,21 @@ static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
 	return ret;
 }
 
-static inline bool ath12k_dp_rx_h_more_frags(struct ath12k_base *ab,
+static inline bool ath12k_dp_rx_h_more_frags(struct ath12k_hal *hal,
 					     struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + ab->hal.hal_desc_sz);
+	hdr = (struct ieee80211_hdr *)(skb->data + hal->hal_desc_sz);
 	return ieee80211_has_morefrags(hdr->frame_control);
 }
 
-static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
+static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_hal *hal,
 					 struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + ab->hal.hal_desc_sz);
+	hdr = (struct ieee80211_hdr *)(skb->data + hal->hal_desc_sz);
 	return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 }
 
@@ -116,18 +116,18 @@ static inline u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 	return ab->hal.ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
-static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
+static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_hal *hal,
 						  struct hal_rx_desc *fdesc,
 						  struct hal_rx_desc *ldesc)
 {
-	ab->hal.ops->rx_desc_copy_end_tlv(fdesc, ldesc);
+	hal->ops->rx_desc_copy_end_tlv(fdesc, ldesc);
 }
 
-static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
+static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_hal *hal,
 						 struct hal_rx_desc *desc,
 						 u16 len)
 {
-	ab->hal.ops->rx_desc_set_msdu_len(desc, len);
+	hal->ops->rx_desc_set_msdu_len(desc, len);
 }
 
 static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
@@ -136,25 +136,25 @@ static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 	return ab->hal.ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
 }
 
-static inline void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
+static inline void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_hal *hal,
 						   struct hal_rx_desc *desc,
 						   struct ieee80211_hdr *hdr)
 {
-	ab->hal.ops->rx_desc_get_dot11_hdr(desc, hdr);
+	hal->ops->rx_desc_get_dot11_hdr(desc, hdr);
 }
 
-static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
+static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_hal *hal,
 						       struct hal_rx_desc *desc,
 						       u8 *crypto_hdr,
 						       enum hal_encrypt_type enctype)
 {
-	ab->hal.ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
+	hal->ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
 }
 
-static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
+static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_hal *hal,
 						struct hal_rx_desc *desc)
 {
-	return ab->hal.ops->rx_desc_get_msdu_src_link_id(desc);
+	return hal->ops->rx_desc_get_msdu_src_link_id(desc);
 }
 
 static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
@@ -178,7 +178,7 @@ bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
 					    struct sk_buff *msdu,
 					    struct hal_rx_desc_data *rx_info);
 u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb);
-void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
+void ath12k_dp_rx_h_sort_frags(struct ath12k_hal *hal,
 			       struct sk_buff_head *frag_list,
 			       struct sk_buff *cur_frag);
 void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
@@ -210,7 +210,7 @@ void ath12k_dp_rx_free(struct ath12k_base *ab);
 int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab);
-int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
+int ath12k_dp_rx_bufs_replenish(struct ath12k_dp *dp,
 				struct dp_rxdma_ring *rx_ring,
 				struct list_head *used_list,
 				int req_entries);
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index bcae34f5db7d..1d4444f3936f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -146,10 +146,9 @@ static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
 	}
 }
 
-int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
-			       struct sk_buff **pskb)
+int ath12k_dp_tx_align_payload(struct ath12k_dp *dp, struct sk_buff **pskb)
 {
-	u32 iova_mask = ab->hw_params->iova_mask;
+	u32 iova_mask = dp->hw_params->iova_mask;
 	unsigned long offset, delta1, delta2;
 	struct sk_buff *skb2, *skb = *pskb;
 	unsigned int headroom = skb_headroom(skb);
@@ -184,28 +183,29 @@ int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 }
 EXPORT_SYMBOL(ath12k_dp_tx_align_payload);
 
-void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
+void ath12k_dp_tx_free_txbuf(struct ath12k_dp *dp,
 			     struct dp_tx_ring *tx_ring,
 			     struct ath12k_tx_desc_params *desc_params)
 {
-	struct ath12k *ar;
+	struct ath12k_pdev_dp *dp_pdev;
 	struct sk_buff *msdu = desc_params->skb;
 	struct ath12k_skb_cb *skb_cb;
-	u8 pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params->mac_id);
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(dp->hw_params, desc_params->mac_id);
 
 	skb_cb = ATH12K_SKB_CB(msdu);
-	ar = ab->pdevs[pdev_id].ar;
 
-	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
+
+	dma_unmap_single(dp->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
-		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+		dma_unmap_single(dp->dev, skb_cb->paddr_ext_desc,
 				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
-	ieee80211_free_txskb(ar->ah->hw, msdu);
+	ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 
-	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
-		wake_up(&ar->dp.tx_empty_waitq);
+	if (atomic_dec_and_test(&dp_pdev->num_tx_pending))
+		wake_up(&dp_pdev->tx_empty_waitq);
 }
 EXPORT_SYMBOL(ath12k_dp_tx_free_txbuf);
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 147409f9ac40..7cef20540179 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -20,14 +20,13 @@ ath12k_dp_tx_get_encap_type(struct ath12k_base *ab, struct sk_buff *skb);
 void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb);
 u8 ath12k_dp_tx_get_tid(struct sk_buff *skb);
 void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len);
-int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
-			       struct sk_buff **pskb);
+int ath12k_dp_tx_align_payload(struct ath12k_dp *dp, struct sk_buff **pskb);
 void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
 				struct ath12k_tx_desc_info *tx_desc,
 				u8 pool_id);
 struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
 						       u8 pool_id);
-void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
+void ath12k_dp_tx_free_txbuf(struct ath12k_dp *dp,
 			     struct dp_tx_ring *tx_ring,
 			     struct ath12k_tx_desc_params *desc_params);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 433ffdb55264..30c27e005ed8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -19,7 +19,6 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 					struct ath12k_ext_irq_grp *irq_grp,
 					int budget)
 {
-	struct ath12k_base *ab = dp->ab;
 	struct napi_struct *napi = &irq_grp->napi;
 	int grp_id = irq_grp->grp_id;
 	int work_done = 0;
@@ -28,21 +27,21 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 	enum dp_monitor_mode monitor_mode;
 	u8 ring_mask;
 
-	if (ab->hw_params->ring_mask->tx[grp_id]) {
-		i = fls(ab->hw_params->ring_mask->tx[grp_id]) - 1;
-		ath12k_wifi7_dp_tx_completion_handler(ab, i);
+	if (dp->hw_params->ring_mask->tx[grp_id]) {
+		i = fls(dp->hw_params->ring_mask->tx[grp_id]) - 1;
+		ath12k_wifi7_dp_tx_completion_handler(dp, i);
 	}
 
-	if (ab->hw_params->ring_mask->rx_err[grp_id]) {
-		work_done = ath12k_wifi7_dp_rx_process_err(ab, napi, budget);
+	if (dp->hw_params->ring_mask->rx_err[grp_id]) {
+		work_done = ath12k_wifi7_dp_rx_process_err(dp, napi, budget);
 		budget -= work_done;
 		tot_work_done += work_done;
 		if (budget <= 0)
 			goto done;
 	}
 
-	if (ab->hw_params->ring_mask->rx_wbm_rel[grp_id]) {
-		work_done = ath12k_wifi7_dp_rx_process_wbm_err(ab, napi, budget);
+	if (dp->hw_params->ring_mask->rx_wbm_rel[grp_id]) {
+		work_done = ath12k_wifi7_dp_rx_process_wbm_err(dp, napi, budget);
 		budget -= work_done;
 		tot_work_done += work_done;
 
@@ -50,24 +49,24 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 			goto done;
 	}
 
-	if (ab->hw_params->ring_mask->rx[grp_id]) {
-		i = fls(ab->hw_params->ring_mask->rx[grp_id]) - 1;
-		work_done = ath12k_wifi7_dp_rx_process(ab, i, napi, budget);
+	if (dp->hw_params->ring_mask->rx[grp_id]) {
+		i = fls(dp->hw_params->ring_mask->rx[grp_id]) - 1;
+		work_done = ath12k_wifi7_dp_rx_process(dp, i, napi, budget);
 		budget -= work_done;
 		tot_work_done += work_done;
 		if (budget <= 0)
 			goto done;
 	}
 
-	if (ab->hw_params->ring_mask->rx_mon_status[grp_id]) {
-		ring_mask = ab->hw_params->ring_mask->rx_mon_status[grp_id];
-		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
+	if (dp->hw_params->ring_mask->rx_mon_status[grp_id]) {
+		ring_mask = dp->hw_params->ring_mask->rx_mon_status[grp_id];
+		for (i = 0; i < dp->ab->num_radios; i++) {
+			for (j = 0; j < dp->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * dp->hw_params->num_rxdma_per_pdev + j;
 
 				if (ring_mask & BIT(id)) {
 					work_done =
-					ath12k_dp_mon_process_ring(ab, id, napi, budget,
+					ath12k_dp_mon_process_ring(dp, id, napi, budget,
 								   0);
 					budget -= work_done;
 					tot_work_done += work_done;
@@ -78,16 +77,16 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 		}
 	}
 
-	if (ab->hw_params->ring_mask->rx_mon_dest[grp_id]) {
+	if (dp->hw_params->ring_mask->rx_mon_dest[grp_id]) {
 		monitor_mode = ATH12K_DP_RX_MONITOR_MODE;
-		ring_mask = ab->hw_params->ring_mask->rx_mon_dest[grp_id];
-		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
+		ring_mask = dp->hw_params->ring_mask->rx_mon_dest[grp_id];
+		for (i = 0; i < dp->ab->num_radios; i++) {
+			for (j = 0; j < dp->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * dp->hw_params->num_rxdma_per_pdev + j;
 
 				if (ring_mask & BIT(id)) {
 					work_done =
-					ath12k_dp_mon_process_ring(ab, id, napi, budget,
+					ath12k_dp_mon_process_ring(dp, id, napi, budget,
 								   monitor_mode);
 					budget -= work_done;
 					tot_work_done += work_done;
@@ -99,16 +98,16 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 		}
 	}
 
-	if (ab->hw_params->ring_mask->tx_mon_dest[grp_id]) {
+	if (dp->hw_params->ring_mask->tx_mon_dest[grp_id]) {
 		monitor_mode = ATH12K_DP_TX_MONITOR_MODE;
-		ring_mask = ab->hw_params->ring_mask->tx_mon_dest[grp_id];
-		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
+		ring_mask = dp->hw_params->ring_mask->tx_mon_dest[grp_id];
+		for (i = 0; i < dp->ab->num_radios; i++) {
+			for (j = 0; j < dp->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * dp->hw_params->num_rxdma_per_pdev + j;
 
 				if (ring_mask & BIT(id)) {
 					work_done =
-					ath12k_dp_mon_process_ring(ab, id, napi, budget,
+					ath12k_dp_mon_process_ring(dp, id, napi, budget,
 								   monitor_mode);
 					budget -= work_done;
 					tot_work_done += work_done;
@@ -120,15 +119,14 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 		}
 	}
 
-	if (ab->hw_params->ring_mask->reo_status[grp_id])
-		ath12k_wifi7_dp_rx_process_reo_status(ab);
+	if (dp->hw_params->ring_mask->reo_status[grp_id])
+		ath12k_wifi7_dp_rx_process_reo_status(dp);
 
-	if (ab->hw_params->ring_mask->host2rxdma[grp_id]) {
-		struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	if (dp->hw_params->ring_mask->host2rxdma[grp_id]) {
 		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 		LIST_HEAD(list);
 
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring, &list, 0);
+		ath12k_dp_rx_bufs_replenish(dp, rx_ring, &list, 0);
 	}
 
 	/* TODO: Implement handler for other interrupts */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index d2026082708e..2138b20a04d5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -125,16 +125,16 @@ void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k_base *ab,
 	peer->rx_tid_active_bitmask &= ~(1 << tid);
 }
 
-int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
+int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_dp *dp,
 					struct ath12k_buffer_addr *buf_addr_info,
 					enum hal_wbm_rel_bm_act action)
 {
+	struct ath12k_base *ab = dp->ab;
 	struct hal_wbm_release_ring *desc;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct hal_srng *srng;
 	int ret = 0;
 
-	srng = &ab->hal.srng_list[dp->wbm_desc_rel_ring.ring_id];
+	srng = &dp->hal->srng_list[dp->wbm_desc_rel_ring.ring_id];
 
 	spin_lock_bh(&srng->lock);
 
@@ -411,19 +411,18 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	}
 }
 
-static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k_dp *dp,
+static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k_hal *hal,
 					    struct sk_buff_head *msdu_list,
 					    struct sk_buff *first, struct sk_buff *last,
 					    u8 l3pad_bytes, int msdu_len,
 					    struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = dp->ab;
 	struct sk_buff *skb;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(first);
 	int buf_first_hdr_len, buf_first_len;
 	struct hal_rx_desc *ldesc;
 	int space_extra, rem_len, buf_len;
-	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = hal->hal_desc_sz;
 	bool is_continuation;
 
 	/* As the msdu is spread across multiple rx buffers,
@@ -453,7 +452,7 @@ static int ath12k_wifi7_dp_rx_msdu_coalesce(struct ath12k_dp *dp,
 	/* When an MSDU spread over multiple buffers MSDU_END
 	 * tlvs are valid only in the last buffer. Copy those tlvs.
 	 */
-	ath12k_dp_rx_desc_end_tlv_copy(ab, rxcb->rx_desc, ldesc);
+	ath12k_dp_rx_desc_end_tlv_copy(hal, rxcb->rx_desc, ldesc);
 
 	space_extra = msdu_len - (buf_first_len + skb_tailroom(first));
 	if (space_extra > 0 &&
@@ -505,18 +504,18 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 					   struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
 	struct ath12k_skb_rxcb *rxcb;
 	struct sk_buff *last_buf;
+	struct ath12k_hal *hal = dp->hal;
 	u8 l3_pad_bytes;
 	u16 msdu_len;
 	int ret;
-	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = hal->hal_desc_sz;
 
 	last_buf = ath12k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
 	if (!last_buf) {
-		ath12k_warn(ab,
+		ath12k_warn(dp->ab,
 			    "No valid Rx buffer to access MSDU_END tlv\n");
 		ret = -EIO;
 		goto free_out;
@@ -525,9 +524,9 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 	rx_desc = (struct hal_rx_desc *)msdu->data;
 	lrx_desc = (struct hal_rx_desc *)last_buf->data;
 
-	ath12k_wifi7_dp_extract_rx_desc_data(ab, rx_info, rx_desc, lrx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(hal, rx_info, rx_desc, lrx_desc);
 	if (!rx_info->msdu_done) {
-		ath12k_warn(ab, "msdu_done bit in msdu_end is not set\n");
+		ath12k_warn(dp->ab, "msdu_done bit in msdu_end is not set\n");
 		ret = -EIO;
 		goto free_out;
 	}
@@ -542,20 +541,20 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 	} else if (!rxcb->is_continuation) {
 		if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
 			ret = -EINVAL;
-			ath12k_warn(ab, "invalid msdu len %u\n", msdu_len);
-			ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
+			ath12k_warn(dp->ab, "invalid msdu len %u\n", msdu_len);
+			ath12k_dbg_dump(dp->ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
 					sizeof(*rx_desc));
 			goto free_out;
 		}
 		skb_put(msdu, hal_rx_desc_sz + l3_pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3_pad_bytes);
 	} else {
-		ret = ath12k_wifi7_dp_rx_msdu_coalesce(dp, msdu_list,
+		ret = ath12k_wifi7_dp_rx_msdu_coalesce(hal, msdu_list,
 						       msdu, last_buf,
 						       l3_pad_bytes, msdu_len,
 						       rx_info);
 		if (ret) {
-			ath12k_warn(ab,
+			ath12k_warn(dp->ab,
 				    "failed to coalesce msdu rx buffer%d\n", ret);
 			goto free_out;
 		}
@@ -579,12 +578,11 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 }
 
 static void
-ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
+ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_dp *dp,
 					    struct napi_struct *napi,
 					    struct sk_buff_head *msdu_list,
 					    int ring_id)
 {
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_hw_group *ag = dp->ag;
 	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct ieee80211_rx_status rx_status = {};
@@ -634,7 +632,7 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 
 		ret = ath12k_wifi7_dp_rx_process_msdu(dp_pdev, msdu, msdu_list, &rx_info);
 		if (ret) {
-			ath12k_dbg(ab, ATH12K_DBG_DATA,
+			ath12k_dbg(dp->ab, ATH12K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
 			dev_kfree_skb_any(msdu);
 			continue;
@@ -646,11 +644,12 @@ ath12k_wifi7_dp_rx_process_received_packets(struct ath12k_base *ab,
 	rcu_read_unlock();
 }
 
-int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
+int ath12k_wifi7_dp_rx_process(struct ath12k_dp *dp, int ring_id,
 			       struct napi_struct *napi, int budget)
 {
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_hw_group *ag = dp->ag;
+	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	struct ath12k_hw_link *hw_links = ag->hw_links;
@@ -659,7 +658,6 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 	struct hal_reo_dest_ring *desc;
 	struct ath12k_dp *partner_dp;
-	struct ath12k_base *partner_ab;
 	struct sk_buff_head msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
 	int total_msdu_reaped = 0;
@@ -674,7 +672,7 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
 		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
 
-	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
+	srng = &hal->srng_list[dp->reo_dst_ring[ring_id].ring_id];
 
 	spin_lock_bh(&srng->lock);
 
@@ -707,13 +705,12 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 
 			continue;
 		}
-		partner_ab = partner_dp->ab;
 
 		/* retry manual desc retrieval */
 		if (!desc_info) {
-			desc_info = ath12k_dp_get_rx_desc(partner_ab, cookie);
+			desc_info = ath12k_dp_get_rx_desc(partner_dp, cookie);
 			if (!desc_info) {
-				ath12k_warn(partner_ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
+				ath12k_warn(partner_dp->ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
 					    cookie);
 				continue;
 			}
@@ -728,12 +725,12 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(partner_ab->dev, rxcb->paddr,
+		dma_unmap_single(partner_dp->dev, rxcb->paddr,
 				 msdu->len + skb_tailroom(msdu),
 				 DMA_FROM_DEVICE);
 
 		num_buffs_reaped[device_id]++;
-		dp->device_stats.reo_rx[ring_id][ab->device_id]++;
+		dp->device_stats.reo_rx[ring_id][dp->device_id]++;
 
 		push_reason = le32_get_bits(desc->info0,
 					    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
@@ -795,15 +792,14 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 			continue;
 
 		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
-		partner_ab = partner_dp->ab;
 		rx_ring = &partner_dp->rx_refill_buf_ring;
 
-		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
+		ath12k_dp_rx_bufs_replenish(partner_dp, rx_ring,
 					    &rx_desc_used_list[device_id],
 					    num_buffs_reaped[device_id]);
 	}
 
-	ath12k_wifi7_dp_rx_process_received_packets(ab, napi, &msdu_list,
+	ath12k_wifi7_dp_rx_process_received_packets(dp, napi, &msdu_list,
 						    ring_id);
 
 exit:
@@ -846,6 +842,7 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 						    struct sk_buff *defrag_skb)
 {
 	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)defrag_skb->data;
 	struct hal_reo_entrance_ring *reo_ent_ring;
 	struct hal_reo_dest_ring *reo_dest_ring;
@@ -861,11 +858,11 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 	enum hal_rx_buf_return_buf_manager idle_link_rbm = dp->idle_link_rbm;
 	u8 dst_ind;
 
-	hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	hal_rx_desc_sz = hal->hal_desc_sz;
 	link_desc_banks = dp->link_desc_banks;
 	reo_dest_ring = rx_tid->dst_ring_desc;
 
-	ath12k_wifi7_hal_rx_reo_ent_paddr_get(ab, &reo_dest_ring->buf_addr_info,
+	ath12k_wifi7_hal_rx_reo_ent_paddr_get(&reo_dest_ring->buf_addr_info,
 					      &link_paddr, &cookie);
 	desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
 
@@ -888,12 +885,12 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 	msdu0->rx_msdu_ext_info.info0 = cpu_to_le32(msdu_ext_info);
 
 	/* change msdu len in hal rx desc */
-	ath12k_dp_rxdesc_set_msdu_len(ab, rx_desc, defrag_skb->len - hal_rx_desc_sz);
+	ath12k_dp_rxdesc_set_msdu_len(hal, rx_desc, defrag_skb->len - hal_rx_desc_sz);
 
-	buf_paddr = dma_map_single(ab->dev, defrag_skb->data,
+	buf_paddr = dma_map_single(dp->dev, defrag_skb->data,
 				   defrag_skb->len + skb_tailroom(defrag_skb),
 				   DMA_TO_DEVICE);
-	if (dma_mapping_error(ab->dev, buf_paddr))
+	if (dma_mapping_error(dp->dev, buf_paddr))
 		return -ENOMEM;
 
 	spin_lock_bh(&dp->rx_desc_lock);
@@ -920,7 +917,7 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 					      HAL_RX_BUF_RBM_SW3_BM);
 
 	/* Fill mpdu details into reo entrance ring */
-	srng = &ab->hal.srng_list[dp->reo_reinject_ring.ring_id];
+	srng = &hal->srng_list[dp->reo_reinject_ring.ring_id];
 
 	spin_lock_bh(&srng->lock);
 	ath12k_hal_srng_access_begin(ab, srng);
@@ -947,7 +944,7 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 	reo_ent_ring->rx_mpdu_info.peer_meta_data =
 		reo_dest_ring->rx_mpdu_info.peer_meta_data;
 
-	if (ab->hw_params->reoq_lut_support) {
+	if (dp->hw_params->reoq_lut_support) {
 		reo_ent_ring->queue_addr_lo = reo_dest_ring->rx_mpdu_info.peer_meta_data;
 		queue_addr_hi = 0;
 	} else {
@@ -981,7 +978,7 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 	list_add_tail(&desc_info->list, &dp->rx_desc_free_list);
 	spin_unlock_bh(&dp->rx_desc_lock);
 err_unmap_dma:
-	dma_unmap_single(ab->dev, buf_paddr, defrag_skb->len + skb_tailroom(defrag_skb),
+	dma_unmap_single(dp->dev, buf_paddr, defrag_skb->len + skb_tailroom(defrag_skb),
 			 DMA_TO_DEVICE);
 	return ret;
 }
@@ -993,7 +990,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 						struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
 	struct ieee80211_key_conf *key_conf;
@@ -1001,7 +998,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
 	int head_len, tail_len, ret;
 	size_t data_len;
-	u32 hdr_len, hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	u32 hdr_len, hal_rx_desc_sz = hal->hal_desc_sz;
 	u8 *key, *data;
 	u8 key_idx;
 
@@ -1038,7 +1035,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 	(ATH12K_SKB_RXCB(msdu))->is_first_msdu = true;
 	(ATH12K_SKB_RXCB(msdu))->is_last_msdu = true;
 
-	ath12k_wifi7_dp_extract_rx_desc_data(ab, rx_info, rx_desc, rx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(hal, rx_info, rx_desc, rx_desc);
 
 	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
@@ -1135,7 +1132,7 @@ void ath12k_wifi7_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 	if (rx_tid->dst_ring_desc) {
 		if (rel_link_desc) {
 			buf_addr_info = &rx_tid->dst_ring_desc->buf_addr_info;
-			ath12k_wifi7_dp_rx_link_desc_return(dp->ab, buf_addr_info, act);
+			ath12k_wifi7_dp_rx_link_desc_return(dp, buf_addr_info, act);
 		}
 		kfree(rx_tid->dst_ring_desc);
 		rx_tid->dst_ring_desc = NULL;
@@ -1153,6 +1150,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 					  struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_hal *hal = dp->hal;
 	struct ath12k_base *ab = dp->ab;
 	struct ath12k_dp_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
@@ -1164,8 +1162,8 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	bool more_frags;
 	enum hal_encrypt_type enctype = rx_info->enctype;
 
-	frag_no = ath12k_dp_rx_h_frag_no(ab, msdu);
-	more_frags = ath12k_dp_rx_h_more_frags(ab, msdu);
+	frag_no = ath12k_dp_rx_h_frag_no(hal, msdu);
+	more_frags = ath12k_dp_rx_h_more_frags(hal, msdu);
 	seqno = rx_info->seq_no;
 
 	if (!rx_info->seq_ctl_valid || !rx_info->fc_valid ||
@@ -1214,7 +1212,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	if ((!rx_tid->rx_frag_bitmap || frag_no > __fls(rx_tid->rx_frag_bitmap)))
 		__skb_queue_tail(&rx_tid->rx_frags, msdu);
 	else
-		ath12k_dp_rx_h_sort_frags(ab, &rx_tid->rx_frags, msdu);
+		ath12k_dp_rx_h_sort_frags(hal, &rx_tid->rx_frags, msdu);
 
 	rx_tid->rx_frag_bitmap |= BIT(frag_no);
 	if (!more_frags)
@@ -1229,7 +1227,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 			goto out_unlock;
 		}
 	} else {
-		ath12k_wifi7_dp_rx_link_desc_return(ab, &ring_desc->buf_addr_info,
+		ath12k_wifi7_dp_rx_link_desc_return(dp, &ring_desc->buf_addr_info,
 						    HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 	}
 
@@ -1280,13 +1278,13 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
 	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	struct sk_buff *msdu;
 	struct ath12k_skb_rxcb *rxcb;
 	struct hal_rx_desc_data rx_info;
 	struct hal_rx_desc *rx_desc;
 	u16 msdu_len;
-	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	u32 hal_rx_desc_sz = hal->hal_desc_sz;
 	struct ath12k_rx_desc_info *desc_info;
 	u64 desc_va;
 
@@ -1296,16 +1294,17 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 
 	/* retry manual desc retrieval */
 	if (!desc_info) {
-		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
+		desc_info = ath12k_dp_get_rx_desc(dp, cookie);
 		if (!desc_info) {
-			ath12k_warn(ab, "Invalid cookie in DP rx error descriptor retrieval: 0x%x\n",
+			ath12k_warn(dp->ab,
+				    "Invalid cookie in DP rx error descriptor retrieval: 0x%x\n",
 				    cookie);
 			return -EINVAL;
 		}
 	}
 
 	if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
-		ath12k_warn(ab, " RX Exception, Check HW CC implementation");
+		ath12k_warn(dp->ab, "RX Exception, Check HW CC implementation");
 
 	msdu = desc_info->skb;
 	desc_info->skb = NULL;
@@ -1313,7 +1312,7 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 	list_add_tail(&desc_info->list, used_list);
 
 	rxcb = ATH12K_SKB_RXCB(msdu);
-	dma_unmap_single(ab->dev, rxcb->paddr,
+	dma_unmap_single(dp->dev, rxcb->paddr,
 			 msdu->len + skb_tailroom(msdu),
 			 DMA_FROM_DEVICE);
 
@@ -1334,12 +1333,12 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
-	ath12k_wifi7_dp_extract_rx_desc_data(ab, &rx_info, rx_desc, rx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(hal, &rx_info, rx_desc, rx_desc);
 
 	msdu_len = rx_info.msdu_len;
 	if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
-		ath12k_warn(ab, "invalid msdu leng %u", msdu_len);
-		ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
+		ath12k_warn(dp->ab, "invalid msdu leng %u", msdu_len);
+		ath12k_dbg_dump(dp->ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
 				sizeof(*rx_desc));
 		dev_kfree_skb_any(msdu);
 		goto exit;
@@ -1349,7 +1348,7 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 
 	if (ath12k_wifi7_dp_rx_frag_h_mpdu(dp_pdev, msdu, desc, &rx_info)) {
 		dev_kfree_skb_any(msdu);
-		ath12k_wifi7_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
+		ath12k_wifi7_dp_rx_link_desc_return(dp, &desc->buf_addr_info,
 						    HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 	}
 exit:
@@ -1357,10 +1356,11 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 	return 0;
 }
 
-int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
+int ath12k_wifi7_dp_rx_process_err(struct ath12k_dp *dp, struct napi_struct *napi,
 				   int budget)
 {
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	struct ath12k_hw_group *ag = dp->ag;
 	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct ath12k_dp *partner_dp;
@@ -1375,7 +1375,6 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 	struct dp_rxdma_ring *rx_ring;
 	struct dp_srng *reo_except;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
-	struct ath12k_base *partner_ab;
 	struct ath12k_pdev_dp *dp_pdev;
 	u8 hw_link_id, device_id;
 	u32 desc_bank, num_msdus;
@@ -1395,7 +1394,7 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 
 	reo_except = &dp->reo_except_ring;
 
-	srng = &ab->hal.srng_list[reo_except->ring_id];
+	srng = &hal->srng_list[reo_except->ring_id];
 
 	spin_lock_bh(&srng->lock);
 
@@ -1406,7 +1405,7 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 		drop = false;
 		dp->device_stats.err_ring_pkts++;
 
-		ret = ath12k_wifi7_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
+		ret = ath12k_wifi7_hal_desc_reo_parse_err(dp, reo_desc, &paddr,
 							  &desc_bank);
 		if (ret) {
 			ath12k_warn(ab, "failed to parse error reo desc %d\n",
@@ -1418,9 +1417,8 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
 		device_id = hw_links[hw_link_id].device_id;
 		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
-		partner_ab = partner_dp->ab;
 
-		pdev_idx = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
+		pdev_idx = ath12k_hw_mac_id_to_pdev_id(partner_dp->hw_params,
 						       hw_links[hw_link_id].pdev_idx);
 
 		link_desc_banks = partner_dp->link_desc_banks;
@@ -1430,11 +1428,11 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 						       msdu_cookies, &rbm);
 		if (rbm != partner_dp->idle_link_rbm &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
-		    rbm != partner_ab->hal.hal_params->rx_buf_rbm) {
+		    rbm != partner_dp->hal->hal_params->rx_buf_rbm) {
 			act = HAL_WBM_REL_BM_ACT_REL_MSDU;
 			dp->device_stats.invalid_rbm++;
 			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
-			ath12k_wifi7_dp_rx_link_desc_return(partner_ab,
+			ath12k_wifi7_dp_rx_link_desc_return(partner_dp,
 							    &reo_desc->buf_addr_info,
 							    act);
 			continue;
@@ -1449,12 +1447,12 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 		 * partner device buffers.
 		 */
 		if (!is_frag || num_msdus > 1 ||
-		    partner_ab->device_id != ab->device_id) {
+		    partner_dp->device_id != dp->device_id) {
 			drop = true;
 			act = HAL_WBM_REL_BM_ACT_PUT_IN_IDLE;
 
 			/* Return the link desc back to wbm idle list */
-			ath12k_wifi7_dp_rx_link_desc_return(partner_ab,
+			ath12k_wifi7_dp_rx_link_desc_return(partner_dp,
 							    &reo_desc->buf_addr_info,
 							    act);
 		}
@@ -1499,10 +1497,9 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 			continue;
 
 		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
-		partner_ab = partner_dp->ab;
 		rx_ring = &partner_dp->rx_refill_buf_ring;
 
-		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
+		ath12k_dp_rx_bufs_replenish(partner_dp, rx_ring,
 					    &rx_desc_used_list[device_id],
 					    num_buffs_reaped[device_id]);
 	}
@@ -1717,7 +1714,7 @@ static void ath12k_wifi7_dp_rx_wbm_err(struct ath12k_pdev_dp *dp_pdev,
 	rx_info.addr2_present = false;
 	rx_info.rx_status = &rxs;
 
-	ath12k_wifi7_dp_extract_rx_desc_data(dp->ab, &rx_info, rx_desc, rx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(dp->hal, &rx_info, rx_desc, rx_desc);
 
 	switch (rxcb->err_rel_src) {
 	case HAL_WBM_REL_SRC_MODULE_REO:
@@ -1771,13 +1768,14 @@ void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
 	cmd->addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 }
 
-int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
+int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_dp *dp,
 				       struct napi_struct *napi, int budget)
 {
 	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
+	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	struct ath12k *ar;
 	struct ath12k_pdev_dp *dp_pdev;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_hw_group *ag = dp->ag;
 	struct ath12k_dp_hw_group *dp_hw_grp = &ag->dp_hw_grp;
 	struct ath12k_dp *partner_dp;
@@ -1803,7 +1801,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
 		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
 
-	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
+	srng = &hal->srng_list[dp->rx_rel_ring.ring_id];
 	spin_lock_bh(&srng->lock);
 
 	ath12k_hal_srng_access_begin(ab, srng);
@@ -1813,11 +1811,10 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		if (!rx_desc)
 			break;
 
-		ret = ath12k_wifi7_hal_wbm_desc_parse_err(ab, rx_desc,
+		ret = ath12k_wifi7_hal_wbm_desc_parse_err(dp, rx_desc,
 							  &err_info);
 		if (ret) {
-			ath12k_warn(ab,
-				    "failed to parse rx error in wbm_rel ring desc %d\n",
+			ath12k_warn(ab, "failed to parse rx error in wbm_rel ring desc %d\n",
 				    ret);
 			continue;
 		}
@@ -1826,7 +1823,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 
 		/* retry manual desc retrieval if hw cc is not done */
 		if (!desc_info) {
-			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
+			desc_info = ath12k_dp_get_rx_desc(dp, err_info.cookie);
 			if (!desc_info) {
 				ath12k_warn(ab, "Invalid cookie in DP WBM rx error descriptor retrieval: 0x%x\n",
 					    err_info.cookie);
@@ -1886,7 +1883,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		hw_link_id = ath12k_dp_rx_get_msdu_src_link(partner_dp->ab,
+		hw_link_id = ath12k_dp_rx_get_msdu_src_link(partner_dp->hal,
 							    msdu_data);
 		if (hw_link_id >= ATH12K_GROUP_MAX_RADIO) {
 			dev_kfree_skb_any(msdu);
@@ -1934,7 +1931,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		partner_dp = ath12k_dp_hw_grp_to_dp(dp_hw_grp, device_id);
 		rx_ring = &partner_dp->rx_refill_buf_ring;
 
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring,
+		ath12k_dp_rx_bufs_replenish(dp, rx_ring,
 					    &rx_desc_used_list[device_id],
 					    num_buffs_reaped[device_id]);
 	}
@@ -1975,7 +1972,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		}
 
 		if (rxcb->err_rel_src < HAL_WBM_REL_SRC_MODULE_MAX) {
-			device_id = ar->ab->device_id;
+			device_id = dp_pdev->dp->device_id;
 			device_stats->rx_wbm_rel_source[rxcb->err_rel_src][device_id]++;
 		}
 
@@ -2065,9 +2062,10 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	return ret;
 }
 
-void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_base *ab)
+void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_dp *dp)
 {
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_base *ab = dp->ab;
+	struct ath12k_hal *hal = dp->hal;
 	struct hal_tlv_64_hdr *hdr;
 	struct hal_srng *srng;
 	struct ath12k_dp_rx_reo_cmd *cmd, *tmp;
@@ -2075,7 +2073,7 @@ void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_base *ab)
 	u16 tag;
 	struct hal_reo_status reo_status;
 
-	srng = &ab->hal.srng_list[dp->reo_status_ring.ring_id];
+	srng = &hal->srng_list[dp->reo_status_ring.ring_id];
 
 	memset(&reo_status, 0, sizeof(reo_status));
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 85677258b1df..b92f9cf173dc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -12,14 +12,14 @@
 
 struct ath12k_hal_reo_cmd;
 
-int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
+int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_dp *dp,
 				       struct napi_struct *napi, int budget);
-int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
+int ath12k_wifi7_dp_rx_process_err(struct ath12k_dp *dp, struct napi_struct *napi,
 				   int budget);
-int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int mac_id,
+int ath12k_wifi7_dp_rx_process(struct ath12k_dp *dp, int mac_id,
 			       struct napi_struct *napi,
 			       int budget);
-void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_base *ab);
+void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_dp *dp);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
@@ -28,7 +28,7 @@ void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
 int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_dp_peer *dp_peer,
 				   struct ath12k_dp_rx_tid *rx_tid,
 				   u16 ssn, enum hal_pn_type pn_type);
-int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
+int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_dp *dp,
 					struct ath12k_buffer_addr *buf_addr_info,
 					enum hal_wbm_rel_bm_act action);
 void ath12k_wifi7_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
@@ -50,11 +50,11 @@ int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k_dp *dp,
 					u32 ba_win_sz, u16 ssn,
 					bool update_ssn);
 static inline
-void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_base *ab,
+void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_hal *hal,
 					  struct hal_rx_desc_data *rx_info,
 					  struct hal_rx_desc *rx_desc,
 					  struct hal_rx_desc *ldesc)
 {
-	ab->hal.ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
+	hal->ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
 }
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index bb8c2384c13e..629084aa36d8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -63,6 +63,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 		       bool is_mcast)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_hal *hal = dp->hal;
 	struct ath12k_base *ab = dp->ab;
 	struct hal_tx_info ti = {};
 	struct ath12k_tx_desc_info *tx_desc;
@@ -84,7 +85,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	bool tcl_ring_retry;
 	bool msdu_ext_desc = false;
 	bool add_htt_metadata = false;
-	u32 iova_mask = ab->hw_params->iova_mask;
+	u32 iova_mask = dp->hw_params->iova_mask;
 	bool is_diff_encap = false;
 	bool is_null_frame = false;
 
@@ -104,14 +105,14 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	 * If all rings are full, we drop the packet.
 	 * TODO: Add throttling logic when all rings are full
 	 */
-	ring_selector = ab->hw_params->hw_ops->get_ring_selector(skb);
+	ring_selector = dp->hw_params->hw_ops->get_ring_selector(skb);
 
 tcl_ring_sel:
 	tcl_ring_retry = false;
-	ti.ring_id = ring_selector % ab->hw_params->max_tx_ring;
+	ti.ring_id = ring_selector % dp->hw_params->max_tx_ring;
 
 	ring_map |= BIT(ti.ring_id);
-	ti.rbm_id = ab->hal.tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
+	ti.rbm_id = hal->tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
 
 	tx_ring = &dp->tx_ring[ti.ring_id];
 
@@ -212,7 +213,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 
 	if (iova_mask &&
 	    (unsigned long)skb->data & iova_mask) {
-		ret = ath12k_dp_tx_align_payload(ab, &skb);
+		ret = ath12k_dp_tx_align_payload(dp, &skb);
 		if (ret) {
 			ath12k_warn(ab, "failed to align TX buffer %d\n", ret);
 			/* don't bail out, give original buffer
@@ -227,8 +228,8 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 		hdr = (void *)skb->data;
 	}
 map:
-	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
-	if (dma_mapping_error(ab->dev, ti.paddr)) {
+	ti.paddr = dma_map_single(dp->dev, skb->data, skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dp->dev, ti.paddr)) {
 		atomic_inc(&dp->device_stats.tx_err.misc_fail);
 		ath12k_warn(ab, "failed to DMA map data Tx buffer\n");
 		ret = -ENOMEM;
@@ -286,9 +287,9 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 			}
 		}
 
-		ti.paddr = dma_map_single(ab->dev, skb_ext_desc->data,
+		ti.paddr = dma_map_single(dp->dev, skb_ext_desc->data,
 					  skb_ext_desc->len, DMA_TO_DEVICE);
-		ret = dma_mapping_error(ab->dev, ti.paddr);
+		ret = dma_mapping_error(dp->dev, ti.paddr);
 		if (ret)
 			goto fail_free_ext_skb;
 
@@ -300,7 +301,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	}
 
 	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
-	tcl_ring = &ab->hal.srng_list[hal_ring_id];
+	tcl_ring = &hal->srng_list[hal_ring_id];
 
 	spin_lock_bh(&tcl_ring->lock);
 
@@ -321,8 +322,8 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.
 		 */
-		if (ring_map != (BIT(ab->hw_params->max_tx_ring) - 1) &&
-		    ab->hw_params->tcl_ring_retry) {
+		if (ring_map != (BIT(dp->hw_params->max_tx_ring) - 1) &&
+		    dp->hw_params->tcl_ring_retry) {
 			tcl_ring_retry = true;
 			ring_selector++;
 		}
@@ -358,14 +359,14 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 
 fail_unmap_dma_ext:
 	if (skb_cb->paddr_ext_desc)
-		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+		dma_unmap_single(dp->dev, skb_cb->paddr_ext_desc,
 				 skb_ext_desc->len,
 				 DMA_TO_DEVICE);
 fail_free_ext_skb:
 	kfree_skb(skb_ext_desc);
 
 fail_unmap_dma:
-	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
+	dma_unmap_single(dp->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
 
 fail_remove_tx_buf:
 	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
@@ -381,37 +382,45 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 }
 
 static void
-ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
+ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_dp *dp,
 				 struct ath12k_tx_desc_params *desc_params,
 				 struct dp_tx_ring *tx_ring,
 				 struct ath12k_dp_htt_wbm_tx_status *ts,
 				 u16 peer_id)
 {
+	struct ath12k_base *ab = dp->ab;
 	struct ieee80211_tx_info *info;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_skb_cb *skb_cb;
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
-	struct ath12k *ar;
 	struct sk_buff *msdu = desc_params->skb;
 	s32 noise_floor;
 	struct ieee80211_tx_status status = {};
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_pdev_dp *dp_pdev;
+	u8 pdev_id;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
 
-	ar = skb_cb->ar;
-	dp_pdev = &ar->dp;
-	ab->dp->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
+	pdev_id = ath12k_hw_mac_id_to_pdev_id(dp->hw_params, desc_params->mac_id);
 
-	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
-		wake_up(&ar->dp.tx_empty_waitq);
+	rcu_read_lock();
+	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_id);
+	if (!dp_pdev) {
+		rcu_read_unlock();
+		return;
+	}
 
-	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+	dp->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
+
+	if (atomic_dec_and_test(&dp_pdev->num_tx_pending))
+		wake_up(&dp_pdev->tx_empty_waitq);
+
+	dma_unmap_single(dp->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
-		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+		dma_unmap_single(dp->dev, skb_cb->paddr_ext_desc,
 				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
@@ -419,14 +428,12 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	vif = skb_cb->vif;
 	if (vif) {
 		ahvif = ath12k_vif_to_ahvif(vif);
-		rcu_read_lock();
 		arvif = rcu_dereference(ahvif->link[skb_cb->link_id]);
 		if (arvif) {
 			spin_lock_bh(&arvif->link_stats_lock);
 			arvif->link_stats.tx_completed++;
 			spin_unlock_bh(&arvif->link_stats_lock);
 		}
-		rcu_read_unlock();
 	}
 
 	memset(&info->status, 0, sizeof(info->status));
@@ -438,6 +445,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 
 			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 				      ab->wmi_ab.svc_map)) {
+				struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+
 				spin_lock_bh(&ar->data_lock);
 				noise_floor = ath12k_pdev_get_noise_floor(ar);
 				spin_unlock_bh(&ar->data_lock);
@@ -450,12 +459,12 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 		}
 	}
-	rcu_read_lock();
+
 	peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DATA,
 			   "dp_tx: failed to find the peer with peer_id %d\n", peer_id);
-		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
+		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	} else {
 		status.sta = peer->sta;
@@ -463,20 +472,19 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 
 	status.info = info;
 	status.skb = msdu;
-	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
+	ieee80211_tx_status_ext(ath12k_pdev_dp_to_hw(dp_pdev), &status);
 exit:
 	rcu_read_unlock();
 }
 
 static void
-ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
+ath12k_dp_tx_process_htt_tx_complete(struct ath12k_dp *dp, void *desc,
 				     struct dp_tx_ring *tx_ring,
 				     struct ath12k_tx_desc_params *desc_params)
 {
 	struct htt_tx_wbm_completion *status_desc;
 	struct ath12k_dp_htt_wbm_tx_status ts = {};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u16 peer_id;
 
 	status_desc = desc;
@@ -494,14 +502,14 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 		peer_id = le32_get_bits(((struct hal_wbm_completion_ring_tx *)desc)->
 				info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
 
-		ath12k_dp_tx_htt_tx_complete_buf(ab, desc_params, tx_ring, &ts, peer_id);
+		ath12k_dp_tx_htt_tx_complete_buf(dp, desc_params, tx_ring, &ts, peer_id);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH:
-		ath12k_dp_tx_free_txbuf(ab, tx_ring, desc_params);
+		ath12k_dp_tx_free_txbuf(dp, tx_ring, desc_params);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
 		/* This event is to be handled only when the driver decides to
@@ -509,7 +517,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 		 */
 		break;
 	default:
-		ath12k_warn(ab, "Unknown htt wbm tx status %d\n", wbm_status);
+		ath12k_warn(dp->ab, "Unknown htt wbm tx status %d\n", wbm_status);
 		break;
 	}
 }
@@ -519,7 +527,6 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_dp_link_peer *peer;
-	struct ath12k_base *ab = dp->ab;
 	struct ath12k_link_sta *arsta;
 	struct rate_info txrate = {};
 	struct ieee80211_sta *sta;
@@ -530,7 +537,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 
 	peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, ts->peer_id);
 	if (!peer || !peer->sta) {
-		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
+		ath12k_dbg(dp->ab, ATH12K_DBG_DP_TX,
 			   "failed to find the peer by id %u\n", ts->peer_id);
 		return;
 	}
@@ -559,7 +566,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 							    &rate_idx,
 							    &rate);
 		if (ret < 0) {
-			ath12k_warn(ab, "Invalid tx legacy rate %d\n", ret);
+			ath12k_warn(dp->ab, "Invalid tx legacy rate %d\n", ret);
 			return;
 		}
 
@@ -567,7 +574,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 		break;
 	case HAL_TX_RATE_STATS_PKT_TYPE_11N:
 		if (ts->mcs > ATH12K_HT_MCS_MAX) {
-			ath12k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
+			ath12k_warn(dp->ab, "Invalid HT mcs index %d\n", ts->mcs);
 			return;
 		}
 
@@ -581,7 +588,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 		break;
 	case HAL_TX_RATE_STATS_PKT_TYPE_11AC:
 		if (ts->mcs > ATH12K_VHT_MCS_MAX) {
-			ath12k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
+			ath12k_warn(dp->ab, "Invalid VHT mcs index %d\n", ts->mcs);
 			return;
 		}
 
@@ -593,7 +600,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 		break;
 	case HAL_TX_RATE_STATS_PKT_TYPE_11AX:
 		if (ts->mcs > ATH12K_HE_MCS_MAX) {
-			ath12k_warn(ab, "Invalid HE mcs index %d\n", ts->mcs);
+			ath12k_warn(dp->ab, "Invalid HE mcs index %d\n", ts->mcs);
 			return;
 		}
 
@@ -603,7 +610,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 		break;
 	case HAL_TX_RATE_STATS_PKT_TYPE_11BE:
 		if (ts->mcs > ATH12K_EHT_MCS_MAX) {
-			ath12k_warn(ab, "Invalid EHT mcs index %d\n", ts->mcs);
+			ath12k_warn(dp->ab, "Invalid EHT mcs index %d\n", ts->mcs);
 			return;
 		}
 
@@ -612,7 +619,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 		txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(ts->sgi);
 		break;
 	default:
-		ath12k_warn(ab, "Invalid tx pkt type: %d\n", ts->pkt_type);
+		ath12k_warn(dp->ab, "Invalid tx pkt type: %d\n", ts->pkt_type);
 		return;
 	}
 
@@ -663,9 +670,9 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 	skb_cb = ATH12K_SKB_CB(msdu);
 	dp->device_stats.tx_completed[ring]++;
 
-	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+	dma_unmap_single(dp->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
-		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+		dma_unmap_single(dp->dev, skb_cb->paddr_ext_desc,
 				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
@@ -773,7 +780,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 }
 
 static void
-ath12k_wifi7_dp_tx_status_parse(struct ath12k_base *ab,
+ath12k_wifi7_dp_tx_status_parse(struct ath12k_dp *dp,
 				struct hal_wbm_completion_ring_tx *desc,
 				struct hal_tx_status *ts)
 {
@@ -809,12 +816,12 @@ ath12k_wifi7_dp_tx_status_parse(struct ath12k_base *ab,
 	}
 }
 
-void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
+void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_dp *dp, int ring_id)
 {
+	struct ath12k_base *ab = dp->ab;
 	struct ath12k_pdev_dp *dp_pdev;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
-	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
+	struct hal_srng *status_ring = &dp->hal->srng_list[hal_ring_id];
 	struct ath12k_tx_desc_info *tx_desc = NULL;
 	struct hal_tx_status ts = {};
 	struct ath12k_tx_desc_params desc_params;
@@ -860,7 +867,7 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		tx_ring->tx_status_tail =
 			ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_tail);
 		tx_status = &tx_ring->tx_status[tx_ring->tx_status_tail];
-		ath12k_wifi7_dp_tx_status_parse(ab, tx_status, &ts);
+		ath12k_wifi7_dp_tx_status_parse(dp, tx_status, &ts);
 
 		if (le32_get_bits(tx_status->info0, HAL_WBM_COMPL_TX_INFO0_CC_DONE)) {
 			/* HW done cookie conversion */
@@ -872,7 +879,7 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 			desc_id = le32_get_bits(tx_status->buf_va_hi,
 						BUFFER_ADDR_INFO1_SW_COOKIE);
 
-			tx_desc = ath12k_dp_get_tx_desc(ab, desc_id);
+			tx_desc = ath12k_dp_get_tx_desc(dp, desc_id);
 		}
 		if (!tx_desc) {
 			ath12k_warn(ab, "unable to retrieve tx_desc!");
@@ -897,12 +904,12 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		 */
 		ath12k_dp_tx_release_txbuf(dp, tx_desc, tx_desc->pool_id);
 		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
-			ath12k_dp_tx_process_htt_tx_complete(ab, (void *)tx_status,
+			ath12k_dp_tx_process_htt_tx_complete(dp, (void *)tx_status,
 							     tx_ring, &desc_params);
 			continue;
 		}
 
-		pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params.mac_id);
+		pdev_idx = ath12k_hw_mac_id_to_pdev_id(dp->hw_params, desc_params.mac_id);
 
 		rcu_read_lock();
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
index 94a5c59289cc..24cf7972d41b 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
@@ -10,7 +10,7 @@
 int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *arvif,
 		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
 		       bool is_mcast);
-void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
+void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_dp *dp, int ring_id);
 u32 ath12k_wifi7_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
 					    struct ath12k_link_vif *arvif);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index b137967eba65..9ae6f52249d9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -320,13 +320,13 @@ ath12k_wifi7_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link,
 	}
 }
 
-int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_base *ab,
+int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_dp *dp,
 					struct hal_reo_dest_ring *desc,
 					dma_addr_t *paddr, u32 *desc_bank)
 {
+	struct ath12k_base *ab = dp->ab;
 	enum hal_reo_dest_ring_push_reason push_reason;
 	enum hal_reo_dest_ring_error_code err_code;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u32 cookie, val;
 
 	push_reason = le32_get_bits(desc->info0,
@@ -348,19 +348,18 @@ int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_base *ab,
 		return -EINVAL;
 	}
 
-	ath12k_wifi7_hal_rx_reo_ent_paddr_get(ab, &desc->buf_addr_info, paddr,
+	ath12k_wifi7_hal_rx_reo_ent_paddr_get(&desc->buf_addr_info, paddr,
 					      &cookie);
 	*desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
 
 	return 0;
 }
 
-int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
+int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_dp *dp, void *desc,
 					struct hal_rx_wbm_rel_info *rel_info)
 {
 	struct hal_wbm_release_ring *wbm_desc = desc;
 	struct hal_wbm_release_ring_cc_rx *wbm_cc_desc = desc;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	enum hal_wbm_rel_desc_type type;
 	enum hal_wbm_rel_src_module rel_src;
 	bool hw_cc_done;
@@ -446,8 +445,7 @@ int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 	return 0;
 }
 
-void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
-					   struct ath12k_buffer_addr *buff_addr,
+void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_buffer_addr *buff_addr,
 					   dma_addr_t *paddr, u32 *cookie)
 {
 	*paddr = ((u64)(le32_get_bits(buff_addr->info1,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index cdc9bb6db93c..2715b7d52cfc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -858,13 +858,12 @@ void ath12k_wifi7_hal_rx_buf_addr_info_set(struct ath12k_buffer_addr *binfo,
 void ath12k_wifi7_hal_rx_buf_addr_info_get(struct ath12k_buffer_addr *binfo,
 					   dma_addr_t *paddr,
 					   u32 *cookie, u8 *rbm);
-int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_base *ab,
+int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_dp *dp,
 					struct hal_reo_dest_ring *desc,
 					dma_addr_t *paddr, u32 *desc_bank);
-int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
+int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_dp *dp, void *desc,
 					struct hal_rx_wbm_rel_info *rel_info);
-void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
-					   struct ath12k_buffer_addr *buff_addr,
+void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_buffer_addr *buff_addr,
 					   dma_addr_t *paddr, u32 *cookie);
 void ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
 					       u32 *sw_cookie,
-- 
2.34.1


