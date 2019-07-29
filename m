Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6878E07
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfG2ObS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 10:31:18 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34670 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfG2ObS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 10:31:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hs6gF-0005jU-1j; Mon, 29 Jul 2019 16:31:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] cfg80211: use parallel_ops for genl
Date:   Mon, 29 Jul 2019 16:31:09 +0200
Message-Id: <20190729143109.18683-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Over time, we really need to get rid of all of our global locking.
One of the things needed is to use parallel_ops. This isn't really
the most important (RTNL is much more important) but OTOH we just
keep adding uses of genl_family_attrbuf() now. Use .parallel_ops to
disallow this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20190726191621.5031-1-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 108 +++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 30 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a8d4b2b6b3ec..b45d0108d2cc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -749,17 +749,25 @@ int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 	int err;
 
 	if (!cb->args[0]) {
+		struct nlattr **attrbuf;
+
+		attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf),
+				  GFP_KERNEL);
+		if (!attrbuf)
+			return -ENOMEM;
+
 		err = nlmsg_parse_deprecated(cb->nlh,
 					     GENL_HDRLEN + nl80211_fam.hdrsize,
-					     genl_family_attrbuf(&nl80211_fam),
-					     nl80211_fam.maxattr,
+					     attrbuf, nl80211_fam.maxattr,
 					     nl80211_policy, NULL);
-		if (err)
+		if (err) {
+			kfree(attrbuf);
 			return err;
+		}
 
-		*wdev = __cfg80211_wdev_from_attrs(
-					sock_net(cb->skb->sk),
-					genl_family_attrbuf(&nl80211_fam));
+		*wdev = __cfg80211_wdev_from_attrs(sock_net(cb->skb->sk),
+						   attrbuf);
+		kfree(attrbuf);
 		if (IS_ERR(*wdev))
 			return PTR_ERR(*wdev);
 		*rdev = wiphy_to_rdev((*wdev)->wiphy);
@@ -2390,14 +2398,21 @@ static int nl80211_dump_wiphy_parse(struct sk_buff *skb,
 				    struct netlink_callback *cb,
 				    struct nl80211_dump_wiphy_state *state)
 {
-	struct nlattr **tb = genl_family_attrbuf(&nl80211_fam);
-	int ret = nlmsg_parse_deprecated(cb->nlh,
-					 GENL_HDRLEN + nl80211_fam.hdrsize,
-					 tb, nl80211_fam.maxattr,
-					 nl80211_policy, NULL);
+	struct nlattr **tb = kcalloc(NUM_NL80211_ATTR, sizeof(*tb), GFP_KERNEL);
+	int ret;
+
+	if (!tb)
+		return -ENOMEM;
+
+	ret = nlmsg_parse_deprecated(cb->nlh,
+				     GENL_HDRLEN + nl80211_fam.hdrsize,
+				     tb, nl80211_fam.maxattr,
+				     nl80211_policy, NULL);
 	/* ignore parse errors for backward compatibility */
-	if (ret)
-		return 0;
+	if (ret) {
+		ret = 0;
+		goto out;
+	}
 
 	state->split = tb[NL80211_ATTR_SPLIT_WIPHY_DUMP];
 	if (tb[NL80211_ATTR_WIPHY])
@@ -2410,8 +2425,10 @@ static int nl80211_dump_wiphy_parse(struct sk_buff *skb,
 		int ifidx = nla_get_u32(tb[NL80211_ATTR_IFINDEX]);
 
 		netdev = __dev_get_by_index(sock_net(skb->sk), ifidx);
-		if (!netdev)
-			return -ENODEV;
+		if (!netdev) {
+			ret = -ENODEV;
+			goto out;
+		}
 		if (netdev->ieee80211_ptr) {
 			rdev = wiphy_to_rdev(
 				netdev->ieee80211_ptr->wiphy);
@@ -2419,7 +2436,10 @@ static int nl80211_dump_wiphy_parse(struct sk_buff *skb,
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(tb);
+	return ret;
 }
 
 static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
@@ -8724,7 +8744,7 @@ static int nl80211_send_survey(struct sk_buff *msg, u32 portid, u32 seq,
 
 static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct nlattr **attrbuf = genl_family_attrbuf(&nl80211_fam);
+	struct nlattr **attrbuf;
 	struct survey_info survey;
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
@@ -8732,6 +8752,10 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	int res;
 	bool radio_stats;
 
+	attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf), GFP_KERNEL);
+	if (!attrbuf)
+		return -ENOMEM;
+
 	rtnl_lock();
 	res = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
 	if (res)
@@ -8776,6 +8800,7 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[2] = survey_idx;
 	res = skb->len;
  out_err:
+	kfree(attrbuf);
 	rtnl_unlock();
 	return res;
 }
@@ -9635,6 +9660,7 @@ static int nl80211_testmode_dump(struct sk_buff *skb,
 				 struct netlink_callback *cb)
 {
 	struct cfg80211_registered_device *rdev;
+	struct nlattr **attrbuf = NULL;
 	int err;
 	long phy_idx;
 	void *data = NULL;
@@ -9655,7 +9681,12 @@ static int nl80211_testmode_dump(struct sk_buff *skb,
 			goto out_err;
 		}
 	} else {
-		struct nlattr **attrbuf = genl_family_attrbuf(&nl80211_fam);
+		attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf),
+				  GFP_KERNEL);
+		if (!attrbuf) {
+			err = -ENOMEM;
+			goto out_err;
+		}
 
 		err = nlmsg_parse_deprecated(cb->nlh,
 					     GENL_HDRLEN + nl80211_fam.hdrsize,
@@ -9722,6 +9753,7 @@ static int nl80211_testmode_dump(struct sk_buff *skb,
 	/* see above */
 	cb->args[0] = phy_idx + 1;
  out_err:
+	kfree(attrbuf);
 	rtnl_unlock();
 	return err;
 }
@@ -12815,7 +12847,7 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 				       struct cfg80211_registered_device **rdev,
 				       struct wireless_dev **wdev)
 {
-	struct nlattr **attrbuf = genl_family_attrbuf(&nl80211_fam);
+	struct nlattr **attrbuf;
 	u32 vid, subcmd;
 	unsigned int i;
 	int vcmd_idx = -1;
@@ -12846,24 +12878,32 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 		return 0;
 	}
 
+	attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf), GFP_KERNEL);
+	if (!attrbuf)
+		return -ENOMEM;
+
 	err = nlmsg_parse_deprecated(cb->nlh,
 				     GENL_HDRLEN + nl80211_fam.hdrsize,
 				     attrbuf, nl80211_fam.maxattr,
 				     nl80211_policy, NULL);
 	if (err)
-		return err;
+		goto out;
 
 	if (!attrbuf[NL80211_ATTR_VENDOR_ID] ||
-	    !attrbuf[NL80211_ATTR_VENDOR_SUBCMD])
-		return -EINVAL;
+	    !attrbuf[NL80211_ATTR_VENDOR_SUBCMD]) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	*wdev = __cfg80211_wdev_from_attrs(sock_net(skb->sk), attrbuf);
 	if (IS_ERR(*wdev))
 		*wdev = NULL;
 
 	*rdev = __cfg80211_rdev_from_attrs(sock_net(skb->sk), attrbuf);
-	if (IS_ERR(*rdev))
-		return PTR_ERR(*rdev);
+	if (IS_ERR(*rdev)) {
+		err = PTR_ERR(*rdev);
+		goto out;
+	}
 
 	vid = nla_get_u32(attrbuf[NL80211_ATTR_VENDOR_ID]);
 	subcmd = nla_get_u32(attrbuf[NL80211_ATTR_VENDOR_SUBCMD]);
@@ -12876,15 +12916,19 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 		if (vcmd->info.vendor_id != vid || vcmd->info.subcmd != subcmd)
 			continue;
 
-		if (!vcmd->dumpit)
-			return -EOPNOTSUPP;
+		if (!vcmd->dumpit) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
 
 		vcmd_idx = i;
 		break;
 	}
 
-	if (vcmd_idx < 0)
-		return -EOPNOTSUPP;
+	if (vcmd_idx < 0) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (attrbuf[NL80211_ATTR_VENDOR_DATA]) {
 		data = nla_data(attrbuf[NL80211_ATTR_VENDOR_DATA]);
@@ -12895,7 +12939,7 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 				attrbuf[NL80211_ATTR_VENDOR_DATA],
 				cb->extack);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* 0 is the first index - add 1 to parse only once */
@@ -12907,7 +12951,10 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 	cb->args[4] = data_len;
 
 	/* keep rtnl locked in successful case */
-	return 0;
+	err = 0;
+out:
+	kfree(attrbuf);
+	return err;
 }
 
 static int nl80211_vendor_cmd_dump(struct sk_buff *skb,
@@ -14585,6 +14632,7 @@ static struct genl_family nl80211_fam __ro_after_init = {
 	.n_ops = ARRAY_SIZE(nl80211_ops),
 	.mcgrps = nl80211_mcgrps,
 	.n_mcgrps = ARRAY_SIZE(nl80211_mcgrps),
+	.parallel_ops = true,
 };
 
 /* notification functions */
-- 
2.20.1

