Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5755A628A53
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiKNUT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiKNUT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E1264D7
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:25 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEGCcAJ004775;
        Mon, 14 Nov 2022 20:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z7d4cJXbcpH/yaETSN31zaww4Q+Q/pGdHsMA3y/rAEI=;
 b=iDZx0plp9DJznlYx1+hy5BvsqnqF/Wl1rjXjC56PtEy1CV6lSJewPo6ud10z4UqZHZmJ
 CjffN+Qf8xMYrdId4GnOQtwXdH7CNP8tJZeR1dzzYBVKoaqGYtXT7nS9VhOiFJ3OCGaR
 roXZF2uhDgYRGE9MLT8OVDIFAtk2knHYz+pxSYDC5mt7uwwUKixZwp/wofL3+8Rnigzf
 kFX1bAPOQXUV0jBetgpHalyUh5a4PStUVwIpoyJx/ACfEfbc6KARpBJCTTXKjAk1VOwc
 pWEwJFZ3FnkujQH1btmgt0MSnkiVc1L3W4hkRZCZi8jaFpG/ePYk4J92rTsPw32gmkuf 6g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kugkpj66y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJL9b025231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:21 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:21 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 01/10] mac80211: generate EMA beacons in AP mode
Date:   Mon, 14 Nov 2022 12:19:03 -0800
Message-ID: <20221114201912.22893-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114201912.22893-1-quic_alokad@quicinc.com>
References: <20221114201912.22893-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2oEQazBCd1TcDYWt7Dm-Egub0yevi5Dx
X-Proofpoint-GUID: 2oEQazBCd1TcDYWt7Dm-Egub0yevi5Dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add APIs to generate an array of beacons for an EMA AP (enhanced
multiple BSSID advertisements), each including a single MBSSID element.
EMA profile periodicity equals the count of elements.

- ieee80211_beacon_get_template_ema_list() - Generate and return all
EMA beacon templates. Drivers must call ieee80211_beacon_free_ema_list()
to free the memory. No change in the prototype for the existing API,
ieee80211_beacon_get_template(), which should be used for non-EMA AP.

- ieee80211_beacon_get_template_ema_index() - Generate a beacon which
includes the multiple BSSID element at the given index. Drivers can use
this function in a loop until NULL is returned which indicates end of
available MBSSID elements.

- ieee80211_beacon_free_ema_list() - free the memory allocated for the
list of EMA beacon templates.

Modify exsiting functions ieee80211_beacon_get_ap(),
ieee80211_get_mbssid_beacon_len() and ieee80211_beacon_add_mbssid()
to accept a new parameter for EMA index.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---

v2:
- Limited the use of IEEE80211_INCLUDE_ALL_MBSSID_ELEMS to only
__ieee80211_beacon_get and its callers. Remaining functions now use
existing MBSSID element count (u8) to decide between EMA vs non-EMA
beacon generation. Macro cannot removed completely as the callers of
__ieee80211_beacon_get() do not have access to the beacon pointer
containing MBSSID count.

- Changed the prototype of ema_index in all function except
__ieee80211_beacon_get() from int to u8.

- Modified ieee80211_beacon_get_ap_ema_list() to return a list of beacons.

- Added WARN_ON() in ieee80211_beacon_get_ap_ema_list().

include/net/mac80211.h     |  68 +++++++++++++++++++
 net/mac80211/cfg.c         |   7 +-
 net/mac80211/ieee80211_i.h |  10 ++-
 net/mac80211/tx.c          | 134 ++++++++++++++++++++++++++++++++++---
 4 files changed, 202 insertions(+), 17 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 721c450a9ccd..ff37f8f46c34 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5225,6 +5225,74 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_mutable_offsets *offs,
 			      unsigned int link_id);
 
+/**
+ * ieee80211_beacon_get_template_ema_index - EMA beacon template generation
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @offs: &struct ieee80211_mutable_offsets pointer to struct that will
+ *	receive the offsets that may be updated by the driver.
+ * @link_id: the link id to which the beacon belongs (or 0 for a non-MLD AP).
+ * @ema_index: index of the beacon in the EMA set.
+ *
+ * This function follows the same rules as ieee80211_beacon_get_template()
+ * but returns a beacon template which includes multiple BSSID element at the
+ * requested index.
+ *
+ * Return: The beacon template. %NULL indicates the end of EMA templates.
+ */
+struct sk_buff *
+ieee80211_beacon_get_template_ema_index(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_mutable_offsets *offs,
+					unsigned int link_id, u8 ema_index);
+
+/**
+ * struct ieee80211_ema_beacons - List of EMA beacons
+ * @cnt: count of EMA beacons.
+ *
+ * @bcn: array of EMA beacons.
+ * @bcn.skb: the skb containing this specific beacon
+ * @bcn.offs: &struct ieee80211_mutable_offsets pointer to struct that will
+ *	receive the offsets that may be updated by the driver.
+ */
+struct ieee80211_ema_beacons {
+	u8 cnt;
+	struct {
+		struct sk_buff *skb;
+		struct ieee80211_mutable_offsets offs;
+	} bcn[];
+};
+
+/**
+ * ieee80211_beacon_get_template_ema_list - EMA beacon template generation
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: the link id to which the beacon belongs (or 0 for a non-MLD AP)
+ *
+ * This function follows the same rules as ieee80211_beacon_get_template()
+ * but allocates and returns a pointer to list of all beacon templates required
+ * to cover all profiles in the multiple BSSID set. Each template includes only
+ * one multiple BSSID element.
+ *
+ * Driver must call ieee80211_beacon_free_ema_list() to free the memory.
+ *
+ * Return: EMA beacon templates of type struct ieee80211_ema_beacons *.
+ *	%NULL on error.
+ */
+struct ieee80211_ema_beacons *
+ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       unsigned int link_id);
+
+/**
+ * ieee80211_beacon_free_ema_list - free an EMA beacon template list
+ * @ema_beacons: list of EMA beacons of type &struct ieee80211_ema_beacons pointers.
+ *
+ * This function will free a list previously acquired by calling
+ * ieee80211_beacon_get_template_ema_list()
+ */
+void ieee80211_beacon_free_ema_list(struct ieee80211_ema_beacons *ema_beacons);
+
 /**
  * ieee80211_beacon_get_tim - beacon generation function
  * @hw: pointer obtained from ieee80211_alloc_hw().
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c848fe04dd44..b60e8c835e46 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1121,11 +1121,11 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	if (params->mbssid_ies) {
 		mbssid = params->mbssid_ies;
 		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
-		size += ieee80211_get_mbssid_beacon_len(mbssid);
+		size += ieee80211_get_mbssid_beacon_len(mbssid, mbssid->cnt);
 	} else if (old && old->mbssid_ies) {
 		mbssid = old->mbssid_ies;
 		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
-		size += ieee80211_get_mbssid_beacon_len(mbssid);
+		size += ieee80211_get_mbssid_beacon_len(mbssid, mbssid->cnt);
 	}
 
 	new = kzalloc(size, GFP_KERNEL);
@@ -3338,7 +3338,8 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 	len = beacon->head_len + beacon->tail_len + beacon->beacon_ies_len +
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
 	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
-	      ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies);
+	      ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
+					      beacon->mbssid_ies->cnt);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
 	if (!new_beacon)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 63ff0d2524b6..e6ee40866dfa 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1166,13 +1166,17 @@ ieee80211_vif_get_shift(struct ieee80211_vif *vif)
 }
 
 static inline int
-ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems)
+ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems, u8 i)
 {
-	int i, len = 0;
+	int len = 0;
 
-	if (!elems)
+	if (!elems || !elems->cnt || i > elems->cnt)
 		return 0;
 
+	if (i < elems->cnt)
+		return elems->elem[i].len;
+
+	/* i == elems->cnt, calculate total length of all MBSSID elements */
 	for (i = 0; i < elems->cnt; i++)
 		len += elems->elem[i].len;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bb2e54610101..ac4a916e7573 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5089,13 +5089,20 @@ ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
 }
 
 static void
-ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon)
+ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon,
+			    u8 i)
 {
-	int i;
+	if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt ||
+	    i > beacon->mbssid_ies->cnt)
+		return;
 
-	if (!beacon->mbssid_ies)
+	if (i < beacon->mbssid_ies->cnt) {
+		skb_put_data(skb, beacon->mbssid_ies->elem[i].data,
+			     beacon->mbssid_ies->elem[i].len);
 		return;
+	}
 
+	/* i == beacon->mbssid_ies->cnt, include all MBSSID elements */
 	for (i = 0; i < beacon->mbssid_ies->cnt; i++)
 		skb_put_data(skb, beacon->mbssid_ies->elem[i].data,
 			     beacon->mbssid_ies->elem[i].len);
@@ -5108,7 +5115,8 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 			struct ieee80211_mutable_offsets *offs,
 			bool is_template,
 			struct beacon_data *beacon,
-			struct ieee80211_chanctx_conf *chanctx_conf)
+			struct ieee80211_chanctx_conf *chanctx_conf,
+			u8 ema_index)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
@@ -5127,7 +5135,9 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	/* headroom, head length,
 	 * tail length, maximum TIM length and multiple BSSID length
 	 */
-	mbssid_len = ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies);
+	mbssid_len = ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
+						     ema_index);
+
 	skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
 			    beacon->tail_len + 256 +
 			    local->hw.extra_beacon_tailroom + mbssid_len);
@@ -5145,7 +5155,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		offs->cntdwn_counter_offs[0] = beacon->cntdwn_counter_offsets[0];
 
 		if (mbssid_len) {
-			ieee80211_beacon_add_mbssid(skb, beacon);
+			ieee80211_beacon_add_mbssid(skb, beacon, ema_index);
 			offs->mbssid_off = skb->len - mbssid_len;
 		}
 
@@ -5164,12 +5174,51 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	return skb;
 }
 
+static struct ieee80211_ema_beacons *
+ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_link_data *link,
+				 struct ieee80211_mutable_offsets *offs,
+				 bool is_template, struct beacon_data *beacon,
+				 struct ieee80211_chanctx_conf *chanctx_conf)
+{
+	struct ieee80211_ema_beacons *ema = NULL;
+
+	if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt)
+		return NULL;
+
+	ema = kzalloc(struct_size(ema, bcn, beacon->mbssid_ies->cnt),
+		      GFP_ATOMIC);
+	if (!ema)
+		return NULL;
+
+	for (ema->cnt = 0; ema->cnt < beacon->mbssid_ies->cnt; ema->cnt++) {
+		ema->bcn[ema->cnt].skb =
+			ieee80211_beacon_get_ap(hw, vif, link,
+						&ema->bcn[ema->cnt].offs,
+						is_template, beacon,
+						chanctx_conf, ema->cnt);
+		if (!ema->bcn[ema->cnt].skb)
+			break;
+	}
+
+	if (ema->cnt == beacon->mbssid_ies->cnt)
+		return ema;
+
+	ieee80211_beacon_free_ema_list(ema);
+	return NULL;
+}
+
+#define IEEE80211_INCLUDE_ALL_MBSSID_ELEMS -1
+
 static struct sk_buff *
 __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
 		       struct ieee80211_mutable_offsets *offs,
 		       bool is_template,
-		       unsigned int link_id)
+		       unsigned int link_id,
+		       int ema_index,
+		       struct ieee80211_ema_beacons **ema_beacons)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct beacon_data *beacon = NULL;
@@ -5198,8 +5247,29 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		if (!beacon)
 			goto out;
 
-		skb = ieee80211_beacon_get_ap(hw, vif, link, offs, is_template,
-					      beacon, chanctx_conf);
+		if (ema_beacons) {
+			*ema_beacons =
+				ieee80211_beacon_get_ap_ema_list(hw, vif, link,
+								 offs,
+								 is_template,
+								 beacon,
+								 chanctx_conf);
+		} else {
+			if (beacon->mbssid_ies && beacon->mbssid_ies->cnt) {
+				if (ema_index >= beacon->mbssid_ies->cnt)
+					goto out; /* End of MBSSID elements */
+
+				if (ema_index <= IEEE80211_INCLUDE_ALL_MBSSID_ELEMS)
+					ema_index = beacon->mbssid_ies->cnt;
+			} else {
+				ema_index = 0;
+			}
+
+			skb = ieee80211_beacon_get_ap(hw, vif, link, offs,
+						      is_template, beacon,
+						      chanctx_conf,
+						      ema_index);
+		}
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 		struct ieee80211_hdr *hdr;
@@ -5287,10 +5357,50 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_mutable_offsets *offs,
 			      unsigned int link_id)
 {
-	return __ieee80211_beacon_get(hw, vif, offs, true, link_id);
+	return __ieee80211_beacon_get(hw, vif, offs, true, link_id,
+				      IEEE80211_INCLUDE_ALL_MBSSID_ELEMS, NULL);
 }
 EXPORT_SYMBOL(ieee80211_beacon_get_template);
 
+struct sk_buff *
+ieee80211_beacon_get_template_ema_index(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_mutable_offsets *offs,
+					unsigned int link_id, u8 ema_index)
+{
+	return __ieee80211_beacon_get(hw, vif, offs, true, link_id, ema_index,
+				      NULL);
+}
+EXPORT_SYMBOL(ieee80211_beacon_get_template_ema_index);
+
+void ieee80211_beacon_free_ema_list(struct ieee80211_ema_beacons *ema_beacons)
+{
+	u8 i;
+
+	if (!ema_beacons)
+		return;
+
+	for (i = 0; i < ema_beacons->cnt; i++)
+		kfree_skb(ema_beacons->bcn[i].skb);
+
+	kfree(ema_beacons);
+}
+EXPORT_SYMBOL(ieee80211_beacon_free_ema_list);
+
+struct ieee80211_ema_beacons *
+ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       unsigned int link_id)
+{
+	struct ieee80211_ema_beacons *ema_beacons = NULL;
+
+	WARN_ON(__ieee80211_beacon_get(hw, vif, NULL, false, link_id, 0,
+				       &ema_beacons));
+
+	return ema_beacons;
+}
+EXPORT_SYMBOL(ieee80211_beacon_get_template_ema_list);
+
 struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 u16 *tim_offset, u16 *tim_length,
@@ -5298,7 +5408,9 @@ struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 {
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false,
-						     link_id);
+						     link_id,
+						     IEEE80211_INCLUDE_ALL_MBSSID_ELEMS,
+						     NULL);
 	struct sk_buff *copy;
 	int shift;
 
-- 
2.17.1

