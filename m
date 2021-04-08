Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55248358344
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDHM2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhDHM2n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:28:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4FC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:28:32 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUTlu-008ztO-An; Thu, 08 Apr 2021 14:28:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: check S1G beacon compat element length
Date:   Thu,  8 Apr 2021 14:28:27 +0200
Message-Id: <20210408142826.f6f4525012de.I9fdeff0afdc683a6024e5ea49d2daa3cd2459d11@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We need to check the length of this element so that we don't
access data beyond its end. Fix that.

Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 019952d4fc7d..758eb7d2a706 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2352,14 +2352,16 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 		return NULL;
 
 	if (ext) {
-		struct ieee80211_s1g_bcn_compat_ie *compat;
-		u8 *ie;
+		const struct ieee80211_s1g_bcn_compat_ie *compat;
+		const struct element *elem;
 
-		ie = (void *)cfg80211_find_ie(WLAN_EID_S1G_BCN_COMPAT,
-					      variable, ielen);
-		if (!ie)
+		elem = cfg80211_find_elem(WLAN_EID_S1G_BCN_COMPAT,
+					  variable, ielen);
+		if (!elem)
+			return NULL;
+		if (elem->datalen < sizeof(*compat))
 			return NULL;
-		compat = (void *)(ie + 2);
+		compat = (void *)elem->data;
 		bssid = ext->u.s1g_beacon.sa;
 		capability = le16_to_cpu(compat->compat_info);
 		beacon_int = le16_to_cpu(compat->beacon_int);
-- 
2.30.2

