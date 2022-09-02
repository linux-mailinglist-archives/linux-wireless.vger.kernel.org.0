Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7925AB429
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiIBOvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiIBOvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3388F97B0F
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=EtcSuSlFXctWvEdBGTgGYEuYv7obrJLJtpO1MuWngXY=;
        t=1662127990; x=1663337590; b=hl73XCIuBdKLRTGbPUT9IKi/cwGmswGm4FVFxPaCHzP2kuu
        3hqU4/K0uX5S/CxpKRuJQCt+aHzxy0/+BKBIyyTyxAasrGdFoNmc0fr24qP84howtMz9hjHE3VvCZ
        /YrPtWEi+PTgVsrvWn9XBe9sdt7Js4L7EmM/NsMsH/f1POtUkhZI6E7qPLJOlLJAk8niOAoW4ypkF
        Wn606wuEYpku/+/GXs1U8N6I1lDioJ96Lqilw8ggqsFZw8qb/5OoVGAwSXB9Op5kB7gC048mKHg5L
        AszAj0AvdQHuSXFsWPzkOrAn8mKKt273BksTA0VoXNipEF6M6XVvFaJrMfENm4Xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pv-006Ch3-2t;
        Fri, 02 Sep 2022 16:13:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Date:   Fri,  2 Sep 2022 16:12:42 +0200
Message-Id: <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
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

In order to let the driver select active links and properly
make multi-link connections, as a first step isolate the
driver from inactive links, and set the active links to be
only the association link for client-side interfaces. For
AP side nothing changes since APs always have to have all
their links active.

To simplify things, update the for_each_sta_active_link()
API to include the appropriate vif pointer.

This also implies not allocating a chanctx for an inactive
link, which requires a few more changes.

Since we now no longer try to program multiple links to the
driver, remove the check in the MLME code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h    |  30 +++----
 net/mac80211/chan.c       |   6 ++
 net/mac80211/driver-ops.c | 172 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/driver-ops.h | 165 ++++++------------------------------
 net/mac80211/key.c        |   8 ++
 net/mac80211/link.c       |  66 ++++++++++++---
 net/mac80211/mlme.c       |  25 ++----
 net/mac80211/util.c       |   2 +-
 8 files changed, 286 insertions(+), 188 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d4e1d73d88cc..20a2f25a38fa 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1799,6 +1799,9 @@ struct ieee80211_vif_cfg {
  * @link_conf: in case of MLD, the per-link BSS configuration,
  *	indexed by link ID
  * @valid_links: bitmap of valid links, or 0 for non-MLO.
+ * @active_links: The bitmap of active links, or 0 for non-MLO.
+ *	The driver shouldn't change this directly, but use the
+ *	API calls meant for that purpose.
  * @addr: address of this interface
  * @p2p: indicates whether this AP or STA interface is a p2p
  *	interface, i.e. a GO or p2p-sta respectively
@@ -1834,7 +1837,7 @@ struct ieee80211_vif {
 	struct ieee80211_vif_cfg cfg;
 	struct ieee80211_bss_conf bss_conf;
 	struct ieee80211_bss_conf __rcu *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
-	u16 valid_links;
+	u16 valid_links, active_links;
 	u8 addr[ETH_ALEN] __aligned(2);
 	bool p2p;
 
@@ -1861,12 +1864,11 @@ struct ieee80211_vif {
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
-/* FIXME: for now loop over all the available links; later will be changed
- * to loop only over the active links.
- */
-#define for_each_vif_active_link(vif, link, link_id)			     \
-	for (link_id = 0; link_id < ARRAY_SIZE((vif)->link_conf); link_id++) \
-		if ((link = rcu_dereference((vif)->link_conf[link_id])))
+#define for_each_vif_active_link(vif, link, link_id)				\
+	for (link_id = 0; link_id < ARRAY_SIZE((vif)->link_conf); link_id++)	\
+		if ((!(vif)->active_links ||					\
+		     (vif)->active_links & BIT(link_id)) &&			\
+		    (link = rcu_dereference((vif)->link_conf[link_id])))
 
 static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
 {
@@ -2264,13 +2266,13 @@ struct ieee80211_sta {
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
-/* FIXME: need to loop only over links which are active and check the actual
- * lock
- */
-#define for_each_sta_active_link(sta, link_sta, link_id)		         \
-	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++)	         \
-		if (((link_sta) = rcu_dereference_protected((sta)->link[link_id],\
-							    1)))	         \
+/* FIXME: check the locking correctly */
+#define for_each_sta_active_link(vif, sta, link_sta, link_id)			\
+	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++)		\
+		if ((!(vif)->active_links ||					\
+		     (vif)->active_links & BIT(link_id)) &&			\
+		    ((link_sta) = rcu_dereference_protected((sta)->link[link_id],\
+							    1)))
 
 /**
  * enum sta_notify_cmd - sta notify command
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index f247daa41563..e72cf0749d49 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1799,6 +1799,12 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	lockdep_assert_held(&local->mtx);
 
+	if (sdata->vif.active_links &&
+	    !(sdata->vif.active_links & BIT(link->link_id))) {
+		ieee80211_link_update_chandef(link, chandef);
+		return 0;
+	}
+
 	mutex_lock(&local->chanctx_mtx);
 
 	ret = cfg80211_chandef_dfs_required(local->hw.wiphy,
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 9b61dc7889c2..5392ffa18270 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -192,6 +192,10 @@ int drv_conf_tx(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
+	if (sdata->vif.active_links &&
+	    !(sdata->vif.active_links & BIT(link->link_id)))
+		return 0;
+
 	if (params->cw_min == 0 || params->cw_min > params->cw_max) {
 		/*
 		 * If we can't configure hardware anyway, don't warn. We may
@@ -272,6 +276,60 @@ void drv_reset_tsf(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+int drv_assign_vif_chanctx(struct ieee80211_local *local,
+			   struct ieee80211_sub_if_data *sdata,
+			   struct ieee80211_bss_conf *link_conf,
+			   struct ieee80211_chanctx *ctx)
+{
+	int ret = 0;
+
+	drv_verify_link_exists(sdata, link_conf);
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	if (sdata->vif.active_links &&
+	    !(sdata->vif.active_links & BIT(link_conf->link_id)))
+		return 0;
+
+	trace_drv_assign_vif_chanctx(local, sdata, link_conf, ctx);
+	if (local->ops->assign_vif_chanctx) {
+		WARN_ON_ONCE(!ctx->driver_present);
+		ret = local->ops->assign_vif_chanctx(&local->hw,
+						     &sdata->vif,
+						     link_conf,
+						     &ctx->conf);
+	}
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
+void drv_unassign_vif_chanctx(struct ieee80211_local *local,
+			      struct ieee80211_sub_if_data *sdata,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct ieee80211_chanctx *ctx)
+{
+	might_sleep();
+
+	drv_verify_link_exists(sdata, link_conf);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	if (sdata->vif.active_links &&
+	    !(sdata->vif.active_links & BIT(link_conf->link_id)))
+		return;
+
+	trace_drv_unassign_vif_chanctx(local, sdata, link_conf, ctx);
+	if (local->ops->unassign_vif_chanctx) {
+		WARN_ON_ONCE(!ctx->driver_present);
+		local->ops->unassign_vif_chanctx(&local->hw,
+						 &sdata->vif,
+						 link_conf,
+						 &ctx->conf);
+	}
+	trace_drv_return_void(local);
+}
+
 int drv_switch_vif_chanctx(struct ieee80211_local *local,
 			   struct ieee80211_vif_chanctx_switch *vifs,
 			   int n_vifs, enum ieee80211_chanctx_switch_mode mode)
@@ -346,3 +404,117 @@ int drv_ampdu_action(struct ieee80211_local *local,
 
 	return ret;
 }
+
+void drv_link_info_changed(struct ieee80211_local *local,
+			   struct ieee80211_sub_if_data *sdata,
+			   struct ieee80211_bss_conf *info,
+			   int link_id, u64 changed)
+{
+	might_sleep();
+
+	if (WARN_ON_ONCE(changed & (BSS_CHANGED_BEACON |
+				    BSS_CHANGED_BEACON_ENABLED) &&
+			 sdata->vif.type != NL80211_IFTYPE_AP &&
+			 sdata->vif.type != NL80211_IFTYPE_ADHOC &&
+			 sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
+			 sdata->vif.type != NL80211_IFTYPE_OCB))
+		return;
+
+	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
+			 sdata->vif.type == NL80211_IFTYPE_NAN ||
+			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+			  !sdata->vif.bss_conf.mu_mimo_owner &&
+			  !(changed & BSS_CHANGED_TXPOWER))))
+		return;
+
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	if (sdata->vif.active_links &&
+	    !(sdata->vif.active_links & BIT(link_id)))
+		return;
+
+	trace_drv_link_info_changed(local, sdata, info, changed);
+	if (local->ops->link_info_changed)
+		local->ops->link_info_changed(&local->hw, &sdata->vif,
+					      info, changed);
+	else if (local->ops->bss_info_changed)
+		local->ops->bss_info_changed(&local->hw, &sdata->vif,
+					     info, changed);
+	trace_drv_return_void(local);
+}
+
+int drv_set_key(struct ieee80211_local *local,
+		enum set_key_cmd cmd,
+		struct ieee80211_sub_if_data *sdata,
+		struct ieee80211_sta *sta,
+		struct ieee80211_key_conf *key)
+{
+	int ret;
+
+	might_sleep();
+
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	if (WARN_ON(key->link_id >= 0 && sdata->vif.active_links &&
+		    !(sdata->vif.active_links & BIT(key->link_id))))
+		return -ENOLINK;
+
+	trace_drv_set_key(local, cmd, sdata, sta, key);
+	ret = local->ops->set_key(&local->hw, cmd, &sdata->vif, sta, key);
+	trace_drv_return_int(local, ret);
+	return ret;
+}
+
+int drv_change_vif_links(struct ieee80211_local *local,
+			 struct ieee80211_sub_if_data *sdata,
+			 u16 old_links, u16 new_links,
+			 struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	int ret = -EOPNOTSUPP;
+
+	might_sleep();
+
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	if (old_links == new_links)
+		return 0;
+
+	trace_drv_change_vif_links(local, sdata, old_links, new_links);
+	if (local->ops->change_vif_links)
+		ret = local->ops->change_vif_links(&local->hw, &sdata->vif,
+						   old_links, new_links, old);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
+int drv_change_sta_links(struct ieee80211_local *local,
+			 struct ieee80211_sub_if_data *sdata,
+			 struct ieee80211_sta *sta,
+			 u16 old_links, u16 new_links)
+{
+	int ret = -EOPNOTSUPP;
+
+	might_sleep();
+
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	old_links &= sdata->vif.active_links;
+	new_links &= sdata->vif.active_links;
+
+	if (old_links == new_links)
+		return 0;
+
+	trace_drv_change_sta_links(local, sdata, sta, old_links, new_links);
+	if (local->ops->change_sta_links)
+		ret = local->ops->change_sta_links(&local->hw, &sdata->vif, sta,
+						   old_links, new_links);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 482f5c97a72b..81e40b0a3b16 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -165,40 +165,10 @@ static inline void drv_vif_cfg_changed(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
-static inline void drv_link_info_changed(struct ieee80211_local *local,
-					 struct ieee80211_sub_if_data *sdata,
-					 struct ieee80211_bss_conf *info,
-					 int link_id, u64 changed)
-{
-	might_sleep();
-
-	if (WARN_ON_ONCE(changed & (BSS_CHANGED_BEACON |
-				    BSS_CHANGED_BEACON_ENABLED) &&
-			 sdata->vif.type != NL80211_IFTYPE_AP &&
-			 sdata->vif.type != NL80211_IFTYPE_ADHOC &&
-			 sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
-			 sdata->vif.type != NL80211_IFTYPE_OCB))
-		return;
-
-	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
-			 sdata->vif.type == NL80211_IFTYPE_NAN ||
-			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
-			  !sdata->vif.bss_conf.mu_mimo_owner &&
-			  !(changed & BSS_CHANGED_TXPOWER))))
-		return;
-
-	if (!check_sdata_in_driver(sdata))
-		return;
-
-	trace_drv_link_info_changed(local, sdata, info, changed);
-	if (local->ops->link_info_changed)
-		local->ops->link_info_changed(&local->hw, &sdata->vif,
-					      info, changed);
-	else if (local->ops->bss_info_changed)
-		local->ops->bss_info_changed(&local->hw, &sdata->vif,
-					     info, changed);
-	trace_drv_return_void(local);
-}
+void drv_link_info_changed(struct ieee80211_local *local,
+			   struct ieee80211_sub_if_data *sdata,
+			   struct ieee80211_bss_conf *info,
+			   int link_id, u64 changed);
 
 static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
 					struct netdev_hw_addr_list *mc_list)
@@ -256,25 +226,11 @@ static inline int drv_set_tim(struct ieee80211_local *local,
 	return ret;
 }
 
-static inline int drv_set_key(struct ieee80211_local *local,
-			      enum set_key_cmd cmd,
-			      struct ieee80211_sub_if_data *sdata,
-			      struct ieee80211_sta *sta,
-			      struct ieee80211_key_conf *key)
-{
-	int ret;
-
-	might_sleep();
-
-	sdata = get_bss_sdata(sdata);
-	if (!check_sdata_in_driver(sdata))
-		return -EIO;
-
-	trace_drv_set_key(local, cmd, sdata, sta, key);
-	ret = local->ops->set_key(&local->hw, cmd, &sdata->vif, sta, key);
-	trace_drv_return_int(local, ret);
-	return ret;
-}
+int drv_set_key(struct ieee80211_local *local,
+		enum set_key_cmd cmd,
+		struct ieee80211_sub_if_data *sdata,
+		struct ieee80211_sta *sta,
+		struct ieee80211_key_conf *key);
 
 static inline void drv_update_tkip_key(struct ieee80211_local *local,
 				       struct ieee80211_sub_if_data *sdata,
@@ -945,52 +901,14 @@ static inline void drv_verify_link_exists(struct ieee80211_sub_if_data *sdata,
 		sdata_assert_lock(sdata);
 }
 
-static inline int drv_assign_vif_chanctx(struct ieee80211_local *local,
-					 struct ieee80211_sub_if_data *sdata,
-					 struct ieee80211_bss_conf *link_conf,
-					 struct ieee80211_chanctx *ctx)
-{
-	int ret = 0;
-
-	drv_verify_link_exists(sdata, link_conf);
-	if (!check_sdata_in_driver(sdata))
-		return -EIO;
-
-	trace_drv_assign_vif_chanctx(local, sdata, link_conf, ctx);
-	if (local->ops->assign_vif_chanctx) {
-		WARN_ON_ONCE(!ctx->driver_present);
-		ret = local->ops->assign_vif_chanctx(&local->hw,
-						     &sdata->vif,
-						     link_conf,
-						     &ctx->conf);
-	}
-	trace_drv_return_int(local, ret);
-
-	return ret;
-}
-
-static inline void drv_unassign_vif_chanctx(struct ieee80211_local *local,
-					    struct ieee80211_sub_if_data *sdata,
-					    struct ieee80211_bss_conf *link_conf,
-					    struct ieee80211_chanctx *ctx)
-{
-	might_sleep();
-
-	drv_verify_link_exists(sdata, link_conf);
-	if (!check_sdata_in_driver(sdata))
-		return;
-
-	trace_drv_unassign_vif_chanctx(local, sdata, link_conf, ctx);
-	if (local->ops->unassign_vif_chanctx) {
-		WARN_ON_ONCE(!ctx->driver_present);
-		local->ops->unassign_vif_chanctx(&local->hw,
-						 &sdata->vif,
-						 link_conf,
-						 &ctx->conf);
-	}
-	trace_drv_return_void(local);
-}
-
+int drv_assign_vif_chanctx(struct ieee80211_local *local,
+			   struct ieee80211_sub_if_data *sdata,
+			   struct ieee80211_bss_conf *link_conf,
+			   struct ieee80211_chanctx *ctx);
+void drv_unassign_vif_chanctx(struct ieee80211_local *local,
+			      struct ieee80211_sub_if_data *sdata,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct ieee80211_chanctx *ctx);
 int drv_switch_vif_chanctx(struct ieee80211_local *local,
 			   struct ieee80211_vif_chanctx_switch *vifs,
 			   int n_vifs, enum ieee80211_chanctx_switch_mode mode);
@@ -1552,46 +1470,13 @@ static inline int drv_net_fill_forward_path(struct ieee80211_local *local,
 	return ret;
 }
 
-static inline int drv_change_vif_links(struct ieee80211_local *local,
-				       struct ieee80211_sub_if_data *sdata,
-				       u16 old_links, u16 new_links,
-				       struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
-{
-	int ret = -EOPNOTSUPP;
-
-	might_sleep();
-
-	if (!check_sdata_in_driver(sdata))
-		return -EIO;
-
-	trace_drv_change_vif_links(local, sdata, old_links, new_links);
-	if (local->ops->change_vif_links)
-		ret = local->ops->change_vif_links(&local->hw, &sdata->vif,
-						   old_links, new_links, old);
-	trace_drv_return_int(local, ret);
-
-	return ret;
-}
-
-static inline int drv_change_sta_links(struct ieee80211_local *local,
-				       struct ieee80211_sub_if_data *sdata,
-				       struct ieee80211_sta *sta,
-				       u16 old_links, u16 new_links)
-{
-	int ret = -EOPNOTSUPP;
-
-	might_sleep();
-
-	if (!check_sdata_in_driver(sdata))
-		return -EIO;
-
-	trace_drv_change_sta_links(local, sdata, sta, old_links, new_links);
-	if (local->ops->change_sta_links)
-		ret = local->ops->change_sta_links(&local->hw, &sdata->vif, sta,
-						   old_links, new_links);
-	trace_drv_return_int(local, ret);
-
-	return ret;
-}
+int drv_change_vif_links(struct ieee80211_local *local,
+			 struct ieee80211_sub_if_data *sdata,
+			 u16 old_links, u16 new_links,
+			 struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS]);
+int drv_change_sta_links(struct ieee80211_local *local,
+			 struct ieee80211_sub_if_data *sdata,
+			 struct ieee80211_sta *sta,
+			 u16 old_links, u16 new_links);
 
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index d89ec93b243b..f6f0f65fb255 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -177,6 +177,10 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 		}
 	}
 
+	if (key->conf.link_id >= 0 && sdata->vif.active_links &&
+	    !(sdata->vif.active_links & BIT(key->conf.link_id)))
+		return 0;
+
 	ret = drv_set_key(key->local, SET_KEY, sdata,
 			  sta ? &sta->sta : NULL, &key->conf);
 
@@ -246,6 +250,10 @@ static void ieee80211_key_disable_hw_accel(struct ieee80211_key *key)
 	sta = key->sta;
 	sdata = key->sdata;
 
+	if (key->conf.link_id >= 0 && sdata->vif.active_links &&
+	    !(sdata->vif.active_links & BIT(key->conf.link_id)))
+		return;
+
 	if (!(key->conf.flags & (IEEE80211_KEY_FLAG_GENERATE_MMIC |
 				 IEEE80211_KEY_FLAG_PUT_MIC_SPACE |
 				 IEEE80211_KEY_FLAG_RESERVE_TAILROOM)))
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 096f313c2a6e..8df348a5edce 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -73,28 +73,37 @@ struct link_container {
 	struct ieee80211_bss_conf conf;
 };
 
-static void ieee80211_free_links(struct ieee80211_sub_if_data *sdata,
-				 struct link_container **links)
+static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
+				      struct link_container **links, u16 mask)
 {
+	struct ieee80211_link_data *link;
 	LIST_HEAD(keys);
 	unsigned int link_id;
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
-		if (!links[link_id])
+		if (!(mask & BIT(link_id)))
 			continue;
-		ieee80211_remove_link_keys(&links[link_id]->data, &keys);
+		link = &links[link_id]->data;
+		if (link_id == 0 && !link)
+			link = &sdata->deflink;
+		if (WARN_ON(!link))
+			continue;
+		ieee80211_remove_link_keys(link, &keys);
+		ieee80211_link_stop(link);
 	}
 
 	synchronize_rcu();
 
 	ieee80211_free_key_list(sdata->local, &keys);
+}
 
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
-		if (!links[link_id])
-			continue;
-		ieee80211_link_stop(&links[link_id]->data);
+static void ieee80211_free_links(struct ieee80211_sub_if_data *sdata,
+				 struct link_container **links)
+{
+	unsigned int link_id;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
 		kfree(links[link_id]);
-	}
 }
 
 static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
@@ -123,11 +132,38 @@ static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
 	return 0;
 }
 
+static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
+					    u16 links)
+{
+	sdata->vif.valid_links = links;
+
+	if (!links) {
+		sdata->vif.active_links = 0;
+		return;
+	}
+
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+		/* in an AP all links are always active */
+		sdata->vif.active_links = links;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (sdata->vif.active_links)
+			break;
+		WARN_ON(hweight16(links) > 1);
+		sdata->vif.active_links = links;
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
 static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 				      struct link_container **to_free,
 				      u16 new_links)
 {
 	u16 old_links = sdata->vif.valid_links;
+	u16 old_active = sdata->vif.active_links;
 	unsigned long add = new_links & ~old_links;
 	unsigned long rem = old_links & ~new_links;
 	unsigned int link_id;
@@ -195,13 +231,17 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_init(sdata, -1, &sdata->deflink,
 				    &sdata->vif.bss_conf);
 
-	sdata->vif.valid_links = new_links;
-
 	ret = ieee80211_check_dup_link_addrs(sdata);
 	if (!ret) {
+		/* for keys we will not be able to undo this */
+		ieee80211_tear_down_links(sdata, to_free, rem);
+
+		ieee80211_set_vif_links_bitmaps(sdata, new_links);
+
 		/* tell the driver */
 		ret = drv_change_vif_links(sdata->local, sdata,
-					   old_links, new_links,
+					   old_links & old_active,
+					   new_links & sdata->vif.active_links,
 					   old);
 	}
 
@@ -209,7 +249,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		/* restore config */
 		memcpy(sdata->link, old_data, sizeof(old_data));
 		memcpy(sdata->vif.link_conf, old, sizeof(old));
-		sdata->vif.valid_links = old_links;
+		ieee80211_set_vif_links_bitmaps(sdata, old_links);
 		/* and free (only) the newly allocated links */
 		memset(to_free, 0, sizeof(links));
 		goto free;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4c8bbf0bd25b..30edac8724d5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4043,11 +4043,11 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		goto out;
 	}
 
-	sband = ieee80211_get_link_sband(link);
-	if (!sband) {
+	if (WARN_ON(!link->conf->chandef.chan)) {
 		ret = false;
 		goto out;
 	}
+	sband = local->hw.wiphy->bands[link->conf->chandef.chan->band];
 
 	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    (!elems->he_cap || !elems->he_operation)) {
@@ -4871,8 +4871,10 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			err = ieee80211_prep_channel(sdata, link,
 						     assoc_data->link[link_id].bss,
 						     &link->u.mgd.conn_flags);
-			if (err)
+			if (err) {
+				link_info(link, "prep_channel failed\n");
 				goto out_err;
+			}
 		}
 
 		err = ieee80211_mgd_setup_link_sta(link, sta, link_sta,
@@ -6876,23 +6878,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
 		size += req->links[i].elems_len;
 
-	if (req->ap_mld_addr) {
-		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-			if (!req->links[i].bss)
-				continue;
-			if (i == assoc_link_id)
-				continue;
-			/*
-			 * For now, support only a single link in MLO, we
-			 * don't have the necessary parsing of the multi-
-			 * link element in the association response, etc.
-			 */
-			sdata_info(sdata,
-				   "refusing MLO association with >1 links\n");
-			return -EINVAL;
-		}
-	}
-
 	assoc_data = kzalloc(size, GFP_KERNEL);
 	if (!assoc_data)
 		return -ENOMEM;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8b4c6b7abafa..0eed18189491 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2902,7 +2902,7 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 		 */
 		rcu_read_unlock();
 
-		if (WARN_ON_ONCE(!chanctx_conf))
+		if (!chanctx_conf)
 			goto unlock;
 
 		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
-- 
2.37.2

