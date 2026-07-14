Return-Path: <linux-wireless+bounces-39068-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQqPHqVBVmov2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39068-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:03:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F1755753
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TcLG9YUo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39068-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39068-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45E8D30333E7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE24437106A;
	Tue, 14 Jul 2026 14:02:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3AC4446E0
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:02:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037774; cv=none; b=ePBmCrPys6shNjUuBdfN5wmdEIYUjwwP7kJd2uax420jWwVWpiQ7XixVp7OPOy7RSn6hYBgluSaSkTj/LcyIFkRfHtLQCI4yCF+Lzji8h9E4EuiZQUqfGfwWhsJ2HIq/WARJMpWaQrtDkoufjKbI8WdkzqnuTQ+EeTlMj33gTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037774; c=relaxed/simple;
	bh=Twbd1G0EESuvA9DN23mLsgMoDXe31L/E0EXKO0gd0v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h75G71KAEuVjtc0KI6YdWET0iOzd8gTh9ekKitUIypP8WYWAr7KNwE2Vly3tZndjpUkPkhlqTSqvnmnccorQ+PJDZjYnVTuHNVVefAmtzWSX0yE+sNRvIz0vMes6ivvlbitAtg/J90s4ORhYp4USERU1PdDsz8eCFSQI/K0mJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcLG9YUo; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037773; x=1815573773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Twbd1G0EESuvA9DN23mLsgMoDXe31L/E0EXKO0gd0v0=;
  b=TcLG9YUol+wyNRz3xbqO2K+AbXU4czj5Q/Jum//0kwlsvOaSo/QQb4Ll
   qM1D6LFFQEK+AI7aPuO9mHmhEkQOsiLitruGICSoi5Ao6AITE6AiTQsvs
   TW7OGjgjUTvHXYb8rdOPYrgoFYs8uXwH7Jsk+AxFPv5EjjsiH4H4CS0aN
   AdlvRGMIVcnU5wRW6kOh2HlxO5dZArymmtj3hAVjXKvClNN89wqgFd/Qk
   QrJPp1qBOVbvr624YYApnCzXok02pdc/fbddZm2/KX7WkrDYMI/LvWu86
   sFUWgQY8x/lGrQGZRkyS9t6LySWMHmopR8nNCSKA77co6QylUP38M11UX
   g==;
X-CSE-ConnectionGUID: BJK5u5TWRlqWSX01/DDxiA==
X-CSE-MsgGUID: Yu0sqHgsQ+aeNBejx0BNjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855111"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855111"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:53 -0700
X-CSE-ConnectionGUID: E3laRtXyTkGvIN0TgjHvag==
X-CSE-MsgGUID: yWaS9JqCRjyavok4q7yROQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737872"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 08/15] wifi: iwlwifi: mld: cancel wiphy work before freeing wiphy
Date: Tue, 14 Jul 2026 17:02:11 +0300
Message-Id: <20260714165826.07aa49f755a2.I734a27b1b0eeb5b0e821aee3318fee8dc0a6bc03@changeid>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39068-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:johannes.berg@intel.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-wireless@vger.kernel.org:query timed out];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C2F1755753

When we fail to load the fw during op-mode start, we purge the list
of the async handlers but we don't cancel the work.
Same when we stop the op-mode.

Before freeing wiphy, we need to cancel/flush any pending wiphy work,
otherwise the work will fire with a freed memory.
cfg80211 will do it anyway, but it will warn.

Cancel the work in those cases.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 78c78cf891cd..5a6c9ab20fd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -446,6 +446,8 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 	}
 
 	if (ret) {
+		/* wiphy memory is about to be freed, we should cancel any pending work */
+		wiphy_work_cancel(mld->wiphy, &mld->async_handlers_wk);
 		wiphy_unlock(mld->wiphy);
 		rtnl_unlock();
 		goto err;
@@ -511,6 +513,7 @@ iwl_op_mode_mld_stop(struct iwl_op_mode *op_mode)
 	iwl_mld_thermal_exit(mld);
 
 	wiphy_lock(mld->wiphy);
+	wiphy_work_cancel(mld->wiphy, &mld->async_handlers_wk);
 	iwl_mld_low_latency_stop(mld);
 	iwl_mld_deinit_time_sync(mld);
 	wiphy_unlock(mld->wiphy);
-- 
2.34.1


