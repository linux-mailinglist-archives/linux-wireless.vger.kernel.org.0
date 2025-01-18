Return-Path: <linux-wireless+bounces-17674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D31A15AF4
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 02:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4542169034
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 01:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2884F5E0;
	Sat, 18 Jan 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K8NB4QLR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315838DE9
	for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165270; cv=none; b=lF4+neq62bn64DVAQZMgUtVdK9o9MqHpaYxj31ovjSoyiRO91z+hxkrF+z1QGEOq0A9Zwqy8CKQ4Zt/f0KRGJrjACdbcg3egpQE0XlIIggrtzmi76bFRx4tCKT6UUrAC+ojkAFqwmMWs7XRJ6/A2MB1KDC6qjzYTEpLEQtJwWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165270; c=relaxed/simple;
	bh=LSa6Fl9T5hKkizsaXC0vAwMoZI9+NtfDIwx3JpWRFWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMYvNP0naBfC1NjGlhbQin8MC02E9TgWMjJ3RVmhQDY+MBHdRV0BUS/Byz7YKgVMvaskM0DpF13uf7N2q7bweanK9tBSaYlOF6fxm57CK0Y+4f0eoBJpfPenl4vgG1ss9F7Y0ePxrf2IVS+0MD8NN7wUCC7FBbaes1bhqtvM8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K8NB4QLR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HC8i50006187;
	Sat, 18 Jan 2025 01:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PkZx8Cmxf/31PlHqkMHpGmvInVO3ADtL2/r/AdQYLHM=; b=K8NB4QLRO9L7wHli
	+NLxIhL/oZ4nJ6Syp2TWmJBWRpXcHKjkuTpZOnl+o4ViO1CxoUB/MLoa+BRkYpIh
	0BR49Mrv7xqeho0I6wfiEAQjPmLeaXtKpor98ppruCP0vgrZubmPLedOjBWMd4nY
	dkUJaGOV9UfMSkPdoDoS2K2JXjaG0m4lb+C8C6CVTWEUx+kN/fJLt1EoET8VGiDU
	iCGFxcvKXArlyO4FJLtrM+C/p1cK2ZDs9IbTbT7y1KxPa1KDNlUqzT5EjNyZ80CU
	LRy9vjE1vrnXomUfFhqGgXtKE5Xf3S2GNmHLaUun1jhBdARkM5gj5wyNSN4n9jQc
	jN4VbQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447py0hm25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 01:54:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50I1sGEd013320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 01:54:17 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 17:54:16 -0800
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: VLAN traffic in multicast path
Date: Fri, 17 Jan 2025 17:54:00 -0800
Message-ID: <20250118015400.1919688-3-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250118015400.1919688-1-quic_msinada@quicinc.com>
References: <20250118015400.1919688-1-quic_msinada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: skaeLXMfOiahBpWGh8yJFzFZ870YRuXP
X-Proofpoint-GUID: skaeLXMfOiahBpWGh8yJFzFZ870YRuXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=669 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501180012

Currently for MLO, sending out multicast frames on each link is handled by
mac80211 only when IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX flag is not set.

Dynamic VLAN multicast traffic utilizes software encryption.
Due to this, mac80211 should handle transmitting multicast frames on
all links for multicast VLAN traffic.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 net/mac80211/tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..40f95bc6ddce 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4525,8 +4525,10 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 						     IEEE80211_TX_CTRL_MLO_LINK_UNSPEC,
 						     NULL);
 	} else if (ieee80211_vif_is_mld(&sdata->vif) &&
-		   sdata->vif.type == NL80211_IFTYPE_AP &&
-		   !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) {
+		   ((sdata->vif.type == NL80211_IFTYPE_AP &&
+		     !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) ||
+		    ((sdata->vif.type == NL80211_IFTYPE_AP_VLAN) &&
+		     !sdata->wdev.use_4addr))) {
 		ieee80211_mlo_multicast_tx(dev, skb);
 	} else {
 normal:
-- 
2.34.1


