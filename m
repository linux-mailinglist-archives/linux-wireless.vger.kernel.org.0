Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3F628D2B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 00:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiKNXHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 18:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiKNXH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 18:07:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D41DA62
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 15:04:50 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEMxPAr014870;
        Mon, 14 Nov 2022 23:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QeD9CjfZ/9pkhh2UScfTDWqvq3fwD0qmenvSJDvTBi4=;
 b=Ug8s47s+164vPuwBthWGeZ2TWFWSci3mAYs+Ea9+Xr0JokwoPZ0w1SKUE0q5p48TQ7kL
 AtNUVVKTzf2I1qciL4rGpYGq/OQJYhuHyVaKXYyZ8QcrADGphgKH6xENPBqdfAMASt1r
 oY3Mu+hWVQMRm0ebQqsqeorcVlvA48Q+1CNlV4VNnyx2aMoSAnZ6+jSvbxS+8T4x3srd
 gg3vbYGTZJDboOvUgP5YQe5MOK0BzYGWL0pNbcEHFD1zOyFQuYp7l7CJYbQxCFtlPx1y
 fZ8p0Rjzr347Q+RTIHW3u3BlQIWZaAxregQ7hpS5dIViwBbxBvnhL8p8R89zdV6VceCU hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kuxwu00dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:04:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEN4QbL026223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:04:26 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 15:04:26 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] mac80211: support RNR for EMA AP
Date:   Mon, 14 Nov 2022 15:04:16 -0800
Message-ID: <20221114230416.20192-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114230416.20192-1-quic_alokad@quicinc.com>
References: <20221114230416.20192-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3p211ZLq7T6xzQ88cf4dPZTLoTOuTkXq
X-Proofpoint-GUID: 3p211ZLq7T6xzQ88cf4dPZTLoTOuTkXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Generate EMA beacons, each including MBSSID and RNR elements at a given
index. If number of stored RNR elements is more than the number of
MBSSID elements then add those in every EMA beacon.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---

v1: Prerequisite patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20221114201912.22893-2-quic_alokad@quicinc.com/

net/mac80211/cfg.c         | 63 +++++++++++++++++++++++++++++++++++---
 net/mac80211/ieee80211_i.h | 21 +++++++++++--
 net/mac80211/tx.c          | 10 ++++++
 3 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b60e8c835e46..7267e7d3c0df 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1083,6 +1083,23 @@ ieee80211_copy_mbssid_beacon(u8 *pos, struct cfg80211_mbssid_elems *dst,
 	return offset;
 }
 
+static int
+ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
+			  struct cfg80211_rnr_elems *src)
+{
+	int i, offset = 0;
+
+	for (i = 0; i < src->cnt; i++) {
+		memcpy(pos + offset, src->elem[i].data, src->elem[i].len);
+		dst->elem[i].len = src->elem[i].len;
+		dst->elem[i].data = pos + offset;
+		offset += dst->elem[i].len;
+	}
+	dst->cnt = src->cnt;
+
+	return offset;
+}
+
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct ieee80211_link_data *link,
 				   struct cfg80211_beacon_data *params,
@@ -1090,6 +1107,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   const struct ieee80211_color_change_settings *cca)
 {
 	struct cfg80211_mbssid_elems *mbssid = NULL;
+	struct cfg80211_rnr_elems *rnr = NULL;
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
 	int size, err;
@@ -1121,11 +1139,21 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	if (params->mbssid_ies) {
 		mbssid = params->mbssid_ies;
 		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
-		size += ieee80211_get_mbssid_beacon_len(mbssid, mbssid->cnt);
+		if (params->rnr_ies) {
+			rnr = params->rnr_ies;
+			size += struct_size(new->rnr_ies, elem, rnr->cnt);
+		}
+		size += ieee80211_get_mbssid_beacon_len(mbssid, rnr,
+							mbssid->cnt);
 	} else if (old && old->mbssid_ies) {
 		mbssid = old->mbssid_ies;
 		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
-		size += ieee80211_get_mbssid_beacon_len(mbssid, mbssid->cnt);
+		if (old && old->rnr_ies) {
+			rnr = old->rnr_ies;
+			size += struct_size(new->rnr_ies, elem, rnr->cnt);
+		}
+		size += ieee80211_get_mbssid_beacon_len(mbssid, rnr,
+							mbssid->cnt);
 	}
 
 	new = kzalloc(size, GFP_KERNEL);
@@ -1136,7 +1164,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	/*
 	 * pointers go into the block we allocated,
-	 * memory is | beacon_data | head | tail | mbssid_ies
+	 * memory is | beacon_data | head | tail | mbssid_ies | rnr_ies
 	 */
 	new->head = ((u8 *) new) + sizeof(*new);
 	new->tail = new->head + new_head_len;
@@ -1148,7 +1176,13 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 		new->mbssid_ies = (void *)pos;
 		pos += struct_size(new->mbssid_ies, elem, mbssid->cnt);
-		ieee80211_copy_mbssid_beacon(pos, new->mbssid_ies, mbssid);
+		pos += ieee80211_copy_mbssid_beacon(pos, new->mbssid_ies,
+						    mbssid);
+		if (rnr) {
+			new->rnr_ies = (void *)pos;
+			pos += struct_size(new->rnr_ies, elem, rnr->cnt);
+			ieee80211_copy_rnr_beacon(pos, new->rnr_ies, rnr);
+		}
 		/* update bssid_indicator */
 		link_conf->bssid_indicator =
 			ilog2(__roundup_pow_of_two(mbssid->cnt + 1));
@@ -1444,6 +1478,7 @@ static void ieee80211_free_next_beacon(struct ieee80211_link_data *link)
 		return;
 
 	kfree(link->u.ap.next_beacon->mbssid_ies);
+	kfree(link->u.ap.next_beacon->rnr_ies);
 	kfree(link->u.ap.next_beacon);
 	link->u.ap.next_beacon = NULL;
 }
@@ -3339,6 +3374,7 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
 	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
 	      ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
+					      beacon->rnr_ies,
 					      beacon->mbssid_ies->cnt);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
@@ -3354,6 +3390,18 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 			kfree(new_beacon);
 			return NULL;
 		}
+
+		if (beacon->rnr_ies && beacon->rnr_ies->cnt) {
+			new_beacon->rnr_ies =
+				kzalloc(struct_size(new_beacon->rnr_ies,
+						    elem, beacon->rnr_ies->cnt),
+					GFP_KERNEL);
+			if (!new_beacon->rnr_ies) {
+				kfree(new_beacon->mbssid_ies);
+				kfree(new_beacon);
+				return NULL;
+			}
+		}
 	}
 
 	pos = (u8 *)(new_beacon + 1);
@@ -3393,10 +3441,15 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
-	if (beacon->mbssid_ies && beacon->mbssid_ies->cnt)
+	if (beacon->mbssid_ies && beacon->mbssid_ies->cnt) {
 		pos += ieee80211_copy_mbssid_beacon(pos,
 						    new_beacon->mbssid_ies,
 						    beacon->mbssid_ies);
+		if (beacon->rnr_ies && beacon->rnr_ies->cnt)
+			pos += ieee80211_copy_rnr_beacon(pos,
+							 new_beacon->rnr_ies,
+							 beacon->rnr_ies);
+	}
 
 	/* might copy -1, meaning no changes requested */
 	new_beacon->ftm_responder = beacon->ftm_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e6ee40866dfa..bf1f30b172ca 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -269,6 +269,7 @@ struct beacon_data {
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
 	struct cfg80211_mbssid_elems *mbssid_ies;
+	struct cfg80211_rnr_elems *rnr_ies;
 	struct rcu_head rcu_head;
 };
 
@@ -1166,20 +1167,34 @@ ieee80211_vif_get_shift(struct ieee80211_vif *vif)
 }
 
 static inline int
-ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems, u8 i)
+ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems,
+				struct cfg80211_rnr_elems *rnr_elems,
+				u8 i)
 {
 	int len = 0;
 
 	if (!elems || !elems->cnt || i > elems->cnt)
 		return 0;
 
-	if (i < elems->cnt)
-		return elems->elem[i].len;
+	if (i < elems->cnt) {
+		len = elems->elem[i].len;
+		if (rnr_elems) {
+			len += rnr_elems->elem[i].len;
+			for (i = elems->cnt; i < rnr_elems->cnt; i++)
+				len += rnr_elems->elem[i].len;
+		}
+		return len;
+	}
 
 	/* i == elems->cnt, calculate total length of all MBSSID elements */
 	for (i = 0; i < elems->cnt; i++)
 		len += elems->elem[i].len;
 
+	if (rnr_elems) {
+		for (i = 0; i < rnr_elems->cnt; i++)
+			len += rnr_elems->elem[i].len;
+	}
+
 	return len;
 }
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ac4a916e7573..a8d618de649c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5099,6 +5099,15 @@ ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon,
 	if (i < beacon->mbssid_ies->cnt) {
 		skb_put_data(skb, beacon->mbssid_ies->elem[i].data,
 			     beacon->mbssid_ies->elem[i].len);
+
+		if (beacon->rnr_ies && beacon->rnr_ies->cnt) {
+			skb_put_data(skb, beacon->rnr_ies->elem[i].data,
+				     beacon->rnr_ies->elem[i].len);
+
+			for (i = beacon->mbssid_ies->cnt; i < beacon->rnr_ies->cnt; i++)
+				skb_put_data(skb, beacon->rnr_ies->elem[i].data,
+					     beacon->rnr_ies->elem[i].len);
+		}
 		return;
 	}
 
@@ -5136,6 +5145,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	 * tail length, maximum TIM length and multiple BSSID length
 	 */
 	mbssid_len = ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
+						     beacon->rnr_ies,
 						     ema_index);
 
 	skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
-- 
2.17.1

