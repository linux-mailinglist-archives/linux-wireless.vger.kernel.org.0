Return-Path: <linux-wireless+bounces-21787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F186A9500D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 13:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B137F3A8B91
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285B6CA5E;
	Mon, 21 Apr 2025 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipWuzdX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699F1C84A8
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234144; cv=none; b=MPhmUQchWgf+CEOi/75LzqJNCywLPvG0IhUrDO3grSVN6J8XNYzkWJyrdlS4ytTDaJ+8Srik7LhA3Ud4kxHu7TkViAPX7EuNiiRopoY5bibl4vuYdoqezGfNB6JL27fgNl4JJtcynj++Ba6hiy3xIra011ero5tCVYTzoR3VPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234144; c=relaxed/simple;
	bh=SF01fBj2uEPRTNilOjp6vIL57l6F5W+EqahcANCeUX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZkMttCFzws34lwRSaJ1ib/TNzeSZZVW189ddOWarcASTfyaEvEkGgt7+gxyyEVGWEKjXPkaBfe/8CJXMCEWTJWGdgNbRfncC4ni3AfjyqEvrrC4NVNqR2sklSHM2cMy3bBXTeXTMvJom9OYkYyCcVbkdEBOx7Tl4PefVa03e6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipWuzdX1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LB4cLH024545
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=i1hoqFNmT3gQKEQ8kWYkIq4lTJqguXCCiXv
	sYANyoDk=; b=ipWuzdX1Co5PGopQUQbHSR1LoQb+VsA2nszAKGbCjuu07BSK7TT
	2Beqi6VB24nuh/pHW2MfSTJ1ikVFibmQOcD5zEilaCewftaYQrt6fbvxDW7My88r
	0Ki9WxudYECFQYdGAY2a0cknr6EmvPpepZgJZVchS2h4eZZ4dDaWH3zLv3HiCVZu
	t26wp7byvGu3Be3GyBgCrGL+xtNMKzzpPpBmJTJEyLoDl3S9/IGxttY0DOtcFeKU
	Q+9lH6dDb13O/6sXFlZPE62EL71ef+ofepI08oeNqEHDD2zsTxSGiYEd4bigqb7Q
	gJ91jMv1Xde8yutvW7QSSIwlpYjVJDF4BGA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642u9c1qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:15:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225ab228a37so33397035ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 04:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745234119; x=1745838919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1hoqFNmT3gQKEQ8kWYkIq4lTJqguXCCiXvsYANyoDk=;
        b=cOmp4aOOyMoeofUvPqgr35EdbE114HwDi/75+qmlMGLGdXxlH2cjNuBw6wf0/QoCf6
         3qVc8UCe/FG2nJQ7IOK/rrIK0Vi2yg+eCQC2WJo/FeFms5rhzD2sXtnN+oi8AujVcIvm
         4+mEs8ICeeNIIIyVNgUm0vXORRGFKWceHr/Oh0qsSXCGbL1EA2bXt6TRy+WRPskiYC2K
         5Ca/bxoazSI/3LGqhKXdEpyUXKy+qdEB6heHIFa2TQoWpXEHv8VXJCqn8KxwloO7tp5A
         qjU1TiqhbDnPkBi78txyfD63RBq1sNDOzFK+BsCv8M9Q5hkod45BfT684FD0hyEr4j7m
         3m/g==
X-Gm-Message-State: AOJu0YwSH9UD3VAoQ7nD6qTPyA2CsluXejLr7mKuNfopeyDJjtwPuWSP
	sDbMi09mBvuKP59a982aPbNoH5Vy6M3ddfckXbph9MsYqJTlVXxGImk6I/Vv4ytbsUmUq8EoLMb
	oY7ltWCbqODrmCUu0nLeTUnwvA17RPjYdOjfvqolEJJO470VTeaLqf3TzvZjLYUGnjZI7LwZKjA
	==
X-Gm-Gg: ASbGnctI0EY5+kYiZOjJetUMZ5+Nfb3bk21tAt6j82JAwudnpj6f/jOa2XWqYKaMVo7
	+E+/lDdddvhC5I6pGHHJk+Z8+Xu4aBqvtrl+aNo1fXzLuab6sPawBHBKp9xWC+dgb/ChcO2qG/a
	bQBCqZq18AkztZJQXkDT1wfzp6+S4nTywC3QtutoN0eEV5W/wNyLB1hhuDE6PSom4yFVKjsdvDs
	tRnaqEKtHKC2VvMPYHLT0RAh5t+9wlgaNee19x3zNEZqZFzIGekXCTVonz7inFVRVyvuX/ZozP2
	IP19tfnsRgd/rxTMYs35nMrTXmPyKn91oAu6/0qH0pvE0lUV/Lq10tSA
X-Received: by 2002:a17:903:41c9:b0:224:78e:4ebe with SMTP id d9443c01a7336-22c53607d73mr160586155ad.33.1745234118774;
        Mon, 21 Apr 2025 04:15:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW1REMRM2nPAAMqdFJ1CLesEeN7hzj2YzvG6+nTHu1uQDuJjMGCatpxHvWRSmTiatZgcB1Aw==
X-Received: by 2002:a17:903:41c9:b0:224:78e:4ebe with SMTP id d9443c01a7336-22c53607d73mr160585845ad.33.1745234118434;
        Mon, 21 Apr 2025 04:15:18 -0700 (PDT)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0bdf5sm7172344a91.15.2025.04.21.04.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:15:17 -0700 (PDT)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: ieee80211: define beacon protection bit field
Date: Mon, 21 Apr 2025 16:45:05 +0530
Message-Id: <20250421111505.3633992-1-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TYaWtQQh c=1 sm=1 tr=0 ts=680628dc cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=gy8QWGJEzyb5cfRzob4A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: c3VNewlNvWdYb4noiAe_rOEihVOORDHK
X-Proofpoint-GUID: c3VNewlNvWdYb4noiAe_rOEihVOORDHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=785 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210087

An AP supporting Beacon Protection should set bit 84 in
the extended capabilities IE (9.4.2.25 in the 802.11be D7 spec).
So the *4th* bit of the 10th byte should be checked to figure out
whether beacon protection is enabled or disabled.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/linux/ieee80211.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 508d466de1cc..aef5a616d598 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4087,6 +4087,9 @@ enum ieee80211_tdls_actioncode {
 /* Defines support for enhanced multi-bssid advertisement*/
 #define WLAN_EXT_CAPA11_EMA_SUPPORT	BIT(3)
 
+/* Enable Beacon Protection */
+#define WLAN_EXT_CAPA11_BCN_PROTECT BIT(4)
+
 /* TDLS specific payload type in the LLC/SNAP header */
 #define WLAN_TDLS_SNAP_RFTYPE	0x2
 

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.34.1


