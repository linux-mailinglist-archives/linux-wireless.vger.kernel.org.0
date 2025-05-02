Return-Path: <linux-wireless+bounces-22349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C093AA72B4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF51BC3A1A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81A25484D;
	Fri,  2 May 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVqF3gVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7A253B7C
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190618; cv=none; b=NgKO45XwpIbApFmO4KKzMOno3oWbdS8GQDS1qd2/Rs6SG4Ml91JAvulL/V2NYu3IKz+wKzck4Itv/zSyak6dA0unjMEyFLVjDzjFpUJxsctUU0Se8UQzp4uigzSgyvQOEXYI/mokdyEJXMO1jXJdaazn9aur4dKntZ8fSMsecBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190618; c=relaxed/simple;
	bh=A0sQ6Vwg6ba0XdUk10/INsEpbG6D4q0BJiPscpxnLcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWhSyYH2nTuupFsmK8GtitPBGZ11BzLBO3cHeL0fFjIPsZbkDASx5EkmKUv5MMHM2FPPppQg/zu9KrLst14qBH4Oc6WHsy5ENAEQY8ueBRrJbFQ6faka2bZHRwqHM/JCtGpbP/QwZaBHkAhvdOI6z+3MYaMooezQjXddPVZNPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVqF3gVo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190617; x=1777726617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0sQ6Vwg6ba0XdUk10/INsEpbG6D4q0BJiPscpxnLcA=;
  b=HVqF3gVoKiKVRbrZlh9a8RyG4V6A/Wxk5sSC+8d4G3ElDP/ySlMDJLDM
   38LSFW4taL2K8C+lgbQ6NBJrVeNdpWU1b0jO2LS2jvuQPl82U8n10x4WA
   3jn5yPw6vhWL9A1SSUGpA0bVnA9nLDkn+9xxWnPmZ1EYGlvG2DMuItS5K
   bvslu2SQ+Hiwb7SHKwuTEojimG92GM7FSzoGqwMbMKpiIXgVhEqSjO4Sc
   ekn3xIw9AJyyaHXhU0HlhDxdovl/YT/iVzYHV48B8a8Mus7u0KsnX/CUV
   h0cl2anOD7IMXaKMhWVWCO1R0MHU9ytAJFErx36hvltLRVRW69ERLPkeq
   A==;
X-CSE-ConnectionGUID: 7SJQbjECQFCxTMkmNI3Y0w==
X-CSE-MsgGUID: Em1mtMNITbyZWYQ/N/DZGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255545"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255545"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:57 -0700
X-CSE-ConnectionGUID: QGYpnkQaQ5WMPUpHviTkxg==
X-CSE-MsgGUID: 0jllJMkgRfmB0dDCQjcvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554728"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: cfg: minor fixes for Sc
Date: Fri,  2 May 2025 15:56:23 +0300
Message-Id: <20250502155404.b313d54b8809.Ia975b6d5460996f2a2761dd3d0fef4a56f1f3e24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Remove the erroneously named IWL_DEVICE_BZ_COMMON macro
from the Sc file and fix some indentation. Also bump the
minimum FW version since it's not released yet anyway,
right now this is mostly to make the config different
from iwl_bz_cfg which would otherwise be the same with
the upcoming transport config cleanups.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 800b6ffec4af..99955fc9331d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	93
+#define IWL_SC_UCODE_API_MIN	98
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
@@ -55,23 +55,23 @@ static const struct iwl_base_params iwl_sc_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-#define IWL_DEVICE_BZ_COMMON						\
-	.ucode_api_max = IWL_SC_UCODE_API_MAX,			\
-	.ucode_api_min = IWL_SC_UCODE_API_MIN,			\
+#define IWL_DEVICE_SC							\
+	.ucode_api_max = IWL_SC_UCODE_API_MAX,				\
+	.ucode_api_min = IWL_SC_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL_SC_DCCM_OFFSET,				\
 	.dccm_len = IWL_SC_DCCM_LEN,					\
 	.dccm2_offset = IWL_SC_DCCM2_OFFSET,				\
-	.dccm2_len = IWL_SC_DCCM2_LEN,				\
+	.dccm2_len = IWL_SC_DCCM2_LEN,					\
 	.smem_offset = IWL_SC_SMEM_OFFSET,				\
 	.smem_len = IWL_SC_SMEM_LEN,					\
 	.apmg_not_supported = true,					\
 	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x30,					\
-	.nvm_ver = IWL_SC_NVM_VERSION,				\
+	.nvm_ver = IWL_SC_NVM_VERSION,					\
 	.trans.rf_id = true,						\
 	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
@@ -114,10 +114,7 @@ static const struct iwl_base_params iwl_sc_base_params = {
 			.addr = DBGI_SRAM_FIFO_POINTERS,		\
 			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
 		},							\
-	}
-
-#define IWL_DEVICE_SC							\
-	IWL_DEVICE_BZ_COMMON,						\
+	},								\
 	.uhb_supported = true,						\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.num_rbds = IWL_NUM_RBDS_SC_EHT,				\
-- 
2.34.1


