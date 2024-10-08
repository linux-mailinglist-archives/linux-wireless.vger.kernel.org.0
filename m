Return-Path: <linux-wireless+bounces-13706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272679940FE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C1CB229B5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C81D2F58;
	Tue,  8 Oct 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f4B4VB1g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925B18C900
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372970; cv=none; b=Zyl8+cfrYcSTO8UDUtO8l3WU2qFDBhK0Ez0aNlCl1H3f4ChtFlXUgdJp4Q8i9bzs0nKhJTwkcR15tzIPVZar6YVxYvHlGJ1K+NuFW3vHfPy3YsBN87/yixo6U/Bg+tSQoKiWYNLGpvThCva8FLOU3P4adfNypq6hgAMzbF/Aqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372970; c=relaxed/simple;
	bh=2P3GKtV34j6b2gowxCx3yn6woMtZIRsHC3bsiNVS9Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DO+x4tN9NiGB5QWSEooI8MyHMy8unf74Nd+EALzIquUK+rN3SVXP54gkea/mJpPBUevy1qWstcNRtc9eqAUfa8KIBq5s8d08ne/28/1mE4uDFRrd8cuyyN7prNOatXewUmqFDsHmX/IxIB5WBO7G92WRi0mFmP+Y+XZesqbFceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f4B4VB1g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497J0bFU006304;
	Tue, 8 Oct 2024 07:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CuOSfRiDmV6PN/+jMbC2dzIzs9xxxliVF5o+eGx24Ro=; b=f4B4VB1gK1FcIt6R
	qYY5J131uhLzYVAcjRG005qxDO0Z9D7TMKLBi4VIztkUpVBQ2jl2h5A4/XNUJFtL
	NrjWZLBuTbfKi9c8yUMCpDhdzXAjgipKB4j83zQXDv2FqV+xnuKNC4lCbc+V4iYc
	xBPMOndeOxXWrVqjJryujemaF3cpggEmgHZmczSjdc9DAuoHEf3o1fs3qbNqm7pv
	S0AHUp2B96w8qAfXDeJcJdF+No6Q6lR71uu63kP26g3SK6tkH4jOQE0OE9fAYpJm
	BJ2fpWK0VegGkqwtE0uNV5d7q5lP+I8Z+rpMW9KJsJxtVn4jmQb9C642B5/yKwD8
	Sh3B7w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424cy7axgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:36:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4987a2XY010534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 07:36:02 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 00:36:00 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 02/11] wifi: ath12k: optimize storage size for struct ath12k
Date: Tue, 8 Oct 2024 15:35:25 +0800
Message-ID: <20241008073534.1195-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241008073534.1195-1-quic_kangyang@quicinc.com>
References: <20241008073534.1195-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JoMiMsXBnWr2wzKbCVfWC7Q_A-xQGdfM
X-Proofpoint-GUID: JoMiMsXBnWr2wzKbCVfWC7Q_A-xQGdfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080048

Optimize storage size for struct ath12k by clean up bool variables.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index a048cba83112..3828b93765d3 100644
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
@@ -621,7 +620,6 @@ struct ath12k {
 	 * However there are deviations from this rule. This flag is used to
 	 * avoid reporting garbage data.
 	 */
-	bool ch_info_can_report_survey;
 	struct survey_info survey[ATH12K_NUM_CHANS];
 	struct completion bss_survey_done;
 
@@ -632,7 +630,6 @@ struct ath12k {
 
 	struct ath12k_wow wow;
 	struct completion target_suspend;
-	bool target_suspend_ack;
 	struct ath12k_per_peer_tx_stats peer_tx_stats;
 	struct list_head ppdu_stats_info;
 	u32 ppdu_stat_list_depth;
@@ -644,16 +641,19 @@ struct ath12k {
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


