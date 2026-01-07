Return-Path: <linux-wireless+bounces-30506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4ACFF07C
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 18:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6318635AB91E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37A345CA8;
	Wed,  7 Jan 2026 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jEtc6V5c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3D345754
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795858; cv=none; b=n/2ShxWvaAUqvwlNb27/AK+w6vbc54/Fqvr6/QhE3ozQ3hmLBD7G4Y/RTE+a1zswC24z+Vm/zC+QtSnonxmZlsAs7Lnggt0oZo13GodO0W8g+ocv2MEcSS7rcCrS7QkUtDR0CXj9WqnoXFbOGSVtB4bJRvU4oGKwb5RReLB2GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795858; c=relaxed/simple;
	bh=SFKX3z490ImFviavaKdKSwwWWR3xay1Dl5/aoGZS4bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKg5HpGxS66EX09UsMM4m3Uz2wyr4CF2bx2pY0EH0EB3rT6L4tBzScI/y+5Ci1hX4yc95DkGadv7ExLuPq1NJErxxH7qlM/uDRKgkiy9Z1UJXV0PeEeg8xyMgeFDL2tCpiQCJZI7aQiLl0qCgO7jclYyerdEmVMMk3RQI+nV02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jEtc6V5c; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OUnPsMV2mnmYyH5fthyJzqBRFImkOJLD0OSdQThfDjQ=;
	t=1767795856; x=1769005456; b=jEtc6V5cNyQercpTHuytZUosmsZZwS0xrBYucJNBeB1kikX
	y/kqthYKrT7b9OQPQ7k4HwYRygo4xo/p3XixXlKiQagkxQLfzffClCV8iovr+lqi/WGFk4hxl2MbK
	qkWpz0CIYaSfD/YhIoFWp/7lG3ZhStrNYD+Wp2BixQ1jftZclQywP/y2nFg0Dqh0v3A+Q/sT+AUlB
	s7to9qPUzm1+AjJMd+nTVTw431fMO5CQV/Awhj34Ne+gGP5YvxR6HxDSVx3SQmwX5PWbQQDg1KO8/
	zzAlEyfK6UB71hHIYXJ5bIfh86scPbfG+FniQ/8ddoqQHax0Cb+Vq10kP76bxc3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSM-00000005agF-08N6;
	Wed, 07 Jan 2026 15:24:14 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 44/46] wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
Date: Wed,  7 Jan 2026 15:22:43 +0100
Message-ID: <20260107152325.07046779d48c.Ic4b1c90552497b7ff2616651a408e5fe8bde7b99@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Allow TX/RX of action frames (for NAN action frames) over
NAN Data interfaces to support cases where there's a secure
NDP and NAFs may be exchanged over that.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c       | 6 +++++-
 net/mac80211/offchannel.c | 9 +++++++--
 net/mac80211/tx.c         | 5 +++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0f05f6b2ff2f..b2a73d6c3ae3 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2017     Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <net/mac80211.h>
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
index ae82533e3c02..0e44a5a18f07 100644
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
index a9a360fe0161..b44ad3a48258 100644
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
@@ -6332,7 +6332,8 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_band band;
 
 	rcu_read_lock();
-	if (sdata->vif.type == NL80211_IFTYPE_NAN) {
+	if (sdata->vif.type == NL80211_IFTYPE_NAN ||
+	    sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
 		band = NUM_NL80211_BANDS;
 	} else if (!ieee80211_vif_is_mld(&sdata->vif)) {
 		WARN_ON(link_id >= 0);
-- 
2.52.0


