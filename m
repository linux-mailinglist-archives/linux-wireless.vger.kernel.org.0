Return-Path: <linux-wireless+bounces-33503-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LYsGkFFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33503-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A42D14D6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B7E730162B5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F6351C13;
	Thu, 19 Mar 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFn3DDhC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E903446C7
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946162; cv=none; b=Mmu0kIIpAyPmG5AeVqUBmj5SES2paXINhV5WKLrcYn+582pa0WhTUcbvsZHlVefA7o7p9NScHwcAfoFj/eR0+f6gflA+mUOW68W5MD/aOH70qbo4J3+zvDStTD6oKtWKxm5zsXycCScqS8HtnIOwkpJZaH202N3IIjt8rq+lvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946162; c=relaxed/simple;
	bh=ktrQeEcUMfb+lDWs21mG+rOAJvpyEvxxIPRLQgvEWUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QL+h09uoutHmL6ceth0UiiQrfnq89+J62XkBIr3Zjg0/ZygCcS7zxZN+AebuBELOgYENyPO31czDY/VsK/qJoiUnnjTnibbsqERmU3Ipq65IuNih9/i/y6RXJMbuPamuHo/2WOgvr2AHhIsHclx9aay1m1vaTB302UpSvCoT6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFn3DDhC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946161; x=1805482161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ktrQeEcUMfb+lDWs21mG+rOAJvpyEvxxIPRLQgvEWUs=;
  b=YFn3DDhC8mszwuGWw0rfHQn0EalcKAZUGm9+ytXuLGEbIUNlfisJNxf/
   HXwwn6wSgWE/MVoiudXZ4s9mHC9Z9t+H4n/J1HAbJ9YLNbzXbwE6AzBz9
   s7KkfX5ljiBNadQm9vtOvwq6gbW7AEhS2GSRBuR68wRWLms4GZtOhAm/I
   WHpftPEvjORM0gvKczURTkc9MX+vq8B5j/umPgcW9UvdZ2VejVUvduBWT
   dMaLMuGVB3JYR3Y3DHQ7CcBvLSHex32kWrSwnutWdWdOsTLOMX8tnFuvS
   lo2XRUooX6ytKCXWXTBN59X+oEZqFOrCN1r3RdhyGbk9T3/W8/y+2VhLU
   w==;
X-CSE-ConnectionGUID: EEPL70NNQ2Gchzx3jKErQA==
X-CSE-MsgGUID: n398LheqQuughAzVCG+lDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656487"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656487"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:21 -0700
X-CSE-ConnectionGUID: riO7pXp2Tfa/11sIsNQhVA==
X-CSE-MsgGUID: 9LLmeNj7Qsii5n5qjG4wfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998541"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: uefi: add support for WGDS rev4
Date: Thu, 19 Mar 2026 20:48:49 +0200
Message-Id: <20260319204647.ad8e49c3a9e1.I51170ba78a706f976e93918d6473185d41e4306d@changeid>
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
	TAGGED_FROM(0.00)[bounces-33503-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D1A42D14D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This new revision includes support for UNII-9. It adds a subband.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 32 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 11 +++++--
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index a3684514c904..6fffc032efd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -25,7 +25,7 @@
 #define BIOS_PPAG_MAX_SUB_BANDS_NUM     12
 
 #define BIOS_GEO_NUM_CHAINS		2
-#define BIOS_GEO_MAX_NUM_BANDS		3
+#define BIOS_GEO_MAX_NUM_BANDS		4
 #define BIOS_GEO_MAX_PROFILE_NUM	8
 #define BIOS_GEO_MIN_PROFILE_NUM	3
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index ccac50385175..f73340c7d537 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -593,21 +593,39 @@ int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_wgds *data;
+	unsigned long expected_size;
+	unsigned long size;
+	int profile_size;
+	int n_subbands;
 	int ret = 0;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WGDS_NAME,
 					      "WGDS", UEFI_WGDS_TABLE_SIZE_REV3,
-					      NULL);
+					      &size);
 	if (IS_ERR(data))
 		return -EINVAL;
 
-	if (data->revision != IWL_UEFI_WGDS_REVISION) {
+	switch (data->revision) {
+	case 3:
+		expected_size = UEFI_WGDS_TABLE_SIZE_REV3;
+		n_subbands = UEFI_GEO_NUM_BANDS_REV3;
+		break;
+	case 4:
+		expected_size = UEFI_WGDS_TABLE_SIZE_REV4;
+		n_subbands = UEFI_GEO_NUM_BANDS_REV4;
+		break;
+	default:
 		ret = -EINVAL;
 		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WGDS revision:%d\n",
 				data->revision);
 		goto out;
 	}
 
+	if (size != expected_size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (data->num_profiles < BIOS_GEO_MIN_PROFILE_NUM ||
 	    data->num_profiles > BIOS_GEO_MAX_PROFILE_NUM) {
 		ret = -EINVAL;
@@ -618,8 +636,7 @@ int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 
 	if (WARN_ON(BIOS_GEO_MAX_PROFILE_NUM >
 		    ARRAY_SIZE(fwrt->geo_profiles) ||
-		    UEFI_GEO_NUM_BANDS_REV3 >
-		    ARRAY_SIZE(fwrt->geo_profiles[0].bands) ||
+		    n_subbands > ARRAY_SIZE(fwrt->geo_profiles[0].bands) ||
 		    BIOS_GEO_NUM_CHAINS >
 		    ARRAY_SIZE(fwrt->geo_profiles[0].bands[0].chains))) {
 		ret = -EINVAL;
@@ -627,13 +644,12 @@ int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	}
 
 	fwrt->geo_rev = data->revision;
+	profile_size = 3 * n_subbands;
 	for (int prof = 0; prof < data->num_profiles; prof++) {
-		const u8 *val = &data->vals[UEFI_WGDS_PROFILE_SIZE_REV3 * prof];
+		const u8 *val = &data->vals[profile_size * prof];
 		struct iwl_geo_profile *geo_prof = &fwrt->geo_profiles[prof];
 
-		for (int subband = 0;
-		     subband < UEFI_GEO_NUM_BANDS_REV3;
-		     subband++) {
+		for (int subband = 0; subband < n_subbands; subband++) {
 			geo_prof->bands[subband].max = *val++;
 
 			for (int chain = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 3959937242d8..0d3dac65178c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -31,7 +31,6 @@
 #define IWL_SGOM_MAP_SIZE		339
 #define IWL_UATS_MAP_SIZE		339
 
-#define IWL_UEFI_WGDS_REVISION		3
 #define IWL_UEFI_MIN_WTAS_REVISION	1
 #define IWL_UEFI_MAX_WTAS_REVISION	2
 #define IWL_UEFI_SPLC_REVISION		0
@@ -82,6 +81,7 @@ struct uefi_cnv_common_step_data {
 #define UEFI_SAR_MAX_CHAINS_PER_PROFILE	4
 
 #define UEFI_GEO_NUM_BANDS_REV3		3
+#define UEFI_GEO_NUM_BANDS_REV4		4
 
 /*
  * struct uefi_cnv_var_wrds - WRDS table as defined in UEFI
@@ -150,7 +150,8 @@ struct uefi_cnv_var_ewrd {
  * @vals: a per-profile table of the offsets to add to SAR values. This is an
  *	array of profiles, each profile is an array of
  *	&struct iwl_geo_profile_band, one for each subband.
- *	There are %UEFI_GEO_NUM_BANDS_REV3 subbands.
+ *	There are %UEFI_GEO_NUM_BANDS_REV3 or %UEFI_GEO_NUM_BANDS_REV4 subbands
+ *	depending on the revision.
  */
 struct uefi_cnv_var_wgds {
 	u8 revision;
@@ -163,10 +164,16 @@ struct uefi_cnv_var_wgds {
  */
 #define UEFI_WGDS_PROFILE_SIZE_REV3 (sizeof(u8) * 3 * UEFI_GEO_NUM_BANDS_REV3)
 
+#define UEFI_WGDS_PROFILE_SIZE_REV4 (sizeof(u8) * 3 * UEFI_GEO_NUM_BANDS_REV4)
+
 #define UEFI_WGDS_TABLE_SIZE_REV3				\
 	(offsetof(struct uefi_cnv_var_wgds, vals) +		\
 	 UEFI_WGDS_PROFILE_SIZE_REV3 * BIOS_GEO_MAX_PROFILE_NUM)
 
+#define UEFI_WGDS_TABLE_SIZE_REV4				\
+	(offsetof(struct uefi_cnv_var_wgds, vals) +		\
+	 UEFI_WGDS_PROFILE_SIZE_REV4 * BIOS_GEO_MAX_PROFILE_NUM)
+
 /*
  * struct uefi_cnv_var_ppag - PPAG table as defined in UEFI
  * @revision: the revision of the table
-- 
2.34.1


