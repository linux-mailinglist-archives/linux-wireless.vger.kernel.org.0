Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11F8261B8D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgIHTEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:04:37 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52712 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731267AbgIHTDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id D22E04F9B05;
        Tue,  8 Sep 2020 19:03:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hL1dqq7M2wh8; Tue,  8 Sep 2020 19:03:37 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 5F8144F9AFF;
        Tue,  8 Sep 2020 19:03:23 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 11/22] cfg80211: parse S1G Operation element for BSS channel
Date:   Tue,  8 Sep 2020 12:03:12 -0700
Message-Id: <20200908190323.15814-12-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extract the BSS primary channel from the S1G Operation
element.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/wireless/scan.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b4c85e8f2107..c2dcb9092257 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1318,15 +1318,26 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
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
+	}
+
+	tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
+	if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
+		struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
+
+		channel_number = s1gop->primary_ch;
+		goto found_channel;
 	}
 
+found_channel:
 	if (channel_number < 0) {
 		/* No channel information in frame payload */
 		return channel;
-- 
2.20.1

