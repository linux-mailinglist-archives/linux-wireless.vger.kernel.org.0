Return-Path: <linux-wireless+bounces-18980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80EA3737D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387711888E0A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBC18DB16;
	Sun, 16 Feb 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/Xgu4MB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399118DB00
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699031; cv=none; b=DGtSOiNH6T4sCTFI4O0wMmfus3Twf3icUhHs7Cz+oDlV1eXuh4dWrcAsZUCRic0Vaaj5OU9lYC3y1vJyWG81kA/dDeC7y8nVJZYwjzp87mmHsnOCNJ6j/lYJ/AoOJX7R5jPqtCXq1kDMhZM4Pj4nkrUNJP3Ep9/9CZ6pwhPiS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699031; c=relaxed/simple;
	bh=6iKIba30iWoSB9BOkpfz3OqrUaQEKhNGZoPqy6XykZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYxFFucj/WmJt+BnWaXd74sSnwZi9SCHfpUv6c2ZAJQ8rQA/UC2xzF6DxiLQnTahkY7kEm9NKSVjOla1K9yZiHk/lfKhFAqoaUYVqKqkW+mbchN6xr2q0aGgq+5S0z4ifZhiRWEfQWDQo8ZprhCfP3BgRbuK05XgiyUgRqPBXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/Xgu4MB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699029; x=1771235029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6iKIba30iWoSB9BOkpfz3OqrUaQEKhNGZoPqy6XykZA=;
  b=h/Xgu4MBruhaIHVNWZuUvOUy3Gp97iV7JMeQXPr9rpD3JwGHjtwwYqbt
   EHkmKag49o7/f8Gdgf40mSEZJ4DdytwMUnrpqo5KoakbpbA67uILhR8wE
   5sFkL/XtJOe/MzL+oJDupZYiEpc1KTGOQvHkshJ53oeTCiGoguGvkXnfs
   6WS0+ADlhCyHdt7nME21pRY6sj7KHSKrN/deM1fTb38T2vzGOzJEG1t69
   exZwBpjiKw7GH7dXcxsFxu+pYbaxeitKt9PQ0weBbw2a/pBNzmsqI2IAz
   JmHuXw1hsqcmefby+etFfaYEq6SV7YqeYNF6mijNjwGD/Tqo+rXHyWv0i
   w==;
X-CSE-ConnectionGUID: CIqrMNWcQNiLooRFamjorw==
X-CSE-MsgGUID: DXnkZvM6T8ag00yRurBvNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323375"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323375"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:49 -0800
X-CSE-ConnectionGUID: gDv4oSJ1TdGu1lBvVPMc/g==
X-CSE-MsgGUID: AI7sG1KbRSGCDy5Q3O25WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785232"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 10/42] wifi: iwlwifi: mld: add file iface.h/c
Date: Sun, 16 Feb 2025 11:42:49 +0200
Message-Id: <20250216111648.2d9de839e5b1.Ibb83c6a99c67eaa21e74ffa0e83596468c2a65ca@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file is handling the driver-level vif object

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 671 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mld/iface.h    | 234 ++++++
 2 files changed, 905 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
new file mode 100644
index 000000000000..0d1803ab665e
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -0,0 +1,671 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#include <net/cfg80211.h>
+
+#include "iface.h"
+#include "hcmd.h"
+#include "key.h"
+#include "mlo.h"
+#include "mac80211.h"
+
+#include "fw/api/context.h"
+#include "fw/api/mac.h"
+#include "fw/api/time-event.h"
+#include "fw/api/datapath.h"
+
+/* Cleanup function for struct iwl_mld_vif, will be called in restart */
+void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld *mld = mld_vif->mld;
+	struct iwl_mld_link *link;
+
+	/* EMLSR is turned back on during recovery */
+	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
+
+	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
+
+	for_each_mld_vif_valid_link(mld_vif, link) {
+		iwl_mld_cleanup_link(mld_vif->mld, link);
+
+		/* Correctly allocated primary link in non-MLO mode */
+		if (!ieee80211_vif_is_mld(vif) &&
+		    link_id == 0 && link == &mld_vif->deflink)
+			continue;
+
+		if (vif->active_links & BIT(link_id))
+			continue;
+
+		/* Should not happen as link removal should always succeed */
+		WARN_ON(1);
+		if (link != &mld_vif->deflink)
+			kfree_rcu(link, rcu_head);
+		RCU_INIT_POINTER(mld_vif->link[link_id], NULL);
+	}
+
+	ieee80211_iter_keys(mld->hw, vif, iwl_mld_cleanup_keys_iter, NULL);
+
+	CLEANUP_STRUCT(mld_vif);
+}
+
+static int iwl_mld_send_mac_cmd(struct iwl_mld *mld,
+				struct iwl_mac_config_cmd *cmd)
+{
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP, MAC_CONFIG_CMD),
+				   cmd);
+	if (ret)
+		IWL_ERR(mld, "Failed to send MAC_CONFIG_CMD ret = %d\n", ret);
+
+	return ret;
+}
+
+int iwl_mld_mac80211_iftype_to_fw(const struct ieee80211_vif *vif)
+{
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		return vif->p2p ? FW_MAC_TYPE_P2P_STA : FW_MAC_TYPE_BSS_STA;
+	case NL80211_IFTYPE_AP:
+		return FW_MAC_TYPE_GO;
+	case NL80211_IFTYPE_MONITOR:
+		return FW_MAC_TYPE_LISTENER;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		return FW_MAC_TYPE_P2P_DEVICE;
+	case NL80211_IFTYPE_ADHOC:
+		return FW_MAC_TYPE_IBSS;
+	default:
+		WARN_ON_ONCE(1);
+	}
+	return FW_MAC_TYPE_BSS_STA;
+}
+
+static bool iwl_mld_is_nic_ack_enabled(struct iwl_mld *mld,
+				       struct ieee80211_vif *vif)
+{
+	const struct ieee80211_supported_band *sband;
+	const struct ieee80211_sta_he_cap *own_he_cap;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* This capability is the same for all bands,
+	 * so take it from one of them.
+	 */
+	sband = mld->hw->wiphy->bands[NL80211_BAND_2GHZ];
+	own_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
+
+	return own_he_cap && (own_he_cap->he_cap_elem.mac_cap_info[2] &
+			       IEEE80211_HE_MAC_CAP2_ACK_EN);
+}
+
+/* fill the common part for all interface types */
+static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
+					struct ieee80211_vif *vif,
+					struct iwl_mac_config_cmd *cmd,
+					u32 action)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	cmd->id_and_color = cpu_to_le32(mld_vif->fw_id);
+	cmd->action = cpu_to_le32(action);
+
+	cmd->mac_type =
+		cpu_to_le32(iwl_mld_mac80211_iftype_to_fw(vif));
+
+	memcpy(cmd->local_mld_addr, vif->addr, ETH_ALEN);
+
+	if (iwlwifi_mod_params.disable_11ax)
+		return;
+
+	cmd->nic_not_ack_enabled =
+		cpu_to_le32(!iwl_mld_is_nic_ack_enabled(mld, vif));
+
+	/* If we have MLO enabled, then the firmware needs to enable
+	 * address translation for the station(s) we add. That depends
+	 * on having EHT enabled in firmware, which in turn depends on
+	 * mac80211 in the code below.
+	 * However, mac80211 doesn't enable HE/EHT until it has parsed
+	 * the association response successfully, so just skip all that
+	 * and enable both when we have MLO.
+	 */
+	if (ieee80211_vif_is_mld(vif)) {
+		if (vif->type == NL80211_IFTYPE_AP)
+			cmd->he_ap_support = cpu_to_le16(1);
+		else
+			cmd->he_support = cpu_to_le16(1);
+
+		cmd->eht_support = cpu_to_le32(1);
+		return;
+	}
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		if (!link_conf->he_support)
+			continue;
+
+		if (vif->type == NL80211_IFTYPE_AP)
+			cmd->he_ap_support = cpu_to_le16(1);
+		else
+			cmd->he_support = cpu_to_le16(1);
+
+		/* EHT, if supported, was already set above */
+		break;
+	}
+}
+
+static void iwl_mld_fill_mac_cmd_sta(struct iwl_mld *mld,
+				     struct ieee80211_vif *vif, u32 action,
+				     struct iwl_mac_config_cmd *cmd)
+{
+	struct ieee80211_bss_conf *link;
+	u32 twt_policy = 0;
+	int link_id;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	WARN_ON(vif->type != NL80211_IFTYPE_STATION);
+
+	/* We always want to hear MCAST frames, if we're not authorized yet,
+	 * we'll drop them.
+	 */
+	cmd->filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_GRP);
+
+	/* Adding a MAC ctxt with is_assoc set is not allowed in fw
+	 * (and shouldn't happen)
+	 */
+	if (vif->cfg.assoc && action != FW_CTXT_ACTION_ADD) {
+		cmd->client.is_assoc = 1;
+
+		if (!iwl_mld_vif_from_mac80211(vif)->authorized)
+			cmd->client.data_policy |=
+				cpu_to_le16(COEX_HIGH_PRIORITY_ENABLE);
+	} else {
+		/* Allow beacons to pass through as long as we are not
+		 * associated
+		 */
+		cmd->filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_BEACON);
+	}
+
+	cmd->client.assoc_id = cpu_to_le16(vif->cfg.aid);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		u16 esr_transition_timeout =
+			u16_get_bits(vif->cfg.eml_cap,
+				     IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
+
+		cmd->client.esr_transition_timeout =
+			min_t(u16, IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU,
+			      esr_transition_timeout);
+		cmd->client.medium_sync_delay =
+			cpu_to_le16(vif->cfg.eml_med_sync_delay);
+	}
+
+	for_each_vif_active_link(vif, link, link_id) {
+		if (!link->he_support)
+			continue;
+
+		if (link->twt_requester)
+			twt_policy |= TWT_SUPPORTED;
+		if (link->twt_protected)
+			twt_policy |= PROTECTED_TWT_SUPPORTED;
+		if (link->twt_broadcast)
+			twt_policy |= BROADCAST_TWT_SUPPORTED;
+	}
+
+	if (!iwlwifi_mod_params.disable_11ax)
+		cmd->client.data_policy |= cpu_to_le16(twt_policy);
+
+	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
+		cmd->filter_flags |=
+			cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
+
+	if (vif->p2p)
+		cmd->client.ctwin =
+			cpu_to_le32(vif->bss_conf.p2p_noa_attr.oppps_ctwindow &
+				    IEEE80211_P2P_OPPPS_CTWINDOW_MASK);
+}
+
+static void iwl_mld_fill_mac_cmd_ap(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    struct iwl_mac_config_cmd *cmd)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	WARN_ON(vif->type != NL80211_IFTYPE_AP);
+
+	cmd->filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
+
+	/* in AP mode, pass beacons from other APs (needed for ht protection).
+	 * When there're no any associated station, which means that we are not
+	 * TXing anyway, don't ask FW to pass beacons to prevent unnecessary
+	 * wake-ups.
+	 */
+	if (mld_vif->num_associated_stas)
+		cmd->filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_BEACON);
+}
+
+static void iwl_mld_go_iterator(void *_data, u8 *mac, struct ieee80211_vif *vif)
+{
+	bool *go_active = _data;
+
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_P2P_GO &&
+	    iwl_mld_vif_from_mac80211(vif)->ap_ibss_active)
+		*go_active = true;
+}
+
+static bool iwl_mld_p2p_dev_has_extended_disc(struct iwl_mld *mld)
+{
+	bool go_active = false;
+
+	/* This flag should be set to true when the P2P Device is
+	 * discoverable and there is at least a P2P GO. Setting
+	 * this flag will allow the P2P Device to be discoverable on other
+	 * channels in addition to its listen channel.
+	 * Note that this flag should not be set in other cases as it opens the
+	 * Rx filters on all MAC and increases the number of interrupts.
+	 */
+	ieee80211_iterate_active_interfaces(mld->hw,
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					iwl_mld_go_iterator, &go_active);
+
+	return go_active;
+}
+
+static void iwl_mld_fill_mac_cmd_p2p_dev(struct iwl_mld *mld,
+					 struct ieee80211_vif *vif,
+					 struct iwl_mac_config_cmd *cmd)
+{
+	bool ext_disc = iwl_mld_p2p_dev_has_extended_disc(mld);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* Override the filter flags to accept all management frames. This is
+	 * needed to support both P2P device discovery using probe requests and
+	 * P2P service discovery using action frames
+	 */
+	cmd->filter_flags = cpu_to_le32(MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT);
+
+	if (ext_disc)
+		cmd->p2p_dev.is_disc_extended = cpu_to_le32(1);
+}
+
+static void iwl_mld_fill_mac_cmd_ibss(struct iwl_mld *mld,
+				      struct ieee80211_vif *vif,
+				      struct iwl_mac_config_cmd *cmd)
+{
+	lockdep_assert_wiphy(mld->wiphy);
+
+	WARN_ON(vif->type != NL80211_IFTYPE_ADHOC);
+
+	cmd->filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_BEACON |
+					 MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
+					 MAC_CFG_FILTER_ACCEPT_GRP);
+}
+
+static int
+iwl_mld_rm_mac_from_fw(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mac_config_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.id_and_color = cpu_to_le32(mld_vif->fw_id),
+	};
+
+	return iwl_mld_send_mac_cmd(mld, &cmd);
+}
+
+int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			  u32 action)
+{
+	struct iwl_mac_config_cmd cmd = {};
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (action == FW_CTXT_ACTION_REMOVE)
+		return iwl_mld_rm_mac_from_fw(mld, vif);
+
+	iwl_mld_mac_cmd_fill_common(mld, vif, &cmd, action);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		iwl_mld_fill_mac_cmd_sta(mld, vif, action, &cmd);
+		break;
+	case NL80211_IFTYPE_AP:
+		iwl_mld_fill_mac_cmd_ap(mld, vif, &cmd);
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		cmd.filter_flags =
+			cpu_to_le32(MAC_CFG_FILTER_PROMISC |
+				    MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT |
+				    MAC_CFG_FILTER_ACCEPT_BEACON |
+				    MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
+				    MAC_CFG_FILTER_ACCEPT_GRP);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		iwl_mld_fill_mac_cmd_p2p_dev(mld, vif, &cmd);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		iwl_mld_fill_mac_cmd_ibss(mld, vif, &cmd);
+		break;
+	default:
+		WARN(1, "not supported yet\n");
+		return -EOPNOTSUPP;
+	}
+
+	return iwl_mld_send_mac_cmd(mld, &cmd);
+}
+
+IWL_MLD_ALLOC_FN(vif, vif)
+
+/* Constructor function for struct iwl_mld_vif */
+static int
+iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	mld_vif->mld = mld;
+	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
+
+	ret = iwl_mld_allocate_vif_fw_id(mld, &mld_vif->fw_id, vif);
+	if (ret)
+		return ret;
+
+	if (!mld->fw_status.in_hw_restart) {
+		wiphy_work_init(&mld_vif->emlsr.unblock_tpt_wk,
+				iwl_mld_emlsr_unblock_tpt_wk);
+		wiphy_delayed_work_init(&mld_vif->emlsr.check_tpt_wk,
+					iwl_mld_emlsr_check_tpt);
+		wiphy_delayed_work_init(&mld_vif->emlsr.prevent_done_wk,
+					iwl_mld_emlsr_prevent_done_wk);
+		wiphy_delayed_work_init(&mld_vif->emlsr.tmp_non_bss_done_wk,
+					iwl_mld_emlsr_tmp_non_bss_done_wk);
+	}
+
+	return 0;
+}
+
+int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_init_vif(mld, vif);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_ADD);
+	if (ret)
+		RCU_INIT_POINTER(mld->fw_id_to_vif[mld_vif->fw_id], NULL);
+
+	return ret;
+}
+
+int iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_REMOVE);
+
+	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld->fw_id_to_vif)))
+		return -EINVAL;
+
+	RCU_INIT_POINTER(mld->fw_id_to_vif[mld_vif->fw_id], NULL);
+
+	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_VIF,
+					       mld_vif->fw_id);
+
+	return ret;
+}
+
+void iwl_mld_set_vif_associated(struct iwl_mld *mld,
+				struct ieee80211_vif *vif)
+{
+	struct ieee80211_bss_conf *link;
+	unsigned int link_id;
+
+	for_each_vif_active_link(vif, link, link_id) {
+		if (iwl_mld_link_set_associated(mld, vif, link))
+			IWL_ERR(mld, "failed to update link %d\n", link_id);
+	}
+
+	iwl_mld_recalc_multicast_filter(mld);
+}
+
+static void iwl_mld_get_fw_id_bss_bitmap_iter(void *_data, u8 *mac,
+					      struct ieee80211_vif *vif)
+{
+	u8 *fw_id_bitmap = _data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION)
+		return;
+
+	*fw_id_bitmap |= BIT(mld_vif->fw_id);
+}
+
+u8 iwl_mld_get_fw_bss_vifs_ids(struct iwl_mld *mld)
+{
+	u8 fw_id_bitmap = 0;
+
+	ieee80211_iterate_interfaces(mld->hw,
+				     IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
+				     iwl_mld_get_fw_id_bss_bitmap_iter,
+				     &fw_id_bitmap);
+
+	return fw_id_bitmap;
+}
+
+void iwl_mld_handle_probe_resp_data_notif(struct iwl_mld *mld,
+					  struct iwl_rx_packet *pkt)
+{
+	const struct iwl_probe_resp_data_notif *notif = (void *)pkt->data;
+	struct iwl_probe_resp_data *old_data, *new_data;
+	struct ieee80211_vif *vif;
+	struct iwl_mld_link *mld_link;
+
+	IWL_DEBUG_INFO(mld, "Probe response data notif: noa %d, csa %d\n",
+		       notif->noa_active, notif->csa_counter);
+
+	if (IWL_FW_CHECK(mld, le32_to_cpu(notif->mac_id) >=
+			 ARRAY_SIZE(mld->fw_id_to_vif),
+			 "mac id is invalid: %d\n",
+			 le32_to_cpu(notif->mac_id)))
+		return;
+
+	vif = wiphy_dereference(mld->wiphy,
+				mld->fw_id_to_vif[le32_to_cpu(notif->mac_id)]);
+
+	/* the firmware gives us the mac_id (and not the link_id), mac80211
+	 * gets a vif and not a link, bottom line, this flow is not MLD ready
+	 * yet.
+	 */
+	if (WARN_ON(!vif) || ieee80211_vif_is_mld(vif))
+		return;
+
+	if (notif->csa_counter != IWL_PROBE_RESP_DATA_NO_CSA &&
+	    notif->csa_counter >= 1)
+		ieee80211_beacon_set_cntdwn(vif, notif->csa_counter);
+
+	if (!vif->p2p)
+		return;
+
+	mld_link = &iwl_mld_vif_from_mac80211(vif)->deflink;
+
+	new_data = kzalloc(sizeof(*new_data), GFP_KERNEL);
+	if (!new_data)
+		return;
+
+	memcpy(&new_data->notif, notif, sizeof(new_data->notif));
+
+	/* noa_attr contains 1 reserved byte, need to substruct it */
+	new_data->noa_len = sizeof(struct ieee80211_vendor_ie) +
+			    sizeof(new_data->notif.noa_attr) - 1;
+
+	/*
+	 * If it's a one time NoA, only one descriptor is needed,
+	 * adjust the length according to len_low.
+	 */
+	if (new_data->notif.noa_attr.len_low ==
+	    sizeof(struct ieee80211_p2p_noa_desc) + 2)
+		new_data->noa_len -= sizeof(struct ieee80211_p2p_noa_desc);
+
+	old_data = wiphy_dereference(mld->wiphy, mld_link->probe_resp_data);
+	rcu_assign_pointer(mld_link->probe_resp_data, new_data);
+
+	if (old_data)
+		kfree_rcu(old_data, rcu_head);
+}
+
+void iwl_mld_handle_uapsd_misbehaving_ap_notif(struct iwl_mld *mld,
+					       struct iwl_rx_packet *pkt)
+{
+	struct iwl_uapsd_misbehaving_ap_notif *notif = (void *)pkt->data;
+	struct ieee80211_vif *vif;
+
+	if (IWL_FW_CHECK(mld, notif->mac_id >= ARRAY_SIZE(mld->fw_id_to_vif),
+			 "mac id is invalid: %d\n", notif->mac_id))
+		return;
+
+	vif = wiphy_dereference(mld->wiphy, mld->fw_id_to_vif[notif->mac_id]);
+
+	if (WARN_ON(!vif) || ieee80211_vif_is_mld(vif))
+		return;
+
+	IWL_WARN(mld, "uapsd misbehaving AP: %pM\n", vif->bss_conf.bssid);
+}
+
+void iwl_mld_handle_datapath_monitor_notif(struct iwl_mld *mld,
+					   struct iwl_rx_packet *pkt)
+{
+	struct iwl_datapath_monitor_notif *notif = (void *)pkt->data;
+	struct ieee80211_bss_conf *link;
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_vif *vif;
+	struct iwl_mld_vif *mld_vif;
+
+	if (notif->type != cpu_to_le32(IWL_DP_MON_NOTIF_TYPE_EXT_CCA))
+		return;
+
+	link = iwl_mld_fw_id_to_link_conf(mld, notif->link_id);
+	if (WARN_ON(!link))
+		return;
+
+	vif = link->vif;
+	if (WARN_ON(!vif) || vif->type != NL80211_IFTYPE_STATION ||
+	    !vif->cfg.assoc)
+		return;
+
+	if (!link->chanreq.oper.chan ||
+	    link->chanreq.oper.chan->band != NL80211_BAND_2GHZ ||
+	    link->chanreq.oper.width < NL80211_CHAN_WIDTH_40)
+		return;
+
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	/* this shouldn't happen *again*, ignore it */
+	if (mld_vif->cca_40mhz_workaround != CCA_40_MHZ_WA_NONE)
+		return;
+
+	mld_vif->cca_40mhz_workaround = CCA_40_MHZ_WA_RECONNECT;
+
+	/*
+	 * This capability manipulation isn't really ideal, but it's the
+	 * easiest choice - otherwise we'd have to do some major changes
+	 * in mac80211 to support this, which isn't worth it. This does
+	 * mean that userspace may have outdated information, but that's
+	 * actually not an issue at all.
+	 */
+	sband = mld->wiphy->bands[NL80211_BAND_2GHZ];
+
+	WARN_ON(!sband->ht_cap.ht_supported);
+	WARN_ON(!(sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40));
+	sband->ht_cap.cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
+
+	if (he_cap) {
+		/* we know that ours is writable */
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;
+
+		WARN_ON(!he->has_he);
+		WARN_ON(!(he->he_cap_elem.phy_cap_info[0] &
+			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G));
+		he->he_cap_elem.phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+	}
+
+	ieee80211_disconnect(vif, true);
+}
+
+void iwl_mld_reset_cca_40mhz_workaround(struct iwl_mld *mld,
+					struct ieee80211_vif *vif)
+{
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (mld_vif->cca_40mhz_workaround == CCA_40_MHZ_WA_NONE)
+		return;
+
+	/* Now we are just reconnecting with the new capabilities,
+	 * but remember to reset the capabilities when we disconnect for real
+	 */
+	if (mld_vif->cca_40mhz_workaround == CCA_40_MHZ_WA_RECONNECT) {
+		mld_vif->cca_40mhz_workaround = CCA_40_MHZ_WA_RESET;
+		return;
+	}
+
+	/* Now cca_40mhz_workaround == CCA_40_MHZ_WA_RESET */
+
+	sband = mld->wiphy->bands[NL80211_BAND_2GHZ];
+
+	sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
+
+	if (he_cap) {
+		/* we know that ours is writable */
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;
+
+		he->he_cap_elem.phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+	}
+
+	mld_vif->cca_40mhz_workaround = CCA_40_MHZ_WA_NONE;
+}
+
+struct ieee80211_vif *iwl_mld_get_bss_vif(struct iwl_mld *mld)
+{
+	unsigned long fw_id_bitmap = iwl_mld_get_fw_bss_vifs_ids(mld);
+	int fw_id;
+
+	if (hweight8(fw_id_bitmap) != 1)
+		return NULL;
+
+	fw_id = __ffs(fw_id_bitmap);
+
+	return wiphy_dereference(mld->wiphy,
+				 mld->fw_id_to_vif[fw_id]);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
new file mode 100644
index 000000000000..7d0dfbe0ab48
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifndef __iwl_mld_iface_h__
+#define __iwl_mld_iface_h__
+
+#include <net/mac80211.h>
+
+#include "link.h"
+#include "session-protect.h"
+#include "d3.h"
+
+enum iwl_mld_cca_40mhz_wa_status {
+	CCA_40_MHZ_WA_NONE,
+	CCA_40_MHZ_WA_RESET,
+	CCA_40_MHZ_WA_RECONNECT,
+};
+
+/**
+ * enum iwl_mld_emlsr_blocked - defines reasons for which EMLSR is blocked
+ *
+ * These blocks are applied/stored per-VIF.
+ *
+ * @IWL_MLD_EMLSR_BLOCKED_PREVENTION: Prevent repeated EMLSR enter/exit
+ * @IWL_MLD_EMLSR_BLOCKED_WOWLAN: WOWLAN is preventing EMLSR
+ * @IWL_MLD_EMLSR_BLOCKED_FW: FW did not recommend MLO
+ * @IWL_MLD_EMLSR_BLOCKED_ROC: remain-on-channel is preventing EMLSR
+ * @IWL_MLD_EMLSR_BLOCKED_NON_BSS: An active non-BSS interface's link is
+ *      preventing EMLSR
+ * @IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS: An expected active non-BSS interface's
+ *      link is preventing EMLSR. This is a temporary blocking that is set when
+ *      there is an indication that a non-BSS interface is to be added.
+ * @IWL_MLD_EMLSR_BLOCKED_TPT: throughput is too low to make EMLSR worthwhile
+ */
+enum iwl_mld_emlsr_blocked {
+	IWL_MLD_EMLSR_BLOCKED_PREVENTION	= 0x1,
+	IWL_MLD_EMLSR_BLOCKED_WOWLAN		= 0x2,
+	IWL_MLD_EMLSR_BLOCKED_FW		= 0x4,
+	IWL_MLD_EMLSR_BLOCKED_ROC		= 0x8,
+	IWL_MLD_EMLSR_BLOCKED_NON_BSS		= 0x10,
+	IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS	= 0x20,
+	IWL_MLD_EMLSR_BLOCKED_TPT		= 0x40,
+};
+
+/**
+ * enum iwl_mld_emlsr_exit - defines reasons for exiting EMLSR
+ *
+ * Reasons to exit EMLSR may be either link specific or even specific to a
+ * combination of links.
+ *
+ * @IWL_MLD_EMLSR_EXIT_BLOCK: Exit due to a block reason being set
+ * @IWL_MLD_EMLSR_EXIT_MISSED_BEACON: Exit due to missed beacons
+ * @IWL_MLD_EMLSR_EXIT_FAIL_ENTRY: FW failed to enter EMLSR
+ * @IWL_MLD_EMLSR_EXIT_CSA: EMLSR prevented due to channel switch on link
+ * @IWL_MLD_EMLSR_EXIT_EQUAL_BAND: EMLSR prevented as both links share the band
+ * @IWL_MLD_EMLSR_EXIT_BANDWIDTH: Bandwidths of primary and secondary links are
+ *      not equal
+ * @IWL_MLD_EMLSR_EXIT_LOW_RSSI: Link RSSI is unsuitable for EMLSR
+ * @IWL_MLD_EMLSR_EXIT_LINK_USAGE: Exit EMLSR due to low TPT on secondary link
+ * @IWL_MLD_EMLSR_EXIT_BT_COEX: Exit EMLSR due to BT coexistence
+ * @IWL_MLD_EMLSR_EXIT_CHAN_LOAD: Exit EMLSR because the primary channel is not
+ *	loaded enough to justify EMLSR.
+ * @IWL_MLD_EMLSR_EXIT_RFI: Exit EMLSR due to RFI
+ */
+enum iwl_mld_emlsr_exit {
+	IWL_MLD_EMLSR_EXIT_BLOCK		= 0x1,
+	IWL_MLD_EMLSR_EXIT_MISSED_BEACON	= 0x2,
+	IWL_MLD_EMLSR_EXIT_FAIL_ENTRY		= 0x4,
+	IWL_MLD_EMLSR_EXIT_CSA			= 0x8,
+	IWL_MLD_EMLSR_EXIT_EQUAL_BAND		= 0x10,
+	IWL_MLD_EMLSR_EXIT_BANDWIDTH		= 0x20,
+	IWL_MLD_EMLSR_EXIT_LOW_RSSI		= 0x40,
+	IWL_MLD_EMLSR_EXIT_LINK_USAGE		= 0x80,
+	IWL_MLD_EMLSR_EXIT_BT_COEX		= 0x100,
+	IWL_MLD_EMLSR_EXIT_CHAN_LOAD		= 0x200,
+	IWL_MLD_EMLSR_EXIT_RFI			= 0x400,
+};
+
+/**
+ * struct iwl_mld_emlsr - per-VIF data about EMLSR operation
+ *
+ * @primary: The current primary link
+ * @selected_primary: Primary link as selected during the last link selection
+ * @selected_links: Links as selected during the last link selection
+ * @blocked_reasons: Reasons preventing EMLSR from being enabled
+ * @last_exit_reason: Reason for the last EMLSR exit
+ * @last_exit_ts: Time of the last EMLSR exit (if @last_exit_reason is non-zero)
+ * @exit_repeat_count: Number of times EMLSR was exited for the same reason
+ * @unblock_tpt_wk: Unblock EMLSR because the throughput limit was reached
+ * @check_tpt_wk: a worker to check if IWL_MLD_EMLSR_BLOCKED_TPT should be
+ *	added, for example if there is no longer enough traffic.
+ * @prevent_done_wk: Worker to remove %IWL_MLD_EMLSR_BLOCKED_PREVENTION
+ * @tmp_non_bss_done_wk: Worker to remove %IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS
+ */
+struct iwl_mld_emlsr {
+	struct_group(zeroed_on_not_authorized,
+		u8 primary;
+
+		u8 selected_primary;
+		u16 selected_links;
+
+		enum iwl_mld_emlsr_blocked blocked_reasons;
+
+		enum iwl_mld_emlsr_exit last_exit_reason;
+		unsigned long last_exit_ts;
+		u8 exit_repeat_count;
+	);
+
+	struct wiphy_work unblock_tpt_wk;
+	struct wiphy_delayed_work check_tpt_wk;
+
+	struct wiphy_delayed_work prevent_done_wk;
+	struct wiphy_delayed_work tmp_non_bss_done_wk;
+};
+
+/**
+ * struct iwl_mld_vif - virtual interface (MAC context) configuration parameters
+ *
+ * @fw_id: fw id of the mac context.
+ * @session_protect: session protection parameters
+ * @ap_sta: pointer to AP sta, for easier access to it.
+ *	Relevant only for STA vifs.
+ * @authorized: indicates the AP station was set to authorized
+ * @bigtks: BIGTKs of the AP, for beacon protection.
+ *	Only valid for STA. (FIXME: needs to be per link)
+ * @num_associated_stas: number of associated STAs. Relevant only for AP mode.
+ * @ap_ibss_active: whether the AP/IBSS was started
+ * @roc_activity: the id of the roc_activity running. Relevant for p2p device
+ *	only. Set to %ROC_NUM_ACTIVITIES when not in use.
+ * @cca_40mhz_workaround: When we are connected in 2.4 GHz and 40 MHz, and the
+ *	environment is too loaded, we work around this by reconnecting to the
+ *	same AP with 20 MHz. This manages the status of the workaround.
+ * @beacon_inject_active: indicates an active debugfs beacon ie injection
+ * @low_latency_causes: bit flags, indicating the causes for low-latency,
+ *	see @iwl_mld_low_latency_cause.
+ * @mld: pointer to the mld structure.
+ * @deflink: default link data, for use in non-MLO,
+ * @link: reference to link data for each valid link, for use in MLO.
+ * @emlsr: information related to EMLSR
+ * @wowlan_data: data used by the wowlan suspend flow
+ * @use_ps_poll: use ps_poll frames
+ * @disable_bf: disable beacon filter
+ * @dbgfs_slink: debugfs symlink for this interface
+ */
+struct iwl_mld_vif {
+	/* Add here fields that need clean up on restart */
+	struct_group(zeroed_on_hw_restart,
+		u8 fw_id;
+		struct iwl_mld_session_protect session_protect;
+		struct ieee80211_sta *ap_sta;
+		bool authorized;
+		struct ieee80211_key_conf __rcu *bigtks[2];
+		u8 num_associated_stas;
+		bool ap_ibss_active;
+		u32 roc_activity;
+		enum iwl_mld_cca_40mhz_wa_status cca_40mhz_workaround;
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+		bool beacon_inject_active;
+#endif
+		u8 low_latency_causes;
+	);
+	/* And here fields that survive a fw restart */
+	struct iwl_mld *mld;
+	struct iwl_mld_link deflink;
+	struct iwl_mld_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	struct iwl_mld_emlsr emlsr;
+
+#if CONFIG_PM_SLEEP
+	struct iwl_mld_wowlan_data wowlan_data;
+#endif
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	bool use_ps_poll;
+	bool disable_bf;
+	struct dentry *dbgfs_slink;
+#endif
+};
+
+static inline struct iwl_mld_vif *
+iwl_mld_vif_from_mac80211(struct ieee80211_vif *vif)
+{
+	return (void *)vif->drv_priv;
+}
+
+#define iwl_mld_link_dereference_check(mld_vif, link_id)		\
+	rcu_dereference_check((mld_vif)->link[link_id],			\
+			      lockdep_is_held(&mld_vif->mld->wiphy->mtx))
+
+#define for_each_mld_vif_valid_link(mld_vif, mld_link)			\
+	for (int link_id = 0; link_id < ARRAY_SIZE((mld_vif)->link);	\
+	     link_id++)							\
+		if ((mld_link = iwl_mld_link_dereference_check(mld_vif, link_id)))
+
+/* Retrieve pointer to mld link from mac80211 structures */
+static inline struct iwl_mld_link *
+iwl_mld_link_from_mac80211(struct ieee80211_bss_conf *bss_conf)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
+
+	return iwl_mld_link_dereference_check(mld_vif, bss_conf->link_id);
+}
+
+int iwl_mld_mac80211_iftype_to_fw(const struct ieee80211_vif *vif);
+
+/* Cleanup function for struct iwl_mld_vif, will be called in restart */
+void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif);
+int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			  u32 action);
+int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
+int iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
+void iwl_mld_set_vif_associated(struct iwl_mld *mld,
+				struct ieee80211_vif *vif);
+u8 iwl_mld_get_fw_bss_vifs_ids(struct iwl_mld *mld);
+void iwl_mld_handle_probe_resp_data_notif(struct iwl_mld *mld,
+					  struct iwl_rx_packet *pkt);
+
+void iwl_mld_handle_datapath_monitor_notif(struct iwl_mld *mld,
+					   struct iwl_rx_packet *pkt);
+
+void iwl_mld_handle_uapsd_misbehaving_ap_notif(struct iwl_mld *mld,
+					       struct iwl_rx_packet *pkt);
+
+void iwl_mld_reset_cca_40mhz_workaround(struct iwl_mld *mld,
+					struct ieee80211_vif *vif);
+
+static inline bool iwl_mld_vif_low_latency(const struct iwl_mld_vif *mld_vif)
+{
+	return !!mld_vif->low_latency_causes;
+}
+
+struct ieee80211_vif *iwl_mld_get_bss_vif(struct iwl_mld *mld);
+
+#endif /* __iwl_mld_iface_h__ */
-- 
2.34.1


