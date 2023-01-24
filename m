Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1954E679ACF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jan 2023 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjAXN6s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Jan 2023 08:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjAXNyt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Jan 2023 08:54:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE594232
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 05:53:04 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBkOKK028186;
        Tue, 24 Jan 2023 13:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ijdytpBz+8rzfHj/35jFE5J/5Mn5FRL3OFGo0aGXhcs=;
 b=iKDRbgXjp+k+JFroxRk7INczJG0znWpGqtX+Rgakv619gM9Sa4ZJQfLcCsqRIF4eAVT0
 Khkt03B2pZISXMBKlPtVFfqELC92qZL0XZ5/ttYBznGWYpM5Sl5pljqhAIGBcD2a4oTB
 qNNwwGgVC+aAAX4scu2m5WMU9YWdRGc3Q6XO4XUKoOjrkZ5MDxWntrOqkIfoiSbh0mJ4
 VsgM3n8jAQXYC7GXPzT0uXtu/c5OXc57IKN5OMB8XMesikPbbgQP4WHIpGxe48jZx5Dv
 gQ77fTGBSUFA2bWAB2i/BpD9oouCto6hkHap18k/jSIfYl7Du4JHhkBdP5+r599mVjNc zA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89gtd004-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:52:11 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ODqBAY015872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:52:11 GMT
Received: from hu-vganneva-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 05:52:09 -0800
From:   Vinay Gannevaram <quic_vganneva@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] nl80211: Allow authentication frames and set keys on NAN interface
Date:   Tue, 24 Jan 2023 19:21:59 +0530
Message-ID: <1674568319-27964-1-git-send-email-quic_vganneva@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ECWSLXZDccPr4XASOn80GiEFVXyzDN5b
X-Proofpoint-ORIG-GUID: ECWSLXZDccPr4XASOn80GiEFVXyzDN5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=977 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240125
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
underlying modules on NAN interface

Signed-off-by: Vinay Gannevaram <quic_vganneva@quicinc.com>

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 64cf611..8c5be87 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1538,6 +1538,7 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_NAN:
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		if (wdev->u.ibss.current_bss)
@@ -1551,7 +1552,6 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
@@ -12251,8 +12251,8 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
-		break;
 	case NL80211_IFTYPE_NAN:
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -12308,8 +12308,8 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
-		break;
 	case NL80211_IFTYPE_NAN:
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.7.4

