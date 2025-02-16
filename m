Return-Path: <linux-wireless+bounces-19002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE316A37395
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC60016CFFC
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5909199396;
	Sun, 16 Feb 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eW5h09ws"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34F19340D
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699059; cv=none; b=mUKdClDjqQxFzFqfXVWn+GQNaYhdoRKrDcHKMqFILFaRGD1jMk8txopB7vmj5V5xptfhhGbiyZOET/Q0IB1fHgLDdzvckxWH4wSslCexjLfoiABLv/2y0ln1YFDu2cgf6NhL59a9dNEQQ5foQkxMZSJFELxfykE9kbbzP7xghcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699059; c=relaxed/simple;
	bh=Oe4KZ+Yfy2/n0Z/AwURrYhnX0uSeksmx5gAB6V28lqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6ye2y8J2zuhwRnxcUKzP0YLmCldwnm+VilrUG5VI/9pbsGj5dK8k+v9DS//dUIhzxDWfZL5JZf02fAYgZkvQyWeBZ3zyOFeeBZnx3ezT2Z5+i7GzEUcRwxZPWtjibZwfn5Cc1n/A6BoapRqH4VxS0A6RpvTQMriZmmWfz58HV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eW5h09ws; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699054; x=1771235054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oe4KZ+Yfy2/n0Z/AwURrYhnX0uSeksmx5gAB6V28lqM=;
  b=eW5h09ws0iofbap1OKELTUGYebap9f1hWRqBQwLmIhtrKD1mNZf4j86v
   b+Rvd22Co6oylmW3XeCmEeOuXFuD1ZCpQbeFLADUnHoBnkpmkiMjFP6pa
   XChlsMh5hlPeBOZJwq8I2rEWVnq7OZF94+nhpeFkFPQiJ3/vfkhdNZJ7J
   QHTivMWiOUWJAbwb+IBshkU9h2WzyPupBN3qai8yEPZY9l3ZkjEvKoaE2
   rHxP7bEZzqSyWhUitt+JBm4PskKUpyuVxNIcmRHsvPRCwmSsQHBwt2RBz
   X9/2x0hPQIcgonw8n6JPObMFSFj6MrkJ+TC/AGYNIXem+ZpDlwS2R0R6D
   Q==;
X-CSE-ConnectionGUID: EIcEaSDvSAeG8LR5Wg6KNA==
X-CSE-MsgGUID: BTbpJgbJSsWBSEZVvKDOMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323416"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323416"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:14 -0800
X-CSE-ConnectionGUID: rMtsE4VQSpuO9xoyasnM9g==
X-CSE-MsgGUID: ZpRYGnXDS1qJk3LlV3zdSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785265"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 30/42] wifi: iwlwifi: mld: add file thermal.h/c
Date: Sun, 16 Feb 2025 11:43:09 +0200
Message-Id: <20250216111649.464f5da344ca.Ib7ef4b721078430d4412229b72c0cd57d8759d01@changeid>
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

this file is handling a link object

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/thermal.c  | 438 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mld/thermal.h  |  36 ++
 2 files changed, 474 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
new file mode 100644
index 000000000000..1909953a9be9
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifdef CONFIG_THERMAL
+#include <linux/sort.h>
+#include <linux/thermal.h>
+#endif
+
+#include "fw/api/phy.h"
+
+#include "thermal.h"
+#include "mld.h"
+#include "hcmd.h"
+
+#define IWL_MLD_CT_KILL_DURATION (5 * HZ)
+
+void iwl_mld_handle_ct_kill_notif(struct iwl_mld *mld,
+				  struct iwl_rx_packet *pkt)
+{
+	const struct ct_kill_notif *notif = (const void *)pkt->data;
+
+	IWL_ERR(mld,
+		"CT Kill notification: temp = %d, DTS = 0x%x, Scheme 0x%x - Enter CT Kill\n",
+		le16_to_cpu(notif->temperature), notif->dts,
+		notif->scheme);
+
+	iwl_mld_set_ctkill(mld, true);
+
+	wiphy_delayed_work_queue(mld->wiphy, &mld->ct_kill_exit_wk,
+				 round_jiffies_relative(IWL_MLD_CT_KILL_DURATION));
+}
+
+static void iwl_mld_exit_ctkill(struct wiphy *wiphy, struct wiphy_work *wk)
+{
+	struct iwl_mld *mld;
+
+	mld = container_of(wk, struct iwl_mld, ct_kill_exit_wk.work);
+
+	IWL_ERR(mld, "Exit CT Kill\n");
+	iwl_mld_set_ctkill(mld, false);
+}
+
+void iwl_mld_handle_temp_notif(struct iwl_mld *mld, struct iwl_rx_packet *pkt)
+{
+	const struct iwl_dts_measurement_notif *notif =
+		(const void *)pkt->data;
+	int temp;
+	u32 ths_crossed;
+
+	temp = le32_to_cpu(notif->temp);
+
+	/* shouldn't be negative, but since it's s32, make sure it isn't */
+	if (IWL_FW_CHECK(mld, temp < 0, "negative temperature %d\n", temp))
+		return;
+
+	ths_crossed = le32_to_cpu(notif->threshold_idx);
+
+	/* 0xFF in ths_crossed means the notification is not related
+	 * to a trip, so we can ignore it here.
+	 */
+	if (ths_crossed == 0xFF)
+		return;
+
+	IWL_DEBUG_TEMP(mld, "Temp = %d Threshold crossed = %d\n",
+		       temp, ths_crossed);
+
+	if (IWL_FW_CHECK(mld, ths_crossed >= IWL_MAX_DTS_TRIPS,
+			 "bad threshold: %d\n", ths_crossed))
+		return;
+
+#ifdef CONFIG_THERMAL
+	if (mld->tzone)
+		thermal_zone_device_update(mld->tzone, THERMAL_TRIP_VIOLATED);
+#endif /* CONFIG_THERMAL */
+}
+
+#ifdef CONFIG_THERMAL
+static int iwl_mld_get_temp(struct iwl_mld *mld, s32 *temp)
+{
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(PHY_OPS_GROUP, CMD_DTS_MEASUREMENT_TRIGGER_WIDE),
+		.flags = CMD_WANT_SKB,
+	};
+	const struct iwl_dts_measurement_resp *resp;
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_send_cmd(mld, &cmd);
+	if (ret) {
+		IWL_ERR(mld,
+			"Failed to send the temperature measurement command (err=%d)\n",
+			ret);
+		return ret;
+	}
+
+	if (iwl_rx_packet_payload_len(cmd.resp_pkt) < sizeof(*resp)) {
+		IWL_ERR(mld,
+			"Failed to get a valid response to DTS measurement\n");
+		ret = -EIO;
+		goto free_resp;
+	}
+
+	resp = (const void *)cmd.resp_pkt->data;
+	*temp = le32_to_cpu(resp->temp);
+
+	IWL_DEBUG_TEMP(mld,
+		       "Got temperature measurement response: temp=%d\n",
+		       *temp);
+
+free_resp:
+	iwl_free_resp(&cmd);
+	return ret;
+}
+
+static int compare_temps(const void *a, const void *b)
+{
+	return ((s16)le16_to_cpu(*(__le16 *)a) -
+		(s16)le16_to_cpu(*(__le16 *)b));
+}
+
+struct iwl_trip_walk_data {
+	__le16 *thresholds;
+	int count;
+};
+
+static int iwl_trip_temp_iter(struct thermal_trip *trip, void *arg)
+{
+	struct iwl_trip_walk_data *twd = arg;
+
+	if (trip->temperature == THERMAL_TEMP_INVALID)
+		return 0;
+
+	twd->thresholds[twd->count++] =
+		cpu_to_le16((s16)(trip->temperature / 1000));
+	return 0;
+}
+#endif
+
+int iwl_mld_config_temp_report_ths(struct iwl_mld *mld)
+{
+	struct temp_report_ths_cmd cmd = {0};
+	int ret;
+#ifdef CONFIG_THERMAL
+	struct iwl_trip_walk_data twd = {
+		.thresholds = cmd.thresholds,
+		.count = 0
+	};
+
+	if (!mld->tzone)
+		goto send;
+
+	/* The thermal core holds an array of temperature trips that are
+	 * unsorted and uncompressed, the FW should get it compressed and
+	 * sorted.
+	 */
+
+	/* compress trips to cmd array, remove uninitialized values*/
+	for_each_thermal_trip(mld->tzone, iwl_trip_temp_iter, &twd);
+
+	cmd.num_temps = cpu_to_le32(twd.count);
+	if (twd.count)
+		sort(cmd.thresholds, twd.count, sizeof(s16),
+		     compare_temps, NULL);
+
+send:
+#endif
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP,
+						TEMP_REPORTING_THRESHOLDS_CMD),
+				   &cmd);
+	if (ret)
+		IWL_ERR(mld, "TEMP_REPORT_THS_CMD command failed (err=%d)\n",
+			ret);
+
+	return ret;
+}
+
+#ifdef CONFIG_THERMAL
+static int iwl_mld_tzone_get_temp(struct thermal_zone_device *device,
+				  int *temperature)
+{
+	struct iwl_mld *mld = thermal_zone_device_priv(device);
+	int temp;
+	int ret = 0;
+
+	wiphy_lock(mld->wiphy);
+
+	if (!mld->fw_status.running) {
+		/* Tell the core that there is no valid temperature value to
+		 * return, but it need not worry about this.
+		 */
+		*temperature = THERMAL_TEMP_INVALID;
+		goto unlock;
+	}
+
+	ret = iwl_mld_get_temp(mld, &temp);
+	if (ret)
+		goto unlock;
+
+	*temperature = temp * 1000;
+unlock:
+	wiphy_unlock(mld->wiphy);
+	return ret;
+}
+
+static int iwl_mld_tzone_set_trip_temp(struct thermal_zone_device *device,
+				       const struct thermal_trip *trip,
+				       int temp)
+{
+	struct iwl_mld *mld = thermal_zone_device_priv(device);
+	int ret;
+
+	wiphy_lock(mld->wiphy);
+
+	if (!mld->fw_status.running) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	if ((temp / 1000) > S16_MAX) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = iwl_mld_config_temp_report_ths(mld);
+unlock:
+	wiphy_unlock(mld->wiphy);
+	return ret;
+}
+
+static  struct thermal_zone_device_ops tzone_ops = {
+	.get_temp = iwl_mld_tzone_get_temp,
+	.set_trip_temp = iwl_mld_tzone_set_trip_temp,
+};
+
+static void iwl_mld_thermal_zone_register(struct iwl_mld *mld)
+{
+	int ret;
+	char name[16];
+	static atomic_t counter = ATOMIC_INIT(0);
+	struct thermal_trip trips[IWL_MAX_DTS_TRIPS] = {
+		[0 ... IWL_MAX_DTS_TRIPS - 1] = {
+			.temperature = THERMAL_TEMP_INVALID,
+			.type = THERMAL_TRIP_PASSIVE,
+			.flags = THERMAL_TRIP_FLAG_RW_TEMP,
+		},
+	};
+
+	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
+
+	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
+	mld->tzone =
+		thermal_zone_device_register_with_trips(name, trips,
+							IWL_MAX_DTS_TRIPS,
+							mld, &tzone_ops,
+							NULL, 0, 0);
+	if (IS_ERR(mld->tzone)) {
+		IWL_DEBUG_TEMP(mld,
+			       "Failed to register to thermal zone (err = %ld)\n",
+			       PTR_ERR(mld->tzone));
+		mld->tzone = NULL;
+		return;
+	}
+
+	ret = thermal_zone_device_enable(mld->tzone);
+	if (ret) {
+		IWL_DEBUG_TEMP(mld, "Failed to enable thermal zone\n");
+		thermal_zone_device_unregister(mld->tzone);
+	}
+}
+
+/* budget in mWatt */
+static const u32 iwl_mld_cdev_budgets[] = {
+	2400,	/* cooling state 0 */
+	2000,	/* cooling state 1 */
+	1800,	/* cooling state 2 */
+	1600,	/* cooling state 3 */
+	1400,	/* cooling state 4 */
+	1200,	/* cooling state 5 */
+	1000,	/* cooling state 6 */
+	900,	/* cooling state 7 */
+	800,	/* cooling state 8 */
+	700,	/* cooling state 9 */
+	650,	/* cooling state 10 */
+	600,	/* cooling state 11 */
+	550,	/* cooling state 12 */
+	500,	/* cooling state 13 */
+	450,	/* cooling state 14 */
+	400,	/* cooling state 15 */
+	350,	/* cooling state 16 */
+	300,	/* cooling state 17 */
+	250,	/* cooling state 18 */
+	200,	/* cooling state 19 */
+	150,	/* cooling state 20 */
+};
+
+int iwl_mld_config_ctdp(struct iwl_mld *mld, u32 state,
+			enum iwl_ctdp_cmd_operation op)
+{
+	struct iwl_ctdp_cmd cmd = {
+		.operation = cpu_to_le32(op),
+		.budget = cpu_to_le32(iwl_mld_cdev_budgets[state]),
+		.window_size = 0,
+	};
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP, CTDP_CONFIG_CMD),
+				   &cmd);
+
+	if (ret) {
+		IWL_ERR(mld, "cTDP command failed (err=%d)\n", ret);
+		return ret;
+	}
+
+	if (op == CTDP_CMD_OPERATION_START)
+		mld->cooling_dev.cur_state = state;
+
+	return 0;
+}
+
+static int iwl_mld_tcool_get_max_state(struct thermal_cooling_device *cdev,
+				       unsigned long *state)
+{
+	*state = ARRAY_SIZE(iwl_mld_cdev_budgets) - 1;
+
+	return 0;
+}
+
+static int iwl_mld_tcool_get_cur_state(struct thermal_cooling_device *cdev,
+				       unsigned long *state)
+{
+	struct iwl_mld *mld = (struct iwl_mld *)(cdev->devdata);
+
+	*state = mld->cooling_dev.cur_state;
+
+	return 0;
+}
+
+static int iwl_mld_tcool_set_cur_state(struct thermal_cooling_device *cdev,
+				       unsigned long new_state)
+{
+	struct iwl_mld *mld = (struct iwl_mld *)(cdev->devdata);
+	int ret;
+
+	wiphy_lock(mld->wiphy);
+
+	if (!mld->fw_status.running) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	if (new_state >= ARRAY_SIZE(iwl_mld_cdev_budgets)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = iwl_mld_config_ctdp(mld, new_state, CTDP_CMD_OPERATION_START);
+
+unlock:
+	wiphy_unlock(mld->wiphy);
+	return ret;
+}
+
+static const struct thermal_cooling_device_ops tcooling_ops = {
+	.get_max_state = iwl_mld_tcool_get_max_state,
+	.get_cur_state = iwl_mld_tcool_get_cur_state,
+	.set_cur_state = iwl_mld_tcool_set_cur_state,
+};
+
+static void iwl_mld_cooling_device_register(struct iwl_mld *mld)
+{
+	char name[] = "iwlwifi";
+
+	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
+
+	mld->cooling_dev.cdev =
+		thermal_cooling_device_register(name,
+						mld,
+						&tcooling_ops);
+
+	if (IS_ERR(mld->cooling_dev.cdev)) {
+		IWL_DEBUG_TEMP(mld,
+			       "Failed to register to cooling device (err = %ld)\n",
+			       PTR_ERR(mld->cooling_dev.cdev));
+		mld->cooling_dev.cdev = NULL;
+		return;
+	}
+}
+
+static void iwl_mld_thermal_zone_unregister(struct iwl_mld *mld)
+{
+	if (!mld->tzone)
+		return;
+
+	IWL_DEBUG_TEMP(mld, "Thermal zone device unregister\n");
+	if (mld->tzone) {
+		thermal_zone_device_unregister(mld->tzone);
+		mld->tzone = NULL;
+	}
+}
+
+static void iwl_mld_cooling_device_unregister(struct iwl_mld *mld)
+{
+	if (!mld->cooling_dev.cdev)
+		return;
+
+	IWL_DEBUG_TEMP(mld, "Cooling device unregister\n");
+	if (mld->cooling_dev.cdev) {
+		thermal_cooling_device_unregister(mld->cooling_dev.cdev);
+		mld->cooling_dev.cdev = NULL;
+	}
+}
+#endif /* CONFIG_THERMAL */
+
+void iwl_mld_thermal_initialize(struct iwl_mld *mld)
+{
+	wiphy_delayed_work_init(&mld->ct_kill_exit_wk, iwl_mld_exit_ctkill);
+
+#ifdef CONFIG_THERMAL
+	iwl_mld_cooling_device_register(mld);
+	iwl_mld_thermal_zone_register(mld);
+#endif
+}
+
+void iwl_mld_thermal_exit(struct iwl_mld *mld)
+{
+	wiphy_delayed_work_cancel(mld->wiphy, &mld->ct_kill_exit_wk);
+
+#ifdef CONFIG_THERMAL
+	iwl_mld_cooling_device_unregister(mld);
+	iwl_mld_thermal_zone_unregister(mld);
+#endif
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.h b/drivers/net/wireless/intel/iwlwifi/mld/thermal.h
new file mode 100644
index 000000000000..8c8893331b05
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_thermal_h__
+#define __iwl_mld_thermal_h__
+
+#include "iwl-trans.h"
+
+struct iwl_mld;
+
+#ifdef CONFIG_THERMAL
+#include <linux/thermal.h>
+
+/*
+ * struct iwl_mld_cooling_device
+ * @cur_state: current state
+ * @cdev: struct thermal cooling device
+ */
+struct iwl_mld_cooling_device {
+	u32 cur_state;
+	struct thermal_cooling_device *cdev;
+};
+
+int iwl_mld_config_ctdp(struct iwl_mld *mld, u32 state,
+			enum iwl_ctdp_cmd_operation op);
+#endif
+
+void iwl_mld_handle_temp_notif(struct iwl_mld *mld, struct iwl_rx_packet *pkt);
+void iwl_mld_handle_ct_kill_notif(struct iwl_mld *mld,
+				  struct iwl_rx_packet *pkt);
+int iwl_mld_config_temp_report_ths(struct iwl_mld *mld);
+void iwl_mld_thermal_initialize(struct iwl_mld *mld);
+void iwl_mld_thermal_exit(struct iwl_mld *mld);
+
+#endif /* __iwl_mld_thermal_h__ */
-- 
2.34.1


