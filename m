Return-Path: <linux-wireless+bounces-33438-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIddI5sRu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33438-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CFB2C2C15
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA8131C25B2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEA371CE5;
	Wed, 18 Mar 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COy6J0wa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334982DB781
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867303; cv=none; b=ZThxjKuVW8nvZ+Xg7EVv5rLvKTqww51+jdkmcARZxgs8IevgB9G2WduhuhsP6Rw3B7tdThY1uA3B0Lp+s/BPPflIoZSVAqFfVQbqffuCuusoff9dbxuvg+7NYIf/RF46YU6Ak4gCnX5+jPZinGe3ZycN3U4bGFIJgtSwI1sVtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867303; c=relaxed/simple;
	bh=Gxhr1aJTmjnVSF/41gxi1bZaJBh3xF9rTNmeKHASd28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBp5vdIZVSmD1f1OxNHFq9b8lnfcmaODo5MdkN+/uY5mIqwMdQlU/iAKCR4XEUF8JzTgRPW26rVVrEaR1+GDqXUFtkApIngT/CFoXLaNT3tvBhJPPIpABgq4+i9kY0BCLNvgzf3jGdDJ9icyPGqEbocOmitqgBnlY+VjR8FGeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COy6J0wa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867302; x=1805403302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gxhr1aJTmjnVSF/41gxi1bZaJBh3xF9rTNmeKHASd28=;
  b=COy6J0wax9hgAhMf78WlYygJ3+OVJK0EpXj7+YadAVst189jovWJav7a
   hbFXk56gYpMMrOHkPnEu3vojgOImwqao7P02+mpavvB0/93K6M5LhmhwI
   LQL9//OYZ8Z6volw9NUjlv8pzwr2iGugxpKhU2Jg/w5FVJs4yfd6M7bEw
   V+K44Rc3tyEWC3wbsZUeBj68BSMsulIl5bBrHAUQ7up+/Dk6eUap+fcRA
   V2W5QgC4lX2swVC2ZrH8tfaMLJfDyA/UZ3w+WFfegTJZUpxr72ykIla9n
   rq9c3Lu9Komc0hU2WonAQuQb75qX5j52HtTTuRQBSBHyikP3QsWss+G1O
   A==;
X-CSE-ConnectionGUID: JHwgKOd6QD62hILuRhe6/g==
X-CSE-MsgGUID: Ug+Uqpq/SLmWyBe5wDpLcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010036"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010036"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:55:02 -0700
X-CSE-ConnectionGUID: AkgnZwmVTLGQ00oqem6rkQ==
X-CSE-MsgGUID: fuKqfeFATLqokWhIs/7FsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793958"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:55:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: acpi: check the size of the ACPI PPAG tables
Date: Wed, 18 Mar 2026 22:54:29 +0200
Message-Id: <20260318225236.451808698662.I91234c8a662608674679ce490b51be792332cd43@changeid>
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
	TAGGED_FROM(0.00)[bounces-33438-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39CFB2C2C15
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


