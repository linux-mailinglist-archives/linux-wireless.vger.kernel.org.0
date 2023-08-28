Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4178AF81
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjH1MFo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjH1MFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526411A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mQZsg7R3UsUQbpTz0VcUsmihOeS0uy88mP9WYnf2ifw=;
        t=1693224330; x=1694433930; b=lcEvYJF7TzTEdgTRO8B8+QYSIR3qqT1zyhr4IyaX4uSKGAe
        8wLNpfagdU+/1v6y076/cVfdR7ETO0K6RhyMq5mS67D5VAsrTS6/mhJIXSG/Mq8YlEzHKOzFWYNeD
        s4LfbCJU18s0cJ0CH2CtiFR4gKyk42tlOzP/aHFP/od66/QYjp7gk/hAxOHNU9BQSsbWfC1n5pJ5e
        r+nSTYJycW0YQXdyeR1WAHLcqsx2NMWV9Osp/MjabQU2vhYFwfGygSAPIUW03DJvK17F8ELZ4m6MA
        JKtY6Lyhk/6ZmTLrD0jIMNfrhQsGne35sR6pUmojQSkEAvWuhBQE/T307Fy+5V3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazn-00Gjgt-2t;
        Mon, 28 Aug 2023 14:05:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/40] wifi: mac80211: lock wiphy in IP address notifier
Date:   Mon, 28 Aug 2023 13:59:41 +0200
Message-ID: <20230828135927.4f3021b5ab83.Ib32eb66779542d682ad69513ae8cce3b16a0fa55@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Lock the wiphy in the IP address notifier as another
place that should have it locked before calling into
the driver. This needs a bit of attention since the
notifier can be called while the wiphy is already
locked, when we remove an interface. Handle this by
not running the notifier in this case, and instead
calling out to the driver directly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 14 ++++++++++++++
 net/mac80211/main.c  | 22 +++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 42e130a6aee9..c0539e78a34e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2284,6 +2284,20 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	list_for_each_entry_safe(sdata, tmp, &unreg_list, list) {
 		bool netdev = sdata->dev;
 
+		/*
+		 * Remove IP addresses explicitly, since the notifier will
+		 * skip the callbacks if wdev->registered is false, since
+		 * we can't acquire the wiphy_lock() again there if already
+		 * inside this locked section.
+		 */
+		sdata_lock(sdata);
+		sdata->vif.cfg.arp_addr_cnt = 0;
+		if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+		    sdata->u.mgd.associated)
+			ieee80211_vif_cfg_change_notify(sdata,
+							BSS_CHANGED_ARP_FILTER);
+		sdata_unlock(sdata);
+
 		list_del(&sdata->list);
 		cfg80211_unregister_wdev(&sdata->wdev);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b6c089648441..f6860889fbdd 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -437,7 +437,7 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 	if (!wdev)
 		return NOTIFY_DONE;
 
-	if (wdev->wiphy != local->hw.wiphy)
+	if (wdev->wiphy != local->hw.wiphy || !wdev->registered)
 		return NOTIFY_DONE;
 
 	sdata = IEEE80211_DEV_TO_SUB_IF(ndev);
@@ -452,6 +452,25 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	ifmgd = &sdata->u.mgd;
+
+	/*
+	 * The nested here is needed to convince lockdep that this is
+	 * all OK. Yes, we lock the wiphy mutex here while we already
+	 * hold the notifier rwsem, that's the normal case. And yes,
+	 * we also acquire the notifier rwsem again when unregistering
+	 * a netdev while we already hold the wiphy mutex, so it does
+	 * look like a typical ABBA deadlock.
+	 *
+	 * However, both of these things happen with the RTNL held
+	 * already. Therefore, they can't actually happen, since the
+	 * lock orders really are ABC and ACB, which is fine due to
+	 * the RTNL (A).
+	 *
+	 * We still need to prevent recursion, which is accomplished
+	 * by the !wdev->registered check above.
+	 */
+	mutex_lock_nested(&local->hw.wiphy->mtx, 1);
+	__acquire(&local->hw.wiphy->mtx);
 	sdata_lock(sdata);
 
 	/* Copy the addresses to the vif config list */
@@ -470,6 +489,7 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 		ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_ARP_FILTER);
 
 	sdata_unlock(sdata);
+	wiphy_unlock(local->hw.wiphy);
 
 	return NOTIFY_OK;
 }
-- 
2.41.0

