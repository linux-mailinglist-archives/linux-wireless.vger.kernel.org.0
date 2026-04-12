Return-Path: <linux-wireless+bounces-34656-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM/fGQmM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34656-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88F3E3BAF
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B9243002B79
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAA437BE7B;
	Sun, 12 Apr 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxPyPMGM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C636B071
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995901; cv=none; b=uE5WSTctG+2fD8DiIAVUvyTIemFLLQMSLtJwmKOtNmf0jhSPf36pr7et959i+tOe7eHxmBSH0I8QehDImBP9QTwqIiY+SGtSLKGpKeMrlqW07cOabUvB+lLMxrkHvlz3hHLx4rZUDgY1j1jx0X8++YqXZ0FBCn23dr2H29e+L/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995901; c=relaxed/simple;
	bh=2QtJxFYOP4rMvx/PMaTxvMJne7JJuQF2BYSDwA2TyKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bc8rteluavn+2QvvhHjYs7QwJTpO92n7hE680YHihujQFthq8qtVMd1GSEYqgActg7XqKUxCdRXvEVQkrfDC3oA0o+9eJ7/uINZbrTpvUoTEt5N/yqGNNV0dhzq/wkjHwbfKhjDNdhNwBw5uGEH2/jX7syKOUc9l5JbsaILsDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxPyPMGM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995899; x=1807531899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2QtJxFYOP4rMvx/PMaTxvMJne7JJuQF2BYSDwA2TyKE=;
  b=YxPyPMGMB2195UxGFmuxoTjCBgz31JqxoFVd8K2gQ66j6aDCsh9SRa+m
   ZDJ9StAbZpjAPx7dTsFcifw8KL9X6VCtON+XtE+r5rDva6ueih3N4Gcj7
   RnUqp4ZVB8a2vnVIUPZyfbF3U1tdkH/DkVzHtWBeHv7ztDs1vpt0WkYjb
   DcxxTN/54XGyewjogRXbHYzYP3PMfPjyCdPDG0Vz6PnQy3JFHmtF9Ah34
   07XG4IFLHRQ6fD5yt+Br8jNwRtyWoZcjTGiLWZKGKF2W88sBHbDYKFZ9i
   Xsotinq5ZA+h7jzOiKhzeQ30c9tUztHsc4a5Eo+rYng2cKzhKu+jZMkLK
   A==;
X-CSE-ConnectionGUID: fTFQKYWrToqDsrPTtGwBKA==
X-CSE-MsgGUID: If/rZ6vSROu7tYampi1Efw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028456"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028456"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:39 -0700
X-CSE-ConnectionGUID: GXdqDiGSRDKKNrbeMC1g5Q==
X-CSE-MsgGUID: D65+DEBuQlSiuI9+BxPdeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411883"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 02/15] wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
Date: Sun, 12 Apr 2026 15:11:11 +0300
Message-Id: <20260412150826.2c8f3b6c09d1.Ic4b1c90552497b7ff2616651a408e5fe8bde7b99@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34656-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D88F3E3BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index af5421dbb4c0..6ff36bd658e6 100644
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


