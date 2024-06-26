Return-Path: <linux-wireless+bounces-9574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B39177AD
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 06:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF441C21590
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A1A31;
	Wed, 26 Jun 2024 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jBmH+cy2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F21E880
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377574; cv=none; b=iKVkL22GB736keG2CUXdF3iwUIaTXy0foSWqEVj3xi1kVZxqd5zVcAV9jnnJHf1DVmTu9aFswMbkIdKw7p8uvMcYxJ+kKJBsa3TCmt85CSGH4k0aiDNAWqvo2gH7Wk2D7qtCs0QG9hVkYWCoFg3uRBN3eO3dBr9eBRhQG6Ii20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377574; c=relaxed/simple;
	bh=p9VeLXrVXqZ7v2vt2XZuMm8Dj/imrcQzP0sjO5qPR7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAYFZ8aK6QR5SCaqgCzSveBswieKdkAC4MhIMd7Y25c3/HpaEe4zKOckgORnEFoxfFhd0F3z/wWPSSa9aw9KXkv3hdvtNmxt9NTJhT0pmnevUDn7Cm0ZaXpF4YdFrK4S1rKAxe+nbdB1jqXYzVnhsg1XxoC3Rv2QzmzvxTdkUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jBmH+cy2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PI06Hr013955;
	Wed, 26 Jun 2024 04:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pgyljzOsemmbt3W+YQVcYHcVAxp7HdhcfwGrCh8plvs=; b=jBmH+cy2vNAepgVS
	BckxF3uaxxATvoq952yGni0I2mWiLB7sVHeUB3uuBbgkBa5dKtuhawPuvHaIUCDf
	SXOUSZmxfP2JsXM+raYyjxEBbqaFsYQpCwVogUmc94iFmbykbYI+4xtxhXEiUg7w
	C8CRaOd633fGu02Od4Rz1+iBgG1u/V4Jos518dUMdg5TA1tRPNfZMdiDlSJvAEql
	4S0yl48VNGdoH7Zc2lnGmlMHxz6DT272QO1hwbQGWpff1AtK5z6sqMIjgAlrSUUF
	1RcAJqFOJ3g2BkMcLiRrL2/gqV0QEn4ow/4oyIvY2WW2X1o+peEWHtMaNtOiIogK
	6knJvA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxh06wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q4qmXI014705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:48 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 21:52:46 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 3/9] wifi: nl80211: allow CAC while other links are beaconing during MLO
Date: Wed, 26 Jun 2024 10:22:10 +0530
Message-ID: <20240626045216.3754013-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626045216.3754013-1-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C6jlc9WwZni-Umx94D-mhsEIL-Wc79hi
X-Proofpoint-ORIG-GUID: C6jlc9WwZni-Umx94D-mhsEIL-Wc79hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=985 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260036

Currently if any of the link is beaconing, CAC can not be started.

However, with MLO, it is possible that interface is beaconing already on a
link that did not require CAC, but now another link is being started that
does require CAC. Hence, same check does not apply to MLO.

Add changes to check the link under consideration is beaconing or not in
case of MLO.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/wireless/nl80211.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b44332dc52be..7420a966997f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10025,7 +10025,20 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		goto unlock;
 	}
 
-	if (cfg80211_beaconing_iface_active(wdev) || wdev->links[0].cac_started) {
+	if (cfg80211_beaconing_iface_active(wdev)) {
+		/* During MLO other link(s) can beacon, only the current link
+		 * can not already beacon
+		 */
+		if (wdev->valid_links &&
+		    !wdev->links[0].ap.beacon_interval) {
+			/* nothing */
+		} else {
+			err = -EBUSY;
+			goto unlock;
+		}
+	}
+
+	if (wdev->links[0].cac_started) {
 		err = -EBUSY;
 		goto unlock;
 	}
-- 
2.34.1


