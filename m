Return-Path: <linux-wireless+bounces-39036-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XVVZKfkbVmoWzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39036-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E0753DAA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="EFf6Q/2e";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39036-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39036-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A05C316C783
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BEF37B007;
	Tue, 14 Jul 2026 11:20:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA5367F4A
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028038; cv=none; b=hG48GJdu39Z6GmwLoCgDBe4IGKDsM2SWsLM+NyKhUVm0plhuYlUNTEFUyblST9qnbmnXjbcNsXti1NpuQ/KNXxZr6m3wfrXm9U73X42YlSQhaHqUEozMpnpZLSpDfGQ69ioRSRF7jdsjU+dYOAPYIKQWyOkoHGXGCwYu754WEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028038; c=relaxed/simple;
	bh=4Y8l9RDcugHabcA+kBrY0awnpggWc1o383GwblSjUoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mry7vo2umzQ0j/cjYfbQrjkJGygnc0rLvyMGspRis2A7UnGX1uymJ2CLef1M/lP329G8Pp0CxGv1oCfRRGCZPqfLGv2guDWEzpQ+bPZ+xj3Dom5mydLEIxWQMThV3sBK758q1srqmzpG1RcIQNgGYURbJYwXSKDFWAg6dRIRTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFf6Q/2e; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028037; x=1815564037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Y8l9RDcugHabcA+kBrY0awnpggWc1o383GwblSjUoo=;
  b=EFf6Q/2eaCFA/NnBcgZZu3bjbCCRAi5Z3pQ4V7tvgFx+jYh0RHoGdnkn
   4xJXtohENrLRgSIgYT4Gbqbm/A5wAkNj88OFo1OEjdPYHYx/0fnBT3RqU
   STxTLdI8OtOg+lB1UbH4ZPNuZ6k0QLHA56LDS7PwUp14JnbASlGrpIZLv
   n3cWMnosDlaFec0es8PthIhfO0Ka5PmLP06qN6FTNcDoHNY/S9Gma9n6A
   J+97HkrdMxYQgh3AKjx1VpOgf7PxooJ4ttB3XeaDh8JHHcy2c9KDCpsDV
   wCOfbQTRUY9on1aslPpf32X/mBGqCeEJ/86K6wqwlj9sCPWi9Wxx5MjVA
   A==;
X-CSE-ConnectionGUID: vv3HQHkgReC1FsZF51VnJg==
X-CSE-MsgGUID: 38O+OH7cTRS6/TfJVkSW5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200315"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200315"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:37 -0700
X-CSE-ConnectionGUID: 4lH8pjM3QueSpIRpjjcrRw==
X-CSE-MsgGUID: VJVAm+JxQSikyQvMq/4UwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250179"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 09/15] wifi: iwlwifi: mvm: validate sta_id in TLC notif
Date: Tue, 14 Jul 2026 14:19:58 +0300
Message-Id: <20260714141909.1ce54794c1f8.I275fd4c1165bf42fb17516c550dd8813a2b8286e@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39036-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 050E0753DAA

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

TLC_MNG_UPDATE_NOTIF uses firmware-provided sta_id to index
fw_id_to_link_sta[] and fw_id_to_mac_id[]. Validate sta_id
before array access to avoid out-of-bounds indexing.

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 89ac4c6b3e54..e2382be8edd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include "rs.h"
 #include "fw-api.h"
@@ -423,9 +423,14 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	struct iwl_lq_sta_rs_fw *lq_sta;
 	u32 flags;
 
+	notif = (void *)pkt->data;
+	if (IWL_FW_CHECK(mvm, notif->sta_id >= mvm->fw->ucode_capa.num_stations,
+			 "Invalid sta id (%d) in TLC notification\n",
+			 notif->sta_id))
+		return;
+
 	rcu_read_lock();
 
-	notif = (void *)pkt->data;
 	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[notif->sta_id]);
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[notif->sta_id]);
 	if (IS_ERR_OR_NULL(sta) || !link_sta) {
-- 
2.34.1


