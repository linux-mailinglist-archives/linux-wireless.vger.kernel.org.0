Return-Path: <linux-wireless+bounces-22368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AABAA8258
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DB717CDD5
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F611553A3;
	Sat,  3 May 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZv48BZL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A427E7D8
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301494; cv=none; b=Bptka2FmpBinO/eVDsoW7hZ6hK5iH9YU4Aq/JlhTn7qLtz3+NwZRAa/D+jE4bSUigP+leQJY2QOJ9AJB8N+plbg3XfySo+HiHZvgpLmj1yHKvF9VOstLMfFTvh8KBVuiBubQl0nOPkmTEP5WUU8+ijgs/jAwO9iGswssArqPPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301494; c=relaxed/simple;
	bh=ILfcGPLPPOe7CfbL7nE7pQOXayrMYeICAa9B/noQuEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDl0oQWvd1xMS84yDblJALyhqFNR3M23VlehZFbIf7JZa5d45qi/w3mtmMSjLUXzczjEr4ZSsHyO1+cMY0HjvtejRizYgnbmmIDnRTXMbu0/fP0EvypEGjfh91jl+C3RVkncL1lGfFy+gMJ8wV3XE5KS9oMVvWEWBqFfhdhq3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZv48BZL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301492; x=1777837492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILfcGPLPPOe7CfbL7nE7pQOXayrMYeICAa9B/noQuEI=;
  b=NZv48BZLD4k316lRVzn9FSJEDwNwuNyKs6HjbkWzdMrU7+Mz8rS3Eaz/
   aJ3Wo8ACl1kaqmb8U2Xo3oDaCRbn5UmS2nEVFipXtf56lyOGxMJb2oK1m
   gFkDtiIAK6bgTM6l6/MqK9B21gqjeLLe7Obn8dQ2oHpVRc4hQSizGp5lK
   ia3iJd4dMI220SkMwy1qNV0tPyuyHWnJ/X0AdQ35q8CB1ffeKWPnLgL1y
   Yj/eEyL5ZI7m5AN2RRMo47C2boYIio47n5MkdQ1HeBBtrXUQjGmPS0xz5
   Ln9PPf7ePXYErR7ovZwvZi8N0h/BmX4jtSm1xrAl/75QNTozBNSnnQ7EE
   g==;
X-CSE-ConnectionGUID: 5tYHgyKKT/u4BCgy4VVOrA==
X-CSE-MsgGUID: uv4j7JyVR2GeBeJa5cG1Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613257"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613257"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:51 -0700
X-CSE-ConnectionGUID: 24k6b7MORTKNrUc/mGneOA==
X-CSE-MsgGUID: 7BTRugVzTbiiowNwydZ7Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644246"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: pcie: rename "continuous" memory
Date: Sat,  3 May 2025 22:44:20 +0300
Message-Id: <20250503224231.8c2ccc0a7469.I6ef88a48c2a2e5c0baa881382017d34eb07f9316@changeid>
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

What's really meant here is "contiguous", appreviate it
as "contig".

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 26 ++++++++-----------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index e383757cfbe0..644ef3fb7ab7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -347,9 +347,9 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 	trans_pcie->prph_info = NULL;
 }
 
-static int iwl_pcie_load_payloads_continuously(struct iwl_trans *trans,
-					       const struct iwl_pnvm_image *pnvm_data,
-					       struct iwl_dram_data *dram)
+static int iwl_pcie_load_payloads_contig(struct iwl_trans *trans,
+					 const struct iwl_pnvm_image *pnvm_data,
+					 struct iwl_dram_data *dram)
 {
 	u32 len, len0, len1;
 
@@ -470,10 +470,8 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 			trans->pnvm_loaded = true;
 	} else {
 		/* save only in one DRAM section */
-		ret = iwl_pcie_load_payloads_continuously
-						(trans,
-						 pnvm_payloads,
-						 &dram_regions->drams[0]);
+		ret = iwl_pcie_load_payloads_contig(trans, pnvm_payloads,
+						    &dram_regions->drams[0]);
 		if (!ret) {
 			dram_regions->n_regions = 1;
 			trans->pnvm_loaded = true;
@@ -508,7 +506,7 @@ static void iwl_pcie_set_pnvm_segments(struct iwl_trans *trans)
 		cpu_to_le32(iwl_dram_regions_size(dram_regions));
 }
 
-static void iwl_pcie_set_continuous_pnvm(struct iwl_trans *trans)
+static void iwl_pcie_set_contig_pnvm(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
@@ -529,7 +527,7 @@ void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
 		iwl_pcie_set_pnvm_segments(trans);
 	else
-		iwl_pcie_set_continuous_pnvm(trans);
+		iwl_pcie_set_contig_pnvm(trans);
 }
 
 int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
@@ -566,10 +564,8 @@ int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
 			trans->reduce_power_loaded = true;
 	} else {
 		/* save only in one DRAM section */
-		ret = iwl_pcie_load_payloads_continuously
-						(trans,
-						 payloads,
-						 &dram_regions->drams[0]);
+		ret = iwl_pcie_load_payloads_contig(trans, payloads,
+						    &dram_regions->drams[0]);
 		if (!ret) {
 			dram_regions->n_regions = 1;
 			trans->reduce_power_loaded = true;
@@ -592,7 +588,7 @@ static void iwl_pcie_set_reduce_power_segments(struct iwl_trans *trans)
 		cpu_to_le32(iwl_dram_regions_size(dram_regions));
 }
 
-static void iwl_pcie_set_continuous_reduce_power(struct iwl_trans *trans)
+static void iwl_pcie_set_contig_reduce_power(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
@@ -614,6 +610,6 @@ iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
 		iwl_pcie_set_reduce_power_segments(trans);
 	else
-		iwl_pcie_set_continuous_reduce_power(trans);
+		iwl_pcie_set_contig_reduce_power(trans);
 }
 
-- 
2.34.1


