Return-Path: <linux-wireless+bounces-25036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D59FAFDE9B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8641673A9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751D3208;
	Wed,  9 Jul 2025 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwVBRb69"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7823ABA1
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033422; cv=none; b=sYvaNbg8deHn1uzf8RSAMl9KIV4MOEjrV2Z05r6DHL4KheI84JUqIKvH6D/2+70XQLEtFxm8PvccOseeHIHqpn6+1WtTM6mHol/97DMbu4FauCl/IfFwT/JD7XRaQWreGJ3Ug3xPOsA7JVEZhJnN/H4l2gyX3YAJHF32PR+5HBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033422; c=relaxed/simple;
	bh=NnBoW9VdNkiPLCIm7PQlyx2dly6Ugzk80cy+nWsft7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E4H70XmYt8Rbvjj9aAydICBf3YvNsXQAcpLAiTExTA0h5Fkvqsq8TaGD0XyCYhzTbAIolKGnhASWjpadG3JlIjQEUIuHXralaDkzvDINGGZ6n5BVoC74hfkvFoFBLJQ/WQPturie3FK1kythKBD0zN/CcPWnVU2srweEm+g6qM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwVBRb69; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752033421; x=1783569421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NnBoW9VdNkiPLCIm7PQlyx2dly6Ugzk80cy+nWsft7k=;
  b=CwVBRb69aBofQz8za9MlkuWrramnPsWXup1uc0KTLR+0rdOT+4ri8jx/
   I8IQ0UUzPs71WxqgLC/BKPMfvxbj4EG1mkWcbXP1fMOATCZGJytZCF5Xq
   07hDKdvDAO0nM0O3ZO12Ssl2Nbk5M8ueUbnLggS9DWJWkKqWEJcURL3ZA
   E9ujls9tP4zTxIMkh+/euXJFz5+e0lA6RWQquhPQ/VzL12+1wDiAEM0sH
   h3WP2M+ifik9azGG7v6F/wTlkvrmXpcgwnX9KAuPtroDB8BMeZKIP1E5I
   llhI8bCrWpmfBORNct/nQviDJwiNXW/jWdIY7JvjShZGAH60ENY6mgyxU
   w==;
X-CSE-ConnectionGUID: YyWFXOHMS4aa+Iby6AWWvQ==
X-CSE-MsgGUID: ikfDEndOQOuj0RsTqlXZFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64866863"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64866863"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:57:00 -0700
X-CSE-ConnectionGUID: aQeA3RkXRzu6xedzVhCfjg==
X-CSE-MsgGUID: 5Na8F0+LTw6yb87kYIUsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155397059"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:56:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-fixes v2] wifi: iwlwifi: mask reserved bits in chan_state_active_bitmap
Date: Wed,  9 Jul 2025 06:56:39 +0300
Message-Id: <20250709065608.7a72c70bdc9d.Ic9be0a3fc3aabde0c4b88568f3bb7b76e375f8d4@changeid>
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

Fixes: ef7ddf4e2f94 ("wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v12")
Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 5 +++--
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)
---
v2: added a Fixes tag

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


