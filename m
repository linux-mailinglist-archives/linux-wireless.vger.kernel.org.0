Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A595BCB88
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiISMMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 08:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiISMMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 08:12:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80355A184
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 05:12:12 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBcPhC016047;
        Mon, 19 Sep 2022 12:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=0lTfyMeBVfyhXIeHOvmrrNzE2dj9Apo0s7eY9ZNFlIA=;
 b=SVRn7/H4kXSAogC0DeP+1rF4dK3JV/7AVgF7+MZeokOZ7JqFlI1P0gHpxar7nI0eiqdk
 I2v2LGWUCo6dGdVIihIDElPgkF8TxoT5T+UX6SeIkCPZeQ2en8lq1okL7fZEJWIYnmSE
 eexRdR6Lsi+xedPiIDivdiciV9RVUNAmc0uF5iNigHrD9QvUN13MY6avLJ/+7a3iwh+r
 GRdVXc+h7pQbv2sXNJDBfIVnb30TOhs2irBMElxY86pVP4m2fHfI8V/qZk3T9sx5Mcp3
 OTIqhwU2C37HvPfYnc0EYOy+7pxbaRnpoghYtZFhtb1/7u7N0imXslNcStW8raI2HBDV QQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6bum013-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JCC8xQ002016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:08 GMT
Received: from u20-san1p10030.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 05:12:07 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/4] wifi: nl80211: Add support for randomizing TA of auth and deauth frames
Date:   Mon, 19 Sep 2022 05:11:52 -0700
Message-ID: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1S9KBI_p8ncJU50gkxhqvkQQPcvdlW9H
X-Proofpoint-GUID: 1S9KBI_p8ncJU50gkxhqvkQQPcvdlW9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to use a random local address for authentication and
deauthentication frames if the driver supports.

The driver needs to configure receive behavior to accept frames with
random transmit address specified in TX path authentication frames
during the time of the frame exchange is pending and such frames need to
be acknowledged similarly to frames sent to the local permanent address
when this random address functionality is used.

This is required for below cases:
- Enabling use of randomized transmit address for PASN authentication
  frames improve privacy of WLAN clients.
- If NL80211_CMD_EXTERNAL_AUTH triggered for MLO connection userspace
  needs to use link address as transmit address when sending SAE
  authentication frames. Drivers may use transmit address different from
  interface address but since NL80211_CMD_EXTERNAL_AUTH may get
  triggered before association kernel won't have the device's link
  addresses by that time. Drivers can use this feature to allow external
  authentication frames with link address before association.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/uapi/linux/nl80211.h |  4 +++
 net/wireless/mlme.c          | 55 +++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c32e7616a366..cd940baae181 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6291,6 +6291,9 @@ enum nl80211_feature_flags {
  *	might apply, e.g. no scans in progress, no offchannel operations
  *	in progress, and no active connections.
  *
+ * @NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA: Device supports randomized TA
+ *	for authentication and deauthentication frames in @NL80211_CMD_FRAME.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6359,6 +6362,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
 	NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE,
+	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 581df7f4c524..43d1b815aaba 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -669,6 +669,39 @@ static bool cfg80211_allowed_address(struct wireless_dev *wdev, const u8 *addr)
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
@@ -767,25 +800,9 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
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

