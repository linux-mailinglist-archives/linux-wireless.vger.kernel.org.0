Return-Path: <linux-wireless+bounces-10626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CC93FC4E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0470B231BF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8AE15F32E;
	Mon, 29 Jul 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEnz5yiy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2D17C7CE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273642; cv=none; b=u9+/S1F+lbm6t64THu0kK5tHsh9uOD78voow/v3Vx0HIIZiky3FLszfXZw/64JZ8Cd1EOEzrkA1GFI6lx/8mRhQ2Ogqcwr1C0jal5MXYZyl2Gq7nhxleLIpRxi/5IUKW9SjXf46aBTEdVqhfPtlCll1UhBO1XtJj+g4m4cCYvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273642; c=relaxed/simple;
	bh=ZJ5XNef/+i6b+CPZzVRb12nGAUhRTOxxCSb9KGzfpnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqR2u1jUnloupwNYMIpMaxKi9wEyWcXP7zEiq0c9TM7jnvpYDAKZcwFWbe3q4HsPCTl62huv1AgRLrHl3YOBAaG6lFO6kVf6flJyy99BBa37UB0gwPOjGdCh5cU28D/U2A7bKMQoYm2v3RcHWowVuUgrwq3wKXz5ocSLabzTrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEnz5yiy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273641; x=1753809641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJ5XNef/+i6b+CPZzVRb12nGAUhRTOxxCSb9KGzfpnY=;
  b=fEnz5yiy8woQsHkD6H2kForZCyjvAxgW1EoTZj/lUfLNtzzqpHz1CJ6B
   wmqKaiesCPewZ+p/VkdFtU25KamKL50YuG8q8VelyZs6tc7pntAFMKQ66
   PM/SzBxFk5gG4ec13Ko+583ed7/20qE2tJVr8U+xFV0kTS37Nzlz3ea4U
   c5F0t5iaeYOgWxPMvuqC46M8MU6ObPea+uy9S+m5aQWK8thjdhwlgcPO9
   a5r9sZ1NOAinZ6QsQ0cz45tNvGRjHQt1PnKG28E3X3OOdoBfTRKB/LTqD
   6VgHE8c2GRzuBdVbdKYkuCmsPJ4ZT3t3RO8RQ76Yn6H018josbzBdAlxg
   Q==;
X-CSE-ConnectionGUID: DSA2L3dwQyWI7Lb2PjpgDA==
X-CSE-MsgGUID: mlLbeeuaQ1SiUG/rjFB96A==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445577"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445577"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:40 -0700
X-CSE-ConnectionGUID: D8GYkNKzQ8K0VYIVz19KfQ==
X-CSE-MsgGUID: hj1iYN0ISXGBJWVEuhTrxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288281"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/17] wifi: iwlwifi: config: label 'gl' devices as discrete
Date: Mon, 29 Jul 2024 20:20:07 +0300
Message-Id: <20240729201718.95aed0620080.Ib9129512c95aa57acc9876bdff8b99dd41e1562c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The 'gl' devices are in the bz family, but they're not,
integrated, so should have their own trans config struct.
Fix that, also necessitating the removal of LTR config,
and while at it remove 0x2727 and 0x272D IDs that were
only used for test chips.

Fixes: c30a2a64788b ("wifi: iwlwifi: add a new PCI device ID for BZ device")ticket=none
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  4 +---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 3b6b8b410be5..b230441abc16 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -148,6 +148,17 @@ const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
+const struct iwl_cfg_trans_params iwl_gl_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_BZ,
+	.base_params = &iwl_bz_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.umac_prph_offset = 0x300000,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+};
+
 const char iwl_bz_name[] = "Intel(R) TBD Bz device";
 const char iwl_fm_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
 const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b2abd4fd1944..34c91deca57b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -504,6 +504,7 @@ extern const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_bz_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_gl_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_sc_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 9ad43464b702..887fe56ad98b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -500,9 +500,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_trans_cfg)},
 
 /* Bz devices */
-	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_gl_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, 0x0000, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, 0x0090, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, 0x0094, iwl_bz_trans_cfg)},
-- 
2.34.1


