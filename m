Return-Path: <linux-wireless+bounces-26294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54702B21F6E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 09:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC93C503AB9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9D02E2821;
	Tue, 12 Aug 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HU0K5DgF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FA2E11D5
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983430; cv=none; b=SXzf40FJhLySNIxSP3GagicTLj+b3Ck1R9SENEekyxvvTTV8Mtg0G6AqoydEvG/a5osUj+UhXXj9DywAAuECzIv6cB2FvXk8T3au9rVjDSrmwOxVsEhexsfsqfbw1l4Y/H1hzRMMkqBaKgdFzAxSh9AfrwsWe4N+CMVy3zi0d4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983430; c=relaxed/simple;
	bh=dlXqNiiTKDdVHbbv9I6JqgnIh525x+Ab2rqKF3BF3eQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bprI2xv4lzp2TSxm9NARHbDEl7lZO6iWzNN81o7RTWeR5MhcO6Edcpwx8qR3iy6xNFsXb9nSpfh1WWch6wXgsfvUn43jJqN/JPIo+/uu7y95C6dtq87vcYCZmyrSvbH4X//DZOBjvSL5IT5XkbnWmw8qi9k9uPpKqONY5IkwjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HU0K5DgF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5ZU6t022560
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M07C5PvjL2mzdd0lFp/tl49J1J/XjIm7qCAeGhKu034=; b=HU0K5DgF4tQyHvDF
	DfSVU79+BqO/8EYK9o6N4G4eJUCLbGP04yN38NTEmzeEro3NdiY9SpNFW2ncHxZF
	q1JpBLuwuajHIgpHknpZ3deRL6Q1VSotkdxodjsCG4EMBqHij+u32Q8Y73Oi0Ifi
	MhBokXMRqCyPG/GA+3K2IX0w2LEuTRm0tl6hL8VhbE6vYDFp/Z13HFmz2A4ThVAO
	3C/LTSMo3usoAatMdllZtxSvjL4zN2VvGms8TWs/MCPAP2v+lV5c00vkjyUYXfbs
	SQHrKh/9TRMfg/RhhrOgrcg4XtIMCN5I5VlSF7bCawzSQ3rcDZ6Lqb4fSroZHfxK
	o1PlQQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vj34r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-75ab147e0a3so10681478b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 00:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983426; x=1755588226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M07C5PvjL2mzdd0lFp/tl49J1J/XjIm7qCAeGhKu034=;
        b=f4psKpyVbQIEq+jGNdGWk+sKGY+4eJaYS1A/yNdkeZYvlHInoGxTRUgsJl6gFRSpLb
         hY7/b4DiTpHiQaMAWCDvBy7Mc2ylLYtRCo9bHbLGWqwA03yQUbrF3DPOBis96Imvno5k
         1qUWsFfs5Wx3Ulu27iHwOsYi2jrReKZABXM3q7HyQkkCLqJ4Yq8athHKUOgf2CMFnsoo
         qXfiDGMTXl9F+mS36X/fTHRvGaS1UNDoAS2jkYv1DTf35xM+gl8dFe9r75aFzByWjXQG
         BQItiW6rrd4cFY0nbOaL7HVDk9fLkUbuOFmashe2MpV8ZRuG43OMt+Ko+LyhfRHcuzbA
         XECA==
X-Forwarded-Encrypted: i=1; AJvYcCWTIBgzUaVmG2HdZuZ+pT7x3377uF8F0vA2njDXXfomUe05UFyURnzj8F0mrJHzQa5LDS9G5Jg4PHQ7YNVP3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0G0U5jXplc+UvwFv0QURBU6b2W1DRePsh9+NuQUFDlOdhm4ZS
	zOgJIKyr28cikrkcoed0hW9XS/CtOo3YWMm+253FsykgIzFhsG/OdvrNQriF/ByJmvIUNP1foY0
	9f1odbGHf+5T9k4DC9yFRrVJdmtPGVOnObPHqaTs5cr7zyD87zULhtCOYD9QuX1qdMlar3QhEW8
	zq8w==
X-Gm-Gg: ASbGncv8atV+pFWa1eb/d8uXHhSYDot8IGiy4G/pnRzL7RqblNF1goBNBsmxIab3ZaG
	hMvbMO2kIVQ8Wkrpkhatj6+9JBv5uZIsNCCxACHd0avIHRRjUeMgJ0tsZAyTHkzvhk77s1bR2Yt
	yWK+ClTfViQPuMOJmgMSGnj+5RPRJuH/2ykkQpiDllD/XBX+56NODNXVBnIKQI7z5NOVTSAcmOo
	Smir6FwVzJYLJF8KmBTXm2U//mJzfgV8UXZVuC7AzoJbJcmDBpUoadg+ZFqj07fWvzufMHgxtFc
	067X6XEEo7TEPbRt51C9HjM6k1lXVLFoANGs1JmK+S3caR393EcXQD/SW5fbyX7yd8WCnQZLL8f
	D5BkcirUbRbkAmH53mo6S0EGPdJSuOFVsHrJRxFPn4qJ6qOwmTE6UNCzzuVTurtPu
X-Received: by 2002:a05:6a20:3943:b0:240:1ae7:d918 with SMTP id adf61e73a8af0-2409a9ed58cmr3795767637.45.1754983425825;
        Tue, 12 Aug 2025 00:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES1xXCu5aUaNjvzm/8zEPHcm0APCLCLG9HjMswe88gdDOplMJhkGlfUk+xwl7iu/ggw4yNLw==
X-Received: by 2002:a05:6a20:3943:b0:240:1ae7:d918 with SMTP id adf61e73a8af0-2409a9ed58cmr3795726637.45.1754983425385;
        Tue, 12 Aug 2025 00:23:45 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm24547338a12.52.2025.08.12.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:23:45 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:53:29 +0530
Subject: [PATCH wireless-next v4 2/3] wifi: mac80211: simplify return value
 handling of cfg80211_get_radio_idx_by_chan()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-2-383ffb6da213@oss.qualcomm.com>
References: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
In-Reply-To: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX9VD2cnqRSkSE
 hoWlm95XHAinZ3cXQpDkFfHOTfpG5WX2P/FWiTnSUEiCEXvELAUdHY79ssJEDniPqMj6gamidbY
 iim5rSpBksswQkjOCJAc7U75BXAUVkAQa6lUP9nII1IvR3H2aEcOXdS9zjgjVe+uTB5+YVct1by
 KaX0WO76LTnuYCRlQY7U1zZJVhLWLXzuXhoW5Qp48DNgzAKcFkD+jTgOWKp74U4cZxLAc7HVUst
 hSKRJ1pBPxUH61ieFbzWj7MaRBLuCNxgkJjMerSD60n72Ux7y5oODjA9McKWUNxEB5xjeuiN7Z3
 qgococepcSFKnJC3rj4r7bb/NJHMuCGXwvSqyDsXwb9MhJqB8GCc38pXdgTY7YjYn42p222YRMc
 ZuD5sz1z
X-Proofpoint-GUID: XxHjOpEWZbHYb6zBh5ryu-Bdi_0Grgqj
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689aec03 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=JbWyVvrk7yFLVdDgZQ0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: XxHjOpEWZbHYb6zBh5ryu-Bdi_0Grgqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

In several instances where cfg80211_get_radio_idx_by_chan() is called,
redundant checks are performed across function — such as verifying if
wiphy->n_radio < 2 or if the returned index is negative. These checks are
unnecessary, as the return value can be directly compared. Moreover, the
function can be safely called even when radio-level properties are not
explicitly advertised since in such case in each call it is going to get
same error value.

Therefore, simplify the usage of this function across all such cases by
removing redundant conditions and relying on the return value directly.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c  | 13 -------------
 net/mac80211/chan.c | 11 -----------
 net/mac80211/util.c | 15 ++++++---------
 3 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2ed07fa121ab73d3afd2f841eb53e6cdc0be91a3..d4100d046442a51a0baf42d6ab3b921302d307f7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3677,12 +3677,7 @@ static bool ieee80211_is_scan_ongoing(struct wiphy *wiphy,
 	if (list_empty(&local->roc_list) && !local->scanning)
 		return false;
 
-	if (wiphy->n_radio < 2)
-		return true;
-
 	req_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chandef->chan);
-	if (req_radio_idx < 0)
-		return true;
 
 	if (local->scanning) {
 		scan_req = wiphy_dereference(wiphy, local->scan_req);
@@ -3701,14 +3696,6 @@ static bool ieee80211_is_scan_ongoing(struct wiphy *wiphy,
 	list_for_each_entry(roc, &local->roc_list, list) {
 		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy,
 								roc->chan);
-		/*
-		 * The roc work is added but chan_radio_idx is invalid.
-		 * Should not happen but if it does, let's not take
-		 * risk and return true.
-		 */
-		if (chan_radio_idx < 0)
-			return true;
-
 		if (chan_radio_idx == req_radio_idx)
 			return true;
 	}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c9cea0e7ac169839f883f73186b575eacfe55db5..57065714cf8ceb5e612705ddc913b90c1f296e2a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -659,19 +659,8 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local,
 
 	for_each_sdata_link(local, link) {
 		if (link->radar_required) {
-			if (wiphy->n_radio < 2)
-				return true;
-
 			chan = link->conf->chanreq.oper.chan;
 			radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
-			/*
-			 * The radio index (radio_idx) is expected to be valid,
-			 * as it's derived from a channel tied to a link. If
-			 * it's invalid (i.e., negative), return true to avoid
-			 * potential issues with radar-sensitive operations.
-			 */
-			if (radio_idx < 0)
-				return true;
 
 			if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
 							       radio_idx))
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32f1bc5908c571416df905bdda1ba54dd7b41f33..51e3e3c913f7f9faa4a0283c0aa9509efc805391 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4022,16 +4022,13 @@ bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
 	for (i = 0; i < scan_req->n_channels; i++) {
 		chan = scan_req->channels[i];
 		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
-		/*
-		 * The chan_radio_idx should be valid since it's taken from a
-		 * valid scan request.
-		 * However, if chan_radio_idx is unexpectedly invalid (negative),
-		 * we take a conservative approach and assume the scan request
-		 * might use the specified radio_idx. Hence, return true.
-		 */
-		if (WARN_ON(chan_radio_idx < 0))
-			return true;
 
+		/* The radio index either matched successfully, or an error
+		 * occurred. For example, if radio-level information is
+		 * missing, the same error value is returned. This
+		 * typically implies a single-radio setup, in which case
+		 * the operation should not be allowed.
+		 */
 		if (chan_radio_idx == radio_idx)
 			return true;
 	}

-- 
2.34.1


