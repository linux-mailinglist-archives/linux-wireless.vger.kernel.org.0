Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7AD6A6A9B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCAKLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCAKKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06813B847
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665443; x=1709201443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LAJhdzpvhJEtnlvmwFw5KXyrkXvWdItXZBwJAg+XZ8E=;
  b=EzSOcg6GnlY/838mXRNas2WuDOOGQWk/fhms5PMiqKStD5y68bOUwXte
   oIKawD2VVy3sWsdji2683ubViNNsrKHkeiTkAHkmEuBfsWBhLf1m8ropV
   rcw04U4/F5VNPFuLxrvbAVfi2uiUwuWp+8nOBTN8mqRNXZqapHEyDW3N4
   Gj0SAtYJUplkmaf7vIEoDE1ngEE+jcfFZvApw7qodiX3zBvTKgm47C+sA
   6DHGyS0+a1YStSYYZo9FskX5sECO2p67bHdQ+BaVbjWvCbt33AmFw3FuL
   wkHidlOdG4yYaPtgv6U1rRNRZPEUQAV3bQHNe9PmCvwgC8sLaqxXV5/9h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662908"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662908"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589191"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589191"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:38 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 15/23] wifi: mac80211: add netdev per-link debugfs data and driver hook
Date:   Wed,  1 Mar 2023 12:09:27 +0200
Message-Id: <20230301115906.fb4c947e4df8.I69b3516ddf4c8a7501b395f652d6063444ecad63@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

This adds the infrastructure to have netdev specific per-link data both
for mac80211 and the driver in debugfs. For the driver, a new callback
is added which is only used if MLO is supported.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h        |  10 ++
 net/mac80211/debugfs_netdev.c | 222 +++++++++++++++++++++++++---------
 net/mac80211/debugfs_netdev.h |  16 +++
 net/mac80211/driver-ops.c     |  25 +++-
 net/mac80211/driver-ops.h     |  16 +++
 net/mac80211/ieee80211_i.h    |   4 +
 net/mac80211/link.c           |   4 +
 7 files changed, 242 insertions(+), 55 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2a1874d994e0..5df9eb828a58 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3844,6 +3844,12 @@ struct ieee80211_prep_tx_info {
  *	the station. See @sta_pre_rcu_remove if needed.
  *	This callback can sleep.
  *
+ * @link_add_debugfs: Drivers can use this callback to add debugfs files
+ *	when a link is added to a mac80211 vif. This callback should be within
+ *	a CONFIG_MAC80211_DEBUGFS conditional. This callback can sleep.
+ *	For non-MLO the callback will be called once for the default bss_conf
+ *	with the vif's directory rather than a separate subdirectory.
+ *
  * @sta_add_debugfs: Drivers can use this callback to add debugfs files
  *	when a station is added to mac80211's station list. This callback
  *	should be within a CONFIG_MAC80211_DEBUGFS conditional. This
@@ -4325,6 +4331,10 @@ struct ieee80211_ops {
 	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta);
 #ifdef CONFIG_MAC80211_DEBUGFS
+	void (*link_add_debugfs)(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *link_conf,
+				 struct dentry *dir);
 	void (*sta_add_debugfs)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 187bb22c0bbd..b0cef37eb394 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -23,16 +23,16 @@
 #include "driver-ops.h"
 
 static ssize_t ieee80211_if_read(
-	struct ieee80211_sub_if_data *sdata,
+	void *data,
 	char __user *userbuf,
 	size_t count, loff_t *ppos,
-	ssize_t (*format)(const struct ieee80211_sub_if_data *, char *, int))
+	ssize_t (*format)(const void *, char *, int))
 {
 	char buf[200];
 	ssize_t ret = -EINVAL;
 
 	read_lock(&dev_base_lock);
-	ret = (*format)(sdata, buf, sizeof(buf));
+	ret = (*format)(data, buf, sizeof(buf));
 	read_unlock(&dev_base_lock);
 
 	if (ret >= 0)
@@ -42,10 +42,10 @@ static ssize_t ieee80211_if_read(
 }
 
 static ssize_t ieee80211_if_write(
-	struct ieee80211_sub_if_data *sdata,
+	void *data,
 	const char __user *userbuf,
 	size_t count, loff_t *ppos,
-	ssize_t (*write)(struct ieee80211_sub_if_data *, const char *, int))
+	ssize_t (*write)(void *, const char *, int))
 {
 	char buf[64];
 	ssize_t ret;
@@ -58,64 +58,64 @@ static ssize_t ieee80211_if_write(
 	buf[count] = '\0';
 
 	rtnl_lock();
-	ret = (*write)(sdata, buf, count);
+	ret = (*write)(data, buf, count);
 	rtnl_unlock();
 
 	return ret;
 }
 
-#define IEEE80211_IF_FMT(name, field, format_string)			\
+#define IEEE80211_IF_FMT(name, type, field, format_string)		\
 static ssize_t ieee80211_if_fmt_##name(					\
-	const struct ieee80211_sub_if_data *sdata, char *buf,		\
+	const type *data, char *buf,					\
 	int buflen)							\
 {									\
-	return scnprintf(buf, buflen, format_string, sdata->field);	\
+	return scnprintf(buf, buflen, format_string, data->field);	\
 }
-#define IEEE80211_IF_FMT_DEC(name, field)				\
-		IEEE80211_IF_FMT(name, field, "%d\n")
-#define IEEE80211_IF_FMT_HEX(name, field)				\
-		IEEE80211_IF_FMT(name, field, "%#x\n")
-#define IEEE80211_IF_FMT_LHEX(name, field)				\
-		IEEE80211_IF_FMT(name, field, "%#lx\n")
+#define IEEE80211_IF_FMT_DEC(name, type, field)				\
+		IEEE80211_IF_FMT(name, type, field, "%d\n")
+#define IEEE80211_IF_FMT_HEX(name, type, field)				\
+		IEEE80211_IF_FMT(name, type, field, "%#x\n")
+#define IEEE80211_IF_FMT_LHEX(name, type, field)			\
+		IEEE80211_IF_FMT(name, type, field, "%#lx\n")
 
-#define IEEE80211_IF_FMT_HEXARRAY(name, field)				\
+#define IEEE80211_IF_FMT_HEXARRAY(name, type, field)			\
 static ssize_t ieee80211_if_fmt_##name(					\
-	const struct ieee80211_sub_if_data *sdata,			\
+	const type *data,						\
 	char *buf, int buflen)						\
 {									\
 	char *p = buf;							\
 	int i;								\
-	for (i = 0; i < sizeof(sdata->field); i++) {			\
+	for (i = 0; i < sizeof(data->field); i++) {			\
 		p += scnprintf(p, buflen + buf - p, "%.2x ",		\
-				 sdata->field[i]);			\
+				 data->field[i]);			\
 	}								\
 	p += scnprintf(p, buflen + buf - p, "\n");			\
 	return p - buf;							\
 }
 
-#define IEEE80211_IF_FMT_ATOMIC(name, field)				\
+#define IEEE80211_IF_FMT_ATOMIC(name, type, field)			\
 static ssize_t ieee80211_if_fmt_##name(					\
-	const struct ieee80211_sub_if_data *sdata,			\
+	const type *data,						\
 	char *buf, int buflen)						\
 {									\
-	return scnprintf(buf, buflen, "%d\n", atomic_read(&sdata->field));\
+	return scnprintf(buf, buflen, "%d\n", atomic_read(&data->field));\
 }
 
-#define IEEE80211_IF_FMT_MAC(name, field)				\
+#define IEEE80211_IF_FMT_MAC(name, type, field)				\
 static ssize_t ieee80211_if_fmt_##name(					\
-	const struct ieee80211_sub_if_data *sdata, char *buf,		\
+	const type *data, char *buf,					\
 	int buflen)							\
 {									\
-	return scnprintf(buf, buflen, "%pM\n", sdata->field);		\
+	return scnprintf(buf, buflen, "%pM\n", data->field);		\
 }
 
-#define IEEE80211_IF_FMT_JIFFIES_TO_MS(name, field)			\
+#define IEEE80211_IF_FMT_JIFFIES_TO_MS(name, type, field)		\
 static ssize_t ieee80211_if_fmt_##name(					\
-	const struct ieee80211_sub_if_data *sdata,			\
+	const type *data,						\
 	char *buf, int buflen)						\
 {									\
 	return scnprintf(buf, buflen, "%d\n",				\
-			 jiffies_to_msecs(sdata->field));		\
+			 jiffies_to_msecs(data->field));		\
 }
 
 #define _IEEE80211_IF_FILE_OPS(name, _read, _write)			\
@@ -126,43 +126,67 @@ static const struct file_operations name##_ops = {			\
 	.llseek = generic_file_llseek,					\
 }
 
-#define _IEEE80211_IF_FILE_R_FN(name)					\
+#define _IEEE80211_IF_FILE_R_FN(name, type)				\
 static ssize_t ieee80211_if_read_##name(struct file *file,		\
 					char __user *userbuf,		\
 					size_t count, loff_t *ppos)	\
 {									\
+	ssize_t (*fn)(const void *, char *, int) = (void *)		\
+		((ssize_t (*)(const type, char *, int))			\
+		 ieee80211_if_fmt_##name);				\
 	return ieee80211_if_read(file->private_data,			\
-				 userbuf, count, ppos,			\
-				 ieee80211_if_fmt_##name);		\
+				 userbuf, count, ppos, fn);		\
 }
 
-#define _IEEE80211_IF_FILE_W_FN(name)					\
+#define _IEEE80211_IF_FILE_W_FN(name, type)				\
 static ssize_t ieee80211_if_write_##name(struct file *file,		\
 					 const char __user *userbuf,	\
 					 size_t count, loff_t *ppos)	\
 {									\
+	ssize_t (*fn)(void *, const char *, int) = (void *)		\
+		((ssize_t (*)(type, const char *, int))			\
+		 ieee80211_if_parse_##name);				\
 	return ieee80211_if_write(file->private_data, userbuf, count,	\
-				  ppos, ieee80211_if_parse_##name);	\
+				  ppos, fn);				\
 }
 
 #define IEEE80211_IF_FILE_R(name)					\
-	_IEEE80211_IF_FILE_R_FN(name)					\
+	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_sub_if_data *)	\
 	_IEEE80211_IF_FILE_OPS(name, ieee80211_if_read_##name, NULL)
 
 #define IEEE80211_IF_FILE_W(name)					\
-	_IEEE80211_IF_FILE_W_FN(name)					\
+	_IEEE80211_IF_FILE_W_FN(name, struct ieee80211_sub_if_data *)	\
 	_IEEE80211_IF_FILE_OPS(name, NULL, ieee80211_if_write_##name)
 
 #define IEEE80211_IF_FILE_RW(name)					\
-	_IEEE80211_IF_FILE_R_FN(name)					\
-	_IEEE80211_IF_FILE_W_FN(name)					\
+	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_sub_if_data *)	\
+	_IEEE80211_IF_FILE_W_FN(name, struct ieee80211_sub_if_data *)	\
 	_IEEE80211_IF_FILE_OPS(name, ieee80211_if_read_##name,		\
 			       ieee80211_if_write_##name)
 
 #define IEEE80211_IF_FILE(name, field, format)				\
-	IEEE80211_IF_FMT_##format(name, field)				\
+	IEEE80211_IF_FMT_##format(name, struct ieee80211_sub_if_data, field) \
 	IEEE80211_IF_FILE_R(name)
 
+/* Same but with a link_ prefix in the ops variable name and different type */
+#define IEEE80211_IF_LINK_FILE_R(name)					\
+	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_link_data *)	\
+	_IEEE80211_IF_FILE_OPS(link_##name, ieee80211_if_read_##name, NULL)
+
+#define IEEE80211_IF_LINK_FILE_W(name)					\
+	_IEEE80211_IF_FILE_W_FN(name)					\
+	_IEEE80211_IF_FILE_OPS(link_##name, NULL, ieee80211_if_write_##name)
+
+#define IEEE80211_IF_LINK_FILE_RW(name)					\
+	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_link_data *)	\
+	_IEEE80211_IF_FILE_W_FN(name, struct ieee80211_link_data *)	\
+	_IEEE80211_IF_FILE_OPS(link_##name, ieee80211_if_read_##name,	\
+			       ieee80211_if_write_##name)
+
+#define IEEE80211_IF_LINK_FILE(name, field, format)				\
+	IEEE80211_IF_FMT_##format(name, struct ieee80211_link_data, field) \
+	IEEE80211_IF_LINK_FILE_R(name)
+
 /* common attributes */
 IEEE80211_IF_FILE(rc_rateidx_mask_2ghz, rc_rateidx_mask[NL80211_BAND_2GHZ],
 		  HEX);
@@ -207,9 +231,9 @@ IEEE80211_IF_FILE_R(rc_rateidx_vht_mcs_mask_5ghz);
 
 IEEE80211_IF_FILE(flags, flags, HEX);
 IEEE80211_IF_FILE(state, state, LHEX);
-IEEE80211_IF_FILE(txpower, vif.bss_conf.txpower, DEC);
-IEEE80211_IF_FILE(ap_power_level, deflink.ap_power_level, DEC);
-IEEE80211_IF_FILE(user_power_level, deflink.user_power_level, DEC);
+IEEE80211_IF_LINK_FILE(txpower, conf->txpower, DEC);
+IEEE80211_IF_LINK_FILE(ap_power_level, ap_power_level, DEC);
+IEEE80211_IF_LINK_FILE(user_power_level, user_power_level, DEC);
 
 static ssize_t
 ieee80211_if_fmt_hw_queues(const struct ieee80211_sub_if_data *sdata,
@@ -236,9 +260,10 @@ IEEE80211_IF_FILE(bssid, deflink.u.mgd.bssid, MAC);
 IEEE80211_IF_FILE(aid, vif.cfg.aid, DEC);
 IEEE80211_IF_FILE(beacon_timeout, u.mgd.beacon_timeout, JIFFIES_TO_MS);
 
-static int ieee80211_set_smps(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_smps(struct ieee80211_link_data *link,
 			      enum ieee80211_smps_mode smps_mode)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	int err;
 
@@ -256,7 +281,7 @@ static int ieee80211_set_smps(struct ieee80211_sub_if_data *sdata,
 		return -EOPNOTSUPP;
 
 	sdata_lock(sdata);
-	err = __ieee80211_request_smps_mgd(sdata, &sdata->deflink, smps_mode);
+	err = __ieee80211_request_smps_mgd(link->sdata, link, smps_mode);
 	sdata_unlock(sdata);
 
 	return err;
@@ -269,24 +294,24 @@ static const char *smps_modes[IEEE80211_SMPS_NUM_MODES] = {
 	[IEEE80211_SMPS_DYNAMIC] = "dynamic",
 };
 
-static ssize_t ieee80211_if_fmt_smps(const struct ieee80211_sub_if_data *sdata,
+static ssize_t ieee80211_if_fmt_smps(const struct ieee80211_link_data *link,
 				     char *buf, int buflen)
 {
-	if (sdata->vif.type == NL80211_IFTYPE_STATION)
+	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
 		return snprintf(buf, buflen, "request: %s\nused: %s\n",
-				smps_modes[sdata->deflink.u.mgd.req_smps],
-				smps_modes[sdata->deflink.smps_mode]);
+				smps_modes[link->u.mgd.req_smps],
+				smps_modes[link->smps_mode]);
 	return -EINVAL;
 }
 
-static ssize_t ieee80211_if_parse_smps(struct ieee80211_sub_if_data *sdata,
+static ssize_t ieee80211_if_parse_smps(struct ieee80211_link_data *link,
 				       const char *buf, int buflen)
 {
 	enum ieee80211_smps_mode mode;
 
 	for (mode = 0; mode < IEEE80211_SMPS_NUM_MODES; mode++) {
 		if (strncmp(buf, smps_modes[mode], buflen) == 0) {
-			int err = ieee80211_set_smps(sdata, mode);
+			int err = ieee80211_set_smps(link, mode);
 			if (!err)
 				return buflen;
 			return err;
@@ -295,7 +320,7 @@ static ssize_t ieee80211_if_parse_smps(struct ieee80211_sub_if_data *sdata,
 
 	return -EINVAL;
 }
-IEEE80211_IF_FILE_RW(smps);
+IEEE80211_IF_LINK_FILE_RW(smps);
 
 static ssize_t ieee80211_if_parse_tkip_mic_test(
 	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
@@ -595,6 +620,8 @@ static ssize_t ieee80211_if_parse_active_links(struct ieee80211_sub_if_data *sda
 }
 IEEE80211_IF_FILE_RW(active_links);
 
+IEEE80211_IF_LINK_FILE(addr, conf->addr, MAC);
+
 #ifdef CONFIG_MAC80211_MESH
 IEEE80211_IF_FILE(estab_plinks, u.mesh.estab_plinks, ATOMIC);
 
@@ -685,7 +712,6 @@ static void add_sta_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD(bssid);
 	DEBUGFS_ADD(aid);
 	DEBUGFS_ADD(beacon_timeout);
-	DEBUGFS_ADD_MODE(smps, 0600);
 	DEBUGFS_ADD_MODE(tkip_mic_test, 0200);
 	DEBUGFS_ADD_MODE(beacon_loss, 0200);
 	DEBUGFS_ADD_MODE(uapsd_queues, 0600);
@@ -788,9 +814,6 @@ static void add_files(struct ieee80211_sub_if_data *sdata)
 
 	DEBUGFS_ADD(flags);
 	DEBUGFS_ADD(state);
-	DEBUGFS_ADD(txpower);
-	DEBUGFS_ADD(user_power_level);
-	DEBUGFS_ADD(ap_power_level);
 
 	if (sdata->vif.type != NL80211_IFTYPE_MONITOR)
 		add_common_files(sdata);
@@ -820,6 +843,31 @@ static void add_files(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
+#undef DEBUGFS_ADD_MODE
+#undef DEBUGFS_ADD
+
+#define DEBUGFS_ADD_MODE(dentry, name, mode) \
+	debugfs_create_file(#name, mode, dentry, \
+			    link, &link_##name##_ops)
+
+#define DEBUGFS_ADD(dentry, name) DEBUGFS_ADD_MODE(dentry, name, 0400)
+
+static void add_link_files(struct ieee80211_link_data *link,
+			   struct dentry *dentry)
+{
+	DEBUGFS_ADD(dentry, txpower);
+	DEBUGFS_ADD(dentry, user_power_level);
+	DEBUGFS_ADD(dentry, ap_power_level);
+
+	switch (link->sdata->vif.type) {
+	case NL80211_IFTYPE_STATION:
+		DEBUGFS_ADD_MODE(dentry, smps, 0600);
+		break;
+	default:
+		break;
+	}
+}
+
 void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata)
 {
 	char buf[10+IFNAMSIZ];
@@ -830,6 +878,9 @@ void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata)
 	sdata->debugfs.subdir_stations = debugfs_create_dir("stations",
 							sdata->vif.debugfs_dir);
 	add_files(sdata);
+
+	if (!(sdata->local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
+		add_link_files(&sdata->deflink, sdata->vif.debugfs_dir);
 }
 
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
@@ -855,3 +906,66 @@ void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata)
 	sprintf(buf, "netdev:%s", sdata->name);
 	debugfs_rename(dir->d_parent, dir, dir->d_parent, buf);
 }
+
+void ieee80211_link_debugfs_add(struct ieee80211_link_data *link)
+{
+	char link_dir_name[10];
+
+	if (WARN_ON(!link->sdata->vif.debugfs_dir))
+		return;
+
+	/* For now, this should not be called for non-MLO capable drivers */
+	if (WARN_ON(!(link->sdata->local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)))
+		return;
+
+	snprintf(link_dir_name, sizeof(link_dir_name),
+		 "link-%d", link->link_id);
+
+	link->debugfs_dir =
+		debugfs_create_dir(link_dir_name,
+				   link->sdata->vif.debugfs_dir);
+
+	DEBUGFS_ADD(link->debugfs_dir, addr);
+	add_link_files(link, link->debugfs_dir);
+}
+
+void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link)
+{
+	if (!link->sdata->vif.debugfs_dir || !link->debugfs_dir) {
+		link->debugfs_dir = NULL;
+		return;
+	}
+
+	if (link->debugfs_dir == link->sdata->vif.debugfs_dir) {
+		WARN_ON(link != &link->sdata->deflink);
+		link->debugfs_dir = NULL;
+		return;
+	}
+
+	debugfs_remove_recursive(link->debugfs_dir);
+	link->debugfs_dir = NULL;
+}
+
+void ieee80211_link_debugfs_drv_add(struct ieee80211_link_data *link)
+{
+	if (WARN_ON(!link->debugfs_dir))
+		return;
+
+	drv_link_add_debugfs(link->sdata->local, link->sdata,
+			     link->conf, link->debugfs_dir);
+}
+
+void ieee80211_link_debugfs_drv_remove(struct ieee80211_link_data *link)
+{
+	if (!link || !link->debugfs_dir)
+		return;
+
+	if (WARN_ON(link->debugfs_dir == link->sdata->vif.debugfs_dir))
+		return;
+
+	/* Recreate the directory excluding the driver data */
+	debugfs_remove_recursive(link->debugfs_dir);
+	link->debugfs_dir = NULL;
+
+	ieee80211_link_debugfs_add(link);
+}
diff --git a/net/mac80211/debugfs_netdev.h b/net/mac80211/debugfs_netdev.h
index a7e9d8d518f9..99e688dcabd6 100644
--- a/net/mac80211/debugfs_netdev.h
+++ b/net/mac80211/debugfs_netdev.h
@@ -10,6 +10,12 @@
 void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata);
+
+void ieee80211_link_debugfs_add(struct ieee80211_link_data *link);
+void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link);
+
+void ieee80211_link_debugfs_drv_add(struct ieee80211_link_data *link);
+void ieee80211_link_debugfs_drv_remove(struct ieee80211_link_data *link);
 #else
 static inline void ieee80211_debugfs_add_netdev(
 	struct ieee80211_sub_if_data *sdata)
@@ -20,6 +26,16 @@ static inline void ieee80211_debugfs_remove_netdev(
 static inline void ieee80211_debugfs_rename_netdev(
 	struct ieee80211_sub_if_data *sdata)
 {}
+
+static inline void ieee80211_link_debugfs_add(struct ieee80211_link_data *link)
+{}
+static inline void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link)
+{}
+
+static inline void ieee80211_link_debugfs_drv_add(struct ieee80211_link_data *link)
+{}
+static inline void ieee80211_link_debugfs_drv_remove(struct ieee80211_link_data *link)
+{}
 #endif
 
 #endif /* __IEEE80211_DEBUGFS_NETDEV_H */
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index cfb09e4aed4d..30cd0c905a24 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -8,6 +8,7 @@
 #include "trace.h"
 #include "driver-ops.h"
 #include "debugfs_sta.h"
+#include "debugfs_netdev.h"
 
 int drv_start(struct ieee80211_local *local)
 {
@@ -477,6 +478,10 @@ int drv_change_vif_links(struct ieee80211_local *local,
 			 u16 old_links, u16 new_links,
 			 struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
 {
+	struct ieee80211_link_data *link;
+	unsigned long links_to_add;
+	unsigned long links_to_rem;
+	unsigned int link_id;
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
@@ -487,13 +492,31 @@ int drv_change_vif_links(struct ieee80211_local *local,
 	if (old_links == new_links)
 		return 0;
 
+	links_to_add = ~old_links & new_links;
+	links_to_rem = old_links & ~new_links;
+
+	for_each_set_bit(link_id, &links_to_rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		link = rcu_access_pointer(sdata->link[link_id]);
+
+		ieee80211_link_debugfs_drv_remove(link);
+	}
+
 	trace_drv_change_vif_links(local, sdata, old_links, new_links);
 	if (local->ops->change_vif_links)
 		ret = local->ops->change_vif_links(&local->hw, &sdata->vif,
 						   old_links, new_links, old);
 	trace_drv_return_int(local, ret);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		link = rcu_access_pointer(sdata->link[link_id]);
+
+		ieee80211_link_debugfs_drv_add(link);
+	}
+
+	return 0;
 }
 
 int drv_change_sta_links(struct ieee80211_local *local,
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 5d13a3dfd366..a68d606e6987 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -465,6 +465,22 @@ static inline void drv_sta_remove(struct ieee80211_local *local,
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
+static inline void drv_link_add_debugfs(struct ieee80211_local *local,
+					struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_bss_conf *link_conf,
+					struct dentry *dir)
+{
+	might_sleep();
+
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	if (local->ops->link_add_debugfs)
+		local->ops->link_add_debugfs(&local->hw, &sdata->vif,
+					     link_conf, dir);
+}
+
 static inline void drv_sta_add_debugfs(struct ieee80211_local *local,
 				       struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_sta *sta,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ecc232eb1ee8..3d4edc25a69e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -999,6 +999,10 @@ struct ieee80211_link_data {
 	struct ieee80211_tx_queue_params tx_conf[IEEE80211_NUM_ACS];
 
 	struct ieee80211_bss_conf *conf;
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+	struct dentry *debugfs_dir;
+#endif
 };
 
 struct ieee80211_sub_if_data {
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index e6f9fce1dadb..e82db88a47f8 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -10,6 +10,7 @@
 #include "ieee80211_i.h"
 #include "driver-ops.h"
 #include "key.h"
+#include "debugfs_netdev.h"
 
 void ieee80211_link_setup(struct ieee80211_link_data *link)
 {
@@ -61,6 +62,8 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 		default:
 			WARN_ON(1);
 		}
+
+		ieee80211_link_debugfs_add(link);
 	}
 }
 
@@ -94,6 +97,7 @@ static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 		if (WARN_ON(!link))
 			continue;
 		ieee80211_remove_link_keys(link, &keys);
+		ieee80211_link_debugfs_remove(link);
 		ieee80211_link_stop(link);
 	}
 
-- 
2.38.1

