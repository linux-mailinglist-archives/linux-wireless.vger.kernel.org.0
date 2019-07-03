Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A1E5E59A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGCNib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 09:38:31 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:38378 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCNib (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 09:38:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hifSu-0000Uu-V0; Wed, 03 Jul 2019 15:38:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] cfg80211: don't parse MBSSID if transmitting BSS isn't created
Date:   Wed,  3 Jul 2019 15:38:22 +0200
Message-Id: <20190703133823.10530-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190703133823.10530-1-johannes@sipsolutions.net>
References: <20190703133823.10530-1-johannes@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Don't parse the multi-BSSID structures if we couldn't even create
their transmitting BSS, this would confuse all of our tracking.

This also means that non_tx_data->tx_bss will never be NULL, so
we can clean up a little bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 70d061ed9cb6..186ae1bb510a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1440,7 +1440,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 			regulatory_hint_found_beacon(wiphy, channel, gfp);
 	}
 
-	if (non_tx_data && non_tx_data->tx_bss) {
+	if (non_tx_data) {
 		/* this is a nontransmitting bss, we need to add it to
 		 * transmitting bss' list if it is not there
 		 */
@@ -1659,6 +1659,8 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 	res = cfg80211_inform_single_bss_data(wiphy, data, ftype, bssid, tsf,
 					      capability, beacon_interval, ie,
 					      ielen, NULL, gfp);
+	if (!res)
+		return NULL;
 	non_tx_data.tx_bss = res;
 	cfg80211_parse_mbssid_data(wiphy, data, ftype, bssid, tsf,
 				   beacon_interval, ie, ielen, &non_tx_data,
-- 
2.17.2

