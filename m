Return-Path: <linux-wireless+bounces-22935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE25AB69FD
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA553A4EEA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5F12777F9;
	Wed, 14 May 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S0i+r7Nc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C26275853;
	Wed, 14 May 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222129; cv=none; b=o9StSpU4aIpXpj/586VQlCM5zKeIQXgd9TNpCqABD30yfa0PoWXUlTYk8PpUi2Kwy8EQ9Wq/I+1PGxyTao2wQs8yoyjiuZiMKHJrhFhazPKma1PKhopoozNGsg7I7LKhLQAJJmnkJWkdB1lQEzN8sWWrI9T/mOdapihC+aw/FyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222129; c=relaxed/simple;
	bh=gaYxSYpTCztvIpdVfbu1698zQwGwlaRTUe4BF4iN56Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kuqgVEvrJI0zKjkL9e1gkPLCG4QQhiZfbvT+AQxtFtIH47/dYDiPz97ZbMoro/AtcpmWTtfvHWeBAUDLSFx7cr11HI5upBK79oDHysUW2YAbq2ZMvfHMVKPNqNEyGiq7Vglx/r4Ia07llB3fNJOc47CimGnjMRxqi/RzperHaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S0i+r7Nc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuvse030369;
	Wed, 14 May 2025 11:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zc8e1OD7sKThUf2M9gNxZjl7oWYLVmRILx6K3MDIRaM=; b=S0i+r7NcfJPUZghP
	3xAyF7w/BWlA23MW4L0q6G9p0p57mmblplf1JZ/W64uogYIUu0Nt8hCH7uzItirD
	CzSuhaNigEDn8myceQMgpTHElY2PBgMRPz+OWwwUE4kBN4FbgaH8J376EQW1Y/rG
	5eKhHGTGbVcTO2mov7ndIbOvmeuMbz9DXNGZSTJx2oZITaLXbMWJJQGq2IWT0/sy
	1DvEjZCRLkG7oGy1n95xMgm9m3ezcPkP8tdhkhwpyIH2bLwaGSiEJ8/Y7MFu4vsG
	1mSZdUki104yCIulTC8ETD5r0ocfhjUqR0crlhW7uYjTRwVLSoK/0Il2tswJcmG2
	qEC3gw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcntfu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EBSgJb015831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:42 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 04:28:41 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Wed, 14 May 2025 16:58:23 +0530
Subject: [PATCH wireless-next 2/3] wifi: mac80211: Allow scan on a radio
 while operating on DFS on another radio
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250514-mlo-dfs-acs-v1-2-74e42a5583c6@quicinc.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
In-Reply-To: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bV8BjPLPTkxEkeA_QvdVwKeSSVNCls8P
X-Authority-Analysis: v=2.4 cv=D8dHKuRj c=1 sm=1 tr=0 ts=68247e6b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=1xQt9wC9bBglAwZFKj8A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwMSBTYWx0ZWRfXzEY76TfOgQWf
 dwaaaxjbTJ/uR6dKZZJ78cDq0GfQn/p8MCY98LPf547BjJj7J8SUlZKPw77C6u/nUu5OQX++ieb
 tRjLZKPxuAkBoB5r7AqnIxG/Mdu3Rn2olAw+1J/dI4AbaToBRck+Ajb5sHhYqLJuwZDGLYeOmzx
 YTzCmEll2uvN/wAG12Uuwp0126WvKCzkv/X2tRhBB75/I9NMIG7ZkLZgK3BJ4rjyricUoj98qUy
 HFHhTveqXEVeAXng36X4HohnrYtTczoIs7pM1BSqAE8ekEd9irKokRJ3bG07JroXEHrb3SdeDay
 e57dybdNtAcT3MIW5qcP1C85LiafMbDp9PFBsqRkHqEmBohQ8tnRp6ruUhHlBTyjiMgzwR4BqbV
 7Al1Cg8aptm+Ic1uDp9uwjCBRvkXKyw/Lu0qxWZ3x9PFxfrtVTkK/shxZV87AA6DYaESpNmm
X-Proofpoint-GUID: bV8BjPLPTkxEkeA_QvdVwKeSSVNCls8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140101

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
 net/mac80211/ieee80211_i.h |  6 +++++-
 net/mac80211/offchannel.c  |  5 ++++-
 net/mac80211/scan.c        | 20 +++++++++++++-------
 net/mac80211/util.c        | 28 ++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 12 deletions(-)

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
index 30809f0b35f73e77b05a6f802011a64900e1532f..a5050e3025b795a1c2a24f1a370ef7e05c2fde6a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2712,8 +2712,12 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
 				      struct ieee80211_link_data *rsvd_for,
 				      bool check_reserved);
-bool ieee80211_is_radar_required(struct ieee80211_local *local);
+bool ieee80211_is_radar_required(struct ieee80211_local *local,
+				 struct cfg80211_scan_request *req);
 
+bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
+					struct cfg80211_scan_request *scan_req,
+					int radio_idx);
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work);
 void ieee80211_dfs_cac_cancel(struct ieee80211_local *local,
 			      struct ieee80211_chanctx *chanctx);
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
index cb707907188585d6874bf290874bdb0ca33bb399..6947a7ede51c990af97ed875017c3e4d351f1cd9 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -571,7 +571,8 @@ static int ieee80211_start_sw_scan(struct ieee80211_local *local,
 	return 0;
 }
 
-static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
+static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata,
+				     struct cfg80211_scan_request *req)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *sdata_iter;
@@ -579,7 +580,7 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!ieee80211_is_radar_required(local))
+	if (!ieee80211_is_radar_required(local, req))
 		return true;
 
 	if (!regulatory_pre_cac_allowed(local->hw.wiphy))
@@ -595,9 +596,10 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
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
@@ -612,15 +614,19 @@ static bool ieee80211_can_scan(struct ieee80211_local *local,
 
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
@@ -717,10 +723,10 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
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
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd4bda40d2a37b14da6a4aa6bf0a02..0c43216fb7a1b0941349be760c331045d2cf9101 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3953,6 +3953,34 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	return radar_detect;
 }
 
+bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
+					struct cfg80211_scan_request *scan_req,
+					int radio_idx)
+{
+	struct ieee80211_channel *chan;
+	int i, chan_radio_idx;
+
+	if (!scan_req)
+		return false;
+
+	for (i = 0; i < scan_req->n_channels; i++) {
+		chan = scan_req->channels[i];
+		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
+		/*
+		 * Skip channels with an invalid radio index and continue
+		 * checking. If any channel in the scan request matches the
+		 * given radio index, return true.
+		 */
+		if (chan_radio_idx < 0)
+			continue;
+
+		if (chan_radio_idx == radio_idx)
+			return true;
+	}
+
+	return false;
+}
+
 static u32
 __ieee80211_get_radio_mask(struct ieee80211_sub_if_data *sdata)
 {

-- 
2.34.1


