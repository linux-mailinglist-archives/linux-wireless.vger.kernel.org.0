Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED51255125
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgH0Wde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:34 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50462 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728014AbgH0Wd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 1976B4F7FD9;
        Thu, 27 Aug 2020 22:33:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nc5z3GesCfgm; Thu, 27 Aug 2020 22:33:23 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 7AB034F8094;
        Thu, 27 Aug 2020 22:33:10 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 11/22] cfg80211: parse S1G Operation element for BSS channel
Date:   Thu, 27 Aug 2020 15:32:53 -0700
Message-Id: <20200827223304.16155-12-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
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
index bf72a13dd2aa..169b6904e011 100644
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

