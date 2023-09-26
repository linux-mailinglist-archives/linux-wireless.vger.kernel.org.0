Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC57AEF19
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjIZOKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZOKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 10:10:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1111F
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=7yIrEC6opCSOaUhaD/9TXPkPt4zsWcfwCiwZkbF8reQ=; t=1695737396; x=1696946996; 
        b=HgJk6U48zOs1gJH5zwWCIJM9B7qXkgA39fv9Pa4EWG1Yz0wEar/1HerOVjXr68+RmDbtIh0iM9n
        8uP5hwQw8qVtmWYa5YdrsgZLs428K/bBzw/MvAq4j9UHm/UdwPzaLh8BzwUu3dDIKZrBGAGodt8+/
        okE2c3sYKakTYkhkcRHCzIxBRy0VpKny4RUiUwv7yyd3Z8q5FmAyOB+gTHirnvdhwJP7vcGbjboJi
        7a+uPD7BveDid66xB7glgys70FkfGqOJ1tERhz8aEaal4qfbu8Vl8KqCa74u3JZmqLj3VMY7T2ZXX
        jFF/mmHhlZANfKRCNIrNYxs2CiV8b/+2/JMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ql8l7-005hSY-2H;
        Tue, 26 Sep 2023 16:09:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: nl80211: remove set_fils_aad support
Date:   Tue, 26 Sep 2023 16:09:51 +0200
Message-ID: <20230926160950.d698c25528e3.If118a835a25c59de20e1728ab71949fdb4172fb2@changeid>
X-Mailer: git-send-email 2.41.0
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

There's no user for this, so remove the support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h  |  6 ------
 net/wireless/nl80211.c  | 30 ------------------------------
 net/wireless/rdev-ops.h | 14 --------------
 net/wireless/trace.h    | 18 ------------------
 4 files changed, 68 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3a4b684f89bf..9f930750db2e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4384,10 +4384,6 @@ struct mgmt_frame_regs {
  *
  * @color_change: Initiate a color change.
  *
- * @set_fils_aad: Set FILS AAD data to the AP driver so that the driver can use
- *	those to decrypt (Re)Association Request and encrypt (Re)Association
- *	Response frame.
- *
  * @set_radar_background: Configure dedicated offchannel chain available for
  *	radar/CAC detection on some hw. This chain can't be used to transmit
  *	or receive frames and it is bounded to a running wdev.
@@ -4748,8 +4744,6 @@ struct cfg80211_ops {
 	int	(*color_change)(struct wiphy *wiphy,
 				struct net_device *dev,
 				struct cfg80211_color_change_settings *params);
-	int     (*set_fils_aad)(struct wiphy *wiphy, struct net_device *dev,
-				struct cfg80211_fils_aad *fils_aad);
 	int	(*set_radar_background)(struct wiphy *wiphy,
 					struct cfg80211_chan_def *chandef);
 	int	(*add_link_station)(struct wiphy *wiphy, struct net_device *dev,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index de47838aca4f..45efc79bfa3c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16079,29 +16079,6 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int nl80211_set_fils_aad(struct sk_buff *skb,
-				struct genl_info *info)
-{
-	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct net_device *dev = info->user_ptr[1];
-	struct cfg80211_fils_aad fils_aad = {};
-	u8 *nonces;
-
-	if (!info->attrs[NL80211_ATTR_MAC] ||
-	    !info->attrs[NL80211_ATTR_FILS_KEK] ||
-	    !info->attrs[NL80211_ATTR_FILS_NONCES])
-		return -EINVAL;
-
-	fils_aad.macaddr = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	fils_aad.kek_len = nla_len(info->attrs[NL80211_ATTR_FILS_KEK]);
-	fils_aad.kek = nla_data(info->attrs[NL80211_ATTR_FILS_KEK]);
-	nonces = nla_data(info->attrs[NL80211_ATTR_FILS_NONCES]);
-	fils_aad.snonce = nonces;
-	fils_aad.anonce = nonces + FILS_NONCE_LEN;
-
-	return rdev_set_fils_aad(rdev, dev, &fils_aad);
-}
-
 static int nl80211_add_link(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -17452,13 +17429,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
-	{
-		.cmd = NL80211_CMD_SET_FILS_AAD,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = nl80211_set_fils_aad,
-		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
-	},
 	{
 		.cmd = NL80211_CMD_ADD_LINK,
 		.doit = nl80211_add_link,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 90bb7ac4b930..9dbad6ecbc6d 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1402,20 +1402,6 @@ static inline int rdev_color_change(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
-static inline int
-rdev_set_fils_aad(struct cfg80211_registered_device *rdev,
-		  struct net_device *dev, struct cfg80211_fils_aad *fils_aad)
-{
-	int ret = -EOPNOTSUPP;
-
-	trace_rdev_set_fils_aad(&rdev->wiphy, dev, fils_aad);
-	if (rdev->ops->set_fils_aad)
-		ret = rdev->ops->set_fils_aad(&rdev->wiphy, dev, fils_aad);
-	trace_rdev_return_int(&rdev->wiphy, ret);
-
-	return ret;
-}
-
 static inline int
 rdev_set_radar_background(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_chan_def *chandef)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 617c0d0dfa96..c6870c311cdf 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2706,24 +2706,6 @@ DEFINE_EVENT(wiphy_wdev_cookie_evt, rdev_abort_pmsr,
 	TP_ARGS(wiphy, wdev, cookie)
 );
 
-TRACE_EVENT(rdev_set_fils_aad,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_fils_aad *fils_aad),
-	TP_ARGS(wiphy, netdev, fils_aad),
-	TP_STRUCT__entry(WIPHY_ENTRY
-		NETDEV_ENTRY
-		__array(u8, macaddr, ETH_ALEN)
-		__field(u8, kek_len)
-	),
-	TP_fast_assign(WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
-		FILS_AAD_ASSIGN(fils_aad);
-	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " FILS_AAD_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->macaddr,
-		  __entry->kek_len)
-);
-
 TRACE_EVENT(rdev_update_owe_info,
 	    TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		     struct cfg80211_update_owe_info *owe_info),
-- 
2.41.0

