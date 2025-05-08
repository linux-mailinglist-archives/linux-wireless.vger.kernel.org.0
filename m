Return-Path: <linux-wireless+bounces-22752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D720AAF983
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464A14C3FDB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6522576E;
	Thu,  8 May 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMIsS9U3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF2227EAF
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706425; cv=none; b=Xo/SQ8GNqa0QXxDoQhXmXE3fRIEkkJ3Gxnkff/77NcQDmfqZFd6XEzcQFyetzjDDpGvt+MBPKzzw1+Rs4Vs6M9OCsVVuukuIO3CVRJio0LS5HYka37cRf6leIhP9LaT3JzarHQE97TnHrjukCtoXHaDBfMJ0f31wPi3DYkWhpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706425; c=relaxed/simple;
	bh=4YimxMz0/eqAmbxV7tD7i05je6si6gblrF1kb/IYfos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJ6T1Hv+BmGHBtTFb1mqIDOG9Mgc0jpzy6Q9fRtWdGctPh3zBAebY3p51iyF4sbZ3J1p4eqiCymxXrrnTGXPbNDf3mO/1nu32GKV2ulurJL/xHwbc+DnMa8WLv018EZWVvcsWTWvs9Oce4ClWNz9mKJ4Eqt+DRC96zXfPhpZEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMIsS9U3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706422; x=1778242422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4YimxMz0/eqAmbxV7tD7i05je6si6gblrF1kb/IYfos=;
  b=HMIsS9U3MVUXKag3wJQiQTrmgk8N7llAWjqz+tuVGxUq5KAyW/oP/nz+
   YYnREpuDL2NFZnOuNzxQ/naMp78MpQwTzfIplak4T7DpfwRl92YmT2DzO
   l8l9Mv0bSlQfR7YUt4+sNzAgKkGZvZH7VkTR25/E2stLGcWuSEBAZ7xCd
   kWkoYiQlOlIyzANUYyx3aJk6CIrkrRQ5ooetkrirjuYiZ96CfHRnbPNc/
   XdWlLxvykeVzU9Sbt+uMcDKp5rDAxx8vec2o5wlAry9pU9dmfSwSyHx7g
   nycjih7l/tATYDAXmuYgA6B+kWlFX0a8kx3SdAxi4X7co5E6U6eN9KO8l
   A==;
X-CSE-ConnectionGUID: b1xIA91MRkGgRuniV1I7AQ==
X-CSE-MsgGUID: jx5xdw5+QfG44o1m0zye2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688056"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:42 -0700
X-CSE-ConnectionGUID: D9KyWzkDQmSuJdyPvqxFTQ==
X-CSE-MsgGUID: BIXY8ZzIRVK5BJEa0z2kIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347893"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: cfg: move MAC parameters to MAC data
Date: Thu,  8 May 2025 15:13:05 +0300
Message-Id: <20250508121306.1277801-15-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are a number of MAC parameters that are in the iwl_cfg
(which is the last config matched to the MAC/RF combination).
This isn't necessary, there are many more of those than MACs,
so move (most of) the data into the MAC family config struct.

Note that DCCM information remains for use by older devices,
and on 9000 series it'll be in struct iwl_cfg but be ignored
when the CRF is in a Qu/So platform.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.c053aa5fcb1f.I68e5d9d640a1827549c3052f66c441c606bb8d68@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  67 ++++++------
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  14 +--
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  60 +++++------
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  79 +++++++-------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 102 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  93 ++++++++--------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  82 +++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  31 +++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 100 +++++++++--------
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  12 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   4 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   8 +-
 30 files changed, 346 insertions(+), 351 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 273625e84676..42f2e2ede774 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -54,18 +54,43 @@ static const struct iwl_family_base_params iwl_22000_base = {
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
+	.smem_offset = IWL_22000_SMEM_OFFSET,
+	.smem_len = IWL_22000_SMEM_LEN,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.apmg_not_supported = true,
+	.mac_addr_from_csr = 0x380,
+	.min_umac_error_event_table = 0x400000,
+	.d3_debug_data_base_addr = 0x401000,
+	.d3_debug_data_length = 60 * 1024,
+	.mon_smem_regs = {
+		.write_ptr = {
+			.addr = LDBG_M2S_BUF_WPTR,
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,
+	},
+		.cycle_cnt = {
+			.addr = LDBG_M2S_BUF_WRAP_CNT,
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,
+		},
+	},
+	.gp2_reg_addr = 0xa02c68,
+	.mon_dram_regs = {
+		.write_ptr = {
+			.addr = MON_BUFF_WRPTR_VER2,
+			.mask = 0xffffffff,
+		},
+		.cycle_cnt = {
+			.addr = MON_BUFF_CYCLE_CNT_VER2,
+			.mask = 0xffffffff,
+		},
+	},
 };
 
-#define IWL_DEVICE_22000_COMMON						\
+#define IWL_DEVICE_22500						\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
+	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.smem_offset = IWL_22000_SMEM_OFFSET,				\
-	.smem_len = IWL_22000_SMEM_LEN,					\
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
-	.apmg_not_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = 0x380,					\
 	.ht_params = {							\
 		.stbc = true,						\
 		.ldpc = true,						\
@@ -73,35 +98,7 @@ static const struct iwl_family_base_params iwl_22000_base = {
 			      BIT(NL80211_BAND_5GHZ),			\
 	},								\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
-	.nvm_type = IWL_NVM_EXT,					\
-	.min_umac_error_event_table = 0x400000,				\
-	.d3_debug_data_base_addr = 0x401000,				\
-	.d3_debug_data_length = 60 * 1024,				\
-	.mon_smem_regs = {						\
-		.write_ptr = {						\
-			.addr = LDBG_M2S_BUF_WPTR,			\
-			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
-	},								\
-		.cycle_cnt = {						\
-			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
-			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
-		},							\
-	}
-
-#define IWL_DEVICE_22500						\
-	IWL_DEVICE_22000_COMMON,					\
-	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
-	.gp2_reg_addr = 0xa02c68,					\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = MON_BUFF_WRPTR_VER2,			\
-			.mask = 0xffffffff,				\
-		},							\
-		.cycle_cnt = {						\
-			.addr = MON_BUFF_CYCLE_CNT_VER2,		\
-			.mask = 0xffffffff,				\
-		},							\
-	}
+	.nvm_type = IWL_NVM_EXT
 
 const struct iwl_mac_cfg iwl_qu_mac_cfg = {
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index 6e4f6591000c..c2c8e81904f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -60,6 +60,7 @@ static const struct iwl_family_base_params iwl7000_base = {
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
 	.apmg_wake_up_wa = true,
+	.nvm_hw_section_num = 0,
 };
 
 static const struct iwl_tt_params iwl7000_high_temp_tt_params = {
@@ -91,7 +92,6 @@ const struct iwl_mac_cfg iwl7000_mac_cfg = {
 
 #define IWL_DEVICE_7000_COMMON					\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.nvm_hw_section_num = 0,				\
 	.non_shared_ant = ANT_A,				\
 	.dccm_offset = IWL7000_DCCM_OFFSET
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index f8448b1541f1..03a09920f258 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -45,6 +45,12 @@ static const struct iwl_family_base_params iwl8000_base = {
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
+	.nvm_hw_section_num = 10,
+	.features = NETIF_F_RXCSUM,
+	.smem_offset = IWL8260_SMEM_OFFSET,
+	.smem_len = IWL8260_SMEM_LEN,
+	.apmg_not_supported = true,
+	.min_umac_error_event_table = 0x800000,
 };
 
 static const struct iwl_tt_params iwl8000_tt_params = {
@@ -75,19 +81,13 @@ const struct iwl_mac_cfg iwl8000_mac_cfg = {
 
 #define IWL_DEVICE_8000_COMMON						\
 	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
-	.features = NETIF_F_RXCSUM,					\
 	.non_shared_ant = ANT_A,					\
 	.dccm_offset = IWL8260_DCCM_OFFSET,				\
 	.dccm_len = IWL8260_DCCM_LEN,					\
 	.dccm2_offset = IWL8260_DCCM2_OFFSET,				\
 	.dccm2_len = IWL8260_DCCM2_LEN,					\
-	.smem_offset = IWL8260_SMEM_OFFSET,				\
-	.smem_len = IWL8260_SMEM_LEN,					\
 	.thermal_params = &iwl8000_tt_params,				\
-	.apmg_not_supported = true,					\
-	.nvm_type = IWL_NVM_EXT,					\
-	.min_umac_error_event_table = 0x800000
+	.nvm_type = IWL_NVM_EXT
 
 #define IWL_DEVICE_8260							\
 	IWL_DEVICE_8000_COMMON,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 15620d15a10e..bc497abd07c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -43,6 +43,35 @@ static const struct iwl_family_base_params iwl9000_base = {
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
+	.smem_offset = IWL9000_SMEM_OFFSET,
+	.smem_len = IWL9000_SMEM_LEN,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.apmg_not_supported = true,
+	.mac_addr_from_csr = 0x380,
+	.min_umac_error_event_table = 0x800000,
+	.d3_debug_data_base_addr = 0x401000,
+	.d3_debug_data_length = 92 * 1024,
+	.nvm_hw_section_num = 10,
+	.mon_smem_regs = {
+		.write_ptr = {
+			.addr = LDBG_M2S_BUF_WPTR,
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,
+		},
+		.cycle_cnt = {
+			.addr = LDBG_M2S_BUF_WRAP_CNT,
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,
+		},
+	},
+	.mon_dram_regs = {
+		.write_ptr = {
+			.addr = MON_BUFF_WRPTR_VER2,
+			.mask = 0xffffffff,
+		},
+		.cycle_cnt = {
+			.addr = MON_BUFF_CYCLE_CNT_VER2,
+			.mask = 0xffffffff,
+		},
+	},
 };
 
 static const struct iwl_tt_params iwl9000_tt_params = {
@@ -70,51 +99,22 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.ucode_api_max = IWL9000_UCODE_API_MAX,				\
 	.ucode_api_min = IWL9000_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL9000_DCCM_OFFSET,				\
 	.dccm_len = IWL9000_DCCM_LEN,					\
 	.dccm2_offset = IWL9000_DCCM2_OFFSET,				\
 	.dccm2_len = IWL9000_DCCM2_LEN,					\
-	.smem_offset = IWL9000_SMEM_OFFSET,				\
-	.smem_len = IWL9000_SMEM_LEN,					\
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.thermal_params = &iwl9000_tt_params,				\
-	.apmg_not_supported = true,					\
 	.num_rbds = 512,						\
 	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = 0x380,					\
 	.nvm_type = IWL_NVM_EXT,					\
-	.min_umac_error_event_table = 0x800000,				\
-	.d3_debug_data_base_addr = 0x401000,				\
-	.d3_debug_data_length = 92 * 1024,				\
 	.ht_params = {							\
 		.stbc = true,						\
 		.ldpc = true,						\
 		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
 			      BIT(NL80211_BAND_5GHZ),			\
 	},								\
-	.nvm_ver = IWL9000_NVM_VERSION,					\
-	.mon_smem_regs = {						\
-		.write_ptr = {						\
-			.addr = LDBG_M2S_BUF_WPTR,			\
-			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
-		},							\
-		.cycle_cnt = {						\
-			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
-			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
-		},							\
-	},								\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = MON_BUFF_WRPTR_VER2,			\
-			.mask = 0xffffffff,				\
-		},							\
-		.cycle_cnt = {						\
-			.addr = MON_BUFF_CYCLE_CNT_VER2,		\
-			.mask = 0xffffffff,				\
-		},							\
-	}
+	.nvm_ver = IWL9000_NVM_VERSION
 
 const struct iwl_mac_cfg iwl9000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 82b127ffb537..748c1f1f73a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -52,18 +52,49 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
+	.smem_offset = IWL_AX210_SMEM_OFFSET,
+	.smem_len = IWL_AX210_SMEM_LEN,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.apmg_not_supported = true,
+	.mac_addr_from_csr = 0x380,
+	.min_umac_error_event_table = 0x400000,
+	.d3_debug_data_base_addr = 0x401000,
+	.d3_debug_data_length = 60 * 1024,
+	.mon_smem_regs = {
+		.write_ptr = {
+			.addr = LDBG_M2S_BUF_WPTR,
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,
+		},
+		.cycle_cnt = {
+			.addr = LDBG_M2S_BUF_WRAP_CNT,
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,
+		},
+	},
+	.min_txq_size = 128,
+	.gp2_reg_addr = 0xd02c68,
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_HE,
+	.mon_dram_regs = {
+		.write_ptr = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,
+		},
+		.cycle_cnt = {
+			.addr = DBGC_DBGBUF_WRAP_AROUND,
+			.mask = 0xffffffff,
+		},
+		.cur_frag = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,
+		},
+	},
 };
 
-#define IWL_DEVICE_AX210_COMMON						\
+#define IWL_DEVICE_AX210						\
 	.ucode_api_min = IWL_AX210_UCODE_API_MIN,			\
+	.ucode_api_max = IWL_AX210_UCODE_API_MAX,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.smem_offset = IWL_AX210_SMEM_OFFSET,				\
-	.smem_len = IWL_AX210_SMEM_LEN,					\
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
-	.apmg_not_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = 0x380,					\
 	.ht_params = {							\
 		.stbc = true,						\
 		.ldpc = true,						\
@@ -71,41 +102,7 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 			      BIT(NL80211_BAND_5GHZ),			\
 	},								\
 	.nvm_ver = IWL_AX210_NVM_VERSION,				\
-	.nvm_type = IWL_NVM_EXT,					\
-	.min_umac_error_event_table = 0x400000,				\
-	.d3_debug_data_base_addr = 0x401000,				\
-	.d3_debug_data_length = 60 * 1024,				\
-	.mon_smem_regs = {						\
-		.write_ptr = {						\
-			.addr = LDBG_M2S_BUF_WPTR,			\
-			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
-	},								\
-		.cycle_cnt = {						\
-			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
-			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
-		},							\
-	}
-
-#define IWL_DEVICE_AX210						\
-	IWL_DEVICE_AX210_COMMON,					\
-	.ucode_api_max = IWL_AX210_UCODE_API_MAX,			\
-	.min_txq_size = 128,						\
-	.gp2_reg_addr = 0xd02c68,					\
-	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_HE,		\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
-		},							\
-		.cycle_cnt = {						\
-			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
-			.mask = 0xffffffff,				\
-		},							\
-		.cur_frag = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
-		},							\
-	}
+	.nvm_type = IWL_NVM_EXT
 
 const struct iwl_mac_cfg iwl_so_mac_cfg = {
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 8d6a042c9c64..3c632b8c7650 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -48,65 +48,63 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
+	.smem_offset = IWL_BZ_SMEM_OFFSET,
+	.smem_len = IWL_BZ_SMEM_LEN,
+	.apmg_not_supported = true,
+	.mac_addr_from_csr = 0x30,
+	.min_umac_error_event_table = 0xD0000,
+	.d3_debug_data_base_addr = 0x401000,
+	.d3_debug_data_length = 60 * 1024,
+	.mon_smem_regs = {
+		.write_ptr = {
+			.addr = LDBG_M2S_BUF_WPTR,
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,
+	},
+		.cycle_cnt = {
+			.addr = LDBG_M2S_BUF_WRAP_CNT,
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,
+		},
+	},
+	.min_txq_size = 128,
+	.gp2_reg_addr = 0xd02c68,
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,
+	.mon_dram_regs = {
+		.write_ptr = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,
+		},
+		.cycle_cnt = {
+			.addr = DBGC_DBGBUF_WRAP_AROUND,
+			.mask = 0xffffffff,
+		},
+		.cur_frag = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,
+		},
+	},
+	.mon_dbgi_regs = {
+		.write_ptr = {
+			.addr = DBGI_SRAM_FIFO_POINTERS,
+			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,
+		},
+	},
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 };
 
-#define IWL_DEVICE_BZ_COMMON						\
-	.ucode_api_max = IWL_BZ_UCODE_API_MAX,			\
-	.ucode_api_min = IWL_BZ_UCODE_API_MIN,			\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.non_shared_ant = ANT_B,					\
-	.smem_offset = IWL_BZ_SMEM_OFFSET,				\
-	.smem_len = IWL_BZ_SMEM_LEN,					\
-	.apmg_not_supported = true,					\
-	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = 0x30,					\
-	.nvm_ver = IWL_BZ_NVM_VERSION,				\
-	.nvm_type = IWL_NVM_EXT,					\
-	.min_umac_error_event_table = 0xD0000,				\
-	.d3_debug_data_base_addr = 0x401000,				\
-	.d3_debug_data_length = 60 * 1024,				\
-	.mon_smem_regs = {						\
-		.write_ptr = {						\
-			.addr = LDBG_M2S_BUF_WPTR,			\
-			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
-	},								\
-		.cycle_cnt = {						\
-			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
-			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
-		},							\
-	},								\
-	.min_txq_size = 128,						\
-	.gp2_reg_addr = 0xd02c68,					\
-	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
-		},							\
-		.cycle_cnt = {						\
-			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
-			.mask = 0xffffffff,				\
-		},							\
-		.cur_frag = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
-		},							\
-	},								\
-	.mon_dbgi_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGI_SRAM_FIFO_POINTERS,		\
-			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
-		},							\
-	}
-
 #define IWL_DEVICE_BZ							\
-	IWL_DEVICE_BZ_COMMON,						\
+	.ucode_api_max = IWL_BZ_UCODE_API_MAX,				\
+	.ucode_api_min = IWL_BZ_UCODE_API_MIN,				\
 	.ht_params = {							\
 		.stbc = true,						\
 		.ldpc = true,						\
 		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
 			      BIT(NL80211_BAND_5GHZ),			\
-	}
+	},								\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.non_shared_ant = ANT_B,					\
+	.vht_mu_mimo_supported = true,					\
+	.nvm_ver = IWL_BZ_NVM_VERSION,					\
+	.nvm_type = IWL_NVM_EXT
 
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
@@ -144,14 +142,12 @@ const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 const struct iwl_cfg iwl_cfg_bz = {
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
 const struct iwl_cfg iwl_cfg_bz_160mhz = {
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 	.bw_limit = 160,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 2d571ffe9588..d7f0797c3231 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -41,61 +41,58 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
+	.smem_offset = IWL_DR_SMEM_OFFSET,
+	.smem_len = IWL_DR_SMEM_LEN,
+	.apmg_not_supported = true,
+	.mac_addr_from_csr = 0x30,
+	.min_umac_error_event_table = 0xD0000,
+	.d3_debug_data_base_addr = 0x401000,
+	.d3_debug_data_length = 60 * 1024,
+	.mon_smem_regs = {
+		.write_ptr = {
+			.addr = LDBG_M2S_BUF_WPTR,
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,
+		},
+		.cycle_cnt = {
+			.addr = LDBG_M2S_BUF_WRAP_CNT,
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,
+		},
+	},
+	.min_txq_size = 128,
+	.gp2_reg_addr = 0xd02c68,
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,
+	.mon_dram_regs = {
+		.write_ptr = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,
+		},
+		.cycle_cnt = {
+			.addr = DBGC_DBGBUF_WRAP_AROUND,
+			.mask = 0xffffffff,
+		},
+		.cur_frag = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,
+		},
+	},
+	.mon_dbgi_regs = {
+		.write_ptr = {
+			.addr = DBGI_SRAM_FIFO_POINTERS,
+			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,
+		},
+	},
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 };
 
-#define IWL_DEVICE_DR_COMMON						\
-	.ucode_api_max = IWL_DR_UCODE_API_MAX,			\
-	.ucode_api_min = IWL_DR_UCODE_API_MIN,			\
+#define IWL_DEVICE_DR							\
+	.ucode_api_max = IWL_DR_UCODE_API_MAX,				\
+	.ucode_api_min = IWL_DR_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.smem_offset = IWL_DR_SMEM_OFFSET,				\
-	.smem_len = IWL_DR_SMEM_LEN,					\
-	.apmg_not_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = 0x30,					\
-	.nvm_ver = IWL_DR_NVM_VERSION,				\
+	.nvm_ver = IWL_DR_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT,					\
-	.min_umac_error_event_table = 0xD0000,				\
-	.d3_debug_data_base_addr = 0x401000,				\
-	.d3_debug_data_length = 60 * 1024,				\
-	.mon_smem_regs = {						\
-		.write_ptr = {						\
-			.addr = LDBG_M2S_BUF_WPTR,			\
-			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
-	},								\
-		.cycle_cnt = {						\
-			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
-			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
-		},							\
-	},								\
-	.min_txq_size = 128,						\
-	.gp2_reg_addr = 0xd02c68,					\
-	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
-		},							\
-		.cycle_cnt = {						\
-			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
-			.mask = 0xffffffff,				\
-		},							\
-		.cur_frag = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
-		},							\
-	},								\
-	.mon_dbgi_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGI_SRAM_FIFO_POINTERS,		\
-			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
-		},							\
-	}
-
-#define IWL_DEVICE_DR							\
-	IWL_DEVICE_DR_COMMON,						\
 	.uhb_supported = true,						\
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.num_rbds = IWL_NUM_RBDS_DR_EHT,				\
 	.ht_params = {							\
 		.stbc = true,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index cdd859b93356..e9a94d4c7d4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -48,6 +48,47 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
 	.pcie_l1_allowed = true,
+	.smem_offset = IWL_SC_SMEM_OFFSET,
+	.smem_len = IWL_SC_SMEM_LEN,
+	.apmg_not_supported = true,
+	.mac_addr_from_csr = 0x30,
+	.min_umac_error_event_table = 0xD0000,
+	.d3_debug_data_base_addr = 0x401000,
+	.d3_debug_data_length = 60 * 1024,
+	.mon_smem_regs = {
+		.write_ptr = {
+			.addr = LDBG_M2S_BUF_WPTR,
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,
+		},
+		.cycle_cnt = {
+			.addr = LDBG_M2S_BUF_WRAP_CNT,
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,
+		},
+	},
+	.min_txq_size = 128,
+	.gp2_reg_addr = 0xd02c68,
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,
+	.mon_dram_regs = {
+		.write_ptr = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,
+		},
+		.cycle_cnt = {
+			.addr = DBGC_DBGBUF_WRAP_AROUND,
+			.mask = 0xffffffff,
+		},
+		.cur_frag = {
+			.addr = DBGC_CUR_DBGBUF_STATUS,
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,
+		},
+	},
+	.mon_dbgi_regs = {
+		.write_ptr = {
+			.addr = DBGI_SRAM_FIFO_POINTERS,
+			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,
+		},
+	},
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 };
 
 #define IWL_DEVICE_SC							\
@@ -55,51 +96,10 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.ucode_api_min = IWL_SC_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
-	.smem_offset = IWL_SC_SMEM_OFFSET,				\
-	.smem_len = IWL_SC_SMEM_LEN,					\
-	.apmg_not_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = 0x30,					\
 	.nvm_ver = IWL_SC_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT,					\
-	.min_umac_error_event_table = 0xD0000,				\
-	.d3_debug_data_base_addr = 0x401000,				\
-	.d3_debug_data_length = 60 * 1024,				\
-	.mon_smem_regs = {						\
-		.write_ptr = {						\
-			.addr = LDBG_M2S_BUF_WPTR,			\
-			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
-	},								\
-		.cycle_cnt = {						\
-			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
-			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
-		},							\
-	},								\
-	.min_txq_size = 128,						\
-	.gp2_reg_addr = 0xd02c68,					\
-	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
-		},							\
-		.cycle_cnt = {						\
-			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
-			.mask = 0xffffffff,				\
-		},							\
-		.cur_frag = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
-		},							\
-	},								\
-	.mon_dbgi_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGI_SRAM_FIFO_POINTERS,		\
-			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
-		},							\
-	},								\
 	.uhb_supported = true,						\
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.num_rbds = IWL_NUM_RBDS_SC_EHT,				\
 	.ht_params = {							\
 		.stbc = true,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index dbe09bd464cf..6ba0bcbcd56b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -809,13 +809,14 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 	const struct iwl_fw_dbg_mem_seg_tlv *fw_mem = fwrt->fw->dbg.mem_tlv;
 	struct iwl_fwrt_shared_mem_cfg *mem_cfg = &fwrt->smem_cfg;
 	u32 file_len, fifo_len = 0, prph_len = 0, radio_len = 0;
-	u32 smem_len = fwrt->fw->dbg.n_mem_tlv ? 0 : fwrt->trans->cfg->smem_len;
+	u32 smem_len = fwrt->fw->dbg.n_mem_tlv ? 0 : fwrt->trans->mac_cfg->base->smem_len;
 	u32 sram2_len = fwrt->fw->dbg.n_mem_tlv ?
 				0 : fwrt->trans->cfg->dccm2_len;
 	int i;
 
 	/* SRAM - include stack CCM if driver knows the values for it */
-	if (!fwrt->trans->cfg->dccm_offset || !fwrt->trans->cfg->dccm_len) {
+	if (!fwrt->trans->cfg->dccm_offset ||
+	    !fwrt->trans->cfg->dccm_len) {
 		const struct fw_img *img;
 
 		if (fwrt->cur_fw_img >= IWL_UCODE_TYPE_MAX)
@@ -876,7 +877,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 
 	if (iwl_fw_dbg_is_d3_debug_enabled(fwrt) && fwrt->dump.d3_debug_data) {
 		file_len += sizeof(*dump_data) +
-			fwrt->trans->cfg->d3_debug_data_length * 2;
+			fwrt->trans->mac_cfg->base->d3_debug_data_length * 2;
 	}
 
 	/* If we only want a monitor dump, reset the file length */
@@ -997,7 +998,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 		}
 
 		iwl_fw_dump_mem(fwrt, &dump_data, smem_len,
-				fwrt->trans->cfg->smem_offset,
+				fwrt->trans->mac_cfg->base->smem_offset,
 				IWL_FW_ERROR_DUMP_MEM_SMEM);
 
 		iwl_fw_dump_mem(fwrt, &dump_data, sram2_len,
@@ -1006,8 +1007,8 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 	}
 
 	if (iwl_fw_dbg_is_d3_debug_enabled(fwrt) && fwrt->dump.d3_debug_data) {
-		u32 addr = fwrt->trans->cfg->d3_debug_data_base_addr;
-		size_t data_size = fwrt->trans->cfg->d3_debug_data_length;
+		u32 addr = fwrt->trans->mac_cfg->base->d3_debug_data_base_addr;
+		size_t data_size = fwrt->trans->mac_cfg->base->d3_debug_data_length;
 
 		dump_data->type = cpu_to_le32(IWL_FW_ERROR_DUMP_D3_DEBUG_DATA);
 		dump_data->len = cpu_to_le32(data_size * 2);
@@ -1818,7 +1819,7 @@ iwl_dump_ini_mon_dram_fill_header(struct iwl_fw_runtime *fwrt,
 	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
 
 	return iwl_dump_ini_mon_fill_header(fwrt, alloc_id, mon_dump,
-					    &fwrt->trans->cfg->mon_dram_regs);
+					    &fwrt->trans->mac_cfg->base->mon_dram_regs);
 }
 
 static void *
@@ -1831,7 +1832,7 @@ iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
 	u32 alloc_id = le32_to_cpu(reg->internal_buffer.alloc_id);
 
 	return iwl_dump_ini_mon_fill_header(fwrt, alloc_id, mon_dump,
-					    &fwrt->trans->cfg->mon_smem_regs);
+					    &fwrt->trans->mac_cfg->base->mon_smem_regs);
 }
 
 static void *
@@ -1845,7 +1846,7 @@ iwl_dump_ini_mon_dbgi_fill_header(struct iwl_fw_runtime *fwrt,
 					    /* no offset calculation later */
 					    IWL_FW_INI_ALLOCATION_ID_DBGC1,
 					    mon_dump,
-					    &fwrt->trans->cfg->mon_dbgi_regs);
+					    &fwrt->trans->mac_cfg->base->mon_dbgi_regs);
 }
 
 static void *
@@ -3283,13 +3284,13 @@ void iwl_fw_error_dump_wk(struct work_struct *work)
 
 void iwl_fw_dbg_read_d3_debug_data(struct iwl_fw_runtime *fwrt)
 {
-	const struct iwl_cfg *cfg = fwrt->trans->cfg;
+	const struct iwl_mac_cfg *mac_cfg = fwrt->trans->mac_cfg;
 
 	if (!iwl_fw_dbg_is_d3_debug_enabled(fwrt))
 		return;
 
 	if (!fwrt->dump.d3_debug_data) {
-		fwrt->dump.d3_debug_data = kmalloc(cfg->d3_debug_data_length,
+		fwrt->dump.d3_debug_data = kmalloc(mac_cfg->base->d3_debug_data_length,
 						   GFP_KERNEL);
 		if (!fwrt->dump.d3_debug_data) {
 			IWL_ERR(fwrt,
@@ -3299,15 +3300,15 @@ void iwl_fw_dbg_read_d3_debug_data(struct iwl_fw_runtime *fwrt)
 	}
 
 	/* if the buffer holds previous debug data it is overwritten */
-	iwl_trans_read_mem_bytes(fwrt->trans, cfg->d3_debug_data_base_addr,
+	iwl_trans_read_mem_bytes(fwrt->trans, mac_cfg->base->d3_debug_data_base_addr,
 				 fwrt->dump.d3_debug_data,
-				 cfg->d3_debug_data_length);
+				 mac_cfg->base->d3_debug_data_length);
 
 	if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_mem)
 		fwrt->sanitize_ops->frob_mem(fwrt->sanitize_ctx,
-					     cfg->d3_debug_data_base_addr,
+					     mac_cfg->base->d3_debug_data_base_addr,
 					     fwrt->dump.d3_debug_data,
-					     cfg->d3_debug_data_length);
+					     mac_cfg->base->d3_debug_data_length);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_read_d3_debug_data);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index bd0d09fcd57e..8034c9ecba69 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -201,7 +201,7 @@ static inline bool iwl_fw_dbg_is_d3_debug_enabled(struct iwl_fw_runtime *fwrt)
 {
 	return fw_has_capa(&fwrt->fw->ucode_capa,
 			   IWL_UCODE_TLV_CAPA_D3_DEBUG) &&
-		fwrt->trans->cfg->d3_debug_data_length && fwrt->ops &&
+		fwrt->trans->mac_cfg->base->d3_debug_data_length && fwrt->ops &&
 		fwrt->ops->d3_debug_enable &&
 		fwrt->ops->d3_debug_enable(fwrt->ops_ctx) &&
 		iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_D3_DEBUG_DATA);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 9e62df8a7e16..c99b18b0ef7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -114,6 +114,28 @@ static inline u8 num_of_ant(u8 mask)
 		!!((mask) & ANT_C);
 }
 
+/**
+ * struct iwl_fw_mon_reg - FW monitor register info
+ * @addr: register address
+ * @mask: register mask
+ */
+struct iwl_fw_mon_reg {
+	u32 addr;
+	u32 mask;
+};
+
+/**
+ * struct iwl_fw_mon_regs - FW monitor registers
+ * @write_ptr: write pointer register
+ * @cycle_cnt: cycle count register
+ * @cur_frag: current fragment in use
+ */
+struct iwl_fw_mon_regs {
+	struct iwl_fw_mon_reg write_ptr;
+	struct iwl_fw_mon_reg cycle_cnt;
+	struct iwl_fw_mon_reg cur_frag;
+};
+
 /**
  * struct iwl_family_base_params - base parameters for an entire family
  * @max_ll_items: max number of OTP blocks
@@ -124,6 +146,7 @@ static inline u8 num_of_ant(u8 mask)
  * @wd_timeout: TX queues watchdog timeout
  * @max_event_log_size: size of event log buffer size for ucode event logging
  * @shadow_reg_enable: HW shadow register support
+ * @apmg_not_supported: there's no APMG
  * @apmg_wake_up_wa: should the MAC access REQ be asserted when a command
  *	is in flight. This is due to a HW bug in 7260, 3160 and 7265.
  * @scd_chain_ext_wa: should the chain extension feature in SCD be disabled.
@@ -132,6 +155,21 @@ static inline u8 num_of_ant(u8 mask)
  * @num_of_queues: number of HW TX queues supported
  * @pcie_l1_allowed: PCIe L1 state is allowed
  * @pll_cfg: PLL configuration needed
+ * @nvm_hw_section_num: the ID of the HW NVM section
+ * @features: hw features, any combination of feature_passlist
+ * @smem_offset: offset from which the SMEM begins
+ * @smem_len: the length of SMEM
+ * @mac_addr_from_csr: read HW address from CSR registers at this offset
+ * @d3_debug_data_base_addr: base address where D3 debug data is stored
+ * @d3_debug_data_length: length of the D3 debug data
+ * @min_ba_txq_size: minimum number of slots required in a TX queue used
+ *	for aggregation
+ * @min_txq_size: minimum number of slots required in a TX queue
+ * @gp2_reg_addr: GP2 (timer) register address
+ * @min_umac_error_event_table: minimum SMEM location of UMAC error table
+ * @mon_dbgi_regs: monitor DBGI registers
+ * @mon_dram_regs: monitor DRAM registers
+ * @mon_smem_regs: monitor SMEM registers
  */
 struct iwl_family_base_params {
 	unsigned int wd_timeout;
@@ -144,6 +182,7 @@ struct iwl_family_base_params {
 	   shadow_reg_enable:1,
 	   pcie_l1_allowed:1,
 	   apmg_wake_up_wa:1,
+	   apmg_not_supported:1,
 	   scd_chain_ext_wa:1;
 
 	u16 num_of_queues;	/* def: HW dependent */
@@ -151,6 +190,20 @@ struct iwl_family_base_params {
 
 	u8 max_ll_items;
 	u8 led_compensation;
+	u32 mac_addr_from_csr:10;
+	u8 nvm_hw_section_num;
+	netdev_features_t features;
+	u32 smem_offset;
+	u32 smem_len;
+	u32 min_umac_error_event_table;
+	u32 d3_debug_data_base_addr;
+	u32 d3_debug_data_length;
+	u32 min_txq_size;
+	u32 gp2_reg_addr;
+	u32 min_ba_txq_size;
+	const struct iwl_fw_mon_regs mon_dram_regs;
+	const struct iwl_fw_mon_regs mon_smem_regs;
+	const struct iwl_fw_mon_regs mon_dbgi_regs;
 };
 
 /*
@@ -285,28 +338,6 @@ struct iwl_mac_cfg {
 	    imr_enabled:1;
 };
 
-/**
- * struct iwl_fw_mon_reg - FW monitor register info
- * @addr: register address
- * @mask: register mask
- */
-struct iwl_fw_mon_reg {
-	u32 addr;
-	u32 mask;
-};
-
-/**
- * struct iwl_fw_mon_regs - FW monitor registers
- * @write_ptr: write pointer register
- * @cycle_cnt: cycle count register
- * @cur_frag: current fragment in use
- */
-struct iwl_fw_mon_regs {
-	struct iwl_fw_mon_reg write_ptr;
-	struct iwl_fw_mon_reg cycle_cnt;
-	struct iwl_fw_mon_reg cur_frag;
-};
-
 /**
  * struct iwl_cfg
  * @fw_name_pre: Firmware filename prefix. The api version and extension
@@ -331,24 +362,14 @@ struct iwl_fw_mon_regs {
  * @high_temp: Is this NIC is designated to be in high temperature.
  * @host_interrupt_operation_mode: device needs host interrupt operation
  *	mode set
- * @nvm_hw_section_num: the ID of the HW NVM section
- * @mac_addr_from_csr: read HW address from CSR registers at this offset
- * @features: hw features, any combination of feature_passlist
  * @pwr_tx_backoffs: translation table between power limits and backoffs
  * @dccm_offset: offset from which DCCM begins
  * @dccm_len: length of DCCM (including runtime stack CCM)
  * @dccm2_offset: offset from which the second DCCM begins
  * @dccm2_len: length of the second DCCM
- * @smem_offset: offset from which the SMEM begins
- * @smem_len: the length of SMEM
  * @vht_mu_mimo_supported: VHT MU-MIMO support
  * @nvm_type: see &enum iwl_nvm_type
- * @d3_debug_data_base_addr: base address where D3 debug data is stored
- * @d3_debug_data_length: length of the D3 debug data
- * @min_txq_size: minimum number of slots required in a TX queue
  * @uhb_supported: ultra high band channels supported
- * @min_ba_txq_size: minimum number of slots required in a TX queue which
- *	based on hardware support (HE - 256, EHT - 1K).
  * @num_rbds: number of receive buffer descriptors to use
  *	(only used for multi-queue capable devices)
  *
@@ -368,13 +389,10 @@ struct iwl_cfg {
 	enum iwl_nvm_type nvm_type;
 	u32 max_data_size;
 	u32 max_inst_size;
-	netdev_features_t features;
 	u32 dccm_offset;
 	u32 dccm_len;
 	u32 dccm2_offset;
 	u32 dccm2_len;
-	u32 smem_offset;
-	u32 smem_len;
 	u16 nvm_ver;
 	u16 nvm_calib_ver;
 	u16 bw_limit;
@@ -383,27 +401,15 @@ struct iwl_cfg {
 	    internal_wimax_coex:1,
 	    host_interrupt_operation_mode:1,
 	    high_temp:1,
-	    mac_addr_from_csr:10,
 	    lp_xtal_workaround:1,
-	    apmg_not_supported:1,
 	    vht_mu_mimo_supported:1,
 	    uhb_supported:1;
 	u8 valid_tx_ant;
 	u8 valid_rx_ant;
 	u8 non_shared_ant;
-	u8 nvm_hw_section_num;
 	u8 ucode_api_max;
 	u8 ucode_api_min;
 	u16 num_rbds;
-	u32 min_umac_error_event_table;
-	u32 d3_debug_data_base_addr;
-	u32 d3_debug_data_length;
-	u32 min_txq_size;
-	u32 gp2_reg_addr;
-	u32 min_ba_txq_size;
-	const struct iwl_fw_mon_regs mon_dram_regs;
-	const struct iwl_fw_mon_regs mon_smem_regs;
-	const struct iwl_fw_mon_regs mon_dbgi_regs;
 };
 
 #define IWL_CFG_ANY (~0)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 54765f585b9a..8b28b0b5721b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -649,7 +649,7 @@ enum msix_hw_int_causes {
  *                     HW address related registers                          *
  *****************************************************************************/
 
-#define CSR_ADDR_BASE(trans)			((trans)->cfg->mac_addr_from_csr)
+#define CSR_ADDR_BASE(trans)			((trans)->mac_cfg->base->mac_addr_from_csr)
 #define CSR_MAC_ADDR0_OTP(trans)		(CSR_ADDR_BASE(trans) + 0x00)
 #define CSR_MAC_ADDR1_OTP(trans)		(CSR_ADDR_BASE(trans) + 0x04)
 #define CSR_MAC_ADDR0_STRAP(trans)		(CSR_ADDR_BASE(trans) + 0x08)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 9bdcadc0bb6b..cf9e2e2ac9d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1403,7 +1403,8 @@ static int iwl_set_hw_address(struct iwl_trans *trans,
 			      struct iwl_nvm_data *data, const __be16 *nvm_hw,
 			      const __le16 *mac_override)
 {
-	if (cfg->mac_addr_from_csr) {
+	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
+	if (mac_cfg->base->mac_addr_from_csr) {
 		iwl_set_hw_address_from_csr(trans, data);
 	} else if (cfg->nvm_type != IWL_NVM_EXT) {
 		const u8 *hw_addr = (const u8 *)(nvm_hw + HW_ADDR);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 87c25277a174..73ed8d5cab43 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -168,7 +168,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	umac_error_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr) &
 		~FW_ADDR_CACHE_CONTROL;
 
-	if (umac_error_table >= trans->cfg->min_umac_error_event_table)
+	if (umac_error_table >= trans->mac_cfg->base->min_umac_error_event_table)
 		iwl_fw_umac_set_alive_err_table(trans, umac_error_table);
 	else
 		IWL_ERR(mld, "Not valid error log pointer 0x%08X\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 1d6ab0a9cc94..8677dbd2b4b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -351,7 +351,7 @@ static void iwl_mac_hw_set_misc(struct iwl_mld *mld)
 	hw->queues = IEEE80211_NUM_ACS;
 
 	hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
-	hw->netdev_features |= mld->cfg->features;
+	hw->netdev_features |= mld->trans->mac_cfg->base->features;
 
 	hw->max_tx_fragments = mld->trans->info.max_skb_frags;
 	hw->max_listen_interval = IWL_MLD_CONN_LISTEN_INTERVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index d5c3f853d96c..5ee38fc168c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -21,7 +21,7 @@
 
 static int iwl_mld_get_systime(struct iwl_mld *mld, u32 *gp2)
 {
-	*gp2 = iwl_read_prph(mld->trans, mld->trans->cfg->gp2_reg_addr);
+	*gp2 = iwl_read_prph(mld->trans, mld->trans->mac_cfg->base->gp2_reg_addr);
 
 	if (*gp2 == 0x5a5a5a5a)
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index bddeb557fd5b..317388ad2170 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -949,7 +949,7 @@ static int iwl_mld_allocate_internal_txq(struct iwl_mld *mld,
 	int queue, size;
 
 	size = max_t(u32, IWL_MGMT_QUEUE_SIZE,
-		     mld->trans->cfg->min_txq_size);
+		     mld->trans->mac_cfg->base->min_txq_size);
 
 	queue = iwl_trans_txq_alloc(mld->trans, 0, sta_mask, tid, size,
 				    IWL_WATCHDOG_DISABLED);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index b72fa6498c52..e478afbc61f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -83,7 +83,7 @@ static int iwl_mld_allocate_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 
 	if (tid == IWL_MGMT_TID)
 		size = max_t(u32, IWL_MGMT_QUEUE_SIZE,
-			     mld->trans->cfg->min_txq_size);
+			     mld->trans->mac_cfg->base->min_txq_size);
 	else
 		size = iwl_mld_get_queue_size(mld, txq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 55a27d772bf9..819e3228462a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -233,7 +233,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 
 	if (umac_error_table) {
 		if (umac_error_table >=
-		    mvm->trans->cfg->min_umac_error_event_table) {
+		    mvm->trans->mac_cfg->base->min_umac_error_event_table) {
 			iwl_fw_umac_set_alive_err_table(mvm->trans,
 							umac_error_table);
 		} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a9b5fb2a56de..37a24f561770 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -771,7 +771,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->features |= NL80211_FEATURE_TDLS_CHANNEL_SWITCH;
 	}
 
-	hw->netdev_features |= mvm->cfg->features;
+	hw->netdev_features |= mvm->trans->mac_cfg->base->features;
 	if (!iwl_mvm_is_csum_supported(mvm))
 		hw->netdev_features &= ~IWL_CSUM_NETIF_FLAGS_MASK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 434d34b21928..b752bc4feb40 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1559,7 +1559,7 @@ static inline bool iwl_mvm_is_lar_supported(struct iwl_mvm *mvm)
 	 * Enable LAR only if it is supported by the FW (TLV) &&
 	 * enabled in the NVM
 	 */
-	if (mvm->cfg->nvm_type == IWL_NVM_EXT)
+	if (mvm->trans->cfg->nvm_type == IWL_NVM_EXT)
 		return nvm_lar && tlv_lar;
 	else
 		return tlv_lar;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 74ee15f77baf..953218f1e025 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -226,7 +226,7 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 	/* Checking for required sections */
 	if (mvm->trans->cfg->nvm_type == IWL_NVM) {
 		if (!mvm->nvm_sections[NVM_SECTION_TYPE_SW].data ||
-		    !mvm->nvm_sections[mvm->cfg->nvm_hw_section_num].data) {
+		    !mvm->nvm_sections[mvm->trans->mac_cfg->base->nvm_hw_section_num].data) {
 			IWL_ERR(mvm, "Can't parse empty OTP/NVM sections\n");
 			return NULL;
 		}
@@ -244,7 +244,7 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 			return NULL;
 		}
 		/* MAC_OVERRIDE or at least HW section must exist */
-		if (!mvm->nvm_sections[mvm->cfg->nvm_hw_section_num].data &&
+		if (!mvm->nvm_sections[mvm->trans->mac_cfg->base->nvm_hw_section_num].data &&
 		    !mvm->nvm_sections[NVM_SECTION_TYPE_MAC_OVERRIDE].data) {
 			IWL_ERR(mvm,
 				"Can't parse mac_address, empty sections\n");
@@ -260,7 +260,7 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 		}
 	}
 
-	hw = (const __be16 *)sections[mvm->cfg->nvm_hw_section_num].data;
+	hw = (const __be16 *)sections[mvm->trans->mac_cfg->base->nvm_hw_section_num].data;
 	sw = (const __le16 *)sections[NVM_SECTION_TYPE_SW].data;
 	calib = (const __le16 *)sections[NVM_SECTION_TYPE_CALIBRATION].data;
 	mac_override =
@@ -309,7 +309,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 	u32 size_read = 0;
 	u8 *nvm_buffer, *temp;
 
-	if (WARN_ON_ONCE(mvm->cfg->nvm_hw_section_num >= NVM_MAX_NUM_SECTIONS))
+	if (WARN_ON_ONCE(mvm->trans->mac_cfg->base->nvm_hw_section_num >= NVM_MAX_NUM_SECTIONS))
 		return -EINVAL;
 
 	/* load NVM values from nic */
@@ -366,7 +366,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 			mvm->nvm_reg_blob.size  = ret;
 			break;
 		default:
-			if (section == mvm->cfg->nvm_hw_section_num) {
+			if (section == mvm->trans->mac_cfg->base->nvm_hw_section_num) {
 				mvm->nvm_hw_blob.data = temp;
 				mvm->nvm_hw_blob.size = ret;
 				break;
@@ -540,7 +540,7 @@ int iwl_mvm_init_mcc(struct iwl_mvm *mvm)
 	struct ieee80211_regdomain *regd;
 	char mcc[3];
 
-	if (mvm->cfg->nvm_type == IWL_NVM_EXT) {
+	if (mvm->trans->cfg->nvm_type == IWL_NVM_EXT) {
 		tlv_lar = fw_has_capa(&mvm->fw->ucode_capa,
 				      IWL_UCODE_TLV_CAPA_LAR_SUPPORT);
 		nvm_lar = mvm->nvm_data->lar_enabled;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e378df38eb2e..5b9c37fb0c0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -135,7 +135,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	 * (PCIe power is lost before PERST# is asserted), causing ME FW
 	 * to lose ownership and not being able to obtain it back.
 	 */
-	if (!mvm->trans->cfg->apmg_not_supported)
+	if (!mvm->trans->mac_cfg->base->apmg_not_supported)
 		iwl_set_bits_mask_prph(mvm->trans, APMG_PS_CTRL_REG,
 				       APMG_PS_CTRL_EARLY_PWR_OFF_RESET_DIS,
 				       ~APMG_PS_CTRL_EARLY_PWR_OFF_RESET_DIS);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index a5190e091bad..8ec4a007b4b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -852,7 +852,7 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 	if (tid == IWL_MAX_TID_COUNT) {
 		tid = IWL_MGMT_TID;
 		size = max_t(u32, IWL_MGMT_QUEUE_SIZE,
-			     mvm->trans->cfg->min_txq_size);
+			     mvm->trans->mac_cfg->base->min_txq_size);
 	} else {
 		size = iwl_mvm_get_queue_size(sta);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 9e0db3a750aa..62da0132f383 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1182,8 +1182,8 @@ u32 iwl_mvm_get_systime(struct iwl_mvm *mvm)
 	u32 reg_addr = DEVICE_SYSTEM_TIME_REG;
 
 	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000 &&
-	    mvm->trans->cfg->gp2_reg_addr)
-		reg_addr = mvm->trans->cfg->gp2_reg_addr;
+	    mvm->trans->mac_cfg->base->gp2_reg_addr)
+		reg_addr = mvm->trans->mac_cfg->base->gp2_reg_addr;
 
 	return iwl_read_prph(mvm->trans, reg_addr);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 2ac03ed56a95..dcc8edeb34ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -110,7 +110,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	u32 control_flags_ext = 0;
 	int ret;
 	int cmdq_size = max_t(u32, IWL_CMD_QUEUE_SIZE,
-			      trans->cfg->min_txq_size);
+			      trans->mac_cfg->base->min_txq_size);
 
 	switch (trans->conf.rx_buf_size) {
 	case IWL_AMSDU_DEF:
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 0f408b94f145..c283ceff0417 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1683,7 +1683,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 
 	/* W/A for WiFi/WiMAX coex and WiMAX own the RF */
 	if (trans->cfg->internal_wimax_coex &&
-	    !trans->cfg->apmg_not_supported &&
+	    !trans->mac_cfg->base->apmg_not_supported &&
 	    (!(iwl_read_prph(trans, APMG_CLK_CTRL_REG) &
 			     APMS_CLK_VAL_MRB_FUNC_MODE) ||
 	     (iwl_read_prph(trans, APMG_PS_CTRL_REG) &
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 838fc98e9c37..d606c586e57c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -253,7 +253,7 @@ static int iwl_pcie_gen2_nic_init(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int queue_size = max_t(u32, IWL_CMD_QUEUE_SIZE,
-			       trans->cfg->min_txq_size);
+			       trans->mac_cfg->base->min_txq_size);
 	int ret;
 
 	/* TODO: most of the logic can be removed in A0 - but not in Z0 */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 850952461b2b..bc4753ec4819 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -237,7 +237,7 @@ static void iwl_trans_pcie_write_shr(struct iwl_trans *trans, u32 reg, u32 val)
 
 static void iwl_pcie_set_pwr(struct iwl_trans *trans, bool vaux)
 {
-	if (trans->cfg->apmg_not_supported)
+	if (trans->mac_cfg->base->apmg_not_supported)
 		return;
 
 	if (vaux && pci_pme_capable(to_pci_dev(trans->dev), PCI_D3cold))
@@ -353,7 +353,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	 * bits do not disable clocks.  This preserves any hardware
 	 * bits already set by default in "CLK_CTRL_REG" after reset.
 	 */
-	if (!trans->cfg->apmg_not_supported) {
+	if (!trans->mac_cfg->base->apmg_not_supported) {
 		iwl_write_prph(trans, APMG_CLK_EN_REG,
 			       APMG_CLK_VAL_DMA_CLK_RQT);
 		udelay(20);
@@ -1271,7 +1271,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool from_irq)
 		iwl_pcie_rx_stop(trans);
 
 		/* Power-down device's busmaster DMA clocks */
-		if (!trans->cfg->apmg_not_supported) {
+		if (!trans->mac_cfg->base->apmg_not_supported) {
 			iwl_write_prph(trans, APMG_CLK_DIS_REG,
 				       APMG_CLK_VAL_DMA_CLK_RQT);
 			udelay(5);
@@ -3527,7 +3527,7 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 					IWL_LDBG_M2S_BUF_BA_MSK) <<
 				       trans->dbg.dest_tlv->base_shift;
 				base *= IWL_M2S_UNIT_SIZE;
-				base += trans->cfg->smem_offset;
+				base += trans->mac_cfg->base->smem_offset;
 			} else {
 				base = iwl_read_prph(trans, base) <<
 				       trans->dbg.dest_tlv->base_shift;
@@ -3568,7 +3568,7 @@ static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 			base = (cfg_reg & IWL_LDBG_M2S_BUF_BA_MSK) <<
 				trans->dbg.dest_tlv->base_shift;
 			base *= IWL_M2S_UNIT_SIZE;
-			base += trans->cfg->smem_offset;
+			base += trans->mac_cfg->base->smem_offset;
 
 			monitor_len =
 				(cfg_reg & IWL_LDBG_M2S_BUF_SIZE_MSK) >>
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index b6d48fff9c0e..715e1154faf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -849,10 +849,10 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
-					  trans->cfg->min_txq_size);
+					  trans->mac_cfg->base->min_txq_size);
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
-					  trans->cfg->min_ba_txq_size);
+					  trans->mac_cfg->base->min_ba_txq_size);
 		trans_pcie->txqs.txq[txq_id] = &trans_pcie->txq_memory[txq_id];
 		ret = iwl_pcie_txq_alloc(trans, trans_pcie->txqs.txq[txq_id],
 					 slots_num, cmd_queue);
@@ -966,10 +966,10 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
-					  trans->cfg->min_txq_size);
+					  trans->mac_cfg->base->min_txq_size);
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
-					  trans->cfg->min_ba_txq_size);
+					  trans->mac_cfg->base->min_ba_txq_size);
 		ret = iwl_txq_init(trans, trans_pcie->txqs.txq[txq_id], slots_num,
 				   cmd_queue);
 		if (ret) {
-- 
2.34.1


