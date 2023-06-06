Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB4724309
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbjFFMuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbjFFMuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C241F1718
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iKdTnkrj73RUHaYW2kgUcm20ZjyZ5BolrROQU/RjcbE=;
        t=1686055783; x=1687265383; b=FnBFFFVc1p7bBRwxMZ/YaCMTlasqPnDuMr37qmIcIdHLqfR
        T+aRVmi5nhNB5Tp0Xuwsiffw1vNDfAkPxg7Jmzwt4v63cmB1JAEAd2LlMCh0AnozNUqX+mGoGZluR
        4ytdLDbXr4PR4ZvTEgS+Cn3YvvJKVqO3ULujK40Sq3XD6YOkgJYRiSxoWsR4DxKXrCETSNeOm/pTD
        qr52CHHgmGZtPGk0wOw6Tt0MCOLI3q2LPJVk1idq0jRP299LzmqS2uLEZM2eLVfdu3NlyU2uA4BSg
        nLSzxJSqea3ajpdr7GZTAhttAUmDkuE+MtkwBh/TxpjvioBavtOUsCiDB1sc4OvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W82-00FZDP-2l;
        Tue, 06 Jun 2023 14:49:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/14] wifi: cfg80211: hold wiphy lock when sending wiphy
Date:   Tue,  6 Jun 2023 14:49:24 +0200
Message-Id: <20230606144753.dc23fb31e3dd.I63a5fd1779625b2c430bd7c4a0b017c338ec3d44@changeid>
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

Sending the wiphy out might cause calls to the driver,
notably get_txq_stats() and get_antenna(). These aren't
very important, since the normally have their own locks
and/or just send out static data, but if the contract
should be that the wiphy lock is always held, these are
also affected. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c    | 8 ++++++++
 net/wireless/nl80211.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 0ae36653c49c..97f01b94c3e2 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -129,6 +129,7 @@ int cfg80211_dev_rename(struct cfg80211_registered_device *rdev,
 	int result;
 
 	ASSERT_RTNL();
+	lockdep_assert_wiphy(&rdev->wiphy);
 
 	/* Ignore nop renames */
 	if (strcmp(newname, wiphy_name(&rdev->wiphy)) == 0)
@@ -195,6 +196,8 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 			continue;
 		nl80211_notify_iface(rdev, wdev, NL80211_CMD_DEL_INTERFACE);
 	}
+
+	wiphy_lock(&rdev->wiphy);
 	nl80211_notify_wiphy(rdev, NL80211_CMD_DEL_WIPHY);
 
 	wiphy_net_set(&rdev->wiphy, net);
@@ -203,6 +206,8 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	WARN_ON(err);
 
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
+	wiphy_unlock(&rdev->wiphy);
+
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
@@ -941,8 +946,10 @@ int wiphy_register(struct wiphy *wiphy)
 	rdev->wiphy.features |= NL80211_FEATURE_SCAN_FLUSH;
 
 	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	res = device_add(&rdev->wiphy.dev);
 	if (res) {
+		wiphy_unlock(&rdev->wiphy);
 		rtnl_unlock();
 		return res;
 	}
@@ -956,6 +963,7 @@ int wiphy_register(struct wiphy *wiphy)
 
 	cfg80211_debugfs_rdev_add(rdev);
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
+	wiphy_unlock(&rdev->wiphy);
 
 	/* set up regulatory info */
 	wiphy_regulatory_register(wiphy);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d95f8053020d..b74092efa6f0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3081,6 +3081,7 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 		if (state->filter_wiphy != -1 &&
 		    state->filter_wiphy != rdev->wiphy_idx)
 			continue;
+		wiphy_lock(&rdev->wiphy);
 		/* attempt to fit multiple wiphy data chunks into the skb */
 		do {
 			ret = nl80211_send_wiphy(rdev, NL80211_CMD_NEW_WIPHY,
@@ -3107,6 +3108,7 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 				    cb->min_dump_alloc < 4096) {
 					cb->min_dump_alloc = 4096;
 					state->split_start = 0;
+					wiphy_unlock(&rdev->wiphy);
 					rtnl_unlock();
 					return 1;
 				}
@@ -3114,6 +3116,7 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 				break;
 			}
 		} while (state->split_start > 0);
+		wiphy_unlock(&rdev->wiphy);
 		break;
 	}
 	rtnl_unlock();
-- 
2.40.1

