Return-Path: <linux-wireless+bounces-22751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF3AAF97F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FC74A2329
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C899225761;
	Thu,  8 May 2025 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8vV92q1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324EE227E82
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706422; cv=none; b=QHVyqOwq7fWvQxpARHv3L/eBPujjSSiiR09B1JnE9gIUhLMIOeaYOZ9Gj1k4qL7hvy0e8rTBiiy/mF2HCkCGVKpjjbFdi8xHRgfmQIhkakb69/7kxKHgdNqzMp2W2KzOHjTIXeASJjvV3ZJNgrx1pUiUexaJEx8+fL5p1I+VMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706422; c=relaxed/simple;
	bh=NSUamcVJAoGvZtVm3poDvlk5oXhwKUPdUmcNpANLi/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+B7G001WHaYfauAlwzU4fVRil3V3MS0MHKMriBw4Fs/o0oqmuYpGb8OQfjcpB493dcvl20Purj1rxu4u4AOIGW8L2+KEOv6vpFXePKV7kluUfCTohjbTvStpQMGfpHaPhYXOxZXW+1cPV3hka0vheZNSRYWOVVgRZ94o4pJ0k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8vV92q1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706414; x=1778242414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSUamcVJAoGvZtVm3poDvlk5oXhwKUPdUmcNpANLi/Q=;
  b=G8vV92q1EhDn0ZpXyn+RX1fFlP0KntKEKf/rqSlG/SLsDshBEFBL5ru2
   FEq7Df/fstzMZTErV3Crw6vEAwhFWjQ/OrvcbtgSwi99kjKMU5R6eCgJB
   lUrEGwjyvRb6kqsL35eUxomDOdprIlRqio/zLjadZEuKTd6sXKhRXdh7J
   duZ1h2+Q47jwiA80qN3LPc06pcUx4nFkOnONbouKKOlMyrgFdFyRxrGgX
   VMTqS/7iVS5dt/iUrOE5BqStsfWtcvcNufGQMG2cRP+XlXOPvBKwOtDrH
   mfvw41x/qOdYu8KU/LqnyrX55viCrJRNAUyQen/u2lJnYlYoFQBRzgG4z
   w==;
X-CSE-ConnectionGUID: Fhp23ieNRymyBlR8hxctIA==
X-CSE-MsgGUID: cjUdjcdPQ+eYHKFjhMdHGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688045"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688045"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:34 -0700
X-CSE-ConnectionGUID: mp+dL+yzTfylHw8P/YUDYw==
X-CSE-MsgGUID: kx/a7MljTBCDXnyQFci/GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347848"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: rename cfg_trans_params to mac_cfg
Date: Thu,  8 May 2025 15:12:59 +0300
Message-Id: <20250508121306.1277801-9-miriam.rachel.korenblit@intel.com>
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

Since 9000 series devices, the devices are split into MAC and
CRF parts. Currently, "struct iwl_cfg" reflects some MAC and
some RF parameters, but we want to clean this up and move the
MAC data to what's now "struct iwl_cfg_trans_params". As the
first step, to reflect the intent, rename this structure.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.0a5f9ea3cec9.I8f464d33fa69fc6c47270912137a27867953e850@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |   8 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |   8 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |   4 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |   6 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   4 +-
 .../net/wireless/intel/iwlwifi/dvm/power.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  26 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  14 +-
 .../net/wireless/intel/iwlwifi/fw/paging.c    |   4 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  72 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |  14 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  14 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  22 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  16 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   4 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 908 +++++++++---------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  56 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  32 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 116 +--
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  16 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  74 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |   8 +-
 63 files changed, 855 insertions(+), 855 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index 0581dc84d59b..2cc2c2f8e653 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -54,7 +54,7 @@ static const struct iwl_eeprom_params iwl1000_eeprom_params = {
 	}
 };
 
-const struct iwl_cfg_trans_params iwl1000_trans_cfg = {
+const struct iwl_mac_cfg iwl1000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_1000,
 	.base_params = &iwl1000_base_params,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index c2d4c8691372..7e8e9c8eda75 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -80,7 +80,7 @@ static const struct iwl_eeprom_params iwl20x0_eeprom_params = {
 	.enhanced_txpower = true,
 };
 
-const struct iwl_cfg_trans_params iwl2000_trans_cfg = {
+const struct iwl_mac_cfg iwl2000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_2000,
 	.base_params = &iwl2000_base_params,
 };
@@ -109,7 +109,7 @@ const struct iwl_cfg iwl2000_2bgn_cfg = {
 const char iwl2000_2bgn_name[] = "Intel(R) Centrino(R) Wireless-N 2200 BGN";
 const char iwl2000_2bgn_d_name[] = "Intel(R) Centrino(R) Wireless-N 2200D BGN";
 
-const struct iwl_cfg_trans_params iwl2030_trans_cfg = {
+const struct iwl_mac_cfg iwl2030_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_2030,
 	.base_params = &iwl2030_base_params,
 };
@@ -136,7 +136,7 @@ const struct iwl_cfg iwl2030_2bgn_cfg = {
 
 const char iwl2030_2bgn_name[] = "Intel(R) Centrino(R) Wireless-N 2230 BGN";
 
-const struct iwl_cfg_trans_params iwl105_trans_cfg = {
+const struct iwl_mac_cfg iwl105_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_105,
 	.base_params = &iwl2000_base_params,
 };
@@ -165,7 +165,7 @@ const struct iwl_cfg iwl105_bgn_cfg = {
 const char iwl105_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 105 BGN";
 const char iwl105_bgn_d_name[] = "Intel(R) Centrino(R) Wireless-N 105D BGN";
 
-const struct iwl_cfg_trans_params iwl135_trans_cfg = {
+const struct iwl_mac_cfg iwl135_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_135,
 	.base_params = &iwl2030_base_params,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 33e70890f8a4..e99c727f81f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -113,7 +113,7 @@ static const struct iwl_base_params iwl_22000_base_params = {
 		},							\
 	}
 
-const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
+const struct iwl_mac_cfg iwl_qu_mac_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
@@ -124,7 +124,7 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
 };
 
-const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg = {
+const struct iwl_mac_cfg iwl_qu_medium_latency_mac_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
@@ -135,7 +135,7 @@ const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_1820US,
 };
 
-const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
+const struct iwl_mac_cfg iwl_qu_long_latency_mac_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
@@ -173,7 +173,7 @@ const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz = {
 	.bw_limit = 80,
 };
 
-const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
+const struct iwl_mac_cfg iwl_ax200_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index 85c1adfefa93..6f9697847b80 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -53,7 +53,7 @@ static const struct iwl_eeprom_params iwl5000_eeprom_params = {
 	},
 };
 
-const struct iwl_cfg_trans_params iwl5000_trans_cfg = {
+const struct iwl_mac_cfg iwl5000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_5000,
 	.base_params = &iwl5000_base_params,
 };
@@ -122,7 +122,7 @@ const struct iwl_cfg iwl5350_agn_cfg = {
 
 const char iwl5350_agn_name[] = "Intel(R) WiMAX/WiFi Link 5350 AGN";
 
-const struct iwl_cfg_trans_params iwl5150_trans_cfg = {
+const struct iwl_mac_cfg iwl5150_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_5150,
 	.base_params = &iwl5000_base_params,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index cb137b3fefc3..ea930bcf8791 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -101,7 +101,7 @@ static const struct iwl_eeprom_params iwl6000_eeprom_params = {
 	.enhanced_txpower = true,
 };
 
-const struct iwl_cfg_trans_params iwl6005_trans_cfg = {
+const struct iwl_mac_cfg iwl6005_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6005,
 	.base_params = &iwl6000_g2_base_params,
 };
@@ -139,7 +139,7 @@ const struct iwl_cfg iwl6005_non_n_cfg = {
 const char iwl6005_2abg_name[] = "Intel(R) Centrino(R) Advanced-N 6205 ABG";
 const char iwl6005_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6205 BG";
 
-const struct iwl_cfg_trans_params iwl6030_trans_cfg = {
+const struct iwl_mac_cfg iwl6030_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6030,
 	.base_params = &iwl6000_g2_base_params,
 };
@@ -218,7 +218,7 @@ const struct iwl_cfg iwl130_bg_cfg = {
 
 const char iwl130_bg_name[] = "Intel(R) Centrino(R) Wireless-N 130 BG";
 
-const struct iwl_cfg_trans_params iwl6000i_trans_cfg = {
+const struct iwl_mac_cfg iwl6000i_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6000i,
 	.base_params = &iwl6000_base_params,
 };
@@ -257,7 +257,7 @@ const struct iwl_cfg iwl6000i_non_n_cfg = {
 const char iwl6000i_2abg_name[] = "Intel(R) Centrino(R) Advanced-N 6200 ABG";
 const char iwl6000i_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6200 BG";
 
-const struct iwl_cfg_trans_params iwl6050_trans_cfg = {
+const struct iwl_mac_cfg iwl6050_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6050,
 	.base_params = &iwl6050_base_params,
 };
@@ -293,7 +293,7 @@ const struct iwl_cfg iwl6050_2abg_cfg = {
 
 const char iwl6050_2abg_name[] = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 ABG";
 
-const struct iwl_cfg_trans_params iwl6150_trans_cfg = {
+const struct iwl_mac_cfg iwl6150_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6150,
 	.base_params = &iwl6050_base_params,
 };
@@ -327,7 +327,7 @@ const struct iwl_cfg iwl6150_bg_cfg = {
 
 const char iwl6150_bg_name[] = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BG";
 
-const struct iwl_cfg_trans_params iwl6000_trans_cfg = {
+const struct iwl_mac_cfg iwl6000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6000,
 	.base_params = &iwl6000_base_params,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index ab7933487675..f93453f159d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -84,7 +84,7 @@ static const struct iwl_tt_params iwl7000_high_temp_tt_params = {
 	.support_tx_backoff = true,
 };
 
-const struct iwl_cfg_trans_params iwl7000_trans_cfg = {
+const struct iwl_mac_cfg iwl7000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_7000,
 	.base_params = &iwl7000_base_params,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 02093a6e857a..d31f38c76a86 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -68,7 +68,7 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 	.support_tx_backoff = true,
 };
 
-const struct iwl_cfg_trans_params iwl8000_trans_cfg = {
+const struct iwl_mac_cfg iwl8000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_8000,
 	.base_params = &iwl8000_base_params,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 70d941ac299b..abfdecad7967 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -117,14 +117,14 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 		},							\
 	}
 
-const struct iwl_cfg_trans_params iwl9000_trans_cfg = {
+const struct iwl_mac_cfg iwl9000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
 	.rf_id = true,
 };
 
-const struct iwl_cfg_trans_params iwl9560_trans_cfg = {
+const struct iwl_mac_cfg iwl9560_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
@@ -133,7 +133,7 @@ const struct iwl_cfg_trans_params iwl9560_trans_cfg = {
 	.xtal_latency = 650,
 };
 
-const struct iwl_cfg_trans_params iwl9560_long_latency_trans_cfg = {
+const struct iwl_mac_cfg iwl9560_long_latency_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
@@ -142,7 +142,7 @@ const struct iwl_cfg_trans_params iwl9560_long_latency_trans_cfg = {
 	.xtal_latency = 2820,
 };
 
-const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg = {
+const struct iwl_mac_cfg iwl9560_shared_clk_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 0fcdca2d4a69..acceb6dda0af 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -117,7 +117,7 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 		},							\
 	}
 
-const struct iwl_cfg_trans_params iwl_so_trans_cfg = {
+const struct iwl_mac_cfg iwl_so_mac_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
@@ -130,7 +130,7 @@ const struct iwl_cfg_trans_params iwl_so_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
 };
 
-const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg = {
+const struct iwl_mac_cfg iwl_so_long_latency_mac_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
@@ -143,7 +143,7 @@ const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg = {
+const struct iwl_mac_cfg iwl_so_long_latency_imr_mac_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
@@ -167,7 +167,7 @@ const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg = {
 #define IWL_NUM_RBDS_NON_HE		512
 #define IWL_NUM_RBDS_AX210_HE		4096
 
-const struct iwl_cfg_trans_params iwl_ma_trans_cfg = {
+const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_AX210,
 	.base_params = &iwl_ax210_base_params,
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index f347b9d29a12..8aad515c1464 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -124,7 +124,7 @@ static const struct iwl_base_params iwl_bz_base_params = {
  */
 #define IWL_NUM_RBDS_BZ_EHT		(512 * 16)
 
-const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
+const struct iwl_mac_cfg iwl_bz_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
 	.base_params = &iwl_bz_base_params,
 	.mq_rx_supported = true,
@@ -137,7 +137,7 @@ const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const struct iwl_cfg_trans_params iwl_gl_trans_cfg = {
+const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
 	.base_params = &iwl_bz_base_params,
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 1218aec8b49a..9b4d008cd8ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -120,7 +120,7 @@ static const struct iwl_base_params iwl_dr_base_params = {
  */
 #define IWL_NUM_RBDS_DR_EHT		(512 * 16)
 
-const struct iwl_cfg_trans_params iwl_dr_trans_cfg = {
+const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
 	.base_params = &iwl_dr_base_params,
 	.mq_rx_supported = true,
@@ -139,7 +139,7 @@ const struct iwl_cfg iwl_cfg_dr = {
 	IWL_DEVICE_DR,
 };
 
-const struct iwl_cfg_trans_params iwl_br_trans_cfg = {
+const struct iwl_mac_cfg iwl_br_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
 	.base_params = &iwl_dr_base_params,
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 5ae1bc4831e2..b0ddda3718e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -124,7 +124,7 @@ static const struct iwl_base_params iwl_sc_base_params = {
  */
 #define IWL_NUM_RBDS_SC_EHT		(512 * 16)
 
-const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
+const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_SC,
 	.base_params = &iwl_sc_base_params,
 	.mq_rx_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index 48a8349680fc..3447ae0b160a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/units.h>
@@ -481,7 +481,7 @@ static void iwl6000_set_ct_threshold(struct iwl_priv *priv)
 /* NIC configuration for 6000 series */
 static void iwl6000_nic_config(struct iwl_priv *priv)
 {
-	switch (priv->trans->trans_cfg->device_family) {
+	switch (priv->trans->mac_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_6005:
 	case IWL_DEVICE_FAMILY_6030:
 	case IWL_DEVICE_FAMILY_6000:
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 884f811e7a27..509b4d71e660 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -781,7 +781,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 	 * CSR auto clock gate disable bit -
 	 * this is only applicable for HW with OTP shadow RAM
 	 */
-	if (trans->trans_cfg->base_params->shadow_ram_support)
+	if (trans->mac_cfg->base_params->shadow_ram_support)
 		iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 			    CSR_RESET_LINK_PWR_MGMT_DISABLED);
 
@@ -902,7 +902,7 @@ static int iwl_find_otp_image(struct iwl_trans *trans,
 		}
 		/* more in the link list, continue */
 		usedblocks++;
-	} while (usedblocks <= trans->trans_cfg->base_params->max_ll_items);
+	} while (usedblocks <= trans->mac_cfg->base_params->max_ll_items);
 
 	/* OTP has no valid blocks */
 	IWL_DEBUG_EEPROM(trans->dev, "OTP has no valid blocks\n");
@@ -935,7 +935,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 	if (nvm_is_otp < 0)
 		return nvm_is_otp;
 
-	sz = trans->trans_cfg->base_params->eeprom_size;
+	sz = trans->mac_cfg->base_params->eeprom_size;
 	IWL_DEBUG_EEPROM(trans->dev, "NVM size = %d\n", sz);
 
 	e = kmalloc(sz, GFP_KERNEL);
@@ -970,7 +970,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 			    CSR_OTP_GP_REG_ECC_CORR_STATUS_MSK |
 			    CSR_OTP_GP_REG_ECC_UNCORR_STATUS_MSK);
 		/* traversing the linked list if no shadow ram supported */
-		if (!trans->trans_cfg->base_params->shadow_ram_support) {
+		if (!trans->mac_cfg->base_params->shadow_ram_support) {
 			ret = iwl_find_otp_image(trans, &validblockaddr);
 			if (ret)
 				goto err_unlock;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.c b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
index 5ca85d90a8d6..2b02c717173e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2025 Intel Corporation
  *****************************************************************************/
 
 
@@ -116,9 +116,9 @@ static int iwl_led_cmd(struct iwl_priv *priv,
 	}
 
 	led_cmd.on = iwl_blink_compensation(priv, on,
-				priv->trans->trans_cfg->base_params->led_compensation);
+				priv->trans->mac_cfg->base_params->led_compensation);
 	led_cmd.off = iwl_blink_compensation(priv, off,
-				priv->trans->trans_cfg->base_params->led_compensation);
+				priv->trans->mac_cfg->base_params->led_compensation);
 
 	ret = iwl_send_led_cmd(priv, &led_cmd);
 	if (!ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 517edc9bf276..7e5c8df67850 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -1091,7 +1091,7 @@ static void iwlagn_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto done;
 	}
 
-	scd_queues = BIT(priv->trans->trans_cfg->base_params->num_of_queues) - 1;
+	scd_queues = BIT(priv->trans->mac_cfg->base_params->num_of_queues) - 1;
 	scd_queues &= ~(BIT(IWL_IPAN_CMD_QUEUE_NUM) |
 			BIT(IWL_DEFAULT_CMD_QUEUE_NUM));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index c62761867023..44c6946f1c20 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1263,7 +1263,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	priv->cfg = cfg;
 	priv->fw = fw;
 
-	switch (priv->trans->trans_cfg->device_family) {
+	switch (priv->trans->mac_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_1000:
 	case IWL_DEVICE_FAMILY_100:
 		priv->lib = &iwl_dvm_1000_cfg;
@@ -1339,7 +1339,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 					    driver_data[2]);
 
 	WARN_ON(sizeof(priv->transport_queue_stop) * BITS_PER_BYTE <
-		priv->trans->trans_cfg->base_params->num_of_queues);
+		priv->trans->mac_cfg->base_params->num_of_queues);
 
 	ucode_flags = fw->ucode_capa.flags;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.c b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
index 7f8006ac15d9..8cd3931af2ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
@@ -196,7 +196,7 @@ static void iwl_static_sleep_cmd(struct iwl_priv *priv,
 	else
 		cmd->flags &= ~IWL_POWER_SLEEP_OVER_DTIM_MSK;
 
-	if (priv->trans->trans_cfg->base_params->shadow_reg_enable)
+	if (priv->trans->mac_cfg->base_params->shadow_reg_enable)
 		cmd->flags |= IWL_POWER_SHADOW_REG_ENA;
 	else
 		cmd->flags &= ~IWL_POWER_SHADOW_REG_ENA;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 111ed1873006..e6f6b22bf259 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 Intel Corporation
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023, 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/kernel.h>
@@ -463,7 +463,7 @@ static int iwlagn_alloc_agg_txq(struct iwl_priv *priv, int mq)
 	int q;
 
 	for (q = IWLAGN_FIRST_AMPDU_QUEUE;
-	     q < priv->trans->trans_cfg->base_params->num_of_queues; q++) {
+	     q < priv->trans->mac_cfg->base_params->num_of_queues; q++) {
 		if (!test_and_set_bit(q, priv->agg_q_alloc)) {
 			priv->queue_to_mac80211[q] = mq;
 			return q;
@@ -1277,7 +1277,7 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 	 * (in Tx queue's circular buffer) of first TFD/frame in window */
 	u16 ba_resp_scd_ssn = le16_to_cpu(ba_resp->scd_ssn);
 
-	if (scd_flow >= priv->trans->trans_cfg->base_params->num_of_queues) {
+	if (scd_flow >= priv->trans->mac_cfg->base_params->num_of_queues) {
 		IWL_ERR(priv,
 			"BUG_ON scd_flow is bigger than number of queues\n");
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 4d49c82d5093..dbe09bd464cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -187,7 +187,7 @@ static void iwl_fw_dump_rxf(struct iwl_fw_runtime *fwrt,
 		/* Pull RXF2 */
 		iwl_fwrt_dump_rxf(fwrt, dump_data, cfg->rxfifo2_size,
 				  RXF_DIFF_FROM_PREV +
-				  fwrt->trans->trans_cfg->umac_prph_offset, 1);
+				  fwrt->trans->mac_cfg->umac_prph_offset, 1);
 		/* Pull LMAC2 RXF1 */
 		if (fwrt->smem_cfg.num_lmacs > 1)
 			iwl_fwrt_dump_rxf(fwrt, dump_data,
@@ -654,10 +654,10 @@ static void iwl_fw_prph_handler(struct iwl_fw_runtime *fwrt, void *ptr,
 {
 	u32 range_len;
 
-	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_ax210);
 		handler(fwrt, iwl_prph_dump_addr_ax210, range_len, ptr);
-	} else if (fwrt->trans->trans_cfg->device_family >=
+	} else if (fwrt->trans->mac_cfg->device_family >=
 		   IWL_DEVICE_FAMILY_22000) {
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_22000);
 		handler(fwrt, iwl_prph_dump_addr_22000, range_len, ptr);
@@ -665,7 +665,7 @@ static void iwl_fw_prph_handler(struct iwl_fw_runtime *fwrt, void *ptr,
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_comm);
 		handler(fwrt, iwl_prph_dump_addr_comm, range_len, ptr);
 
-		if (fwrt->trans->trans_cfg->mq_rx_supported) {
+		if (fwrt->trans->mac_cfg->mq_rx_supported) {
 			range_len = ARRAY_SIZE(iwl_prph_dump_addr_9000);
 			handler(fwrt, iwl_prph_dump_addr_9000, range_len, ptr);
 		}
@@ -838,7 +838,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 			iwl_fw_prph_handler(fwrt, &prph_len,
 					    iwl_fw_get_prph_len);
 
-		if (fwrt->trans->trans_cfg->device_family ==
+		if (fwrt->trans->mac_cfg->device_family ==
 		    IWL_DEVICE_FAMILY_7000 &&
 		    iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_RADIO_REG))
 			radio_len = sizeof(*dump_data) + RADIO_REG_MAX_READ;
@@ -1110,7 +1110,7 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = size;
 
-	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (fwrt->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		indirect_wr_addr = WMAL_INDRCT_CMD1;
 
 	indirect_wr_addr += le32_to_cpu(offset);
@@ -1267,7 +1267,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	/* all paged index start from 1 to skip CSS section */
 	idx++;
 
-	if (!fwrt->trans->trans_cfg->gen2)
+	if (!fwrt->trans->mac_cfg->gen2)
 		return _iwl_dump_ini_paging_iter(fwrt, range_ptr, range_len, idx);
 
 	range = range_ptr;
@@ -1791,7 +1791,7 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 
 	data->write_ptr = iwl_get_mon_reg(fwrt, alloc_id,
 					  &addrs->write_ptr);
-	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		u32 wrt_ptr = le32_to_cpu(data->write_ptr);
 
 		data->write_ptr = cpu_to_le32(wrt_ptr >> 2);
@@ -1910,7 +1910,7 @@ iwl_dump_ini_mem_block_ranges(struct iwl_fw_runtime *fwrt,
 static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 				      struct iwl_dump_ini_region_data *reg_data)
 {
-	if (fwrt->trans->trans_cfg->gen2) {
+	if (fwrt->trans->mac_cfg->gen2) {
 		if (fwrt->trans->init_dram.paging_cnt)
 			return fwrt->trans->init_dram.paging_cnt - 1;
 		else
@@ -2022,7 +2022,7 @@ iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 	/* start from 1 to skip CSS section */
 	for (i = 1; i <= iwl_dump_ini_paging_ranges(fwrt, reg_data); i++) {
 		size += range_header_len;
-		if (fwrt->trans->trans_cfg->gen2)
+		if (fwrt->trans->mac_cfg->gen2)
 			size += fwrt->trans->init_dram.paging[i].size;
 		else
 			size += fwrt->fw_paging_db[i].fw_paging_size;
@@ -3342,7 +3342,7 @@ static int iwl_fw_dbg_suspend_resume_hcmd(struct iwl_trans *trans, bool suspend)
 static void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 				      struct iwl_fw_dbg_params *params)
 {
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
 		return;
 	}
@@ -3366,7 +3366,7 @@ static int iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 	if (!params)
 		return -EIO;
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
 		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
@@ -3468,7 +3468,7 @@ void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt)
 				  GENMASK(31, IWL_FW_DBG_DOMAIN_POS + 1));
 
 	/* supported starting from 9000 devices */
-	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
+	if (fwrt->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		return;
 
 	if (fwrt->trans->dbg.yoyo_bin_loaded || (preset && preset != 1))
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 35e30e5db462..bd0d09fcd57e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2019, 2021-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -210,7 +210,7 @@ static inline bool iwl_fw_dbg_is_d3_debug_enabled(struct iwl_fw_runtime *fwrt)
 static inline bool iwl_fw_dbg_is_paging_enabled(struct iwl_fw_runtime *fwrt)
 {
 	return iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_PAGING) &&
-		!fwrt->trans->trans_cfg->gen2 &&
+		!fwrt->trans->mac_cfg->gen2 &&
 		fwrt->cur_fw_img < IWL_UCODE_TYPE_MAX &&
 		fwrt->fw->img[fwrt->cur_fw_img].paging_mem_size &&
 		fwrt->fw_paging_db[0].fw_paging_block;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index c7b261c8ec96..3ec42a4ea801 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -417,10 +417,10 @@ static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
 	struct iwl_trans *trans = fwrt->trans;
 	u32 error, data1;
 
-	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		error = UMAG_SB_CPU_2_STATUS;
 		data1 = UMAG_SB_CPU_1_STATUS;
-	} else if (fwrt->trans->trans_cfg->device_family >=
+	} else if (fwrt->trans->mac_cfg->device_family >=
 		   IWL_DEVICE_FAMILY_8000) {
 		error = SB_CPU_2_STATUS;
 		data1 = SB_CPU_1_STATUS;
@@ -439,7 +439,7 @@ static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
 	IWL_ERR(fwrt, "0x%08X | IML/ROM data1\n",
 		iwl_read_umac_prph(trans, data1));
 
-	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
 		IWL_ERR(fwrt, "0x%08X | IML/ROM WFPM_AUTH_KEY_0\n",
 			iwl_read_umac_prph(trans, SB_MODIFY_CFG_FLAG));
 }
@@ -508,7 +508,7 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 		iwl_fwrt_dump_rcm_error_log(fwrt, 1);
 	iwl_fwrt_dump_iml_error_log(fwrt);
 	iwl_fwrt_dump_fseq_regs(fwrt);
-	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		pc_data = fwrt->trans->dbg.pc_data;
 
 		if (!iwl_trans_grab_nic_access(fwrt->trans))
@@ -522,7 +522,7 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 		iwl_trans_release_nic_access(fwrt->trans);
 	}
 
-	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		u32 scratch = iwl_read32(fwrt->trans, CSR_FUNC_SCRATCH);
 
 		IWL_ERR(fwrt, "Function Scratch status:\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index e1270fdc2544..d1d8058ad29f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -72,7 +72,7 @@ int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt)
 	 * values in VER_1, this is backwards-compatible with VER_2,
 	 * as long as we don't set any other bits.
 	 */
-	if (!fwrt->trans->trans_cfg->integrated)
+	if (!fwrt->trans->mac_cfg->integrated)
 		cmd.flags = cpu_to_le32(SOC_CONFIG_CMD_FLAGS_DISCRETE);
 
 	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_NONE !=
@@ -84,17 +84,17 @@ int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt)
 	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_1820US !=
 		     SOC_FLAGS_LTR_APPLY_DELAY_1820);
 
-	if (fwrt->trans->trans_cfg->ltr_delay != IWL_CFG_TRANS_LTR_DELAY_NONE &&
-	    !WARN_ON(!fwrt->trans->trans_cfg->integrated))
-		cmd.flags |= le32_encode_bits(fwrt->trans->trans_cfg->ltr_delay,
+	if (fwrt->trans->mac_cfg->ltr_delay != IWL_CFG_TRANS_LTR_DELAY_NONE &&
+	    !WARN_ON(!fwrt->trans->mac_cfg->integrated))
+		cmd.flags |= le32_encode_bits(fwrt->trans->mac_cfg->ltr_delay,
 					      SOC_FLAGS_LTR_APPLY_DELAY_MASK);
 
 	if (iwl_fw_lookup_cmd_ver(fwrt->fw, SCAN_REQ_UMAC,
 				  IWL_FW_CMD_VER_UNKNOWN) >= 2 &&
-	    fwrt->trans->trans_cfg->low_latency_xtal)
+	    fwrt->trans->mac_cfg->low_latency_xtal)
 		cmd.flags |= cpu_to_le32(SOC_CONFIG_CMD_FLAGS_LOW_LATENCY);
 
-	cmd.latency = cpu_to_le32(fwrt->trans->trans_cfg->xtal_latency);
+	cmd.latency = cpu_to_le32(fwrt->trans->mac_cfg->xtal_latency);
 
 	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
 	if (ret)
@@ -119,7 +119,7 @@ int iwl_configure_rxq(struct iwl_fw_runtime *fwrt)
 	if (fwrt->trans->info.num_rxqs == 1)
 		return 0;
 
-	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22000)
+	if (fwrt->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_22000)
 		return 0;
 
 	/* skip the default queue */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index a7b7cae874a2..826409f6f710 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021, 2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -267,7 +267,7 @@ int iwl_init_paging(struct iwl_fw_runtime *fwrt, enum iwl_ucode_type type)
 	const struct fw_img *fw = &fwrt->fw->img[type];
 	int ret;
 
-	if (fwrt->trans->trans_cfg->gen2)
+	if (fwrt->trans->mac_cfg->gen2)
 		return 0;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index a72e116eaeaf..9bed3d573b1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -247,10 +247,10 @@ static inline void iwl_bios_setup_step(struct iwl_trans *trans,
 {
 	u32 dsbr;
 
-	if (!trans->trans_cfg->integrated)
+	if (!trans->mac_cfg->integrated)
 		return;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
 		return;
 
 	if (iwl_bios_get_dsbr(fwrt, &dsbr))
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/smem.c b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
index 3f1272014daf..90fd69b4860c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021, 2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -102,7 +102,7 @@ void iwl_get_shared_mem_conf(struct iwl_fw_runtime *fwrt)
 	}
 
 	pkt = cmd.resp_pkt;
-	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
 		iwl_parse_shared_mem_22000(fwrt, pkt);
 	else
 		iwl_parse_shared_mem(fwrt, pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index ce68d96c31b8..48126ec6b94b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -325,7 +325,7 @@ void iwl_uefi_get_step_table(struct iwl_trans *trans)
 	struct uefi_cnv_common_step_data *data;
 	int ret;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
 	data = iwl_uefi_get_verified_variable_guid(trans, &IWL_EFI_WIFI_BT_GUID,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 320b14303a66..accbc684e59d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -238,7 +238,7 @@ struct iwl_pwr_tx_backoff {
 	u32 backoff;
 };
 
-enum iwl_cfg_trans_ltr_delay {
+enum iwl_mac_cfg_ltr_delay {
 	IWL_CFG_TRANS_LTR_DELAY_NONE	= 0,
 	IWL_CFG_TRANS_LTR_DELAY_200US	= 1,
 	IWL_CFG_TRANS_LTR_DELAY_2500US	= 2,
@@ -246,7 +246,7 @@ enum iwl_cfg_trans_ltr_delay {
 };
 
 /**
- * struct iwl_cfg_trans_params - information needed to start the trans
+ * struct iwl_mac_cfg - information about the MAC-specific device part
  *
  * These values are specific to the device ID and do not change when
  * multiple configs are used for a single device ID.  They values are
@@ -264,10 +264,10 @@ enum iwl_cfg_trans_ltr_delay {
  * @integrated: discrete or integrated
  * @low_latency_xtal: use the low latency xtal if supported
  * @bisr_workaround: BISR hardware workaround (for 22260 series devices)
- * @ltr_delay: LTR delay parameter, &enum iwl_cfg_trans_ltr_delay.
+ * @ltr_delay: LTR delay parameter, &enum iwl_mac_cfg_ltr_delay.
  * @imr_enabled: use the IMR if supported.
  */
-struct iwl_cfg_trans_params {
+struct iwl_mac_cfg {
 	const struct iwl_base_params *base_params;
 	enum iwl_device_family device_family;
 	u32 umac_prph_offset;
@@ -485,38 +485,38 @@ extern const struct pci_device_id iwl_hw_card_ids[];
 /*
  * This list declares the config structures for all devices.
  */
-extern const struct iwl_cfg_trans_params iwl1000_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl5000_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl2000_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl2030_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl105_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl135_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl5150_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl6005_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl6030_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl6000i_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl6050_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl6150_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl6000_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl7000_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl8000_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl9560_long_latency_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_so_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_bz_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_gl_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_sc_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_dr_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_br_trans_cfg;
+extern const struct iwl_mac_cfg iwl1000_mac_cfg;
+extern const struct iwl_mac_cfg iwl5000_mac_cfg;
+extern const struct iwl_mac_cfg iwl2000_mac_cfg;
+extern const struct iwl_mac_cfg iwl2030_mac_cfg;
+extern const struct iwl_mac_cfg iwl105_mac_cfg;
+extern const struct iwl_mac_cfg iwl135_mac_cfg;
+extern const struct iwl_mac_cfg iwl5150_mac_cfg;
+extern const struct iwl_mac_cfg iwl6005_mac_cfg;
+extern const struct iwl_mac_cfg iwl6030_mac_cfg;
+extern const struct iwl_mac_cfg iwl6000i_mac_cfg;
+extern const struct iwl_mac_cfg iwl6050_mac_cfg;
+extern const struct iwl_mac_cfg iwl6150_mac_cfg;
+extern const struct iwl_mac_cfg iwl6000_mac_cfg;
+extern const struct iwl_mac_cfg iwl7000_mac_cfg;
+extern const struct iwl_mac_cfg iwl8000_mac_cfg;
+extern const struct iwl_mac_cfg iwl9000_mac_cfg;
+extern const struct iwl_mac_cfg iwl9560_mac_cfg;
+extern const struct iwl_mac_cfg iwl9560_long_latency_mac_cfg;
+extern const struct iwl_mac_cfg iwl9560_shared_clk_mac_cfg;
+extern const struct iwl_mac_cfg iwl_qu_mac_cfg;
+extern const struct iwl_mac_cfg iwl_qu_medium_latency_mac_cfg;
+extern const struct iwl_mac_cfg iwl_qu_long_latency_mac_cfg;
+extern const struct iwl_mac_cfg iwl_ax200_mac_cfg;
+extern const struct iwl_mac_cfg iwl_so_mac_cfg;
+extern const struct iwl_mac_cfg iwl_so_long_latency_mac_cfg;
+extern const struct iwl_mac_cfg iwl_so_long_latency_imr_mac_cfg;
+extern const struct iwl_mac_cfg iwl_ma_mac_cfg;
+extern const struct iwl_mac_cfg iwl_bz_mac_cfg;
+extern const struct iwl_mac_cfg iwl_gl_mac_cfg;
+extern const struct iwl_mac_cfg iwl_sc_mac_cfg;
+extern const struct iwl_mac_cfg iwl_dr_mac_cfg;
+extern const struct iwl_mac_cfg iwl_br_mac_cfg;
 
 extern const char iwl1000_bgn_name[];
 extern const char iwl1000_bg_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index ce787326aa69..5c8f6dc9a3e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -503,7 +503,7 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	int res;
 
 	if (!iwlwifi_mod_params.enable_ini ||
-	    trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_8000)
+	    trans->mac_cfg->device_family <= IWL_DEVICE_FAMILY_8000)
 		return;
 
 	res = firmware_request_nowarn(&fw, yoyo_bin, dev);
@@ -603,11 +603,11 @@ static int iwl_dbg_tlv_alloc_fragments(struct iwl_fw_runtime *fwrt,
 		return 0;
 
 	num_frags = le32_to_cpu(fw_mon_cfg->max_frags_num);
-	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+	if (fwrt->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
 		if (alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
 			return -EIO;
 		num_frags = 1;
-	} else if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ &&
+	} else if (fwrt->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ &&
 			   alloc_id > IWL_FW_INI_ALLOCATION_ID_DBGC3) {
 		return -EIO;
 	}
@@ -1241,7 +1241,7 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 
 		fwrt->trans->dbg.restart_required = false;
 
-		if (fwrt->trans->trans_cfg->device_family ==
+		if (fwrt->trans->mac_cfg->device_family ==
 		    IWL_DEVICE_FAMILY_9000) {
 			fwrt->trans->dbg.restart_required = true;
 		} else if (tp == IWL_FW_INI_TIME_POINT_FW_ASSERT &&
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 2fade565a810..186c0a2d4772 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -297,7 +297,7 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
 	const char *fw_name_pre;
 
-	if (drv->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
+	if (drv->trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
 	    (drv->trans->info.hw_rev_step != SILICON_B_STEP &&
 	     drv->trans->info.hw_rev_step != SILICON_C_STEP)) {
 		IWL_ERR(drv,
@@ -1293,7 +1293,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*dbg_ptrs))
 				goto invalid_tlv_len;
-			if (drv->trans->trans_cfg->device_family <
+			if (drv->trans->mac_cfg->device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
 			drv->trans->dbg.umac_error_event_table =
@@ -1309,7 +1309,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*dbg_ptrs))
 				goto invalid_tlv_len;
-			if (drv->trans->trans_cfg->device_family <
+			if (drv->trans->mac_cfg->device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
 			drv->trans->dbg.lmac_error_event_table[0] =
@@ -1755,14 +1755,14 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 		fw->init_evtlog_size = (pieces->init_evtlog_size - 16)/12;
 	else
 		fw->init_evtlog_size =
-			drv->trans->trans_cfg->base_params->max_event_log_size;
+			drv->trans->mac_cfg->base_params->max_event_log_size;
 	fw->init_errlog_ptr = pieces->init_errlog_ptr;
 	fw->inst_evtlog_ptr = pieces->inst_evtlog_ptr;
 	if (pieces->inst_evtlog_size)
 		fw->inst_evtlog_size = (pieces->inst_evtlog_size - 16)/12;
 	else
 		fw->inst_evtlog_size =
-			drv->trans->trans_cfg->base_params->max_event_log_size;
+			drv->trans->mac_cfg->base_params->max_event_log_size;
 	fw->inst_errlog_ptr = pieces->inst_errlog_ptr;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index 5c8f1868db64..c1c24f33e637 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021, 2023-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021, 2023-2025 Intel Corporation
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fh_h__
@@ -71,7 +71,7 @@
 static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 					     unsigned int chnl)
 {
-	if (trans->trans_cfg->gen2) {
+	if (trans->mac_cfg->gen2) {
 		WARN_ON_ONCE(chnl >= 64);
 		return TFH_TFDQ_CBB_TABLE + 8 * chnl;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 29221657c9ef..80591809164e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -211,13 +211,13 @@ IWL_EXPORT_SYMBOL(iwl_clear_bits_prph);
 
 void iwl_force_nmi(struct iwl_trans *trans)
 {
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_write_prph_delay(trans, DEVICE_SET_NMI_REG,
 				     DEVICE_SET_NMI_VAL_DRV, 1);
-	else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	else if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
 				UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER);
-	else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+	else if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    UREG_DOORBELL_TO_ISR6_NMI_BIT);
 	else
@@ -368,7 +368,7 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 		FH_TSSR_TX_ERROR_REG
 	};
 
-	if (trans->trans_cfg->mq_rx_supported)
+	if (trans->mac_cfg->mq_rx_supported)
 		return iwl_dump_rfh(trans, buf);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -423,7 +423,7 @@ static void iwl_dump_host_monitor_block(struct iwl_trans *trans,
 
 static void iwl_dump_host_monitor(struct iwl_trans *trans)
 {
-	switch (trans->trans_cfg->device_family) {
+	switch (trans->mac_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_22000:
 	case IWL_DEVICE_FAMILY_AX210:
 		IWL_ERR(trans, "CSR_RESET = 0x%x\n",
@@ -445,11 +445,11 @@ static void iwl_dump_host_monitor(struct iwl_trans *trans)
 
 int iwl_finish_nic_init(struct iwl_trans *trans)
 {
-	const struct iwl_cfg_trans_params *cfg_trans = trans->trans_cfg;
+	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
 	u32 poll_ready;
 	int err;
 
-	if (cfg_trans->bisr_workaround) {
+	if (mac_cfg->bisr_workaround) {
 		/* ensure the TOP FSM isn't still in previous reset */
 		mdelay(2);
 	}
@@ -458,7 +458,7 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 	 * Set "initialization complete" bit to move adapter from
 	 * D0U* --> D0A* (powered-up active) state.
 	 */
-	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ |
 			    CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
@@ -469,7 +469,7 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY;
 	}
 
-	if (cfg_trans->device_family == IWL_DEVICE_FAMILY_8000)
+	if (mac_cfg->device_family == IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
 	/*
@@ -484,7 +484,7 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 		iwl_dump_host_monitor(trans);
 	}
 
-	if (cfg_trans->bisr_workaround) {
+	if (mac_cfg->bisr_workaround) {
 		/* ensure BISR shift has finished */
 		udelay(200);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index 37b3bd62897e..f4833c5fe86e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2021, 2025 Intel Corporation
  */
 #ifndef __iwl_io_h__
 #define __iwl_io_h__
@@ -64,38 +64,38 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf);
  */
 static inline u32 iwl_umac_prph(struct iwl_trans *trans, u32 ofs)
 {
-	return ofs + trans->trans_cfg->umac_prph_offset;
+	return ofs + trans->mac_cfg->umac_prph_offset;
 }
 
 static inline u32 iwl_read_umac_prph_no_grab(struct iwl_trans *trans, u32 ofs)
 {
 	return iwl_read_prph_no_grab(trans, ofs +
-				     trans->trans_cfg->umac_prph_offset);
+				     trans->mac_cfg->umac_prph_offset);
 }
 
 static inline u32 iwl_read_umac_prph(struct iwl_trans *trans, u32 ofs)
 {
-	return iwl_read_prph(trans, ofs + trans->trans_cfg->umac_prph_offset);
+	return iwl_read_prph(trans, ofs + trans->mac_cfg->umac_prph_offset);
 }
 
 static inline void iwl_write_umac_prph_no_grab(struct iwl_trans *trans, u32 ofs,
 					       u32 val)
 {
-	iwl_write_prph_no_grab(trans,  ofs + trans->trans_cfg->umac_prph_offset,
+	iwl_write_prph_no_grab(trans,  ofs + trans->mac_cfg->umac_prph_offset,
 			       val);
 }
 
 static inline void iwl_write_umac_prph(struct iwl_trans *trans, u32 ofs,
 				       u32 val)
 {
-	iwl_write_prph(trans,  ofs + trans->trans_cfg->umac_prph_offset, val);
+	iwl_write_prph(trans,  ofs + trans->mac_cfg->umac_prph_offset, val);
 }
 
 static inline int iwl_poll_umac_prph_bit(struct iwl_trans *trans, u32 addr,
 					 u32 bits, u32 mask, int timeout)
 {
 	return iwl_poll_prph_bit(trans, addr +
-				 trans->trans_cfg->umac_prph_offset,
+				 trans->mac_cfg->umac_prph_offset,
 				 bits, mask, timeout);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 96dc27b93db1..9bdcadc0bb6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -542,14 +542,14 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 
 	switch (iwlwifi_mod_params.amsdu_size) {
 	case IWL_AMSDU_DEF:
-		if (trans->trans_cfg->mq_rx_supported)
+		if (trans->mac_cfg->mq_rx_supported)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
 			vht_cap->cap |= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
 		break;
 	case IWL_AMSDU_2K:
-		if (trans->trans_cfg->mq_rx_supported)
+		if (trans->mac_cfg->mq_rx_supported)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
@@ -920,7 +920,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 {
 	bool is_ap = iftype_data->types_mask & (BIT(NL80211_IFTYPE_AP) |
 						BIT(NL80211_IFTYPE_P2P_GO));
-	bool slow_pcie = (!trans->trans_cfg->integrated &&
+	bool slow_pcie = (!trans->mac_cfg->integrated &&
 			  trans->info.pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB);
 
 	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be)
@@ -1036,7 +1036,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210 && !is_ap)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210 && !is_ap)
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
 			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 
@@ -1081,7 +1081,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.mac_cap_info[2] |=
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT;
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
 	    !is_ap) {
 		iftype_data->vendor_elems.data = iwl_vendor_caps;
 		iftype_data->vendor_elems.len = ARRAY_SIZE(iwl_vendor_caps);
@@ -1445,7 +1445,7 @@ iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	 * in 5GHz otherwise the FW will throw a sysassert when we try
 	 * to use them.
 	 */
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		/*
 		 * Unlike the other sections in the NVM, the hw
 		 * section uses big-endian.
@@ -2004,7 +2004,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 			 le32_to_cpu(dword_buff[3]));
 
 		/* nvm file validation, dword_buff[2] holds the file version */
-		if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_8000 &&
+		if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_8000 &&
 		    trans->info.hw_rev_step == SILICON_C_STEP &&
 		    le32_to_cpu(dword_buff[2]) < 0xE4A) {
 			ret = -EFAULT;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
index cb8149874fcb..4f8a63a4c296 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
@@ -75,7 +75,7 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 	if (cfg->ht_params.ldpc)
 		ht_info->cap |= IEEE80211_HT_CAP_LDPC_CODING;
 
-	if (trans->trans_cfg->mq_rx_supported ||
+	if (trans->mac_cfg->mq_rx_supported ||
 	    iwlwifi_mod_params.amsdu_size >= IWL_AMSDU_8K)
 		ht_info->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 87e707e68019..b8165ee2b1e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -158,12 +158,12 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 
 	if (trans->request_top_reset) {
 		trans->request_top_reset = 0;
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_SC)
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC)
 			return IWL_RESET_MODE_TOP_RESET;
 		return IWL_RESET_MODE_PROD_RESET;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
 		escalation_list = escalation_list_sc;
 		escalation_list_size = ARRAY_SIZE(escalation_list_sc);
 	} else {
@@ -253,7 +253,7 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_cfg_trans_params *cfg_trans)
+				  const struct iwl_mac_cfg *mac_cfg)
 {
 	struct iwl_trans *trans;
 #ifdef CONFIG_LOCKDEP
@@ -264,7 +264,7 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 	if (!trans)
 		return NULL;
 
-	trans->trans_cfg = cfg_trans;
+	trans->mac_cfg = mac_cfg;
 
 #ifdef CONFIG_LOCKDEP
 	lockdep_init_map(&trans->sync_cmd_lockdep_map, "sync_cmd_lockdep_map",
@@ -286,10 +286,10 @@ int iwl_trans_init(struct iwl_trans *trans)
 	if (WARN_ON(!trans->info.name || !trans->info.num_rxqs))
 		return -EINVAL;
 
-	if (!trans->trans_cfg->gen2) {
+	if (!trans->mac_cfg->gen2) {
 		txcmd_size = sizeof(struct iwl_tx_cmd);
 		txcmd_align = sizeof(void *);
-	} else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+	} else if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
 		txcmd_size = sizeof(struct iwl_tx_cmd_gen2);
 		txcmd_align = 64;
 	} else {
@@ -301,7 +301,7 @@ int iwl_trans_init(struct iwl_trans *trans)
 	txcmd_size += 36; /* biggest possible 802.11 header */
 
 	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
-	if (WARN_ON(trans->trans_cfg->gen2 && txcmd_size >= txcmd_align))
+	if (WARN_ON(trans->mac_cfg->gen2 && txcmd_size >= txcmd_align))
 		return -EINVAL;
 
 	snprintf(trans->dev_cmd_pool_name, sizeof(trans->dev_cmd_pool_name),
@@ -594,7 +594,7 @@ void iwl_trans_fw_alive(struct iwl_trans *trans)
 
 	trans->state = IWL_TRANS_FW_ALIVE;
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		iwl_trans_pcie_gen2_fw_alive(trans);
 	else
 		iwl_trans_pcie_fw_alive(trans);
@@ -615,7 +615,7 @@ int iwl_trans_start_fw(struct iwl_trans *trans, const struct iwl_fw *fw,
 
 	clear_bit(STATUS_FW_ERROR, &trans->status);
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		ret = iwl_trans_pcie_gen2_start_fw(trans, fw, img,
 						   run_in_rfkill);
 	else
@@ -661,7 +661,7 @@ void iwl_trans_stop_device(struct iwl_trans *trans)
 		iwl_op_mode_dump_error(trans->op_mode, &mode);
 	}
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		iwl_trans_pcie_gen2_stop_device(trans);
 	else
 		iwl_trans_pcie_stop_device(trans);
@@ -680,7 +680,7 @@ int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		      "bad state = %d\n", trans->state))
 		return -EIO;
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		return iwl_txq_gen2_tx(trans, skb, dev_cmd, queue);
 
 	return iwl_trans_pcie_tx(trans, skb, dev_cmd, queue);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 62a200c1a6b9..904df78297f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -855,7 +855,7 @@ struct iwl_trans_info {
  *
  * @csme_own: true if we couldn't get ownership on the device
  * @op_mode: pointer to the op_mode
- * @trans_cfg: the trans-specific configuration part
+ * @mac_cfg: the trans-specific configuration part
  * @cfg: pointer to the configuration
  * @drv: pointer to iwl_drv
  * @conf: configuration set by the opmode before enter
@@ -891,7 +891,7 @@ struct iwl_trans_info {
 struct iwl_trans {
 	bool csme_own;
 	struct iwl_op_mode *op_mode;
-	const struct iwl_cfg_trans_params *trans_cfg;
+	const struct iwl_mac_cfg *mac_cfg;
 	const struct iwl_cfg *cfg;
 	struct iwl_drv *drv;
 	struct iwl_trans_config conf;
@@ -1203,7 +1203,7 @@ static inline void iwl_trans_finish_sw_reset(struct iwl_trans *trans)
  *****************************************************/
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 			  struct device *dev,
-			  const struct iwl_cfg_trans_params *cfg_trans);
+			  const struct iwl_mac_cfg *cfg_trans);
 int iwl_trans_init(struct iwl_trans *trans);
 void iwl_trans_free(struct iwl_trans *trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index cecefa26445f..80f7290ef8b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -580,7 +580,7 @@ iwl_mld_get_omi_bw_reduction_pointers(struct iwl_mld *mld,
 
 	*link_sta = NULL;
 
-	if (mld->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+	if (mld->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
 		return NULL;
 
 	vif = iwl_mld_get_bss_vif(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index c95274c563c3..41b465ace6fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -76,7 +76,7 @@ static int iwl_mld_allocate_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	 */
 	unsigned int watchdog_timeout = txq->vif->type == NL80211_IFTYPE_AP ?
 				IWL_WATCHDOG_DISABLED :
-				mld->trans->trans_cfg->base_params->wd_timeout;
+				mld->trans->mac_cfg->base_params->wd_timeout;
 	int queue, size;
 
 	lockdep_assert_wiphy(mld->wiphy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 21641d41a958..13cdc077d8d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2013-2014, 2018-2020, 2022-2024 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2020, 2022-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  */
 #include <linux/ieee80211.h>
@@ -181,7 +181,7 @@ static int iwl_mvm_bt_coex_reduced_txp(struct iwl_mvm *mvm, u8 sta_id,
 	struct iwl_mvm_sta *mvmsta;
 	u32 value;
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
 	mvmsta = iwl_mvm_sta_from_staid_protected(mvm, sta_id);
@@ -569,7 +569,7 @@ static void iwl_mvm_bt_coex_notif_handle(struct iwl_mvm *mvm)
 					mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
 					iwl_mvm_bt_notif_iterator, &data);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		rcu_read_unlock();
 		return;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d56cc09797f7..507c03198c92 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1370,7 +1370,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	 * recording before entering D3. In later devices the FW stops the
 	 * recording automatically.
 	 */
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_fw_dbg_stop_restart_recording(&mvm->fwrt, NULL, true);
 
 	/* must be last -- this switches firmware state */
@@ -2823,7 +2823,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 				status->qos_seq_ctr[i] + 0x10;
 	}
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		i = mvm->offload_tid;
 		iwl_trans_set_q_ptrs(mvm->trans,
 				     mvm_ap_sta->tid_data[i].txq_id,
@@ -3425,7 +3425,7 @@ static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
 	 * AX210 and above don't need the command since they have
 	 * the doorbell interrupt.
 	 */
-	if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_22000 &&
+	if (mvm->trans->mac_cfg->device_family <= IWL_DEVICE_FAMILY_22000 &&
 	    fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_D0I3_END_FIRST)) {
 		ret = iwl_mvm_send_cmd(mvm, &cmd);
 		if (ret < 0)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 671d3f8d79c1..86a87ea89916 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1277,7 +1277,7 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 		return -EIO;
 
 	/* supporting only MQ RX */
-	if (!mvm->trans->trans_cfg->mq_rx_supported)
+	if (!mvm->trans->mac_cfg->mq_rx_supported)
 		return -EOPNOTSUPP;
 
 	rxb._page = alloc_pages(GFP_ATOMIC, 0);
@@ -1468,7 +1468,7 @@ static ssize_t iwl_dbgfs_fw_dbg_clear_write(struct iwl_mvm *mvm,
 					    char *buf, size_t count,
 					    loff_t *ppos)
 {
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		return -EOPNOTSUPP;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d3ec554d4eba..55a27d772bf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -293,7 +293,7 @@ static void iwl_mvm_print_pd_notification(struct iwl_mvm *mvm)
 	IWL_ERR(mvm, #reg_name ": 0x%x\n", iwl_read_umac_prph(trans, reg_name))
 
 	struct iwl_trans *trans = mvm->trans;
-	enum iwl_device_family device_family = trans->trans_cfg->device_family;
+	enum iwl_device_family device_family = trans->mac_cfg->device_family;
 
 	if (device_family < IWL_DEVICE_FAMILY_8000)
 		return;
@@ -355,7 +355,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	ret = iwl_wait_notification(&mvm->notif_wait, &alive_wait,
 				    MVM_UCODE_ALIVE_TIMEOUT);
 
-	if (mvm->trans->trans_cfg->device_family ==
+	if (mvm->trans->mac_cfg->device_family ==
 	    IWL_DEVICE_FAMILY_AX210) {
 		/* print these registers regardless of alive fail/success */
 		IWL_INFO(mvm, "WFPM_UMAC_PD_NOTIFICATION: 0x%x\n",
@@ -372,14 +372,14 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 		struct iwl_trans *trans = mvm->trans;
 
 		/* SecBoot info */
-		if (trans->trans_cfg->device_family >=
+		if (trans->mac_cfg->device_family >=
 					IWL_DEVICE_FAMILY_22000) {
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
 				iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS),
 				iwl_read_umac_prph(trans,
 						   UMAG_SB_CPU_2_STATUS));
-		} else if (trans->trans_cfg->device_family >=
+		} else if (trans->mac_cfg->device_family >=
 			   IWL_DEVICE_FAMILY_8000) {
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
@@ -390,7 +390,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 		iwl_mvm_print_pd_notification(mvm);
 
 		/* LMAC/UMAC PC info */
-		if (trans->trans_cfg->device_family >=
+		if (trans->mac_cfg->device_family >=
 					IWL_DEVICE_FAMILY_22000) {
 			pc_data = trans->dbg.pc_data;
 			for (count = 0; count < trans->dbg.num_pc;
@@ -398,7 +398,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 				IWL_ERR(mvm, "%s: 0x%x\n",
 					pc_data->pc_name,
 					pc_data->pc_address);
-		} else if (trans->trans_cfg->device_family >=
+		} else if (trans->mac_cfg->device_family >=
 					IWL_DEVICE_FAMILY_9000) {
 			IWL_ERR(mvm, "UMAC PC: 0x%x\n",
 				iwl_read_umac_prph(trans,
@@ -497,7 +497,7 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 	};
 
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
 		IWL_DEBUG_RADIO(mvm, "UATS feature is not supported\n");
 		return;
 	}
@@ -584,7 +584,7 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 
 	/* set flags extra PHY configuration flags from the device's cfg */
 	phy_cfg_cmd.phy_cfg |=
-		cpu_to_le32(mvm->trans->trans_cfg->extra_phy_cfg_flags);
+		cpu_to_le32(mvm->trans->mac_cfg->extra_phy_cfg_flags);
 
 	phy_cfg_cmd.calib_control.event_trigger =
 		mvm->fw->default_calib[ucode_type].event_trigger;
@@ -623,7 +623,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 
 	mvm->rfkill_safe_init_done = false;
 
-	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+	if (mvm->trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
 		sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
 		/* if needed, we'll reset this on our way out later */
 		mvm->fw_product_reset = sb_cfg == SB_CFG_RESIDES_IN_ROM;
@@ -757,7 +757,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 		goto remove_notif;
 	}
 
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000) {
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_8000) {
 		ret = iwl_mvm_send_bt_init_conf(mvm);
 		if (ret)
 			goto remove_notif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/led.c b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
index 1ea7c44250d4..c3cc1ea3ccc9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2025 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #include <linux/leds.h>
@@ -102,7 +102,7 @@ void iwl_mvm_leds_sync(struct iwl_mvm *mvm)
 	 * if we control through the register, we're doing it
 	 * even when the firmware isn't up, so no need to sync
 	 */
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		return;
 
 	iwl_mvm_led_set(mvm, mvm->led.brightness > 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a968f5401da1..a9b5fb2a56de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -311,8 +311,8 @@ int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	/* This has been tested on those devices only */
-	if (mvm->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
-	    mvm->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_22000)
+	if (mvm->trans->mac_cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
+	    mvm->trans->mac_cfg->device_family != IWL_DEVICE_FAMILY_22000)
 		return -EOPNOTSUPP;
 
 	if (!mvm->nvm_data)
@@ -391,7 +391,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	 * for older devices. We also don't see this issue on any newer
 	 * devices.
 	 */
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000)
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000)
 		ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, TX_FRAG_LIST);
 
@@ -402,7 +402,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	/* We want to use the mac80211's reorder buffer for 9000 */
 	if (iwl_mvm_has_new_rx_api(mvm) &&
-	    mvm->trans->trans_cfg->device_family > IWL_DEVICE_FAMILY_9000)
+	    mvm->trans->mac_cfg->device_family > IWL_DEVICE_FAMILY_9000)
 		ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 
 	if (fw_has_capa(&mvm->fw->ucode_capa,
@@ -544,7 +544,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->regulatory_flags |= REGULATORY_CUSTOM_REG |
 					       REGULATORY_DISABLE_BEACON_HINTS;
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_DFS_CONCURRENT);
 
@@ -1379,7 +1379,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm, bool suspend)
 		iwl_mvm_rm_aux_sta(mvm);
 
 	if (suspend &&
-	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+	    mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		iwl_mvm_fast_suspend(mvm);
 		/* From this point on, we won't touch the device */
 		iwl_mvm_mei_device_state(mvm, false);
@@ -3052,7 +3052,7 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	 * context. For the newer, the beacon is a resource that belongs to a
 	 * MAC, so need to send beacon template after adding the mac.
 	 */
-	if (mvm->trans->trans_cfg->device_family > IWL_DEVICE_FAMILY_22000) {
+	if (mvm->trans->mac_cfg->device_family > IWL_DEVICE_FAMILY_22000) {
 		/* Add the mac context */
 		ret = iwl_mvm_mac_ctxt_add(mvm, vif);
 		if (ret)
@@ -4389,7 +4389,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
-		if (!mvm->trans->trans_cfg->gen2) {
+		if (!mvm->trans->mac_cfg->gen2) {
 			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
 			key->flags |= IEEE80211_KEY_FLAG_PUT_IV_SPACE;
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 8f275397fddf..b810fd167046 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -148,7 +148,7 @@ int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 {
 	int ret, txq;
 	unsigned int wdg_timeout = _wdg_timeout ? *_wdg_timeout :
-		mvm->trans->trans_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base_params->wd_timeout;
 
 	if (WARN_ON_ONCE(sta->sta_id == IWL_INVALID_STA))
 		return -ENOSPC;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 75e7e0a69624..96eb29698a6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1623,13 +1623,13 @@ static inline bool iwl_mvm_has_new_station_api(const struct iwl_fw *fw)
 static inline bool iwl_mvm_has_new_tx_api(struct iwl_mvm *mvm)
 {
 	/* TODO - replace with TLV once defined */
-	return mvm->trans->trans_cfg->gen2;
+	return mvm->trans->mac_cfg->gen2;
 }
 
 static inline bool iwl_mvm_has_unified_ucode(struct iwl_mvm *mvm)
 {
 	/* TODO - better define this */
-	return mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000;
+	return mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000;
 }
 
 static inline bool iwl_mvm_is_cdb_supported(struct iwl_mvm *mvm)
@@ -1654,7 +1654,7 @@ static inline bool iwl_mvm_cdb_scan_api(struct iwl_mvm *mvm)
 	 * but then there's a little bit of code in scan that won't make
 	 * any sense...
 	 */
-	return mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000;
+	return mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000;
 }
 
 static inline bool iwl_mvm_is_scan_ext_chan_supported(struct iwl_mvm *mvm)
@@ -1768,7 +1768,7 @@ extern const u8 iwl_mvm_ac_to_bz_tx_fifo[];
 static inline u8 iwl_mvm_mac_ac_to_tx_fifo(struct iwl_mvm *mvm,
 					   enum ieee80211_ac_numbers ac)
 {
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		return iwl_mvm_ac_to_bz_tx_fifo[ac];
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return iwl_mvm_ac_to_gen2_tx_fifo[ac];
@@ -2457,7 +2457,7 @@ void iwl_mvm_vif_set_low_latency(struct iwl_mvm_vif *mvmvif, bool set,
  */
 static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 {
-	return ((BIT(mvm->trans->trans_cfg->base_params->num_of_queues) - 1) &
+	return ((BIT(mvm->trans->mac_cfg->base_params->num_of_queues) - 1) &
 		~BIT(IWL_MVM_DQA_CMD_QUEUE));
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 734f9e814a54..9e4a70a21f47 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -191,7 +191,7 @@ static int iwl_nvm_read_section(struct iwl_mvm *mvm, u16 section,
 	while (ret == length) {
 		/* Check no memory assumptions fail and cause an overflow */
 		if ((size_read + offset + length) >
-		    mvm->trans->trans_cfg->base_params->eeprom_size) {
+		    mvm->trans->mac_cfg->base_params->eeprom_size) {
 			IWL_ERR(mvm, "EEPROM size is too small for NVM\n");
 			return -ENOBUFS;
 		}
@@ -316,7 +316,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 	/* Read From FW NVM */
 	IWL_DEBUG_EEPROM(mvm->trans->dev, "Read from NVM\n");
 
-	nvm_buffer = kmalloc(mvm->trans->trans_cfg->base_params->eeprom_size,
+	nvm_buffer = kmalloc(mvm->trans->mac_cfg->base_params->eeprom_size,
 			     GFP_KERNEL);
 	if (!nvm_buffer)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9797788d2fce..e378df38eb2e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -92,7 +92,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	IWL_DEBUG_INFO(mvm, "Radio type=0x%x-0x%x-0x%x\n", radio_cfg_type,
 		       radio_cfg_step, radio_cfg_dash);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return;
 
 	/* SKU control */
@@ -114,7 +114,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	 * unrelated errors. Need to further investigate this, but for now
 	 * we'll separate cases.
 	 */
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		reg_val |= CSR_HW_IF_CONFIG_REG_BIT_RADIO_SI;
 
 	if (iwl_fw_dbg_is_d3_debug_enabled(&mvm->fwrt))
@@ -1312,7 +1312,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (!hw)
 		return ERR_PTR(-ENOMEM);
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		max_agg = 512;
 	else
 		max_agg = IEEE80211_MAX_AMPDU_BUF_HE;
@@ -1380,7 +1380,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (iwl_mvm_has_new_rx_api(mvm)) {
 		op_mode->ops = &iwl_mvm_ops_mq;
 		trans->conf.rx_mpdu_cmd_hdr_size =
-			(trans->trans_cfg->device_family >=
+			(trans->mac_cfg->device_family >=
 			 IWL_DEVICE_FAMILY_AX210) ?
 			sizeof(struct iwl_rx_mpdu_desc) :
 			IWL_RX_DESC_SIZE_V1;
@@ -2137,7 +2137,7 @@ static bool iwl_mvm_sw_reset(struct iwl_op_mode *op_mode,
 			mvm->fwrt.trans->dbg.restart_required = false;
 			ieee80211_restart_hw(mvm->hw);
 			return true;
-		} else if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_8000) {
+		} else if (mvm->trans->mac_cfg->device_family <= IWL_DEVICE_FAMILY_8000) {
 			ieee80211_restart_hw(mvm->hw);
 			return true;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a9ff3e592a0c..5802ed80a9ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3311,7 +3311,7 @@ static void rs_build_rates_table_from_fixed(struct iwl_mvm *mvm,
 	if (num_of_ant(ant) == 1)
 		lq_cmd->single_stream_ant_msk = ant;
 
-	if (!mvm->trans->trans_cfg->gen2)
+	if (!mvm->trans->mac_cfg->gen2)
 		lq_cmd->agg_frame_cnt_limit = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	else
 		lq_cmd->agg_frame_cnt_limit =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 2799a5e05790..077aadbf95db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -171,7 +171,7 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 			      shdr->type != htons(ETH_P_PAE) &&
 			      shdr->type != htons(ETH_P_TDLS))))
 			skb->ip_summed = CHECKSUM_NONE;
-		else if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		else if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
 			/* mac80211 assumes full CSUM including SNAP header */
 			skb_postpush_rcsum(skb, shdr, sizeof(*shdr));
 	}
@@ -409,7 +409,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		    !(status & IWL_RX_MPDU_RES_STATUS_TTAK_OK))
 			return 0;
 
-		if (mvm->trans->trans_cfg->gen2 &&
+		if (mvm->trans->mac_cfg->gen2 &&
 		    !(status & RX_MPDU_RES_STATUS_MIC_OK))
 			stats->flag |= RX_FLAG_MMIC_ERROR;
 
@@ -426,7 +426,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 		if (pkt_flags & FH_RSCSR_RADA_EN) {
 			stats->flag |= RX_FLAG_ICV_STRIPPED;
-			if (mvm->trans->trans_cfg->gen2)
+			if (mvm->trans->mac_cfg->gen2)
 				stats->flag |= RX_FLAG_MMIC_STRIPPED;
 		}
 
@@ -462,7 +462,7 @@ static void iwl_mvm_rx_csum(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_mpdu_desc *desc = (void *)pkt->data;
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		if (pkt->len_n_flags & cpu_to_le32(FH_RSCSR_RPA_EN)) {
 			u16 hwsum = be16_to_cpu(desc->v3.raw_xsum);
 
@@ -744,7 +744,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	baid = (reorder & IWL_RX_MPDU_REORDER_BAID_MASK) >>
 		IWL_RX_MPDU_REORDER_BAID_SHIFT;
 
-	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000)
+	if (mvm->trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_9000)
 		return false;
 
 	/*
@@ -2048,7 +2048,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		desc_size = sizeof(*desc);
 	else
 		desc_size = IWL_RX_DESC_SIZE_V1;
@@ -2058,7 +2058,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		return;
 	}
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		phy_data.rate_n_flags =
 			iwl_mvm_v3_rate_from_fw(desc->v3.rate_n_flags,
 						mvm->fw_rates_ver);
@@ -2142,7 +2142,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (likely(!(phy_data.phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD))) {
 		u64 tsf_on_air_rise;
 
-		if (mvm->trans->trans_cfg->device_family >=
+		if (mvm->trans->mac_cfg->device_family >=
 		    IWL_DEVICE_FAMILY_AX210)
 			tsf_on_air_rise = le64_to_cpu(desc->v3.tsf_on_air_rise);
 		else
@@ -2301,7 +2301,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 			*qc &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 
-			if (mvm->trans->trans_cfg->device_family ==
+			if (mvm->trans->mac_cfg->device_family ==
 			    IWL_DEVICE_FAMILY_9000) {
 				iwl_mvm_flip_address(hdr->addr3);
 
@@ -2347,7 +2347,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc) &&
 	    likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2)) &&
 	    likely(!iwl_mvm_mei_filter_scan(mvm, skb))) {
-		if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
+		if (mvm->trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
 		    (desc->mac_flags2 & IWL_RX_MPDU_MFLG2_AMSDU) &&
 		    !(desc->amsdu_info & IWL_RX_MPDU_AMSDU_LAST_SUBFRAME))
 			rx_status->flag |= RX_FLAG_AMSDU_MORE;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 4f672732c4e0..5393e98d2a08 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -791,10 +791,10 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN(maxq >= mvm->trans->trans_cfg->base_params->num_of_queues,
+	if (WARN(maxq >= mvm->trans->mac_cfg->base_params->num_of_queues,
 		 "max queue %d >= num_of_queues (%d)", maxq,
-		 mvm->trans->trans_cfg->base_params->num_of_queues))
-		maxq = mvm->trans->trans_cfg->base_params->num_of_queues - 1;
+		 mvm->trans->mac_cfg->base_params->num_of_queues))
+		maxq = mvm->trans->mac_cfg->base_params->num_of_queues - 1;
 
 	/* This should not be hit with new TX path */
 	if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
@@ -1765,7 +1765,7 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		mvm_sta->deflink.sta_id = sta_id;
 		rcu_assign_pointer(mvm_sta->link[0], &mvm_sta->deflink);
 
-		if (!mvm->trans->trans_cfg->gen2)
+		if (!mvm->trans->mac_cfg->gen2)
 			mvm_sta->deflink.lq_sta.rs_drv.pers.max_agg_bufsize =
 				LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 		else
@@ -2189,7 +2189,7 @@ static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
 					  u8 sta_id, u8 fifo)
 {
 	unsigned int wdg_timeout =
-		mvm->trans->trans_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base_params->wd_timeout;
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.fifo = fifo,
 		.sta_id = sta_id,
@@ -2206,7 +2206,7 @@ static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
 static int iwl_mvm_enable_aux_snif_queue_tvqm(struct iwl_mvm *mvm, u8 sta_id)
 {
 	unsigned int wdg_timeout =
-		mvm->trans->trans_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base_params->wd_timeout;
 
 	WARN_ON(!iwl_mvm_has_new_tx_api(mvm));
 
@@ -3177,7 +3177,7 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
 	normalized_ssn = tid_data->ssn;
-	if (mvm->trans->trans_cfg->gen2)
+	if (mvm->trans->mac_cfg->gen2)
 		normalized_ssn &= 0xff;
 
 	if (normalized_ssn == tid_data->next_reclaimed) {
@@ -4305,7 +4305,7 @@ u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data)
 	 * In 22000 HW, the next_reclaimed index is only 8 bit, so we'll need
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
-	if (mvm->trans->trans_cfg->gen2)
+	if (mvm->trans->mac_cfg->gen2)
 		sn &= 0xff;
 
 	return ieee80211_sn_sub(sn, tid_data->next_reclaimed);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index dd6e5559d31d..a8a2c77e5696 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -532,7 +532,7 @@ static bool iwl_mvm_use_host_rate(struct iwl_mvm *mvm,
 	 * (since we don't necesarily know the link), but FW rate
 	 * selection was fixed.
 	 */
-	return mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ;
+	return mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ;
 }
 
 static void iwl_mvm_copy_hdr(void *cmd, const void *hdr, int hdrlen,
@@ -598,7 +598,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			flags |= IWL_TX_FLAGS_HIGH_PRI;
 		}
 
-		if (mvm->trans->trans_cfg->device_family >=
+		if (mvm->trans->mac_cfg->device_family >=
 		    IWL_DEVICE_FAMILY_AX210) {
 			struct iwl_tx_cmd_gen3 *cmd = (void *)dev_cmd->payload;
 			u32 offload_assist = iwl_mvm_tx_csum(mvm, skb,
@@ -1376,7 +1376,7 @@ static void iwl_mvm_check_ratid_empty(struct iwl_mvm *mvm,
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
 	normalized_ssn = tid_data->ssn;
-	if (mvm->trans->trans_cfg->gen2)
+	if (mvm->trans->mac_cfg->gen2)
 		normalized_ssn &= 0xff;
 
 	if (normalized_ssn != tid_data->next_reclaimed)
@@ -1575,7 +1575,7 @@ static inline u32 iwl_mvm_get_scd_ssn(struct iwl_mvm *mvm,
 	u32 val = le32_to_cpup((__le32 *)iwl_mvm_get_agg_status(mvm, tx_resp) +
 			       tx_resp->frame_count);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return val & 0xFFFF;
 	return val & 0xFFF;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 4416d35b1bcf..2deda1dbd64f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -742,7 +742,7 @@ unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif)
 {
 	unsigned int default_timeout =
-		mvm->trans->trans_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base_params->wd_timeout;
 
 	/*
 	 * We can't know when the station is asleep or awake, so we
@@ -1181,7 +1181,7 @@ u32 iwl_mvm_get_systime(struct iwl_mvm *mvm)
 {
 	u32 reg_addr = DEVICE_SYSTEM_TIME_REG;
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000 &&
+	if (mvm->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_22000 &&
 	    mvm->trans->cfg->gp2_reg_addr)
 		reg_addr = mvm->trans->cfg->gp2_reg_addr;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 05876aea42e3..2ac03ed56a95 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -158,7 +158,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	control_flags |= IWL_PRPH_SCRATCH_MTR_MODE;
 	control_flags |= IWL_PRPH_MTR_FORMAT_256B & IWL_PRPH_SCRATCH_MTR_FORMAT;
 
-	if (trans->trans_cfg->imr_enabled)
+	if (trans->mac_cfg->imr_enabled)
 		control_flags |= IWL_PRPH_SCRATCH_IMR_DEBUG_EN;
 
 	if (CSR_HW_REV_TYPE(trans->info.hw_rev) == IWL_CFG_MAC_TYPE_GL &&
@@ -170,7 +170,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	}
 
 	if (trans->do_top_reset) {
-		WARN_ON(trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC);
+		WARN_ON(trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC);
 		control_flags |= IWL_PRPH_SCRATCH_TOP_RESET;
 	}
 
@@ -456,7 +456,7 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 	if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
 		return -EBUSY;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
 	if (!pnvm_payloads->n_chunks) {
@@ -524,7 +524,7 @@ static void iwl_pcie_set_contig_pnvm(struct iwl_trans *trans)
 void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 					   const struct iwl_ucode_capabilities *capa)
 {
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
 	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
@@ -547,7 +547,7 @@ int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
 	if (trans->reduce_power_loaded)
 		return 0;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
 	if (WARN_ON(prph_sc_ctrl->reduce_power_cfg.size))
@@ -607,7 +607,7 @@ void
 iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 					      const struct iwl_ucode_capabilities *capa)
 {
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
 	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 94c1b844a6b1..b3eb6ceb4648 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -21,7 +21,7 @@
 							 struct _struct)
 extern int _invalid_type;
 #define _TRANS_CFG_CHECK(cfg)						\
-	(__builtin_choose_expr(_IS_A(cfg, iwl_cfg_trans_params),	\
+	(__builtin_choose_expr(_IS_A(cfg, iwl_mac_cfg),	\
 			       0, _invalid_type))
 #define _ASSIGN_CFG(cfg) (_TRANS_CFG_CHECK(cfg) + (kernel_ulong_t)&(cfg))
 
@@ -33,515 +33,515 @@ extern int _invalid_type;
 /* Hardware specific file defines the PCI IDs table for that hardware module */
 VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 #if IS_ENABLED(CONFIG_IWLDVM)
-	{IWL_PCI_DEVICE(0x4232, 0x1201, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1301, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1204, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1304, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1205, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1305, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1206, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1306, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1221, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1321, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1224, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1324, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1225, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1325, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1226, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1326, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1211, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1311, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1214, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1314, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1215, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1315, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1216, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1316, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1201, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1301, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1204, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1304, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1205, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1305, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1206, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1306, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1221, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1321, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1224, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1324, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1225, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1325, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1226, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1326, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1211, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1311, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1214, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1314, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1215, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1315, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1216, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1316, iwl5000_mac_cfg)}, /* Half Mini Card */
 
 /* 5300 Series WiFi */
-	{IWL_PCI_DEVICE(0x4235, 0x1021, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1121, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1024, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1124, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1001, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1101, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1004, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1104, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1011, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1111, iwl5000_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1014, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1114, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1021, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1121, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1024, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1124, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1001, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1101, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1004, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1104, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1011, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1111, iwl5000_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1014, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1114, iwl5000_mac_cfg)}, /* Half Mini Card */
 
 /* 5350 Series WiFi/WiMax */
-	{IWL_PCI_DEVICE(0x423A, 0x1001, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423A, 0x1021, iwl5000_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423B, 0x1011, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423A, 0x1001, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423A, 0x1021, iwl5000_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423B, 0x1011, iwl5000_mac_cfg)}, /* Mini Card */
 
 /* 5150 Series Wifi/WiMax */
-	{IWL_PCI_DEVICE(0x423C, 0x1201, iwl5150_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1301, iwl5150_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1206, iwl5150_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1306, iwl5150_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1221, iwl5150_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1321, iwl5150_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1326, iwl5150_trans_cfg)}, /* Half Mini Card */
-
-	{IWL_PCI_DEVICE(0x423D, 0x1211, iwl5150_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423D, 0x1311, iwl5150_trans_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423D, 0x1216, iwl5150_trans_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423D, 0x1316, iwl5150_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1201, iwl5150_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1301, iwl5150_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1206, iwl5150_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1306, iwl5150_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1221, iwl5150_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1321, iwl5150_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1326, iwl5150_mac_cfg)}, /* Half Mini Card */
+
+	{IWL_PCI_DEVICE(0x423D, 0x1211, iwl5150_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423D, 0x1311, iwl5150_mac_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423D, 0x1216, iwl5150_mac_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423D, 0x1316, iwl5150_mac_cfg)}, /* Half Mini Card */
 
 /* 6x00 Series */
-	{IWL_PCI_DEVICE(0x422B, 0x1101, iwl6000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422B, 0x1108, iwl6000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422B, 0x1121, iwl6000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422B, 0x1128, iwl6000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1301, iwl6000i_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1306, iwl6000i_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1307, iwl6000i_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1321, iwl6000i_trans_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1326, iwl6000i_trans_cfg)},
-	{IWL_PCI_DEVICE(0x4238, 0x1111, iwl6000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x4238, 0x1118, iwl6000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x4239, 0x1311, iwl6000i_trans_cfg)},
-	{IWL_PCI_DEVICE(0x4239, 0x1316, iwl6000i_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1101, iwl6000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1108, iwl6000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1121, iwl6000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1128, iwl6000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1301, iwl6000i_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1306, iwl6000i_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1307, iwl6000i_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1321, iwl6000i_mac_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1326, iwl6000i_mac_cfg)},
+	{IWL_PCI_DEVICE(0x4238, 0x1111, iwl6000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x4238, 0x1118, iwl6000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x4239, 0x1311, iwl6000i_mac_cfg)},
+	{IWL_PCI_DEVICE(0x4239, 0x1316, iwl6000i_mac_cfg)},
 
 /* 6x05 Series */
-	{IWL_PCI_DEVICE(0x0082, 0x1301, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1306, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1307, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1308, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1321, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1326, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1328, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0x1311, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0x1318, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0x1316, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0xC020, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0xC220, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0xC228, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x4820, iwl6005_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1304, iwl6005_trans_cfg)},/* low 5GHz active */
-	{IWL_PCI_DEVICE(0x0082, 0x1305, iwl6005_trans_cfg)},/* high 5GHz active */
+	{IWL_PCI_DEVICE(0x0082, 0x1301, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1306, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1307, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1308, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1321, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1326, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1328, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0x1311, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0x1318, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0x1316, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0xC020, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0xC220, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0xC228, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x4820, iwl6005_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1304, iwl6005_mac_cfg)},/* low 5GHz active */
+	{IWL_PCI_DEVICE(0x0082, 0x1305, iwl6005_mac_cfg)},/* high 5GHz active */
 
 /* 6x30 Series */
-	{IWL_PCI_DEVICE(0x008A, 0x5305, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5307, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5325, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5327, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x008B, 0x5315, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x008B, 0x5317, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0090, 0x5211, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0090, 0x5215, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0090, 0x5216, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5201, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5205, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5206, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5207, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5221, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5225, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5226, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5305, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5307, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5325, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5327, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008B, 0x5315, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008B, 0x5317, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0090, 0x5211, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0090, 0x5215, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0090, 0x5216, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5201, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5205, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5206, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5207, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5221, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5225, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5226, iwl6030_mac_cfg)},
 
 /* 6x50 WiFi/WiMax Series */
-	{IWL_PCI_DEVICE(0x0087, 0x1301, iwl6050_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0087, 0x1306, iwl6050_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0087, 0x1321, iwl6050_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0087, 0x1326, iwl6050_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0089, 0x1311, iwl6050_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0089, 0x1316, iwl6050_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1301, iwl6050_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1306, iwl6050_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1321, iwl6050_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1326, iwl6050_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0089, 0x1311, iwl6050_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0089, 0x1316, iwl6050_mac_cfg)},
 
 /* 6150 WiFi/WiMax Series */
-	{IWL_PCI_DEVICE(0x0885, 0x1305, iwl6150_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0885, 0x1307, iwl6150_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0885, 0x1325, iwl6150_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0885, 0x1327, iwl6150_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0886, 0x1315, iwl6150_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0886, 0x1317, iwl6150_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1305, iwl6150_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1307, iwl6150_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1325, iwl6150_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1327, iwl6150_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0886, 0x1315, iwl6150_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0886, 0x1317, iwl6150_mac_cfg)},
 
 /* 1000 Series WiFi */
-	{IWL_PCI_DEVICE(0x0083, 0x1205, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1305, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1225, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1325, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1215, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1315, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1206, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1306, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1226, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1326, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1216, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1316, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1205, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1305, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1225, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1325, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1215, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1315, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1206, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1306, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1226, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1326, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1216, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1316, iwl1000_mac_cfg)},
 
 /* 100 Series WiFi */
-	{IWL_PCI_DEVICE(0x08AE, 0x1005, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08AE, 0x1007, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08AF, 0x1015, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08AF, 0x1017, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08AE, 0x1025, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08AE, 0x1027, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1005, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1007, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08AF, 0x1015, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08AF, 0x1017, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1025, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1027, iwl1000_mac_cfg)},
 
 /* 130 Series WiFi */
-	{IWL_PCI_DEVICE(0x0896, 0x5005, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5007, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0897, 0x5015, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0897, 0x5017, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5025, iwl1000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5027, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5005, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5007, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0897, 0x5015, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0897, 0x5017, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5025, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5027, iwl1000_mac_cfg)},
 
 /* 2x00 Series */
-	{IWL_PCI_DEVICE(0x0890, 0x4022, iwl2000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0891, 0x4222, iwl2000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0890, 0x4422, iwl2000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0890, 0x4822, iwl2000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0890, 0x4022, iwl2000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0891, 0x4222, iwl2000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0890, 0x4422, iwl2000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0890, 0x4822, iwl2000_mac_cfg)},
 
 /* 2x30 Series */
-	{IWL_PCI_DEVICE(0x0887, 0x4062, iwl2030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0888, 0x4262, iwl2030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0887, 0x4462, iwl2030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0887, 0x4062, iwl2030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0888, 0x4262, iwl2030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0887, 0x4462, iwl2030_mac_cfg)},
 
 /* 6x35 Series */
-	{IWL_PCI_DEVICE(0x088E, 0x4060, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x406A, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x088F, 0x4260, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x088F, 0x426A, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x4460, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x446A, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x4860, iwl6030_trans_cfg)},
-	{IWL_PCI_DEVICE(0x088F, 0x5260, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x4060, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x406A, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x088F, 0x4260, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x088F, 0x426A, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x4460, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x446A, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x4860, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x088F, 0x5260, iwl6030_mac_cfg)},
 
 /* 105 Series */
-	{IWL_PCI_DEVICE(0x0894, 0x0022, iwl105_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0895, 0x0222, iwl105_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0894, 0x0422, iwl105_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0894, 0x0822, iwl105_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0894, 0x0022, iwl105_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0895, 0x0222, iwl105_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0894, 0x0422, iwl105_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0894, 0x0822, iwl105_mac_cfg)},
 
 /* 135 Series */
-	{IWL_PCI_DEVICE(0x0892, 0x0062, iwl135_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0893, 0x0262, iwl135_trans_cfg)},
-	{IWL_PCI_DEVICE(0x0892, 0x0462, iwl135_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0892, 0x0062, iwl135_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0893, 0x0262, iwl135_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0892, 0x0462, iwl135_mac_cfg)},
 #endif /* CONFIG_IWLDVM */
 
 #if IS_ENABLED(CONFIG_IWLMVM)
 /* 7260 Series */
-	{IWL_PCI_DEVICE(0x08B1, 0x4070, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4072, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4170, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4C60, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4C70, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4060, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x406A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4160, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4062, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4162, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4270, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4272, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4260, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x426A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4262, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4470, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4472, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4460, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x446A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4462, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4870, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x486E, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4A70, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4A6E, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4A6C, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4570, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4560, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4370, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4360, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5070, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5072, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5170, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5770, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4020, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x402A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4220, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4420, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC070, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC072, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC170, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC060, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC06A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC160, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC062, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC162, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC770, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC760, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC270, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xCC70, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xCC60, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC272, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC260, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC26A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC262, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC470, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC472, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC460, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC462, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC570, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC560, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC370, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC360, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC020, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC02A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC220, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC420, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4070, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4072, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4170, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4C60, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4C70, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4060, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x406A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4160, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4062, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4162, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4270, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4272, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4260, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x426A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4262, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4470, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4472, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4460, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x446A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4462, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4870, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x486E, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4A70, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4A6E, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4A6C, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4570, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4560, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4370, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4360, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5070, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5072, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5170, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5770, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4020, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x402A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4220, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4420, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC070, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC072, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC170, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC060, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC06A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC160, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC062, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC162, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC770, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC760, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC270, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xCC70, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xCC60, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC272, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC260, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC26A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC262, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC470, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC472, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC460, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC462, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC570, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC560, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC370, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC360, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC020, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC02A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC220, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC420, iwl7000_mac_cfg)},
 
 /* 3160 Series */
-	{IWL_PCI_DEVICE(0x08B3, 0x0070, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0072, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0170, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0172, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0060, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0062, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x0270, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x0272, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0470, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0472, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x0370, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8070, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8072, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8170, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8172, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8060, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8062, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x8270, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x8370, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x8272, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8470, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8570, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x1070, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x1170, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0070, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0072, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0170, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0172, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0060, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0062, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x0270, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x0272, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0470, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0472, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x0370, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8070, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8072, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8170, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8172, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8060, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8062, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x8270, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x8370, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x8272, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8470, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8570, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x1070, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x1170, iwl7000_mac_cfg)},
 
 /* 3165 Series */
-	{IWL_PCI_DEVICE(0x3165, 0x4010, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4012, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3166, 0x4212, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4410, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4510, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4110, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3166, 0x4310, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3166, 0x4210, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x8010, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x8110, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4010, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4012, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3166, 0x4212, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4410, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4510, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4110, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3166, 0x4310, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3166, 0x4210, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x8010, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x8110, iwl7000_mac_cfg)},
 
 /* 3168 Series */
-	{IWL_PCI_DEVICE(0x24FB, 0x2010, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x2110, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x2050, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x2150, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x0000, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2010, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2110, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2050, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2150, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x0000, iwl7000_mac_cfg)},
 
 /* 7265 Series */
-	{IWL_PCI_DEVICE(0x095A, 0x5010, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5110, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5100, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5310, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5302, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5210, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5C10, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5012, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5412, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5410, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5510, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5400, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x1010, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5000, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x500A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5200, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5002, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5102, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5202, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9010, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9012, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x900A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9110, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9112, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x9210, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x9200, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9510, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x9310, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9410, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5020, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x502A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5420, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5090, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5190, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5590, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5290, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5490, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5F10, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5212, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x520A, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9000, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9400, iwl7000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9E10, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5010, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5110, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5100, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5310, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5302, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5210, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5C10, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5012, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5412, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5410, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5510, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5400, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x1010, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5000, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x500A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5200, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5002, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5102, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5202, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9010, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9012, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x900A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9110, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9112, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x9210, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x9200, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9510, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x9310, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9410, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5020, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x502A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5420, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5090, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5190, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5590, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5290, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5490, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5F10, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5212, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x520A, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9000, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9400, iwl7000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9E10, iwl7000_mac_cfg)},
 
 /* 8000 Series */
-	{IWL_PCI_DEVICE(0x24F3, 0x0010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x10B0, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0130, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1130, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0132, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1132, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x01F0, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0012, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1012, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0250, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0150, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1150, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x0030, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x1030, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xC010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xC110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xD010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xC050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xD050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xD0B0, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xB0B0, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x8030, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x9030, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0xC030, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0xD030, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8130, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9130, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8132, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9132, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8150, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9150, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0004, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0044, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F5, 0x0010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F6, 0x0030, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0810, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0910, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0850, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0950, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0930, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0000, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x4010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1130, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0130, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x10D0, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0150, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x9010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8050, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8010, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0810, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x9110, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8130, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0910, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0930, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0950, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0850, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1014, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x3E02, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x3E01, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1012, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0012, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0014, iwl8000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x10B0, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0130, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1130, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0132, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1132, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x01F0, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0012, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1012, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0250, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0150, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1150, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x0030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x1030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xC010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xC110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xD010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xC050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xD050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xD0B0, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xB0B0, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x8030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x9030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0xC030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0xD030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8130, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9130, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8132, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9132, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8150, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9150, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0004, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0044, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F5, 0x0010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F6, 0x0030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0810, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0910, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0850, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0950, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0930, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0000, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x4010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1130, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0130, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x10D0, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0150, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x9010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8050, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0810, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x9110, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8130, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0910, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0930, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0950, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0850, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1014, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x3E02, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x3E01, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1012, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0012, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0014, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8000_mac_cfg)},
 
 /* 9000 Series */
-	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9560_long_latency_trans_cfg)},
-	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9560_shared_clk_trans_cfg)},
-	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9560_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9560_long_latency_mac_cfg)},
+	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9560_shared_clk_mac_cfg)},
+	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9560_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9560_mac_cfg)},
 
 /* Qu devices */
-	{IWL_PCI_DEVICE(0x02F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
-	{IWL_PCI_DEVICE(0x06F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+	{IWL_PCI_DEVICE(0x02F0, PCI_ANY_ID, iwl_qu_mac_cfg)},
+	{IWL_PCI_DEVICE(0x06F0, PCI_ANY_ID, iwl_qu_mac_cfg)},
 
-	{IWL_PCI_DEVICE(0x34F0, PCI_ANY_ID, iwl_qu_medium_latency_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3DF0, PCI_ANY_ID, iwl_qu_medium_latency_trans_cfg)},
-	{IWL_PCI_DEVICE(0x4DF0, PCI_ANY_ID, iwl_qu_medium_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x34F0, PCI_ANY_ID, iwl_qu_medium_latency_mac_cfg)},
+	{IWL_PCI_DEVICE(0x3DF0, PCI_ANY_ID, iwl_qu_medium_latency_mac_cfg)},
+	{IWL_PCI_DEVICE(0x4DF0, PCI_ANY_ID, iwl_qu_medium_latency_mac_cfg)},
 
-	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_long_latency_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_long_latency_mac_cfg)},
 
-	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_trans_cfg)},
+	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_mac_cfg)},
 
 /* So devices */
-	{IWL_PCI_DEVICE(0x2725, PCI_ANY_ID, iwl_so_trans_cfg)},
-	{IWL_PCI_DEVICE(0x7A70, PCI_ANY_ID, iwl_so_long_latency_imr_trans_cfg)},
-	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_trans_cfg)},
-	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
-	{IWL_PCI_DEVICE(0x51F1, PCI_ANY_ID, iwl_so_long_latency_imr_trans_cfg)},
-	{IWL_PCI_DEVICE(0x54F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
-	{IWL_PCI_DEVICE(0x7F70, PCI_ANY_ID, iwl_so_trans_cfg)},
+	{IWL_PCI_DEVICE(0x2725, PCI_ANY_ID, iwl_so_mac_cfg)},
+	{IWL_PCI_DEVICE(0x7A70, PCI_ANY_ID, iwl_so_long_latency_imr_mac_cfg)},
+	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_mac_cfg)},
+	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_mac_cfg)},
+	{IWL_PCI_DEVICE(0x51F1, PCI_ANY_ID, iwl_so_long_latency_imr_mac_cfg)},
+	{IWL_PCI_DEVICE(0x54F0, PCI_ANY_ID, iwl_so_long_latency_mac_cfg)},
+	{IWL_PCI_DEVICE(0x7F70, PCI_ANY_ID, iwl_so_mac_cfg)},
 
 /* Ma devices */
-	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_trans_cfg)},
-	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_trans_cfg)},
+	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_mac_cfg)},
+	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_mac_cfg)},
 #endif /* CONFIG_IWLMVM */
 #if IS_ENABLED(CONFIG_IWLMLD)
 /* Bz devices */
-	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_gl_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0000, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0090, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0094, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0098, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x009C, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x00C0, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x00C4, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x00E0, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x00E4, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x00E8, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x00EC, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0100, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0110, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0114, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0118, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x011C, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0310, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0314, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0510, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x0A10, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x1671, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x1672, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x1771, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x1772, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x1791, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x1792, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x4090, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x40C4, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x40E0, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x4110, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, 0x4314, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0x4D40, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_gl_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0000, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0090, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0094, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0098, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x009C, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00C0, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00C4, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E0, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E4, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E8, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00EC, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0100, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0110, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0114, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0118, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x011C, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0310, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0314, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0510, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0A10, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1671, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1672, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1771, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1772, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1791, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1792, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4090, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x40C4, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x40E0, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4110, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4314, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0x4D40, PCI_ANY_ID, iwl_bz_mac_cfg)},
 
 /* Sc devices */
-	{IWL_PCI_DEVICE(0xE440, PCI_ANY_ID, iwl_sc_trans_cfg)},
-	{IWL_PCI_DEVICE(0xE340, PCI_ANY_ID, iwl_sc_trans_cfg)},
-	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_trans_cfg)},
-	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_trans_cfg)},
+	{IWL_PCI_DEVICE(0xE440, PCI_ANY_ID, iwl_sc_mac_cfg)},
+	{IWL_PCI_DEVICE(0xE340, PCI_ANY_ID, iwl_sc_mac_cfg)},
+	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_mac_cfg)},
+	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_mac_cfg)},
 
 /* Dr devices */
-	{IWL_PCI_DEVICE(0x272F, PCI_ANY_ID, iwl_dr_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272F, PCI_ANY_ID, iwl_dr_mac_cfg)},
 #endif /* CONFIG_IWLMLD */
 
 	{0}
@@ -1521,7 +1521,7 @@ static void get_crf_id(struct iwl_trans *iwl_trans,
 	u32 val = 0;
 	u8 step;
 
-	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		sd_reg_ver_addr = SD_REG_VER_GEN2;
 	else
 		sd_reg_ver_addr = SD_REG_VER;
@@ -1737,7 +1737,7 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 			  iwl_pcie_recheck_me_status);
 
 	/* we don't have a good way of determining this until BZ */
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
 		return;
 
 	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
@@ -1760,7 +1760,7 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	const struct iwl_cfg_trans_params *trans;
+	const struct iwl_mac_cfg *trans;
 	const struct iwl_dev_info *dev_info;
 	struct iwl_trans_info info = {
 		.hw_id = (pdev->device << 16) + pdev->subsystem_device,
@@ -1812,8 +1812,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * extract the RF_ID.
 	 * This is relevant only for family 9000 and up.
 	 */
-	if (iwl_trans->trans_cfg->rf_id &&
-	    iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	if (iwl_trans->mac_cfg->rf_id &&
+	    iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
 	    !CSR_HW_RFID_TYPE(info.hw_rf_id) && map_crf_id(iwl_trans, &info)) {
 		ret = -EINVAL;
 		goto out_free_trans;
@@ -1860,7 +1860,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	IWL_INFO(iwl_trans, "Detected %s\n", info.name);
 
-	if (iwl_trans->trans_cfg->mq_rx_supported) {
+	if (iwl_trans->mac_cfg->mq_rx_supported) {
 		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
 			ret = -EINVAL;
 			goto out_free_trans;
@@ -1870,7 +1870,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
 	}
 
-	if (!iwl_trans->trans_cfg->integrated) {
+	if (!iwl_trans->mac_cfg->integrated) {
 		u16 link_status;
 
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
@@ -1963,7 +1963,7 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
 	 * so assume that any bits there mean that the device is usable.
 	 */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ &&
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ &&
 	    !iwl_read32(trans, CSR_FUNC_SCRATCH))
 		device_was_powered_off = true;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 8adeddeb0e4c..9eb80b014cee 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -194,7 +194,7 @@ struct iwl_rb_allocator {
 static inline u16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
 					 struct iwl_rxq *rxq)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		__le16 *rb_stts = rxq->rb_stts;
 
 		return le16_to_cpu(READ_ONCE(*rb_stts));
@@ -536,7 +536,7 @@ iwl_trans_pcie_get_trans(struct iwl_trans_pcie *trans_pcie)
  */
 struct iwl_trans
 *iwl_trans_pcie_alloc(struct pci_dev *pdev,
-		      const struct iwl_cfg_trans_params *cfg_trans,
+		      const struct iwl_mac_cfg *mac_cfg,
 		      struct iwl_trans_info *info);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
@@ -663,7 +663,7 @@ static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		idx = iwl_txq_get_cmd_index(txq, idx);
 
 	return (u8 *)txq->tfds + trans_pcie->txqs.tfd.size * idx;
@@ -702,7 +702,7 @@ static inline void iwl_txq_stop(struct iwl_trans *trans, struct iwl_txq *txq)
 static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
 {
 	return ++index &
-		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+		(trans->mac_cfg->base_params->max_tfd_queue_size - 1);
 }
 
 /**
@@ -713,7 +713,7 @@ static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
 static inline int iwl_txq_dec_wrap(struct iwl_trans *trans, int index)
 {
 	return --index &
-		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+		(trans->mac_cfg->base_params->max_tfd_queue_size - 1);
 }
 
 void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq);
@@ -768,7 +768,7 @@ static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
 	struct iwl_tfd *tfd;
 	struct iwl_tfd_tb *tb;
 
-	if (trans->trans_cfg->gen2) {
+	if (trans->mac_cfg->gen2) {
 		struct iwl_tfh_tfd *tfh_tfd = _tfd;
 		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
 
@@ -1002,7 +1002,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 					   MSIX_HW_INT_CAUSES_REG_RF_KILL);
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000) {
 		/*
 		 * On 9000-series devices this bit isn't enabled by default, so
 		 * when we power down the device we need set the bit to allow it
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 712b8ded9f4b..919e4c3b1880 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -144,12 +144,12 @@ static inline __le32 iwl_pcie_dma_addr2rbd_ptr(dma_addr_t dma_addr)
  */
 int iwl_pcie_rx_stop(struct iwl_trans *trans)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		/* TODO: remove this once fw does it */
 		iwl_write_umac_prph(trans, RFH_RXF_DMA_CFG_GEN3, 0);
 		return iwl_poll_umac_prph_bit(trans, RFH_GEN_STATUS_GEN3,
 					      RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
-	} else if (trans->trans_cfg->mq_rx_supported) {
+	} else if (trans->mac_cfg->mq_rx_supported) {
 		iwl_write_prph(trans, RFH_RXF_DMA_CFG, 0);
 		return iwl_poll_prph_bit(trans, RFH_GEN_STATUS,
 					   RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
@@ -176,7 +176,7 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 1. shadow registers aren't enabled
 	 * 2. there is a chance that the NIC is asleep
 	 */
-	if (!trans->trans_cfg->base_params->shadow_reg_enable &&
+	if (!trans->mac_cfg->base_params->shadow_reg_enable &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		reg = iwl_read32(trans, CSR_UCODE_DRV_GP1);
 
@@ -191,9 +191,9 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 	}
 
 	rxq->write_actual = round_down(rxq->write, 8);
-	if (!trans->trans_cfg->mq_rx_supported)
+	if (!trans->mac_cfg->mq_rx_supported)
 		iwl_write32(trans, FH_RSCSR_CHNL0_WPTR, rxq->write_actual);
-	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_write32(trans, HBUS_TARG_WRPTR, rxq->write_actual |
 			    HBUS_TARG_WRPTR_RX_Q(rxq->id));
 	else
@@ -222,7 +222,7 @@ static void iwl_pcie_restock_bd(struct iwl_trans *trans,
 				struct iwl_rxq *rxq,
 				struct iwl_rx_mem_buffer *rxb)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		struct iwl_rx_transfer_desc *bd = rxq->bd;
 
 		BUILD_BUG_ON(sizeof(*bd) != 2 * sizeof(u64));
@@ -349,7 +349,7 @@ static void iwl_pcie_rxsq_restock(struct iwl_trans *trans,
 static
 void iwl_pcie_rxq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
-	if (trans->trans_cfg->mq_rx_supported)
+	if (trans->mac_cfg->mq_rx_supported)
 		iwl_pcie_rxmq_restock(trans, rxq);
 	else
 		iwl_pcie_rxsq_restock(trans, rxq);
@@ -658,19 +658,19 @@ void iwl_pcie_rx_allocator_work(struct work_struct *data)
 
 static int iwl_pcie_free_bd_size(struct iwl_trans *trans)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return sizeof(struct iwl_rx_transfer_desc);
 
-	return trans->trans_cfg->mq_rx_supported ?
+	return trans->mac_cfg->mq_rx_supported ?
 			sizeof(__le64) : sizeof(__le32);
 }
 
 static int iwl_pcie_used_bd_size(struct iwl_trans *trans)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		return sizeof(struct iwl_rx_completion_desc_bz);
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return sizeof(struct iwl_rx_completion_desc);
 
 	return sizeof(__le32);
@@ -702,7 +702,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 
 static size_t iwl_pcie_rb_stts_size(struct iwl_trans *trans)
 {
-	bool use_rx_td = (trans->trans_cfg->device_family >=
+	bool use_rx_td = (trans->mac_cfg->device_family >=
 			  IWL_DEVICE_FAMILY_AX210);
 
 	if (use_rx_td)
@@ -721,7 +721,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	int free_size;
 
 	spin_lock_init(&rxq->lock);
-	if (trans->trans_cfg->mq_rx_supported)
+	if (trans->mac_cfg->mq_rx_supported)
 		rxq->queue_size = trans->cfg->num_rbds;
 	else
 		rxq->queue_size = RX_QUEUE_SIZE;
@@ -737,7 +737,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	if (!rxq->bd)
 		goto err;
 
-	if (trans->trans_cfg->mq_rx_supported) {
+	if (trans->mac_cfg->mq_rx_supported) {
 		rxq->used_bd = dma_alloc_coherent(dev,
 						  iwl_pcie_used_bd_size(trans) *
 							rxq->queue_size,
@@ -976,7 +976,7 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 			       RFH_GEN_CFG_VAL(DEFAULT_RXQ_NUM, 0) |
 			       RFH_GEN_CFG_SERVICE_DMA_SNOOP |
 			       RFH_GEN_CFG_VAL(RB_CHUNK_SIZE,
-					       trans->trans_cfg->integrated ?
+					       trans->mac_cfg->integrated ?
 					       RFH_GEN_CFG_RB_CHUNK_SIZE_64 :
 					       RFH_GEN_CFG_RB_CHUNK_SIZE_128));
 	/* Enable the relevant rx queues */
@@ -1122,7 +1122,7 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 		rxq->write = 0;
 		rxq->write_actual = 0;
 		memset(rxq->rb_stts, 0,
-		       (trans->trans_cfg->device_family >=
+		       (trans->mac_cfg->device_family >=
 			IWL_DEVICE_FAMILY_AX210) ?
 		       sizeof(__le16) : sizeof(struct iwl_rb_status));
 
@@ -1144,7 +1144,7 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 	}
 
 	/* move the pool to the default queue and allocator ownerships */
-	queue_size = trans->trans_cfg->mq_rx_supported ?
+	queue_size = trans->mac_cfg->mq_rx_supported ?
 			trans_pcie->num_rx_bufs - 1 : RX_QUEUE_SIZE;
 	allocator_pool_size = trans->info.num_rxqs *
 		(RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC);
@@ -1175,7 +1175,7 @@ int iwl_pcie_rx_init(struct iwl_trans *trans)
 	if (ret)
 		return ret;
 
-	if (trans->trans_cfg->mq_rx_supported)
+	if (trans->mac_cfg->mq_rx_supported)
 		iwl_pcie_rx_mq_hw_init(trans);
 	else
 		iwl_pcie_rx_hw_init(trans, trans_pcie->rxq);
@@ -1408,7 +1408,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		}
 
 		page_stolen |= rxcb._page_stolen;
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 			break;
 	}
 
@@ -1454,18 +1454,18 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc) != 32);
 	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc_bz) != 4);
 
-	if (!trans->trans_cfg->mq_rx_supported) {
+	if (!trans->mac_cfg->mq_rx_supported) {
 		rxb = rxq->queue[i];
 		rxq->queue[i] = NULL;
 		return rxb;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		struct iwl_rx_completion_desc_bz *cd = rxq->used_bd;
 
 		vid = le16_to_cpu(cd[i].rbid);
 		*join = cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
-	} else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	} else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		struct iwl_rx_completion_desc *cd = rxq->used_bd;
 
 		vid = le16_to_cpu(cd[i].rbid);
@@ -1694,7 +1694,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 		return;
 	}
 
-	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->mac_cfg->base_params->num_of_queues; i++) {
 		if (!trans_pcie->txqs.txq[i])
 			continue;
 		timer_delete(&trans_pcie->txqs.txq[i]->stuck_timer);
@@ -1833,7 +1833,7 @@ static void iwl_trans_pcie_handle_reset_interrupt(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 state;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
 		u32 val = iwl_read32(trans, CSR_IPC_STATE);
 
 		state = u32_get_bits(val, CSR_IPC_STATE_RESET);
@@ -1984,7 +1984,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	if (inta & CSR_INT_BIT_ALIVE) {
 		IWL_DEBUG_ISR(trans, "Alive interrupt\n");
 		isr_stats->alive++;
-		if (trans->trans_cfg->gen2) {
+		if (trans->mac_cfg->gen2) {
 			/*
 			 * We can restock, since firmware configured
 			 * the RFH
@@ -2347,7 +2347,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		}
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		sw_err = inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ;
 	else
 		sw_err = inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR;
@@ -2355,7 +2355,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_TOP_FATAL_ERR) {
 		IWL_ERR(trans, "TOP Fatal error detected, inta_hw=0x%x.\n",
 			inta_hw);
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 			trans->request_top_reset = 1;
 			iwl_op_mode_nic_error(trans->op_mode,
 					      IWL_ERR_TYPE_TOP_FATAL_ERROR);
@@ -2400,7 +2400,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_ALIVE) {
 		IWL_DEBUG_ISR(trans, "Alive interrupt\n");
 		isr_stats->alive++;
-		if (trans->trans_cfg->gen2) {
+		if (trans->mac_cfg->gen2) {
 			/* We can restock, since firmware configured the RFH */
 			iwl_pcie_rxmq_restock(trans, trans_pcie->rxq);
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index a47a5922ff24..838fc98e9c37 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -87,7 +87,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * Clear "initialization complete" bit to move adapter from
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_clear_bit(trans, CSR_GP_CNTRL,
 			      CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
 	else
@@ -102,10 +102,10 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 
 	trans_pcie->fw_reset_state = FW_RESET_REQUESTED;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
 				    UREG_NIC_SET_NMI_DRIVER_RESET_HANDSHAKE);
-	else if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
+	else if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    UREG_DOORBELL_TO_ISR6_RESET_HANDSHAKE);
 	else
@@ -191,7 +191,7 @@ static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	}
 
 	iwl_pcie_ctxt_info_free_paging(trans);
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		iwl_pcie_ctxt_info_gen3_free(trans, false);
 	else
 		iwl_pcie_ctxt_info_free(trans);
@@ -374,7 +374,7 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 	/* now that we got alive we can free the fw image & the context info.
 	 * paging memory cannot be freed included since FW will still use it
 	 */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		iwl_pcie_ctxt_info_gen3_free(trans, true);
 	else
 		iwl_pcie_ctxt_info_free(trans);
@@ -390,7 +390,7 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 	iwl_pcie_get_rf_name(trans);
 	mutex_unlock(&trans_pcie->mutex);
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		trans->step_urm = !!(iwl_read_umac_prph(trans,
 							CNVI_PMU_STEP_FLOW) &
 					CNVI_PMU_STEP_FLOW_FORCE_URM);
@@ -413,21 +413,21 @@ static bool iwl_pcie_set_ltr(struct iwl_trans *trans)
 	 * initialize the LTR to ~250 usec (see ltr_val above).
 	 * The firmware initializes this again later (to a smaller value).
 	 */
-	if ((trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210 ||
-	     trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) &&
-	    !trans->trans_cfg->integrated) {
+	if ((trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_AX210 ||
+	     trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_22000) &&
+	    !trans->mac_cfg->integrated) {
 		iwl_write32(trans, CSR_LTR_LONG_VAL_AD, ltr_val);
 		return true;
 	}
 
-	if (trans->trans_cfg->integrated &&
-	    trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) {
+	if (trans->mac_cfg->integrated &&
+	    trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_22000) {
 		iwl_write_prph(trans, HPM_MAC_LTR_CSR, HPM_MAC_LRT_ENABLE_ALL);
 		iwl_write_prph(trans, HPM_UMAC_LTR, ltr_val);
 		return true;
 	}
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
 		/* First clear the interrupt, just in case */
 		iwl_write32(trans, CSR_MSIX_HW_INT_CAUSES_AD,
 			    MSIX_HW_INT_CAUSES_REG_IML);
@@ -546,14 +546,14 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	}
 
 	if (WARN_ON(trans->do_top_reset &&
-		    trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC))
+		    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC))
 		return -EINVAL;
 
 	/* we need to wait later - set state */
 	if (trans->do_top_reset)
 		trans_pcie->fw_reset_state = FW_RESET_TOP_REQUESTED;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		if (!top_reset_done) {
 			ret = iwl_pcie_ctxt_info_gen3_alloc(trans, fw, img);
 			if (ret)
@@ -569,13 +569,13 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 
 	keep_ram_busy = !iwl_pcie_set_ltr(trans);
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		IWL_DEBUG_POWER(trans, "function scratch register value is 0x%08x\n",
 				iwl_read32(trans, CSR_FUNC_SCRATCH));
 		iwl_write32(trans, CSR_FUNC_SCRATCH, CSR_FUNC_SCRATCH_INIT_VALUE);
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_ROM_START);
-	} else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	} else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		iwl_write_umac_prph(trans, UREG_CPU_INIT_RUN, 1);
 	} else {
 		iwl_write_prph(trans, UREG_CPU_INIT_RUN, 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 4d281c702eec..945cd2455be1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -131,7 +131,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 int iwl_trans_pcie_sw_reset(struct iwl_trans *trans, bool retake_ownership)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
 		usleep_range(10000, 20000);
@@ -293,7 +293,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	 */
 
 	/* Disable L0S exit timer (platform NMI Work/Around) */
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		iwl_set_bit(trans, CSR_GIO_CHICKEN_BITS,
 			    CSR_GIO_CHICKEN_BITS_REG_BIT_DIS_L0S_EXIT_TIMER);
 
@@ -317,7 +317,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	iwl_pcie_apm_config(trans);
 
 	/* Configure analog phase-lock-loop before activating to D0A */
-	if (trans->trans_cfg->base_params->pll_cfg)
+	if (trans->mac_cfg->base_params->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
 	ret = iwl_finish_nic_init(trans);
@@ -469,7 +469,7 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 
 	/* stop device's busmaster DMA activity */
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_REQ);
 
@@ -501,10 +501,10 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 			iwl_pcie_apm_init(trans);
 
 		/* inform ME that we are leaving */
-		if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000)
+		if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_7000)
 			iwl_set_bits_prph(trans, APMG_PCIDEV_STT_REG,
 					  APMG_PCIDEV_STT_VAL_WAKE_ME);
-		else if (trans->trans_cfg->device_family >=
+		else if (trans->mac_cfg->device_family >=
 			 IWL_DEVICE_FAMILY_8000) {
 			iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 				    CSR_RESET_LINK_PWR_MGMT_DISABLED);
@@ -565,7 +565,7 @@ static int iwl_pcie_nic_init(struct iwl_trans *trans)
 		return -ENOMEM;
 	}
 
-	if (trans->trans_cfg->base_params->shadow_reg_enable) {
+	if (trans->mac_cfg->base_params->shadow_reg_enable) {
 		/* enable shadow regs in HW */
 		iwl_set_bit(trans, CSR_MAC_SHADOW_REG_CTRL, 0x800FFFFF);
 		IWL_DEBUG_INFO(trans, "Enabling shadow registers in device\n");
@@ -634,7 +634,7 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 				IWL_DEBUG_INFO(trans,
 					       "Couldn't prepare the card but SAP is connected\n");
 				trans->csme_own = true;
-				if (trans->trans_cfg->device_family !=
+				if (trans->mac_cfg->device_family !=
 				    IWL_DEVICE_FAMILY_9000)
 					IWL_ERR(trans,
 						"SAP not supported for this NIC family\n");
@@ -819,7 +819,7 @@ static int iwl_pcie_load_cpu_sections_8000(struct iwl_trans *trans,
 
 	iwl_enable_interrupts(trans);
 
-	if (trans->trans_cfg->gen2) {
+	if (trans->mac_cfg->gen2) {
 		if (cpu == 1)
 			iwl_write_prph(trans, UREG_UCODE_LOAD_STATUS,
 				       0xFFFF);
@@ -977,7 +977,7 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 	if (dest->monitor_mode == EXTERNAL_MODE && fw_mon->size) {
 		iwl_write_prph(trans, le32_to_cpu(dest->base_reg),
 			       fw_mon->physical >> dest->base_shift);
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
 				       (fw_mon->physical + fw_mon->size -
 					256) >> dest->end_shift);
@@ -1153,7 +1153,7 @@ static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 	 */
 	iwl_pcie_map_list(trans, causes_list_common,
 			  ARRAY_SIZE(causes_list_common), val);
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_pcie_map_list(trans, causes_list_bz,
 				  ARRAY_SIZE(causes_list_bz), val);
 	else
@@ -1196,7 +1196,7 @@ void iwl_pcie_conf_msix_hw(struct iwl_trans_pcie *trans_pcie)
 	struct iwl_trans *trans = trans_pcie->trans;
 
 	if (!trans_pcie->msix_enabled) {
-		if (trans->trans_cfg->mq_rx_supported &&
+		if (trans->mac_cfg->mq_rx_supported &&
 		    test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 			iwl_write_umac_prph(trans, UREG_CHICK,
 					    UREG_CHICK_MSI_ENABLE);
@@ -1279,7 +1279,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool from_irq)
 	}
 
 	/* Make sure (redundant) we've released our request to stay awake */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_clear_bit(trans, CSR_GP_CNTRL,
 			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
 	else
@@ -1410,7 +1410,7 @@ int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 	iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
 
 	/* Load the given image to the HW */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		ret = iwl_pcie_load_given_ucode_8000(trans, img);
 	else
 		ret = iwl_pcie_load_given_ucode(trans, img);
@@ -1487,7 +1487,7 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 	IWL_WARN(trans, "reporting RF_KILL (radio %s)\n",
 		 state ? "disabled" : "enabled");
 	if (iwl_op_mode_hw_rf_kill(trans->op_mode, state) &&
-	    !WARN_ON(trans->trans_cfg->gen2))
+	    !WARN_ON(trans->mac_cfg->gen2))
 		_iwl_trans_pcie_stop_device(trans, from_irq);
 }
 
@@ -1507,7 +1507,7 @@ static void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
 
 	iwl_pcie_synchronize_irqs(trans);
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		iwl_clear_bit(trans, CSR_GP_CNTRL,
 			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
 		iwl_clear_bit(trans, CSR_GP_CNTRL,
@@ -1536,11 +1536,11 @@ static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    suspend ? UREG_DOORBELL_TO_ISR6_SUSPEND :
 					      UREG_DOORBELL_TO_ISR6_RESUME);
-	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_write32(trans, CSR_IPC_SLEEP_CONTROL,
 			    suspend ? CSR_IPC_SLEEP_CONTROL_SUSPEND :
 				      CSR_IPC_SLEEP_CONTROL_RESUME);
@@ -1595,7 +1595,7 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 		goto out;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
 	else
@@ -1655,7 +1655,7 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 static void
 iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 			    struct iwl_trans *trans,
-			    const struct iwl_cfg_trans_params *cfg_trans,
+			    const struct iwl_mac_cfg *mac_cfg,
 			    struct iwl_trans_info *info)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1663,10 +1663,10 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 	u16 pci_cmd;
 	u32 max_rx_queues = IWL_MAX_RX_HW_QUEUES;
 
-	if (!cfg_trans->mq_rx_supported)
+	if (!mac_cfg->mq_rx_supported)
 		goto enable_msi;
 
-	if (cfg_trans->device_family <= IWL_DEVICE_FAMILY_9000)
+	if (mac_cfg->device_family <= IWL_DEVICE_FAMILY_9000)
 		max_rx_queues = IWL_9000_MAX_RX_HW_QUEUES;
 
 	max_irqs = min_t(u32, num_online_cpus() + 2, max_rx_queues);
@@ -1797,7 +1797,7 @@ static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
 {
 	u32 hpm, wprot;
 
-	switch (trans->trans_cfg->device_family) {
+	switch (trans->mac_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_9000:
 		wprot = PREG_PRPH_WPROT_9000;
 		break;
@@ -1866,8 +1866,8 @@ static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 	if (err)
 		return err;
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
-	    trans->trans_cfg->integrated) {
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
+	    trans->mac_cfg->integrated) {
 		err = iwl_pcie_gen2_force_power_gating(trans);
 		if (err)
 			return err;
@@ -1942,7 +1942,7 @@ u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs)
 
 static u32 iwl_trans_pcie_prph_msk(struct iwl_trans *trans)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return 0x00FFFFFF;
 	else
 		return 0x000FFFFF;
@@ -2036,7 +2036,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 
 	iwl_pcie_synchronize_irqs(trans);
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		iwl_txq_gen2_tx_free(trans);
 	else
 		iwl_pcie_tx_free(trans);
@@ -2376,7 +2376,7 @@ void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
 
 	removal->pdev = to_pci_dev(trans->dev);
 	removal->mode = mode;
-	removal->integrated = trans->trans_cfg->integrated;
+	removal->integrated = trans->mac_cfg->integrated;
 	INIT_WORK(&removal->work, iwl_trans_pcie_removal_wk);
 	pci_dev_get(removal->pdev);
 	schedule_work(&removal->work);
@@ -2404,7 +2404,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		write = CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ;
 		mask = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
 		poll = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
@@ -2412,7 +2412,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 
 	/* this bit wakes up the NIC */
 	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL, write);
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
 	/*
@@ -2493,7 +2493,7 @@ void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
 					   CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
 	else
@@ -2672,7 +2672,7 @@ int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 
 	/* waiting for all the tx frames complete might take a while */
 	for (cnt = 0;
-	     cnt < trans->trans_cfg->base_params->num_of_queues;
+	     cnt < trans->mac_cfg->base_params->num_of_queues;
 	     cnt++) {
 
 		if (cnt == trans->conf.cmd_queue)
@@ -2816,7 +2816,7 @@ static void *iwl_dbgfs_tx_queue_seq_start(struct seq_file *seq, loff_t *pos)
 	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
 	struct iwl_dbgfs_tx_queue_state *state;
 
-	if (*pos >= priv->trans->trans_cfg->base_params->num_of_queues)
+	if (*pos >= priv->trans->mac_cfg->base_params->num_of_queues)
 		return NULL;
 
 	state = kmalloc(sizeof(*state), GFP_KERNEL);
@@ -2834,7 +2834,7 @@ static void *iwl_dbgfs_tx_queue_seq_next(struct seq_file *seq,
 
 	*pos = ++state->pos;
 
-	if (*pos >= priv->trans->trans_cfg->base_params->num_of_queues)
+	if (*pos >= priv->trans->mac_cfg->base_params->num_of_queues)
 		return NULL;
 
 	return state;
@@ -3268,7 +3268,7 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 		if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 			return -EINVAL;
 		if (mode == IWL_RESET_MODE_TOP_RESET) {
-			if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+			if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
 				return -EINVAL;
 			trans->request_top_reset = 1;
 		}
@@ -3416,7 +3416,7 @@ static u32 iwl_trans_pcie_fh_regs_dump(struct iwl_trans *trans,
 	(*data)->len = cpu_to_le32(fh_regs_len);
 	val = (void *)(*data)->data;
 
-	if (!trans->trans_cfg->gen2)
+	if (!trans->mac_cfg->gen2)
 		for (i = FH_MEM_LOWER_BOUND; i < FH_MEM_UPPER_BOUND;
 		     i += sizeof(u32))
 			*val++ = cpu_to_le32(iwl_trans_pcie_read32(trans, i));
@@ -3463,7 +3463,7 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 {
 	u32 base, base_high, write_ptr, write_ptr_val, wrap_cnt;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		base = DBGC_CUR_DBGBUF_BASE_ADDR_LSB;
 		base_high = DBGC_CUR_DBGBUF_BASE_ADDR_MSB;
 		write_ptr = DBGC_CUR_DBGBUF_STATUS;
@@ -3483,7 +3483,7 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 		cpu_to_le32(iwl_read_prph(trans, wrap_cnt));
 	fw_mon_data->fw_mon_base_ptr =
 		cpu_to_le32(iwl_read_prph(trans, base));
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		fw_mon_data->fw_mon_base_high_ptr =
 			cpu_to_le32(iwl_read_prph(trans, base_high));
 		write_ptr_val &= DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK;
@@ -3503,8 +3503,8 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 
 	if (trans->dbg.dest_tlv ||
 	    (fw_mon->size &&
-	     (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
-	      trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
+	     (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
+	      trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
 		struct iwl_fw_error_dump_fw_mon *fw_mon_data;
 
 		(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_FW_MONITOR);
@@ -3584,7 +3584,7 @@ static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 			      trans->dbg.dest_tlv->end_shift;
 
 			/* Make "end" point to the actual end */
-			if (trans->trans_cfg->device_family >=
+			if (trans->mac_cfg->device_family >=
 			    IWL_DEVICE_FAMILY_8000 ||
 			    trans->dbg.dest_tlv->monitor_mode == MARBH_MODE)
 				end += (1 << trans->dbg.dest_tlv->end_shift);
@@ -3611,7 +3611,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 	u32 len, num_rbs = 0, monitor_len = 0;
 	int i, ptr;
 	bool dump_rbs = test_bit(STATUS_FW_ERROR, &trans->status) &&
-			!trans->trans_cfg->mq_rx_supported &&
+			!trans->mac_cfg->mq_rx_supported &&
 			dump_mask & BIT(IWL_FW_ERROR_DUMP_RB);
 
 	if (!dump_mask)
@@ -3636,7 +3636,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 
 	/* FH registers */
 	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_FH_REGS)) {
-		if (trans->trans_cfg->gen2)
+		if (trans->mac_cfg->gen2)
 			len += sizeof(*data) +
 			       (iwl_umac_prph(trans, FH_MEM_UPPER_BOUND_GEN2) -
 				iwl_umac_prph(trans, FH_MEM_LOWER_BOUND_GEN2));
@@ -3661,7 +3661,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 	}
 
 	/* Paged memory for gen2 HW */
-	if (trans->trans_cfg->gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING))
+	if (trans->mac_cfg->gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING))
 		for (i = 0; i < trans->init_dram.paging_cnt; i++)
 			len += sizeof(*data) +
 			       sizeof(struct iwl_fw_error_dump_paging) +
@@ -3686,7 +3686,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 			u8 tfdidx;
 			u32 caplen, cmdlen;
 
-			if (trans->trans_cfg->gen2)
+			if (trans->mac_cfg->gen2)
 				tfdidx = idx;
 			else
 				tfdidx = ptr;
@@ -3726,7 +3726,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 		len += iwl_trans_pcie_dump_rbs(trans, &data, num_rbs);
 
 	/* Paged memory for gen2 HW */
-	if (trans->trans_cfg->gen2 &&
+	if (trans->mac_cfg->gen2 &&
 	    dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING)) {
 		for (i = 0; i < trans->init_dram.paging_cnt; i++) {
 			struct iwl_fw_error_dump_paging *paging;
@@ -3766,7 +3766,7 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 
 	if (trans_pcie->msix_enabled) {
 		inta_addr = CSR_MSIX_HW_INT_CAUSES_AD;
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 			sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ;
 		else
 			sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR;
@@ -3780,7 +3780,7 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 
 struct iwl_trans *
 iwl_trans_pcie_alloc(struct pci_dev *pdev,
-		     const struct iwl_cfg_trans_params *cfg_trans,
+		     const struct iwl_mac_cfg *mac_cfg,
 		     struct iwl_trans_info *info)
 {
 	struct iwl_trans_pcie *trans_pcie, **priv;
@@ -3801,7 +3801,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		return ERR_PTR(ret);
 
 	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev,
-				cfg_trans);
+				mac_cfg);
 	if (!trans)
 		return ERR_PTR(-ENOMEM);
 
@@ -3810,7 +3810,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	/* Initialize the wait queue for commands */
 	init_waitqueue_head(&trans_pcie->wait_command_queue);
 
-	if (trans->trans_cfg->gen2) {
+	if (trans->mac_cfg->gen2) {
 		trans_pcie->txqs.tfd.addr_size = 64;
 		trans_pcie->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
 		trans_pcie->txqs.tfd.size = sizeof(struct iwl_tfh_tfd);
@@ -3821,7 +3821,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	}
 
 	trans_pcie->supported_dma_mask = (u32)DMA_BIT_MASK(12);
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		trans_pcie->supported_dma_mask = (u32)DMA_BIT_MASK(11);
 
 	info->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
@@ -3832,10 +3832,10 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		goto out_free_trans;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		trans_pcie->txqs.bc_tbl_size =
 			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_BZ;
-	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		trans_pcie->txqs.bc_tbl_size =
 			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_AX210;
 	else
@@ -3845,7 +3845,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * table, but they're pretty small (1k) so use a DMA pool that we
 	 * allocate here.
 	 */
-	if (trans->trans_cfg->gen2) {
+	if (trans->mac_cfg->gen2) {
 		trans_pcie->txqs.bc_pool =
 			dmam_pool_create("iwlwifi:bc", trans->dev,
 					 trans_pcie->txqs.bc_tbl_size,
@@ -3858,7 +3858,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	/* Some things must not change even if the config does */
 	WARN_ON(trans_pcie->txqs.tfd.addr_size !=
-		(trans->trans_cfg->gen2 ? 64 : 36));
+		(trans->mac_cfg->gen2 ? 64 : 36));
 
 	/* Initialize NAPI here - it should be before registering to mac80211
 	 * in the opmode but after the HW struct is allocated.
@@ -3892,7 +3892,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie->debug_rfkill = -1;
 
-	if (!cfg_trans->base_params->pcie_l1_allowed) {
+	if (!mac_cfg->base_params->pcie_l1_allowed) {
 		/*
 		 * W/A - seems to solve weird behavior. We need to remove this
 		 * if we don't want to stay in L1 all the time. This wastes a
@@ -3949,14 +3949,14 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * "dash" value). To keep hw_rev backwards compatible - we'll store it
 	 * in the old format.
 	 */
-	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_8000)
+	if (mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		info->hw_rev_step = info->hw_rev & 0xF;
 	else
 		info->hw_rev_step = (info->hw_rev & 0xC) >> 2;
 
 	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", info->hw_rev);
 
-	iwl_pcie_set_interrupt_capa(pdev, trans, cfg_trans, info);
+	iwl_pcie_set_interrupt_capa(pdev, trans, mac_cfg, info);
 
 	init_waitqueue_head(&trans_pcie->sx_waitq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index b567ff3f9052..3fbb7dcee7c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -501,7 +501,7 @@ struct iwl_tfh_tfd *iwl_txq_gen2_build_tfd(struct iwl_trans *trans,
 
 	memset(tfd, 0, sizeof(*tfd));
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = sizeof(struct iwl_tx_cmd_gen2);
 	else
 		len = sizeof(struct iwl_tx_cmd_gen3);
@@ -535,17 +535,17 @@ int iwl_txq_space(struct iwl_trans *trans, const struct iwl_txq *q)
 	 * If q->n_window is smaller than max_tfd_queue_size, there is no need
 	 * to reserve any queue entries for this purpose.
 	 */
-	if (q->n_window < trans->trans_cfg->base_params->max_tfd_queue_size)
+	if (q->n_window < trans->mac_cfg->base_params->max_tfd_queue_size)
 		max = q->n_window;
 	else
-		max = trans->trans_cfg->base_params->max_tfd_queue_size - 1;
+		max = trans->mac_cfg->base_params->max_tfd_queue_size - 1;
 
 	/*
 	 * max_tfd_queue_size is a power of 2, so the following is equivalent to
 	 * modulo by max_tfd_queue_size and is well defined.
 	 */
 	used = (q->write_ptr - q->read_ptr) &
-		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+		(trans->mac_cfg->base_params->max_tfd_queue_size - 1);
 
 	if (WARN_ON(used > max))
 		return 0;
@@ -580,7 +580,7 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 	 */
 	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		struct iwl_gen3_bc_tbl_entry *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
 
 		WARN_ON(len > 0x3FFF);
@@ -780,7 +780,7 @@ int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		return -1;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		struct iwl_tx_cmd_gen3 *tx_cmd_gen3 =
 			(void *)dev_cmd->payload;
 
@@ -1002,7 +1002,7 @@ static int iwl_pcie_txq_alloc_response(struct iwl_trans *trans,
 
 	txq->id = qid;
 	trans_pcie->txqs.txq[qid] = txq;
-	wr_ptr &= (trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+	wr_ptr &= (trans->mac_cfg->base_params->max_tfd_queue_size - 1);
 
 	/* Place first TFD at index corresponding to start sequence number */
 	txq->read_ptr = wr_ptr;
@@ -1038,7 +1038,7 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
 	/* but must be power of 2 values for calculating read/write pointers */
 	size = rounddown_pow_of_two(size);
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
 	    trans->info.hw_rev_step == SILICON_A_STEP) {
 		size = 4096;
 		txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index c876912e9aaf..3cc47e648492 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -89,7 +89,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 2. NIC is woken up for CMD regardless of shadow outside this function
 	 * 3. there is a chance that the NIC is asleep
 	 */
-	if (!trans->trans_cfg->base_params->shadow_reg_enable &&
+	if (!trans->mac_cfg->base_params->shadow_reg_enable &&
 	    txq_id != trans->conf.cmd_queue &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		/*
@@ -124,7 +124,7 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->mac_cfg->base_params->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txqs.txq[i];
 
 		if (!test_bit(i, trans_pcie->txqs.queue_used))
@@ -192,7 +192,7 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	if (!trans->trans_cfg->base_params->apmg_wake_up_wa)
+	if (!trans->mac_cfg->base_params->apmg_wake_up_wa)
 		return;
 
 	spin_lock(&trans_pcie->reg_lock);
@@ -355,7 +355,7 @@ static void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 	/* We have only q->n_window txq->entries, but we use
 	 * TFD_QUEUE_SIZE_MAX tfds
 	 */
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
 				       iwl_txq_get_tfd(trans, txq, read_ptr));
 	else
@@ -456,7 +456,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	if (txq->tfds) {
 		dma_free_coherent(dev,
 				  trans_pcie->txqs.tfd.size *
-				  trans->trans_cfg->base_params->max_tfd_queue_size,
+				  trans->mac_cfg->base_params->max_tfd_queue_size,
 				  txq->tfds, txq->dma_addr);
 		txq->dma_addr = 0;
 		txq->tfds = NULL;
@@ -478,7 +478,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 void iwl_pcie_tx_start(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int nq = trans->trans_cfg->base_params->num_of_queues;
+	int nq = trans->mac_cfg->base_params->num_of_queues;
 	int chan;
 	u32 reg_val;
 	int clear_dwords = (SCD_TRANS_TBL_OFFSET_QUEUE(nq) -
@@ -504,7 +504,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans)
 	/* The chain extension of the SCD doesn't work well. This feature is
 	 * enabled by default by the HW, so we need to disable it manually.
 	 */
-	if (trans->trans_cfg->base_params->scd_chain_ext_wa)
+	if (trans->mac_cfg->base_params->scd_chain_ext_wa)
 		iwl_write_prph(trans, SCD_CHAINEXT_EN, 0);
 
 	iwl_trans_ac_txq_enable(trans, trans->conf.cmd_queue,
@@ -526,7 +526,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans)
 			   reg_val | FH_TX_CHICKEN_BITS_SCD_AUTO_RETRY_EN);
 
 	/* Enable L1-Active */
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		iwl_clear_bits_prph(trans, APMG_PCIDEV_STT_REG,
 				    APMG_PCIDEV_STT_VAL_L1_ACT_DIS);
 }
@@ -540,13 +540,13 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 	 * we should never get here in gen2 trans mode return early to avoid
 	 * having invalid accesses
 	 */
-	if (WARN_ON_ONCE(trans->trans_cfg->gen2))
+	if (WARN_ON_ONCE(trans->mac_cfg->gen2))
 		return;
 
-	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
 	     txq_id++) {
 		struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
-		if (trans->trans_cfg->gen2)
+		if (trans->mac_cfg->gen2)
 			iwl_write_direct64(trans,
 					   FH_MEM_CBBC_QUEUE(trans, txq_id),
 					   txq->dma_addr);
@@ -630,7 +630,7 @@ int iwl_pcie_tx_stop(struct iwl_trans *trans)
 		return 0;
 
 	/* Unmap DMA from host system and free skb's */
-	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
 	     txq_id++)
 		iwl_pcie_txq_unmap(trans, txq_id);
 
@@ -653,7 +653,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 	/* Tx queues */
 	if (trans_pcie->txq_memory) {
 		for (txq_id = 0;
-		     txq_id < trans->trans_cfg->base_params->num_of_queues;
+		     txq_id < trans->mac_cfg->base_params->num_of_queues;
 		     txq_id++) {
 			iwl_pcie_txq_free(trans, txq_id);
 			trans_pcie->txqs.txq[txq_id] = NULL;
@@ -675,7 +675,7 @@ void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 	bool active;
 	u8 fifo;
 
-	if (trans->trans_cfg->gen2) {
+	if (trans->mac_cfg->gen2) {
 		IWL_ERR(trans, "Queue %d is stuck %d %d\n", txq_id,
 			txq->read_ptr, txq->write_ptr);
 		/* TODO: access new SCD registers and dump them */
@@ -692,9 +692,9 @@ void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 		jiffies_to_msecs(txq->wd_timeout),
 		txq->read_ptr, txq->write_ptr,
 		iwl_read_prph(trans, SCD_QUEUE_RDPTR(txq_id)) &
-			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
+			(trans->mac_cfg->base_params->max_tfd_queue_size - 1),
 			iwl_read_prph(trans, SCD_QUEUE_WRPTR(txq_id)) &
-			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
+			(trans->mac_cfg->base_params->max_tfd_queue_size - 1),
 			iwl_read_direct32(trans, FH_TX_TRB_REG(fifo)));
 }
 
@@ -720,8 +720,8 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 		       int slots_num, bool cmd_queue)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	size_t num_entries = trans->trans_cfg->gen2 ?
-		slots_num : trans->trans_cfg->base_params->max_tfd_queue_size;
+	size_t num_entries = trans->mac_cfg->gen2 ?
+		slots_num : trans->mac_cfg->base_params->max_tfd_queue_size;
 	size_t tfd_sz;
 	size_t tb0_buf_sz;
 	int i;
@@ -776,7 +776,7 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 	for (i = 0; i < num_entries; i++) {
 		void *tfd = iwl_txq_get_tfd(trans, txq, i);
 
-		if (trans->trans_cfg->gen2)
+		if (trans->mac_cfg->gen2)
 			iwl_txq_set_tfd_invalid_gen2(trans, tfd);
 		else
 			iwl_txq_set_tfd_invalid_gen1(trans, tfd);
@@ -805,9 +805,9 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	int ret;
 	int txq_id, slots_num;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	u16 bc_tbls_size = trans->trans_cfg->base_params->num_of_queues;
+	u16 bc_tbls_size = trans->mac_cfg->base_params->num_of_queues;
 
-	if (WARN_ON(trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))
+	if (WARN_ON(trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))
 		return -EINVAL;
 
 	bc_tbls_size *= sizeof(struct iwlagn_scd_bc_tbl);
@@ -834,7 +834,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	}
 
 	trans_pcie->txq_memory =
-		kcalloc(trans->trans_cfg->base_params->num_of_queues,
+		kcalloc(trans->mac_cfg->base_params->num_of_queues,
 			sizeof(struct iwl_txq), GFP_KERNEL);
 	if (!trans_pcie->txq_memory) {
 		IWL_ERR(trans, "Not enough memory for txq\n");
@@ -843,7 +843,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	}
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans->conf.cmd_queue);
 
@@ -902,7 +902,7 @@ int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
 		 int slots_num, bool cmd_queue)
 {
 	u32 tfd_queue_max_size =
-		trans->trans_cfg->base_params->max_tfd_queue_size;
+		trans->mac_cfg->base_params->max_tfd_queue_size;
 	int ret;
 
 	txq->need_update = false;
@@ -960,7 +960,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	spin_unlock_bh(&trans_pcie->irq_lock);
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans->conf.cmd_queue);
 
@@ -988,7 +988,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	}
 
 	iwl_set_bits_prph(trans, SCD_GP_CTRL, SCD_GP_CTRL_AUTO_ACTIVE_MODE);
-	if (trans->trans_cfg->base_params->num_of_queues > 20)
+	if (trans->mac_cfg->base_params->num_of_queues > 20)
 		iwl_set_bits_prph(trans, SCD_GP_CTRL,
 				  SCD_GP_CTRL_ENABLE_31_QUEUES);
 
@@ -1009,7 +1009,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return -ENODEV;
 
-	if (!trans->trans_cfg->base_params->apmg_wake_up_wa)
+	if (!trans->mac_cfg->base_params->apmg_wake_up_wa)
 		return 0;
 
 	/*
@@ -1087,12 +1087,12 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 	idx = iwl_txq_get_cmd_index(txq, idx);
 	r = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 
-	if (idx >= trans->trans_cfg->base_params->max_tfd_queue_size ||
+	if (idx >= trans->mac_cfg->base_params->max_tfd_queue_size ||
 	    (!iwl_txq_used(txq, idx, txq->read_ptr, txq->write_ptr))) {
 		WARN_ONCE(test_bit(txq_id, trans_pcie->txqs.queue_used),
 			  "%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
 			  __func__, txq_id, idx,
-			  trans->trans_cfg->base_params->max_tfd_queue_size,
+			  trans->mac_cfg->base_params->max_tfd_queue_size,
 			  txq->write_ptr, txq->read_ptr);
 		return;
 	}
@@ -1203,7 +1203,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		 * this sad hardware issue.
 		 * This bug has been fixed on devices 9000 and up.
 		 */
-		scd_bug = !trans->trans_cfg->mq_rx_supported &&
+		scd_bug = !trans->mac_cfg->mq_rx_supported &&
 			!((ssn - txq->write_ptr) & 0x3f) &&
 			(ssn != txq->write_ptr);
 		if (scd_bug)
@@ -1308,7 +1308,7 @@ static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->mac_cfg->base_params->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txqs.txq[i];
 
 		if (i == trans->conf.cmd_queue)
@@ -1652,7 +1652,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	group_id = cmd->hdr.group_id;
 	cmd_id = WIDE_ID(group_id, cmd->hdr.cmd);
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		iwl_txq_gen2_tfd_unmap(trans, meta,
 				       iwl_txq_get_tfd(trans, txq, index));
 	else
@@ -2091,7 +2091,7 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 		break;
 	}
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = DIV_ROUND_UP(len, 4);
 
 	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
@@ -2385,7 +2385,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		IWL_ERR(trans,
 			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
 			__func__, txq_id, last_to_free,
-			trans->trans_cfg->base_params->max_tfd_queue_size,
+			trans->mac_cfg->base_params->max_tfd_queue_size,
 			txq_write_ptr, txq_read_ptr);
 
 		iwl_op_mode_time_point(trans->op_mode,
@@ -2414,7 +2414,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 		txq->entries[read_ptr].skb = NULL;
 
-		if (!trans->trans_cfg->gen2)
+		if (!trans->mac_cfg->gen2)
 			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq,
 							txq_read_ptr);
 
@@ -2566,7 +2566,7 @@ static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
 
 	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n", cmd_str);
 
-	if (trans->trans_cfg->gen2)
+	if (trans->mac_cfg->gen2)
 		cmd_idx = iwl_pcie_gen2_enqueue_hcmd(trans, cmd);
 	else
 		cmd_idx = iwl_pcie_enqueue_hcmd(trans, cmd);
@@ -2668,7 +2668,7 @@ int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 		if (WARN_ON(cmd->flags & CMD_WANT_SKB))
 			return -EINVAL;
 
-		if (trans->trans_cfg->gen2)
+		if (trans->mac_cfg->gen2)
 			ret = iwl_pcie_gen2_enqueue_hcmd(trans, cmd);
 		else
 			ret = iwl_pcie_enqueue_hcmd(trans, cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index d5071fde20cf..c86495abf29b 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -155,14 +155,14 @@ static void devinfo_pci_ids(struct kunit *test)
 	}
 }
 
-static void devinfo_no_trans_cfg_dups(struct kunit *test)
+static void devinfo_no_mac_cfg_dups(struct kunit *test)
 {
 	for (int i = 0; iwl_hw_card_ids[i].vendor; i++) {
-		const struct iwl_cfg_trans_params *cfg_i =
+		const struct iwl_mac_cfg *cfg_i =
 			(void *)iwl_hw_card_ids[i].driver_data;
 
 		for (int j = 0; j < i; j++) {
-			const struct iwl_cfg_trans_params *cfg_j =
+			const struct iwl_mac_cfg *cfg_j =
 				(void *)iwl_hw_card_ids[j].driver_data;
 
 			if (cfg_i == cfg_j)
@@ -184,7 +184,7 @@ static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_check_subdev_match),
 	KUNIT_CASE(devinfo_check_killer_subdev),
 	KUNIT_CASE(devinfo_pci_ids),
-	KUNIT_CASE(devinfo_no_trans_cfg_dups),
+	KUNIT_CASE(devinfo_no_mac_cfg_dups),
 	{}
 };
 
-- 
2.34.1


