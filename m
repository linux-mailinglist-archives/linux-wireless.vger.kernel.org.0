Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BE072CAA7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjFLPvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbjFLPvf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B3CA
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585094; x=1718121094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1RsE6mh63V1wDjoPllwd0vZJtt7grmzr24oyOp06vA=;
  b=lJtc1C7GhmsiwUzJiVMbUqpxNaYB0oddojALdJDPv9uXHr9rs5m8v682
   0cayVA0ez6vqvy8Mho6/k35UU3ahl5xyVTXbUJVgiFbO+8cv00X16sfpr
   6+GUXphIMqYDWMRiJKx7r7TM3jyNiynpu97O7UIHfHSLl8UbtbK+fZKek
   0P0pfYYjekJ29ItQ4TbhJCnyODZ7RpG08xr8HyjbAnSSe6zbdQIAQ7P6d
   YU5KyHur2iOTdD714pfEYFqPath+EWjuArSrQ+QqtuR32Col9XqYoKHzf
   BqBEFAfMFpDZbS9Ov+WWKDXStFfWi17T06h2V6iOhx7LKJO4d04t4gFZS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674177"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499248"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499248"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: debugfs: add entry for setting maximum TXOP time
Date:   Mon, 12 Jun 2023 18:51:03 +0300
Message-Id: <20230612184434.4ab332037a25.I57c33574a61edd68bd0ec1aa7009f31111fd7efe@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

Add an entry for setting the maximum TXOP time in microseconds.
The configured value can be read from the same entry.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 38 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  3 ++
 3 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 3613b1fdc5d9..762bce70e262 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -679,6 +679,42 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file *file,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
+static ssize_t iwl_dbgfs_max_tx_op_write(struct ieee80211_vif *vif, char *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	u16 value;
+	int ret;
+
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mvm->mutex);
+	mvmvif->max_tx_op = value;
+	mutex_unlock(&mvm->mutex);
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_max_tx_op_read(struct file *file,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct ieee80211_vif *vif = file->private_data;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	char buf[10];
+	int len;
+
+	mutex_lock(&mvm->mutex);
+	len = scnprintf(buf, sizeof(buf), "%hu\n", mvmvif->max_tx_op);
+	mutex_unlock(&mvm->mutex);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
 #define MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz) \
 	_MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz, struct ieee80211_vif)
 #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
@@ -698,6 +734,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(uapsd_misbehaving, 20);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
+MVM_DEBUGFS_READ_WRITE_FILE_OPS(max_tx_op, 10);
 
 
 void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -733,6 +770,7 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	MVM_DEBUGFS_ADD_FILE_VIF(rx_phyinfo, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(quota_min, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(os_device_timediff, mvmvif->dbgfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE_VIF(max_tx_op, mvmvif->dbgfs_dir, 0600);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    mvmvif == mvm->bf_allowed_vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 90cb8eeec47c..afcc55231bbc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -358,6 +358,7 @@ struct iwl_mvm_vif_link_info {
  * @csa_failed: CSA failed to schedule time event, report an error later
  * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
  * @features: hw features active for this vif
+ * @max_tx_op: max TXOP in usecs for all ACs, zero for no limit.
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -443,6 +444,8 @@ struct iwl_mvm_vif {
 		struct ieee80211_key_conf __rcu *keys[2];
 	} bcn_prot;
 
+	u16 max_tx_op;
+
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index e77b6157f759..992642edfcbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -588,6 +588,7 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 				cpu_to_le16(max_amsdu_len) : 0,
 	};
 	unsigned int link_id = link_conf->link_id;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
 	int cmd_ver;
 	int ret;
 
@@ -616,6 +617,8 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	 */
 	sta->deflink.agg.max_amsdu_len = max_amsdu_len;
 
+	cfg_cmd.max_tx_op = cpu_to_le16(mvmvif->max_tx_op);
+
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					WIDE_ID(DATA_PATH_GROUP,
 						TLC_MNG_CONFIG_CMD),
-- 
2.38.1

