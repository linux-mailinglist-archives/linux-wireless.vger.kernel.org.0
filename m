Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F831671990
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 11:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjARKr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjARKp1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 05:45:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BA613D2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 01:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4e16ZFcjZ7IAtZTWYVwwuj1PGSePX6yjNLpGdjr2cvQ=;
        t=1674035519; x=1675245119; b=Qz+xeMH8kx5mf/fj6Hhg7ajOnoBsm5OEGO8apyJSej3XEj7
        4XoQYYysOHWMulMQNkn2q+Pg/MEIYTdzmBlLoW8xavDIXwvAbuBqs4nFywH0rQuyd/xrUYjDxgFny
        C2vkQ6pQGukYrID3g7cSbfUY8I4m90z4RNY1p1m4b7BZuq3M9gkvQD7abdzka3ARcbGno+kdq4nxM
        lklxNeFOj7KuuBrUY1GtJ8u7y/ZvYk7qNBGniI3k8QKQS/UlEsg0mrKKKHCjrhUp8quydbLCQYKQ2
        eLDlu5rVVpsxRhDNvOHMdk31x6v0vV625vFDbt3R71PDN92bAN2yBFsflsp9Dmjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pI56q-005YFT-1r;
        Wed, 18 Jan 2023 10:51:56 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: wireless: deny wireless extensions on MLO-capable devices
Date:   Wed, 18 Jan 2023 10:51:53 +0100
Message-Id: <20230118105152.45f85078a1e0.Ib9eabc2ec5bf6b0244e4d973e93baaa3d8c91bd8@changeid>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118105152.a7158a929a6f.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
References: <20230118105152.a7158a929a6f.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These are WiFi 7 devices that will be introduced into the market
in 2023, with new drivers. Wireless extensions haven't been in
real development since 2006. Since wireless has evolved a lot,
and continues to evolve significantly with Multi-Link Operation,
there's really no good way to still support wireless extensions
for devices that do MLO.

Stop supporting wireless extensions for new devices. We don't
consider this a regression since no such devices (apart from
hwsim) exist yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/wext-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 6e5f5ea92ddb..13a72b17248e 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -662,6 +662,8 @@ struct iw_statistics *get_wireless_stats(struct net_device *dev)
 	    dev->ieee80211_ptr->wiphy->wext &&
 	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats) {
 		wireless_warn_cfg80211_wext();
+		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
+			return NULL;
 		return dev->ieee80211_ptr->wiphy->wext->get_wireless_stats(dev);
 	}
 #endif
@@ -702,6 +704,8 @@ static iw_handler get_handler(struct net_device *dev, unsigned int cmd)
 #ifdef CONFIG_CFG80211_WEXT
 	if (dev->ieee80211_ptr && dev->ieee80211_ptr->wiphy) {
 		wireless_warn_cfg80211_wext();
+		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
+			return NULL;
 		handlers = dev->ieee80211_ptr->wiphy->wext;
 	}
 #endif
-- 
2.39.0

