Return-Path: <linux-wireless+bounces-25065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D0AFDF25
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478FD4E5221
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653A426A1D9;
	Wed,  9 Jul 2025 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej6haONo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB526A1CC
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038232; cv=none; b=KX/FnngaSasgQOlfc6lmOe71EQDgp7CUXShrNs6anSNs/hiAG6fOsoHap0r6Q26t5ppkMcIKZcmLOMCH4fPNNnYhIlg0l1ZcsTk+GCJ92xtN6sx645ulbYmsvVfj5JJCHGJj/oDA96sLoquWz1SQP1h1b3DwlvFpvXGUa0X339E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038232; c=relaxed/simple;
	bh=GtuEbTpamAK+AAUTtJ6VaTKL6lc+8v2trQGdLhUqw6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsP4fsr7nOAxF8l+fnd6yhbkjYgKq0bcseFyFR+jMgoeDAXzrclk4HSIPjx6EpsqVwgJZ5nahAK74EeJy41Rc94vTze9vnboQfYFlDjC/jMdYg/Bla28HTrY0tm6AO+FqHep51zNs8ZLyqlvZ7aH610wjyPtOO3+h+QLEGSr8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej6haONo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038231; x=1783574231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GtuEbTpamAK+AAUTtJ6VaTKL6lc+8v2trQGdLhUqw6A=;
  b=ej6haONoY3kYV+f8T9GbcDjQCe/BrkyfNKdHpwjU1u9+JH/ghBc8j9p0
   5Me3auM/SOTordgIqqgnQHHJnAt0xqvPpqRSZpplpLCZR5ZT6anfL52Pu
   t/Vuq/lf3vyj1Oi1KSJMRp+n3jnj+59Z+39NNG2ccqWS/4lvBV1tI5bJH
   U9cZBmeHv+3s+sAI//LybzFQlaFnZh5YzSED3MOag3U949ifVCPIEEyCf
   Ov2Ppsao+5DAkCgiyMG1D+15tLqr5Uj0Ucx3PE9kr+XiYfXtddffuxrpw
   dU9RvmE1aYikECL52iHlGUiAg+g9Wtu0BejIYfGAZTN90H8oVK/syhbVr
   Q==;
X-CSE-ConnectionGUID: 3jc3+L4JRJybJ2VvK0wpfQ==
X-CSE-MsgGUID: Mdnxe0edSuOskHzI3ZOnpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091178"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091178"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:11 -0700
X-CSE-ConnectionGUID: 1Etkg9ZAR0WpA1Ji+hUISw==
X-CSE-MsgGUID: +ft6efHrTXq/tL+Ixom0QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327887"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 11/15] wifi: iwlwifi: pcie: rename iwl_pci_gen1_2_probe() argument
Date: Wed,  9 Jul 2025 08:16:30 +0300
Message-Id: <20250709081300.72d87406f8d7.I8b39f01e06ad7791efe718c267cbf367233920a3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Using 'trans' for the mac config is confusing, rename the
argument to 'mac_cfg'.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h | 6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index ec17e2e84151..7dd11891ccfe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1078,9 +1078,9 @@ void __releases(nic_access_nobh)
 iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
 int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
-			const struct pci_device_id *ent,
-			const struct iwl_mac_cfg *trans, u8 __iomem *hw_base,
-			u32 hw_rev);
+			 const struct pci_device_id *ent,
+			 const struct iwl_mac_cfg *mac_cfg,
+			 u8 __iomem *hw_base, u32 hw_rev);
 
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 5f65ab7a3fa6..fd5866e667c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4130,8 +4130,8 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 
 int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *ent,
-			 const struct iwl_mac_cfg *trans, u8 __iomem *hw_base,
-			 u32 hw_rev)
+			 const struct iwl_mac_cfg *mac_cfg,
+			 u8 __iomem *hw_base, u32 hw_rev)
 {
 	const struct iwl_dev_info *dev_info;
 	struct iwl_trans_info info = {
@@ -4142,7 +4142,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie;
 	int ret;
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info, hw_base);
+	iwl_trans = iwl_trans_pcie_alloc(pdev, mac_cfg, &info, hw_base);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
-- 
2.34.1


