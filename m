Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF55619D87
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKDQmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiKDQm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 12:42:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2F531225
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=LDn3Qjo8q0FDNqpvma+78Hs9DRDAmzINlacFJFLo3Yo=; t=1667580147; x=1668789747; 
        b=eU9yuE3eNoPrmi8HtOCc+ADV7LHL4mnbmbeROCOH816AfWCJ0WQptfJI0IKhUBYWoRZtJvsh0IH
        fYfXqyfi6+yorGoca/YuNjkkSLY33fXhUP3oqOSzgGOGITtMf8teOKw6hpbUAT0tCgj/8KmkhPEhv
        zIvSeoBhgpw5NUFILGvwUlVWZQdDSi+fhobv/nPvmmw2uCyJ4dRIxkbhm3r87edVv8MHJvd4uAQ8U
        8z5Tw9pkayESw1fw1DV4AWYDb+JnkuLCjndDmhLCskQ+mCqDYRektW5dy3d6Goa9IJ7zyhEifG/aX
        +Rt4t5262Nguids1T0jnVprwLOW9Oeo2EzsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oqzlw-008v9Z-1X;
        Fri, 04 Nov 2022 17:42:24 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/2] wifi: wireless: warn on most wireless extension usage
Date:   Fri,  4 Nov 2022 17:42:20 +0100
Message-Id: <20221104174218.26f9541c0bfa.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
X-Mailer: git-send-email 2.38.1
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

With MLO/EHT support around the corner, we're going to
remove support for wireless extensions with new devices
since MLO cannot be properly indicated using them.

Add a warning to indicate which processes are still
using wireless extensions, if being used with modern
(i.e. cfg80211) drivers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/wext-core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index fe8765c4075d..cbeb8be214a8 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -636,7 +636,15 @@ void wireless_send_event(struct net_device *	dev,
 }
 EXPORT_SYMBOL(wireless_send_event);
 
+#ifdef CONFIG_CFG80211_WEXT
+static void wireless_warn_cfg80211_wext(void)
+{
+	char name[sizeof(current->comm)];
 
+	pr_warn_ratelimited("warning: `%s' uses wireless extensions that are deprecated for modern drivers\n",
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
2.38.1

