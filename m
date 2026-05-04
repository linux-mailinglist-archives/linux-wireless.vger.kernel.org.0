Return-Path: <linux-wireless+bounces-35813-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPfRDF5J+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35813-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:23:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F84B9495
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF1C302A6F0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E822DEA90;
	Mon,  4 May 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOIv5/tJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375952DECCC
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879285; cv=none; b=Nj7q3v+TlFAM2or0ykHEpV/guFGOF8L4u2m8q6KDbidxWmHj3IDpQeK+4am2V6QHuGFkn8lWaGeHvhO4ic5QtG4ExhtoAAkAm6JUk3HTLYyJoKdJc6Ysq54s9QN1ldw7RWHaUDePU6SsAReMti3ANJxfbJCWzvP+rAk9Z9N4oVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879285; c=relaxed/simple;
	bh=LLxUu9T6uw2wV340GCpsc7SiUDyV6XxgEEynqCAByWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOJQkmAA4pmueoLrSdlso7VJKfYjqNJoUlFf+mtwmmU4Oo+5IqfLVH90tM4YS2qGIy00RQBzM8VGWEmg2zAege/9duovsxmBhiK9CwxRDSUogSyMrw81UqgKFTHiraWCek0NVvi78NcossizixFx/SMr+SmRGUwBE/D7NOjEylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOIv5/tJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879282; x=1809415282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LLxUu9T6uw2wV340GCpsc7SiUDyV6XxgEEynqCAByWU=;
  b=UOIv5/tJH5D5F4/9S5u1ccBL4QY4mwuUJXFqkzxRTQuxHXvzjuAQsaVS
   qPkoK+EvwBouOrzmiMGbu8N362or8NEOyf/uapQnGmXUVf3TTdKwH7Bf+
   z0CgO7SeMDX7R//Gr/LNirvXiROYcGR7ogbte9+LFfo+TdVYO7IIX+ayc
   Fx8FQVtGtmEkAatUyvGKIt5s6duLWcYGKxcXHxBBFwpuupd8iFFOPtzLS
   bXLZTmza90/oZmXwliFWyLvX7LukjGQ7/ZjXMOAJtdD/p50LxrTLz/56z
   k+XW9VZPhiwrhi5o/GAM2hK4CkLmss6MXMtRV3jRMFjfbKU1uI0eOxGkg
   g==;
X-CSE-ConnectionGUID: rBom5fBvQGyhn6v1XrgTxA==
X-CSE-MsgGUID: I6gmk5yTSda3SPRQlcTkEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398320"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398320"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:18 -0700
X-CSE-ConnectionGUID: HiYiqrsjR/KOlK8Eo74giw==
X-CSE-MsgGUID: zrg38uW4SzSo92MI2HH0sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555235"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 04/15] wifi: mac80211: Allow setting MAC address on interface creation
Date: Mon,  4 May 2026 10:20:44 +0300
Message-Id: <20260504101829.d268b245037b.I351e16270c34ee734fed98da25db848211ab7cc2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
References: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D38F84B9495
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
	TAGGED_FROM(0.00)[bounces-35813-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
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


