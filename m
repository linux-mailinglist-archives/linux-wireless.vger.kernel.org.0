Return-Path: <linux-wireless+bounces-14614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3A9B3654
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA4282BDA
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7EF18B47E;
	Mon, 28 Oct 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4l/laIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307AD1DE2D7
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132365; cv=none; b=I/HbPbpGF7jcSlPwXAFFz3wzuY59QZXa4eqjfppGwnOzcEALyruybRdhGODEzFYG0n9Q7emKpUKZHIrX/OjwAK++MP2o9OYVTNMrNZvY3tXxJqAgUUGdSXDHflmP5qlOm09uXtgFk/U10crih1X02YaH6CbkVNzL+v4ej0XyRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132365; c=relaxed/simple;
	bh=1hv5NIKUS0DmAE2+YHJJOQG/0btmkcPNy6lICxLB6Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEmLVIKo9KpE7qPtJh3LWntD04LASNSxuIhoFrK1wqlHS5hus3JKGw7yJrqpgFjL781ApBcvwtdvy0lDD+nA7ept/qs4/J0SsAxtMEZ4NV80StrM4vl2x4Koi3v88znIuM6unJ0p+Iv3etJMu5yl9jRz9aGw1LVfJqdOhmN9WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4l/laIp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730132363; x=1761668363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hv5NIKUS0DmAE2+YHJJOQG/0btmkcPNy6lICxLB6Uc=;
  b=h4l/laIpCvojSbZwvhoM858YEJD8rLvcmnpdadjm4pp4C0H7jgnnfPDL
   AO8q56Lq22LkwMWheYMljc8nisznDjp+rLzXgdejO7WXvRRXnrdmAPi3x
   +4xBce9+KN/oT26JfVpkkulhHrQ/p5L4XPqmVMURRZGfwPrBZcVTwstom
   MwxMjuvVZKCbdP3GENTBSq+cNPIKIFchllaXx0Yd+1iS/D+eRCpxtfDor
   JLVfv6yaxxanP2SFbjAc+XDbx2u/VU/XgDG2J3tlLF4zarTPpbdpdSlUA
   MK/NQAvKSi83tQL42hZVSLMbZdSjdMFk5MgQ2Wx3lJ4CVYYkZ27GLfN6A
   A==;
X-CSE-ConnectionGUID: d2oWVkfpQQmRjkVCHzBrRg==
X-CSE-MsgGUID: gN65NxeMRjKuoIDROkKXKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41099905"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="41099905"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:22 -0700
X-CSE-ConnectionGUID: OQlXnvKXSh6pXtQDH7c03w==
X-CSE-MsgGUID: tQv4XHhnQMiayIptxyiDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81561571"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] wifi: iwlwifi: mvm: cleanup iwl_mvm_sta_del
Date: Mon, 28 Oct 2024 18:19:02 +0200
Message-Id: <20241028181512.8101de3b9c09.Ia1cc352b871593be4f51cb3db98f9eedd5267857@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
References: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Now it neither sets the ret argument or return something else than
false.
Cleanup this function to be void and to not receive the ret argument.
This also allows to get rid of the sta_in_fw parameter in
iwl_mvm_mld_free_sta_link.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 27 ++++++-------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  9 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  7 +++--
 4 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0dfa2c0453e4..343e4814f504 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1153,7 +1153,7 @@ static void iwl_mvm_cleanup_sta_iterator(void *data, struct ieee80211_sta *sta)
 			 * Delete the stale data to avoid issues later on.
 			 */
 			iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta,
-						  link_id, false);
+						  link_id);
 		}
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 99eb1e1db1bb..0c724eb4a65b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -518,11 +518,9 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
 			       struct iwl_mvm_sta *mvm_sta,
 			       struct iwl_mvm_link_sta *mvm_sta_link,
-			       unsigned int link_id,
-			       bool is_in_fw)
+			       unsigned int link_id)
 {
-	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id],
-			 is_in_fw ? ERR_PTR(-EINVAL) : NULL);
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id], NULL);
 	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[mvm_sta_link->sta_id], NULL);
 	RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
 
@@ -543,7 +541,7 @@ static void iwl_mvm_mld_sta_rm_all_sta_links(struct iwl_mvm *mvm,
 		if (!link)
 			continue;
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, link, link_id, false);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, link, link_id);
 	}
 }
 
@@ -835,18 +833,11 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		struct iwl_mvm_link_sta *mvm_link_sta =
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
-		bool stay_in_fw;
+		iwl_mvm_sta_del(mvm, vif, sta, link_sta);
 
-		stay_in_fw = iwl_mvm_sta_del(mvm, vif, sta, link_sta, &ret);
-		if (ret)
-			break;
-
-		if (!stay_in_fw)
-			ret = iwl_mvm_mld_rm_sta_from_fw(mvm,
-							 mvm_link_sta->sta_id);
+		ret = iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_link_sta->sta_id);
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta,
-					  link_id, stay_in_fw);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta, link_id);
 	}
 	kfree(mvm_sta->mpdu_counters);
 	mvm_sta->mpdu_counters = NULL;
@@ -1111,8 +1102,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 		if (vif->type == NL80211_IFTYPE_STATION)
 			mvm_vif_link->ap_sta_id = IWL_MVM_INVALID_STA;
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id,
-					  false);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
 	}
 
 	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
@@ -1216,8 +1206,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id,
-					  false);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 112b78c1b0e3..4187ca259a5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2045,9 +2045,9 @@ int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
  * Returns if we're done with removing the station, either
  * with error or success
  */
-bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+void iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta,
-		     struct ieee80211_link_sta *link_sta, int *ret)
+		     struct ieee80211_link_sta *link_sta)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_vif_link_info *mvm_link =
@@ -2080,8 +2080,6 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
 		cancel_delayed_work(&mvm->tdls_cs.dwork);
 	}
-
-	return false;
 }
 
 int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
@@ -2137,8 +2135,7 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		*status = IWL_MVM_QUEUE_FREE;
 	}
 
-	if (iwl_mvm_sta_del(mvm, vif, sta, &sta->deflink, &ret))
-		return ret;
+	iwl_mvm_sta_del(mvm, vif, sta, &sta->deflink);
 
 	ret = iwl_mvm_rm_sta_common(mvm, mvm_sta->deflink.sta_id);
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id], NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 4a3799ae7c18..54d8c0df2284 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -507,9 +507,9 @@ void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 					  struct ieee80211_sta *sta);
 int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
 				  struct iwl_mvm_sta *mvm_sta);
-bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+void iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta,
-		     struct ieee80211_link_sta *link_sta, int *ret);
+		     struct ieee80211_link_sta *link_sta);
 int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		   struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta);
@@ -665,8 +665,7 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
 			       struct iwl_mvm_sta *mvm_sta,
 			       struct iwl_mvm_link_sta *mvm_sta_link,
-			       unsigned int link_id,
-			       bool is_in_fw);
+			       unsigned int link_id);
 int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id);
 int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
-- 
2.34.1


