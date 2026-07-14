Return-Path: <linux-wireless+bounces-39041-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5gk1FyEcVmoezQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39041-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:23:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E3F753DBB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:23:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JqyWoQmt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39041-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39041-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F8630A64AB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252D379996;
	Tue, 14 Jul 2026 11:20:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89A377559
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028046; cv=none; b=Hdiq+OTfDZtYPn4mwHHEaPB5K+R+iekNHgQQlNLd/tW84y6J7BORoNh+QgVAgNa7b/HGLnEvJMD962wVhW2VgH35ji7ddyoud7Hff+mQMAiSVND9oEAqKwiElvDQlIBe7C7Xu51KET8ZQIOnX4zVH46mq3iFqUpht6XTVzqfmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028046; c=relaxed/simple;
	bh=M6aMwbtEBKhXxZi9FQRfGKN86ZXyzmV83iO+KHscnNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxEqWEFsB52t3TUDG5l+DgpfIrckSW0TJpttIyxcwBuJHm9LoXrDSrcX2UZakze7l5t/hQijElroU+Nf/S3T0RUZq3Q8YGcjFywpu/HZFUmaFapnObt77oFVpgo97jkrbkds4f86ZOIlXjAQaPYvGJocv56/v0PQYF8QT3HfH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqyWoQmt; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028044; x=1815564044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6aMwbtEBKhXxZi9FQRfGKN86ZXyzmV83iO+KHscnNY=;
  b=JqyWoQmtg9YTpJHbQ5fbnqbuVp3dgVr9kNADvmXvT5RVWhA/jRm0/kel
   obnttLZJJcURtCTd8Z8isIMV9epmsEJJeQY+/WeAKWYk+qZuAJPxwAD6c
   6OfQfsu//XPUuP+krpo1Nl5ySpATrnvIbqTZDI9SxHLam/Z1T8PDveSz/
   IAhDmiP7Orig24f0h6mN1c6Jw7kV2Jw7EvWn5X/PnCd68uo/+Fb7YQYtG
   r4qaSepwCRZ0J8fYhDEQ8uc5HRuXJ+ePOh/geLqK1/FJI+Tn7MIXRtRJh
   OhEPIu1dPoJNRdAqrFnY0MxK4bqDNnXIBwTq+vSwz3++6fWWcEuhlAz9d
   A==;
X-CSE-ConnectionGUID: rQ86pojaTKCmictqyc8edA==
X-CSE-MsgGUID: kk5sj3YzQHq5HbRYOISeYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200326"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:44 -0700
X-CSE-ConnectionGUID: G0e0Eb4VSOqaIXXPuVcSKg==
X-CSE-MsgGUID: jaHgNzPnTMyBNPED7WrMrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250204"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 14/15] wifi: iwlwifi: pcie: null RX pointers after free
Date: Tue, 14 Jul 2026 14:20:03 +0300
Message-Id: <20260714141909.33e8978d8b36.Ibaedd4b0ce01405b940de7b90223b6d2c5136ffd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
References: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
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
	TAGGED_FROM(0.00)[bounces-39041-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2E3F753DBB

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When iwl_pcie_tx_init() fails after RX init, nic init unwinds via
iwl_pcie_rx_free().

The freed RX members stayed non-NULL on the live transport object,
so later teardown or retry could touch stale RX state.
Set rx_pool, global_table, rxq, and alloc_page to NULL after free
to make repeated cleanup and retry paths safe.

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
index fe263cdc2e4f..4631e11f2a96 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2024, 2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1238,11 +1238,16 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 		}
 	}
 	kfree(trans_pcie->rx_pool);
+	trans_pcie->rx_pool = NULL;
 	kfree(trans_pcie->global_table);
+	trans_pcie->global_table = NULL;
 	kfree(trans_pcie->rxq);
+	trans_pcie->rxq = NULL;
 
-	if (trans_pcie->alloc_page)
+	if (trans_pcie->alloc_page) {
 		__free_pages(trans_pcie->alloc_page, trans_pcie->rx_page_order);
+		trans_pcie->alloc_page = NULL;
+	}
 }
 
 static void iwl_pcie_rx_move_to_allocator(struct iwl_rxq *rxq,
-- 
2.34.1


