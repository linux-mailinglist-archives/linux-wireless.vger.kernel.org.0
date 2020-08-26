Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9202526A0
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 07:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHZF5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 01:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgHZF5E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 01:57:04 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CEC0613ED
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 22:57:03 -0700 (PDT)
Received: from [149.224.157.14] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kAoQc-0004ao-T0; Wed, 26 Aug 2020 07:56:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 4/5] mac80211: add support for BSS coloring
Date:   Wed, 26 Aug 2020 07:56:49 +0200
Message-Id: <20200826055650.1101224-4-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826055650.1101224-1-john@phrozen.org>
References: <20200826055650.1101224-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The color change (color change announcement) is very similar to how CSA works where
we have an IE that includes a counter. When the counter hits 0, the new
color is applied via an updated beacon.

This patch makes the CSA counter functionality reusable, rather than
implementing it again. This also allows for future reuse incase support
for other counter IEs gets added.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  28 +++++
 net/mac80211/cfg.c         | 228 +++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  12 ++
 net/mac80211/iface.c       |   3 +
 net/mac80211/tx.c          |  24 ++--
 5 files changed, 277 insertions(+), 18 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ec148b3e9c41..5f970ad6463e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1645,6 +1645,10 @@ enum ieee80211_vif_flags {
  * @txq: the multicast data TX queue (if driver uses the TXQ abstraction)
  * @txqs_stopped: per AC flag to indicate that intermediate TXQs are stopped,
  *	protected by fq->lock.
+ * @color_change_active: marks whether a color change is going on. Internally it is
+ *	write-protected by sdata_lock and local->mtx so holding either is fine
+ *	for read access.
+ * @color_change_color: the color that we will have after the change.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1672,6 +1676,9 @@ struct ieee80211_vif {
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
+	bool color_change_active;
+	u8 color_change_color;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -4890,6 +4897,16 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif);
  */
 bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif);
 
+/**
+ * ieee80211_color_change_finish - notify mac80211 about color change
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ *
+ * After a color change announcement was scheduled and the counter in this
+ * announcement hits 1, this function must be called by the driver to
+ * notify mac80211 that the color can be changed
+ */
+void ieee80211_color_change_finish(struct ieee80211_vif *vif);
+
 /**
  * ieee80211_proberesp_get - retrieve a Probe Response template
  * @hw: pointer obtained from ieee80211_alloc_hw().
@@ -6593,4 +6610,15 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
  */
 bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
 
+/**
+ * ieeee80211_obss_color_collision_notify notify userland about a BSS color
+ * collision.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @color_bitmap: a 64 bit bitmap representing the colors that the local BSS is
+ *	aware of.
+ */
+void
+ieeee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
+				       u64 color_bitmap);
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4e39e31a985..cae4c3696c12 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -809,7 +809,8 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 
 static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 				    const u8 *resp, size_t resp_len,
-				    const struct ieee80211_csa_settings *csa)
+				    const struct ieee80211_csa_settings *csa,
+				    const struct ieee80211_color_change_settings *color_change)
 {
 	struct probe_resp *new, *old;
 
@@ -829,6 +830,8 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_presp,
 		       csa->n_counter_offsets_presp *
 		       sizeof(new->cntdwn_counter_offsets[0]));
+	if (color_change)
+		new->cntdwn_counter_offsets[0] = color_change->counter_offset_presp;
 
 	rcu_assign_pointer(sdata->u.ap.probe_resp, new);
 	if (old)
@@ -881,7 +884,8 @@ static int ieee80211_set_ftm_responder_params(
 
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
-				   const struct ieee80211_csa_settings *csa)
+				   const struct ieee80211_csa_settings *csa,
+				   const struct ieee80211_color_change_settings *color_change)
 {
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
@@ -932,6 +936,11 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		       sizeof(new->cntdwn_counter_offsets[0]));
 	}
 
+	if (color_change) {
+		new->cntdwn_current_counter = color_change->count;
+		new->cntdwn_counter_offsets[0] = color_change->counter_offset_beacon;
+	}
+
 	/* copy in head */
 	if (params->head)
 		memcpy(new->head, params->head, new_head_len);
@@ -946,7 +955,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			memcpy(new->tail, old->tail, new_tail_len);
 
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
-				       params->probe_resp_len, csa);
+				       params->probe_resp_len, csa, color_change);
 	if (err < 0) {
 		kfree(new);
 		return err;
@@ -1098,7 +1107,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		}
 	}
 
-	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL);
+	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL, NULL);
 	if (err < 0) {
 		ieee80211_vif_release_channel(sdata);
 		return err;
@@ -1136,17 +1145,17 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	sdata_assert_lock(sdata);
 
-	/* don't allow changing the beacon while CSA is in place - offset
+	/* don't allow changing the beacon while a countdown is in place - offset
 	 * of channel switch counter may change
 	 */
-	if (sdata->vif.csa_active)
+	if (sdata->vif.csa_active || sdata->vif.color_change_active)
 		return -EBUSY;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, params, NULL);
+	err = ieee80211_assign_beacon(sdata, params, NULL, NULL);
 	if (err < 0)
 		return err;
 	ieee80211_bss_info_change_notify(sdata, err);
@@ -3031,7 +3040,7 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
-					      NULL);
+					      NULL, NULL);
 		kfree(sdata->u.ap.next_beacon);
 		sdata->u.ap.next_beacon = NULL;
 
@@ -3197,7 +3206,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.n_counter_offsets_presp = params->n_counter_offsets_presp;
 		csa.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa);
+		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa, NULL);
 		if (err < 0) {
 			kfree(sdata->u.ap.next_beacon);
 			return err;
@@ -3285,6 +3294,14 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
+{
+	sdata->vif.color_change_active = false;
+	kfree(sdata->u.ap.next_beacon);
+	sdata->u.ap.next_beacon = NULL;
+	cfg80211_color_change_aborted_notify(sdata->dev);
+}
+
 static int
 __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			   struct cfg80211_csa_settings *params)
@@ -3353,6 +3370,10 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	/* if there is a color change in progress, abort it */
+	if (sdata->vif.color_change_active)
+		ieee80211_color_change_abort(sdata);
+
 	err = ieee80211_set_csa_beacon(sdata, params, &changed);
 	if (err) {
 		ieee80211_vif_unreserve_chanctx(sdata);
@@ -3993,6 +4014,194 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 	return ret;
 }
 
+static int ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+						   u32 *changed)
+{
+	int err;
+
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
+					      NULL, NULL);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+
+		if (err < 0)
+			return err;
+		*changed |= err;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+					     struct cfg80211_color_change_settings *params,
+					     u32 *changed)
+{
+	struct ieee80211_color_change_settings color_change = {};
+	int err;
+
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+		sdata->u.ap.next_beacon =
+			cfg80211_beacon_dup(&params->beacon_after);
+		if (!sdata->u.ap.next_beacon)
+			return -ENOMEM;
+
+		if (params->count <= 1)
+			break;
+
+		color_change.counter_offset_beacon = params->counter_offset_beacon;
+		color_change.counter_offset_presp = params->counter_offset_presp;
+		color_change.count = params->count;
+
+		err = ieee80211_assign_beacon(sdata, &params->beacon_color_change,
+					      NULL, &color_change);
+		if (err < 0) {
+			kfree(sdata->u.ap.next_beacon);
+			return err;
+		}
+		*changed |= err;
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	u32 changed = 0;
+	int err;
+
+	sdata_assert_lock(sdata);
+	lockdep_assert_held(&local->mtx);
+
+	sdata->vif.color_change_active = false;
+
+	err = ieee80211_set_after_color_change_beacon(sdata, &changed);
+	if (err) {
+		cfg80211_color_change_aborted_notify(sdata->dev);
+		return err;
+	}
+
+	sdata->vif.bss_conf.he_bss_color.color = sdata->vif.color_change_color;
+	sdata->vif.bss_conf.he_bss_color.enabled = 1;
+	changed |= BSS_CHANGED_HE_BSS_COLOR;
+
+	ieee80211_bss_info_change_notify(sdata, changed);
+
+	cfg80211_color_change_notify(sdata->dev);
+
+	return 0;
+}
+
+void ieee80211_color_change_finalize_work(struct work_struct *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     color_change_finalize_work);
+	struct ieee80211_local *local = sdata->local;
+
+	sdata_lock(sdata);
+	mutex_lock(&local->mtx);
+
+	/* AP might have been stopped while waiting for the lock. */
+	if (!sdata->vif.color_change_active)
+		goto unlock;
+
+	if (!ieee80211_sdata_running(sdata))
+		goto unlock;
+
+	ieee80211_color_change_finalize(sdata);
+
+unlock:
+	mutex_unlock(&local->mtx);
+	sdata_unlock(sdata);
+}
+
+void ieee80211_color_change_finish(struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	ieee80211_queue_work(&sdata->local->hw,
+			     &sdata->color_change_finalize_work);
+}
+EXPORT_SYMBOL_GPL(ieee80211_color_change_finish);
+
+void
+ieeee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
+				       u64 color_bitmap)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (sdata->vif.color_change_active || sdata->vif.csa_active)
+		return;
+
+	cfg80211_obss_color_collision_notify(sdata->dev, color_bitmap);
+}
+EXPORT_SYMBOL_GPL(ieeee80211_obss_color_collision_notify);
+
+static int
+__ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
+			 struct cfg80211_color_change_settings *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	u32 changed = 0;
+	int err;
+
+	sdata_assert_lock(sdata);
+	lockdep_assert_held(&local->mtx);
+
+	/* don't allow another color change if one is already active or if csa
+	 * is active
+	 */
+	if (sdata->vif.color_change_active || sdata->vif.csa_active)
+		return -EBUSY;
+
+	err = ieee80211_set_color_change_beacon(sdata, params, &changed);
+	if (err)
+		return err;
+
+	sdata->vif.color_change_active = true;
+	sdata->vif.color_change_color = params->color;
+
+	cfg80211_color_change_started_notify(sdata->dev, params->count);
+
+	if (changed) {
+		sdata->vif.bss_conf.he_bss_color.enabled = 0;
+		changed |= BSS_CHANGED_HE_BSS_COLOR;
+		ieee80211_bss_info_change_notify(sdata, changed);
+	} else {
+		/* if the beacon didn't change, we can finalize immediately */
+		ieee80211_color_change_finalize(sdata);
+	}
+
+	return 0;
+}
+
+static int ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
+				  struct cfg80211_color_change_settings *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	int err;
+
+	mutex_lock(&local->mtx);
+	err = __ieee80211_color_change(wiphy, dev, params);
+	mutex_unlock(&local->mtx);
+
+	return err;
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4096,4 +4305,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.probe_mesh_link = ieee80211_probe_mesh_link,
 	.set_tid_config = ieee80211_set_tid_config,
 	.reset_tid_config = ieee80211_reset_tid_config,
+	.color_change = ieee80211_color_change,
 };
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6bf879660a93..72841930316c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -255,6 +255,13 @@ struct ieee80211_csa_settings {
 	u8 count;
 };
 
+struct ieee80211_color_change_settings {
+	u16 counter_offset_beacon;
+	u16 counter_offset_presp;
+
+	u8 count;
+};
+
 struct beacon_data {
 	u8 *head, *tail;
 	int head_len, tail_len;
@@ -923,6 +930,8 @@ struct ieee80211_sub_if_data {
 	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
 	struct cfg80211_chan_def csa_chandef;
 
+	struct work_struct color_change_finalize_work;
+
 	struct list_head assigned_chanctx_list; /* protected by chanctx_mtx */
 	struct list_head reserved_chanctx_list; /* protected by chanctx_mtx */
 
@@ -1737,6 +1746,9 @@ void ieee80211_csa_finalize_work(struct work_struct *work);
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			     struct cfg80211_csa_settings *params);
 
+/* color change handling */
+void ieee80211_color_change_finalize_work(struct work_struct *work);
+
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 					 NETIF_F_HW_CSUM | NETIF_F_SG | \
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9740ae8fa697..6681795f63c8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -912,6 +912,8 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 				   GFP_KERNEL);
 	}
 
+	cancel_work_sync(&sdata->color_change_finalize_work);
+
 	/* APs need special treatment */
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
 		struct ieee80211_sub_if_data *vlan, *tmpsdata;
@@ -1496,6 +1498,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->csa_finalize_work, ieee80211_csa_finalize_work);
+	INIT_WORK(&sdata->color_change_finalize_work, ieee80211_color_change_finalize_work);
 	INIT_LIST_HEAD(&sdata->assigned_chanctx_list);
 	INIT_LIST_HEAD(&sdata->reserved_chanctx_list);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d2136007e2eb..481dd7cc36d3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4541,11 +4541,12 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 					struct beacon_data *beacon)
 {
+	u16 *bcn_offsets, *resp_offsets;
 	struct probe_resp *resp;
 	u8 *beacon_data;
 	size_t beacon_data_len;
 	int i;
-	u8 count = beacon->cntdwn_current_counter;
+	u8 count, max_count = 1;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
@@ -4565,21 +4566,25 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 	}
 
 	rcu_read_lock();
-	for (i = 0; i < IEEE80211_MAX_CNTDWN_COUNTERS_NUM; ++i) {
-		resp = rcu_dereference(sdata->u.ap.probe_resp);
+	resp = rcu_dereference(sdata->u.ap.probe_resp);
 
-		if (beacon->cntdwn_counter_offsets[i]) {
-			if (WARN_ON_ONCE(beacon->cntdwn_counter_offsets[i] >=
-					 beacon_data_len)) {
+	bcn_offsets = beacon->cntdwn_counter_offsets;
+	resp_offsets = resp->cntdwn_counter_offsets;
+	count = beacon->cntdwn_current_counter;
+	if (sdata->vif.csa_active)
+		max_count = IEEE80211_MAX_CNTDWN_COUNTERS_NUM;
+
+	for (i = 0; i < max_count; ++i) {
+		if (bcn_offsets[i]) {
+			if (WARN_ON_ONCE(bcn_offsets[i] >= beacon_data_len)) {
 				rcu_read_unlock();
 				return;
 			}
-
-			beacon_data[beacon->cntdwn_counter_offsets[i]] = count;
+			beacon_data[bcn_offsets[i]] = count;
 		}
 
 		if (sdata->vif.type == NL80211_IFTYPE_AP && resp)
-			resp->data[resp->cntdwn_counter_offsets[i]] = count;
+			resp->data[resp_offsets[i]] = count;
 	}
 	rcu_read_unlock();
 }
@@ -4789,6 +4794,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			if (offs) {
 				offs->tim_offset = beacon->head_len;
 				offs->tim_length = skb->len - beacon->head_len;
+				offs->cntdwn_counter_offs[0] = beacon->cntdwn_counter_offsets[0];
 
 				/* for AP the csa offsets are from tail */
 				csa_off_base = skb->len;
-- 
2.25.1

