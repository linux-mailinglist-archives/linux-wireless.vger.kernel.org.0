Return-Path: <linux-wireless+bounces-18984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41ADA3737F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BD716CECC
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7C18DB1D;
	Sun, 16 Feb 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAje2BlS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B018FDD8
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699035; cv=none; b=gUO5BjzOP7p/uWSvhgO4Vm/Cm61Eda8QhsBI9OSD+KU6YK46k+tAMGZ5QoxEUsbHYYkpTj0fsrdyQrL9wJqwnS1nO8uYGGt6vsT0NefddxGsOEKGqrnS8ZxwJvUMw2y+PHJQF/ODQQ+YWE89OkAlmcf1m70NBEbFojXpxdpKNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699035; c=relaxed/simple;
	bh=iv4K39IAZG3QFBX2GVdd2po6RJWHDN8fkAL+IEfoNOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uG1JBhx7WBYgNlZEuplcCqqeKTVKyuT4KlmzaK4Qla3bs7dJXGvYAhCcHW5rIkbsW1vrdpsGiTE1sHCVZ6SPU6NKhUtCLoxtoARaEdONfuA6Bf5SrS9YdDXOu87Utrs586WOkG4pMOJJUBdvt/S2Ab+knkbIT4hG0umhOnGDWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAje2BlS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699034; x=1771235034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iv4K39IAZG3QFBX2GVdd2po6RJWHDN8fkAL+IEfoNOY=;
  b=LAje2BlSu7y/czi8ZgWsV04zvonmx3ox/UUCgVsu3dpZBe3wAjU2odhJ
   9lVsoHewQCOvEvtXNvjt0tJh5QrOy9i+3txhsGJA2VcZGnFQqRgqBkk6J
   1nvj/s/8DybGT5tDHKlSnvAF9lRRVC93FB0eBY+CDDe8bQG5Eg3IYPBVH
   PVX5LshI4i57VGnbPVJeziGs4ZEDvFfqJzYPPflB14EwHJfTYTpvca0B9
   LuEKpqWDVUAxH8A0icQkfm5xeTBBKby9xUVtVBqxwfAmXyHjwo9svW0g4
   W14973AN4dCrLXRnZYaHNPghOysqvMg8mjtFsrteZTjf4kIOJgJl79JKn
   A==;
X-CSE-ConnectionGUID: oD3IJMoWQMeeihqgQI23rg==
X-CSE-MsgGUID: 3Y7tIgcmQxi6gMWmGfQcbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323384"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323384"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:54 -0800
X-CSE-ConnectionGUID: SAcItA0YT5GBuKH+SdHzOg==
X-CSE-MsgGUID: SkvuNQNHR8yNYuUNyf8lzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785241"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 14/42] wifi: iwlwifi: mld: add file low_latency.h/c
Date: Sun, 16 Feb 2025 11:42:53 +0200
Message-Id: <20250216111648.5069651eef22.I75c5b55b9705aac89f2469e4d88033632425c842@changeid>
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

this file is handling low latency functionality

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/low_latency.c  | 335 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mld/low_latency.h  |  68 ++++
 2 files changed, 403 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
new file mode 100644
index 000000000000..439fc10a4a41
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#include "mld.h"
+#include "iface.h"
+#include "low_latency.h"
+#include "hcmd.h"
+#include "power.h"
+
+#define MLD_LL_WK_INTERVAL_MSEC 500
+#define MLD_LL_PERIOD (HZ * MLD_LL_WK_INTERVAL_MSEC / 1000)
+#define MLD_LL_ACTIVE_WK_PERIOD (HZ * 10)
+
+/* packets/MLD_LL_WK_PERIOD seconds */
+#define MLD_LL_ENABLE_THRESH 100
+
+static bool iwl_mld_calc_low_latency(struct iwl_mld *mld,
+				     unsigned long timestamp)
+{
+	struct iwl_mld_low_latency *ll = &mld->low_latency;
+	bool global_low_latency = false;
+	u8 num_rx_q = mld->trans->num_rx_queues;
+
+	for (int mac_id = 0; mac_id < NUM_MAC_INDEX_DRIVER; mac_id++) {
+		u32 total_vo_vi_pkts = 0;
+		bool ll_period_expired;
+
+		/* If it's not initialized yet, it means we have not yet
+		 * received/transmitted any vo/vi packet on this MAC.
+		 */
+		if (!ll->window_start[mac_id])
+			continue;
+
+		ll_period_expired =
+			time_after(timestamp, ll->window_start[mac_id] +
+				   MLD_LL_ACTIVE_WK_PERIOD);
+
+		if (ll_period_expired)
+			ll->window_start[mac_id] = timestamp;
+
+		for (int q = 0; q < num_rx_q; q++) {
+			struct iwl_mld_low_latency_packets_counters *counters =
+				&mld->low_latency.pkts_counters[q];
+
+			spin_lock_bh(&counters->lock);
+
+			total_vo_vi_pkts += counters->vo_vi[mac_id];
+
+			if (ll_period_expired)
+				counters->vo_vi[mac_id] = 0;
+
+			spin_unlock_bh(&counters->lock);
+		}
+
+		/* enable immediately with enough packets but defer
+		 * disabling only if the low-latency period expired and
+		 * below threshold.
+		 */
+		if (total_vo_vi_pkts > MLD_LL_ENABLE_THRESH)
+			mld->low_latency.result[mac_id] = true;
+		else if (ll_period_expired)
+			mld->low_latency.result[mac_id] = false;
+
+		global_low_latency |= mld->low_latency.result[mac_id];
+	}
+
+	return global_low_latency;
+}
+
+static void iwl_mld_low_latency_iter(void *_data, u8 *mac,
+				     struct ieee80211_vif *vif)
+{
+	struct iwl_mld *mld = _data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	bool prev = mld_vif->low_latency_causes & LOW_LATENCY_TRAFFIC;
+	bool low_latency;
+
+	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld->low_latency.result)))
+		return;
+
+	low_latency = mld->low_latency.result[mld_vif->fw_id];
+
+	if (prev != low_latency)
+		iwl_mld_vif_update_low_latency(mld, vif, low_latency,
+					       LOW_LATENCY_TRAFFIC);
+}
+
+static void iwl_mld_low_latency_wk(struct wiphy *wiphy, struct wiphy_work *wk)
+{
+	struct iwl_mld *mld = container_of(wk, struct iwl_mld,
+					   low_latency.work.work);
+	unsigned long timestamp = jiffies;
+	bool low_latency_active;
+
+	if (mld->fw_status.in_hw_restart)
+		return;
+
+	/* It is assumed that the work was scheduled only after checking
+	 * at least MLD_LL_PERIOD has passed since the last update.
+	 */
+
+	low_latency_active = iwl_mld_calc_low_latency(mld, timestamp);
+
+	/* Update the timestamp now after the low-latency calculation */
+	mld->low_latency.timestamp = timestamp;
+
+	/* If low-latency is active we need to force re-evaluation after
+	 * 10 seconds, so that we can disable low-latency when
+	 * the low-latency traffic ends.
+	 *
+	 * Otherwise, we don't need to run the work because there is nothing to
+	 * disable.
+	 *
+	 * Note that this has no impact on the regular scheduling of the
+	 * updates triggered by traffic - those happen whenever the
+	 * MLD_LL_PERIOD timeout expire.
+	 */
+	if (low_latency_active)
+		wiphy_delayed_work_queue(mld->wiphy, &mld->low_latency.work,
+					 MLD_LL_ACTIVE_WK_PERIOD);
+
+	ieee80211_iterate_active_interfaces(mld->hw,
+					    IEEE80211_IFACE_ITER_NORMAL,
+					    iwl_mld_low_latency_iter, mld);
+}
+
+int iwl_mld_low_latency_init(struct iwl_mld *mld)
+{
+	struct iwl_mld_low_latency *ll = &mld->low_latency;
+	unsigned long ts = jiffies;
+
+	ll->pkts_counters = kcalloc(mld->trans->num_rx_queues,
+				    sizeof(*ll->pkts_counters), GFP_KERNEL);
+	if (!ll->pkts_counters)
+		return -ENOMEM;
+
+	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+		spin_lock_init(&ll->pkts_counters[q].lock);
+
+	wiphy_delayed_work_init(&ll->work, iwl_mld_low_latency_wk);
+
+	ll->timestamp = ts;
+
+	/* The low-latency window_start will be initialized per-MAC on
+	 * the first vo/vi packet received/transmitted.
+	 */
+
+	return 0;
+}
+
+void iwl_mld_low_latency_free(struct iwl_mld *mld)
+{
+	struct iwl_mld_low_latency *ll = &mld->low_latency;
+
+	kfree(ll->pkts_counters);
+	ll->pkts_counters = NULL;
+}
+
+void iwl_mld_low_latency_restart_cleanup(struct iwl_mld *mld)
+{
+	struct iwl_mld_low_latency *ll = &mld->low_latency;
+
+	ll->timestamp = jiffies;
+
+	memset(ll->window_start, 0, sizeof(ll->window_start));
+	memset(ll->result, 0, sizeof(ll->result));
+
+	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+		memset(ll->pkts_counters[q].vo_vi, 0,
+		       sizeof(ll->pkts_counters[q].vo_vi));
+}
+
+static int iwl_mld_send_low_latency_cmd(struct iwl_mld *mld, bool low_latency,
+					u16 mac_id)
+{
+	struct iwl_mac_low_latency_cmd cmd = {
+		.mac_id = cpu_to_le32(mac_id)
+	};
+	u16 cmd_id = WIDE_ID(MAC_CONF_GROUP, LOW_LATENCY_CMD);
+	int ret;
+
+	if (low_latency) {
+		/* Currently we don't care about the direction */
+		cmd.low_latency_rx = 1;
+		cmd.low_latency_tx = 1;
+	}
+
+	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd);
+	if (ret)
+		IWL_ERR(mld, "Failed to send low latency command\n");
+
+	return ret;
+}
+
+static void iwl_mld_vif_set_low_latency(struct iwl_mld_vif *mld_vif, bool set,
+					enum iwl_mld_low_latency_cause cause)
+{
+	if (set)
+		mld_vif->low_latency_causes |= cause;
+	else
+		mld_vif->low_latency_causes &= ~cause;
+}
+
+void iwl_mld_vif_update_low_latency(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    bool low_latency,
+				    enum iwl_mld_low_latency_cause cause)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	bool prev;
+
+	prev = iwl_mld_vif_low_latency(mld_vif);
+	iwl_mld_vif_set_low_latency(mld_vif, low_latency, cause);
+
+	low_latency = iwl_mld_vif_low_latency(mld_vif);
+	if (low_latency == prev)
+		return;
+
+	if (iwl_mld_send_low_latency_cmd(mld, low_latency, mld_vif->fw_id)) {
+		/* revert to previous low-latency state */
+		iwl_mld_vif_set_low_latency(mld_vif, prev, cause);
+		return;
+	}
+
+	if (low_latency)
+		iwl_mld_leave_omi_bw_reduction(mld);
+
+	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_P2P_CLIENT)
+		return;
+
+	iwl_mld_update_mac_power(mld, vif, false);
+}
+
+static bool iwl_mld_is_vo_vi_pkt(struct ieee80211_hdr *hdr)
+{
+	u8 tid;
+	static const u8 tid_to_mac80211_ac[] = {
+		IEEE80211_AC_BE,
+		IEEE80211_AC_BK,
+		IEEE80211_AC_BK,
+		IEEE80211_AC_BE,
+		IEEE80211_AC_VI,
+		IEEE80211_AC_VI,
+		IEEE80211_AC_VO,
+		IEEE80211_AC_VO,
+	};
+
+	if (!hdr || !ieee80211_is_data_qos(hdr->frame_control))
+		return false;
+
+	tid = ieee80211_get_tid(hdr);
+	if (tid >= IWL_MAX_TID_COUNT)
+		return false;
+
+	return tid_to_mac80211_ac[tid] < IEEE80211_AC_VI;
+}
+
+void iwl_mld_low_latency_update_counters(struct iwl_mld *mld,
+					 struct ieee80211_hdr *hdr,
+					 struct ieee80211_sta *sta,
+					 u8 queue)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(mld_sta->vif);
+	struct iwl_mld_low_latency_packets_counters *counters;
+	unsigned long ts = jiffies ? jiffies : 1;
+	u8 fw_id = mld_vif->fw_id;
+
+	/* we should have failed op mode init if NULL */
+	if (WARN_ON_ONCE(!mld->low_latency.pkts_counters))
+		return;
+
+	if (WARN_ON_ONCE(fw_id >= ARRAY_SIZE(counters->vo_vi) ||
+			 queue >= mld->trans->num_rx_queues))
+		return;
+
+	if (mld->low_latency.stopped)
+		return;
+
+	if (!iwl_mld_is_vo_vi_pkt(hdr))
+		return;
+
+	counters = &mld->low_latency.pkts_counters[queue];
+
+	spin_lock_bh(&counters->lock);
+	counters->vo_vi[fw_id]++;
+	spin_unlock_bh(&counters->lock);
+
+	/* Initialize the window_start on the first vo/vi packet */
+	if (!mld->low_latency.window_start[fw_id])
+		mld->low_latency.window_start[fw_id] = ts;
+
+	if (time_is_before_jiffies(mld->low_latency.timestamp + MLD_LL_PERIOD))
+		wiphy_delayed_work_queue(mld->wiphy, &mld->low_latency.work,
+					 0);
+}
+
+void iwl_mld_low_latency_stop(struct iwl_mld *mld)
+{
+	lockdep_assert_wiphy(mld->wiphy);
+
+	mld->low_latency.stopped = true;
+
+	wiphy_delayed_work_cancel(mld->wiphy, &mld->low_latency.work);
+}
+
+void iwl_mld_low_latency_restart(struct iwl_mld *mld)
+{
+	struct iwl_mld_low_latency *ll = &mld->low_latency;
+	bool low_latency = false;
+	unsigned long ts = jiffies;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ll->timestamp = ts;
+	mld->low_latency.stopped = false;
+
+	for (int mac = 0; mac < NUM_MAC_INDEX_DRIVER; mac++) {
+		ll->window_start[mac] = 0;
+		low_latency |= ll->result[mac];
+
+		for (int q = 0; q < mld->trans->num_rx_queues; q++) {
+			spin_lock_bh(&ll->pkts_counters[q].lock);
+			ll->pkts_counters[q].vo_vi[mac] = 0;
+			spin_unlock_bh(&ll->pkts_counters[q].lock);
+		}
+	}
+
+	/* if low latency is active, force re-evaluation to cover the case of
+	 * no traffic.
+	 */
+	if (low_latency)
+		wiphy_delayed_work_queue(mld->wiphy, &ll->work, MLD_LL_PERIOD);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.h b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.h
new file mode 100644
index 000000000000..f59684d235af
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_low_latency_h__
+#define __iwl_mld_low_latency_h__
+
+/**
+ * struct iwl_mld_low_latency_packets_counters - Packets counters
+ * @lock: synchronize the counting in data path against the worker
+ * @vo_vi: per-mac, counts the number of TX and RX voice and video packets
+ */
+struct iwl_mld_low_latency_packets_counters {
+	spinlock_t lock;
+	u32 vo_vi[NUM_MAC_INDEX_DRIVER];
+} ____cacheline_aligned_in_smp;
+
+/**
+ * enum iwl_mld_low_latency_cause - low-latency set causes
+ *
+ * @LOW_LATENCY_TRAFFIC: indicates low-latency traffic was detected
+ * @LOW_LATENCY_DEBUGFS: low-latency mode set from debugfs
+ * @LOW_LATENCY_VIF_TYPE: low-latency mode set because of vif type (AP)
+ */
+enum iwl_mld_low_latency_cause {
+	LOW_LATENCY_TRAFFIC	= BIT(0),
+	LOW_LATENCY_DEBUGFS	= BIT(1),
+	LOW_LATENCY_VIF_TYPE	= BIT(2),
+};
+
+/**
+ * struct iwl_mld_low_latency - Manage low-latency detection and activation.
+ * @work: this work is used to detect low-latency by monitoring the number of
+ *	voice and video packets transmitted in a period of time. If the
+ *	threshold is reached, low-latency is activated. When active,
+ *	it is deactivated if the threshold is not reached within a
+ *	10-second period.
+ * @timestamp: timestamp of the last update.
+ * @window_start: per-mac, timestamp of the start of the current window. when
+ *	the window is over, the counters are reset.
+ * @pkts_counters: per-queue array voice/video packet counters
+ * @result: per-mac latest low-latency result
+ * @stopped: if true, ignore the requests to update the counters
+ */
+struct iwl_mld_low_latency {
+	struct wiphy_delayed_work work;
+	unsigned long timestamp;
+	unsigned long window_start[NUM_MAC_INDEX_DRIVER];
+	struct iwl_mld_low_latency_packets_counters *pkts_counters;
+	bool result[NUM_MAC_INDEX_DRIVER];
+	bool stopped;
+};
+
+int iwl_mld_low_latency_init(struct iwl_mld *mld);
+void iwl_mld_low_latency_free(struct iwl_mld *mld);
+void iwl_mld_low_latency_restart_cleanup(struct iwl_mld *mld);
+void iwl_mld_vif_update_low_latency(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    bool low_latency,
+				    enum iwl_mld_low_latency_cause cause);
+void iwl_mld_low_latency_update_counters(struct iwl_mld *mld,
+					 struct ieee80211_hdr *hdr,
+					 struct ieee80211_sta *sta,
+					 u8 queue);
+void iwl_mld_low_latency_stop(struct iwl_mld *mld);
+void iwl_mld_low_latency_restart(struct iwl_mld *mld);
+
+#endif /* __iwl_mld_low_latency_h__ */
-- 
2.34.1


