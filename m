Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E776C66CD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 12:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCWLi2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 07:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCWLiY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 07:38:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2292F7B9
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 04:38:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N3tDea009694;
        Thu, 23 Mar 2023 11:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=P33gsQRyh3ufsy64Hauw1vIUrGOS20TnlbU3DODTQsE=;
 b=M9HE2CJgLkcOPHGlnkbO+AkY3zlcGs2wMDIv3yFaVryUSSEA+PJuX2cY6r35TLoCblfX
 7kFrhdMmG2v6+pwoVsMSMuNZKkcjRbcRN/mYJ1875jIEgb7YQ1yvR2a/rlHsporQbhCR
 wQn7XsIN/5dZQMULN+9Gqfwe6ZueQcdA6t94XDZU6yhuCODjv3As/QpqStDEK/M1t5Om
 NOW9rxg7/4DbWzeL8F/711WJflrPnTytJ3yNRrMzEWEYQTX3VIGRMZhf6K6mTuAsTLlE
 RqNXsLDfw/yn1ARRntQ5Fw2B3oEIWDBBgs55EfHY9UWILk4VhjZYPEk0PYl/j1Tsz31+ og== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg64k2524-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:38:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NBcDjv025959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:38:13 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 04:38:12 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 2/2] mac80211: support RNR for EMA AP
Date:   Thu, 23 Mar 2023 04:38:01 -0700
Message-ID: <20230323113801.6903-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230323113801.6903-1-quic_alokad@quicinc.com>
References: <20230323113801.6903-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pNgie2eJtBTuD-cd9fONU3H6YrdJhCVI
X-Proofpoint-ORIG-GUID: pNgie2eJtBTuD-cd9fONU3H6YrdJhCVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230088
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 net/mac80211/cfg.c         | 63 +++++++++++++++++++++++++++++++++++---
 net/mac80211/ieee80211_i.h | 21 +++++++++++--
 net/mac80211/tx.c          | 10 ++++++
 3 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index db5fa334b801..ebbd13d0c29a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1084,6 +1084,23 @@ ieee80211_copy_mbssid_beacon(u8 *pos, struct cfg80211_mbssid_elems *dst,
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
@@ -1091,6 +1108,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   const struct ieee80211_color_change_settings *cca)
 {
 	struct cfg80211_mbssid_elems *mbssid = NULL;
+	struct cfg80211_rnr_elems *rnr = NULL;
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
 	int size, err;
@@ -1122,11 +1140,21 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1137,7 +1165,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	/*
 	 * pointers go into the block we allocated,
-	 * memory is | beacon_data | head | tail | mbssid_ies
+	 * memory is | beacon_data | head | tail | mbssid_ies | rnr_ies
 	 */
 	new->head = ((u8 *) new) + sizeof(*new);
 	new->tail = new->head + new_head_len;
@@ -1149,7 +1177,13 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
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
@@ -1507,6 +1541,7 @@ static void ieee80211_free_next_beacon(struct ieee80211_link_data *link)
 		return;
 
 	kfree(link->u.ap.next_beacon->mbssid_ies);
+	kfree(link->u.ap.next_beacon->rnr_ies);
 	kfree(link->u.ap.next_beacon);
 	link->u.ap.next_beacon = NULL;
 }
@@ -3410,6 +3445,7 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 
 	if (beacon->mbssid_ies)
 		len += ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
+						       beacon->rnr_ies,
 						       beacon->mbssid_ies->cnt);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
@@ -3425,6 +3461,18 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
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
@@ -3464,10 +3512,15 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
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
index 84d10e993eca..85ecbf57d64e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -270,6 +270,7 @@ struct beacon_data {
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
 	struct cfg80211_mbssid_elems *mbssid_ies;
+	struct cfg80211_rnr_elems *rnr_ies;
 	struct rcu_head rcu_head;
 };
 
@@ -1186,20 +1187,34 @@ ieee80211_vif_get_shift(struct ieee80211_vif *vif)
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
index 139eec6c64da..dfe6b9c9b29e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5222,6 +5222,15 @@ ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon,
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
 
@@ -5259,6 +5268,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	 * tail length, maximum TIM length and multiple BSSID length
 	 */
 	mbssid_len = ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
+						     beacon->rnr_ies,
 						     ema_index);
 
 	skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
-- 
2.39.0

