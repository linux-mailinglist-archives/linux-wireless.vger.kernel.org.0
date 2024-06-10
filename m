Return-Path: <linux-wireless+bounces-8749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826F901D51
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD181C212E5
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472297405C;
	Mon, 10 Jun 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nOEvfRpe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2871B48
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009556; cv=none; b=BZmYNhXH6BKddFUE6Jj4woEc0pZupRGR1woUEetsOK1pAVW2UJyt7FFNzgklBZSIVii0xssGL5ZEmBglL00ZtU4LhFAgjb1lHbutUfz76iHe7xHGJ9oAV5cLgMxDK7f9ZhsLm1ZtK4wfJYHpGmSnNPh+M936mC0/ebSnsrUprwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009556; c=relaxed/simple;
	bh=5uk4py0zQd49/zbzmnqUTilSfavER+71vZ+ohtjTp5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwuCHh+F/BZ6C6d2QhoP6dYAATC6AEbPgRaUpNOLakzbf/McDMbwjg5KQ87KSom6FUEKe4NSCkCVbcFB+pvtAS0rEviLqoaUCRc++53E3HeUIyUMyvTAz+9mFlXuqDNDf5XIsIt+y31lwRCS1vd50ZF7U2LNaRBVSKyvewbUFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nOEvfRpe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A1TUhl009443;
	Mon, 10 Jun 2024 08:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bcEOGKzF42SpbJMqueOVKoiT
	v+AX7FTQrXL1boUi1js=; b=nOEvfRpe/ijt7IrZO9nI8wl515RXL9Jf6gSU6aa4
	leyTNWxJ2bAsnYNFd7x/orYOAE71m7BKmgoizrwKMxNO6w/JaCppR/VP97MgnbHZ
	obwuxxyQMb47yUQPdzYn8/V46NYPcGjxkr9jI1scLshPuIWrIppDOmlwHulyYU7U
	/ReEcA+IZnPDbyjrFAj8zMQPgaSglx1WEFTJlVrX+zzAGmXSaQKCexjTiIADVQ9i
	E8iWqnb7sRGXHuzE/QND3dXXV3/4VDgkMwUf8ccFF0cffDJyX6mMXkJJSzMdcopa
	zRbt7N5aw05WUzb0o25JtpLYQ9EM+YXRsUbmSiuVsBGiaA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymea6k1gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A8qU6C019521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:30 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 01:52:28 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH 4/4] wifi: cfg80211: make sure to process all per-STA profiles
Date: Mon, 10 Jun 2024 14:22:04 +0530
Message-ID: <1718009524-5579-5-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I8cGEHlLhSc2i-6W9KNfCGWvb1hrqZFe
X-Proofpoint-ORIG-GUID: I8cGEHlLhSc2i-6W9KNfCGWvb1hrqZFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=951 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100067

Currently if BSS entry can't be created from any per-STA profile all
subsequent per-STA profiles in the multi-link element are ignored,
though they can generate valid BSS entries. To avoid this continue
processing the remaining per-STA profiles in the multi-link element
even if BSS entry not created from current per-STA profile.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 37ebe5a..546758c 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3046,7 +3046,7 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 
 		bss = cfg80211_inform_single_bss_data(wiphy, &data, gfp);
 		if (!bss)
-			break;
+			continue;
 		cfg80211_put_bss(wiphy, bss);
 	}
 
-- 
2.7.4


