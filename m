Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D091D1F8E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbgEMTph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 15:45:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33374 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390696AbgEMTph (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 15:45:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589399137; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=JD3H+2UIrtT/l1bJEqxT6tXQ3eAeBzabY+eu8PkbSb4=; b=XTPbmbzIDlbm79XA5PUNFyAnePyPSdg8rcG1z4T1OqUp5Uoe4YBMSokIYOybTF1UfTo3xI/s
 nne3wkXCoZAMnbALxhxQdS4dWVSM1aPgvfp7vm/o/io37GAZyLhDra+E37nqA6fu3erPu3Wl
 BN58k4ghqYpWFyiUNCnvYiJ8RXw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc4e4e.7f501de4b110-smtp-out-n03;
 Wed, 13 May 2020 19:45:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F33B8C433BA; Wed, 13 May 2020 19:45:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4A8DC433F2;
        Wed, 13 May 2020 19:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4A8DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Vamsi Krishna <vamsin@codeaurora.org>
Subject: [PATCH v3 01/11] cfg80211: use only HE capability to set prohibited flags in 6 GHz
Date:   Wed, 13 May 2020 12:44:55 -0700
Message-Id: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The prohibited flags to determine whether configured bandwidth
is supported by driver are validated only against HT and VHT capability.
In 6 GHz band, Only HE capability should be validated to find out
given chandef is usable.

Co-developed-by: Vamsi Krishna <vamsin@codeaurora.org>
Signed-off-by: Vamsi Krishna <vamsin@codeaurora.org>
Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/wireless/chan.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index fcac5c6366e1..582b487576e1 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -19,6 +19,11 @@ static bool cfg80211_valid_60g_freq(u32 freq)
 	return freq >= 58320 && freq <= 70200;
 }
 
+static bool cfg80211_is_6ghz_freq(u32 freq)
+{
+	return (freq > 5940 && freq < 7105);
+}
+
 void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 			     struct ieee80211_channel *chan,
 			     enum nl80211_channel_type chan_type)
@@ -882,6 +887,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
 	struct ieee80211_edmg *edmg_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
 	u32 width, control_freq, cap;
 
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
@@ -890,6 +896,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 	ht_cap = &wiphy->bands[chandef->chan->band]->ht_cap;
 	vht_cap = &wiphy->bands[chandef->chan->band]->vht_cap;
 	edmg_cap = &wiphy->bands[chandef->chan->band]->edmg_cap;
+	he_cap = ieee80211_get_he_sta_cap(wiphy->bands[chandef->chan->band]);
 
 	if (edmg_cap->channels &&
 	    !cfg80211_edmg_usable(wiphy,
@@ -919,6 +926,16 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		width = 40;
+		if (cfg80211_is_6ghz_freq(chandef->center_freq1)) {
+			if (!he_cap)
+				return false;
+			if (!he_cap->has_he_6ghz)
+				return false;
+			if (!(he_cap->he_cap_elem.phy_cap_info[0] &
+			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
+				return false;
+			break;
+		}
 		if (!ht_cap->ht_supported)
 			return false;
 		if (!(ht_cap->cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) ||
@@ -933,24 +950,53 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
 		cap = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-		if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
+		if (!cfg80211_is_6ghz_freq(chandef->center_freq1) &&
+		    cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
 			return false;
+		if (cfg80211_is_6ghz_freq(chandef->center_freq1)) {
+			if (!he_cap)
+				return false;
+			if (!he_cap->has_he_6ghz)
+				return false;
+			if (!(he_cap->he_cap_elem.phy_cap_info[0] &
+			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G))
+				return false;
+		}
 		/* fall through */
 	case NL80211_CHAN_WIDTH_80:
-		if (!vht_cap->vht_supported)
+		if (cfg80211_is_6ghz_freq(chandef->center_freq1)) {
+			if (!he_cap)
+				return false;
+			if (!he_cap->has_he_6ghz)
+				return false;
+			if (!(he_cap->he_cap_elem.phy_cap_info[0] &
+			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
+				return false;
+		} else if (!vht_cap->vht_supported) {
 			return false;
+		}
 		prohibited_flags |= IEEE80211_CHAN_NO_80MHZ;
 		width = 80;
 		break;
 	case NL80211_CHAN_WIDTH_160:
+		prohibited_flags |= IEEE80211_CHAN_NO_160MHZ;
+		width = 160;
+		if (cfg80211_is_6ghz_freq(chandef->center_freq1)) {
+			if (!he_cap)
+				return false;
+			if (!he_cap->has_he_6ghz)
+				return false;
+			if (!(he_cap->he_cap_elem.phy_cap_info[0] &
+			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G))
+				return false;
+			break;
+		}
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
2.7.4
