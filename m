Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2C66BE3D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 13:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjAPMzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 07:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjAPMyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 07:54:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABCD1EFE1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 04:52:26 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G9w43G010168;
        Mon, 16 Jan 2023 12:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6sHo+YIp00q0T0mjuxg06LE4sMIgI1vJIXBCijhKmO8=;
 b=bU+Yjt+tWFQ0kV7YuisMym2/nPzx6MiOEX8l+zBrdQuaEy/J1bOebttn/XNhaG234lhB
 K7z33NdIjeEOdpVlLn20p4lYBlu36Cgz6tpDXUvnoYA2adWnwiCDaYZHZCKNE69f6YTd
 xACD7v751PMZdYStesa5St1ny4CPleaIhtk24EOKGaJSJ5VsONql7ZSVJG7LEWn7KESD
 C41RsZdcsZZjF59BcD1NN3AyEgXRHU8uTK7hAGSyMSrl6Kcwh6ROpX6WiHo9pzNeJjGJ
 Hs5g43ZZaMlENb5XjVFBpislw3QUUvD0h1ajP0MEBCM5KIbBpYEAsDziuL4fT+wbIOX/ 4A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3kqsuhts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 12:52:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30GCqMua016656
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 12:52:22 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 16 Jan 2023 04:52:20 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH] wifi: cfg80211: Authentication offload to user space for MLO connection in STA mode
Date:   Mon, 16 Jan 2023 18:20:58 +0530
Message-ID: <20230116125058.1604843-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ZQuyfCZvYityEE2NKEfknSX9ttY1xE-
X-Proofpoint-ORIG-GUID: 7ZQuyfCZvYityEE2NKEfknSX9ttY1xE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_09,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160096
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently authentication request event interface doesn't have support to
indicate the user space whether it should enable MLO or not during the
authentication with the specified AP. But driver needs such capability
since the connection is MLO or not decided by the driver in case of SME
offload to the driver.

Add support for driver to indicate MLD address of the AP in
authentication offload request to inform user space to enable MLO during
authentication process. Driver shall look at NL80211_ATTR_MLO_SUPPORT
flag capability in NL80211_CMD_CONNECT to know whether the user space
supports enabling MLO during the authentication offload.

User space should enable MLO during the authentication only when it
receives the AP MLD address in authentication offload request. User
space shouldn't enable MLO if the authentication offload request doesn't
indicate the AP MLD address even if the AP is MLO capable.

When MLO is enabled, user space should use the MAC address of the
interface (on which driver sent request) as self MLD address. User space
and driver to use MLD addresses in RA, TA and BSSID fields of the frames
between them, and driver translates the MLD addresses to/from link
addresses based on the link chosen for the authentication.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 17 +++++++++++++++++
 net/wireless/nl80211.c       |  4 +++-
 net/wireless/trace.h         |  7 +++++--
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03d4f4deadae..80b5a5ef970b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3606,6 +3606,17 @@ struct cfg80211_pmk_conf {
  *	the real status code for failures. Used only for the authentication
  *	response command interface (user space to driver).
  * @pmkid: The identifier to refer a PMKSA.
+ * @mld_addr: MLD address of the peer. Used by the authentication request event
+ *	interface. Driver indicates this to enable MLO during the authentication
+ *	offload to user space. Driver shall look at %NL80211_ATTR_MLO_SUPPORT
+ *	flag capability in NL80211_CMD_CONNECT to know whether the user space
+ *	supports enabling MLO during the authentication offload.
+ *	User space should use the address of the interface (on which the
+ *	authentication request event reported) as self MLD address. User space
+ *	and driver should use MLD addresses in RA, TA and BSSID fields of
+ *	authentication frames sent or received via cfg80211. The driver
+ *	translates the MLD addresses to/from link addresses based on the link
+ *	chosen for the authentication.
  */
 struct cfg80211_external_auth_params {
 	enum nl80211_external_auth_action action;
@@ -3614,6 +3625,7 @@ struct cfg80211_external_auth_params {
 	unsigned int key_mgmt_suite;
 	u16 status;
 	const u8 *pmkid;
+	u8 mld_addr[ETH_ALEN] __aligned(2);
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..2ac6b3c500fb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1166,6 +1166,23 @@
  *	%NL80211_ATTR_STATUS_CODE attribute in %NL80211_CMD_EXTERNAL_AUTH
  *	command interface.
  *
+ *	Host driver sends MLD address of the AP with %NL80211_ATTR_MLD_ADDR in
+ *	%NL80211_CMD_EXTERNAL_AUTH event to indicate user space to enable MLO
+ *	during the authentication offload in STA mode while connecting to MLD
+ *	APs. Host driver should check %NL80211_ATTR_MLO_SUPPORT flag capability
+ *	in %NL80211_CMD_CONNECT to know whether the user space supports enabling
+ *	MLO during the authentication offload or not.
+ *	User space should enable MLO during the authentication only when it
+ *	receives the AP MLD address in authentication offload request. User
+ *	space shouldn't enable MLO when the authentication offload request
+ *	doesn't indicate the AP MLD address even if the AP is MLO capable.
+ *	User space should use %NL80211_ATTR_MLD_ADDR as peer's MLD address and
+ *	interface address identified by %NL80211_ATTR_IFINDEX as self MLD
+ *	address. User space and host driver to use MLD addresses in RA, TA and
+ *	BSSID fields of the frames between them, and host driver translates the
+ *	MLD addresses to/from link addresses based on the link chosen for the
+ *	authentication.
+ *
  *	Host driver reports this status on an authentication failure to the
  *	user space through the connect result as the user space would have
  *	initiated the connection through the connect request.
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33a82ecab9d5..0790325bf5c1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19718,7 +19718,9 @@ int cfg80211_external_auth_request(struct net_device *dev,
 			params->action) ||
 	    nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, params->bssid) ||
 	    nla_put(msg, NL80211_ATTR_SSID, params->ssid.ssid_len,
-		    params->ssid.ssid))
+		    params->ssid.ssid) ||
+	    (!is_zero_ether_addr(params->mld_addr) &&
+	     nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN, params->mld_addr)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47..bb8dc1b9b652 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2528,6 +2528,7 @@ TRACE_EVENT(rdev_external_auth,
 			     MAC_ENTRY(bssid)
 			     __array(u8, ssid, IEEE80211_MAX_SSID_LEN + 1)
 			     __field(u16, status)
+			     MAC_ENTRY(mld_addr)
 	    ),
 	    TP_fast_assign(WIPHY_ASSIGN;
 			   NETDEV_ASSIGN;
@@ -2536,10 +2537,12 @@ TRACE_EVENT(rdev_external_auth,
 			   memcpy(__entry->ssid, params->ssid.ssid,
 				  params->ssid.ssid_len);
 			   __entry->status = params->status;
+			   MAC_ASSIGN(mld_addr, params->mld_addr);
 	    ),
 	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT
-		      ", ssid: %s, status: %u", WIPHY_PR_ARG, NETDEV_PR_ARG,
-		      __entry->bssid, __entry->ssid, __entry->status)
+		      ", ssid: %s, status: %u, mld_addr: " MAC_PR_FMT,
+		      WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
+		      __entry->ssid, __entry->status, __entry->mld_addr)
 );
 
 TRACE_EVENT(rdev_start_radar_detection,
-- 
2.25.1

