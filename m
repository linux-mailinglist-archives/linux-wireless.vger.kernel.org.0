Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAA44394D9
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJYLds (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 07:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhJYLdp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 07:33:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A82CC061225
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=ach9StXDJzI5Sf7vM2bgUgWGOedzg3IHgvN1nz8MC/U=; t=1635161483; x=1636371083; 
        b=SFiSxpFZ7RfRFyiP172sGHYLb0TGPRFY23lJZ7Qwdx51tcjcS9nCo7fUBurAiSvFvyZQ95DI1pu
        KiLNgPzOGnR028JEuPHcl0SXl+pFmDwq4D6CasbOQSJ8h5xE/zU+rsTajs/9TxEML/YmNgjV1TAKP
        Iu2BlNFHom8lA3LCNob1XWuWu5TTB9Idn2W7xl/RZ2MdGZhr88HBKfzBb9nA58cMx+OxfYFU0xC+E
        AdR7Nzo15gvpTKbBQh7grHSdkbvxzX0mVN/wPAoYCJ5FZa0ndFvjzhBScMQ1qWDNuVaVRscx5D431
        aUROg2bLJSrf5WcTrTbbU4ObZlbAWbe6YBgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1meyCB-006gzH-Dj;
        Mon, 25 Oct 2021 13:31:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>, Jouni Malinen <j@w1.fi>
Subject: [PATCH] cfg80211: fix management registrations locking
Date:   Mon, 25 Oct 2021 13:31:12 +0200
Message-Id: <20211025133111.5cf733eab0f4.I7b0abb0494ab712f74e2efcd24bb31ac33f7eee9@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The management registrations locking was broken, the list was
locked for each wdev, but cfg80211_mgmt_registrations_update()
iterated it without holding all the correct spinlocks, causing
list corruption.

Rather than trying to fix it with fine-grained locking, just
move the lock to the wiphy/rdev (still need the list on each
wdev), we already need to hold the wdev lock to change it, so
there's no contention on the lock in any case. This trivially
fixes the bug since we hold one wdev's lock already, and now
will hold the lock that protects all lists.

Reported-by: Jouni Malinen <j@w1.fi>
Fixes: 6cd536fe62ef ("cfg80211: change internal management frame registration API")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  2 --
 net/wireless/core.c    |  2 +-
 net/wireless/core.h    |  2 ++
 net/wireless/mlme.c    | 26 ++++++++++++++------------
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62dd8422e0dc..27336fc70467 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5376,7 +5376,6 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  *	netdev and may otherwise be used by driver read-only, will be update
  *	by cfg80211 on change_interface
  * @mgmt_registrations: list of registrations for management frames
- * @mgmt_registrations_lock: lock for the list
  * @mgmt_registrations_need_update: mgmt registrations were updated,
  *	need to propagate the update to the driver
  * @mtx: mutex used to lock data in this struct, may be used by drivers
@@ -5423,7 +5422,6 @@ struct wireless_dev {
 	u32 identifier;
 
 	struct list_head mgmt_registrations;
-	spinlock_t mgmt_registrations_lock;
 	u8 mgmt_registrations_need_update:1;
 
 	struct mutex mtx;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 03323121ca50..aaba847d79eb 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -524,6 +524,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->propagate_cac_done_wk, cfg80211_propagate_cac_done_wk);
 	INIT_WORK(&rdev->mgmt_registrations_update_wk,
 		  cfg80211_mgmt_registrations_update_wk);
+	spin_lock_init(&rdev->mgmt_registrations_lock);
 
 #ifdef CONFIG_CFG80211_DEFAULT_PS
 	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -1279,7 +1280,6 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 	INIT_LIST_HEAD(&wdev->event_list);
 	spin_lock_init(&wdev->event_lock);
 	INIT_LIST_HEAD(&wdev->mgmt_registrations);
-	spin_lock_init(&wdev->mgmt_registrations_lock);
 	INIT_LIST_HEAD(&wdev->pmsr_list);
 	spin_lock_init(&wdev->pmsr_lock);
 	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b35d0db12f1d..1720abf36f92 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -100,6 +100,8 @@ struct cfg80211_registered_device {
 	struct work_struct propagate_cac_done_wk;
 
 	struct work_struct mgmt_registrations_update_wk;
+	/* lock for all wdev lists */
+	spinlock_t mgmt_registrations_lock;
 
 	/* must be last because of the way we do wiphy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN */
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3aa69b375a10..783acd2c4211 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -452,9 +452,9 @@ static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
 
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
-	spin_lock_bh(&wdev->mgmt_registrations_lock);
+	spin_lock_bh(&rdev->mgmt_registrations_lock);
 	if (!wdev->mgmt_registrations_need_update) {
-		spin_unlock_bh(&wdev->mgmt_registrations_lock);
+		spin_unlock_bh(&rdev->mgmt_registrations_lock);
 		return;
 	}
 
@@ -479,7 +479,7 @@ static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
 	rcu_read_unlock();
 
 	wdev->mgmt_registrations_need_update = 0;
-	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+	spin_unlock_bh(&rdev->mgmt_registrations_lock);
 
 	rdev_update_mgmt_frame_registrations(rdev, wdev, &upd);
 }
@@ -503,6 +503,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 				int match_len, bool multicast_rx,
 				struct netlink_ext_ack *extack)
 {
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct cfg80211_mgmt_registration *reg, *nreg;
 	int err = 0;
 	u16 mgmt_type;
@@ -548,7 +549,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	if (!nreg)
 		return -ENOMEM;
 
-	spin_lock_bh(&wdev->mgmt_registrations_lock);
+	spin_lock_bh(&rdev->mgmt_registrations_lock);
 
 	list_for_each_entry(reg, &wdev->mgmt_registrations, list) {
 		int mlen = min(match_len, reg->match_len);
@@ -583,7 +584,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 		list_add(&nreg->list, &wdev->mgmt_registrations);
 	}
 	wdev->mgmt_registrations_need_update = 1;
-	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+	spin_unlock_bh(&rdev->mgmt_registrations_lock);
 
 	cfg80211_mgmt_registrations_update(wdev);
 
@@ -591,7 +592,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 
  out:
 	kfree(nreg);
-	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+	spin_unlock_bh(&rdev->mgmt_registrations_lock);
 
 	return err;
 }
@@ -602,7 +603,7 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct cfg80211_mgmt_registration *reg, *tmp;
 
-	spin_lock_bh(&wdev->mgmt_registrations_lock);
+	spin_lock_bh(&rdev->mgmt_registrations_lock);
 
 	list_for_each_entry_safe(reg, tmp, &wdev->mgmt_registrations, list) {
 		if (reg->nlportid != nlportid)
@@ -615,7 +616,7 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 		schedule_work(&rdev->mgmt_registrations_update_wk);
 	}
 
-	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+	spin_unlock_bh(&rdev->mgmt_registrations_lock);
 
 	if (nlportid && rdev->crit_proto_nlportid == nlportid) {
 		rdev->crit_proto_nlportid = 0;
@@ -628,15 +629,16 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev)
 {
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct cfg80211_mgmt_registration *reg, *tmp;
 
-	spin_lock_bh(&wdev->mgmt_registrations_lock);
+	spin_lock_bh(&rdev->mgmt_registrations_lock);
 	list_for_each_entry_safe(reg, tmp, &wdev->mgmt_registrations, list) {
 		list_del(&reg->list);
 		kfree(reg);
 	}
 	wdev->mgmt_registrations_need_update = 1;
-	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+	spin_unlock_bh(&rdev->mgmt_registrations_lock);
 
 	cfg80211_mgmt_registrations_update(wdev);
 }
@@ -784,7 +786,7 @@ bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
 	data = buf + ieee80211_hdrlen(mgmt->frame_control);
 	data_len = len - ieee80211_hdrlen(mgmt->frame_control);
 
-	spin_lock_bh(&wdev->mgmt_registrations_lock);
+	spin_lock_bh(&rdev->mgmt_registrations_lock);
 
 	list_for_each_entry(reg, &wdev->mgmt_registrations, list) {
 		if (reg->frame_type != ftype)
@@ -808,7 +810,7 @@ bool cfg80211_rx_mgmt_khz(struct wireless_dev *wdev, int freq, int sig_dbm,
 		break;
 	}
 
-	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+	spin_unlock_bh(&rdev->mgmt_registrations_lock);
 
 	trace_cfg80211_return_bool(result);
 	return result;
-- 
2.31.1

