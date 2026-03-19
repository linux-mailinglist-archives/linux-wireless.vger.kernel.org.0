Return-Path: <linux-wireless+bounces-33471-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AADPHJ/Au2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33471-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:23:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC72C88B1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74B3630DEB44
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F83B3C14;
	Thu, 19 Mar 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNO2DwnP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088F3BA252
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911394; cv=none; b=Q9egcj7hEE6r6yorTZAqrDkxYeNOOqFJ8uVJxRDXL816/oUhKjvx0MAGuE3hmXNBtxXVgJmMfK2rLEG6tl03M+UlOHJKDqaI53EfZStYVmZTLnRHBWiJ5YOccdlRpZoWCMiFnEdnCNpkm+NcgWNSIoQjs8sxkFwrf+XtGrGH9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911394; c=relaxed/simple;
	bh=2Hm0v4mg9kbPayj1gBHKaxMAysswBEFgXGoN+NOIHsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/YJtFyA21mTCOXDOrQCVIR3hID+loVe+GxHZN26i/C0ix9R7SuU1BefnDFyMa76IO8CqCJdZIHLxuBfoKRYfyAvT/YYXEhYb0xy5YMFdArmS3L6M/oxkfAAQz5oOZTK0JvI6NaFzWIn1Vc6l7iYMojTKEthBleGCnLf5jbsRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNO2DwnP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911391; x=1805447391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Hm0v4mg9kbPayj1gBHKaxMAysswBEFgXGoN+NOIHsg=;
  b=CNO2DwnPQxqqAL9MaxXrvPn7Vt03zyF3KUBjv236SnXGfGScVS/fQvGh
   Mc8XJLWgl7BfDfInsu+/SPfz6ONUlZiUBwopQzj55l2sf8iVEthOOyUj5
   dqATKOZMyNPk1Q6BcLzK9hirpu/uejCzhfkV4iXceGEIYcBlNbmHLCit0
   w8cCkJ0t7IPgF31iv7Qf4F+SPWMA4y418dCex73NlCGfx3kq9auU/trRh
   aIiwpH9yBJSncI/bz5Qk2WHaSBTnqOSUvdwsd1d6UEeRhKeAqFAAkwVb2
   T+XSN/X0fK2jZ8uAnjTXv4thC0NfYFecIrRpsksPSjDXwzIUCLacE6d/A
   Q==;
X-CSE-ConnectionGUID: CwDb+DVYSB6Lw4XzNnxx0Q==
X-CSE-MsgGUID: Ry1dTC2iRWCn35Q9yqTvJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992724"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992724"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:51 -0700
X-CSE-ConnectionGUID: l5yXu1iaTuG7vZc+W/ytiA==
X-CSE-MsgGUID: ZyCOFzmXTXyB1z50PDJqnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387147"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 09/15] wifi: iwlwifi: uefi: open code the PPAG table store operation
Date: Thu, 19 Mar 2026 11:09:21 +0200
Message-Id: <20260319110722.61e729ea2bde.I9d9cda29f576290bf966f780bf7ad5af34970e6f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33471-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77EC72C88B1
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


