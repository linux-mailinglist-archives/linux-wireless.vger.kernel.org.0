Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC96CD28F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjC2HH1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjC2HHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37740E4
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073628; x=1711609628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Sj0XFcROK6iv2RHJAN80CCvDkUUiZZsjK/x580vuiQ=;
  b=SpxFAZtQ+qRzGjjnbRHYDVy0+DWk6uCZiWI/eOoRH85hXYJXAE97wFVd
   m3mikiJHCMDfkTrx8EhWxJu/isyEf3+iSlZ2M53+jj1q+fs9g+N8v9H2a
   8qKkxcXEcJosP0sKHIIMKeWlQY7V1WPBA+6T9Lde5Tiawu66l+0htu5pT
   TsjRyiAolclW5Tc8uVlkcJR4r3dkI6/bvaR3drQiSRleRbnwdqBahteOr
   1dFGlKy1PiSnqw8PloFDS6/diAn1UXBhOK85ivU1LomIO7Ogev/vsBkS2
   HqWFfw2NiReJ+yKFaAO0YzykdeOZN7rV8GOZg9wH1hUjbm8X70dJ5c0we
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450804"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450804"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111313"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111313"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/34] wifi: iwlwifi: mvm: implement mac80211 callback change_sta_links
Date:   Wed, 29 Mar 2023 10:05:18 +0300
Message-Id: <20230329100039.156d1aae5de1.I32973141be1190222169879f8caf7038c1a8f769@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Add/removed from iwl driver and firmware station links.
Update the station queues accordingly (which station links
are connected to the station queues).

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   9 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 246 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 +
 3 files changed, 236 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index be9b2efa5ef5..e475d0daf512 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -953,7 +953,14 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 			     struct ieee80211_sta *sta,
 			     u16 old_links, u16 new_links)
 {
-	return 0;
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_mld_update_sta_links(mvm, vif, sta, old_links, new_links);
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
 }
 
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index c877c94dd1d6..9be6d858411d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -479,15 +479,53 @@ static void iwl_mvm_mld_sta_rm_all_sta_links(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
+				      struct iwl_mvm_sta *mvm_sta,
+				      struct iwl_mvm_link_sta *mvm_sta_link,
+				      unsigned int link_id)
+{
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id], NULL);
+	RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
+
+	if (mvm_sta_link != &mvm_sta->deflink)
+		kfree_rcu(mvm_sta_link, rcu_head);
+}
+
+static int iwl_mvm_mld_alloc_sta_link(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta,
+				      unsigned int link_id)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_link_sta *link;
+	u32 sta_id = iwl_mvm_find_free_sta_id(mvm,
+					  ieee80211_vif_type_p2p(vif));
+
+	if (sta_id == IWL_MVM_INVALID_STA)
+		return -ENOSPC;
+
+	if (rcu_access_pointer(sta->link[link_id]) == &sta->deflink) {
+		link = &mvm_sta->deflink;
+	} else {
+		link = kzalloc(sizeof(*link), GFP_KERNEL);
+		if (!link)
+			return -ENOMEM;
+	}
+
+	link->sta_id = sta_id;
+	rcu_assign_pointer(mvm_sta->link[link_id], link);
+	rcu_assign_pointer(mvm->fw_id_to_mac_id[link->sta_id], sta);
+
+	return 0;
+}
+
 /* allocate all the links of a sta, called when the station is first added */
 static int iwl_mvm_mld_alloc_sta_links(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_mvm_link_sta *link;
 	unsigned int link_id;
-	u32 sta_id;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -497,27 +535,9 @@ static int iwl_mvm_mld_alloc_sta_links(struct iwl_mvm *mvm,
 		    mvm_sta->link[link_id])
 			continue;
 
-		sta_id = iwl_mvm_find_free_sta_id(mvm,
-						  ieee80211_vif_type_p2p(vif));
-
-		if (sta_id == IWL_MVM_INVALID_STA) {
-			ret = -ENOSPC;
+		ret = iwl_mvm_mld_alloc_sta_link(mvm, vif, sta, link_id);
+		if (ret)
 			goto err;
-		}
-
-		if (rcu_access_pointer(sta->link[link_id]) == &sta->deflink) {
-			link = &mvm_sta->deflink;
-		} else {
-			link = kzalloc(sizeof(*link), GFP_KERNEL);
-			if (!link) {
-				ret = -ENOMEM;
-				goto err;
-			}
-		}
-
-		link->sta_id = sta_id;
-		rcu_assign_pointer(mvm_sta->link[link_id], link);
-		rcu_assign_pointer(mvm->fw_id_to_mac_id[link->sta_id], sta);
 	}
 
 	return 0;
@@ -846,3 +866,185 @@ void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 
 	rcu_read_unlock();
 }
+
+static int iwl_mvm_mld_update_sta_queue(struct iwl_mvm *mvm,
+					struct iwl_mvm_sta *mvm_sta,
+					u32 old_sta_mask,
+					u32 new_sta_mask)
+{
+	struct iwl_scd_queue_cfg_cmd cmd = {
+		.operation = cpu_to_le32(IWL_SCD_QUEUE_MODIFY),
+		.u.modify.old_sta_mask = cpu_to_le32(old_sta_mask),
+		.u.modify.new_sta_mask = cpu_to_le32(new_sta_mask),
+	};
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DATA_PATH_GROUP, SCD_QUEUE_CONFIG_CMD),
+		.len[0] = sizeof(cmd),
+		.data[0] = &cmd
+	};
+	int tid;
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	for (tid = 0; tid <= IWL_MAX_TID_COUNT; tid++) {
+		struct iwl_mvm_tid_data *tid_data = &mvm_sta->tid_data[tid];
+		int txq_id = tid_data->txq_id;
+
+		if (txq_id == IWL_MVM_INVALID_QUEUE)
+			continue;
+
+		if (tid == IWL_MAX_TID_COUNT)
+			cmd.u.modify.tid = cpu_to_le32(IWL_MGMT_TID);
+		else
+			cmd.u.modify.tid = cpu_to_le32(tid);
+
+		ret = iwl_mvm_send_cmd(mvm, &hcmd);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 u16 old_links, u16 new_links)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_link_sta *mvm_sta_link;
+	struct iwl_mvm_vif_link_info *mvm_vif_link;
+	unsigned long links_to_add = ~old_links & new_links;
+	unsigned long links_to_rem = old_links & ~new_links;
+	unsigned long old_links_long = old_links;
+	u32 current_sta_mask = 0, sta_mask_added = 0, sta_mask_to_rem = 0;
+	unsigned long link_sta_added_to_fw = 0, link_sta_allocated = 0;
+	unsigned int link_id;
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	for_each_set_bit(link_id, &old_links_long,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		mvm_sta_link =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (WARN_ON(!mvm_sta_link)) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		current_sta_mask |= BIT(mvm_sta_link->sta_id);
+		if (links_to_rem & BIT(link_id))
+			sta_mask_to_rem |= BIT(mvm_sta_link->sta_id);
+	}
+
+	if (sta_mask_to_rem) {
+		ret = iwl_mvm_mld_update_sta_queue(mvm, mvm_sta,
+						   current_sta_mask,
+						   current_sta_mask & ~sta_mask_to_rem);
+		if (WARN_ON(ret))
+			goto err;
+
+		current_sta_mask &= ~sta_mask_to_rem;
+	}
+
+	for_each_set_bit(link_id, &links_to_rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mvm_sta_link =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+		mvm_vif_link = mvm_vif->link[link_id];
+
+		if (WARN_ON(!mvm_sta_link || !mvm_vif_link)) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_sta_link->sta_id);
+		if (WARN_ON(ret))
+			goto err;
+
+		if (vif->type == NL80211_IFTYPE_STATION)
+			mvm_vif_link->ap_sta_id = IWL_MVM_INVALID_STA;
+
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
+	}
+
+	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference_protected(vif->link_conf[link_id], 1);
+		struct ieee80211_link_sta *link_sta =
+			rcu_dereference_protected(sta->link[link_id], 1);
+		mvm_vif_link = mvm_vif->link[link_id];
+
+		if (WARN_ON(!mvm_vif_link || !link_conf || !link_sta ||
+			    mvm_sta->link[link_id])) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = iwl_mvm_mld_alloc_sta_link(mvm, vif, sta, link_id);
+		if (WARN_ON(ret))
+			goto err;
+
+		mvm_sta_link =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (WARN_ON(!mvm_sta_link)) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (vif->type == NL80211_IFTYPE_STATION)
+			iwl_mvm_mld_set_ap_sta_id(sta, mvm_vif_link,
+						  mvm_sta_link);
+
+		link_sta_allocated |= BIT(link_id);
+
+		sta_mask_added |= BIT(mvm_sta_link->sta_id);
+
+		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
+					  mvm_sta_link);
+		if (WARN_ON(ret))
+			goto err;
+
+		link_sta_added_to_fw |= BIT(link_id);
+	}
+
+	if (sta_mask_added) {
+		ret = iwl_mvm_mld_update_sta_queue(mvm, mvm_sta,
+						   current_sta_mask,
+						   current_sta_mask | sta_mask_added);
+		if (WARN_ON(ret))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	/* remove all already allocated stations in FW */
+	for_each_set_bit(link_id, &link_sta_added_to_fw,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		mvm_sta_link =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_sta_link->sta_id);
+	}
+
+	/* remove all already allocated station links in driver */
+	for_each_set_bit(link_id, &link_sta_allocated,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		mvm_sta_link =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 6d4db666368b..2402b41bc0bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -641,6 +641,10 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			  u8 sta_id);
+int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 u16 old_links, u16 new_links);
 
 /* Queues */
 void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
-- 
2.38.1

