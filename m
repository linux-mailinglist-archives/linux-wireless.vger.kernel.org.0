Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C637261B8E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgIHTEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:04:37 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52724 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731704AbgIHTDj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 0E8DD4F9AFC;
        Tue,  8 Sep 2020 19:03:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yaDXb8JiQvk1; Tue,  8 Sep 2020 19:03:31 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 289044F9ACB;
        Tue,  8 Sep 2020 19:03:22 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 07/22] mac80211: s1g: choose scanning width based on frequency
Date:   Tue,  8 Sep 2020 12:03:08 -0700
Message-Id: <20200908190323.15814-8-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

An S1G BSS can beacon at either 1 or 2 MHz and the channel
width is unique to a given frequency. Ignore scan channel
width for now and use the allowed channel width.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/scan.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5ac2785cdc7b..5002791fe165 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -905,6 +905,17 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	local->scan_chandef.center_freq1 = chan->center_freq;
 	local->scan_chandef.freq1_offset = chan->freq_offset;
 	local->scan_chandef.center_freq2 = 0;
+
+	/* For scanning on the S1G band, ignore scan_width (which is constant
+	 * across all channels) for now since channel width is specific to each
+	 * channel. Detect the required channel width here and likely revisit
+	 * later. Maybe scan_width could be used to build the channel scan list?
+	 */
+	if (chan->band == NL80211_BAND_S1GHZ) {
+		local->scan_chandef.width = ieee80211_s1g_channel_width(chan);
+		goto  set_channel;
+	}
+
 	switch (scan_req->scan_width) {
 	case NL80211_BSS_CHAN_WIDTH_5:
 		local->scan_chandef.width = NL80211_CHAN_WIDTH_5;
@@ -925,8 +936,14 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 		else
 			local->scan_chandef.width = NL80211_CHAN_WIDTH_20_NOHT;
 		break;
+	case NL80211_BSS_CHAN_WIDTH_1:
+	case NL80211_BSS_CHAN_WIDTH_2:
+		/* shouldn't get here, S1G handled above */
+		WARN_ON(1);
+		break;
 	}
 
+set_channel:
 	if (ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_CHANNEL))
 		skip = 1;
 
-- 
2.20.1

