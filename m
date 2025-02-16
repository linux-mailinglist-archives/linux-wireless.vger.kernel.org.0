Return-Path: <linux-wireless+bounces-19000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BAA37393
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90943AF6DB
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682D198A37;
	Sun, 16 Feb 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfCSB9If"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6FE195985
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699057; cv=none; b=GJtR6IdIiU3AUq59T0hp0Xc6B5uvf0Le4HSRnIJPlUffLH+GIUfRdukq7yNlKSa5chdo75gYYtrouZb1WWXXhedfM2xR2SADTwoTYh2V1JIthrTKnlgQE7dif22i1J8pquR6mhhZkPN3tBjFOPpxQvRZPWTVKFNL0SXB7aFKOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699057; c=relaxed/simple;
	bh=PCuRWMcVO+47o3aoPJ5mDwViPboFjkq/1H+9vPJTWec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8V/715WEnQ6UO+KtJY79yK73a7JZO/cIHzHwIJUE93nWW4gcDXNF4AyiP4fHRJGPnkGaDl4CkEsb1kCDATI1ngnHK9OUoO/T68hkMX1ilWFmWM1BXK/AIR1WIFjtFOI+dSOp1/Z88hl3agq/mmiSuEd959qu1nW8QsifNpeBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfCSB9If; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699055; x=1771235055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PCuRWMcVO+47o3aoPJ5mDwViPboFjkq/1H+9vPJTWec=;
  b=OfCSB9IfAXuYSB4cW7kYuBZWjYOETopoiGa0wRObIz2KS9G+54Sy+X5H
   WcqtJbAmg8c5ldn8kxd0VC0G4QiSxkh8YhL99cWJT09QPyJn4hdUYQ7ZT
   1VIvSihMe+SQH5QDuexIXoNot06JQncOaFuIdlK1XGgkaZwuPpDOrWsc9
   xgwP3eUltgsW9nJJ99O6wIC1xkWUdmMO1hJRS+7zwI5jNA2v2nqml5d0y
   XBo7sKQ4dZzlBSeACsBzVGYZw1oI2CQrgWAu7LDWLtaJRWekidRgRNPT7
   c9MUU5Lk+5fRi7v/lZ6ZU64E6qWw1WmhXeMzZ5EgVgBoCkU5JipXz/my+
   w==;
X-CSE-ConnectionGUID: xF/DnLg/TlSCNfStHpqS1Q==
X-CSE-MsgGUID: 4iWI8MPDRvCHWk603fheHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323418"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323418"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:15 -0800
X-CSE-ConnectionGUID: YCF2q+PbTm6SEYd1CoCv5A==
X-CSE-MsgGUID: +M7bu1EVQOWZSa8H9j9fkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785272"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 31/42] wifi: iwlwifi: mld: add file time_sync.h/c
Date: Sun, 16 Feb 2025 11:43:10 +0200
Message-Id: <20250216111649.3bb0336c119f.If910948f23b356ce5a721030bfb1ec4de69fc88f@changeid>
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

these fils are handling time synchronization

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/time_sync.c    | 240 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mld/time_sync.h    |  26 ++
 2 files changed, 266 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/time_sync.c b/drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
new file mode 100644
index 000000000000..50799f9bfccb
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include "mld.h"
+#include "hcmd.h"
+#include "ptp.h"
+#include "time_sync.h"
+#include <linux/ieee80211.h>
+
+static int iwl_mld_init_time_sync(struct iwl_mld *mld, u32 protocols,
+				  const u8 *addr)
+{
+	struct iwl_mld_time_sync_data *time_sync = kzalloc(sizeof(*time_sync),
+							   GFP_KERNEL);
+
+	if (!time_sync)
+		return -ENOMEM;
+
+	time_sync->active_protocols = protocols;
+	ether_addr_copy(time_sync->peer_addr, addr);
+	skb_queue_head_init(&time_sync->frame_list);
+	rcu_assign_pointer(mld->time_sync, time_sync);
+
+	return 0;
+}
+
+int iwl_mld_time_sync_fw_config(struct iwl_mld *mld)
+{
+	struct iwl_time_sync_cfg_cmd cmd = {};
+	struct iwl_mld_time_sync_data *time_sync;
+	int err;
+
+	time_sync = wiphy_dereference(mld->wiphy, mld->time_sync);
+	if (!time_sync)
+		return -EINVAL;
+
+	cmd.protocols = cpu_to_le32(time_sync->active_protocols);
+	ether_addr_copy(cmd.peer_addr, time_sync->peer_addr);
+
+	err = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(DATA_PATH_GROUP,
+					   WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD),
+				   &cmd);
+	if (err)
+		IWL_ERR(mld, "Failed to send time sync cfg cmd: %d\n", err);
+
+	return err;
+}
+
+int iwl_mld_time_sync_config(struct iwl_mld *mld, const u8 *addr, u32 protocols)
+{
+	struct iwl_mld_time_sync_data *time_sync;
+	int err;
+
+	time_sync = wiphy_dereference(mld->wiphy, mld->time_sync);
+
+	/* The fw only supports one peer. We do allow reconfiguration of the
+	 * same peer for cases of fw reset etc.
+	 */
+	if (time_sync && time_sync->active_protocols &&
+	    !ether_addr_equal(addr, time_sync->peer_addr)) {
+		IWL_DEBUG_INFO(mld, "Time sync: reject config for peer: %pM\n",
+			       addr);
+		return -ENOBUFS;
+	}
+
+	if (protocols & ~(IWL_TIME_SYNC_PROTOCOL_TM |
+			  IWL_TIME_SYNC_PROTOCOL_FTM))
+		return -EINVAL;
+
+	IWL_DEBUG_INFO(mld, "Time sync: set peer addr=%pM\n", addr);
+
+	iwl_mld_deinit_time_sync(mld);
+	err = iwl_mld_init_time_sync(mld, protocols, addr);
+	if (err)
+		return err;
+
+	err = iwl_mld_time_sync_fw_config(mld);
+	return err;
+}
+
+void iwl_mld_deinit_time_sync(struct iwl_mld *mld)
+{
+	struct iwl_mld_time_sync_data *time_sync =
+		wiphy_dereference(mld->wiphy, mld->time_sync);
+
+	if (!time_sync)
+		return;
+
+	RCU_INIT_POINTER(mld->time_sync, NULL);
+	skb_queue_purge(&time_sync->frame_list);
+	kfree_rcu(time_sync, rcu_head);
+}
+
+bool iwl_mld_time_sync_frame(struct iwl_mld *mld, struct sk_buff *skb, u8 *addr)
+{
+	struct iwl_mld_time_sync_data *time_sync;
+
+	rcu_read_lock();
+	time_sync = rcu_dereference(mld->time_sync);
+	if (time_sync && ether_addr_equal(time_sync->peer_addr, addr) &&
+	    (ieee80211_is_timing_measurement(skb) || ieee80211_is_ftm(skb))) {
+		skb_queue_tail(&time_sync->frame_list, skb);
+		rcu_read_unlock();
+		return true;
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
+static bool iwl_mld_is_skb_match(struct sk_buff *skb, u8 *addr, u8 dialog_token)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	u8 skb_dialog_token;
+
+	if (ieee80211_is_timing_measurement(skb))
+		skb_dialog_token = mgmt->u.action.u.wnm_timing_msr.dialog_token;
+	else
+		skb_dialog_token = mgmt->u.action.u.ftm.dialog_token;
+
+	if ((ether_addr_equal(mgmt->sa, addr) ||
+	     ether_addr_equal(mgmt->da, addr)) &&
+	    skb_dialog_token == dialog_token)
+		return true;
+
+	return false;
+}
+
+static struct sk_buff *iwl_mld_time_sync_find_skb(struct iwl_mld *mld, u8 *addr,
+						  u8 dialog_token)
+{
+	struct iwl_mld_time_sync_data *time_sync;
+	struct sk_buff *skb;
+
+	rcu_read_lock();
+
+	time_sync = rcu_dereference(mld->time_sync);
+	if (IWL_FW_CHECK(mld, !time_sync,
+			 "Time sync notification but time sync is not initialized\n")) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	/* The notifications are expected to arrive in the same order of the
+	 * frames. If the incoming notification doesn't match the first SKB
+	 * in the queue, it means there was no time sync notification for this
+	 * SKB and it can be dropped.
+	 */
+	while ((skb = skb_dequeue(&time_sync->frame_list))) {
+		if (iwl_mld_is_skb_match(skb, addr, dialog_token))
+			break;
+
+		kfree_skb(skb);
+		skb = NULL;
+		IWL_DEBUG_DROP(mld,
+			       "Time sync: drop SKB without matching notification\n");
+	}
+	rcu_read_unlock();
+
+	return skb;
+}
+
+static u64 iwl_mld_get_64_bit(__le32 high, __le32 low)
+{
+	return ((u64)le32_to_cpu(high) << 32) | le32_to_cpu(low);
+}
+
+void iwl_mld_handle_time_msmt_notif(struct iwl_mld *mld,
+				    struct iwl_rx_packet *pkt)
+{
+	struct ptp_data *data = &mld->ptp_data;
+	struct iwl_time_msmt_notify *notif = (void *)pkt->data;
+	struct ieee80211_rx_status *rx_status;
+	struct skb_shared_hwtstamps *shwt;
+	u64 ts_10ns;
+	struct sk_buff *skb =
+		iwl_mld_time_sync_find_skb(mld, notif->peer_addr,
+					   le32_to_cpu(notif->dialog_token));
+	u64 adj_time;
+
+	if (IWL_FW_CHECK(mld, !skb, "Time sync event but no pending skb\n"))
+		return;
+
+	spin_lock_bh(&data->lock);
+	ts_10ns = iwl_mld_get_64_bit(notif->t2_hi, notif->t2_lo);
+	adj_time = iwl_mld_ptp_get_adj_time(mld, ts_10ns * 10);
+	shwt = skb_hwtstamps(skb);
+	shwt->hwtstamp = ktime_set(0, adj_time);
+
+	ts_10ns = iwl_mld_get_64_bit(notif->t3_hi, notif->t3_lo);
+	adj_time = iwl_mld_ptp_get_adj_time(mld, ts_10ns * 10);
+	rx_status = IEEE80211_SKB_RXCB(skb);
+	rx_status->ack_tx_hwtstamp = ktime_set(0, adj_time);
+	spin_unlock_bh(&data->lock);
+
+	IWL_DEBUG_INFO(mld,
+		       "Time sync: RX event - report frame t2=%llu t3=%llu\n",
+		       ktime_to_ns(shwt->hwtstamp),
+		       ktime_to_ns(rx_status->ack_tx_hwtstamp));
+	ieee80211_rx_napi(mld->hw, NULL, skb, NULL);
+}
+
+void iwl_mld_handle_time_sync_confirm_notif(struct iwl_mld *mld,
+					    struct iwl_rx_packet *pkt)
+{
+	struct ptp_data *data = &mld->ptp_data;
+	struct iwl_time_msmt_cfm_notify *notif = (void *)pkt->data;
+	struct ieee80211_tx_status status = {};
+	struct skb_shared_hwtstamps *shwt;
+	u64 ts_10ns, adj_time;
+
+	status.skb =
+		iwl_mld_time_sync_find_skb(mld, notif->peer_addr,
+					   le32_to_cpu(notif->dialog_token));
+
+	if (IWL_FW_CHECK(mld, !status.skb,
+			 "Time sync confirm but no pending skb\n"))
+		return;
+
+	spin_lock_bh(&data->lock);
+	ts_10ns = iwl_mld_get_64_bit(notif->t1_hi, notif->t1_lo);
+	adj_time = iwl_mld_ptp_get_adj_time(mld, ts_10ns * 10);
+	shwt = skb_hwtstamps(status.skb);
+	shwt->hwtstamp = ktime_set(0, adj_time);
+
+	ts_10ns = iwl_mld_get_64_bit(notif->t4_hi, notif->t4_lo);
+	adj_time = iwl_mld_ptp_get_adj_time(mld, ts_10ns * 10);
+	status.info = IEEE80211_SKB_CB(status.skb);
+	status.ack_hwtstamp = ktime_set(0, adj_time);
+	spin_unlock_bh(&data->lock);
+
+	IWL_DEBUG_INFO(mld,
+		       "Time sync: TX event - report frame t1=%llu t4=%llu\n",
+		       ktime_to_ns(shwt->hwtstamp),
+		       ktime_to_ns(status.ack_hwtstamp));
+	ieee80211_tx_status_ext(mld->hw, &status);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/time_sync.h b/drivers/net/wireless/intel/iwlwifi/mld/time_sync.h
new file mode 100644
index 000000000000..2d4c5512e961
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/time_sync.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#ifndef __iwl_mld_time_sync_h__
+#define __iwl_mld_time_sync_h__
+
+struct iwl_mld_time_sync_data {
+	struct rcu_head rcu_head;
+	u8 peer_addr[ETH_ALEN];
+	u32 active_protocols;
+	struct sk_buff_head frame_list;
+};
+
+int iwl_mld_time_sync_config(struct iwl_mld *mld, const u8 *addr,
+			     u32 protocols);
+int iwl_mld_time_sync_fw_config(struct iwl_mld *mld);
+void iwl_mld_deinit_time_sync(struct iwl_mld *mld);
+void iwl_mld_handle_time_msmt_notif(struct iwl_mld *mld,
+				    struct iwl_rx_packet *pkt);
+bool iwl_mld_time_sync_frame(struct iwl_mld *mld, struct sk_buff *skb,
+			     u8 *addr);
+void iwl_mld_handle_time_sync_confirm_notif(struct iwl_mld *mld,
+					    struct iwl_rx_packet *pkt);
+
+#endif /* __iwl_mld_time_sync_h__ */
-- 
2.34.1


