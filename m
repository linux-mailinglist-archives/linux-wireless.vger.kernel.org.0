Return-Path: <linux-wireless+bounces-30484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951DCFF604
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FB86300A3D6
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A2341079;
	Wed,  7 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f3lyGvwT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1533E369
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795836; cv=none; b=CjsDLtu1hsnkJPuUCCZRqPByXqJy6bEqXrDbe1Moi6pQO/sEwpFL1rasykEd98I5jT6mMOqPkB0Z3O0cfDwpEE2A6Q7dSiX6nl0LdOdaDRgVP/S02Q++GGgt/LfoAW9HkTE+MDwC836ZP4LNc6Ru1mHh+Kd53IQWYW1LZxpxzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795836; c=relaxed/simple;
	bh=vSxubMQCDsedQBlmF4ltgUrHZIhf4OG5gjZZk0pXaaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ba1t1+fehSb7Xl2ZsLpiJBtxB257HmDb7CmsBf6dmMVIHPka3aqmEoHubrL0snGTP+JTunObsnvQqXuNM8UDIW0IDboMgJZjMBd/4N4rq9pswUwNjOBGz8bjFQ/04PAuQJgvzPn+4vRK1KC3Rhzot5THeL/xBrLzPp2nM8Tcsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f3lyGvwT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=S/+yn6nLNRQbYDLKaxol8AhPh3FIqcESEmp4vzApxBo=;
	t=1767795834; x=1769005434; b=f3lyGvwTi80YknaM93TN0SbHvYnPsmZaSqcYyp8F7I5xTwN
	j4OdUcwsNOCwII0gHpApJjCYyHtXaC1Jh968UL7QyN00ika7fTs1UyecpnW+u3cq0xYS4UdFkSz+k
	ZsXEXRvcnJVInhvRJElZe+SS8migEI60LTRmEvzcV8OlcbDhJ42gDfIpzAo+070EKKF2bbfmqq9iD
	gQwFa2mEofq5nuod5v2nNlmfJwLgBbYvmg4kATTOiygmk1/Wy9XS7K0w9HTsja0BHDAxlWb4LyHw7
	avSntHNz2fazJVAgGWbPBGbQS9vwyfdG4EiqMJUbdaLYftZy4Mc10gQqu0HCgCnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS0-00000005agF-2aZD;
	Wed, 07 Jan 2026 15:23:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 22/46] wifi: mac80211: improve interface iteration ergonomics
Date: Wed,  7 Jan 2026 15:22:21 +0100
Message-ID: <20260107152325.e23a7429bbac.Ie387227504c975c109c125b3c57f0bb3fdab2835@changeid>
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

Right now, the only way to iterate interfaces is to declare an
iterator function, possibly data structure to use, and pass all
that to the iteration helper function. This is annoying, and
there's really no inherent need for it, except it was easier to
implement with the iflist mutex, but that's not used much now.

Add a new for_each_interface() macro that does the iteration in
a more ergonomic way. To avoid even more exported functions, do
the old ieee80211_iterate_active_interfaces_mtx() as an inline
using the new way, which may also let the compiler optimise it
a bit more, e.g. via inlining the iterator function.

Also provide for_each_active_interface() for the common case of
just iterating active interfaces.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 42 +++++++++++++++++++++++++++++-----
 net/mac80211/util.c    | 52 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 66f27b0c04a9..f7cdfb6b6d0c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6274,6 +6274,30 @@ void ieee80211_iterate_active_interfaces_atomic(struct ieee80211_hw *hw,
 						    struct ieee80211_vif *vif),
 						void *data);
 
+struct ieee80211_vif *
+__ieee80211_iterate_interfaces(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *prev,
+			       u32 iter_flags);
+
+/**
+ * for_each_interface - iterate interfaces under wiphy mutex
+ * @vif: the iterator variable
+ * @hw: the HW to iterate for
+ * @flags: the iteration flags, see &enum ieee80211_interface_iteration_flags
+ */
+#define for_each_interface(vif, hw, flags)				\
+	for (vif = __ieee80211_iterate_interfaces(hw, NULL, flags);	\
+	     vif;							\
+	     vif = __ieee80211_iterate_interfaces(hw, vif, flags))
+
+/**
+ * for_each_active_interface - iterate active interfaces under wiphy mutex
+ * @vif: the iterator variable
+ * @hw: the HW to iterate for
+ */
+#define for_each_active_interface(vif, hw)				\
+	for_each_interface(vif, hw, IEEE80211_IFACE_ITER_ACTIVE)
+
 /**
  * ieee80211_iterate_active_interfaces_mtx - iterate active interfaces
  *
@@ -6286,12 +6310,18 @@ void ieee80211_iterate_active_interfaces_atomic(struct ieee80211_hw *hw,
  * @iterator: the iterator function to call, cannot sleep
  * @data: first argument of the iterator function
  */
-void ieee80211_iterate_active_interfaces_mtx(struct ieee80211_hw *hw,
-					     u32 iter_flags,
-					     void (*iterator)(void *data,
-						u8 *mac,
-						struct ieee80211_vif *vif),
-					     void *data);
+static inline void
+ieee80211_iterate_active_interfaces_mtx(struct ieee80211_hw *hw,
+					u32 iter_flags,
+					void (*iterator)(void *data, u8 *mac,
+							 struct ieee80211_vif *vif),
+					void *data)
+{
+	struct ieee80211_vif *vif;
+
+	for_each_interface(vif, hw, iter_flags | IEEE80211_IFACE_ITER_ACTIVE)
+		iterator(data, vif->addr, vif);
+}
 
 /**
  * ieee80211_iterate_stations_atomic - iterate stations
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c93ffccb27e8..d123043d5cb9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -812,20 +812,56 @@ void ieee80211_iterate_active_interfaces_atomic(
 }
 EXPORT_SYMBOL_GPL(ieee80211_iterate_active_interfaces_atomic);
 
-void ieee80211_iterate_active_interfaces_mtx(
-	struct ieee80211_hw *hw, u32 iter_flags,
-	void (*iterator)(void *data, u8 *mac,
-			 struct ieee80211_vif *vif),
-	void *data)
+struct ieee80211_vif *
+__ieee80211_iterate_interfaces(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *prev,
+			       u32 iter_flags)
 {
+	bool active_only = iter_flags & IEEE80211_IFACE_ITER_ACTIVE;
+	struct ieee80211_sub_if_data *sdata = NULL, *monitor;
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	__iterate_interfaces(local, iter_flags | IEEE80211_IFACE_ITER_ACTIVE,
-			     iterator, data);
+	if (prev)
+		sdata = vif_to_sdata(prev);
+
+	monitor = rcu_dereference_check(local->monitor_sdata,
+					lockdep_is_held(&hw->wiphy->mtx));
+	if (monitor && monitor == sdata)
+		return NULL;
+
+	sdata = list_prepare_entry(sdata, &local->interfaces, list);
+	list_for_each_entry_continue(sdata, &local->interfaces, list) {
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_MONITOR:
+			if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) &&
+			    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+				continue;
+			break;
+		case NL80211_IFTYPE_AP_VLAN:
+			continue;
+		default:
+			break;
+		}
+		if (!(iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL) &&
+		    active_only && !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
+			continue;
+		if ((iter_flags & IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER) &&
+		    !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
+			continue;
+		if (ieee80211_sdata_running(sdata) || !active_only)
+			return &sdata->vif;
+	}
+
+	if (monitor && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
+	    (iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL || !active_only ||
+	     monitor->flags & IEEE80211_SDATA_IN_DRIVER))
+		return &monitor->vif;
+
+	return NULL;
 }
-EXPORT_SYMBOL_GPL(ieee80211_iterate_active_interfaces_mtx);
+EXPORT_SYMBOL_GPL(__ieee80211_iterate_interfaces);
 
 static void __iterate_stations(struct ieee80211_local *local,
 			       void (*iterator)(void *data,
-- 
2.52.0


