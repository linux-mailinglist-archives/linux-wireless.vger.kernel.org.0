Return-Path: <linux-wireless+bounces-22870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12AAB3BF0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 17:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF2A3AC944
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E7B66E;
	Mon, 12 May 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RfFx15G+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABE1DE8A6
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063403; cv=none; b=eFUkYwgBDxbvuiVs6l6wK3lAd0hFZjgucPLtqgoy1T8WT5BFvyS1VhU4/W/JteIol2WfEqrqRns3YuwosKXE1uxUnGiFMhuhW/dW3hRVk7kPhqdRTwZ2boW0SbYLajZPlG0B3wLPKDHO+895GxSNgt1QL0e2NQkU1iHoL4xQVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063403; c=relaxed/simple;
	bh=nGqTgJgJJarcgWnfChPOqPpuxbS9prEWZ3MU7ZEHgj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iOEXghnNoptcblGZe2y+ZM3d/1b2MQMNMTK6aaj9C4mqWF47NUAO8hMMrpXp0vWrdIe5WaMPskMO4p5jRG5uvBw9971OP5pOOu9XicIHkWtXMtOUe4NOXyTuTYYvw5xx9QT8jn40jNy35rjZ3SUBHKBMVeSXKIqmT4ANFSenTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RfFx15G+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C9PaRt019935
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 15:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zrQ8HCH0L6bcF6OpRumggZPbii/H5c4lVW7
	jizG6qnY=; b=RfFx15G+/Xuxp7RkCRHTewcXM65zfLwrWTQvHyQvX45aoEAQcHj
	u29poMpk49En/MXIgLPvBw9TklEWia+joI9yh5gC8zkNX2RBmRQ0wTCAsSiJspoU
	O2d+Y+N37KWoNoFq4e37aT2xuiB7tiT4OCgwHgsjYmBzxqfd4oKvRdIFZmB0CzzK
	XuRPBwJHfpgpLqRdzPvSLzl1/VPZaQo1JE/L0/L74aqmpQJwwP+aFNy10f3xkg9W
	7a+Gl4xJnWiLnf7YRH3PJqBFxxtN5hXRZ47s3ilunk39OLzFthwzGNY8PKYmlmVe
	rGBiOc30oAbYd2wK5Ee3m6fuT+Wpe7djiLQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qd2rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 15:23:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30cbf82bd11so800871a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 08:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747063396; x=1747668196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrQ8HCH0L6bcF6OpRumggZPbii/H5c4lVW7jizG6qnY=;
        b=vj9/UZt1d8R8pDAHvrDg72PN7AHO4Wj4gGtm4D41MkTMma+iaMI0A3/HO5BoCfxGi7
         RCKgsVvNZJwWK0eIWqtx0S2HznTCSsM7SM8A3bXJKGG+Ul3yWWkl4YZ+2ZzxB/+IwjwQ
         r3xbwej8gpY+MBzlpgxOe/bcCp/IWlmB52ZsuMXDWkQyfUFpSDsDSX5iuUBzeb2QIGyZ
         bPiRlvP/1y0us6ygE7k6SzoJQXxZWfXCuHLix39+P8ySX/gVonlNmr9RxTZEeq0p8XrG
         5CjrAQb0qmrQVSiUXRWvHuPgmYbQCD3ZA6+JajFqb8SNDf5E5df76py3A1cqjCCBXM9W
         RISQ==
X-Gm-Message-State: AOJu0YxegoqOkJfexkX2/Xhpr1sisr2Ap46rjIMCWFbZ6k06+RuWEYes
	7KwZsw8ew6YzCuPQRUa/y0Bvr63dzxidy902vtEGGraWx/p7ySHYkt+Na52CYQyPoK+I+r6whXb
	XfWU1jEq1EI2nASS5yhsi4UJY2fOrKWfLsJrH8qnBkiuY9XA2nHOu3hXTYZ/OyRkKbwYfc1Wq1g
	==
X-Gm-Gg: ASbGncua1jXwkDQAGblL2DKfFcaANuIu/hmbk1isS8Xax3dDfSeyjDpAPX7JH3JVCP2
	HSoMHqDL0xSai040NPjA55x8BdCNJJxcZB4OKHX1o8PZFPSnsJGiF7U+1II1xO7+bYlGk3ee948
	vB9YK/hzt3BX6l4WhZRYCMpjqVncfLz/2GyscID4uQYbcNeM2t6HwvBsJ+LyTHu85+kRnUV/66R
	nRbjjZD9Z7dvbsqLKOuZ3OyvuOQ48EB/SF2zd90tIM4PjEp1FXqkyvWTph6UJh628u4vMqm9kaH
	c4sxs+HcMHUBI8/Se58nJoi00PMRUSoiJSUsahUkdKPC/Q3rplEprt1n4i0OUMwyWJ3PQTaE9va
	pJ/eeo0mZz/Ag4PcxorFBr4vDhlslCW9RQFyQMyyjQQqZ
X-Received: by 2002:a17:90b:4a0f:b0:2f7:4cce:ae37 with SMTP id 98e67ed59e1d1-30c3d3e8420mr24060570a91.18.1747063395611;
        Mon, 12 May 2025 08:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFOcB/v/0uMX1D61eCtM1HPB6fg3P20OSO3SBkF/y/CxZOvTs+2wtwWPWs8NQcTbUNZ5nRvg==
X-Received: by 2002:a17:90b:4a0f:b0:2f7:4cce:ae37 with SMTP id 98e67ed59e1d1-30c3d3e8420mr24060543a91.18.1747063395208;
        Mon, 12 May 2025 08:23:15 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4fe22f2sm9850368a91.30.2025.05.12.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 08:23:14 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Subject: [PATCH v2] iw: print NO-EHT flags for reg get command
Date: Mon, 12 May 2025 20:53:04 +0530
Message-Id: <20250512152304.2852658-1-manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=68221265 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=BzR64oxeuZbbf90ASlgA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: I7IOirNfX93P6hY48jXoAyOzTVWsU9GJ
X-Proofpoint-GUID: I7IOirNfX93P6hY48jXoAyOzTVWsU9GJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MCBTYWx0ZWRfX7mT69XyNBWol
 R6v57YEI9kXUknY5EqulcEs9l95dLFJ2P4pv3LOFz8S9qE5+rWBG9ZqDdSe5QYpPXpbOR8pVJzK
 XmN1lEKN4cAWnOe7HMjZFEi+W8jjxi1QQJFNegosRvVkfijakJZf0XZD8sgGKQWyUBpmJuGjo4X
 zQc38BStqYCo9C5fODA4IPGNyySCzZk3eAb/12qX/PHXfWEmXLiMJrhb6r1mY/nBISHuo7wj1yd
 mQ54Fg+ulY3dzRaGtEGlVZuA/SlUBBcn3CftHDExpNlEX5B37X/816U0jWyVjqxBfkRBkuNUJao
 yyO4Eyj2FdsIcvsn+uLkT49ACSKpeGhkGukBPW40tnefPVkKmMABY3JpM+YTCVNgw35FQkutRYz
 axhBqKO62/YasoD+eCRl9SAGsM4C0BUrurWcwItMnyt1UtZeFvXzBSTFW+uwfINxJNNPm+0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505120160

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Currently when NO-EHT flag is set by driver, iw doesn't display that
information in the 'iw reg get' command. Add changes to print "NO-EHT"
while displaying the reg rules via reg get command, if a reg rule is
marked with NO-EHT flag.

Sample Output:

country RU: DFS-UNSET
        (2402 - 2472 @ 40), (N/A, 20), (N/A), NO-EHT
        (5170 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW, NO-EHT
        (5250 - 5330 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW, NO-EHT
        (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW, NO-EHT
        (5735 - 5835 @ 80), (N/A, 30), (N/A), AUTO-BW, NO-EHT

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
v2:
 - Re-based on ToT. No functionality changes.
 - Updated mailing list.
---
 reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reg.c b/reg.c
index 27899ce..f24535d 100644
--- a/reg.c
+++ b/reg.c
@@ -204,6 +204,7 @@ static int print_reg_handler(struct nl_msg *msg, void *arg)
 		PARSE_FLAG(NL80211_RRF_NO_160MHZ, "NO-160MHZ");
 		PARSE_FLAG(NL80211_RRF_NO_HE, "NO-HE");
 		PARSE_FLAG(NL80211_RRF_NO_320MHZ, "NO-320MHZ");
+		PARSE_FLAG(NL80211_RRF_NO_EHT, "NO-EHT");
 
 		/* Kernels that support NO_IR always turn on both flags */
 		if ((flags & NL80211_RRF_NO_IR) && (flags & __NL80211_RRF_NO_IBSS)) {

base-commit: 59660a349cf35903e951f99bdd8a74df063c912e
-- 
2.34.1


