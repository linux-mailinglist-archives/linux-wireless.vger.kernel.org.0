Return-Path: <linux-wireless+bounces-33468-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGSkGTHAu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33468-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:21:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A4F2C885C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A931032BE7B4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA33BA245;
	Thu, 19 Mar 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7158Jog"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F463AF673
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911391; cv=none; b=a0J6mIKaj9r0O1lOT/9ARbLG51rJLz9nkirBXKb7H77aKeeQ8WfbGIOCLxgy49e+W/wfzrrRGk9UIpuGg1iFR7AEZgWIczD3dFi6Nv8mGgoqTkGRZO5Di8hD2NX9j1xtFac9np8ObCoFakxCysXQppRTVypIWNydcUppKXwH43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911391; c=relaxed/simple;
	bh=jbLU+2qsbgL6ElJvmR0vtQy8jiyrz24JkAH4QFTczyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwUZnkfoHME8RjwVym6LnWPgSfAqz7HRxKwXHeMxB1c3xkFpDbtvB9V2eWpbUKl316oGJHprU5mC1Lgo8YtFc2TsvXfmzB4qzio+1iPcVHcDvggBfibhUiSxLdHG4Ytodtcbx5c97V05u5cEEiNl/0qPcdke6RKnGR9KO3XfJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7158Jog; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911387; x=1805447387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbLU+2qsbgL6ElJvmR0vtQy8jiyrz24JkAH4QFTczyA=;
  b=i7158JogVMAL2DT+yvQIYjhRYbORKX9jKdfsLZf4o0I8WLCpfcoi6XAK
   ghccNHnx3Bi1WPtP4v/g7gV2aRL+Dj0Ee0+tYAPj3b5eOyM1A7aEWZuMC
   zjt0rYYstSoNpRQMyvAiarpgjPc/LjdLoqaJJeRvtfdnKwySbanE5rk2X
   uV04IeLohMXBgDkseHdkqwZIvN1ah/mcDoElOWR8EKqDfqFTvjxWEO8LT
   vndhME/kE8SD391ul7nv1NawFzEZRpWUASTTWLQzc0L2qwgxXpPbffF3K
   uAgD5toBZeWAKrbm3CWxhrgqYQZpIb6nYpWXVNuVlrSyb1Ht0/Ql19MOS
   w==;
X-CSE-ConnectionGUID: Mwu+EbmyS0yisLtWD+vulw==
X-CSE-MsgGUID: mE/MhNTUQsuZCO2JwwkpCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992709"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992709"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:46 -0700
X-CSE-ConnectionGUID: UCHP4svZQSqOmGCwTg3yeA==
X-CSE-MsgGUID: TBfGdR/8QZqFTaXfw6DO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387131"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Nidhish A N <nidhish.a.n@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 05/15] wifi: iwlwifi: mvm: cleanup some more MLO code
Date: Thu, 19 Mar 2026 11:09:17 +0200
Message-Id: <20260319110722.8efcec472e91.Icaf4f4d6b9008e12310f408cfef7f35643f27ca5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33468-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 08A4F2C885C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nidhish A N <nidhish.a.n@intel.com>

iwlmld is now the op mode that is used  for EHT devices,
so iwlmvm code can never run in MLO.
Clean up some more MLO code.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  46 ---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 132 --------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 285 ------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 -
 5 files changed, 472 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 9bb253dcf4a7..4869a5fa8abc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -121,52 +121,6 @@ struct iwl_mvm_sta_key_update_data {
 	int err;
 };
 
-static void iwl_mvm_mld_update_sta_key(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_sta *sta,
-				       struct ieee80211_key_conf *key,
-				       void *_data)
-{
-	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
-	struct iwl_mvm_sta_key_update_data *data = _data;
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_sec_key_cmd cmd = {
-		.action = cpu_to_le32(FW_CTXT_ACTION_MODIFY),
-		.u.modify.old_sta_mask = cpu_to_le32(data->old_sta_mask),
-		.u.modify.new_sta_mask = cpu_to_le32(data->new_sta_mask),
-		.u.modify.key_id = cpu_to_le32(key->keyidx),
-		.u.modify.key_flags =
-			cpu_to_le32(iwl_mvm_get_sec_flags(mvm, vif, sta, key)),
-	};
-	int err;
-
-	/* only need to do this for pairwise keys (link_id == -1) */
-	if (sta != data->sta || key->link_id >= 0)
-		return;
-
-	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
-
-	if (err)
-		data->err = err;
-}
-
-int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta,
-				u32 old_sta_mask,
-				u32 new_sta_mask)
-{
-	struct iwl_mvm_sta_key_update_data data = {
-		.sta = sta,
-		.old_sta_mask = old_sta_mask,
-		.new_sta_mask = new_sta_mask,
-	};
-
-	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
-			    &data);
-	return data.err;
-}
-
 static int __iwl_mvm_sec_key_del(struct iwl_mvm *mvm, u32 sta_mask,
 				 u32 key_flags, u32 keyidx, u32 flags)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 896ed9823021..f1dbfeae20bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -886,133 +886,6 @@ static int iwl_mvm_mld_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
 }
 
-static int
-iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif,
-			     u16 old_links, u16 new_links,
-			     struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
-{
-	struct iwl_mvm_vif_link_info *new_link[IEEE80211_MLD_MAX_NUM_LINKS] = {};
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	u16 removed = old_links & ~new_links;
-	u16 added = new_links & ~old_links;
-	int err, i;
-
-	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-			break;
-
-		if (!(added & BIT(i)))
-			continue;
-		new_link[i] = kzalloc_obj(*new_link[i]);
-		if (!new_link[i]) {
-			err = -ENOMEM;
-			goto free;
-		}
-
-		new_link[i]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
-		iwl_mvm_init_link(new_link[i]);
-	}
-
-	mutex_lock(&mvm->mutex);
-
-	/* If we're in RESTART flow, the default link wasn't added in
-         * drv_add_interface(), and link[0] doesn't point to it.
-	 */
-	if (old_links == 0 && !test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
-					&mvm->status)) {
-		err = iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
-		if (err)
-			goto out_err;
-		mvmvif->link[0] = NULL;
-	}
-
-	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		if (removed & BIT(i)) {
-			struct ieee80211_bss_conf *link_conf = old[i];
-
-			err = iwl_mvm_disable_link(mvm, vif, link_conf);
-			if (err)
-				goto out_err;
-			kfree(mvmvif->link[i]);
-			mvmvif->link[i] = NULL;
-		} else if (added & BIT(i)) {
-			struct ieee80211_bss_conf *link_conf;
-
-			link_conf = link_conf_dereference_protected(vif, i);
-			if (WARN_ON(!link_conf))
-				continue;
-
-			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
-				      &mvm->status))
-				mvmvif->link[i] = new_link[i];
-			new_link[i] = NULL;
-			err = iwl_mvm_add_link(mvm, vif, link_conf);
-			if (err)
-				goto out_err;
-		}
-	}
-
-	err = 0;
-	if (new_links == 0) {
-		mvmvif->link[0] = &mvmvif->deflink;
-		err = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
-	}
-
-out_err:
-	/* we really don't have a good way to roll back here ... */
-	mutex_unlock(&mvm->mutex);
-
-free:
-	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
-		kfree(new_link[i]);
-	return err;
-}
-
-static int
-iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta,
-			     u16 old_links, u16 new_links)
-{
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-
-	guard(mvm)(mvm);
-	return iwl_mvm_mld_update_sta_links(mvm, vif, sta, old_links, new_links);
-}
-
-static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif,
-					   u16 desired_links)
-{
-	int n_links = hweight16(desired_links);
-
-	if (n_links <= 1)
-		return true;
-
-	WARN_ON(1);
-	return false;
-}
-
-static enum ieee80211_neg_ttlm_res
-iwl_mvm_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			 struct ieee80211_neg_ttlm *neg_ttlm)
-{
-	u16 map;
-	u8 i;
-
-	/* Verify all TIDs are mapped to the same links set */
-	map = neg_ttlm->downlink[0];
-	for (i = 0; i < IEEE80211_TTLM_NUM_TIDS; i++) {
-		if (neg_ttlm->downlink[i] != neg_ttlm->uplink[i] ||
-		    neg_ttlm->uplink[i] != map)
-			return NEG_TTLM_RES_REJECT;
-	}
-
-	return NEG_TTLM_RES_ACCEPT;
-}
-
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1102,9 +975,4 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.link_sta_add_debugfs = iwl_mvm_link_sta_add_debugfs,
 #endif
 	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
-
-	.change_vif_links = iwl_mvm_mld_change_vif_links,
-	.change_sta_links = iwl_mvm_mld_change_sta_links,
-	.can_activate_links = iwl_mvm_mld_can_activate_links,
-	.can_neg_ttlm = iwl_mvm_mld_can_neg_ttlm,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 3359e02e151f..44e16ee9514e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -913,288 +913,3 @@ void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 
 	rcu_read_unlock();
 }
-
-static int iwl_mvm_mld_update_sta_queues(struct iwl_mvm *mvm,
-					 struct ieee80211_sta *sta,
-					 u32 old_sta_mask,
-					 u32 new_sta_mask)
-{
-	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_scd_queue_cfg_cmd cmd = {
-		.operation = cpu_to_le32(IWL_SCD_QUEUE_MODIFY),
-		.u.modify.old_sta_mask = cpu_to_le32(old_sta_mask),
-		.u.modify.new_sta_mask = cpu_to_le32(new_sta_mask),
-	};
-	struct iwl_host_cmd hcmd = {
-		.id = WIDE_ID(DATA_PATH_GROUP, SCD_QUEUE_CONFIG_CMD),
-		.len[0] = sizeof(cmd),
-		.data[0] = &cmd
-	};
-	int tid;
-	int ret;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	for (tid = 0; tid <= IWL_MAX_TID_COUNT; tid++) {
-		struct iwl_mvm_tid_data *tid_data = &mvm_sta->tid_data[tid];
-		int txq_id = tid_data->txq_id;
-
-		if (txq_id == IWL_MVM_INVALID_QUEUE)
-			continue;
-
-		if (tid == IWL_MAX_TID_COUNT)
-			cmd.u.modify.tid = cpu_to_le32(IWL_MGMT_TID);
-		else
-			cmd.u.modify.tid = cpu_to_le32(tid);
-
-		ret = iwl_mvm_send_cmd(mvm, &hcmd);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
-					u32 old_sta_mask,
-					u32 new_sta_mask)
-{
-	struct iwl_rx_baid_cfg_cmd cmd = {
-		.action = cpu_to_le32(IWL_RX_BAID_ACTION_MODIFY),
-		.modify.old_sta_id_mask = cpu_to_le32(old_sta_mask),
-		.modify.new_sta_id_mask = cpu_to_le32(new_sta_mask),
-	};
-	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD);
-	int baid;
-
-	/* mac80211 will remove sessions later, but we ignore all that */
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		return 0;
-
-	BUILD_BUG_ON(sizeof(struct iwl_rx_baid_cfg_resp) != sizeof(baid));
-
-	for (baid = 0; baid < ARRAY_SIZE(mvm->baid_map); baid++) {
-		struct iwl_mvm_baid_data *data;
-		int ret;
-
-		data = rcu_dereference_protected(mvm->baid_map[baid],
-						 lockdep_is_held(&mvm->mutex));
-		if (!data)
-			continue;
-
-		if (!(data->sta_mask & old_sta_mask))
-			continue;
-
-		WARN_ONCE(data->sta_mask != old_sta_mask,
-			  "BAID data for %d corrupted - expected 0x%x found 0x%x\n",
-			  baid, old_sta_mask, data->sta_mask);
-
-		cmd.modify.tid = cpu_to_le32(data->tid);
-
-		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_SEND_IN_RFKILL,
-					   sizeof(cmd), &cmd);
-		data->sta_mask = new_sta_mask;
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int iwl_mvm_mld_update_sta_resources(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif,
-					    struct ieee80211_sta *sta,
-					    u32 old_sta_mask,
-					    u32 new_sta_mask)
-{
-	int ret;
-
-	ret = iwl_mvm_mld_update_sta_queues(mvm, sta,
-					    old_sta_mask,
-					    new_sta_mask);
-	if (ret)
-		return ret;
-
-	ret = iwl_mvm_mld_update_sta_keys(mvm, vif, sta,
-					  old_sta_mask,
-					  new_sta_mask);
-	if (ret)
-		return ret;
-
-	return iwl_mvm_mld_update_sta_baids(mvm, old_sta_mask, new_sta_mask);
-}
-
-int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta,
-				 u16 old_links, u16 new_links)
-{
-	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_link_sta *mvm_sta_link;
-	struct iwl_mvm_vif_link_info *mvm_vif_link;
-	unsigned long links_to_add = ~old_links & new_links;
-	unsigned long links_to_rem = old_links & ~new_links;
-	unsigned long old_links_long = old_links;
-	u32 current_sta_mask = 0, sta_mask_added = 0, sta_mask_to_rem = 0;
-	unsigned long link_sta_added_to_fw = 0, link_sta_allocated = 0;
-	unsigned int link_id;
-	int ret;
-
-	lockdep_assert_wiphy(mvm->hw->wiphy);
-	lockdep_assert_held(&mvm->mutex);
-
-	for_each_set_bit(link_id, &old_links_long,
-			 IEEE80211_MLD_MAX_NUM_LINKS) {
-		mvm_sta_link =
-			rcu_dereference_protected(mvm_sta->link[link_id],
-						  lockdep_is_held(&mvm->mutex));
-
-		if (WARN_ON(!mvm_sta_link)) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		current_sta_mask |= BIT(mvm_sta_link->sta_id);
-		if (links_to_rem & BIT(link_id))
-			sta_mask_to_rem |= BIT(mvm_sta_link->sta_id);
-	}
-
-	if (sta_mask_to_rem) {
-		ret = iwl_mvm_mld_update_sta_resources(mvm, vif, sta,
-						       current_sta_mask,
-						       current_sta_mask &
-							~sta_mask_to_rem);
-		if (WARN_ON(ret))
-			goto err;
-
-		current_sta_mask &= ~sta_mask_to_rem;
-	}
-
-	for_each_set_bit(link_id, &links_to_rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mvm_sta_link =
-			rcu_dereference_protected(mvm_sta->link[link_id],
-						  lockdep_is_held(&mvm->mutex));
-		mvm_vif_link = mvm_vif->link[link_id];
-
-		if (WARN_ON(!mvm_sta_link || !mvm_vif_link)) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		ret = iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_sta_link->sta_id);
-		if (WARN_ON(ret))
-			goto err;
-
-		if (vif->type == NL80211_IFTYPE_STATION)
-			mvm_vif_link->ap_sta_id = IWL_INVALID_STA;
-
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
-	}
-
-	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			link_conf_dereference_protected(vif, link_id);
-		struct ieee80211_link_sta *link_sta =
-			link_sta_dereference_protected(sta, link_id);
-		mvm_vif_link = mvm_vif->link[link_id];
-
-		if (WARN_ON(!mvm_vif_link || !link_conf || !link_sta)) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
-			struct iwl_mvm_link_sta *mvm_link_sta =
-				rcu_dereference_protected(mvm_sta->link[link_id],
-							  lockdep_is_held(&mvm->mutex));
-			u32 sta_id;
-
-			if (WARN_ON(!mvm_link_sta)) {
-				ret = -EINVAL;
-				goto err;
-			}
-
-			sta_id = mvm_link_sta->sta_id;
-
-			rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
-			rcu_assign_pointer(mvm->fw_id_to_link_sta[sta_id],
-					   link_sta);
-		} else {
-			if (WARN_ON(mvm_sta->link[link_id])) {
-				ret = -EINVAL;
-				goto err;
-			}
-			ret = iwl_mvm_mld_alloc_sta_link(mvm, vif, sta,
-							 link_id);
-			if (WARN_ON(ret))
-				goto err;
-		}
-
-		link_sta->agg.max_rc_amsdu_len = 1;
-		ieee80211_sta_recalc_aggregates(sta);
-
-		mvm_sta_link =
-			rcu_dereference_protected(mvm_sta->link[link_id],
-						  lockdep_is_held(&mvm->mutex));
-
-		if (WARN_ON(!mvm_sta_link)) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		if (vif->type == NL80211_IFTYPE_STATION)
-			iwl_mvm_mld_set_ap_sta_id(sta, mvm_vif_link,
-						  mvm_sta_link);
-
-		link_sta_allocated |= BIT(link_id);
-
-		sta_mask_added |= BIT(mvm_sta_link->sta_id);
-
-		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
-					  mvm_sta_link);
-		if (WARN_ON(ret))
-			goto err;
-
-		link_sta_added_to_fw |= BIT(link_id);
-
-		iwl_mvm_rs_add_sta_link(mvm, mvm_sta_link);
-
-		iwl_mvm_rs_rate_init(mvm, vif, sta, link_conf, link_sta,
-				     link_conf->chanreq.oper.chan->band);
-	}
-
-	if (sta_mask_added) {
-		ret = iwl_mvm_mld_update_sta_resources(mvm, vif, sta,
-						       current_sta_mask,
-						       current_sta_mask |
-							sta_mask_added);
-		if (WARN_ON(ret))
-			goto err;
-	}
-
-	return 0;
-
-err:
-	/* remove all already allocated stations in FW */
-	for_each_set_bit(link_id, &link_sta_added_to_fw,
-			 IEEE80211_MLD_MAX_NUM_LINKS) {
-		mvm_sta_link =
-			rcu_dereference_protected(mvm_sta->link[link_id],
-						  lockdep_is_held(&mvm->mutex));
-
-		iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_sta_link->sta_id);
-	}
-
-	/* remove all already allocated station links in driver */
-	for_each_set_bit(link_id, &link_sta_allocated,
-			 IEEE80211_MLD_MAX_NUM_LINKS) {
-		mvm_sta_link =
-			rcu_dereference_protected(mvm_sta->link[link_id],
-						  lockdep_is_held(&mvm->mutex));
-
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
-	}
-
-	return ret;
-}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 46a9dfa58a53..402ba5dee8b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2450,11 +2450,6 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       struct iwl_mvm_vif_link_info *link,
 			       unsigned int link_id);
-int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta,
-				u32 old_sta_mask,
-				u32 new_sta_mask);
 int iwl_mvm_mld_send_key(struct iwl_mvm *mvm, u32 sta_mask, u32 key_flags,
 			 struct ieee80211_key_conf *keyconf);
 u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index c25edc7c1813..ff099aec7886 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -637,10 +637,6 @@ void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
 			       struct iwl_mvm_link_sta *mvm_sta_link,
 			       unsigned int link_id);
 int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id);
-int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta,
-				 u16 old_links, u16 new_links);
 u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   int filter_link_id);
 int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
-- 
2.34.1


