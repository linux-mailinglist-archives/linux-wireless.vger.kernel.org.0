Return-Path: <linux-wireless+bounces-22953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C8FAB71E9
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260B91BA17D5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371627CCE7;
	Wed, 14 May 2025 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iz1EuprN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4527EC78
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241381; cv=none; b=CZr5x5fe4Zg/iLFNH4tDfpvun8BaoHoaDoCyVifmeiVgsgk7A2lezNrIEahgZrJGPg1Yinl4gBvNoK1xsf9Vsh4uFE/hiaw3r9lViVBmcWegPq2BmqPAi5UleLR6zYwDoqY53Xso+6g3CMV1xLq7EYnpafp6z5LvkgDmhnwkxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241381; c=relaxed/simple;
	bh=ijkHFdZ52LoMGkEAmieypmAJ4wEgxRTn0t3LFb3kwF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFxdDhZybpllNZDpUsIQpezHAFo+r9Hjpmk5G6PIfGtAjiqk1LQhiliYSJws3KT9SUBmxW/oeksvPdPtLpW2k5b0jqFJ3AK13STDNdvV+hMytOHV7Gzz8HJi2TeqBEQJpaXsWZxYIfpWsVarQ+wVQLDSND/w8T29IXz3E8vDrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iz1EuprN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuhvS002748;
	Wed, 14 May 2025 16:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v4Y1EaNWOfmT4kiBPDVtCo9UeAOcKreEJ8dz2MKyNYk=; b=iz1EuprN04WNmEjN
	RRNpKg07lhjnC5z9RUEMT5zhXKUYkOs9EFGpMCscO9HDQxGih7QHLaIpDjiNgIrJ
	0kVEoMNr0DFI9Y/+r1Gs2cfGCBJAR1ix5IuqV7LoCa2kLWYJFYu4s1CJV7y2jA1o
	NsIzxLvOKxyoK7GbR9zM8WNqlepVceoi2lc+LnpheaicK4vf1mBCEBGMOgIq+jgG
	P7o3wy9zkuX2FKbFEz5rkZRPRNnFetK/nQEGTbKMSNFsJ8kkQkjuB0ldByAnCf2B
	/uj9Q159X+RJRW2w2kM3l10hMuAAl/VMUPOZmY6MiEdZwhpztpiaU2cHpNSxEkSe
	0xO9/A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpbdex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EGnZKs001885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:35 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 09:49:33 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v7 09/10] wifi: mac80211: add link_sta_statistics ops to fill link station statistics
Date: Wed, 14 May 2025 22:18:56 +0530
Message-ID: <20250514164857.227540-10-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514164857.227540-1-quic_sarishar@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: wcKnhSvxZJOp5jTUWIMZQBl3QuI8ydQE
X-Proofpoint-ORIG-GUID: wcKnhSvxZJOp5jTUWIMZQBl3QuI8ydQE
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=6824c99f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=sCcAGWPSh8-MqCaDQy4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1MSBTYWx0ZWRfX2YxLpJXTl8Io
 e1ckocOOj8P5HpPvRAScM3dEbizecOOMFFKeGnal7BZ8pQrOJTyG0kdzEFhtRsljutBwf9GbtnT
 nseUpKeuc5lS9s1ll1QY13YACnxfQpBqhfVqLuw7u3Ps1LmxGFQZDl/cH+WfoNgJY2qQ5XqA+0g
 gbGZ/wAm/HMGUhwLvOD/hnNEXkklVT5eSO7maCKooqB10uBH9kgKnmNsABfS0mvE2TaJKjSKEny
 oVVDBcVa4v/JJ5RDY3Qw32pUd3q8IOVh2FFtvSLaEyIPKdOhb5IuV7LjTL7Hj53X1CkEL0A3aRU
 bvGqcI92apYSVsiZUaCUHOuEYsLwWcO7Kqxp7KuyKbu4GvsfGwo5wCMGav+sc27vzC6Kxm+U7bZ
 HKOGUuPKW6IepoQAiJC+1y3di/RgaAF8NrNyHThtRnoTRDJ50gYyljzjmIbk86hTwfvW8jFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140151

Currently, link station statistics for MLO are filled by mac80211.
But there are some statistics that kept by mac80211 might not be
accurate, so let the driver pre-fill the link statistics. The driver
can fill the values (indicating which field is filled, by setting the
filled bitmapin in link_station structure).
Statistics that driver don't fill are filled by mac80211.

Hence, add link_sta_statistics callback to fill link station statistics for
MLO in sta_set_link_sinfo() by drivers.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/mac80211.h    | 13 +++++++++++++
 net/mac80211/driver-ops.h | 19 +++++++++++++++++++
 net/mac80211/sta_info.c   |  4 +---
 net/mac80211/trace.h      |  7 +++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a305e7f9c6b2..fc30e7b0708d 100644
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
+				    struct ieee80211_sta *sta,
+				    struct link_station_info *link_sinfo);
 
 	/**
 	 * @ampdu_action:
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 307587c8a003..60940b92c4d1 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -631,6 +631,25 @@ static inline void drv_sta_statistics(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_link_sta_statistics(struct ieee80211_local *local,
+					   struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_sta *sta,
+					   struct link_station_info *link_sinfo)
+{
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	trace_drv_link_sta_statistics(local, sdata, sta);
+	if (local->ops->link_sta_statistics)
+		local->ops->link_sta_statistics(&local->hw, &sdata->vif, sta,
+						link_sinfo);
+	trace_drv_return_void(local);
+}
+
 int drv_conf_tx(struct ieee80211_local *local,
 		struct ieee80211_link_data *link, u16 ac,
 		const struct ieee80211_tx_queue_params *params);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 906569651fbd..ec0512c6c50a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2724,9 +2724,7 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 
 	ether_addr_copy(link_sinfo->addr, link_sta_info->addr);
 
-	/* TODO: add drv_link_sta_statistics() ops to fill link_station
-	 * statistics of station.
-	 */
+	drv_link_sta_statistics(sta->local, sdata, &sta->sta, link_sinfo);
 
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..72ed15d605f6 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1002,6 +1002,13 @@ DEFINE_EVENT(sta_event, drv_sta_statistics,
 	TP_ARGS(local, sdata, sta)
 );
 
+DEFINE_EVENT(sta_event, drv_link_sta_statistics,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta),
+	TP_ARGS(local, sdata, sta)
+);
+
 DEFINE_EVENT(sta_event, drv_sta_add,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


