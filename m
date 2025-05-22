Return-Path: <linux-wireless+bounces-23292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1CCAC07FA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A24B1BC589C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0D289E08;
	Thu, 22 May 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tk1BTfW5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3B28A702
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904210; cv=none; b=kAW27lvof+cfOdm9pz37KoMnlWEQfSXPxlB+2F4JPfHgJh3o/iQ2wXLS/DXUsH2+ZBr07qWEoVPjDa979cXIEvK1ZvHMiUQub2W8SRxyQalcYYnsAcOrYDtzsXrpPrhuGTttT+ni3X/0/juSd+2UHL/ICa1nCBVziBkcMKYla/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904210; c=relaxed/simple;
	bh=qNG0czitw4S/OWDO7mgO22cXCcPaBwmuQkBYXCJdBBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=do9F1A0JV8BpCV7wXa5qaEWSig33LTkSzp5mlzLBSVXQiaHzwYvcVUQiMbNr+ibKtR1IqXHDQogrTnrrKe9jqjXZz5V1eZ5HpTjcyBmk36kVq0psOYV/PDR0vBA9sWydLIhthTZObV+PZACVz2U30aJMYpdolkfLrq1L3fWh3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tk1BTfW5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M75ADP016577;
	Thu, 22 May 2025 08:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jGeRLg6o/lYAUFf6stBQwhzDatx8M/u5ECw+I5/I0Is=; b=Tk1BTfW5IUyUvgzW
	8SnYKDL9XRZx4wkvAULo1pAA5478582KCGzrN1cJ7JQ15h6SJFyTnnAMK4C969s6
	yMlWINfCCYybrCxdu1KtwnPlqskmXgGAAYh9yYkpn4MPOnJzcztr1fpl3fvx9D/H
	SMnyuyTwBlzypgFpZnJBRVdzxX4TJyG058h1qZPvszScQ7yEsXgM4mLa7ZCoR+8n
	cK1pDUZ/ru18jqul09IF8LQxEfDfbcOixScNiyGbTwyUadCKKln23hEFVc8SKMrC
	whZEMPfjCzsh6MmQMN+89XSvGITTO/bnfW2w+wiGbLijjSAdlqDdif6mzbtFpWF9
	hRNt3Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9wqj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8ugoR008948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:42 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 May 2025 01:56:41 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v9 10/10] wifi: mac80211: add link_sta_statistics ops to fill link station statistics
Date: Thu, 22 May 2025 14:26:01 +0530
Message-ID: <20250522085601.2741458-11-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682ee6cb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=sCcAGWPSh8-MqCaDQy4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NWt4LZBJkuIrv0nlQ5LKc_EAcR__m088
X-Proofpoint-GUID: NWt4LZBJkuIrv0nlQ5LKc_EAcR__m088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfX6JHbrIvaNyfY
 Uh1iB7sVV3ZV38xG+HVFggvShAiBsLFzFynLxHhO/1K13J16QmDEWLaY8xJB3vasQfxxg1gy+28
 hCHmHBopiozwN7AxqXSkIZphmm3mEwGcUwq4NIXWYkQ24VnqeVgf9zvNd2wQv4G4FapGSFOvcjY
 TWuSRly7Can0KUwckpjipcqS8wtZbqqeemA+dvWbbVU+6BnYYh4UbjvLNYZnZZvU84pxDkDykpC
 3pUC9Pxu6C82Y62BOOxiIpYxtvDImnjaHv62XW9Q0eqcVOeJW/r4xPRScyo7DFQyVArNEBKh7ZF
 vTSZW1DPF+Rl0dASLsaQ6BsGpwRc0OYhp8Ezo5m76NuS4V3asu7Tyh90qtQIJ9YqI0vxgNjhXO2
 RlZuKkHHjN3eGxx5XPjQRfU2TQ8xsw88emhVEObk1Mg6nSrLhv/FSlU5yVz2sUXYvwsgafGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220089

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
index 37e9fd0ab021..5175b8b2800d 100644
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


