Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E43756C0BE
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiGHQwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiGHQw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 12:52:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328974361
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657299146; x=1688835146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5oufjD70T0Nm3AKvWZAVy8tsfi/hpQvZ5iFwqXRUD74=;
  b=OUBCfn5MJofM+RWZiF1l1k13fSJoT/IeIejg2O/ffnmr3ep/eJaZcLFv
   irtbAeBqag4XsHV9SB7K7jMF+S1G3vCBK9h9ar/xd8r7uSK+3XKTaQnTW
   ZzSdZvMtOcbQIewjaJ8kJWwDupxlfdpMgaSmrkJJ74NVKS9ds3X/Nbzsf
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jul 2022 09:52:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:52:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 09:52:25 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 09:52:24 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] nl80211: Allow transmitting auth frames with random TA
Date:   Fri, 8 Jul 2022 22:22:11 +0530
Message-ID: <20220708165212.2069149-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow authentication frames with a random local address as transmit
address if the driver supports.

This is required for below cases:
- Enabling use of randomized transmit address for PASN authentication
  frames improve privacy of WLAN clients.
- To allow user space to use link address indicated by driver as
  transmit address for authentication frames triggered by
  NL80211_CMD_EXTERNAL_AUTH for MLO connection.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/uapi/linux/nl80211.h |  4 ++++
 net/wireless/mlme.c          | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 279f9715919e..9e665f7b3e23 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6225,6 +6225,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
  *	detection.
  *
+ * @NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA: Device supports randomized TA
+ *	for authentication frames in @NL80211_CMD_FRAME.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6292,6 +6295,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
+	NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 2bb4da97b66a..176513a75ddf 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -736,6 +736,16 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 	}
 
 	if (!ether_addr_equal(mgmt->sa, wdev_address(wdev))) {
+		/* Allow random TA to be used with authentication frames if the
+		 * driver has indicated support for this. Otherwise, only allow
+		 * the local address to be used.
+		 */
+		if (ieee80211_is_auth(mgmt->frame_control) &&
+		    wiphy_ext_feature_isset(
+			   &rdev->wiphy,
+			   NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA))
+			goto out_tx;
+
 		/* Allow random TA to be used with Public Action frames if the
 		 * driver has indicated support for this. Otherwise, only allow
 		 * the local address to be used.
@@ -755,6 +765,7 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 	}
 
+out_tx:
 	/* Transmit the Action frame as requested by user space */
 	return rdev_mgmt_tx(rdev, wdev, params, cookie);
 }
-- 
2.25.1

