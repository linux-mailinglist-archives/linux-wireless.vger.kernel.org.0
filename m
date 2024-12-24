Return-Path: <linux-wireless+bounces-16790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33309FC0FA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 18:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5D9164F6A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C7212D85;
	Tue, 24 Dec 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC1VnpVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E1212D94
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061275; cv=none; b=f2iHIU7kdWwwoIgCMdLURL6Gos5juNXBZMmuECeCBNeagVIIk+kBJuwE3CQc6/nrhExdKEexVJFkRjVIPdQVKf25cbGkzUFoR5fJQ+gYQ9+yU0p617tKOz9Ixapa+eWA9PK7I2uvAIBUry/dozOwZelrTNc3SSYsr7JC3V4XcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061275; c=relaxed/simple;
	bh=2puN5Kg20AOWdMyK/Ut1Z26EneYlIRr+5o7SHZhMX9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kl/qGJWVUA/LWl/ujbjnuEuS5W7l8XAnHCS5bBe5xVQ99g0KXe20XB3jTHJcbvjcKEsl/F/i2RaEdSPqyoz7JzAk86Chu0kRoORVNdFAOn8XvULY/U7M7cDXxxBVHk+QOjsrQAIESnSKyj3Q8qRz8LeLlC9gzLWMNOyetc82Sh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC1VnpVl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735061274; x=1766597274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2puN5Kg20AOWdMyK/Ut1Z26EneYlIRr+5o7SHZhMX9s=;
  b=aC1VnpVl2MI0hUm+AiMRkU2sGU8RGZ5VaDy8WfL/2LlTMwg5thaiAFqS
   bvZdmPLHjBrwyRoTB6VWGR4oVKTCroY7UjfzKy5qSGEpr1nAMmNvz73ul
   uoBmEzrEaogaV0gC2YL30Jr1kSJUdp1g0G9HJlGY/NqLBrZQ0EOmN00Nj
   sYtSFYLuAn/I4tCkWvT0DM/kACIcHNWWnB4vCsKrN0ON/EpvWkkA9LYgV
   J4syFrQWpWgz6NO2H7Gqkrm6sCeczKQdy8euQcuGlkLdDiUwgQ4wDTOPz
   SdAmiXAMgh0Lfj27I4mBp4YqjIPXVZOJpk3wD2Eg+Yl7r/4s4rjV/vrQZ
   w==;
X-CSE-ConnectionGUID: S3SF3HiETaiD5Os+0Y2M+w==
X-CSE-MsgGUID: 7mbf6LEhTbKrnmYP3pUahg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39311136"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="39311136"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:54 -0800
X-CSE-ConnectionGUID: DcAQrDFoREyDRPSTWwE8wA==
X-CSE-MsgGUID: 9kp3p0InRbePnNmuzKy9gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="99341050"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RESEND][PATCH 5/5] wifi: iwlwifi: mvm: cleanup iwl_mvm_sta_del
Date: Tue, 24 Dec 2024 19:27:31 +0200
Message-Id: <20241224192322.ecebfa16c62c.Ia1cc352b871593be4f51cb3db98f9eedd5267857@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224172731.2640748-1-miriam.rachel.korenblit@intel.com>
References: <20241224172731.2640748-1-miriam.rachel.korenblit@intel.com>
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
index 54275374815a..e22c9172bf02 100644
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
index 019839604011..2f159024eeb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -518,14 +518,12 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
 			       struct iwl_mvm_sta *mvm_sta,
 			       struct iwl_mvm_link_sta *mvm_sta_link,
-			       unsigned int link_id,
-			       bool is_in_fw)
+			       unsigned int link_id)
 {
 	lockdep_assert_wiphy(mvm->hw->wiphy);
 	lockdep_assert_held(&mvm->mutex);
 
-	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id],
-			 is_in_fw ? ERR_PTR(-EINVAL) : NULL);
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id], NULL);
 	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[mvm_sta_link->sta_id], NULL);
 	RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
 
@@ -546,7 +544,7 @@ static void iwl_mvm_mld_sta_rm_all_sta_links(struct iwl_mvm *mvm,
 		if (!link)
 			continue;
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, link, link_id, false);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, link, link_id);
 	}
 }
 
@@ -844,18 +842,11 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
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
@@ -1122,8 +1113,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 		if (vif->type == NL80211_IFTYPE_STATION)
 			mvm_vif_link->ap_sta_id = IWL_INVALID_STA;
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id,
-					  false);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
 	}
 
 	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
@@ -1227,8 +1217,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id,
-					  false);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 35f4ca89920e..9d9d385f67ac 100644
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
 		mvm->tdls_cs.peer.sta_id = IWL_INVALID_STA;
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


