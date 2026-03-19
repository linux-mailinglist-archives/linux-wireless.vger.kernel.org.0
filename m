Return-Path: <linux-wireless+bounces-33506-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEZ+NUhFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33506-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE302D14E4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEED13016880
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74334D391;
	Thu, 19 Mar 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qi29DW24"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F834D4D8
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946167; cv=none; b=TX0Nr33UNBVMfnNQHBJj5sjjOFeL6ev34NiT+WVo0Y8oWngzeGo0+jg5Ok1kS3WXFfBoDbdK9rrVlnYUxPC3grUKVeT+DqwKJqDFQjsy9T/QEl1sszOLJgYBbszk/JDlR81za/MpXZAv3Cvdhcr/jm2hqZLRIbb1RGJgWyuHJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946167; c=relaxed/simple;
	bh=kAa/LAupe9jfZSliZ2mJAXDS+I26kQNDpwcxk8Ebdi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHHS9igEHbeaxYNJeZoDdxzXnLcjbY0WY2rxu3i6xFpTxVd5EOLn0YD2wRTClOWDoKDyDOA1EM8qgmwaulgrjIl9w0ZNfDEgYsqrjyQS9A7kIpiW0GDAEkgWIH3OEFtVEScAYDXtcA44EVK+g3YWBEAb76HaMuRuFeZN//6N5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qi29DW24; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946166; x=1805482166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAa/LAupe9jfZSliZ2mJAXDS+I26kQNDpwcxk8Ebdi0=;
  b=Qi29DW24KIDYYbV3QwBKGsfhp13HA5R3jrFl3vwUAX3QgwVEsC+oLNIx
   TFQpNDtLQ2lGMttQAQKuuD5XUHHVEyP0jHn2EFD/POrIGfe4Wfp1ASuvF
   Mqc2n5kHGEmiIMstt7P7/j7l68UgrNGisyvTmQQKkStMMAfDXLoktEEef
   BjrzsLtGG02tlANa/vbBmLDmPnbQZvRgRdV1BeIc7esQumxeNUyKfrAsG
   GRX+vs2PPUwDHYpuCJ8mXUKIddpuOfjJ5IFe7tsJ5NMCudfKupd1hYHaa
   x2dpaJPTcd+N2T+Y6ZZjaq8ci3ceIy0XXi+NxRHFPVueAm00x9AXdNGHS
   g==;
X-CSE-ConnectionGUID: OdqWok4GQa6RZ8HPk4i/Wg==
X-CSE-MsgGUID: p/LoICPvQgG1Dz4U+ug58Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656491"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656491"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:26 -0700
X-CSE-ConnectionGUID: vcI7wrDIQhaiogmEN5oV1g==
X-CSE-MsgGUID: XNchgc1WQ1uTgoatk2JtIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998576"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: support PER_CHAIN_LIMIT_OFFSET_CMD v6
Date: Thu, 19 Mar 2026 20:48:52 +0200
Message-Id: <20260319204647.eaff31760dd7.Ic7f56fbbe310833723094f965e7ba3f8624d0ef9@changeid>
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
	TAGGED_FROM(0.00)[bounces-33506-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 7CE302D14E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This includes support for UNII-9.
Store the source of the WGDS table in the firmware runtime object to be
able to pass the information to the firmware.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  1 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 14 ++++++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  1 +
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 32 +++++++++++++++----
 5 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 16d91c6915f0..bf0f851a9075 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -973,6 +973,7 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	}
 
 	fwrt->geo_num_profiles = num_profiles;
+	fwrt->geo_bios_source = BIOS_SOURCE_ACPI;
 	fwrt->geo_enabled = true;
 	ret = 0;
 out_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index ec923162a44b..a3f916630df2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -457,6 +457,7 @@ struct iwl_dev_tx_power_cmd {
 #define IWL_NUM_GEO_PROFILES_V3		8
 #define IWL_NUM_BANDS_PER_CHAIN_V1	2
 #define IWL_NUM_BANDS_PER_CHAIN_V2	3
+#define IWL_NUM_BANDS_PER_CHAIN_V6	4
 
 /**
  * enum iwl_geo_per_chain_offset_operation - type of operation
@@ -538,12 +539,25 @@ struct iwl_geo_tx_power_profiles_cmd_v5 {
 	__le32 table_revision;
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_5 */
 
+/**
+ * struct iwl_geo_tx_power_profiles_cmd_v6 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
+ * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
+ * @table: offset profile per band.
+ * @bios_hdr: describes the revision and the source of the BIOS
+ */
+struct iwl_geo_tx_power_profiles_cmd_v6 {
+	__le32 ops;
+	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES_V3][IWL_NUM_BANDS_PER_CHAIN_V6];
+	struct iwl_bios_config_hdr bios_hdr;
+} __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_6 */
+
 union iwl_geo_tx_power_profiles_cmd {
 	struct iwl_geo_tx_power_profiles_cmd_v1 v1;
 	struct iwl_geo_tx_power_profiles_cmd_v2 v2;
 	struct iwl_geo_tx_power_profiles_cmd_v3 v3;
 	struct iwl_geo_tx_power_profiles_cmd_v4 v4;
 	struct iwl_geo_tx_power_profiles_cmd_v5 v5;
+	struct iwl_geo_tx_power_profiles_cmd_v6 v6;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 411e75b45530..d80ae610e56c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -113,6 +113,7 @@ struct iwl_txf_iter_data {
  *	Only read the UEFI variables if locked.
  * @sar_profiles: sar profiles as read from WRDS/EWRD BIOS tables
  * @geo_profiles: geographic profiles as read from WGDS BIOS table
+ * @geo_bios_source: see &enum bios_source
  * @phy_filters: specific phy filters as read from WPFC BIOS table
  * @ppag_bios_rev: PPAG BIOS revision
  * @ppag_bios_source: see &enum bios_source
@@ -204,6 +205,7 @@ struct iwl_fw_runtime {
 	u8 sar_chain_b_profile;
 	u8 reduced_power_flags;
 	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
+	enum bios_source geo_bios_source;
 	u32 geo_rev;
 	u32 geo_num_profiles;
 	bool geo_enabled;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index f73340c7d537..2ef0a7a920ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -644,6 +644,7 @@ int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	}
 
 	fwrt->geo_rev = data->revision;
+	fwrt->geo_bios_source = BIOS_SOURCE_UEFI;
 	profile_size = 3 * n_subbands;
 	for (int prof = 0; prof < data->num_profiles; prof++) {
 		const u8 *val = &data->vals[profile_size * prof];
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 78db140aa1f2..68413d1824ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -73,16 +73,36 @@ static int iwl_mld_geo_sar_init(struct iwl_mld *mld)
 {
 	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD);
 	/* Only set to South Korea if the table revision is 1 */
-	__le32 sk = cpu_to_le32(mld->fwrt.geo_rev == 1 ? 1 : 0);
+	u8 sk = mld->fwrt.geo_rev == 1 ? 1 : 0;
 	union iwl_geo_tx_power_profiles_cmd cmd = {
 		.v5.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES),
-		.v5.table_revision = sk,
 	};
+	u32 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0);
+	int n_subbands;
+	int cmd_size;
 	int ret;
 
-	ret = iwl_sar_geo_fill_table(&mld->fwrt, &cmd.v5.table[0][0],
-				     ARRAY_SIZE(cmd.v5.table[0]),
-				     BIOS_GEO_MAX_PROFILE_NUM);
+	switch (cmd_ver) {
+	case 5:
+		n_subbands = ARRAY_SIZE(cmd.v5.table[0]);
+		cmd.v5.table_revision = cpu_to_le32(sk);
+		cmd_size = sizeof(cmd.v5);
+		break;
+	case 6:
+		n_subbands = ARRAY_SIZE(cmd.v6.table[0]);
+		cmd.v6.bios_hdr.table_revision = mld->fwrt.geo_rev;
+		cmd.v6.bios_hdr.table_source = mld->fwrt.geo_bios_source;
+		cmd_size = sizeof(cmd.v6);
+		break;
+	default:
+		WARN(false, "unsupported version: %d", cmd_ver);
+		return -EINVAL;
+	}
+
+	BUILD_BUG_ON(offsetof(typeof(cmd), v6.table) !=
+		     offsetof(typeof(cmd), v5.table));
+	ret = iwl_sar_geo_fill_table(&mld->fwrt, &cmd.v6.table[0][0],
+				     n_subbands, BIOS_GEO_MAX_PROFILE_NUM);
 
 	/* It is a valid scenario to not support SAR, or miss wgds table,
 	 * but in that case there is no need to send the command.
@@ -90,7 +110,7 @@ static int iwl_mld_geo_sar_init(struct iwl_mld *mld)
 	if (ret)
 		return 0;
 
-	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, sizeof(cmd.v5));
+	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, cmd_size);
 }
 
 int iwl_mld_config_sar_profile(struct iwl_mld *mld, int prof_a, int prof_b)
-- 
2.34.1


