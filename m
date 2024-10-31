Return-Path: <linux-wireless+bounces-14775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886DB9B7BEC
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D28F28272F
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8219E994;
	Thu, 31 Oct 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UG8xWO6q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EA13D886
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382168; cv=none; b=ss+vECqapHBeH+JwcLFm36ScAOkDchYyD1m1j1EUZz5HhjWKJQX/w/eW3wdtuOBxb9rl3SOZU45xjJkNrvbCaHVzttKzR1J6Pt4QTpqq979sLnCnwQA4YQKbOimE80FBp2rUzxluN/A8EicnSKT1RosnRVUetsCgMki3U1sXDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382168; c=relaxed/simple;
	bh=29atCypjyLEBwYLtg5VTReV8HMQqKDsHValQT9fd9dU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QoSdQEf088uqYyQcoKRw7CuAI+RjAs8p172ioMV9LB6/AUA78CGXlCUqdxtH/LK69L6qjcZQEGhO4D4JqYpakgKoOB+KEMZz2LVShz3td5Jkswn64FERM4BEbAKkmINJQSYB1DDfxAq4cKdh4U7hnVtCyUFdSX2DA9VGjn8AgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UG8xWO6q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VBuNRr005427;
	Thu, 31 Oct 2024 13:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3G85wS5pLeerxIJwITwx1z
	3vDnJqfi7ipaoWwSJ8MYw=; b=UG8xWO6qXl/zzMtgsVkix/EuF0J+IXRWRfvFAh
	KvPGT8QEhuRDrB3oXcLYud22UGaqYOyt3wTr4Ai+QOEn+lLHwOWS7sxb3NNr+kJU
	MtjSr7OvA8U0AHFZZjEuJQl88TfI3MlfNrQGh5qhJ2yzwDsR3kc4PLmqkXT2y034
	fOWbdQXTaSg2OK5Floji28RjmkBq31oBGc28SUapfsbyVOt6JJTIHMqu4jp1y6M7
	bItmQw0Ja0GZv4Gw60ZBx5SMtoZn/ngXzlaDsAC+oRPZSiZeKrzbUHVgrsXr8a8N
	/IZN80OhLre3iD0mspWVBuOXDkYE17IazixDBGczhBfoElAw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42m1xc9sut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:42:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VDggQx022037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:42:42 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 31 Oct 2024 06:42:40 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: cfg80211: Remove the Medium Synchronization Delay validity check
Date: Thu, 31 Oct 2024 21:42:23 +0800
Message-ID: <20241031134223.970-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5cXh7mjkYCdinw4CIyQX0O18C03me7L6
X-Proofpoint-ORIG-GUID: 5cXh7mjkYCdinw4CIyQX0O18C03me7L6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410310104

Currently, when the driver attempts to connect to an AP MLD with multiple
APs, the cfg80211_mlme_check_mlo_compat() function requires the Medium
Synchronization Delay values from different APs of the same AP MLD to be
equal, which may result in connection failures.

This is because when the driver receives a multi-link probe response from
an AP MLD with multiple APs, cfg80211 updates the Elements for each AP
based on the multi-link probe response. If the Medium Synchronization Delay
is set in the multi-link probe response, the Elements for each AP belonging
to the same AP MLD will have the Medium Synchronization Delay set
simultaneously. If non-multi-link probe responses are received from
different APs of the same MLD AP, cfg80211 will still update the Elements
based on the non-multi-link probe response. Since the non-multi-link probe
response does not set the Medium Synchronization Delay
(IEEE 802.11be-2024-35.3.4.4), if the Elements from a non-multi-link probe
response overwrite those from a multi-link probe response that has set the
Medium Synchronization Delay, the Medium Synchronization Delay values for
APs belonging to the same AP MLD will not be equal. This discrepancy causes
the cfg80211_mlme_check_mlo_compat() function to fail, leading to
connection failures. Commit ccb964b4ab16
("wifi: cfg80211: validate MLO connections better") did not take this into
account.

To address this issue, remove this validity check.

Fixes: ccb964b4ab16 ("wifi: cfg80211: validate MLO connections better")
Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 net/wireless/mlme.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 4dac81854721..a5eb92d93074 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -340,12 +340,6 @@ cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *mle_a,
 		return -EINVAL;
 	}
 
-	if (ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_a) !=
-	    ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_b)) {
-		NL_SET_ERR_MSG(extack, "link EML medium sync delay mismatch");
-		return -EINVAL;
-	}
-
 	if (ieee80211_mle_get_eml_cap((const u8 *)mle_a) !=
 	    ieee80211_mle_get_eml_cap((const u8 *)mle_b)) {
 		NL_SET_ERR_MSG(extack, "link EML capabilities mismatch");

base-commit: e7e2957f403ba4655199f2ba9920c1a015a7be44
-- 
2.34.1


