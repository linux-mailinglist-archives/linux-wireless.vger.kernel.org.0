Return-Path: <linux-wireless+bounces-26739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1FB396E1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74953B4388
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7728B2C2368;
	Thu, 28 Aug 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkAgaOqk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26802DE1FE
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369621; cv=none; b=IRMifq9qz4iYey9MRgJpgqrNIPYC8nuSD8RnynYCngwoLIMqxp+53MQqG37pKVFKTju1wx0hjeEZ+KoVHwb2Y2dxYwqYjT55bGYINcnD20BuD6mzGO3EFT9muuKDY2LOvU8wzyD+J4CmCBZMCfZfWVSJ4Ia0m3l1JR1OLZkmHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369621; c=relaxed/simple;
	bh=IxyifHUkF0Kez12oofkENNTFo1pz6uwSda2lcJcpv4k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAUz16HXLaR0NglQv2j9oYmT2zDjjIp1e/y4nji/rTAM4cHUJ+hpn9drU7+bWyE3xrEdb9zxomP7LzuEs0lJCunCddHFwDSsTT66Tjiuf/sbQWthhPyxVSPZQ9mq8/qBa0IalGeed7CgVqEAQWVPzQ+XXqnE0SuN794Hdi29dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkAgaOqk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369620; x=1787905620;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=IxyifHUkF0Kez12oofkENNTFo1pz6uwSda2lcJcpv4k=;
  b=SkAgaOqkXqkaw9q3gFjOA4swinBKHMDq97fdnWk+3N2dUV7U0p0Rl9cY
   eys/nJ1dnx8qA2CaT/4emtMycA0w8/DvNzeJ1TeAQQoUojczIEmFMnUPl
   hgSk1mfVYA+BKxLrQry6RFOPfitMwcy6no11JOIXYnx8YZl9MmTebYiDg
   GihFWPN/XoqjLhEc+KjdjBn+sLG3infxiYispZXmOWHyr1TPoitK5Tt/p
   oNgcSVE3jbLNJwJvC+01kwfVg5NgqW84Ev853W6RtuvBml8rOH+J4bopS
   GxOnwU8ubB/GyP36nyfrJvqzA+fMT9rx7NO0iaeYuZb3fwX8uygmRcfeJ
   g==;
X-CSE-ConnectionGUID: 4o46eY5gSCKRAYuewsiJ6Q==
X-CSE-MsgGUID: mZAWFK96RneFOEaoTGttng==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003356"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003356"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:43 -0700
X-CSE-ConnectionGUID: A62kvqFOQq+X9LfxiZ1lAw==
X-CSE-MsgGUID: QFeqgg7sRy2sa1Iji0J1mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224509"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: gen1_2: move gen specific code to a function
Date: Thu, 28 Aug 2025 11:25:55 +0300
Message-Id: <20250828111032.a584254bcf83.I69d176b94d23f0f34d28733c48964f277a0a67a1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The remove function will be called also for gen3 devices, so move out
the gen1_2 code to a function that will be called only for gen1/2
devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c         |  7 +------
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h |  1 +
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c    | 11 +++++++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b7add05f7a85..5cb0b519e762 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1171,16 +1171,11 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	if (!trans)
 		return;
 
-	cancel_delayed_work_sync(&trans_pcie->me_recheck_wk);
-
-	iwl_drv_stop(trans->drv);
-
-	iwl_trans_pcie_free(trans);
+	iwl_pcie_gen1_2_remove(trans);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 4f49473decb9..b5114fb4eaa2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1103,6 +1103,7 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *ent,
 			 const struct iwl_mac_cfg *mac_cfg,
 			 u8 __iomem *hw_base, u32 hw_rev);
+void iwl_pcie_gen1_2_remove(struct iwl_trans *trans);
 
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index bd503cb8f504..234a02223c20 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4298,6 +4298,17 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	return ret;
 }
 
+void iwl_pcie_gen1_2_remove(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	cancel_delayed_work_sync(&trans_pcie->me_recheck_wk);
+
+	iwl_drv_stop(trans->drv);
+
+	iwl_trans_pcie_free(trans);
+}
+
 int iwl_pcie_gen1_2_finish_nic_init(struct iwl_trans *trans)
 {
 	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
-- 
2.34.1


