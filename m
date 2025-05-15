Return-Path: <linux-wireless+bounces-22987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185BAB7D48
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D394E0F20
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F060295DB8;
	Thu, 15 May 2025 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eYlXffVq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA6296D07
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288185; cv=none; b=RP5x3zCVvYJHbUxUu5GJMzXyFd1Ml5D7tbOLNC3RfkOfoasiNL9s//K49cjyJ0sCCLFrpaUyKqlG/3gWi8Aun2psqjjo4m2bZ835kTSmJ68+VnOIbl3iCDuNP2L382yf1//6ixQi4ODez5oc7XDNXFUnHh4Jn3q31PJgvoKDSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288185; c=relaxed/simple;
	bh=g7w+pqROPuMNmYuwcvP5lcOHtHX6LpOHgj6XH1FK3co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCEBuvgpP2ppMMmfaUqbVQr1Yh0LJdWAEPMbLBCZbtz5Oyo3Cy1ZL5hdwn07uh/nlA6Bg5BDhLEAWBQFqiy5NaoUS+fbGObMIEK9jnXjo1C2lvNBBlQNx0JfNS6kb011S9QhubJ0sTMg6tcjMe2QOlnO2sKEHlQHFK/9zV08KI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eYlXffVq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ELHZqk025434;
	Thu, 15 May 2025 05:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NT3N8CDRFMmqjV5qdcn3wWt4iMElb6vL6dHTJxidP0=; b=eYlXffVqksI+HgRt
	3b4j3FDnxEBYxwjw7gI/DTo4KYNExi0oZns9XWGyR5T8mFwS3YFnX7/liNrMqydO
	o9/BK+Dqa7IeGVK6q2VAQdFFGjQzSKlnOgu1Qnx30pZd3L0hvsNkdBd8YYT/QXlx
	mVTfquOQYTCpuGXJjPZ5SPXz0+Gwc4gmufILpC8LbC4OydGoRnkVSW24+7dTo8Zl
	wxAY19RAdPWu5zKG2sIOj+YHU/6p2kDjN64hyYjFDi2Di9BLkQ9Vv+OxBXTZxQIB
	sU0I+rZxKhpx9e7479Rhm1uPhQv17mrAnM1mzQ61nTmkbWmG0aDMdwmIfYhqHyj8
	Y90CFQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew4y9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5ncuQ001177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:38 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:37 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 10/10] wifi: mac80211: correct RX stats packet increment for multi-link
Date: Thu, 15 May 2025 11:19:04 +0530
Message-ID: <20250515054904.1214096-11-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dAHtRVWfDBxMhMMBUQxhQuCHonAstvmV
X-Proofpoint-ORIG-GUID: dAHtRVWfDBxMhMMBUQxhQuCHonAstvmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfX9S0AqXNtV2Gf
 pAv6PrFo2qyJHvkXiioae7HrY/jlZ+S/Zr0/Kvt1vXSJ9PwpYk5slxrO6Di/MdVxMA1gGm78pSx
 l5j2rj8ZehHyp6wdxNGLBgAsEW2aBXHFv677bi9Ya1LMOqZqzizidFsCYfSQ7h8H/HP4Pdgi2mH
 Pt2yaZ4Av6CVocxfRLmFRUmRMsDBPhqJtZ347rmVsk0tMAK8pqqCFdmajhAjCpgGwig5TZz18e/
 n2FfLQJi2AE23wmDidYOyN/wSrAGwMDcI1encaFUfHxumOKWIhd2AJG+iZRjiJwgCrQYyQLD2O9
 wgVfJxuGDPnz89gbOi7lWdHPH77ajwE2pHR3naz7yHSzMSVt7X7V91ysNHWNrnEvm1t6qzLvJcW
 PvIopIncx46drmH/6zYyxz1Q6uF1F+v/qGc1qn/F6EXs2B4jPZfZZ57H5dsh9DZ0NcP9Lj6f
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68258073 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=DHE891H7Gske2VlohvUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=970 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150055

Currently, RX stats packets are incremented for deflink member for
non-ML and multi-link(ML) station case. However, for ML station,
packets should be incremented based on the specific link.

Therefore, if a valid link_id is present, fetch the corresponding
link station information and increment the RX packets for that link.
For non-MLO stations, the deflink will still be used.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/rx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..a3222c0e86ac 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -231,8 +231,19 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 
 	skb_queue_tail(&sdata->skb_queue, skb);
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
-	if (sta)
-		sta->deflink.rx_stats.packets++;
+	if (sta) {
+		struct link_sta_info *link_sta_info;
+
+		if (link_id >= 0) {
+			link_sta_info = rcu_dereference(sta->link[link_id]);
+			if (!link_sta_info)
+				return;
+		} else {
+			link_sta_info = &sta->deflink;
+		}
+
+		link_sta_info->rx_stats.packets++;
+	}
 }
 
 static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


