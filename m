Return-Path: <linux-wireless+bounces-39033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dmOUJOAbVmoRzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4318753D9C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=boV32HZX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39033-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39033-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D082A3149FA0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27A367F4A;
	Tue, 14 Jul 2026 11:20:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D5379996
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028034; cv=none; b=JtfnuttegVREzli8dZ4p63zyu+Cz2bUTgit6N2+GCJOyUYB+cqonnCRgBWRlhSyyL/pvgMj2cGOXhBWJBRw8Y2yFgj8dHgVGZKdU0rYxB05MbHzJPPPRMVlorUeCHMPR3ClYod9BP3lWHONCza5A8/uPuR9RYPopbBpXbk6BNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028034; c=relaxed/simple;
	bh=jlYU0vAqDOuc6bus3o5RYNWl9AcxqEMoHa1l2ohgxXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkEwWXWP9I0EHIcdt+auYBrYA7O9aXBhj+SjIR246yMUG8ZJf0pbZEwmY9sptN9Ik7gG6pfLU5iMrm3fQGpGlBV7HfZd/v8siywYCyoihzs0dng2RClyZVyE1PvK8vhPGLgIqOT5hzpBGVGof3WdJyXQ4aQfm/LHhZ8TvkYH0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boV32HZX; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028033; x=1815564033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jlYU0vAqDOuc6bus3o5RYNWl9AcxqEMoHa1l2ohgxXk=;
  b=boV32HZXYQ0BfPoGp1LIwkXZWIV5MelDVj+otQ9mgE11W/lygeQ2nONs
   QvMItELgIJwmc3dzvx9REhe9CPnOeZenjM/Ils8LjGzceMq1d260EeSi4
   KwWDkqbkvuDi9rZkwF2xz3edi6CRIT148xFj8NCKPGxCeZE91NAX3lb4t
   vzayZOSzgJ25GNzRyZsxEPDEVS5aLb3iM+WOr7rAM8Xic9ujKz/2YKjS6
   zomLOtfBuu7+hxZakTDM99Mf077vrkSXPvzh2ggGLKNatuW2Ivaxa14I5
   xNexn8lb25PtZfy/x01UVdoocz0q9MudBTrP3o2SkQl2xHU4VXV5gcncd
   w==;
X-CSE-ConnectionGUID: 5Ue9OKAsSZWSxZvoEfKCnw==
X-CSE-MsgGUID: 4PJdg3LxTkW3cc2/bkvPEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200308"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200308"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:33 -0700
X-CSE-ConnectionGUID: FPmcl//ERsC0SjU0R05NKA==
X-CSE-MsgGUID: 6bUv9Q+1Smaz25IqUaXAhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250162"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 06/15] wifi: iwlwifi: mld: validate reorder BAID
Date: Tue, 14 Jul 2026 14:19:55 +0300
Message-Id: <20260714141909.07ea823b8eea.Ica915fa0cce0427bf5e3420ae933f57118fedf86@changeid>
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
	TAGGED_FROM(0.00)[bounces-39033-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4318753D9C

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Reject BAIDs >= IWL_MAX_BAID before indexing fw_id_to_ba.

This prevents out-of-bounds access on malformed notifications.

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index e3627ad0321c..a464ebdec57f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include "agg.h"
 #include "sta.h"
@@ -222,6 +222,11 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 	if (baid == IWL_RX_REORDER_DATA_INVALID_BAID)
 		return IWL_MLD_PASS_SKB;
 
+	if (IWL_FW_CHECK(mld, baid >= ARRAY_SIZE(mld->fw_id_to_ba),
+			 "Got out-of-range BAID %u in reorder_data=0x%x\n",
+			 baid, reorder))
+		return IWL_MLD_PASS_SKB;
+
 	/* no sta yet */
 	if (WARN_ONCE(!sta,
 		      "Got valid BAID without a valid station assigned\n"))
-- 
2.34.1


