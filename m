Return-Path: <linux-wireless+bounces-9090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9796990B19D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF23B371CE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1C19AD4D;
	Mon, 17 Jun 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP6MBzFv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73E198A0A;
	Mon, 17 Jun 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630625; cv=none; b=Ia2ZZawCCjRjIbGswVRSgfQT7a2kqUECvfwbWsoxeMkYM0uJ4rSYBIvwNRdg7fdNHjut+BxzM2COLCq2X6WKWwTCw/aT4m6wmMvp0dH3BCuSTzQe1zK2ikW9G03bhXZu4U7kX7qUC2dtGc96jvbh+zG+QFBDodoi6P/Iil/3CKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630625; c=relaxed/simple;
	bh=ibb4uObZWTwc/aDwEPI3oT3bbs+fT8c/jEDjooH+vYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1MLsVIUgSOpraQeWOs+FpSSqjawDdFPeKMmRfRCMKo1Tbz5hrdHOL8Xn88i6wvOfVH0a4fpzKEFpDwtJfXU0S+nsFI/BCt/pywDE2relOe9oNpkdsGuFkTkbqWpXQVOibbmRIEJ9yoYYhnVmHR44N7TMQj4FhZJF3i/zenBRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP6MBzFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C20C4AF1C;
	Mon, 17 Jun 2024 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630625;
	bh=ibb4uObZWTwc/aDwEPI3oT3bbs+fT8c/jEDjooH+vYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MP6MBzFv8TGeDMiRkM8Wo8w3QEVYcqVLRP85pgUR00s9GhYwOB6uZhPkPX+GR2Y7S
	 QCKlji4u7bta9EBAI182ohuP3x7v2tJ5qH42IeCMzuOs1nXLhvCSDTaTyJzPsdebew
	 6qAfWq6SHE5nyJz7b5/sqDb2/IMaakQT+RRL/sEACu0nr1P9EfC3gscDyhNq1JRx2b
	 wRbIkT1AwhAgiXv5gCXu/sXQH/4XfkAFuqMewE0czdbK69oPUmlsZgKnQMJ96m4Oii
	 JyEK44ln88f+Sq8yPYlTMMjYy4zlZEJJkhqXzPuKcmqQSDxYf6219fHcINf5zAKmH2
	 4IRRbn5nsAggg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	emmanuel.grumbach@intel.com,
	ilan.peer@intel.com,
	shaul.triebitz@intel.com,
	dan.carpenter@linaro.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/35] wifi: iwlwifi: mvm: remove stale STA link data during restart
Date: Mon, 17 Jun 2024 09:22:14 -0400
Message-ID: <20240617132309.2588101-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit cc3ba78f202de9752aceb16342ab62bdfbffac7e ]

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
Link: https://msgid.link/20240513132416.d2fd60338055.I840d4fdce5fd49fe69896d928b071067e3730259@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 37 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 10 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +++
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 375f401b14535..e281e07be73fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1051,6 +1051,39 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
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
@@ -1073,6 +1106,10 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 	 */
 	ieee80211_iterate_interfaces(mvm->hw, 0, iwl_mvm_cleanup_iterator, mvm);
 
+	/* cleanup stations as links may be gone after restart */
+	ieee80211_iterate_stations_atomic(mvm->hw,
+					  iwl_mvm_cleanup_sta_iterator, mvm);
+
 	mvm->p2p_device_vif = NULL;
 
 	iwl_mvm_reset_phy_ctxts(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 121da93e99c6a..2dcc13d4a4a79 100644
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
index 7364346a1209f..95ef60daa62f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -642,6 +642,11 @@ int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
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
2.43.0


