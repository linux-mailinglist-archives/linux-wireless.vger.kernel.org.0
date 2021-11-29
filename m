Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D872F46169D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348267AbhK2Nia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49826 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242441AbhK2NgY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:24 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmE-0012xo-Vz; Mon, 29 Nov 2021 15:33:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:43 +0200
Message-Id: <iwlwifi.20211129152938.2d0240b07f11.I759e8e990f5386ba2b56ffb2488a8d4e16e22c1b@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/16] cfg80211: simplify cfg80211_chandef_valid()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are a lot of duplicate checks in this function to
check the delta between the control channel and CF1.
With the addition of 320 MHz, this will become even more.
Simplify the code so that the common checks are done
only once for multiple bandwidths.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/chan.c | 62 +++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 869c43d4414c..5b865c4719d1 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -245,19 +245,7 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		    oper_freq - MHZ_TO_KHZ(oper_width) / 2)
 			return false;
 		break;
-	case NL80211_CHAN_WIDTH_40:
-		if (chandef->center_freq1 != control_freq + 10 &&
-		    chandef->center_freq1 != control_freq - 10)
-			return false;
-		if (chandef->center_freq2)
-			return false;
-		break;
 	case NL80211_CHAN_WIDTH_80P80:
-		if (chandef->center_freq1 != control_freq + 30 &&
-		    chandef->center_freq1 != control_freq + 10 &&
-		    chandef->center_freq1 != control_freq - 10 &&
-		    chandef->center_freq1 != control_freq - 30)
-			return false;
 		if (!chandef->center_freq2)
 			return false;
 		/* adjacent is not allowed -- that's a 160 MHz channel */
@@ -265,28 +253,42 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		    chandef->center_freq2 - chandef->center_freq1 == 80)
 			return false;
 		break;
-	case NL80211_CHAN_WIDTH_80:
-		if (chandef->center_freq1 != control_freq + 30 &&
-		    chandef->center_freq1 != control_freq + 10 &&
-		    chandef->center_freq1 != control_freq - 10 &&
-		    chandef->center_freq1 != control_freq - 30)
-			return false;
+	default:
 		if (chandef->center_freq2)
 			return false;
 		break;
-	case NL80211_CHAN_WIDTH_160:
-		if (chandef->center_freq1 != control_freq + 70 &&
-		    chandef->center_freq1 != control_freq + 50 &&
-		    chandef->center_freq1 != control_freq + 30 &&
-		    chandef->center_freq1 != control_freq + 10 &&
-		    chandef->center_freq1 != control_freq - 10 &&
-		    chandef->center_freq1 != control_freq - 30 &&
-		    chandef->center_freq1 != control_freq - 50 &&
-		    chandef->center_freq1 != control_freq - 70)
-			return false;
-		if (chandef->center_freq2)
-			return false;
+	}
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_5:
+	case NL80211_CHAN_WIDTH_10:
+	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_1:
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
+	case NL80211_CHAN_WIDTH_8:
+	case NL80211_CHAN_WIDTH_16:
+		/* all checked above */
 		break;
+	case NL80211_CHAN_WIDTH_160:
+		if (chandef->center_freq1 == control_freq + 70 ||
+		    chandef->center_freq1 == control_freq + 50 ||
+		    chandef->center_freq1 == control_freq - 50 ||
+		    chandef->center_freq1 == control_freq - 70)
+			break;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_80:
+		if (chandef->center_freq1 == control_freq + 30 ||
+		    chandef->center_freq1 == control_freq - 30)
+			break;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_40:
+		if (chandef->center_freq1 == control_freq + 10 ||
+		    chandef->center_freq1 == control_freq - 10)
+			break;
+		fallthrough;
 	default:
 		return false;
 	}
-- 
2.33.1

