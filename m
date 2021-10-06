Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A894236DD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 06:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJFELk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 00:11:40 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39439 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhJFELj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 00:11:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633493388; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: To: From: Sender;
 bh=iqal0zwD8YmtOjAlNnBB3OfcmPC+ryvEtHq25qb4E54=; b=bi5DzoTNyRoitk6OwwE5uXTYK1pN+S7O4h/eyLpAvJQNoaVHFZsSzG3I3oDA7uvyPdNOEq+z
 wcIVRFzzmcgmtF5TK5q5GOCNGPZdUOQ4ZL5adtEx4y6VsefqLF7+gTudQdnQt0ZS5F/7pMXe
 /uteqQKUi4c5l+CBZWavFHYgx2M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 615d218bff0285fb0aeb4884 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 04:09:47
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A62D8C4360C; Wed,  6 Oct 2021 04:09:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B0A9C43616;
        Wed,  6 Oct 2021 04:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1B0A9C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [v13 2/3] mac80211: MBSSID and EMA beacon handling in AP mode
Date:   Tue,  5 Oct 2021 21:09:37 -0700
Message-Id: <20211006040938.9531-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006040938.9531-1-alokad@codeaurora.org>
References: <20211006040938.9531-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add new fields in struct beacon_data to store all MBSSID elements.

For a non-EMA AP, generate a single beacon template which includes all
MBSSID elements.
For an EMA AP, generate multiple beacon templates, each including
a single MBSSID element. EMA profile periodicity equals the count of
elements.

Move CSA offset to reflect the MBSSID element length.

Add new APIs for the drivers to retrieve MBSSID and EMA beacons:
- ieee80211_beacon_get_template_ema_index() - Generate the EMA beacon
  which includes the multiple BSSID element at the given index.
  Drivers can use this function in a loop as well NULL is returned.
- ieee80211_beacon_get_template_ema_list() - Generate all EMA templates.
  Drivers must call ieee80211_beacon_free_ema_list() to free the memory.
No change in the prototype for the existing API
ieee80211_beacon_get_template() which should be used for non-EMA cases,
both with and without multiple BSSID enabled.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v13:
- Reverted lock related changes around __ieee80211_beacon_get().
- Replaced the infinite loop to generate EMA beacons by a finite
  loop and also reordered code so that rcu_dereference(ap->beacon)
  happens only once.
- Removed ema_index from struct beacon_data and the function
  ieee80211_beacon_get_template_ema_next(), replaced by
  ieee80211_beacon_get_template_ema_index() as given in the description.

 include/net/mac80211.h     |  66 ++++++++++++++
 net/mac80211/cfg.c         | 163 +++++++++++++++++++++++++++-------
 net/mac80211/ieee80211_i.h |   1 +
 net/mac80211/tx.c          | 175 ++++++++++++++++++++++++++++++++++---
 4 files changed, 363 insertions(+), 42 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 13cad5e9e6c0..dab66ada0ebd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4919,12 +4919,14 @@ void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
  * @cntdwn_counter_offs: array of IEEE80211_MAX_CNTDWN_COUNTERS_NUM offsets
  *	to countdown counters.  This array can contain zero values which
  *	should be ignored.
+ * @mbssid_off: position of the multiple bssid element
  */
 struct ieee80211_mutable_offsets {
 	u16 tim_offset;
 	u16 tim_length;
 
 	u16 cntdwn_counter_offs[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
+	u16 mbssid_off;
 };
 
 /**
@@ -4951,6 +4953,70 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_mutable_offsets *offs);
 
+/**
+ * ieee80211_beacon_get_template_ema_index - EMA beacon template generation
+ *	function for drivers using the sw offload path.
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @offs: &struct ieee80211_mutable_offsets pointer to struct that will
+ *	receive the offsets that may be updated by the driver.
+ * @ema_index: index of the beacon in the EMA set, must be more than or equal
+ *	to 0.
+ *
+ * This function follows the same rules as ieee80211_beacon_get_template()
+ * but returns a beacon template which includes multiple BSSID element at the
+ * requested index.
+ *
+ * Return: The beacon template. %NULL on error or if the given index is more
+ *	than or equal to the number of EMA beacons.
+ */
+struct sk_buff *
+ieee80211_beacon_get_template_ema_index(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_mutable_offsets *offs,
+					u8 ema_index);
+
+/**
+ * struct ieee80211_ema_bcns - list entry of an EMA beacon
+ * @list: the list pointer.
+ * @skb: the skb containing this specific beacon
+ * @offs: &struct ieee80211_mutable_offsets pointer to struct that will
+ *	receive the offsets that may be updated by the driver.
+ */
+struct ieee80211_ema_bcns {
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
+ *	&struct ieee80211_ema_bcns pointers. Driver must call INIT_LIST_HEAD()
+ *	before calling this function to initialize the list.
+ *
+ * This function follows the same rules as ieee80211_beacon_get_template()
+ * but returns a linked list of all beacon templates required to cover all
+ * profiles in the multiple BSSID set. Each template includes only one multiple
+ * BSSID element. Driver must call ieee80211_beacon_free_ema_list() to free
+ * the allocated memory after done.
+ */
+void ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct list_head *head);
+
+/**
+ * ieee80211_beacon_free_ema_list - free an EMA beacon template list
+ * @head: linked list head containing &struct ieee80211_ema_bcns pointers.
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
index e2b791c37591..cfe99de457cb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -987,15 +987,49 @@ static int ieee80211_set_ftm_responder_params(
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
+		memcpy(offset, src->elem[i].data, dest->elem[i].len);
+		dest->elem[i].data = offset;
+		offset += dest->elem[i].len;
+	}
+
+	return offset;
+}
+
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
 				   const struct ieee80211_csa_settings *csa,
 				   const struct ieee80211_color_change_settings *cca)
 {
-	struct beacon_data *new, *old;
-	int new_head_len, new_tail_len;
+	struct beacon_data *new = NULL, *old;
+	int new_head_len, new_tail_len, new_mbssid_len = 0;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
+	u8 *new_mbssid_offset;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
 
@@ -1017,12 +1051,27 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	/* new or old multiple BSSID elements? */
+	if (params->mbssid_ies)
+		new_mbssid_len = ieee80211_get_mbssid_beacon_len(params->mbssid_ies);
+	else if (old && old->mbssid_ies)
+		new_mbssid_len = ieee80211_get_mbssid_beacon_len(old->mbssid_ies);
+
+	size = sizeof(*new) + new_head_len + new_tail_len + new_mbssid_len;
 
 	new = kzalloc(size, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
+	if (new_mbssid_len) {
+		new->mbssid_ies = kzalloc(sizeof(*params->mbssid_ies),
+					  GFP_KERNEL);
+		if (!new->mbssid_ies) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
 	/* start filling the new info now */
 
 	/*
@@ -1034,6 +1083,15 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
 
+	/* copy in optional mbssid_ies */
+	new_mbssid_offset = new->tail + new_tail_len;
+	if (params->mbssid_ies)
+		ieee80211_copy_mbssid_beacon(new_mbssid_offset, new->mbssid_ies,
+					     params->mbssid_ies);
+	else if (old && old->mbssid_ies)
+		ieee80211_copy_mbssid_beacon(new_mbssid_offset, new->mbssid_ies,
+					     old->mbssid_ies);
+
 	if (csa) {
 		new->cntdwn_current_counter = csa->count;
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
@@ -1059,10 +1117,8 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
 				       params->probe_resp_len, csa, cca);
-	if (err < 0) {
-		kfree(new);
-		return err;
-	}
+	if (err < 0)
+		goto error;
 	if (err == 0)
 		changed |= BSS_CHANGED_AP_PROBE_RESP;
 
@@ -1074,20 +1130,26 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 							 params->civicloc,
 							 params->civicloc_len);
 
-		if (err < 0) {
-			kfree(new);
-			return err;
-		}
+		if (err < 0)
+			goto error;
 
 		changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
 
 	rcu_assign_pointer(sdata->u.ap.beacon, new);
 
-	if (old)
+	if (old) {
+		kfree(old->mbssid_ies);
 		kfree_rcu(old, rcu_head);
-
+	}
 	return changed;
+
+error:
+	if (new) {
+		kfree(new->mbssid_ies);
+		kfree(new);
+	}
+	return err;
 }
 
 static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
@@ -1246,8 +1308,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
 
-		if (old)
+		if (old) {
+			kfree(old->mbssid_ies);
 			kfree_rcu(old, rcu_head);
+		}
 		RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
 		goto error;
 	}
@@ -1327,8 +1391,11 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 
 	mutex_unlock(&local->mtx);
 
-	kfree(sdata->u.ap.next_beacon);
-	sdata->u.ap.next_beacon = NULL;
+	if (sdata->u.ap.next_beacon) {
+		kfree(sdata->u.ap.next_beacon->mbssid_ies);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+	}
 
 	/* turn off carrier for this interface and dependent VLANs */
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
@@ -1340,6 +1407,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.fils_discovery, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.unsol_bcast_probe_resp, NULL);
+	kfree(old_beacon->mbssid_ies);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
@@ -3123,13 +3191,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 
 	len = beacon->head_len + beacon->tail_len + beacon->beacon_ies_len +
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
-	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len;
+	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
+	      ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
 	if (!new_beacon)
 		return NULL;
 
+	if (beacon->mbssid_ies) {
+		new_beacon->mbssid_ies = kzalloc(sizeof(*beacon->mbssid_ies),
+						 GFP_KERNEL);
+		if (!new_beacon->mbssid_ies) {
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
@@ -3166,6 +3245,9 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
+	if (beacon->mbssid_ies && beacon->mbssid_ies->cnt)
+		pos = ieee80211_copy_mbssid_beacon(pos, new_beacon->mbssid_ies,
+						   beacon->mbssid_ies);
 
 	/* might copy -1, meaning no changes requested */
 	new_beacon->ftm_responder = beacon->ftm_responder;
@@ -3203,8 +3285,11 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP:
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		if (sdata->u.ap.next_beacon) {
+			kfree(sdata->u.ap.next_beacon->mbssid_ies);
+			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
+		}
 
 		if (err < 0)
 			return err;
@@ -3359,8 +3444,10 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		if ((params->n_counter_offsets_beacon >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
-		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM))
-			return -EINVAL;
+		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
+			err = -EINVAL;
+			goto error;
+		}
 
 		csa.counter_offsets_beacon = params->counter_offsets_beacon;
 		csa.counter_offsets_presp = params->counter_offsets_presp;
@@ -3369,10 +3456,8 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.count = params->count;
 
 		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa, NULL);
-		if (err < 0) {
-			kfree(sdata->u.ap.next_beacon);
-			return err;
-		}
+		if (err < 0)
+			goto error;
 		*changed |= err;
 
 		break;
@@ -3455,13 +3540,24 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	return 0;
+
+error:
+	if (sdata->vif.type == NL80211_IFTYPE_AP && sdata->u.ap.next_beacon) {
+		kfree(sdata->u.ap.next_beacon->mbssid_ies);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+	}
+	return err;
 }
 
 static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 {
 	sdata->vif.color_change_active = false;
-	kfree(sdata->u.ap.next_beacon);
-	sdata->u.ap.next_beacon = NULL;
+	if (sdata->u.ap.next_beacon) {
+		kfree(sdata->u.ap.next_beacon->mbssid_ies);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+	}
 
 	cfg80211_color_change_aborted_notify(sdata->dev);
 }
@@ -4199,8 +4295,11 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 
 		ret = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		if (sdata->u.ap.next_beacon) {
+			kfree(sdata->u.ap.next_beacon->mbssid_ies);
+			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
+		}
 
 		if (ret < 0)
 			return ret;
@@ -4243,7 +4342,11 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 		err = ieee80211_assign_beacon(sdata, &params->beacon_color_change,
 					      NULL, &color_change);
 		if (err < 0) {
-			kfree(sdata->u.ap.next_beacon);
+			if (sdata->u.ap.next_beacon) {
+				kfree(sdata->u.ap.next_beacon->mbssid_ies);
+				kfree(sdata->u.ap.next_beacon);
+				sdata->u.ap.next_beacon = NULL;
+			}
 			return err;
 		}
 		*changed |= err;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c3b8590a7e90..cf98823beeba 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -257,6 +257,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct rcu_head rcu_head;
 };
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ac9ab007dc6f..5e26427ff100 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5033,19 +5033,62 @@ ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
 		       IEEE80211_TX_CTL_FIRST_FRAGMENT;
 }
 
+static int ieee80211_beacon_mbssid_len(struct beacon_data *beacon, int index)
+{
+	int len = 0;
+
+	if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt)
+		return 0;
+	else if (index >= beacon->mbssid_ies->cnt)
+		return -1;
+
+	if (index >= 0) {
+		len = beacon->mbssid_ies->elem[index].len;
+	} else {
+		u8 i;
+
+		for (i = 0; i < beacon->mbssid_ies->cnt; i++)
+			len += beacon->mbssid_ies->elem[i].len;
+	}
+
+	return len;
+}
+
+static void ieee80211_beacon_add_mbssid(struct beacon_data *beacon, int index,
+					struct sk_buff *skb)
+{
+	if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt ||
+	    index >= beacon->mbssid_ies->cnt)
+		return;
+
+	if (index >= 0) {
+		skb_put_data(skb, beacon->mbssid_ies->elem[index].data,
+			     beacon->mbssid_ies->elem[index].len);
+	} else {
+		int i;
+
+		for (i = 0; i < beacon->mbssid_ies->cnt; i++)
+			skb_put_data(skb,
+				     beacon->mbssid_ies->elem[i].data,
+				     beacon->mbssid_ies->elem[i].len);
+	}
+}
+
 static struct sk_buff *
-ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
-			struct ieee80211_vif *vif,
-			struct ieee80211_mutable_offsets *offs,
-			bool is_template,
-			struct beacon_data *beacon,
-			struct ieee80211_chanctx_conf *chanctx_conf)
+__ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_mutable_offsets *offs,
+			  bool is_template,
+			  struct beacon_data *beacon,
+			  struct ieee80211_chanctx_conf *chanctx_conf,
+			  int ema_index)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_if_ap *ap = &sdata->u.ap;
 	struct sk_buff *skb = NULL;
 	u16 csa_off_base = 0;
+	size_t mbssid_elems_len = 0;
 
 	if (beacon->cntdwn_counter_offsets[0]) {
 		if (!is_template)
@@ -5054,12 +5097,16 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		ieee80211_set_beacon_cntdwn(sdata, beacon);
 	}
 
+	mbssid_elems_len = ieee80211_beacon_mbssid_len(beacon, ema_index);
+	if (mbssid_elems_len == -1)
+		return NULL;
+
 	/* headroom, head length,
-	 * tail length and maximum TIM length
+	 * tail length, maximum TIM length and multiple BSSID length
 	 */
 	skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
 			    beacon->tail_len + 256 +
-			    local->hw.extra_beacon_tailroom);
+			    local->hw.extra_beacon_tailroom + mbssid_elems_len);
 	if (!skb)
 		return NULL;
 
@@ -5077,6 +5124,14 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
+	if (mbssid_elems_len) {
+		ieee80211_beacon_add_mbssid(beacon, ema_index, skb);
+		if (offs) {
+			offs->mbssid_off = skb->len - mbssid_elems_len;
+			csa_off_base = skb->len;
+		}
+	}
+
 	if (beacon->tail)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
@@ -5088,11 +5143,73 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	return skb;
 }
 
+static struct sk_buff *
+ieee80211_beacon_get_ap_mbssid(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_mutable_offsets *offs,
+			       bool is_template,
+			       struct beacon_data *beacon,
+			       struct ieee80211_chanctx_conf *chanctx_conf,
+			       int ema_index,
+			       struct list_head *ema_list)
+{
+	u8 i;
+
+	if (!ema_list)
+		return __ieee80211_beacon_get_ap(hw, vif, offs, is_template,
+						 beacon, chanctx_conf,
+						 ema_index);
+
+	for (i = 0; i < beacon->mbssid_ies->cnt; i++) {
+		struct ieee80211_ema_bcns *bcn;
+
+		bcn = kzalloc(sizeof(*bcn), GFP_KERNEL);
+		if (!bcn)
+			break;
+
+		bcn->skb = __ieee80211_beacon_get_ap(hw, vif, &bcn->offs,
+						     is_template, beacon,
+						     chanctx_conf, i);
+		if (!bcn->skb) {
+			kfree(bcn);
+			break;
+		}
+		list_add_tail(&bcn->list, ema_list);
+	}
+
+	if (i < beacon->mbssid_ies->cnt)
+		ieee80211_beacon_free_ema_list(ema_list);
+
+	return NULL;
+}
+
+static struct sk_buff *
+ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
+			struct ieee80211_vif *vif,
+			struct ieee80211_mutable_offsets *offs,
+			bool is_template,
+			struct beacon_data *beacon,
+			struct ieee80211_chanctx_conf *chanctx_conf,
+			int ema_index,
+			struct list_head *ema_list)
+{
+	if (beacon->mbssid_ies && beacon->mbssid_ies->cnt)
+		return ieee80211_beacon_get_ap_mbssid(hw, vif, offs,
+						      is_template, beacon,
+						      chanctx_conf, ema_index,
+						      ema_list);
+
+	return __ieee80211_beacon_get_ap(hw, vif, offs, is_template, beacon,
+					 chanctx_conf, -1);
+}
+
 static struct sk_buff *
 __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
 		       struct ieee80211_mutable_offsets *offs,
-		       bool is_template)
+		       bool is_template,
+		       int ema_index,
+		       struct list_head *ema_list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct beacon_data *beacon = NULL;
@@ -5119,7 +5236,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			goto out;
 
 		skb = ieee80211_beacon_get_ap(hw, vif, offs, is_template,
-					      beacon, chanctx_conf);
+					      beacon, chanctx_conf, ema_index,
+					      ema_list);
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 		struct ieee80211_hdr *hdr;
@@ -5205,16 +5323,49 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_mutable_offsets *offs)
 {
-	return __ieee80211_beacon_get(hw, vif, offs, true);
+	return __ieee80211_beacon_get(hw, vif, offs, true, -1, NULL);
 }
 EXPORT_SYMBOL(ieee80211_beacon_get_template);
 
+struct sk_buff *
+ieee80211_beacon_get_template_ema_index(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_mutable_offsets *offs,
+					u8 ema_index)
+{
+	return __ieee80211_beacon_get(hw, vif, offs, true, ema_index, NULL);
+}
+EXPORT_SYMBOL(ieee80211_beacon_get_template_ema_index);
+
+void ieee80211_beacon_free_ema_list(struct list_head *head)
+{
+	struct ieee80211_ema_bcns *ema, *tmp;
+
+	list_for_each_entry_safe(ema, tmp, head, list) {
+		kfree_skb(ema->skb);
+		kfree(ema);
+	}
+}
+EXPORT_SYMBOL(ieee80211_beacon_free_ema_list);
+
+void ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct list_head *head)
+{
+	if (!head)
+		return;
+
+	(void)__ieee80211_beacon_get(hw, vif, NULL, false, 0, head);
+}
+EXPORT_SYMBOL(ieee80211_beacon_get_template_ema_list);
+
 struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 u16 *tim_offset, u16 *tim_length)
 {
 	struct ieee80211_mutable_offsets offs = {};
-	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false);
+	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false, 0,
+						     NULL);
 	struct sk_buff *copy;
 	struct ieee80211_supported_band *sband;
 	int shift;
-- 
2.31.1

