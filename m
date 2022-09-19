Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351605BCB86
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiISMMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISMMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 08:12:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D4B1EE
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 05:12:12 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JAo282019353;
        Mon, 19 Sep 2022 12:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=uSH9scg0N/s6aP+KS+BRJOom8+y8vJ1wGzkciAP6jBY=;
 b=a0gEwcIBEk/QqvtaeHfISfF2At3HHXVOCGVzFmDmWdqjfrVrX+8XlGhSntGtWpsSPJHc
 afn2Wm90AVkoTjj9K2dMHTk41cl60gYeF7ASnmn6xPOWLWpjwgAebqEG8NVAlsa4PSOq
 67GlYTvX4juaBnLZQsXQ7F3fDdSMavz22ZRlPeeoTLU9ROtfk8Ei1/yf+x8gpjKCWGn8
 PashKyYEvzAwAOfrNZJJiRJ4g6L0NA0P2B6N/h4TOVXL2gGnjOuc6/rELYBv3vP4DdgQ
 xZXTOAlA4BFMPbvoZE8WwwPeGeTfYDJsyyBOX+YYt01ws5yjLJhRhQg5lk1wadWJP2Oe QQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6b1vk33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JCC9p4032572
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:09 GMT
Received: from u20-san1p10030.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 05:12:08 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/4] wifi: cfg80211: Add support to trigger external authentication for MLO connection
Date:   Mon, 19 Sep 2022 05:11:55 -0700
Message-ID: <20220919121155.3069765-4-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
References: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yENniJbf_JNe459IJDAuVzWDzKpHlm1K
X-Proofpoint-ORIG-GUID: yENniJbf_JNe459IJDAuVzWDzKpHlm1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, there is no support for drivers to indicate external
authentication request is for MLO or non-MLO connection. This
information needed for userspace to consider MLO specific changes
during authentication like adding Multi-Link IE with MLD address in
authentication frames. Also, the transmit address of the authentication
frames can be different from the interface address for MLO connection.

Add transmit address parameter in external authentication request to
indicate userspace to enable MLO and use the transmit address as TA in
the authentication frames. If transmit address not indicated by driver
userspace must do legacy authentication.

Also, If the driver is using transmit address different from interface
address it should advertise
NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA flag. This is needed since
the external authentication request may get triggered before association
and cfg80211 won't have link address information by that time.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h |  9 +++++++++
 net/wireless/core.h    |  1 +
 net/wireless/mlme.c    |  2 +-
 net/wireless/nl80211.c | 10 ++++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e09ff87146c1..4d490d507333 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3604,6 +3604,14 @@ struct cfg80211_pmk_conf {
  *	the real status code for failures. Used only for the authentication
  *	response command interface (user space to driver).
  * @pmkid: The identifier to refer a PMKSA.
+ * @tx_addr: Driver shall fill this parameter to indicate userpsace to enable
+ *	MLO and use tx_addr as TA of the authentication frames. Also, Drivers
+ *	which may use transmit address different from interface address must
+ *	indicate %NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA since the
+ *	external authentication request may get triggered before association and
+ *	cfg80211 won't have link address information by that time. If transmit
+ *	address not indicated by driver userspace must do legacy authentication.
+ *	This parameter valid only for the authentication request event.
  */
 struct cfg80211_external_auth_params {
 	enum nl80211_external_auth_action action;
@@ -3612,6 +3620,7 @@ struct cfg80211_external_auth_params {
 	unsigned int key_mgmt_suite;
 	u16 status;
 	const u8 *pmkid;
+	u8 tx_addr[ETH_ALEN] __aligned(2);
 };
 
 /**
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 775e16cb99ed..288cb91c24f3 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -566,5 +566,6 @@ void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id);
 void cfg80211_remove_links(struct wireless_dev *wdev);
 int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
 				 struct wireless_dev *wdev);
+bool cfg80211_allowed_address(struct wireless_dev *wdev, const u8 *addr);
 
 #endif /* __NET_WIRELESS_CORE_H */
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 43d1b815aaba..17ce998cdc42 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -657,7 +657,7 @@ void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev)
 	cfg80211_mgmt_registrations_update(wdev);
 }
 
-static bool cfg80211_allowed_address(struct wireless_dev *wdev, const u8 *addr)
+bool cfg80211_allowed_address(struct wireless_dev *wdev, const u8 *addr)
 {
 	int i;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8ff8b1c040f0..fdeda730ebdb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19703,6 +19703,16 @@ int cfg80211_external_auth_request(struct net_device *dev,
 		    params->ssid.ssid))
 		goto nla_put_failure;
 
+	if (!is_zero_ether_addr(params->tx_addr)) {
+		if (!cfg80211_allowed_address(wdev, params->tx_addr) &&
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+			    NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA))
+			return -EINVAL;
+
+		if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, params->tx_addr))
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(msg, hdr);
 	genlmsg_unicast(wiphy_net(&rdev->wiphy), msg,
 			wdev->conn_owner_nlportid);
-- 
2.25.1

