Return-Path: <linux-wireless+bounces-39043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NKL/GAwfVmrSzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:35:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA42753F1C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:35:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Z7FuIuGr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39043-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39043-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 991F530A10D0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4563E35C1BD;
	Tue, 14 Jul 2026 11:33:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6A351C25
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028787; cv=none; b=epNwoC1BHvFBVaDhNTDJbzcLP39D5RDBqpK9WSPB9Cxpl0DtEFXn7yZM/0avCEiVR8Z5Sd6qx0BceBziiT6Pf2PmQ0yvkxV9EIRjGU3FOThlamCGZ9TWd+4L+Yz5GbEIKxWlLVuD4IEV+rGP4hbFLUZHc/01RWG9zjwoPhvMtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028787; c=relaxed/simple;
	bh=lgdY2i2zY0yJXwsvhw/nNRTH7tXzSuNZr3zyw1eFAQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rW5ycssDpxlCM+HXmNcA3hO4f4VUM8nbML87N1ZmGg4t4d2MbTQA0oXXHxyyruGMDUWKMXRo7FmbJOVvgLNUaPbbNwSppMDgXVlklqIXSNXniddTxBQMShDWgpdNm1duBij3TO2Wu1gpnymHeveIn4K4PkLvleJLFPnuO3S1rN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7FuIuGr; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028785; x=1815564785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lgdY2i2zY0yJXwsvhw/nNRTH7tXzSuNZr3zyw1eFAQc=;
  b=Z7FuIuGrAC4TJd4MUeTGJ7ZuA8SP1D8UPZYZscPlLyOglprDmowCPE2S
   UuAOPyiNB30K4ZlSRIfNXNtL5gdexYPpfxe4FzRAqyyd7LtWXwPFX4mfx
   jMLlmrq8XCZchSMNLzhCP8KWlZAhyqxujO/I0dUf+qMt/9QOKSE1RvD3v
   3uJk/Imxd/hyeRF3ZoJWGr6+H/WcFsFQJfXwE6nlrMgiPmtJTVa4JFunC
   HVlil7BD2VulwtpO5MnnAk9g4HuxpKZAZ3lFW7CBKOTufzriosOreGpf5
   1VVyDsfNeq9rbWdtH19oIRDT8qZFdPdVLbEgMzZqhLv5A8QRNdm4ze0DW
   w==;
X-CSE-ConnectionGUID: y0FyC3ZDQeGuJ5WGKS92RQ==
X-CSE-MsgGUID: CYP7Qg8YQy+eF4QljQT+QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469567"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469567"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:04 -0700
X-CSE-ConnectionGUID: OIOqdPTlTSS8X9xitqdRCA==
X-CSE-MsgGUID: MOkqvTgOSey9EDasChslEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882901"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: add a compile time check for too long hcmds
Date: Tue, 14 Jul 2026 14:32:27 +0300
Message-Id: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39043-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:johannes.berg@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACA42753F1C

A host command that is bigger than the allowed payload length should be
sent with the NOCOPY flag. If it is sent without, we will get a warning.

We do know at compile time what is the maximum size of a hcmd payload that
the transport supports, so in order to catch bugs early,
add a compile time check to iwl_*_send_cmd_pdu to catch that.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h |  9 +++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 20 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  8 ++++----
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h b/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
index 64a8d4248324..19e1c9e509cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifndef __iwl_mld_hcmd_h__
 #define __iwl_mld_hcmd_h__
@@ -42,7 +42,12 @@ __iwl_mld_send_cmd_with_flags_pdu(struct iwl_mld *mld, u32 id,
 
 #define _iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, len,	\
 					 ignored...)			\
-	__iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, len)
+	({								\
+		BUILD_BUG_ON(__builtin_constant_p(len) &&		\
+			     (u16)(len) > IWL_MAX_CMD_PAYLOAD_SIZE);	\
+		__iwl_mld_send_cmd_with_flags_pdu(mld, id, flags,	\
+						  data, len);		\
+	})
 #define iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, len...)	\
 	_iwl_mld_send_cmd_with_flags_pdu(mld, id, flags, data, ##len,	\
 					 sizeof(*(data)))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 683cac56822c..1b56a2695bde 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1675,14 +1675,24 @@ u32 iwl_mvm_get_systime(struct iwl_mvm *mvm);
 /* Tx / Host Commands */
 int iwl_mvm_send_cmd(struct iwl_mvm *mvm,
 		     struct iwl_host_cmd *cmd);
-int iwl_mvm_send_cmd_pdu(struct iwl_mvm *mvm, u32 id,
-			 u32 flags, u16 len, const void *data);
+int _iwl_mvm_send_cmd_pdu(struct iwl_mvm *mvm, u32 id,
+			  u32 flags, u16 len, const void *data);
+#define iwl_mvm_send_cmd_pdu(mvm, id, flags, len, data) ({		\
+	BUILD_BUG_ON(__builtin_constant_p(len) &&			\
+		     (u16)(len) > IWL_MAX_CMD_PAYLOAD_SIZE);		\
+	_iwl_mvm_send_cmd_pdu(mvm, id, flags, len, data);		\
+})
 int iwl_mvm_send_cmd_status(struct iwl_mvm *mvm,
 			    struct iwl_host_cmd *cmd,
 			    u32 *status);
-int iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id,
-				u16 len, const void *data,
-				u32 *status);
+int _iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id,
+				 u16 len, const void *data,
+				 u32 *status);
+#define iwl_mvm_send_cmd_pdu_status(mvm, id, len, data, status) ({	\
+	BUILD_BUG_ON(__builtin_constant_p(len) &&			\
+		     (u16)(len) > IWL_MAX_CMD_PAYLOAD_SIZE);		\
+	_iwl_mvm_send_cmd_pdu_status(mvm, id, len, data, status);	\
+})
 int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta);
 int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 2e12f93ad32b..849342c96ae7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -73,8 +73,8 @@ int iwl_mvm_send_cmd(struct iwl_mvm *mvm, struct iwl_host_cmd *cmd)
 	return ret;
 }
 
-int iwl_mvm_send_cmd_pdu(struct iwl_mvm *mvm, u32 id,
-			 u32 flags, u16 len, const void *data)
+int _iwl_mvm_send_cmd_pdu(struct iwl_mvm *mvm, u32 id,
+			  u32 flags, u16 len, const void *data)
 {
 	struct iwl_host_cmd cmd = {
 		.id = id,
@@ -137,8 +137,8 @@ int iwl_mvm_send_cmd_status(struct iwl_mvm *mvm, struct iwl_host_cmd *cmd,
 /*
  * We assume that the caller set the status to the sucess value
  */
-int iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id, u16 len,
-				const void *data, u32 *status)
+int _iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id, u16 len,
+				 const void *data, u32 *status)
 {
 	struct iwl_host_cmd cmd = {
 		.id = id,
-- 
2.34.1


