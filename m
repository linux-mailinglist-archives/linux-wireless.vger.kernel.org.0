Return-Path: <linux-wireless+bounces-36537-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNhdCKh1CWokbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36537-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA055FD3B
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D48593004C10
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFABB67E;
	Sun, 17 May 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9gkRZxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771E28686
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004828; cv=none; b=cGunK4ttW8gO5J/QvTHbnFo3tiAdr4YwSrJUQZESXCwr4ugCeVR9dz/s1Vz665cPFDVXowhS5SmxngWFSggK3FoWn+aAu6Y7TTdMNiIGhgP5vfsBc8ia1TloUEWhW6pfp8ON1m4cOBqO6M4V8bCmjonoSkuQWZ+deIi9nsI1Xxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004828; c=relaxed/simple;
	bh=9GeyZWmWVBPjcRagclXzlJ4S+Cuufprp5GHIpboePww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6KVMMWcu2P2eSoFsJ2lHINHfGzq5I3xFrmfLG+ppfDX4c9l/nvfTvqbBUoieNQsvg5xy5Kirg/3rBjad9fbm3IGNMNMPMgs87J+dvclxfGq8Gqm088wg8ukjRtRVAxBAik0qMRGfxiAYOrXpJ6p1SnSFLGDnLR+z4nd96oPMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9gkRZxM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004826; x=1810540826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9GeyZWmWVBPjcRagclXzlJ4S+Cuufprp5GHIpboePww=;
  b=b9gkRZxMY3EMUVqPCzqsDWnRE3lwKHGLJ7xbg3iQvgmXdRmNuYqXM821
   DHPPOX+lkGoqNGniVsmWd5IoRbhAsaqqYUk7qyokiaJk+RqRAn22S5hEq
   jtNwCBn31JBuBcov3xICqDdrU0SoR1WQczFXOKmBbIkiXJbRRBZoXTAzk
   yBOAMNOMVsGPRgn0MSxNONjQYGFcJf0TuzOCPnEXESumbvwSSi7/A9fIU
   +ihrzw1kx+Jkrgx42ddr3+G2av+o/YhYjam9Spu+wZtAEiCE27xn4Ud/q
   gzDvCQMb1p233e7MjOWlBn4ABNyjGolVwrkvTYOwsTaTn5GKiSmjN4mIe
   Q==;
X-CSE-ConnectionGUID: W90v279YQ6KYc0dk1B8BYg==
X-CSE-MsgGUID: 56iERXE+Tq+OdSwJuZzz4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606949"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606949"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:26 -0700
X-CSE-ConnectionGUID: X4i4ayuSRpSC+Lhbm16eKw==
X-CSE-MsgGUID: cj1jI0tVTI6scCGfPg9Piw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490375"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 01/15] wifi: iwlwifi: mld: don't flush async_handlers_wk when canceling notifications
Date: Sun, 17 May 2026 10:59:45 +0300
Message-Id: <20260517100550.70dddca96191.I06d3c6433ec22f81f2fb3fb2ee43881e662c5212@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95CA055FD3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36537-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


