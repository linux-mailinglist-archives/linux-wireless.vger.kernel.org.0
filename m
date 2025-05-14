Return-Path: <linux-wireless+bounces-22954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E9AB71EA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D1B1796E4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72527E7D2;
	Wed, 14 May 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fRjVlcI9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561327E7DE
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241383; cv=none; b=Mo3/cy9v9VFgjY4dFLbk+9NXaxGDfkzli1vDlFReWlq/1K3TlG1/j87fNlqzzwSUVIT11hAIKeaiR7Jug83yvpXVSkuuG1+gDxaZejQPVtWXmVXUcr444oqpVagPoq6MXiVxe7OnKCT+PfXJRCJNcuH5hOWt/lzPvxJ4MWTvKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241383; c=relaxed/simple;
	bh=g7w+pqROPuMNmYuwcvP5lcOHtHX6LpOHgj6XH1FK3co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhuxZJax0+6/Sv171wjPj09YHyN4Og54ypVvbJ/OI0+dP4wb9nF+rNBII+Q5AYFPtFgWQ0CR/AWXJDEl5YCVzyzGYajhOeI0MA2jwfBqvGMpeBuRGz8Dzb17aAJlbSm1UB8PFHZAGsTt37TpHjuqs3Gs15Pe6Ri+fwZEbukZOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fRjVlcI9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuo2f012668;
	Wed, 14 May 2025 16:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NT3N8CDRFMmqjV5qdcn3wWt4iMElb6vL6dHTJxidP0=; b=fRjVlcI9Wv9kCbdd
	RR/zIej1K+oJ2+r0At7rfheYuNW3dwYMBKtRQGvjnfzDyXWGW7z/nCAfk2v8JE5a
	OXFUBvrUSnYr6ngEyZldCaBWFRxCXiTJnypspag7i8SheOS5Of2BVwWB1bDQGGeF
	8e52Dw7yW9MV/1Drj0UWdlbCYyL03JBbHCFXVNYR/lHJGx25QXItfv+O+xJXdBlR
	uu9hmajBAQg9PiRO4gV/fAiaeKyJRNg7VWqkDcbL5emQbReuypTyusMfl0FrC3VD
	CmkZs4vIBxVzyHB/AT6G3bGJPSnKOo0zhdMnJlTuTBondO8GGotzkHESsnM3cTnc
	d8EHnQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcykerk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EGnawS011530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:36 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 09:49:35 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v7 10/10] wifi: mac80211: correct RX stats packet increment for multi-link
Date: Wed, 14 May 2025 22:18:57 +0530
Message-ID: <20250514164857.227540-11-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514164857.227540-1-quic_sarishar@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TyafISxTiNto3Lk7yU5vWg1OaWrXvAXX
X-Proofpoint-ORIG-GUID: TyafISxTiNto3Lk7yU5vWg1OaWrXvAXX
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=6824c9a1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=DHE891H7Gske2VlohvUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1MSBTYWx0ZWRfX60DJps6e+Yef
 cvujSqWJi7U0zAiZAzSHMybm+Dmus/k74j6GqB8I1vABHq4kBxQhuXAkJ6ibeo0hW/S9rcTOypw
 p7gzMye4YWhiZZnR3k5SKg1vU/+2dVBYhTFaouQrixTFe98gMOs774bfV8Z0hxBx4NHuIHL+/1o
 W3QkOpD/a84kJ5fRcB64k2fwvEzyXfQU3tDnLZR3nJsJtIWq/Y1Rc6GGLJlHG++tkXbYVc9WXXC
 UTToKg21PORVgt+RDJVP+nHfehLOp43wAy7Pl79qve2LZsp8KieqZ/WiCMeGF+blZHKWgMUpDCw
 KM39J97Exwkw57BjrR5yc9mAaMlPoFHLHK5/qbdjVH+6bDgkRrAXSMIwD2dT/0VZC90DUVzGmkt
 T1Y2MDi25618JGf0/nG8fO/FcqJsAg7dFcuQX82o5olCEF4/HZZ8BYrdD0ggtzwB1oWHWdpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=971 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140151

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


