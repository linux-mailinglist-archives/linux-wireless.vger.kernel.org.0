Return-Path: <linux-wireless+bounces-28502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C2C2B4AD
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEEF18940A1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E230214D;
	Mon,  3 Nov 2025 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PTlW9s+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435B30148C
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168918; cv=none; b=iSCfHLDmfzcw8BklSmDsPjjOPNlX4i1TMpahqOrrhkd87kXe5C+ppRLgGrL+p96vvljQ8Ujophacj2XekHBpTJFGJJcyCT162UBgz0W5fXLRua5PrUyjqJjpIlFRBe1GpEEDyWIj1Y+/UcTzCfjbUSMs6FAthLy7jd+dFELvC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168918; c=relaxed/simple;
	bh=7M852KgxVXXZ19b3P/EHucF/kS3piMPadP6k8H9AiPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2vqm6IkIfvadNTUlNCXhdNna/lhY9WIxfI7xW6CVW0V6gBDJRF3Ei5Ii/Byh9rlT3+bFYFYhopYcVfflcpSalKKcPdE0Y8rUBbxrZpyrkQfONfMQp97KSbV1tke4m9wCilRiSMqqmW2f0mSleKTaF2aXdOtkIfp1jG8CshQyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PTlW9s+p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38oaXe2730166;
	Mon, 3 Nov 2025 11:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rlmh9wQswCbWmedKJ3yvoiPGDKlZdl8mP9TGs42IBMU=; b=PTlW9s+phN3Szimg
	EksBZ73ql6EcxUTMahdRFeh1PdbeAhIEiYtTEmsLCHoPR7di0Q1WTxOJgRjPU75Y
	F5pDMorSwWqEaeXN22Xv9E1IuU57/BqYRj+LoGgol5nYL9zhMpgOVwG7vWmZ0+rS
	qxxVnYBeazDcUoDkRg0JAo7asGJhMJk4bpbB0+sW45JqUez59hDgpbwrm/FOEUE8
	LnumkcDyLaPPTuLwf0RgpXOJZ7ahEkecrE3hG/s4uxg/xItKxrPY+hoXt6ysHhjV
	OHojE3C1DtxP4raL2uZWj77+GQ1OPJH7yG4KlE7arHXm3Uihg0c0vQ/XkH5KF5sd
	bBg1kQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6s86ge35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLqUt031000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:52 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:50 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 10/12] wifi: ath12k: Build all the files in wifi7 directory into ath12k_wifi7.ko
Date: Mon, 3 Nov 2025 16:51:09 +0530
Message-ID: <20251103112111.2260639-11-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNCBTYWx0ZWRfX52TfwE8gFzeM
 5igvH1EoI4sFMwE06n1eiGYsVhoqYdLXSsWvtZHhWAEp2hRBESapiWx0/hluL3bn7mc0HLc2pIT
 Z42sjpfBSlTTig2ZM0XryXjPzpgDLM1PrZtHVQzmq0DvqmBxAHIBlzF62DOTfDxyMVZ+1+TORIM
 QlI4toY2tPMq7BHCRQVX1eljYoX7E/KDtSOOe1XiJA1/n2q8T4iBm64rqvPzFXdwK3J4w31k3wX
 nl7DZxif+3DzpBpXyb9iM8W/kR64mtjfZ970wDdpTeRykLDdoMdnTyP1WQkkLjqAdJ21JFiWIrx
 ONIGL0Q7hcNrr4EMwR5f5m01L1RRG/gOpIZeuUcHj0YPVxNwirdDMJEI43BCeuV+2Doii6/6HxI
 yWHYkjFKT8rAmFKlgLB/SbVmxxE3Hg==
X-Authority-Analysis: v=2.4 cv=Tq/rRTXh c=1 sm=1 tr=0 ts=69089051 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=CCRrIDIhvsUG8RHOlFMA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: iUbsNIaZSM6jv6cRpVNvuJ0E0XBn1UDI
X-Proofpoint-ORIG-GUID: iUbsNIaZSM6jv6cRpVNvuJ0E0XBn1UDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030104

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move files built as part of ath12k.ko from wifi7 directory to ath12k_wifi7.ko.
Export necessary symbols from ath12k.ko and remove redundant exports from
the wifi7 directory, as they are no longer needed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile            |  9 ---------
 drivers/net/wireless/ath/ath12k/core.c              |  1 +
 drivers/net/wireless/ath/ath12k/debug.c             |  1 +
 drivers/net/wireless/ath/ath12k/dp.c                |  2 ++
 drivers/net/wireless/ath/ath12k/dp_htt.c            |  1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c            |  1 +
 drivers/net/wireless/ath/ath12k/dp_peer.c           |  2 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c             | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/dp_tx.c             |  9 +++++++++
 drivers/net/wireless/ath/ath12k/hal.c               |  8 ++++++++
 drivers/net/wireless/ath/ath12k/mac.c               |  5 +++++
 drivers/net/wireless/ath/ath12k/wifi7/Makefile      | 10 +++++++++-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c          |  2 --
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c       |  2 --
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c       |  1 -
 drivers/net/wireless/ath/ath12k/wifi7/hal.c         |  1 -
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c |  1 -
 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c |  1 -
 18 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index d397bc494cf2..3ba1236956cc 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -24,15 +24,6 @@ ath12k-y += core.o \
 
 ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
 
-ath12k-y += wifi7/hal_tx.o \
-	    wifi7/hal_rx.o \
-	    wifi7/dp_rx.o \
-	    wifi7/dp_tx.o \
-	    wifi7/dp.o \
-	    wifi7/hal.o \
-	    wifi7/hal_qcn9274.o \
-	    wifi7/hal_wcn7850.o
-
 obj-$(CONFIG_ATH12K) += wifi7/
 
 ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 912832b6004c..34d9e3b68d2f 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -32,6 +32,7 @@ EXPORT_SYMBOL(ath12k_debug_mask);
 bool ath12k_ftm_mode;
 module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
 MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
+EXPORT_SYMBOL(ath12k_ftm_mode);
 
 /* protected with ath12k_hw_group_mutex */
 static struct list_head ath12k_hw_group_list = LIST_HEAD_INIT(ath12k_hw_group_list);
diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index 5fe9b2fbf509..34b3b2c920dc 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -105,5 +105,6 @@ void ath12k_dbg_dump(struct ath12k_base *ab,
 		}
 	}
 }
+EXPORT_SYMBOL(ath12k_dbg_dump);
 
 #endif /* CONFIG_ATH12K_DEBUG */
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index b65f421d5b83..647c2fa7ea1b 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1181,6 +1181,7 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 
 	return *desc_addr_ptr;
 }
+EXPORT_SYMBOL(ath12k_dp_get_rx_desc);
 
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 cookie)
@@ -1204,6 +1205,7 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 
 	return *desc_addr_ptr;
 }
+EXPORT_SYMBOL(ath12k_dp_get_tx_desc);
 
 static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 39f42cd99835..cc71c5c5de5a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -1077,6 +1077,7 @@ int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_dp_tx_htt_rx_filter_setup);
 
 int
 ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 04473b04a7b6..3b73b5501898 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -4437,3 +4437,4 @@ int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 
 	return num_buffs_reaped;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_process_ring);
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 0ad01f7414cd..2e66872b5572 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -426,6 +426,7 @@ struct ath12k_dp_peer *ath12k_dp_peer_find_by_peerid(struct ath12k_pdev_dp *dp_p
 
 	return rcu_dereference(dp_pdev->dp_hw->dp_peers[index]);
 }
+EXPORT_SYMBOL(ath12k_dp_peer_find_by_peerid);
 
 struct ath12k_dp_link_peer *
 ath12k_dp_link_peer_find_by_peerid(struct ath12k_pdev_dp *dp_pdev, u16 peer_id)
@@ -447,6 +448,7 @@ ath12k_dp_link_peer_find_by_peerid(struct ath12k_pdev_dp *dp_pdev, u16 peer_id)
 
 	return rcu_dereference(dp_peer->link_peers[link_id]);
 }
+EXPORT_SYMBOL(ath12k_dp_link_peer_find_by_peerid);
 
 int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
 			  struct ath12k_dp_peer_create_params *params)
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 763d8cff0529..ff9335955682 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -163,6 +163,7 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 
 	return req_entries - num_remain;
 }
+EXPORT_SYMBOL(ath12k_dp_rx_bufs_replenish);
 
 static int ath12k_dp_rxdma_mon_buf_ring_free(struct ath12k_base *ab,
 					     struct dp_rxdma_mon_ring *rx_ring)
@@ -382,6 +383,7 @@ void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
 	kfree(rx_tid->qbuf.vaddr);
 	rx_tid->qbuf.vaddr = NULL;
 }
+EXPORT_SYMBOL(ath12k_dp_reo_cmd_free);
 
 void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 			       enum hal_reo_cmd_status status)
@@ -444,6 +446,7 @@ void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 	kfree(rx_tid->qbuf.vaddr);
 	rx_tid->qbuf.vaddr = NULL;
 }
+EXPORT_SYMBOL(ath12k_dp_rx_tid_del_func);
 
 void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_dp_link_peer *peer)
 {
@@ -709,6 +712,7 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_dp_rx_get_msdu_last_buf);
 
 struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
 					       struct sk_buff *first)
@@ -1024,6 +1028,7 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 		break;
 	}
 }
+EXPORT_SYMBOL(ath12k_dp_rx_h_undecap);
 
 struct ath12k_dp_link_peer *
 ath12k_dp_rx_h_find_link_peer(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
@@ -1176,6 +1181,7 @@ void ath12k_dp_rx_h_ppdu(struct ath12k_pdev_dp *dp_pdev,
 
 	ath12k_dp_rx_h_rate(dp_pdev, rx_info);
 }
+EXPORT_SYMBOL(ath12k_dp_rx_h_ppdu);
 
 void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struct *napi,
 			       struct sk_buff *msdu,
@@ -1246,6 +1252,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 
 	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
 }
+EXPORT_SYMBOL(ath12k_dp_rx_deliver_msdu);
 
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
 					    struct hal_rx_desc *rx_desc,
@@ -1268,6 +1275,7 @@ bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
 	WARN_ON_ONCE(1);
 	return false;
 }
+EXPORT_SYMBOL(ath12k_dp_rx_check_nwifi_hdr_len_valid);
 
 static void ath12k_dp_rx_frag_timer(struct timer_list *timer)
 {
@@ -1367,6 +1375,7 @@ int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
 	shash_desc_zero(desc);
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_dp_rx_h_michael_mic);
 
 void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 				 enum hal_encrypt_type enctype, u32 flags)
@@ -1399,6 +1408,7 @@ void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff
 		skb_pull(msdu, crypto_len);
 	}
 }
+EXPORT_SYMBOL(ath12k_dp_rx_h_undecap_frag);
 
 static int ath12k_dp_rx_h_cmp_frags(struct ath12k_base *ab,
 				    struct sk_buff *a, struct sk_buff *b)
@@ -1427,6 +1437,7 @@ void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
 	}
 	__skb_queue_tail(frag_list, cur_frag);
 }
+EXPORT_SYMBOL(ath12k_dp_rx_h_sort_frags);
 
 u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb)
 {
@@ -1447,6 +1458,7 @@ u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb)
 
 	return pn;
 }
+EXPORT_SYMBOL(ath12k_dp_rx_h_get_pn);
 
 void ath12k_dp_rx_free(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 8d5e10781377..bcae34f5db7d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -25,6 +25,7 @@ ath12k_dp_tx_get_encap_type(struct ath12k_base *ab, struct sk_buff *skb)
 
 	return HAL_TCL_ENCAP_TYPE_NATIVE_WIFI;
 }
+EXPORT_SYMBOL(ath12k_dp_tx_get_encap_type);
 
 void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb)
 {
@@ -42,6 +43,7 @@ void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb)
 	hdr = (void *)skb->data;
 	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
 }
+EXPORT_SYMBOL(ath12k_dp_tx_encap_nwifi);
 
 u8 ath12k_dp_tx_get_tid(struct sk_buff *skb)
 {
@@ -55,6 +57,7 @@ u8 ath12k_dp_tx_get_tid(struct sk_buff *skb)
 	else
 		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 }
+EXPORT_SYMBOL(ath12k_dp_tx_get_tid);
 
 enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher)
 {
@@ -77,6 +80,7 @@ enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher)
 		return HAL_ENCRYPT_TYPE_OPEN;
 	}
 }
+EXPORT_SYMBOL(ath12k_dp_tx_get_encrypt_type);
 
 void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
 				struct ath12k_tx_desc_info *tx_desc,
@@ -87,6 +91,7 @@ void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
 	list_move_tail(&tx_desc->list, &dp->tx_desc_free_list[pool_id]);
 	spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
 }
+EXPORT_SYMBOL(ath12k_dp_tx_release_txbuf);
 
 struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
 						       u8 pool_id)
@@ -108,6 +113,7 @@ struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
 
 	return desc;
 }
+EXPORT_SYMBOL(ath12k_dp_tx_assign_buffer);
 
 void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len)
 {
@@ -121,6 +127,7 @@ void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len)
 	memset(metadata, 0, tail_len);
 	return metadata;
 }
+EXPORT_SYMBOL(ath12k_dp_metadata_align_skb);
 
 static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
 				      unsigned long delta,
@@ -175,6 +182,7 @@ int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 out:
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_dp_tx_align_payload);
 
 void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 			     struct dp_tx_ring *tx_ring,
@@ -200,3 +208,4 @@ void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
 }
+EXPORT_SYMBOL(ath12k_dp_tx_free_txbuf);
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 08063d1094ae..efa039f6df92 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -217,6 +217,7 @@ int ath12k_hal_srng_get_entrysize(struct ath12k_base *ab, u32 ring_type)
 
 	return (srng_config->entry_size << 2);
 }
+EXPORT_SYMBOL(ath12k_hal_srng_get_entrysize);
 
 int ath12k_hal_srng_get_max_entries(struct ath12k_base *ab, u32 ring_type)
 {
@@ -246,6 +247,7 @@ void ath12k_hal_srng_get_params(struct ath12k_base *ab, struct hal_srng *srng,
 	params->msi2_data = srng->msi2_data;
 	params->flags = srng->flags;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_get_params);
 
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng)
@@ -316,6 +318,7 @@ void *ath12k_hal_srng_dst_peek(struct ath12k_base *ab, struct hal_srng *srng)
 
 	return NULL;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_dst_peek);
 
 void *ath12k_hal_srng_dst_get_next_entry(struct ath12k_base *ab,
 					 struct hal_srng *srng)
@@ -334,6 +337,7 @@ void *ath12k_hal_srng_dst_get_next_entry(struct ath12k_base *ab,
 
 	return desc;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_dst_get_next_entry);
 
 int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 				 bool sync_hw_ptr)
@@ -356,6 +360,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	else
 		return (srng->ring_size - tp + hp) / srng->entry_size;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_dst_num_free);
 
 /* Returns number of available entries in src ring */
 int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
@@ -430,6 +435,7 @@ void *ath12k_hal_srng_src_get_next_entry(struct ath12k_base *ab,
 
 	return desc;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_src_get_next_entry);
 
 void *ath12k_hal_srng_src_peek(struct ath12k_base *ab, struct hal_srng *srng)
 {
@@ -500,6 +506,7 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 		}
 	}
 }
+EXPORT_SYMBOL(ath12k_hal_srng_access_begin);
 
 /* Update cached ring head/tail pointers to HW. ath12k_hal_srng_access_begin()
  * should have been called before this.
@@ -555,6 +562,7 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 
 	srng->timestamp = jiffies;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_access_end);
 
 int ath12k_hal_srng_setup(struct ath12k_base *ab, enum hal_ring_type type,
 			  int ring_num, int mac_id,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a079f80ef546..4647c555cb48 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -363,6 +363,7 @@ u16 ath12k_mac_he_convert_tones_to_ru_tones(u16 tones)
 		return RU_26;
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_he_convert_tones_to_ru_tones);
 
 enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi)
 {
@@ -377,6 +378,7 @@ enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi)
 		return NL80211_RATE_INFO_EHT_GI_0_8;
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_eht_gi_to_nl80211_eht_gi);
 
 enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones)
 {
@@ -417,6 +419,7 @@ enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru
 		return NL80211_RATE_INFO_EHT_RU_ALLOC_26;
 	}
 }
+EXPORT_SYMBOL(ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc);
 
 enum rate_info_bw
 ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw)
@@ -443,6 +446,7 @@ ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw)
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_mac_bw_to_mac80211_bw);
 
 enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw bw)
 {
@@ -486,6 +490,7 @@ int ath12k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL(ath12k_mac_hw_ratecode_to_legacy_rate);
 
 u8 ath12k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
 			     u32 bitrate)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/Makefile b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
index 872ca620a5c5..30258a1b313d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/Makefile
+++ b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
@@ -5,6 +5,14 @@ ath12k_wifi7-y += core.o \
 	          wmi.o \
 	          mhi.o \
 	          ce.o \
-	          hw.o
+	          hw.o \
+		  hal_tx.o \
+		  hal_rx.o \
+		  dp_rx.o \
+		  dp_tx.o \
+		  dp.o \
+		  hal.o \
+		  hal_qcn9274.o \
+		  hal_wcn7850.o
 
 ath12k_wifi7-$(CONFIG_ATH12K_AHB) += ahb.o
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index cf7ede27623a..433ffdb55264 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -170,10 +170,8 @@ struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 
 	return dp;
 }
-EXPORT_SYMBOL(ath12k_wifi7_dp_device_alloc);
 
 void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp)
 {
 	kfree(dp);
 }
-EXPORT_SYMBOL(ath12k_wifi7_dp_device_free);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 5eb62afde4a5..d2026082708e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -2022,7 +2022,6 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 
 	return ret;
 }
-EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_qcn9274);
 
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 {
@@ -2065,7 +2064,6 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 
 	return ret;
 }
-EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_wcn7850);
 
 void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 7e16bc12e36a..bb8c2384c13e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -379,7 +379,6 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 
 	return ret;
 }
-EXPORT_SYMBOL(ath12k_wifi7_dp_tx);
 
 static void
 ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index f48adb83599e..03a007dd6857 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -59,7 +59,6 @@ int ath12k_wifi7_hal_init(struct ath12k_base *ab)
 
 	return 0;
 }
-EXPORT_SYMBOL(ath12k_wifi7_hal_init);
 
 static unsigned int ath12k_wifi7_hal_reo1_ring_id_offset(struct ath12k_hal *hal)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index f13376b7faa1..4b6f43389b2d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1029,4 +1029,3 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 };
-EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index a73e7539a27a..f243bc3ab409 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -802,4 +802,3 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 };
-EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1


