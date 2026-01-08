Return-Path: <linux-wireless+bounces-30572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC2D043C6
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B325430F03DC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC53E9F9D;
	Thu,  8 Jan 2026 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="al3EQXet"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCB135A53
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879279; cv=none; b=kqmq9cFUME+wdplQAL8W5LBpNf9jwAeF6dPHETA49ilrfWBcGpsLTHk/mSuebIgV6CMvtKEPYNoQUCw1Mj+uBshOPzMn7r/U9KuebJejgFUyufv5OI9+S4Iiaeqp7Hb4VFNzkUtcwQmXfVcTyi7qFUHNTkynbGiY/Sv6p9nP/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879279; c=relaxed/simple;
	bh=FGeaka978Z5V3K02WnRG6g6xycfci/TzOLrgyVjNjLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYgYRl5v/Fg8iNwRM/SJEMqWCgfGsP/NMSxJl8+XmDsKz0Q7E5JkrNGKXdY23y24g5hiOjiKZlJC9MHSoDkN+iImcKjQkUfyXjbV4GqIl5OAv832Q0ATfIGkAsKDSa3zOiNB7l1hjndDUOPTUH7BPYQGJwRJJeuamuLrnQk4quA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=al3EQXet; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=scBvNIhLWSDXdaccajs59FpABnKRCgD0l2wemt5/Xss=;
	t=1767879277; x=1769088877; b=al3EQXetKXurH6aP4UkcNZ3o/r5ccd+Om19gy8TRP8b7Zth
	6b8Qp8X2b5F0V9MjQ2jvWhaKxn5q2ZPocUJc5eZmieA3F9uDebR0qp8V8XbRHS8Rybm6eMmlPeuVw
	Q5l2siJaMwF1qn0uwL5tx9GgX7kSwXXBD/KeETz4/8gld18cdEmG5IispzuyZ+xnPTAEIQDt7+Hgo
	l2HrR7gS9PqTar0T/jFlG3fhVlsjwcDurpr55OO+rJLjNKjGsLNi8F11uiVZ8Fe8UlvpPtQ6+ZLtb
	yd7TtKYjE3fLguXvnraFAKFK9M3C5hY18Rn4CF7gk8oxuNt8gfVC0Ju3qtZ1+BCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdq9r-00000006WWB-0ETS;
	Thu, 08 Jan 2026 14:34:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: improve station iteration ergonomics
Date: Thu,  8 Jan 2026 14:34:32 +0100
Message-ID: <20260108143431.d2b641f6f6af.I4470024f7404446052564b15bcf8b3f1ada33655@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108143431.f2581e0c381a.Ie387227504c975c109c125b3c57f0bb3fdab2835@changeid>
References: <20260108143431.f2581e0c381a.Ie387227504c975c109c125b3c57f0bb3fdab2835@changeid>
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
index 88ae5d60d9b9..36daccef6554 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6338,6 +6338,20 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
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
@@ -6350,10 +6364,17 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
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
index 13f2e911f330..b95f7d50e77d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -880,18 +880,29 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
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


