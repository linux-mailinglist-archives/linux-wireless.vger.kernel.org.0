Return-Path: <linux-wireless+bounces-35600-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHnfIlzu8WmulgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35600-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0F493A58
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA712302514D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D973DE427;
	Wed, 29 Apr 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BW1cutK1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2437F746
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462868; cv=none; b=dx0iFJridUFRyLOY5B23Vi4KcY1s1ga/AaJja689OQ1rMeNKRBC7CA4fHktw9oq4kiPlqWQJobeFAVrAX3FTEOAOqOjPPwr6I4gumXf2WkqgW891P6iYt+xbiF9KtwQ9K1izT6E7dczFio5yZE185m+eyLoHnScc4WFSVL23MB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462868; c=relaxed/simple;
	bh=aZW59m5rRAKBh3zYOBYEB73IQUXaW4YryxqsimC8Fko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLtvGHxw8nUGw/s0MzYQNisJyP1gsj+GOiXG+WCY/wNvquDdtGd46VATBwVB1/6QsprrVKMeRljo59UCzxvDxqfMqLZG/1lZ8fcYSfnpX+fBq/IWEJKvQWRRgW0hg9bQVszzwotaGFpOvHVw9uniGuicFmGUXy8zzgxQhJun2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BW1cutK1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777462867; x=1808998867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZW59m5rRAKBh3zYOBYEB73IQUXaW4YryxqsimC8Fko=;
  b=BW1cutK1CaGl0QdZam3IHhbtaofqdCMKvuL1uqhaLZ2E/Ze6WJbgmv5A
   TdZBd/DnKYtl1zPBuMt4+CAaV2BmCFggyq07PaYQyI3RlSJGv6HCMcfL4
   bOig7SGijJP5J5LrY6FbQM/LmYvjdM9ZTBSA5tWWCcEFlVxCw65+mAMEm
   tQk5VR0yhUKql6tiTlzGVgMNeWXcBED1aji6bVVO0WORKduRlYkC1Pg16
   0xIfInRcVMit5QyrAApiRreJosGm5fDSI7Sf/uIk+1lRJmAk3Jqa1qfgm
   aRz98suLFE1PW4a+uooMSvAo611KbGxbOKSKddKrYGoArWd4UVO8e+KbB
   Q==;
X-CSE-ConnectionGUID: fE50m2dOTb2NcqgeS4U1Yw==
X-CSE-MsgGUID: foOINS7bS1KQizB+S2QCCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88986111"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88986111"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:05 -0700
X-CSE-ConnectionGUID: MhC30tGXSuqz9xY+FeCDeA==
X-CSE-MsgGUID: /TwEtWkzT/C+zhbHSdB4Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234505112"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless-next 02/15] wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
Date: Wed, 29 Apr 2026 14:40:36 +0300
Message-Id: <20260429143813.4ac207c60ebb.Ic4b1c90552497b7ff2616651a408e5fe8bde7b99@changeid>
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
X-Rspamd-Queue-Id: 1FC0F493A58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35600-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,sipsolutions.net:email]

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


