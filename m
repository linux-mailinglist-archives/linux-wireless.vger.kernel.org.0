Return-Path: <linux-wireless+bounces-39071-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oezSM9dCVmqY2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39071-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B1755887
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hi0h36jb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39071-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39071-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B580A31D9C9B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3EE47D927;
	Tue, 14 Jul 2026 14:03:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9747CC7E
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:03:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037798; cv=none; b=XStEWkWr1dwUR5R/mHsl91K2QSCagNOrgZOrSB78PBQMBzuC4uJTcC3ImP2DVuABvtaeYl9yX+mdDmNx3yyTdhSEMMqrO6KOONGs/UbWuKr5QyOQLYNTTSPqswZsXmQIb2VegGV4zpdaM07+XADo95GgfiG/b3W6zpRrbrGTyEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037798; c=relaxed/simple;
	bh=jTe98RMCDc8g+c2+R+2zJ6feGpdPamYg7BPuXTu2UpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ejzwi5Z239XXgegU3NJpz64i49WFgLkOtS5XMo0ARIT25u//8ICMkRnDZed/kMshzH1pIFCO5MlTMh2t6BbBMzlQYKB2TmVJRtz1kMLIj+OfBwXaGeCXneOPEH3rj1zcWJrNaltJyYx9NuHPyqNVn6tI5I7FaXHErbahVvJRmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hi0h36jb; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037796; x=1815573796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTe98RMCDc8g+c2+R+2zJ6feGpdPamYg7BPuXTu2UpI=;
  b=hi0h36jbvCuaQzoNxC93Yo5u2Ag5ieauZIC1XB0WfNf+5CLYdFstNItZ
   zAQPWlhiiPAHOhT2SBVU5Eae7Q3stYFXPh0NdgUKzw444LndLoRrpUNrb
   C9uSbw551VpYieYHtsAbXjuT0f8OhiuC/G2IYaJ4lJeJWBNKVYAlRh0Gk
   v5DavNvDla6vsYbPpUB6QWSWoKvZIi/T0EpBjTAxgRDUmBrR+9Bcnms0Y
   2XmWaPyw6oCfhMvXcp63/aIWN1ZOrCb0d7t7n5X8NWrzvaG5kCh4DQkRL
   6vh29dexcPV7NE+zEJWO285PuRo51q9Ll1AM3Z7GorU2soscKcXUMcRwr
   Q==;
X-CSE-ConnectionGUID: izfqyz51QyCGyLKbp/HA+g==
X-CSE-MsgGUID: 7MBdeEz8SG+GgJBndJ6ueA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855125"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855125"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:56 -0700
X-CSE-ConnectionGUID: gpnA3+RmSTSA+nIzfXthwA==
X-CSE-MsgGUID: zZJiAnIeT3qR1a/JGTHw0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737897"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 10/15] wifi: iwlwifi: pcie: validate txq_id in txq_enable
Date: Tue, 14 Jul 2026 17:02:13 +0300
Message-Id: <20260714165826.273be072f5ff.I0d6c36a4c06bdbb4655164c7792da32b6143731e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
References: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39071-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,changeid:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E0B1755887

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


