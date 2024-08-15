Return-Path: <linux-wireless+bounces-11492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F743953822
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 18:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBC51C22FFC
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F651B9B4E;
	Thu, 15 Aug 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M1RwssTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2ED1B582B;
	Thu, 15 Aug 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738798; cv=none; b=G164+BdK3nJYXR0OOFrEjllMqBUXICIHIDexIdYoP7pP/a4UjBd2F7QvfwY/01zHBO+SNsp2TJGTSdeAZJ3kZx/mxqds+MFULzS0wy8WAaTeLS97GVx7tk9HCpsRZJS/a9ccErI4LSqBjVhllAdrRKVdQZksghZAE3M2zRfukZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738798; c=relaxed/simple;
	bh=DYbBiyj5qYewvbb7Re7XGSYEHPMVwyQyJX5sJF6AXRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=r8TPUzqUfN6bN1M06kJokHXnLDouNP55/c1yMlYl6rjLf9fGezLE3OXoYbVMnokjUd8rhO6Z4HYZCbBQa6bu9CVhp2soHdMbM0TOfQSbn5JYwLPQNWPxv+JH3MNIAhHo3KB+ywLXBUO8z4r+QF0xx5t1of6BbPm+ru3cTiOH5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M1RwssTr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FFsAYf022989;
	Thu, 15 Aug 2024 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HSE9lOXCQAY2IALUk8wdaT
	jRFfDB8opieWccJFkeUPQ=; b=M1RwssTrbhws/TAQlsg1zB0eqYHuPFoQbB0n90
	5IT1A01AcyQf46vp2fglgbC4iRGVqFbY6A8dqdEQ7bSWfyHPYGD/OVOlBpIY0F+A
	U/v65s+6eWIIc1owERHo6RnXSuo+UnLCwuangl8hCxUmPti9Ng46r52M7Q7OLSi+
	cWSnfrxO6/HapOXh+CtoDQQyfl0Npt3EZhKAxRKt7zo8edRJf7OBwip9ii/ciaLV
	zIKfcxpbBDG+fqS4R2VVosrTbugBvYgsORXeyAfm2AdGm5fC0Ib/LmctSESu2QSG
	1LLXIV+MjI22yB1ClAa9WLo1KgTkm0F/8aAGLGKQPDss6dcg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410m29543a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 16:18:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47FGIVe9004160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 16:18:31 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 Aug
 2024 09:18:30 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 15 Aug 2024 09:18:30 -0700
Subject: [PATCH] wifi: mac80211: Fix ieee80211_convert_to_unicast() logic
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240815-ieee80211_convert_to_unicast-v1-1-648f0c195474@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFUqvmYC/32Oyw6CMBBFf8V0bQ3DQ4sr/8MQUtpRJpFW21Ixh
 H+3kLh1eRb3nDszj47Qs/NuZg4jebImAex3TPXS3JGTTszyLC8zAQUnRBRZDtAqayK60Abbjoa
 U9IGD1oj1UZwANEuKp8MbTZv+2iTupEfeOWlUv0rf5PCB3nODU+CDJLOOevLBus92KcI6/dWr/
 /UIHDhmhehqIcpKi8trJEVGHZQdWLMsyxfLlnAK7wAAAA==
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Braun
	<michael-dev@fami-braun.de>
CC: Harsh Kumar Bijlani <hbijlani@qti.qualcomm.com>,
        Kalyan Tallapragada
	<ktallapr@qti.qualcomm.com>,
        Jyothi Chukkapalli <jchukkap@qti.qualcomm.com>,
        Anirban Sirkhell <anirban@qti.qualcomm.com>,
        Johannes Berg
	<johannes.berg@intel.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NsLUW30wjT628CfXDSWPNx6PGr70rEfB
X-Proofpoint-ORIG-GUID: NsLUW30wjT628CfXDSWPNx6PGr70rEfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_09,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150118

The current logic in ieee80211_convert_to_unicast() uses skb_clone()
to obtain an skb for each individual destination of a multicast
frame, and then updates the destination address in the cloned skb's
data buffer before placing that skb on the provided queue.

This logic is flawed since skb_clone() shares the same data buffer
with the original and the cloned skb, and hence each time the
destination address is updated, it overwrites the previous destination
address in this shared buffer. As a result, due to the special handing
of the first valid destination, all of the skbs will eventually be
sent to that first destination.

Fix this issue by using skb_copy() instead of skb_clone(). This will
result in a duplicate data buffer being allocated for each
destination, and hence each skb will be transmitted to the proper
destination.

Fixes: ebceec860fc3 ("mac80211: multicast to unicast conversion")
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 net/mac80211/tx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 72a9ba8bc5fd..0ee1c7df424c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4408,7 +4408,7 @@ ieee80211_convert_to_unicast(struct sk_buff *skb, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	const struct ethhdr *eth = (struct ethhdr *)skb->data;
 	struct sta_info *sta, *first = NULL;
-	struct sk_buff *cloned_skb;
+	struct sk_buff *copied_skb;
 
 	rcu_read_lock();
 
@@ -4423,14 +4423,14 @@ ieee80211_convert_to_unicast(struct sk_buff *skb, struct net_device *dev,
 			first = sta;
 			continue;
 		}
-		cloned_skb = skb_clone(skb, GFP_ATOMIC);
-		if (!cloned_skb)
+		copied_skb = skb_copy(skb, GFP_ATOMIC);
+		if (!copied_skb)
 			goto multicast;
-		if (unlikely(ieee80211_change_da(cloned_skb, sta))) {
-			dev_kfree_skb(cloned_skb);
+		if (unlikely(ieee80211_change_da(copied_skb, sta))) {
+			dev_kfree_skb(copied_skb);
 			goto multicast;
 		}
-		__skb_queue_tail(queue, cloned_skb);
+		__skb_queue_tail(queue, copied_skb);
 	}
 
 	if (likely(first)) {

---
base-commit: ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa
change-id: 20240813-ieee80211_convert_to_unicast-1ddee968711d


