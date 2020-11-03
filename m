Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9012A3FCD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKCJR4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgKCJRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:17:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED15C0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:17:52 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsRp-0006BN-5T; Tue, 03 Nov 2020 10:17:49 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V5 3/4] mac80211: add multiple bssid/EMA support to beacon handling
Date:   Tue,  3 Nov 2020 10:17:42 +0100
Message-Id: <20201103091743.1924854-4-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103091743.1924854-1-john@phrozen.org>
References: <20201103091743.1924854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  90 +++++++++++++++++++++
 net/mac80211/cfg.c         |  57 +++++++++++++-
 net/mac80211/ieee80211_i.h |   2 +
 net/mac80211/tx.c          | 156 +++++++++++++++++++++++++++++++++----
 4 files changed, 285 insertions(+), 20 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 1edaee6710a6..051b7cae2516 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4865,12 +4865,17 @@ void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
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
@@ -4897,6 +4902,91 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
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
+
+struct sk_buff *
+ieee80211_beacon_get_template_ema_next(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_mutable_offsets *offs);
+
+/** struct ieee80211_ema_bcn_list - list entry of an EMA beacon
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
+int
+ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct list_head *head);
+
+/**
+ * ieee80211_beacon_free_ema_list - free an EMA beacon template list
+ * @head: linked list head containing &struct ieee80211_ema_bcn_list pointers.
+ *
+ * This function will free a list previously acquired by calling
+ * ieee80211_beacon_get_template_ema_list()
+ */
+
+void
+ieee80211_beacon_free_ema_list(struct list_head *head);
+
 /**
  * ieee80211_beacon_get_tim - beacon generation function
  * @hw: pointer obtained from ieee80211_alloc_hw().
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 12a6edf490ca..cfe38480a3fc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -983,12 +983,38 @@ static int ieee80211_set_ftm_responder_params(
 	return 0;
 }
 
+static int ieee80211_get_multiple_bssid_beacon_len(struct cfg80211_multiple_bssid_data *data)
+{
+	int i, len = 0;
+
+	for (i = 0; i < data->cnt; i++)
+		len += data->len[i];
+
+	return len;
+}
+
+static u8 *ieee80211_copy_multiple_bssid_beacon(u8 *offset,
+						struct cfg80211_multiple_bssid_data *new,
+						struct cfg80211_multiple_bssid_data *old)
+{
+	int i;
+
+	*new = *old;
+	for (i = 0; i < new->cnt; i++) {
+		new->ies[i] = offset;
+		memcpy(new->ies[i], old->ies[i], new->len[i]);
+		offset += new->len[i];
+	}
+	return offset;
+}
+
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
 				   const struct ieee80211_csa_settings *csa)
 {
 	struct beacon_data *new, *old;
-	int new_head_len, new_tail_len;
+	int new_head_len, new_tail_len, new_multiple_bssid_len;
+	u8 *new_multiple_bssid_offset;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
 
@@ -1012,7 +1038,15 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	/* new or old multiple_bssid? */
+	if (params->multiple_bssid.cnt || !old)
+		new_multiple_bssid_len =
+			ieee80211_get_multiple_bssid_beacon_len(&params->multiple_bssid);
+	else
+		new_multiple_bssid_len =
+			ieee80211_get_multiple_bssid_beacon_len(&old->multiple_bssid);
+
+	size = sizeof(*new) + new_head_len + new_tail_len + new_multiple_bssid_len;
 
 	new = kzalloc(size, GFP_KERNEL);
 	if (!new)
@@ -1029,6 +1063,18 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
 
+	new_multiple_bssid_offset = new->tail + new_tail_len;
+
+	/* copy in optional multiple_bssid_ies */
+	if (params->multiple_bssid.cnt)
+		ieee80211_copy_multiple_bssid_beacon(new_multiple_bssid_offset,
+						     &new->multiple_bssid,
+						     &params->multiple_bssid);
+	else if (old && old->multiple_bssid.cnt)
+		ieee80211_copy_multiple_bssid_beacon(new_multiple_bssid_offset,
+						     &new->multiple_bssid,
+						     &old->multiple_bssid);
+
 	if (csa) {
 		new->cntdwn_current_counter = csa->count;
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
@@ -3095,7 +3141,8 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 
 	len = beacon->head_len + beacon->tail_len + beacon->beacon_ies_len +
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
-	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len;
+	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
+	      ieee80211_get_multiple_bssid_beacon_len(&beacon->multiple_bssid);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
 	if (!new_beacon)
@@ -3138,6 +3185,10 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
+	if (beacon->multiple_bssid.cnt)
+		pos = ieee80211_copy_multiple_bssid_beacon(pos,
+							   &new_beacon->multiple_bssid,
+							   &beacon->multiple_bssid);
 
 	/* might copy -1, meaning no changes requested */
 	new_beacon->ftm_responder = beacon->ftm_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2a21226fb518..e510abc5ace2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -261,6 +261,8 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	struct cfg80211_multiple_bssid_data multiple_bssid;
+	u16 ema_index;
 	struct rcu_head rcu_head;
 };
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8ba10a48ded4..ca0d49af9a0f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4735,11 +4735,25 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	return 0;
 }
 
+static void
+ieee80211_beacon_add_multiple_bssid_config(struct ieee80211_vif *vif, struct sk_buff *skb,
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
@@ -4751,13 +4765,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
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
@@ -4767,6 +4779,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ap->beacon);
 		if (beacon) {
+			int multiple_bssid_len = 0;
+
 			if (beacon->cntdwn_counter_offsets[0]) {
 				if (!is_template)
 					ieee80211_beacon_update_cntdwn(vif);
@@ -4774,6 +4788,27 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				ieee80211_set_beacon_cntdwn(sdata, beacon);
 			}
 
+			if (ema_index == IEEE80211_BCN_EMA_NEXT) {
+				ema_index = beacon->ema_index;
+				beacon->ema_index++;
+				beacon->ema_index %= beacon->multiple_bssid.cnt;
+			}
+
+			if (ema_index != IEEE80211_BCN_EMA_NONE &&
+			    ema_index >= beacon->multiple_bssid.cnt)
+				return NULL;
+
+			if (beacon->multiple_bssid.cnt) {
+				if (ema_index >= IEEE80211_BCN_EMA_INDEX) {
+					multiple_bssid_len = beacon->multiple_bssid.len[ema_index];
+				} else {
+					int i;
+
+					for (i = 0; i < beacon->multiple_bssid.cnt; i++)
+						multiple_bssid_len = beacon->multiple_bssid.len[i];
+				}
+			}
+
 			/*
 			 * headroom, head length,
 			 * tail length and maximum TIM length
@@ -4781,9 +4816,10 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			skb = dev_alloc_skb(local->tx_headroom +
 					    beacon->head_len +
 					    beacon->tail_len + 256 +
-					    local->hw.extra_beacon_tailroom);
+					    local->hw.extra_beacon_tailroom +
+					    multiple_bssid_len);
 			if (!skb)
-				goto out;
+				return NULL;
 
 			skb_reserve(skb, local->tx_headroom);
 			skb_put_data(skb, beacon->head, beacon->head_len);
@@ -4799,21 +4835,39 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				csa_off_base = skb->len;
 			}
 
+			if (multiple_bssid_len) {
+				if (ema_index >= IEEE80211_BCN_EMA_INDEX) {
+					ieee80211_beacon_add_multiple_bssid_config(vif, skb,
+									   &beacon->multiple_bssid);
+					skb_put_data(skb,
+						     beacon->multiple_bssid.ies[ema_index],
+						     beacon->multiple_bssid.len[ema_index]);
+				} else {
+					int i;
+
+					for (i = 0; i < beacon->multiple_bssid.cnt; i++)
+						skb_put_data(skb, beacon->multiple_bssid.ies[i],
+							     beacon->multiple_bssid.len[i]);
+				}
+				if (offs)
+					offs->multiple_bssid_offset = skb->len - multiple_bssid_len;
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
@@ -4825,7 +4879,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
 				    local->hw.extra_beacon_tailroom);
 		if (!skb)
-			goto out;
+			return NULL;
 		skb_reserve(skb, local->tx_headroom);
 		skb_put_data(skb, beacon->head, beacon->head_len);
 
@@ -4837,7 +4891,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ifmsh->beacon);
 		if (!beacon)
-			goto out;
+			return NULL;
 
 		if (beacon->cntdwn_counter_offsets[0]) {
 			if (!is_template)
@@ -4860,7 +4914,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				    beacon->tail_len +
 				    local->hw.extra_beacon_tailroom);
 		if (!skb)
-			goto out;
+			return NULL;
 		skb_reserve(skb, local->tx_headroom);
 		skb_put_data(skb, beacon->head, beacon->head_len);
 		ieee80211_beacon_add_tim(sdata, &ifmsh->ps, skb, is_template);
@@ -4873,7 +4927,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 	} else {
 		WARN_ON(1);
-		goto out;
+		return NULL;
 	}
 
 	/* CSA offsets */
@@ -4916,8 +4970,6 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT |
 			IEEE80211_TX_CTL_ASSIGN_SEQ |
 			IEEE80211_TX_CTL_FIRST_FRAGMENT;
- out:
-	rcu_read_unlock();
 	return skb;
 
 }
@@ -4927,16 +4979,86 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_mutable_offsets *offs)
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
 
+struct sk_buff *
+ieee80211_beacon_get_template_ema_next(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_mutable_offsets *offs)
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
+void
+ieee80211_beacon_free_ema_list(struct list_head *head)
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
2.25.1

