Return-Path: <linux-wireless+bounces-36525-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHD8E7zPCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36525-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D655DA2D
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A628D300F518
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1A92BDC23;
	Sat, 16 May 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDMfmQcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EBE54654
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962324; cv=none; b=k0kMNjWwdv3v3o9r+BHprGIRw6TQf6BJA/BdhSbMEpp+IFx0O/r061SHfZ3mWMK31hGGntZARDDaiHgvmf3/MTlFZw49KTmuM1Mt+QCZGDM6LC3oMMwZ34bCKzGhCoy9xFbSXwiv1Sw2VsDygfJahK4H1kyYUWi6mcj3tUKLuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962324; c=relaxed/simple;
	bh=iHTFSVMn97jIsYgAlB1/kXdX1+SyUTZCwMHbKTf3xCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dM3FFaB4M4E/npO2sabGlzdVoMGBVOQGfIZoTkEbdrYFkJrXnuQyXBlrME9IjLElypoP+yFIShAwxKAI84hghRsBMqYJSGhKaBe3Hlo6XGCxsydNSbkM+paz48aok1KAcih4Hd5gxoDMiBJrPPSAo/PN215TomAXrLMCqhnytzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDMfmQcG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962322; x=1810498322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHTFSVMn97jIsYgAlB1/kXdX1+SyUTZCwMHbKTf3xCI=;
  b=MDMfmQcGX+56juEmKwzhutExgBCpg1nTiRq30unj2xmk6ajEHJ140/iU
   KE8Y3oWeVwpnJLyjnYV7qVUYj9s9Io70XzbzuXvEUnfNi9sKLJNqjJCSZ
   4j5cNA+bZ57IXG2DCgx7MZ6zAaCvj649BqK4mJETNH6AKYZ7ACWrq09m2
   mn446vG8bGkc3aeV3lruJtALF9pyCYFcJobzx9cQpC9hHWVHWlS/3Zt9i
   IMINE3LHjN1aBRrdgve+T24HSawIz5tY06P3vRT4IPEdaWwJJaVPyjuXq
   GUBeAKF1vLDf7kINdlT2Ot9aeRQP6zavNgkxYKvxZ+FUNGNX43WqX1dDs
   A==;
X-CSE-ConnectionGUID: QCeG2/WMSh6n6fYixazIVA==
X-CSE-MsgGUID: hrQlWbxrT5CKPsvlrY9joA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845728"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:02 -0700
X-CSE-ConnectionGUID: ObZwcf0XQJOwGb50MRSd0g==
X-CSE-MsgGUID: /V8AUTkZRR6ZzERgpw4SnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130899"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 07/15] wifi: iwlwifi: move iwl_trans_activate_nic to iwl-trans.c
Date: Sat, 16 May 2026 23:11:29 +0300
Message-Id: <20260516230843.0d433fb04d51.I50c48e3f4abe23236d3735236dac250588780f6a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E64D655DA2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36525-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This function reaches the transport eventually so move it to
iwl-trans.c. Now we can remove the include to the pcie transport's
internal header from iwl-io.c

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c    | 7 -------
 drivers/net/wireless/intel/iwlwifi/iwl-io.h    | 2 --
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 9 ++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 ++
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index c4ccfffdf6af..bb746112ddad 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -12,7 +12,6 @@
 #include "iwl-debug.h"
 #include "iwl-prph.h"
 #include "iwl-fh.h"
-#include "pcie/gen1_2/internal.h"
 
 void iwl_write8(struct iwl_trans *trans, u32 ofs, u8 val)
 {
@@ -412,12 +411,6 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 	return 0;
 }
 
-int iwl_trans_activate_nic(struct iwl_trans *trans)
-{
-	return iwl_pcie_gen1_2_activate_nic(trans);
-}
-IWL_EXPORT_SYMBOL(iwl_trans_activate_nic);
-
 void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 				  u32 sw_err_bit)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index d920a32fc173..6dce2e5267a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -59,8 +59,6 @@ void iwl_set_bits_mask_prph(struct iwl_trans *trans, u32 ofs,
 void iwl_clear_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask);
 void iwl_force_nmi(struct iwl_trans *trans);
 
-int iwl_trans_activate_nic(struct iwl_trans *trans);
-
 /* Error handling */
 int iwl_dump_fh(struct iwl_trans *trans, char **buf);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index db1db0a42928..5b44e15fe64d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021, 2023-2025 Intel Corporation
+ * Copyright (C) 2019-2021, 2023-2026 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
@@ -820,3 +820,10 @@ bool iwl_trans_is_ltr_enabled(struct iwl_trans *trans)
 	return iwl_pcie_gen1_2_is_ltr_enabled(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_is_ltr_enabled);
+
+int iwl_trans_activate_nic(struct iwl_trans *trans)
+{
+	return iwl_pcie_gen1_2_activate_nic(trans);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_activate_nic);
+
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index c661807c6e6b..1ed6bcb7882c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1053,6 +1053,8 @@ static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 
 void iwl_trans_interrupts(struct iwl_trans *trans, bool enable);
 
+int iwl_trans_activate_nic(struct iwl_trans *trans);
+
 static inline void iwl_trans_finish_sw_reset(struct iwl_trans *trans)
 {
 	clear_bit(STATUS_IN_SW_RESET, &trans->status);
-- 
2.34.1


