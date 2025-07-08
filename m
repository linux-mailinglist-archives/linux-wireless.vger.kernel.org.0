Return-Path: <linux-wireless+bounces-25002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C883AFD83F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FF958453C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A221D3E6;
	Tue,  8 Jul 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5boqXCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5814EC73
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006079; cv=none; b=UZm3+xixvbhs+b5Uww2GqeQk91udqvFT1NTbRazwRl4vq0rsNpuyQ4hFL9bKqgbdfsiZwnfZYBqe8VwRrRIkTzYA3cc2t1kPcItxRJLesiudMkDtfZYSNqCmc2C5ISUSGIYbX3HggIJZum6vvMlQqeYNYuhbi6iOhFeO+/Fr/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006079; c=relaxed/simple;
	bh=O/DLSEBvYM0VCAmIbZuAc7I2/r61ODVHkovgUv8Sl5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRT3o29TnBJoBpxHTlshO92DL8HWROMXo0eSC77xj/XTFOdkPPQGQ3P2OfRqwMq3MBixnDUj6xZEfZM0FOao8XDhr+vT20X4UYR4tg9jsBf8Qp0xGxT1uEvthZwm/bfmrqr4rOX+NxYYVhcPeUSluP3eWbpkwLwVUU+XmW4DCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5boqXCl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752006078; x=1783542078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O/DLSEBvYM0VCAmIbZuAc7I2/r61ODVHkovgUv8Sl5g=;
  b=E5boqXCllsbtqFimN9LfCqTaPO2G9+kqvwu3A5lj/RvTMPtstzhV4vPg
   OCQIm33wep1L6SPK8wFOfUv4u0d2SB5tiYAKEIAHV1fnURmXflznQVdfl
   VcXcrymV1fhOYO39u/OC8LuOPvUd69xpIgdT8zD8FqgHsI8D/VmZ9V6Vk
   b+HOILIk7y1DKR9eDSGi0a+WdqFFGpBZgDB5L1LJt2ExkpFsNMNNRZPaE
   yEmU84ZAzOeDlW06WYb91mzoLx5vgy3uRTX0EYV6vT0K4AfIbbqBBvpJh
   0y2o8y8DOPbe85W2wpwnmhkIOTIcAPZCumkZHuWDjzqA5gf99e982sb3E
   Q==;
X-CSE-ConnectionGUID: l8bSLk9bSjayLIO8gjf+oQ==
X-CSE-MsgGUID: MTtyWn4TQISnkhY8YQptLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="56867144"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="56867144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 13:21:16 -0700
X-CSE-ConnectionGUID: dILuGp/dTbuuHpw5lJsa1A==
X-CSE-MsgGUID: fK/wyHuNTQmpc2j3FVPnuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161142968"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 13:21:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: mask reserved bits in chan_state_active_bitmap
Date: Tue,  8 Jul 2025 23:20:55 +0300
Message-Id: <20250708232043.4b1b9094d059.Ic9be0a3fc3aabde0c4b88568f3bb7b76e375f8d4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Mask the reserved bits as firmware will assert if reserved bits are set.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 5 +++--
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 5cdc09d465d4..e90f3187e55c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -754,7 +754,7 @@ struct iwl_lari_config_change_cmd_v10 {
  *	according to the BIOS definitions.
  *	For LARI cmd version 11 - bits 0:4 are supported.
  *	For LARI cmd version 12 - bits 0:6 are supported and bits 7:31 are
- *	reserved. No need to mask out the reserved bits.
+ *	reserved.
  * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
  *	Each bit represents a set of channels in a specific band that should be
  *	disabled
@@ -787,6 +787,7 @@ struct iwl_lari_config_change_cmd {
 /* Activate UNII-1 (5.2GHz) for World Wide */
 #define ACTIVATE_5G2_IN_WW_MASK			BIT(4)
 #define CHAN_STATE_ACTIVE_BITMAP_CMD_V11	0x1F
+#define CHAN_STATE_ACTIVE_BITMAP_CMD_V12	0x7F
 
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 74b90bd92c48..ebfba981cf89 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -614,6 +614,7 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
 	if (!ret) {
+		value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V12;
 		if (cmd_ver < 8)
 			value &= ~ACTIVATE_5G2_IN_WW_MASK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 326c300470ea..436219d1ec5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -251,8 +251,10 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 			cpu_to_le32(value &= DSM_UNII4_ALLOW_BITMAP);
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
-	if (!ret)
+	if (!ret) {
+		value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V12;
 		cmd.chan_state_active_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_6E, &value);
 	if (!ret)
-- 
2.34.1


