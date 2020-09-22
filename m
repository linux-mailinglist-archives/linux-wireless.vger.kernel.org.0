Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48308273A3B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgIVFh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:29 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34018 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728901AbgIVFh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id BC5B74F9E0C;
        Tue, 22 Sep 2020 05:37:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hInuVOfDSjCs; Tue, 22 Sep 2020 05:37:26 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 82C9C4F9DFB;
        Tue, 22 Sep 2020 05:37:18 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 06/17] cfg80211: parse S1G Operation element for BSS channel
Date:   Mon, 21 Sep 2020 19:28:07 -0700
Message-Id: <20200922022818.15855-7-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extract the BSS primary channel from the S1G Operation
element.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---

v4:
 - add protection against strange IEs in S1G (Johannes)
---
 net/wireless/scan.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b4c85e8f2107..38dabe33a4c5 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1315,18 +1315,34 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 	int channel_number = -1;
 	struct ieee80211_channel *alt_channel;
 
+
+	if (channel->band == NL80211_BAND_S1GHZ) {
+		tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
+		if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
+			struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
+
+			channel_number = s1gop->primary_ch;
+		}
+
+		/* even if we didn't try to use the one frame came in on */
+		goto found_channel;
+	}
+
 	tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
 	if (tmp && tmp[1] == 1) {
 		channel_number = tmp[2];
-	} else {
-		tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
-		if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
-			struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
+		goto found_channel;
+	}
 
-			channel_number = htop->primary_chan;
-		}
+	tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
+	if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
+		struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
+
+		channel_number = htop->primary_chan;
+		goto found_channel;
 	}
 
+found_channel:
 	if (channel_number < 0) {
 		/* No channel information in frame payload */
 		return channel;
-- 
2.20.1

