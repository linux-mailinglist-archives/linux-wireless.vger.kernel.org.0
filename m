Return-Path: <linux-wireless+bounces-18972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE90A37373
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE30F16CE9E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144418DB13;
	Sun, 16 Feb 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyZ+gczK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45118DB02
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699020; cv=none; b=L7HWO3pRnXX6Od0poCCEuDcH2HgRdNamIH2HFrPGv9jeh6OsZr47zvxq2Xbpi+zKtf+vpDy8NMj28HI/V6ZCK5oViww14x65yAIeyTP1KKzBLKAaxdSvjMm8kgIBVjt8FsLoxk8DWjQSbgjwLxz9T8unQu5N9RNRyGB/4cJlg/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699020; c=relaxed/simple;
	bh=QGvKkaABqK5JOVgbQ+0slePqLj0ZGjBl+FVCy3GborA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlR3988cHpaKG9QRcY0Mdg1IEq3hRQ3zswnZKzgbiYMCvzQNB3uhXDPrBXl49VpMEzpBIcAMu6BM4+g4LQvKbo89rXrl1dfWb97W49W85BJ+bRcCvBUZc0nr0TIblXy5Bd+kzYU4+QVCA3LUcNNWLptu2G13oHWocG3ME1rlVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyZ+gczK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699018; x=1771235018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QGvKkaABqK5JOVgbQ+0slePqLj0ZGjBl+FVCy3GborA=;
  b=hyZ+gczKRGChlovVq3L7Vm4nUb18ITK39Cgg5EEpnPUHqhE7Lnh0uGrq
   4f/JLQ50LATWpLou5WIIoChjGQ8KcOOqFuNJWwCrLO9blBjUbMc9vmVpz
   wDrRBc8FDArHm3TUzNktA7em+CkHdx554fnfQPLqH6K/j+b7FZQebzd1v
   DkMa76NCBLjb9cA1E6GdX58zKxKap2Jr0goJx1sq8HMZ9KovuTaKloKrT
   qY4Cl9ZNyFuJgNeqhy3vPBQ0cbaOPLxHZOnomLv4CerwTky20pe4lp0NS
   B/kGTj1v6F48Bv9dNKlhgBor+LSJl2rxlAl0pMSs4GpACvbYTJt8fwGre
   w==;
X-CSE-ConnectionGUID: Bm2BkJ/PTIiSQUiE6RM+PQ==
X-CSE-MsgGUID: 0/gKo8YlSAmXa9F0ZIZYzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323345"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:38 -0800
X-CSE-ConnectionGUID: k5jhy6N/T/C/ABLzjJK17Q==
X-CSE-MsgGUID: Vd+jbE8rQES4D9fVcCY/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785191"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 02/42] wifi: iwlwifi: mld: add file ap.h/c
Date: Sun, 16 Feb 2025 11:42:41 +0200
Message-Id: <20250216111648.3e314e7524e8.Id953ec59e54d016f270edc4a3354bbd20464eefe@changeid>
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

this file handles ap related logic

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ap.c | 344 ++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/ap.h |  46 +++
 2 files changed, 390 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.c b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
new file mode 100644
index 000000000000..571eabd0b511
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <linux/crc32.h>
+
+#include <net/mac80211.h>
+
+#include "ap.h"
+#include "hcmd.h"
+#include "tx.h"
+#include "power.h"
+#include "key.h"
+#include "iwl-utils.h"
+
+#include "fw/api/sta.h"
+
+void iwl_mld_set_tim_idx(struct iwl_mld *mld, __le32 *tim_index,
+			 u8 *beacon, u32 frame_size)
+{
+	u32 tim_idx;
+	struct ieee80211_mgmt *mgmt = (void *)beacon;
+
+	/* The index is relative to frame start but we start looking at the
+	 * variable-length part of the beacon.
+	 */
+	tim_idx = mgmt->u.beacon.variable - beacon;
+
+	/* Parse variable-length elements of beacon to find WLAN_EID_TIM */
+	while ((tim_idx < (frame_size - 2)) &&
+	       (beacon[tim_idx] != WLAN_EID_TIM))
+		tim_idx += beacon[tim_idx + 1] + 2;
+
+	/* If TIM field was found, set variables */
+	if ((tim_idx < (frame_size - 1)) && beacon[tim_idx] == WLAN_EID_TIM)
+		*tim_index = cpu_to_le32(tim_idx);
+	else
+		IWL_WARN(mld, "Unable to find TIM Element in beacon\n");
+}
+
+u8 iwl_mld_get_rate_flags(struct iwl_mld *mld,
+			  struct ieee80211_tx_info *info,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link,
+			  enum nl80211_band band)
+{
+	u32 legacy = link->beacon_tx_rate.control[band].legacy;
+	u32 rate_idx, rate_flags = 0, fw_rate;
+
+	/* if beacon rate was configured try using it */
+	if (hweight32(legacy) == 1) {
+		u32 rate = ffs(legacy) - 1;
+		struct ieee80211_supported_band *sband =
+			mld->hw->wiphy->bands[band];
+
+		rate_idx = sband->bitrates[rate].hw_value;
+	} else {
+		rate_idx = iwl_mld_get_lowest_rate(mld, info, vif);
+	}
+
+	if (rate_idx <= IWL_LAST_CCK_RATE)
+		rate_flags = IWL_MAC_BEACON_CCK;
+
+	/* Legacy rates are indexed as follows:
+	 * 0 - 3 for CCK and 0 - 7 for OFDM.
+	 */
+	fw_rate = (rate_idx >= IWL_FIRST_OFDM_RATE ?
+		     rate_idx - IWL_FIRST_OFDM_RATE : rate_idx);
+
+	return fw_rate | rate_flags;
+}
+
+int iwl_mld_send_beacon_template_cmd(struct iwl_mld *mld,
+				     struct sk_buff *beacon,
+				     struct iwl_mac_beacon_cmd *cmd)
+{
+	struct iwl_host_cmd hcmd = {
+		.id = BEACON_TEMPLATE_CMD,
+	};
+
+	hcmd.len[0] = sizeof(*cmd);
+	hcmd.data[0] = cmd;
+
+	hcmd.len[1] = beacon->len;
+	hcmd.data[1] = beacon->data;
+	hcmd.dataflags[1] = IWL_HCMD_DFL_DUP;
+
+	return iwl_mld_send_cmd(mld, &hcmd);
+}
+
+static int iwl_mld_fill_beacon_template_cmd(struct iwl_mld *mld,
+					    struct ieee80211_vif *vif,
+					    struct sk_buff *beacon,
+					    struct iwl_mac_beacon_cmd *cmd,
+					    struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(beacon);
+	struct ieee80211_chanctx_conf *ctx;
+	bool enable_fils;
+	u16 flags = 0;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(!mld_link))
+		return -EINVAL;
+
+	cmd->link_id = cpu_to_le32(mld_link->fw_id);
+
+	ctx = wiphy_dereference(mld->wiphy, link->chanctx_conf);
+	if (WARN_ON(!ctx || !ctx->def.chan))
+		return -EINVAL;
+
+	enable_fils = cfg80211_channel_is_psc(ctx->def.chan) ||
+		(ctx->def.chan->band == NL80211_BAND_6GHZ &&
+		 ctx->def.width >= NL80211_CHAN_WIDTH_80);
+
+	if (enable_fils) {
+		flags |= IWL_MAC_BEACON_FILS;
+		cmd->short_ssid = cpu_to_le32(~crc32_le(~0, vif->cfg.ssid,
+							vif->cfg.ssid_len));
+	}
+
+	cmd->byte_cnt = cpu_to_le16((u16)beacon->len);
+
+	flags |= iwl_mld_get_rate_flags(mld, info, vif, link,
+					ctx->def.chan->band);
+
+	cmd->flags = cpu_to_le16(flags);
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		iwl_mld_set_tim_idx(mld, &cmd->tim_idx,
+				    beacon->data, beacon->len);
+
+		cmd->btwt_offset =
+			cpu_to_le32(iwl_find_ie_offset(beacon->data,
+						       WLAN_EID_S1G_TWT,
+						       beacon->len));
+	}
+
+	cmd->csa_offset =
+		cpu_to_le32(iwl_find_ie_offset(beacon->data,
+					       WLAN_EID_CHANNEL_SWITCH,
+					       beacon->len));
+	cmd->ecsa_offset =
+		cpu_to_le32(iwl_find_ie_offset(beacon->data,
+					       WLAN_EID_EXT_CHANSWITCH_ANN,
+					       beacon->len));
+
+	return 0;
+}
+
+/* The beacon template for the AP/GO/IBSS has changed and needs update */
+int iwl_mld_update_beacon_template(struct iwl_mld *mld,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf)
+{
+	struct iwl_mac_beacon_cmd cmd = {};
+	struct sk_buff *beacon;
+	int ret;
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+#endif
+
+	WARN_ON(vif->type != NL80211_IFTYPE_AP &&
+		vif->type != NL80211_IFTYPE_ADHOC);
+
+	if (IWL_MLD_NON_TRANSMITTING_AP)
+		return 0;
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	if (mld_vif->beacon_inject_active) {
+		IWL_DEBUG_INFO(mld,
+			       "Can't update template, beacon injection's active\n");
+		return -EBUSY;
+	}
+
+#endif
+	beacon = ieee80211_beacon_get_template(mld->hw, vif, NULL,
+					       link_conf->link_id);
+	if (!beacon)
+		return -ENOMEM;
+
+	ret = iwl_mld_fill_beacon_template_cmd(mld, vif, beacon, &cmd,
+					       link_conf);
+
+	if (!ret)
+		ret = iwl_mld_send_beacon_template_cmd(mld, beacon, &cmd);
+
+	dev_kfree_skb(beacon);
+
+	return ret;
+}
+
+void iwl_mld_free_ap_early_key(struct iwl_mld *mld,
+			       struct ieee80211_key_conf *key,
+			       struct iwl_mld_vif *mld_vif)
+{
+	struct iwl_mld_link *link;
+
+	if (WARN_ON(key->link_id < 0))
+		return;
+
+	link = iwl_mld_link_dereference_check(mld_vif, key->link_id);
+	if (WARN_ON(!link))
+		return;
+
+	for (int i = 0; i < ARRAY_SIZE(link->ap_early_keys); i++) {
+		if (link->ap_early_keys[i] != key)
+			continue;
+		/* Those weren't sent to FW, so should be marked as INVALID */
+		if (WARN_ON(key->hw_key_idx != STA_KEY_IDX_INVALID))
+			key->hw_key_idx = STA_KEY_IDX_INVALID;
+		link->ap_early_keys[i] = NULL;
+	}
+}
+
+int iwl_mld_store_ap_early_key(struct iwl_mld *mld,
+			       struct ieee80211_key_conf *key,
+			       struct iwl_mld_vif *mld_vif)
+{
+	struct iwl_mld_link *link;
+
+	if (WARN_ON(key->link_id < 0))
+		return -EINVAL;
+
+	link = iwl_mld_link_dereference_check(mld_vif, key->link_id);
+	if (WARN_ON(!link))
+		return -EINVAL;
+
+	for (int i = 0; i < ARRAY_SIZE(link->ap_early_keys); i++) {
+		if (!link->ap_early_keys[i]) {
+			link->ap_early_keys[i] = key;
+			return 0;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+static int iwl_mld_send_ap_early_keys(struct iwl_mld *mld,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	int ret = 0;
+
+	if (WARN_ON(!link))
+		return -EINVAL;
+
+	for (int i = 0; i < ARRAY_SIZE(mld_link->ap_early_keys); i++) {
+		struct ieee80211_key_conf *key = mld_link->ap_early_keys[i];
+
+		if (!key)
+			continue;
+
+		mld_link->ap_early_keys[i] = NULL;
+
+		ret = iwl_mld_add_key(mld, vif, NULL, key);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		iwl_mld_send_ap_tx_power_constraint_cmd(mld, vif, link);
+
+	ret = iwl_mld_update_beacon_template(mld, vif, link);
+	if (ret)
+		return ret;
+
+	/* the link should be already activated when assigning chan context,
+	 * and LINK_CONTEXT_MODIFY_EHT_PARAMS is deprecated
+	 */
+	ret = iwl_mld_change_link_in_fw(mld, link,
+					LINK_CONTEXT_MODIFY_ALL &
+					~(LINK_CONTEXT_MODIFY_ACTIVE |
+					  LINK_CONTEXT_MODIFY_EHT_PARAMS));
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_add_mcast_sta(mld, vif, link);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_add_bcast_sta(mld, vif, link);
+	if (ret)
+		goto rm_mcast;
+
+	/* Those keys were configured by the upper layers before starting the
+	 * AP. Now that it is started and the bcast and mcast sta were added to
+	 * the FW, we can add the keys too.
+	 */
+	ret = iwl_mld_send_ap_early_keys(mld, vif, link);
+	if (ret)
+		goto rm_bcast;
+
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_AP)
+		iwl_mld_vif_update_low_latency(mld, vif, true,
+					       LOW_LATENCY_VIF_TYPE);
+
+	mld_vif->ap_ibss_active = true;
+
+	if (vif->p2p && mld->p2p_device_vif)
+		return iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
+					     FW_CTXT_ACTION_MODIFY);
+
+	return 0;
+rm_bcast:
+	iwl_mld_remove_bcast_sta(mld, vif, link);
+rm_mcast:
+	iwl_mld_remove_mcast_sta(mld, vif, link);
+	return ret;
+}
+
+void iwl_mld_stop_ap_ibss(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	mld_vif->ap_ibss_active = false;
+
+	if (vif->p2p && mld->p2p_device_vif)
+		iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
+				      FW_CTXT_ACTION_MODIFY);
+
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_AP)
+		iwl_mld_vif_update_low_latency(mld, vif, false,
+					       LOW_LATENCY_VIF_TYPE);
+
+	iwl_mld_remove_bcast_sta(mld, vif, link);
+
+	iwl_mld_remove_mcast_sta(mld, vif, link);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.h b/drivers/net/wireless/intel/iwlwifi/mld/ap.h
new file mode 100644
index 000000000000..7d904cef4018
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.h
@@ -0,0 +1,46 @@
+
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_ap_h__
+#define __iwl_ap_h__
+
+#include "mld.h"
+#include "iface.h"
+
+#include "fw/api/tx.h"
+
+int iwl_mld_update_beacon_template(struct iwl_mld *mld,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf);
+
+int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link);
+
+void iwl_mld_stop_ap_ibss(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link);
+
+int iwl_mld_store_ap_early_key(struct iwl_mld *mld,
+			       struct ieee80211_key_conf *key,
+			       struct iwl_mld_vif *mld_vif);
+
+void iwl_mld_free_ap_early_key(struct iwl_mld *mld,
+			       struct ieee80211_key_conf *key,
+			       struct iwl_mld_vif *mld_vif);
+
+u8 iwl_mld_get_rate_flags(struct iwl_mld *mld,
+			  struct ieee80211_tx_info *info,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link,
+			  enum nl80211_band band);
+
+void iwl_mld_set_tim_idx(struct iwl_mld *mld, __le32 *tim_index,
+			 u8 *beacon, u32 frame_size);
+
+int iwl_mld_send_beacon_template_cmd(struct iwl_mld *mld,
+				     struct sk_buff *beacon,
+				     struct iwl_mac_beacon_cmd *cmd);
+
+#endif /* __iwl_ap_h__ */
-- 
2.34.1


