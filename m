Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE35D663EF0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjAJLGl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 06:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbjAJLF5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 06:05:57 -0500
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3812D12AFA
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 03:05:47 -0800 (PST)
From:   Nick Hainke <vincent@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1673348743;
        bh=fVE7VUuYXMA8XRUUXdGvwE2xRu8C7zt1YgYXmiRmJBo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZToH6qzPk6uSaYZ8uVL8YR33ivhvX2ARkVR4mFQXosVLWIKquzPbETr+4kUxj2fAa
         l6KMWEW6AzWdBgcIzmJmSkKiyFrrOcJECTkQjdGKpZ5xKgIvU0K55gJSs9BRLzD2Lh
         hXl873lJytv9zrpAve5RqZUUePNaXdDuNAUabq4/UI2UkwbMGMAnFS0bY2iBwYsFLD
         JmizsPCwMyaYG57nHAxjMRHss+7sn+Za+CpGOrldjsAD3qBTfV9lqobAxnO8NF1enP
         fSZp0PfMXSOHzbr+nlarVmWUGmO6akRZjrpwYPcelG5yU9OZwxPYBIanssdt8D/jkh
         Sxy5RtAUcTrig==
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Nick Hainke <vincent@systemli.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] wifi: mac80211: add support for scanning in ap mode
Date:   Tue, 10 Jan 2023 12:05:24 +0100
Message-Id: <20230110110524.511258-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

OpenWRT has shipped a patch since 2011 that allows it to perform a scan
in AP mode, whether it is supported by the driver or not. In certain
situations, it may be desirable to scan an interface that is currently
in AP mode regardless of whether frames are missed. The patch adds a
module parameter "allow_ap_scan" that, if set to true, allows the behavior
described above.

Tested-on: TP Link Archer C7 V2 (Qualcomm Atheros QCA9558,
           Qualcomm Atheros QCA9880-BR4A) with OpenWrt Linux 5.15.86

Signed-off-by: Nick Hainke <vincent@systemli.org>
---
 net/mac80211/cfg.c         | 3 +++
 net/mac80211/ieee80211_i.h | 3 +++
 net/mac80211/main.c        | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8f9a2ab502b3..04730fb0f621 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2723,6 +2723,9 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 */
 		fallthrough;
 	case NL80211_IFTYPE_AP:
+		/* Support scanning in AP mode regardless of driver support. */
+		if (allow_ap_scan)
+			break;
 		/*
 		 * If the scan has been forced (and the driver supports
 		 * forcing), don't care about being beaconing already.
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 63ff0d2524b6..d48c7dd00dd4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2566,4 +2566,7 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+
+extern bool allow_ap_scan;
+
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 846528850612..c33d99717cd0 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -33,6 +33,11 @@
 #include "led.h"
 #include "debugfs.h"
 
+bool allow_ap_scan;
+module_param(allow_ap_scan, bool, 0644);
+MODULE_PARM_DESC(allow_ap_scan,
+		 "Support scanning in AP mode regardless of driver support.");
+
 void ieee80211_configure_filter(struct ieee80211_local *local)
 {
 	u64 mc;
-- 
2.39.0

