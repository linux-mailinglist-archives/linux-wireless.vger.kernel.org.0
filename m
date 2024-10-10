Return-Path: <linux-wireless+bounces-13848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F311999846E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B531C229D9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA6C1C32FE;
	Thu, 10 Oct 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O93VeC7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834D1C3316
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558332; cv=none; b=mZawmPKKBOmjPqCh2Bd7iOeQ814rIPTvhsMvpaQDFhBvQ8No/+cIarjoY/9QFxtaFWd5skzY0KzfBK0Ify0Hh2zBuj4AaiHpBclvXCjfTqiVyhcOB7YRqTd/Ti3Dk89NsaL8aFR3Z2nb9nY+MDvPjMlW1zrfzbZXSQ2oTKc/af8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558332; c=relaxed/simple;
	bh=Ao31ZAkhPCvQj+GZVD0jFba/9Vv8oA4aGHXpV5jlYR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSYEMxdxaJgIvD3yvvcRnDsXke79U1Wj+MNmQZnP1h/xGb+Ox/HANGP7Q/5cnyCEtgg6nHCJAl0LJuYdJGhx98YCF7IPvjj2jTVH9pcYJOoqbwhXehNNyET43MEMhZUYnSuSkWZAMT1dp2j5ZMcIa53yU5BjK1Ml0+0g6BsorMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O93VeC7q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558330; x=1760094330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ao31ZAkhPCvQj+GZVD0jFba/9Vv8oA4aGHXpV5jlYR8=;
  b=O93VeC7qfLDJC3457VQ+8eFk1IM0mUKz0qpH2f3nTYkYegg3b5+Zr6/A
   n8KU6UFZCfNoYXPB1jwcmGePHXWVUjXezQ6LlR8PQTQpbcFrqkNsIhro9
   T9hlzLtxYzEFkVsSW1TJ+fQAcV+lWYB/0sBIoMcTjvf2zRakgSGWO2tkc
   YU23hUYoLCNBUwCIt2vvw0nt2FZZKHDxUEgM0CUd0qZspmPT9Y4A/Czg0
   YJFehhkylnqOqARfGtG91Oofm89iupRpY1YocJ+doTPll2whgE8Z2gGIs
   owitTxTSocghALOurj7y2AbFZDTc1EE/T1lN9EDZolRdUy3VQiGE/pCk5
   Q==;
X-CSE-ConnectionGUID: A+f9i5cURxS2gpX/iZex7A==
X-CSE-MsgGUID: ZQsMTvqhQCq8AN9ycriAPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697744"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697744"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:30 -0700
X-CSE-ConnectionGUID: 1Cmt60KGT02awNxbbJJakA==
X-CSE-MsgGUID: 1L/lkDFLS62T5TtBPhlhRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362333"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 6/9] wifi: iwlwifi: mvm: SAR table alignment
Date: Thu, 10 Oct 2024 14:05:04 +0300
Message-Id: <20241010140328.f077aced4dee.I4dc618f12d01f7ad19f9f8881f6e09eea77e9a14@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

SAR table format in ACPI and local data base are different,
So modified code to read data properly.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 96 ++++++++++++--------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index a7cea0a55b35..0bc32291815e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -429,38 +429,28 @@ int iwl_acpi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 	return ret;
 }
 
-static int iwl_acpi_sar_set_profile(union acpi_object *table,
-				    struct iwl_sar_profile *profile,
-				    bool enabled, u8 num_chains,
-				    u8 num_sub_bands)
+static int
+iwl_acpi_parse_chains_table(union acpi_object *table,
+			    struct iwl_sar_profile_chain *chains,
+			    u8 num_chains, u8 num_sub_bands)
 {
-	int i, j, idx = 0;
-
-	/*
-	 * The table from ACPI is flat, but we store it in a
-	 * structured array.
-	 */
-	for (i = 0; i < BIOS_SAR_MAX_CHAINS_PER_PROFILE; i++) {
-		for (j = 0; j < BIOS_SAR_MAX_SUB_BANDS_NUM; j++) {
+	for (u8 chain = 0; chain < num_chains; chain++) {
+		for (u8 subband = 0; subband < BIOS_SAR_MAX_SUB_BANDS_NUM;
+		     subband++) {
 			/* if we don't have the values, use the default */
-			if (i >= num_chains || j >= num_sub_bands) {
-				profile->chains[i].subbands[j] = 0;
+			if (subband >= num_sub_bands) {
+				chains[chain].subbands[subband] = 0;
+			} else if (table->type != ACPI_TYPE_INTEGER ||
+				   table->integer.value > U8_MAX) {
+				return -EINVAL;
 			} else {
-				if (table[idx].type != ACPI_TYPE_INTEGER ||
-				    table[idx].integer.value > U8_MAX)
-					return -EINVAL;
-
-				profile->chains[i].subbands[j] =
-					table[idx].integer.value;
-
-				idx++;
+				chains[chain].subbands[subband] =
+					table->integer.value;
+				table++;
 			}
 		}
 	}
 
-	/* Only if all values were valid can the profile be enabled */
-	profile->enabled = enabled;
-
 	return 0;
 }
 
@@ -543,9 +533,11 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	/* The profile from WRDS is officially profile 1, but goes
 	 * into sar_profiles[0] (because we don't have a profile 0).
 	 */
-	ret = iwl_acpi_sar_set_profile(table, &fwrt->sar_profiles[0],
-				       flags & IWL_SAR_ENABLE_MSK,
-				       num_chains, num_sub_bands);
+	ret = iwl_acpi_parse_chains_table(table, fwrt->sar_profiles[0].chains,
+					  num_chains, num_sub_bands);
+	if (!ret && flags & IWL_SAR_ENABLE_MSK)
+		fwrt->sar_profiles[0].enabled = true;
+
 out_free:
 	kfree(data);
 	return ret;
@@ -557,7 +549,7 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	bool enabled;
 	int i, n_profiles, tbl_rev, pos;
 	int ret = 0;
-	u8 num_chains, num_sub_bands;
+	u8 num_sub_bands;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_EWRD_METHOD);
 	if (IS_ERR(data))
@@ -573,7 +565,6 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 			goto out_free;
 		}
 
-		num_chains = ACPI_SAR_NUM_CHAINS_REV2;
 		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV2;
 
 		goto read_table;
@@ -589,7 +580,6 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 			goto out_free;
 		}
 
-		num_chains = ACPI_SAR_NUM_CHAINS_REV1;
 		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV1;
 
 		goto read_table;
@@ -605,7 +595,6 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 			goto out_free;
 		}
 
-		num_chains = ACPI_SAR_NUM_CHAINS_REV0;
 		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV0;
 
 		goto read_table;
@@ -637,23 +626,54 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	/* the tables start at element 3 */
 	pos = 3;
 
+	BUILD_BUG_ON(ACPI_SAR_NUM_CHAINS_REV0 != ACPI_SAR_NUM_CHAINS_REV1);
+	BUILD_BUG_ON(ACPI_SAR_NUM_CHAINS_REV2 != 2 * ACPI_SAR_NUM_CHAINS_REV0);
+
+	/* parse non-cdb chains for all profiles */
 	for (i = 0; i < n_profiles; i++) {
 		union acpi_object *table = &wifi_pkg->package.elements[pos];
+
 		/* The EWRD profiles officially go from 2 to 4, but we
 		 * save them in sar_profiles[1-3] (because we don't
 		 * have profile 0).  So in the array we start from 1.
 		 */
-		ret = iwl_acpi_sar_set_profile(table,
-					       &fwrt->sar_profiles[i + 1],
-					       enabled, num_chains,
-					       num_sub_bands);
+		ret = iwl_acpi_parse_chains_table(table,
+						  fwrt->sar_profiles[i + 1].chains,
+						  ACPI_SAR_NUM_CHAINS_REV0,
+						  num_sub_bands);
 		if (ret < 0)
-			break;
+			goto out_free;
 
 		/* go to the next table */
-		pos += num_chains * num_sub_bands;
+		pos += ACPI_SAR_NUM_CHAINS_REV0 * num_sub_bands;
 	}
 
+	/* non-cdb table revisions */
+	if (tbl_rev < 2)
+		goto set_enabled;
+
+	/* parse cdb chains for all profiles */
+	for (i = 0; i < n_profiles; i++) {
+		struct iwl_sar_profile_chain *chains;
+		union acpi_object *table;
+
+		table = &wifi_pkg->package.elements[pos];
+		chains = &fwrt->sar_profiles[i + 1].chains[ACPI_SAR_NUM_CHAINS_REV0];
+		ret = iwl_acpi_parse_chains_table(table,
+						  chains,
+						  ACPI_SAR_NUM_CHAINS_REV0,
+						  num_sub_bands);
+		if (ret < 0)
+			goto out_free;
+
+		/* go to the next table */
+		pos += ACPI_SAR_NUM_CHAINS_REV0 * num_sub_bands;
+	}
+
+set_enabled:
+	for (i = 0; i < n_profiles; i++)
+		fwrt->sar_profiles[i + 1].enabled = enabled;
+
 out_free:
 	kfree(data);
 	return ret;
-- 
2.34.1


