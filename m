Return-Path: <linux-wireless+bounces-27052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C690FB479A0
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8253C3BF7BE
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498820F079;
	Sun,  7 Sep 2025 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEWjwk7m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA421CC6A
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233859; cv=none; b=RtUXpqMLspg8zkdKrVbnNIDDD4N6js6k7tAbr/2Njv/8HS4g2VlthMisX0eNyyGsaple++SSAoAosfsLjtUaWbwvwR01/KkyQOxjE/nHOc8SpNfD1WaXQBp+H1UvkAxcWLjBPBPZtlWOj6YVjc4rR9FbJojyjrOfKlTL2lI1+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233859; c=relaxed/simple;
	bh=U5vv17nbva+Klrw3qCBcjKZIxudE37lliA0iTpguk2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0YXAZEC4kqwik/RRWwFMlvta+VTM41t4Gi26/6g1LJGO0iJNAH+L5uCb6GoUbZaiafF/5dwQOuxuBcpaBJrmMh8Z8+jly0WKkwWxaWJbFun93ChWVqH4LqF7yvcZH1mvabnm5s1qjzLwpsgTcjmJNbitl7lyrDjm/ULMNvbxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEWjwk7m; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233858; x=1788769858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5vv17nbva+Klrw3qCBcjKZIxudE37lliA0iTpguk2U=;
  b=nEWjwk7mRulYMwW0zhxvs2guBz9nlE6hBCsfnqtPclDcTuuJIarJVgGV
   O4W7OtvrPPCDZxI/XhKUMtWBkpC4aqL6jPteH9gzKVUTtusWIURbdXBQR
   uxb+LP9PfA3XYugCSIUtT8PCNfQWxsBp3f7o0lohWhAZXqWJcI6+0mKVk
   FAuZev+8KyFf2/mLmPAgJ8FiSZ1K4bpsJrmiveQETKs57GjU9dYgEBxsc
   FM/0iRgvJOQb4MZ00iDbGMc73BtpBDrqBYIUJbSKJT47RsOXS/YrTziVD
   derGt1Mcl244XergcBh3BH5uc4WsD09QaE6YoOUobsz5qkGcv1a7WQ2cm
   A==;
X-CSE-ConnectionGUID: 5jULHPBhRJGyTzCsTvlOUA==
X-CSE-MsgGUID: 5C7x33KCR8+nG3l37pWYCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973609"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973609"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:58 -0700
X-CSE-ConnectionGUID: YJCq0fbZRQCfJ2/v3V0Zsg==
X-CSE-MsgGUID: AadqXevxQ9S+93tg8IMW0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790043"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: pcie: move ltr_enabled to the specific transport
Date: Sun,  7 Sep 2025 11:30:04 +0300
Message-Id: <20250907112757.9f9dc80ab06c.I3eeca8b17abeba6ed30f0d681518c81ede0acf30@changeid>
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
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c            | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h            | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c               | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h | 8 ++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c    | 4 ++--
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index b428cb522d0d..5232f66c2d52 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -816,3 +816,9 @@ bool iwl_trans_is_pm_supported(struct iwl_trans *trans)
 	return iwl_pcie_gen1_is_pm_supported(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_is_pm_supported);
+
+bool iwl_trans_is_ltr_enabled(struct iwl_trans *trans)
+{
+	return iwl_pcie_gen1_2_is_ltr_enabled(trans);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_is_ltr_enabled);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index e5d38b3bd76a..a0cc5d7745e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -844,7 +844,6 @@ struct iwl_trans_info {
  * @dev: pointer to struct device * that represents the device
  * @info: device information for use by other layers
  * @pnvm_loaded: indicates PNVM was loaded
- * @ltr_enabled: set to true if the LTR is enabled
  * @suppress_cmd_error_once: suppress "FW error in SYNC CMD" once,
  *	e.g. for testing
  * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
@@ -883,7 +882,6 @@ struct iwl_trans {
 	bool step_urm;
 	bool suppress_cmd_error_once;
 
-	bool ltr_enabled;
 	u8 pnvm_loaded:1;
 	u8 fail_to_parse_pnvm_image:1;
 	u8 reduce_power_loaded:1;
@@ -1262,4 +1260,6 @@ static inline u16 iwl_trans_get_device_id(struct iwl_trans *trans)
 
 bool iwl_trans_is_pm_supported(struct iwl_trans *trans);
 
+bool iwl_trans_is_ltr_enabled(struct iwl_trans *trans);
+
 #endif /* __iwl_trans_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d931c6eaf12f..865f973f677d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -837,7 +837,7 @@ static int iwl_mvm_config_ltr(struct iwl_mvm *mvm)
 		.flags = cpu_to_le32(LTR_CFG_FLAG_FEATURE_ENABLE),
 	};
 
-	if (!mvm->trans->ltr_enabled)
+	if (!iwl_trans_is_ltr_enabled(mvm->trans))
 		return 0;
 
 	return iwl_mvm_send_cmd_pdu(mvm, LTR_CONFIG, 0,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 2ee3bf4869d2..207c56e338dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -404,6 +404,7 @@ struct iwl_pcie_txqs {
  *	The user should use iwl_trans_{alloc,free}_tx_cmd.
  * @dev_cmd_pool_name: name for the TX command allocation pool
  * @pm_support: set to true in start_hw if link pm is supported
+ * @ltr_enabled: set to true if the LTR is enabled
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -515,6 +516,7 @@ struct iwl_trans_pcie {
 	char dev_cmd_pool_name[50];
 
 	bool pm_support;
+	bool ltr_enabled;
 };
 
 static inline struct iwl_trans_pcie *
@@ -1161,4 +1163,10 @@ static inline bool iwl_pcie_gen1_is_pm_supported(struct iwl_trans *trans)
 	return trans_pcie->pm_support;
 }
 
+static inline bool iwl_pcie_gen1_2_is_ltr_enabled(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	return trans_pcie->ltr_enabled;
+}
 #endif /* __iwl_trans_int_pcie_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index c1fe87fb64c6..59307b5df441 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -217,10 +217,10 @@ void iwl_pcie_apm_config(struct iwl_trans *trans)
 	trans_pcie->pm_support = !(lctl & PCI_EXP_LNKCTL_ASPM_L0S);
 
 	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_DEVCTL2, &cap);
-	trans->ltr_enabled = cap & PCI_EXP_DEVCTL2_LTR_EN;
+	trans_pcie->ltr_enabled = cap & PCI_EXP_DEVCTL2_LTR_EN;
 	IWL_DEBUG_POWER(trans, "L1 %sabled - LTR %sabled\n",
 			(lctl & PCI_EXP_LNKCTL_ASPM_L1) ? "En" : "Dis",
-			trans->ltr_enabled ? "En" : "Dis");
+			trans_pcie->ltr_enabled ? "En" : "Dis");
 }
 
 /*
-- 
2.34.1


