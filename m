Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C72805C9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 19:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgJARrx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 13:47:53 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:35732 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732096AbgJARrx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 13:47:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 76C3F4FA090;
        Thu,  1 Oct 2020 17:47:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qZb2HNhWpCCD; Thu,  1 Oct 2020 17:47:49 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 832354F9067;
        Thu,  1 Oct 2020 17:47:49 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH] mac80211: avoid processing non-S1G elements on S1G band
Date:   Thu,  1 Oct 2020 10:47:48 -0700
Message-Id: <20201001174748.24520-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In ieee80211_determine_chantype(), the sband->ht_cap was
being processed before S1G Operation element.  Since the
HT capability element should not be present on the S1G
band, avoid processing potential garbage by moving the
call to ieee80211_apply_htcap_overrides() to after the S1G
block.

Also, in case of a missing S1G Operation element, we would
continue trying to process non-S1G elements (and return
with a channel width of 20MHz). Instead, just assume
primary channel is equal to operating and infer the
operating width from the BSS channel, then return.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/mlme.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 38e87ac9902e..e9a8e8e94ee6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -172,13 +172,13 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			ret = 0;
 		vht_chandef = *chandef;
 		goto out;
-	}
-
-	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
-	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+	} else if (sband->band == NL80211_BAND_S1GHZ) {
+		if (!ieee80211_chandef_s1g_oper(s1g_oper, chandef)) {
+			sdata_info(sdata,
+				   "Missing S1G Operation Element? Trying operating == primary\n");
+			chandef->width = ieee80211_s1g_channel_width(channel);
+		}
 
-	if (s1g_oper && sband->band == NL80211_BAND_S1GHZ) {
-		ieee80211_chandef_s1g_oper(s1g_oper, chandef);
 		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
 		      IEEE80211_STA_DISABLE_VHT |
 		      IEEE80211_STA_DISABLE_80P80MHZ |
@@ -186,6 +186,9 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
+	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
+	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		ret = IEEE80211_STA_DISABLE_HT |
 		      IEEE80211_STA_DISABLE_VHT |
-- 
2.20.1

