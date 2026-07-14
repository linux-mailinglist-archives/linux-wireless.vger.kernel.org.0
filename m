Return-Path: <linux-wireless+bounces-39052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AZIjGIEeVmq5zQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE24753EE2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lalEx2io;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39052-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39052-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76832300915A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098D35C19F;
	Tue, 14 Jul 2026 11:33:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8542380FEE
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028800; cv=none; b=SjhTkVu/GtonWYz2WklgGW6WLeNaXmh/b5Sh7aGI8MBuytdhadrg+BQQREV90tDd6YHIaxp0GkfAdEn+L4X3F6NZ5WHnhWMndZkY6PWm8srcMGmTEm3H+gNfq+5ctOwdTwHAwZN20X9yZ+ALIF+Q0l7LhanLUCqt2iOqvTFDEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028800; c=relaxed/simple;
	bh=jTe98RMCDc8g+c2+R+2zJ6feGpdPamYg7BPuXTu2UpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYrepHlnCRx8XW+StYcVNAXyKh+bUz3NTD6u4y6cAlfGl9/IJTmmPKz40Qte5TjN8kcwrgxEYotQWsgdSDYPGl387X7Di/bfjdtahb2eZLckn3dV2YV3QkYvZKd/4HKiqW8dFcfInc8DmlKbmdn7+yplIXNcVConQGyTNGVQfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lalEx2io; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028799; x=1815564799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTe98RMCDc8g+c2+R+2zJ6feGpdPamYg7BPuXTu2UpI=;
  b=lalEx2iobXa7RgYHJkjeBr9RtlRbWyeVME/nBvWkY0y9LsKXwMgeN4id
   CvpxVyIc8LkO3AUQid03QbEGjiM7DoJ8mhV8BnSAI9qr57JB7YjTW1R7w
   YRQTdpi61S3ArfpygTvYj9o7G7rwLKS1MnmyRWsiu+ElHu/lsOv+yhjg2
   6z5c9hseIbtOq5EIMiDwqOrjp1YKvmf2+cPZTeOlrKXbGQzavmKv+LIl2
   fxPtuVYTopKRavfojgcMbu1KP30K1Tz8bBd6RTMq1cLvoi5n7Je3CObCp
   BDICEDofx0xa+1zNzkX16V3jcHAX4vn9mTIzlltM+3xNCSC06KiwOfnfp
   A==;
X-CSE-ConnectionGUID: H1VI7nJsTmmd3tjElDJMdw==
X-CSE-MsgGUID: NST02gFtRAW6L0gnvUe1uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469602"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:18 -0700
X-CSE-ConnectionGUID: sBjfXIyST/a21e2E+//nNw==
X-CSE-MsgGUID: ePC15JYgRsWOjbdlbka/bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882959"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: pcie: validate txq_id in txq_enable
Date: Tue, 14 Jul 2026 14:32:36 +0300
Message-Id: <20260714143119.273be072f5ff.I0d6c36a4c06bdbb4655164c7792da32b6143731e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
References: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39052-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,changeid:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BE24753EE2

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Avoid indexing txq arrays and queue-used bitmaps with an
invalid queue ID by adding an early bounds check in
iwl_trans_pcie_txq_enable().

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index fdb3ba4f63c0..dc2fe0c4f68c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021, 2023-2025 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021, 2023-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1149,10 +1149,17 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 			       unsigned int wdg_timeout)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
+	struct iwl_txq *txq;
 	int fifo = -1;
 	bool scd_bug = false;
 
+	if (WARN_ONCE(txq_id < 0 ||
+		      txq_id >= trans->mac_cfg->base->num_of_queues,
+		      "queue %d out of range", txq_id))
+		return false;
+
+	txq = trans_pcie->txqs.txq[txq_id];
+
 	if (test_and_set_bit(txq_id, trans_pcie->txqs.queue_used))
 		WARN_ONCE(1, "queue %d already used - expect issues", txq_id);
 
-- 
2.34.1


