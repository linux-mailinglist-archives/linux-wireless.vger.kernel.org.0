Return-Path: <linux-wireless+bounces-17163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E33FA0492F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 19:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FC93A4C1E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B421EBFE2;
	Tue,  7 Jan 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SGJKikRy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937F1F428B
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274433; cv=none; b=ShPA1v2C7TRH7UvH+50OxlRC8Tq4fH40B6rvVS3VWyGgwasdtFjRjwbFLFizmZpgQAMr5/UbeC15YjzEymCilxBTsaNoEPj5Jv1dgovtwHk/36R/JaIzrMn8xmHRGoyQ1D3nyIraje7guGTPAqFD3RJmlmGCOBrqBySlvaVfYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274433; c=relaxed/simple;
	bh=qhh5bYRWLtymXdupDySsN7/ZBkrIMgS76Cv2XK7mrHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO3id4NoFi5BSat181vmmaPcKA4JUBeQrhGhisFv/9Qe8QLNJVs69/u2HR2VdpH/xtJ6UbWew4oCB48X9FSaJbonPsCNnch5rcrkWCmBriVM7xIIiDMMOVb1FkRcoZinzEOftjlBYRK3/iUYV8ICufSykvNnns2HlxoKAYtJNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SGJKikRy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507GriVu031829;
	Tue, 7 Jan 2025 18:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rR52YQ32v4WgZd4ioB6B8gsYo4L2T/BVjM+UxvJ8WUA=; b=SGJKikRy2I5nA8WZ
	rxrWQDCo8jjVTaQNvhAduWM0dB7vUiyMsykE0pHDLhQ9MbHn65sBG/+Pd1w4/yej
	AqHKkmF9NMVI99R5ZJNscSzx3k3Nh8XkA4f/9lG+rymQeeo80R+qgyPdS1nh6iez
	Y/LXWpjGixOQ8VjIhoL3i6HrYqTTN48gnzmCU3WrfpPHgqk7RTf5+iTnU+NCQyU1
	LEp8b5b0E3M641DZ5GRdSXSZy7EuTruzEVdxc8l5eJ415os3DwamJgznxi0u5X5R
	+j3UrEtxNfDbXi52te32oAFIoaU1Wgh/h8K4lpN+H1TPbDHY6wf3Pb+I+dFj2v1P
	dqNBGw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44186ng7ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:27:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507IR1wa032312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 18:27:01 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 10:26:59 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH RFC 3/5] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Tue, 7 Jan 2025 23:55:04 +0530
Message-ID: <20250107182506.1838704-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107182506.1838704-1-quic_ramess@quicinc.com>
References: <20250107182506.1838704-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: hQ8E8mdH1FR7OE1M4X3VP9TT7DSmlL6y
X-Proofpoint-GUID: hQ8E8mdH1FR7OE1M4X3VP9TT7DSmlL6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070153

From: Roopni Devanathan <quic_rdevanat@quicinc.com>

Add support to get the radio for which RTS threshold needs to be changed
from userspace. Pass on this radio index to underlying drivers as an
additional argument.
A value of NL80211_WIPHY_RADIO_ID_MAX(255) indicates radio index is not
mentioned and the configuration applies to all radio(s) of the wiphy.

Note:
The change in interface in mac80211_hwsim.c is a sample of how the
changes in interface corresponding to setting RTS threshold would
affect mac80211 drivers. All the affected drivers will be modified
similarly when the design is concluded and the patch series moves
from RFC state.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 ++-
 include/net/mac80211.h                        |  2 +-
 net/mac80211/cfg.c                            |  8 ++++++-
 net/mac80211/driver-ops.h                     |  6 ++---
 net/mac80211/trace.h                          | 24 ++++++++++++++++---
 net/mac80211/util.c                           |  7 +++++-
 6 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf6a331d4042..0c02e7f8a2e0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3330,7 +3330,8 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 	return 1;
 }
 
-static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id,
+					    u32 value)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9320d4bc22ee..6675fd6be204 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4553,7 +4553,7 @@ struct ieee80211_ops {
 			    struct ieee80211_key_conf *key,
 			    struct ieee80211_key_seq *seq);
 	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
-	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
+	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id, u32 value);
 	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 33a325524997..e2125ce42fb5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3033,7 +3033,13 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 chan
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
-		err = drv_set_rts_threshold(local, wiphy->rts_threshold);
+		u32 rts_threshold;
+
+		if (radio_id >= wiphy->n_radio)
+			rts_threshold = wiphy->rts_threshold;
+		else
+			rts_threshold = wiphy->radio_cfg[radio_id].rts_threshold;
+		err = drv_set_rts_threshold(local, radio_id, rts_threshold);
 
 		if (err)
 			return err;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c64531e0a60e..e77962c5b23f 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -402,16 +402,16 @@ static inline int drv_set_frag_threshold(struct ieee80211_local *local,
 }
 
 static inline int drv_set_rts_threshold(struct ieee80211_local *local,
-					u32 value)
+					u8 radio_id, u32 value)
 {
 	int ret = 0;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	trace_drv_set_rts_threshold(local, value);
+	trace_drv_set_rts_threshold(local, radio_id, value);
 	if (local->ops->set_rts_threshold)
-		ret = local->ops->set_rts_threshold(&local->hw, value);
+		ret = local->ops->set_rts_threshold(&local->hw, radio_id, value);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index dc35fed7e9b0..8792f69365fb 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -823,9 +823,27 @@ DEFINE_EVENT(local_u32_evt, drv_set_frag_threshold,
 	TP_ARGS(local, value)
 );
 
-DEFINE_EVENT(local_u32_evt, drv_set_rts_threshold,
-	TP_PROTO(struct ieee80211_local *local, u32 value),
-	TP_ARGS(local, value)
+TRACE_EVENT(drv_set_rts_threshold,
+	TP_PROTO(struct ieee80211_local *local, u8 radio_id, u32 value),
+
+	TP_ARGS(local, radio_id, value),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(u8, radio_id)
+		__field(u32, value)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->radio_id = radio_id;
+		__entry->value = value;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " value:%d",
+		LOCAL_PR_ARG, __entry->value
+	)
 );
 
 TRACE_EVENT(drv_set_coverage_class,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7b656326e68a..109ddfe47f13 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1837,7 +1837,12 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	drv_set_frag_threshold(local, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, hw->wiphy->rts_threshold);
+	if (hw->wiphy->n_radio)
+		for (i = 0; i < hw->wiphy->n_radio; i++)
+			drv_set_rts_threshold(local, i, hw->wiphy->radio_cfg[i].rts_threshold);
+
+	else
+		drv_set_rts_threshold(local, NL80211_WIPHY_RADIO_ID_MAX, hw->wiphy->rts_threshold);
 
 	/* reset coverage class */
 	drv_set_coverage_class(local, hw->wiphy->coverage_class);
-- 
2.34.1


