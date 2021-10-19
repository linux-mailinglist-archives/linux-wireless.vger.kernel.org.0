Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21143353F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhJSMB7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 08:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhJSMB6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 08:01:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DE926113D;
        Tue, 19 Oct 2021 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634644786;
        bh=tyaEHIND8wtVgCzYDUnjRRE9A+umQK4q8h0ga8CK+Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ks5sGGotgegwGkTxrZ89hBNlL4RS1Mp+5NBXcM5v4z4PIY5sYJwQ5s3G7Xfts1gbP
         O1rNvFAAxQEV6AFoz+Fg+jY7iyrKV9BuNj208uQBNDJpkgaZzh2DQe6TAUg+DpMe29
         b3xJC0EedfVjeAj+3hdsjX2l8oBPFFk2tYBiF5v3GJ/2w7EwJUmDsW4VFw83NOoXf6
         gDrP6xXZZPu8YsjSkrkFMEKxAxbcZOhSQhjSPa0Xivtkj6l+8h/Bqkh+wI/cVm/CLp
         ierhu1pXY0y0U5176roSClgllggyPFfAsVWYpNKnTmPty8NDY5LuRidrsaeoilwQjI
         ZJx0V/275dQgQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: [PATCH mac80211-next 2/4] cfg80211: introduce NL80211_ATTR_RADAR_OFFCHAN netlink attribute
Date:   Tue, 19 Oct 2021 13:59:05 +0200
Message-Id: <c3adad927a5d32003fd969edc32c566869673a34.1634644309.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634644309.git.lorenzo@kernel.org>
References: <cover.1634644309.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_ATTR_RADAR_OFFCHAN netlink attribute in order to
configure offchannel radar chain if supported by the underlay driver.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index eda608b1eb09..96e622777bb2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2639,6 +2639,10 @@ enum nl80211_commands {
  *	Mandatory parameter for the transmitting interface to enable MBSSID.
  *	Optional for the non-transmitting interfaces.
  *
+ * @NL80211_ATTR_RADAR_OFFCHAN: Configure dedicated chain available for radar
+ *	detection on some hw. The chain can't be used to transmits or receives
+ *	frames. The driver is supposed to implement CAC management in sw or fw.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3145,6 +3149,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MBSSID_CONFIG,
 	NL80211_ATTR_MBSSID_ELEMS,
 
+	NL80211_ATTR_RADAR_OFFCHAN,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3f37e4d5c5d2..a296f180624e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -776,6 +776,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MBSSID_CONFIG] =
 			NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
+	[NL80211_ATTR_RADAR_OFFCHAN] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -9279,10 +9280,12 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	if (netif_carrier_ok(dev))
+	if (!nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN]) &&
+	    netif_carrier_ok(dev))
 		return -EBUSY;
 
-	if (wdev->cac_started)
+	if (!nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN]) &&
+	    wdev->cac_started)
 		return -EBUSY;
 
 	err = cfg80211_chandef_dfs_required(wiphy, &chandef, wdev->iftype);
@@ -9299,6 +9302,11 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD))
 		return -EOPNOTSUPP;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN])) {
+		/* offchannel radar detection */
+		return rdev_set_radar_offchan(rdev, &chandef);
+	}
+
 	if (!rdev->ops->start_radar_detection)
 		return -EOPNOTSUPP;
 
-- 
2.31.1

