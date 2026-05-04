Return-Path: <linux-wireless+bounces-35808-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOxsOvVI+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35808-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12214B9443
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2D22300107C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82812DBF76;
	Mon,  4 May 2026 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOkAasiI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77916283FCF
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879279; cv=none; b=rpaqvMTDTQCd1RebK6roE4Cm/ckayBmaO/IfqLEg0VcHAdO3e08gAL7QN6thpEhmNaoRfqvahowE87EvXFb0PFBBUVFg0r2p+IZSss6CUdhUNq2/me4fhg0/ZCsk6/D1C413oBVIRhnQcQzN4B0AQGISKqF48mZIDd8i5SAwfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879279; c=relaxed/simple;
	bh=ywvEHQH1LKhefXukMDwkR3KBPTdE8zvRCasjF/R3d4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tvkwdpc4cg0uZMj4JEITK+6+EGbhCOdmbzk1JGkjaPtGk6HCdFQyvFCYoWrBLdkgdw4pLgzEoXg550yuacCgXo91wZFJkbaOWLKMkp6trakOUFAx2m4TjDHklvxRyVk3D+g1tbs3m4vPjiQMtEjNBglkpTgCG1AYfW/8yT4iZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOkAasiI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879278; x=1809415278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywvEHQH1LKhefXukMDwkR3KBPTdE8zvRCasjF/R3d4Y=;
  b=HOkAasiIHEB34GPyfDvimDbay7x6KKqRIdMgTtWlJROC3RL1sAnPlPsr
   wnhjph2Lh8z3PMambJapDgG5sOS+n2zh7aEM2lFSYk6L9QGD6SO+aAUxS
   4ealbrXjAI3FBO6P/FhYvT7KQDXcJ/9tkSpntYZcTzuBfQzdU8tqN9S2Z
   TehZWsLxLSadpn6viudq5vOxLZw9BgIBqSvjLQwsQUHOVn2xta+3+Ksev
   rTqFc4EUCKFnulZG8+upzxnQwHl5h3LZcJiPVdYy38LqAD+O3k5obCO53
   yFGvRji1c6v37pi/dviwcQ5rprSMxcABkY/3QIJGVfSiHFYgtQ3qd0MKL
   w==;
X-CSE-ConnectionGUID: m8RNrNExRm+uNXQypOFWlA==
X-CSE-MsgGUID: xzgvwYrSTYO89fikP9KVJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398316"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398316"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:18 -0700
X-CSE-ConnectionGUID: FmZbFnucQOiTW/mfxQyb5Q==
X-CSE-MsgGUID: bz1+ZPU3Ti6x5uMhv/jJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555246"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 06/15] wifi: mac80211: avoid out-of-bounds access in monitor
Date: Mon,  4 May 2026 10:20:46 +0300
Message-Id: <20260504101829.346c9893d136.I15919027597c04ec35c6217db6e52e2a605e5cfc@changeid>
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
X-Rspamd-Queue-Id: F12214B9443
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35808-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]

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


