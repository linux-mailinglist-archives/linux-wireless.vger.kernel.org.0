Return-Path: <linux-wireless+bounces-35602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDiAHHzu8WmulgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5EB493A9C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2550E306B184
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F243F211F;
	Wed, 29 Apr 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDyj6Chq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E037D10F
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462870; cv=none; b=NeEjFFlnGWbA58Ogls2SJ2ridYxj3+Wj/pNYuA2nt2KoJP8SL1VrzeaFV6p5Lj+keRDJiRaiigE2ktI/Aeto9/ebTq/ifSeUceO+7EP4zP6nFq/45zEQudAjLk8Pip9bsTZu1BLDF9QCBbwT1s3a9wiRJfiGa+vvKhF9mYtMkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462870; c=relaxed/simple;
	bh=LLxUu9T6uw2wV340GCpsc7SiUDyV6XxgEEynqCAByWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/Tg5CmQQ94BorfS3N1ebgMt7FN4gUk6N8CtsrhoYShkXx9/VQnrrABsbpsPv0mySKkvggeyv6maDxuX+N7Xi4+kkBBWIu1GOuctn2jIBe1LTjDKXMqLJ1m9FL8ItwVrJMHMubZx102kE00PVvbN9S2iynvQK7ukGDnHIm9f+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDyj6Chq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777462869; x=1808998869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LLxUu9T6uw2wV340GCpsc7SiUDyV6XxgEEynqCAByWU=;
  b=LDyj6ChqP4i3daUDzTeeRwBJkDPIk6TnVMqDTlEUSxIxZ4VRYd8tXlT9
   KpuhVnHnL8tO4GOZmohMK+FmZc01fcn4caHcuNLVX9+9pW/tpBkDfbcXv
   dRoSeCnu1oy4QLrmzTUSwSq4EKpiI++m5RVC1j/5eCnUTCEifSc6Xskye
   Pw+sJYXLbjkmGD+bwrEII0Pi347i9gio2vqv7Vea99jahyojFBK8GLRsR
   VrBfGyZA7iEyfQKtmlLqKsgktjUJ5LK+L/Kbc6eM8wuVaShg/mqxDrF5K
   vqyWmPbmy4Z/DjJ4xtvL5E0x/6iexzdSruisgrIH4WqN0a/x5Gx/+IEJE
   A==;
X-CSE-ConnectionGUID: yhUe7d9VRdOv+2WW6B1bHA==
X-CSE-MsgGUID: 171MqXy2Rfis1DrXJ0G/qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88986116"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88986116"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:08 -0700
X-CSE-ConnectionGUID: PjAGrvcqQvqqjIoHllIK4A==
X-CSE-MsgGUID: seYtt3orTBy0bkejT0XXlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234505122"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next 04/15] wifi: mac80211: Allow setting MAC address on interface creation
Date: Wed, 29 Apr 2026 14:40:38 +0300
Message-Id: <20260429143813.d268b245037b.I351e16270c34ee734fed98da25db848211ab7cc2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
References: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE5EB493A9C
X-Rspamd-Action: no action
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35602-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Ilan Peer <ilan.peer@intel.com>

Allow setting the interface MAC address for NAN Device interfaces
and P2P Device interfaces on interface creation.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/iface.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 95b779c4d627..683d8db4da14 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2280,7 +2280,12 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		sdata->dev = NULL;
 		strscpy(sdata->name, name, IFNAMSIZ);
-		ieee80211_assign_perm_addr(local, wdev->address, type);
+
+		if (is_valid_ether_addr(params->macaddr))
+			memcpy(wdev->address, params->macaddr, ETH_ALEN);
+		else
+			ieee80211_assign_perm_addr(local, wdev->address, type);
+
 		memcpy(sdata->vif.addr, wdev->address, ETH_ALEN);
 		ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
 
-- 
2.34.1


