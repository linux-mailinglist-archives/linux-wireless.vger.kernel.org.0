Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516ED573324
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiGMJpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A45EF9C9
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DG76LziSNeDUfVmn9tJn46vQ4awamEJ6AFjSoI70F0c=;
        t=1657705510; x=1658915110; b=TOmrosvyTLP4o5vaDN1BAX3kTbOAI8tLTXLZWF/RPBoflKG
        NMxnU5NN0fekhBifCqn9ulFurY/upBujNAA90fJCYPeUCXqHY7zjNBFRKjTT/4BF2aWudztTWS7Ey
        OZgJ5d/sUSd2jNXhrhtJt4BLQSgz4bSISiCx7HUB7wOxuc/JccXUnyP3yf19ukwSC6VoBbpsWA5++
        81DOrmTSt44ZBkgMUzBJuN5+fQIdK3FyHFnzRAWTSc7Vd+5DgFhBpoGfeUyvou495EoDVbxovSURt
        w8CM1QvaB97TwhII+yvB54JISiErLMBgu0RwWC/Ab604rMnVK9oZuAn4nqSJnDVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvb-00EgvB-T2;
        Wed, 13 Jul 2022 11:45:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/76] wifi: nl80211: hold wdev mutex for channel switch APIs
Date:   Wed, 13 Jul 2022 11:43:58 +0200
Message-Id: <20220713114425.6f718736f921.Ie0fba6025a9fe4bd0ec64fb5fff2d8765a5837fd@changeid>
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

Since we deal with links in an MLD here, hold the wdev
mutex now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 26d277c14fd4..59ea1157969e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3348,8 +3348,13 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
 	struct net_device *netdev = info->user_ptr[1];
+	int ret;
+
+	wdev_lock(netdev->ieee80211_ptr);
+	ret = __nl80211_set_channel(rdev, netdev, info, link_id);
+	wdev_unlock(netdev->ieee80211_ptr);
 
-	return __nl80211_set_channel(rdev, netdev, info, link_id);
+	return ret;
 }
 
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
@@ -3461,10 +3466,16 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		result = __nl80211_set_channel(
-			rdev,
-			nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
-			info, -1);
+		if (wdev) {
+			wdev_lock(wdev);
+			result = __nl80211_set_channel(
+				rdev,
+				nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
+				info, -1);
+			wdev_unlock(wdev);
+		} else {
+			result = __nl80211_set_channel(rdev, netdev, info, -1);
+		}
 		if (result)
 			goto out;
 	}
-- 
2.36.1

