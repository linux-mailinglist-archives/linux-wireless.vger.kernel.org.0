Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE62FB3CA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 09:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbhASILl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 03:11:41 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:19776 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731626AbhASILP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 03:11:15 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 03:10:26 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611043844; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=yY0KvOeoT6cYiopYqZkQkMIzll/B/JVMCaWYtQ4VIks=; b=pb52GzsiovMpRU2TdpBkRsc7U6HlL36F2keDgHo3oGphz99yavYm4l5P447UOvi1P/DAE9GZ
 lsFHPVbgFFKXIibx3QKsK9C/EtnIzywRRGSzM9acBGqqT1CmXdkhbt+4Bl2KLY3kW46xYaMM
 VnN5bWDVH5sIvmboz/CNgDHis2c=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 600693ff1e3bf9b6690a64d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 08:10:39
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13CA3C433CA; Tue, 19 Jan 2021 08:10:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 463D9C433C6;
        Tue, 19 Jan 2021 08:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 463D9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V6 3/4] mac80211: add multiple bssid/EMA support to beacon handling
Date:   Tue, 19 Jan 2021 00:10:26 -0800
Message-Id: <20210119081027.5133-4-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210119081027.5133-1-alokad@codeaurora.org>
References: <20210119081027.5133-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

With beacon_data now holding the additional information about the multiple
bssid elements, we need to honour these in the various beacon handling
code paths.

Extend ieee80211_beacon_get_template() to allow generation of multiple
bssid/EMA beacons. The API provides support for HW that can offload the
EMA beaconing aswell as HW that will require periodic updates of the
beacon template upon completion events.

In case the HW can do full EMA offload, functions are provided that allow
the driver to get a list of the periodicity number of beacons and their
matching mutable offsets.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v6: Addressed review comments.
Dynamic memory allocation of MBSSID element structures in beacons.
Added MBSSID config element length in beacon length calculation.

 include/net/mac80211.h     |  86 +++++++++++++++++
 net/mac80211/cfg.c         | 117 ++++++++++++++++++++---
 net/mac80211/ieee80211_i.h |   2 +
 net/mac80211/tx.c          | 189 ++++++++++++++++++++++++++++++++-----
 4 files changed, 362 insertions(+), 32 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 861156d7dfc3..6336b6a5a1be 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4872,12 +4872,17 @@ void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
  * @cntdwn_counter_offs: array of IEEE80211_MAX_CNTDWN_COUNTERS_NUM offsets
  *	to countdown counters.  This array can contain zero values which
  *	should be ignored.
+ * @multiple_bssid_offset: position of the multiple bssid element
+ * @multiple_bssid_length: size of the multiple bssid element
  */
 struct ieee80211_mutable_offsets {
 	u16 tim_offset;
 	u16 tim_length;
 
 	u16 cntdwn_counter_offs[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
+
+	u16 multiple_bssid_offset;
+	u16 multiple_bssid_length;
 };
 
 /**
@@ -4904,6 +4909,87 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_mutable_offsets *offs);
 
+/**
+ * enum ieee80211_bcn_tmpl_ema - EMA beacon generation type
+ * @IEEE80211_BCN_EMA_NONE: don't generate an EMA beacon.
+ * @IEEE80211_BCN_EMA_NEXT: generate the next periodicity beacon.
+ * @IEEE80211_BCN_EMA_INDEX: generate beacon by periodicity index
+ *	if the value is >= this enum value.
+ */
+enum ieee80211_bcn_tmpl_ema {
+	IEEE80211_BCN_EMA_NONE	= -2,
+	IEEE80211_BCN_EMA_NEXT	= -1,
+	IEEE80211_BCN_EMA_INDEX	= 0,
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
+ * This function differs from ieee80211_beacon_get_template in the sense that
+ * it generates EMA VAP templates. When we use multiple_bssid, the beacons can
+ * get very large costing a lot of airtime. To work around this, we iterate
+ * over the multiple bssid elements and only send one inside the beacon for
+ * 1..n. Calling this function will auto-increment the periodicity counter.
+ *
+ * This function needs to follow the same rules as ieee80211_beacon_get_template
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
+ * This function differs from ieee80211_beacon_get_template in the sense that
+ * it generates EMA VAP templates. When we use multiple_bssid, the beacons can
+ * get very large costing a lot of airtime. To work around this, we iterate
+ * over the multiple bssid elements and only send one inside the beacon for
+ * 1..n. This function will populate a linked list that the driver can pass
+ * to the HW.
+ *
+ * This function needs to follow the same rules as ieee80211_beacon_get_template
+ *
+ * Return: The nuber of entries in the list or 0 on error.
+ */
+
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
index 91e659a43f67..9c4346f69a7b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -984,12 +984,48 @@ static int ieee80211_set_ftm_responder_params(
 	return 0;
 }
 
+	static int
+ieee80211_get_multiple_bssid_beacon_len(struct cfg80211_multiple_bssid_data *data)
+{
+	int i, len = 0;
+
+	if (!data)
+		return 0;
+
+	for (i = 0; i < data->cnt; i++)
+		len += data->elems[i].len;
+
+	return len;
+}
+
+static u8 *ieee80211_copy_multiple_bssid_beacon(u8 *offset,
+						struct cfg80211_multiple_bssid_data *dest,
+						struct cfg80211_multiple_bssid_data *src)
+{
+	int i;
+
+	if (!dest || !src)
+		return offset;
+
+	dest->cnt = src->cnt;
+	for (i = 0; i < dest->cnt; i++) {
+		dest->elems[i].len = src->elems[i].len;
+		dest->elems[i].data = offset;
+		memcpy(dest->elems[i].data, src->elems[i].data,
+		       dest->elems[i].len);
+		offset += dest->elems[i].len;
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
+	int new_head_len, new_tail_len, new_multiple_bssid_len = 0;
+	u8 *new_multiple_bssid_offset;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
 
@@ -1013,12 +1049,30 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	/* new or old multiple_bssid? */
+	if (params->multiple_bssid)
+		new_multiple_bssid_len =
+			ieee80211_get_multiple_bssid_beacon_len(params->multiple_bssid);
+	else if (old && old->multiple_bssid)
+		new_multiple_bssid_len =
+			ieee80211_get_multiple_bssid_beacon_len(old->multiple_bssid);
+
+	size = sizeof(*new) + new_head_len + new_tail_len +
+	       new_multiple_bssid_len;
 
 	new = kzalloc(size, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
+	if (new_multiple_bssid_len) {
+		new->multiple_bssid = kzalloc(sizeof(*params->multiple_bssid),
+					      GFP_KERNEL);
+		if (!new->multiple_bssid) {
+			kfree(new);
+			return -ENOMEM;
+		}
+	}
+
 	/* start filling the new info now */
 
 	/*
@@ -1030,6 +1084,17 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
 
+	/* copy in optional multiple_bssid_ies */
+	new_multiple_bssid_offset = new->tail + new_tail_len;
+	if (params->multiple_bssid)
+		ieee80211_copy_multiple_bssid_beacon(new_multiple_bssid_offset,
+						     new->multiple_bssid,
+						     params->multiple_bssid);
+	else if (old && old->multiple_bssid)
+		ieee80211_copy_multiple_bssid_beacon(new_multiple_bssid_offset,
+						     new->multiple_bssid,
+						     old->multiple_bssid);
+
 	if (csa) {
 		new->cntdwn_current_counter = csa->count;
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
@@ -1053,6 +1118,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
 				       params->probe_resp_len, csa);
 	if (err < 0) {
+		kfree(new->multiple_bssid);
 		kfree(new);
 		return err;
 	}
@@ -1068,6 +1134,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 							 params->civicloc_len);
 
 		if (err < 0) {
+			kfree(new->multiple_bssid);
 			kfree(new);
 			return err;
 		}
@@ -1077,9 +1144,10 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	rcu_assign_pointer(sdata->u.ap.beacon, new);
 
-	if (old)
+	if (old) {
+		kfree(old->multiple_bssid);
 		kfree_rcu(old, rcu_head);
-
+	}
 	return changed;
 }
 
@@ -1234,8 +1302,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
 
-		if (old)
+		if (old) {
+			kfree(old->multiple_bssid);
 			kfree_rcu(old, rcu_head);
+		}
 		RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
 		goto error;
 	}
@@ -1315,8 +1385,11 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 
 	mutex_unlock(&local->mtx);
 
-	kfree(sdata->u.ap.next_beacon);
-	sdata->u.ap.next_beacon = NULL;
+	if (sdata->u.ap.next_beacon) {
+		kfree(sdata->u.ap.next_beacon->multiple_bssid);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+	}
 
 	/* turn off carrier for this interface and dependent VLANs */
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
@@ -1328,6 +1401,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.fils_discovery, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.unsol_bcast_probe_resp, NULL);
+	kfree(old_beacon->multiple_bssid);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
@@ -3084,13 +3158,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 
 	len = beacon->head_len + beacon->tail_len + beacon->beacon_ies_len +
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
-	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len;
+	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
+	      ieee80211_get_multiple_bssid_beacon_len(beacon->multiple_bssid);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
 	if (!new_beacon)
 		return NULL;
 
+	if (beacon->multiple_bssid) {
+		new_beacon->multiple_bssid = kzalloc(sizeof(*beacon->multiple_bssid),
+						     GFP_KERNEL);
+		if (!new_beacon->multiple_bssid) {
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
@@ -3127,6 +3212,10 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
+	if (beacon->multiple_bssid && beacon->multiple_bssid->cnt)
+		pos = ieee80211_copy_multiple_bssid_beacon(pos,
+							   new_beacon->multiple_bssid,
+							   beacon->multiple_bssid);
 
 	/* might copy -1, meaning no changes requested */
 	new_beacon->ftm_responder = beacon->ftm_responder;
@@ -3164,8 +3253,11 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP:
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		if (sdata->u.ap.next_beacon) {
+			kfree(sdata->u.ap.next_beacon->multiple_bssid);
+			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
+		}
 
 		if (err < 0)
 			return err;
@@ -3331,7 +3423,10 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa);
 		if (err < 0) {
-			kfree(sdata->u.ap.next_beacon);
+			if (sdata->u.ap.next_beacon) {
+				kfree(sdata->u.ap.next_beacon->multiple_bssid);
+				kfree(sdata->u.ap.next_beacon);
+			}
 			return err;
 		}
 		*changed |= err;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8bf9c0e974d6..beb8e2ea612b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -261,6 +261,8 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	struct cfg80211_multiple_bssid_data *multiple_bssid;
+	u16 ema_index;
 	struct rcu_head rcu_head;
 };
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6422da6690f7..c28eb17186d0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4721,11 +4721,71 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	return 0;
 }
 
+static int ieee80211_beacon_multiple_bssid_len(struct beacon_data *beacon,
+					       int index)
+{
+	int len = 0, i;
+
+	if (index == IEEE80211_BCN_EMA_NEXT) {
+		index = beacon->ema_index;
+		beacon->ema_index++;
+		beacon->ema_index %= beacon->multiple_bssid->cnt;
+	}
+
+	if (index != IEEE80211_BCN_EMA_NONE &&
+	    index >= beacon->multiple_bssid->cnt)
+		return -1;
+
+	if (beacon->multiple_bssid->cnt) {
+		if (index >= IEEE80211_BCN_EMA_INDEX) {
+			len = beacon->multiple_bssid->elems[index].len;
+		} else {
+			for (i = 0; i < beacon->multiple_bssid->cnt; i++)
+				len += beacon->multiple_bssid->elems[i].len;
+		}
+	}
+	return len;
+}
+
+static void
+ieee80211_beacon_add_multiple_bssid_config(struct ieee80211_vif *vif,
+					   struct sk_buff *skb,
+					   struct cfg80211_multiple_bssid_data *config)
+{
+	u8 *pos = skb_put(skb, 5);
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 3;
+	*pos++ = WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION;
+	*pos++ = vif->bss_conf.multiple_bssid.count;
+	*pos++ = config->cnt;
+}
+
+static void
+ieee80211_beacon_add_multiple_bssid(struct ieee80211_vif *vif,
+				    struct sk_buff *skb,
+				    struct cfg80211_multiple_bssid_data *config,
+				    int index)
+{
+	if (index >= IEEE80211_BCN_EMA_INDEX) {
+		ieee80211_beacon_add_multiple_bssid_config(vif, skb, config);
+		skb_put_data(skb, config->elems[index].data,
+			     config->elems[index].len);
+	} else {
+		int i;
+
+		for (i = 0; i < config->cnt; i++)
+			skb_put_data(skb, config->elems[i].data,
+				     config->elems[i].len);
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
@@ -4737,13 +4797,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
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
@@ -4753,6 +4811,9 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ap->beacon);
 		if (beacon) {
+			int multiple_bssid_elems_len = 0;
+			int multiple_bssid_config_len = 5;
+
 			if (beacon->cntdwn_counter_offsets[0]) {
 				if (!is_template)
 					ieee80211_beacon_update_cntdwn(vif);
@@ -4760,6 +4821,14 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				ieee80211_set_beacon_cntdwn(sdata, beacon);
 			}
 
+			if (beacon->multiple_bssid) {
+				multiple_bssid_elems_len =
+					ieee80211_beacon_multiple_bssid_len(beacon,
+									    ema_index);
+				if (multiple_bssid_elems_len == -1)
+					return NULL;
+			}
+
 			/*
 			 * headroom, head length,
 			 * tail length and maximum TIM length
@@ -4767,9 +4836,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			skb = dev_alloc_skb(local->tx_headroom +
 					    beacon->head_len +
 					    beacon->tail_len + 256 +
-					    local->hw.extra_beacon_tailroom);
+					    local->hw.extra_beacon_tailroom +
+					    multiple_bssid_config_len +
+					    multiple_bssid_elems_len);
 			if (!skb)
-				goto out;
+				return NULL;
 
 			skb_reserve(skb, local->tx_headroom);
 			skb_put_data(skb, beacon->head, beacon->head_len);
@@ -4785,21 +4856,32 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				csa_off_base = skb->len;
 			}
 
+			if (multiple_bssid_elems_len) {
+				ieee80211_beacon_add_multiple_bssid(vif, skb,
+								    beacon->multiple_bssid,
+								    ema_index);
+				if (offs) {
+					offs->multiple_bssid_offset = skb->len -
+								      multiple_bssid_elems_len;
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
@@ -4811,7 +4893,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
 				    local->hw.extra_beacon_tailroom);
 		if (!skb)
-			goto out;
+			return NULL;
 		skb_reserve(skb, local->tx_headroom);
 		skb_put_data(skb, beacon->head, beacon->head_len);
 
@@ -4823,7 +4905,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ifmsh->beacon);
 		if (!beacon)
-			goto out;
+			return NULL;
 
 		if (beacon->cntdwn_counter_offsets[0]) {
 			if (!is_template)
@@ -4846,7 +4928,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				    beacon->tail_len +
 				    local->hw.extra_beacon_tailroom);
 		if (!skb)
-			goto out;
+			return NULL;
 		skb_reserve(skb, local->tx_headroom);
 		skb_put_data(skb, beacon->head, beacon->head_len);
 		ieee80211_beacon_add_tim(sdata, &ifmsh->ps, skb, is_template);
@@ -4859,7 +4941,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 	} else {
 		WARN_ON(1);
-		goto out;
+		return NULL;
 	}
 
 	/* CSA offsets */
@@ -4902,27 +4984,92 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
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
+	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false,
+						     IEEE80211_BCN_EMA_NONE);
 	struct sk_buff *copy;
 	struct ieee80211_supported_band *sband;
 	int shift;
-- 
2.25.0

