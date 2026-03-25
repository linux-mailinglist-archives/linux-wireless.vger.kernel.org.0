Return-Path: <linux-wireless+bounces-33849-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC4GLqLsw2kAvAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33849-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 15:09:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E523267B5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 15:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6022D3250FC5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A253DA5CB;
	Wed, 25 Mar 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfrqG/vL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5D262D0B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446522; cv=none; b=PmOyCkJwM0jie5lw91DQZ3vm5QFQz2JUZ9yyBL8xGBcMTPty32rJGzezVgnu9mdSoI2iGlXDqUSmJe3iJwmKBnR1q/v9/6sXGvqAiXW5DMK7V+7yx22MQN0OApdPp0+DOcCFrTi7cldb8O6AXlvKbff3C1YbZ+GjEsnrTV+iIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446522; c=relaxed/simple;
	bh=Rwty5JJQlCxzLZYZ2DstHvPi6lMJ0DgsLS8zZVo0F5Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XqBflUKD+wFHbPD8SDxUYGWhDGbfWfaSzzOaAwmJeD1mSyY5sjsZnyCJSZetW4lPW1Ad8eynTEnBh/E7lpNesB5uLWuJUExJrH8SRaGj+MgpYC/6TZ5fYX63+vQDt1URPYi62PQSxar2jrtFEVrXKp+A/DEF+A3tv7q61NBgA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfrqG/vL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774446519; x=1805982519;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rwty5JJQlCxzLZYZ2DstHvPi6lMJ0DgsLS8zZVo0F5Q=;
  b=HfrqG/vLQec8P9HEIwM8WySi3qdlbUovh0SEzLGJKK2ggGZsDdQ793ku
   nttlN0KYa95OCvEAf6nD/EH3w6xw7HAEBKOMxEeSEoMjliEJuMRu3m+oi
   A4xM+dSDNbEyAsGfsDMJcKUZRFFLznaM0v/u6FXPEFyW8xgmxovYPXmlJ
   b11BURZAbmHF0KrP/+sBxSt99p1DePkRWz6QQlfwOJ1gVWlI4ukPEZzEI
   QUDl1E72Q84qH9S/qp6lJGm9w5GwzL6RmYPzM4x9u/xT/51ZgOeJYx8Du
   w89WSoPP7DFJLI/P5h00JCW25uBImaD4c2R++VzovTuwrlXyyPlBT9vXP
   A==;
X-CSE-ConnectionGUID: Pfnl5cvgSBW461JyS4Z4Tg==
X-CSE-MsgGUID: YdRy2sEXQJ2vrE6E2/AYUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79339824"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="79339824"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:48:35 -0700
X-CSE-ConnectionGUID: sKK9bVLNTXSJUIquaNdIzA==
X-CSE-MsgGUID: P4NoTeWIRKm20M4F3hJ1JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="223757414"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:48:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next] wifi: mac80211: cleanup error path of ieee80211_do_open
Date: Wed, 25 Mar 2026 15:48:23 +0200
Message-Id: <20260325154742.3c532a9132c3.Idac5c38d5ad7ce97782a8c05ae72bb0c689c4fa9@changeid>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33849-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 15E523267B5
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
---
v2: make the commit apply

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


