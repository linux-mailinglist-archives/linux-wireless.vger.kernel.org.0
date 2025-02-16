Return-Path: <linux-wireless+bounces-18991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B11A37387
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912273AB6ED
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156C418DB01;
	Sun, 16 Feb 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHcbNHOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236161922E0
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699045; cv=none; b=VKlUW6O6USfcDAf+DOK02p32jgzSXHxkXcMor6fH2ISFD/Xj0JBVHnAwrR+R1gJ9jcJwMgtBVFhSMxUYCjUUUjEHMrDSwGQu4Iw3XMYrmdlwbtfvAGPU43+I6uKG6g+xpJ8/bCzPTOhVUk2v5XjXDVc0e93Xo+qDT1UtDnn9l0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699045; c=relaxed/simple;
	bh=h8QPlytHKbp59LXHgyOICGV5bbs/qBc1VcF6kYGVu1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oF01OkRvTjYPOUlNVnoDyrco/Sfk8Zo8Pkrx7/wlNCERxua8t4FiUcb2rXKHWUXLjD9JbRS88aF+Y2KMjjlQ/5/R0pwaHlyBYfk9erX0RFCr0Z+t5Bhf6xxfRgLnGyunWEmhccr0wo8XyZXGdLlmf4nkUwADbUNIOgNlJgFWC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHcbNHOI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699043; x=1771235043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h8QPlytHKbp59LXHgyOICGV5bbs/qBc1VcF6kYGVu1k=;
  b=UHcbNHOIm/Jpo2za9SKfTIY1EkIpjSIccsd/G9lfqOzoF5cA7vVP4yp/
   SOhSlG3Deavv6wT6EvcdJo8KpOge7+Kqg5cAwi4F6auwnCj3zJA4ITHew
   palO6pIkzoeko7snDw5q9rXLFGocLAsQPjzf1L2G1xbU1gwjntqvojPqt
   R/Helm4SN0CBkfJEe/q7MKCIpPFMyHeM7dhBGVWNcyKdkywOoRtN4Gpm/
   6DBNvGAIOw+SwL1iD3UWjx0VcncpuL0E5Pr2fijlHF8eNneuc9H/r/fvG
   qJKYACm/jifTSijLmbl0zz6VgwzNQwEwkSTnOcyJtBXalBQ6Vk30hrdQB
   Q==;
X-CSE-ConnectionGUID: 1lRtW6PiQGyjkEBlnNuHAw==
X-CSE-MsgGUID: /N4EPDyyQIisJZWNI5+CzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323398"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323398"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:03 -0800
X-CSE-ConnectionGUID: ZbiqLtT6QKiblU8RC/jFoQ==
X-CSE-MsgGUID: 4fJwaRazToSobQULkbelkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785249"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 21/42] wifi: iwlwifi: mld: add file power.h/c
Date: Sun, 16 Feb 2025 11:43:00 +0200
Message-Id: <20250216111648.e848d2d90594.Ifa65568d5aa8d23fa02c99aa6a55da9cebebeb8b@changeid>
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

these files are handling power aspects

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/power.c    | 395 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mld/power.h    |  33 ++
 2 files changed, 428 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
new file mode 100644
index 000000000000..ed7c0319f239
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#include <net/mac80211.h>
+
+#include "mld.h"
+#include "hcmd.h"
+#include "power.h"
+#include "iface.h"
+#include "link.h"
+#include "constants.h"
+
+static void iwl_mld_vif_ps_iterator(void *data, u8 *mac,
+				    struct ieee80211_vif *vif)
+{
+	bool *ps_enable = (bool *)data;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	*ps_enable &= vif->cfg.ps;
+}
+
+int iwl_mld_update_device_power(struct iwl_mld *mld, bool d3)
+{
+	struct iwl_device_power_cmd cmd = {};
+	bool enable_ps = false;
+
+	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM) {
+		enable_ps = true;
+
+		/* Disable power save if any STA interface has
+		 * power save turned off
+		 */
+		ieee80211_iterate_active_interfaces_mtx(mld->hw,
+							IEEE80211_IFACE_ITER_NORMAL,
+							iwl_mld_vif_ps_iterator,
+							&enable_ps);
+	}
+
+	if (enable_ps)
+		cmd.flags |=
+			cpu_to_le16(DEVICE_POWER_FLAGS_POWER_SAVE_ENA_MSK);
+
+	if (d3)
+		cmd.flags |=
+			cpu_to_le16(DEVICE_POWER_FLAGS_NO_SLEEP_TILL_D3_MSK);
+
+	IWL_DEBUG_POWER(mld,
+			"Sending device power command with flags = 0x%X\n",
+			cmd.flags);
+
+	return iwl_mld_send_cmd_pdu(mld, POWER_TABLE_CMD, &cmd);
+}
+
+int iwl_mld_enable_beacon_filter(struct iwl_mld *mld,
+				 const struct ieee80211_bss_conf *link_conf,
+				 bool d3)
+{
+	struct iwl_beacon_filter_cmd cmd = {
+		IWL_BF_CMD_CONFIG_DEFAULTS,
+		.bf_enable_beacon_filter = cpu_to_le32(1),
+		.ba_enable_beacon_abort = cpu_to_le32(1),
+	};
+
+	if (ieee80211_vif_type_p2p(link_conf->vif) != NL80211_IFTYPE_STATION)
+		return 0;
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	if (iwl_mld_vif_from_mac80211(link_conf->vif)->disable_bf)
+		return 0;
+#endif
+
+	if (link_conf->cqm_rssi_thold) {
+		cmd.bf_energy_delta =
+			cpu_to_le32(link_conf->cqm_rssi_hyst);
+		/* fw uses an absolute value for this */
+		cmd.bf_roaming_state =
+			cpu_to_le32(-link_conf->cqm_rssi_thold);
+	}
+
+	if (d3)
+		cmd.ba_escape_timer = cpu_to_le32(IWL_BA_ESCAPE_TIMER_D3);
+
+	return iwl_mld_send_cmd_pdu(mld, REPLY_BEACON_FILTERING_CMD,
+				    &cmd);
+}
+
+int iwl_mld_disable_beacon_filter(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif)
+{
+	struct iwl_beacon_filter_cmd cmd = {};
+
+	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION)
+		return 0;
+
+	return iwl_mld_send_cmd_pdu(mld, REPLY_BEACON_FILTERING_CMD,
+				    &cmd);
+}
+
+static bool iwl_mld_power_is_radar(struct iwl_mld *mld,
+				   const struct ieee80211_bss_conf *link_conf)
+{
+	const struct ieee80211_chanctx_conf *chanctx_conf;
+
+	chanctx_conf = wiphy_dereference(mld->wiphy, link_conf->chanctx_conf);
+
+	if (WARN_ON(!chanctx_conf))
+		return false;
+
+	return chanctx_conf->def.chan->flags & IEEE80211_CHAN_RADAR;
+}
+
+static void iwl_mld_power_configure_uapsd(struct iwl_mld *mld,
+					  struct iwl_mld_link *link,
+					  struct iwl_mac_power_cmd *cmd,
+					  bool ps_poll)
+{
+	bool tid_found = false;
+
+	cmd->rx_data_timeout_uapsd =
+		cpu_to_le32(IWL_MLD_UAPSD_RX_DATA_TIMEOUT);
+	cmd->tx_data_timeout_uapsd =
+		cpu_to_le32(IWL_MLD_UAPSD_TX_DATA_TIMEOUT);
+
+	 /* set advanced pm flag with no uapsd ACs to enable ps-poll */
+	if (ps_poll) {
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_ADVANCE_PM_ENA_MSK);
+		return;
+	}
+
+	for (enum ieee80211_ac_numbers ac = IEEE80211_AC_VO;
+	     ac <= IEEE80211_AC_BK;
+	     ac++) {
+		if (!link->queue_params[ac].uapsd)
+			continue;
+
+		cmd->flags |=
+			cpu_to_le16(POWER_FLAGS_ADVANCE_PM_ENA_MSK |
+				    POWER_FLAGS_UAPSD_MISBEHAVING_ENA_MSK);
+
+		cmd->uapsd_ac_flags |= BIT(ac);
+
+		/* QNDP TID - the highest TID with no admission control */
+		if (!tid_found && !link->queue_params[ac].acm) {
+			tid_found = true;
+			switch (ac) {
+			case IEEE80211_AC_VO:
+				cmd->qndp_tid = 6;
+				break;
+			case IEEE80211_AC_VI:
+				cmd->qndp_tid = 5;
+				break;
+			case IEEE80211_AC_BE:
+				cmd->qndp_tid = 0;
+				break;
+			case IEEE80211_AC_BK:
+				cmd->qndp_tid = 1;
+				break;
+			}
+		}
+	}
+
+	if (cmd->uapsd_ac_flags == (BIT(IEEE80211_AC_VO) |
+				    BIT(IEEE80211_AC_VI) |
+				    BIT(IEEE80211_AC_BE) |
+				    BIT(IEEE80211_AC_BK))) {
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_SNOOZE_ENA_MSK);
+		cmd->snooze_interval = cpu_to_le16(IWL_MLD_PS_SNOOZE_INTERVAL);
+		cmd->snooze_window = cpu_to_le16(IWL_MLD_PS_SNOOZE_WINDOW);
+	}
+
+	cmd->uapsd_max_sp = mld->hw->uapsd_max_sp_len;
+}
+
+static void
+iwl_mld_power_config_skip_dtim(struct iwl_mld *mld,
+			       const struct ieee80211_bss_conf *link_conf,
+			       struct iwl_mac_power_cmd *cmd)
+{
+	unsigned int dtimper_tu;
+	unsigned int dtimper;
+	unsigned int skip;
+
+	dtimper = link_conf->dtim_period ?: 1;
+	dtimper_tu = dtimper * link_conf->beacon_int;
+
+	if (dtimper >= 10 || iwl_mld_power_is_radar(mld, link_conf))
+		return;
+
+	if (WARN_ON(!dtimper_tu))
+		return;
+
+	/* configure skip over dtim up to 900 TU DTIM interval */
+	skip = max_t(int, 1, 900 / dtimper_tu);
+
+	cmd->skip_dtim_periods = skip;
+	cmd->flags |= cpu_to_le16(POWER_FLAGS_SKIP_OVER_DTIM_MSK);
+}
+
+#define POWER_KEEP_ALIVE_PERIOD_SEC    25
+static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    struct iwl_mac_power_cmd *cmd,
+				    bool d3)
+{
+	int dtimper, bi;
+	int keep_alive;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf = &vif->bss_conf;
+	struct iwl_mld_link *link = &mld_vif->deflink;
+	bool ps_poll = false;
+
+	cmd->id_and_color = cpu_to_le32(mld_vif->fw_id);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		int link_id;
+
+		if (WARN_ON(!vif->active_links))
+			return;
+
+		/* The firmware consumes one single configuration for the vif
+		 * and can't differentiate between links, just pick the lowest
+		 * link_id's configuration and use that.
+		 */
+		link_id = __ffs(vif->active_links);
+		link_conf = link_conf_dereference_check(vif, link_id);
+		link = iwl_mld_link_dereference_check(mld_vif, link_id);
+
+		if (WARN_ON(!link_conf || !link))
+			return;
+	}
+	dtimper = link_conf->dtim_period;
+	bi = link_conf->beacon_int;
+
+	/* Regardless of power management state the driver must set
+	 * keep alive period. FW will use it for sending keep alive NDPs
+	 * immediately after association. Check that keep alive period
+	 * is at least 3 * DTIM
+	 */
+	keep_alive = DIV_ROUND_UP(ieee80211_tu_to_usec(3 * dtimper * bi),
+				  USEC_PER_SEC);
+	keep_alive = max(keep_alive, POWER_KEEP_ALIVE_PERIOD_SEC);
+	cmd->keep_alive_seconds = cpu_to_le16(keep_alive);
+
+	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM)
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_POWER_SAVE_ENA_MSK);
+
+	if (!vif->cfg.ps || iwl_mld_tdls_sta_count(mld) > 0)
+		return;
+
+	cmd->flags |= cpu_to_le16(POWER_FLAGS_POWER_MANAGEMENT_ENA_MSK);
+
+	/* firmware supports LPRX for beacons at rate 1 Mbps or 6 Mbps only */
+	if (link_conf->beacon_rate &&
+	    (link_conf->beacon_rate->bitrate == 10 ||
+	     link_conf->beacon_rate->bitrate == 60)) {
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_LPRX_ENA_MSK);
+		cmd->lprx_rssi_threshold = POWER_LPRX_RSSI_THRESHOLD;
+	}
+
+	if (d3) {
+		iwl_mld_power_config_skip_dtim(mld, link_conf, cmd);
+		cmd->rx_data_timeout =
+			cpu_to_le32(IWL_MLD_WOWLAN_PS_RX_DATA_TIMEOUT);
+		cmd->tx_data_timeout =
+			cpu_to_le32(IWL_MLD_WOWLAN_PS_TX_DATA_TIMEOUT);
+	} else if (iwl_mld_vif_low_latency(mld_vif) && vif->p2p) {
+		cmd->tx_data_timeout =
+			cpu_to_le32(IWL_MLD_SHORT_PS_TX_DATA_TIMEOUT);
+		cmd->rx_data_timeout =
+			cpu_to_le32(IWL_MLD_SHORT_PS_RX_DATA_TIMEOUT);
+	} else {
+		cmd->rx_data_timeout =
+			cpu_to_le32(IWL_MLD_DEFAULT_PS_RX_DATA_TIMEOUT);
+		cmd->tx_data_timeout =
+			cpu_to_le32(IWL_MLD_DEFAULT_PS_TX_DATA_TIMEOUT);
+	}
+
+	/* uAPSD is only enabled for specific certifications. For those cases,
+	 * mac80211 will allow uAPSD. Always call iwl_mld_power_configure_uapsd
+	 * which will look at what mac80211 is saying.
+	 */
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	ps_poll = mld_vif->use_ps_poll;
+#endif
+	iwl_mld_power_configure_uapsd(mld, link, cmd, ps_poll);
+}
+
+int iwl_mld_update_mac_power(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			     bool d3)
+{
+	struct iwl_mac_power_cmd cmd = {};
+
+	iwl_mld_power_build_cmd(mld, vif, &cmd, d3);
+
+	return iwl_mld_send_cmd_pdu(mld, MAC_PM_POWER_TABLE, &cmd);
+}
+
+static void
+iwl_mld_tpe_sta_cmd_data(struct iwl_txpower_constraints_cmd *cmd,
+			 const struct ieee80211_bss_conf *link)
+{
+	u8 i;
+
+	/* NOTE: the 0 here is IEEE80211_TPE_CAT_6GHZ_DEFAULT,
+	 * we fully ignore IEEE80211_TPE_CAT_6GHZ_SUBORDINATE
+	 */
+
+	BUILD_BUG_ON(ARRAY_SIZE(cmd->psd_pwr) !=
+		     ARRAY_SIZE(link->tpe.psd_local[0].power));
+
+	/* if not valid, mac80211 puts default (max value) */
+	for (i = 0; i < ARRAY_SIZE(cmd->psd_pwr); i++)
+		cmd->psd_pwr[i] = min(link->tpe.psd_local[0].power[i],
+				      link->tpe.psd_reg_client[0].power[i]);
+
+	BUILD_BUG_ON(ARRAY_SIZE(cmd->eirp_pwr) !=
+		     ARRAY_SIZE(link->tpe.max_local[0].power));
+
+	for (i = 0; i < ARRAY_SIZE(cmd->eirp_pwr); i++)
+		cmd->eirp_pwr[i] = min(link->tpe.max_local[0].power[i],
+				       link->tpe.max_reg_client[0].power[i]);
+}
+
+void
+iwl_mld_send_ap_tx_power_constraint_cmd(struct iwl_mld *mld,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link)
+{
+	struct iwl_txpower_constraints_cmd cmd = {};
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (!mld_link->active)
+		return;
+
+	if (link->chanreq.oper.chan->band != NL80211_BAND_6GHZ)
+		return;
+
+	cmd.link_id = cpu_to_le16(mld_link->fw_id);
+	memset(cmd.psd_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.psd_pwr));
+	memset(cmd.eirp_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.eirp_pwr));
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
+	} else if (link->power_type == IEEE80211_REG_UNSET_AP) {
+		return;
+	} else {
+		cmd.ap_type = cpu_to_le16(link->power_type - 1);
+		iwl_mld_tpe_sta_cmd_data(&cmd, link);
+	}
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(PHY_OPS_GROUP,
+					   AP_TX_POWER_CONSTRAINTS_CMD),
+				   &cmd);
+	if (ret)
+		IWL_ERR(mld,
+			"failed to send AP_TX_POWER_CONSTRAINTS_CMD (%d)\n",
+			ret);
+}
+
+int iwl_mld_set_tx_power(struct iwl_mld *mld,
+			 struct ieee80211_bss_conf *link_conf,
+			 s16 tx_power)
+{
+	u32 cmd_id = REDUCE_TX_POWER_CMD;
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link_conf);
+	u16 u_tx_power = tx_power == IWL_DEFAULT_MAX_TX_POWER ?
+		IWL_DEV_MAX_TX_POWER : 8 * tx_power;
+	struct iwl_dev_tx_power_cmd cmd = {
+		/* Those fields sit on the same place for v9 and v10 */
+		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_LINK),
+		.common.pwr_restriction = cpu_to_le16(u_tx_power),
+	};
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id,
+					   IWL_FW_CMD_VER_UNKNOWN);
+	int len = sizeof(cmd.common);
+
+	if (WARN_ON(!mld_link))
+		return -ENODEV;
+
+	cmd.common.link_id = cpu_to_le32(mld_link->fw_id);
+
+	if (cmd_ver == 10)
+		len += sizeof(cmd.v10);
+	else if (cmd_ver == 9)
+		len += sizeof(cmd.v9);
+
+	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, len);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.h b/drivers/net/wireless/intel/iwlwifi/mld/power.h
new file mode 100644
index 000000000000..05ce27bef106
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_power_h__
+#define __iwl_mld_power_h__
+
+#include <net/mac80211.h>
+
+#include "mld.h"
+
+int iwl_mld_update_device_power(struct iwl_mld *mld, bool d3);
+
+int iwl_mld_enable_beacon_filter(struct iwl_mld *mld,
+				 const struct ieee80211_bss_conf *link_conf,
+				 bool d3);
+
+int iwl_mld_disable_beacon_filter(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif);
+
+int iwl_mld_update_mac_power(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			     bool d3);
+
+void
+iwl_mld_send_ap_tx_power_constraint_cmd(struct iwl_mld *mld,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link);
+
+int iwl_mld_set_tx_power(struct iwl_mld *mld,
+			 struct ieee80211_bss_conf *link_conf,
+			 s16 tx_power);
+
+#endif /* __iwl_mld_power_h__ */
-- 
2.34.1


