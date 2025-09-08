Return-Path: <linux-wireless+bounces-27093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BD1B48BD9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98B57AF8C6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1B3019CC;
	Mon,  8 Sep 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df9rw+Eb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76549307AF8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330035; cv=none; b=Y/Xurg8aGxJd6VHIb0vCgMbS6CmOse11P1UYpcXbwOphHvmp4X6PZJa6AT9m+tJL542mZNQc0fhDFjqZq43V9C6Xfth1hSYnyE/gkX4kyCCn8ktity1ybrerkqmnsS+309JXcgSyjdX7Noi9SgslGc9UaBu7Clkkn3B/60V10Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330035; c=relaxed/simple;
	bh=xb9c2Xlcw4gZefjwxbs210xJBuWHcowpv09i/btKZWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=paQ8z+feLvINLq5Hfd+9HsROsYVMpQ1/vsrd8OZRh2omecoZNz9lMS150vMSyh8A+BZNalAQcGpxR1XPpLjUk55HfElVsmEv2jAq8n6EnZnswDBV+l+iF/41+lXb503KajmX72oKi5AE/IliO0VrbHErfW0KyODbNbc0JiaFy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df9rw+Eb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330033; x=1788866033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xb9c2Xlcw4gZefjwxbs210xJBuWHcowpv09i/btKZWA=;
  b=Df9rw+EbhjfGk3A/oAeGTW5m4wA7RLcNt0PmPViI6vjvX0W5e65wF9aQ
   zEpchLK4vS+9++YQcbkaB7A78sEMuK53t9S64gyoIWbnEQ49cjtUcZQe1
   UxFZ/VS7p9XA0/Ops0TWE14uY+4fmKxsef9nmAcO8oa7IoiTui82zXMuN
   0mTQxH1Pe11mnIT/Vz5iQgVI83xho0Bl5brfgGySJIQqqvxYmwvURuuuZ
   GVPOLzx4bPiQXqQhV6vfEta37Lf20+xETbAHQrfLGvfQ5Uji3aCKoEHD7
   9EvP9Xp7Og+KWawQvEc830UEQ24L68/S5dJhuvxJRGbzX7yl7PXkJmIfR
   A==;
X-CSE-ConnectionGUID: aGjqtjc3T0G6XmCptDU2Pw==
X-CSE-MsgGUID: grsX21dmQBuIZZiL/2uOqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037918"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037918"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:52 -0700
X-CSE-ConnectionGUID: RZ6JFxtBRwmpcr6IV+VnzA==
X-CSE-MsgGUID: 8irJEf2GSB+MUnLJwdQotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126604"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/14] wifi: mac80211: Get the correct interface for non-netdev skb status
Date: Mon,  8 Sep 2025 14:13:05 +0300
Message-Id: <20250908140015.5252d2579a49.Id4576531c6b2ad83c9498b708dc0ade6b0214fa8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The function ieee80211_sdata_from_skb() always returned the P2P Device
interface in case the skb was not associated with a netdev and didn't
consider the possibility that an NAN Device interface is also enabled.

To support configurations where both P2P Device and a NAN Device
interface are active, extend the function to match the correct
interface based on address 2 in the 802.11 MAC header.

Since the 'p2p_sdata' field in struct ieee80211_local is no longer
needed, remove it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/iface.c       | 16 +---------------
 net/mac80211/status.c      | 21 +++++++++++++++++++--
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5ccb22b5ecf7..8ddd8fa3f51f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1675,8 +1675,6 @@ struct ieee80211_local {
 	struct idr ack_status_frames;
 	spinlock_t ack_status_lock;
 
-	struct ieee80211_sub_if_data __rcu *p2p_sdata;
-
 	/* virtual monitor interface */
 	struct ieee80211_sub_if_data __rcu *monitor_sdata;
 	struct ieee80211_chan_req monitor_chanreq;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4a9175d9f51c..a7873832d4fa 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -620,10 +620,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 		spin_unlock_bh(&sdata->u.nan.func_lock);
 		break;
-	case NL80211_IFTYPE_P2P_DEVICE:
-		/* relies on synchronize_rcu() below */
-		RCU_INIT_POINTER(local->p2p_sdata, NULL);
-		fallthrough;
 	default:
 		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
 		/*
@@ -1414,6 +1410,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		ieee80211_recalc_idle(local);
 
 		netif_carrier_on(dev);
+		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
 		break;
 	default:
 		if (coming_up) {
@@ -1477,17 +1474,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			sdata->vif.type != NL80211_IFTYPE_STATION);
 	}
 
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_P2P_DEVICE:
-		rcu_assign_pointer(local->p2p_sdata, sdata);
-		break;
-	case NL80211_IFTYPE_MONITOR:
-		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
-		break;
-	default:
-		break;
-	}
-
 	/*
 	 * set_multicast_list will be invoked by the networking core
 	 * which will check whether any increments here were done in
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index a362254b310c..4b38aa0e902a 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2021-2024  Intel Corporation
+ * Copyright 2021-2025  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -572,6 +572,7 @@ static struct ieee80211_sub_if_data *
 ieee80211_sdata_from_skb(struct ieee80211_local *local, struct sk_buff *skb)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 
 	if (skb->dev) {
 		list_for_each_entry_rcu(sdata, &local->interfaces, list) {
@@ -585,7 +586,23 @@ ieee80211_sdata_from_skb(struct ieee80211_local *local, struct sk_buff *skb)
 		return NULL;
 	}
 
-	return rcu_dereference(local->p2p_sdata);
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_P2P_DEVICE:
+			break;
+		case NL80211_IFTYPE_NAN:
+			if (sdata->u.nan.started)
+				break;
+			fallthrough;
+		default:
+			continue;
+		}
+
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return sdata;
+	}
+
+	return NULL;
 }
 
 static void ieee80211_report_ack_skb(struct ieee80211_local *local,
-- 
2.34.1


