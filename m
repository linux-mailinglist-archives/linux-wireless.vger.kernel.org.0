Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5B51D345
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiEFIZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 04:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344584AbiEFIZ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 04:25:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D076831C
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=4sPmKHbGH6IxzTqB4x5j6ud0P17yI97bijhVjUYEI2M=; t=1651825304; x=1653034904; 
        b=pwBVnF8tuhW7D7Y2fD+nZ1S5o9ihaCrPBl5sKbtsEqNuub7yKEHnnff1Nk9iYTinw6+RmKcHo5Z
        Gyn5TCVeyZVofq9d1JZSaOhlBUcMfsKNTkcYQbmxBqHGPJMngvccdc3Pc2Ma9gcEia8k84O+f1Dxe
        aVisjfFMX4PVxm6KdHnas1cN0QJqeB59ApdtsgukQqo3EhC8VDqW7JLRLEa+4y1ybUWATzxAqudW5
        FwX/jyPBpFqTTq5oqUwmr17N10tU2FpVnYt2Xz3+vnEr/dgGVOitsrNhyz+7Ym0r+QqnZ1Wh0wix5
        guA1o36KpBqNN+DUweyNU3yRwtbUbH8DU1GA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmtDa-0042c5-5k;
        Fri, 06 May 2022 10:21:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: fix locking in nl80211_set_tx_bitrate_mask()
Date:   Fri,  6 May 2022 10:21:38 +0200
Message-Id: <20220506102136.06b7205419e6.I2a87c05fbd8bc5e565e84d190d4cfd2e92695a90@changeid>
X-Mailer: git-send-email 2.35.1
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

This accesses the wdev's chandef etc., so cannot safely
be used without holding the lock.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c64baae9863..ac8f98692fd7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11665,18 +11665,23 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 	struct cfg80211_bitrate_mask mask;
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
 	if (!rdev->ops->set_bitrate_mask)
 		return -EOPNOTSUPP;
 
+	wdev_lock(wdev);
 	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 					    NL80211_ATTR_TX_RATES, &mask,
 					    dev, true);
 	if (err)
-		return err;
+		goto out;
 
-	return rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
+	err = rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
+out:
+	wdev_unlock(wdev);
+	return err;
 }
 
 static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
-- 
2.35.1

