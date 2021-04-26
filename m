Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9296E36B9A6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhDZTGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:06:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35783 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233755AbhDZTGg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:06:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619463955; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1wfIxUKSnJVHsfDYTP3AdZa5jBF4MawqpS+X9lb9wsA=; b=eTtXk124pUzc2FLgkZAN8qCF312oKEfrCc17d2E+oT1+t9vJ6ytCNEtaqPwYVocImsVv7+AA
 tKM2KjADDZNaXrLUJxz18ABpLsWtGjeVRBz/lJweHOKEC6ddiiDtnI4evGu0QhoJcyLP8mEz
 0D9jY78goYT78hnV4263hM/h9Ug=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60870f0a215b831afb9a00c4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 19:05:46
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75BC8C4338A; Mon, 26 Apr 2021 19:05:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5ADAC43217;
        Mon, 26 Apr 2021 19:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5ADAC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v10 3/4] mac80211: MBSSID and EMA support in beacon handling
Date:   Mon, 26 Apr 2021 12:05:33 -0700
Message-Id: <20210426190534.12667-4-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426190534.12667-1-alokad@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

New fields added in struct beacon_data to store all MBSSID elements and
the index of the next element to be included in beacon template.

For a non-EMA AP, a single beacon template is generated with all elements.
For an EMA AP, multiple beacon templates are generated and each includes
a single MBSSID element. EMA profile periodicity equals the count of
elements.
This patch also generates and includes multiple BSSID configuration element
in each beacon template for both EMA/non-EMA AP when MBSSID is enabled.

New field added in struct ieee80211_mutable_offsets to store offset of the
first MBSSID element in beacons. Also the offset for channel switch
announcement (CSA) is modified to account for MBSSID length.

Depending on the hardware support and the usecase, drivers should use
following functions for beacon generation:
(1) ieee80211_beacon_get_template() - Existing function for legacy beacon
    generation for non-MBSSID APs. No change in prototype.
(2) ieee80211_beacon_get_template_ema_next() - Generate the next EMA
    beacon template using the 'ema_index' stored in beacon_data.
(3) ieee80211_beacon_get_template_ema_list() - Generate all EMA templates.
    Drivers must call ieee80211_beacon_free_ema_list() to free the memory.

This commit also adds a missing free() for sdata->u.ap.next_beacon in
ieee80211_set_csa_beacon() and sets the pointer to NULL in case of error.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v10: Added the lock missing in v9 for ieee80211_beacon_get_tim()

 include/net/mac80211.h     |  89 +++++++++++++++++
 net/mac80211/cfg.c         | 116 ++++++++++++++++++++---
 net/mac80211/ieee80211_i.h |   2 +
 net/mac80211/tx.c          | 189 ++++++++++++++++++++++++++++++++-----
 4 files changed, 363 insertions(+), 33 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ca83bfe14355..a5bc0d996cbe 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4897,12 +4897,14 @@ void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
  * @cntdwn_counter_offs: array of IEEE80211_MAX_CNTDWN_COUNTERS_NUM offsets
  *	to countdown counters.  This array can contain zero values which
  *	should be ignored.
+ * @mbssid_offset: position of the multiple bssid element
  */
 struct ieee80211_mutable_offsets {
 	u16 tim_offset;
 	u16 tim_length;
 
 	u16 cntdwn_counter_offs[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
+	u16 mbssid_offset;
 };
 
 /**
@@ -4929,6 +4931,93 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_mutable_offsets *offs);
 
+/**
+ * enum ieee80211_bcn_tmpl_ema - EMA beacon generation type
+ *
+ * When enhanced multi-BSSID advertisements (EMA) mode is enabled, the
+ * non-transmitting profiles from the multiple BSSID set are split into more
+ * than one multiple BSSID elements if required. Each EMA beacon includes only
+ * one element to reduce the total size. The number of beacons required to
+ * cover all profiles is called as the profile periodicity of the set.
+ *
+ * In MAC80211, the multiple BSSID elements passed by the application are
+ * stored in a array and the index of the next element (starting from 0) to be
+ * included in the beacon template is tracked through the member ema_index of
+ * struct beacon_data.
+ *
+ * @IEEE80211_BCN_EMA_NONE: Used when EMA is disabled. Only one beacon
+ *	template will be generated which includes all multiple BSSID elements.
+ * @IEEE80211_BCN_EMA_NEXT: Used when EMA is enabled. Includes the next
+ *	multiple BSSID element while generating the beacon template.
+ * @IEEE80211_BCN_EMA_BASE: Used when EMA is enabled. Beacon template includes
+ *	the multiple MBSSID element at a specified index which should be set
+ *	to a value more than or equal to IEEE80211_BCN_EMA_BASE.
+ */
+enum ieee80211_bcn_tmpl_ema {
+	IEEE80211_BCN_EMA_NONE = -2,
+	IEEE80211_BCN_EMA_NEXT = -1,
+	IEEE80211_BCN_EMA_BASE = 0,
+};
+
+/**
+ * ieee80211_beacon_get_template_ema_next - EMA beacon template generation
+ *	function for drivers using the sw offload path.
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @offs: &struct ieee80211_mutable_offsets pointer to struct that will
+ *	receive the offsets that may be updated by the driver.
+ *
+ * This function follows the same rules as ieee80211_beacon_get_template()
+ * but returns a beacon template which includes the next multiple BSSID
+ * element.
+ *
+ * Return: The beacon template. %NULL on error.
+ */
+struct sk_buff *ieee80211_beacon_get_template_ema_next(struct ieee80211_hw *hw,
+						       struct ieee80211_vif *vif,
+						       struct ieee80211_mutable_offsets *offs);
+
+/**
+ * struct ieee80211_ema_bcn_list - list entry of an EMA beacon
+ * @list: the list pointer.
+ * @skb: the skb containing this specific beacon
+ * @offs: &struct ieee80211_mutable_offsets pointer to struct that will
+ *	receive the offsets that may be updated by the driver.
+ */
+struct ieee80211_ema_bcn_list {
+	struct list_head list;
+	struct sk_buff *skb;
+	struct ieee80211_mutable_offsets offs;
+};
+
+/**
+ * ieee80211_beacon_get_template_ema_list - EMA beacon template generation
+ *	function for drivers using the hw offload.
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @head: linked list head that will get populated with
+ *	&struct ieee80211_ema_bcn_list pointers.
+ *
+ * This function follows the same rules as ieee80211_beacon_get_template()
+ * but returns a linked list of all beacon templates required to cover all
+ * profiles in the multiple BSSID set. Each template includes only one multiple
+ * BSSID element.
+ *
+ * Return: The nuber of entries in the list or 0 on error.
+ */
+int ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct list_head *head);
+
+/**
+ * ieee80211_beacon_free_ema_list - free an EMA beacon template list
+ * @head: linked list head containing &struct ieee80211_ema_bcn_list pointers.
+ *
+ * This function will free a list previously acquired by calling
+ * ieee80211_beacon_get_template_ema_list()
+ */
+void ieee80211_beacon_free_ema_list(struct list_head *head);
+
 /**
  * ieee80211_beacon_get_tim - beacon generation function
  * @hw: pointer obtained from ieee80211_alloc_hw().
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d1a965897b9d..db21e1a621b1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1002,14 +1002,49 @@ static int ieee80211_set_ftm_responder_params(
 	return 0;
 }
 
+static int ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems)
+{
+	int i, len = 0;
+
+	if (!elems)
+		return 0;
+
+	for (i = 0; i < elems->cnt; i++)
+		len += elems->elem[i].len;
+
+	return len;
+}
+
+static u8 *ieee80211_copy_mbssid_beacon(u8 *offset,
+					struct cfg80211_mbssid_elems *dest,
+					struct cfg80211_mbssid_elems *src)
+{
+	int i;
+
+	if (!dest || !src)
+		return offset;
+
+	dest->cnt = src->cnt;
+	for (i = 0; i < dest->cnt; i++) {
+		dest->elem[i].len = src->elem[i].len;
+		dest->elem[i].data = offset;
+		memcpy(dest->elem[i].data, src->elem[i].data,
+		       dest->elem[i].len);
+		offset += dest->elem[i].len;
+	}
+
+	return offset;
+}
+
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
 				   const struct ieee80211_csa_settings *csa)
 {
 	struct beacon_data *new, *old;
-	int new_head_len, new_tail_len;
+	int new_head_len, new_tail_len, new_mbssid_len = 0;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
+	u8 *new_mbssid_offset;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
 
@@ -1031,12 +1066,26 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	/* new or old mbssid? */
+	if (params->mbssid)
+		new_mbssid_len = ieee80211_get_mbssid_beacon_len(params->mbssid);
+	else if (old && old->mbssid)
+		new_mbssid_len = ieee80211_get_mbssid_beacon_len(old->mbssid);
+
+	size = sizeof(*new) + new_head_len + new_tail_len + new_mbssid_len;
 
 	new = kzalloc(size, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
+	if (new_mbssid_len) {
+		new->mbssid = kzalloc(sizeof(*params->mbssid), GFP_KERNEL);
+		if (!new->mbssid) {
+			kfree(new);
+			return -ENOMEM;
+		}
+	}
+
 	/* start filling the new info now */
 
 	/*
@@ -1048,6 +1097,15 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
 
+	/* copy in optional mbssid_ies */
+	new_mbssid_offset = new->tail + new_tail_len;
+	if (params->mbssid)
+		ieee80211_copy_mbssid_beacon(new_mbssid_offset, new->mbssid,
+					     params->mbssid);
+	else if (old && old->mbssid)
+		ieee80211_copy_mbssid_beacon(new_mbssid_offset, new->mbssid,
+					     old->mbssid);
+
 	if (csa) {
 		new->cntdwn_current_counter = csa->count;
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
@@ -1071,6 +1129,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
 				       params->probe_resp_len, csa);
 	if (err < 0) {
+		kfree(new->mbssid);
 		kfree(new);
 		return err;
 	}
@@ -1086,6 +1145,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 							 params->civicloc_len);
 
 		if (err < 0) {
+			kfree(new->mbssid);
 			kfree(new);
 			return err;
 		}
@@ -1095,9 +1155,10 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	rcu_assign_pointer(sdata->u.ap.beacon, new);
 
-	if (old)
+	if (old) {
+		kfree(old->mbssid);
 		kfree_rcu(old, rcu_head);
-
+	}
 	return changed;
 }
 
@@ -1255,8 +1316,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
 
-		if (old)
+		if (old) {
+			kfree(old->mbssid);
 			kfree_rcu(old, rcu_head);
+		}
 		RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
 		goto error;
 	}
@@ -1336,8 +1399,11 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 
 	mutex_unlock(&local->mtx);
 
-	kfree(sdata->u.ap.next_beacon);
-	sdata->u.ap.next_beacon = NULL;
+	if (sdata->u.ap.next_beacon) {
+		kfree(sdata->u.ap.next_beacon->mbssid);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+	}
 
 	/* turn off carrier for this interface and dependent VLANs */
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
@@ -1349,6 +1415,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.fils_discovery, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.unsol_bcast_probe_resp, NULL);
+	kfree(old_beacon->mbssid);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
@@ -3107,13 +3174,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 
 	len = beacon->head_len + beacon->tail_len + beacon->beacon_ies_len +
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
-	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len;
+	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
+	      ieee80211_get_mbssid_beacon_len(beacon->mbssid);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
 	if (!new_beacon)
 		return NULL;
 
+	if (beacon->mbssid) {
+		new_beacon->mbssid = kzalloc(sizeof(*beacon->mbssid),
+					     GFP_KERNEL);
+		if (!new_beacon->mbssid) {
+			kfree(new_beacon);
+			return NULL;
+		}
+	}
+
 	pos = (u8 *)(new_beacon + 1);
+
 	if (beacon->head_len) {
 		new_beacon->head_len = beacon->head_len;
 		new_beacon->head = pos;
@@ -3150,6 +3228,9 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
+	if (beacon->mbssid && beacon->mbssid->cnt)
+		pos = ieee80211_copy_mbssid_beacon(pos, new_beacon->mbssid,
+						   beacon->mbssid);
 
 	/* might copy -1, meaning no changes requested */
 	new_beacon->ftm_responder = beacon->ftm_responder;
@@ -3187,8 +3268,11 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP:
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		if (sdata->u.ap.next_beacon) {
+			kfree(sdata->u.ap.next_beacon->mbssid);
+			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
+		}
 
 		if (err < 0)
 			return err;
@@ -3343,8 +3427,14 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		if ((params->n_counter_offsets_beacon >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
-		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM))
+		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
+			if (sdata->u.ap.next_beacon) {
+				kfree(sdata->u.ap.next_beacon->mbssid);
+				kfree(sdata->u.ap.next_beacon);
+				sdata->u.ap.next_beacon = NULL;
+			}
 			return -EINVAL;
+		}
 
 		csa.counter_offsets_beacon = params->counter_offsets_beacon;
 		csa.counter_offsets_presp = params->counter_offsets_presp;
@@ -3353,8 +3443,10 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.count = params->count;
 
 		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa);
-		if (err < 0) {
+		if (err < 0 && sdata->u.ap.next_beacon) {
+			kfree(sdata->u.ap.next_beacon->mbssid);
 			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
 			return err;
 		}
 		*changed |= err;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8fcbaa1eedf3..cc9455434ddc 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -261,6 +261,8 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	struct cfg80211_mbssid_elems *mbssid;
+	u16 ema_index;
 	struct rcu_head rcu_head;
 };
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0b719f3d2dec..4bba3fd5368c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4746,11 +4746,68 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	return 0;
 }
 
+static int ieee80211_beacon_mbssid_len(struct beacon_data *beacon, int index)
+{
+	int len = 0, i;
+
+	if (index == IEEE80211_BCN_EMA_NEXT) {
+		index = beacon->ema_index;
+		beacon->ema_index++;
+		beacon->ema_index %= beacon->mbssid->cnt;
+	}
+
+	if (index != IEEE80211_BCN_EMA_NONE && index >= beacon->mbssid->cnt)
+		return -1;
+
+	if (beacon->mbssid->cnt) {
+		if (index >= IEEE80211_BCN_EMA_BASE) {
+			len = beacon->mbssid->elem[index].len;
+		} else {
+			for (i = 0; i < beacon->mbssid->cnt; i++)
+				len += beacon->mbssid->elem[i].len;
+		}
+	}
+	return len;
+}
+
+static void
+ieee80211_beacon_add_mbssid_config(struct ieee80211_vif *vif,
+				   struct sk_buff *skb,
+				   struct cfg80211_mbssid_elems *elems)
+{
+	u8 *pos = skb_put(skb, 5);
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 3;
+	*pos++ = WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION;
+	*pos++ = vif->bss_conf.mbssid.count;
+	*pos++ = elems->cnt;
+}
+
+static void ieee80211_beacon_add_mbssid(struct ieee80211_vif *vif,
+					struct sk_buff *skb,
+					struct cfg80211_mbssid_elems *elems,
+					int index)
+{
+	if (index >= IEEE80211_BCN_EMA_BASE) {
+		ieee80211_beacon_add_mbssid_config(vif, skb, elems);
+		skb_put_data(skb, elems->elem[index].data,
+			     elems->elem[index].len);
+	} else {
+		int i;
+
+		for (i = 0; i < elems->cnt; i++)
+			skb_put_data(skb, elems->elem[i].data,
+				     elems->elem[i].len);
+	}
+}
+
 static struct sk_buff *
 __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
 		       struct ieee80211_mutable_offsets *offs,
-		       bool is_template)
+		       bool is_template,
+		       int ema_index)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct beacon_data *beacon = NULL;
@@ -4762,13 +4819,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	int csa_off_base = 0;
 
-	rcu_read_lock();
-
 	sdata = vif_to_sdata(vif);
 	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
 
 	if (!ieee80211_sdata_running(sdata) || !chanctx_conf)
-		goto out;
+		return NULL;
 
 	if (offs)
 		memset(offs, 0, sizeof(*offs));
@@ -4778,6 +4833,9 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ap->beacon);
 		if (beacon) {
+			int mbssid_elems_len = 0;
+			int mbssid_config_len = 5;
+
 			if (beacon->cntdwn_counter_offsets[0]) {
 				if (!is_template)
 					ieee80211_beacon_update_cntdwn(vif);
@@ -4785,6 +4843,14 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				ieee80211_set_beacon_cntdwn(sdata, beacon);
 			}
 
+			if (beacon->mbssid) {
+				mbssid_elems_len =
+					ieee80211_beacon_mbssid_len(beacon,
+								    ema_index);
+				if (mbssid_elems_len == -1)
+					return NULL;
+			}
+
 			/*
 			 * headroom, head length,
 			 * tail length and maximum TIM length
@@ -4792,9 +4858,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			skb = dev_alloc_skb(local->tx_headroom +
 					    beacon->head_len +
 					    beacon->tail_len + 256 +
-					    local->hw.extra_beacon_tailroom);
+					    local->hw.extra_beacon_tailroom +
+					    mbssid_config_len +
+					    mbssid_elems_len);
 			if (!skb)
-				goto out;
+				return NULL;
 
 			skb_reserve(skb, local->tx_headroom);
 			skb_put_data(skb, beacon->head, beacon->head_len);
@@ -4810,21 +4878,32 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				csa_off_base = skb->len;
 			}
 
+			if (mbssid_elems_len) {
+				ieee80211_beacon_add_mbssid(vif, skb,
+							    beacon->mbssid,
+							    ema_index);
+				if (offs) {
+					offs->mbssid_offset = skb->len -
+							      mbssid_elems_len;
+					csa_off_base = skb->len;
+				}
+			}
+
 			if (beacon->tail)
 				skb_put_data(skb, beacon->tail,
 					     beacon->tail_len);
 
 			if (ieee80211_beacon_protect(skb, local, sdata) < 0)
-				goto out;
+				return NULL;
 		} else
-			goto out;
+			return NULL;
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 		struct ieee80211_hdr *hdr;
 
 		beacon = rcu_dereference(ifibss->presp);
 		if (!beacon)
-			goto out;
+			return NULL;
 
 		if (beacon->cntdwn_counter_offsets[0]) {
 			if (!is_template)
@@ -4836,7 +4915,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
 				    local->hw.extra_beacon_tailroom);
 		if (!skb)
-			goto out;
+			return NULL;
 		skb_reserve(skb, local->tx_headroom);
 		skb_put_data(skb, beacon->head, beacon->head_len);
 
@@ -4848,7 +4927,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ifmsh->beacon);
 		if (!beacon)
-			goto out;
+			return NULL;
 
 		if (beacon->cntdwn_counter_offsets[0]) {
 			if (!is_template)
@@ -4871,7 +4950,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				    beacon->tail_len +
 				    local->hw.extra_beacon_tailroom);
 		if (!skb)
-			goto out;
+			return NULL;
 		skb_reserve(skb, local->tx_headroom);
 		skb_put_data(skb, beacon->head, beacon->head_len);
 		ieee80211_beacon_add_tim(sdata, &ifmsh->ps, skb, is_template);
@@ -4884,7 +4963,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 	} else {
 		WARN_ON(1);
-		goto out;
+		return NULL;
 	}
 
 	/* CSA offsets */
@@ -4927,31 +5006,99 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT |
 			IEEE80211_TX_CTL_ASSIGN_SEQ |
 			IEEE80211_TX_CTL_FIRST_FRAGMENT;
- out:
-	rcu_read_unlock();
 	return skb;
 
 }
 
-struct sk_buff *
-ieee80211_beacon_get_template(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif,
-			      struct ieee80211_mutable_offsets *offs)
+struct sk_buff *ieee80211_beacon_get_template(struct ieee80211_hw *hw,
+					      struct ieee80211_vif *vif,
+					      struct ieee80211_mutable_offsets *offs)
 {
-	return __ieee80211_beacon_get(hw, vif, offs, true);
+	struct sk_buff *bcn;
+
+	rcu_read_lock();
+	bcn = __ieee80211_beacon_get(hw, vif, offs, true,
+				     IEEE80211_BCN_EMA_NONE);
+	rcu_read_unlock();
+
+	return bcn;
 }
 EXPORT_SYMBOL(ieee80211_beacon_get_template);
 
+struct sk_buff *ieee80211_beacon_get_template_ema_next(struct ieee80211_hw *hw,
+						       struct ieee80211_vif *vif,
+						       struct ieee80211_mutable_offsets *offs)
+{
+	struct sk_buff *bcn;
+
+	rcu_read_lock();
+	bcn = __ieee80211_beacon_get(hw, vif, offs, true,
+				     IEEE80211_BCN_EMA_NEXT);
+	rcu_read_unlock();
+
+	return bcn;
+}
+EXPORT_SYMBOL(ieee80211_beacon_get_template_ema_next);
+
+void ieee80211_beacon_free_ema_list(struct list_head *head)
+{
+	struct ieee80211_ema_bcn_list *ema, *tmp;
+
+	list_for_each_entry_safe(ema, tmp, head, list) {
+		kfree_skb(ema->skb);
+		kfree(ema);
+	}
+}
+EXPORT_SYMBOL(ieee80211_beacon_free_ema_list);
+
+int
+ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct list_head *head)
+{
+	int cnt = 0;
+
+	rcu_read_lock();
+	while (true) {
+		struct ieee80211_ema_bcn_list *ema;
+
+		ema = kmalloc(sizeof(*ema), GFP_KERNEL);
+		if (!ema) {
+			ieee80211_beacon_free_ema_list(head);
+			cnt = 0;
+			goto out;
+		}
+
+		ema->skb = __ieee80211_beacon_get(hw, vif, &ema->offs, true,
+						  cnt);
+		if (!ema->skb) {
+			kfree(ema);
+			break;
+		}
+		list_add_tail(&ema->list, head);
+		cnt++;
+	}
+out:
+	rcu_read_unlock();
+
+	return cnt;
+}
+EXPORT_SYMBOL(ieee80211_beacon_get_template_ema_list);
+
 struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 u16 *tim_offset, u16 *tim_length)
 {
 	struct ieee80211_mutable_offsets offs = {};
-	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false);
+	struct sk_buff *bcn = NULL;
 	struct sk_buff *copy;
 	struct ieee80211_supported_band *sband;
 	int shift;
 
+	rcu_read_lock();
+	bcn = __ieee80211_beacon_get(hw, vif, &offs, false,
+				     IEEE80211_BCN_EMA_NONE);
+	rcu_read_unlock();
 	if (!bcn)
 		return bcn;
 
-- 
2.31.1

