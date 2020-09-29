Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FF27D5AD
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 20:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgI2STw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 14:19:52 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:56814 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725320AbgI2STw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 14:19:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 2F91E4F9FF0;
        Tue, 29 Sep 2020 18:19:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zxySzrkbIJB7; Tue, 29 Sep 2020 18:19:49 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 706784F9FEC;
        Tue, 29 Sep 2020 18:19:49 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH] mac80211: process S1G Operation element before HT
Date:   Tue, 29 Sep 2020 11:19:48 -0700
Message-Id: <20200929181948.22894-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sband->ht_cap was being processed before S1G Operation
element.  Since the HT capability element should not be
present on the S1G band, avoid processing potential
garbage by moving the call to
ieee80211_apply_htcap_overrides() to after the S1G block.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 38e87ac9902e..80b4d46d0b20 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -174,9 +174,6 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
-	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
-
 	if (s1g_oper && sband->band == NL80211_BAND_S1GHZ) {
 		ieee80211_chandef_s1g_oper(s1g_oper, chandef);
 		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
@@ -186,6 +183,9 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
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

