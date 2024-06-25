Return-Path: <linux-wireless+bounces-9541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CE916E7C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7391F22F13
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B56171084;
	Tue, 25 Jun 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnBqoDbG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EA172BB4
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334304; cv=none; b=XcJtJdbSt4Sn2pM2kW4dJl6JOy+wOcmesJQhK2pm8m+cCnL6SxaHYc2MxLk9IKRWUHh/bwmxQJO77Y0S1RBS0jlqZreqwm4mAPnogqTHD6mEL3bdiQ3Q/WGe4mvLWP9+9QOA1Dlm0044uCV69mjc096WNeroRXZpe6irMaOqqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334304; c=relaxed/simple;
	bh=qcjt9CUqgGpmTvAl3ln5sBdA5qCZNoTHsib7pRrnQN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFD9pnD/FRUsTBJImjKDTm5T/F4+8t28SZatLUmJwcJ9dWEYrw9M3+j1LmForD/YExU/UA9lnCiRZxy13D3S9RcZdmHCzGbB8urSLhb+j9OvfJ93eCSH7c9vT6m1/Om4pU+U1lw0IPy8ekqSiKzM7l6viPIh1lxTZ0Qz3yOt4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnBqoDbG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334303; x=1750870303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcjt9CUqgGpmTvAl3ln5sBdA5qCZNoTHsib7pRrnQN8=;
  b=fnBqoDbGvgn4rzr9j3schYCEV2aG7az+QpasO0JjNZ55pRKJarc8p0iN
   nQ7IMxvYNJxwEMJPvBxQYHd3ZXKHpI81esDHWu5/N1Cf8L/sO+bfbmnjx
   eFnRIEooS+hEmlDZcfteDnk2zERzFl1tj5uFf+Iouxn6cm8D6Sn5HCIwo
   9+McQOGGlKGCmyXH6n1dPcnuBTvRqaGnGzg72ITF6NY1DjISHUycJDUmR
   cHGwCBimS/t1NxD20I0QrWM9Kvq1b4nUeY4WAASQAW4Bqy7AV3dhzd6gU
   l5C7tU0BNrYcOTz8Ky7c3RkY62fDKSNTNW0x/GmHD0wNGspe/Drg4C4/4
   g==;
X-CSE-ConnectionGUID: hgaoocJ+RtyYfsJEa97Wpg==
X-CSE-MsgGUID: W8QKej51QQylJua/q8fbmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594734"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594734"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:42 -0700
X-CSE-ConnectionGUID: Res97fxASWqPIzPotwn6sA==
X-CSE-MsgGUID: LDodxXSwRtO9S8UskgYTbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632603"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/17] wifi: iwlwifi: fw: api: fix some kernel-doc
Date: Tue, 25 Jun 2024 19:51:13 +0300
Message-Id: <20240625194805.4c530804b4ff.I68b894b9cdbd9560d86b92646e9b6b17a6d5117e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are naming issues of structs vs. kernel-doc,
fix some that I noticed now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h   |  4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h |  4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h    | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h     |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
index 4419631604b4..1fc65469990e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2023-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -76,7 +76,7 @@ struct iwl_phy_specific_cfg {
 } __packed; /* PHY_SPECIFIC_CONFIGURATION_API_VER_1*/
 
 /**
- * struct iwl_phy_cfg_cmd - Phy configuration command
+ * struct iwl_phy_cfg_cmd_v1 - Phy configuration command
  *
  * @phy_cfg: PHY configuration value, uses &enum iwl_fw_phy_cfg
  * @calib_control: calibration control data
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index 08a2c416ce60..f192e02e4ba8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -113,7 +113,7 @@ struct iwl_phy_context_cmd_tail {
 } __packed;
 
 /**
- * struct iwl_phy_context_cmd - config of the PHY context
+ * struct iwl_phy_context_cmd_v1 - config of the PHY context
  * ( PHY_CONTEXT_CMD = 0x8 )
  * @id_and_color: ID and color of the relevant Binding
  * @action: action to perform, see &enum iwl_ctxt_action
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 532d5cfa9162..19eb6008fe4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -462,7 +462,7 @@ struct iwl_per_chain_offset {
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_PER_CHAIN_S_VER_1 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v1 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
+ * struct iwl_geo_tx_power_profiles_cmd_v1 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  */
@@ -472,7 +472,7 @@ struct iwl_geo_tx_power_profiles_cmd_v1 {
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_1 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v2 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
+ * struct iwl_geo_tx_power_profiles_cmd_v2 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
@@ -484,7 +484,7 @@ struct iwl_geo_tx_power_profiles_cmd_v2 {
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_2 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v3 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
+ * struct iwl_geo_tx_power_profiles_cmd_v3 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
@@ -496,7 +496,7 @@ struct iwl_geo_tx_power_profiles_cmd_v3 {
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_3 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v4 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
+ * struct iwl_geo_tx_power_profiles_cmd_v4 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
@@ -508,7 +508,7 @@ struct iwl_geo_tx_power_profiles_cmd_v4 {
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_4 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v5 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
+ * struct iwl_geo_tx_power_profiles_cmd_v5 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: 0 for not-South Korea, 1 for South Korea (the name is misleading)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index c00f9422306d..69a204c7f14a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -423,7 +423,7 @@ struct iwl_lmac_scan_complete_notif {
 } __packed;
 
 /**
- * struct iwl_scan_offload_complete - PERIODIC_SCAN_COMPLETE_NTF_API_S_VER_2
+ * struct iwl_periodic_scan_complete - PERIODIC_SCAN_COMPLETE_NTF_API_S_VER_2
  * @last_schedule_line: last schedule line executed (fast or regular)
  * @last_schedule_iteration: last scan iteration executed before scan abort
  * @status: &enum iwl_scan_offload_complete_status
-- 
2.34.1


