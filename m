Return-Path: <linux-wireless+bounces-10980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E599486AA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 02:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9774C1C21DDF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 00:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B6EBE;
	Tue,  6 Aug 2024 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="qA/wBazy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD28184D
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904885; cv=none; b=H5J5ic4Vp3dYfX5DFdMzTIeCZcX1AYYoBRzAY4fgdvcq5CYfFdjqMtFXxgCfLttXrNQqzhY+zb4YUyTFzkhcwRNZ5XAcGWvCNZmlUt/kU7kla1qXOOLD0/ImDbUR9ldQy4hS4ot8lBzCRYbM64xH2zDDGIt9zj1oK7i226KHa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904885; c=relaxed/simple;
	bh=6rpFksuZv0QPk4Gmly0DRa7c/BanhtLnZg7XdGCPb+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjdCQgjs9bjCFZU8RFD3/AmKPoXaQVzgWrZkrRqn6AkURLHBxgzGCXA4MnQBmX0OlNuJm7MeVcY2to6/q8pzCn6FbdKAgADaDETYPIvlg3YUwaOh6bcYzvQanKpvEUvKZNO65sefJPysLOdmMkY5vDnKhJiiqU38TZC3vkvb9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=qA/wBazy; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 23C0818007C;
	Tue,  6 Aug 2024 00:41:15 +0000 (UTC)
Received: from carkeek.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B59AE13C2B1;
	Mon,  5 Aug 2024 17:41:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B59AE13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1722904874;
	bh=6rpFksuZv0QPk4Gmly0DRa7c/BanhtLnZg7XdGCPb+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qA/wBazy8DtqrN3OjA8GZT25B0diOI4CIjZH5hycVhe4gw54ynpT6B1M9karvSOQQ
	 Dr9sxtSySF+E170rYggc3OTOfgWFyQTNfnQJkRSkMGB+KkYgXZXQMggXCGJPhLCgHT
	 ph69htOm2DgBFYeFSyDog171xsKdN2rxKiVfB6z4=
From: Rory Little <rory@candelatech.com>
To: kvalo@kernel.org,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 1/2] wifi: mac80211: Add non-atomic station iterator.
Date: Mon,  5 Aug 2024 17:40:23 -0700
Message-Id: <20240806004024.2014080-2-rory@candelatech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806004024.2014080-1-rory@candelatech.com>
References: <20240806004024.2014080-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1722904876-MP_zBZic_eJW
X-MDID-O:
 us5;ut7;1722904876;MP_zBZic_eJW;<rory@candelatech.com>;9989741adba0574bb335b9e9d00002fb

Drivers may at times want to iterate their stations with a function
which requires some non-atomic operations.

ieee80211_iterate_stations_mtx() introduces an API to iterate stations
while holding that wiphy's mutex. This allows the iterating function to
do non-atomic operations safely.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 include/net/mac80211.h | 18 ++++++++++++++++++
 net/mac80211/util.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e1580360e099..6c8a2dd53243 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6313,6 +6313,24 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
 				       void (*iterator)(void *data,
 						struct ieee80211_sta *sta),
 				       void *data);
+
+/**
+ * ieee80211_iterate_stations_mtx - iterate stations
+ *
+ * This function iterates over all stations associated with a given
+ * hardware that are currently uploaded to the driver and calls the callback
+ * function for them. This version can only be used while holding the wiphy
+ * mutex.
+ *
+ * @hw: the hardware struct of which the interfaces should be iterated over
+ * @iterator: the iterator function to call
+ * @data: first argument of the iterator function
+ */
+void ieee80211_iterate_stations_mtx(struct ieee80211_hw *hw,
+				    void (*iterator)(void *data,
+						     struct ieee80211_sta *sta),
+				    void *data);
+
 /**
  * ieee80211_queue_work - add work onto the mac80211 workqueue
  *
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ef7133ac13f0..e12c871f0477 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -940,6 +940,23 @@ static void __iterate_stations(struct ieee80211_local *local,
 	}
 }
 
+static void __iterate_stations_safe(struct ieee80211_local *local,
+				    void (*iterator)(void *data,
+						     struct ieee80211_sta *sta),
+				    void *data)
+{
+	struct sta_info *sta, *sta_temp;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	list_for_each_entry_safe(sta, sta_temp, &local->sta_list, list) {
+		if (!sta->uploaded)
+			continue;
+
+		iterator(data, &sta->sta);
+	}
+}
+
 void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
 			void (*iterator)(void *data,
 					 struct ieee80211_sta *sta),
@@ -953,6 +970,19 @@ void ieee80211_iterate_stations_atomic(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(ieee80211_iterate_stations_atomic);
 
+void ieee80211_iterate_stations_mtx(struct ieee80211_hw *hw,
+				    void (*iterator)(void *data,
+						     struct ieee80211_sta *sta),
+				    void *data)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	__iterate_stations_safe(local, iterator, data);
+}
+EXPORT_SYMBOL_GPL(ieee80211_iterate_stations_mtx);
+
 struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
-- 
2.34.1


