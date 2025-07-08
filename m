Return-Path: <linux-wireless+bounces-24988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9DAFD7A2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3163AC4D6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57CF241667;
	Tue,  8 Jul 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9IcPrXk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26E23C519
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004289; cv=none; b=FwvzqyKqiRghVN8C/mtbCeKc+nnhDYjJjtOWFj9sJD0IFaKXF0SlSkIF7ceWZclIKlQE4lKVH/A0kMH84BDXHm88MI0DEjHgMSky0Z3xXGirhrsT4+aU7dHK/ukmV63MgI81WXpkOmZ/vTRAWXYXSEXdnTU0y2YraWC3G/fHQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004289; c=relaxed/simple;
	bh=e0wFfcPvoFHpGN4v6vAAuRPMTy2PT2bo2VkqSIgvH8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Osd1m1+AxOHw+fHMi1fFAbnckVdaqWSmrNWU55FhntAYN9qcT+4B8bwBWBPXqNqU1Ns9c+EDvLJo9LwGZgQk4o8/h6TLTNPFWeTpgrHCmn/kQUXHvg27uM3Mb347QPqkNG1Vgb2eVJEBKksomx4zjTRbEKp5aPY/MgHSzU5JxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9IcPrXk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004288; x=1783540288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0wFfcPvoFHpGN4v6vAAuRPMTy2PT2bo2VkqSIgvH8o=;
  b=X9IcPrXkq9DzWYQzvmoBlzn0uiavcfCrttYjcX47DTuEy8IhXjIQAN7o
   KMgpKwyO6yytuqk0BpAbucqpoal6yBrezg4fxWz56a8MXU2KNEfchx1YL
   qTPRODi0w2zTSNm6hbbae+Pvw9Gzdiuf8x4nbJtfhRKuIPSfblMMkfW2B
   kNHdJg/I8ZpKlQu2ieopUMzGIYCpzcqtDdJ8+p3y1VpMST3XwVt4UkUPi
   qOv5LevEZwmje9R3SNuQqaR0K3E50oS1O4jt2LlUHVt0+OkT0G4LKzhjy
   1rUicDQhOityZh2WSDtdHpmYjnn0KQtXjHTu+vPgP9jnL84ot3/bJGB1V
   Q==;
X-CSE-ConnectionGUID: lVO4sbrFSdSdLz1/LzGsHg==
X-CSE-MsgGUID: CN2W+CfnTO6q1HJEFTf2wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229726"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229726"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:28 -0700
X-CSE-ConnectionGUID: 3A6Dm4GGTPqpeeTKiqytIQ==
X-CSE-MsgGUID: mvGXkWZfTF+DNmqo/w8OiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668986"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: pcie: rename iwl_pci_gen1_2_probe() argument
Date: Tue,  8 Jul 2025 22:50:49 +0300
Message-Id: <20250708224652.a614fa44559e.I8b39f01e06ad7791efe718c267cbf367233920a3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
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
index 89a25af6b9fd..b2c95cca875f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4133,8 +4133,8 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 
 int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *ent,
-			 const struct iwl_mac_cfg *trans, u8 __iomem *hw_base,
-			 u32 hw_rev)
+			 const struct iwl_mac_cfg *mac_cfg,
+			 u8 __iomem *hw_base, u32 hw_rev)
 {
 	const struct iwl_dev_info *dev_info;
 	struct iwl_trans_info info = {
@@ -4145,7 +4145,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie;
 	int ret;
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info, hw_base);
+	iwl_trans = iwl_trans_pcie_alloc(pdev, mac_cfg, &info, hw_base);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
-- 
2.34.1


