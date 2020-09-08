Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32A261B8A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgIHTDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:03:47 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52712 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731692AbgIHTDf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 869434F9AF6;
        Tue,  8 Sep 2020 19:03:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ME-LNnyBFcbk; Tue,  8 Sep 2020 19:03:29 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id D60074F9AFC;
        Tue,  8 Sep 2020 19:03:21 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 06/22] {cfg,mac}80211: get correct default channel width for S1G
Date:   Tue,  8 Sep 2020 12:03:07 -0700
Message-Id: <20200908190323.15814-7-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Until now, the wifi default channels were assumed to be
NL80211_CHAN_NO_HT, or NL80211_CHAN_WIDTH_20_NOHT. S1G
devices however do not support these channel types/width.
When a default channel width is requested (during default
chandef init, or chanctx removal when not using channel
context), for S1G calculate the correct width. Fixes eg.
configuring strange (20Mhz) width during a scan on the S1G
band.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/chan.c |  9 ++++++++-
 net/wireless/chan.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index bdc0f29dc6cd..8f48aff74c7b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -536,7 +536,14 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 
 	if (!local->use_chanctx) {
 		struct cfg80211_chan_def *chandef = &local->_oper_chandef;
-		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
+		/* S1G doesn't have 20MHz, so get the correct width for the
+		 * current channel.
+		 */
+		if (chandef->chan->band == NL80211_BAND_S1GHZ)
+			chandef->width =
+				ieee80211_s1g_channel_width(chandef->chan);
+		else
+			chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 		chandef->center_freq1 = chandef->chan->center_freq;
 		chandef->freq1_offset = chandef->chan->freq_offset;
 		chandef->center_freq2 = 0;
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e27a6d5497b5..1407440779df 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -32,6 +32,16 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 	chandef->edmg.bw_config = 0;
 	chandef->edmg.channels = 0;
 
+	/* S1G allows a single width per channel, and since chan_type seems to
+	 * be for backwards compatibility only, ignore it and return the per
+	 * frequency width.
+	 */
+	if (chan->band == NL80211_BAND_S1GHZ) {
+		chandef->width = ieee80211_s1g_channel_width(chan);
+		chandef->center_freq1 = chan->center_freq;
+		return;
+	}
+
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
 		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-- 
2.20.1

