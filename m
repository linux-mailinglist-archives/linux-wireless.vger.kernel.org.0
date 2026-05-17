Return-Path: <linux-wireless+bounces-36543-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIvpOsN1CWokbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36543-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 527CC55FD6F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD056301227A
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14EB2E8B9B;
	Sun, 17 May 2026 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbNjlNgT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97C258EF9
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004835; cv=none; b=FR9aAdul+05eQwEmT04qURNqJyfyAYONXBCz4p/lWnWpqyUCB61gr56TpkwnQZni+sp1mfobS3Leka1jYH5xSaSzYWoPv/Fbjj7xdFl31VjiHMn2kZPobtPWT4pjIFRF6ggessmQk41TFexgcQKcmWGc2ladyu9SiXwHfSo3HoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004835; c=relaxed/simple;
	bh=iHTFSVMn97jIsYgAlB1/kXdX1+SyUTZCwMHbKTf3xCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OyxqXLVLrijp0iZt9TPHCMvEuTvZJaSBg2zoO61rWLNJJeh9QX/2syCVqc/a2M8ysRRpRO94eN+l+CiSSFBDT23jrN+W2L5dum90md6J0+MDk4FzXJfBUDQ+WgmG/tE6hWFkmU0UbPRXMFRtkpXBKJwGHBzipRVO2f3LUNwK+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbNjlNgT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004834; x=1810540834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHTFSVMn97jIsYgAlB1/kXdX1+SyUTZCwMHbKTf3xCI=;
  b=VbNjlNgT/xt2FMz9u+BTA2l7sgTy3YFDP0KerMvM3K8AhYLCCoztXgjA
   v9b117SLZkd/iRlTlQ1FcJMs7urjAZJU9C9An/WnDA5te3XDkxzjFfUp/
   hlCWlT3p0yE3ak2+f54GbRCutLwUWuDuUpFhvRNyUuQ9lMsyaniCCjOnH
   Va9fdjVORW5pmHMme1uTyQc+EJTgt7dhscxdKspqYUiripBy31pYKJCdf
   UD7z3rIBVFqitqKO/jWL7w8TTXflIPNveERI2xNy5ivZ2ebU4NWgXjUbG
   oJ+39JvSxPthCcS9m2iF8187ZJv/yBALlUYLnVhBDJbQFh1oCBYTUWv2G
   w==;
X-CSE-ConnectionGUID: NlQFLq8HQL2/m4HfXg7khw==
X-CSE-MsgGUID: LY1vgDYUQ1W3jJ06NWdchg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606960"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606960"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:34 -0700
X-CSE-ConnectionGUID: MWjgB+fSRQ+a/gS5kv7pRg==
X-CSE-MsgGUID: rdlArnOxTmCcAly64svhvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490446"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/15] wifi: iwlwifi: move iwl_trans_activate_nic to iwl-trans.c
Date: Sun, 17 May 2026 10:59:51 +0300
Message-Id: <20260517100550.0d433fb04d51.I50c48e3f4abe23236d3735236dac250588780f6a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 527CC55FD6F
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
	TAGGED_FROM(0.00)[bounces-36543-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
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


