Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E372CAA6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjFLPvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjFLPve (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E6D10E2
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585092; x=1718121092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JUjHA71Ygj223GonPFPLj29FikON2qsAB+Ue8fJYJQY=;
  b=kihhKiAyor6Njo8xtJYaN09O1uvXVfLqTgLZbjVLvsvhgOOJUuNrdoNG
   LHI+rzLV5x4HDgya+UB/o6A+qRNB4+ISxVH+hrm690voD+Pj838Y8MrYT
   U4PeLpqvYUiDUTHW4PcbABF6dXK+/HSOyF/noOnvVtvAIy67aga42T+5A
   e7tVKBGtPVWRCgXW4aj9XdULFp3HdxhjxjW6dpUL18tpNAzNXFy5KJf47
   Hhy5nBKEZrKwtDqDTVa7KxcoADv/PO/LpzGoL2JtQIX94j9+ekBGK8/jK
   rEdzaJREbMF2n0AeQQtX3kogu9evcH3K4OQXtJ35amfI23NxPYXJ5DuBn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674168"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674168"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499234"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499234"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: make debugfs entries link specific
Date:   Mon, 12 Jun 2023 18:51:02 +0300
Message-Id: <20230612184434.a8e0c40d325e.I374d9433c3b8694667e1ce550d65f6f1f0d23c05@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

All of the station elements are really elements for the link. Create
them from the correct callback and return the link specific information
rather than always using the default link.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 198 ++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   9 +-
 6 files changed, 169 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 84a488538427..c037b2ad5fa1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -391,13 +391,14 @@ static ssize_t iwl_dbgfs_stations_read(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
 
-static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
+static ssize_t iwl_dbgfs_rs_data_read(struct ieee80211_link_sta *link_sta,
+				      struct iwl_mvm_sta *mvmsta,
+				      struct iwl_mvm *mvm,
+				      struct iwl_mvm_link_sta *mvm_link_sta,
+				      char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
-	struct ieee80211_sta *sta = file->private_data;
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
-	struct iwl_mvm *mvm = lq_sta->pers.drv;
+	struct iwl_lq_sta_rs_fw *lq_sta = &mvm_link_sta->lq_sta.rs_fw;
 	static const size_t bufsz = 2048;
 	char *buff;
 	int desc = 0;
@@ -407,8 +408,6 @@ static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
 	if (!buff)
 		return -ENOMEM;
 
-	mutex_lock(&mvm->mutex);
-
 	desc += scnprintf(buff + desc, bufsz - desc, "sta_id %d\n",
 			  lq_sta->pers.sta_id);
 	desc += scnprintf(buff + desc, bufsz - desc,
@@ -429,18 +428,19 @@ static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
 				     lq_sta->last_rate_n_flags);
 	if (desc < bufsz - 1)
 		buff[desc++] = '\n';
-	mutex_unlock(&mvm->mutex);
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
 	kfree(buff);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_sta *sta,
+static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_link_sta *link_sta,
+					 struct iwl_mvm_sta *mvmsta,
+					 struct iwl_mvm *mvm,
+					 struct iwl_mvm_link_sta *mvm_link_sta,
 					 char *buf, size_t count,
 					 loff_t *ppos)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	int i;
 	u16 amsdu_len;
 
@@ -448,36 +448,39 @@ static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_sta *sta,
 		return -EINVAL;
 
 	/* only change from debug set <-> debug unset */
-	if (amsdu_len && mvmsta->orig_amsdu_len)
+	if (amsdu_len && mvm_link_sta->orig_amsdu_len)
 		return -EBUSY;
 
 	if (amsdu_len) {
-		mvmsta->orig_amsdu_len = sta->cur->max_amsdu_len;
-		sta->deflink.agg.max_amsdu_len = amsdu_len;
-		sta->deflink.agg.max_amsdu_len = amsdu_len;
-		for (i = 0; i < ARRAY_SIZE(sta->deflink.agg.max_tid_amsdu_len); i++)
-			sta->deflink.agg.max_tid_amsdu_len[i] = amsdu_len;
+		mvm_link_sta->orig_amsdu_len = link_sta->agg.max_amsdu_len;
+		link_sta->agg.max_amsdu_len = amsdu_len;
+		link_sta->agg.max_amsdu_len = amsdu_len;
+		for (i = 0; i < ARRAY_SIZE(link_sta->agg.max_tid_amsdu_len); i++)
+			link_sta->agg.max_tid_amsdu_len[i] = amsdu_len;
 	} else {
-		sta->deflink.agg.max_amsdu_len = mvmsta->orig_amsdu_len;
-		mvmsta->orig_amsdu_len = 0;
+		link_sta->agg.max_amsdu_len = mvm_link_sta->orig_amsdu_len;
+		mvm_link_sta->orig_amsdu_len = 0;
 	}
 
+	ieee80211_sta_recalc_aggregates(link_sta->sta);
+
 	return count;
 }
 
-static ssize_t iwl_dbgfs_amsdu_len_read(struct file *file,
+static ssize_t iwl_dbgfs_amsdu_len_read(struct ieee80211_link_sta *link_sta,
+					struct iwl_mvm_sta *mvmsta,
+					struct iwl_mvm *mvm,
+					struct iwl_mvm_link_sta *mvm_link_sta,
 					char __user *user_buf,
 					size_t count, loff_t *ppos)
 {
-	struct ieee80211_sta *sta = file->private_data;
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
 	char buf[32];
 	int pos;
 
-	pos = scnprintf(buf, sizeof(buf), "current %d ", sta->cur->max_amsdu_len);
+	pos = scnprintf(buf, sizeof(buf), "current %d ",
+			link_sta->agg.max_amsdu_len);
 	pos += scnprintf(buf + pos, sizeof(buf) - pos, "stored %d\n",
-			 mvmsta->orig_amsdu_len);
+			 mvm_link_sta->orig_amsdu_len);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
@@ -1596,17 +1599,127 @@ static ssize_t iwl_dbgfs_dbg_time_point_write(struct iwl_mvm *mvm,
 #define MVM_DEBUGFS_ADD_FILE(name, parent, mode) \
 	MVM_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
 
-#define MVM_DEBUGFS_WRITE_STA_FILE_OPS(name, bufsz) \
-	_MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz, struct ieee80211_sta)
-#define MVM_DEBUGFS_READ_WRITE_STA_FILE_OPS(name, bufsz) \
-	_MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz, struct ieee80211_sta)
+static ssize_t
+_iwl_dbgfs_link_sta_wrap_write(ssize_t (*real)(struct ieee80211_link_sta *,
+					       struct iwl_mvm_sta *,
+					       struct iwl_mvm *,
+					       struct iwl_mvm_link_sta *,
+					       char *,
+					       size_t, loff_t *),
+			   struct file *file,
+			   char *buf, size_t buf_size, loff_t *ppos)
+{
+	struct ieee80211_link_sta *link_sta = file->private_data;
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(link_sta->sta);
+	struct iwl_mvm *mvm = iwl_mvm_vif_from_mac80211(mvmsta->vif)->mvm;
+	struct iwl_mvm_link_sta *mvm_link_sta;
+	ssize_t ret;
 
-#define MVM_DEBUGFS_ADD_STA_FILE_ALIAS(alias, name, parent, mode) do {	\
-		debugfs_create_file(alias, mode, parent, sta,		\
-				    &iwl_dbgfs_##name##_ops);		\
-	} while (0)
-#define MVM_DEBUGFS_ADD_STA_FILE(name, parent, mode) \
-	MVM_DEBUGFS_ADD_STA_FILE_ALIAS(#name, name, parent, mode)
+	mutex_lock(&mvm->mutex);
+
+	mvm_link_sta = rcu_dereference_protected(mvmsta->link[link_sta->link_id],
+						 lockdep_is_held(&mvm->mutex));
+	if (WARN_ON(!mvm_link_sta)) {
+		mutex_unlock(&mvm->mutex);
+		return -ENODEV;
+	}
+
+	ret = real(link_sta, mvmsta, mvm, mvm_link_sta, buf, buf_size, ppos);
+
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
+}
+
+static ssize_t
+_iwl_dbgfs_link_sta_wrap_read(ssize_t (*real)(struct ieee80211_link_sta *,
+					      struct iwl_mvm_sta *,
+					      struct iwl_mvm *,
+					      struct iwl_mvm_link_sta *,
+					      char __user *,
+					      size_t, loff_t *),
+			   struct file *file,
+			   char __user *user_buf, size_t count, loff_t *ppos)
+{
+	struct ieee80211_link_sta *link_sta = file->private_data;
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(link_sta->sta);
+	struct iwl_mvm *mvm = iwl_mvm_vif_from_mac80211(mvmsta->vif)->mvm;
+	struct iwl_mvm_link_sta *mvm_link_sta;
+	ssize_t ret;
+
+	mutex_lock(&mvm->mutex);
+
+	mvm_link_sta = rcu_dereference_protected(mvmsta->link[link_sta->link_id],
+						 lockdep_is_held(&mvm->mutex));
+	if (WARN_ON(!mvm_link_sta)) {
+		mutex_unlock(&mvm->mutex);
+		return -ENODEV;
+	}
+
+	ret = real(link_sta, mvmsta, mvm, mvm_link_sta, user_buf, count, ppos);
+
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
+}
+
+#define MVM_DEBUGFS_LINK_STA_WRITE_WRAPPER(name, buflen)		\
+static ssize_t _iwl_dbgfs_link_sta_##name##_write(struct file *file,	\
+					 const char __user *user_buf,	\
+					 size_t count, loff_t *ppos)	\
+{									\
+	char buf[buflen] = {};						\
+	size_t buf_size = min(count, sizeof(buf) -  1);			\
+									\
+	if (copy_from_user(buf, user_buf, sizeof(buf)))			\
+		return -EFAULT;						\
+									\
+	return _iwl_dbgfs_link_sta_wrap_write(iwl_dbgfs_##name##_write,	\
+					      file,			\
+					      buf, buf_size, ppos);	\
+}									\
+
+#define MVM_DEBUGFS_LINK_STA_READ_WRAPPER(name)		\
+static ssize_t _iwl_dbgfs_link_sta_##name##_read(struct file *file,	\
+					 char __user *user_buf,		\
+					 size_t count, loff_t *ppos)	\
+{									\
+	return _iwl_dbgfs_link_sta_wrap_read(iwl_dbgfs_##name##_read,	\
+					     file,			\
+					     user_buf, count, ppos);	\
+}									\
+
+#define MVM_DEBUGFS_WRITE_LINK_STA_FILE_OPS(name, bufsz)		\
+MVM_DEBUGFS_LINK_STA_WRITE_WRAPPER(name, bufsz)				\
+static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
+	.write = _iwl_dbgfs_link_sta_##name##_write,			\
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+}
+
+#define MVM_DEBUGFS_READ_LINK_STA_FILE_OPS(name)			\
+MVM_DEBUGFS_LINK_STA_READ_WRAPPER(name)					\
+static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
+	.read = _iwl_dbgfs_link_sta_##name##_read,			\
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+}
+
+#define MVM_DEBUGFS_READ_WRITE_LINK_STA_FILE_OPS(name, bufsz)		\
+MVM_DEBUGFS_LINK_STA_READ_WRAPPER(name)					\
+MVM_DEBUGFS_LINK_STA_WRITE_WRAPPER(name, bufsz)				\
+static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
+	.read = _iwl_dbgfs_link_sta_##name##_read,			\
+	.write = _iwl_dbgfs_link_sta_##name##_write,			\
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+}
+
+#define MVM_DEBUGFS_ADD_LINK_STA_FILE_ALIAS(alias, name, parent, mode)	\
+		debugfs_create_file(alias, mode, parent, link_sta,	\
+				    &iwl_dbgfs_link_sta_##name##_ops)
+#define MVM_DEBUGFS_ADD_LINK_STA_FILE(name, parent, mode) \
+	MVM_DEBUGFS_ADD_LINK_STA_FILE_ALIAS(#name, name, parent, mode)
 
 static ssize_t
 iwl_dbgfs_prph_reg_read(struct file *file,
@@ -1891,7 +2004,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(sram, 64);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(set_nic_temperature, 64);
 MVM_DEBUGFS_READ_FILE_OPS(nic_temp);
 MVM_DEBUGFS_READ_FILE_OPS(stations);
-MVM_DEBUGFS_READ_FILE_OPS(rs_data);
+MVM_DEBUGFS_READ_LINK_STA_FILE_OPS(rs_data);
 MVM_DEBUGFS_READ_FILE_OPS(bt_notif);
 MVM_DEBUGFS_READ_FILE_OPS(bt_cmd);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(disable_power_off, 64);
@@ -1921,7 +2034,7 @@ MVM_DEBUGFS_READ_FILE_OPS(sar_geo_profile);
 MVM_DEBUGFS_READ_FILE_OPS(wifi_6e_enable);
 #endif
 
-MVM_DEBUGFS_READ_WRITE_STA_FILE_OPS(amsdu_len, 16);
+MVM_DEBUGFS_READ_WRITE_LINK_STA_FILE_OPS(amsdu_len, 16);
 
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(he_sniffer_params, 32);
 
@@ -2068,17 +2181,18 @@ static const struct file_operations iwl_dbgfs_mem_ops = {
 	.llseek = default_llseek,
 };
 
-void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta,
-			     struct dentry *dir)
+void iwl_mvm_link_sta_add_debugfs(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_link_sta *link_sta,
+				  struct dentry *dir)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	if (iwl_mvm_has_tlc_offload(mvm)) {
-		MVM_DEBUGFS_ADD_STA_FILE(rs_data, dir, 0400);
+		MVM_DEBUGFS_ADD_LINK_STA_FILE(rs_data, dir, 0400);
 	}
-	MVM_DEBUGFS_ADD_STA_FILE(amsdu_len, dir, 0600);
+
+	MVM_DEBUGFS_ADD_LINK_STA_FILE(amsdu_len, dir, 0600);
 }
 
 void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 91c38d42d034..f8fd34305e69 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6255,7 +6255,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 
 	.can_aggregate_in_amsdu = iwl_mvm_mac_can_aggregate,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	.sta_add_debugfs = iwl_mvm_sta_add_debugfs,
+	.link_sta_add_debugfs = iwl_mvm_link_sta_add_debugfs,
 #endif
 	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index fb06cf94fcc3..5e28a1645aa9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1093,7 +1093,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.abort_pmsr = iwl_mvm_abort_pmsr,
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	.sta_add_debugfs = iwl_mvm_sta_add_debugfs,
+	.link_sta_add_debugfs = iwl_mvm_link_sta_add_debugfs,
 #endif
 	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7b5db55ebe92..90cb8eeec47c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2337,10 +2337,10 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm);
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm);
 void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta,
-			     struct dentry *dir);
+void iwl_mvm_link_sta_add_debugfs(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_link_sta *link_sta,
+				  struct dentry *dir);
 #endif
 
 /* new MLD related APIs */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index f72d1ca3cfed..e77b6157f759 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -478,7 +478,7 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 		IWL_DEBUG_RATE(mvm, "new rate: %s\n", pretty_rate);
 	}
 
-	if (flags & IWL_TLC_NOTIF_FLAG_AMSDU && !mvmsta->orig_amsdu_len) {
+	if (flags & IWL_TLC_NOTIF_FLAG_AMSDU && !mvm_link_sta->orig_amsdu_len) {
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
@@ -488,7 +488,7 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 			 * so also check with orig_amsdu_len which holds the
 			 * original data before debugfs changed the value
 			 */
-			WARN_ON(mvmsta->orig_amsdu_len < size);
+			WARN_ON(mvm_link_sta->orig_amsdu_len < size);
 			goto out;
 		}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 9acc01b7a4c9..7364346a1209 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -336,6 +336,9 @@ struct iwl_mvm_rxq_dup_data {
  * @sta_id: the index of the station in the fw
  * @lq_sta: holds rate scaling data, either for the case when RS is done in
  *	the driver - %rs_drv or in the FW - %rs_fw.
+ * @orig_amsdu_len: used to save the original amsdu_len when it is changed via
+ *      debugfs.  If it's set to 0, it means that it is it's not set via
+ *      debugfs.
  * @avg_energy: energy as reported by FW statistics notification
  */
 struct iwl_mvm_link_sta {
@@ -346,6 +349,8 @@ struct iwl_mvm_link_sta {
 		struct iwl_lq_sta rs_drv;
 	} lq_sta;
 
+	u16 orig_amsdu_len;
+
 	u8 avg_energy;
 };
 
@@ -375,9 +380,6 @@ struct iwl_mvm_link_sta {
  * @amsdu_enabled: bitmap of TX AMSDU allowed TIDs.
  *	In case TLC offload is not active it is either 0xFFFF or 0.
  * @max_amsdu_len: max AMSDU length
- * @orig_amsdu_len: used to save the original amsdu_len when it is changed via
- *      debugfs.  If it's set to 0, it means that it is it's not set via
- *      debugfs.
  * @agg_tids: bitmap of tids whose status is operational aggregated (IWL_AGG_ON)
  * @sleeping: sta sleep transitions in power management
  * @sleep_tx_count: the number of frames that we told the firmware to let out
@@ -429,7 +431,6 @@ struct iwl_mvm_sta {
 	bool disable_tx;
 	u16 amsdu_enabled;
 	u16 max_amsdu_len;
-	u16 orig_amsdu_len;
 	bool sleeping;
 	u8 agg_tids;
 	u8 sleep_tx_count;
-- 
2.38.1

