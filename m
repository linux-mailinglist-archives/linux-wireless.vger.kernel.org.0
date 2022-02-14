Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B0A4B457B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 10:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiBNJSe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 04:18:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbiBNJSd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 04:18:33 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1675606E8
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=gnBSBd9Esj0G6dPLnuW23VTcMz+DBLega5KEjtxrzk4=; t=1644830306; x=1646039906; 
        b=hhE4HTJosRedY+rN8C1h0Y7dS8a0jDHqqj8bEiqd0Huev9lvBrqMkX8wu+lftijOWY/zslRgwgI
        1lGLixb+Mu+6cKouHwr2a9iMfvaqMqjSP9mt55qM8oP799JEZuaD5NOAky/dFauqKbvmyu45/Wj5g
        /5gVXZlF7VaRFAio2Vnqlr01+cc55p0Q5+fKXin/RlKv3cTSadD23IhIDtMy8lnlxRxU7ru30gT5O
        HUtPMhqsaBp1tUSuE5pD3zWOtaM1KqmGa7jOp96iMCh82h9i2TSoW6BEe62G126u6wpNJzSZC9mes
        4h3HafMcw/ZN2INFb6bUWtaPXv8TqcKLFffA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJXV1-000twr-Vd;
        Mon, 14 Feb 2022 10:18:24 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: use RCU to read regdom in reg get/dump
Date:   Mon, 14 Feb 2022 10:18:20 +0100
Message-Id: <20220214101820.5d4acbcf2a46.Ibfc91980439862125e983d9adeebaba73fe38e2d@changeid>
X-Mailer: git-send-email 2.34.1
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

Use RCU here to read the regdomain, this will allow us
to remove the RTNL locking from the setter.

Note in nl80211_get_reg_do() we still need the RTNL to
do the wiphy lookup.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 578bff9c378b..56ff332132f7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7948,6 +7948,7 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev;
 	struct wiphy *wiphy = NULL;
 	struct sk_buff *msg;
+	int err = -EMSGSIZE;
 	void *hdr;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -7966,34 +7967,35 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
-			nlmsg_free(msg);
-			rtnl_unlock();
-			return PTR_ERR(rdev);
+			err = PTR_ERR(rdev);
+			goto nla_put_failure;
 		}
 
 		wiphy = &rdev->wiphy;
 		self_managed = wiphy->regulatory_flags &
 			       REGULATORY_WIPHY_SELF_MANAGED;
+
+		rcu_read_lock();
+
 		regdom = get_wiphy_regdom(wiphy);
 
 		/* a self-managed-reg device must have a private regdom */
 		if (WARN_ON(!regdom && self_managed)) {
-			nlmsg_free(msg);
-			rtnl_unlock();
-			return -EINVAL;
+			err = -EINVAL;
+			goto nla_put_failure_rcu;
 		}
 
 		if (regdom &&
 		    nla_put_u32(msg, NL80211_ATTR_WIPHY, get_wiphy_idx(wiphy)))
-			goto nla_put_failure;
+			goto nla_put_failure_rcu;
+	} else {
+		rcu_read_lock();
 	}
 
 	if (!wiphy && reg_last_request_cell_base() &&
 	    nla_put_u32(msg, NL80211_ATTR_USER_REG_HINT_TYPE,
 			NL80211_USER_REG_HINT_CELL_BASE))
-		goto nla_put_failure;
-
-	rcu_read_lock();
+		goto nla_put_failure_rcu;
 
 	if (!regdom)
 		regdom = rcu_dereference(cfg80211_regdomain);
@@ -8013,7 +8015,7 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 	rtnl_unlock();
 put_failure:
 	nlmsg_free(msg);
-	return -EMSGSIZE;
+	return err;
 }
 
 static int nl80211_send_regdom(struct sk_buff *msg, struct netlink_callback *cb,
@@ -8059,19 +8061,19 @@ static int nl80211_get_reg_dump(struct sk_buff *skb,
 	struct cfg80211_registered_device *rdev;
 	int err, reg_idx, start = cb->args[2];
 
-	rtnl_lock();
+	rcu_read_lock();
 
 	if (cfg80211_regdomain && start == 0) {
 		err = nl80211_send_regdom(skb, cb, cb->nlh->nlmsg_seq,
 					  NLM_F_MULTI, NULL,
-					  rtnl_dereference(cfg80211_regdomain));
+					  rcu_dereference(cfg80211_regdomain));
 		if (err < 0)
 			goto out_err;
 	}
 
 	/* the global regdom is idx 0 */
 	reg_idx = 1;
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
 		regdom = get_wiphy_regdom(&rdev->wiphy);
 		if (!regdom)
 			continue;
@@ -8090,7 +8092,7 @@ static int nl80211_get_reg_dump(struct sk_buff *skb,
 	cb->args[2] = reg_idx;
 	err = skb->len;
 out_err:
-	rtnl_unlock();
+	rcu_read_unlock();
 	return err;
 }
 
-- 
2.34.1

