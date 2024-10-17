Return-Path: <linux-wireless+bounces-14122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4A9A192B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 05:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277A61C22C48
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 03:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DE7DA8C;
	Thu, 17 Oct 2024 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QxLPVhPo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E01F94D
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134694; cv=none; b=dHz6lrObpa6o4Xl+wQEOP8N5iktIubIH9qr3go5oSu8EP1MlrzClVL5E1l2MNxfra+JNgqDCOThShBJXdW4gXIg09suw34rRkl1Tq7WcH7MuX3u3RsbJd+q/CQbx5Zha2FflwZeut/SOAytSZzh+2NqC+lzCV2ubZvSN2Xx7I/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134694; c=relaxed/simple;
	bh=raOc72T5ow4Nf56MpMheJBa2FVZfsRP2fgdYpGJCxfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4Tw+Cgg3tH9UhEPHzSTZOMdcV7edaBVGex7sUVBarOZximgMDhlXP24Yr5uS3TG0d7A9i+3LFuJrbThAQ0nPoVRqFQq2iem6NalsIQh09bhH9sSeENxs5cPEc3PoCg7jZYEV1rGjKqw2xA6hollesO9BVsj5Xfh9oPrHbdZJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QxLPVhPo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GH6wYd014541;
	Thu, 17 Oct 2024 03:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4I+vndbtgVku40LQdwDgvR9tyqELjUdRDLpVbpuiwHQ=; b=QxLPVhPozLaibTLF
	O1YfoVXs4yqyYZMhYQva5k6/kQsTGx9+Ix04cSDGKywgu6QDxMvcjEtqV3sjChcO
	7jzQt2sJ6r8RsuT3wt84w5ZBXBUUw0DLMPilRkNvMHCZGrwpgvz2mvXlwcDEJFeh
	rHDh5eqV6lQea8hGmAe1q1xo2WrAIrASW0ZWOJoPeEJIQN0+WQlAldp9Sbc2rrnr
	t+qHMVN28ZrTIzGBuXmiBN6KizXJM7IyYyd6ozPaORGbVQ0YbwuYppwPSTkRxTch
	gSWKlz6Yt989+whZpXL9YGZaFAhGUhxqu2vnfud0llUWHNVo2pgmMS19wNrW/dkR
	kjhdzg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a79hbbc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:11:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H3BPWq025668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:11:25 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 20:11:24 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 02/11] wifi: ath12k: optimize storage size for struct ath12k
Date: Thu, 17 Oct 2024 11:10:47 +0800
Message-ID: <20241017031056.1714-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241017031056.1714-1-quic_kangyang@quicinc.com>
References: <20241017031056.1714-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: BfEauYCOjfgKCmOOqftMhl2mGhefTi5Q
X-Proofpoint-ORIG-GUID: BfEauYCOjfgKCmOOqftMhl2mGhefTi5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410170021

Optimize storage size for struct ath12k by clean up bool variables.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8833c83d0292..18820c23cfaa 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -556,17 +556,16 @@ struct ath12k {
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
@@ -643,7 +642,6 @@ struct ath12k {
 	 * However there are deviations from this rule. This flag is used to
 	 * avoid reporting garbage data.
 	 */
-	bool ch_info_can_report_survey;
 	struct survey_info survey[ATH12K_NUM_CHANS];
 	struct completion bss_survey_done;
 
@@ -654,7 +652,6 @@ struct ath12k {
 
 	struct ath12k_wow wow;
 	struct completion target_suspend;
-	bool target_suspend_ack;
 	struct ath12k_per_peer_tx_stats peer_tx_stats;
 	struct list_head ppdu_stats_info;
 	u32 ppdu_stat_list_depth;
@@ -666,16 +663,19 @@ struct ath12k {
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


