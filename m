Return-Path: <linux-wireless+bounces-36633-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMZoLJIHDGqBUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36633-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EFB578530
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B1E308C9D1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFF39657A;
	Tue, 19 May 2026 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHR7yiZJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCCB3947AC
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172835; cv=none; b=X7HfWJWKEVp0rYhl+BINaZWVaR39F5L6Wg7BdPLkZSdOhFppmJb5zsV7d2NIQZU9Fii+47t6BP5UOeq/3YgaLzt61pAt3e2sBzSPMRJ3vesjvS6FakDzYtc/rOtSBr3jl7ned/4ej9CGS7IKZFnnLk7TvwY6on5in97cIK4ubTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172835; c=relaxed/simple;
	bh=O36NlgUGcJC2Th2IgK65761bf6G0a6546lGi3aO+ohU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d81FeT4adT8h2/6BR1wgw2k0vq31du2eAILjA0g4ZddcGEkLnSWpnf5M2Gyoe4Fvb0B2986bNU8ixDBZB1MkfyHAbYPCTA/3Y4aYsEcafG9jOtxQwsQlAacwf6DfpUgG/PFSNERnaiyozAWLNyXPnKZ7Oa2gGUXHQc9Vao01L/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHR7yiZJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172834; x=1810708834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O36NlgUGcJC2Th2IgK65761bf6G0a6546lGi3aO+ohU=;
  b=NHR7yiZJ0ZmEDMc5/uUiIrg6nwdbMNqgLPTr2NndHy+6IS50NOlytn7o
   pQbhIruV+J3xG2QZzc3IBrAuWvWoK0egYhJPYJXSodSZhop8O0KVuxu9b
   GsHrF+rsRZU6uRgmpVXxUA6GIQbMUlLQG1/tUIzsrMHFrzhpkuystmjJh
   XghizXbZ2IN9LNCDU4Lwun+a47jM3ZgbvDnHgNm6CEXPXvpt65/Rzi+d6
   fzVRZfkMgwoXltvhkmg7DmmTRkSp78UE1rq6FVkYOSODb1R/KxN6SFE/3
   MXUV0gQHMnJrG82kXt85d7SbKQGJB11qbpdEGuJ6zYnM3sNhZD4pnx1b3
   A==;
X-CSE-ConnectionGUID: 0AU8XIj/SDWDjrAXa7TEQg==
X-CSE-MsgGUID: GE5sa2itRaeuJPZ/8fBg2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605655"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605655"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:33 -0700
X-CSE-ConnectionGUID: wa5h9Nu5SVWmMt/ExdmJgA==
X-CSE-MsgGUID: 6n31YLYARc+T2sz17GjB8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227297"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v3 iwlwifi-next 07/15] wifi: iwlwifi: move iwl_trans_activate_nic to iwl-trans.c
Date: Tue, 19 May 2026 09:40:02 +0300
Message-Id: <20260519064010.549003-8-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36633-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 30EFB578530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This function reaches the transport eventually so move it to
iwl-trans.c. Now we can remove the include to the pcie transport's
internal header from iwl-io.c

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Link: https://patch.msgid.link/20260517100550.0d433fb04d51.I50c48e3f4abe23236d3735236dac250588780f6a@changeid
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


