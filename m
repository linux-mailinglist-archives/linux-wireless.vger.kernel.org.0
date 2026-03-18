Return-Path: <linux-wireless+bounces-33437-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gISCGZcRu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33437-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4562C2C0E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3153331BE635
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15922371051;
	Wed, 18 Mar 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIZEC40y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D97372B37
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867303; cv=none; b=cSvRYZN7Gncn8inh/7YXjLvwZdsUEgFJnAAARf5nvuL1JOsWiZWBYxsRm6iQgGHxZ2nvJCYrm+etqBeXCrAe4JhbxrAqz4lesOiMYa98JXQDSmvlp69BcIoyF1FbWHAYWIPzY7rRFtSclN3WJZ8b4QxL6Ic2Dlwk+Hx5sGdlH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867303; c=relaxed/simple;
	bh=3U2vFM3LEuR28r8ELOYDFi3OdFyjwLWg7wirs3SnKIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCZIsuR6URkVsiTPVuFfj3fvVCtUAP82gaXWyq4/9tmraQS0ns+uP6efr5oOgSSkixAHRfRJTFr0XSr8IsRRM6rQAAi0eU5mcfO1/nyXNRNGlAa5llB+LSEEuHz7XlfqQjknCcBEG0oA63kX7rETSlOZRNKMmzXem2rLSlBqYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIZEC40y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867301; x=1805403301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3U2vFM3LEuR28r8ELOYDFi3OdFyjwLWg7wirs3SnKIQ=;
  b=DIZEC40yy1/gl93fsTezywBVayKdAur1zwbOfYe89pMzgQ3o480/wqnK
   dkrqEUAykQshOpNHIqJfWp2kC6DjSb/fB6xC/fxgA+xPq3obbe6ynp6gm
   dhbj0S4DGKU0nE2T0dmHy/dbVQJJMuuBomKggJDIQFUDX9X4JHHyTB9za
   gl5pLosb0D5GZvsyywabXzGFjwXA+Fw+x1zoD/eQOerPuO4yc5KcMs30o
   4tm15vQsWNu3sJSv5lWK3uEUj9KONDLnptnN7BXuF0SFn7VY8O+302dEu
   keYoV+lYEOEZCJxP0eewV+3NjPDIQflQQtpKZZT7PXFGlMoczABvXnpM9
   A==;
X-CSE-ConnectionGUID: dcup/NoRRXWJZ5KW8+sEGw==
X-CSE-MsgGUID: W5gY6lsFTGalt4BHG6YfUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010035"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010035"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:55:00 -0700
X-CSE-ConnectionGUID: rwfA/HyGQMC+dkP1WRD0rw==
X-CSE-MsgGUID: LYq/Ju+JS1a4p6Y6inBdiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793947"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: regulatory: support a new command for PPAG
Date: Wed, 18 Mar 2026 22:54:28 +0200
Message-Id: <20260318225236.2e577236d3c9.I042697a73893d79ef761796354b5d1dd8522f734@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33437-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA4562C2C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Per Platform Antenna Gain is getting support for UNII-9.
Add a new version of PER_PLATFORM_ANT_GAIN_CMD.
This requires to increase the number of subbands in the firmware runtime
object.
Pass the number of subbands to iwl_bios_print_ppag to avoid printing
invalid values.

Introduce BIOS_PPAG_MAX_SUB_BANDS_NUM to avoid impacting
BIOS_SAR_MAX_SUB_BANDS_NUM which was used until now for PPAG as well.
SAR will get support for the new subband in future patches.

While at it, print the PPAG table as it was read from BIOS.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  1 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  8 +++
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 21 ++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  6 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  1 +
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 66 +++++++++++++++----
 6 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index b64abb8439b7..d00191e84f20 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -981,6 +981,7 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		}
 	}
 
+	iwl_bios_print_ppag(fwrt, num_sub_bands);
 	fwrt->ppag_bios_source = BIOS_SOURCE_ACPI;
 	ret = 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 0cd8a12e0f7c..118c08f95649 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -269,6 +269,7 @@ enum iwl_dev_tx_power_cmd_mode {
 #define IWL_NUM_CHAIN_LIMITS	2
 #define IWL_NUM_SUB_BANDS_V1	5
 #define IWL_NUM_SUB_BANDS_V2	11
+#define IWL_NUM_SUB_BANDS_V3	12
 
 /**
  * struct iwl_dev_tx_power_common - Common part of the TX power reduction cmd
@@ -573,6 +574,7 @@ enum iwl_ppag_flags {
  * @v1: command version 1 structure.
  * @v5: command version 5 structure.
  * @v7: command version 7 structure.
+ * @v8: command version 8 structure.
  * @v1.flags: values from &enum iwl_ppag_flags
  * @v1.gain: table of antenna gain values per chain and sub-band
  * @v1.reserved: reserved
@@ -581,6 +583,8 @@ enum iwl_ppag_flags {
  * @v7.ppag_config_info: see @struct bios_value_u32
  * @v7.gain: table of antenna gain values per chain and sub-band
  * @v7.reserved: reserved
+ * @v8.ppag_config_info: see @struct bios_value_u32
+ * @v8.gain: table of antenna gain values per chain and sub-band
  */
 union iwl_ppag_table_cmd {
 	struct {
@@ -598,6 +602,10 @@ union iwl_ppag_table_cmd {
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
 		s8 reserved[2];
 	} __packed v7; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_7 */
+	struct {
+		struct bios_value_u32 ppag_config_info;
+		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V3];
+	} __packed v8; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_8 */
 } __packed;
 
 #define IWL_PPAG_CMD_V1_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 9e834cc1b054..55128caac7ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -318,6 +318,27 @@ bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_is_ppag_approved);
 
+/* Print the PPAG table as read from BIOS */
+void iwl_bios_print_ppag(struct iwl_fw_runtime *fwrt, int n_subbands)
+{
+	int i, j;
+
+	IWL_DEBUG_RADIO(fwrt, "PPAG table as read from BIOS:\n");
+	IWL_DEBUG_RADIO(fwrt, "PPAG revision = %d\n", fwrt->ppag_bios_rev);
+	IWL_DEBUG_RADIO(fwrt, "PPAG flags = 0x%x\n", fwrt->ppag_flags);
+
+	if (WARN_ON_ONCE(n_subbands >
+			 ARRAY_SIZE(fwrt->ppag_chains[0].subbands)))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(fwrt->ppag_chains); i++)
+		for (j = 0; j < n_subbands; j++)
+			IWL_DEBUG_RADIO(fwrt,
+					"ppag_chains[%d].subbands[%d] = %d\n",
+					i, j,
+					fwrt->ppag_chains[i].subbands[j]);
+}
+
 bool iwl_is_tas_approved(void)
 {
 	return dmi_check_system(dmi_tas_approved_list);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 8e04b0e2d507..446c8a2c4f9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -22,6 +22,7 @@
 #define BIOS_SAR_MAX_CHAINS_PER_PROFILE 4
 #define BIOS_SAR_NUM_CHAINS             2
 #define BIOS_SAR_MAX_SUB_BANDS_NUM      11
+#define BIOS_PPAG_MAX_SUB_BANDS_NUM     12
 
 #define BIOS_GEO_NUM_CHAINS		2
 #define BIOS_GEO_MAX_NUM_BANDS		3
@@ -100,7 +101,7 @@ struct iwl_geo_profile {
 
 /* Same thing as with SAR, all revisions fit in revision 2 */
 struct iwl_ppag_chain {
-	s8 subbands[BIOS_SAR_MAX_SUB_BANDS_NUM];
+	s8 subbands[BIOS_PPAG_MAX_SUB_BANDS_NUM];
 };
 
 struct iwl_tas_data {
@@ -180,6 +181,9 @@ enum iwl_dsm_masks_reg {
 
 struct iwl_fw_runtime;
 
+/* Print the PPAG table as read from BIOS */
+void iwl_bios_print_ppag(struct iwl_fw_runtime *fwrt, int n_subbands);
+
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 
 int iwl_sar_geo_fill_table(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 38f9d9adf90e..fba41976be6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -607,6 +607,7 @@ int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 				data->vals[chain * UEFI_PPAG_SUB_BANDS_NUM + subband];
 	}
 
+	iwl_bios_print_ppag(fwrt, UEFI_PPAG_SUB_BANDS_NUM);
 	fwrt->ppag_bios_source = BIOS_SOURCE_UEFI;
 out:
 	kfree(data);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index d1a55b565898..27059ec93847 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -166,30 +166,74 @@ static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 {
 	struct iwl_fw_runtime *fwrt = &mld->fwrt;
 	union iwl_ppag_table_cmd cmd = {
-		.v7.ppag_config_info.hdr.table_source = fwrt->ppag_bios_source,
-		.v7.ppag_config_info.hdr.table_revision = fwrt->ppag_bios_rev,
-		.v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags),
+		/* v7 and v8 have the same layout for the ppag_config_info */
+		.v8.ppag_config_info.hdr.table_source = fwrt->ppag_bios_source,
+		.v8.ppag_config_info.hdr.table_revision = fwrt->ppag_bios_rev,
+		.v8.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags),
 	};
+	int cmd_ver =
+		iwl_fw_lookup_cmd_ver(mld->fw,
+				      WIDE_ID(PHY_OPS_GROUP,
+					      PER_PLATFORM_ANT_GAIN_CMD), 1);
+	int cmd_len = sizeof(cmd.v8);
 	int ret;
 
+	BUILD_BUG_ON(offsetof(typeof(cmd), v8.ppag_config_info.hdr) !=
+		     offsetof(typeof(cmd), v7.ppag_config_info.hdr));
+	BUILD_BUG_ON(offsetof(typeof(cmd), v8.gain) !=
+		     offsetof(typeof(cmd), v7.gain));
+
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.v7.gain) > ARRAY_SIZE(fwrt->ppag_chains));
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.v7.gain[0]) >
+		     ARRAY_SIZE(fwrt->ppag_chains[0].subbands));
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.v8.gain) > ARRAY_SIZE(fwrt->ppag_chains));
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.v8.gain[0]) >
+		     ARRAY_SIZE(fwrt->ppag_chains[0].subbands));
+
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits going to be sent: %d\n",
 			fwrt->ppag_flags);
 
-	for (int chain = 0; chain < IWL_NUM_CHAIN_LIMITS; chain++) {
-		for (int subband = 0; subband < IWL_NUM_SUB_BANDS_V2; subband++) {
-			cmd.v7.gain[chain][subband] =
-				fwrt->ppag_chains[chain].subbands[subband];
-			IWL_DEBUG_RADIO(fwrt,
-					"PPAG table: chain[%d] band[%d]: gain = %d\n",
-					chain, subband, cmd.v7.gain[chain][subband]);
+	/* Since ver 7 will be deprecated at some point, don't bother making
+	 * this code generic for both ver 7 and ver 8: duplicate the code.
+	 */
+	if (cmd_ver == 7) {
+		for (int chain = 0; chain < ARRAY_SIZE(cmd.v7.gain); chain++) {
+			for (int subband = 0;
+			     subband < ARRAY_SIZE(cmd.v7.gain[0]);
+			     subband++) {
+				cmd.v7.gain[chain][subband] =
+					fwrt->ppag_chains[chain].subbands[subband];
+				IWL_DEBUG_RADIO(fwrt,
+						"PPAG table: chain[%d] band[%d]: gain = %d\n",
+						chain, subband,
+						cmd.v7.gain[chain][subband]);
+			}
 		}
+		cmd_len = sizeof(cmd.v7);
+	} else if (cmd_ver == 8) {
+		for (int chain = 0; chain < ARRAY_SIZE(cmd.v8.gain); chain++) {
+			for (int subband = 0;
+			     subband < ARRAY_SIZE(cmd.v8.gain[0]);
+			     subband++) {
+				cmd.v8.gain[chain][subband] =
+					fwrt->ppag_chains[chain].subbands[subband];
+				IWL_DEBUG_RADIO(fwrt,
+						"PPAG table: chain[%d] band[%d]: gain = %d\n",
+						chain, subband,
+						cmd.v8.gain[chain][subband]);
+			}
+		}
+	} else {
+		WARN(1, "Bad version for PER_PLATFORM_ANT_GAIN_CMD %d\n",
+		     cmd_ver);
+		return -EINVAL;
 	}
 
 	IWL_DEBUG_RADIO(mld, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
-				   &cmd, sizeof(cmd.v7));
+				   &cmd, cmd_len);
 	if (ret < 0)
 		IWL_ERR(mld, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
-- 
2.34.1


