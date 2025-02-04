Return-Path: <linux-wireless+bounces-18427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F97A27773
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815D1164E29
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97422144CB;
	Tue,  4 Feb 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="o1JbwMlv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2773201027
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687383; cv=none; b=UaBgqPpMcmFzi7cyeiD3O09KOd+Sk5ub4Fn4zU+R1qz7uE0d9hHk0Cp7lKsC7BXPkzyJUWhIIT3vLxqCj+altQJS8l5BQGsdgPFYUqyk8KN6uao9yUFLWkR2NB5Nf9JH5dRZstXHZEWN2VZU2DlNs4vbFNERoQtmB4a24wvfRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687383; c=relaxed/simple;
	bh=Q7QHUEo5DPSxH7VvYDSWmsHXxza6E1IMneBmPhRvGu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ute2ETDoaqhWEgPUCwUPnoMM7ZGu8eH//FdicgVmgvkkvhGAJTdsUM+Yzzhher/3PJdxmHw1I44b0wDN7V18lGEUlAU9l4nXkkd/R/udJ8xIDDGXsNfAk8BPAaeeraPCBwCrsWCQn6yCBS+5+S9tML8CTKRVVQ1J2hsuEIm/yos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=o1JbwMlv; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1738687376;
	bh=Q7QHUEo5DPSxH7VvYDSWmsHXxza6E1IMneBmPhRvGu8=;
	h=From:To:Cc:Subject:Date;
	b=o1JbwMlvxFWmWkQH+/s+kis9IbXNXVCUEGvp8Qv/gcqK/BBNlYGv34q31c25X/PWh
	 DXQnzf5nmmGbnYruCvLNl3xChs2riXQsgs08rcMzpMBeAz5Ev7hqi2qZhjFhSDjquH
	 PZ0UfujLRmKqxKFyCT4WY1Y4d+nox7xjbWeXtgg4=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH] wifi: mac80211: remove debugfs dir for virtual monitor
Date: Tue,  4 Feb 2025 17:42:40 +0100
Message-ID: <20250204164240.370153-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't call ieee80211_debugfs_recreate_netdev() for virtual monitor
interface when deleting it.

The virtual monitor interface shouldn't have debugfs entries and trying
to update them will *create* them on deletion.

And when the virtual monitor interface is created/destroyed multiple
times we'll get warnings about debugfs name conflicts.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
That was a bit more tricky than expected:

local->monitor_sdata is normally already deleted when we call
drv_remove_interface. And we can't simply skip the call for all monitor
interfaces...

And one additional remark:
My iwlmvm card is not taking it well when I bring down the monitor interface
while TXing on it. The firmware crashes for my "Alder Lake-S PCH CNVi WiFi"
card.

But that also happens with unpatched kernels and so I don't care
much about that. I can make a bug report, if that's news and want you to
look into that.

Alexander
---
 net/mac80211/driver-ops.c | 10 ++++++++--
 net/mac80211/iface.c      | 11 ++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 299d38e9e863..2fc60e1e77a5 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -116,8 +116,14 @@ void drv_remove_interface(struct ieee80211_local *local,
 
 	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
 
-	/* Remove driver debugfs entries */
-	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
+	/*
+	 * Remove driver debugfs entries.
+	 * The virtual monitor interface doesn't get a debugfs
+	 * entry, so it's exempt here.
+	 */
+	if (sdata != local->monitor_sdata)
+		ieee80211_debugfs_recreate_netdev(sdata,
+						  sdata->vif.valid_links);
 
 	trace_drv_remove_interface(local, sdata);
 	local->ops->remove_interface(&local->hw, &sdata->vif);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7d3ebfcb8c2b..e627e2df3038 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1203,16 +1203,17 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 		return;
 	}
 
-	RCU_INIT_POINTER(local->monitor_sdata, NULL);
-	mutex_unlock(&local->iflist_mtx);
-
-	synchronize_net();
-
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	ieee80211_link_release_channel(&sdata->deflink);
 
 	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 		drv_remove_interface(local, sdata);
 
+	RCU_INIT_POINTER(local->monitor_sdata, NULL);
+	mutex_unlock(&local->iflist_mtx);
+
+	synchronize_net();
+
 	kfree(sdata);
 }
 
-- 
2.48.1


