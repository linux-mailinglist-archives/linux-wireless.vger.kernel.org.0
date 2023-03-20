Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20066C0EEF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjCTKeM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjCTKd4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:33:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7409EEC
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308418; x=1710844418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pZzWdBveRrOSTQQc83hDDqtc6XoTG6dlHnI4v7gFhA4=;
  b=egXR+t4z+EYZSPeGy5jt+C9wezngKpqr//INJTl4mVCYesMFfzl/doS0
   I1HVkU56/KWqfdYORbfGb7BaDHPtZYM2iIcVOM9k1QcqRIwTxzypOkuIq
   TKjpchOa8TfPfS3XWZ8hOx7hQwYIWYeNRMdiRBq+pba1nBzxoZmi2Wtsu
   i91WqcjlL/BPOYZYykG3UiJXY80096h853ruNt9q5ZjGfuS9yauodftiD
   KF6e/pfAkFsHV54C6ZCG3p+74MgAAN3mvaWkO+cPnOmqLFf23rRHGWZWH
   50RWHmAfbwUsrl7X9325xscsR0mYO6dN6RfqznCyEQ8hyo+fpwjnnsNVn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997877"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523644"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523644"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/18] wifi: iwlwifi: mvm: read synced time from firmware if supported
Date:   Mon, 20 Mar 2023 12:33:03 +0200
Message-Id: <20230320122330.a6be5f0b5580.Idedb496a5943fa496143066ffbed08185a8c4582@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

If the firmware supports reading synced GP2/ATRB timestamps,
read the synced timestamps from firmware instead of reading the
GP2 register and the system time separately. Reading the synced
time from firmware should be more accurate.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 49 +++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  | 57 ++++++++++++++++++-
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 8b38a0073077..59db52f32e43 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -26,6 +26,11 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	TRIGGER_RX_QUEUES_NOTIF_CMD = 0x2,
 
+	/**
+	 * @WNM_PLATFORM_PTM_REQUEST_CMD: &struct iwl_time_sync_cfg_cmd
+	 */
+	WNM_PLATFORM_PTM_REQUEST_CMD = 0x3,
+
 	/**
 	 * @STA_HE_CTXT_CMD: &struct iwl_he_sta_context_cmd
 	 */
@@ -146,6 +151,48 @@ enum iwl_channel_estimation_flags {
 	IWL_CHANNEL_ESTIMATION_COUNTER	= BIT(2),
 };
 
+/**
+ * enum iwl_synced_time_operation - PTM request options
+ *
+ * @IWL_SYNCED_TIME_OPERATION_READ_ARTB: read only the ARTB time
+ * @IWL_SYNCED_TIME_OPERATION_READ_GP2: read only the GP2 time
+ * @IWL_SYNCED_TIME_OPERATION_READ_BOTH: latch the ARTB and GP2 clocks and
+ *	provide timestamps from both clocks for the same time point
+ */
+enum iwl_synced_time_operation {
+	IWL_SYNCED_TIME_OPERATION_READ_ARTB = 1,
+	IWL_SYNCED_TIME_OPERATION_READ_GP2,
+	IWL_SYNCED_TIME_OPERATION_READ_BOTH,
+};
+
+/**
+ * struct iwl_synced_time_cmd - request synced GP2/ARTB timestamps
+ *
+ * @operation: one of &enum iwl_synced_time_operation
+ */
+struct iwl_synced_time_cmd {
+	__le32 operation;
+} __packed; /* WNM_80211V_TIMING_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_synced_time_rsp - response to iwl_synced_time_cmd
+ *
+ * @operation: one of &enum iwl_synced_time_operation
+ * @platform_timestamp_hi: high DWORD of the ARTB clock timestamp in nanoseconds
+ * @platform_timestamp_lo: low DWORD of the ARTB clock timestamp in nanoseconds
+ * @gp2_timestamp_hi: high DWORD of the GP2 clock timestamp in 10's of
+ *	nanoseconds
+ * @gp2_timestamp_lo: low DWORD of the GP2 clock timestamp in 10's of
+ *	nanoseconds
+ */
+struct iwl_synced_time_rsp {
+	__le32 operation;
+	__le32 platform_timestamp_hi;
+	__le32 platform_timestamp_lo;
+	__le32 gp2_timestamp_hi;
+	__le32 gp2_timestamp_lo;
+} __packed; /* WNM_80211V_TIMING_RSP_API_S_VER_1 */
+
 /**
  * struct iwl_channel_estimation_cfg - channel estimation reporting config
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index a7817d952022..e4b2f1a87575 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -455,6 +455,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
 	IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)104,
 	IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)105,
+	IWL_UCODE_TLV_CAPA_SYNCED_TIME			= (__force iwl_ucode_tlv_capa_t)106,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index f786f5efb497..10f23c8b1dd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -23,12 +23,54 @@ static void iwl_mvm_ptp_update_new_read(struct iwl_mvm *mvm, u32 gp2)
 	schedule_delayed_work(&mvm->ptp_data.dwork, IWL_PTP_WRAP_TIME);
 }
 
+static int
+iwl_mvm_get_crosstimestamp_fw(struct iwl_mvm *mvm, u32 *gp2, u64 *sys_time)
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
+	ret = iwl_mvm_send_cmd(mvm, &cmd);
+	if (ret)
+		return ret;
+
+	pkt = cmd.resp_pkt;
+
+	if (iwl_rx_packet_payload_len(pkt) != sizeof(*resp)) {
+		IWL_ERR(mvm, "PTP: Invalid command response\n");
+		iwl_free_resp(&cmd);
+		return -EIO;
+	}
+
+	resp = (void *)pkt->data;
+
+	gp2_10ns = (u64)le32_to_cpu(resp->gp2_timestamp_hi) << 32 |
+		le32_to_cpu(resp->gp2_timestamp_lo);
+	*gp2 = gp2_10ns / 100;
+
+	*sys_time = (u64)le32_to_cpu(resp->platform_timestamp_hi) << 32 |
+		le32_to_cpu(resp->platform_timestamp_lo);
+
+	return ret;
+}
+
 static int
 iwl_mvm_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
 			       struct system_device_crosststamp *xtstamp)
 {
 	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
 					   ptp_data.ptp_clock_info);
+	int ret = 0;
 	/* Raw value read from GP2 register in usec */
 	u32 gp2;
 	/* GP2 value in ns*/
@@ -43,7 +85,16 @@ iwl_mvm_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
 		return -ENODEV;
 	}
 
-	iwl_mvm_get_sync_time(mvm, CLOCK_REALTIME, &gp2, NULL, &sys_time);
+	mutex_lock(&mvm->mutex);
+	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SYNCED_TIME)) {
+		ret = iwl_mvm_get_crosstimestamp_fw(mvm, &gp2, &sys_time);
+
+		if (ret)
+			goto out;
+	} else {
+		iwl_mvm_get_sync_time(mvm, CLOCK_REALTIME, &gp2, NULL,
+				      &sys_time);
+	}
 
 	iwl_mvm_ptp_update_new_read(mvm, gp2);
 
@@ -57,7 +108,9 @@ iwl_mvm_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
 	xtstamp->device = (ktime_t)gp2_ns;
 	xtstamp->sys_realtime = sys_time;
 
-	return 0;
+out:
+	mutex_unlock(&mvm->mutex);
+	return ret;
 }
 
 static void iwl_mvm_ptp_work(struct work_struct *wk)
-- 
2.38.1

