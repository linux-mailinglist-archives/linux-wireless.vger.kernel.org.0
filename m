Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0425667198F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 11:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjARKr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 05:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjARKpY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 05:45:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D88613CF
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=x72o7ep9GIbtpvo4o5YWqYysQ1ZD6wGWVXjajHeduW4=; t=1674035518; x=1675245118; 
        b=TaqiC7mPrZdnWp8YMtnxk9pK2o9/haUhA/o5bkNFFNUHyMoX3CuuvDUplJ4ht5MlXfVe2/HCN2G
        4vzNq6qrDbR7ArylEIlBIJ3OP9QeMh+23JLJIo6tse9iHGAhhNkyWB5lJ9N+5CrLxSPd8TEH+hB9W
        0yVlP87CpqIuRAwLhRHsBzygRtAPcpnVo26EfH2sfRsYuDC926wcF+Q8n3sWiH7BRvu6G1+/wb0wU
        59lhbk6Ls1BGoy2ihoDUtM5uRR/7oTAh/Pj3fgCLZBtSNstP/Vkjj/yJ5RRv+j0z858nxL3UfucAZ
        tPZIky4E1McCf04ZV1y5YOER6YVkJbNp5U/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pI56q-005YFT-0P;
        Wed, 18 Jan 2023 10:51:56 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: wireless: warn on most wireless extension usage
Date:   Wed, 18 Jan 2023 10:51:52 +0100
Message-Id: <20230118105152.a7158a929a6f.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
X-Mailer: git-send-email 2.39.0
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

With WiFi 7 (802.11ax, MLO/EHT) around the corner, we're going to
remove support for wireless extensions with new devices since MLO
(multi-link operation) cannot be properly indicated using them.

Add a warning to indicate which processes are still using wireless
extensions, if being used with modern (i.e. cfg80211) drivers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/wext-core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index fe8765c4075d..6e5f5ea92ddb 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -636,7 +636,15 @@ void wireless_send_event(struct net_device *	dev,
 }
 EXPORT_SYMBOL(wireless_send_event);
 
+#ifdef CONFIG_CFG80211_WEXT
+static void wireless_warn_cfg80211_wext(void)
+{
+	char name[sizeof(current->comm)];
 
+	pr_warn_ratelimited("warning: `%s' uses wireless extensions that are deprecated for modern drivers; use nl80211\n",
+			    get_task_comm(name, current));
+}
+#endif
 
 /* IW handlers */
 
@@ -652,8 +660,10 @@ struct iw_statistics *get_wireless_stats(struct net_device *dev)
 	if (dev->ieee80211_ptr &&
 	    dev->ieee80211_ptr->wiphy &&
 	    dev->ieee80211_ptr->wiphy->wext &&
-	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats)
+	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats) {
+		wireless_warn_cfg80211_wext();
 		return dev->ieee80211_ptr->wiphy->wext->get_wireless_stats(dev);
+	}
 #endif
 
 	/* not found */
@@ -690,8 +700,10 @@ static iw_handler get_handler(struct net_device *dev, unsigned int cmd)
 	const struct iw_handler_def *handlers = NULL;
 
 #ifdef CONFIG_CFG80211_WEXT
-	if (dev->ieee80211_ptr && dev->ieee80211_ptr->wiphy)
+	if (dev->ieee80211_ptr && dev->ieee80211_ptr->wiphy) {
+		wireless_warn_cfg80211_wext();
 		handlers = dev->ieee80211_ptr->wiphy->wext;
+	}
 #endif
 #ifdef CONFIG_WIRELESS_EXT
 	if (dev->wireless_handlers)
-- 
2.39.0

