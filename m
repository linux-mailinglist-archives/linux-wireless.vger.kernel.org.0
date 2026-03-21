Return-Path: <linux-wireless+bounces-33641-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HxQIQrWvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33641-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:31:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16C2E68DE
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A402F301E947
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B933C528;
	Sat, 21 Mar 2026 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN4hiDQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E83368A5
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114192; cv=none; b=ZuU6nLfCZKKlAc8HXbcUSwpsccDU53CVd3rkkk1ajb4xP6LnIlKzhcQVcuVIu6BloxY5Cmhe2J4qbdheV4lJ5mWiF+xvgKTl7zsWqCl9/RISbGE7Fye63HBprRaYdmwQ49xN8JlfnUWUvlr2ZN8dvZZBo+qAYXfIlh/v3Rb8O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114192; c=relaxed/simple;
	bh=Vbpc/yC603n2kDA1IpsXNn1zd0x2CweGzgmWcJl8ilI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrVL4K82aUfaH1TayVcsFrdnm7cUqcUCk7u9pu3/XFHmb5e45nInZ4fwP1e2qE2hHznx0O8wdphRSpInWp5t+Xl7v20kvUbK8HSbkutf68dXwMLKyxeIt1fh2EKlWksqxnl+R+R96ZGEKtr7g4KN2pSn0b7CK115v+HMaADd+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN4hiDQi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114191; x=1805650191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vbpc/yC603n2kDA1IpsXNn1zd0x2CweGzgmWcJl8ilI=;
  b=YN4hiDQiPYvg2MjlsZYOPnlnp0jtKHLk0sdpBevrOVlxKkawfgzNqzoH
   WQqEJxjsuHDoY9rp7PHpDyBzvzYFDUdePQvl7kRvG1jezi6krmRSSNJtD
   1n8jq02EChnUTtD8R9U14bBxdIfvVpQpLrrR3vXGRbMTpEcpFRujPseOR
   0cmM+d3nN2jWNi6VZmvm0aNO/2rz+pOH+S9QlOk1QYFgTs+MQ4e9BTS9h
   L3VDfIPM0dZllEhYqXbY3yAzvynjoiLWAV32arRijQFZYpE+BbD3EQQgh
   bVHnWjOSTcLIC595zP/ZP3S4K7YaKRHXXUhjfZ6XNV9VJAoGKC2xdC7dF
   Q==;
X-CSE-ConnectionGUID: gWYHmAIySjSaB2NjzE6D2w==
X-CSE-MsgGUID: 8vFJsSIlSwyh50reh/tQow==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244598"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244598"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:51 -0700
X-CSE-ConnectionGUID: lrLVh7PUQqafpAYJH6X2iQ==
X-CSE-MsgGUID: Nr7RQLfgTu+evyuERVIymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813615"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Eilon Rinat <eilon.rinat@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: reduce the number of prints upon firmware crash
Date: Sat, 21 Mar 2026 19:29:21 +0200
Message-Id: <20260321192637.3bb8b142ff48.Ieacb12bf3bc930a4c28824e31d8e06eda177ba78@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33641-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: DE16C2E68DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When the firmware crashes, we print data to be able to know what
happened. The problem is that those prints became excessive as during
the course of the years, we added more data without ever removing the
prints that were no longer useful.
Instead of spamming the log with data that will not help anyone, limit
the prints to what is really needed.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Eilon Rinat <eilon.rinat@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 69 +-------------------
 1 file changed, 1 insertion(+), 68 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index ddd714cff2f4..c2af66899a78 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -128,19 +128,11 @@ static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
 
 	IWL_ERR(fwrt, "0x%08X | %s\n", table.error_id,
 		iwl_fw_lookup_assert_desc(table.error_id));
-	IWL_ERR(fwrt, "0x%08X | umac branchlink1\n", table.blink1);
-	IWL_ERR(fwrt, "0x%08X | umac branchlink2\n", table.blink2);
-	IWL_ERR(fwrt, "0x%08X | umac interruptlink1\n", table.ilink1);
 	IWL_ERR(fwrt, "0x%08X | umac interruptlink2\n", table.ilink2);
 	IWL_ERR(fwrt, "0x%08X | umac data1\n", table.data1);
 	IWL_ERR(fwrt, "0x%08X | umac data2\n", table.data2);
 	IWL_ERR(fwrt, "0x%08X | umac data3\n", table.data3);
-	IWL_ERR(fwrt, "0x%08X | umac major\n", table.umac_major);
-	IWL_ERR(fwrt, "0x%08X | umac minor\n", table.umac_minor);
-	IWL_ERR(fwrt, "0x%08X | frame pointer\n", table.frame_pointer);
-	IWL_ERR(fwrt, "0x%08X | stack pointer\n", table.stack_pointer);
 	IWL_ERR(fwrt, "0x%08X | last host cmd\n", table.cmd_header);
-	IWL_ERR(fwrt, "0x%08X | isr status reg\n", table.nic_isr_pref);
 }
 
 static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_num)
@@ -200,39 +192,10 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 
 	IWL_ERR(fwrt, "0x%08X | %-28s\n", table.error_id,
 		iwl_fw_lookup_assert_desc(table.error_id));
-	IWL_ERR(fwrt, "0x%08X | trm_hw_status0\n", table.trm_hw_status0);
-	IWL_ERR(fwrt, "0x%08X | trm_hw_status1\n", table.trm_hw_status1);
-	IWL_ERR(fwrt, "0x%08X | branchlink2\n", table.blink2);
-	IWL_ERR(fwrt, "0x%08X | interruptlink1\n", table.ilink1);
 	IWL_ERR(fwrt, "0x%08X | interruptlink2\n", table.ilink2);
 	IWL_ERR(fwrt, "0x%08X | data1\n", table.data1);
 	IWL_ERR(fwrt, "0x%08X | data2\n", table.data2);
 	IWL_ERR(fwrt, "0x%08X | data3\n", table.data3);
-	IWL_ERR(fwrt, "0x%08X | beacon time\n", table.bcon_time);
-	IWL_ERR(fwrt, "0x%08X | tsf low\n", table.tsf_low);
-	IWL_ERR(fwrt, "0x%08X | tsf hi\n", table.tsf_hi);
-	IWL_ERR(fwrt, "0x%08X | time gp1\n", table.gp1);
-	IWL_ERR(fwrt, "0x%08X | time gp2\n", table.gp2);
-	IWL_ERR(fwrt, "0x%08X | uCode revision type\n", table.fw_rev_type);
-	IWL_ERR(fwrt, "0x%08X | uCode version major\n", table.major);
-	IWL_ERR(fwrt, "0x%08X | uCode version minor\n", table.minor);
-	IWL_ERR(fwrt, "0x%08X | hw version\n", table.hw_ver);
-	IWL_ERR(fwrt, "0x%08X | board version\n", table.brd_ver);
-	IWL_ERR(fwrt, "0x%08X | hcmd\n", table.hcmd);
-	IWL_ERR(fwrt, "0x%08X | isr0\n", table.isr0);
-	IWL_ERR(fwrt, "0x%08X | isr1\n", table.isr1);
-	IWL_ERR(fwrt, "0x%08X | isr2\n", table.isr2);
-	IWL_ERR(fwrt, "0x%08X | isr3\n", table.isr3);
-	IWL_ERR(fwrt, "0x%08X | isr4\n", table.isr4);
-	IWL_ERR(fwrt, "0x%08X | last cmd Id\n", table.last_cmd_id);
-	IWL_ERR(fwrt, "0x%08X | wait_event\n", table.wait_event);
-	IWL_ERR(fwrt, "0x%08X | l2p_control\n", table.l2p_control);
-	IWL_ERR(fwrt, "0x%08X | l2p_duration\n", table.l2p_duration);
-	IWL_ERR(fwrt, "0x%08X | l2p_mhvalid\n", table.l2p_mhvalid);
-	IWL_ERR(fwrt, "0x%08X | l2p_addr_match\n", table.l2p_addr_match);
-	IWL_ERR(fwrt, "0x%08X | lmpm_pmg_sel\n", table.lmpm_pmg_sel);
-	IWL_ERR(fwrt, "0x%08X | timestamp\n", table.u_timestamp);
-	IWL_ERR(fwrt, "0x%08X | flow_handler\n", table.flow_handler);
 }
 
 /*
@@ -264,7 +227,6 @@ static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 	struct iwl_trans *trans = fwrt->trans;
 	struct iwl_tcm_error_event_table table = {};
 	u32 base = fwrt->trans->dbg.tcm_error_event_table[idx];
-	int i;
 	u32 flag = idx ? IWL_ERROR_EVENT_TABLE_TCM2 :
 			 IWL_ERROR_EVENT_TABLE_TCM1;
 
@@ -275,23 +237,10 @@ static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 
 	IWL_ERR(fwrt, "TCM%d status:\n", idx + 1);
 	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
-	IWL_ERR(fwrt, "0x%08X | tcm branchlink2\n", table.blink2);
-	IWL_ERR(fwrt, "0x%08X | tcm interruptlink1\n", table.ilink1);
 	IWL_ERR(fwrt, "0x%08X | tcm interruptlink2\n", table.ilink2);
 	IWL_ERR(fwrt, "0x%08X | tcm data1\n", table.data1);
 	IWL_ERR(fwrt, "0x%08X | tcm data2\n", table.data2);
 	IWL_ERR(fwrt, "0x%08X | tcm data3\n", table.data3);
-	IWL_ERR(fwrt, "0x%08X | tcm log PC\n", table.logpc);
-	IWL_ERR(fwrt, "0x%08X | tcm frame pointer\n", table.frame_pointer);
-	IWL_ERR(fwrt, "0x%08X | tcm stack pointer\n", table.stack_pointer);
-	IWL_ERR(fwrt, "0x%08X | tcm msg ID\n", table.msgid);
-	IWL_ERR(fwrt, "0x%08X | tcm ISR status\n", table.isr);
-	for (i = 0; i < ARRAY_SIZE(table.hw_status); i++)
-		IWL_ERR(fwrt, "0x%08X | tcm HW status[%d]\n",
-			table.hw_status[i], i);
-	for (i = 0; i < ARRAY_SIZE(table.sw_status); i++)
-		IWL_ERR(fwrt, "0x%08X | tcm SW status[%d]\n",
-			table.sw_status[i], i);
 }
 
 /*
@@ -338,26 +287,10 @@ static void iwl_fwrt_dump_rcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 
 	IWL_ERR(fwrt, "RCM%d status:\n", idx + 1);
 	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
-	IWL_ERR(fwrt, "0x%08X | rcm branchlink2\n", table.blink2);
-	IWL_ERR(fwrt, "0x%08X | rcm interruptlink1\n", table.ilink1);
 	IWL_ERR(fwrt, "0x%08X | rcm interruptlink2\n", table.ilink2);
 	IWL_ERR(fwrt, "0x%08X | rcm data1\n", table.data1);
 	IWL_ERR(fwrt, "0x%08X | rcm data2\n", table.data2);
 	IWL_ERR(fwrt, "0x%08X | rcm data3\n", table.data3);
-	IWL_ERR(fwrt, "0x%08X | rcm log PC\n", table.logpc);
-	IWL_ERR(fwrt, "0x%08X | rcm frame pointer\n", table.frame_pointer);
-	IWL_ERR(fwrt, "0x%08X | rcm stack pointer\n", table.stack_pointer);
-	IWL_ERR(fwrt, "0x%08X | rcm msg ID\n", table.msgid);
-	IWL_ERR(fwrt, "0x%08X | rcm ISR status\n", table.isr);
-	IWL_ERR(fwrt, "0x%08X | frame HW status\n", table.frame_hw_status);
-	IWL_ERR(fwrt, "0x%08X | LMAC-to-RCM request mbox\n",
-		table.mbx_lmac_to_rcm_req);
-	IWL_ERR(fwrt, "0x%08X | RCM-to-LMAC request mbox\n",
-		table.mbx_rcm_to_lmac_req);
-	IWL_ERR(fwrt, "0x%08X | MAC header control\n", table.mh_ctl);
-	IWL_ERR(fwrt, "0x%08X | MAC header addr1 low\n", table.mh_addr1_lo);
-	IWL_ERR(fwrt, "0x%08X | MAC header info\n", table.mh_info);
-	IWL_ERR(fwrt, "0x%08X | MAC header error\n", table.mh_err);
 }
 
 static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
-- 
2.34.1


