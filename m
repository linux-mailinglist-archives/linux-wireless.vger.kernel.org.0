Return-Path: <linux-wireless+bounces-25031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF909AFDE87
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE836541E08
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4B21421A;
	Wed,  9 Jul 2025 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7O6PbDr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894A222597
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032653; cv=none; b=Ytj/1rSFkUlrhRgizc01NOKXWXcBgnLGwINqZMh4BkkjM8bvg3tui3lBswxeuAXdkewBeACZMtOx3lpgYGp85YaeYgnjJoa2Hn4Y7JYwMf8MUPiP3PwDko9hJhnDxIWZP7zEZhgPGBK6Jle6GJUzQ6MXD0NxhkZq5B2Iv7z0cdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032653; c=relaxed/simple;
	bh=e0wFfcPvoFHpGN4v6vAAuRPMTy2PT2bo2VkqSIgvH8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fb3TF2Q7R7WuCuOyIY5A+BFWsyaPU7I5VSmvW3KFbd3CArTjJhDZuAL1sndUEFpKUnAVuzdqaMfxfEuq5N5D386HmJ8mtsgQjf8fQlulbBmFuB7NiXqE6ILlJlO+X7FSGdNqdnBdV5K15oeDXxkTZ2Ebh6CND0nlHgkIGQz+GhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7O6PbDr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032652; x=1783568652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0wFfcPvoFHpGN4v6vAAuRPMTy2PT2bo2VkqSIgvH8o=;
  b=V7O6PbDrJqYuSUCtQhIClaTopohoxj/gQKiF4nNlUlj2TNaKBuESVftx
   EW+6iqq28cD+CYiBhVD6f8rNXt7fzPsagLIxc3bUN4SimbAbhOCrIdtL4
   fJ3EYK4BfFfT0o/0btYUAV3Fvuad/CuwTQxFz1B0NQ3WoSwgHg4JhIr/8
   Lkbm5SSakdWIdGT3Kl+1V1vfXjQLimQIjl/1MeFr5mOhxvbH5ah4jzltw
   yk7pINht11BFkWg9S/y0KlWOMnQbq6A3E9imQSsbIb5x7HgPSzfOtJiZ3
   BQAV4fjV3YH6RDApCktFL789CVYtPSvMlCS5YmtWUD7Qj9uVuVkQ78BjZ
   A==;
X-CSE-ConnectionGUID: kxffBpWXROOih6oqs3dq6w==
X-CSE-MsgGUID: /YGDwajmQeOwX6c586uj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720655"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:11 -0700
X-CSE-ConnectionGUID: iAkMOW4uRHe2uTQm3ee6jA==
X-CSE-MsgGUID: uKdLPMqsQt+fXl4Dav/P3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390569"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 11/15] wifi: iwlwifi: pcie: rename iwl_pci_gen1_2_probe() argument
Date: Wed,  9 Jul 2025 06:43:35 +0300
Message-Id: <20250709063858.633cd9759510.I8b39f01e06ad7791efe718c267cbf367233920a3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
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


