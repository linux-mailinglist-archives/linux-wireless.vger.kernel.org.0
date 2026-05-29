Return-Path: <linux-wireless+bounces-37097-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PwqCMErGWogrwgAu9opvQ
	(envelope-from <linux-wireless+bounces-37097-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:01:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 763625FDAFF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91DB311E793
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BEB3A9DA1;
	Fri, 29 May 2026 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCY6Rc1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84D3A2544
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034249; cv=none; b=GCImmvHQOqkj893X2JPfblKk+Xk5qpUw1T8XUNu4umTdPbk6lMav3NKGllOoUKbyRSmkS+tt7Dm1DDvABCGJpIMskLROudrLhSlPy8fcN/Lc6R41pyTntYpwZ6VI4lKKLPptM8M1sgekhyvhET69721NNcJablWdvC/F9pTmODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034249; c=relaxed/simple;
	bh=mBKDbSD9Q5oavZDJJQQd0Azsv/gL5g5FlEd+/+Dtc+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvk1d1HsltxNnVg5HAfUmR1ol+tVK3ra4EkrmB50unKXJDBuxAlWrWcviDZ6+62dX/1QU68PJYe+k6DMSDMziBxpAVP0WeoYsQ6c2i0wFEHtABC6bzfoxHS9KUS04VxxINw3pydcI49OCeb7RAeaQ5RD0p1qe2o22SA88WbMmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCY6Rc1k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780034246; x=1811570246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mBKDbSD9Q5oavZDJJQQd0Azsv/gL5g5FlEd+/+Dtc+8=;
  b=bCY6Rc1kKhGXFwNmMGQg8loENJsnpibOPn2VUhSRWmGkSRuZAANuNN8u
   1J7YBc9wjUrtHJW896FKl15CmQNo/UHQmlk36Ebk7K5CjfEnVTi5Fhmv3
   iy5140W+ciNXq0hP79FeAo+mfGxdPFmY+troS5G77THYHkORB4UNhK+vA
   mJd8SqhwpxPzvAyfQJPB1+tX8eIob/UY/z0cZGBombC9LHHnIGSzHbkml
   9d0OL/PG0pffTrnUG5CEHIdkmbkxEi/LeRjP3yJH9tr6m/64gvy3snfLB
   DRukaHEye8tCTTofmqI+R8TxnpVkOohuxJXqfMiFmL6SYT/rDAOGQ9eGE
   A==;
X-CSE-ConnectionGUID: u4cYtsuiTA+dtIOlpEH98A==
X-CSE-MsgGUID: qshLwQoiQMelPpsu3rOUyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84741134"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="84741134"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:57:26 -0700
X-CSE-ConnectionGUID: yga5G9lZRKufVSRbrRDN6A==
X-CSE-MsgGUID: kSrGT8CiRv+KGjnldmNIzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="238572742"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:57:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 wireless-fixes 3/3] wifi: iwlwifi: mvm: avoid oversized UATS command copy
Date: Fri, 29 May 2026 08:57:07 +0300
Message-Id: <20260529085453.9af349ab459b.I348df3980764c15efce0099a35fe8a88fb2a6ee2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529055707.24862-1-miriam.rachel.korenblit@intel.com>
References: <20260529055707.24862-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37097-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 763625FDAFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

MCC_ALLOWED_AP_TYPE_CMD exceeds the fixed copied host-command buffer
and triggers warnings in the gen2 enqueue path when command
0xc05 is sent.

Use IWL_HCMD_DFL_NOCOPY as it was done before the offending commit.

Fixes: 078df640ef05 ("wifi: iwlwifi: mld: add support for iwl_mcc_allowed_ap_type_cmd v2")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 26 +++++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f05df3a3300e..6e507d6dcdd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -459,9 +459,14 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 
 static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 {
+	struct iwl_mcc_allowed_ap_type_cmd_v1 *cmd __free(kfree) = NULL;
 	int cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
 			     MCC_ALLOWED_AP_TYPE_CMD);
-	struct iwl_mcc_allowed_ap_type_cmd_v1 cmd = {};
+	struct iwl_host_cmd hcmd = {
+		.id = cmd_id,
+		.len[0] = sizeof(*cmd),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
 	u8 cmd_ver;
 	int ret;
 
@@ -485,14 +490,25 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 	if (!mvm->fwrt.ap_type_cmd_valid)
 		return;
 
+	/* Since we free the command immediately after iwl_mvm_send_cmd, we
+	 * must send this command in SYNC mode.
+	 */
+	lockdep_assert_held(&mvm->mutex);
+
+	cmd = kzalloc_obj(*cmd);
+	if (!cmd)
+		return;
+
 	BUILD_BUG_ON(sizeof(mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map) !=
-		     sizeof(cmd.mcc_to_ap_type_map));
+		     sizeof(cmd->mcc_to_ap_type_map));
 
-	memcpy(cmd.mcc_to_ap_type_map,
+	memcpy(cmd->mcc_to_ap_type_map,
 	       mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map,
 	       sizeof(mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map));
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+	hcmd.data[0] = cmd;
+
+	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (ret < 0)
 		IWL_ERR(mvm, "failed to send MCC_ALLOWED_AP_TYPE_CMD (%d)\n",
 			ret);
-- 
2.34.1


