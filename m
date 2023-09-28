Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3FB7B1FBA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjI1OgJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjI1OgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781B1B2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911764; x=1727447764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J4bkYJMTZkleugx0jHuV7+wbBiBml12mH0woJNycvq8=;
  b=V4O7wSB+CwTpXQTWJfN0NSMGvmzNNQaH3yE6l1Jd7BoWn+C76E5P1qum
   1eoGClq4G6UXmcOdZ2tP0Ho0QBHMBdmmLMZQaSACzfywnIEluTwIZ7XD+
   oD/A8HqRcmmOH2h/9BNVavtgM2Kkeitfz0mbo8UgRm0kzN9aDvUkOCffb
   qx3DCE57DtiSgxvshW8c69cLwDeJ+px/0+1+8Ql+8GfF8Jv4S6KklFH4z
   59X6jJKQnI/isnwMH27jjyblxyZoiBudESGxGxVlw17piyL3RkZqYbyZY
   E7YnJA7P6EKtEOyUlYxPw2C3nxAtKKvHqbYQN/zgAcxxZHv0qXCBoKGBu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688427"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688427"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590414"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590414"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/18] wifi: mac80211: handle debugfs when switching to/from MLO
Date:   Thu, 28 Sep 2023 17:35:26 +0300
Message-Id: <20230928172905.082e698caca9.I5bef7b2026e0f58b4a958b3d1f459ac5baeccfc9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

In MLO, we have a per-link debugfs directory which contains the
per-link files. In case of non-MLO we would like to put the per-link
files in the netdev directory to keep it how it was before MLO.

- Upon interface creation the netdev will be created with the per-link
  files in it.
- Upon switching to MLO: delete the entire netdev directory and then
  recreate it without the per-link files. Then the per-link directories
  with the per-link files in it will be created in ieee80211_link_init()
- Upon switching to non-MLO: delete the entire netdev directory
  (including the per-link directories) and recreate it with the per-link
  files in it.

Note that this also aligns to always call the vif link debugfs
method for the deflink as promised in the documentation, which
wasn't done before.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/debugfs_netdev.c | 23 ++++++++++++++++++-----
 net/mac80211/debugfs_netdev.h | 15 ++++++++++++---
 net/mac80211/driver-ops.c     |  5 ++++-
 net/mac80211/iface.c          |  2 +-
 net/mac80211/link.c           |  5 +++++
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 14a40348959a..b383dad18841 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -934,18 +934,20 @@ static void add_link_files(struct ieee80211_link_data *link,
 	}
 }
 
-void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata)
+void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
+				  bool mld_vif)
 {
 	char buf[10+IFNAMSIZ];
 
 	sprintf(buf, "netdev:%s", sdata->name);
 	sdata->vif.debugfs_dir = debugfs_create_dir(buf,
 		sdata->local->hw.wiphy->debugfsdir);
+	/* deflink also has this */
+	sdata->deflink.debugfs_dir = sdata->vif.debugfs_dir;
 	sdata->debugfs.subdir_stations = debugfs_create_dir("stations",
 							sdata->vif.debugfs_dir);
 	add_files(sdata);
-
-	if (!(sdata->local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
+	if (!mld_vif)
 		add_link_files(&sdata->deflink, sdata->vif.debugfs_dir);
 }
 
@@ -973,11 +975,21 @@ void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata)
 	debugfs_rename(dir->d_parent, dir, dir->d_parent, buf);
 }
 
+void ieee80211_debugfs_recreate_netdev(struct ieee80211_sub_if_data *sdata,
+				       bool mld_vif)
+{
+	ieee80211_debugfs_remove_netdev(sdata);
+	ieee80211_debugfs_add_netdev(sdata, mld_vif);
+	drv_vif_add_debugfs(sdata->local, sdata);
+	if (!mld_vif)
+		ieee80211_link_debugfs_drv_add(&sdata->deflink);
+}
+
 void ieee80211_link_debugfs_add(struct ieee80211_link_data *link)
 {
 	char link_dir_name[10];
 
-	if (WARN_ON(!link->sdata->vif.debugfs_dir))
+	if (WARN_ON(!link->sdata->vif.debugfs_dir || link->debugfs_dir))
 		return;
 
 	/* For now, this should not be called for non-MLO capable drivers */
@@ -1014,7 +1026,8 @@ void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link)
 
 void ieee80211_link_debugfs_drv_add(struct ieee80211_link_data *link)
 {
-	if (WARN_ON(!link->debugfs_dir))
+	if (link->sdata->vif.type == NL80211_IFTYPE_MONITOR ||
+	    WARN_ON(!link->debugfs_dir))
 		return;
 
 	drv_link_add_debugfs(link->sdata->local, link->sdata,
diff --git a/net/mac80211/debugfs_netdev.h b/net/mac80211/debugfs_netdev.h
index 99e688dcabd6..b226b1aae88a 100644
--- a/net/mac80211/debugfs_netdev.h
+++ b/net/mac80211/debugfs_netdev.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Portions:
+ * Copyright (C) 2023 Intel Corporation
+ */
 /* routines exported for debugfs handling */
 
 #ifndef __IEEE80211_DEBUGFS_NETDEV_H
@@ -7,9 +11,12 @@
 #include "ieee80211_i.h"
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata);
+void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
+				  bool mld_vif);
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata);
+void ieee80211_debugfs_recreate_netdev(struct ieee80211_sub_if_data *sdata,
+				       bool mld_vif);
 
 void ieee80211_link_debugfs_add(struct ieee80211_link_data *link);
 void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link);
@@ -18,7 +25,7 @@ void ieee80211_link_debugfs_drv_add(struct ieee80211_link_data *link);
 void ieee80211_link_debugfs_drv_remove(struct ieee80211_link_data *link);
 #else
 static inline void ieee80211_debugfs_add_netdev(
-	struct ieee80211_sub_if_data *sdata)
+	struct ieee80211_sub_if_data *sdata, bool mld_vif)
 {}
 static inline void ieee80211_debugfs_remove_netdev(
 	struct ieee80211_sub_if_data *sdata)
@@ -26,7 +33,9 @@ static inline void ieee80211_debugfs_remove_netdev(
 static inline void ieee80211_debugfs_rename_netdev(
 	struct ieee80211_sub_if_data *sdata)
 {}
-
+static inline void ieee80211_debugfs_recreate_netdev(
+	struct ieee80211_sub_if_data *sdata, bool mld_vif)
+{}
 static inline void ieee80211_link_debugfs_add(struct ieee80211_link_data *link)
 {}
 static inline void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link)
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 08861ec61be9..7938ec87ef25 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -77,8 +77,11 @@ int drv_add_interface(struct ieee80211_local *local,
 
 	sdata->flags |= IEEE80211_SDATA_IN_DRIVER;
 
-	if (!local->in_reconfig)
+	if (!local->in_reconfig) {
 		drv_vif_add_debugfs(local, sdata);
+		/* initially vif is not MLD */
+		ieee80211_link_debugfs_drv_add(&sdata->deflink);
+	}
 
 	return 0;
 }
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 510f8aead4f9..124cc53f6b34 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1775,7 +1775,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	/* need to do this after the switch so vif.type is correct */
 	ieee80211_link_setup(&sdata->deflink);
 
-	ieee80211_debugfs_add_netdev(sdata);
+	ieee80211_debugfs_add_netdev(sdata, false);
 }
 
 static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 2a78374f6f04..76c61a132569 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -235,6 +235,9 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
 	}
 
+	if (!old_links)
+		ieee80211_debugfs_recreate_netdev(sdata, true);
+
 	/* link them into data structures */
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		WARN_ON(!use_deflink &&
@@ -261,6 +264,8 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 					   old_links & old_active,
 					   new_links & sdata->vif.active_links,
 					   old);
+		if (!new_links)
+			ieee80211_debugfs_recreate_netdev(sdata, false);
 	}
 
 	if (ret) {
-- 
2.38.1

