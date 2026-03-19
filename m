Return-Path: <linux-wireless+bounces-33496-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDpiGjFFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33496-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D076F2D14B2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BF6301E7F3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48F3446A6;
	Thu, 19 Mar 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knTrwEz+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567115CD74
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946154; cv=none; b=gi8ELd1FFLVMxldO7G0J6mZahKYkIHDtp220xVB6rU7m6mgs8eN+rQoSaVvKPCP9tCQ1Yz2W1R9zr1xjZj7phIx092sXh34NasDtfzYPdYOgQtlSGU359aJN9DY8qonzd2yRCQi4v4hEU8KwuW6TQ6tosMsucvSTfpgQEXIOU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946154; c=relaxed/simple;
	bh=e6WVAxMn5B0qZIf1NDlu7N0y9FT5sJqiVteFNYDQgjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EI17tR+PbDUVoeEsU5fUOufN9icPhmoaor16Pw3gkNg4PY24RGILGtC+Jo9/TYBTtt8KE/Joww4mI9khKLeLjI3DjC6xMoU+f++lJHR6WR3DS0DBZ1dxv2O1TiJHsjLXS5Ml6S4J3dJ+awkG04KtWHCs1BxAzVB3E6Xco8+n/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knTrwEz+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946152; x=1805482152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6WVAxMn5B0qZIf1NDlu7N0y9FT5sJqiVteFNYDQgjs=;
  b=knTrwEz+NqqPoC65RM3U0DnxbjxXeB6SnHiU3fqVjK5hXNuKvkSTCGkI
   uHdUMb5YQ7YRIgejuOP2PJ0ZllQ3aqNB+b9WsKa3F7+cCVcmCLKBU2iVF
   qGpnW9RWv6/6NCAdJZHls+GoQ9IXZkIXon0rAwd+xlhZ+R/UHIe2XNayl
   hYXltQSxE0tyVwOrMQrQqzkWK/5GqsYP4iPVkRnwmU0GUuV3ACAJadhVO
   oxYsnNsGQsn8fEyiEsI4CMZOgFvu0MtzU3veiByNyQIjiBEdHZ1lUnSpX
   A2vlBRUx/lxpfju/Smvm12RGJLg8woZxiRXQUp+RBEcvb6T+ZAu7ILfYF
   A==;
X-CSE-ConnectionGUID: yi1Q0Or5Qfim9IhmKZQq2g==
X-CSE-MsgGUID: ny44K8oCT0+pajKVTpp3Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656466"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656466"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:08 -0700
X-CSE-ConnectionGUID: Vnks7pKhS+SB4vmblMpCdQ==
X-CSE-MsgGUID: ol+/Esb7QQGVjeZivqwffA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998483"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: uefi: add support for PPAG table rev5
Date: Thu, 19 Mar 2026 20:48:41 +0200
Message-Id: <20260319204647.b9ebcff37599.I1e8bb9cee5a028ed416b6094c0fdbf9f859c6dd8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
References: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33496-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D076F2D14B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This table has another subband for UNII-9.
Add defines for the sizes of rev4 and rev5 to easily know how much data
to ask from iwl_uefi_get_verified_variable.
In case rev5 doesn't exist, fallback to rev4.
Check that the revision advertised by the fetched table matches the size
that we got.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 66 +++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 17 +++--
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index fba41976be6b..84b6f8b7eda9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -570,44 +570,66 @@ int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_ppag *data;
+	int n_subbands;
+	u32 valid_rev;
 	int ret = 0;
-	int data_sz = sizeof(*data) + sizeof(data->vals[0]) *
-		IWL_NUM_CHAIN_LIMITS * UEFI_PPAG_SUB_BANDS_NUM;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_PPAG_NAME,
-					      "PPAG", data_sz, NULL);
-	if (IS_ERR(data))
-		return -EINVAL;
+					      "PPAG", UEFI_PPAG_DATA_SIZE_V5,
+					      NULL);
+	if (!IS_ERR(data)) {
+		n_subbands = UEFI_PPAG_SUB_BANDS_NUM_REV5;
+		valid_rev = BIT(5);
+
+		goto parse_table;
+	}
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans,
+					      IWL_UEFI_PPAG_NAME,
+					      "PPAG",
+					      UEFI_PPAG_DATA_SIZE_V4,
+					      NULL);
+	if (!IS_ERR(data)) {
+		n_subbands = UEFI_PPAG_SUB_BANDS_NUM_REV4;
+		/* revisions 1-4 have all the same size */
+		valid_rev = BIT(1) | BIT(2) | BIT(3) | BIT(4);
 
-	if (data->revision < IWL_UEFI_MIN_PPAG_REV ||
-	    data->revision > IWL_UEFI_MAX_PPAG_REV) {
+		goto parse_table;
+	}
+
+	return -EINVAL;
+
+parse_table:
+	if (!(BIT(data->revision) & valid_rev)) {
 		ret = -EINVAL;
-		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI PPAG revision:%d\n",
+		IWL_DEBUG_RADIO(fwrt,
+				"Unsupported UEFI PPAG revision:%d\n",
 				data->revision);
 		goto out;
 	}
 
-	fwrt->ppag_bios_rev = data->revision;
-	fwrt->ppag_flags = iwl_bios_get_ppag_flags(data->ppag_modes,
-						   fwrt->ppag_bios_rev);
-
 	/*
 	 * Make sure fwrt has enough room to hold
 	 * data coming from the UEFI table
 	 */
-	BUILD_BUG_ON(ARRAY_SIZE(fwrt->ppag_chains) *
-		     ARRAY_SIZE(fwrt->ppag_chains[0].subbands) <
-		     IWL_NUM_CHAIN_LIMITS * UEFI_PPAG_SUB_BANDS_NUM);
-
-	for (int chain = 0; chain < IWL_NUM_CHAIN_LIMITS; chain++) {
-		for (int subband = 0;
-		     subband < UEFI_PPAG_SUB_BANDS_NUM;
-		     subband++)
+	if (WARN_ON(ARRAY_SIZE(fwrt->ppag_chains) *
+		    ARRAY_SIZE(fwrt->ppag_chains[0].subbands)  <
+		    UEFI_PPAG_NUM_CHAINS * n_subbands)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fwrt->ppag_bios_rev = data->revision;
+	fwrt->ppag_flags = iwl_bios_get_ppag_flags(data->ppag_modes,
+						   fwrt->ppag_bios_rev);
+
+	for (int chain = 0; chain < UEFI_PPAG_NUM_CHAINS; chain++) {
+		for (int subband = 0; subband < n_subbands; subband++)
 			fwrt->ppag_chains[chain].subbands[subband] =
-				data->vals[chain * UEFI_PPAG_SUB_BANDS_NUM + subband];
+				data->vals[chain * n_subbands + subband];
 	}
 
-	iwl_bios_print_ppag(fwrt, UEFI_PPAG_SUB_BANDS_NUM);
+	iwl_bios_print_ppag(fwrt, n_subbands);
 	fwrt->ppag_bios_source = BIOS_SOURCE_UEFI;
 out:
 	kfree(data);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 4f0ce068a589..5046b6a45419 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -34,8 +34,6 @@
 #define IWL_UEFI_WRDS_REVISION		2
 #define IWL_UEFI_EWRD_REVISION		2
 #define IWL_UEFI_WGDS_REVISION		3
-#define IWL_UEFI_MIN_PPAG_REV		1
-#define IWL_UEFI_MAX_PPAG_REV		4
 #define IWL_UEFI_MIN_WTAS_REVISION	1
 #define IWL_UEFI_MAX_WTAS_REVISION	2
 #define IWL_UEFI_SPLC_REVISION		0
@@ -77,7 +75,9 @@ struct uefi_cnv_common_step_data {
 } __packed;
 
 #define UEFI_SAR_MAX_SUB_BANDS_NUM	11
-#define UEFI_PPAG_SUB_BANDS_NUM		11
+#define UEFI_PPAG_SUB_BANDS_NUM_REV4	11
+#define UEFI_PPAG_SUB_BANDS_NUM_REV5	12
+#define UEFI_PPAG_NUM_CHAINS		2
 #define UEFI_SAR_MAX_CHAINS_PER_PROFILE	4
 
 /*
@@ -143,7 +143,9 @@ struct uefi_cnv_var_wgds {
  * @ppag_modes: values from &enum iwl_ppag_flags
  * @vals: the PPAG values per chain and band as an array.
  *	vals[chain * num_of_subbands + subband] will return the right value.
- *	num_of_subbands is %UEFI_PPAG_SUB_BANDS_NUM.
+ *	num_of_subbands depends on the revision. For revision 5, it is
+ *	%UEFI_PPAG_SUB_BANDS_NUM_REV5, for earlier revision it is
+ *	%UEFI_PPAG_SUB_BANDS_NUM_REV4.
  *	the max number of chains is currently 2
  */
 struct uefi_cnv_var_ppag {
@@ -152,6 +154,13 @@ struct uefi_cnv_var_ppag {
 	s8 vals[];
 } __packed;
 
+#define UEFI_PPAG_DATA_SIZE_V4				\
+	(offsetof(struct uefi_cnv_var_ppag, vals) +	\
+	sizeof(s8) * UEFI_PPAG_NUM_CHAINS * UEFI_PPAG_SUB_BANDS_NUM_REV4)
+#define UEFI_PPAG_DATA_SIZE_V5				\
+	(offsetof(struct uefi_cnv_var_ppag, vals) +	\
+	sizeof(s8) * UEFI_PPAG_NUM_CHAINS * UEFI_PPAG_SUB_BANDS_NUM_REV5)
+
 /* struct uefi_cnv_var_wtas - WTAS tabled as defined in UEFI
  * @revision: the revision of the table
  * @tas_selection: different options of TAS enablement.
-- 
2.34.1


