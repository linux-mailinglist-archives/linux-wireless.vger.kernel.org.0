Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0097A5F54DB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJENBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJENA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE81EEC5
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qnll5W4uhRYffmFYvjQjMFYXL0t9tuWhkKPrxq6MSgI=;
        t=1664974853; x=1666184453; b=qSP1xlysYnc7/dHnJXT3YAekvbtb1avOYxYliymn/77VV4v
        p/fL0AfZl4POpKuHN8F1ueFlIiOG7eiKqEtX9JXOaj3tZy9jn/nxtD3Gl6htZ+a3crs5GwZQOVpS+
        PEUkJbQqqedjNqabVBR0fCvc6jzDSLfQHFSdb1L+Bf1DjXnNEPdQjsLQLG+V4EqM4+1FI6ddxTtch
        D0jtrQmeMKvA7gRkIq71qjn4pHpuBTmKtq+mpsl1oMLzzNijudwmX6nWZ4+s/XNgoqaFb8s7165Qj
        uJXiRbakkcLXl6RPwkX0oznghSysBkURNYcTLl/Q6AaAj2kt1BaAn4n5cSqgCeYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og415-00G2RL-09;
        Wed, 05 Oct 2022 15:00:51 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 02/28] wifi: mac80211: add API to show the link STAs in debugfs
Date:   Wed,  5 Oct 2022 15:00:22 +0200
Message-Id: <20221005145226.520e0d996c5e.I4575134bf2d12af084d2d29dadc4632f2f813ca5@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

Create debugfs data per-link. For drivers, there is a new operation
link_sta_add_debugfs which will always be called.

For non-MLO, the station directory will be used directly rather than
creating a corresponding subdirectory. As such, non-MLO drivers can
simply continue to create the data from sta_debugfs_add.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  11 ++++
 net/mac80211/debugfs_sta.c | 127 ++++++++++++++++++++++++++++++-------
 net/mac80211/debugfs_sta.h |   9 +++
 net/mac80211/driver-ops.c  |  27 +++++++-
 net/mac80211/driver-ops.h  |  16 +++++
 net/mac80211/sta_info.c    |  25 ++++++++
 net/mac80211/sta_info.h    |   5 ++
 7 files changed, 197 insertions(+), 23 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7778a92d9582..c413050ec8dd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3790,6 +3790,13 @@ struct ieee80211_prep_tx_info {
  *	should be within a CONFIG_MAC80211_DEBUGFS conditional. This
  *	callback can sleep.
  *
+ * @link_sta_add_debugfs: Drivers can use this callback to add debugfs files
+ *	when a link is added to a mac80211 station. This callback
+ *	should be within a CPTCFG_MAC80211_DEBUGFS conditional. This
+ *	callback can sleep.
+ *	For non-MLO the callback will be called once for the deflink with the
+ *	station's directory rather than a separate subdirectory.
+ *
  * @sta_notify: Notifies low level driver about power state transition of an
  *	associated station, AP,  IBSS/WDS/mesh peer etc. For a VIF operating
  *	in AP mode, this callback will not be called when the flag
@@ -4260,6 +4267,10 @@ struct ieee80211_ops {
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
 				struct dentry *dir);
+	void (*link_sta_add_debugfs)(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_link_sta *link_sta,
+				     struct dentry *dir);
 #endif
 	void (*sta_notify)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			enum sta_notify_cmd, struct ieee80211_sta *sta);
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index d3397c1248d3..68c07d4b95a5 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -5,7 +5,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2021 Intel Corporation
+ * Copyright (C) 2018 - 2022 Intel Corporation
  */
 
 #include <linux/debugfs.h>
@@ -435,8 +435,16 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 }
 STA_OPS_RW(agg_status);
 
-static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+/* link sta attributes */
+#define LINK_STA_OPS(name)						\
+static const struct file_operations link_sta_ ##name## _ops = {		\
+	.read = link_sta_##name##_read,					\
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+}
+
+static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
+				     size_t count, loff_t *ppos)
 {
 #define PRINT_HT_CAP(_cond, _str) \
 	do { \
@@ -446,8 +454,8 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 	char *buf, *p;
 	int i;
 	ssize_t bufsz = 512;
-	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_ht_cap *htc = &sta->sta.deflink.ht_cap;
+	struct link_sta_info *link_sta = file->private_data;
+	struct ieee80211_sta_ht_cap *htc = &link_sta->pub->ht_cap;
 	ssize_t ret;
 
 	buf = kzalloc(bufsz, GFP_KERNEL);
@@ -524,14 +532,14 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 	kfree(buf);
 	return ret;
 }
-STA_OPS(ht_capa);
+LINK_STA_OPS(ht_capa);
 
-static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t link_sta_vht_capa_read(struct file *file, char __user *userbuf,
+				      size_t count, loff_t *ppos)
 {
 	char *buf, *p;
-	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_vht_cap *vhtc = &sta->sta.deflink.vht_cap;
+	struct link_sta_info *link_sta = file->private_data;
+	struct ieee80211_sta_vht_cap *vhtc = &link_sta->pub->vht_cap;
 	ssize_t ret;
 	ssize_t bufsz = 512;
 
@@ -638,15 +646,15 @@ static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 	kfree(buf);
 	return ret;
 }
-STA_OPS(vht_capa);
+LINK_STA_OPS(vht_capa);
 
-static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
+				     size_t count, loff_t *ppos)
 {
 	char *buf, *p;
 	size_t buf_sz = PAGE_SIZE;
-	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_he_cap *hec = &sta->sta.deflink.he_cap;
+	struct link_sta_info *link_sta = file->private_data;
+	struct ieee80211_sta_he_cap *hec = &link_sta->pub->he_cap;
 	struct ieee80211_he_mcs_nss_supp *nss = &hec->he_mcs_nss_supp;
 	u8 ppe_size;
 	u8 *cap;
@@ -1011,7 +1019,7 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 	kfree(buf);
 	return ret;
 }
-STA_OPS(he_capa);
+LINK_STA_OPS(he_capa);
 
 #define DEBUGFS_ADD(name) \
 	debugfs_create_file(#name, 0400, \
@@ -1048,12 +1056,7 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 	DEBUGFS_ADD(num_ps_buf_frames);
 	DEBUGFS_ADD(last_seq_ctrl);
 	DEBUGFS_ADD(agg_status);
-	DEBUGFS_ADD(ht_capa);
-	DEBUGFS_ADD(vht_capa);
-	DEBUGFS_ADD(he_capa);
-
-	DEBUGFS_ADD_COUNTER(rx_duplicates, deflink.rx_stats.num_duplicates);
-	DEBUGFS_ADD_COUNTER(rx_fragments, deflink.rx_stats.fragments);
+	/* FIXME: Kept here as the statistics are only done on the deflink */
 	DEBUGFS_ADD_COUNTER(tx_filtered, deflink.status_stats.filtered);
 
 	if (local->ops->wake_tx_queue) {
@@ -1076,3 +1079,83 @@ void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 	debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }
+
+#undef DEBUGFS_ADD
+#undef DEBUGFS_ADD_COUNTER
+
+#define DEBUGFS_ADD(name) \
+	debugfs_create_file(#name, 0400, \
+		link_sta->debugfs_dir, link_sta, &link_sta_ ##name## _ops)
+#define DEBUGFS_ADD_COUNTER(name, field)				\
+	debugfs_create_ulong(#name, 0400, link_sta->debugfs_dir, &link_sta->field)
+
+void ieee80211_link_sta_debugfs_add(struct link_sta_info *link_sta)
+{
+	if (WARN_ON(!link_sta->sta->debugfs_dir))
+		return;
+
+	/* For non-MLO, leave the files in the main directory. */
+	if (link_sta->sta->sta.valid_links) {
+		char link_dir_name[10];
+
+		snprintf(link_dir_name, sizeof(link_dir_name),
+			 "link-%d", link_sta->link_id);
+
+		link_sta->debugfs_dir =
+			debugfs_create_dir(link_dir_name,
+					   link_sta->sta->debugfs_dir);
+	} else {
+		if (WARN_ON(link_sta != &link_sta->sta->deflink))
+			return;
+
+		link_sta->debugfs_dir = link_sta->sta->debugfs_dir;
+	}
+
+	DEBUGFS_ADD(ht_capa);
+	DEBUGFS_ADD(vht_capa);
+	DEBUGFS_ADD(he_capa);
+
+	DEBUGFS_ADD_COUNTER(rx_duplicates, rx_stats.num_duplicates);
+	DEBUGFS_ADD_COUNTER(rx_fragments, rx_stats.fragments);
+}
+
+void ieee80211_link_sta_debugfs_remove(struct link_sta_info *link_sta)
+{
+	if (!link_sta->debugfs_dir || !link_sta->sta->debugfs_dir) {
+		link_sta->debugfs_dir = NULL;
+		return;
+	}
+
+	if (link_sta->debugfs_dir == link_sta->sta->debugfs_dir) {
+		WARN_ON(link_sta != &link_sta->sta->deflink);
+		link_sta->sta->debugfs_dir = NULL;
+		return;
+	}
+
+	debugfs_remove_recursive(link_sta->debugfs_dir);
+	link_sta->debugfs_dir = NULL;
+}
+
+void ieee80211_link_sta_debugfs_drv_add(struct link_sta_info *link_sta)
+{
+	if (WARN_ON(!link_sta->debugfs_dir))
+		return;
+
+	drv_link_sta_add_debugfs(link_sta->sta->local, link_sta->sta->sdata,
+				 link_sta->pub, link_sta->debugfs_dir);
+}
+
+void ieee80211_link_sta_debugfs_drv_remove(struct link_sta_info *link_sta)
+{
+	if (!link_sta->debugfs_dir)
+		return;
+
+	if (WARN_ON(link_sta->debugfs_dir == link_sta->sta->debugfs_dir))
+		return;
+
+	/* Recreate the directory excluding the driver data */
+	debugfs_remove_recursive(link_sta->debugfs_dir);
+	link_sta->debugfs_dir = NULL;
+
+	ieee80211_link_sta_debugfs_add(link_sta);
+}
diff --git a/net/mac80211/debugfs_sta.h b/net/mac80211/debugfs_sta.h
index d2e7c27ad6d1..fcc0939685c5 100644
--- a/net/mac80211/debugfs_sta.h
+++ b/net/mac80211/debugfs_sta.h
@@ -7,9 +7,18 @@
 #ifdef CONFIG_MAC80211_DEBUGFS
 void ieee80211_sta_debugfs_add(struct sta_info *sta);
 void ieee80211_sta_debugfs_remove(struct sta_info *sta);
+
+void ieee80211_link_sta_debugfs_add(struct link_sta_info *link_sta);
+void ieee80211_link_sta_debugfs_remove(struct link_sta_info *link_sta);
+
+void ieee80211_link_sta_debugfs_drv_add(struct link_sta_info *link_sta);
+void ieee80211_link_sta_debugfs_drv_remove(struct link_sta_info *link_sta);
 #else
 static inline void ieee80211_sta_debugfs_add(struct sta_info *sta) {}
 static inline void ieee80211_sta_debugfs_remove(struct sta_info *sta) {}
+
+static inline void ieee80211_link_sta_debugfs_drv_add(struct link_sta_info *link_sta) {}
+static inline void ieee80211_link_sta_debugfs_drv_remove(struct link_sta_info *link_sta) {}
 #endif
 
 #endif /* __MAC80211_DEBUGFS_STA_H */
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 5392ffa18270..d737db4e07e2 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -7,6 +7,7 @@
 #include "ieee80211_i.h"
 #include "trace.h"
 #include "driver-ops.h"
+#include "debugfs_sta.h"
 
 int drv_start(struct ieee80211_local *local)
 {
@@ -497,6 +498,11 @@ int drv_change_sta_links(struct ieee80211_local *local,
 			 struct ieee80211_sta *sta,
 			 u16 old_links, u16 new_links)
 {
+	struct sta_info *info = container_of(sta, struct sta_info, sta);
+	struct link_sta_info *link_sta;
+	unsigned long links_to_add;
+	unsigned long links_to_rem;
+	unsigned int link_id;
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
@@ -510,11 +516,30 @@ int drv_change_sta_links(struct ieee80211_local *local,
 	if (old_links == new_links)
 		return 0;
 
+	links_to_add = ~old_links & new_links;
+	links_to_rem = old_links & ~new_links;
+
+	for_each_set_bit(link_id, &links_to_rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		link_sta = rcu_dereference_protected(info->link[link_id],
+						     lockdep_is_held(&local->sta_mtx));
+
+		ieee80211_link_sta_debugfs_drv_remove(link_sta);
+	}
+
 	trace_drv_change_sta_links(local, sdata, sta, old_links, new_links);
 	if (local->ops->change_sta_links)
 		ret = local->ops->change_sta_links(&local->hw, &sdata->vif, sta,
 						   old_links, new_links);
 	trace_drv_return_int(local, ret);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		link_sta = rcu_dereference_protected(info->link[link_id],
+						     lockdep_is_held(&local->sta_mtx));
+		ieee80211_link_sta_debugfs_drv_add(link_sta);
+	}
+
+	return 0;
 }
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 81e40b0a3b16..809bad53e15b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -480,6 +480,22 @@ static inline void drv_sta_add_debugfs(struct ieee80211_local *local,
 		local->ops->sta_add_debugfs(&local->hw, &sdata->vif,
 					    sta, dir);
 }
+
+static inline void drv_link_sta_add_debugfs(struct ieee80211_local *local,
+					    struct ieee80211_sub_if_data *sdata,
+					    struct ieee80211_link_sta *link_sta,
+					    struct dentry *dir)
+{
+	might_sleep();
+
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	if (local->ops->link_sta_add_debugfs)
+		local->ops->link_sta_add_debugfs(&local->hw, &sdata->vif,
+						 link_sta, dir);
+}
 #endif
 
 static inline void drv_sta_pre_rcu_remove(struct ieee80211_local *local,
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 71b1488bd390..e6beaea4075e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -366,6 +366,9 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 	if (unhash)
 		link_sta_info_hash_del(sta->local, link_sta);
 
+	if (test_sta_flag(sta, WLAN_STA_INSERTED))
+		ieee80211_link_sta_debugfs_remove(link_sta);
+
 	if (link_sta != &sta->deflink)
 		alloc = container_of(link_sta, typeof(*alloc), info);
 
@@ -875,6 +878,26 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 
 	ieee80211_sta_debugfs_add(sta);
 	rate_control_add_sta_debugfs(sta);
+	if (sta->sta.valid_links) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(sta->link); i++) {
+			struct link_sta_info *link_sta;
+
+			link_sta = rcu_dereference_protected(sta->link[i],
+							     lockdep_is_held(&local->sta_mtx));
+
+			if (!link_sta)
+				continue;
+
+			ieee80211_link_sta_debugfs_add(link_sta);
+			if (sdata->vif.active_links & BIT(i))
+				ieee80211_link_sta_debugfs_drv_add(link_sta);
+		}
+	} else {
+		ieee80211_link_sta_debugfs_add(&sta->deflink);
+		ieee80211_link_sta_debugfs_drv_add(&sta->deflink);
+	}
 
 	sinfo->generation = local->sta_generation;
 	cfg80211_new_sta(sdata->dev, sta->sta.addr, sinfo, GFP_KERNEL);
@@ -2824,6 +2847,8 @@ int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
 
 	sta_info_add_link(sta, link_id, &alloc->info, &alloc->sta);
 
+	ieee80211_link_sta_debugfs_add(&alloc->info);
+
 	return 0;
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 2517ea714dc4..6e672bf9c79d 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -513,6 +513,7 @@ struct ieee80211_fragment_cache {
  * @status_stats.avg_ack_signal: average ACK signal
  * @cur_max_bandwidth: maximum bandwidth to use for TX to the station,
  *	taken from HT/VHT capabilities or VHT operating mode notification
+ * @debugfs_dir: debug filesystem directory dentry
  * @pub: public (driver visible) link STA data
  * TODO Move other link params from sta_info as required for MLD operation
  */
@@ -560,6 +561,10 @@ struct link_sta_info {
 
 	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
 
+#ifdef CONFIG_MAC80211_DEBUGFS
+	struct dentry *debugfs_dir;
+#endif
+
 	struct ieee80211_link_sta *pub;
 };
 
-- 
2.37.3

