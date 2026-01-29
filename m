Return-Path: <linux-wireless+bounces-31339-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJQ4ADe1e2neHwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31339-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 20:29:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D3B3FA9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 20:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2F53044A47
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5C3126C1;
	Thu, 29 Jan 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlKFYPeE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C51324718
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714845; cv=none; b=ptFbtMYtgwDEA9nxBPIuMu05R5OIBWj0oDfV6RRCzoS6+SqrDLsSG7QGN8VWLcXzkeOQHbJH7gG8y7d0Nx8fYfNBC2Xq0ogA3rvYzFcVNmQUZGAKtXGfdu8asu4dlKvFDUMOKj6TfMaLoeR8m2GGJkwR27xBRoCL4EqlpkiwDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714845; c=relaxed/simple;
	bh=F/HH4zCOxS33eUY0DCU5hkbv8NM81+NW8AvteB0JjHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZijZnVzQTyht7x9tQTuFvLitPqbS0uBwOFhikmZyqN7XFjIsgEnEq//QX88lLNG/E0DESWVaMx3tYBjSL8DplOj5UW9LQOSkUN2qx/q7y0q8u/o23/fuqJHiCO+pIxVzt3mFgmaKIzFZQf+3XHy5EgLS48k2cYUsElIWYzoS2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlKFYPeE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769714843; x=1801250843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/HH4zCOxS33eUY0DCU5hkbv8NM81+NW8AvteB0JjHs=;
  b=RlKFYPeEWLEUNo3lpohpNRKC4o30djamF0+ez/Sgrc29tDZt3g/G2FVM
   YceLrF99gHZkLCj5DqnnSDMLdBt32+bEXvVG1xIOgCe9B4HwrDVRawkWc
   Jk4Gr1js85VtqxNuA6ShJcnAdSoF1aOeoSs14tKw0fWcHzDt4AJwhLPmV
   3UWi0zG1v6EzgzBG5y/ARcj7WDM5/+1AsgsagoytYwQe5nFuFJOc1B6Lt
   DqUB9iIEgYKWhisDy9mcKyhiqHdlC43k24ODLQ7uqzzIZNnPV3TYYsVWs
   rC1Y9NbbV47FgmGnJhJF8el5TRG84pUWesMhh9OQmPnPKxjveJKcmxeV4
   w==;
X-CSE-ConnectionGUID: k6qzWBxUQ0WAk71h8v6+IQ==
X-CSE-MsgGUID: /27CcXtLS7eoFDxBcaiboQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81700591"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="81700591"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:27:22 -0800
X-CSE-ConnectionGUID: +2GrAbeAST+aUW8yjjEK1g==
X-CSE-MsgGUID: VHu0SoobT6a/J9PlJU79SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208576882"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:27:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 2/2] wifi: iwlwifi: mvm: pause TCM on fast resume
Date: Thu, 29 Jan 2026 21:27:10 +0200
Message-Id: <20260129212650.05621f3faedb.I44df9cf9183b5143df8078131e0d87c0fd7e1763@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129212650.a36482a60719.I5bf64a108ca39dacb5ca0dcd8b7258a3ce8db74c@changeid>
References: <20260129212650.a36482a60719.I5bf64a108ca39dacb5ca0dcd8b7258a3ce8db74c@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-31339-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 796D3B3FA9
X-Rspamd-Action: no action

Not pausing it means that we can have the TCM work queued into a
non-freezable workqueue, which, in resume, is re-activated before the
driver's resume is called.
The TCM work might send commands to the FW before we resumed the device,
leading to an assert.

Closes: https://lore.kernel.org/linux-wireless/aTDoDiD55qlUZ0pn@debian.local/
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Fixes: e8bb19c1d590 ("wifi: iwlwifi: support fast resume")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 07f1a84c274e..af1a45845999 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -3239,6 +3239,8 @@ void iwl_mvm_fast_suspend(struct iwl_mvm *mvm)
 
 	IWL_DEBUG_WOWLAN(mvm, "Starting fast suspend flow\n");
 
+	iwl_mvm_pause_tcm(mvm, true);
+
 	mvm->fast_resume = true;
 	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
@@ -3295,6 +3297,8 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 		mvm->trans->state = IWL_TRANS_NO_FW;
 	}
 
+	iwl_mvm_resume_tcm(mvm);
+
 out:
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 	mvm->fast_resume = false;
-- 
2.34.1


