Return-Path: <linux-wireless+bounces-35782-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM/tDXUO92mQbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35782-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EED4B500D
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15BDD3002D11
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764B3AEF51;
	Sun,  3 May 2026 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBZtaabN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131E3AE6F5
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798766; cv=none; b=oTKitDzl5+gBntteQPMsyZ13VPQox4WGO2/B/SWJj68uqlUvTW9/gMIryA38An7vRYRAbHWKVctXdovmWOszst2eS3S+5uD8yiXId+dleVnBmaVdPEZAmxREMo6d57Dr6z77Ng1cGPoUlzub0nTf3UKz3WUwPIl9R9jcqZCDbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798766; c=relaxed/simple;
	bh=aZW59m5rRAKBh3zYOBYEB73IQUXaW4YryxqsimC8Fko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWodbZl1LBKjrXPWORGh/ueQRVOBIpChZuLn7Rj1vAWrKmCfUL9Eme0A6ty9xsCCPwTjXT/3qDQJ5wZx8tc600qYNNtFQ8KZduaKDxFmjxBLMXbS7m8bNwB/kSKSOBOfs4vEl/hVZf7UEGU5I9nBCHKsoUGKOAf6GYh6BEcJCIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBZtaabN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777798765; x=1809334765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZW59m5rRAKBh3zYOBYEB73IQUXaW4YryxqsimC8Fko=;
  b=QBZtaabNSBs+1wamzrKHkVh3PoWZRtltXc0dpfecU0wQfANJuc+I2Ldg
   60luiyyh7A51p5Vfw+G3Nfwg8Py4+IA9P34kdpTYbff+bJMOibGWMbTm7
   1fN2Eidbysoi/3/S9SjzbgTN4cSxQl+91MkQHmy+0L9Z5kb4DDMJJU0wD
   Rj8qMQpBYv4AuZQdXYI/5yAVAWmxJ+JEAD7tnGIAFB96Se+dAZ7rgFrin
   NXrxI3CXh+tCrcWATEBICmc01pq/sVuLe/2vwR9yDUfnwB5E+mSQV0VAc
   fK2KJkaTuUsb5/pluEVZguYBxMqNS9WCgdR2bFPR+pxJgejk0B157js/q
   w==;
X-CSE-ConnectionGUID: MkxKj3FbRaG2epNYg/xvQw==
X-CSE-MsgGUID: 6gGU2eZERSqxinwg5sNZpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="89380339"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="89380339"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:23 -0700
X-CSE-ConnectionGUID: KSL4E321Sv+m76Clwh5FIg==
X-CSE-MsgGUID: jUwqiBraRaqx3h+hLTBqvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="235123767"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 wireless-next 02/15] wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
Date: Sun,  3 May 2026 11:58:54 +0300
Message-Id: <20260503115440.4ac207c60ebb.Ic4b1c90552497b7ff2616651a408e5fe8bde7b99@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
References: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35EED4B500D
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
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35782-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:email,sourmilk.net:email]

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


