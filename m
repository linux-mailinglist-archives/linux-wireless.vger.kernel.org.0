Return-Path: <linux-wireless+bounces-18977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1395BA37379
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5D916CEE9
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB318DB3F;
	Sun, 16 Feb 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eljzTsvi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3D18DB00
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699027; cv=none; b=WXAAxBpJJAaZapm+ZnnqVTliCgfgiB2FLqyZibL5Yasenl1vEi1ngrK1XqIbs3rC/AS6FganDhdciWp9wQdR4rnEqlv9WUufiLWnQatgQ6jREi/tUfhoN+0rSyzi7w0aO1UciOzq43sN0q9KPWyCIMIdX2prcyEgAg2te6hdewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699027; c=relaxed/simple;
	bh=Q213pkjPH8ewenhXpjbN0UfSXudJQTstDYbbu/reBOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxzpIlyF+a2ucSIPmmPRoSPLnPY6OQyhu0zeNQ3MFf68lGrPkYf12t3oxrstpeKksB29YBrjAtIFuKiLnTt1vU9Mssq1fupWBQpmxNQzIhtJteJrz5yPbFLGV/q8d6l/PtTwxNlvV89dC2EJsybVwQvWxMQLDIsF7DiAjKH+/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eljzTsvi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699025; x=1771235025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q213pkjPH8ewenhXpjbN0UfSXudJQTstDYbbu/reBOE=;
  b=eljzTsvinGdSKmpEER7yV8DOi2SPvFfBZR5bRilgg/2TwB7Kicm3PZWO
   Qg10WVxGXlJFnXcsmA1OBfkgp4mAqRFqLGzqxDZ1TPArVDR5Lr8PYGqOh
   K4QUI0xbmub9ah3nw/IOKRHxkzUOE3yXC75R9bNCERD5yCVeia2absH7R
   GzgebxQEbGG4JJfkT9Z0PohA5plLemXUtFmir+DBiYjwsY+nOdfHDflLV
   wSO0HjH3RKTKzRchv0Ae7F5bEjEnU2Y/bCumNjsrPsFR5rk/RD7Z+/MeA
   A5FEGNZtTFa5KLTjHTwtvhiLHYUB+yRZoIuZAlokIDhVVDkh5rM6DWNDe
   A==;
X-CSE-ConnectionGUID: YRm9euhwRyKjUmK0lyX8Zw==
X-CSE-MsgGUID: vYBgzx+gQu+EPyzFw8dbBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323369"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323369"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:45 -0800
X-CSE-ConnectionGUID: aj1HAxrNTMqBvUWiLXVYXA==
X-CSE-MsgGUID: lhe5KAAESnmjgBBVvNUDAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785223"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 07/42] wifi: iwlwifi: mld: add file ftm-initiator.h/c
Date: Sun, 16 Feb 2025 11:42:46 +0200
Message-Id: <20250216111648.22a28a8eeaab.I192b3cd636b2203a4a39f41c77b60caf761192cd@changeid>
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

this file is handling a FTM

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/mld/ftm-initiator.c         | 451 ++++++++++++++++++
 .../intel/iwlwifi/mld/ftm-initiator.h         |  15 +
 2 files changed, 466 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
new file mode 100644
index 000000000000..f77ba21a174d
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#include <linux/etherdevice.h>
+#include <linux/math64.h>
+#include <net/cfg80211.h>
+#include "mld.h"
+#include "iface.h"
+#include "phy.h"
+#include "iwl-io.h"
+#include "iwl-prph.h"
+#include "constants.h"
+#include "fw/api/location.h"
+#include "ftm-initiator.h"
+
+static void iwl_mld_ftm_cmd_common(struct iwl_mld *mld,
+				   struct ieee80211_vif *vif,
+				   struct iwl_tof_range_req_cmd *cmd,
+				   struct cfg80211_pmsr_request *req)
+{
+	int i;
+
+	cmd->initiator_flags =
+		cpu_to_le32(IWL_TOF_INITIATOR_FLAGS_MACADDR_RANDOM |
+			    IWL_TOF_INITIATOR_FLAGS_NON_ASAP_SUPPORT);
+	cmd->request_id = req->cookie;
+	cmd->num_of_ap = req->n_peers;
+
+	/* Use a large value for "no timeout". Don't use the maximum value
+	 * because of fw limitations.
+	 */
+	if (req->timeout)
+		cmd->req_timeout_ms = cpu_to_le32(min(req->timeout, 0xfffff));
+	else
+		cmd->req_timeout_ms = cpu_to_le32(0xfffff);
+
+	memcpy(cmd->macaddr_template, req->mac_addr, ETH_ALEN);
+	for (i = 0; i < ETH_ALEN; i++)
+		cmd->macaddr_mask[i] = ~req->mac_addr_mask[i];
+
+	if (vif->cfg.assoc) {
+		memcpy(cmd->range_req_bssid, vif->bss_conf.bssid, ETH_ALEN);
+
+		/* AP's TSF is only relevant if associated */
+		for (i = 0; i < req->n_peers; i++) {
+			if (req->peers[i].report_ap_tsf) {
+				struct iwl_mld_vif *mld_vif =
+					iwl_mld_vif_from_mac80211(vif);
+
+				cmd->tsf_mac_id = cpu_to_le32(mld_vif->fw_id);
+				return;
+			}
+		}
+	} else {
+		eth_broadcast_addr(cmd->range_req_bssid);
+	}
+
+	/* Don't report AP's TSF */
+	cmd->tsf_mac_id = cpu_to_le32(0xff);
+}
+
+static int
+iwl_mld_ftm_set_target_chandef(struct iwl_mld *mld,
+			       struct cfg80211_pmsr_request_peer *peer,
+			       struct iwl_tof_range_req_ap_entry *target)
+{
+	u32 freq = peer->chandef.chan->center_freq;
+
+	target->channel_num = ieee80211_frequency_to_channel(freq);
+
+	switch (peer->chandef.width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		target->format_bw = IWL_LOCATION_FRAME_FORMAT_LEGACY;
+		target->format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_20:
+		target->format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
+		target->format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		target->format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
+		target->format_bw |= IWL_LOCATION_BW_40MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		target->format_bw = IWL_LOCATION_FRAME_FORMAT_VHT;
+		target->format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		target->format_bw = IWL_LOCATION_FRAME_FORMAT_HE;
+		target->format_bw |= IWL_LOCATION_BW_160MHZ << LOCATION_BW_POS;
+		break;
+	default:
+		IWL_ERR(mld, "Unsupported BW in FTM request (%d)\n",
+			peer->chandef.width);
+		return -EINVAL;
+}
+
+	/* non EDCA based measurement must use HE preamble */
+	if (peer->ftm.trigger_based || peer->ftm.non_trigger_based)
+		target->format_bw |= IWL_LOCATION_FRAME_FORMAT_HE;
+
+	target->ctrl_ch_position =
+		(peer->chandef.width > NL80211_CHAN_WIDTH_20) ?
+		iwl_mld_get_fw_ctrl_pos(&peer->chandef) : 0;
+
+	target->band = iwl_mld_nl80211_band_to_fw(peer->chandef.chan->band);
+	return 0;
+}
+
+#define FTM_SET_FLAG(flag) (target->initiator_ap_flags |= \
+			    cpu_to_le32(IWL_INITIATOR_AP_FLAGS_##flag))
+
+static void
+iwl_mld_ftm_set_target_flags(struct iwl_mld *mld,
+			     struct cfg80211_pmsr_request_peer *peer,
+			     struct iwl_tof_range_req_ap_entry *target)
+{
+	target->initiator_ap_flags = cpu_to_le32(0);
+
+	if (peer->ftm.asap)
+		FTM_SET_FLAG(ASAP);
+
+	if (peer->ftm.request_lci)
+		FTM_SET_FLAG(LCI_REQUEST);
+
+	if (peer->ftm.request_civicloc)
+		FTM_SET_FLAG(CIVIC_REQUEST);
+
+	if (IWL_MLD_FTM_INITIATOR_DYNACK)
+		FTM_SET_FLAG(DYN_ACK);
+
+	if (IWL_MLD_FTM_INITIATOR_ALGO == IWL_TOF_ALGO_TYPE_LINEAR_REG)
+		FTM_SET_FLAG(ALGO_LR);
+	else if (IWL_MLD_FTM_INITIATOR_ALGO == IWL_TOF_ALGO_TYPE_FFT)
+		FTM_SET_FLAG(ALGO_FFT);
+
+	if (peer->ftm.trigger_based)
+		FTM_SET_FLAG(TB);
+	else if (peer->ftm.non_trigger_based)
+		FTM_SET_FLAG(NON_TB);
+
+	if ((peer->ftm.trigger_based || peer->ftm.non_trigger_based) &&
+	    peer->ftm.lmr_feedback)
+		FTM_SET_FLAG(LMR_FEEDBACK);
+}
+
+static void iwl_mld_ftm_set_sta(struct iwl_mld *mld, struct ieee80211_vif *vif,
+				struct cfg80211_pmsr_request_peer *peer,
+				struct iwl_tof_range_req_ap_entry *target)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	u32 sta_id_mask;
+
+	target->sta_id = IWL_INVALID_STA;
+
+	/* TODO: add ftm_unprotected debugfs support */
+
+	if (!vif->cfg.assoc || !mld_vif->ap_sta)
+		return;
+
+	sta_id_mask = iwl_mld_fw_sta_id_mask(mld, mld_vif->ap_sta);
+	if (WARN_ON(hweight32(sta_id_mask) != 1))
+		return;
+
+	target->sta_id = __ffs(sta_id_mask);
+
+	if (mld_vif->ap_sta->mfp &&
+	    (peer->ftm.trigger_based || peer->ftm.non_trigger_based))
+		FTM_SET_FLAG(PMF);
+}
+
+static int
+iwl_mld_ftm_set_target(struct iwl_mld *mld, struct ieee80211_vif *vif,
+		       struct cfg80211_pmsr_request_peer *peer,
+		       struct iwl_tof_range_req_ap_entry *target)
+{
+	u32 i2r_max_sts;
+	int ret;
+
+	ret = iwl_mld_ftm_set_target_chandef(mld, peer, target);
+	if (ret)
+		return ret;
+
+	memcpy(target->bssid, peer->addr, ETH_ALEN);
+	target->burst_period = cpu_to_le16(peer->ftm.burst_period);
+	target->samples_per_burst = peer->ftm.ftms_per_burst;
+	target->num_of_bursts = peer->ftm.num_bursts_exp;
+	iwl_mld_ftm_set_target_flags(mld, peer, target);
+	iwl_mld_ftm_set_sta(mld, vif, peer, target);
+
+	/* TODO: add secured ranging support */
+
+	i2r_max_sts = IWL_MLD_FTM_I2R_MAX_STS > 1 ? 1 :
+		IWL_MLD_FTM_I2R_MAX_STS;
+
+	target->r2i_ndp_params = IWL_MLD_FTM_R2I_MAX_REP |
+		(IWL_MLD_FTM_R2I_MAX_STS << IWL_LOCATION_MAX_STS_POS) |
+		(IWL_MLD_FTM_R2I_MAX_TOTAL_LTF << IWL_LOCATION_TOTAL_LTF_POS);
+	target->i2r_ndp_params = IWL_MLD_FTM_I2R_MAX_REP |
+		(i2r_max_sts << IWL_LOCATION_MAX_STS_POS) |
+		(IWL_MLD_FTM_I2R_MAX_TOTAL_LTF << IWL_LOCATION_TOTAL_LTF_POS);
+
+	if (peer->ftm.non_trigger_based) {
+		target->min_time_between_msr =
+			cpu_to_le16(IWL_MLD_FTM_NON_TB_MIN_TIME_BETWEEN_MSR);
+		target->burst_period =
+			cpu_to_le16(IWL_MLD_FTM_NON_TB_MAX_TIME_BETWEEN_MSR);
+	} else {
+		target->min_time_between_msr = cpu_to_le16(0);
+	}
+
+	/* TODO: Beacon interval is currently unknown, so use the common value
+	 * of 100 TUs.
+	 */
+	target->beacon_interval = cpu_to_le16(100);
+
+	return 0;
+}
+
+int iwl_mld_ftm_start(struct iwl_mld *mld, struct ieee80211_vif *vif,
+		      struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
+		.dataflags[0] = IWL_HCMD_DFL_DUP,
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+	u8 i;
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (mld->ftm_initiator.req)
+		return -EBUSY;
+
+	if (req->n_peers > ARRAY_SIZE(cmd.ap))
+		return -EINVAL;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	iwl_mld_ftm_cmd_common(mld, vif, (void *)&cmd, req);
+
+	for (i = 0; i < cmd.num_of_ap; i++) {
+		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
+		struct iwl_tof_range_req_ap_entry *target = &cmd.ap[i];
+
+		ret = iwl_mld_ftm_set_target(mld, vif, peer, target);
+		if (ret)
+			return ret;
+	}
+
+	/* TODO: get the status from the response*/
+	ret = iwl_mld_send_cmd(mld, &hcmd);
+	if (!ret) {
+		mld->ftm_initiator.req = req;
+		mld->ftm_initiator.req_wdev = ieee80211_vif_to_wdev(vif);
+	}
+
+	return ret;
+}
+
+static void iwl_mld_ftm_reset(struct iwl_mld *mld)
+{
+	lockdep_assert_wiphy(mld->wiphy);
+
+	mld->ftm_initiator.req = NULL;
+	mld->ftm_initiator.req_wdev = NULL;
+	memset(mld->ftm_initiator.responses, 0,
+	       sizeof(mld->ftm_initiator.responses));
+}
+
+static int iwl_mld_ftm_range_resp_valid(struct iwl_mld *mld, u8 request_id,
+					u8 num_of_aps)
+{
+	if (IWL_FW_CHECK(mld, request_id != (u8)mld->ftm_initiator.req->cookie,
+			 "Request ID mismatch, got %u, active %u\n",
+			 request_id, (u8)mld->ftm_initiator.req->cookie))
+		return -EINVAL;
+
+	if (IWL_FW_CHECK(mld, num_of_aps > mld->ftm_initiator.req->n_peers ||
+			 num_of_aps > IWL_TOF_MAX_APS,
+			 "FTM range response: invalid num of APs (%u)\n",
+			 num_of_aps))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int iwl_mld_ftm_find_peer(struct cfg80211_pmsr_request *req,
+				 const u8 *addr)
+{
+	for (int i = 0; i < req->n_peers; i++) {
+		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
+
+		if (ether_addr_equal_unaligned(peer->addr, addr))
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+static void iwl_mld_debug_range_resp(struct iwl_mld *mld, u8 index,
+				     struct cfg80211_pmsr_result *res)
+{
+	s64 rtt_avg = div_s64(res->ftm.rtt_avg * 100, 6666);
+
+	IWL_DEBUG_INFO(mld, "entry %d\n", index);
+	IWL_DEBUG_INFO(mld, "\tstatus: %d\n", res->status);
+	IWL_DEBUG_INFO(mld, "\tBSSID: %pM\n", res->addr);
+	IWL_DEBUG_INFO(mld, "\thost time: %llu\n", res->host_time);
+	IWL_DEBUG_INFO(mld, "\tburst index: %d\n", res->ftm.burst_index);
+	IWL_DEBUG_INFO(mld, "\tsuccess num: %u\n", res->ftm.num_ftmr_successes);
+	IWL_DEBUG_INFO(mld, "\trssi: %d\n", res->ftm.rssi_avg);
+	IWL_DEBUG_INFO(mld, "\trssi spread: %d\n", res->ftm.rssi_spread);
+	IWL_DEBUG_INFO(mld, "\trtt: %lld\n", res->ftm.rtt_avg);
+	IWL_DEBUG_INFO(mld, "\trtt var: %llu\n", res->ftm.rtt_variance);
+	IWL_DEBUG_INFO(mld, "\trtt spread: %llu\n", res->ftm.rtt_spread);
+	IWL_DEBUG_INFO(mld, "\tdistance: %lld\n", rtt_avg);
+}
+
+void iwl_mld_handle_ftm_resp_notif(struct iwl_mld *mld,
+				   struct iwl_rx_packet *pkt)
+{
+	struct iwl_tof_range_rsp_ntfy *fw_resp = (void *)pkt->data;
+	u8 num_of_aps, last_in_batch;
+
+	if (IWL_FW_CHECK(mld, !mld->ftm_initiator.req,
+			 "FTM response without a pending request\n"))
+		return;
+
+	if (iwl_mld_ftm_range_resp_valid(mld, fw_resp->request_id,
+					 fw_resp->num_of_aps))
+		return;
+
+	num_of_aps = fw_resp->num_of_aps;
+	last_in_batch = fw_resp->last_report;
+
+	IWL_DEBUG_INFO(mld, "Range response received\n");
+	IWL_DEBUG_INFO(mld, "request id: %llu, num of entries: %u\n",
+		       mld->ftm_initiator.req->cookie, num_of_aps);
+
+	for (int i = 0; i < num_of_aps; i++) {
+		struct cfg80211_pmsr_result result = {};
+		struct iwl_tof_range_rsp_ap_entry_ntfy *fw_ap;
+		int peer_idx;
+
+		fw_ap = &fw_resp->ap[i];
+		result.final = fw_ap->last_burst;
+		result.ap_tsf = le32_to_cpu(fw_ap->start_tsf);
+		result.ap_tsf_valid = 1;
+
+		peer_idx = iwl_mld_ftm_find_peer(mld->ftm_initiator.req,
+						 fw_ap->bssid);
+		if (peer_idx < 0) {
+			IWL_WARN(mld,
+				 "Unknown address (%pM, target #%d) in FTM response\n",
+				 fw_ap->bssid, i);
+			continue;
+		}
+
+		switch (fw_ap->measure_status) {
+		case IWL_TOF_ENTRY_SUCCESS:
+			result.status = NL80211_PMSR_STATUS_SUCCESS;
+			break;
+		case IWL_TOF_ENTRY_TIMING_MEASURE_TIMEOUT:
+			result.status = NL80211_PMSR_STATUS_TIMEOUT;
+			break;
+		case IWL_TOF_ENTRY_NO_RESPONSE:
+			result.status = NL80211_PMSR_STATUS_FAILURE;
+			result.ftm.failure_reason =
+				NL80211_PMSR_FTM_FAILURE_NO_RESPONSE;
+			break;
+		case IWL_TOF_ENTRY_REQUEST_REJECTED:
+			result.status = NL80211_PMSR_STATUS_FAILURE;
+			result.ftm.failure_reason =
+				NL80211_PMSR_FTM_FAILURE_PEER_BUSY;
+			result.ftm.busy_retry_time = fw_ap->refusal_period;
+			break;
+		default:
+			result.status = NL80211_PMSR_STATUS_FAILURE;
+			result.ftm.failure_reason =
+				NL80211_PMSR_FTM_FAILURE_UNSPECIFIED;
+			break;
+		}
+		memcpy(result.addr, fw_ap->bssid, ETH_ALEN);
+
+		/* TODO: convert the timestamp from the result to systime */
+		result.host_time = ktime_get_boottime_ns();
+
+		result.type = NL80211_PMSR_TYPE_FTM;
+		result.ftm.burst_index = mld->ftm_initiator.responses[peer_idx];
+		mld->ftm_initiator.responses[peer_idx]++;
+		result.ftm.rssi_avg = fw_ap->rssi;
+		result.ftm.rssi_avg_valid = 1;
+		result.ftm.rssi_spread = fw_ap->rssi_spread;
+		result.ftm.rssi_spread_valid = 1;
+		result.ftm.rtt_avg = (s32)le32_to_cpu(fw_ap->rtt);
+		result.ftm.rtt_avg_valid = 1;
+		result.ftm.rtt_variance = le32_to_cpu(fw_ap->rtt_variance);
+		result.ftm.rtt_variance_valid = 1;
+		result.ftm.rtt_spread = le32_to_cpu(fw_ap->rtt_spread);
+		result.ftm.rtt_spread_valid = 1;
+
+		cfg80211_pmsr_report(mld->ftm_initiator.req_wdev,
+				     mld->ftm_initiator.req,
+				     &result, GFP_KERNEL);
+
+		if (fw_has_api(&mld->fw->ucode_capa,
+			       IWL_UCODE_TLV_API_FTM_RTT_ACCURACY))
+			IWL_DEBUG_INFO(mld, "RTT confidence: %u\n",
+				       fw_ap->rttConfidence);
+
+		iwl_mld_debug_range_resp(mld, i, &result);
+	}
+
+	if (last_in_batch) {
+		cfg80211_pmsr_complete(mld->ftm_initiator.req_wdev,
+				       mld->ftm_initiator.req,
+				       GFP_KERNEL);
+		iwl_mld_ftm_reset(mld);
+	}
+}
+
+void iwl_mld_ftm_restart_cleanup(struct iwl_mld *mld)
+{
+	struct cfg80211_pmsr_result result = {
+		.status = NL80211_PMSR_STATUS_FAILURE,
+		.final = 1,
+		.host_time = ktime_get_boottime_ns(),
+		.type = NL80211_PMSR_TYPE_FTM,
+	};
+
+	if (!mld->ftm_initiator.req)
+		return;
+
+	for (int i = 0; i < mld->ftm_initiator.req->n_peers; i++) {
+		memcpy(result.addr, mld->ftm_initiator.req->peers[i].addr,
+		       ETH_ALEN);
+
+		cfg80211_pmsr_report(mld->ftm_initiator.req_wdev,
+				     mld->ftm_initiator.req,
+				     &result, GFP_KERNEL);
+	}
+
+	cfg80211_pmsr_complete(mld->ftm_initiator.req_wdev,
+			       mld->ftm_initiator.req, GFP_KERNEL);
+	iwl_mld_ftm_reset(mld);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
new file mode 100644
index 000000000000..ff6021659442
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#ifndef __iwl_mld_ftm_initiator_h__
+#define __iwl_mld_ftm_initiator_h__
+
+int iwl_mld_ftm_start(struct iwl_mld *mld, struct ieee80211_vif *vif,
+		      struct cfg80211_pmsr_request *req);
+
+void iwl_mld_handle_ftm_resp_notif(struct iwl_mld *mld,
+				   struct iwl_rx_packet *pkt);
+void iwl_mld_ftm_restart_cleanup(struct iwl_mld *mld);
+
+#endif /* __iwl_mld_ftm_initiator_h__ */
-- 
2.34.1


