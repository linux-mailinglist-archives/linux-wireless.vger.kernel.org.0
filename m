Return-Path: <linux-wireless+bounces-18040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006DA1DAB2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54347A2B82
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C916CD33;
	Mon, 27 Jan 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="UOXeY37b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56315D5C4
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995872; cv=none; b=YrlVorUjOMJsrjg/7bhX9iymU0w+BK9Lz6IdpTzR9Q1bk5mkM3rBUu5SbV/+Rcf8BRPTlG97K638UyOILX2e8dEQsn44lOfd7MR1hMH2HSYww2VBHtQpST51/yRgNtHyOS7BM/EH/VK+V4WnQ6SG9Fiz1BNhrBuviLp0cOruy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995872; c=relaxed/simple;
	bh=0P39nBFonvA472ZjtFhVRectDaTp6bwcemm9aXtbqFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0J8D9pw0FbX9wKEaSkY9r2AlvMYNVQR8deonCG6pSw1kO9ug9khdu9mHvg53l4nSOZ40fB9YLmtNuVILBYKAEBD0M5f6E6bj5v6h0KluIvpSPqrY8X6Gis94Y6xT2ldYZebhY3TWStOk0hja7LaAzcOkMGzccK8OoJRltZ6jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=UOXeY37b; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995297;
	bh=0P39nBFonvA472ZjtFhVRectDaTp6bwcemm9aXtbqFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UOXeY37bViPkNBlktNAtKJ4XzHqisjvnO7R772Xgy2bdm4HIQn6qpNikrECIXs06e
	 ODGtWsMy42mLWmKDTzRHoS5ESGgTAERRv7NlNLNHzS0M30jAo4wB2cGsQLPDRzc7/n
	 M+idnOjAcISzBlUnevC2V5yy0KhnpguJkKgBU6eY=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [RFC PATCH 02/13] wifi: mac80211: Fix debugfs handling for virtual monitor
Date: Mon, 27 Jan 2025 17:26:14 +0100
Message-ID: <20250127162625.20747-3-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create debugfs entry for the virtual monitor interface when it's
created and delete them again when it's deleted again.
Instead of creating them on deletion, when calling
drv_remove_interface().

This fixes debugfs name collisions when deleting and re-creating a
monitor interface with the same name.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
A user can still create collisions in the debugfs when using names like
e.g. phy0-monitor for another monitor interface. And then trigger the
creation of the virtual monitor interface... But I guess that's ok and
not worth the hassle to fix it.
---
 net/mac80211/iface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b0c02942dac3..1a2b682c452c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1162,6 +1162,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		}
 	}
 
+	ieee80211_debugfs_recreate_netdev(sdata, false);
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
@@ -1212,6 +1213,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 		return;
 	}
 
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	RCU_INIT_POINTER(local->monitor_sdata, NULL);
 	mutex_unlock(&local->iflist_mtx);
 
@@ -1222,6 +1224,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 		drv_remove_interface(local, sdata);
 
+	ieee80211_debugfs_remove_netdev(sdata);
 	kfree(sdata);
 }
 
-- 
2.48.1


