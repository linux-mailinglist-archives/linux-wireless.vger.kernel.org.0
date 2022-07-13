Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27F573365
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiGMJqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiGMJpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C4F7893
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fsKzv+34q3EUXYExjWS2wuXXB8x7YPKwDiaJAwIfvD0=;
        t=1657705527; x=1658915127; b=k5IVP/tiXUtTI+U1jxTBB/S1nuNHtpBLxY5c7LxOGsR4Jo1
        s1hXDRpwfVcUSAVL/2Fc9k2TqiK+keNp+gIsOX2Jb8HB6xneBXbt/jQXMynCczoQNkcS0feZPremq
        eZYfJWQ25Cygc6zUhWUf0gFSlFz4Ub92HuBjmsrN1leH2iIQrnrtg4/K2TWctt6p2+grXKznSpKN/
        XPzJghBjUSMLEOI+qccHqhjbi6VkmQaodLe7BNcQdjCrEtFcVLD0mK0aqYQIXCK5CKUnlAWB0HUBC
        hDDoMnW4Olk3fqzRCLncmiIqq8AhlC3W2PeEzkF5VL+VyMCqWPwG115JcivXKQVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvt-00EgvB-TZ;
        Wed, 13 Jul 2022 11:45:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 60/76] wifi: nl80211: better validate link ID for stations
Date:   Wed, 13 Jul 2022 11:44:46 +0200
Message-Id: <20220713114426.56d57ed2ecc2.Ifc3da61fe1396f52b57d0e34a9e6dbea6a1a13b1@changeid>
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

If we add a station on an MLD, we need a link ID to see
where it lives (by default). Validate the link ID against
the valid_links.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d774e9a95492..37ec8b3897b4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6991,6 +6991,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
 	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct station_parameters params;
 	u8 *mac_addr = NULL;
 	u32 auth_assoc = BIT(NL80211_STA_FLAG_AUTHENTICATED) |
@@ -7018,14 +7019,6 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		nl80211_link_id_or_invalid(info->attrs);
 
 	if (info->attrs[NL80211_ATTR_MLD_ADDR]) {
-		/* If MLD_ADDR attribute is set then this is an MLD station
-		 * and the MLD_ADDR attribute holds the MLD address and the
-		 * MAC attribute holds for the LINK address.
-		 * In that case, the link_id is also expected to be valid.
-		 */
-		if (params.link_sta_params.link_id < 0)
-			return -EINVAL;
-
 		mac_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
 		params.link_sta_params.mld_mac = mac_addr;
 		params.link_sta_params.link_mac =
@@ -7253,9 +7246,24 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	/* be aware of params.vlan when changing code here */
 
 	wdev_lock(dev->ieee80211_ptr);
+	if (wdev->valid_links) {
+		if (params.link_sta_params.link_id < 0) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (!(wdev->valid_links & BIT(params.link_sta_params.link_id))) {
+			err = -ENOLINK;
+			goto out;
+		}
+	} else {
+		if (params.link_sta_params.link_id >= 0) {
+			err = -EINVAL;
+			goto out;
+		}
+	}
 	err = rdev_add_station(rdev, dev, mac_addr, &params);
+out:
 	wdev_unlock(dev->ieee80211_ptr);
-
 	dev_put(params.vlan);
 	return err;
 }
-- 
2.36.1

