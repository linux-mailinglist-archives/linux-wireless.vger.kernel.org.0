Return-Path: <linux-wireless+bounces-22376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89747AA8260
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C1B17CB67
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FF27EC97;
	Sat,  3 May 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5Tm/v7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8081A239E
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301509; cv=none; b=Wceh8Eo8DG1nA+wpWsr8f3O8fj/djy7JXXMnlLEYiBg/4Hdq+/jG8jksN3kUJTnF/M7NCgNN/IXJJ/xwvNW1i0HwQc4+Au0a61aAAE9yYN6eh2gcRS+hT2yukdPthwa1CJZI1+u3HPc6zxmHapyKPLvigEOWubMM1RALLm155cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301509; c=relaxed/simple;
	bh=Y90ssbHEIpPCx8q/7LTrHev3ODDqgVyrptfjsaBU0dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgI1Tf/9XURFT0FReND3MFNKjoWY/4sQ+dp5cIxNxMOfUDHVF+RdQO1SMGFnVtqFLwHbhaBtTot8l82vKCozdHqDcJvrwOWewM8bfMRmdS2DAW/7nmq7xSxZuug8sGnfXlOGKrZd13BKutvW1u0l93x4JFGpqjI+pIsuWl69qEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5Tm/v7o; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301508; x=1777837508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y90ssbHEIpPCx8q/7LTrHev3ODDqgVyrptfjsaBU0dw=;
  b=Q5Tm/v7oz6TdjOEP+N/I9aasinYA4SrO+JL9b4zehjKWnsV2qYOjtHFS
   vHnEV7Un+OV6S2n5aR2muWDu8A3ShYMFZ1Bo6fi5VhDHLcc44gFLbgrFH
   zTjTBrVnzpv+HLmVjGAOvgeTIxFaEJAFdFbu5yuHTGFLgEYKP/GMsrBce
   sPkqkE+Fo0MDS6iB8er23a5gdgwYzRhxtjleAoNkx10ZzqYml5dzB/ZK+
   VJB+ddM01OTrpN3AlKQND/hEUVYvj9hi/zPsJoJf9MqWchHmJ+BQJzD1r
   6xbJbnGzvc9wjGWwVh/K7ydPgv1HCTdbYj4EST6usGDRZt8UIGrcKtQxb
   Q==;
X-CSE-ConnectionGUID: vF8sJ/SLREKd/2G4smtU3A==
X-CSE-MsgGUID: 1xBQZr6QS/+KpiPDEZVNZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613266"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:07 -0700
X-CSE-ConnectionGUID: lmhILgzqQRSBzEVNUvFQSg==
X-CSE-MsgGUID: LhCrwKI0SXWMBu6IJTSSCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644331"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: trans: remove hw_id_str
Date: Sat,  3 May 2025 22:44:28 +0300
Message-Id: <20250503224231.4623574bdbe1.I8b09dd25702e7d7e2f0b4c61390baf73878f681d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This has never been used, so remove it now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h  | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index cdd16c37a585..627afd27e23b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -823,7 +823,6 @@ struct iwl_txq {
  * @hw_wfpm_id: a u32 with the device wfpm ID
  * @hw_id: a u32 with the ID of the device / sub-device.
  *	Set during transport allocation.
- * @hw_id_str: a string with info about HW ID. Set during transport allocation.
  * @sku_id: the SKU identifier (for PNVM matching)
  * @pnvm_loaded: indicates PNVM was loaded
  * @hw_rev: the revision data of the HW
@@ -887,7 +886,6 @@ struct iwl_trans {
 	u32 hw_cnv_id;
 	u32 hw_wfpm_id;
 	u32 hw_id;
-	char hw_id_str[52];
 	u32 sku_id[3];
 	bool reduced_cap_sku;
 	bool step_urm;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index cdcd3c8e47a8..cb41dbf3e0d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3980,8 +3980,6 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	iwl_pcie_set_interrupt_capa(pdev, trans, cfg_trans);
 	trans->hw_id = (pdev->device << 16) + pdev->subsystem_device;
-	snprintf(trans->hw_id_str, sizeof(trans->hw_id_str),
-		 "PCI ID: 0x%04X:0x%04X", pdev->device, pdev->subsystem_device);
 
 	init_waitqueue_head(&trans_pcie->sx_waitq);
 
-- 
2.34.1


