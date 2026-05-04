Return-Path: <linux-wireless+bounces-35829-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KrOG7Rs+GnPuQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35829-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:53:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E744BB471
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B264130069AE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE9389441;
	Mon,  4 May 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akSHfj2W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7701361660;
	Mon,  4 May 2026 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888424; cv=none; b=Fy7fA9ZSR/a8OYtNFjUWXmGXgnEyMSsxXcZkzM0fsCRdcGdVEVvq2/Msq0mYUh8cNHRl6vjQCq5UqsOkfTFJ8O1O6fT/D17/iHRRV3OYm1VVx8ALMj9wwNU5seUVMv2dQJ4WxUMOhZON/tagneMrlRwDPEUz3YZH0u7++HCRSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888424; c=relaxed/simple;
	bh=mKa58w5dpFcGWRMkLBxMJoKorqe0hrHK6WSxFCGon3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NxLAS0Tyl3CU1WlIHYVmCC7c6Z4p8Uu/cjAYHzfCCwp8Ddp1wujtvV3ZZHkRwT2yk/7jrmxqyk908l/y0yFrkSuQuPLqsMfSzTXN9atMDn2XHGCnZ0DYo9MfIxLcPQNEJLym0BA1FyMa6nxZvdEGx0PXVZcZ/y3IbLD323BvmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akSHfj2W; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777888423; x=1809424423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mKa58w5dpFcGWRMkLBxMJoKorqe0hrHK6WSxFCGon3s=;
  b=akSHfj2W/Ljb0FuJxRFjwIKDeW/aZlf0fifA15rbtwXlDT1oO+QC6Uw0
   Os7r7yqQH0dAJg6D/vV8zNyz4j6WyhMF2g8WJxfZm0m5Myjpm4QbFhGiP
   RIE4v0p/PtcGAW615aQQOd14llT2YFdOpYwallNshZditT4oLXqeplpMl
   ejxjYVDvzZuFQgwTPifXG5BTzrJ+5dOffPngWwXDXKpQnaBo6db4r9X91
   lD+hwuY3tHzimYvY2R8JyY8zEInIDfPF9YAGgSXo4WcE3aRpIlN62CoMF
   XD0O4reBdLP+keur1Gklxr/NhLieay1bcmlGf1NQwRI+nEWjSMIPwhZz7
   Q==;
X-CSE-ConnectionGUID: N2ZFbGIsTgeQNt8cMpqffQ==
X-CSE-MsgGUID: W1FPmwZyQECWHGW0Iw8aMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78767579"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78767579"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:53:43 -0700
X-CSE-ConnectionGUID: agQKhT/XSYqTWtiB5Eb7tg==
X-CSE-MsgGUID: cPqsscEAQYSTLcuxwiIXUQ==
X-ExtLoop1: 1
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa003.fm.intel.com with ESMTP; 04 May 2026 02:53:39 -0700
From: Avinash Bhatt <avinash.bhatt@intel.com>
To: devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	linux-kernel@vger.kernel.org,
	kobi.guetta@intel.com,
	emmanuel.grumbach@intel.com,
	avinash.bhatt@intel.com
Subject: [PATCH v2 3/3] wifi: iwlwifi: dt: use Device Tree as fallback BIOS configuration source
Date: Mon,  4 May 2026 12:53:27 +0300
Message-Id: <20260504095327.30892-4-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504095327.30892-1-avinash.bhatt@intel.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68E744BB471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35829-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

When neither UEFI variables nor ACPI methods provide a BIOS
configuration table, fall back to Device Tree. This preserves the
existing UEFI -> ACPI priority order and extends it with DT as the
lowest-priority source.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c  | 3 +++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c        | 3 +++
 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 55128caac7ed..10bb4d2f64cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -8,6 +8,7 @@
 #include "regulatory.h"
 #include "fw/runtime.h"
 #include "fw/uefi.h"
+#include "fw/dt.h"
 
 #define GET_BIOS_TABLE(__name, ...)					\
 do {									\
@@ -16,6 +17,8 @@ do {									\
 		ret = iwl_uefi_get_ ## __name(__VA_ARGS__);		\
 	if (ret < 0)							\
 		ret = iwl_acpi_get_ ## __name(__VA_ARGS__);		\
+	if (ret < 0)							\
+		ret = iwl_dt_get_ ## __name(__VA_ARGS__);		\
 	return ret;							\
 } while (0)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 495e9d8f3af6..a3e93112caff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -12,6 +12,7 @@
 #include "fw/api/coex.h"
 #include "fw/dbg.h"
 #include "fw/uefi.h"
+#include "fw/dt.h"
 
 #include "mld.h"
 #include "mlo.h"
@@ -418,6 +419,8 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 	iwl_mld_get_bios_tables(mld);
 	iwl_uefi_get_sgom_table(trans, &mld->fwrt);
 	mld->bios_enable_puncturing = iwl_uefi_get_puncturing(&mld->fwrt);
+	if (!mld->bios_enable_puncturing)
+		mld->bios_enable_puncturing = iwl_dt_get_puncturing(&mld->fwrt);
 
 	iwl_mld_hw_set_regulatory(mld);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 659243ada86c..1c7d2136b2e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include <linux/dmi.h>
@@ -8,6 +8,7 @@
 #include "fw/regulatory.h"
 #include "fw/acpi.h"
 #include "fw/uefi.h"
+#include "fw/dt.h"
 
 #include "regulatory.h"
 #include "mld.h"
@@ -64,6 +65,8 @@ void iwl_mld_get_bios_tables(struct iwl_mld *mld)
 	}
 
 	iwl_uefi_get_uats_table(mld->trans, &mld->fwrt);
+	if (!mld->fwrt.ap_type_cmd_valid)
+		iwl_dt_get_uats_table(&mld->fwrt);
 	iwl_uefi_get_uneb_table(mld->trans, &mld->fwrt);
 
 	iwl_bios_get_phy_filters(&mld->fwrt);
-- 
2.34.1


