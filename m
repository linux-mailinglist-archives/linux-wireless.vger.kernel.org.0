Return-Path: <linux-wireless+bounces-34660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKctABiM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D83E3BD2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DE9B3013EFF
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2937BE6B;
	Sun, 12 Apr 2026 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuLZzlgv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391937BE65
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995907; cv=none; b=Uw8WG+LFgMoEbBvW5JGOD1Suu1TTMG8WldTjQaaNKWkvw1JPCgkjV0SejmX7M7o44WANGZmmhez883XJ730pLb2roT8LkGJCq9GNspS7Evbjv2dgQVvtcx9Q29Js9VipN8yngmmdA8TyTgTTYO5/RAF8Rv2ogekm5vnMOJTTRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995907; c=relaxed/simple;
	bh=ywvEHQH1LKhefXukMDwkR3KBPTdE8zvRCasjF/R3d4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iyj+sMp7aoCmszGI5qmsH7E8DL92OonPFHnfLHPjaLpSOkcuhI1u5KfGGEjqA1uKZaJ8DUMDL688svHmTNIrQ+cxrIVBck2nHZLlOWL+R7TJcybsd1P0npifUWCEhZzM1ljgdfTBKrNk+mwo4fA+5WdPbhsJ7JSHUaQe0oo9FSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuLZzlgv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995905; x=1807531905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywvEHQH1LKhefXukMDwkR3KBPTdE8zvRCasjF/R3d4Y=;
  b=OuLZzlgvNbO8uFz6iHYLoLmwqJ0aroEobeg3zI5s7EaiPUEtsUCBGG+9
   DrFVyezapnJPKXZsZJ/gRpbLGRi4T55u5/zYfi9sjHzljkwcXk9mAlhy5
   e/TeWq/790xVYHlJPgRLwxs3OPZ8rfbOHn/s01Qh6utpazPLHmLPqrktF
   q5PZxEiMJTDrWfTEPncuwRBYToP1dlfIyr33QAMKs5jeheM6Jw8Q9gwYG
   dxCq9cZJl8gjspsTSnS5a7DV5rIcfIoQtgqlX7Zr+6xJUD0ySqJp1wykA
   PaEi/gVIQruQeaS162oGsFexMziG3ysfE+5cH8K3c2/kiplEfdo3UuZLc
   w==;
X-CSE-ConnectionGUID: TZLyiA/VSLmWpZFnp5GSDg==
X-CSE-MsgGUID: nS5sKqn6TluWadhM0O/zCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028463"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:45 -0700
X-CSE-ConnectionGUID: pPyKG+GnQ+6LprZs8xtLvg==
X-CSE-MsgGUID: GZGOxTipQXGD+pYAkw+I0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411903"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: mac80211: avoid out-of-bounds access in monitor
Date: Sun, 12 Apr 2026 15:11:15 +0300
Message-Id: <20260412150826.e2edd9711512.I15919027597c04ec35c6217db6e52e2a605e5cfc@changeid>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34660-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A8D83E3BD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In NAN, we don't know on what band the frame will be sent. Therefore we
set info->band to NUM_NL80211_BANDS. However, this leads to out-of-bound
access in ieee80211_add_tx_radiotap_header when we try to access the
sbands array.

Fix it by not accessing the array if the band is NUM_NL80211_BANDS.
This means that we will not report rate info for legacy rate in NAN.
But nobody really cares about it.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/status.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 4b38aa0e902a..8716eda8317d 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2021-2025  Intel Corporation
+ * Copyright 2021-2026  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -295,9 +295,10 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 						 RATE_INFO_FLAGS_VHT_MCS |
 						 RATE_INFO_FLAGS_HE_MCS)))
 			legacy_rate = status_rate->rate_idx.legacy;
-	} else if (info->status.rates[0].idx >= 0 &&
-		 !(info->status.rates[0].flags & (IEEE80211_TX_RC_MCS |
-						  IEEE80211_TX_RC_VHT_MCS))) {
+	} else if (info->band < NUM_NL80211_BANDS &&
+		   info->status.rates[0].idx >= 0 &&
+		   !(info->status.rates[0].flags & (IEEE80211_TX_RC_MCS |
+						    IEEE80211_TX_RC_VHT_MCS))) {
 		struct ieee80211_supported_band *sband;
 
 		sband = local->hw.wiphy->bands[info->band];
-- 
2.34.1


