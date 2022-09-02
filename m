Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A715AB43F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiIBOwA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiIBOvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB8CEB02
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ab6ydZX56sh4OhPLFsOZuomQ8ZF/RQ4XGWJ8U9u7lHY=;
        t=1662127996; x=1663337596; b=kRvZsJ2Arb1UEl1IWT2ZkgeMlww1lnfj7APjphgpQaITpAu
        uxEyKnP40U2kbtJ7xhz6CpHJh9AmeaIL89mRvoSfPjh3VVB/YwCLm/TDJ500wkwmwcGpBwSxX6mjI
        9YObNtfXOgGo8l8Zfwrz27OB4xnh99Ktmw3ZP6Dvfj1ZTx7nf2ruFx6XhAq5yV08eSYY/9l1QL9kC
        ZUYlBk1uEJX9zhjKXBQrHNdlQaapCPtz6Sptr2V01m7P7hClgQt9mqfdW8g3mZ3r6OPYwLEYJg80O
        mZ0thQU2ewRgpUDuXtbdRYC9KjEImfatZeorYy1zexWBtU9jvmL3hsHCOKOBnG8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Q2-006Ch3-0e;
        Fri, 02 Sep 2022 16:13:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 24/27] wifi: mac80211: implement link switching
Date:   Fri,  2 Sep 2022 16:12:56 +0200
Message-Id: <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Implement an API function and debugfs file to switch
active links.

Also provide an async version of the API so drivers
can call it in arbitrary contexts, e.g. while in the
authorized callback.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h        |  41 ++++++++
 net/mac80211/debugfs_netdev.c |  26 ++++++
 net/mac80211/ieee80211_i.h    |   4 +
 net/mac80211/iface.c          |  12 +++
 net/mac80211/key.c            |  34 +++++++
 net/mac80211/key.h            |   3 +
 net/mac80211/link.c           | 171 ++++++++++++++++++++++++++++++++++
 7 files changed, 291 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 873e81a45a97..ac2bad57933f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7184,4 +7184,45 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
 	       ieee80211_is_data(hdr->frame_control);
 }
 
+/**
+ * ieee80211_set_active_links - set active links in client mode
+ * @vif: interface to set active links on
+ * @active_links: the new active links bitmap
+ *
+ * This changes the active links on an interface. The interface
+ * must be in client mode (in AP mode, all links are always active),
+ * and @active_links must be a subset of the vif's valid_links.
+ *
+ * If a link is switched off and another is switched on at the same
+ * time (e.g. active_links going from 0x1 to 0x10) then you will get
+ * a sequence of calls like
+ *  - change_vif_links(0x11)
+ *  - unassign_vif_chanctx(link_id=0)
+ *  - change_sta_links(0x11) for each affected STA (the AP)
+ *    (TDLS connections on now inactive links should be torn down)
+ *  - remove group keys on the old link (link_id 0)
+ *  - add new group keys (GTK/IGTK/BIGTK) on the new link (link_id 4)
+ *  - change_sta_links(0x10) for each affected STA (the AP)
+ *  - assign_vif_chanctx(link_id=4)
+ *  - change_vif_links(0x10)
+ *
+ * Note: This function acquires some mac80211 locks and must not
+ *	 be called with any driver locks held that could cause a
+ *	 lock dependency inversion. Best call it without locks.
+ */
+int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
+
+/**
+ * ieee80211_set_active_links_async - asynchronously set active links
+ * @vif: interface to set active links on
+ * @active_links: the new active links bitmap
+ *
+ * See ieee80211_set_active_links() for more information, the only
+ * difference here is that the link change is triggered async and
+ * can be called in any context, but the link switch will only be
+ * completed after it returns.
+ */
+void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
+				      u16 active_links);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 1e5b041a5cea..5b014786fd2d 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -570,6 +570,30 @@ static ssize_t ieee80211_if_parse_tsf(
 }
 IEEE80211_IF_FILE_RW(tsf);
 
+static ssize_t ieee80211_if_fmt_valid_links(const struct ieee80211_sub_if_data *sdata,
+					    char *buf, int buflen)
+{
+	return snprintf(buf, buflen, "0x%x\n", sdata->vif.valid_links);
+}
+IEEE80211_IF_FILE_R(valid_links);
+
+static ssize_t ieee80211_if_fmt_active_links(const struct ieee80211_sub_if_data *sdata,
+					     char *buf, int buflen)
+{
+	return snprintf(buf, buflen, "0x%x\n", sdata->vif.active_links);
+}
+
+static ssize_t ieee80211_if_parse_active_links(struct ieee80211_sub_if_data *sdata,
+					       const char *buf, int buflen)
+{
+	u16 active_links;
+
+	if (kstrtou16(buf, 0, &active_links))
+		return -EINVAL;
+
+	return ieee80211_set_active_links(&sdata->vif, active_links) ?: buflen;
+}
+IEEE80211_IF_FILE_RW(active_links);
 
 #ifdef CONFIG_MAC80211_MESH
 IEEE80211_IF_FILE(estab_plinks, u.mesh.estab_plinks, ATOMIC);
@@ -670,6 +694,8 @@ static void add_sta_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD_MODE(uapsd_queues, 0600);
 	DEBUGFS_ADD_MODE(uapsd_max_sp_len, 0600);
 	DEBUGFS_ADD_MODE(tdls_wider_bw, 0600);
+	DEBUGFS_ADD_MODE(valid_links, 0200);
+	DEBUGFS_ADD_MODE(active_links, 0600);
 }
 
 static void add_ap_files(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 977aea4467e0..4e1d4c339f2d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1081,6 +1081,10 @@ struct ieee80211_sub_if_data {
 	struct ieee80211_link_data deflink;
 	struct ieee80211_link_data __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
+	/* for ieee80211_set_active_links_async() */
+	struct work_struct activate_links_work;
+	u16 desired_active_links;
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
 		struct dentry *subdir_stations;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index bf1c44d53c30..30c62b63d179 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -683,6 +683,8 @@ static int ieee80211_stop(struct net_device *dev)
 		ieee80211_stop_mbssid(sdata);
 	}
 
+	cancel_work_sync(&sdata->activate_links_work);
+
 	wiphy_lock(sdata->local->hw.wiphy);
 	ieee80211_do_stop(sdata, true);
 	wiphy_unlock(sdata->local->hw.wiphy);
@@ -1653,6 +1655,15 @@ static void ieee80211_recalc_smps_work(struct work_struct *work)
 	ieee80211_recalc_smps(sdata, &sdata->deflink);
 }
 
+static void ieee80211_activate_links_work(struct work_struct *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     activate_links_work);
+
+	ieee80211_set_active_links(&sdata->vif, sdata->desired_active_links);
+}
+
 /*
  * Helper function to initialise an interface to a specific type.
  */
@@ -1690,6 +1701,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	skb_queue_head_init(&sdata->status_queue);
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
+	INIT_WORK(&sdata->activate_links_work, ieee80211_activate_links_work);
 
 	switch (type) {
 	case NL80211_IFTYPE_P2P_GO:
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index f6f0f65fb255..e8f6c1e5eabf 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -1445,3 +1445,37 @@ void ieee80211_key_replay(struct ieee80211_key_conf *keyconf)
 	}
 }
 EXPORT_SYMBOL_GPL(ieee80211_key_replay);
+
+int ieee80211_key_switch_links(struct ieee80211_sub_if_data *sdata,
+			       unsigned long del_links_mask,
+			       unsigned long add_links_mask)
+{
+	struct ieee80211_key *key;
+	int ret;
+
+	list_for_each_entry(key, &sdata->key_list, list) {
+		if (key->conf.link_id < 0 ||
+		    !(del_links_mask & BIT(key->conf.link_id)))
+			continue;
+
+		/* shouldn't happen for per-link keys */
+		WARN_ON(key->sta);
+
+		ieee80211_key_disable_hw_accel(key);
+	}
+
+	list_for_each_entry(key, &sdata->key_list, list) {
+		if (key->conf.link_id < 0 ||
+		    !(add_links_mask & BIT(key->conf.link_id)))
+			continue;
+
+		/* shouldn't happen for per-link keys */
+		WARN_ON(key->sta);
+
+		ret = ieee80211_key_enable_hw_accel(key);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index 518af24aab56..f3df97df4b72 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -165,6 +165,9 @@ void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 void ieee80211_free_sta_keys(struct ieee80211_local *local,
 			     struct sta_info *sta);
 void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata);
+int ieee80211_key_switch_links(struct ieee80211_sub_if_data *sdata,
+			       unsigned long del_links_mask,
+			       unsigned long add_links_mask);
 
 #define key_mtx_dereference(local, ref) \
 	rcu_dereference_protected(ref, lockdep_is_held(&((local)->key_mtx)))
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 8df348a5edce..e309708abae8 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -9,6 +9,7 @@
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
 #include "driver-ops.h"
+#include "key.h"
 
 void ieee80211_link_setup(struct ieee80211_link_data *link)
 {
@@ -300,3 +301,173 @@ void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_free_links(sdata, links);
 }
+
+static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
+				       u16 active_links)
+{
+	struct ieee80211_bss_conf *link_confs[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_local *local = sdata->local;
+	u16 old_active = sdata->vif.active_links;
+	unsigned long rem = old_active & ~active_links;
+	unsigned long add = active_links & ~old_active;
+	struct sta_info *sta;
+	unsigned int link_id;
+	int ret, i;
+
+	if (!ieee80211_sdata_running(sdata))
+		return -ENETDOWN;
+
+	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+		return -EINVAL;
+
+	/* cannot activate links that don't exist */
+	if (active_links & ~sdata->vif.valid_links)
+		return -EINVAL;
+
+	/* nothing to do */
+	if (old_active == active_links)
+		return 0;
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
+		link_confs[i] = sdata_dereference(sdata->vif.link_conf[i],
+						  sdata);
+
+	if (add) {
+		sdata->vif.active_links |= active_links;
+		ret = drv_change_vif_links(local, sdata,
+					   old_active,
+					   sdata->vif.active_links,
+					   link_confs);
+		if (ret) {
+			sdata->vif.active_links = old_active;
+			return ret;
+		}
+	}
+
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		/* FIXME: kill TDLS connections on the link */
+
+		ieee80211_link_release_channel(link);
+	}
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		if (sdata != sta->sdata)
+			continue;
+		ret = drv_change_sta_links(local, sdata, &sta->sta,
+					   old_active,
+					   old_active | active_links);
+		WARN_ON_ONCE(ret);
+	}
+
+	ret = ieee80211_key_switch_links(sdata, rem, add);
+	WARN_ON_ONCE(ret);
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		if (sdata != sta->sdata)
+			continue;
+		ret = drv_change_sta_links(local, sdata, &sta->sta,
+					   old_active | active_links,
+					   active_links);
+		WARN_ON_ONCE(ret);
+	}
+
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		ret = ieee80211_link_use_channel(link, &link->conf->chandef,
+						 IEEE80211_CHANCTX_SHARED);
+		WARN_ON_ONCE(ret);
+
+		ieee80211_link_info_change_notify(sdata, link,
+						  BSS_CHANGED_ERP_CTS_PROT |
+						  BSS_CHANGED_ERP_PREAMBLE |
+						  BSS_CHANGED_ERP_SLOT |
+						  BSS_CHANGED_HT |
+						  BSS_CHANGED_BASIC_RATES |
+						  BSS_CHANGED_BSSID |
+						  BSS_CHANGED_CQM |
+						  BSS_CHANGED_QOS |
+						  BSS_CHANGED_TXPOWER |
+						  BSS_CHANGED_BANDWIDTH |
+						  BSS_CHANGED_TWT |
+						  BSS_CHANGED_HE_OBSS_PD |
+						  BSS_CHANGED_HE_BSS_COLOR);
+		ieee80211_mgd_set_link_qos_params(link);
+	}
+
+	old_active = sdata->vif.active_links;
+	sdata->vif.active_links = active_links;
+
+	if (rem) {
+		ret = drv_change_vif_links(local, sdata, old_active,
+					   active_links, link_confs);
+		WARN_ON_ONCE(ret);
+	}
+
+	return 0;
+}
+
+int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_local *local = sdata->local;
+	u16 old_active;
+	int ret;
+
+	sdata_lock(sdata);
+	mutex_lock(&local->sta_mtx);
+	mutex_lock(&local->mtx);
+	mutex_lock(&local->key_mtx);
+	old_active = sdata->vif.active_links;
+	if (old_active & active_links) {
+		/*
+		 * if there's at least one link that stays active across
+		 * the change then switch to it (to those) first, and
+		 * then enable the additional links
+		 */
+		ret = _ieee80211_set_active_links(sdata,
+						  old_active & active_links);
+		if (!ret)
+			ret = _ieee80211_set_active_links(sdata, active_links);
+	} else {
+		/* otherwise switch directly */
+		ret = _ieee80211_set_active_links(sdata, active_links);
+	}
+	mutex_unlock(&local->key_mtx);
+	mutex_unlock(&local->mtx);
+	mutex_unlock(&local->sta_mtx);
+	sdata_unlock(sdata);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ieee80211_set_active_links);
+
+void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
+				      u16 active_links)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (!ieee80211_sdata_running(sdata))
+		return;
+
+	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+		return;
+
+	/* cannot activate links that don't exist */
+	if (active_links & ~sdata->vif.valid_links)
+		return;
+
+	/* nothing to do */
+	if (sdata->vif.active_links == active_links)
+		return;
+
+	sdata->desired_active_links = active_links;
+	schedule_work(&sdata->activate_links_work);
+}
+EXPORT_SYMBOL_GPL(ieee80211_set_active_links_async);
-- 
2.37.2

