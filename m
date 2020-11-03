Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19B52A3FE4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgKCJWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgKCJWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:22:48 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A67C0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:22:48 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsWb-0006Q9-V5; Tue, 03 Nov 2020 10:22:46 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V6 2/3] mac80211: add support for BSS color change
Date:   Tue,  3 Nov 2020 10:22:43 +0100
Message-Id: <20201103092244.1925158-3-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103092244.1925158-1-john@phrozen.org>
References: <20201103092244.1925158-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The color change announcement is very similar to how CSA works where
we have an IE that includes a counter. When the counter hits 0, the new
color is applied via an updated beacon.

This patch makes the CSA counter functionality reusable, rather than
implementing it again. This also allows for future reuse incase support
for other counter IEs gets added.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  28 +++++
 net/mac80211/cfg.c         | 250 +++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  12 ++
 net/mac80211/iface.c       |   3 +
 net/mac80211/tx.c          |  24 ++--
 5 files changed, 299 insertions(+), 18 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 051b7cae2516..078dd77f69d2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1718,6 +1718,10 @@ enum ieee80211_vif_multiple_bssid_flags {
  * @multiple_bssid.parent: a non-transmitted bssid has a transmitted parent.
  * @multiple_bssid.flags: multiple bssid flags, see
  *	&enum ieee80211_vif_multiple_bssid_flags
+ * @color_change_active: marks whether a color change is going on. Internally it is
+ *	write-protected by sdata_lock and local->mtx so holding either is fine
+ *	for read access.
+ * @color_change_color: the color that we will have after the change.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1750,6 +1754,9 @@ struct ieee80211_vif {
 		u32 flags;
 	} multiple_bssid;
 
+	bool color_change_active;
+	u8 color_change_color;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -5073,6 +5080,16 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif);
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
@@ -6805,4 +6822,15 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
 struct sk_buff *
 ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif);
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
index 457a956bb637..1ace5e20eb6a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -860,7 +860,8 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 
 static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 				    const u8 *resp, size_t resp_len,
-				    const struct ieee80211_csa_settings *csa)
+				    const struct ieee80211_csa_settings *csa,
+				    const struct ieee80211_color_change_settings *color_change)
 {
 	struct probe_resp *new, *old;
 
@@ -880,6 +881,8 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_presp,
 		       csa->n_counter_offsets_presp *
 		       sizeof(new->cntdwn_counter_offsets[0]));
+	if (color_change)
+		new->cntdwn_counter_offsets[0] = color_change->counter_offset_presp;
 
 	rcu_assign_pointer(sdata->u.ap.probe_resp, new);
 	if (old)
@@ -1010,7 +1013,8 @@ static u8 *ieee80211_copy_multiple_bssid_beacon(u8 *offset,
 
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
-				   const struct ieee80211_csa_settings *csa)
+				   const struct ieee80211_csa_settings *csa,
+				   const struct ieee80211_color_change_settings *color_change)
 {
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len, new_multiple_bssid_len;
@@ -1082,6 +1086,11 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1096,7 +1105,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			memcpy(new->tail, old->tail, new_tail_len);
 
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
-				       params->probe_resp_len, csa);
+				       params->probe_resp_len, csa, color_change);
 	if (err < 0) {
 		kfree(new);
 		return err;
@@ -1256,7 +1265,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
 		sdata->vif.bss_conf.beacon_tx_rate = params->beacon_rate;
 
-	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL);
+	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL, NULL);
 	if (err < 0)
 		goto error;
 	changed |= err;
@@ -1311,17 +1320,17 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
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
@@ -3225,7 +3234,7 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
-					      NULL);
+					      NULL, NULL);
 		kfree(sdata->u.ap.next_beacon);
 		sdata->u.ap.next_beacon = NULL;
 
@@ -3391,7 +3400,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.n_counter_offsets_presp = params->n_counter_offsets_presp;
 		csa.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa);
+		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa, NULL);
 		if (err < 0) {
 			kfree(sdata->u.ap.next_beacon);
 			return err;
@@ -3479,6 +3488,14 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -3550,6 +3567,10 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	/* if there is a color change in progress, abort it */
+	if (sdata->vif.color_change_active)
+		ieee80211_color_change_abort(sdata);
+
 	err = ieee80211_set_csa_beacon(sdata, params, &changed);
 	if (err) {
 		ieee80211_vif_unreserve_chanctx(sdata);
@@ -4190,6 +4211,216 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
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
+static void ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
+						     u8 color, int enable, u32 changed)
+{
+	sdata->vif.bss_conf.he_bss_color.color = color;
+	sdata->vif.bss_conf.he_bss_color.enabled = enable;
+	changed |= BSS_CHANGED_HE_BSS_COLOR;
+
+	ieee80211_bss_info_change_notify(sdata, changed);
+
+	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_MULTI_BSSID_AP) &&
+	    !sdata->vif.multiple_bssid.parent) {
+		struct ieee80211_sub_if_data *child;
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(child, &sdata->local->interfaces, list) {
+			if (child->vif.multiple_bssid.parent != &sdata->vif)
+				continue;
+			sdata_lock(child);
+			child->vif.bss_conf.he_bss_color.color = color;
+			child->vif.bss_conf.he_bss_color.enabled = enable;
+			ieee80211_bss_info_change_notify(child, BSS_CHANGED_HE_BSS_COLOR);
+			sdata_unlock(child);
+		}
+		rcu_read_unlock();
+	}
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
+	ieee80211_color_change_bss_config_notify(sdata, sdata->vif.color_change_color, 1, 0);
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
+	if (changed)
+		ieee80211_color_change_bss_config_notify(sdata, 0, 0, changed);
+	else
+		/* if the beacon didn't change, we can finalize immediately */
+		ieee80211_color_change_finalize(sdata);
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
+	if (sdata->vif.multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING)
+		return -EINVAL;
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
@@ -4293,4 +4524,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.probe_mesh_link = ieee80211_probe_mesh_link,
 	.set_tid_config = ieee80211_set_tid_config,
 	.reset_tid_config = ieee80211_reset_tid_config,
+	.color_change = ieee80211_color_change,
 };
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e510abc5ace2..2eb96a514dc6 100644
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
@@ -941,6 +948,8 @@ struct ieee80211_sub_if_data {
 	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
 	struct cfg80211_chan_def csa_chandef;
 
+	struct work_struct color_change_finalize_work;
+
 	struct list_head assigned_chanctx_list; /* protected by chanctx_mtx */
 	struct list_head reserved_chanctx_list; /* protected by chanctx_mtx */
 
@@ -1758,6 +1767,9 @@ void ieee80211_csa_finalize_work(struct work_struct *work);
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			     struct cfg80211_csa_settings *params);
 
+/* color change handling */
+void ieee80211_color_change_finalize_work(struct work_struct *work);
+
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 					 NETIF_F_HW_CSUM | NETIF_F_SG | \
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 63a0391d2b66..f0d317de5833 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -485,6 +485,8 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 				   GFP_KERNEL);
 	}
 
+	cancel_work_sync(&sdata->color_change_finalize_work);
+
 	/* APs need special treatment */
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
 		struct ieee80211_sub_if_data *vlan, *tmpsdata;
@@ -1539,6 +1541,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->csa_finalize_work, ieee80211_csa_finalize_work);
+	INIT_WORK(&sdata->color_change_finalize_work, ieee80211_color_change_finalize_work);
 	INIT_LIST_HEAD(&sdata->assigned_chanctx_list);
 	INIT_LIST_HEAD(&sdata->reserved_chanctx_list);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ca0d49af9a0f..1f69fe4c4356 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4546,11 +4546,12 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
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
@@ -4570,21 +4571,25 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
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
@@ -4830,6 +4835,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			if (offs) {
 				offs->tim_offset = beacon->head_len;
 				offs->tim_length = skb->len - beacon->head_len;
+				offs->cntdwn_counter_offs[0] = beacon->cntdwn_counter_offsets[0];
 
 				/* for AP the csa offsets are from tail */
 				csa_off_base = skb->len;
-- 
2.25.1

