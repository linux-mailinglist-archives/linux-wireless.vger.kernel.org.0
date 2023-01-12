Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92783666857
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 02:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjALBYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 20:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjALBYt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 20:24:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7D40856
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 17:24:49 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BNvAaj029436;
        Thu, 12 Jan 2023 01:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4d0NK3mY13n3Tp6eoJiARZmZ7pTGxfPaaYeId66oSY0=;
 b=O4XBzZxrqB/B2tGjLxpIYFj3KCxMdmglUTzJmDopdIbl1coIkC/Bu0oBe4dps1U3sbRZ
 /b8vsGDupf6gD19OBl3k2/lFaOp4EYn9xvvxdLixBWBSkmClu2Mm2apjE/hK6MYkF3O5
 ZQZOqe0MAhkN7zlcUON7JP4L+DdQto/G91vt/xn9KcJjQ+WLI2hjtvQ1CtZtDx1QQPZy
 WQ0C0k+1OJ8o9hJaEAINwWR58lwM0TS1Un2qNoCoCpLoVyB+ZRRTPcebMyxHTIwUgJzG
 HJ1VFtZXxD5A9tuCijbwv8cjY0rsn3+PvBb4dqusUCiE1DGRW/UQnkow9yA9Ip3aN3/T TQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1km2jk3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C1OiCH001196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:44 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 17:24:42 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v3 1/3] wifi: nl80211: Add support for randomizing TA of auth and deauth frames
Date:   Thu, 12 Jan 2023 06:54:13 +0530
Message-ID: <20230112012415.167556-2-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
References: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1n_hKUqkcV1J_iUXS6q03BNzpi13678f
X-Proofpoint-GUID: 1n_hKUqkcV1J_iUXS6q03BNzpi13678f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
v2:
 - Move random address allowed checks to separate function.
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

