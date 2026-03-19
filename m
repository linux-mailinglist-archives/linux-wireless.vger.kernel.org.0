Return-Path: <linux-wireless+bounces-33477-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CfuAbTAu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33477-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:24:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1222C88B8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B913630802C6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E23B2FEB;
	Thu, 19 Mar 2026 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuaSpv1a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0463BA24A
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911402; cv=none; b=HvKsMFidsFCg0HbVlEo5TMdEPsyzrGIF2MU9p88Dv70Q5LG+v6pbTkESzEmwpR9iDKNtI7fw/2HzYvM6PG+NDrZM2wCDXIBmXfC6XAhl5f7FBGIij+VZ5DkuMdt6+Mx0MWjJA3jx4QCFHHVWHNA+RfL1UGB8BMVedgJE+bkcmzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911402; c=relaxed/simple;
	bh=Gxhr1aJTmjnVSF/41gxi1bZaJBh3xF9rTNmeKHASd28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqC5q4bcE4kNmYf/5LoT7MQUtRfQsIMPxu00ND3Tsc/okGaxCFH0Ll1DukoMwxgB0WTbr8ne1RFKttiJuW6W+1Y5jUnQ93X2n95UMqrzSEZQ/iKJMZVCzu8QMkhZvwRvKyjDCLZMBcVHG2AueDULybr+14trpcu6+4atFMdCI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuaSpv1a; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911399; x=1805447399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gxhr1aJTmjnVSF/41gxi1bZaJBh3xF9rTNmeKHASd28=;
  b=FuaSpv1a89Uh7zFl3Smrm8kzjWgqadEpEyrI3dgDw44AzoEdzsryYSe+
   U5urlchuFus1P1Dy3yPHemhhffMM0bW30l0zgWcyEQiPcKk3xqbsq4A85
   ON70XORbL09Mnb+9RAkBTFrIICxIqf1JaYSGeCiqJSICZIWStpD6oTpNH
   Vaqr+/2/moLpmGxqvgm5gKk9rGK2hAeRbYbsMllxJG4Jvpxfn28NiiflE
   vtM2oVgiygn2VAg9NCnL/E07or06MbE3XSnT8nBRAdn2EDcZ+wMe8Hm1q
   sNnbvdChEBtDGb7N6NHrw9eMIEqSD6frLsnCJrn0mKGvG3iub9dBrkDWb
   w==;
X-CSE-ConnectionGUID: yBPMAde2SqGypRIZnKpHHA==
X-CSE-MsgGUID: KtxmoiCCRsGoVnhiooVRvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992746"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992746"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:57 -0700
X-CSE-ConnectionGUID: vnHAcTW9S+aqsBIlk91Ikg==
X-CSE-MsgGUID: 45m9pDcWRReqfkPUbtapVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387163"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: acpi: check the size of the ACPI PPAG tables
Date: Thu, 19 Mar 2026 11:09:26 +0200
Message-Id: <20260319110722.451808698662.I91234c8a662608674679ce490b51be792332cd43@changeid>
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
	TAGGED_FROM(0.00)[bounces-33477-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 1E1222C88B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to make sure we don't have a buffer overflow while reading the
PPAG tables from ACPI into the firmware runtime object.
Add an ACPI specific define for the number of chains in order to
decouple the ACPI layout from the other objects.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 11 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  5 +++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index d00191e84f20..de30799519cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -951,6 +951,15 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	goto out_free;
 
 read_table:
+	if (WARN_ON_ONCE(num_sub_bands >
+			 ARRAY_SIZE(fwrt->ppag_chains[0].subbands))) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	BUILD_BUG_ON(ACPI_PPAG_NUM_CHAINS >
+		     ARRAY_SIZE(fwrt->ppag_chains));
+
 	fwrt->ppag_bios_rev = tbl_rev;
 	flags = &wifi_pkg->package.elements[1];
 
@@ -967,7 +976,7 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	 * first sub-band (j=0) corresponds to Low-Band (2.4GHz), and the
 	 * following sub-bands to High-Band (5GHz).
 	 */
-	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
+	for (i = 0; i < ACPI_PPAG_NUM_CHAINS; i++) {
 		for (j = 0; j < num_sub_bands; j++) {
 			union acpi_object *ent;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 06cece4ea6d9..c34dc17ff608 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -96,9 +96,10 @@
  */
 #define ACPI_WTAS_WIFI_DATA_SIZE	(3 + IWL_WTAS_BLACK_LIST_MAX)
 
-#define ACPI_PPAG_WIFI_DATA_SIZE_V1	((IWL_NUM_CHAIN_LIMITS * \
+#define ACPI_PPAG_NUM_CHAINS		2
+#define ACPI_PPAG_WIFI_DATA_SIZE_V1	((ACPI_PPAG_NUM_CHAINS * \
 					  IWL_NUM_SUB_BANDS_V1) + 2)
-#define ACPI_PPAG_WIFI_DATA_SIZE_V2	((IWL_NUM_CHAIN_LIMITS * \
+#define ACPI_PPAG_WIFI_DATA_SIZE_V2	((ACPI_PPAG_NUM_CHAINS * \
 					  IWL_NUM_SUB_BANDS_V2) + 2)
 
 #define IWL_SAR_ENABLE_MSK		BIT(0)
-- 
2.34.1


