Return-Path: <linux-wireless+bounces-7521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E38C350C
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E4D281C87
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40311BF47;
	Sun, 12 May 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cARnuj5n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DD19470
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488300; cv=none; b=cQOy0SwEL+UrlZ6vuQ7dG78R540FjW/s8SgLsViuYABbraL3WdahX+Y4RA/GjRpQ7s6TVu5FTEc8zvpkSaJTy99FewKcYcQUjZd8ncT1m4A7JbDRAVYpu079aZI3rPWif0KF7AVfX/LIzXqN1x43ysCiLeG7tYRXXgYRGOQ4FW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488300; c=relaxed/simple;
	bh=Za2UWbVBINje6RFOAVwZNay2Aqtae3XpPKlxOevknFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTHCdqMpdt7y/hjWHgUEbgzZXofkPSyJtL4KZkp7WuAzeBy9Jn74llYDrBZGlgPAulGpH9XZJVVzF9yPhmmWVdza+sIDhGjpCEjG35oFoxEWj5j+K/TErobwUKqKMTLlMFuuVG785ldTUlQsNZeK4XZkoTdIwxHXB5u2mfuGeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cARnuj5n; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488299; x=1747024299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Za2UWbVBINje6RFOAVwZNay2Aqtae3XpPKlxOevknFY=;
  b=cARnuj5nW8yov7D/SSBjuPS4JjiZrHfVj9u3djh/YGVyKshJetqNomxH
   dORYsglDFEka8/uD6vXo1YNV+LITZIHIi9fPNOKXPRhmIruFokelhtqEe
   UADZBjRtI0dDbnmnnoEBa1pTu2SydnCiiyVq8BzWYiJXQGlGOBA/5YsoY
   wYS9AqO+tXio+sycYmkTXgy910DKcRS50nRSKH0BnPHjkxizemzWT/hZR
   MaZ5PaK6Bi9/vYPv2ar63YrVg9+SZJQk2VXASG0AoJH0LbYgB0z+dOjHQ
   X8cD97iDskqSzN9wpd5kg8ET7bH5Q4+cRpEnRAeTPuQnva3YbvzAQL/g4
   g==;
X-CSE-ConnectionGUID: +jtk9D29TtiHA/NjIbtbZw==
X-CSE-MsgGUID: PoNMBpmmTXGDy/JJWB8/gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323856"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323856"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:39 -0700
X-CSE-ConnectionGUID: PfEik2oRR/OiYOZmm3DNhQ==
X-CSE-MsgGUID: wVtGPBFdSZ+ycnPFGqcMfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532169"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 10/16] wifi: iwlwifi: mvm: remove stale STA link data during restart
Date: Sun, 12 May 2024 07:31:04 +0300
Message-Id: <20240512072733.12d9368a4f72.I840d4fdce5fd49fe69896d928b071067e3730259@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

If pre-recovery mac80211 tried to disable a link but this disablement
failed, then there might be a mismatch between mac80211 assuming the
link has been disabled and the driver still having the data around.
During recover itself, that is not a problem, but should the link be
activated again at a later point, iwlwifi will refuse the activation as
it detects the inconsistent state.

Solve this corner-case by iterating the station in the restart cleanup
handler.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 37 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 10 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +++
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 486a6b8f3c97..628b50ee0244 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1128,6 +1128,39 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 }
 
+static void iwl_mvm_cleanup_sta_iterator(void *data, struct ieee80211_sta *sta)
+{
+	struct iwl_mvm *mvm = data;
+	struct iwl_mvm_sta *mvm_sta;
+	struct ieee80211_vif *vif;
+	int link_id;
+
+	mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	vif = mvm_sta->vif;
+
+	if (!sta->valid_links)
+		return;
+
+	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++) {
+		struct iwl_mvm_link_sta *mvm_link_sta;
+
+		mvm_link_sta =
+			rcu_dereference_check(mvm_sta->link[link_id],
+					      lockdep_is_held(&mvm->mutex));
+		if (mvm_link_sta && !(vif->active_links & BIT(link_id))) {
+			/*
+			 * We have a link STA but the link is inactive in
+			 * mac80211. This will happen if we failed to
+			 * deactivate the link but mac80211 roll back the
+			 * deactivation of the link.
+			 * Delete the stale data to avoid issues later on.
+			 */
+			iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta,
+						  link_id, false);
+		}
+	}
+}
+
 static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 {
 	iwl_mvm_stop_device(mvm);
@@ -1150,6 +1183,10 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 	 */
 	ieee80211_iterate_interfaces(mvm->hw, 0, iwl_mvm_cleanup_iterator, mvm);
 
+	/* cleanup stations as links may be gone after restart */
+	ieee80211_iterate_stations_atomic(mvm->hw,
+					  iwl_mvm_cleanup_sta_iterator, mvm);
+
 	mvm->p2p_device_vif = NULL;
 
 	iwl_mvm_reset_phy_ctxts(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 3b2875f2cab7..d20aa639eea5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -515,11 +515,11 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	return iwl_mvm_mld_send_sta_cmd(mvm, &cmd);
 }
 
-static void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
-				      struct iwl_mvm_sta *mvm_sta,
-				      struct iwl_mvm_link_sta *mvm_sta_link,
-				      unsigned int link_id,
-				      bool is_in_fw)
+void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
+			       struct iwl_mvm_sta *mvm_sta,
+			       struct iwl_mvm_link_sta *mvm_sta_link,
+			       unsigned int link_id,
+			       bool is_in_fw)
 {
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id],
 			 is_in_fw ? ERR_PTR(-EINVAL) : NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 264f1f9394b6..754a05a8c189 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -662,6 +662,11 @@ int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
+			       struct iwl_mvm_sta *mvm_sta,
+			       struct iwl_mvm_link_sta *mvm_sta_link,
+			       unsigned int link_id,
+			       bool is_in_fw);
 int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id);
 int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
-- 
2.34.1


