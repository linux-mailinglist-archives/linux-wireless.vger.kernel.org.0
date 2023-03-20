Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043DB6C0EEE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCTKeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjCTKdu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:33:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B43718A80
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308416; x=1710844416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KiKNgbsZ7hV1EvNhKAOmw24zQGJrX1kkTeOjnh57KPM=;
  b=TefUkhDeLdFubLhMwUGVaC4t21lOphYQDPxDUvklTv/M2OMAp9c8fGLr
   B2wovl8xCWw9pwToxlnvnbX+B+0cxKNLsXZEQZ8k5yHyEJpM7tAd8KtFE
   yyK5zg8TOmia1VqEkHQFS+XpqgW33uWXjomQ2uDeJncTuNq6h0mhua93W
   zpLPzvUC5ZW+yXhbGxbAp2nlPFt3yoWyuhm6Knzbmrev32N55ywqsPspw
   oJq4dA3hWOsNyAq97uoqOXjvt4Z7v3nfPUJasOPwvNQyt8tOXqgy/Q4L2
   9fnve7aBFyUS+I5VjPQFIxhWWQpAPJ6XEyFUe0rpEyrICme8kd4y1eHOa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997858"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997858"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523640"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523640"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/18] wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)
Date:   Mon, 20 Mar 2023 12:33:02 +0200
Message-Id: <20230320122330.ae1d64f513b9.Ib3b6ad61c9fa2fc5908f1e0d6f59f4af6eec1a77@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Krishnanand Prabhu <krishnanand.prabhu@intel.com>

Add support to enable/disable PHC clock. The PHC clock includes support
for fetching the cross timestamp i.e. a non-atomic snapshot of the current
time from the hardware (WiFi device) clock and system clock (wall-clock)
simultaneously.

Signed-off-by: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  15 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  | 131 ++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index b82f79ac5378..943e8de9bc98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -8,6 +8,7 @@ iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
 iwlmvm-y += rfi.o
 iwlmvm-y += mld-key.o mld-mac.o link.o mld-sta.o mld-mac80211.o
+iwlmvm-y += ptp.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index fe7dfdcd531b..4079c0d939c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1669,6 +1669,9 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
 		iwl_mvm_send_recovery_cmd(mvm, ERROR_RECOVERY_UPDATE_DB);
 
+	if (!mvm->ptp_data.ptp_clock)
+		iwl_mvm_ptp_init(mvm);
+
 	if (iwl_acpi_get_eckv(mvm->dev, &mvm->ext_clock_valid))
 		IWL_DEBUG_INFO(mvm, "ECKV table doesn't exist in BIOS\n");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7cc3526e78ce..4d99e76811a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -16,6 +16,8 @@
 #include <linux/thermal.h>
 #endif
 
+#include <linux/ptp_clock_kernel.h>
+
 #include <linux/ktime.h>
 
 #include "iwl-op-mode.h"
@@ -770,6 +772,15 @@ struct iwl_mvm_dqa_txq_info {
 	enum iwl_mvm_queue_status status;
 };
 
+struct ptp_data {
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_clock_info;
+	/* keeps track of GP2 wrap-around */
+	u32 last_gp2;
+	u32 wrap_counter;
+	struct delayed_work dwork;
+};
+
 struct iwl_mvm {
 	/* for logger access */
 	struct device *dev;
@@ -1080,6 +1091,8 @@ struct iwl_mvm {
 
 	struct list_head resp_pasn_list;
 
+	struct ptp_data ptp_data;
+
 	struct {
 		u8 range_resp;
 	} cmd_ver;
@@ -2121,6 +2134,8 @@ void iwl_mvm_event_frame_timeout_callback(struct iwl_mvm *mvm,
 					  const struct ieee80211_sta *sta,
 					  u16 tid);
 
+void iwl_mvm_ptp_init(struct iwl_mvm *mvm);
+void iwl_mvm_ptp_remove(struct iwl_mvm *mvm);
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b);
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm);
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 03da4e53de67..e7def1a0f767 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1435,6 +1435,8 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 	kfree(mvm->error_recovery_buf);
 	mvm->error_recovery_buf = NULL;
 
+	iwl_mvm_ptp_remove(mvm);
+
 	iwl_trans_op_mode_leave(mvm->trans);
 
 	iwl_phy_db_free(mvm->phy_db);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
new file mode 100644
index 000000000000..f786f5efb497
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2021 - 2023 Intel Corporation
+ */
+
+#include "mvm.h"
+#include "iwl-debug.h"
+#include <linux/timekeeping.h>
+
+#define IWL_PTP_GP2_WRAP	0x100000000ULL
+#define IWL_PTP_WRAP_TIME	(3600 * HZ)
+
+static void iwl_mvm_ptp_update_new_read(struct iwl_mvm *mvm, u32 gp2)
+{
+	if (gp2 < mvm->ptp_data.last_gp2) {
+		mvm->ptp_data.wrap_counter++;
+		IWL_DEBUG_INFO(mvm,
+			       "PTP: wraparound detected (new counter=%u)\n",
+			       mvm->ptp_data.wrap_counter);
+	}
+
+	mvm->ptp_data.last_gp2 = gp2;
+	schedule_delayed_work(&mvm->ptp_data.dwork, IWL_PTP_WRAP_TIME);
+}
+
+static int
+iwl_mvm_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
+			       struct system_device_crosststamp *xtstamp)
+{
+	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
+					   ptp_data.ptp_clock_info);
+	/* Raw value read from GP2 register in usec */
+	u32 gp2;
+	/* GP2 value in ns*/
+	s64 gp2_ns;
+	/* System (wall) time */
+	ktime_t sys_time;
+
+	memset(xtstamp, 0, sizeof(struct system_device_crosststamp));
+
+	if (!mvm->ptp_data.ptp_clock) {
+		IWL_ERR(mvm, "No PHC clock registered\n");
+		return -ENODEV;
+	}
+
+	iwl_mvm_get_sync_time(mvm, CLOCK_REALTIME, &gp2, NULL, &sys_time);
+
+	iwl_mvm_ptp_update_new_read(mvm, gp2);
+
+	gp2_ns = (gp2 + (mvm->ptp_data.wrap_counter * IWL_PTP_GP2_WRAP)) *
+		NSEC_PER_USEC;
+
+	IWL_INFO(mvm, "Got Sync Time: GP2:%u, last_GP2: %u, GP2_ns: %lld, sys_time: %lld\n",
+		 gp2, mvm->ptp_data.last_gp2, gp2_ns, (s64)sys_time);
+
+	/* System monotonic raw time is not used */
+	xtstamp->device = (ktime_t)gp2_ns;
+	xtstamp->sys_realtime = sys_time;
+
+	return 0;
+}
+
+static void iwl_mvm_ptp_work(struct work_struct *wk)
+{
+	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm,
+					   ptp_data.dwork.work);
+	u32 gp2;
+
+	mutex_lock(&mvm->mutex);
+	gp2 = iwl_mvm_get_systime(mvm);
+	iwl_mvm_ptp_update_new_read(mvm, gp2);
+	mutex_unlock(&mvm->mutex);
+}
+
+/* iwl_mvm_ptp_init - initialize PTP for devices which support it.
+ * @mvm: internal mvm structure, see &struct iwl_mvm.
+ *
+ * Performs the required steps for enabling PTP support.
+ */
+void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
+{
+	/* Warn if the interface already has a ptp_clock defined */
+	if (WARN_ON(mvm->ptp_data.ptp_clock))
+		return;
+
+	mvm->ptp_data.ptp_clock_info.owner = THIS_MODULE;
+	mvm->ptp_data.ptp_clock_info.max_adj = 0x7fffffff;
+	mvm->ptp_data.ptp_clock_info.getcrosststamp =
+					iwl_mvm_phc_get_crosstimestamp;
+
+	/* Give a short 'friendly name' to identify the PHC clock */
+	snprintf(mvm->ptp_data.ptp_clock_info.name,
+		 sizeof(mvm->ptp_data.ptp_clock_info.name),
+		 "%s", "iwlwifi-PTP");
+
+	INIT_DELAYED_WORK(&mvm->ptp_data.dwork, iwl_mvm_ptp_work);
+
+	mvm->ptp_data.ptp_clock =
+		ptp_clock_register(&mvm->ptp_data.ptp_clock_info, mvm->dev);
+
+	if (IS_ERR(mvm->ptp_data.ptp_clock)) {
+		IWL_ERR(mvm, "Failed to register PHC clock (%ld)\n",
+			PTR_ERR(mvm->ptp_data.ptp_clock));
+		mvm->ptp_data.ptp_clock = NULL;
+	} else if (mvm->ptp_data.ptp_clock) {
+		IWL_INFO(mvm, "Registered PHC clock: %s, with index: %d\n",
+			 mvm->ptp_data.ptp_clock_info.name,
+			 ptp_clock_index(mvm->ptp_data.ptp_clock));
+	}
+}
+
+/* iwl_mvm_ptp_remove - disable PTP device.
+ * @mvm: internal mvm structure, see &struct iwl_mvm.
+ *
+ * Disable PTP support.
+ */
+void iwl_mvm_ptp_remove(struct iwl_mvm *mvm)
+{
+	if (mvm->ptp_data.ptp_clock) {
+		IWL_INFO(mvm, "Unregistering PHC clock: %s, with index: %d\n",
+			 mvm->ptp_data.ptp_clock_info.name,
+			 ptp_clock_index(mvm->ptp_data.ptp_clock));
+
+		ptp_clock_unregister(mvm->ptp_data.ptp_clock);
+		mvm->ptp_data.ptp_clock = NULL;
+		memset(&mvm->ptp_data.ptp_clock_info, 0,
+		       sizeof(mvm->ptp_data.ptp_clock_info));
+		mvm->ptp_data.last_gp2 = 0;
+		cancel_delayed_work_sync(&mvm->ptp_data.dwork);
+	}
+}
-- 
2.38.1

