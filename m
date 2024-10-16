Return-Path: <linux-wireless+bounces-14047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B434D9A01E3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FC21C20A66
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4A71BE871;
	Wed, 16 Oct 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZMb7IxI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE4199FD0
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061857; cv=none; b=CBy8gtMw/2kdJ7ejnIVqxBM5TXHdJejDouWD2ZmAluiyq6p1y2oXl9ab5thnt7BvInXlhVlBOR6FSjHjQ71Y7tBsVsholCecP4/Q68evZaTUOAjMYKESFOCos59xsk9xMWNB87kDyNfHVtvQKWnAKI6d9RcpaAZ6D8/HXmdf63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061857; c=relaxed/simple;
	bh=FtYMtwh4RLT39ol5W8yyo5suU0atdP/bLgO58eVLRxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr3t3xzHFfl9JNkGmKBh3Uh1ghUiDbWqq6xGRPJRIixfhIvA2pIbZFwCB2pQQC5Vsj6LUOPtim7uWVtkWwr3yo400n4sGYSR70ZC7W7znwPVV63imIakKXThFLCq4kKKkyd8ICvYsFOCubSsXajvT0KZr+eAjBEQD0vmhk3+kg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZMb7IxI4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6uX47023594;
	Wed, 16 Oct 2024 06:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	USyLgNYKL7ZaNaYpkXrZKHBkOhYZiWSO1x0nf99AyTc=; b=ZMb7IxI4mRTUZw81
	TOZz4y3CyIu07Qt5KSUwsM9BSmdt4ZC3uFLJwpcxAGrKzdYy9odi/1k4HDG/ZLTT
	SdAf0yJTovjedSgrBHR98Yeo4M7iih+hQMAsE1mL1EFj/o0o+Ojuws1x5Bt9JD0J
	iEkB3fT8x3qYS6ilHbBOlB/maTPCrvU09M8r4ytMUKZUmRWj3jhunq30rmwo+iYC
	3nbbau3guWrtcRWReJYiC9pfnmdBsQevJk9b1xYYbmjhPl1Wu5gMv2JnOK8+7dVP
	20xm7U4Boj9GtLjCygjM/ccDdBsgH6MhBV+7rOYFnGkSaKtvcHHAYdhXzDt8B+4K
	LZgkwA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq002j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6vRD5006825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:27 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:57:26 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 02/11] wifi: ath12k: optimize storage size for struct ath12k
Date: Wed, 16 Oct 2024 14:56:51 +0800
Message-ID: <20241016065700.1090-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241016065700.1090-1-quic_kangyang@quicinc.com>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i45uRDuq4jTFH7nvCKEMxp-rxHh0BG-M
X-Proofpoint-GUID: i45uRDuq4jTFH7nvCKEMxp-rxHh0BG-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160044

Optimize storage size for struct ath12k by clean up bool variables.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cbcace4671cb..0c39b37d6a47 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -531,17 +531,16 @@ struct ath12k {
 	u32 ht_cap_info;
 	u32 vht_cap_info;
 	struct ath12k_he ar_he;
-	bool supports_6ghz;
 	struct {
 		struct completion started;
 		struct completion completed;
 		struct completion on_channel;
 		struct delayed_work timeout;
 		enum ath12k_scan_state state;
-		bool is_roc;
 		int vdev_id;
 		int roc_freq;
-		bool roc_notify;
+		bool is_roc:1;
+		bool roc_notify:1;
 	} scan;
 
 	struct {
@@ -618,7 +617,6 @@ struct ath12k {
 	 * However there are deviations from this rule. This flag is used to
 	 * avoid reporting garbage data.
 	 */
-	bool ch_info_can_report_survey;
 	struct survey_info survey[ATH12K_NUM_CHANS];
 	struct completion bss_survey_done;
 
@@ -629,7 +627,6 @@ struct ath12k {
 
 	struct ath12k_wow wow;
 	struct completion target_suspend;
-	bool target_suspend_ack;
 	struct ath12k_per_peer_tx_stats peer_tx_stats;
 	struct list_head ppdu_stats_info;
 	u32 ppdu_stat_list_depth;
@@ -641,16 +638,19 @@ struct ath12k {
 	struct ath12k_debug debug;
 #endif
 
-	bool dfs_block_radar_events;
-	bool monitor_conf_enabled;
-	bool monitor_vdev_created;
-	bool monitor_started;
 	int monitor_vdev_id;
 
 	u32 freq_low;
 	u32 freq_high;
 
-	bool nlo_enabled;
+	bool supports_6ghz:1;
+	bool ch_info_can_report_survey:1;
+	bool target_suspend_ack:1;
+	bool dfs_block_radar_events:1;
+	bool monitor_conf_enabled:1;
+	bool monitor_vdev_created:1;
+	bool monitor_started:1;
+	bool nlo_enabled:1;
 };
 
 struct ath12k_hw {
-- 
2.34.1


