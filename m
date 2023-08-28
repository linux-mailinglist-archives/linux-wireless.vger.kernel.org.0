Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6578AF9E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjH1MGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjH1MFt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65BB120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6H2p5w+09ZoWBAqa95ufS5zEb54lbZF1Flghqa5+IkQ=;
        t=1693224347; x=1694433947; b=cyD/PN13fNKmnIYHvnJ2G3mRYteCGVzbrozdsuNKgfBv7uM
        GYPF9pgD1I9BRGKjlcH1LnuiXt2pdUbxSivpQJW5ZgyoFHM8UTb3cOrvYYEwWW1raO9XfHi/IJsMU
        gCU0bTR+iMEc00oJycjep+8CQWRrl9UDG9hIBuYiuLCZ+8gR5o+DqMSB1Ug1AZejYOkNoTEFSgUy8
        tY+VJBF2aPPH0NyUIlzBqNs1j+QgpFvIiTfjbOgubswdZ9uAttrMWYWTJ3S4QtIzBwI+IWnVCCkGV
        H5ihk+cHLK27zhkLVvMMFO4ib10oiGkdqUQKz7wkfSt0lajN7OEDpIVBWI42h1IA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab04-00Gjgt-2s;
        Mon, 28 Aug 2023 14:05:45 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 32/40] wifi: mac80211: take wiphy lock for MAC addr change
Date:   Mon, 28 Aug 2023 14:00:00 +0200
Message-ID: <20230828135928.12d33d6286ca.Ia6fad96b541f354046ae17a32584d4067c144d54@changeid>
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

We want to ensure everything holds the wiphy lock,
so also extend that to the MAC change callback.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a465a18bf3bd..343343a7a3e2 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -251,9 +251,9 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 	return ret;
 }
 
-static int ieee80211_change_mac(struct net_device *dev, void *addr)
+static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
+				 void *addr)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 	struct sockaddr *sa = addr;
 	bool check_dup = true;
@@ -278,7 +278,7 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 
 	if (live)
 		drv_remove_interface(local, sdata);
-	ret = eth_mac_addr(dev, sa);
+	ret = eth_mac_addr(sdata->dev, sa);
 
 	if (ret == 0) {
 		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
@@ -294,6 +294,19 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	return ret;
 }
 
+static int ieee80211_change_mac(struct net_device *dev, void *addr)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	int ret;
+
+	wiphy_lock(local->hw.wiphy);
+	ret = _ieee80211_change_mac(sdata, addr);
+	wiphy_unlock(local->hw.wiphy);
+
+	return ret;
+}
+
 static inline int identical_mac_addr_allowed(int type1, int type2)
 {
 	return type1 == NL80211_IFTYPE_MONITOR ||
-- 
2.41.0

