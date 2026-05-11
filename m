Return-Path: <linux-wireless+bounces-36244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJfHA7oaAmofoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:06:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56233514113
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 434DE31DD265
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2946935958;
	Mon, 11 May 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVC1Xsug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6043B4E9A
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521015; cv=none; b=QA48fzeeT25DKHuHpHIu7TeKBQRxhCgXlvDBAJJHgPxPJK7MDPmP1P14wnZ3ngqXHPqigxqJI6Zjh19tgq3U8K/eMzR3xKN9ahvxgqVz2pYa5hyMkAtuYKqjq67Qb1b89b2518nw8aLhJMF82C6BJ3sTh56hUY9+dWaIEfsJvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521015; c=relaxed/simple;
	bh=cQyr0cUqZeZnDxUc//o5E1nebVxLFsvoOwDLFCQvlRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCkGjGtm4s8ElxvPDlqi84Zer0F2NR5ucdJxS0zj4sqhj9qvz1ZlJvqkSZd3O+HjKzqw+B1bwv5jgKkcsyKoxcXslmYEe4AMADTagYw07MWdWKS15fJQA82ErF2VJSHft36e5kDb402H3flgoqsXvYFN0gE1dJ3UZpat+Cz/zoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVC1Xsug; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521014; x=1810057014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQyr0cUqZeZnDxUc//o5E1nebVxLFsvoOwDLFCQvlRw=;
  b=kVC1XsugEaNcXuGfJiJ8BtP4oylqevpuqo4HNcGsEESR2FHEWgzyHDtr
   ehlU8qecA7Z65V7eMk8iKwIdD+MiFY66P3e78ohwGZql+n3zWPRNZJ993
   bS9rDgFxGTsLmsY9/AMv/Tf2iegWSrd0deUK5eJMoF5xTwGWWXTYDLrQ1
   rIbwklE9HKXXyc1SHd+eRwFMgB0E5ZNfShMCNCmmbp38dGGL7yS6gpOLm
   c8racds17qfQAIqIUvxLia24Vo5tDT5j7K5y84Z109Bpg43yMk2CZiJck
   iMp0zJxe/FZdE9I08H5T3C3nxwn16/mX5pkPdpP/nvReAeM0FqoRVKXrA
   g==;
X-CSE-ConnectionGUID: T9m5YXGNTUOkA9uSbIliIw==
X-CSE-MsgGUID: sH/KvMV5Qq6E20gmeSyR6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314775"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314775"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:53 -0700
X-CSE-ConnectionGUID: IfZ2fC7hTIuDzKIAB2zE+w==
X-CSE-MsgGUID: 5LibCFgwQZeRoAbWmJTpMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004627"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: fix the access to CNVR TOP registers
Date: Mon, 11 May 2026 20:36:19 +0300
Message-Id: <20260511203428.09778340db51.I28d678ad404bbf8068f139666d38e29be5aa063b@changeid>
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
X-Rspamd-Queue-Id: 56233514113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36244-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

For Dr and Sc, we need to wait until the TOP is ready to gets its
registers read by the host.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 18 ++++++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |  4 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  7 ++++-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 26 ++++++++++++++++++-
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index b1944584c693..c4ccfffdf6af 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2022, 2024-2025 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2022, 2024-2026 Intel Corporation
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
 #include <linux/device.h>
@@ -168,6 +168,22 @@ int iwl_poll_prph_bit(struct iwl_trans *trans, u32 addr,
 	return -ETIMEDOUT;
 }
 
+int iwl_poll_umac_prph_bits_no_grab(struct iwl_trans *trans, u32 addr,
+				    u32 bits, u32 mask, int timeout)
+{
+	int t = 0;
+
+	do {
+		if ((iwl_read_umac_prph_no_grab(trans, addr) & mask) ==
+		    (bits & mask))
+			return 0;
+		udelay(IWL_POLL_INTERVAL);
+		t += IWL_POLL_INTERVAL;
+	} while (t < timeout);
+
+	return -ETIMEDOUT;
+}
+
 void iwl_set_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask)
 {
 	if (iwl_trans_grab_nic_access(trans)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index 5bcec239ffc4..d920a32fc173 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2021, 2025 Intel Corporation
+ * Copyright (C) 2018-2021, 2025-2026 Intel Corporation
  */
 #ifndef __iwl_io_h__
 #define __iwl_io_h__
@@ -51,6 +51,8 @@ static inline void iwl_write_prph(struct iwl_trans *trans, u32 ofs, u32 val)
 
 int iwl_poll_prph_bit(struct iwl_trans *trans, u32 addr,
 		      u32 bits, u32 mask, int timeout);
+int iwl_poll_umac_prph_bits_no_grab(struct iwl_trans *trans, u32 addr,
+				    u32 bits, u32 mask, int timeout);
 void iwl_set_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask);
 void iwl_set_bits_mask_prph(struct iwl_trans *trans, u32 ofs,
 			    u32 bits, u32 mask);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index a7214ddcfaf5..6ca1f51b69a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -411,6 +411,11 @@ enum {
 #define HPM_SECONDARY_DEVICE_STATE      0xa03404
 #define WFPM_MAC_OTP_CFG7_ADDR		0xa03338
 #define WFPM_MAC_OTP_CFG7_DATA		0xa0333c
+#define WFPM_RSRCS_4PHS_REQ_STTS	0xa033f8
+#define WFPM_RSRCS_4PHS_ACK_STTS	0xa033fc
+
+#define RSRC_REQ_CNVR_TOP BIT(6)
+#define RSRC_ACK_CNVR_TOP BIT(6)
 
 
 /* For UMAG_GEN_HW_STATUS reg check */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index a05f60f9224b..377b2e30b540 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2007-2015, 2018-2024 Intel Corporation
+ * Copyright (C) 2007-2015, 2018-2024, 2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -4000,6 +4000,30 @@ static void get_crf_id(struct iwl_trans *iwl_trans,
 	else
 		sd_reg_ver_addr = SD_REG_VER;
 
+	/* wait until the device is ready to access the prph registers */
+	if (iwl_trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_DR ||
+	    iwl_trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_SC) {
+		u32 req = iwl_read_umac_prph_no_grab(iwl_trans,
+						     WFPM_RSRCS_4PHS_REQ_STTS);
+		int ret;
+
+		if (!(req & RSRC_REQ_CNVR_TOP)) {
+			IWL_ERR(iwl_trans,
+				"WFPM_RSRCS_4PHS_REQ_STTS bit 6 is clear 0x%x\n",
+				req);
+			return;
+		}
+
+		ret = iwl_poll_umac_prph_bits_no_grab(iwl_trans,
+						      WFPM_RSRCS_4PHS_ACK_STTS,
+						      RSRC_ACK_CNVR_TOP,
+						      RSRC_ACK_CNVR_TOP,
+						      50 * 1000);
+		if (ret < 0)
+			IWL_ERR(iwl_trans,
+				"WFPM_RSRCS_4PHS_ACK_STTS bit 6 is clear\n");
+	}
+
 	/* Enable access to peripheral registers */
 	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
 	val |= WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK;
-- 
2.34.1


