Return-Path: <linux-wireless+bounces-36242-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJdjD7UTAmrangEAu9opvQ
	(envelope-from <linux-wireless+bounces-36242-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:36:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B8513975
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB0CB300F5DE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7913FF8BF;
	Mon, 11 May 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHH3ObiA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FD441022
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521011; cv=none; b=CPNgNuyrRhWBLMflMGSjmIsaUEWoz9jhGf4ZVSeuIqeuhS0to42tRekGjUPAFaabRhEqnelAwvP9uEqw4iZY5VWdDXOk4CxS8l6JO80Mp90m586rPiLlzYIAT/JcEDPYhkv0LsjWvPuzcHO0tNB+0FdsW094OYxoziipKF+ug0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521011; c=relaxed/simple;
	bh=QO1FtNCoBEL6OjZkJikcorJExnUqFassmHs/peZWi5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvaVYEf0CH3R2WXBescubvm4rn1xWuoNr3jKTDFjpfzhJGnwvlcpbxJYV7Dn4jr6/NyUJVkUn/M6/gS9cqtH+NafyZNfS4Ss+o8gJzzq87KKDI2ECLvZOS7mirdgIAe98faxqRCIqKDfh7OPzd+LVRAj7Fu7wTIoiEpEcspEYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHH3ObiA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521010; x=1810057010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QO1FtNCoBEL6OjZkJikcorJExnUqFassmHs/peZWi5g=;
  b=RHH3ObiAbb7dyMaj1RdN6wz4QWPare1NXWqRNo1kSo/QFgjG6abTWV6B
   w/AUk2SYt1RN1K9aH4t+mORsFYfPVz/H2Gg+DWz0hV3aFQg+pPpG7pSxJ
   S+9ACNW+qnoBClPl2IbVCLDQOGFPFREjIr7Qwt2PbnPHDDhSkHGBVxIOt
   XRo42j/7JwsTx0OAqXlbRlzg9lDW0UqwNb41aCRAyJF36cvSGoSkEzhVb
   U7OLNlYjRU+YHcn/U24+kpkbXWCcJh2Arz0CoBD0Ca77sxwvGc4mZTr/O
   AQGQ2ufrs5RYU891hAfYk/F39M0yDtsmQwTNWHzpheCDe8oiwaCfaXHcJ
   Q==;
X-CSE-ConnectionGUID: 82CKIIoqSTyueEbF6zNBgA==
X-CSE-MsgGUID: 5EWsJr7EQ/SCzfLm0r2CbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314764"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:50 -0700
X-CSE-ConnectionGUID: rNoIwV5NQPubibAHNU+dKw==
X-CSE-MsgGUID: RIU0McnQTnad+acU2FtsEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004518"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: add RF name handling for PE chip type for debugfs
Date: Mon, 11 May 2026 20:36:17 +0300
Message-Id: <20260511203428.f49fbbe61925.I7e001558e66eb2c6c5081be7c21defe6a81aa265@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD6B8513975
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36242-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Implement RF name handling for PE chip type in debugfs,
including special case handling to show PETC when the
silicon is in Z step.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h             | 3 ++-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c  | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index f3fa37fee2e4..d2fa80a3dd04 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -366,6 +366,7 @@ enum {
 #define CSR_HW_RF_ID_TYPE_GF4		(0x0010E000)
 #define CSR_HW_RF_ID_TYPE_FM		(0x00112000)
 #define CSR_HW_RF_ID_TYPE_WP		(0x00113000)
+#define CSR_HW_RF_ID_TYPE_PE		(0x00114000)
 
 /* HW_RF CHIP STEP  */
 #define CSR_HW_RF_STEP(_val) (((_val) >> 8) & 0xF)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index a50e845cea42..87e5f79ccb3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-prph.h"
@@ -327,6 +327,13 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 		else
 			pos = scnprintf(buf, buflen, "WH");
 		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_PE):
+		if (SILICON_Z_STEP ==
+		    CSR_HW_RFID_STEP(trans->info.hw_rf_id))
+			pos = scnprintf(buf, buflen, "PETC");
+		else
+			pos = scnprintf(buf, buflen, "PE");
+		break;
 	default:
 		return;
 	}
-- 
2.34.1


