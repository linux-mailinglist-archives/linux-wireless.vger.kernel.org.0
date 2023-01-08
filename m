Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9F6613DA
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 08:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjAHHQ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 02:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAHHQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 02:16:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212C1A38A
        for <linux-wireless@vger.kernel.org>; Sat,  7 Jan 2023 23:16:22 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3087FUBM009038;
        Sun, 8 Jan 2023 07:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=1czhL9+v4bTN0hnW/RTBNgMC/+Fh65TA54QEhSENbHE=;
 b=QEvTw7p647aFBKi+GY1j1FlLTJ+oKBQkIn+bbGsIbRS3bDQ3WbYoEVxAuh0DVnPimWg/
 OI7xv1PpdS6U+nVVNjSowhjsXJ2OnFlzHXhcFUmcyb1g9gSkWjjr/dLxzW3lRMdJx3PD
 tBmoQUzDM/y27dpNIDuAmeHKcYZc8zjoMfE6oZojgchH1Wan7G4sBq2A90G4EvexePV6
 U64VDPlSiiraV4pO0Prgw1XPnFPZ4WOmb7aOmldUyJIiZbbczswWEEY/f8EktRlsqbx9
 S6UoRPigPzDaUaMTlRgxjGTUGaYZcudUBEOx0OMszWlUG4Q46BeWRcEnfq2APMlAMSrP Yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my14fs7c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Jan 2023 07:16:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3087GIqD026183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Jan 2023 07:16:18 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sat, 7 Jan 2023 23:16:16 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 1/3] wifi: nl80211: Add support for randomizing TA of auth and deauth frames
Date:   Sun, 8 Jan 2023 12:45:50 +0530
Message-ID: <20230108071552.2646591-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LV5OuJyeQAa2g95v-woRDm_t7mJF9DOs
X-Proofpoint-ORIG-GUID: LV5OuJyeQAa2g95v-woRDm_t7mJF9DOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301080049
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to use a random local address in authentication and
deauthentication frames sent to unassociated peer when the driver
supports.

The driver needs to configure receive behavior to accept frames with
random transmit address specified in TX path authentication frames
during the time of the frame exchange is pending and such frames need to
be acknowledged similarly to frames sent to the local permanent address
when this random address functionality is used.

This capability allows use of randomized transmit address for PASN
authentication frames to improve privacy of WLAN clients.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/uapi/linux/nl80211.h |  5 ++++
 net/wireless/mlme.c          | 55 +++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..6bfcc3d2ec06 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6294,6 +6294,10 @@ enum nl80211_feature_flags {
  *	might apply, e.g. no scans in progress, no offchannel operations
  *	in progress, and no active connections.
  *
+ * @NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA: Device supports randomized TA
+ *	in authentication and deauthentication frames sent to unassociated peer
+ *	using @NL80211_CMD_FRAME.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6362,6 +6366,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
 	NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE,
+	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 58e1fb18f85a..cfacda5bd80b 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -673,6 +673,39 @@ static bool cfg80211_allowed_address(struct wireless_dev *wdev, const u8 *addr)
 	return ether_addr_equal(addr, wdev_address(wdev));
 }
 
+static bool cfg80211_allowed_random_address(struct wireless_dev *wdev,
+					    const struct ieee80211_mgmt *mgmt)
+{
+	if (ieee80211_is_auth(mgmt->frame_control) ||
+	    ieee80211_is_deauth(mgmt->frame_control)) {
+		/* Allow random TA to be used with authentication and
+		 * deauthentication frames if the driver has indicated support.
+		 */
+		if (wiphy_ext_feature_isset(
+			    wdev->wiphy,
+			    NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA))
+			return true;
+	} else if (ieee80211_is_action(mgmt->frame_control) &&
+		   mgmt->u.action.category == WLAN_CATEGORY_PUBLIC) {
+		/* Allow random TA to be used with Public Action frames if the
+		 * driver has indicated support.
+		 */
+		if (!wdev->connected &&
+		    wiphy_ext_feature_isset(
+			    wdev->wiphy,
+			    NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA))
+			return true;
+
+		if (wdev->connected &&
+		    wiphy_ext_feature_isset(
+			    wdev->wiphy,
+			    NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA_CONNECTED))
+			return true;
+	}
+
+	return false;
+}
+
 int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			  struct wireless_dev *wdev,
 			  struct cfg80211_mgmt_tx_params *params, u64 *cookie)
@@ -771,25 +804,9 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			return err;
 	}
 
-	if (!cfg80211_allowed_address(wdev, mgmt->sa)) {
-		/* Allow random TA to be used with Public Action frames if the
-		 * driver has indicated support for this. Otherwise, only allow
-		 * the local address to be used.
-		 */
-		if (!ieee80211_is_action(mgmt->frame_control) ||
-		    mgmt->u.action.category != WLAN_CATEGORY_PUBLIC)
-			return -EINVAL;
-		if (!wdev->connected &&
-		    !wiphy_ext_feature_isset(
-			    &rdev->wiphy,
-			    NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA))
-			return -EINVAL;
-		if (wdev->connected &&
-		    !wiphy_ext_feature_isset(
-			    &rdev->wiphy,
-			    NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA_CONNECTED))
-			return -EINVAL;
-	}
+	if (!cfg80211_allowed_address(wdev, mgmt->sa) &&
+	    !cfg80211_allowed_random_address(wdev, mgmt))
+		return -EINVAL;
 
 	/* Transmit the management frame as requested by user space */
 	return rdev_mgmt_tx(rdev, wdev, params, cookie);
-- 
2.25.1

