Return-Path: <linux-wireless+bounces-37036-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LJhNKNOF2qaAggAu9opvQ
	(envelope-from <linux-wireless+bounces-37036-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A307F5E9E40
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AAB6302C83F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE73B6345;
	Wed, 27 May 2026 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2HTgcUP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC3E3B52FB
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912345; cv=none; b=HSY0rXNac4xfPCpDEt1STA/TJK7Q4U5wD1BsSOxKJU6V7UTU1Oz1VQeE6DJPrhvGTfCV4sZmtq1W84X8UWgyHz/qM5Tk1Fx6ywdeSviNMwqT897ylhzfS2fg5+XYtIlW1chVQsWYrD3QungceZNAFEH7TyBOzM/YhGxlzvyILRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912345; c=relaxed/simple;
	bh=RtqOvZa+TcAK8BE4WaAznV2EEctVZmi6hOc16ilQFBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzLzD2qoeCbMAyXBXuqMwjD1Htx1XKnwJxf2biBdk3gbLYPqxsLiIZys/yuoDWupnhs1uqFy0nTCHLfpOCbl7/gm1YVz1Ra1ymq6JuTbfDr289H5OXgJpAVcDtOni0+Q6myKU53T7iRBiSnXrqfwxYiFIVRqPfF3gRymMLmBwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2HTgcUP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912344; x=1811448344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtqOvZa+TcAK8BE4WaAznV2EEctVZmi6hOc16ilQFBY=;
  b=R2HTgcUPR6uzyBBlxE4aclkaJOfCWfAopGXKD1Zyl2o2lNYE0qu2wsea
   bRsbqJP4oP72uNjoc4oZWR8Rm0rTliB7gwA+zayLb8Vp7h5pB8xyn3WhT
   oiORiuVpgrEdfE4Jsm8yc5tLtuwwGn84XiyG8Kol/z7/+sXBNdT8zP67e
   UOoNT88xu5DJJjhX5SMfOtBw3nzhIsJ3GMh2LEsepOhqFNguqAMCIhE0M
   bLNmSTyrVPPxQjHCyUnvpeLDpwH2DsItknMV9haJ9RWfWHzivbsMxcIQb
   oZT3BIcyIF013fCiLHkhV7bAcTT+uG4Eoui49xCWpcpKfuITragnNT2vK
   w==;
X-CSE-ConnectionGUID: pPXrYTEER5yOeJh4uPzjgg==
X-CSE-MsgGUID: GMi706HpTtCoFO0JzwHk5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940877"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:44 -0700
X-CSE-ConnectionGUID: UT7ru7LmTgqrR6JYqgy+MA==
X-CSE-MsgGUID: bNxOOuK6SW6nN6yHI2WjSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286982"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o netdetect
Date: Wed, 27 May 2026 23:05:09 +0300
Message-Id: <20260527230313.19720967372b.Iff30814510a26f9f609f98eeea3111c50c1afb31@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37036-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A307F5E9E40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Clearly, from a user perspective, it must be valid to configure
WoWLAN and then suspend while not connected to a network. Since
mac80211 doesn't distinguish these cases and simply calls the
driver to suspend whenever WoWLAN is configured, the driver has
to cleanly handle the case where it's called for WoWLAN, it's
not connected but there's also no netdetect configured.

Remove the WARN_ON() and keep returning 1 to disconnect and
then suspend.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index fc0a5871df2f..458a668ba916 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -2066,8 +2066,11 @@ int iwl_mld_wowlan_suspend(struct iwl_mld *mld, struct cfg80211_wowlan *wowlan)
 
 	if (!bss_vif->cfg.assoc) {
 		int ret;
-		/* If we're not associated, this must be netdetect */
-		if (WARN_ON(!wowlan->nd_config))
+		/*
+		 * If not associated we can only do netdetect, if
+		 * that's not enabled then just suspend normally.
+		 */
+		if (!wowlan->nd_config)
 			return 1;
 
 		ret = iwl_mld_netdetect_config(mld, bss_vif, wowlan);
-- 
2.34.1


