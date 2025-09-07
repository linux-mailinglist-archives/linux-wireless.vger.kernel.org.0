Return-Path: <linux-wireless+bounces-27051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D2B4799F
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D641B22C61
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E921D3EA;
	Sun,  7 Sep 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7Wq5OLb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154321CC49
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233858; cv=none; b=gx6oE659sCztukBoZ2ttc+UZgQyZXcb5+feZFR4J/wCmX92t6AsRwpYUwSWZaaE4CCBCtELkrS2dUwKWucMawLrT2RGcYcrAfh+QaFk6NftLuGRlkbE/HC6onDjBAnAPgbFgWOtMGvKWkMcMaBTmr8HrCtP/MOZqzgLA5/AcILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233858; c=relaxed/simple;
	bh=6+z9WDZKDdEtaDXp/Yq7cAEHfa9eAArgh8EdDEAJ/sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHexWNkvtweo+MCdHzuqtxBjL3gMbHH4I/YhV+twdX8BQ5awULhA+8pHk39/8+Qh3GUarB/tCGlsXuZ3YbfI9oMAiBSureZRibj+N2Pm37Mz79NU0Gb+MEkLzEgnG1H6dKyY47lAMal+NoUuAAXkcRiojIB4XN71GiTEExBlpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7Wq5OLb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233857; x=1788769857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+z9WDZKDdEtaDXp/Yq7cAEHfa9eAArgh8EdDEAJ/sQ=;
  b=N7Wq5OLbDOCguHLNq5TY8yoXmsCXfHZLEcZ7GOs9s9fayowX4YNx6NFB
   yjs9oFdxNTy55JWnMoYDp6vub3pwNuUg/ArSPtc0TF2ZjHADqm+t48Fdc
   eKslvrZC7Qq7+Ypp4b+MfSEIXyEds+2hzuX2lV9eb7UL1JE8lbGiNM5Li
   nsMtojA0d+M/sVODD9KWeIEuYGwXSKHgVuXNLUytjndCtxmqr9UPrgSjQ
   r4HsXLk0Ys/SM4bzbrl86kXn063fDR+lwWZxQww5f/GyvhDAWHobJYHWJ
   e2w9fPrNRB8XcIchmiUg0dwz/MHd2rrg7FafJ/QuQzLYgOzBBU0SUUByL
   A==;
X-CSE-ConnectionGUID: rV/GdV3UQgCTJdcBBss0WA==
X-CSE-MsgGUID: gdu774efRRyLXzbaF+3HrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973608"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973608"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:57 -0700
X-CSE-ConnectionGUID: VFLIOQe9SKmiLCmwXZDPDQ==
X-CSE-MsgGUID: HIDDyrqmTqie+pmUQ6zY6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790035"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: pcie: move pm_support to the specific transport
Date: Sun,  7 Sep 2025 11:30:03 +0300
Message-Id: <20250907112757.997193cabd04.Ic6648f040430c94150d0fa11601f50a6a630b862@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Currently it is under iwl_trans, which is the bus agnostic part of the
transport. But really it is relevant for pcie only, so move it to the
iwl_trans_pcie and export it via an API to the opmode.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/power.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c         |  9 +++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |  4 ++--
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h  | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  2 +-
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.c b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
index 6b42d6e5f30f..e7dbba7134f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
@@ -368,7 +368,7 @@ int iwl_power_update_mode(struct iwl_priv *priv, bool force)
 /* initialize to default */
 void iwl_power_initialize(struct iwl_priv *priv)
 {
-	priv->power_data.bus_pm = priv->trans->pm_support;
+	priv->power_data.bus_pm = iwl_trans_is_pm_supported(priv->trans);
 
 	priv->power_data.debug_sleep_level_override = -1;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 26aafaf19eda..b428cb522d0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -807,3 +807,12 @@ void iwl_trans_set_reduce_power(struct iwl_trans *trans,
 {
 	iwl_trans_pcie_ctx_info_v2_set_reduce_power(trans, capa);
 }
+
+bool iwl_trans_is_pm_supported(struct iwl_trans *trans)
+{
+	if (WARN_ON(trans->mac_cfg->gen2))
+		return false;
+
+	return iwl_pcie_gen1_is_pm_supported(trans);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_is_pm_supported);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3d5b47aaa4dc..e5d38b3bd76a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -844,7 +844,6 @@ struct iwl_trans_info {
  * @dev: pointer to struct device * that represents the device
  * @info: device information for use by other layers
  * @pnvm_loaded: indicates PNVM was loaded
- * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
  * @suppress_cmd_error_once: suppress "FW error in SYNC CMD" once,
  *	e.g. for testing
@@ -884,7 +883,6 @@ struct iwl_trans {
 	bool step_urm;
 	bool suppress_cmd_error_once;
 
-	bool pm_support;
 	bool ltr_enabled;
 	u8 pnvm_loaded:1;
 	u8 fail_to_parse_pnvm_image:1;
@@ -1262,4 +1260,6 @@ static inline u16 iwl_trans_get_device_id(struct iwl_trans *trans)
 	return u32_get_bits(trans->info.hw_id, GENMASK(31, 16));
 }
 
+bool iwl_trans_is_pm_supported(struct iwl_trans *trans);
+
 #endif /* __iwl_trans_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 36fe5863f735..2ee3bf4869d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -403,6 +403,7 @@ struct iwl_pcie_txqs {
  * @dev_cmd_pool: pool for Tx cmd allocation - for internal use only.
  *	The user should use iwl_trans_{alloc,free}_tx_cmd.
  * @dev_cmd_pool_name: name for the TX command allocation pool
+ * @pm_support: set to true in start_hw if link pm is supported
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -512,6 +513,8 @@ struct iwl_trans_pcie {
 
 	struct kmem_cache *dev_cmd_pool;
 	char dev_cmd_pool_name[50];
+
+	bool pm_support;
 };
 
 static inline struct iwl_trans_pcie *
@@ -1151,4 +1154,11 @@ int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
 int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
 				struct iwl_trans_rxq_dma_data *data);
 
+static inline bool iwl_pcie_gen1_is_pm_supported(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	return trans_pcie->pm_support;
+}
+
 #endif /* __iwl_trans_int_pcie_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 922397408138..c1fe87fb64c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -214,7 +214,7 @@ void iwl_pcie_apm_config(struct iwl_trans *trans)
 	iwl_set_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_DISABLED);
 
 	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_LNKCTL, &lctl);
-	trans->pm_support = !(lctl & PCI_EXP_LNKCTL_ASPM_L0S);
+	trans_pcie->pm_support = !(lctl & PCI_EXP_LNKCTL_ASPM_L0S);
 
 	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_DEVCTL2, &cap);
 	trans->ltr_enabled = cap & PCI_EXP_DEVCTL2_LTR_EN;
-- 
2.34.1


