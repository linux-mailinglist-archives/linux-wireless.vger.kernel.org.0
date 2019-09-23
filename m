Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1035CBB324
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfIWLvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 07:51:23 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37200 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfIWLvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 07:51:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iCMsD-0001oa-7d; Mon, 23 Sep 2019 13:51:21 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] cfg80211: initialize on-stack chandefs
Date:   Mon, 23 Sep 2019 13:51:16 +0200
Message-Id: <1569239475-I2dcce394ecf873376c386a78f31c2ec8b538fa25@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In a few places we don't properly initialize on-stack chandefs,
resulting in EDMG data to be non-zero, which broke things.

Additionally, in a few places we rely on the driver to init the
data completely, but perhaps we shouldn't as non-EDMG drivers
may not initialize the EDMG data, also initialize it there.

Fixes: 2a38075cd0be ("nl80211: Add support for EDMG channels")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c     | 4 +++-
 net/wireless/reg.c         | 2 +-
 net/wireless/wext-compat.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d21b1581a665..b9797a3c110a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2636,6 +2636,8 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 
 	control_freq = nla_get_u32(attrs[NL80211_ATTR_WIPHY_FREQ]);
 
+	memset(chandef, 0, sizeof(*chandef));
+
 	chandef->chan = ieee80211_get_channel(&rdev->wiphy, control_freq);
 	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 	chandef->center_freq1 = control_freq;
@@ -3176,7 +3178,7 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 
 	if (rdev->ops->get_channel) {
 		int ret;
-		struct cfg80211_chan_def chandef;
+		struct cfg80211_chan_def chandef = {};
 
 		ret = rdev_get_channel(rdev, wdev, &chandef);
 		if (ret == 0) {
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 5311d0ae2454..420c4207ab59 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2108,7 +2108,7 @@ static void reg_call_notifier(struct wiphy *wiphy,
 
 static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 {
-	struct cfg80211_chan_def chandef;
+	struct cfg80211_chan_def chandef = {};
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	enum nl80211_iftype iftype;
 
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 7b6529d81c61..cac9e28d852b 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -798,7 +798,7 @@ static int cfg80211_wext_giwfreq(struct net_device *dev,
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	struct cfg80211_chan_def chandef;
+	struct cfg80211_chan_def chandef = {};
 	int ret;
 
 	switch (wdev->iftype) {
-- 
2.20.1

