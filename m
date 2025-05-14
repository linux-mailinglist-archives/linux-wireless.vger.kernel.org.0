Return-Path: <linux-wireless+bounces-22936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5CAB69FF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9C316C4AB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B027932D;
	Wed, 14 May 2025 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AC+NALNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7AE27780B;
	Wed, 14 May 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222131; cv=none; b=I9166lDUjCfK51giovtaUq67+7rthi39x7WAYsObC88Bp5gCw2BQ4o91qhi//TQUhvL2R2E+LyKcgEjBJrT3e0dbF0BZoRMG7S7GQkQecfBXOES4hm9QqBKYfB1Ov4dR3Ag3UHdc93INTi0UoRAIeue30Tagj3RmUBNJ4uONyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222131; c=relaxed/simple;
	bh=lWcMkKP5WjOJPIK1ZklGby3zm9tNmCc+vjZeevWrmDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=So1qdKYECinbGRhTpnZyO04S2M8z6766cOqTnsCGKohIlxN90/KqQa7R9GtvVAn9MUbCXNZDFgPmkWhxI6OK/9Qm1DHWbRI1J2F+Yf0lCW2FtILEDTZq5fWVc/CCaSvpH5ytV+wjqdo3Xxkjb3gUlfrrchvOBsZvNPcm25u+fLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AC+NALNV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuuHD030337;
	Wed, 14 May 2025 11:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FABUxBAB7ve6/Od0ovAZom4q3487/OGFf4YLme/fiAQ=; b=AC+NALNVzZlawFNV
	h5iBJm4nKhtNRefUwOFmV8qzAnpinLWU77oDvRIiLDg/lT1bQbjGisE6u/BmUD9q
	gHcJrulzcnDA8KEm/KjrmGiTH9Tnbu55sbOsDFQARQq1mTDEqwHjgTJ44FocZ7cJ
	oYhb2mn4/aMZTOzlXLiib1i3/D+Db1smEngO+cicpVHNUQZBHonIcwby8yCNitr8
	BixI2/GXcO6znE8YbE8HOe34P4IuTrkexfwoGk22D0j3torvtUF1HIDJyxirLVW4
	TMAnm6MesUVtPzZChS/0D4uAY3bsfzfSA3R8VgMjIpyTMSeKKvL4zpuM0bePU7Mz
	6knDsw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcntfua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EBSie2015868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:28:44 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 04:28:42 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Wed, 14 May 2025 16:58:24 +0530
Subject: [PATCH wireless-next 3/3] wifi: mac80211: Allow DFS/CSA on a radio
 if scan is ongoing on another radio
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250514-mlo-dfs-acs-v1-3-74e42a5583c6@quicinc.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
In-Reply-To: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5aDDtgtLu1q9DQPzOdBn8pIYhz6RSg_b
X-Authority-Analysis: v=2.4 cv=D8dHKuRj c=1 sm=1 tr=0 ts=68247e6d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Mksv0VV1BSGs6I7ZarMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwMSBTYWx0ZWRfX8v5nvwNvbql1
 UPsGjMLqnqEz8atvZFnGo0MXbbCPGeb7ZXQ5FriUvXlyVsfuKImKCGnsTWM2GzKnHldlXuLH0T0
 y7tShvCyUfQ0v5nIWAp4Qhov+f+GkHq2uXOf0wcQdujYXSPN+CkPgLQDjSWHGfFnccGL5+HVL/r
 0HCDgvKJw+bqPqsOPxPEZb1m6HESS2JtVDN+2LFpWvT1p6GDYC5gVhVtK9Js7hgYxwaxtFD/vHu
 RCJwbGhDGuikLGCayzk95Ae0tcwzw0quCfGCyStZvP/VYsRjpEZ+qVijuRmFUIYLP08CeK3qb3G
 r1syUK9UarpIOS1f0Nnbk68gue7AtfWD5LF2ElsFs0859NpJ0V5X+pcS+G/p8xRi9glXB6GeVAV
 OtDfzm8zW2XjQJCRomibUq4ocuZvX0saSjVeK53iIFDaSH+ROcHOvlBa+YQ4A4qXo4imMwzR
X-Proofpoint-GUID: 5aDDtgtLu1q9DQPzOdBn8pIYhz6RSg_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140101

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
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 net/mac80211/cfg.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2cd8731d8275b2f67c1b1305ec0bafc368a4498a..b76598abfb76708468432b3ec082955d4820e4a3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3549,6 +3549,68 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 	return 0;
 }
 
+static bool
+__ieee80211_is_scan_ongoing(struct wiphy *wiphy,
+			    struct ieee80211_local *local,
+			    struct cfg80211_chan_def *chandef)
+{
+	struct cfg80211_scan_request *scan_req;
+	int chan_radio_idx, req_radio_idx;
+	struct ieee80211_roc_work *roc;
+	bool ret = false;
+
+	if (!list_empty(&local->roc_list) || local->scanning)
+		ret = true;
+
+	if (wiphy->n_radio < 2)
+		return ret;
+
+	/*
+	 * Multiple HWs are grouped under same wiphy. If not scanning then
+	 * return now itself
+	 */
+	if (!ret)
+		return ret;
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
+	if (!list_empty(&local->roc_list)) {
+		list_for_each_entry(roc, &local->roc_list, list) {
+			chan_radio_idx =
+				cfg80211_get_radio_idx_by_chan(wiphy,
+							       roc->chan);
+			/*
+			 * The roc work is added but chan_radio_idx is invalid.
+			 * Should not happen but if it does, let's not take
+			 * risk and return true.
+			 */
+			if (chan_radio_idx < 0)
+				return true;
+
+			if (chan_radio_idx == req_radio_idx)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 					   struct net_device *dev,
 					   struct cfg80211_chan_def *chandef,
@@ -3562,7 +3624,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!list_empty(&local->roc_list) || local->scanning)
+	if (__ieee80211_is_scan_ongoing(wiphy, local, chandef))
 		return -EBUSY;
 
 	link_data = sdata_dereference(sdata->link[link_id], sdata);
@@ -4054,7 +4116,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!list_empty(&local->roc_list) || local->scanning)
+	if (__ieee80211_is_scan_ongoing(wiphy, local, &params->chandef))
 		return -EBUSY;
 
 	if (sdata->wdev.links[link_id].cac_started)

-- 
2.34.1


