Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C41E64CC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391384AbgE1Oyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391387AbgE1Oyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:54:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA39BC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:54:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJra-004vYI-Li; Thu, 28 May 2020 16:50:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/24] cfg80211: treat 6 GHz channels as valid regardless of capability
Date:   Thu, 28 May 2020 16:50:13 +0200
Message-Id: <20200528165011.f51a626ad410.I82f09b2b14a56413ce20376d09967fe954a033eb@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If a 6 GHz channel exists, then we can probably safely assume that
the device actually supports it, and then it should support most
bandwidths.

This will probably need to be extended to check the interface type
and then dig into the HE capabilities for that though, to have the
correct bandwidth check.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/chan.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e111c08daa0e..cddf92c5d09e 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -6,7 +6,7 @@
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2018       Intel Corporation
+ * Copyright 2018-2020	Intel Corporation
  */
 
 #include <linux/export.h>
@@ -919,7 +919,8 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		width = 10;
 		break;
 	case NL80211_CHAN_WIDTH_20:
-		if (!ht_cap->ht_supported)
+		if (!ht_cap->ht_supported &&
+		    chandef->chan->band != NL80211_BAND_6GHZ)
 			return false;
 		/* fall through */
 	case NL80211_CHAN_WIDTH_20_NOHT:
@@ -928,6 +929,8 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		width = 40;
+		if (chandef->chan->band == NL80211_BAND_6GHZ)
+			break;
 		if (!ht_cap->ht_supported)
 			return false;
 		if (!(ht_cap->cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) ||
@@ -942,24 +945,29 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
 		cap = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-		if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
+		if (chandef->chan->band != NL80211_BAND_6GHZ &&
+		    cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
 			return false;
 		/* fall through */
 	case NL80211_CHAN_WIDTH_80:
-		if (!vht_cap->vht_supported)
-			return false;
 		prohibited_flags |= IEEE80211_CHAN_NO_80MHZ;
 		width = 80;
+		if (chandef->chan->band == NL80211_BAND_6GHZ)
+			break;
+		if (!vht_cap->vht_supported)
+			return false;
 		break;
 	case NL80211_CHAN_WIDTH_160:
+		prohibited_flags |= IEEE80211_CHAN_NO_160MHZ;
+		width = 160;
+		if (chandef->chan->band == NL80211_BAND_6GHZ)
+			break;
 		if (!vht_cap->vht_supported)
 			return false;
 		cap = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 		if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
 		    cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
 			return false;
-		prohibited_flags |= IEEE80211_CHAN_NO_160MHZ;
-		width = 160;
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.26.2

