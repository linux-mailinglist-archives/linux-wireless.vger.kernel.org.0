Return-Path: <linux-wireless+bounces-33502-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN+8AEZFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33502-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731712D14DD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AFE9304AC1A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604F345738;
	Thu, 19 Mar 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LV855LZG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFB315D33
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946161; cv=none; b=jnPrMfvcz3XduMBtQAHaOeZZ6dQ6VhobspVU9UhFXcrxJpHFRQtDcGCtmKNNZjkXjHKxyDYzePt+HOo50ZopHgpq4/8kbTqgjxIBqzOPh9F/ET7SQc1WMA+OhYHsCBb2xmm+jvZkRqY7FopaF+YW1KTmceSS+wdpkuV8coQSZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946161; c=relaxed/simple;
	bh=ldEkHGkF9Pl9G0eqrpcojRSUtTlkfZ4VpD6gGkTFRAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6+6wM3XAusfK6vCBK0epwr4Jpo9MtOA1G1ef0s/daLZF/ctIWzwPY7yNL7bUufbNRRsaZ7bqGyxtzUX7l+NBpp60eWIYQiUiVd0PPepsM+Wk0umFyQOfXz52N66Lg0GqZeYMeuRgVHf2QpPXtfg3hoKSebV+ldc/AgnuCgJllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LV855LZG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946160; x=1805482160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ldEkHGkF9Pl9G0eqrpcojRSUtTlkfZ4VpD6gGkTFRAk=;
  b=LV855LZGWD/IRbBSvwlQstoY3TrjnA7nYX1pFMmawhX6whplmNC7jzt3
   ITrZHp0tk0ZoNjvvpTBXIT/kCxvvnDA/phMQlTcpIGV5hgt1rjoMkH9W2
   Zvv+PLi1g5NQ5+LpmCHpWMdyb7vaqb2/dgnYiyF991GVJwBXpmYXVi4Mm
   qccgzZsNr1eeiY9fmEYRGAfTN25SGN0lVex0c2cpa3+fKSNL7CO+PLeg0
   mksctHcloJ3oKlcVOgVh650dc5/d5qlvVcVryu6FwO6t9NAiP3+Mv8N4d
   WkPmyS+Y6c9eV7BLy0sEfDrXhq5t5uf9vFse1GTkSJUvRtNqR8h/0MSHl
   w==;
X-CSE-ConnectionGUID: nnpePpLqRV2KflB6GNzUqg==
X-CSE-MsgGUID: pmNpVkJbSu+F97sx6+6dZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656486"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656486"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:20 -0700
X-CSE-ConnectionGUID: h25QM5grTSyZ7XLQokNZ1Q==
X-CSE-MsgGUID: ylmKmDuDQVKuwkM2eGqNqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998530"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: uefi: open code the parsing of the WGDS table
Date: Thu, 19 Mar 2026 20:48:48 +0200
Message-Id: <20260319204647.140706e6e91f.I83ca04932bc21aa358119890001e876ced1e1bda@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33502-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 731712D14DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We will soon add support for UNII-9 band in the WGDS table. We need to
decouple the UEFI code from the firmware runtime code.
The firmware runtime is just a software object which will need to grow
and UEFI objects need a new revision to grow. Existing systems will keep
the same UEFI objects.

Just like PPAG and SAR, stop using structures to parse the UEFI tables
since the layout depends on the revision.
The support for the new revision will be added in the next patch, for
now, just do the ground work.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 33 +++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 18 +++++++++--
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 3d3d698bacd0..ccac50385175 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -593,10 +593,11 @@ int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_wgds *data;
-	int i, ret = 0;
+	int ret = 0;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WGDS_NAME,
-					      "WGDS", sizeof(*data), NULL);
+					      "WGDS", UEFI_WGDS_TABLE_SIZE_REV3,
+					      NULL);
 	if (IS_ERR(data))
 		return -EINVAL;
 
@@ -615,10 +616,32 @@ int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 		goto out;
 	}
 
+	if (WARN_ON(BIOS_GEO_MAX_PROFILE_NUM >
+		    ARRAY_SIZE(fwrt->geo_profiles) ||
+		    UEFI_GEO_NUM_BANDS_REV3 >
+		    ARRAY_SIZE(fwrt->geo_profiles[0].bands) ||
+		    BIOS_GEO_NUM_CHAINS >
+		    ARRAY_SIZE(fwrt->geo_profiles[0].bands[0].chains))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	fwrt->geo_rev = data->revision;
-	for (i = 0; i < data->num_profiles; i++)
-		memcpy(&fwrt->geo_profiles[i], &data->geo_profiles[i],
-		       sizeof(struct iwl_geo_profile));
+	for (int prof = 0; prof < data->num_profiles; prof++) {
+		const u8 *val = &data->vals[UEFI_WGDS_PROFILE_SIZE_REV3 * prof];
+		struct iwl_geo_profile *geo_prof = &fwrt->geo_profiles[prof];
+
+		for (int subband = 0;
+		     subband < UEFI_GEO_NUM_BANDS_REV3;
+		     subband++) {
+			geo_prof->bands[subband].max = *val++;
+
+			for (int chain = 0;
+			     chain < BIOS_GEO_NUM_CHAINS;
+			     chain++)
+				geo_prof->bands[subband].chains[chain] = *val++;
+		}
+	}
 
 	fwrt->geo_num_profiles = data->num_profiles;
 	fwrt->geo_enabled = true;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index aa5a4c5a7392..3959937242d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -81,6 +81,8 @@ struct uefi_cnv_common_step_data {
 
 #define UEFI_SAR_MAX_CHAINS_PER_PROFILE	4
 
+#define UEFI_GEO_NUM_BANDS_REV3		3
+
 /*
  * struct uefi_cnv_var_wrds - WRDS table as defined in UEFI
  *
@@ -145,14 +147,26 @@ struct uefi_cnv_var_ewrd {
  * @revision: the revision of the table
  * @num_profiles: the number of geo profiles we have in the table.
  *	The first 3 are mandatory, and can have up to 8.
- * @geo_profiles: a per-profile table of the offsets to add to SAR values.
+ * @vals: a per-profile table of the offsets to add to SAR values. This is an
+ *	array of profiles, each profile is an array of
+ *	&struct iwl_geo_profile_band, one for each subband.
+ *	There are %UEFI_GEO_NUM_BANDS_REV3 subbands.
  */
 struct uefi_cnv_var_wgds {
 	u8 revision;
 	u8 num_profiles;
-	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
+	u8 vals[];
 } __packed;
 
+/* struct iwl_geo_profile_band is 3 bytes-long, but since it is not packed,
+ * we can't use sizeof()
+ */
+#define UEFI_WGDS_PROFILE_SIZE_REV3 (sizeof(u8) * 3 * UEFI_GEO_NUM_BANDS_REV3)
+
+#define UEFI_WGDS_TABLE_SIZE_REV3				\
+	(offsetof(struct uefi_cnv_var_wgds, vals) +		\
+	 UEFI_WGDS_PROFILE_SIZE_REV3 * BIOS_GEO_MAX_PROFILE_NUM)
+
 /*
  * struct uefi_cnv_var_ppag - PPAG table as defined in UEFI
  * @revision: the revision of the table
-- 
2.34.1


