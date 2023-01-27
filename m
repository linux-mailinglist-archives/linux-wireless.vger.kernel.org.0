Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5367EDD6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 19:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjA0Ss5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 13:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjA0Sst (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 13:48:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED06086EBC
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 10:48:17 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30REs3CM006507;
        Fri, 27 Jan 2023 18:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=rOelrGtj1bwuwdcd2F3b40zFFYD91MRqsAvsvUzrXpw=;
 b=IaWEo9wPtHv71l4pi8rr2bRlP+hlhiFsiSbRvDDbEfpyu7PlgKFoZ99A56oNIZzsrGvl
 2DeYqQf2IrJE+fGDPNP0wFNyimE7RXXob5gJv+IlF7jOWyR1a0lgCzaA/t/PRexgkHpb
 QqXJ1PadPHP3eaZLqwcb583jYg2rq7IXJkHy38JbkyqmnGnjmib4mXiMDKfChGxP9pR5
 MNtod4AZhoQb8hcIhQ7q2s0raDeYAmUIuowX/4cmWiQn3JUJ0c5rAY3MeQmmfBxIl8hf
 +wqmcQ7qUgXdv9iPtM81zZr67X7HpWo758ZqJhBWUSTN69+PF6ltZSwgUzoUW60tL5Mo JA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc956s51q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:47:49 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RIlmOT029513
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:47:48 GMT
Received: from hu-vganneva-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 10:47:47 -0800
From:   Vinay Gannevaram <quic_vganneva@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] nl80211: Allow authentication frames and set keys on NAN interface
Date:   Sat, 28 Jan 2023 00:17:36 +0530
Message-ID: <1674845256-4300-1-git-send-email-quic_vganneva@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Th74YNptj8cNYts4ckSaoSuWXmf1l0Rv
X-Proofpoint-ORIG-GUID: Th74YNptj8cNYts4ckSaoSuWXmf1l0Rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_12,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270173
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wi-Fi Aware R4 specification defines NAN Pairing which uses PASN handshake
to authenticate the peer and generate keys. Hence allow to register and transmit
the PASN authentication frames on NAN interface and set the keys to driver or
underlying modules on NAN interface.

The driver needs to configure the feature flag NL80211_EXT_FEATURE_SECURE_NAN,
which also helps userspace modules to know if the driver supports secure NAN.

Signed-off-by: Vinay Gannevaram <quic_vganneva@quicinc.com>
---
v2:
 - Add feature flag to indicate SECURE_NAN support from driver
---
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8ecb0fb..07352a9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6296,6 +6296,10 @@ enum nl80211_feature_flags {
  *	might apply, e.g. no scans in progress, no offchannel operations
  *	in progress, and no active connections.
  *
+ * @NL80211_EXT_FEATURE_SECURE_NAN: Device supports NAN Pairing which enables
+ *	authentication, data encryption and message integrity.
+ *
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6364,6 +6368,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
 	NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE,
+	NL80211_EXT_FEATURE_SECURE_NAN,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 64cf611..cf96d63 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1548,10 +1548,13 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 		if (wdev->connected)
 			return 0;
 		return -ENOLINK;
+	case NL80211_IFTYPE_NAN:
+		if (wiphy_ext_feature_isset(wdev->wiphy,
+					    NL80211_EXT_FEATURE_SECURE_NAN))
+			return 0;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
@@ -12253,6 +12256,9 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
 	case NL80211_IFTYPE_NAN:
+		if (wiphy_ext_feature_isset(wdev->wiphy,
+					    NL80211_EXT_FEATURE_SECURE_NAN))
+			break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -12310,6 +12316,9 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_P2P_GO:
 		break;
 	case NL80211_IFTYPE_NAN:
+		if (wiphy_ext_feature_isset(wdev->wiphy,
+					    NL80211_EXT_FEATURE_SECURE_NAN))
+			break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -12447,6 +12456,9 @@ static int nl80211_tx_mgmt_cancel_wait(struct sk_buff *skb, struct genl_info *in
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
 	case NL80211_IFTYPE_NAN:
+		if (wiphy_ext_feature_isset(wdev->wiphy,
+					    NL80211_EXT_FEATURE_SECURE_NAN))
+			break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.7.4

