Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E136A3E22
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 10:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjB0JTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 04:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjB0JS3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 04:18:29 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C322792
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=4uifnW/0TGu1IWXspfNwGuZW2BXSqRxVRqMyALZUeg0=; t=1677489216; x=1678698816; 
        b=yOfWcUIT9abln8H0oU1HbtA4rtFa2+uLbyDUnkoiBzTPy4OOWCZuMqu2pMIIh9o6+P+q3TPUe5D
        /GHYgvj9owKzCgA7R3KH9ym/O5Yjpuh2m0JsTI6DJ5h6tJM94E58Y1nsuK6UF/x9FrSdn6xbZtods
        JNP140zewmt0Yk9FHkr1YTnBqWbBFUHTpT3rjz5a4clTdleoWMfy9h3JylEvQZXzRgfKeDMfG/lqS
        tv138WfjpcqpLtWRd2pVcjHdPUD9vY2PYuy7jk3AxFylkVd6w7hI8CaFJ7N0UjrJ0+FrCZsbvUa7P
        iV8nrkNGoIEkzp7fNAUosNuqOgWzLo052mzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pWZZZ-006zwH-2c;
        Mon, 27 Feb 2023 10:13:29 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] wifi: cfg80211: allow two wext calls
Date:   Mon, 27 Feb 2023 10:13:27 +0100
Message-Id: <20230227101326.d991669b20b9.Iaee03cafd239aab1cc635c008c5882ccc6c2aeae@changeid>
X-Mailer: git-send-email 2.39.2
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

The wext call SIOCGIWMODE appears to be frequently used by
the QT libraries to determine whether or not a netdev is
wireless and here multi-link makes no difference. Also,
SIOCGIWNAME is completely static.

Allow these calls without a warning since these won't be
going away if we allow them here now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Really not sure this is the right thing to do. On the one
hand it's easy, but on the other hand we've been disabling
WEXT completely for drivers Intel ships, and nobody has
complained about that in years.
---
 net/wireless/wext-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index a125fd1fa134..ae4bcda1a369 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -703,9 +703,16 @@ static iw_handler get_handler(struct net_device *dev, unsigned int cmd)
 
 #ifdef CONFIG_CFG80211_WEXT
 	if (dev->ieee80211_ptr && dev->ieee80211_ptr->wiphy) {
-		wireless_warn_cfg80211_wext();
-		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
-			return NULL;
+		switch (cmd) {
+		case SIOCGIWNAME:
+		case SIOCGIWMODE:
+			break;
+		default:
+			wireless_warn_cfg80211_wext();
+			if (dev->ieee80211_ptr->wiphy->flags &
+					WIPHY_FLAG_SUPPORTS_MLO)
+				return NULL;
+		}
 		handlers = dev->ieee80211_ptr->wiphy->wext;
 	}
 #endif
-- 
2.39.2

