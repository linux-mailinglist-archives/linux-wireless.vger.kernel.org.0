Return-Path: <linux-wireless+bounces-23074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD556AB9A36
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856C97B0747
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3A481C4;
	Fri, 16 May 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mg7J3dFb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466023373B
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391545; cv=none; b=lONwLbk34j3MjEH4A9+9xnWK1kMgN/y2pvn/hgnSTp+yRtNZlL4kGS2aNV0kGl2peXyMQFHgcgpDRc1+LWZYnMtb6s995/DZARU9oxP1wSirbs4BmrTmpx3XW259u0AQnStCio1ODXBr3TA6q+NwAVP8bEv6qVgIGo2a587dmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391545; c=relaxed/simple;
	bh=/C0zCFlmoCu6SwB6lcoMtilSssRPYWVKRmqyPdOjwR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEnr+eCrCV1QBkB4mh0N/v5owBTqw8qJKL6tCeMDqpbLmsFNKBCDcmzb2peBWipV799HBQhvzPW5FWCWqcI7UdMDSeG4SWM2n4GdjXRIZBd9ytHDeiBuOUJUNy32iOZjZ5BHjXMFXZioawx+9MLgWaKhljjgJ09q4fb/Nobub6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mg7J3dFb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G3HJUt026254
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xe4JJpZYL0oQKo4qYAE5I1ncsvjogZQwLUp9nB2aP0=; b=mg7J3dFbSef0ZfRT
	LdOHuus7faZ4JxMkfU8Hg2DHOu+wvy2UOzX7b3KEPfHhpzK3mYfHGOXniDbvA0co
	I3qLz6TFTKVwRtrc6jojmp3QGtvKCnk8pNxwNMUK7n3wglnCDilnmGoIMCnZ0wXy
	nFFsKM1PyLn9TuZgWCdMJFSZupmVdKXBdaMOfvWLXkoTK2IBkU+J2HxhFXUle+97
	kj2R64eh/X+32jtNy4C9VnlcpJe7Zyoih22kZF82yURERhk60jk+LwAxofgdEl3c
	v5IHAbdpN/JmuC3zfQEGSvsgEo8vse5HYC3PGURN1pngu8LdbwdD33bcEy+fxVkH
	hsYoWg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyst8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:32:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso1575482b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 03:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747391542; x=1747996342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xe4JJpZYL0oQKo4qYAE5I1ncsvjogZQwLUp9nB2aP0=;
        b=rM7XhRwdi9MJs/qoXt07W3s9/Dcn1aYbixkz2KdECmce5gsMO0AP6/unvWSBQbZF4i
         aicEWdwhVsQ9rtwIN/nNE4v5hyETRVnr3yGRRzqn9T99vLm6SXNdnaXjOxDzy94kUOHG
         wNzx+3eQMhoFtqNXSnMKJrTH6dBn4K8T1WmQaMjdROdeyx+BgFmBlEZh4Hzvyr3dcqts
         PEusDrZIML3MEvWSOciU5I59k/eXamhuRMou91UCP9kJoOwB5GfLxJ+1Zas3xW2N7Uc9
         yuTPe2fBpmXAAzuPLBVY0alayJW627pco3jMsu2Fs2yaKawv3jRhrtEjRs1DvYTzQ2+P
         pGTg==
X-Gm-Message-State: AOJu0Yy3cUTJAlWI1LQC/K5Aw6aUANvvjnzDLcYH3o7hr+sIdktGK7X4
	h5s2pL8OthyGojjdPiGemXgpGDLsn7iUuNNzEaYfp++ohn9xE0G6OXYm9wuBznAxRWw5zOmugnA
	TVFpkYEQZjtHsmuCDILpBKapCrT+VSL17eE6r/j0vKiAGZqsL5pCrZgVB4BpCH3fyvZbi3A==
X-Gm-Gg: ASbGncsgUB8dF8z3FDLBTcKBnhfsX3eNeNvQizAyRVdbYnlhlTwGf7vPZcrWEz00iK/
	QH4+RqmlYuuhM/7a/gS8O1YdUdhIUp4mpAqOOD5p1VCqnizWIFKN+VN1i3gk35QYYlOCq5kcR6E
	kz36t0jLTL0TtlpQpw0E08D+PBGBXxiEgPmLkUOe9A6xsKpxFBzQUHHi/que3uFykXSxC2/5qIK
	fZJAtEjQWLOaaHNNB+CVCI6S430KxPsS1gYxtcbYxkxZl2yflH+a8yHFG6TjdAMhJTt5RmJQS+Q
	DhMl6R+lk1hKM340VTV5VwHPycqZeZzYhKnGVDtkN4VyFlqoJJb/z5+K53ub2FMiXsuTMQjwwj0
	EHNR+V67kRzcNEh6+Kwg9tWYbePsWYcNzzuRX
X-Received: by 2002:a05:6a00:8593:b0:732:2923:b70f with SMTP id d2e1a72fcca58-742a97bd16emr3417935b3a.11.1747391542048;
        Fri, 16 May 2025 03:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw+3bj0H7s+N+1VhN7TU4jcgdq8iHHxRkKSKdccszazRmhKVDHpqKbGq8N2Qh/FdfH7ixzfA==
X-Received: by 2002:a05:6a00:8593:b0:732:2923:b70f with SMTP id d2e1a72fcca58-742a97bd16emr3417899b3a.11.1747391541597;
        Fri, 16 May 2025 03:32:21 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986d8d7sm1247585b3a.130.2025.05.16.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 03:32:21 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 16 May 2025 16:02:07 +0530
Subject: [PATCH wireless-next v2 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-bug_fix_mlo_scan-v2-1-12e59d9110ac@oss.qualcomm.com>
References: <20250516-bug_fix_mlo_scan-v2-0-12e59d9110ac@oss.qualcomm.com>
In-Reply-To: <20250516-bug_fix_mlo_scan-v2-0-12e59d9110ac@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: x1AbuvAfDbnCEdVBubdxunuQgOAVar_c
X-Proofpoint-ORIG-GUID: x1AbuvAfDbnCEdVBubdxunuQgOAVar_c
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=68271437 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=DDi9Blm5zKVmG00JEVUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwMCBTYWx0ZWRfXyiPhKstpQkIX
 mraye4n0pDShMTKGBS0zyzqpOx16MnwLPb7FV+EHyxD82ss6vAAFyAfZP/zNCbLQTMfv1/BKiON
 6mwz2O0xOW3Cq0EMOSQdf5Mf8u7CycAr38wgQK7YYcYDePpQXYRpRKBSkejeyR6QV/UTRULvqcj
 c+8VHAkFOTMmAeDtFehKjzqYga6iuHcChrTNqTwc5l7+tMegKQ6OzeaAOQLCJ2O305IwJZu1Ttv
 G/3zQbSJeBQ5XbseunnjT4DxG6nBqhjLuGcKmwEUyNWJPq/Sb3pVQPvjliGDdSL4NSIlcToFzVi
 Y5fMkQpAAUPiVVmBwKZ4DXU5hMDvwHz83a118pLez+5YRHwQh0mhGskvjmBeqWRMVrSzHqOVTeP
 ZcJz2lusy1DVtSVo+HlLMGemXSLSiKcV96m1PJ4GZ62k1gDG1WMg/1beLIAN6LFCpY1zJ0pK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160100

When an AP interface is already beaconing, a subsequent scan is not allowed
unless the user space explicitly sets the flag NL80211_SCAN_FLAG_AP in the
scan request. If this flag is not set, the scan request will be returned
with the error code -EOPNOTSUPP. However, this restriction currently
applies only to non-ML interfaces. For ML interfaces, scans are allowed
without this flag being explicitly set by the user space which is wrong.
This is because the beaconing check currently uses only the deflink, which
does not get set during MLO.

Hence to fix this, during MLO, use the existing helper
ieee80211_num_beaconing_links() to know if any of the link is beaconing.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 05b7296b152cfbe1e81f8981eee52d72f711706c..d9d88f2f283120ba366401d3ac546e59d8c61c21 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2924,7 +2924,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (sdata->deflink.u.ap.beacon &&
+		if (ieee80211_num_beaconing_links(sdata) &&
 		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
 		     !(req->flags & NL80211_SCAN_FLAG_AP)))
 			return -EOPNOTSUPP;

-- 
2.34.1


