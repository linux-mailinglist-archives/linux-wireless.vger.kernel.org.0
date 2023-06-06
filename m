Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C53724303
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbjFFMuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbjFFMuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2961715
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4k4XuKR3EBRR8WpMNiPncB3yO0aC5enUZr4e25hByng=;
        t=1686055782; x=1687265382; b=REwMU34PMPVeUmPIHVFfxiagg/71OUIY1lvdq46OuVebil6
        nCnyXAW5W8FhUaQE/Y9RjcmnzJXMMZQT/zGsNKkOEldlYedQXDYZSEFwlOwoz2Yjs6hKSfFSRBAt3
        vdO43NNy45w5D3ynWRdAbbekNeVgF01P82Sj8R2vIQy3QYkSZCSG2yaKVx/xmCA4cjZKIQ1h/o3bO
        PlumNEi0RACHmOOopObkzD0MZBNlWNRvyQrFcxJGEuQr9/8OPNdjCExJJvTMFVXCaBujqZ30czWLr
        leSh07JvFKB5JCZLD3o5/XYWk9y+QAu/6G5vU8meXZ5gG1RIKkQ766G2cHH9Fjhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W83-00FZDP-1m;
        Tue, 06 Jun 2023 14:49:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/14] wifi: mac80211: unregister netdevs through cfg80211
Date:   Tue,  6 Jun 2023 14:49:27 +0200
Message-Id: <20230606144753.1bc1e1c1187c.I61968a8fdb9e61873c459f87398e95e5f006fb83@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606124933.181107-1-johannes@sipsolutions.net>
References: <20230606124933.181107-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since we want to have wiphy_lock() for the unregistration
in the future, unregister also netdevs via cfg80211 now
to be able to hold the wiphy_lock() for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f820098e6a70..5b67b44e3f89 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2258,7 +2258,6 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata, *tmp;
 	LIST_HEAD(unreg_list);
-	LIST_HEAD(wdev_list);
 
 	ASSERT_RTNL();
 
@@ -2281,23 +2280,18 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	ieee80211_txq_teardown_flows(local);
 
 	mutex_lock(&local->iflist_mtx);
-	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
-
-		if (sdata->dev)
-			unregister_netdevice_queue(sdata->dev, &unreg_list);
-		else
-			list_add(&sdata->list, &wdev_list);
-	}
+	list_splice_init(&local->interfaces, &unreg_list);
 	mutex_unlock(&local->iflist_mtx);
 
-	unregister_netdevice_many(&unreg_list);
-
 	wiphy_lock(local->hw.wiphy);
-	list_for_each_entry_safe(sdata, tmp, &wdev_list, list) {
+	list_for_each_entry_safe(sdata, tmp, &unreg_list, list) {
+		bool netdev = sdata->dev;
+
 		list_del(&sdata->list);
 		cfg80211_unregister_wdev(&sdata->wdev);
-		kfree(sdata);
+
+		if (!netdev)
+			kfree(sdata);
 	}
 	wiphy_unlock(local->hw.wiphy);
 }
-- 
2.40.1

