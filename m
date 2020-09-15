Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11F269CEE
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 06:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgIOEU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 00:20:28 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38136 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgIOEU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 00:20:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600143627; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=t0svxPuvyKJb0xQZATGZ8rTUXo2yMQ05hzjugVu9JLI=; b=v1kSDZiiDoRaJpOZuJzBYG0ZgRN7sV04sLBPsP4gBag0j7yanISfWNXmCvs6tkWaA/yTQ6c1
 xEyq1F1Emp77xr+Gwl2jVcGbA5SPaRZucHsDXmbc61wUEGBVgpz1dO53aIWUSMAHwR5ZmAVs
 xfOlr+xO82GWErTxgTCdcJKJMTI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f6040efcc683673f9a7e0e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 04:19:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4030C433F0; Tue, 15 Sep 2020 04:19:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85284C433CA;
        Tue, 15 Sep 2020 04:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85284C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH] cfg80211: add support to configure HE MCS for beacon rate
Date:   Mon, 14 Sep 2020 21:19:47 -0700
Message-Id: <1600143587-25327-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows an option to configure a single HE MCS beacon tx rate.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/uapi/linux/nl80211.h |  9 +++++++--
 net/wireless/nl80211.c       | 22 ++++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0584e0d349f0..4041b92791f1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1750,8 +1750,9 @@ enum nl80211_commands {
  *	specify just a single bitrate, which is to be used for the beacon.
  *	The driver must also specify support for this with the extended
  *	features NL80211_EXT_FEATURE_BEACON_RATE_LEGACY,
- *	NL80211_EXT_FEATURE_BEACON_RATE_HT and
- *	NL80211_EXT_FEATURE_BEACON_RATE_VHT.
+ *	NL80211_EXT_FEATURE_BEACON_RATE_HT,
+ *	NL80211_EXT_FEATURE_BEACON_RATE_VHT and
+ *	NL80211_EXT_FEATURE_BEACON_RATE_HE.
  *
  * @NL80211_ATTR_FRAME_MATCH: A binary attribute which typically must contain
  *	at least one byte, currently used with @NL80211_CMD_REGISTER_FRAME.
@@ -5852,6 +5853,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD_AP: Device wants to do SAE authentication
  *	in AP mode (SAE password is passed as part of the start AP command).
  *
+ * @NL80211_EXT_FEATURE_BEACON_RATE_HE: Driver supports beacon rate
+ *	configuration (AP/mesh) with HE rates.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5910,6 +5914,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_OPERATING_CHANNEL_VALIDATION,
 	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD_AP,
+	NL80211_EXT_FEATURE_BEACON_RATE_HE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 201d029687cc..d54fb579a9b3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4663,7 +4663,7 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 				   enum nl80211_band band,
 				   struct cfg80211_bitrate_mask *beacon_rate)
 {
-	u32 count_ht, count_vht, i;
+	u32 count_ht, count_vht, count_he, i;
 	u32 rate = beacon_rate->control[band].legacy;
 
 	/* Allow only one rate */
@@ -4696,7 +4696,21 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 	}
 
-	if ((count_ht && count_vht) || (!rate && !count_ht && !count_vht))
+	count_he = 0;
+	for (i = 0; i < NL80211_HE_NSS_MAX; i++) {
+		if (hweight16(beacon_rate->control[band].he_mcs[i]) > 1) {
+			return -EINVAL;
+		} else if (beacon_rate->control[band].he_mcs[i]) {
+			count_he++;
+			if (count_he > 1)
+				return -EINVAL;
+		}
+		if (count_he && rate)
+			return -EINVAL;
+	}
+
+	if ((count_ht && count_vht && count_he) ||
+	    (!rate && !count_ht && !count_vht && !count_he))
 		return -EINVAL;
 
 	if (rate &&
@@ -4711,6 +4725,10 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	    !wiphy_ext_feature_isset(&rdev->wiphy,
 				     NL80211_EXT_FEATURE_BEACON_RATE_VHT))
 		return -EINVAL;
+	if (count_he &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_BEACON_RATE_HE))
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.7.4

