Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE3596D14
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiHQK4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiHQKzx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 06:55:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E461DAD
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 03:55:53 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HAVg58032600;
        Wed, 17 Aug 2022 10:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=y0eZou6ChvKdSEhvoYjAllfowJMUO7DVYp0qu6Cl54U=;
 b=UmTqJeOYQmsjnHGfKJakTFE6hlC4Cdz+LRecJihLArpt4ReSGnWIIcw5Kemeu0qG2K3q
 hjtIGmvXdxaqN7eS+S1lbFJjtcsDC6UrP9Ow15wMcCsQGFAOpJV2r6j2eoftf3tjzuN1
 oCQxdfq62rePWGsl7rA8XlOXIdqkacaZIZThj9WZfVz+In5LyPI7B3HnFCToYcvWX2tF
 EzVEkiB8Kb/8PBJThE6Dux/Dy9aUb5rtNbnBfeO4WioEI1NxzCP5d+LAhfs5YZXHo6ag
 FI7GMxAWvUFaJgAzWrrabWrqGfdjCTf4APBTHc2q7qJ1LQhlGlCo39j66MjCp649giWo jg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j0tqc91dy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:55:50 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27HAgdHO005201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:42:39 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 03:42:39 -0700
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 03:42:37 -0700
From:   Vasanthakumar <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: use the corresponding link for stats update
Date:   Wed, 17 Aug 2022 16:12:13 +0530
Message-ID: <20220817104213.2531-3-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220817104213.2531-1-quic_vthiagar@quicinc.com>
References: <20220817104213.2531-1-quic_vthiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HLzl-gF9VqWIZEIJ4vEnEPy_VIk3Cl3q
X-Proofpoint-ORIG-GUID: HLzl-gF9VqWIZEIJ4vEnEPy_VIk3Cl3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=723 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

With link_id reported in rx_status for MLO connection, do the
stats update on the appropriate link instead of always deflink.

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 net/mac80211/rx.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 80f2e3bc5e70..7f350886039a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4524,19 +4524,30 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 	struct ieee80211_sta_rx_stats *stats;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
 	struct sta_info *sta = rx->sta;
+	struct link_sta_info *link_sta;
 	struct sk_buff *skb = rx->skb;
 	void *sa = skb->data + ETH_ALEN;
 	void *da = skb->data;
 
-	stats = &sta->deflink.rx_stats;
+	if (rx->link_id >= 0) {
+		link_sta = rcu_dereference(sta->link[rx->link_id]);
+		if (WARN_ON_ONCE(!link_sta)) {
+			dev_kfree_skb(rx->skb);
+			return;
+		}
+	} else {
+		link_sta = &sta->deflink;
+	}
+
+	stats = &link_sta->rx_stats;
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->deflink.pcpu_rx_stats);
+		stats = this_cpu_ptr(link_sta->pcpu_rx_stats);
 
 	/* statistics part of ieee80211_rx_h_sta_process() */
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
 		stats->last_signal = status->signal;
 		if (!fast_rx->uses_rss)
-			ewma_signal_add(&sta->deflink.rx_stats_avg.signal,
+			ewma_signal_add(&link_sta->rx_stats_avg.signal,
 					-status->signal);
 	}
 
@@ -4552,7 +4563,7 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 
 			stats->chain_signal_last[i] = signal;
 			if (!fast_rx->uses_rss)
-				ewma_signal_add(&sta->deflink.rx_stats_avg.chain_signal[i],
+				ewma_signal_add(&link_sta->rx_stats_avg.chain_signal[i],
 						-signal);
 		}
 	}
@@ -4628,7 +4639,8 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 da[ETH_ALEN];
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
-	struct ieee80211_sta_rx_stats *stats = &sta->deflink.rx_stats;
+	struct link_sta_info *link_sta;
+	struct ieee80211_sta_rx_stats *stats;
 
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -4729,8 +4741,19 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	return true;
  drop:
 	dev_kfree_skb(skb);
+
+	if (rx->link_id >= 0) {
+		link_sta = rcu_dereference(sta->link[rx->link_id]);
+		if (!link_sta)
+			return true;
+	} else {
+		link_sta = &sta->deflink;
+	}
+
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->deflink.pcpu_rx_stats);
+		stats = this_cpu_ptr(link_sta->pcpu_rx_stats);
+	else
+		stats = &link_sta->rx_stats;
 
 	stats->dropped++;
 	return true;
-- 
2.17.1

