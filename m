Return-Path: <linux-wireless+bounces-18938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B96A34C01
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9842B18888C6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B11204088;
	Thu, 13 Feb 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aIvKqwj0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161628A2B2
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467959; cv=none; b=WlC5NFTo8n6o4c2mpddbBQjrqpmbBghdjx5JAAnczA2Q6x7yF8MzjzpgWI1Up0TSHpA4Lu9vRw7NfDQfztoe4E2h/MMQysOwl1dS6nQTYOYl8JXWiEgUyM9o39M9fUjWgQ0ymIwV5h3vQggeuAFurPrwZHHDCeoCNbF0zgKKR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467959; c=relaxed/simple;
	bh=CDICUg2AK/8cdkE6kVqBavgh9fxEDUP7rsB6/oUFDbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/M/hd3PF743Yw39Ik+7clXrJkgjJhz1Kj6LIi3HCd14O5m1j+i3bcJRkFSnpbHNUHnZV0Gr7ne+PpQmpZ0i7HrBRIG0IledT97yS0JS23ju6tJx+w6vz0S1e8Sr3SBMVtNZdz0WRdVoBttIAfYqLoT20oYUjMWs82D4KGtktdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aIvKqwj0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA2Gtl001950;
	Thu, 13 Feb 2025 17:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nzDf3KOa5bW6zzNYV+sQTxb/LGZFhDNVVVgSlMS8ZR4=; b=aIvKqwj0Gld6Yixe
	DPIkgaIFkIWsU2uS6PtwLyvMoWLAZ76TrBd95UqP4kqV/InGZm2phfJmn7VItW6a
	X6o9lNMhD/lK7MGDOZhd3z5qnz/6Px+I2DLLoLQP26Kuv7XybqJHXJLXkv8aNrzP
	FBJu/eSu8eJtcJ7TXD6T8mFrMszTZn/n/yixfbdzXv6OHFsLBeTu4CsUL3qMJPeP
	9YR1/zGmLm/sesP90mvSy8phRszPuuxqMhmTPhyAbPo5mySJcpdoMkxqsZy2z90I
	QTx/V6iPViYRte6A5ErnSi2qtCs0BIjQb2nIUw11khKh7Lu5uT6pU2QFYe50br4Y
	3rlGgA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp95et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:32:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHWVbH029486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:32:31 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:32:29 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH v2 1/5] wifi: mac80211: correct RX stats packet increment for multi-link
Date: Thu, 13 Feb 2025 23:02:02 +0530
Message-ID: <20250213173206.1665731-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213173206.1665731-1-quic_sarishar@quicinc.com>
References: <20250213173206.1665731-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: K6X5VkmHieRPMbJeQS7I0t7JK7AEhgq-
X-Proofpoint-GUID: K6X5VkmHieRPMbJeQS7I0t7JK7AEhgq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=964 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130125

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
index 1e28efe4203c..eb3e2d550c8f 100644
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


