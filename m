Return-Path: <linux-wireless+bounces-18416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DEA271CB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 13:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 10DBB1883818
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816E20F06E;
	Tue,  4 Feb 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="QtjqusU6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F220F068
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671988; cv=none; b=Vh9tIxmUgkSJTDx1yQBHsn4ieBMXo/wqb7u+XTnfGjBkPPqOpP4w/BLLNmMSyFChpY3Ix19mBMeiJR1K717cMsMbSdX9dacKPV6fPJIcglvraC9uYY2GMi9HkTrtW3R7g4n7WFpfA3UazUVWj9TibqWScn90O5zB/7GGtwqKMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671988; c=relaxed/simple;
	bh=Bqo4ogGQBTT1OmWEK+0WI1S+foWCh3UhrEKW44EWWdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgbPJ2aqPTVu7EZAiXhMpsCcBMi06A4ZGNeyYkbSCk4eW6pff82+tOJN7+VstWixAQ8ZYUQcDM08gNcb74xq/lrU0+9ny7a2VS1GoMauTdOmZmR6GRmmMckaq12kjdTUSX6ceXt+Axftg7kmt2fzxSMcX3oHDWG6tEdxMloWYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=QtjqusU6; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1738671982;
	bh=Bqo4ogGQBTT1OmWEK+0WI1S+foWCh3UhrEKW44EWWdc=;
	h=From:To:Cc:Subject:Date;
	b=QtjqusU6cVCO9XIrXdO5Uw1fpBrrfB3NM3YeNKhZih9ydQViQgDuIc4enVslj6SqA
	 RniPLPjtxift7pjth1zpN+DNRGaDWpSniNaBpb3RLr+Go1UJBecqtdq7uY5RjC/svJ
	 mDHl/+iV9LcwVWvGv9OedzBJbHi5a3rVJxOyVaRE=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH] wifi: mac80211: Debugfs handling for virtual monitor
Date: Tue,  4 Feb 2025 13:26:17 +0100
Message-ID: <20250204122617.8976-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create/delete debugfs entry for the virtual monitor interface according
to the state of the virtual monitor interface.

This fixes the following issues:
 1) Debugfs is not getting an entry when the virtual monitor interface
    is created.
 2) Instead debugfs gets an entry when it's deleted.
 3) And debugfs warns, that it already has directory for the virtual
    monitor interface every time the virtual monitor interface is
    removed again after the first time.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
Changes compared to the RFC patch in
https://lore.kernel.org/linux-wireless/20250127162625.20747-3-Alexander@wetzel-home.de/

 Moved debugfs and SDATA_STATE_RUNNING to the end of
 ieee80211_add_virtual_monitor()
---
 net/mac80211/iface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7d3ebfcb8c2b..bee11f5da16c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1153,8 +1153,6 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		}
 	}
 
-	set_bit(SDATA_STATE_RUNNING, &sdata->state);
-
 	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
 	if (ret) {
 		kfree(sdata);
@@ -1177,6 +1175,9 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		return ret;
 	}
 
+	ieee80211_debugfs_recreate_netdev(sdata, false);
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
+
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
@@ -1203,6 +1204,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 		return;
 	}
 
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	RCU_INIT_POINTER(local->monitor_sdata, NULL);
 	mutex_unlock(&local->iflist_mtx);
 
@@ -1213,6 +1215,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 		drv_remove_interface(local, sdata);
 
+	ieee80211_debugfs_remove_netdev(sdata);
 	kfree(sdata);
 }
 
-- 
2.48.1


