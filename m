Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5857E3B4DD7
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Jun 2021 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFZJlj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Jun 2021 05:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhFZJli (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Jun 2021 05:41:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A773661923;
        Sat, 26 Jun 2021 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624700356;
        bh=o0BRc5ij1owNZEfDyrmAzJV0G4+pnLxwP5Ar7Ad8kaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyM3jKQ8FeZuBJQH6KTg+rNaAbEV7bgsGgOmoJo7PMgUpchEtQEOZqXRAaXlfqbSY
         oC73gyQerU4pCpmhnOCADvkB9+rGUsBsPWB3Jdkjb1x3276gQKe0Pt3L3Qat2k5hia
         TmzFa6+RFxy3ank+YH8Sy59r5JpUpJCm1g3tYdfwpjuLnvqlSVdLq1e+bc26Hv/Jpm
         BrB+4SznjAKpwOGRufHsqUJgAYQNXIwBVn6b+NGIqoKLo824iGldt/+cYc8ckvFbSi
         LbO0d5yYqFk4OtJYkKy63LpRgf9V/FSp62VDEJ/UTZjF5JFh+IjgYGEZdP01WHQ9Wp
         +RIPrFjOeh5Hw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, john@phrozen.org,
        ryder.lee@mediatek.com
Subject: [PATCH v7 mac80211-next 2/2] mac80211: add support for BSS color change
Date:   Sat, 26 Jun 2021 11:39:00 +0200
Message-Id: <4a37ffe2210e524140e414a67269f9928b5be425.1624699891.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624699891.git.lorenzo@kernel.org>
References: <cover.1624699891.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

The color change announcement is very similar to how CSA works where
we have an IE that includes a counter. When the counter hits 0, the new
color is applied via an updated beacon.

This patch makes the CSA counter functionality reusable, rather than
implementing it again. This also allows for future reuse incase support
for other counter IEs gets added.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  29 +++++
 net/mac80211/cfg.c         | 234 +++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  11 ++
 net/mac80211/iface.c       |   2 +
 net/mac80211/tx.c          |  25 ++--
 5 files changed, 280 insertions(+), 21 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d8a1d09a2141..a23e6734d26b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1711,6 +1711,10 @@ enum ieee80211_offload_flags {
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
+ * @color_change_active: marks whether a color change is ongoing. Internally it is
+ *	write-protected by sdata_lock and local->mtx so holding either is fine
+ *	for read access.
+ * @color_change_color: the bss color that will be used after the change.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1739,6 +1743,9 @@ struct ieee80211_vif {
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
+	bool color_change_active;
+	u8 color_change_color;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -5007,6 +5014,16 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif);
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
@@ -6771,6 +6788,18 @@ struct sk_buff *
 ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif);
 
+/**
+ * ieeee80211_obss_color_collision_notify - notify userland about a BSS color
+ * collision.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @color_bitmap: a 64 bit bitmap representing the colors that the local BSS is
+ *	aware of.
+ */
+void
+ieeee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
+				       u64 color_bitmap);
+
 /**
  * ieee80211_is_tx_data - check if frame is a data frame
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 84cc7733ea66..1c6a08c661c2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -809,9 +809,11 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 	return ret;
 }
 
-static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
-				    const u8 *resp, size_t resp_len,
-				    const struct ieee80211_csa_settings *csa)
+static int
+ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
+			 const u8 *resp, size_t resp_len,
+			 const struct ieee80211_csa_settings *csa,
+			 const struct ieee80211_color_change_settings *cca)
 {
 	struct probe_resp *new, *old;
 
@@ -831,6 +833,8 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_presp,
 		       csa->n_counter_offsets_presp *
 		       sizeof(new->cntdwn_counter_offsets[0]));
+	else if (cca)
+		new->cntdwn_counter_offsets[0] = cca->counter_offset_presp;
 
 	rcu_assign_pointer(sdata->u.ap.probe_resp, new);
 	if (old)
@@ -936,7 +940,8 @@ static int ieee80211_set_ftm_responder_params(
 
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
-				   const struct ieee80211_csa_settings *csa)
+				   const struct ieee80211_csa_settings *csa,
+				   const struct ieee80211_color_change_settings *cca)
 {
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
@@ -985,6 +990,9 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
 		       csa->n_counter_offsets_beacon *
 		       sizeof(new->cntdwn_counter_offsets[0]));
+	} else if (cca) {
+		new->cntdwn_current_counter = cca->count;
+		new->cntdwn_counter_offsets[0] = cca->counter_offset_beacon;
 	}
 
 	/* copy in head */
@@ -1001,7 +1009,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			memcpy(new->tail, old->tail, new_tail_len);
 
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
-				       params->probe_resp_len, csa);
+				       params->probe_resp_len, csa, cca);
 	if (err < 0) {
 		kfree(new);
 		return err;
@@ -1156,7 +1164,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
 		sdata->vif.bss_conf.beacon_tx_rate = params->beacon_rate;
 
-	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL);
+	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL, NULL);
 	if (err < 0)
 		goto error;
 	changed |= err;
@@ -1211,17 +1219,17 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
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
@@ -3137,7 +3145,7 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
-					      NULL);
+					      NULL, NULL);
 		kfree(sdata->u.ap.next_beacon);
 		sdata->u.ap.next_beacon = NULL;
 
@@ -3303,7 +3311,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.n_counter_offsets_presp = params->n_counter_offsets_presp;
 		csa.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa);
+		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa, NULL);
 		if (err < 0) {
 			kfree(sdata->u.ap.next_beacon);
 			return err;
@@ -3392,6 +3400,15 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
+{
+	sdata->vif.color_change_active = false;
+	kfree(sdata->u.ap.next_beacon);
+	sdata->u.ap.next_beacon = NULL;
+
+	cfg80211_color_change_aborted_notify(sdata->dev);
+}
+
 static int
 __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			   struct cfg80211_csa_settings *params)
@@ -3460,6 +3477,10 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	/* if there is a color change in progress, abort it */
+	if (sdata->vif.color_change_active)
+		ieee80211_color_change_abort(sdata);
+
 	err = ieee80211_set_csa_beacon(sdata, params, &changed);
 	if (err) {
 		ieee80211_vif_unreserve_chanctx(sdata);
@@ -4111,6 +4132,196 @@ static int ieee80211_set_sar_specs(struct wiphy *wiphy,
 	return local->ops->set_sar_specs(&local->hw, sar);
 }
 
+static int
+ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+					u32 *changed)
+{
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP: {
+		int ret;
+
+		ret = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
+					      NULL, NULL);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+
+		if (ret < 0)
+			return ret;
+
+		*changed |= ret;
+		break;
+	}
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_color_change_settings *params,
+				  u32 *changed)
+{
+	struct ieee80211_color_change_settings color_change = {};
+	int err;
+
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+		sdata->u.ap.next_beacon =
+			cfg80211_beacon_dup(&params->beacon_next);
+		if (!sdata->u.ap.next_beacon)
+			return -ENOMEM;
+
+		if (params->count <= 1)
+			break;
+
+		color_change.counter_offset_beacon =
+			params->counter_offset_beacon;
+		color_change.counter_offset_presp =
+			params->counter_offset_presp;
+		color_change.count = params->count;
+
+		err = ieee80211_assign_beacon(sdata, &params->beacon_color_change,
+					      NULL, &color_change);
+		if (err < 0) {
+			kfree(sdata->u.ap.next_beacon);
+			return err;
+		}
+		*changed |= err;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void
+ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
+					 u8 color, int enable, u32 changed)
+{
+	sdata->vif.bss_conf.he_bss_color.color = color;
+	sdata->vif.bss_conf.he_bss_color.enabled = enable;
+	changed |= BSS_CHANGED_HE_BSS_COLOR;
+
+	ieee80211_bss_info_change_notify(sdata, changed);
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
+	ieee80211_color_change_bss_config_notify(sdata,
+						 sdata->vif.color_change_color,
+						 1, 0);
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
+ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
+		       struct cfg80211_color_change_settings *params)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	u32 changed = 0;
+	int err;
+
+	sdata_assert_lock(sdata);
+
+	mutex_lock(&local->mtx);
+
+	/* don't allow another color change if one is already active or if csa
+	 * is active
+	 */
+	if (sdata->vif.color_change_active || sdata->vif.csa_active) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	err = ieee80211_set_color_change_beacon(sdata, params, &changed);
+	if (err)
+		goto out;
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
+out:
+	mutex_unlock(&local->mtx);
+
+	return err;
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4214,4 +4425,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_tid_config = ieee80211_set_tid_config,
 	.reset_tid_config = ieee80211_reset_tid_config,
 	.set_sar_specs = ieee80211_set_sar_specs,
+	.color_change = ieee80211_color_change,
 };
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 22549b95d1aa..497ab66fa523 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -244,6 +244,12 @@ struct ieee80211_csa_settings {
 	u8 count;
 };
 
+struct ieee80211_color_change_settings {
+	u16 counter_offset_beacon;
+	u16 counter_offset_presp;
+	u8 count;
+};
+
 struct beacon_data {
 	u8 *head, *tail;
 	int head_len, tail_len;
@@ -923,6 +929,8 @@ struct ieee80211_sub_if_data {
 	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
 	struct cfg80211_chan_def csa_chandef;
 
+	struct work_struct color_change_finalize_work;
+
 	struct list_head assigned_chanctx_list; /* protected by chanctx_mtx */
 	struct list_head reserved_chanctx_list; /* protected by chanctx_mtx */
 
@@ -1887,6 +1895,9 @@ void ieee80211_csa_finalize_work(struct work_struct *work);
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			     struct cfg80211_csa_settings *params);
 
+/* color change handling */
+void ieee80211_color_change_finalize_work(struct work_struct *work);
+
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 					 NETIF_F_HW_CSUM | NETIF_F_SG | \
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1e5e9fc45523..601fc3dc5489 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -462,6 +462,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	sdata_unlock(sdata);
 
 	cancel_work_sync(&sdata->csa_finalize_work);
+	cancel_work_sync(&sdata->color_change_finalize_work);
 
 	cancel_delayed_work_sync(&sdata->dfs_cac_timer_work);
 
@@ -1531,6 +1532,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->csa_finalize_work, ieee80211_csa_finalize_work);
+	INIT_WORK(&sdata->color_change_finalize_work, ieee80211_color_change_finalize_work);
 	INIT_LIST_HEAD(&sdata->assigned_chanctx_list);
 	INIT_LIST_HEAD(&sdata->reserved_chanctx_list);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e96981144358..3660dd32d8df 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4775,11 +4775,11 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 					struct beacon_data *beacon)
 {
+	u8 *beacon_data, count, max_count = 1;
+	u16 *bcn_offsets, *resp_offsets;
 	struct probe_resp *resp;
-	u8 *beacon_data;
 	size_t beacon_data_len;
 	int i;
-	u8 count = beacon->cntdwn_current_counter;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
@@ -4799,21 +4799,25 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 	}
 
 	rcu_read_lock();
-	for (i = 0; i < IEEE80211_MAX_CNTDWN_COUNTERS_NUM; ++i) {
-		resp = rcu_dereference(sdata->u.ap.probe_resp);
+	resp = rcu_dereference(sdata->u.ap.probe_resp);
+
+	bcn_offsets = beacon->cntdwn_counter_offsets;
+	resp_offsets = resp->cntdwn_counter_offsets;
+	count = beacon->cntdwn_current_counter;
+	if (sdata->vif.csa_active)
+		max_count = IEEE80211_MAX_CNTDWN_COUNTERS_NUM;
 
-		if (beacon->cntdwn_counter_offsets[i]) {
-			if (WARN_ON_ONCE(beacon->cntdwn_counter_offsets[i] >=
-					 beacon_data_len)) {
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
@@ -5023,6 +5027,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			if (offs) {
 				offs->tim_offset = beacon->head_len;
 				offs->tim_length = skb->len - beacon->head_len;
+				offs->cntdwn_counter_offs[0] = beacon->cntdwn_counter_offsets[0];
 
 				/* for AP the csa offsets are from tail */
 				csa_off_base = skb->len;
-- 
2.31.1

