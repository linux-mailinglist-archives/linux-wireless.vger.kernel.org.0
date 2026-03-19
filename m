Return-Path: <linux-wireless+bounces-33499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDw4I0xFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934B2D14EC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F497300C54C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3043451B3;
	Thu, 19 Mar 2026 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duhS9NMn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849A347BC9
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946156; cv=none; b=CK+iYvk4gsv5V30jPDTT+OcW8cADglPRq9qVmEftoSG1kKhg0xP6IhDsAHoZmVKd/i/8mQQXYkvT96Co016H03XIrPea2XUFiFUYNpkttKJMCwElaDLLHWGV0JFR9Y1PlnNZ/4UYe4VTJwJrRFY3WjN09crbRa/YeYiyVZ/+Ed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946156; c=relaxed/simple;
	bh=9yuz3iq3PeYwVJvbLg6CNkXMkDGa4bqYqvLm8F7gERw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUgxdG5dL1huYynLdjLQ2naywdr2kgCvzAC8Xr0r/31L8kFxtbBzQUAUZxv6AwgK4axRzxHCbssebr4CTpQ/jbt2yE3/illab+cCYxKft2vbvz/YvoQG/oFQfPCAghTgFVkoz40OxgYHNCAaT8qd56fqkV3mXOuo3QCgy77dNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duhS9NMn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946155; x=1805482155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9yuz3iq3PeYwVJvbLg6CNkXMkDGa4bqYqvLm8F7gERw=;
  b=duhS9NMnqjCgLYTK9YnzKoqHjO1fSYK29OKWvbW1MZOl3HvH373jwwOL
   +mN4H9UZjFYIe8wm9kgh784di6TBsi5VUCLo1ygwY8k1HNigCiLyMmXbZ
   LyY0H9mfgCcT03aI8um1Gg5SKtIj2nWfG7JYRfbA+u1OPxGB5n+KNChYp
   fdBMaCa+NOhrq2fzGVwpMHMN+a62lKHDQX7aMJO0iCFx6dBdys7VquqWX
   Caf0HHiXG9DGJoDPs1Z638cb6CH6K0j5TLPW/GW4jJz0NNOsTUmq22qNv
   PnPa+chv2HoJHAQWZuHKJkFXIqvE5XqxOKSfGC3nqthVpG5lbO3+gfELM
   Q==;
X-CSE-ConnectionGUID: tEtIKbKaThC+M3rxhI2V+A==
X-CSE-MsgGUID: nLPz3TDpSk2qMW0phzIPhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656480"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:15 -0700
X-CSE-ConnectionGUID: gyBVh3vITSO6I8frixa8Ow==
X-CSE-MsgGUID: vpnNDqLWQLOUKv1tPa/coA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998516"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: acpi: add support for WRDS rev 3 table
Date: Thu, 19 Mar 2026 20:48:45 +0200
Message-Id: <20260319204647.06543ec65e00.I73135c7d61bff9b46ad9862d93f4faf923983fd4@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33499-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8934B2D14EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This table includes another sub-band for UNII-9.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 25 +++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4d0a93832336..debbba22a909 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -535,7 +535,23 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* start by trying to read revision 2 */
+	/* start by trying to read revision 3 */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WRDS_WIFI_DATA_SIZE_REV3,
+					 &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 3) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		num_chains = ACPI_SAR_NUM_CHAINS_REV2;
+		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV3;
+
+		goto read_table;
+	}
+
+	/* then try revision 2 */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WRDS_WIFI_DATA_SIZE_REV2,
 					 &tbl_rev);
@@ -592,6 +608,13 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 		goto out_free;
 	}
 
+	if (WARN_ON(num_chains * num_sub_bands >
+		    ARRAY_SIZE(fwrt->sar_profiles[0].chains) *
+		    ARRAY_SIZE(fwrt->sar_profiles[0].chains[0].subbands))) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	IWL_DEBUG_RADIO(fwrt, "Reading WRDS tbl_rev=%d\n", tbl_rev);
 
 	flags = wifi_pkg->package.elements[1].integer.value;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 138fdb9a5273..ec6af1b58098 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -39,6 +39,7 @@
 #define ACPI_SAR_NUM_SUB_BANDS_REV0	5
 #define ACPI_SAR_NUM_SUB_BANDS_REV1	11
 #define ACPI_SAR_NUM_SUB_BANDS_REV2	11
+#define ACPI_SAR_NUM_SUB_BANDS_REV3	12
 
 #define ACPI_WRDS_WIFI_DATA_SIZE_REV0	(ACPI_SAR_NUM_CHAINS_REV0 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV0 + 2)
@@ -46,6 +47,8 @@
 					 ACPI_SAR_NUM_SUB_BANDS_REV1 + 2)
 #define ACPI_WRDS_WIFI_DATA_SIZE_REV2	(ACPI_SAR_NUM_CHAINS_REV2 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 2)
+#define ACPI_WRDS_WIFI_DATA_SIZE_REV3	(ACPI_SAR_NUM_CHAINS_REV2 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV3 + 2)
 #define ACPI_EWRD_WIFI_DATA_SIZE_REV0	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_NUM_CHAINS_REV0 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV0 + 3)
-- 
2.34.1


