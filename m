Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A69283CFC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgJERC6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 13:02:58 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:37164 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726320AbgJERC6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 13:02:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id C0EBC4FA159;
        Mon,  5 Oct 2020 16:51:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u1y-kOCBxBGU; Mon,  5 Oct 2020 16:51:21 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id BD4DF4FA158;
        Mon,  5 Oct 2020 16:51:20 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>,
        syzbot+92715a0eccd6c881bc32@syzkaller.appspotmail.com
Subject: [PATCH] cfg80211: only allow S1G channels on S1G band
Date:   Mon,  5 Oct 2020 09:51:22 -0700
Message-Id: <20201005165122.17583-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As discovered by syzbot, cfg80211 was accepting S1G
channel widths on non-S1G bands. Add a check for this, and
consolidate the 1MHz frequency check as it ends up being a
subset of the others.

Reported-by: syzbot+92715a0eccd6c881bc32@syzkaller.appspotmail.com
Fixes: 11b34737b18a ("nl80211: support setting S1G channels")
Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/wireless/chan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 96e24ee4c7e8..22d1779ab2b1 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -207,7 +207,6 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	control_freq = chandef->chan->center_freq;
 
 	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_1:
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20:
@@ -218,10 +217,14 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		if (chandef->center_freq2)
 			return false;
 		break;
+	case NL80211_CHAN_WIDTH_1:
 	case NL80211_CHAN_WIDTH_2:
 	case NL80211_CHAN_WIDTH_4:
 	case NL80211_CHAN_WIDTH_8:
 	case NL80211_CHAN_WIDTH_16:
+		if (chandef->chan->band != NL80211_BAND_S1GHZ)
+			return false;
+
 		control_freq = ieee80211_channel_to_khz(chandef->chan);
 		oper_freq = ieee80211_chandef_to_khz(chandef);
 		control_width = nl80211_chan_width_to_mhz(
-- 
2.20.1

