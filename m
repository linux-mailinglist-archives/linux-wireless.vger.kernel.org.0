Return-Path: <linux-wireless+bounces-18992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9FA37388
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A38E3AA6CD
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150B192B8A;
	Sun, 16 Feb 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyyOo7zm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042121925BA
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699045; cv=none; b=icA9CeCsNRzOEPFUBFnoq4B0CkEMgr/4DpKqoIt3j8/3DJvPU38OjorO/jTLN7OScDPtcnUC/UqfjX1204IubAjqt7GfQbeFBaHefXd0mHv1GgX/xxHAx9H83hRrt+2jjj2hLnaXV6UlgVw8Jj8UFwZBsNpJwqQQ/CugMLWCVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699045; c=relaxed/simple;
	bh=5FbsItZUdIlICXv2OcFRuvkX2yf8s/Vhjak7V91rRlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPVuLZV4avlF5brYmU7Ef8ttWNM5r4K69kJFzKWDY+yNIYBUlaEMqTkiLgghiLggkKusU7erujoRhFEttvcmXoZ6WK/tFsdBV5kuoTXaWrjO0F9iOCtdLJ9zc2W/vN4HlD0+D9PsPnPK55TWoX8MkFlmkc3r54VuQU40kv2KtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyyOo7zm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699044; x=1771235044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FbsItZUdIlICXv2OcFRuvkX2yf8s/Vhjak7V91rRlo=;
  b=lyyOo7zms3Hi76/6j2Eqe6v/Y4WcGSJZCOdlZAlx8xNkK90JIxmihhVK
   thJMSTTZZmaBPRoiqm9Fwy2crpzXi61iY38JrDhWr99qQnAkZJLPr9BtY
   SVjm1bz4y+tXt84f2tDtMIb18o/JTK4wN7ryHcph43c9NNtRyKZ71UN9z
   y+0pR3kUMVJvFi1FbWdp2rd8tnU3HdVWqABXYQu1Hun9pfYY+9zMIzDZ6
   5peguJreOadJ00+fUmxhTOQz1tuOXTf0BB3L1jiS824gmaswvEnT2DRcJ
   F7mfzBezx5n2wpsVQMakh/VNz9uP1LLmlPItuZ1tToTaLUvpJ5gS0K86Y
   g==;
X-CSE-ConnectionGUID: KWt6tmJTRJmffbgKhVVm+w==
X-CSE-MsgGUID: inx4R0ZzQFW9fvMdRYXiJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323400"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323400"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:04 -0800
X-CSE-ConnectionGUID: hISwmGFqSe+VPK18+KMkhg==
X-CSE-MsgGUID: Jz1tg1pLRhSaUzDWA/fCwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785253"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 22/42] wifi: iwlwifi: mld: add file ptp.h/c
Date: Sun, 16 Feb 2025 11:43:01 +0200
Message-Id: <20250216111648.cf3ebb584706.If44066560db54cfdd62cccb3a71032d95b931c6b@changeid>
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

these fils are implementing p2p clock APIs

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 321 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/ptp.h |  45 +++
 2 files changed, 366 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
new file mode 100644
index 000000000000..d5c3f853d96c
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include "mld.h"
+#include "iwl-debug.h"
+#include "hcmd.h"
+#include "ptp.h"
+#include <linux/timekeeping.h>
+
+/* The scaled_ppm parameter is ppm (parts per million) with a 16-bit fractional
+ * part, which means that a value of 1 in one of those fields actually means
+ * 2^-16 ppm, and 2^16=65536 is 1 ppm.
+ */
+#define PTP_SCALE_FACTOR	65536000000ULL
+
+#define IWL_PTP_GP2_WRAP	0x100000000ULL
+#define IWL_PTP_WRAP_TIME	(3600 * HZ)
+#define IWL_PTP_WRAP_THRESHOLD_USEC	(5000)
+
+static int iwl_mld_get_systime(struct iwl_mld *mld, u32 *gp2)
+{
+	*gp2 = iwl_read_prph(mld->trans, mld->trans->cfg->gp2_reg_addr);
+
+	if (*gp2 == 0x5a5a5a5a)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void iwl_mld_ptp_update_new_read(struct iwl_mld *mld, u32 gp2)
+{
+	IWL_DEBUG_PTP(mld, "PTP: last_gp2=%u, new gp2 read=%u\n",
+		      mld->ptp_data.last_gp2, gp2);
+
+	/* If the difference is above the threshold, assume it's a wraparound.
+	 * Otherwise assume it's an old read and ignore it.
+	 */
+	if (gp2 < mld->ptp_data.last_gp2) {
+		if (mld->ptp_data.last_gp2 - gp2 <
+		    IWL_PTP_WRAP_THRESHOLD_USEC) {
+			IWL_DEBUG_PTP(mld,
+				      "PTP: ignore old read (gp2=%u, last_gp2=%u)\n",
+				      gp2, mld->ptp_data.last_gp2);
+			return;
+		}
+
+		mld->ptp_data.wrap_counter++;
+		IWL_DEBUG_PTP(mld,
+			      "PTP: wraparound detected (new counter=%u)\n",
+			      mld->ptp_data.wrap_counter);
+	}
+
+	mld->ptp_data.last_gp2 = gp2;
+	schedule_delayed_work(&mld->ptp_data.dwork, IWL_PTP_WRAP_TIME);
+}
+
+u64 iwl_mld_ptp_get_adj_time(struct iwl_mld *mld, u64 base_time_ns)
+{
+	struct ptp_data *data = &mld->ptp_data;
+	u64 scale_time_gp2_ns = mld->ptp_data.scale_update_gp2 * NSEC_PER_USEC;
+	u64 res;
+	u64 diff;
+	s64 scaled_diff;
+
+	lockdep_assert_held(&data->lock);
+
+	iwl_mld_ptp_update_new_read(mld,
+				    div64_u64(base_time_ns, NSEC_PER_USEC));
+
+	base_time_ns = base_time_ns +
+		(data->wrap_counter * IWL_PTP_GP2_WRAP * NSEC_PER_USEC);
+
+	/* It is possible that a GP2 timestamp was received from fw before the
+	 * last scale update.
+	 */
+	if (base_time_ns < scale_time_gp2_ns) {
+		diff = scale_time_gp2_ns - base_time_ns;
+		scaled_diff = -mul_u64_u64_div_u64(diff,
+						   data->scaled_freq,
+						   PTP_SCALE_FACTOR);
+	} else {
+		diff = base_time_ns - scale_time_gp2_ns;
+		scaled_diff = mul_u64_u64_div_u64(diff,
+						  data->scaled_freq,
+						  PTP_SCALE_FACTOR);
+	}
+
+	IWL_DEBUG_PTP(mld, "base_time=%llu diff ns=%llu scaled_diff_ns=%lld\n",
+		      (unsigned long long)base_time_ns,
+		      (unsigned long long)diff, (long long)scaled_diff);
+
+	res = data->scale_update_adj_time_ns + data->delta + scaled_diff;
+
+	IWL_DEBUG_PTP(mld, "scale_update_ns=%llu delta=%lld adj=%llu\n",
+		      (unsigned long long)data->scale_update_adj_time_ns,
+		      (long long)data->delta, (unsigned long long)res);
+	return res;
+}
+
+static int iwl_mld_ptp_gettime(struct ptp_clock_info *ptp,
+			       struct timespec64 *ts)
+{
+	struct iwl_mld *mld = container_of(ptp, struct iwl_mld,
+					   ptp_data.ptp_clock_info);
+	struct ptp_data *data = &mld->ptp_data;
+	u32 gp2;
+	u64 ns;
+
+	if (iwl_mld_get_systime(mld, &gp2)) {
+		IWL_DEBUG_PTP(mld, "PTP: gettime: failed to read systime\n");
+		return -EIO;
+	}
+
+	spin_lock_bh(&data->lock);
+	ns = iwl_mld_ptp_get_adj_time(mld, (u64)gp2 * NSEC_PER_USEC);
+	spin_unlock_bh(&data->lock);
+
+	*ts = ns_to_timespec64(ns);
+	return 0;
+}
+
+static int iwl_mld_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct iwl_mld *mld = container_of(ptp, struct iwl_mld,
+					   ptp_data.ptp_clock_info);
+	struct ptp_data *data = &mld->ptp_data;
+
+	spin_lock_bh(&data->lock);
+	data->delta += delta;
+	IWL_DEBUG_PTP(mld, "delta=%lld, new delta=%lld\n", (long long)delta,
+		      (long long)data->delta);
+	spin_unlock_bh(&data->lock);
+	return 0;
+}
+
+static int iwl_mld_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct iwl_mld *mld = container_of(ptp, struct iwl_mld,
+					   ptp_data.ptp_clock_info);
+	struct ptp_data *data = &mld->ptp_data;
+	u32 gp2;
+
+	/* Must call iwl_mld_ptp_get_adj_time() before updating
+	 * data->scale_update_gp2 or data->scaled_freq since
+	 * scale_update_adj_time_ns should reflect the previous scaled_freq.
+	 */
+	if (iwl_mld_get_systime(mld, &gp2)) {
+		IWL_DEBUG_PTP(mld, "adjfine: failed to read systime\n");
+		return -EBUSY;
+	}
+
+	spin_lock_bh(&data->lock);
+	data->scale_update_adj_time_ns =
+		iwl_mld_ptp_get_adj_time(mld, gp2 * NSEC_PER_USEC);
+	data->scale_update_gp2 = gp2;
+
+	/* scale_update_adj_time_ns now relects the configured delta, the
+	 * wrap_counter and the previous scaled frequency. Thus delta and
+	 * wrap_counter should be reset, and the scale frequency is updated
+	 * to the new frequency.
+	 */
+	data->delta = 0;
+	data->wrap_counter = 0;
+	data->scaled_freq = PTP_SCALE_FACTOR + scaled_ppm;
+	IWL_DEBUG_PTP(mld, "adjfine: scaled_ppm=%ld new=%llu\n",
+		      scaled_ppm, (unsigned long long)data->scaled_freq);
+	spin_unlock_bh(&data->lock);
+	return 0;
+}
+
+static void iwl_mld_ptp_work(struct work_struct *wk)
+{
+	struct iwl_mld *mld = container_of(wk, struct iwl_mld,
+					   ptp_data.dwork.work);
+	struct ptp_data *data = &mld->ptp_data;
+	u32 gp2;
+
+	spin_lock_bh(&data->lock);
+	if (!iwl_mld_get_systime(mld, &gp2))
+		iwl_mld_ptp_update_new_read(mld, gp2);
+	else
+		IWL_DEBUG_PTP(mld, "PTP work: failed to read GP2\n");
+	spin_unlock_bh(&data->lock);
+}
+
+static int
+iwl_mld_get_crosstimestamp_fw(struct iwl_mld *mld, u32 *gp2, u64 *sys_time)
+{
+	struct iwl_synced_time_cmd synced_time_cmd = {
+		.operation = cpu_to_le32(IWL_SYNCED_TIME_OPERATION_READ_BOTH)
+	};
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(DATA_PATH_GROUP, WNM_PLATFORM_PTM_REQUEST_CMD),
+		.flags = CMD_WANT_SKB,
+		.data[0] = &synced_time_cmd,
+		.len[0] = sizeof(synced_time_cmd),
+	};
+	struct iwl_synced_time_rsp *resp;
+	struct iwl_rx_packet *pkt;
+	int ret;
+	u64 gp2_10ns;
+
+	wiphy_lock(mld->wiphy);
+	ret = iwl_mld_send_cmd(mld, &cmd);
+	wiphy_unlock(mld->wiphy);
+	if (ret)
+		return ret;
+
+	pkt = cmd.resp_pkt;
+
+	if (iwl_rx_packet_payload_len(pkt) != sizeof(*resp)) {
+		IWL_DEBUG_PTP(mld, "PTP: Invalid PTM command response\n");
+		iwl_free_resp(&cmd);
+		return -EIO;
+	}
+
+	resp = (void *)pkt->data;
+
+	gp2_10ns = (u64)le32_to_cpu(resp->gp2_timestamp_hi) << 32 |
+		le32_to_cpu(resp->gp2_timestamp_lo);
+	*gp2 = div_u64(gp2_10ns, 100);
+
+	*sys_time = (u64)le32_to_cpu(resp->platform_timestamp_hi) << 32 |
+		le32_to_cpu(resp->platform_timestamp_lo);
+
+	iwl_free_resp(&cmd);
+	return ret;
+}
+
+static int
+iwl_mld_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
+			       struct system_device_crosststamp *xtstamp)
+{
+	struct iwl_mld *mld = container_of(ptp, struct iwl_mld,
+					   ptp_data.ptp_clock_info);
+	struct ptp_data *data = &mld->ptp_data;
+	int ret = 0;
+	/* Raw value read from GP2 register in usec */
+	u32 gp2;
+	/* GP2 value in ns*/
+	s64 gp2_ns;
+	/* System (wall) time */
+	ktime_t sys_time;
+
+	memset(xtstamp, 0, sizeof(struct system_device_crosststamp));
+
+	ret = iwl_mld_get_crosstimestamp_fw(mld, &gp2, &sys_time);
+	if (ret) {
+		IWL_DEBUG_PTP(mld,
+			      "PTP: fw get_crosstimestamp failed (ret=%d)\n",
+			      ret);
+		return ret;
+	}
+
+	spin_lock_bh(&data->lock);
+	gp2_ns = iwl_mld_ptp_get_adj_time(mld, (u64)gp2 * NSEC_PER_USEC);
+	spin_unlock_bh(&data->lock);
+
+	IWL_DEBUG_PTP(mld,
+		      "Got Sync Time: GP2:%u, last_GP2: %u, GP2_ns: %lld, sys_time: %lld\n",
+		      gp2, mld->ptp_data.last_gp2, gp2_ns, (s64)sys_time);
+
+	/* System monotonic raw time is not used */
+	xtstamp->device = ns_to_ktime(gp2_ns);
+	xtstamp->sys_realtime = sys_time;
+
+	return ret;
+}
+
+void iwl_mld_ptp_init(struct iwl_mld *mld)
+{
+	if (WARN_ON(mld->ptp_data.ptp_clock))
+		return;
+
+	spin_lock_init(&mld->ptp_data.lock);
+	INIT_DELAYED_WORK(&mld->ptp_data.dwork, iwl_mld_ptp_work);
+
+	mld->ptp_data.ptp_clock_info.owner = THIS_MODULE;
+	mld->ptp_data.ptp_clock_info.gettime64 = iwl_mld_ptp_gettime;
+	mld->ptp_data.ptp_clock_info.max_adj = 0x7fffffff;
+	mld->ptp_data.ptp_clock_info.adjtime = iwl_mld_ptp_adjtime;
+	mld->ptp_data.ptp_clock_info.adjfine = iwl_mld_ptp_adjfine;
+	mld->ptp_data.scaled_freq = PTP_SCALE_FACTOR;
+	mld->ptp_data.ptp_clock_info.getcrosststamp =
+					iwl_mld_phc_get_crosstimestamp;
+
+	/* Give a short 'friendly name' to identify the PHC clock */
+	snprintf(mld->ptp_data.ptp_clock_info.name,
+		 sizeof(mld->ptp_data.ptp_clock_info.name),
+		 "%s", "iwlwifi-PTP");
+
+	mld->ptp_data.ptp_clock =
+		ptp_clock_register(&mld->ptp_data.ptp_clock_info, mld->dev);
+
+	if (IS_ERR_OR_NULL(mld->ptp_data.ptp_clock)) {
+		IWL_ERR(mld, "Failed to register PHC clock (%ld)\n",
+			PTR_ERR(mld->ptp_data.ptp_clock));
+		mld->ptp_data.ptp_clock = NULL;
+	} else {
+		IWL_INFO(mld, "Registered PHC clock: %s, with index: %d\n",
+			 mld->ptp_data.ptp_clock_info.name,
+			 ptp_clock_index(mld->ptp_data.ptp_clock));
+	}
+}
+
+void iwl_mld_ptp_remove(struct iwl_mld *mld)
+{
+	if (mld->ptp_data.ptp_clock) {
+		IWL_INFO(mld, "Unregistering PHC clock: %s, with index: %d\n",
+			 mld->ptp_data.ptp_clock_info.name,
+			 ptp_clock_index(mld->ptp_data.ptp_clock));
+
+		ptp_clock_unregister(mld->ptp_data.ptp_clock);
+		mld->ptp_data.ptp_clock = NULL;
+		mld->ptp_data.last_gp2 = 0;
+		mld->ptp_data.wrap_counter = 0;
+		cancel_delayed_work_sync(&mld->ptp_data.dwork);
+	}
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.h b/drivers/net/wireless/intel/iwlwifi/mld/ptp.h
new file mode 100644
index 000000000000..f3d18dd304e5
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#ifndef __iwl_mld_ptp_h__
+#define __iwl_mld_ptp_h__
+
+#include <linux/ptp_clock_kernel.h>
+
+/**
+ * struct ptp_data - PTP hardware clock data
+ *
+ * @ptp_clock: struct ptp_clock pointer returned by the ptp_clock_register()
+ *	function.
+ * @ptp_clock_info: struct ptp_clock_info that describes a PTP hardware clock
+ * @lock: protects the time adjustments data
+ * @delta: delta between hardware clock and ptp clock in nanoseconds
+ * @scale_update_gp2: GP2 time when the scale was last updated
+ * @scale_update_adj_time_ns: adjusted time when the scale was last updated,
+ *	in nanoseconds
+ * @scaled_freq: clock frequency offset, scaled to 65536000000
+ * @last_gp2: the last GP2 reading from the hardware, used for tracking GP2
+ *	wraparounds
+ * @wrap_counter: number of wraparounds since scale_update_adj_time_ns
+ * @dwork: worker scheduled every 1 hour to detect workarounds
+ */
+struct ptp_data {
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_clock_info;
+
+	spinlock_t lock;
+	s64 delta;
+	u32 scale_update_gp2;
+	u64 scale_update_adj_time_ns;
+	u64 scaled_freq;
+	u32 last_gp2;
+	u32 wrap_counter;
+	struct delayed_work dwork;
+};
+
+void iwl_mld_ptp_init(struct iwl_mld *mld);
+void iwl_mld_ptp_remove(struct iwl_mld *mld);
+u64 iwl_mld_ptp_get_adj_time(struct iwl_mld *mld, u64 base_time_ns);
+
+#endif /* __iwl_mld_ptp_h__ */
-- 
2.34.1


