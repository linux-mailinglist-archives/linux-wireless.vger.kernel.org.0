Return-Path: <linux-wireless+bounces-33433-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A8rEnURu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33433-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE22C2BF9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0261831A27AF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4B2DB781;
	Wed, 18 Mar 2026 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHFz1RHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782B371051
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867296; cv=none; b=QYzQZgr4z2Az+IGjgydaD2P3GVYADS8GyS1ZtzkqyOclhVcONO/aN6AOqqxsb0eXeEwuZ1sdonAOsIEcmXu3jtKxvznbHnjMHDjdi2GUbibzNK/EsE+Vcpo1/t8btN6Hxi8ib9Uw4vZhleRlQbOTrK2esfq4bC0PO90QZx8Fbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867296; c=relaxed/simple;
	bh=2Hm0v4mg9kbPayj1gBHKaxMAysswBEFgXGoN+NOIHsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOpEXHmtMtVTRGA7bGtkVOJD706s1THcRIwLIIpOUZX/lD8bEBPg1J7YAC/Hzr8lY3ebs0GokIUQjyo+WPtavXDJ42OpX6OPgOyX5STz9niWgZ7ekUJH/4HFEG4QbnAEqGanx2KQqNyXUYp0uHsv2odO5ZGioWmWk6PvAU4f+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHFz1RHO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867295; x=1805403295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Hm0v4mg9kbPayj1gBHKaxMAysswBEFgXGoN+NOIHsg=;
  b=RHFz1RHO0k815vyTHAk5XQIzQUCjR7MPJf0Yk8huEOGZcWlRwCl4P6GP
   T5NaUhfsRUA0moCuACG+YduEP4RjmkYdI1z4IJsvtbkTJ+9pkMQRyguX9
   5OmbzY3ab9arx92QMGzFU1Q4tLsMDVIMQ0Xvq4CeGoYE31wVtJ3R+0re2
   m0RdCgXLr94pIgQXrkN6o+HspXynTB4dDb3YJYfuCerRiLYrDNp7FpZnA
   NQmEwyIsTEu8QnAHT74QdSXeAlE/6oYmow/t88yCiTKdmFoji0d9LNNmk
   XHVCcH1uT/OxE9P88yeMFPSiGuy4KSEiz0Skh2Ifsjj0bISvfBemzBua0
   w==;
X-CSE-ConnectionGUID: dgm1pE/uQqmVO15CIzzPaA==
X-CSE-MsgGUID: WaPfRJluTQu38iPrwPLarw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010026"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010026"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:55 -0700
X-CSE-ConnectionGUID: D54W2JG7TIClcSwE2dpqYQ==
X-CSE-MsgGUID: CRQwMwbJSE2Fhj6Q1fzV6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793902"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: uefi: open code the PPAG table store operation
Date: Wed, 18 Mar 2026 22:54:24 +0200
Message-Id: <20260318225236.61e729ea2bde.I9d9cda29f576290bf966f780bf7ad5af34970e6f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
References: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33433-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCBE22C2BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The structure in firmware runtime will need to grow because we're adding
a subband for UNII-9.
This means that we will soon no longer be able to just memcpy the data
from the UEFI table. The layout of the array will change.
Tediously copy the data byte-byte to make sure things get to the right
place even when we'll increase the number of subbands.
Make it easier for the uefi_cnv_var_ppag structure to grow by
simpiflying the layout it becomes an array of s8.
The layout of the structure becomes less obvious from the structure's
declaration, but then the code is more flexible.

Don't use UEFI_SAR_MAX_SUB_BANDS_NUM for the number of bands for PPAG.
Of course, SAR related structures will grow in future patches, but
decouple SAR and PPAG to make the work easier.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 23 ++++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 16 +++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index d4e1ab1f7c84..38f9d9adf90e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -571,9 +571,11 @@ int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_ppag *data;
 	int ret = 0;
+	int data_sz = sizeof(*data) + sizeof(data->vals[0]) *
+		IWL_NUM_CHAIN_LIMITS * UEFI_PPAG_SUB_BANDS_NUM;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_PPAG_NAME,
-					      "PPAG", sizeof(*data), NULL);
+					      "PPAG", data_sz, NULL);
 	if (IS_ERR(data))
 		return -EINVAL;
 
@@ -589,9 +591,22 @@ int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	fwrt->ppag_flags = iwl_bios_get_ppag_flags(data->ppag_modes,
 						   fwrt->ppag_bios_rev);
 
-	BUILD_BUG_ON(sizeof(fwrt->ppag_chains) != sizeof(data->ppag_chains));
-	memcpy(&fwrt->ppag_chains, &data->ppag_chains,
-	       sizeof(data->ppag_chains));
+	/*
+	 * Make sure fwrt has enough room to hold
+	 * data coming from the UEFI table
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(fwrt->ppag_chains) *
+		     ARRAY_SIZE(fwrt->ppag_chains[0].subbands) <
+		     IWL_NUM_CHAIN_LIMITS * UEFI_PPAG_SUB_BANDS_NUM);
+
+	for (int chain = 0; chain < IWL_NUM_CHAIN_LIMITS; chain++) {
+		for (int subband = 0;
+		     subband < UEFI_PPAG_SUB_BANDS_NUM;
+		     subband++)
+			fwrt->ppag_chains[chain].subbands[subband] =
+				data->vals[chain * UEFI_PPAG_SUB_BANDS_NUM + subband];
+	}
+
 	fwrt->ppag_bios_source = BIOS_SOURCE_UEFI;
 out:
 	kfree(data);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index c6940a3c03ea..4f0ce068a589 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -77,6 +77,7 @@ struct uefi_cnv_common_step_data {
 } __packed;
 
 #define UEFI_SAR_MAX_SUB_BANDS_NUM	11
+#define UEFI_PPAG_SUB_BANDS_NUM		11
 #define UEFI_SAR_MAX_CHAINS_PER_PROFILE	4
 
 /*
@@ -136,24 +137,19 @@ struct uefi_cnv_var_wgds {
 	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
 } __packed;
 
-/*
- * struct uefi_ppag_chain - PPAG table for a specific chain
- * @subbands: the PPAG values for band
- */
-struct uefi_ppag_chain {
-	s8 subbands[UEFI_SAR_MAX_SUB_BANDS_NUM];
-};
-
 /*
  * struct uefi_cnv_var_ppag - PPAG table as defined in UEFI
  * @revision: the revision of the table
  * @ppag_modes: values from &enum iwl_ppag_flags
- * @ppag_chains: the PPAG values per chain and band
+ * @vals: the PPAG values per chain and band as an array.
+ *	vals[chain * num_of_subbands + subband] will return the right value.
+ *	num_of_subbands is %UEFI_PPAG_SUB_BANDS_NUM.
+ *	the max number of chains is currently 2
  */
 struct uefi_cnv_var_ppag {
 	u8 revision;
 	u32 ppag_modes;
-	struct uefi_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
+	s8 vals[];
 } __packed;
 
 /* struct uefi_cnv_var_wtas - WTAS tabled as defined in UEFI
-- 
2.34.1


