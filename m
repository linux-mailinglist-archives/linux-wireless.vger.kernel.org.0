Return-Path: <linux-wireless+bounces-23441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4865EAC4A70
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08877A4D0B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9324DCF5;
	Tue, 27 May 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j6Jj1irA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D91F4639;
	Tue, 27 May 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335340; cv=none; b=nI1kcfAnSyElo9HrZ4aqvbhtrKrvv4K0cMNWA1mCO78bYtWyMUsWKGc/EGwnTkaHSVkNQGhoye5r3J7YVZAECpDWxZpZYQ143WRHaZDObuDJPQzRaJTX/csP5vmBwf3HnberuB4nSTzRkHK5ba72KpcAiDmT9QDpGxwbLiHwH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335340; c=relaxed/simple;
	bh=d2MR+zhqZHmxXPSNZyM/WcNvG7scVSHoFI7w3VnaXo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FHvWAjd9FjO9l2aFCQtBmnX1WMIPvS7nsD1e4/YOWkdtQeir5svzibdTHny5MG6bu5qDAgfiAkGbq162BgC1lqhFIddheO7Y4F9IR3DOYyLqnLgAZBbTLE+DnHaT3OJud72AYcrqnrSt1/wkdHKhwJmzPkeIeayqaA8Sh8Lt/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j6Jj1irA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R4U3Jc025125;
	Tue, 27 May 2025 08:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mhD2FuS1XDZe/4BI8aUhAdOOjyCwW4qTekwCeP62S0g=; b=j6Jj1irAKnF7u4yy
	VI+yTCrTdHUYmBK5j3ik8Ah5WWhZCosEEqogRo26SZhVkJS6dHlsL3MsfItxa40z
	PsB/cBhMZ3DwRRI6codht+SpKiFxWW9CCvft0QaqWwx/42+mvubVrZCKi80fCrhV
	W7cUFxAMXvNwNtv56UElR8hllUtoxyRZLbgJejmHM7mmJp3flWsbgn0IOUoCkcW/
	TMM4ZEhYnFcQrPmYrR4oulNtRiX2pR/Q8AxnKJKRxNyY6WXuORQU5n4FZ/xaVUbW
	Ldl8V0GPGf02qY7nJsMGfGuSlfTnkr0ZH+VB3+BVpiu2m7XF7Tm9wRTwAbsUorPp
	Orpkuw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u79p66n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54R8g9eB006107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:09 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 01:42:07 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Tue, 27 May 2025 14:11:44 +0530
Subject: [PATCH wireless-next v2 2/3] wifi: mac80211: Allow DFS/CSA on a
 radio if scan is ongoing on another radio
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-mlo-dfs-acs-v2-2-92c2f37c81d9@quicinc.com>
References: <20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com>
In-Reply-To: <20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Aditya
 Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EHdOPiOF5f692_VWVtAb49X2SFeEUbrK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA3MCBTYWx0ZWRfX6PNO4DHvwLWo
 a77zu1r19PIhfrF1mD9YGk05ifL1zzJo/VSNBDqOkfRkGP8uo83OleRc2ns1q4uffRUVBo7X5Mg
 HHkLQ2b6q4eEIRRNvJJmAGi8UZWgNmE3CPVyxtxjU3JjbCy/zPdEY9RqxJvebwq1vmuMpR/9SYo
 OfBkY+PlhZLQg79mhsd57qtFZcW8Ee1ysgWgy72vTE/0GUA9mEHdoydsUj5PVZtcgToEl6rmIsI
 Ka53lRY9ogN/U/zd4FkyTEffGZyizIOUikhUJsfZgiFjI3OEXKtBcwmaXyGqhPsBlmxlh9gxVOb
 kqhpK4ob2yA+FoxZGJhoPGm/4IYl7X5IfhHH+Rpu9kxD349SQUKCdVrCFIcGDd21lFpo6kWn3/4
 ZF7d0U6YrEPGCGqJPGZ/Ugjff+aIAeiSST6LKM2cagw59BjRRsZxCvyexUK9hBZBoV7G0eDJ
X-Authority-Analysis: v=2.4 cv=HNnDFptv c=1 sm=1 tr=0 ts=68357ae2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=i7suQ1YZypGL9Jg2cBMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EHdOPiOF5f692_VWVtAb49X2SFeEUbrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270070

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Currently, in multi-radio wiphy cases, if a scan is ongoing on one radio,
-EBUSY is returned when DFS or a channel switch is initiated on another
radio. Because of this, an MLD AP with one radio (link) in an ongoing scan
cannot initiate DFS or a channel switch on another radio (link).

In multi-radio wiphy cases, multiple radios are grouped under a single
wiphy. Hence, if a scan is ongoing on one underlying radio and DFS or a
channel switch is requested on a different underlying radio of the same
wiphy, these operations can be allowed simultaneously.

Add logic to check the underlying radio used for the ongoing scan. If the
radio on which DFS or a channel switch is requested is not being used for
the scan, allow the operation; otherwise, return -EBUSY.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 net/mac80211/cfg.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/util.c        | 27 +++++++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f283120ba366401d3ac546e59d8c61c21..55a8fbd255148b3a40d9239f5bfd4c7e6619c0c7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3549,6 +3549,56 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 	return 0;
 }
 
+static bool ieee80211_is_scan_ongoing(struct wiphy *wiphy,
+				      struct ieee80211_local *local,
+				      struct cfg80211_chan_def *chandef)
+{
+	struct cfg80211_scan_request *scan_req;
+	int chan_radio_idx, req_radio_idx;
+	struct ieee80211_roc_work *roc;
+
+	if (list_empty(&local->roc_list) && !local->scanning)
+		return false;
+
+	if (wiphy->n_radio < 2)
+		return true;
+
+	req_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chandef->chan);
+	if (req_radio_idx < 0)
+		return true;
+
+	if (local->scanning) {
+		scan_req = wiphy_dereference(wiphy, local->scan_req);
+		/*
+		 * Scan is going on but info is not there. Should not happen
+		 * but if it does, let's not take risk and assume we can't use
+		 * the hw hence return true
+		 */
+		if (WARN_ON_ONCE(!scan_req))
+			return true;
+
+		return ieee80211_is_radio_idx_in_scan_req(wiphy, scan_req,
+							  req_radio_idx);
+	}
+
+	list_for_each_entry(roc, &local->roc_list, list) {
+		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy,
+								roc->chan);
+		/*
+		 * The roc work is added but chan_radio_idx is invalid.
+		 * Should not happen but if it does, let's not take
+		 * risk and return true.
+		 */
+		if (chan_radio_idx < 0)
+			return true;
+
+		if (chan_radio_idx == req_radio_idx)
+			return true;
+	}
+
+	return false;
+}
+
 static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 					   struct net_device *dev,
 					   struct cfg80211_chan_def *chandef,
@@ -3562,7 +3612,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!list_empty(&local->roc_list) || local->scanning)
+	if (ieee80211_is_scan_ongoing(wiphy, local, chandef))
 		return -EBUSY;
 
 	link_data = sdata_dereference(sdata->link[link_id], sdata);
@@ -4054,7 +4104,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!list_empty(&local->roc_list) || local->scanning)
+	if (ieee80211_is_scan_ongoing(wiphy, local, &params->chandef))
 		return -EBUSY;
 
 	if (sdata->wdev.links[link_id].cac_started)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 30809f0b35f73e77b05a6f802011a64900e1532f..7719d6c307fed5f44c9a5e35b8250c31daa6f523 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2713,6 +2713,9 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				      struct ieee80211_link_data *rsvd_for,
 				      bool check_reserved);
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
+bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
+					struct cfg80211_scan_request *scan_req,
+					int radio_idx);
 
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work);
 void ieee80211_dfs_cac_cancel(struct ieee80211_local *local,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd4bda40d2a37b14da6a4aa6bf0a02..ea73a38fb8665ec7179289771f44e8ba3abef5f7 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3953,6 +3953,33 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	return radar_detect;
 }
 
+bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
+					struct cfg80211_scan_request *scan_req,
+					int radio_idx)
+{
+	struct ieee80211_channel *chan;
+	int i, chan_radio_idx;
+
+	for (i = 0; i < scan_req->n_channels; i++) {
+		chan = scan_req->channels[i];
+		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
+		/*
+		 * The chan_radio_idx should be valid since it's taken from a
+		 * valid scan request.
+		 * However, if chan_radio_idx is unexpectedly invalid (negative),
+		 * we take a conservative approach and assume the scan request
+		 * might use the specified radio_idx. Hence, return true.
+		 */
+		if (WARN_ON(chan_radio_idx < 0))
+			return true;
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


