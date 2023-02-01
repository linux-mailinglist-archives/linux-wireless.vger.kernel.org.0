Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5945C685FB3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 07:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBAGQq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 01:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAGQp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 01:16:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770D10F9
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 22:16:44 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3115Nq8Z024028;
        Wed, 1 Feb 2023 06:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=CdtZRRyJ9n/kgTnulxjQCuBH7OMELgOTKZ8nHJaFjJs=;
 b=T2k5h1bJsqJPXMGyHzC8/VlwYDGEobDpAfKUO1qm9eWQ5DgkzHI5U1n4fMhxI4yNt1+2
 sDpDpuy3Gm7J/j8ohY89y1WzQt1jSwd25l9Dfi1/Wy1ucX7V5XiW4/vhUV5ZjJlyHeDY
 dOnyr6EJL6WMPc9kas23V8L6hUK+iuQRHyHp+cl1qTxuu2eSce55C//MH+ViElCuoV+P
 3W1nm6t6dhjsYdrTzM9KRSjom+lpAciTzf4UPaax8yvWiqJyn3n63r0WVUJh8u/Df6/L
 9HtI1kz+iDTEP8v8FV3WIqvfn6Qiz6e3h6iLZU8LWjpIT9ZCd1T+ys479FOd3uwOLhWD qQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3new3ub4p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:16:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3116Gdcl006417
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 06:16:39 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 22:16:37 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH] wifi: cfg80211: Allow action frames to be transmitted with link BSS in MLD
Date:   Wed, 1 Feb 2023 11:46:02 +0530
Message-ID: <20230201061602.3918-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hMCAs_cuPCIBUDQSUeCcWjfUy5DivRWZ
X-Proofpoint-ORIG-GUID: hMCAs_cuPCIBUDQSUeCcWjfUy5DivRWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=601
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently action frames TX only with ML address as A3(BSSID) are
allowed in an ML AP, but TX for a non-ML Station can happen in any
link of an ML BSS with link BSS address as A3.
In case of an MLD, if User-space has provided a valid link_id in
action frame TX request, allow transmission of the frame in that link.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 net/wireless/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 58e1fb18f85a..81d3f40d6235 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -742,7 +742,10 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_P2P_GO:
 		case NL80211_IFTYPE_AP_VLAN:
-			if (!ether_addr_equal(mgmt->bssid, wdev_address(wdev)))
+			if (!ether_addr_equal(mgmt->bssid, wdev_address(wdev)) &&
+			    (params->link_id < 0 ||
+			     !ether_addr_equal(mgmt->bssid,
+					       wdev->links[params->link_id].addr)))
 				err = -EINVAL;
 			break;
 		case NL80211_IFTYPE_MESH_POINT:

base-commit: 4ca69027691a0039279b64cfa0aa511d9c9fde59
-- 
2.17.1

