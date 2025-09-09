Return-Path: <linux-wireless+bounces-27123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E198B49FF2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789574E51F2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F7272E66;
	Tue,  9 Sep 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/Y9cNqK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2826F285
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388122; cv=none; b=XJVdfKRq3ol5A1XO+pe2oRq1yj681fprfXxEOoeE4HG95A4wIV2fVFPxv/q+Iw7uFlH3+Mg5uKMktWhyK5uvRuN6YZ+fzCnfbGnQdJNXhsaJAc6GR8ARYOVslynUCyDMj5GFd+Y0hga1S/JKBeBhdT4zVhrn4ehhvmJRM/AnUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388122; c=relaxed/simple;
	bh=6+z9WDZKDdEtaDXp/Yq7cAEHfa9eAArgh8EdDEAJ/sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt48oGPXvsZPJWrEWR92De1QBRZNdCVsJyfqwquVI4n8Vu0yF6ooNxIYl9/pPEWRSXtPDPdhys5gkqbcIwM2R5Zaoiax98cuEJ38EZXaIPnpCIynPv1BK223PdZZCPcX1VLURoWILwuQP88A4Czp01ztn2Ob9w/f2l6g0RnTJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/Y9cNqK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388121; x=1788924121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+z9WDZKDdEtaDXp/Yq7cAEHfa9eAArgh8EdDEAJ/sQ=;
  b=Z/Y9cNqK/KPw0W1XFUs/W/JageaTyGa3iBLZOQdYa7uh6G8PDdfKZLPp
   ooNMhwrX1oBvBPr0Klm4kvbgbihCGNmWwcHHqvDUOYLciylK3+EgSDPYm
   3Ef2pdm+aQ3jkB8Mm6Qs4vyY5eiJlsz4b+XBk3ItUY9PHqEitAN2SSfF6
   st9PGK04Pt//0y7mdcxBIUrIy0QewcjYVycpDOdhpNokKTtew+/O+P6s5
   4f6hLrLuo5dZs9/asn23TloVir6HRae9zijGAy8FZgKDBVyN2ZVVhj03f
   rYUPE0wV65CCrU5LB8z4MzLiBYgkMRl/q1qefMKboQD2g55qao6WpSflZ
   g==;
X-CSE-ConnectionGUID: hpz7ftGWRFShOXn6KFYGkQ==
X-CSE-MsgGUID: pLi8y/zUQv6h+MH1Ed4lTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281056"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:01 -0700
X-CSE-ConnectionGUID: 5zc2OhiYSMqK7feGZDofcQ==
X-CSE-MsgGUID: B7Gz+jqNQ32+JE+Q92l4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950362"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 04/15] wifi: iwlwifi: pcie: move pm_support to the specific transport
Date: Tue,  9 Sep 2025 06:21:17 +0300
Message-Id: <20250909061931.997193cabd04.Ic6648f040430c94150d0fa11601f50a6a630b862@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
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


