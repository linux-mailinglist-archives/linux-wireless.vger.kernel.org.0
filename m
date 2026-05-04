Return-Path: <linux-wireless+bounces-35810-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HeCGvlI+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35810-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CFB4B944A
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0256330046AB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E12DECC6;
	Mon,  4 May 2026 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVHmxOAw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91292DC79F
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879282; cv=none; b=p1QbufStPmcQa0lKPuExuLD2WpakQ3Ei3dElxpq05DI6CfEGOv/C/3HGqT3Ra3UFSsTCZl1zyDKf2toM1mPQZmGKHbSWw/p4sCZM90r0aMx9fuwg80VveZOgEr8+8xFrJPrRF68kAx7VTPS0imU1i1PsRw8xovlolFoEDWa9RAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879282; c=relaxed/simple;
	bh=aZW59m5rRAKBh3zYOBYEB73IQUXaW4YryxqsimC8Fko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqxzb1yZHJTPIAM+cOdOfs7IqrqPIrPuVvBhNh745MYYijTuRvmUke+V10Zv/H5C1a+nV+n1c2Yyy3ybhU7smIjg2Wut6BNmPlvwJcA8VPClEoShDWou2k32+xzO+IXdGqJTBta1uHKeKKGJSRFjimQbBT2+dNjhLGJXEqZDTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVHmxOAw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879280; x=1809415280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZW59m5rRAKBh3zYOBYEB73IQUXaW4YryxqsimC8Fko=;
  b=RVHmxOAwIVFI/CSxQjriAoEco4zWmlIdiupo776EfuHLoFhE5DxjIr39
   AUbE44Q9AyFIsgQB2AbWyTJ9eSUKXi+d2aM1GkewlO22b09A1ePb33yWk
   wyAu5GI8RfJhWJj9134XWmXKEEDLDI+mTZVVf0MTt1+iGu9vT+NrO6GvC
   9NqnL3zkI/GnyEKCW7DsjNkCLlJbilspcABIZB32OrA0Mds8uBJcsqTwX
   gN7K6/+xPf6xVhW2TxunWI3DcaZZ8jIJTXsyv5Tq3bnYGz/dWvSGBXJL+
   t9Br6b/4GekKVqgv4g40dLTFMvdEROP6qRrm+EuBQOvqoPALNinKi157G
   g==;
X-CSE-ConnectionGUID: nsMwLLuLQSq09idWXhjxCQ==
X-CSE-MsgGUID: N36Qo55lTN2QsgF2lRro1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398318"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398318"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:18 -0700
X-CSE-ConnectionGUID: g3jsrXWiQaGBkvDfCZE8cA==
X-CSE-MsgGUID: qIqvPjGaSNiUwAyohH4OVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555223"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v4 wireless-next 02/15] wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
Date: Mon,  4 May 2026 10:20:42 +0300
Message-Id: <20260504101829.4ac207c60ebb.Ic4b1c90552497b7ff2616651a408e5fe8bde7b99@changeid>
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
X-Rspamd-Queue-Id: 69CFB4B944A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35810-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: Ilan Peer <ilan.peer@intel.com>

Allow TX/RX of action frames (for NAN action frames) over
NAN Data interfaces to support cases where there's a secure
NDP and NAFs may be exchanged over that.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/main.c       | 4 ++++
 net/mac80211/offchannel.c | 9 +++++++--
 net/mac80211/tx.c         | 5 +++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f47dd58770ad..8400792d67e2 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -750,6 +750,10 @@ ieee80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
 			BIT(IEEE80211_STYPE_AUTH >> 4),
 	},
+	[NL80211_IFTYPE_NAN_DATA] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4),
+	},
 };
 
 static const struct ieee80211_ht_cap mac80211_ht_capa_mod_mask = {
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index f60f6a58948b..10c962d28037 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -8,7 +8,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019, 2022-2025 Intel Corporation
+ * Copyright (C) 2019, 2022-2026 Intel Corporation
  */
 #include <linux/export.h>
 #include <net/mac80211.h>
@@ -898,6 +898,10 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		break;
 	case NL80211_IFTYPE_NAN:
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		if (is_multicast_ether_addr(mgmt->da))
+			return -EOPNOTSUPP;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -911,7 +915,8 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	/* Check if the operating channel is the requested channel */
 	if (!params->chan && mlo_sta) {
 		need_offchan = false;
-	} else if (sdata->vif.type == NL80211_IFTYPE_NAN) {
+	} else if (sdata->vif.type == NL80211_IFTYPE_NAN ||
+		   sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
 		/* Frames can be sent during NAN schedule */
 	} else if (!need_offchan) {
 		struct ieee80211_chanctx_conf *chanctx_conf = NULL;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1702f816419b..c18de2cb3769 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -6377,7 +6377,8 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_band band;
 
 	rcu_read_lock();
-	if (sdata->vif.type == NL80211_IFTYPE_NAN) {
+	if (sdata->vif.type == NL80211_IFTYPE_NAN ||
+	    sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
 		band = NUM_NL80211_BANDS;
 	} else if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		WARN_ON(link_id >= 0);
-- 
2.34.1


