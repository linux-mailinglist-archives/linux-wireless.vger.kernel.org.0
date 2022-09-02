Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06215AB41E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiIBOvT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiIBOvD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351504D810
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=EU9sg5aPJgpY7LA8+6sIDCi0mVL7owaquPUDRFm190g=;
        t=1662127986; x=1663337586; b=FwdOX3fXTHZt+dXRl6ur8Ccg8FlHBxIetOMNSLHd0/4Lqyq
        TmPif3omQRTFery5CF5iHLhdmPGEZKiBV4a9f02QsWEap5h/Ich3vPuqcncTDzRyTKyDNRLGOJ18J
        wvLHuY++p8Rsi3mnSeRAK9F/fYZXfbdKcM3Ew//+htUpPNwdYY9KAUUX7GjC7bDTbKeZIsA/3ekGq
        SzmZhu1TYc8GLckzTWUiCrodYw92NV7rDd+Y12flaWhm2R1jzxeYQYFtYrrJbTSN8SWDQ99ZFihnp
        1FQ5BQlXE/aq9hzxQHn2TuNkcnXcFdpACnRCa6oEeH8K5o6bWkYoZXWpk/VVO0qQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Ps-006Ch3-02;
        Fri, 02 Sep 2022 16:13:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/27] wifi: mac80211: move link code to a new file
Date:   Fri,  2 Sep 2022 16:12:37 +0200
Message-Id: <20220902161143.9f95a21e1f83.I09793626bcf7b079efbcd6b1652af8012c875e04@changeid>
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

We probably should've done that originally, we already have
about 300 lines of code there, and will add more. Move all
the link code we wrote to a new file.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/Makefile      |   1 +
 net/mac80211/ieee80211_i.h |  14 +-
 net/mac80211/iface.c       | 251 -----------------------------------
 net/mac80211/link.c        | 262 +++++++++++++++++++++++++++++++++++++
 4 files changed, 274 insertions(+), 254 deletions(-)
 create mode 100644 net/mac80211/link.c

diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index af1df3a6bd55..b8de44da1fb8 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -16,6 +16,7 @@ mac80211-y := \
 	s1g.o \
 	ibss.o \
 	iface.o \
+	link.o \
 	rate.o \
 	michael.o \
 	tkip.o \
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e902feecfad4..b41c49338cd3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1930,9 +1930,6 @@ void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
 int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
-int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
-			    u16 new_links);
-
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
 void ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata,
 			      bool update_bss);
@@ -1943,6 +1940,17 @@ static inline bool ieee80211_sdata_running(struct ieee80211_sub_if_data *sdata)
 	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
 }
 
+/* link handling */
+void ieee80211_link_setup(struct ieee80211_link_data *link);
+void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
+			 int link_id,
+			 struct ieee80211_link_data *link,
+			 struct ieee80211_bss_conf *link_conf);
+void ieee80211_link_stop(struct ieee80211_link_data *link);
+int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
+			    u16 new_links);
+void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 14505278073a..bf1c44d53c30 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -368,257 +368,6 @@ static int ieee80211_open(struct net_device *dev)
 	return err;
 }
 
-static void ieee80211_link_setup(struct ieee80211_link_data *link)
-{
-	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
-		ieee80211_mgd_setup_link(link);
-}
-
-static void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
-				int link_id,
-				struct ieee80211_link_data *link,
-				struct ieee80211_bss_conf *link_conf)
-{
-	bool deflink = link_id < 0;
-
-	if (link_id < 0)
-		link_id = 0;
-
-	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
-	rcu_assign_pointer(sdata->link[link_id], link);
-
-	link->sdata = sdata;
-	link->link_id = link_id;
-	link->conf = link_conf;
-	link_conf->link_id = link_id;
-
-	INIT_WORK(&link->csa_finalize_work,
-		  ieee80211_csa_finalize_work);
-	INIT_WORK(&link->color_change_finalize_work,
-		  ieee80211_color_change_finalize_work);
-	INIT_LIST_HEAD(&link->assigned_chanctx_list);
-	INIT_LIST_HEAD(&link->reserved_chanctx_list);
-	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
-			  ieee80211_dfs_cac_timer_work);
-
-	if (!deflink) {
-		switch (sdata->vif.type) {
-		case NL80211_IFTYPE_AP:
-			ether_addr_copy(link_conf->addr,
-					sdata->wdev.links[link_id].addr);
-			link_conf->bssid = link_conf->addr;
-			WARN_ON(!(sdata->wdev.valid_links & BIT(link_id)));
-			break;
-		case NL80211_IFTYPE_STATION:
-			/* station sets the bssid in ieee80211_mgd_setup_link */
-			break;
-		default:
-			WARN_ON(1);
-		}
-	}
-}
-
-static void ieee80211_link_stop(struct ieee80211_link_data *link)
-{
-	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
-		ieee80211_mgd_stop_link(link);
-
-	ieee80211_link_release_channel(link);
-}
-
-struct link_container {
-	struct ieee80211_link_data data;
-	struct ieee80211_bss_conf conf;
-};
-
-static void ieee80211_free_links(struct ieee80211_sub_if_data *sdata,
-				 struct link_container **links)
-{
-	LIST_HEAD(keys);
-	unsigned int link_id;
-
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
-		if (!links[link_id])
-			continue;
-		ieee80211_remove_link_keys(&links[link_id]->data, &keys);
-	}
-
-	synchronize_rcu();
-
-	ieee80211_free_key_list(sdata->local, &keys);
-
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
-		if (!links[link_id])
-			continue;
-		ieee80211_link_stop(&links[link_id]->data);
-		kfree(links[link_id]);
-	}
-}
-
-static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
-{
-	unsigned int i, j;
-
-	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		struct ieee80211_link_data *link1;
-
-		link1 = sdata_dereference(sdata->link[i], sdata);
-		if (!link1)
-			continue;
-		for (j = i + 1; j < IEEE80211_MLD_MAX_NUM_LINKS; j++) {
-			struct ieee80211_link_data *link2;
-
-			link2 = sdata_dereference(sdata->link[j], sdata);
-			if (!link2)
-				continue;
-
-			if (ether_addr_equal(link1->conf->addr,
-					     link2->conf->addr))
-				return -EALREADY;
-		}
-	}
-
-	return 0;
-}
-
-static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
-				      struct link_container **to_free,
-				      u16 new_links)
-{
-	u16 old_links = sdata->vif.valid_links;
-	unsigned long add = new_links & ~old_links;
-	unsigned long rem = old_links & ~new_links;
-	unsigned int link_id;
-	int ret;
-	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *link;
-	struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS];
-	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
-	bool use_deflink = old_links == 0; /* set for error case */
-
-	sdata_assert_lock(sdata);
-
-	memset(to_free, 0, sizeof(links));
-
-	if (old_links == new_links)
-		return 0;
-
-	/* if there were no old links, need to clear the pointers to deflink */
-	if (!old_links)
-		rem |= BIT(0);
-
-	/* allocate new link structures first */
-	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		link = kzalloc(sizeof(*link), GFP_KERNEL);
-		if (!link) {
-			ret = -ENOMEM;
-			goto free;
-		}
-		links[link_id] = link;
-	}
-
-	/* keep track of the old pointers for the driver */
-	BUILD_BUG_ON(sizeof(old) != sizeof(sdata->vif.link_conf));
-	memcpy(old, sdata->vif.link_conf, sizeof(old));
-	/* and for us in error cases */
-	BUILD_BUG_ON(sizeof(old_data) != sizeof(sdata->link));
-	memcpy(old_data, sdata->link, sizeof(old_data));
-
-	/* grab old links to free later */
-	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		if (rcu_access_pointer(sdata->link[link_id]) != &sdata->deflink) {
-			/*
-			 * we must have allocated the data through this path so
-			 * we know we can free both at the same time
-			 */
-			to_free[link_id] = container_of(rcu_access_pointer(sdata->link[link_id]),
-							typeof(*links[link_id]),
-							data);
-		}
-
-		RCU_INIT_POINTER(sdata->link[link_id], NULL);
-		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
-	}
-
-	/* link them into data structures */
-	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		WARN_ON(!use_deflink &&
-			rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink);
-
-		link = links[link_id];
-		ieee80211_link_init(sdata, link_id, &link->data, &link->conf);
-		ieee80211_link_setup(&link->data);
-	}
-
-	if (new_links == 0)
-		ieee80211_link_init(sdata, -1, &sdata->deflink,
-				    &sdata->vif.bss_conf);
-
-	sdata->vif.valid_links = new_links;
-
-	ret = ieee80211_check_dup_link_addrs(sdata);
-	if (!ret) {
-		/* tell the driver */
-		ret = drv_change_vif_links(sdata->local, sdata,
-					   old_links, new_links,
-					   old);
-	}
-
-	if (ret) {
-		/* restore config */
-		memcpy(sdata->link, old_data, sizeof(old_data));
-		memcpy(sdata->vif.link_conf, old, sizeof(old));
-		sdata->vif.valid_links = old_links;
-		/* and free (only) the newly allocated links */
-		memset(to_free, 0, sizeof(links));
-		goto free;
-	}
-
-	/* use deflink/bss_conf again if and only if there are no more links */
-	use_deflink = new_links == 0;
-
-	goto deinit;
-free:
-	/* if we failed during allocation, only free all */
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
-		kfree(links[link_id]);
-		links[link_id] = NULL;
-	}
-deinit:
-	if (use_deflink)
-		ieee80211_link_init(sdata, -1, &sdata->deflink,
-				    &sdata->vif.bss_conf);
-	return ret;
-}
-
-int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
-			    u16 new_links)
-{
-	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
-	int ret;
-
-	ret = ieee80211_vif_update_links(sdata, links, new_links);
-	ieee80211_free_links(sdata, links);
-
-	return ret;
-}
-
-static void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
-{
-	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
-
-	/*
-	 * The locking here is different because when we free links
-	 * in the station case we need to be able to cancel_work_sync()
-	 * something that also takes the lock.
-	 */
-
-	sdata_lock(sdata);
-	ieee80211_vif_update_links(sdata, links, 0);
-	sdata_unlock(sdata);
-
-	ieee80211_free_links(sdata, links);
-}
-
 static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_down)
 {
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
new file mode 100644
index 000000000000..096f313c2a6e
--- /dev/null
+++ b/net/mac80211/link.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MLO link handling
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <net/mac80211.h>
+#include "ieee80211_i.h"
+#include "driver-ops.h"
+
+void ieee80211_link_setup(struct ieee80211_link_data *link)
+{
+	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
+		ieee80211_mgd_setup_link(link);
+}
+
+void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
+			 int link_id,
+			 struct ieee80211_link_data *link,
+			 struct ieee80211_bss_conf *link_conf)
+{
+	bool deflink = link_id < 0;
+
+	if (link_id < 0)
+		link_id = 0;
+
+	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
+	rcu_assign_pointer(sdata->link[link_id], link);
+
+	link->sdata = sdata;
+	link->link_id = link_id;
+	link->conf = link_conf;
+	link_conf->link_id = link_id;
+
+	INIT_WORK(&link->csa_finalize_work,
+		  ieee80211_csa_finalize_work);
+	INIT_WORK(&link->color_change_finalize_work,
+		  ieee80211_color_change_finalize_work);
+	INIT_LIST_HEAD(&link->assigned_chanctx_list);
+	INIT_LIST_HEAD(&link->reserved_chanctx_list);
+	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
+			  ieee80211_dfs_cac_timer_work);
+
+	if (!deflink) {
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_AP:
+			ether_addr_copy(link_conf->addr,
+					sdata->wdev.links[link_id].addr);
+			link_conf->bssid = link_conf->addr;
+			WARN_ON(!(sdata->wdev.valid_links & BIT(link_id)));
+			break;
+		case NL80211_IFTYPE_STATION:
+			/* station sets the bssid in ieee80211_mgd_setup_link */
+			break;
+		default:
+			WARN_ON(1);
+		}
+	}
+}
+
+void ieee80211_link_stop(struct ieee80211_link_data *link)
+{
+	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
+		ieee80211_mgd_stop_link(link);
+
+	ieee80211_link_release_channel(link);
+}
+
+struct link_container {
+	struct ieee80211_link_data data;
+	struct ieee80211_bss_conf conf;
+};
+
+static void ieee80211_free_links(struct ieee80211_sub_if_data *sdata,
+				 struct link_container **links)
+{
+	LIST_HEAD(keys);
+	unsigned int link_id;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		if (!links[link_id])
+			continue;
+		ieee80211_remove_link_keys(&links[link_id]->data, &keys);
+	}
+
+	synchronize_rcu();
+
+	ieee80211_free_key_list(sdata->local, &keys);
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		if (!links[link_id])
+			continue;
+		ieee80211_link_stop(&links[link_id]->data);
+		kfree(links[link_id]);
+	}
+}
+
+static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		struct ieee80211_link_data *link1;
+
+		link1 = sdata_dereference(sdata->link[i], sdata);
+		if (!link1)
+			continue;
+		for (j = i + 1; j < IEEE80211_MLD_MAX_NUM_LINKS; j++) {
+			struct ieee80211_link_data *link2;
+
+			link2 = sdata_dereference(sdata->link[j], sdata);
+			if (!link2)
+				continue;
+
+			if (ether_addr_equal(link1->conf->addr,
+					     link2->conf->addr))
+				return -EALREADY;
+		}
+	}
+
+	return 0;
+}
+
+static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
+				      struct link_container **to_free,
+				      u16 new_links)
+{
+	u16 old_links = sdata->vif.valid_links;
+	unsigned long add = new_links & ~old_links;
+	unsigned long rem = old_links & ~new_links;
+	unsigned int link_id;
+	int ret;
+	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *link;
+	struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
+	bool use_deflink = old_links == 0; /* set for error case */
+
+	sdata_assert_lock(sdata);
+
+	memset(to_free, 0, sizeof(links));
+
+	if (old_links == new_links)
+		return 0;
+
+	/* if there were no old links, need to clear the pointers to deflink */
+	if (!old_links)
+		rem |= BIT(0);
+
+	/* allocate new link structures first */
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		link = kzalloc(sizeof(*link), GFP_KERNEL);
+		if (!link) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		links[link_id] = link;
+	}
+
+	/* keep track of the old pointers for the driver */
+	BUILD_BUG_ON(sizeof(old) != sizeof(sdata->vif.link_conf));
+	memcpy(old, sdata->vif.link_conf, sizeof(old));
+	/* and for us in error cases */
+	BUILD_BUG_ON(sizeof(old_data) != sizeof(sdata->link));
+	memcpy(old_data, sdata->link, sizeof(old_data));
+
+	/* grab old links to free later */
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (rcu_access_pointer(sdata->link[link_id]) != &sdata->deflink) {
+			/*
+			 * we must have allocated the data through this path so
+			 * we know we can free both at the same time
+			 */
+			to_free[link_id] = container_of(rcu_access_pointer(sdata->link[link_id]),
+							typeof(*links[link_id]),
+							data);
+		}
+
+		RCU_INIT_POINTER(sdata->link[link_id], NULL);
+		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
+	}
+
+	/* link them into data structures */
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		WARN_ON(!use_deflink &&
+			rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink);
+
+		link = links[link_id];
+		ieee80211_link_init(sdata, link_id, &link->data, &link->conf);
+		ieee80211_link_setup(&link->data);
+	}
+
+	if (new_links == 0)
+		ieee80211_link_init(sdata, -1, &sdata->deflink,
+				    &sdata->vif.bss_conf);
+
+	sdata->vif.valid_links = new_links;
+
+	ret = ieee80211_check_dup_link_addrs(sdata);
+	if (!ret) {
+		/* tell the driver */
+		ret = drv_change_vif_links(sdata->local, sdata,
+					   old_links, new_links,
+					   old);
+	}
+
+	if (ret) {
+		/* restore config */
+		memcpy(sdata->link, old_data, sizeof(old_data));
+		memcpy(sdata->vif.link_conf, old, sizeof(old));
+		sdata->vif.valid_links = old_links;
+		/* and free (only) the newly allocated links */
+		memset(to_free, 0, sizeof(links));
+		goto free;
+	}
+
+	/* use deflink/bss_conf again if and only if there are no more links */
+	use_deflink = new_links == 0;
+
+	goto deinit;
+free:
+	/* if we failed during allocation, only free all */
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		kfree(links[link_id]);
+		links[link_id] = NULL;
+	}
+deinit:
+	if (use_deflink)
+		ieee80211_link_init(sdata, -1, &sdata->deflink,
+				    &sdata->vif.bss_conf);
+	return ret;
+}
+
+int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
+			    u16 new_links)
+{
+	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
+	int ret;
+
+	ret = ieee80211_vif_update_links(sdata, links, new_links);
+	ieee80211_free_links(sdata, links);
+
+	return ret;
+}
+
+void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
+{
+	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	/*
+	 * The locking here is different because when we free links
+	 * in the station case we need to be able to cancel_work_sync()
+	 * something that also takes the lock.
+	 */
+
+	sdata_lock(sdata);
+	ieee80211_vif_update_links(sdata, links, 0);
+	sdata_unlock(sdata);
+
+	ieee80211_free_links(sdata, links);
+}
-- 
2.37.2

