Return-Path: <linux-wireless+bounces-26645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5AEB36F4F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E42986AA0
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190E34AAFE;
	Tue, 26 Aug 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoOLu8RT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FA30BBAA
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223751; cv=none; b=PE3/7X07syxyvXXx7PUM6MPi3TxafdyUpXBwO+H5CGVQ9bbg1FOX5sfNUueTQu9FAOegJUcXxJ0MCtjN9mtxb82a4lh6Ct5C58MJnXVfR4+nTtH7Co8PEon2ViHygbdUBXMFXdvHweR3/US4a03zl6HIdWxWCiBejX0MNEZm2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223751; c=relaxed/simple;
	bh=RGnHW0iHIrmlitaOZaIGB7UwpA7zfMSkGYRR9tcbqwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MeE4+nPNrqJPjpPwRJnzlXNg8AZoh9Y3HE1c8Kar7aOd0XTJGyZW3n43oIKsi6jctJCcSll1zVhUGi7qq7BZLtMslVhUkhvQ0B0ciUDGM8tzOLZyJjbJnzEfcBehWu8NciYThwm4UKdJzew0UQdfmM7LubDRWmeLtPJuiJM4u2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoOLu8RT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223749; x=1787759749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGnHW0iHIrmlitaOZaIGB7UwpA7zfMSkGYRR9tcbqwY=;
  b=hoOLu8RTHx7bST+9IxYKXQhMpT/D7c0ItHxIeDHA0Q7/jYzudeNGq2Di
   tZcUEUBip1dmVxQYsQaL5xB9AavLPScUkSxMrs2N8CdxWtawYYcHEDRsp
   a/jWTx8FdwdQSn5X4JabfKS+GaEBMaBzQLfUgZjDVif4dTGskKHOlAS+r
   sPuNKvzATA4jmi24EtGzW3DnEQOPJiuU+gZplXsDKMvhfOK0+jOX67G6g
   4oQOfDxTPN3FaaS3+BV+C/ac5JJSId2SwdbR1ayAb+biv2LQQ1qQ9RFOK
   79mO6jP0a9sG/0fqh1tl19TT9OUQQjHn5A4yZHupp4j/y4hjxt3K0oROX
   Q==;
X-CSE-ConnectionGUID: 8yk5pRa+SLqN6MOoCca0Jg==
X-CSE-MsgGUID: +FzEC84qQUe1l32xQjk3cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108423"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108423"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:40 -0700
X-CSE-ConnectionGUID: fN/N0OMgRZKgcb9VkomOHg==
X-CSE-MsgGUID: NJrAU+aWTqK6lyIr0Sx3Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218269"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: add a new FW file numbering scheme
Date: Tue, 26 Aug 2025 18:54:56 +0300
Message-Id: <20250826184046.7bba17bf200b.I33044cf6d97c623c47f765ea467635f01fc88731@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Firmware releases follow a "Core N" pattern, but due to some
historical accidents, the API number for a Core N has always
been N+3. That's confusing for everyone.

For future firmware releases the firmware will make new file
names that, instead of being named with the API number, will
be named with the core number. For example, for the next one
for bz/fm it'd be "iwlwifi-bz-b0-fm-c0-c99.ucode" instead of
the now expected "iwlwifi-bz-b0-fm-c0-102.ucode".

In the driver, represent that as an offset of 1000, and then
request the "c<core>" format instead of just "<api>". When
looking for older versions, skip from 1099 to 101 (which is
core 98.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 16 ++++----
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   | 11 ++---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 16 ++++----
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 39 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 41 ++++++++++++++-----
 5 files changed, 85 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 0acf52064132..3e6206e739f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -9,8 +9,8 @@
 #include "iwl-prph.h"
 #include "fw/api/txq.h"
 
-/* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	102
+/* Highest firmware core release supported */
+#define IWL_BZ_UCODE_CORE_MAX	99
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	100
@@ -75,7 +75,7 @@ static const struct iwl_family_base_params iwl_bz_base = {
 		},
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.ucode_api_max = IWL_BZ_UCODE_API_MAX,
+	.ucode_api_max = ENCODE_CORE_AS_API(IWL_BZ_UCODE_CORE_MAX),
 	.ucode_api_min = IWL_BZ_UCODE_API_MIN,
 };
 
@@ -101,8 +101,8 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.low_latency_xtal = true,
 };
 
-IWL_FW_AND_PNVM(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_API_MAX);
+IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 3c8fa8aa78ca..e53a785686c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -8,8 +8,8 @@
 #include "iwl-prph.h"
 #include "fw/api/txq.h"
 
-/* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	102
+/* Highest firmware core release supported */
+#define IWL_DR_UCODE_CORE_MAX	99
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	100
@@ -20,9 +20,6 @@
 
 #define IWL_DR_A_PE_A_FW_PRE		"iwlwifi-dr-a0-pe-a0"
 
-#define IWL_DR_A_PE_A_FW_MODULE_FIRMWARE(api) \
-	IWL_DR_A_PE_A_FW_PRE "-" __stringify(api) ".ucode"
-
 static const struct iwl_family_base_params iwl_dr_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -73,7 +70,7 @@ static const struct iwl_family_base_params iwl_dr_base = {
 		},
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.ucode_api_max = IWL_DR_UCODE_API_MAX,
+	.ucode_api_max = ENCODE_CORE_AS_API(IWL_DR_UCODE_CORE_MAX),
 	.ucode_api_min = IWL_DR_UCODE_API_MIN,
 };
 
@@ -89,5 +86,5 @@ const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-MODULE_FIRMWARE(IWL_DR_A_PE_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
+IWL_CORE_FW(IWL_DR_A_PE_A_FW_PRE, IWL_DR_UCODE_CORE_MAX);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index ee1dc27362c5..e9449b59114a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -9,8 +9,8 @@
 #include "iwl-prph.h"
 #include "fw/api/txq.h"
 
-/* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	102
+/* Highest firmware core release supported */
+#define IWL_SC_UCODE_CORE_MAX	99
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	100
@@ -78,7 +78,7 @@ static const struct iwl_family_base_params iwl_sc_base = {
 		},
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.ucode_api_max = IWL_SC_UCODE_API_MAX,
+	.ucode_api_max = ENCODE_CORE_AS_API(IWL_SC_UCODE_CORE_MAX),
 	.ucode_api_min = IWL_SC_UCODE_API_MIN,
 };
 
@@ -94,8 +94,8 @@ const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC2_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC2_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_CORE_FW(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_SC_A_WH_A_FW_PRE, IWL_SC_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_SC2_A_FM_C_FW_PRE, IWL_SC_UCODE_CORE_MAX);
+IWL_CORE_FW(IWL_SC2_A_WH_A_FW_PRE, IWL_SC_UCODE_CORE_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 30e5f5a5cd89..d27c9ec151f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -107,6 +107,9 @@ enum iwl_nvm_type {
 	MODULE_FIRMWARE(pfx "-" __stringify(api) ".ucode");	\
 	MODULE_FIRMWARE(pfx ".pnvm")
 
+#define IWL_CORE_FW(pfx, core)					\
+	MODULE_FIRMWARE(pfx "-c" __stringify(core) ".ucode")
+
 static inline u8 num_of_ant(u8 mask)
 {
 	return  !!((mask) & ANT_A) +
@@ -192,8 +195,8 @@ struct iwl_family_base_params {
 
 	u8 max_ll_items;
 	u8 led_compensation;
-	u8 ucode_api_max;
-	u8 ucode_api_min;
+	u16 ucode_api_max;
+	u16 ucode_api_min;
 	u32 mac_addr_from_csr:10;
 	u8 nvm_hw_section_num;
 	netdev_features_t features;
@@ -210,6 +213,34 @@ struct iwl_family_base_params {
 	const struct iwl_fw_mon_regs mon_dbgi_regs;
 };
 
+/*
+ * FW is released as "core N release", and we used to have a
+ * gap of 3 between the API version and core number. Now the
+ * reported API version will be 1000 + core and we encode it
+ * in the filename as "c<core>".
+ */
+#define API_IS_CORE_START		1000
+#define API_TO_CORE_OFFS		3
+#define ENCODE_CORE_AS_API(core)	(API_IS_CORE_START + (core))
+
+static inline bool iwl_api_is_core_number(int api)
+{
+	return api >= API_IS_CORE_START;
+}
+
+static inline int iwl_api_to_core(int api)
+{
+	if (iwl_api_is_core_number(api))
+		return api - API_IS_CORE_START;
+
+	return api - API_TO_CORE_OFFS;
+}
+
+#define FW_API_FMT			"%s%d"
+#define FW_API_ARG(n)						\
+	iwl_api_is_core_number(n) ? "c" : "",			\
+	iwl_api_is_core_number(n) ? (n) - API_IS_CORE_START : (n)
+
 /*
  * @stbc: support Tx STBC and 1*SS Rx STBC
  * @ldpc: support Tx/Rx with LDPC
@@ -422,8 +453,8 @@ struct iwl_rf_cfg {
 	u8 valid_tx_ant;
 	u8 valid_rx_ant;
 	u8 non_shared_ant;
-	u8 ucode_api_max;
-	u8 ucode_api_min;
+	u16 ucode_api_max;
+	u16 ucode_api_min;
 	u16 num_rbds;
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 28aad975434b..6045a7915b91 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -341,6 +341,8 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 
 	if (first)
 		drv->fw_index = ucode_api_max;
+	else if (drv->fw_index == ENCODE_CORE_AS_API(99))
+		drv->fw_index = 101; /* last API-scheme number below core 99 */
 	else
 		drv->fw_index--;
 
@@ -348,13 +350,15 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		IWL_ERR(drv, "no suitable firmware found!\n");
 
 		if (ucode_api_min == ucode_api_max) {
-			IWL_ERR(drv, "%s-%d is required\n", fw_name_pre,
-				ucode_api_max);
+			IWL_ERR(drv, "%s-" FW_API_FMT " is required\n",
+				fw_name_pre, FW_API_ARG(ucode_api_max));
 		} else {
-			IWL_ERR(drv, "minimum version required: %s-%d\n",
-				fw_name_pre, ucode_api_min);
-			IWL_ERR(drv, "maximum version supported: %s-%d\n",
-				fw_name_pre, ucode_api_max);
+			IWL_ERR(drv,
+				"minimum version required: %s-" FW_API_FMT "\n",
+				fw_name_pre, FW_API_ARG(ucode_api_min));
+			IWL_ERR(drv,
+				"maximum version supported: %s-" FW_API_FMT "\n",
+				fw_name_pre, FW_API_ARG(ucode_api_max));
 		}
 
 		IWL_ERR(drv,
@@ -362,8 +366,9 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		return -ENOENT;
 	}
 
-	snprintf(drv->firmware_name, sizeof(drv->firmware_name), "%s-%d.ucode",
-		 fw_name_pre, drv->fw_index);
+	snprintf(drv->firmware_name, sizeof(drv->firmware_name),
+		 "%s-" FW_API_FMT ".ucode",
+		 fw_name_pre, FW_API_ARG(drv->fw_index));
 
 	IWL_DEBUG_FW_INFO(drv, "attempting to load firmware '%s'\n",
 			  drv->firmware_name);
@@ -1588,6 +1593,7 @@ static void _iwl_op_mode_stop(struct iwl_drv *drv)
  */
 static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 {
+	unsigned int min_core, max_core, loaded_core;
 	struct iwl_drv *drv = context;
 	struct iwl_fw *fw = &drv->fw;
 	const struct iwl_ucode_header *ucode;
@@ -1650,11 +1656,24 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	 * firmware filename ... but we don't check for that and only rely
 	 * on the API version read from firmware header from here on forward
 	 */
-	if (api_ver < api_min || api_ver > api_max) {
+
+	/*
+	 * if -cN.ucode file was loaded, core version == file version,
+	 * otherwise core version == file version (API version) - 3
+	 */
+	if (iwl_api_is_core_number(drv->fw_index))
+		loaded_core = api_ver;
+	else
+		loaded_core = api_ver - API_TO_CORE_OFFS;
+
+	min_core = iwl_api_to_core(api_min);
+	max_core = iwl_api_to_core(api_max);
+
+	if (loaded_core < min_core || loaded_core > max_core) {
 		IWL_ERR(drv,
 			"Driver unable to support your firmware API. "
-			"Driver supports v%u, firmware is v%u.\n",
-			api_max, api_ver);
+			"Driver supports FW core %u..%u, firmware is %u.\n",
+			min_core, max_core, loaded_core);
 		goto try_again;
 	}
 
-- 
2.34.1


