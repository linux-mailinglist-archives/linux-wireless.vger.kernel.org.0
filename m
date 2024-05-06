Return-Path: <linux-wireless+bounces-7205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E716B8BC805
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1CAB213E9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A70481B1;
	Mon,  6 May 2024 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDUfPf1l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B573250263
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979097; cv=none; b=UGkJJTXyFR8MSIVolYNqLOf8WeYJFfT1L6GhjOqj8YGoCWglo2dIC/XciEArBwYInIfr2WtMFEMex3sfnFprLHGuMW435+FS7qpnd6aBPPAzxpBnECL2YCnRKQrjQmHHLt6xno0bT/NjiTR1n2rmRGzZ3E0u1hZc5ek9tJocflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979097; c=relaxed/simple;
	bh=MUQSYQ+lgbOX9qrW52+esnLzPIqOBRUE+0QDq/uu/38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQlpmhawE2gnADwHDzDFq1LFk8n700rOP/Xs6V04Z6aTLHa9uiaH2UveR1jWmtScGi29qByebFgJpoDu0JMS6nunlK5zdy6JBYgntOLKtgK1RudRYs4DD4Lf7aqzzcl0i2b3V3q3OCi1VECVOD8Sh7LH6Q0Ftoc8oLHrZtCRyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDUfPf1l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979096; x=1746515096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUQSYQ+lgbOX9qrW52+esnLzPIqOBRUE+0QDq/uu/38=;
  b=iDUfPf1lH/02t23xbTmJCCSoQZgZs3WeGsZ78asb3NcpmKwJXHU1j5nB
   +JgA7NJIyEtllawhhs+OL9Wx6b1S2ACFTv30dwtFl5Edw5o0h/Kty/9D2
   vlqmSRAsDVpyBfBW3DhWttRp0XI7qYpLb7jlPVtsDLJZUjxl5xNkDqCDg
   AUG5z0kUuFuQIn2KOhC8J7ElN6iUEqs/CPvsjk0E2+0rexanhBfqgD44H
   euTzGUbrwBYvHY2mrlW0WFa7V9w7h6/jnKjz4B87OzPIpj6LkE9tMZAx0
   lUKCvjnaV1to8pKAaoSlqixO4RyCjQKRnC8wSfsmVWlCltRWmy3H1+J/F
   A==;
X-CSE-ConnectionGUID: Qx6viz+RSCC6VbLTa3KscQ==
X-CSE-MsgGUID: sIBSejUKSnqaF67G67MwhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638221"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638221"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:44 -0700
X-CSE-ConnectionGUID: /3oDjQb8Rp+BXAXlKT1G1g==
X-CSE-MsgGUID: QqPNvHXyQ5KZ/y+5yw29oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264931"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: add the firmware API for channel survey
Date: Mon,  6 May 2024 10:04:12 +0300
Message-Id: <20240506095953.1facde532676.I3864ac4bc0fecb7fd5136e85c07585ab7100234b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When requested, the firmware can return per-channel survey information
generally used for ACS (automatic channel selection). Add the API for
this, which consists of a flag and a new channel survey notification.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 33 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 93078f8cc08c..6684506f4fc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -13,6 +13,10 @@
  * enum iwl_scan_subcmd_ids - scan commands
  */
 enum iwl_scan_subcmd_ids {
+	/**
+	 * @CHANNEL_SURVEY_NOTIF: &struct iwl_umac_scan_channel_survey_notif
+	 */
+	CHANNEL_SURVEY_NOTIF = 0xFB,
 	/**
 	 * @OFFLOAD_MATCH_INFO_NOTIF: &struct iwl_scan_offload_match_info
 	 */
@@ -62,6 +66,8 @@ struct iwl_ssid_ie {
 #define IWL_FAST_SCHED_SCAN_ITERATIONS 3
 #define IWL_MAX_SCHED_SCAN_PLANS 2
 
+#define IWL_MAX_NUM_NOISE_RESULTS 22
+
 enum scan_framework_client {
 	SCAN_CLIENT_SCHED_SCAN		= BIT(0),
 	SCAN_CLIENT_NETDETECT		= BIT(1),
@@ -642,10 +648,13 @@ enum iwl_umac_scan_general_flags {
  *	notification per channel or not.
  * @IWL_UMAC_SCAN_GEN_FLAGS2_ALLOW_CHNL_REORDER: Whether to allow channel
  *	reorder optimization or not.
+ * @IWL_UMAC_SCAN_GEN_FLAGS2_COLLECT_CHANNEL_STATS: Enable channel statistics
+ *	collection when #IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE is set.
  */
 enum iwl_umac_scan_general_flags2 {
 	IWL_UMAC_SCAN_GEN_FLAGS2_NOTIF_PER_CHNL		= BIT(0),
 	IWL_UMAC_SCAN_GEN_FLAGS2_ALLOW_CHNL_REORDER	= BIT(1),
+	IWL_UMAC_SCAN_GEN_FLAGS2_COLLECT_CHANNEL_STATS	= BIT(3),
 };
 
 /**
@@ -1258,4 +1267,26 @@ struct iwl_umac_scan_iter_complete_notif {
 	struct iwl_scan_results_notif results[];
 } __packed; /* SCAN_ITER_COMPLETE_NTF_UMAC_API_S_VER_2 */
 
+/**
+ * struct iwl_umac_scan_channel_survey_notif - data for survey
+ * @channel: the channel scanned
+ * @band: band of channel
+ * @noise: noise floor measurements in negative dBm, invalid 0xff
+ * @reserved: for future use and alignment
+ * @active_time: time in ms the radio was turned on (on the channel)
+ * @busy_time: time in ms the channel was sensed busy, 0 for a clean channel
+ * @tx_time: time the radio spent transmitting data
+ * @rx_time: time the radio spent receiving data
+ */
+struct iwl_umac_scan_channel_survey_notif {
+	__le32 channel;
+	__le32 band;
+	u8 noise[IWL_MAX_NUM_NOISE_RESULTS];
+	u8 reserved[2];
+	__le32 active_time;
+	__le32 busy_time;
+	__le32 tx_time;
+	__le32 rx_time;
+} __packed; /* SCAN_CHANNEL_SURVEY_NTF_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_scan_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b27a03207938..c52e69743c80 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -651,6 +651,7 @@ static const struct iwl_hcmd_names iwl_mvm_statistics_names[] = {
  * Access is done through binary search
  */
 static const struct iwl_hcmd_names iwl_mvm_scan_names[] = {
+	HCMD_NAME(CHANNEL_SURVEY_NOTIF),
 	HCMD_NAME(OFFLOAD_MATCH_INFO_NOTIF),
 };
 
-- 
2.34.1


