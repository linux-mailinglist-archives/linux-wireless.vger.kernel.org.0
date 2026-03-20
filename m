Return-Path: <linux-wireless+bounces-33590-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SALOAO47vWkH8AIAu9opvQ
	(envelope-from <linux-wireless+bounces-33590-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 13:22:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEBC2DA169
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 13:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 939B13056B4B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382023B27C5;
	Fri, 20 Mar 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSxeflZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1083AE71C
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009244; cv=none; b=WQ/sIwt07IscZwiPHPPsrTGtpwB/kqhPgxzMeFNP2XUsHco5OVLWZPwuuAd+0BIbbK0pEtHTdQt2AdKdxVmRsdlVkKMa7YO/dPs0pdtbIqUm6oyfUlY3D5QpFZ835ts02Ke0FL76XQvX2m/+r3NPlqb58MGB5+IHZOIs9kGAEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009244; c=relaxed/simple;
	bh=DiW37+WmIU/jYnBJN2kKwXvHB20b5aKHHb7+9wFTidg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XoOpW5xpmM0x4xGX6biMdSZBAKWVVB7KBClnnJgJGigMx2+14JF1Wps/u/ebOc7WNAxw2gZPqt48AJdR4L9GIHlboibE0dhUxnmAS0fo6W3Ah60nl/PJsIYZAZB6qwzqTtV9f8Qniz3Nd8vFnyBhNWlqBCWmXaRYYVBwKPrxPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSxeflZA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774009241; x=1805545241;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DiW37+WmIU/jYnBJN2kKwXvHB20b5aKHHb7+9wFTidg=;
  b=eSxeflZA79mNg4KIgiKseN3lCzNCHbqmfqsNdqHfWpaPhz77Di4Oa/BJ
   t5L9+bbh2OQ8dfs+sSs0PnhKPePdaOlCN7meVKFvXsJGcsyZfryXuQkxI
   KQ2qCzC+OitI0+GIlnbNMDyVmyfGNYRiQJYAIrrnpGvYYaF1sgwi05X+C
   HS5VR3bor16UnObj5Yl69Uz6tKJ9LAGAq69yZn18C3atPHjm0n+3jpNRi
   HoCQ0RCVWsDaWNHouvgrimvtRXZPD+z6Jiv1qWZJVMiG1PeVgBwEm35Vr
   kGJ341ffHW4qGkTd3EUxOf/jCYX+Z88jfWJEg3gfxj7YzqijDq55fFikk
   A==;
X-CSE-ConnectionGUID: aYQqqc+RQp2wvN71buksLA==
X-CSE-MsgGUID: cLC72fRTTwqB94f1qp3/3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74793029"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74793029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:20:40 -0700
X-CSE-ConnectionGUID: 4ee4d/vsQ+Gz7Oi0noSy5g==
X-CSE-MsgGUID: ago/cIyyT7yz0vFYt4C/lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223491928"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:20:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next] wifi: mac80211: cleanup error path of ieee80211_do_open
Date: Fri, 20 Mar 2026 14:20:28 +0200
Message-Id: <20260320142021.0e7b1f5cdd02.Idac5c38d5ad7ce97782a8c05ae72bb0c689c4fa9@changeid>
X-Mailer: git-send-email 2.34.1
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-33590-lists,linux-wireless=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 2CEBC2DA169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If we failed on drv_start, we currently cleanup AP_VLAN reference to
bss.
But this is not needed, since AP_VLAN must be tied to a pre-existing AP
interface, so open_count cannot be 0, so we will never call drv_start
for AP_VLAN interfaces.

Remove these cleanup and return immediately instead.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/iface.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 232fc0b80e44..234de4762be5 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1361,8 +1361,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		break;
 		}
 	case NL80211_IFTYPE_AP:
-		sdata->bss = &sdata->u.ap;
-		break;
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_MONITOR:
@@ -1387,8 +1385,13 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		local->reconfig_failure = false;
 
 		res = drv_start(local);
-		if (res)
-			goto err_del_bss;
+		if (res) {
+			/*
+			 * no need to worry about AP_VLAN cleanup since in that
+			 * case we can't have open_count == 0
+			 */
+			return res;
+		}
 		ieee80211_led_radio(local, true);
 		ieee80211_mod_tpt_led_trig(local,
 					   IEEE80211_TPT_LEDTRIG_FL_RADIO, 0);
@@ -1459,6 +1462,9 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		netif_carrier_on(dev);
 		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
 		break;
+	case NL80211_IFTYPE_AP:
+		sdata->bss = &sdata->u.ap;
+		fallthrough;
 	default:
 		if (coming_up) {
 			ieee80211_del_virtual_monitor(local);
@@ -1547,10 +1553,10 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
  err_stop:
 	if (!local->open_count)
 		drv_stop(local, false);
- err_del_bss:
-	sdata->bss = NULL;
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
+	/* Might not be initialized yet, but it is harmless */
+	sdata->bss = NULL;
 	return res;
 }
 
-- 
2.34.1


