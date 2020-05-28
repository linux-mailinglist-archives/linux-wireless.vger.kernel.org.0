Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA41E6B31
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406661AbgE1ThE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406535AbgE1ThC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:37:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C235C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:37:02 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIs-0054OL-Dw; Thu, 28 May 2020 21:34:58 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 19/24] cfg80211: require HE capabilities for 6 GHz band
Date:   Thu, 28 May 2020 21:34:42 +0200
Message-Id: <20200528213443.5881cb3c8c4a.I583b54172f91f98d44af64a16c5826fe458cbb27@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On 6 GHz band, HE capabilities must be available for all of
the interface types, otherwise we shouldn't use 6 GHz. Check
this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 1651f86db6ca..5b6714460490 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -791,6 +791,7 @@ int wiphy_register(struct wiphy *wiphy)
 	/* sanity check supported bands/channels */
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		u16 types = 0;
+		bool have_he = false;
 
 		sband = wiphy->bands[band];
 		if (!sband)
@@ -859,8 +860,17 @@ int wiphy_register(struct wiphy *wiphy)
 				return -EINVAL;
 
 			types |= iftd->types_mask;
+
+			if (i == 0)
+				have_he = iftd->he_cap.has_he;
+			else
+				have_he = have_he &&
+					  iftd->he_cap.has_he;
 		}
 
+		if (WARN_ON(!have_he && band == NL80211_BAND_6GHZ))
+			return -EINVAL;
+
 		have_band = true;
 	}
 
-- 
2.26.2

