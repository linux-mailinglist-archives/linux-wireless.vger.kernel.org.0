Return-Path: <linux-wireless+bounces-36627-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KBJNmAHDGodUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36627-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC185784F7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 445833011C4C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AE1DD877;
	Tue, 19 May 2026 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C31W2jPf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E80390C86
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172828; cv=none; b=qMvJjrPOstdXoXP9MtR+LQKRsPm5RZyXVIifpFrt8+NmBSWaK0YgsUYPFBczCe9sC61dtPgUvWwiMrzUEjCiWEQSG7uHjw8rjXKlktvTnUUImLbAjFTb1u+aB/838x+2Zxlyt41kt3KBctSkAt6M4JOFKlnA1yTAWZRH5lyGoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172828; c=relaxed/simple;
	bh=8dQUsXm0kOU6KyUcA/zuJ5g1csVAtxd+zhsn0b0VaMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcQVEjA4RJyFgGUe22nxkwcMt9H6bf/jOBO3AHSswi11jNK7u6ZcRmYbh96fvdLfHpdJ2O1KaU5cfLbed3g1VfBMLOdwoWStP+t/TP7eKP7LUZN9SgqbRaseHqaf/3MS/KyKO0Pb6YZvUUPmYXFFEJXE5gPNz8BYbEbealZfXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C31W2jPf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172827; x=1810708827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8dQUsXm0kOU6KyUcA/zuJ5g1csVAtxd+zhsn0b0VaMM=;
  b=C31W2jPfRqHKcN8hTA7ga4Cgx0y0RvhwJzTyGiy+1mp6uvM4Rjg2QeLM
   eRa2bqTmbuENxZPY2AmLUDkZRdVsvqbc8oly9gxZkcw4tvU7VUhebhEKO
   dZfvTdIiQ+iIK6syiH1jk5zlW30e+pkjRfmjyGUVGCeELzzgEmt22URre
   AwkRZt2IW4wmwjq2FobFT9ee+vwg6geEX8rDl9o+ycoKzzdbwhXebbP8m
   AS/2AB2B6qQsCsFu0eJ+3rzZMCIkQ20LRQSv7Ty4VvTMBq+1m3c9AyvfT
   LyjL5Rhgcdrpd6AidovCnBM4oPiIDDQFmi+W4I7ZC/6tI1JCxBYChhhxo
   A==;
X-CSE-ConnectionGUID: bIH/PJyUQZqkkRpkZFZ1XQ==
X-CSE-MsgGUID: t4Moi4YeRkmDWJaLtRzPYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605627"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605627"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:26 -0700
X-CSE-ConnectionGUID: zGWv+DPBQC+ycu99R13UOg==
X-CSE-MsgGUID: PNLJm+OGT1SZWxKe9m3T4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227271"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 iwlwifi-next 01/15] wifi: iwlwifi: mld: don't flush async_handlers_wk when canceling notifications
Date: Tue, 19 May 2026 09:39:56 +0300
Message-Id: <20260519064010.549003-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36627-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 8EC185784F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iwl_mld_cancel_async_notifications does 2 things: it purges the list of
notifications and flushes the async_handlers_wk.

We call iwl_mld_cancel_async_notifications after we stopped or suspended
the fw. So in that stage we don't expect any new notification coming,
and if erroneously there are new notifications coming, the work will be
queued again anyway, so the flush is pretty much pointless.

iwl_mld_cancel_async_notifications will need to be called in a context
w/o the wiphy lock held, and the only reason why this function requires
the lock being held is for flushing the work.

Remove the flush.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20260517100550.70dddca96191.I06d3c6433ec22f81f2fb3fb2ee43881e662c5212@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/notif.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index d7383022a0ed..7574689e4088 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -694,10 +694,6 @@ void iwl_mld_cancel_async_notifications(struct iwl_mld *mld)
 {
 	struct iwl_async_handler_entry *entry, *tmp;
 
-	lockdep_assert_wiphy(mld->wiphy);
-
-	wiphy_work_cancel(mld->wiphy, &mld->async_handlers_wk);
-
 	spin_lock_bh(&mld->async_handlers_lock);
 	list_for_each_entry_safe(entry, tmp, &mld->async_handlers_list, list) {
 		iwl_mld_log_async_handler_op(mld, "Purged", &entry->rxb);
-- 
2.34.1


