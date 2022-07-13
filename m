Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C1457332D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiGMJpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FC0F32E5
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pNN1w0OOrG995doc8bTXDjpoZL/0FPotk5lpUbHOeug=;
        t=1657705510; x=1658915110; b=RNJQC1akU2jjx+QTmJR7J6fAJiyWBsrEAgZ0r0Qa+TdCNsc
        zBJzEccu2oA4gIKJ8lIbyyiEydJX6DL/jskEb13N/CWGXugCyfj/fQBiKxjvDZo0504gmOVitrGCN
        LAESNpPQT198dgo6izZWqvpxVM781baQ/lZ7ReKqd9Fw9ZbLKWpxf8kmiJ3SmGRbIGNCbK2mvU+xl
        U3HL5KjGejxJHuCuar/6myn5rKa4KCwxSVa1Xtfht20khtIEKVP5BBObeN5kZ2++OSALB2yzZbPx6
        79kB2Q0TjsUMM3K7123Bsi9SNIHxdqFb3Pdb6YpBEWVWbWICC6bn4WJTSvuOZctg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvc-00EgvB-4r;
        Wed, 13 Jul 2022 11:45:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/76] wifi: nl80211: hold wdev mutex for station APIs
Date:   Wed, 13 Jul 2022 11:43:59 +0200
Message-Id: <20220713114425.f1104f6daaf7.Ief517e652cfa298ad3c71f0f5cedaeac8bdec27b@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since this will need to refer - at least in part - to the link
stations of an MLD, hold the wdev mutex for driver convenience.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 59ea1157969e..9eee853efd57 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6976,7 +6976,9 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* driver will call cfg80211_check_station_change() */
+	wdev_lock(dev->ieee80211_ptr);
 	err = rdev_change_station(rdev, dev, mac_addr, &params);
+	wdev_unlock(dev->ieee80211_ptr);
 
  out_put_vlan:
 	dev_put(params.vlan);
@@ -7232,7 +7234,9 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	/* be aware of params.vlan when changing code here */
 
+	wdev_lock(dev->ieee80211_ptr);
 	err = rdev_add_station(rdev, dev, mac_addr, &params);
+	wdev_unlock(dev->ieee80211_ptr);
 
 	dev_put(params.vlan);
 	return err;
@@ -7243,6 +7247,7 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct station_del_parameters params;
+	int ret;
 
 	memset(&params, 0, sizeof(params));
 
@@ -7290,7 +7295,11 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 		params.reason_code = WLAN_REASON_PREV_AUTH_NOT_VALID;
 	}
 
-	return rdev_del_station(rdev, dev, &params);
+	wdev_lock(dev->ieee80211_ptr);
+	ret = rdev_del_station(rdev, dev, &params);
+	wdev_unlock(dev->ieee80211_ptr);
+
+	return ret;
 }
 
 static int nl80211_send_mpath(struct sk_buff *msg, u32 portid, u32 seq,
-- 
2.36.1

