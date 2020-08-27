Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32B625511C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgH0WdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:21 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50398 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727961AbgH0WdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id C249E4F80CE;
        Thu, 27 Aug 2020 22:33:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f7PtT7hXLvcZ; Thu, 27 Aug 2020 22:33:14 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 3D0D94F80F8;
        Thu, 27 Aug 2020 22:33:08 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 05/22] nl80211: support setting S1G channels
Date:   Thu, 27 Aug 2020 15:32:47 -0700
Message-Id: <20200827223304.16155-6-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S1G channels have a single width defined per frequency, so
derive it from the channel flags with
ieee80211_s1g_channel_width().

Also support setting an S1G channel where control frequency may
differ from operating, and add some basic validation to
ensure the control channel is with the operating.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/net/cfg80211.h |  10 ++++
 net/wireless/chan.c    | 130 ++++++++++++++++++++++++-----------------
 net/wireless/util.c    |  27 +++++++++
 3 files changed, 115 insertions(+), 52 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2c737d6be9a1..f44839823d1e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5290,6 +5290,16 @@ ieee80211_channel_to_khz(const struct ieee80211_channel *chan)
 	return MHZ_TO_KHZ(chan->center_freq) + chan->freq_offset;
 }
 
+/**
+ * ieee80211_s1g_channel_width - get allowed channel width from @chan
+ *
+ * Only allowed for band NL80211_BAND_S1GHZ
+ * @chan: channel
+ * Return: The allowed channel width for this center_freq
+ */
+enum nl80211_chan_width
+ieee80211_s1g_channel_width(const struct ieee80211_channel *chan);
+
 /**
  * ieee80211_channel_to_freq_khz - convert channel number to frequency
  * @chan: channel number
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 90f0f82cd9ca..0a4b8d3eaed9 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -140,9 +140,62 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 	return true;
 }
 
+static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
+{
+	int mhz;
+
+	switch (chan_width) {
+	case NL80211_CHAN_WIDTH_1:
+		mhz = 1;
+		break;
+	case NL80211_CHAN_WIDTH_2:
+		mhz = 2;
+		break;
+	case NL80211_CHAN_WIDTH_4:
+		mhz = 4;
+		break;
+	case NL80211_CHAN_WIDTH_8:
+		mhz = 8;
+		break;
+	case NL80211_CHAN_WIDTH_16:
+		mhz = 16;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		mhz = 5;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		mhz = 10;
+		break;
+	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		mhz = 20;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		mhz = 40;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_80:
+		mhz = 80;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		mhz = 160;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -1;
+	}
+	return mhz;
+}
+
+static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
+{
+	return nl80211_chan_width_to_mhz(c->width);
+}
+
 bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
-	u32 control_freq;
+	u32 control_freq, oper_freq;
+	int oper_width, control_width;
 
 	if (!chandef->chan)
 		return false;
@@ -154,10 +207,6 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_1:
-	case NL80211_CHAN_WIDTH_2:
-	case NL80211_CHAN_WIDTH_4:
-	case NL80211_CHAN_WIDTH_8:
-	case NL80211_CHAN_WIDTH_16:
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20:
@@ -168,6 +217,30 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		if (chandef->center_freq2)
 			return false;
 		break;
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
+	case NL80211_CHAN_WIDTH_8:
+	case NL80211_CHAN_WIDTH_16:
+		control_freq = ieee80211_channel_to_khz(chandef->chan);
+		oper_freq = ieee80211_chandef_to_khz(chandef);
+		control_width = nl80211_chan_width_to_mhz(
+					ieee80211_s1g_channel_width(
+								chandef->chan));
+		oper_width = cfg80211_chandef_get_width(chandef);
+
+		if (oper_width < 0 || control_width < 0)
+			return false;
+		if (chandef->center_freq2)
+			return false;
+
+		if (control_freq + MHZ_TO_KHZ(control_width) / 2 >
+		    oper_freq + MHZ_TO_KHZ(oper_width) / 2)
+			return false;
+
+		if (control_freq - MHZ_TO_KHZ(control_width) / 2 <
+		    oper_freq - MHZ_TO_KHZ(oper_width) / 2)
+			return false;
+		break;
 	case NL80211_CHAN_WIDTH_40:
 		if (chandef->center_freq1 != control_freq + 10 &&
 		    chandef->center_freq1 != control_freq - 10)
@@ -263,53 +336,6 @@ static void chandef_primary_freqs(const struct cfg80211_chan_def *c,
 	}
 }
 
-static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
-{
-	int width;
-
-	switch (c->width) {
-	case NL80211_CHAN_WIDTH_1:
-		width = 1;
-		break;
-	case NL80211_CHAN_WIDTH_2:
-		width = 2;
-		break;
-	case NL80211_CHAN_WIDTH_4:
-		width = 4;
-		break;
-	case NL80211_CHAN_WIDTH_8:
-		width = 8;
-		break;
-	case NL80211_CHAN_WIDTH_16:
-		width = 16;
-		break;
-	case NL80211_CHAN_WIDTH_5:
-		width = 5;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		width = 10;
-		break;
-	case NL80211_CHAN_WIDTH_20:
-	case NL80211_CHAN_WIDTH_20_NOHT:
-		width = 20;
-		break;
-	case NL80211_CHAN_WIDTH_40:
-		width = 40;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-	case NL80211_CHAN_WIDTH_80:
-		width = 80;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		width = 160;
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return -1;
-	}
-	return width;
-}
-
 const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 			    const struct cfg80211_chan_def *c2)
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 383278c05a75..91ffb5132501 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -111,6 +111,33 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 }
 EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
 
+enum nl80211_chan_width
+ieee80211_s1g_channel_width(const struct ieee80211_channel *chan)
+{
+	if (WARN_ON(!chan || chan->band != NL80211_BAND_S1GHZ))
+		return NL80211_CHAN_WIDTH_20_NOHT;
+
+	/*S1G defines a single allowed channel width per channel.
+	 * Extract that width here.
+	 */
+	if (chan->flags & IEEE80211_CHAN_1MHZ)
+		return NL80211_CHAN_WIDTH_1;
+	else if (chan->flags & IEEE80211_CHAN_2MHZ)
+		return NL80211_CHAN_WIDTH_2;
+	else if (chan->flags & IEEE80211_CHAN_4MHZ)
+		return NL80211_CHAN_WIDTH_4;
+	else if (chan->flags & IEEE80211_CHAN_8MHZ)
+		return NL80211_CHAN_WIDTH_8;
+	else if (chan->flags & IEEE80211_CHAN_16MHZ)
+		return NL80211_CHAN_WIDTH_16;
+
+	pr_err("unknown channel width for channel at %dKHz?\n",
+	       ieee80211_channel_to_khz(chan));
+
+	return NL80211_CHAN_WIDTH_1;
+}
+EXPORT_SYMBOL(ieee80211_s1g_channel_width);
+
 int ieee80211_freq_khz_to_channel(u32 freq)
 {
 	/* TODO: just handle MHz for now */
-- 
2.20.1

