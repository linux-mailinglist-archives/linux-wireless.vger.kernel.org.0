Return-Path: <linux-wireless+bounces-18534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E15A28B06
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764EA7A3582
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924B91426C;
	Wed,  5 Feb 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVsj9ERv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D31FC1D
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760195; cv=none; b=MLx/863EJglGiUuZztS8lk9Ktt+CWwypRjz8FKsOjF25SCfH035hsgD23qTTBrmH/PfYsj1voFt9UkSZOPCQIHood46Vo8OGhJTF6115qgee6bt1yf1dozzUQ5I4M5mLrgbZrllfZFxT5GePQNpsqU3gVvyz5kS8wbAp4CPKUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760195; c=relaxed/simple;
	bh=/JHREcTEfxE6izzE1k0uZBJTLz73phPEpbPkQJMHRWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7jS9r18s8E+K0iybovUeG0mzqd5RWIJ1g3biwCM2MkeE5FZGKh5kL4ezzPuQzd13+o3b69iYqx1Dpasv9iBi+dhQY2vcGqpQuhZ1J/938uRI4XW4CI+zqzIM0w2ZIr1fOW4Z6h2YUtYQa/fFdwRQImChTW8UOwQH+MZk16TZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVsj9ERv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760194; x=1770296194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/JHREcTEfxE6izzE1k0uZBJTLz73phPEpbPkQJMHRWs=;
  b=gVsj9ERvkDQ/zWY5K4J5EHUrP6rkexKPPk3TZuji350uBnIAeKI9+1bP
   DwH8J1cBjpfk51EdqwbaRtS6Y1zpRm3lq8EVtHyTn1OmJbwTk3HBE6xUa
   kGCd2mhuk4T960XvoLCCP8EElQb3lMR/XKnD3LTXyZZM/7zYhB0jX1+bD
   Kwr90cjDm4XPP2hHByi9vXteR81wgX5S0WCmXfWvUjJB3CVHeJx2PBFfP
   imIlIXH4QX4CW3d3cRqNN8xENwuaW2mk48mCtxtqNWRZ+25gqGkn95S2Z
   QsQIrK8rW2C/7EmPpm4Hv8tTuTp9j/C9vpmsok4lsNAUxp3YdAVOgwrKI
   Q==;
X-CSE-ConnectionGUID: QBGCHCI8S76ownppDcfh0A==
X-CSE-MsgGUID: nm8ce6PhTSyggqiW3aBkWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159220"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159220"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:33 -0800
X-CSE-ConnectionGUID: 3n8TZvxRTQ6KwPqJwHO+3Q==
X-CSE-MsgGUID: GiAStNbMROOcnkwQzsSk2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745498"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 16/19] wifi: iwlwifi: support ROC version 6
Date: Wed,  5 Feb 2025 14:55:45 +0200
Message-Id: <20250205145347.956c33729d48.I609835c08f0003c084a13a1e1e505cb7bc8ecbc6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

Version 6 added ROC with multi repetitions.
We don't use it, but need to update the command
length.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/fw/api/time-event.h         |  42 +++-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c  | 224 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   6 +-
 3 files changed, 265 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.c

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index 18d030334a6a..f586379d66dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020, 2022-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020, 2022-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -351,7 +351,7 @@ enum iwl_roc_activity {
 }; /* ROC_ACTIVITY_API_E_VER_1 */
 
 /*
- * ROC command
+ * ROC command v5
  *
  * Command requests the firmware to remain on a channel for a certain duration.
  *
@@ -366,7 +366,7 @@ enum iwl_roc_activity {
  * @max_delay: max delay the ROC can start in TU
  * @duration: remain on channel duration in TU
  */
-struct iwl_roc_req {
+struct iwl_roc_req_v5 {
 	__le32 action;
 	__le32 activity;
 	__le32 sta_id;
@@ -375,7 +375,41 @@ struct iwl_roc_req {
 	__le16 reserved;
 	__le32 max_delay;
 	__le32 duration;
-} __packed; /* ROC_CMD_API_S_VER_3 */
+} __packed; /* ROC_CMD_API_S_VER_5 */
+
+/*
+ * ROC command
+ *
+ * Command requests the firmware to remain on a channel for a certain duration.
+ *
+ * ( MAC_CONF_GROUP 0x3, ROC_CMD 0xE )
+ *
+ * @action: action to perform, see &enum iwl_ctxt_action
+ * @activity: type of activity, see &enum iwl_roc_activity
+ * @sta_id: station id, resumed during "Remain On Channel" activity.
+ * @channel_info: &struct iwl_fw_channel_info
+ * @node_addr: node MAC address for Rx filtering
+ * @reserved1: align to a dword
+ * @max_delay: max delay the ROC can start in TU
+ * @duration: remain on channel duration in TU
+ * @interval: interval between repetitions (when repetitions > 1).
+ * @repetitions: number of repetitions
+ *	0xFF: infinite repetitions. 0 or 1: single repetition.
+ * @reserved2: align to a dword
+ */
+struct iwl_roc_req {
+	__le32 action;
+	__le32 activity;
+	__le32 sta_id;
+	struct iwl_fw_channel_info channel_info;
+	u8 node_addr[ETH_ALEN];
+	__le16 reserved1;
+	__le32 max_delay;
+	__le32 duration;
+	__le32 interval;
+	u8 repetitions;
+	u8 reserved2[3];
+} __packed; /* ROC_CMD_API_S_VER_6 */
 
 /*
  * ROC notification
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.c b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
new file mode 100644
index 000000000000..b87faca23ceb
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 - 2025 Intel Corporation
+ */
+#include <net/cfg80211.h>
+#include <net/mac80211.h>
+
+#include "mld.h"
+#include "roc.h"
+#include "hcmd.h"
+#include "iface.h"
+#include "sta.h"
+#include "mlo.h"
+
+#include "fw/api/context.h"
+#include "fw/api/time-event.h"
+
+#define AUX_ROC_MAX_DELAY MSEC_TO_TU(200)
+
+static void
+iwl_mld_vif_iter_emlsr_block_roc(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int *result = data;
+	int ret;
+
+	ret = iwl_mld_block_emlsr_sync(mld_vif->mld, vif,
+				       IWL_MLD_EMLSR_BLOCKED_ROC,
+				       iwl_mld_get_primary_link(vif));
+	if (ret)
+		*result = ret;
+}
+
+int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct ieee80211_channel *channel, int duration,
+		      enum ieee80211_roc_type type)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_int_sta *aux_sta;
+	struct iwl_roc_req cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+	};
+	u8 ver = iwl_fw_lookup_cmd_ver(mld->fw,
+				       WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
+	u16 cmd_len = ver < 6 ? sizeof(struct iwl_roc_req_v5) : sizeof(cmd);
+	enum iwl_roc_activity activity;
+	int ret = 0;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_emlsr_block_roc,
+						&ret);
+	if (ret)
+		return ret;
+
+	/* TODO: task=Hotspot 2.0 */
+	if (vif->type != NL80211_IFTYPE_P2P_DEVICE) {
+		IWL_ERR(mld, "NOT SUPPORTED: ROC on vif->type %d\n",
+			vif->type);
+
+		return -EOPNOTSUPP;
+	}
+
+	switch (type) {
+	case IEEE80211_ROC_TYPE_NORMAL:
+		activity = ROC_ACTIVITY_P2P_DISC;
+		break;
+	case IEEE80211_ROC_TYPE_MGMT_TX:
+		activity = ROC_ACTIVITY_P2P_NEG;
+		break;
+	default:
+		WARN_ONCE(1, "Got an invalid P2P ROC type\n");
+		return -EINVAL;
+	}
+
+	if (WARN_ON(mld_vif->roc_activity != ROC_NUM_ACTIVITIES))
+		return -EBUSY;
+
+	/* No MLO on P2P device */
+	aux_sta = &mld_vif->deflink.aux_sta;
+
+	ret = iwl_mld_add_aux_sta(mld, aux_sta);
+	if (ret)
+		return ret;
+
+	cmd.activity = cpu_to_le32(activity);
+	cmd.sta_id = cpu_to_le32(aux_sta->sta_id);
+	cmd.channel_info.channel = cpu_to_le32(channel->hw_value);
+	cmd.channel_info.band = iwl_mld_nl80211_band_to_fw(channel->band);
+	cmd.channel_info.width = IWL_PHY_CHANNEL_MODE20;
+	/* TODO: task=Hotspot 2.0, revisit those parameters when we add an ROC
+	 * on the BSS vif
+	 */
+	cmd.max_delay = cpu_to_le32(AUX_ROC_MAX_DELAY);
+	cmd.duration = cpu_to_le32(MSEC_TO_TU(duration));
+
+	memcpy(cmd.node_addr, vif->addr, ETH_ALEN);
+
+	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
+				   &cmd, cmd_len);
+	if (ret) {
+		IWL_ERR(mld, "Couldn't send the ROC_CMD\n");
+		return ret;
+	}
+	mld_vif->roc_activity = activity;
+
+	return 0;
+}
+
+static void
+iwl_mld_vif_iter_emlsr_unblock_roc(void *data, u8 *mac,
+				   struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	iwl_mld_unblock_emlsr(mld_vif->mld, vif, IWL_MLD_EMLSR_BLOCKED_ROC);
+}
+
+static void iwl_mld_destroy_roc(struct iwl_mld *mld,
+				struct ieee80211_vif *vif,
+				struct iwl_mld_vif *mld_vif)
+{
+	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_emlsr_unblock_roc,
+						NULL);
+
+	/* wait until every tx has seen that roc_activity has been reset */
+	synchronize_net();
+	/* from here, no new tx will be added
+	 * we can flush the Tx on the queues
+	 */
+
+	iwl_mld_flush_link_sta_txqs(mld, mld_vif->deflink.aux_sta.sta_id);
+
+	iwl_mld_remove_aux_sta(mld, vif, &vif->bss_conf);
+}
+
+int iwl_mld_cancel_roc(struct ieee80211_hw *hw,
+		       struct ieee80211_vif *vif)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_roc_req cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+	};
+	u8 ver = iwl_fw_lookup_cmd_ver(mld->fw,
+				       WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
+	u16 cmd_len = ver < 6 ? sizeof(struct iwl_roc_req_v5) : sizeof(cmd);
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* TODO: task=Hotspot 2.0 */
+	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE))
+		return -EOPNOTSUPP;
+
+	/* No roc activity running it's probably already done */
+	if (mld_vif->roc_activity == ROC_NUM_ACTIVITIES)
+		return 0;
+
+	cmd.activity = cpu_to_le32(mld_vif->roc_activity);
+
+	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
+				   &cmd, cmd_len);
+	if (ret)
+		IWL_ERR(mld, "Couldn't send the command to cancel the ROC\n");
+
+	/* We may have raced with the firmware expiring the ROC instance at
+	 * this very moment. In that case, we can have a notification in the
+	 * async processing queue. However, none can arrive _after_ this as
+	 * ROC_CMD was sent synchronously, i.e. we waited for a response and
+	 * the firmware cannot refer to this ROC after the response. Thus,
+	 * if we just cancel the notification (if there's one) we'll be at a
+	 * clean state for any possible next ROC.
+	 */
+	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_ROC,
+					       mld_vif->roc_activity);
+
+	iwl_mld_destroy_roc(mld, vif, mld_vif);
+
+	return 0;
+}
+
+void iwl_mld_handle_roc_notif(struct iwl_mld *mld,
+			      struct iwl_rx_packet *pkt)
+{
+	const struct iwl_roc_notif *notif = (void *)pkt->data;
+	u32 activity = le32_to_cpu(notif->activity);
+	/* TODO: task=Hotspot 2.0 - roc can run on BSS */
+	struct ieee80211_vif *vif = mld->p2p_device_vif;
+	struct iwl_mld_vif *mld_vif;
+
+	if (WARN_ON(!vif))
+		return;
+
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+	/* It is possible that the ROC was canceled
+	 * but the notification was already fired.
+	 */
+	if (mld_vif->roc_activity != activity)
+		return;
+
+	if (le32_to_cpu(notif->success) &&
+	    le32_to_cpu(notif->started)) {
+		/* We had a successful start */
+		ieee80211_ready_on_channel(mld->hw);
+	} else {
+		/* ROC was not successful, tell the firmware to remove it */
+		if (le32_to_cpu(notif->started))
+			iwl_mld_cancel_roc(mld->hw, vif);
+		else
+			iwl_mld_destroy_roc(mld, vif, mld_vif);
+		/* we need to let know mac80211 about end OR
+		 * an unsuccessful start
+		 */
+		ieee80211_remain_on_channel_expired(mld->hw);
+	}
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 9216c43a35c4..198f94292674 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -771,7 +771,7 @@ static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 
 static void iwl_mvm_roc_rm_cmd(struct iwl_mvm *mvm, u32 activity)
 {
-	struct iwl_roc_req roc_cmd = {
+	struct iwl_roc_req_v5 roc_cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 		.activity = cpu_to_le32(activity),
 	};
@@ -1100,7 +1100,7 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 {
 	int res;
 	u32 duration_tu, delay;
-	struct iwl_roc_req roc_req = {
+	struct iwl_roc_req_v5 roc_req = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 		.activity = cpu_to_le32(activity),
 		.sta_id = cpu_to_le32(mvm->aux_sta.sta_id),
-- 
2.34.1


