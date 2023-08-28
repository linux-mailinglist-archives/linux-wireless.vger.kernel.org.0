Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A484978AF86
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjH1MFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjH1MFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B6120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9YWrRX5taoxsf+E2wNMIE4k2TUVEt+ZbVMuPk85QoKs=;
        t=1693224329; x=1694433929; b=SHjHbhj2rSvR83xIF6kKEGsJ1in/85aStDX0ciSegKHjEiW
        7dNmlM0f4tl13Mj7EFnrXbtF6HGyjM5nBdFqYyN2xiUaLttoiUxDvcfg+H7bZYibsS1pT16ADFQf7
        eVFZ2PsOTlWlOwXDq6Tl4uYf75BMo/VKT/G49Kxsze4gs12DDjr2HXP5+EMUJiOm07q3cTExICYIC
        bCiYmmbJpozUM3tS3UFbGadPzVQ0pIIrkSP+rXuH6jdsqk7ZDkVqm5jugH52xkOBSJv3hJ0wYiqQc
        jnS9SNWzgfd7R6sOtDhEi5cbU52+oQCYE7BPMS8xmlpepMnZjx03CVm6V+KTVemw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazn-00Gjgt-0b;
        Mon, 28 Aug 2023 14:05:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 12/40] wifi: mac80211: move monitor work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:40 +0200
Message-ID: <20230828135927.3092fa7388f1.I80fd564ebecf7cad040d3d3968f61119c85be973@changeid>
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

Again this serves to simplify the locking in mac80211
in the future, since this is a relatively complex work.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 72955758a846..1cb29a67a2c7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -473,7 +473,7 @@ struct ieee80211_if_managed {
 	struct timer_list timer;
 	struct timer_list conn_mon_timer;
 	struct timer_list bcn_mon_timer;
-	struct work_struct monitor_work;
+	struct wiphy_work monitor_work;
 	struct wiphy_work beacon_connection_loss_work;
 	struct wiphy_work csa_connection_drop_work;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5644e25ec5fe..ab0be5c30860 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6683,10 +6683,11 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 		return;
 	}
 
-	ieee80211_queue_work(&local->hw, &ifmgd->monitor_work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->u.mgd.monitor_work);
 }
 
-static void ieee80211_sta_monitor_work(struct work_struct *work)
+static void ieee80211_sta_monitor_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
@@ -6702,8 +6703,8 @@ static void ieee80211_restart_sta_timer(struct ieee80211_sub_if_data *sdata)
 
 		/* let's probe the connection once */
 		if (!ieee80211_hw_check(&sdata->local->hw, CONNECTION_MONITOR))
-			ieee80211_queue_work(&sdata->local->hw,
-					     &sdata->u.mgd.monitor_work);
+			wiphy_work_queue(sdata->local->hw.wiphy,
+					 &sdata->u.mgd.monitor_work);
 	}
 }
 
@@ -6821,7 +6822,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	INIT_WORK(&ifmgd->monitor_work, ieee80211_sta_monitor_work);
+	wiphy_work_init(&ifmgd->monitor_work, ieee80211_sta_monitor_work);
 	wiphy_work_init(&ifmgd->beacon_connection_loss_work,
 			ieee80211_beacon_connection_loss_work);
 	wiphy_work_init(&ifmgd->csa_connection_drop_work,
@@ -7850,7 +7851,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	 * they will not do anything but might not have been
 	 * cancelled when disconnecting.
 	 */
-	cancel_work_sync(&ifmgd->monitor_work);
+	wiphy_work_cancel(sdata->local->hw.wiphy,
+			  &ifmgd->monitor_work);
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->beacon_connection_loss_work);
 	wiphy_work_cancel(sdata->local->hw.wiphy,
-- 
2.41.0

