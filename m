Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8F557779
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 12:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiFWKKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFWKJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 06:09:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D396C49C8E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=9iYUUrOLnyBqrO7ZKizWVfemZsTZXipW2Vvq/7tMejc=; t=1655978997; x=1657188597; 
        b=lmVr0m5aiA9aiImDzvUjR+2N2quCQ84DPSLvQCylOil2ueEyUITaT6p+JhgK13cQEeY+busMqAz
        QuI5grYgI72acOaoBiYh/cYtsG9f0qu7csCdJrSZIXmcEKMooD/Y6/Zgj0hlVnnhqRjEIsb/+bxpt
        jjAewGJdkSlQzm2uX/5AwNPPLil/On7DGJdh4xd6nbFOdAxkq9VN74FzB5xuIFgYWByjTvBG1+XJU
        CKev6dw24sybYMJur6yHVM9KSBrXXWGL+YB9hH106HXnG5wH/P1E9SkU8hz8f9sdBZOF9eKxaWmIo
        duRkGEdgNhlGzfPqhdKFJkAPgxhPxoLVNKiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o4JmX-00Dhip-3y;
        Thu, 23 Jun 2022 12:09:49 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] cfg80211: fix kernel-doc
Date:   Thu, 23 Jun 2022 12:09:46 +0200
Message-Id: <20220623120945.9b26f55a4b43.Ib1ba631c5c7adf7ad2995ac2404455f4114df0ae@changeid>
X-Mailer: git-send-email 2.36.1
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

Some things are now removed, and some are not documented, but
mark all the new things as private since drivers shouldn't be
using them anyway.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 996782c44838..44f185a2f424 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5563,18 +5563,8 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @netdev: (private) Used to reference back to the netdev, may be %NULL
  * @identifier: (private) Identifier used in nl80211 to identify this
  *	wireless device if it has no netdev
- * @connected_addr: (private) BSSID or AP MLD address if connected
  * @connected: indicates if connected or not (STA mode)
- * @current_bss: (private) Used by the internal configuration code
- * @chandef: (private) Used by the internal configuration code to track
- *	the user-set channel definition.
- * @preset_chandef: (private) Used by the internal configuration code to
- *	track the channel to be used for AP later
  * @bssid: (private) Used by the internal configuration code
- * @ssid: (private) Used by the internal configuration code
- * @ssid_len: (private) Used by the internal configuration code
- * @mesh_id_len: (private) Used by the internal configuration code
- * @mesh_id_up_len: (private) Used by the internal configuration code
  * @wext: (private) Used by the internal wireless extensions compat code
  * @wext.ibss: (private) IBSS data part of wext handling
  * @wext.connect: (private) connection handling data
@@ -5695,6 +5685,7 @@ struct wireless_dev {
 
 	unsigned long unprot_beacon_reported;
 
+	/* private: */
 	union {
 		struct {
 			u8 connected_addr[ETH_ALEN] __aligned(2);
-- 
2.36.1

