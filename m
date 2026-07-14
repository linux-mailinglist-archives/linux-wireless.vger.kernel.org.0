Return-Path: <linux-wireless+bounces-39028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d0UgD34bVmoDzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:20:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD47B753D6D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:20:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CxNWev9x;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39028-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39028-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 289D73006B44
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83D376A0C;
	Tue, 14 Jul 2026 11:20:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A603630AE
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028028; cv=none; b=Zk/ooqqHeV0L+UyJW0XJbpOUX0yHPpy3TWsEPZWKe2LPMZK360c7ywwdm6QCmGdtx212ZYPRMFa9JGNifoGpr/G6MRaFSydt/qwNoVoneAPcFSeVF7X5KbLyilAPiUhvjYhmekQiL+A8Un40K5JtKHiabBA8XfyASolc/cEFG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028028; c=relaxed/simple;
	bh=YBFVZkqnp6Fik8amhU3+Cc7FhBzgGruU8exu13z9KO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbOGu198AU9iG+bIf/06OUz/Sd9isESdWnO4wNo1H47NQOcSooxDIiRmJBP0lg4Nfg2Rb3w3TIXHv+hSmtnS1GArZ3Vgp24rzssjAgLwid+rp/nfLVy/IoMrlL0J4Eucs9WTILWsocThc2Y7u6bSdN7Y+OBxF8bocrvkTiO9SBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxNWev9x; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028026; x=1815564026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YBFVZkqnp6Fik8amhU3+Cc7FhBzgGruU8exu13z9KO8=;
  b=CxNWev9xqes6U05N+cKKNeO947K2w9rsUADe6q6WWzw/IVnEXl+4Eb8A
   RyD7IsCoiVE+65S47bloWLx74oWCWB6XQF7mXf3y+Gr+1EaqP7QseQGWw
   QfQxIfblAUYUvkjBACjNjpJPgiqcMln3n5vYmhaRF5YynP7PxW87Rwuhz
   rnVm0J1EwOXqkbRpDGPn1a+wxxG4W/1aABxf8QAu7TSyTET+9Fd48NALO
   arxMk4TlboSGmUl7buyyCnKRR4sfXVQbms/ElGhlEjaA58AbWvLyDWfV5
   zHLDvLz/QyC69JiceF3oiL+fS7WzwlcgLbXTIr+5p/mg1wNxsTqAb+cek
   w==;
X-CSE-ConnectionGUID: q8FPy+ljQkKzqOrCPoICRQ==
X-CSE-MsgGUID: 0LEUAEXnSY+Cirx2bGq7YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200291"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200291"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:25 -0700
X-CSE-ConnectionGUID: QltVVsRCSBmHA78oPYgG8Q==
X-CSE-MsgGUID: VsBFfRGPQpG2vEJhSSFJIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250143"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-fixes 01/15] wifi: iwlwifi: mvm: verify scan id reported by firmware
Date: Tue, 14 Jul 2026 14:19:50 +0300
Message-Id: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39028-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:avraham.stern@intel.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,changeid:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD47B753D6D

From: Avraham Stern <avraham.stern@intel.com>

The scan id reported by firmware in scan complete notification is
used as an index to the scan status array. Verify the reported id
does not exceed the array size.

Fixes: 8d14ccd878e5 ("iwlwifi: mvm: make UMAC scans use the stopping scan status")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 79829f775c89..42f9d9a713b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -3217,6 +3217,10 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 
 	mvm->mei_scan_filter.is_mei_limited_scan = false;
 
+	if (IWL_FW_CHECK(mvm, uid >= ARRAY_SIZE(mvm->scan_uid_status),
+			 "FW reports out-of-range scan UID %d\n", uid))
+		return;
+
 	IWL_DEBUG_SCAN(mvm,
 		       "Scan completed: uid=%u type=%u, status=%s, EBS=%s\n",
 		       uid, mvm->scan_uid_status[uid],
-- 
2.34.1


