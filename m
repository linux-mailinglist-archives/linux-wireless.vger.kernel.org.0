Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C805E433541
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhJSMCG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 08:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235512AbhJSMCB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 08:02:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5361608FE;
        Tue, 19 Oct 2021 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634644788;
        bh=5TpOpCEmRgdDJAFrndHldF7r7JFyL8Oty5GQHp4GKF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kU0NdzehiCgcugWCGC04fVItE99rULOuzP8bS5mWE3bbd7lPG18VHLJ5Zmuxdm0lV
         lM0GXuKn8Fr/mWLpCpssgOVeHMXRZ+4ugBexTttN+DNtkw57tULm6QhPKpwPsBq0BT
         w8tANrXLXATKbN5ktqwE8NIgoefMFLhltduRL0A0XdMqo7r794A524FOchtTQK45dx
         Bby7voGQS+7l7FOi5P9yVYMP5kMaKwHRozMNZedrzvU9us/4HaCsNda9jA0892LQRC
         B9g0Gk4mZSsE3hsmaRPSQUjzrlisqJpBpT3WIb6U/LdA9xm3T6bX7tO+0ws6fZ05kk
         /SxhE6LGqhUIA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: [PATCH mac80211-next 4/4] cfg80211: introduce NL80211_EXT_FEATURE_RADAR_OFFCHAN feature flag
Date:   Tue, 19 Oct 2021 13:59:07 +0200
Message-Id: <b453dd696f27559cd028e49cf8f9d5566a2e0601.1634644309.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634644309.git.lorenzo@kernel.org>
References: <cover.1634644309.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_EXT_FEATURE_RADAR_OFFCHAN feature flag in order to
notify userland the underlay hw supports offchannel radar/CAC detection.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/uapi/linux/nl80211.h | 4 ++++
 net/wireless/nl80211.c       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 96e622777bb2..d856c95ea736 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6055,6 +6055,9 @@ enum nl80211_feature_flags {
  *	frames. Userspace has to share FILS AAD details to the driver by using
  *	@NL80211_CMD_SET_FILS_AAD.
  *
+ * @NL80211_EXT_FEATURE_RADAR_OFFCHAN: Device supports offchannel radar/CAC
+ *	detection.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6121,6 +6124,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE,
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
+	NL80211_EXT_FEATURE_RADAR_OFFCHAN,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a296f180624e..9f19ff5b13c5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9304,6 +9304,10 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN])) {
 		/* offchannel radar detection */
+		if (!wiphy_ext_feature_isset(wiphy,
+					     NL80211_EXT_FEATURE_RADAR_OFFCHAN))
+			return -EOPNOTSUPP;
+
 		return rdev_set_radar_offchan(rdev, &chandef);
 	}
 
-- 
2.31.1

