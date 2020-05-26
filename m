Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6401B57E5
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDWJOE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgDWJOE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 05:14:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2508C03C1AF
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 02:13:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jRXvh-00Emix-0t; Thu, 23 Apr 2020 11:13:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     sumit.garg@linaro.org, Johannes Berg <johannes.berg@intel.com>,
        Jouni Malinen <j@w1.fi>,
        kernel test robot <rong.a.chen@intel.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH] mac80211: populate debugfs only after cfg80211 init
Date:   Thu, 23 Apr 2020 11:13:49 +0200
Message-Id: <20200423111344.0e00d3346f12.Iadc76a03a55093d94391fc672e996a458702875d@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When fixing the initialization race, we neglected to account for
the fact that debugfs is initialized in wiphy_register(), and
some debugfs things went missing (or rather were rerooted to the
global debugfs root).

Fix this by adding debugfs entries only after wiphy_register().
This requires some changes in the rate control code since it
currently adds debugfs at alloc time, which can no longer be
done after the reordering.

Reported-by: Jouni Malinen <j@w1.fi>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Felix Fietkau <nbd@nbd.name>
Fixes: 52e04b4ce5d0 ("mac80211: fix race in ieee80211_register_hw()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-rs.c |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  2 +-
 drivers/net/wireless/realtek/rtlwifi/rc.c     |  2 +-
 include/net/mac80211.h                        |  4 +++-
 net/mac80211/main.c                           |  5 ++--
 net/mac80211/rate.c                           | 15 ++++--------
 net/mac80211/rate.h                           | 23 +++++++++++++++++++
 net/mac80211/rc80211_minstrel_ht.c            | 19 ++++++++++-----
 10 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 6209f85a71dd..0af9e997c9f6 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -374,7 +374,7 @@ il3945_rs_rate_init(struct il_priv *il, struct ieee80211_sta *sta, u8 sta_id)
 }
 
 static void *
-il3945_rs_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
+il3945_rs_alloc(struct ieee80211_hw *hw)
 {
 	return hw->priv;
 }
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 7c6e2c863497..0a02d8aca320 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2474,7 +2474,7 @@ il4965_rs_fill_link_cmd(struct il_priv *il, struct il_lq_sta *lq_sta,
 }
 
 static void *
-il4965_rs_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
+il4965_rs_alloc(struct ieee80211_hw *hw)
 {
 	return hw->priv;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 226165db7dfd..dac809df7f1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -3019,7 +3019,7 @@ static void rs_fill_link_cmd(struct iwl_priv *priv,
 			cpu_to_le16(priv->lib->bt_params->agg_time_limit);
 }
 
-static void *rs_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
+static void *rs_alloc(struct ieee80211_hw *hw)
 {
 	return hw->priv;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index c1aba2bf73cf..00e7fdbaeb7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3665,7 +3665,7 @@ static void rs_fill_lq_cmd(struct iwl_mvm *mvm,
 			cpu_to_le16(iwl_mvm_coex_agg_time_limit(mvm, sta));
 }
 
-static void *rs_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
+static void *rs_alloc(struct ieee80211_hw *hw)
 {
 	return hw->priv;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rc.c b/drivers/net/wireless/realtek/rtlwifi/rc.c
index 0c7d74902d33..4b5ea0ec9109 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rc.c
@@ -261,7 +261,7 @@ static void rtl_rate_update(void *ppriv,
 {
 }
 
-static void *rtl_rate_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
+static void *rtl_rate_alloc(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	return rtlpriv;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b6b4de0e4b5e..97fec4d310ac 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6007,7 +6007,9 @@ enum rate_control_capabilities {
 struct rate_control_ops {
 	unsigned long capa;
 	const char *name;
-	void *(*alloc)(struct ieee80211_hw *hw, struct dentry *debugfsdir);
+	void *(*alloc)(struct ieee80211_hw *hw);
+	void (*add_debugfs)(struct ieee80211_hw *hw, void *priv,
+			    struct dentry *debugfsdir);
 	void (*free)(void *priv);
 
 	void *(*alloc_sta)(void *priv, struct ieee80211_sta *sta, gfp_t gfp);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0e9ad60fb2b3..6423173bb87e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1183,8 +1183,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	local->tx_headroom = max_t(unsigned int , local->hw.extra_tx_headroom,
 				   IEEE80211_TX_STATUS_HEADROOM);
 
-	debugfs_hw_add(local);
-
 	/*
 	 * if the driver doesn't specify a max listen interval we
 	 * use 5 which should be a safe default
@@ -1273,6 +1271,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	if (result < 0)
 		goto fail_wiphy_register;
 
+	debugfs_hw_add(local);
+	rate_control_add_debugfs(local);
+
 	rtnl_lock();
 
 	/* add one default STA interface if supported */
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index a1e9fc7878aa..b051f125d3af 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -214,17 +214,16 @@ static ssize_t rcname_read(struct file *file, char __user *userbuf,
 				       ref->ops->name, len);
 }
 
-static const struct file_operations rcname_ops = {
+const struct file_operations rcname_ops = {
 	.read = rcname_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 #endif
 
-static struct rate_control_ref *rate_control_alloc(const char *name,
-					    struct ieee80211_local *local)
+static struct rate_control_ref *
+rate_control_alloc(const char *name, struct ieee80211_local *local)
 {
-	struct dentry *debugfsdir = NULL;
 	struct rate_control_ref *ref;
 
 	ref = kmalloc(sizeof(struct rate_control_ref), GFP_KERNEL);
@@ -234,13 +233,7 @@ static struct rate_control_ref *rate_control_alloc(const char *name,
 	if (!ref->ops)
 		goto free;
 
-#ifdef CONFIG_MAC80211_DEBUGFS
-	debugfsdir = debugfs_create_dir("rc", local->hw.wiphy->debugfsdir);
-	local->debugfs.rcdir = debugfsdir;
-	debugfs_create_file("name", 0400, debugfsdir, ref, &rcname_ops);
-#endif
-
-	ref->priv = ref->ops->alloc(&local->hw, debugfsdir);
+	ref->priv = ref->ops->alloc(&local->hw);
 	if (!ref->priv)
 		goto free;
 	return ref;
diff --git a/net/mac80211/rate.h b/net/mac80211/rate.h
index 5397c6dad056..79b44d3db171 100644
--- a/net/mac80211/rate.h
+++ b/net/mac80211/rate.h
@@ -60,6 +60,29 @@ static inline void rate_control_add_sta_debugfs(struct sta_info *sta)
 #endif
 }
 
+extern const struct file_operations rcname_ops;
+
+static inline void rate_control_add_debugfs(struct ieee80211_local *local)
+{
+#ifdef CONFIG_MAC80211_DEBUGFS
+	struct dentry *debugfsdir;
+
+	if (!local->rate_ctrl)
+		return;
+
+	if (!local->rate_ctrl->ops->add_debugfs)
+		return;
+
+	debugfsdir = debugfs_create_dir("rc", local->hw.wiphy->debugfsdir);
+	local->debugfs.rcdir = debugfsdir;
+	debugfs_create_file("name", 0400, debugfsdir,
+			    local->rate_ctrl, &rcname_ops);
+
+	local->rate_ctrl->ops->add_debugfs(&local->hw, local->rate_ctrl->priv,
+					   debugfsdir);
+#endif
+}
+
 void ieee80211_check_rate_mask(struct ieee80211_sub_if_data *sdata);
 
 /* Get a reference to the rate control algorithm. If `name' is NULL, get the
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 694a31978a04..5dc3e5bc4e64 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1635,7 +1635,7 @@ minstrel_ht_init_cck_rates(struct minstrel_priv *mp)
 }
 
 static void *
-minstrel_ht_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
+minstrel_ht_alloc(struct ieee80211_hw *hw)
 {
 	struct minstrel_priv *mp;
 
@@ -1673,7 +1673,17 @@ minstrel_ht_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
 	mp->update_interval = HZ / 10;
 	mp->new_avg = true;
 
+	minstrel_ht_init_cck_rates(mp);
+
+	return mp;
+}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
+static void minstrel_ht_add_debugfs(struct ieee80211_hw *hw, void *priv,
+				    struct dentry *debugfsdir)
+{
+	struct minstrel_priv *mp = priv;
+
 	mp->fixed_rate_idx = (u32) -1;
 	debugfs_create_u32("fixed_rate_idx", S_IRUGO | S_IWUGO, debugfsdir,
 			   &mp->fixed_rate_idx);
@@ -1681,12 +1691,8 @@ minstrel_ht_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
 			   &mp->sample_switch);
 	debugfs_create_bool("new_avg", S_IRUGO | S_IWUSR, debugfsdir,
 			   &mp->new_avg);
-#endif
-
-	minstrel_ht_init_cck_rates(mp);
-
-	return mp;
 }
+#endif
 
 static void
 minstrel_ht_free(void *priv)
@@ -1725,6 +1731,7 @@ static const struct rate_control_ops mac80211_minstrel_ht = {
 	.alloc = minstrel_ht_alloc,
 	.free = minstrel_ht_free,
 #ifdef CONFIG_MAC80211_DEBUGFS
+	.add_debugfs = minstrel_ht_add_debugfs,
 	.add_sta_debugfs = minstrel_ht_add_sta_debugfs,
 #endif
 	.get_expected_throughput = minstrel_ht_get_expected_throughput,
-- 
2.25.1

