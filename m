Return-Path: <linux-wireless+bounces-26171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCF5B1C4B8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F8C560D36
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D922FE06;
	Wed,  6 Aug 2025 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSye6P+V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E0273D60
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479088; cv=none; b=FCN6Z3Kdml39BwL59o5aXWSExPSpjzcTSH8oneIkUWBshsfeIsjQznKx5o/8S+/Ibcdy48PrRUal42xkK5koj76LF9iPP2JW52Wxu9spJZzCbBwKLPWzqitBDixnHUNwJenTSfytIhgVVheysj/9YcucLpvvOe10o6ZsD345u+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479088; c=relaxed/simple;
	bh=OW5fNeWtlCXfiZkUdIslwVD5w5PA/Y3HQYOh2W3tXmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NL4PQUtCCdZwZvGmafaXyxB1OV9BN//vNmyHUlcE0IqeFGZIFcoWdW45bw/wCkiQlTP1Jni1MyIEoSBCgeh0gJfPLWc9n06zMiUaHbpBW4Gh9KxdraXlp0ouPUsPsRULQqTOVF5UWEgEICF6ykqvabCe3ccPl1/Db/ZGSePe1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kSye6P+V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765fn9f031794
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=Ir92q7l0gK6rtjU+Ab2cFXyx0jStoBczysjE/OFO7w8=; b=kS
	ye6P+VyWfQw8H6ATHdRNrj+s4kJJLWDkH/zd5Fxyjl/EPETrZI+A15a2vWRqBSW6
	SW7uiY46O8M17XETfV+UldoEksvCv0vsBzEZW9RrjlpBTuYls/WvHINozlUIHLgo
	MuwXTVv6Zp14TOD7S6jHZ5ssb5PmNs6yWKp8yrbvQXbcK700g7HRSTLSkXILBnOy
	SrsJnwqVEc819pkbByXemvjkFf7TgT4MDa7BiFgCJHhRNfm9TFfs4cT/Z4SJ1xmF
	usJaoAncJzZ9s5Lx92c12i2zKLSJ7l4v5hz+Or2piVf/sXKB4LO+BG73g6I/vXQk
	tJC11MuN6dBOyG6yVVgg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybajc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:18:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76be7fe3d65so8891283b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479085; x=1755083885;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir92q7l0gK6rtjU+Ab2cFXyx0jStoBczysjE/OFO7w8=;
        b=mHbGb3XN30zzYwqTTo+LHdRPV5/C7x5YUzRuvUxm2LDCJCslg6gTY5/4N5D0AdmAdP
         EGOGA0OiLytxo0OHMVNa8i8n7a660nMpStSKcppBwot3jAvK4Zhi9BJirYTSUiPKIFhY
         G5q/K9Uve+Ch53f5MFilgJCiRZn2CaIYYtybHdGBoz7SmDTYF1vOw01y0FC/f1mrBMaU
         VxUWh1XhbnWa54xjlpREc2ITByGtwV3Mp17ZyH74BX98z8zyTQOQRotYJ5R8GFtD8qro
         n6h9tFgPyMOnfPh5+KkjmO+8JS4AXLU4rbe6TkyL6HDgWbXSevtlbLC/W4LVp+JuSBTY
         ZhZA==
X-Gm-Message-State: AOJu0YzjElMkedJVuwtD76dsfXz96O6wk2LZGQowwCz29k4HftQ/T84N
	hE1ZJV0ZgXA6bxvdHrKBZUKtA20RF2V6oswHrs/nFUCtcTkU6DzBLemsVQIg7gBiGiZCDR2Ie9O
	qOQmsTNOBve5p3nt+XWxaST15lqQotl4E/076B/0rK+5jicBZNIOug/wiTaR/trRtp9DeBw==
X-Gm-Gg: ASbGncuC4qtu7l57dHZiaN2aJtIWUYaQcXAIq2ttod2styJ2bOaNhFTlDyKQQ6aH8oA
	IJf0lRCYxxmwwwnl8UfUAcCVpo6z5CC9NmNJgJOfisdr1Cl9ovAqKKyY/qEGuHe+UPj73eQeOvD
	8/EZjNREZiG/w41zGKxHTPcLXJRuOsJiTLn7DVhvj9laCtPtTGyI3zyleeZ1REEByo2kZKsZuSe
	LW6hXHW8J0wCHY2ffdrNTabsE4Pih0p/X2OtRVyf5QEhZDP/skuyv5UJDKjm28ph4AVItFCjzwL
	JpUHZBk1ItnVfBZq+clTW5AejCP1CrGEL5dl1/L1SVDPHF32gvvTJCWTfXBarkoFz2x1DCERtft
	9NIjT+ZKdgpkVTS/knOCEt7smERhWlZFEnUWThWAzCjfpedTTBcKVneA/h5Oq+wmGHuG6vYyR0g
	==
X-Received: by 2002:a05:6a21:328c:b0:234:8b24:108d with SMTP id adf61e73a8af0-240313b0ec0mr4238968637.22.1754479084426;
        Wed, 06 Aug 2025 04:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0fyWvbKc1rj97afBcSLW8nlfByDTR896iZ3YLok3hoDmjxdqOEnVq6x29QzM9f8fc70+g0w==
X-Received: by 2002:a05:6a21:328c:b0:234:8b24:108d with SMTP id adf61e73a8af0-240313b0ec0mr4238919637.22.1754479083887;
        Wed, 06 Aug 2025 04:18:03 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:18:03 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 4/7] wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
Date: Wed,  6 Aug 2025 16:47:47 +0530
Message-Id: <20250806111750.3214584-5-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX7W0HCTcF22BZ
 dBUaneHdzaAlx8JFRhvUohbKgCxma3snwRiU+EGCGoQ3eMQkeZ1RR7NuEHshLtf/2oFReA42TqQ
 kLX2zl04g6JpB5pjDlXz5a1/kX/MVSW4KMaRVYZFX+9BSPmKsKYp37x7n5tLAMPij3fUrDb8uhX
 dUWYicC5QYl4nackgc2dLeDE4fkUMDI4t9Ud6Cev2txFLr+/tIXR9ewD0xPy1MoTjo712et+3L8
 LjNKFJNdCNR13AeSOoF0vSKnAyk3I4iP3wNbn+UYk4dtQmAaSABGRcAQc/HZDJ8lwEh84aJbT/K
 ubSqcmI9LK9ftpLQm3jSDjMBOktUmLT0oxwQD6BLRrPn/ZjV6WH773FJbxiwCq1bb5umho7hxhu
 0wpa35Fy
X-Proofpoint-GUID: x_oFTqK-FFcCALYKcwJdskP5c62THoN6
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=689339ed cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KD_jr8PvZQrAthsRHXcA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: x_oFTqK-FFcCALYKcwJdskP5c62THoN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Introduce ath12k_dp_rx_tid_rxq as a lightweight structure to represent
only the necessary fields for REO command construction. Replace direct
usage of ath12k_dp_rx_tid in REO command paths with this new structure.

This decouples REO command logic from internal TID state representation,
improves modularity, and reduces unnecessary data dependencies.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 46 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp_rx.h | 10 ++++--
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 0337355262f2..fbebc79024cf 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -22,7 +22,7 @@
 #define ATH12K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
 static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
-					     struct ath12k_dp_rx_tid *rx_tid);
+					   struct ath12k_dp_rx_tid_rxq *rx_tid);
 
 static enum hal_encrypt_type ath12k_dp_rx_h_enctype(struct ath12k_base *ab,
 						    struct hal_rx_desc *desc)
@@ -584,6 +584,14 @@ static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
 	return 0;
 }
 
+static void ath12k_dp_init_rx_tid_rxq(struct ath12k_dp_rx_tid_rxq *rx_tid_rxq,
+				      struct ath12k_dp_rx_tid *rx_tid)
+{
+	rx_tid_rxq->tid = rx_tid->tid;
+	rx_tid_rxq->active = rx_tid->active;
+	rx_tid_rxq->qbuf = rx_tid->qbuf;
+}
+
 static void ath12k_dp_rx_tid_cleanup(struct ath12k_base *ab,
 				     struct ath12k_reoq_buf *tid_qbuf)
 {
@@ -621,7 +629,7 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
 				   enum hal_reo_cmd_status status)
 {
-	struct ath12k_dp_rx_tid *rx_tid = ctx;
+	struct ath12k_dp_rx_tid_rxq *rx_tid = ctx;
 
 	if (status != HAL_REO_CMD_SUCCESS)
 		ath12k_warn(dp->ab, "failed to flush rx tid hw desc, tid %d status %d\n",
@@ -630,7 +638,8 @@ static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
 	ath12k_dp_rx_tid_cleanup(dp->ab, &rx_tid->qbuf);
 }
 
-static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
+static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab,
+				  struct ath12k_dp_rx_tid_rxq *rx_tid,
 				  enum hal_reo_cmd_type type,
 				  struct ath12k_hal_reo_cmd *cmd,
 				  void (*cb)(struct ath12k_dp *dp, void *ctx,
@@ -676,7 +685,7 @@ static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_ti
 }
 
 static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
-				      struct ath12k_dp_rx_tid *rx_tid)
+				      struct ath12k_dp_rx_tid_rxq *rx_tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
 	unsigned long tot_desc_sz, desc_sz;
@@ -719,7 +728,7 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 				      enum hal_reo_cmd_status status)
 {
 	struct ath12k_base *ab = dp->ab;
-	struct ath12k_dp_rx_tid *rx_tid = ctx;
+	struct ath12k_dp_rx_tid_rxq *rx_tid = ctx;
 	struct ath12k_dp_rx_reo_cache_flush_elem *elem, *tmp;
 
 	if (status == HAL_REO_CMD_DRAIN) {
@@ -774,7 +783,7 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 }
 
 static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
-					     struct ath12k_dp_rx_tid *rx_tid)
+					   struct ath12k_dp_rx_tid_rxq *rx_tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
 
@@ -849,11 +858,14 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 {
 	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
 	int ret;
+	struct ath12k_dp_rx_tid_rxq rx_tid_rxq;
 
 	if (!rx_tid->active)
 		return;
 
-	ret = ath12k_dp_rx_tid_delete_handler(ar->ab, rx_tid);
+	ath12k_dp_init_rx_tid_rxq(&rx_tid_rxq, rx_tid);
+
+	ret = ath12k_dp_rx_tid_delete_handler(ar->ab, &rx_tid_rxq);
 	if (ret) {
 		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
 			   tid, ret);
@@ -950,9 +962,12 @@ static int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 {
 	struct ath12k_hal_reo_cmd cmd = {};
 	int ret;
+	struct ath12k_dp_rx_tid_rxq rx_tid_rxq;
 
-	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
+	ath12k_dp_init_rx_tid_rxq(&rx_tid_rxq, rx_tid);
+
+	cmd.addr_lo = lower_32_bits(rx_tid_rxq.qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid_rxq.qbuf.paddr_aligned);
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
 	cmd.upd0 = HAL_REO_CMD_UPD0_BA_WINDOW_SIZE;
 	cmd.ba_window_size = ba_win_sz;
@@ -962,12 +977,12 @@ static int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 		cmd.upd2 = u32_encode_bits(ssn, HAL_REO_CMD_UPD2_SSN);
 	}
 
-	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
+	ret = ath12k_dp_reo_cmd_send(ar->ab, &rx_tid_rxq,
 				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
 				     NULL);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to update rx tid queue, tid %d (%d)\n",
-			    rx_tid->tid, ret);
+			    rx_tid_rxq.tid, ret);
 		return ret;
 	}
 
@@ -1216,6 +1231,7 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 	struct ath12k_hal_reo_cmd cmd = {};
 	struct ath12k_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
+	struct ath12k_dp_rx_tid_rxq rx_tid_rxq;
 	u8 tid;
 	int ret = 0;
 
@@ -1262,9 +1278,11 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 		rx_tid = &peer->rx_tid[tid];
 		if (!rx_tid->active)
 			continue;
-		cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
-		cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
+
+		ath12k_dp_init_rx_tid_rxq(&rx_tid_rxq, rx_tid);
+		cmd.addr_lo = lower_32_bits(rx_tid_rxq.qbuf.paddr_aligned);
+		cmd.addr_hi = upper_32_bits(rx_tid_rxq.qbuf.paddr_aligned);
+		ret = ath12k_dp_reo_cmd_send(ab, &rx_tid_rxq,
 					     HAL_REO_CMD_UPDATE_RX_QUEUE,
 					     &cmd, NULL);
 		if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index e971a314bd2d..da2332236b77 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -31,15 +31,21 @@ struct ath12k_dp_rx_tid {
 	struct ath12k_base *ab;
 };
 
+struct ath12k_dp_rx_tid_rxq {
+	u8 tid;
+	bool active;
+	struct ath12k_reoq_buf qbuf;
+};
+
 struct ath12k_dp_rx_reo_cache_flush_elem {
 	struct list_head list;
-	struct ath12k_dp_rx_tid data;
+	struct ath12k_dp_rx_tid_rxq data;
 	unsigned long ts;
 };
 
 struct ath12k_dp_rx_reo_cmd {
 	struct list_head list;
-	struct ath12k_dp_rx_tid data;
+	struct ath12k_dp_rx_tid_rxq data;
 	int cmd_num;
 	void (*handler)(struct ath12k_dp *dp, void *ctx,
 			enum hal_reo_cmd_status status);
-- 
2.17.1


