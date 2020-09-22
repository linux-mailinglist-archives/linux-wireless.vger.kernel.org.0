Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF093273A36
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgIVFhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:21 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:33940 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728384AbgIVFhU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 65F824F2279;
        Tue, 22 Sep 2020 05:37:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wY-DPTS5RD5G; Tue, 22 Sep 2020 05:37:17 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 5F78A4F9DF0;
        Tue, 22 Sep 2020 05:37:17 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 01/17] {cfg,mac}80211: get correct default channel width for S1G
Date:   Mon, 21 Sep 2020 19:28:02 -0700
Message-Id: <20200922022818.15855-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When deleting a channel context, mac80211 would assing
NL80211_CHAN_WIDTH_20_NOHT as the default channel width.
This is wrong in S1G however, so instead get the allowed
channel width for a given channel.

Fixes eg.  configuring strange (20Mhz) width during a scan
on the S1G band.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---

v4:
 - drop S1G channel width calculation in
   cfg80211_chandef_create as it is not needed (Johannes)
---
 net/mac80211/chan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

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
-- 
2.20.1

