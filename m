Return-Path: <linux-wireless+bounces-36519-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ReFI47PCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36519-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:11:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D255D9EF
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F94A300F950
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8733435DA69;
	Sat, 16 May 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Atef7HUf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA829A32D
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962315; cv=none; b=UDzw42kwGSXjj6BBH+M0MZWzge/+C3vP+8XHPxoONtDYaac8rbCIaZwXy2vDZjxoLG6lsIAH7JEn3mhv5Px3Ms2FROnKo4786DGAuDip42bZL1jb7oRBt1NE2pZWetdy2yviWp1BB6qMcKoxKkY4QwUkYNoZYP6WQ2bIkRR4zVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962315; c=relaxed/simple;
	bh=9GeyZWmWVBPjcRagclXzlJ4S+Cuufprp5GHIpboePww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbljuccGtPYcp/HrxyhDQMAkcArKosnbciKwqtKs/x74RKWkYsvYFwiF4bO1iduVHy4+t70DkTbtCckVhnhl3y9MIJEooXYnCIa/JBTcn5ZpVdqH+2FH6KDBZRRltHCt/cYRlWiGV4dtBgosZI6pY+ZF8drL7nT8Ix5KZQdqEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Atef7HUf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962314; x=1810498314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9GeyZWmWVBPjcRagclXzlJ4S+Cuufprp5GHIpboePww=;
  b=Atef7HUfbTosXkLnJTfpABAmNGQRB7L8+bOB400feVnGJ9sYOykcnNPy
   gV6M3LB+QFU2q97aAgWwBkL/4fhkqcm0/URbq/KZZ7NuXavM2wPEFIgpl
   7GAd+gtaBgJ1DJ8xw78PeflV+0Pj0lW6NEnCUdTiEg4PSON94aLb2ExXT
   oBpKA7IswHM6BtQJ81OZm9pH/Qxl4r1dN4kkRHad1wDJnFA79Xk1aGf6R
   q3SLE0JwTrRxQN2LN1R6zC6w9Rv0/qcBuUZctZSiUQ+hlEezYWSxmivFZ
   SctURWdbRCPNBRAJWD+/sNdIvjuntHeZj63V7FQMCQGiSnCqm2PmlfRYt
   A==;
X-CSE-ConnectionGUID: Rxjqn+clTJaYSRRGBzU8CQ==
X-CSE-MsgGUID: 2CSXsYWuTi+SCOsMeU0AUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845722"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845722"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:54 -0700
X-CSE-ConnectionGUID: 73NIrHW+RaC6SlK3XEKqtA==
X-CSE-MsgGUID: RfLzXmsQT/2eEZykvYfERA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130853"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 01/15] wifi: iwlwifi: mld: don't flush async_handlers_wk when canceling notifications
Date: Sat, 16 May 2026 23:11:23 +0300
Message-Id: <20260516230843.70dddca96191.I06d3c6433ec22f81f2fb3fb2ee43881e662c5212@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C77D255D9EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36519-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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


