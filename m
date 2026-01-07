Return-Path: <linux-wireless+bounces-30485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36110CFE721
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 478873066DFC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF673341AB1;
	Wed,  7 Jan 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kQPS+nME"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932133EAE6
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795837; cv=none; b=SQc77hSQzsVyBEzUkzi2zsKTvfrDnsemHiJcKv5qUuwkFKraxQYavgo9q4G1IrOwkV2vXXy59uBCMkcMMQHHwr4pfaqyCqMj+6yW/Fr45hrbyP7aOqOPejVW7XM+q/2noWdG1Rj9nSqYoCsqtdMRIuV9WPb0mWs6AERxHXh1bJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795837; c=relaxed/simple;
	bh=KbJE16uIiqwBG9fTxAPAIWiwLQi4Ruep3tPGwzIMw+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDQlgnMZza/KC2jo4VRjn0Bqb9Uo86jCczJeUjB26jAQzHSchTu8mt4hJx+15RGNls34WUjhyXsW62LQTzRYun7Mhu7vGQ3t0RMiE8cGPBDje56AMXV1MRiKFp+BLXYVIFNcgM1/TS4vkp0w/JcV6Jt6GnwxxB6qf1NCVRPa/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kQPS+nME; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CuHgmyOYXYS52gXmD5GV4mP0rVqPjzdPPT8BSB8EGZc=;
	t=1767795836; x=1769005436; b=kQPS+nMEn63TNcTSmqEw1yQ6bW+kELmL5hkO7mvR5ThyUvL
	Y9rQ5UOpMITp/s8BolW/sXaVCrb7TfnRY5m7nlUvD2Nak6Ns8WpKvQIveEtEYP1sDVTzcBXoFP1uz
	1Pn3y21tuNVZIUGo+T7ltZjgNJgs3b3UOQPCc+7c9OXCEZRxUOkDZTFkSV5Zdwyeqcjb4OvdG9Rkp
	Xa3CAKJWKOYzwYtvQv7y5fowIr+eNtCs+lz4wVZ+LsQWv2LLbN9a/goMJ6zhu/fRbToWfiMJfdGAu
	AI/EEq8tb/dTevxc05QF4q0xzYNBVR9N8lIWkdFmz2LpelLUmRP/Q1n14c/Pm8eA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS1-00000005agF-1sul;
	Wed, 07 Jan 2026 15:23:53 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 23/46] wifi: mac80211: improve station iteration ergonomics
Date: Wed,  7 Jan 2026 15:22:22 +0100
Message-ID: <20260107152325.609692cd6588.I4470024f7404446052564b15bcf8b3f1ada33655@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Right now, the only way to iterate stations is to declare an
iterator function, possibly data structure to use, and pass all
that to the iteration helper function. This is annoying, and
there's really no inherent need for it.

Add a new for_each_station() macro that does the iteration in
a more ergonomic way. To avoid even more exported functions, do
the old ieee80211_iterate_stations_mtx() as an inline using the
new way, which may also let the compiler optimise it a bit more,
e.g. via inlining the iterator function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 29 +++++++++++++++++++++++++----
 net/mac80211/util.c    | 23 +++++++++++++++++------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f7cdfb6b6d0c..f5abc0297e7f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6340,6 +6340,20 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
 						struct ieee80211_sta *sta),
 				       void *data);
 
+struct ieee80211_sta *
+__ieee80211_iterate_stations(struct ieee80211_hw *hw,
+			     struct ieee80211_sta *prev);
+
+/**
+ * for_each_station - iterate stations under wiphy mutex
+ * @sta: the iterator variable
+ * @hw: the HW to iterate for
+ */
+#define for_each_station(sta, hw)					\
+	for (sta = __ieee80211_iterate_stations(hw, NULL);		\
+	     sta;							\
+	     sta = __ieee80211_iterate_stations(hw, sta))
+
 /**
  * ieee80211_iterate_stations_mtx - iterate stations
  *
@@ -6352,10 +6366,17 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
  * @iterator: the iterator function to call
  * @data: first argument of the iterator function
  */
-void ieee80211_iterate_stations_mtx(struct ieee80211_hw *hw,
-				    void (*iterator)(void *data,
-						     struct ieee80211_sta *sta),
-				    void *data);
+static inline void
+ieee80211_iterate_stations_mtx(struct ieee80211_hw *hw,
+			       void (*iterator)(void *data,
+						struct ieee80211_sta *sta),
+			       void *data)
+{
+	struct ieee80211_sta *sta;
+
+	for_each_station(sta, hw)
+		iterator(data, sta);
+}
 
 /**
  * ieee80211_queue_work - add work onto the mac80211 workqueue
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d123043d5cb9..79ef74744357 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -892,18 +892,29 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(ieee80211_iterate_stations_atomic);
 
-void ieee80211_iterate_stations_mtx(struct ieee80211_hw *hw,
-				    void (*iterator)(void *data,
-						     struct ieee80211_sta *sta),
-				    void *data)
+struct ieee80211_sta *
+__ieee80211_iterate_stations(struct ieee80211_hw *hw,
+			     struct ieee80211_sta *prev)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct sta_info *sta = NULL;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	__iterate_stations(local, iterator, data);
+	if (prev)
+		sta = container_of(prev, struct sta_info, sta);
+
+	sta = list_prepare_entry(sta, &local->sta_list, list);
+	list_for_each_entry_continue(sta, &local->sta_list, list) {
+		if (!sta->uploaded)
+			continue;
+
+		return &sta->sta;
+	}
+
+	return NULL;
 }
-EXPORT_SYMBOL_GPL(ieee80211_iterate_stations_mtx);
+EXPORT_SYMBOL_GPL(__ieee80211_iterate_stations);
 
 struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev)
 {
-- 
2.52.0


