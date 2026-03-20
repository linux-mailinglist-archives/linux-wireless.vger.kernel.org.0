Return-Path: <linux-wireless+bounces-33588-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIT9DAw6vWkN7wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33588-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 13:14:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F12D9F6B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 396DE3032653
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646028FFFB;
	Fri, 20 Mar 2026 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abgl/RZz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448432ED34
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008841; cv=none; b=vBNRP8d4GeE96RY6rc/ntIZioew05zT7EqI5c6IJysA1Xp6KCDXGWg0PjdWV9mkcQej9k2lKljECT3b0Utl2tNJO8gP0Brgc3kOm6filLnMRizhUKdInqViACVHalZ+BBofVdSt+OJvjeFDvWID7/zckldp6DJu9hY+oddhsrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008841; c=relaxed/simple;
	bh=Yov5qz6Coi9i8XA/VzGIp4sFMxbxM++82OuNqzI/6zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2BYH+84kNcKeXfwnsxQKCqOLW+oLAGuo41xzOdPdJaibJFQ3FSRr4qh6Cb2ZaxF2W8Q9wiaRiQZWJrdXy6tmhrNPZzKUkgO/PeWIiuGoMfl6vMq0U9tBud9IO57Crasxc8Bn5X1jLH45Yt5lCBU17dx7DgUi+Dyu6n7rUyfz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abgl/RZz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774008839; x=1805544839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yov5qz6Coi9i8XA/VzGIp4sFMxbxM++82OuNqzI/6zg=;
  b=abgl/RZz/CloEeM3hg+ggGAzkzSP6MaquE8ynWv8l0WAzG2JW3Qx5p+C
   YftgLIJVaFI3P2IsrjNeZ5EW1W6HY1K31yd46F/wC/ZdKL+aC+nCnJCDa
   CsfK1Hw/vIjKF2wrqOkTWqL0QFFav49/Ic7Tyu3tBS3hwthmtnuhg4tFD
   9lPCGozatkRUVG29eIrjXedOz0bW2B8Q234MFYTgoNzOMZ8lBhQ5UpLgz
   NrnFD8EaNIchJuIb5HivtNqSuAs9vcM+9usFs5cap2k2hHxFEvqvfztTA
   kia6c/WlI/Y6Y++1JSAg/DxUHrTeuuRZU6DG29NJOn82HMs1VCzv6nYJz
   w==;
X-CSE-ConnectionGUID: sCLPnA6LTIKvdz9q3V+YBQ==
X-CSE-MsgGUID: C73PnPbvQi+CcT1y3Y6Siw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74792743"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74792743"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:13:59 -0700
X-CSE-ConnectionGUID: shDzxIixSWeZkkAuiPm+cg==
X-CSE-MsgGUID: uAKZ9p+ASMOuSB5zaNKwsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223490288"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:13:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: properly handle error in ieee80211_add_virtual_monitor
Date: Fri, 20 Mar 2026 14:13:46 +0200
Message-Id: <20260320141312.5546126313b1.I689dba2f54069b259702e8d246cedf79a73b82c6@changeid>
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33588-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 760F12D9F6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In case of an error in ieee80211_add_virtual_monitor,
SDATA_STATE_RUNNING should be cleared as it was set in this function.
Do it there instead of in the error path of ieee80211_do_open.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/iface.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 40ce0bb72726..232fc0b80e44 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1222,14 +1222,14 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
 		}
 	}
 
-	set_bit(SDATA_STATE_RUNNING, &sdata->state);
-
 	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
 	if (ret) {
 		kfree(sdata);
 		return ret;
 	}
 
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
+
 	mutex_lock(&local->iflist_mtx);
 	rcu_assign_pointer(local->monitor_sdata, sdata);
 	mutex_unlock(&local->iflist_mtx);
@@ -1242,6 +1242,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
 		mutex_unlock(&local->iflist_mtx);
 		synchronize_net();
 		drv_remove_interface(local, sdata);
+		clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 		kfree(sdata);
 		return ret;
 	}
@@ -1550,8 +1551,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	sdata->bss = NULL;
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
-	/* might already be clear but that doesn't matter */
-	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	return res;
 }
 
-- 
2.34.1


