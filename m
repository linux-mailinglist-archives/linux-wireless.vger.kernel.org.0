Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B194A290CA2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393577AbgJPUQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Oct 2020 16:16:27 -0400
Received: from z5.mailgun.us ([104.130.96.5]:36444 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393352AbgJPUQ1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Oct 2020 16:16:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602879386; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hIWGLXVK7+qIfe3AqpuV42/opXGXnW752j/jkPACMmU=; b=UkabmQd1D6xfpxy/JRqHNPzt2K8cGGcvNlLTUDAwb4MVhZUIUiNieDgzPLsvLvbr9R3un+iR
 OWm4G/yTD+37iow6fxBU/ESJPKxW1S/Z/GeBbZyXGgo/KXWKSuoFcq1hKnNeF5s0ImXvUz4Q
 Ouo1RbNC/Fh5m1zmmx+SklWNnos=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f89ff6ad63768e57bf34233 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 20:15:38
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF2F6C433FE; Fri, 16 Oct 2020 20:15:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19B52C433C9;
        Fri, 16 Oct 2020 20:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19B52C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 2/2] cfg80211: add support to configure HE MCS for beacon rate
Date:   Fri, 16 Oct 2020 13:15:27 -0700
Message-Id: <1602879327-29488-2-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602879327-29488-1-git-send-email-rmanohar@codeaurora.org>
References: <1602879327-29488-1-git-send-email-rmanohar@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows an option to configure a single HE MCS beacon tx rate.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/uapi/linux/nl80211.h |  9 +++++++--
 net/wireless/nl80211.c       | 25 +++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 47700a2b9af9..0c9f0b8a1e4e 100644
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
@@ -5896,6 +5897,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP: Driver/device supports
  *	unsolicited broadcast probe response transmission
  *
+ * @NL80211_EXT_FEATURE_BEACON_RATE_HE: Driver supports beacon rate
+ *	configuration (AP/mesh) with HE rates.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5956,6 +5960,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD_AP,
 	NL80211_EXT_FEATURE_FILS_DISCOVERY,
 	NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP,
+	NL80211_EXT_FEATURE_BEACON_RATE_HE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b61699a04dc4..2e24d6eef791 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4680,6 +4680,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					mask->control[band].ht_mcs))
 				return -EINVAL;
 		}
+
 		if (tb[NL80211_TXRATE_VHT]) {
 			if (!vht_set_mcs_mask(
 					sband,
@@ -4687,6 +4688,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					mask->control[band].vht_mcs))
 				return -EINVAL;
 		}
+
 		if (tb[NL80211_TXRATE_GI]) {
 			mask->control[band].gi =
 				nla_get_u8(tb[NL80211_TXRATE_GI]);
@@ -4698,6 +4700,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 				     nla_data(tb[NL80211_TXRATE_HE]),
 				     mask->control[band].he_mcs))
 			return -EINVAL;
+
 		if (tb[NL80211_TXRATE_HE_GI])
 			mask->control[band].he_gi =
 				nla_get_u8(tb[NL80211_TXRATE_HE_GI]);
@@ -4739,7 +4742,7 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 				   enum nl80211_band band,
 				   struct cfg80211_bitrate_mask *beacon_rate)
 {
-	u32 count_ht, count_vht, i;
+	u32 count_ht, count_vht, count_he, i;
 	u32 rate = beacon_rate->control[band].legacy;
 
 	/* Allow only one rate */
@@ -4772,7 +4775,21 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
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
@@ -4787,6 +4804,10 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
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

