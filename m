Return-Path: <linux-wireless+bounces-23442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D602AC4A75
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6417A4E85
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E124DD17;
	Tue, 27 May 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GOTYUoiP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A224DCEB;
	Tue, 27 May 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335342; cv=none; b=QkdCZCik7XLINvs7rW1ak50xTGHHko9ipCmlPbVTIOcX2wvYGswTdu0QKNad5FtOy799DsrUz5nH6tzStF/wbcaEQc2Esl9F1VMjQhnQymxOPveO/VBi2iafJbBdOPnZnl3JVkh7WhKpYdohSFCJvgtL3YdHVMObG+6wiqPouVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335342; c=relaxed/simple;
	bh=nVndev4+WoZyI/KcSKGCk0rfEs2ZhIK7wjjPQBbZ4nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A0MYRsx5QQkwP+eO77Rg5mkBdNJYD9qgXCDypBwQhKUSs7ye769u/Op9hz1imv2aq8vo+9h01sJSdrK0VLJ+DkZf1SlWF7gMFdVLqZ8EKz/IfAfu7xUtXsXUUMtM+FA/uocLIZt8nUG4CFYlnLQbOGPTKrE9U0cbJjyibNq3cVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GOTYUoiP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R3FSFK005190;
	Tue, 27 May 2025 08:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fos2bFgEpclUexn4EAdi3t6B56RBfPVmqrRk0f9F3Dc=; b=GOTYUoiPjqD7WzK9
	4OkxRP1RBDhI1TFPhmZ5wBCxUdUFE2oJ2w9AdVpKfCR6pMgiT47VrCqQU6CMK/PS
	8ISjYKYran6OhjuXHthvnIINqWTHX4up8/MFT3L2KX7V3yEPTMuB8U3AZAXTVssC
	VTOTc4tZmYyFg+OIzWoV8M54S6a+KBSRvRSaQxOfesww5VAVH5NkWiuttq0kyy+7
	2msSdGGlYpA8VcN7xMoGOkH1rFD3hcehubDzlByfaC3Xh1ditS3NGqfOYTe2/a0i
	5pIhtYrdTqw/VlhKR0KCbPp270YYU148WiMVnDwN1xsOiaTB+xduXMV4xY3Bjlib
	uor6ww==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u79p66n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54R8gBSg006172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:11 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 01:42:09 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Tue, 27 May 2025 14:11:45 +0530
Subject: [PATCH wireless-next v2 3/3] wifi: mac80211: Allow scan on a radio
 while operating on DFS on another radio
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-mlo-dfs-acs-v2-3-92c2f37c81d9@quicinc.com>
References: <20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com>
In-Reply-To: <20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qXe7aIMwYLZaiGbWwLD9zryKQQkK90CY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA3MCBTYWx0ZWRfX+Ie01IDg6rpG
 DdD642z8QDb76Fy+CuqvvzoCL6MwQE09tXRniBaCZH0LLlixBxBc4JyWXnw6IhJyQwNqu9yV1LR
 d6edjNheATqzVtVU/N5BNQIa67/OOWKFtpV5O5wQ831xtvageziEGiCx+k4HIx/yoDq3L+Wk8W5
 xHqcG61VcZvk5H1N3c2dJg/5sC3PfthddHJLmoq1llZLpYM5j2Eex9lXbwTq9kEomWPszwsfQq2
 aWa7w6MGUbKVJmGDmvHLJDLbwmbaJt3+ELxOwpX6eCfuzreY7Nn4pNdwaWmT5xyweyGl0ZPQbwX
 tuEBKuC3DLlI7INNqieLKAS/NygvvrlnOwTqkinQ8zNyuw2yY95yFS6uC5tboAcKf6UBKmi4d2J
 vsqDr//g1bhrb6me7UFCa2SIrpAG0zl4ZeNY2rol88rmiYb5IpMCTpEHo43Guj9uEBAIk2Wa
X-Authority-Analysis: v=2.4 cv=HNnDFptv c=1 sm=1 tr=0 ts=68357ae4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=6kngQRzwmQaPL7Ky5oUA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qXe7aIMwYLZaiGbWwLD9zryKQQkK90CY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270070

Currently, in multi-radio wiphy cases, if one radio is operating on a DFS
channel, -EBUSY is returned even when a scan is requested on a different
radio. Because of this, an MLD AP with one radio (link) on a DFS channel
and Automatic Channel Selection (ACS) on another radio (link) cannot be
brought up.

In multi-radio wiphy cases, multiple radios are grouped under a single
wiphy. Hence, if a radio is operating on a DFS channel and a scan is
requested on a different radio of the same wiphy, the scan can be allowed
simultaneously without impacting the DFS operations.

Add logic to check the underlying radio used for the requested scan. If the
radio on which DFS is already running is not being used, allow the scan
operation; otherwise, return -EBUSY.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 net/mac80211/chan.c        | 30 +++++++++++++++++++++++++++---
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/offchannel.c  |  5 ++++-
 net/mac80211/scan.c        | 20 +++++++++++++-------
 4 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 3aaf5abf1acc13008a0472672c826d495c80407c..94c83f58e23d0666af881e5e0c981cca17231bfd 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -644,15 +644,39 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 	return NULL;
 }
 
-bool ieee80211_is_radar_required(struct ieee80211_local *local)
+bool ieee80211_is_radar_required(struct ieee80211_local *local,
+				 struct cfg80211_scan_request *req)
 {
+	struct wiphy *wiphy = local->hw.wiphy;
 	struct ieee80211_link_data *link;
+	struct ieee80211_channel *chan;
+	int radio_idx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (!req)
+		return false;
+
 	for_each_sdata_link(local, link) {
-		if (link->radar_required)
-			return true;
+		if (link->radar_required) {
+			if (wiphy->n_radio < 2)
+				return true;
+
+			chan = link->conf->chanreq.oper.chan;
+			radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
+			/*
+			 * The radio index (radio_idx) is expected to be valid,
+			 * as it's derived from a channel tied to a link. If
+			 * it's invalid (i.e., negative), return true to avoid
+			 * potential issues with radar-sensitive operations.
+			 */
+			if (radio_idx < 0)
+				return true;
+
+			if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
+							       radio_idx))
+				return true;
+		}
 	}
 
 	return false;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7719d6c307fed5f44c9a5e35b8250c31daa6f523..9b9c7209878b076c5c3c09a78d067cf54d2d95a6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2712,7 +2712,8 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
 				      struct ieee80211_link_data *rsvd_for,
 				      bool check_reserved);
-bool ieee80211_is_radar_required(struct ieee80211_local *local);
+bool ieee80211_is_radar_required(struct ieee80211_local *local,
+				 struct cfg80211_scan_request *req);
 bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
 					struct cfg80211_scan_request *scan_req,
 					int radio_idx);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 2b9abc27462eb5a41f47523d1653c7f27137588d..686d9f6e9b527acaa3500e8d99d5ca513bb1025e 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -567,6 +567,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 {
 	struct ieee80211_roc_work *roc, *tmp;
 	bool queued = false, combine_started = true;
+	struct cfg80211_scan_request *req;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -612,9 +613,11 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 		roc->mgmt_tx_cookie = *cookie;
 	}
 
+	req = wiphy_dereference(local->hw.wiphy, local->scan_req);
+
 	/* if there's no need to queue, handle it immediately */
 	if (list_empty(&local->roc_list) &&
-	    !local->scanning && !ieee80211_is_radar_required(local)) {
+	    !local->scanning && !ieee80211_is_radar_required(local, req)) {
 		/* if not HW assist, just queue & schedule work */
 		if (!local->ops->remain_on_channel) {
 			list_add_tail(&roc->list, &local->roc_list);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 7b8da40a912d020f229a74c67bd5a57fb513a72d..e37a1281291e92b66bf983e8582adfbf50696b4f 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -587,7 +587,8 @@ static int ieee80211_start_sw_scan(struct ieee80211_local *local,
 	return 0;
 }
 
-static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
+static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata,
+				     struct cfg80211_scan_request *req)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *sdata_iter;
@@ -595,7 +596,7 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!ieee80211_is_radar_required(local))
+	if (!ieee80211_is_radar_required(local, req))
 		return true;
 
 	if (!regulatory_pre_cac_allowed(local->hw.wiphy))
@@ -611,9 +612,10 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
 }
 
 static bool ieee80211_can_scan(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata)
+			       struct ieee80211_sub_if_data *sdata,
+			       struct cfg80211_scan_request *req)
 {
-	if (!__ieee80211_can_leave_ch(sdata))
+	if (!__ieee80211_can_leave_ch(sdata, req))
 		return false;
 
 	if (!list_empty(&local->roc_list))
@@ -628,15 +630,19 @@ static bool ieee80211_can_scan(struct ieee80211_local *local,
 
 void ieee80211_run_deferred_scan(struct ieee80211_local *local)
 {
+	struct cfg80211_scan_request *req;
+
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->scan_req || local->scanning)
 		return;
 
+	req = wiphy_dereference(local->hw.wiphy, local->scan_req);
 	if (!ieee80211_can_scan(local,
 				rcu_dereference_protected(
 					local->scan_sdata,
-					lockdep_is_held(&local->hw.wiphy->mtx))))
+					lockdep_is_held(&local->hw.wiphy->mtx)),
+				req))
 		return;
 
 	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work,
@@ -733,10 +739,10 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 	    !(sdata->vif.active_links & BIT(req->tsf_report_link_id)))
 		return -EINVAL;
 
-	if (!__ieee80211_can_leave_ch(sdata))
+	if (!__ieee80211_can_leave_ch(sdata, req))
 		return -EBUSY;
 
-	if (!ieee80211_can_scan(local, sdata)) {
+	if (!ieee80211_can_scan(local, sdata, req)) {
 		/* wait for the work to finish/time out */
 		rcu_assign_pointer(local->scan_req, req);
 		rcu_assign_pointer(local->scan_sdata, sdata);

-- 
2.34.1


