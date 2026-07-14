Return-Path: <linux-wireless+bounces-39039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6fQPLBEcVmoczQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E1753DB2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=aBP2kGma;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39039-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39039-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A243186088
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6CF377559;
	Tue, 14 Jul 2026 11:20:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7E373C12
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028043; cv=none; b=s2mP524jjuX0A6sUvQZ15sHEsvC2AcDD0oZYFBTT9arDWsG8QZAo/q2wKUIzUQbiww8Ybpzo8Z3NqSSr17jH6QCCXu8KHVSXT+SCLD0+KyJs/F5amU338jCcM8i8PTWfmnXahCqbR0LGOFTgFi1f39eUnQ96bYgLtrtQkbAsLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028043; c=relaxed/simple;
	bh=sZJO3Q6AV16jJqAiAnneh48VnsEZdfrUgItXbfQ0TjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkXQO7lTODoxv4q79sLBVkufDhNXlbPZF9HDSfvzkf8Mq8I9Kcs0wgh9Sroy/cnE3DXYsOyMCZ6/yvaktmKp7rbtp+/lqIRb6RHiYfg91UWNxk0cgeNXgJhQ/2xH7lUZ5FEzXPES8BrC4yFKE4RIZA1Dq+7RmuI1Q+6HrtuED3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBP2kGma; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028042; x=1815564042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sZJO3Q6AV16jJqAiAnneh48VnsEZdfrUgItXbfQ0TjE=;
  b=aBP2kGmaV3EGMC/gwuT9AruDI+0RIUXVXDIztLsWW8XQKiQnN6jE46Nn
   Hk1AFwfLe0H3TkKJZQquO6N4wq5syFCfs9614kiDCxmYKaMMJwBdyErui
   fuV4bIrrk6+25/Md3EbQMCzoQeM8EMPiZbSkHUMwbNTZ+cxkn4nTSNZn0
   NfxZotxT+7+KlIzD5UUM8obt7TdHA+Fx4PR1u77qBsjWHmi21KONUucDu
   dtgjolPWOiLq9Y8Ph0Phnr4jxHG9fAjYC/CpEbWK4tf3Z4elDV83A/Maw
   DCr/Le5ZqH9WTTH+hW3E4F04Feou1BDAOq2LSX57n3zHj1XOe15fjvvfQ
   Q==;
X-CSE-ConnectionGUID: s8eDl2VJTVyMfm1rI7HLFQ==
X-CSE-MsgGUID: 5nY4U7HARaGJ5wijKFNxPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200322"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200322"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:41 -0700
X-CSE-ConnectionGUID: JhejHvscQzuSnR4jjBl+tQ==
X-CSE-MsgGUID: KVmKJuypQVyq1ghccL9fZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250194"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 12/15] wifi: iwlwifi: mld: clear tzone on fail
Date: Tue, 14 Jul 2026 14:20:01 +0300
Message-Id: <20260714141909.595dcb8cb7fe.I8125e4a2eeb0390798e3f4074c62c00443eda8e8@changeid>
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
	TAGGED_FROM(0.00)[bounces-39039-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 304E1753DB2

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

iwl_mld_thermal_zone_register() stores the thermal zone pointer in
mld->tzone before calling thermal_zone_device_enable(). If enable
fails, the code unregisters the zone but leaves mld->tzone stale,
so iwl_mld_thermal_zone_unregister() can unregister it again.
Clear mld->tzone after unregister in the error path.

While at it remove a pointless if in iwl_mld_thermal_zone_unregister
after we've alredy checked the tzone pointer is not NULL.

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
index f8a8c35066be..e445b1d7d4b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifdef CONFIG_THERMAL
 #include <linux/sort.h>
@@ -272,6 +272,7 @@ static void iwl_mld_thermal_zone_register(struct iwl_mld *mld)
 	if (ret) {
 		IWL_DEBUG_TEMP(mld, "Failed to enable thermal zone\n");
 		thermal_zone_device_unregister(mld->tzone);
+		mld->tzone = NULL;
 	}
 }
 
@@ -385,10 +386,8 @@ static void iwl_mld_thermal_zone_unregister(struct iwl_mld *mld)
 		return;
 
 	IWL_DEBUG_TEMP(mld, "Thermal zone device unregister\n");
-	if (mld->tzone) {
-		thermal_zone_device_unregister(mld->tzone);
-		mld->tzone = NULL;
-	}
+	thermal_zone_device_unregister(mld->tzone);
+	mld->tzone = NULL;
 }
 
 static void iwl_mld_cooling_device_unregister(struct iwl_mld *mld)
-- 
2.34.1


