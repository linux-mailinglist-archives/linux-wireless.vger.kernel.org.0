Return-Path: <linux-wireless+bounces-22747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B6AAAF97D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E2E4C2611
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F7A2288D2;
	Thu,  8 May 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAr6Xoxk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538B22425B
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706418; cv=none; b=SBRHnCqcciptmqaoNOMQ+NqqAGXNJHnCJ0ENCaXm/SZCFhOYfRNTrMUJP7H3HCvgkp5eJGtZYMXxPsA4Rc5VFYd1x8iCKij2hy+DX8O9khcAJ1HEGlLrvibqCWBuCSZdxsnTcaPWQn8F+cOm6szJvL7AX0q+mFznE3OJEVY2WZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706418; c=relaxed/simple;
	bh=OoFEskxI6MujMxRGQbtYWMseDmQDQUXo5ATdNkH6S2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAMAJPE4qUDANpyXmZrrv/ThZIBsg/schrOlHfQVvWMfJWsjPyPfvijQ2fXC8pis1cyUt+uBMsWmHNfEvqmfGAzyY9RTHJpwIPB/kxu7KpaFE3peVc4EGMffTztzY17PgKTE6WUNIR7PKgGoWSmg7mt02E8bmGv16DECm+syDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAr6Xoxk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706416; x=1778242416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoFEskxI6MujMxRGQbtYWMseDmQDQUXo5ATdNkH6S2E=;
  b=hAr6Xoxkk10lxDpWDtc1bySWnJM3POavv0QSDM6WjTz5TVWjZ3Lhwnep
   vrDEZ3uGypWCtAm+yMeocvf1Kx5KArWCBbMq9JF1HsZi45RjNoNJOb3jk
   j4ZQURZVmgX2vHVJkpRYyslugIovhbT7DHjIySskD5BC71Bxna1sylmJL
   hkn2+4VmFdaP/GLPudksUZxBwQ+E3/fJSE4324E9+lJOJpQJNENUyu9rf
   YXFKJ3/8ooMiH2h82v7Fr0/rqIrf55jYdGKNn5TZQvCa30oPP0Lr3Vr9Y
   swM+bmjcAkqG0vzaRUE29utGcQpyYvrY8bBDAw3OQo8eSaLLJuZcro87y
   A==;
X-CSE-ConnectionGUID: 0SANM3T6SEap1p/WahLQyg==
X-CSE-MsgGUID: VsfeG8l2TgKfZuQ7yyBzRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688048"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688048"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:36 -0700
X-CSE-ConnectionGUID: q5JZ3JqgTCCfcrZ0JW7dJw==
X-CSE-MsgGUID: Nrw40ctESHCbTWFb1X6PcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347865"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: cfg: remove rf_id field
Date: Thu,  8 May 2025 15:13:01 +0300
Message-Id: <20250508121306.1277801-11-miriam.rachel.korenblit@intel.com>
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

This field is always set for >= 9000 series, but then we
already check that, so it's not needed. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.622518e090e7.I48f1f0cd2a715d6941a47f372f3edbb6b727498d@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 4 ----
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   | 4 ----
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 4 ----
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 2 --
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c     | 2 --
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 4 +---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 3 +--
 8 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index db11252ca73c..f95cf1c0ae03 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -114,7 +114,6 @@ static const struct iwl_base_params iwl_22000_base_params = {
 
 const struct iwl_mac_cfg iwl_qu_mac_cfg = {
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
@@ -125,7 +124,6 @@ const struct iwl_mac_cfg iwl_qu_mac_cfg = {
 
 const struct iwl_mac_cfg iwl_qu_medium_latency_mac_cfg = {
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
@@ -136,7 +134,6 @@ const struct iwl_mac_cfg iwl_qu_medium_latency_mac_cfg = {
 
 const struct iwl_mac_cfg iwl_qu_long_latency_mac_cfg = {
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
@@ -176,7 +173,6 @@ const struct iwl_mac_cfg iwl_ax200_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.bisr_workaround = 1,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 0c3429dfca2a..7abe5f87ab34 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -120,14 +120,12 @@ const struct iwl_mac_cfg iwl9000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 };
 
 const struct iwl_mac_cfg iwl9560_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.integrated = true,
 	.xtal_latency = 650,
 };
@@ -136,7 +134,6 @@ const struct iwl_mac_cfg iwl9560_long_latency_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.integrated = true,
 	.xtal_latency = 2820,
 };
@@ -145,7 +142,6 @@ const struct iwl_mac_cfg iwl9560_shared_clk_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base_params = &iwl9000_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.integrated = true,
 	.xtal_latency = 670,
 	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index d78f8ecaf133..067252ef9c94 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -118,7 +118,6 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 
 const struct iwl_mac_cfg iwl_so_mac_cfg = {
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_AX210,
 	.base_params = &iwl_ax210_base_params,
@@ -131,7 +130,6 @@ const struct iwl_mac_cfg iwl_so_mac_cfg = {
 
 const struct iwl_mac_cfg iwl_so_long_latency_mac_cfg = {
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_AX210,
 	.base_params = &iwl_ax210_base_params,
@@ -144,7 +142,6 @@ const struct iwl_mac_cfg iwl_so_long_latency_mac_cfg = {
 
 const struct iwl_mac_cfg iwl_so_long_latency_imr_mac_cfg = {
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_AX210,
 	.base_params = &iwl_ax210_base_params,
@@ -170,7 +167,6 @@ const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_AX210,
 	.base_params = &iwl_ax210_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.integrated = true,
 	.umac_prph_offset = 0x300000
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 61ba92cac37c..a8fe9244a818 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -127,7 +127,6 @@ const struct iwl_mac_cfg iwl_bz_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
 	.base_params = &iwl_bz_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.integrated = true,
 	.umac_prph_offset = 0x300000,
@@ -140,7 +139,6 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
 	.base_params = &iwl_bz_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.umac_prph_offset = 0x300000,
 	.xtal_latency = 12000,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 9b1ae8de7529..a258f49b8325 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -123,7 +123,6 @@ const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
 	.base_params = &iwl_dr_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.integrated = true,
 	.umac_prph_offset = 0x300000,
@@ -142,7 +141,6 @@ const struct iwl_mac_cfg iwl_br_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
 	.base_params = &iwl_dr_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.umac_prph_offset = 0x300000,
 	.xtal_latency = 12000,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index d06e15a5a9d7..4786a7714f6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -127,7 +127,6 @@ const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_SC,
 	.base_params = &iwl_sc_base_params,
 	.mq_rx_supported = true,
-	.rf_id = true,
 	.gen2 = true,
 	.integrated = true,
 	.umac_prph_offset = 0x300000,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 85afdff0cc98..dfbca1ac34a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -258,7 +258,6 @@ enum iwl_mac_cfg_ltr_delay {
  * @umac_prph_offset: offset to add to UMAC periphery address
  * @xtal_latency: power up latency to get the xtal stabilized
  * @extra_phy_cfg_flags: extra configuration flags to pass to the PHY
- * @rf_id: need to read rf_id to determine the firmware image
  * @gen2: 22000 and on transport operation
  * @mq_rx_supported: multi-queue rx support
  * @integrated: discrete or integrated
@@ -273,8 +272,7 @@ struct iwl_mac_cfg {
 	u32 umac_prph_offset;
 	u32 xtal_latency;
 	u32 extra_phy_cfg_flags;
-	u32 rf_id:1,
-	    gen2:1,
+	u32 gen2:1,
 	    mq_rx_supported:1,
 	    integrated:1,
 	    low_latency_xtal:1,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b3eb6ceb4648..45a62733b28a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1812,8 +1812,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * extract the RF_ID.
 	 * This is relevant only for family 9000 and up.
 	 */
-	if (iwl_trans->mac_cfg->rf_id &&
-	    iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
 	    !CSR_HW_RFID_TYPE(info.hw_rf_id) && map_crf_id(iwl_trans, &info)) {
 		ret = -EINVAL;
 		goto out_free_trans;
-- 
2.34.1


