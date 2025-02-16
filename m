Return-Path: <linux-wireless+bounces-18983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00883A37380
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F7188BCB5
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BFC18DB15;
	Sun, 16 Feb 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6Fk2a5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0918DB19
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699035; cv=none; b=nOkwgGv8xiQWBM2cfJ+/KC0yHVuqRvCSGl25b8+KhubSuSsJYosblSSG4VtR4TY4Ctn1uY1w6HGJiVtR0RHged+5t2L80jjr/gg31e/wO/7KFS/Ap3vqfmDRYL9tkkffuYx34dsuHdG6Mgq7gTyo8iXZdwxuYOB/06Q8GLEqvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699035; c=relaxed/simple;
	bh=p/u5oOW992CCaEinwIrRHF/oIpMLfAXSmG1KeCxBiSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcrqrQFwN02BELEwrqMFmcvpCmmWprtLwFfEFt+20YWHLqdqqS0QVoe809Mg2XXVk+GzRy8B4CpOmlAhcDncR5I2E1nJ7PIGJACg9xNbfxxe5PUjO28ZsxiEhZjGWUiLtSFdVc3QncOZ/9CMMeL3tchnkFMLDx7G6+Bp3e1SXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6Fk2a5P; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699033; x=1771235033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/u5oOW992CCaEinwIrRHF/oIpMLfAXSmG1KeCxBiSs=;
  b=H6Fk2a5PZlJiufk5VzNJtCPO/5jvYJjJXGnQDCtp5hzTWgbpu7QY+oNY
   X3qgsebAAv7lR8rf7BHy3pT/Nx1pKJVDjEhzBnnyGXw55s8inIyymI3qS
   OqaVP9RvDZ3C54MfxSV2qzI6kfVAp17mhrUGPsXH05qBimQCcl4X7Lmv+
   w/3Sjpj7ce+iuXxdxxgohhuWcsE8WUGs0VPJAu6zcQ5nfktDWC0a2Yepk
   YEKkoaC9fFawgvWYUha2jIIglmwLEjeRJHH0ucO4nPMLpUCebHHaqHQr0
   ZE7DUmMMSYqK0ey0WAD27gutPRQD0+hdEeLTZLThWZ6rHMZb31kjE/JKu
   w==;
X-CSE-ConnectionGUID: y3v7rQOfRhmijZEV13lhBw==
X-CSE-MsgGUID: S2jVP0icRGCwzAOjx+qqyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323382"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323382"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:53 -0800
X-CSE-ConnectionGUID: b5LDysHERP6ObXSgjUVQ2Q==
X-CSE-MsgGUID: o54ocTaMTYKTfgiUf58VbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785239"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 13/42] wifi: iwlwifi: mld: add file link.h/c
Date: Sun, 16 Feb 2025 11:42:52 +0200
Message-Id: <20250216111648.695c36b2e2f6.I3e2cadbe5ec2f18cfff874dd00ada616d7f5e9b1@changeid>
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

this file is handling the driver-level link object

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 1216 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  153 +++
 2 files changed, 1369 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
new file mode 100644
index 000000000000..64ebafc35c9b
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -0,0 +1,1216 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include "constants.h"
+#include "link.h"
+#include "iface.h"
+#include "mlo.h"
+#include "hcmd.h"
+#include "phy.h"
+#include "fw/api/rs.h"
+#include "fw/api/txq.h"
+#include "fw/api/mac.h"
+
+#include "fw/api/context.h"
+#include "fw/dbg.h"
+
+static int iwl_mld_send_link_cmd(struct iwl_mld *mld,
+				 struct iwl_link_config_cmd *cmd,
+				 enum iwl_ctxt_action action)
+{
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	cmd->action = cpu_to_le32(action);
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP, LINK_CONFIG_CMD),
+				   cmd);
+	if (ret)
+		IWL_ERR(mld, "Failed to send LINK_CONFIG_CMD (action:%d): %d\n",
+			action, ret);
+	return ret;
+}
+
+static int iwl_mld_add_link_to_fw(struct iwl_mld *mld,
+				  struct ieee80211_bss_conf *link_conf)
+{
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(link_conf);
+	struct iwl_link_config_cmd cmd = {};
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(!link))
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(link->fw_id);
+	cmd.mac_id = cpu_to_le32(mld_vif->fw_id);
+	cmd.spec_link_id = link_conf->link_id;
+	cmd.phy_id = cpu_to_le32(FW_CTXT_ID_INVALID);
+
+	ether_addr_copy(cmd.local_link_addr, link_conf->addr);
+
+	if (vif->type == NL80211_IFTYPE_ADHOC && link_conf->bssid)
+		ether_addr_copy(cmd.ibss_bssid_addr, link_conf->bssid);
+
+	return iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_ADD);
+}
+
+/* Get the basic rates of the used band and add the mandatory ones */
+static void iwl_mld_fill_rates(struct iwl_mld *mld,
+			       struct ieee80211_bss_conf *link,
+			       struct ieee80211_chanctx_conf *chan_ctx,
+			       __le32 *cck_rates, __le32 *ofdm_rates)
+{
+	struct cfg80211_chan_def *chandef =
+		iwl_mld_get_chandef_from_chanctx(chan_ctx);
+	struct ieee80211_supported_band *sband =
+		mld->hw->wiphy->bands[chandef->chan->band];
+	unsigned long basic = link->basic_rates;
+	int lowest_present_ofdm = 100;
+	int lowest_present_cck = 100;
+	u32 cck = 0;
+	u32 ofdm = 0;
+	int i;
+
+	for_each_set_bit(i, &basic, BITS_PER_LONG) {
+		int hw = sband->bitrates[i].hw_value;
+
+		if (hw >= IWL_FIRST_OFDM_RATE) {
+			ofdm |= BIT(hw - IWL_FIRST_OFDM_RATE);
+			if (lowest_present_ofdm > hw)
+				lowest_present_ofdm = hw;
+		} else {
+			BUILD_BUG_ON(IWL_FIRST_CCK_RATE != 0);
+
+			cck |= BIT(hw);
+			if (lowest_present_cck > hw)
+				lowest_present_cck = hw;
+		}
+	}
+
+	/* Now we've got the basic rates as bitmaps in the ofdm and cck
+	 * variables. This isn't sufficient though, as there might not
+	 * be all the right rates in the bitmap. E.g. if the only basic
+	 * rates are 5.5 Mbps and 11 Mbps, we still need to add 1 Mbps
+	 * and 6 Mbps because the 802.11-2007 standard says in 9.6:
+	 *
+	 *    [...] a STA responding to a received frame shall transmit
+	 *    its Control Response frame [...] at the highest rate in the
+	 *    BSSBasicRateSet parameter that is less than or equal to the
+	 *    rate of the immediately previous frame in the frame exchange
+	 *    sequence ([...]) and that is of the same modulation class
+	 *    ([...]) as the received frame. If no rate contained in the
+	 *    BSSBasicRateSet parameter meets these conditions, then the
+	 *    control frame sent in response to a received frame shall be
+	 *    transmitted at the highest mandatory rate of the PHY that is
+	 *    less than or equal to the rate of the received frame, and
+	 *    that is of the same modulation class as the received frame.
+	 *
+	 * As a consequence, we need to add all mandatory rates that are
+	 * lower than all of the basic rates to these bitmaps.
+	 */
+
+	if (lowest_present_ofdm > IWL_RATE_24M_INDEX)
+		ofdm |= IWL_RATE_BIT_MSK(24) >> IWL_FIRST_OFDM_RATE;
+	if (lowest_present_ofdm > IWL_RATE_12M_INDEX)
+		ofdm |= IWL_RATE_BIT_MSK(12) >> IWL_FIRST_OFDM_RATE;
+	/* 6M already there or needed so always add */
+	ofdm |= IWL_RATE_BIT_MSK(6) >> IWL_FIRST_OFDM_RATE;
+
+	/* CCK is a bit more complex with DSSS vs. HR/DSSS vs. ERP.
+	 * Note, however:
+	 *  - if no CCK rates are basic, it must be ERP since there must
+	 *    be some basic rates at all, so they're OFDM => ERP PHY
+	 *    (or we're in 5 GHz, and the cck bitmap will never be used)
+	 *  - if 11M is a basic rate, it must be ERP as well, so add 5.5M
+	 *  - if 5.5M is basic, 1M and 2M are mandatory
+	 *  - if 2M is basic, 1M is mandatory
+	 *  - if 1M is basic, that's the only valid ACK rate.
+	 * As a consequence, it's not as complicated as it sounds, just add
+	 * any lower rates to the ACK rate bitmap.
+	 */
+	if (lowest_present_cck > IWL_RATE_11M_INDEX)
+		cck |= IWL_RATE_BIT_MSK(11) >> IWL_FIRST_CCK_RATE;
+	if (lowest_present_cck > IWL_RATE_5M_INDEX)
+		cck |= IWL_RATE_BIT_MSK(5) >> IWL_FIRST_CCK_RATE;
+	if (lowest_present_cck > IWL_RATE_2M_INDEX)
+		cck |= IWL_RATE_BIT_MSK(2) >> IWL_FIRST_CCK_RATE;
+	/* 1M already there or needed so always add */
+	cck |= IWL_RATE_BIT_MSK(1) >> IWL_FIRST_CCK_RATE;
+
+	*cck_rates = cpu_to_le32((u32)cck);
+	*ofdm_rates = cpu_to_le32((u32)ofdm);
+}
+
+static void iwl_mld_fill_protection_flags(struct iwl_mld *mld,
+					  struct ieee80211_bss_conf *link,
+					  __le32 *protection_flags)
+{
+	u8 protection_mode = link->ht_operation_mode &
+				IEEE80211_HT_OP_MODE_PROTECTION;
+	u8 ht_flag = LINK_PROT_FLG_HT_PROT | LINK_PROT_FLG_FAT_PROT;
+
+	IWL_DEBUG_RATE(mld, "HT protection mode: %d\n", protection_mode);
+
+	if (link->use_cts_prot)
+		*protection_flags |= cpu_to_le32(LINK_PROT_FLG_TGG_PROTECT);
+
+	/* See section 9.23.3.1 of IEEE 80211-2012.
+	 * Nongreenfield HT STAs Present is not supported.
+	 */
+	switch (protection_mode) {
+	case IEEE80211_HT_OP_MODE_PROTECTION_NONE:
+		break;
+	case IEEE80211_HT_OP_MODE_PROTECTION_NONMEMBER:
+	case IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED:
+		*protection_flags |= cpu_to_le32(ht_flag);
+		break;
+	case IEEE80211_HT_OP_MODE_PROTECTION_20MHZ:
+		/* Protect when channel wider than 20MHz */
+		if (link->chanreq.oper.width > NL80211_CHAN_WIDTH_20)
+			*protection_flags |= cpu_to_le32(ht_flag);
+		break;
+	}
+}
+
+static u8 iwl_mld_mac80211_ac_to_fw_ac(enum ieee80211_ac_numbers ac)
+{
+	static const u8 mac80211_ac_to_fw[] = {
+		AC_VO,
+		AC_VI,
+		AC_BE,
+		AC_BK
+	};
+
+	return mac80211_ac_to_fw[ac];
+}
+
+static void iwl_mld_fill_qos_params(struct ieee80211_bss_conf *link,
+				    struct iwl_ac_qos *ac, __le32 *qos_flags)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+
+	/* no need to check mld_link since it is done in the caller */
+
+	for (int mac_ac = 0; mac_ac < IEEE80211_NUM_ACS; mac_ac++) {
+		u8 txf = iwl_mld_mac80211_ac_to_fw_tx_fifo(mac_ac);
+		u8 fw_ac = iwl_mld_mac80211_ac_to_fw_ac(mac_ac);
+
+		ac[fw_ac].cw_min =
+			cpu_to_le16(mld_link->queue_params[mac_ac].cw_min);
+		ac[fw_ac].cw_max =
+			cpu_to_le16(mld_link->queue_params[mac_ac].cw_max);
+		ac[fw_ac].edca_txop =
+			cpu_to_le16(mld_link->queue_params[mac_ac].txop * 32);
+		ac[fw_ac].aifsn = mld_link->queue_params[mac_ac].aifs;
+		ac[fw_ac].fifos_mask = BIT(txf);
+	}
+
+	if (link->qos)
+		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_UPDATE_EDCA);
+
+	if (link->chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT)
+		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_TGN);
+}
+
+static bool iwl_mld_fill_mu_edca(struct iwl_mld *mld,
+				 const struct iwl_mld_link *mld_link,
+				 struct iwl_he_backoff_conf *trig_based_txf)
+{
+	for (int mac_ac = 0; mac_ac < IEEE80211_NUM_ACS; mac_ac++) {
+		const struct ieee80211_he_mu_edca_param_ac_rec *mu_edca =
+			&mld_link->queue_params[mac_ac].mu_edca_param_rec;
+		u8 fw_ac = iwl_mld_mac80211_ac_to_fw_ac(mac_ac);
+
+		if (!mld_link->queue_params[mac_ac].mu_edca)
+			return false;
+
+		trig_based_txf[fw_ac].cwmin =
+			cpu_to_le16(mu_edca->ecw_min_max & 0xf);
+		trig_based_txf[fw_ac].cwmax =
+			cpu_to_le16((mu_edca->ecw_min_max & 0xf0) >> 4);
+		trig_based_txf[fw_ac].aifsn =
+			cpu_to_le16(mu_edca->aifsn & 0xf);
+		trig_based_txf[fw_ac].mu_time =
+			cpu_to_le16(mu_edca->mu_edca_timer);
+	}
+	return true;
+}
+
+static u8 iwl_mld_sta_rx_bw_to_fw(enum ieee80211_sta_rx_bandwidth bw)
+{
+	switch (bw) {
+	default: /* potential future values not supported by this hw/driver */
+	case IEEE80211_STA_RX_BW_20:
+		return IWL_LINK_MODIFY_BW_20;
+	case IEEE80211_STA_RX_BW_40:
+		return IWL_LINK_MODIFY_BW_40;
+	case IEEE80211_STA_RX_BW_80:
+		return IWL_LINK_MODIFY_BW_80;
+	case IEEE80211_STA_RX_BW_160:
+		return IWL_LINK_MODIFY_BW_160;
+	case IEEE80211_STA_RX_BW_320:
+		return IWL_LINK_MODIFY_BW_320;
+	}
+}
+
+static int _iwl_mld_change_link_in_fw(struct iwl_mld *mld,
+				      struct ieee80211_bss_conf *link,
+				      enum ieee80211_sta_rx_bandwidth bw,
+				      u32 changes)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	struct ieee80211_vif *vif = link->vif;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_chanctx_conf *chan_ctx;
+	struct iwl_link_config_cmd cmd = {};
+	u32 flags = 0;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(!mld_link))
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(mld_link->fw_id);
+	cmd.spec_link_id = link->link_id;
+	cmd.mac_id = cpu_to_le32(mld_vif->fw_id);
+
+	chan_ctx = wiphy_dereference(mld->wiphy, mld_link->chan_ctx);
+
+	cmd.phy_id = cpu_to_le32(chan_ctx ?
+		iwl_mld_phy_from_mac80211(chan_ctx)->fw_id :
+		FW_CTXT_ID_INVALID);
+
+	ether_addr_copy(cmd.local_link_addr, link->addr);
+
+	cmd.active = cpu_to_le32(mld_link->active);
+
+	if ((changes & LINK_CONTEXT_MODIFY_ACTIVE) && !mld_link->active &&
+	    mld_link->silent_deactivation) {
+		/* We are de-activating a link that is having CSA with
+		 * immediate quiet in EMLSR. Tell the firmware not to send any
+		 * frame.
+		 */
+		cmd.block_tx = 1;
+		mld_link->silent_deactivation = false;
+	}
+
+	if (vif->type == NL80211_IFTYPE_ADHOC && link->bssid)
+		ether_addr_copy(cmd.ibss_bssid_addr, link->bssid);
+
+	/* Channel context is needed to get the rates */
+	if (chan_ctx)
+		iwl_mld_fill_rates(mld, link, chan_ctx, &cmd.cck_rates,
+				   &cmd.ofdm_rates);
+
+	cmd.cck_short_preamble = cpu_to_le32(link->use_short_preamble);
+	cmd.short_slot = cpu_to_le32(link->use_short_slot);
+
+	iwl_mld_fill_protection_flags(mld, link, &cmd.protection_flags);
+
+	iwl_mld_fill_qos_params(link, cmd.ac, &cmd.qos_flags);
+
+	cmd.bi = cpu_to_le32(link->beacon_int);
+	cmd.dtim_interval = cpu_to_le32(link->beacon_int * link->dtim_period);
+
+	if (changes & LINK_CONTEXT_MODIFY_BANDWIDTH)
+		cmd.modify_bandwidth = iwl_mld_sta_rx_bw_to_fw(bw);
+
+	/* Configure HE parameters only if HE is supported, and only after
+	 * the parameters are set in mac80211 (meaning after assoc)
+	 */
+	if (!link->he_support || iwlwifi_mod_params.disable_11ax ||
+	    (vif->type == NL80211_IFTYPE_STATION && !vif->cfg.assoc)) {
+		changes &= ~LINK_CONTEXT_MODIFY_HE_PARAMS;
+		goto send_cmd;
+	}
+
+	/* ap_sta may be NULL if we're disconnecting */
+	if (mld_vif->ap_sta) {
+		struct ieee80211_link_sta *link_sta =
+			link_sta_dereference_check(mld_vif->ap_sta,
+						   link->link_id);
+
+		if (!WARN_ON(!link_sta) && link_sta->he_cap.has_he &&
+		    link_sta->he_cap.he_cap_elem.mac_cap_info[5] &
+		    IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX)
+			cmd.ul_mu_data_disable = 1;
+	}
+
+	cmd.htc_trig_based_pkt_ext = link->htc_trig_based_pkt_ext;
+
+	if (link->uora_exists) {
+		cmd.rand_alloc_ecwmin = link->uora_ocw_range & 0x7;
+		cmd.rand_alloc_ecwmax = (link->uora_ocw_range >> 3) & 0x7;
+	}
+
+	if (iwl_mld_fill_mu_edca(mld, mld_link, cmd.trig_based_txf))
+		flags |= LINK_FLG_MU_EDCA_CW;
+
+	cmd.bss_color = link->he_bss_color.color;
+
+	if (!link->he_bss_color.enabled)
+		flags |= LINK_FLG_BSS_COLOR_DIS;
+
+	cmd.frame_time_rts_th = cpu_to_le16(link->frame_time_rts_th);
+
+	/* Block 26-tone RU OFDMA transmissions */
+	if (mld_link->he_ru_2mhz_block)
+		flags |= LINK_FLG_RU_2MHZ_BLOCK;
+
+	if (link->nontransmitted) {
+		ether_addr_copy(cmd.ref_bssid_addr, link->transmitter_bssid);
+		cmd.bssid_index = link->bssid_index;
+	}
+
+	/* The only EHT parameter is puncturing, and starting from PHY cmd
+	 * version 6 - it is sent there. For older versions of the PHY cmd,
+	 * puncturing is not needed at all.
+	 */
+	if (WARN_ON(changes & LINK_CONTEXT_MODIFY_EHT_PARAMS))
+		changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
+
+send_cmd:
+	cmd.modify_mask = cpu_to_le32(changes);
+	cmd.flags = cpu_to_le32(flags);
+
+	return iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_MODIFY);
+}
+
+int iwl_mld_change_link_in_fw(struct iwl_mld *mld,
+			      struct ieee80211_bss_conf *link,
+			      u32 changes)
+{
+	if (WARN_ON(changes & LINK_CONTEXT_MODIFY_BANDWIDTH))
+		changes &= ~LINK_CONTEXT_MODIFY_BANDWIDTH;
+
+	return _iwl_mld_change_link_in_fw(mld, link, 0, changes);
+}
+
+int iwl_mld_change_link_omi_bw(struct iwl_mld *mld,
+			       struct ieee80211_bss_conf *link,
+			       enum ieee80211_sta_rx_bandwidth bw)
+{
+	return _iwl_mld_change_link_in_fw(mld, link, bw,
+					  LINK_CONTEXT_MODIFY_BANDWIDTH);
+}
+
+int iwl_mld_activate_link(struct iwl_mld *mld,
+			  struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(!mld_link || mld_link->active))
+		return -EINVAL;
+
+	mld_link->rx_omi.exit_ts = jiffies;
+	mld_link->active = true;
+
+	ret = iwl_mld_change_link_in_fw(mld, link,
+					LINK_CONTEXT_MODIFY_ACTIVE);
+	if (ret)
+		mld_link->active = false;
+
+	return ret;
+}
+
+void iwl_mld_deactivate_link(struct iwl_mld *mld,
+			     struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	struct iwl_probe_resp_data *probe_data;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(!mld_link || !mld_link->active))
+		return;
+
+	iwl_mld_cancel_session_protection(mld, link->vif, link->link_id);
+
+	/* If we deactivate the link, we will probably remove it, or switch
+	 * channel. In both cases, the CSA or Notice of Absence information is
+	 * now irrelevant. Remove the data here.
+	 */
+	probe_data = wiphy_dereference(mld->wiphy, mld_link->probe_resp_data);
+	RCU_INIT_POINTER(mld_link->probe_resp_data, NULL);
+	if (probe_data)
+		kfree_rcu(probe_data, rcu_head);
+
+	mld_link->active = false;
+
+	iwl_mld_change_link_in_fw(mld, link, LINK_CONTEXT_MODIFY_ACTIVE);
+
+	/* Now that the link is not active in FW, we don't expect any new
+	 * notifications for it. Cancel the ones that are already pending
+	 */
+	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_LINK,
+					       mld_link->fw_id);
+}
+
+static int
+iwl_mld_rm_link_from_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	struct iwl_link_config_cmd cmd = {};
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(!mld_link))
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(mld_link->fw_id);
+	cmd.spec_link_id = link->link_id;
+	cmd.phy_id = cpu_to_le32(FW_CTXT_ID_INVALID);
+
+	return iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
+}
+
+static void iwl_mld_omi_bw_update(struct iwl_mld *mld,
+				  struct ieee80211_bss_conf *link_conf,
+				  struct iwl_mld_link *mld_link,
+				  struct ieee80211_link_sta *link_sta,
+				  enum ieee80211_sta_rx_bandwidth bw,
+				  bool ap_update)
+{
+	enum ieee80211_sta_rx_bandwidth apply_bw;
+
+	mld_link->rx_omi.desired_bw = bw;
+
+	/* Can't update OMI while already in progress, desired_bw was
+	 * set so on FW notification the worker will see the change
+	 * and apply new the new desired bw.
+	 */
+	if (mld_link->rx_omi.bw_in_progress)
+		return;
+
+	if (bw == IEEE80211_STA_RX_BW_MAX)
+		apply_bw = ieee80211_chan_width_to_rx_bw(link_conf->chanreq.oper.width);
+	else
+		apply_bw = bw;
+
+	if (!ap_update) {
+		/* The update isn't due to AP tracking after leaving OMI,
+		 * where the AP could increase BW and then we must tell
+		 * it that we can do the increased BW as well, if we did
+		 * update the chandef.
+		 * In this case, if we want MAX, then we will need to send
+		 * a new OMI to the AP if it increases its own bandwidth as
+		 * we can (due to internal and FW limitations, and being
+		 * worried the AP might break) only send to what we're doing
+		 * at the moment. In this case, set last_max_bw; otherwise
+		 * if we really want to decrease our bandwidth set it to 0
+		 * to indicate no updates are needed if the AP changes.
+		 */
+		if (bw != IEEE80211_STA_RX_BW_MAX)
+			mld_link->rx_omi.last_max_bw = apply_bw;
+		else
+			mld_link->rx_omi.last_max_bw = 0;
+	} else {
+		/* Otherwise, if we're already trying to do maximum and
+		 * the AP is changing, set last_max_bw to the new max the
+		 * AP is using, we'll only get to this code path if the
+		 * new bandwidth of the AP is bigger than what we sent it
+		 * previously. This avoids repeatedly sending updates if
+		 * it changes bandwidth, only doing it once on an increase.
+		 */
+		mld_link->rx_omi.last_max_bw = apply_bw;
+	}
+
+	if (ieee80211_prepare_rx_omi_bw(link_sta, bw)) {
+		mld_link->rx_omi.bw_in_progress = apply_bw;
+		iwl_mld_change_link_omi_bw(mld, link_conf, apply_bw);
+	}
+}
+
+static void iwl_mld_omi_bw_finished_work(struct wiphy *wiphy,
+					 struct wiphy_work *work)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_link *mld_link =
+		container_of(work, typeof(*mld_link), rx_omi.finished_work.work);
+	enum ieee80211_sta_rx_bandwidth desired_bw, switched_to_bw;
+	struct ieee80211_vif *vif = mld_link->vif;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_sta *link_sta;
+
+	if (!mld_vif->ap_sta)
+		return;
+
+	link_sta = wiphy_dereference(mld->wiphy,
+				     mld_vif->ap_sta->link[mld_link->link_id]);
+	if (WARN_ON_ONCE(!link_sta))
+		return;
+
+	link_conf = link_conf_dereference_protected(vif, link_sta->link_id);
+	if (WARN_ON_ONCE(!link_conf))
+		return;
+
+	if (WARN_ON(!mld_link->rx_omi.bw_in_progress))
+		return;
+
+	desired_bw = mld_link->rx_omi.desired_bw;
+	switched_to_bw = mld_link->rx_omi.bw_in_progress;
+
+	ieee80211_finalize_rx_omi_bw(link_sta);
+	mld_link->rx_omi.bw_in_progress = 0;
+
+	if (desired_bw != switched_to_bw)
+		iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta,
+				      desired_bw, false);
+}
+
+static struct ieee80211_vif *
+iwl_mld_get_omi_bw_reduction_pointers(struct iwl_mld *mld,
+				      struct ieee80211_link_sta **link_sta,
+				      struct iwl_mld_link **mld_link)
+{
+	struct iwl_mld_vif *mld_vif;
+	struct ieee80211_vif *vif;
+	int n_link_stas = 0;
+
+	*link_sta = NULL;
+
+	if (mld->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+		return NULL;
+
+	vif = iwl_mld_get_bss_vif(mld);
+	if (!vif)
+		return NULL;
+
+	for (int i = 0; i < ARRAY_SIZE(mld->fw_id_to_link_sta); i++) {
+		struct ieee80211_link_sta *tmp;
+
+		tmp = wiphy_dereference(mld->wiphy, mld->fw_id_to_link_sta[i]);
+		if (IS_ERR_OR_NULL(tmp))
+			continue;
+
+		n_link_stas++;
+		*link_sta = tmp;
+	}
+
+	/* can't do anything if we have TDLS peers or EMLSR */
+	if (n_link_stas != 1)
+		return NULL;
+
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+	*mld_link = iwl_mld_link_dereference_check(mld_vif,
+						   (*link_sta)->link_id);
+	if (WARN_ON(!*mld_link))
+		return NULL;
+
+	return vif;
+}
+
+void iwl_mld_omi_ap_changed_bw(struct iwl_mld *mld,
+			       struct ieee80211_bss_conf *link_conf,
+			       enum ieee80211_sta_rx_bandwidth bw)
+{
+	struct ieee80211_link_sta *link_sta;
+	struct iwl_mld_link *mld_link;
+	struct ieee80211_vif *vif;
+
+	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
+	if (!vif)
+		return;
+
+	if (WARN_ON(link_conf->vif != vif))
+		return;
+
+	/* This is 0 if we requested an OMI BW reduction and don't want to
+	 * be sending an OMI when the AP's bandwidth changes.
+	 */
+	if (!mld_link->rx_omi.last_max_bw)
+		return;
+
+	/* We only need to tell the AP if it increases BW over what we last
+	 * told it we were using, if it reduces then our last OMI to it will
+	 * not get used anyway (e.g. we said we want 160 but it's doing 80.)
+	 */
+	if (bw < mld_link->rx_omi.last_max_bw)
+		return;
+
+	iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta, bw, true);
+}
+
+void iwl_mld_handle_omi_status_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt)
+{
+	struct ieee80211_link_sta *link_sta;
+	struct iwl_mld_link *mld_link;
+	struct ieee80211_vif *vif;
+
+	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
+	if (IWL_FW_CHECK(mld, !vif, "unexpected OMI notification\n"))
+		return;
+
+	if (IWL_FW_CHECK(mld, !mld_link->rx_omi.bw_in_progress,
+			 "OMI notification when not requested\n"))
+		return;
+
+	wiphy_delayed_work_queue(mld->hw->wiphy,
+				 &mld_link->rx_omi.finished_work,
+				 msecs_to_jiffies(IWL_MLD_OMI_AP_SETTLE_DELAY));
+}
+
+void iwl_mld_leave_omi_bw_reduction(struct iwl_mld *mld)
+{
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_sta *link_sta;
+	struct iwl_mld_link *mld_link;
+	struct ieee80211_vif *vif;
+
+	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
+	if (!vif)
+		return;
+
+	link_conf = link_conf_dereference_protected(vif, link_sta->link_id);
+	if (WARN_ON_ONCE(!link_conf))
+		return;
+
+	if (!link_conf->he_support)
+		return;
+
+	mld_link->rx_omi.exit_ts = jiffies;
+
+	iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta,
+			      IEEE80211_STA_RX_BW_MAX, false);
+}
+
+void iwl_mld_check_omi_bw_reduction(struct iwl_mld *mld)
+{
+	enum ieee80211_sta_rx_bandwidth bw = IEEE80211_STA_RX_BW_MAX;
+	struct ieee80211_chanctx_conf *chanctx;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_sta *link_sta;
+	struct cfg80211_chan_def chandef;
+	struct iwl_mld_link *mld_link;
+	struct iwl_mld_vif *mld_vif;
+	struct ieee80211_vif *vif;
+	struct iwl_mld_phy *phy;
+	u16 punctured;
+	int exit_thr;
+
+	/* not allowed in CAM mode */
+	if (iwlmld_mod_params.power_scheme == IWL_POWER_SCHEME_CAM)
+		return;
+
+	/* must have one BSS connection (no P2P), no TDLS, nor EMLSR */
+	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
+	if (!vif)
+		return;
+
+	link_conf = link_conf_dereference_protected(vif, link_sta->link_id);
+	if (WARN_ON_ONCE(!link_conf))
+		return;
+
+	if (!link_conf->he_support)
+		return;
+
+	chanctx = wiphy_dereference(mld->wiphy, mld_link->chan_ctx);
+	if (WARN_ON(!chanctx))
+		return;
+
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+	if (!mld_vif->authorized)
+		goto apply;
+
+	/* must not be in low-latency mode */
+	if (iwl_mld_vif_low_latency(mld_vif))
+		goto apply;
+
+	chandef = link_conf->chanreq.oper;
+
+	switch (chandef.width) {
+	case NL80211_CHAN_WIDTH_320:
+		exit_thr = IWL_MLD_OMI_EXIT_CHAN_LOAD_320;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		exit_thr = IWL_MLD_OMI_EXIT_CHAN_LOAD_160;
+		break;
+	default:
+		/* since we reduce to 80 MHz, must have more to start with */
+		goto apply;
+	}
+
+	/* not to be done if primary 80 MHz is punctured */
+	if (cfg80211_chandef_primary(&chandef, NL80211_CHAN_WIDTH_80,
+				     &punctured) < 0 ||
+	    punctured != 0)
+		goto apply;
+
+	phy = iwl_mld_phy_from_mac80211(chanctx);
+
+	if (phy->channel_load_by_us > exit_thr) {
+		/* send OMI for max bandwidth */
+		goto apply;
+	}
+
+	if (phy->channel_load_by_us > IWL_MLD_OMI_ENTER_CHAN_LOAD) {
+		/* no changes between enter/exit thresholds */
+		return;
+	}
+
+	if (time_is_before_jiffies(mld_link->rx_omi.exit_ts +
+				   msecs_to_jiffies(IWL_MLD_OMI_EXIT_PROTECTION)))
+		return;
+
+	/* reduce bandwidth to 80 MHz to save power */
+	bw = IEEE80211_STA_RX_BW_80;
+apply:
+	iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta, bw, false);
+}
+
+IWL_MLD_ALLOC_FN(link, bss_conf)
+
+/* Constructor function for struct iwl_mld_link */
+static int
+iwl_mld_init_link(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
+		  struct iwl_mld_link *mld_link)
+{
+	mld_link->vif = link->vif;
+	mld_link->link_id = link->link_id;
+
+	iwl_mld_init_internal_sta(&mld_link->bcast_sta);
+	iwl_mld_init_internal_sta(&mld_link->mcast_sta);
+	iwl_mld_init_internal_sta(&mld_link->aux_sta);
+
+	wiphy_delayed_work_init(&mld_link->rx_omi.finished_work,
+				iwl_mld_omi_bw_finished_work);
+
+	return iwl_mld_allocate_link_fw_id(mld, &mld_link->fw_id, link);
+}
+
+/* Initializes the link structure, maps fw id to the ieee80211_bss_conf, and
+ * adds a link to the fw
+ */
+int iwl_mld_add_link(struct iwl_mld *mld,
+		     struct ieee80211_bss_conf *bss_conf)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
+	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
+	bool is_deflink = bss_conf == &bss_conf->vif->bss_conf;
+	int ret;
+
+	if (!link) {
+		if (is_deflink)
+			link = &mld_vif->deflink;
+		else
+			link = kzalloc(sizeof(*link), GFP_KERNEL);
+	} else {
+		WARN_ON(!mld->fw_status.in_hw_restart);
+	}
+
+	ret = iwl_mld_init_link(mld, bss_conf, link);
+	if (ret)
+		goto free;
+
+	rcu_assign_pointer(mld_vif->link[bss_conf->link_id], link);
+
+	ret = iwl_mld_add_link_to_fw(mld, bss_conf);
+	if (ret) {
+		RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link->fw_id], NULL);
+		RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
+		goto free;
+	}
+
+	return ret;
+
+free:
+	if (!is_deflink)
+		kfree(link);
+	return ret;
+}
+
+/* Remove link from fw, unmap the bss_conf, and destroy the link structure */
+int iwl_mld_remove_link(struct iwl_mld *mld,
+			struct ieee80211_bss_conf *bss_conf)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
+	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
+	bool is_deflink = link == &mld_vif->deflink;
+	int ret;
+
+	if (WARN_ON(!link || link->active))
+		return -EINVAL;
+
+	ret = iwl_mld_rm_link_from_fw(mld, bss_conf);
+	/* Continue cleanup on failure */
+
+	if (!is_deflink)
+		kfree_rcu(link, rcu_head);
+
+	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
+
+	wiphy_delayed_work_cancel(mld->wiphy, &link->rx_omi.finished_work);
+
+	if (WARN_ON(link->fw_id >= mld->fw->ucode_capa.num_links))
+		return -EINVAL;
+
+	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link->fw_id], NULL);
+
+	return ret;
+}
+
+void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
+					struct iwl_rx_packet *pkt)
+{
+	const struct iwl_missed_beacons_notif *notif = (const void *)pkt->data;
+	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
+	u32 link_id = le32_to_cpu(notif->link_id);
+	u32 missed_bcon = le32_to_cpu(notif->consec_missed_beacons);
+	u32 missed_bcon_since_rx =
+		le32_to_cpu(notif->consec_missed_beacons_since_last_rx);
+	u32 scnd_lnk_bcn_lost =
+		le32_to_cpu(notif->consec_missed_beacons_other_link);
+	struct ieee80211_bss_conf *link_conf =
+		iwl_mld_fw_id_to_link_conf(mld, link_id);
+	u32 bss_param_ch_cnt_link_id;
+	struct ieee80211_vif *vif;
+
+	if (WARN_ON(!link_conf))
+		return;
+
+	vif = link_conf->vif;
+	bss_param_ch_cnt_link_id = link_conf->bss_param_ch_cnt_link_id;
+
+	IWL_DEBUG_INFO(mld,
+		       "missed bcn link_id=%u, %u consecutive=%u\n",
+		       link_id, missed_bcon, missed_bcon_since_rx);
+
+	if (WARN_ON(!vif))
+		return;
+
+	mld->trans->dbg.dump_file_name_ext_valid = true;
+	snprintf(mld->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
+		 "LinkId_%d_MacType_%d", link_id,
+		 iwl_mld_mac80211_iftype_to_fw(vif));
+
+	iwl_dbg_tlv_time_point(&mld->fwrt,
+			       IWL_FW_INI_TIME_POINT_MISSED_BEACONS, &tp_data);
+
+	if (missed_bcon >= IWL_MLD_MISSED_BEACONS_THRESHOLD_LONG) {
+		if (missed_bcon_since_rx >=
+		    IWL_MLD_MISSED_BEACONS_SINCE_RX_THOLD) {
+			ieee80211_connection_loss(vif);
+			return;
+		}
+		IWL_WARN(mld,
+			 "missed beacons exceeds threshold, but receiving data. Stay connected, Expect bugs.\n");
+		return;
+	}
+
+	if (missed_bcon_since_rx > IWL_MLD_MISSED_BEACONS_THRESHOLD) {
+		ieee80211_cqm_beacon_loss_notify(vif, GFP_ATOMIC);
+
+		/* try to switch links, no-op if we don't have MLO */
+		iwl_mld_trigger_link_selection(mld, vif);
+	}
+
+	/* no more logic if we're not in EMLSR */
+	if (hweight16(vif->active_links) <= 1)
+		return;
+
+	/* We are processing a notification before link activation */
+	if (le32_to_cpu(notif->other_link_id) == FW_CTXT_ID_INVALID)
+		return;
+
+	/* Exit EMLSR if we lost more than
+	 * IWL_MLD_MISSED_BEACONS_EXIT_ESR_THRESH beacons on boths links
+	 * OR more than IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH on current link.
+	 * OR more than IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED
+	 * on current link and the link's bss_param_ch_count has changed on
+	 * the other link's beacon.
+	 */
+	if ((missed_bcon >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS &&
+	     scnd_lnk_bcn_lost >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS) ||
+	    missed_bcon >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH ||
+	    (bss_param_ch_cnt_link_id != link_id &&
+	     missed_bcon >=
+	     IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED)) {
+		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_MISSED_BEACON,
+				   iwl_mld_get_primary_link(vif));
+	}
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_handle_missed_beacon_notif);
+
+bool iwl_mld_cancel_missed_beacon_notif(struct iwl_mld *mld,
+					struct iwl_rx_packet *pkt,
+					u32 removed_link_id)
+{
+	struct iwl_missed_beacons_notif *notif = (void *)pkt->data;
+
+	if (le32_to_cpu(notif->other_link_id) == removed_link_id) {
+		/* Second link is being removed. Don't cancel the notification,
+		 * but mark second link as invalid.
+		 */
+		notif->other_link_id = cpu_to_le32(FW_CTXT_ID_INVALID);
+	}
+
+	/* If the primary link is removed, cancel the notification */
+	return le32_to_cpu(notif->link_id) == removed_link_id;
+}
+
+int iwl_mld_link_set_associated(struct iwl_mld *mld, struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link)
+{
+	return iwl_mld_change_link_in_fw(mld, link, LINK_CONTEXT_MODIFY_ALL &
+					 ~(LINK_CONTEXT_MODIFY_ACTIVE |
+					   LINK_CONTEXT_MODIFY_EHT_PARAMS));
+}
+
+struct iwl_mld_rssi_to_grade {
+	s8 rssi[2];
+	u16 grade;
+};
+
+#define RSSI_TO_GRADE_LINE(_lb, _hb_uhb, _grade) \
+	{ \
+		.rssi = {_lb, _hb_uhb}, \
+		.grade = _grade \
+	}
+
+/*
+ * This array must be sorted by increasing RSSI for proper functionality.
+ * The grades are actually estimated throughput, represented as fixed-point
+ * with a scale factor of 1/10.
+ */
+static const struct iwl_mld_rssi_to_grade rssi_to_grade_map[] = {
+	RSSI_TO_GRADE_LINE(-85, -89, 172),
+	RSSI_TO_GRADE_LINE(-83, -86, 344),
+	RSSI_TO_GRADE_LINE(-82, -85, 516),
+	RSSI_TO_GRADE_LINE(-80, -83, 688),
+	RSSI_TO_GRADE_LINE(-77, -79, 1032),
+	RSSI_TO_GRADE_LINE(-73, -76, 1376),
+	RSSI_TO_GRADE_LINE(-70, -74, 1548),
+	RSSI_TO_GRADE_LINE(-69, -72, 1720),
+	RSSI_TO_GRADE_LINE(-65, -68, 2064),
+	RSSI_TO_GRADE_LINE(-61, -66, 2294),
+	RSSI_TO_GRADE_LINE(-58, -61, 2580),
+	RSSI_TO_GRADE_LINE(-55, -58, 2868),
+	RSSI_TO_GRADE_LINE(-46, -55, 3098),
+	RSSI_TO_GRADE_LINE(-43, -54, 3442)
+};
+
+#define MAX_GRADE (rssi_to_grade_map[ARRAY_SIZE(rssi_to_grade_map) - 1].grade)
+
+#define DEFAULT_CHAN_LOAD_2GHZ	30
+#define DEFAULT_CHAN_LOAD_5GHZ	15
+#define DEFAULT_CHAN_LOAD_6GHZ	0
+
+/* Factors calculation is done with fixed-point with a scaling factor of 1/256 */
+#define SCALE_FACTOR 256
+#define MAX_CHAN_LOAD 256
+
+static unsigned int
+iwl_mld_get_n_subchannels(const struct ieee80211_bss_conf *link_conf)
+{
+	enum nl80211_chan_width chan_width =
+		link_conf->chanreq.oper.width;
+	int mhz = nl80211_chan_width_to_mhz(chan_width);
+	unsigned int n_subchannels;
+
+	if (WARN_ONCE(mhz < 20 || mhz > 320,
+		      "Invalid channel width : (%d)\n", mhz))
+		return 1;
+
+	/* total number of subchannels */
+	n_subchannels = mhz / 20;
+
+	/* No puncturing if less than 80 MHz */
+	if (mhz >= 80)
+		n_subchannels -= hweight16(link_conf->chanreq.oper.punctured);
+
+	return n_subchannels;
+}
+
+static int
+iwl_mld_get_chan_load_from_element(struct iwl_mld *mld,
+				   struct ieee80211_bss_conf *link_conf)
+{
+	struct ieee80211_vif *vif = link_conf->vif;
+	const struct cfg80211_bss_ies *ies;
+	const struct element *bss_load_elem = NULL;
+	const struct ieee80211_bss_load_elem *bss_load;
+
+	guard(rcu)();
+
+	if (ieee80211_vif_link_active(vif, link_conf->link_id))
+		ies = rcu_dereference(link_conf->bss->beacon_ies);
+	else
+		ies = rcu_dereference(link_conf->bss->ies);
+
+	if (ies)
+		bss_load_elem = cfg80211_find_elem(WLAN_EID_QBSS_LOAD,
+						   ies->data, ies->len);
+
+	if (!bss_load_elem ||
+	    bss_load_elem->datalen != sizeof(*bss_load))
+		return -EINVAL;
+
+	bss_load = (const void *)bss_load_elem->data;
+
+	return bss_load->channel_util;
+}
+
+static unsigned int
+iwl_mld_get_chan_load_by_us(struct iwl_mld *mld,
+			    struct ieee80211_bss_conf *link_conf,
+			    bool expect_active_link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link_conf);
+	struct ieee80211_chanctx_conf *chan_ctx;
+	struct iwl_mld_phy *phy;
+
+	if (!mld_link || !mld_link->active) {
+		WARN_ON(expect_active_link);
+		return 0;
+	}
+
+	if (WARN_ONCE(!rcu_access_pointer(mld_link->chan_ctx),
+		      "Active link (%u) without channel ctxt assigned!\n",
+		      link_conf->link_id))
+		return 0;
+
+	chan_ctx = wiphy_dereference(mld->wiphy, mld_link->chan_ctx);
+	phy = iwl_mld_phy_from_mac80211(chan_ctx);
+
+	return phy->channel_load_by_us;
+}
+
+/* Returns error if the channel utilization element is invalid/unavailable */
+int iwl_mld_get_chan_load_by_others(struct iwl_mld *mld,
+				    struct ieee80211_bss_conf *link_conf,
+				    bool expect_active_link)
+{
+	int chan_load;
+	unsigned int chan_load_by_us;
+
+	/* get overall load */
+	chan_load = iwl_mld_get_chan_load_from_element(mld, link_conf);
+	if (chan_load < 0)
+		return chan_load;
+
+	chan_load_by_us = iwl_mld_get_chan_load_by_us(mld, link_conf,
+						      expect_active_link);
+
+	/* channel load by us is given in percentage */
+	chan_load_by_us =
+		NORMALIZE_PERCENT_TO_255(chan_load_by_us);
+
+	/* Use only values that firmware sends that can possibly be valid */
+	if (chan_load_by_us <= chan_load)
+		chan_load -= chan_load_by_us;
+
+	return chan_load;
+}
+
+static unsigned int
+iwl_mld_get_default_chan_load(struct ieee80211_bss_conf *link_conf)
+{
+	enum nl80211_band band = link_conf->chanreq.oper.chan->band;
+
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		return DEFAULT_CHAN_LOAD_2GHZ;
+	case NL80211_BAND_5GHZ:
+		return DEFAULT_CHAN_LOAD_5GHZ;
+	case NL80211_BAND_6GHZ:
+		return DEFAULT_CHAN_LOAD_6GHZ;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
+unsigned int iwl_mld_get_chan_load(struct iwl_mld *mld,
+				   struct ieee80211_bss_conf *link_conf)
+{
+	int chan_load;
+
+	chan_load = iwl_mld_get_chan_load_by_others(mld, link_conf, false);
+	if (chan_load >= 0)
+		return chan_load;
+
+	/* No information from the element, take the defaults */
+	chan_load = iwl_mld_get_default_chan_load(link_conf);
+
+	/* The defaults are given in percentage */
+	return NORMALIZE_PERCENT_TO_255(chan_load);
+}
+
+static unsigned int
+iwl_mld_get_avail_chan_load(struct iwl_mld *mld,
+			    struct ieee80211_bss_conf *link_conf)
+{
+	return MAX_CHAN_LOAD - iwl_mld_get_chan_load(mld, link_conf);
+}
+
+/* This function calculates the grade of a link. Returns 0 in error case */
+unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
+				    struct ieee80211_bss_conf *link_conf)
+{
+	enum nl80211_band band;
+	int rssi_idx;
+	s32 link_rssi;
+	unsigned int grade = MAX_GRADE;
+
+	if (WARN_ON_ONCE(!link_conf))
+		return 0;
+
+	band = link_conf->chanreq.oper.chan->band;
+	if (WARN_ONCE(band != NL80211_BAND_2GHZ &&
+		      band != NL80211_BAND_5GHZ &&
+		      band != NL80211_BAND_6GHZ,
+		      "Invalid band (%u)\n", band))
+		return 0;
+
+	link_rssi = MBM_TO_DBM(link_conf->bss->signal);
+	/*
+	 * For 6 GHz the RSSI of the beacons is lower than
+	 * the RSSI of the data.
+	 */
+	if (band == NL80211_BAND_6GHZ && link_rssi)
+		link_rssi += 4;
+
+	rssi_idx = band == NL80211_BAND_2GHZ ? 0 : 1;
+
+	/* No valid RSSI - take the lowest grade */
+	if (!link_rssi)
+		link_rssi = rssi_to_grade_map[0].rssi[rssi_idx];
+
+	IWL_DEBUG_EHT(mld,
+		      "Calculating grade of link %d: band = %d, bandwidth = %d, punctured subchannels =0x%x RSSI = %d\n",
+		      link_conf->link_id, band,
+		      link_conf->chanreq.oper.width,
+		      link_conf->chanreq.oper.punctured, link_rssi);
+
+	/* Get grade based on RSSI */
+	for (int i = 0; i < ARRAY_SIZE(rssi_to_grade_map); i++) {
+		const struct iwl_mld_rssi_to_grade *line =
+			&rssi_to_grade_map[i];
+
+		if (link_rssi > line->rssi[rssi_idx])
+			continue;
+		grade = line->grade;
+		break;
+	}
+
+	/* Apply the channel load and puncturing factors */
+	grade = grade * iwl_mld_get_avail_chan_load(mld, link_conf) / SCALE_FACTOR;
+	grade = grade * iwl_mld_get_n_subchannels(link_conf);
+
+	IWL_DEBUG_EHT(mld, "Link %d's grade: %d\n", link_conf->link_id, grade);
+
+	return grade;
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_get_link_grade);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
new file mode 100644
index 000000000000..e1e5cd933190
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifndef __iwl_mld_link_h__
+#define __iwl_mld_link_h__
+
+#include <net/mac80211.h>
+
+#include "mld.h"
+#include "sta.h"
+
+/**
+ * struct iwl_probe_resp_data - data for NoA/CSA updates
+ * @rcu_head: used for freeing the data on update
+ * @notif: notification data
+ * @noa_len: length of NoA attribute, calculated from the notification
+ */
+struct iwl_probe_resp_data {
+	struct rcu_head rcu_head;
+	struct iwl_probe_resp_data_notif notif;
+	int noa_len;
+};
+
+/**
+ * struct iwl_mld_link - link configuration parameters
+ *
+ * @rcu_head: RCU head for freeing this data.
+ * @fw_id: the fw id of the link.
+ * @active: if the link is active or not.
+ * @queue_params: QoS data from mac80211. This is updated with a call to
+ *	drv_conf_tx per each AC, and then notified once with BSS_CHANGED_QOS.
+ *	So we store it here and then send one link cmd for all the ACs.
+ * @chan_ctx: pointer to the channel context assigned to the link. If a link
+ *	has an assigned channel context it means that it is active.
+ * @he_ru_2mhz_block: 26-tone RU OFDMA transmissions should be blocked.
+ * @igtk: fw can only have one IGTK at a time, whereas mac80211 can have two.
+ *	This tracks the one IGTK that currently exists in FW.
+ * @vif: the vif this link belongs to
+ * @bcast_sta: station used for broadcast packets. Used in AP, GO and IBSS.
+ * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
+ * @aux_sta: station used for remain on channel. Used in P2P device.
+ * @link_id: over the air link ID
+ * @ap_early_keys: The firmware cannot install keys before bcast/mcast STAs,
+ *	but higher layers work differently, so we store the keys here for
+ *	later installation.
+ * @silent_deactivation: next deactivation needs to be silent.
+ * @probe_resp_data: data from FW notification to store NOA related data to be
+ *	inserted into probe response.
+ * @rx_omi: data for BW reduction with OMI
+ * @rx_omi.bw_in_progress: update is in progress (indicates target BW)
+ * @rx_omi.exit_ts: timestamp of last exit
+ * @rx_omi.finished_work: work for the delayed reaction to the firmware saying
+ *	the change was applied, and for then applying a new mode if it was
+ *	updated while waiting for firmware/AP settle delay.
+ * @rx_omi.desired_bw: desired bandwidth
+ * @rx_omi.last_max_bw: last maximum BW used by firmware, for AP BW changes
+ */
+struct iwl_mld_link {
+	struct rcu_head rcu_head;
+
+	/* Add here fields that need clean up on restart */
+	struct_group(zeroed_on_hw_restart,
+		u8 fw_id;
+		bool active;
+		struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+		struct ieee80211_chanctx_conf __rcu *chan_ctx;
+		bool he_ru_2mhz_block;
+		struct ieee80211_key_conf *igtk;
+	);
+	/* And here fields that survive a fw restart */
+	struct ieee80211_vif *vif;
+	struct iwl_mld_int_sta bcast_sta;
+	struct iwl_mld_int_sta mcast_sta;
+	struct iwl_mld_int_sta aux_sta;
+	u8 link_id;
+
+	struct {
+		struct wiphy_delayed_work finished_work;
+		unsigned long exit_ts;
+		enum ieee80211_sta_rx_bandwidth bw_in_progress,
+						desired_bw,
+						last_max_bw;
+	} rx_omi;
+
+	/* we can only have 2 GTK + 2 IGTK + 2 BIGTK active at a time */
+	struct ieee80211_key_conf *ap_early_keys[6];
+	bool silent_deactivation;
+	struct iwl_probe_resp_data __rcu *probe_resp_data;
+};
+
+/* Cleanup function for struct iwl_mld_phy, will be called in restart */
+static inline void
+iwl_mld_cleanup_link(struct iwl_mld *mld, struct iwl_mld_link *link)
+{
+	struct iwl_probe_resp_data *probe_data;
+
+	probe_data = wiphy_dereference(mld->wiphy, link->probe_resp_data);
+	RCU_INIT_POINTER(link->probe_resp_data, NULL);
+	if (probe_data)
+		kfree_rcu(probe_data, rcu_head);
+
+	CLEANUP_STRUCT(link);
+	if (link->bcast_sta.sta_id != IWL_INVALID_STA)
+		iwl_mld_free_internal_sta(mld, &link->bcast_sta);
+	if (link->mcast_sta.sta_id != IWL_INVALID_STA)
+		iwl_mld_free_internal_sta(mld, &link->mcast_sta);
+	if (link->aux_sta.sta_id != IWL_INVALID_STA)
+		iwl_mld_free_internal_sta(mld, &link->aux_sta);
+}
+
+/* Convert a percentage from [0,100] to [0,255] */
+#define NORMALIZE_PERCENT_TO_255(percentage) ((percentage) * 256 / 100)
+
+int iwl_mld_add_link(struct iwl_mld *mld,
+		     struct ieee80211_bss_conf *bss_conf);
+int iwl_mld_remove_link(struct iwl_mld *mld,
+			struct ieee80211_bss_conf *bss_conf);
+int iwl_mld_activate_link(struct iwl_mld *mld,
+			  struct ieee80211_bss_conf *link);
+void iwl_mld_deactivate_link(struct iwl_mld *mld,
+			     struct ieee80211_bss_conf *link);
+int iwl_mld_change_link_omi_bw(struct iwl_mld *mld,
+			       struct ieee80211_bss_conf *link,
+			       enum ieee80211_sta_rx_bandwidth bw);
+int iwl_mld_change_link_in_fw(struct iwl_mld *mld,
+			      struct ieee80211_bss_conf *link, u32 changes);
+void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
+					struct iwl_rx_packet *pkt);
+bool iwl_mld_cancel_missed_beacon_notif(struct iwl_mld *mld,
+					struct iwl_rx_packet *pkt,
+					u32 removed_link_id);
+int iwl_mld_link_set_associated(struct iwl_mld *mld, struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link);
+
+unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
+				    struct ieee80211_bss_conf *link_conf);
+
+unsigned int iwl_mld_get_chan_load(struct iwl_mld *mld,
+				   struct ieee80211_bss_conf *link_conf);
+
+int iwl_mld_get_chan_load_by_others(struct iwl_mld *mld,
+				    struct ieee80211_bss_conf *link_conf,
+				    bool expect_active_link);
+void iwl_mld_handle_omi_status_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt);
+void iwl_mld_leave_omi_bw_reduction(struct iwl_mld *mld);
+void iwl_mld_check_omi_bw_reduction(struct iwl_mld *mld);
+void iwl_mld_omi_ap_changed_bw(struct iwl_mld *mld,
+			       struct ieee80211_bss_conf *link_conf,
+			       enum ieee80211_sta_rx_bandwidth bw);
+
+#endif /* __iwl_mld_link_h__ */
-- 
2.34.1


