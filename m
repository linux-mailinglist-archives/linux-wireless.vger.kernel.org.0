Return-Path: <linux-wireless+bounces-34658-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CrhJwiM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34658-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D33E3BAE
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B288A3004D3E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED53F3783DB;
	Sun, 12 Apr 2026 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOfzrL+L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817AC37BE8C
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995903; cv=none; b=DFMlOvFnSHab7MAZTnatiUaaCpxbb9g4PEXUrYzD+Q5+89l3jgONxBYSTlxz7LvwICJWZxbJUqc7tyyt0Wf9BZyv9cfD/zTrODIKCIT9rN/DNB3Gf3c+SCkjFlhqa4Nei5n17dRUeIsCWNfLGA454sIeX7fzjOpT1XYTCiYYc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995903; c=relaxed/simple;
	bh=LLxUu9T6uw2wV340GCpsc7SiUDyV6XxgEEynqCAByWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zc03P9xiw2LRx61JhB17IKaVLX/WKHn4Y+1Eg4eBihy4a12n/5K6LfMQHZWbDazAxcPcvFDeCdr2KrZMPAtH0+6/linbWXJ15wPvJuKbV3dvK9ju/bgdHta2HG4gV8Kelp0/vaZxZwakNhlIj2qHwJVUhiHpAo5Vh/9Yb2oy2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOfzrL+L; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995902; x=1807531902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LLxUu9T6uw2wV340GCpsc7SiUDyV6XxgEEynqCAByWU=;
  b=AOfzrL+L1yNmvyheJGlHJocarDnjNtizvTRe2XyPfcvE7RoUgyYUy6do
   mqAYPKAw+IhDQtSJJMaZhA2AyrDJoZiIXMBqUSdt/1SYBh3lT5rakNUsN
   bfp3mMEd2J2cqjIJfOLsirbeTrYYByGRBRsoYAuZwg+5RkGzwcYmB9JMT
   HmXnNr3qo/3a0kYOAxJtDP0H1WskEsAYghuMi0yuMA/tnqLkpzPYKRO9y
   yCpjc+5ThnYVnMDRET+9zAmpo/MwnNex8ZiIUaTcLMR3/C9Kmjh3vMCuX
   iwzyhpJBJC0l0EeptWfHTiawoP2zKVT1W6E149t/VGBT44T8OeUDrxPBR
   g==;
X-CSE-ConnectionGUID: vfc57ZUkQh2pWjb5Cq6U+Q==
X-CSE-MsgGUID: iKwwT1+jRP6Rai60XIqWbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028460"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028460"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:42 -0700
X-CSE-ConnectionGUID: c9nbIGQhSNC8Gi/CFm9JaA==
X-CSE-MsgGUID: PT2v68wwQ2W9xjuPH+J+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411893"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: mac80211: Allow setting MAC address on interface creation
Date: Sun, 12 Apr 2026 15:11:13 +0300
Message-Id: <20260412150826.1de21fb81c5c.I351e16270c34ee734fed98da25db848211ab7cc2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34658-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 489D33E3BAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


