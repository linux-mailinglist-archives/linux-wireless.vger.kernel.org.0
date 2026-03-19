Return-Path: <linux-wireless+bounces-33500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLw2BDtFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B582D14C7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01E603011C81
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB08283C93;
	Thu, 19 Mar 2026 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cx+2BII2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647ED34D923
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946158; cv=none; b=cOfACjtHQ4LXMN4iMh6EHZeMriYIBHkADfUqZm6JJMYu9/Ks0QTo7dP7LY3pOItSXzpxQrfzxGfQICWPCXO1udqD/ftYEy/uFF4ml2q39t/GjU6S8IT1fnUiQEI0Pg5hxX7Dj/pucFRMOI2533MURaGQTMVKdm3F1rgnFD7DwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946158; c=relaxed/simple;
	bh=O0ryixJB3PIPoBdRLAiXs1fq586YYeOsJJRrqrPNo6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDh9DgwqNyvTxul6DB7uia4Mhz9vOUoIa9Q3OFbtfVA/VQnj+obk8/zWgvVazn8x0opW8mHQxWb7pl6JhMtSWtyDGh/hxtlSSMK9nm1eMd+1QfK4vffVeER8KwIJUV6Kt8paayv2IQ8bJIgg6sycz4ndIUEMsDuF2rzWkDax8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cx+2BII2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946157; x=1805482157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O0ryixJB3PIPoBdRLAiXs1fq586YYeOsJJRrqrPNo6s=;
  b=Cx+2BII2FFIuLuUnDSvDWNOEzcfIacVELLsWa6UwtPpNKc2MrzZR2nT+
   DYtaTgpEtyzQ6TqHujMjLxElj5fMO0AqRPNVBl8J9I6hJsKWTRFoMljLi
   GTZs2beWYPI1j1bSFFC81RKtC/Aw6cH94+unOUXlpl9dYfR/osOeWqdL5
   wlrmrJ4FxPY2xIwXghQyuRwP9NzpVl4XI5f3l/TQX/5LKoTHAs3MWJnhk
   MYvt+yOaUMri1oQEtKLNV6fSb0fhVTzrmsW3nsynvl/bE5wsqu5AiGkmI
   k7vOLxI5d5eedL+MBbVwX40FbHJRcNMSY3f3809pcd7fwW2iaxyaBwSTR
   Q==;
X-CSE-ConnectionGUID: MyV3XLF5Q5SorYCWZ2dNiQ==
X-CSE-MsgGUID: 3BmX5vGISQ+ZNV3+K0MhhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656481"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:16 -0700
X-CSE-ConnectionGUID: Zglz5Yj2RjOLY1PmGTCpKg==
X-CSE-MsgGUID: 3YVBfpdkRpyfbpJbLZQ2EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998521"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: acpi: add support for EWRD rev 3 table
Date: Thu, 19 Mar 2026 20:48:46 +0200
Message-Id: <20260319204647.9182284f007e.Ibbe7c1f8442933d29695b9bf56b8e775394c71f8@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33500-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: A0B582D14C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This table includes another sub-band for UNII-9.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 31 +++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  3 ++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index debbba22a909..721bd014bbaa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -648,7 +648,22 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* start by trying to read revision 2 */
+	/* start by trying to read revision 3 */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_EWRD_WIFI_DATA_SIZE_REV3,
+					 &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 3) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV3;
+
+		goto read_table;
+	}
+
+	/* then try revision 2 */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_EWRD_WIFI_DATA_SIZE_REV2,
 					 &tbl_rev);
@@ -703,6 +718,13 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 		goto out_free;
 	}
 
+	if (WARN_ON(ACPI_SAR_NUM_CHAINS_REV0 * num_sub_bands >
+		    ARRAY_SIZE(fwrt->sar_profiles[0].chains) *
+		    ARRAY_SIZE(fwrt->sar_profiles[0].chains[0].subbands))) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	enabled = !!(wifi_pkg->package.elements[1].integer.value);
 	n_profiles = wifi_pkg->package.elements[2].integer.value;
 
@@ -745,6 +767,13 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	if (tbl_rev < 2)
 		goto set_enabled;
 
+	if (WARN_ON(ACPI_SAR_NUM_CHAINS_REV0 * 2 * num_sub_bands >
+		    ARRAY_SIZE(fwrt->sar_profiles[0].chains) *
+		    ARRAY_SIZE(fwrt->sar_profiles[0].chains[0].subbands))) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	/* parse cdb chains for all profiles */
 	for (i = 0; i < n_profiles; i++) {
 		struct iwl_sar_profile_chain *chains;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index ec6af1b58098..8e5ed72d4d8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -58,6 +58,9 @@
 #define ACPI_EWRD_WIFI_DATA_SIZE_REV2	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_NUM_CHAINS_REV2 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 3)
+#define ACPI_EWRD_WIFI_DATA_SIZE_REV3	((ACPI_SAR_PROFILE_NUM - 1) * \
+					 ACPI_SAR_NUM_CHAINS_REV2 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV3 + 3)
 #define ACPI_WPFC_WIFI_DATA_SIZE	5 /* domain and 4 filter config words */
 
 /* revision 0 and 1 are identical, except for the semantics in the FW */
-- 
2.34.1


