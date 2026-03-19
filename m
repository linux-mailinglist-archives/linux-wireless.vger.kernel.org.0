Return-Path: <linux-wireless+bounces-33497-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCVfAjRFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33497-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F92D14B9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EACAC301B7AA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB86336EF1;
	Thu, 19 Mar 2026 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4a9wY66"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369213451B3
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946155; cv=none; b=V1VqNMYPxLFCXOST5u9yXcoOtnLvJ9RQFuvy5mldPcz4LY51AEOQ/48xBBeL6K6cwVakvbToVjasq3ZTHbpn0zjikGbbpMwNoBXUS0wKfW5ryer/oPdiyhZE9UFHehwUPyJt+2swKzYBNB0AOlha61VOWyWR1xcrbixW8w66D7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946155; c=relaxed/simple;
	bh=sV9f79W3pZgxciLXBGORvOb85JVh+LHOirRYLd5KmP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlnbXFUduHwzYlLqvfpnNpe8gxT/TzH1xxo6j+8vjr/oD9WR10lUr0iVEcFh8gzV1EGbv/wCzk52sGFG1WYPQSVp497ZxjiEOqbVLLq2opbtydXMdfClniv6UPQV9c9UiweWrKj6Ii/FSItdD8TP6DnjlStbInMw9IggHqe8Qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4a9wY66; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946154; x=1805482154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sV9f79W3pZgxciLXBGORvOb85JVh+LHOirRYLd5KmP0=;
  b=j4a9wY66TTegj0j4z8dUqDfyoF2UznqACyrQkC8HbDXs5cSX5Xl6yOkf
   M7WYIbab/ToE/Sf/o0F8YJxqC9/sD4JXepdslNRd8yFrVDfsFjGP9Bm6S
   vE6HFBoucqMeq721JbNtDNT4SWjGX0g+nJtNrLkhxPAH18acgRtZLQYiZ
   8etye7WLaplW5UVbh+OG9GvCM19FsOT1HB35/QLuVmOIENkb0rFJ/bj0J
   f/QFhUd7EqD3Odh/qm/ENdpPgT8ayZdkv6DRIxVzxW9979JLAMCiWthu3
   bGRXV+O5iihaJewnn4x/U7Cfnu01LOlzdXetUtzahXhZhCaPVIq9X6FL4
   Q==;
X-CSE-ConnectionGUID: uTQLRNWdSoyeWtGOcVOttw==
X-CSE-MsgGUID: hRI1T7TBQJem07DDyWbUbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656479"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656479"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:13 -0700
X-CSE-ConnectionGUID: ld6CTj1MSVe35M7dVCRmGQ==
X-CSE-MsgGUID: VCgI+if9SIKPGGJr4pjVNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998512"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: uefi: support the new WRDS and EWRD tables
Date: Thu, 19 Mar 2026 20:48:44 +0200
Message-Id: <20260319204647.6948f69e6ae4.Icf990e13de6905c35a8de69f1445f8eb4aa43ee4@changeid>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33497-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 973F92D14B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Those tables now have support for UNII-9 subband.
Refactor iwl_uefi_set_sar_profile to get an array of values that makes
it easier to use when the number of subbands can vary.
Revamp a bit the code that fetches the tables to ask for the smaller
table, then we can check the size of the object that we got and compare
to the expected sizes to determine what revision to expect.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 92 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 62 ++++++++-----
 3 files changed, 116 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 446c8a2c4f9d..a3684514c904 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -21,7 +21,7 @@
  */
 #define BIOS_SAR_MAX_CHAINS_PER_PROFILE 4
 #define BIOS_SAR_NUM_CHAINS             2
-#define BIOS_SAR_MAX_SUB_BANDS_NUM      11
+#define BIOS_SAR_MAX_SUB_BANDS_NUM      12
 #define BIOS_PPAG_MAX_SUB_BANDS_NUM     12
 
 #define BIOS_GEO_NUM_CHAINS		2
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 84b6f8b7eda9..3d3d698bacd0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -460,11 +460,30 @@ void iwl_uefi_get_uneb_table(struct iwl_trans *trans,
 IWL_EXPORT_SYMBOL(iwl_uefi_get_uneb_table);
 
 static void iwl_uefi_set_sar_profile(struct iwl_fw_runtime *fwrt,
-				     struct uefi_sar_profile *uefi_sar_prof,
-				     u8 prof_index, bool enabled)
+				     const u8 *vals, u8 prof_index,
+				     u8 num_subbands, bool enabled)
 {
-	memcpy(&fwrt->sar_profiles[prof_index].chains, uefi_sar_prof,
-	       sizeof(struct uefi_sar_profile));
+	struct iwl_sar_profile *sar_prof = &fwrt->sar_profiles[prof_index];
+
+	/*
+	 * Make sure fwrt has enough room to hold the data
+	 * coming from the UEFI table
+	 */
+	if (WARN_ON(ARRAY_SIZE(sar_prof->chains) *
+		    ARRAY_SIZE(sar_prof->chains[0].subbands)  <
+		    UEFI_SAR_MAX_CHAINS_PER_PROFILE * num_subbands))
+		return;
+
+	BUILD_BUG_ON(ARRAY_SIZE(sar_prof->chains) !=
+		     UEFI_SAR_MAX_CHAINS_PER_PROFILE);
+
+	for (int chain = 0;
+	     chain < UEFI_SAR_MAX_CHAINS_PER_PROFILE;
+	     chain++) {
+		for (int subband = 0; subband < num_subbands; subband++)
+			sar_prof->chains[chain].subbands[subband] =
+				vals[chain * num_subbands + subband];
+	}
 
 	fwrt->sar_profiles[prof_index].enabled = enabled & IWL_SAR_ENABLE_MSK;
 }
@@ -472,24 +491,46 @@ static void iwl_uefi_set_sar_profile(struct iwl_fw_runtime *fwrt,
 int iwl_uefi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_wrds *data;
+	unsigned long size;
+	unsigned long expected_size;
+	int num_subbands;
 	int ret = 0;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WRDS_NAME,
-					      "WRDS", sizeof(*data), NULL);
+					      "WRDS",
+					      UEFI_SAR_WRDS_TABLE_SIZE_REV2,
+					      &size);
+
 	if (IS_ERR(data))
 		return -EINVAL;
 
-	if (data->revision != IWL_UEFI_WRDS_REVISION) {
-		ret = -EINVAL;
-		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WRDS revision:%d\n",
+	switch (data->revision) {
+	case 2:
+		expected_size = UEFI_SAR_WRDS_TABLE_SIZE_REV2;
+		num_subbands = UEFI_SAR_SUB_BANDS_NUM_REV2;
+		break;
+	case 3:
+		expected_size = UEFI_SAR_WRDS_TABLE_SIZE_REV3;
+		num_subbands = UEFI_SAR_SUB_BANDS_NUM_REV3;
+		break;
+	default:
+		IWL_DEBUG_RADIO(fwrt,
+				"Unsupported UEFI WRDS revision:%d\n",
 				data->revision);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (size != expected_size) {
+		ret = -EINVAL;
 		goto out;
 	}
 
 	/* The profile from WRDS is officially profile 1, but goes
 	 * into sar_profiles[0] (because we don't have a profile 0).
 	 */
-	iwl_uefi_set_sar_profile(fwrt, &data->sar_profile, 0, data->mode);
+	iwl_uefi_set_sar_profile(fwrt, data->vals, 0,
+				 num_subbands, data->mode);
 out:
 	kfree(data);
 	return ret;
@@ -498,21 +539,40 @@ int iwl_uefi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_ewrd *data;
+	unsigned long expected_size;
 	int i, ret = 0;
+	unsigned long size;
+	int num_subbands;
+	int profile_size;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_EWRD_NAME,
-					      "EWRD", sizeof(*data), NULL);
+					      "EWRD",
+					      UEFI_SAR_EWRD_TABLE_SIZE_REV2,
+					      &size);
 	if (IS_ERR(data))
 		return -EINVAL;
 
-	if (data->revision != IWL_UEFI_EWRD_REVISION) {
-		ret = -EINVAL;
-		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI EWRD revision:%d\n",
+	switch (data->revision) {
+	case 2:
+		expected_size = UEFI_SAR_EWRD_TABLE_SIZE_REV2;
+		num_subbands = UEFI_SAR_SUB_BANDS_NUM_REV2;
+		profile_size = UEFI_SAR_PROFILE_SIZE_REV2;
+		break;
+	case 3:
+		expected_size = UEFI_SAR_EWRD_TABLE_SIZE_REV3;
+		num_subbands = UEFI_SAR_SUB_BANDS_NUM_REV3;
+		profile_size = UEFI_SAR_PROFILE_SIZE_REV3;
+		break;
+	default:
+		IWL_DEBUG_RADIO(fwrt,
+				"Unsupported UEFI EWRD revision:%d\n",
 				data->revision);
+		ret = -EINVAL;
 		goto out;
 	}
 
-	if (data->num_profiles >= BIOS_SAR_MAX_PROFILE_NUM) {
+	if (size != expected_size ||
+	    data->num_profiles >= BIOS_SAR_MAX_PROFILE_NUM) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -522,8 +582,8 @@ int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 		 * save them in sar_profiles[1-3] (because we don't
 		 * have profile 0).  So in the array we start from 1.
 		 */
-		iwl_uefi_set_sar_profile(fwrt, &data->sar_profiles[i], i + 1,
-					 data->mode);
+		iwl_uefi_set_sar_profile(fwrt, &data->vals[i * profile_size],
+					 i + 1, num_subbands, data->mode);
 
 out:
 	kfree(data);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 5046b6a45419..aa5a4c5a7392 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -31,8 +31,6 @@
 #define IWL_SGOM_MAP_SIZE		339
 #define IWL_UATS_MAP_SIZE		339
 
-#define IWL_UEFI_WRDS_REVISION		2
-#define IWL_UEFI_EWRD_REVISION		2
 #define IWL_UEFI_WGDS_REVISION		3
 #define IWL_UEFI_MIN_WTAS_REVISION	1
 #define IWL_UEFI_MAX_WTAS_REVISION	2
@@ -74,56 +72,74 @@ struct uefi_cnv_common_step_data {
 	u8 radio2;
 } __packed;
 
-#define UEFI_SAR_MAX_SUB_BANDS_NUM	11
 #define UEFI_PPAG_SUB_BANDS_NUM_REV4	11
 #define UEFI_PPAG_SUB_BANDS_NUM_REV5	12
 #define UEFI_PPAG_NUM_CHAINS		2
-#define UEFI_SAR_MAX_CHAINS_PER_PROFILE	4
 
-/*
- * struct uefi_sar_profile_chain - per-chain values of a SAR profile
- * @subbands: the SAR value for each subband
- */
-struct uefi_sar_profile_chain {
-	u8 subbands[UEFI_SAR_MAX_SUB_BANDS_NUM];
-};
+#define UEFI_SAR_SUB_BANDS_NUM_REV2	11
+#define UEFI_SAR_SUB_BANDS_NUM_REV3	12
 
-/*
- * struct uefi_sar_profile - a SAR profile as defined in UEFI
- *
- * @chains: a per-chain table of SAR values
- */
-struct uefi_sar_profile {
-	struct uefi_sar_profile_chain chains[UEFI_SAR_MAX_CHAINS_PER_PROFILE];
-} __packed;
+#define UEFI_SAR_MAX_CHAINS_PER_PROFILE	4
 
 /*
  * struct uefi_cnv_var_wrds - WRDS table as defined in UEFI
  *
  * @revision: the revision of the table
  * @mode: is WRDS enbaled/disabled
- * @sar_profile: sar profile #1
+ * @vals: values for sar profile #1 as an array:
+ *	vals[chain * num_of_subbands + subband] will return the right value.
+ *	num_of_subbands depends on the revision. For revision 3, it is
+ *	%UEFI_SAR_SUB_BANDS_NUM_REV3, for earlier revision, it is
+ *	%UEFI_SAR_SUB_BANDS_NUM_REV2.
+ *	The max number of chains is currently 2
  */
 struct uefi_cnv_var_wrds {
 	u8 revision;
 	u32 mode;
-	struct uefi_sar_profile sar_profile;
+	u8 vals[];
 } __packed;
 
+#define UEFI_SAR_PROFILE_SIZE_REV2			\
+	(sizeof(u8) * UEFI_SAR_MAX_CHAINS_PER_PROFILE *	\
+	 UEFI_SAR_SUB_BANDS_NUM_REV2)
+
+#define UEFI_SAR_PROFILE_SIZE_REV3			\
+	(sizeof(u8) * UEFI_SAR_MAX_CHAINS_PER_PROFILE *	\
+	 UEFI_SAR_SUB_BANDS_NUM_REV3)
+
+#define UEFI_SAR_WRDS_TABLE_SIZE_REV2			\
+	(offsetof(struct uefi_cnv_var_wrds, vals) +	\
+	 UEFI_SAR_PROFILE_SIZE_REV2)
+
+#define UEFI_SAR_WRDS_TABLE_SIZE_REV3			\
+	(offsetof(struct uefi_cnv_var_wrds, vals) +	\
+	 UEFI_SAR_PROFILE_SIZE_REV3)
+
 /*
  * struct uefi_cnv_var_ewrd - EWRD table as defined in UEFI
  * @revision: the revision of the table
  * @mode: is WRDS enbaled/disabled
  * @num_profiles: how many additional profiles we have in this table (0-3)
- * @sar_profiles: the additional SAR profiles (#2-#4)
+ * @vals: the additional SAR profiles (#2-#4) as an array of SAR profiles.
+ *	A SAR profile is defined the &struct uefi_cnv_var_wrds::vals. The size
+ *	of each profile depends on the number of subbands which depends on the
+ *	revision. This is explained in &struct uefi_cnv_var_wrds.
  */
 struct uefi_cnv_var_ewrd {
 	u8 revision;
 	u32 mode;
 	u32 num_profiles;
-	struct uefi_sar_profile sar_profiles[BIOS_SAR_MAX_PROFILE_NUM - 1];
+	u8 vals[];
 } __packed;
 
+#define UEFI_SAR_EWRD_TABLE_SIZE_REV2				\
+	(offsetof(struct uefi_cnv_var_ewrd, vals) +		\
+	 UEFI_SAR_PROFILE_SIZE_REV2 * (BIOS_SAR_MAX_PROFILE_NUM - 1))
+
+#define UEFI_SAR_EWRD_TABLE_SIZE_REV3				\
+	(offsetof(struct uefi_cnv_var_ewrd, vals) +		\
+	 UEFI_SAR_PROFILE_SIZE_REV3 * (BIOS_SAR_MAX_PROFILE_NUM - 1))
+
 /*
  * struct uefi_cnv_var_wgds - WGDS table as defined in UEFI
  * @revision: the revision of the table
-- 
2.34.1


