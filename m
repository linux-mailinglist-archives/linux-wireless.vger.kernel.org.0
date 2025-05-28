Return-Path: <linux-wireless+bounces-23462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E2AC6163
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6414A35B7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F820F085;
	Wed, 28 May 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g4sAhthH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206720B80B
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411102; cv=none; b=AT/pUad40FwzhDRj5y4AX4btEeDViMvD+M46qAc5TSRdzFPJGDYuTxx4pZJzFyn7Wl27GrWQqTnUBY6To3pylV3iQS/nJcw+GBfrUwRk9G1tFgd0hwyUTK7Qr7K3Oq0z0j+RIJjYjDVWhTdkFYsIZhdV9XmXp4jIJbZelGYNcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411102; c=relaxed/simple;
	bh=BRVcBo2etUo8lp1IQlZZZRzWT2JeBPu6tNSNgQEKBEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqLGMMarZQyKJ0q8wC8UDmqOdVV5Mjhi0rbatoaUu95yj+8pWzq6YlFbQjRv8DTFI1eLjMppmVHKJYB2XG/NKpLQcJo/mVPFWdyUCU68p9IX9khwWM8RP0+/l603S3IUn2y0Tvf7hBpCCSvdF0od41zvgsdsfiVh64694qyGm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g4sAhthH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S40xL6029130;
	Wed, 28 May 2025 05:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nvaN3Uvjmz3T0chVLcWvKvSKH9ZTRzF/gQhbRoqOD+w=; b=g4sAhthHLtKhkNgL
	4uBp/O4ayM0hB+VN6ehdBz8KeIQqUn29FS2XVmoc4vzjlxmGkfjex/qj95Fb4UfX
	XXRf8+s/k7vQydQ6MOMXu6jE02g8GTmPAgwF1e7u1zIen5pS8SL1DsmhqUhhZQYw
	iLqwEjFTUUQwY3yFIMKE1TXOozY+qAYSy5ShCk1g/jiqYSBrkCFJ5rD31FczJFLB
	QwqTqxrl5vrfoYo9i6IO37sirQ9Un0uPyjuV5PG8tiFFoIbgBwG52n/X1mYf2axE
	MCqD+gtdMORRQ+uMX9NtTxtLNTtXKz0/wpOvISGZ1fA8Zg2kFeUf5yjoIgE6p8Lt
	lYKX8w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w992k6ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S5itK4016644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:55 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 22:44:54 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v10 10/10] wifi: mac80211: add link_sta_statistics ops to fill link station statistics
Date: Wed, 28 May 2025 11:14:20 +0530
Message-ID: <20250528054420.3050133-11-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OSBTYWx0ZWRfX4n8/vxaoX9aA
 SaTnFoU29nmPvsDzVH8gdc24oytK271S9zl/NMVH/6vuk483Z6UkBr6uIIQrI192gup579ZlU0Q
 z/KfnEPSFfog77qtKygrS822BIoaWlmGH48P/Ce7qQ8T08haswa4tE8VNKgMEOjuII3+eEi/mFH
 gdT3TKdNVS9B+NDXoMGrpvVBCGZG5liMxu6eDFgALzzpDjffWQ3SfPWwGEtz3lvTc2syL636m0d
 WC7qACxv14lvG5jBjCtmAfr7OIWIpP3QOT3pnse93GFeU5WY3bGyWx/ujEBwCibPMktlRgPbDYC
 2t1kYxzthp+M8T+pW/GrVXfIqlum1FyCQ36pCVsGEcMrta9+NOPNpfm9Z3q5NWCNzgk9FcCqEKP
 ox/M7oPQmuFc3h5ROaDCntQMqA0D3TnEBFhMzBLfg7aSq+xSN8Rz/1TxcL3Qwo2EHZ6IIFtD
X-Authority-Analysis: v=2.4 cv=Fes3xI+6 c=1 sm=1 tr=0 ts=6836a2d8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=sCcAGWPSh8-MqCaDQy4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zJurjTtbFoj-dti5UxKSprFnzg0QQ4VQ
X-Proofpoint-ORIG-GUID: zJurjTtbFoj-dti5UxKSprFnzg0QQ4VQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280049

Currently, link station statistics for MLO are filled by mac80211.
But there are some statistics that kept by mac80211 might not be
accurate, so let the driver pre-fill the link statistics. The driver
can fill the values (indicating which field is filled, by setting the
filled bitmapin in link_station structure).
Statistics that driver don't fill are filled by mac80211.

Hence, add link_sta_statistics callback to fill link station statistics
for MLO in sta_set_link_sinfo() by drivers.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/mac80211.h    | 13 +++++++++++++
 net/mac80211/driver-ops.h | 19 +++++++++++++++++++
 net/mac80211/sta_info.c   |  6 +++---
 net/mac80211/trace.h      | 27 +++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a305e7f9c6b2..fa2325692abf 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4133,6 +4133,15 @@ struct ieee80211_prep_tx_info {
  *	Statistics that the driver doesn't fill will be filled by mac80211.
  *	The callback can sleep.
  *
+ * @link_sta_statistics: Get link statistics for this station. For example with
+ *	beacon filtering, the statistics kept by mac80211 might not be
+ *	accurate, so let the driver pre-fill the statistics. The driver can
+ *	fill most of the values (indicating which by setting the filled
+ *	bitmap), but not all of them make sense - see the source for which
+ *	ones are possible.
+ *	Statistics that the driver doesn't fill will be filled by mac80211.
+ *	The callback can sleep.
+ *
  * @conf_tx: Configure TX queue parameters (EDCF (aifs, cw_min, cw_max),
  *	bursting) for a hardware TX queue.
  *	Returns a negative error code on failure.
@@ -4627,6 +4636,10 @@ struct ieee80211_ops {
 			   s64 offset);
 	void (*reset_tsf)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 	int (*tx_last_beacon)(struct ieee80211_hw *hw);
+	void (*link_sta_statistics)(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_link_sta *link_sta,
+				    struct link_station_info *link_sinfo);
 
 	/**
 	 * @ampdu_action:
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 307587c8a003..ba017bf3fd15 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -631,6 +631,25 @@ static inline void drv_sta_statistics(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_link_sta_statistics(struct ieee80211_local *local,
+					   struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_link_sta *link_sta,
+					   struct link_station_info *link_sinfo)
+{
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	trace_drv_link_sta_statistics(local, sdata, link_sta);
+	if (local->ops->link_sta_statistics)
+		local->ops->link_sta_statistics(&local->hw, &sdata->vif,
+						link_sta, link_sinfo);
+	trace_drv_return_void(local);
+}
+
 int drv_conf_tx(struct ieee80211_local *local,
 		struct ieee80211_link_data *link, u16 ac,
 		const struct ieee80211_tx_queue_params *params);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 63c0c0dda8b7..a47fa20b25c8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2743,9 +2743,9 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 
 	ether_addr_copy(link_sinfo->addr, link_sta_info->addr);
 
-	/* TODO: add drv_link_sta_statistics() ops to fill link_station
-	 * statistics of station.
-	 */
+	drv_link_sta_statistics(sta->local, sdata,
+				link_sta_info->pub,
+				link_sinfo);
 
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..8215ca58ce5e 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1002,6 +1002,33 @@ DEFINE_EVENT(sta_event, drv_sta_statistics,
 	TP_ARGS(local, sdata, sta)
 );
 
+TRACE_EVENT(drv_link_sta_statistics,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_link_sta *link_sta),
+
+	TP_ARGS(local, sdata, link_sta),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__field(u32, link_id)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_NAMED_ASSIGN(link_sta->sta);
+		__entry->link_id = link_sta->link_id;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " (link %d)",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->link_id
+	)
+);
+
 DEFINE_EVENT(sta_event, drv_sta_add,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


