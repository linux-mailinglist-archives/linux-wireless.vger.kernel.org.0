Return-Path: <linux-wireless+bounces-36377-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MALODg0VBGqDDQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36377-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:07:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F2C52DEFC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACFC8309A940
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859B3D3326;
	Wed, 13 May 2026 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8+amBEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0F3D3302;
	Wed, 13 May 2026 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652350; cv=none; b=m3+HWKsC/Nkhy61O8YR0gjQ++h9rWdrJVWScPFggzAWbuQ6zZVZ5gt6c/dAfLc+9DRGwkLbxybNKac7lrDPBVYWQvNX6fPxGzDmtaDZoVxwbhaLCCnUhiev8FxaGrFEvgpgGdSrUP4N6ObpMjRUFuPuUwhIeHZ8rOzc3Kc2vdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652350; c=relaxed/simple;
	bh=vNaQjYEzsW3hrnW4jAtb5W62bkbeqFDjM4KUyUPNwoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYO8Zow2FXLiOmOhKdZtSkD7b0OaNp8JqD9rH2t1BxtULczZIiZEksu5Wa9/RHDL1VjhItacD0fkz8MLjS2hWN5/Us4TL8UDS5MHHSPaSrxhNKruwwGq+ruTHQPZfwVeCvFhLY0hOaDc7Lpa2oGyt6etfblIrsnfe9DZe7R2AZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8+amBEn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778652348; x=1810188348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vNaQjYEzsW3hrnW4jAtb5W62bkbeqFDjM4KUyUPNwoo=;
  b=n8+amBEnTQebUWB8mIDZ12VyTrgfnRl3r8Dm8A7FLgpk0spFN6bUVAQs
   oDwJTGVbwAINHCIdx5G/fuqeJCBnmPgc9HwX9CUMi+CFMlj0/z1P/9IyQ
   OtqzoErxVvJy+ftN6GaQ4r5bhiv6+YeAX2amOj00wxmx0ftJ//NVAZQcz
   1/V9h/wtlYXuLJNhoYS4XnwjdsMJ0fYBtYGupRLVGW+c++eYMLF5LahqA
   tgDOL/fnpNJl0fOeTI0Ifig3pnQSxgOembeFyrp41uKV9aBWOijP8Xeah
   QHV+D/a/63uHgjmxV1nhl1bF9IEoCbcwYjO3GzskoUxSXCqxYAiGg1Mtj
   A==;
X-CSE-ConnectionGUID: 6qdSMZtgQpmKqvNyLJCk2g==
X-CSE-MsgGUID: Z7Mi4YBGSeOFwZ85h5Ihtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90954413"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90954413"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 23:05:45 -0700
X-CSE-ConnectionGUID: 2STAC0B+THOQSMqEy6Hlog==
X-CSE-MsgGUID: V160g7j/Sii/HC6LzW7XXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233712408"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa010.fm.intel.com with ESMTP; 12 May 2026 23:05:43 -0700
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
	emmanuel.grumbach@intel.com
Subject: [PATCH v3 3/3] wifi: iwlwifi: dt: use Device Tree as fallback BIOS configuration source
Date: Wed, 13 May 2026 09:05:31 +0300
Message-Id: <20260513060531.8130-4-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513060531.8130-1-avinash.bhatt@intel.com>
References: <20260513060531.8130-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96F2C52DEFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36377-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index 640e729091..d7ead787c2 100644
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
+	if (ret < 0 && iwl_dt_is_compatible(fwrt))			\
+		ret = iwl_dt_get_ ## __name(__VA_ARGS__);		\
 	return ret;							\
 } while (0)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 130eba60b4..1a95b19d33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -12,6 +12,7 @@
 #include "fw/api/coex.h"
 #include "fw/dbg.h"
 #include "fw/uefi.h"
+#include "fw/dt.h"
 
 #include "mld.h"
 #include "mlo.h"
@@ -466,6 +467,8 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 	iwl_mld_get_bios_tables(mld);
 	iwl_uefi_get_sgom_table(trans, &mld->fwrt);
 	mld->bios_enable_puncturing = iwl_uefi_get_puncturing(&mld->fwrt);
+	if (!mld->bios_enable_puncturing && iwl_dt_is_compatible(&mld->fwrt))
+		mld->bios_enable_puncturing = iwl_dt_get_puncturing(&mld->fwrt);
 	mld->rfi.bios_enabled = iwl_rfi_is_enabled_in_bios(&mld->fwrt);
 
 	iwl_mld_hw_set_regulatory(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 97b2283f51..ce539a0be7 100644
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
+	if (!mld->fwrt.ap_type_cmd_valid && iwl_dt_is_compatible(&mld->fwrt))
+		iwl_dt_get_uats_table(&mld->fwrt);
 	iwl_uefi_get_uneb_table(mld->trans, &mld->fwrt);
 
 	iwl_bios_get_phy_filters(&mld->fwrt);
-- 
2.34.1


