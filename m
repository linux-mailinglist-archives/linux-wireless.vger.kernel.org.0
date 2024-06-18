Return-Path: <linux-wireless+bounces-9157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B590CC07
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D855280988
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489A158D70;
	Tue, 18 Jun 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgFgCMZX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A713C81B;
	Tue, 18 Jun 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714213; cv=none; b=PcuqQdFo6n+YrdNvDZzQ5Xn4EAXC7kjNV4neVeahvsJynQpna6sA1JjtyYpoQVcqhB914tSDvmg/hfNBPEwZsvWIEb2Wk1yx1gvmImVB+p9wt+aczdtuF1QhE6MtBO+fOmiT5XoRJWhSClaa1pho9vGYbEQme+Yj1t7nnIZLPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714213; c=relaxed/simple;
	bh=W+Kqzrrisl+xzqP63S4grqOrs6f5pItw2/GgaKQC/zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvCaNT8vf8T51x/Z9I64pmOcgmAGX0GCe5PNjKemImcO1TOW6jZ1AMqwI/knD/1TrGnk/lEx8oY6ER90hMd/bxR5FfVXrviH9eYQfPyQ9au4ubt4oDPpnJnkUlr7P62lrZo7u9/PciKaLaB6pMbqWdFAV6HZ5lOgJaEe57RZraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgFgCMZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C36AC3277B;
	Tue, 18 Jun 2024 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714213;
	bh=W+Kqzrrisl+xzqP63S4grqOrs6f5pItw2/GgaKQC/zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgFgCMZX+L3ynhwO2BeCWsJO4XxuSe7+e5EWlGvxYnSZDqVkvrR/A3zK0LLVSrgFl
	 34762YFrcgzebtyuSBpKr2CmwWeqm5SK6zsNQ8Xtgke6kX06+ofqCRguyH7qqxJUNg
	 Ps56oEhPeDLgL1kBbpzzINfaObs/BE260yqfQZkD8zwW1wEKqWaNlQrYgI4jNnka2x
	 TEPttfh/l2whIoY3VwJ9SKEISn8Fyr3Gor1MqPUqZdqlXZzvlOzfdAKfIsf5xA3w8i
	 c9QKwCgvvmjOpHoY5ZP5MRplqy22thY6mqo1ealuIBnf7rqU9oAUUQJ4hYdPEn3Qs4
	 5d99JEANV5JpQ==
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
Subject: [PATCH AUTOSEL 6.9 19/44] wifi: iwlwifi: mvm: remove stale STA link data during restart
Date: Tue, 18 Jun 2024 08:35:00 -0400
Message-ID: <20240618123611.3301370-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 7ed7444c98715..d2557d9f63e59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1115,6 +1115,39 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
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
@@ -1137,6 +1170,10 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 	 */
 	ieee80211_iterate_interfaces(mvm->hw, 0, iwl_mvm_cleanup_iterator, mvm);
 
+	/* cleanup stations as links may be gone after restart */
+	ieee80211_iterate_stations_atomic(mvm->hw,
+					  iwl_mvm_cleanup_sta_iterator, mvm);
+
 	mvm->p2p_device_vif = NULL;
 
 	iwl_mvm_reset_phy_ctxts(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 36dc291d98dd6..a21e29947475f 100644
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
index b3450569864eb..7dd8f7f4b4492 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -638,6 +638,11 @@ int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
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


