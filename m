Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD9643E03
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 09:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLFIC7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 03:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLFIC4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 03:02:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF4EDAC
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 00:02:55 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B67F8Lh021155;
        Tue, 6 Dec 2022 08:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Hi8c7IAzWDOJAkJJWpW07dO9P+BtlU3NYZ+RPOE48Bo=;
 b=LtGv6h7Wt7htHpMyPExeaeoysQtMogk3fy2Mm0jHybEPvyyX90vnHKBLGD33k/q7aHKl
 F1Ce5Ka/dkV1Kk4wL3hhYD7SyqhOwoZJqUCb1E47u7a2b2Vo0CG+7EJn4JAJN/tXq9Dc
 t0TR8QvqXP/SL4Gz3H3twOgb7pLtk/U9vRKfL7PZFdxfbcHo3Glw2KTRpiKEJlmePq3J
 Q2CxE5pbCM5zkeESlcIzMwSklrEA+LXwZsBBH+DkW80Uhu63I6e1YNEPRjY+2Q1hyaaf
 1P2xIIqvq76wJjNx0Dk4onx9Rjd6YXMspnOYvZXVIAqkESe9SZHfSU2272oqhcnL6GW0 0A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ma1660608-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 08:02:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B682p0h000537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 08:02:52 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 00:02:49 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: cfg80211: Use MLD address to indicate MLD STA disconnection
Date:   Tue, 6 Dec 2022 13:32:26 +0530
Message-ID: <20221206080226.1702646-4-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
References: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bhWW4lLHJnTfGHExCpyPSG-DX3mDNX1u
X-Proofpoint-GUID: bhWW4lLHJnTfGHExCpyPSG-DX3mDNX1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_05,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=878
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use station's MLD address to report disconnection of MLD station.
Updated documentation in multiple places to indicate the same.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 4 ++--
 include/uapi/linux/nl80211.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 36cecfa217f1..eeb9a43c77df 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7812,7 +7812,7 @@ void cfg80211_new_sta(struct net_device *dev, const u8 *mac_addr,
 /**
  * cfg80211_del_sta_sinfo - notify userspace about deletion of a station
  * @dev: the netdev
- * @mac_addr: the station's address
+ * @mac_addr: the station's address. For MLD station, MLD address is used.
  * @sinfo: the station information/statistics
  * @gfp: allocation flags
  */
@@ -7823,7 +7823,7 @@ void cfg80211_del_sta_sinfo(struct net_device *dev, const u8 *mac_addr,
  * cfg80211_del_sta - notify userspace about deletion of a station
  *
  * @dev: the netdev
- * @mac_addr: the station's address
+ * @mac_addr: the station's address. For MLD station, MLD address is used.
  * @gfp: allocation flags
  */
 static inline void cfg80211_del_sta(struct net_device *dev,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..e1d54ebc1dcb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -424,7 +424,8 @@
  *	interface identified by %NL80211_ATTR_IFINDEX.
  * @NL80211_CMD_DEL_STATION: Remove a station identified by %NL80211_ATTR_MAC
  *	or, if no MAC address given, all stations, on the interface identified
- *	by %NL80211_ATTR_IFINDEX. %NL80211_ATTR_MGMT_SUBTYPE and
+ *	by %NL80211_ATTR_IFINDEX. For MLD station, MLD address is used in
+ *	%NL80211_ATTR_MAC. %NL80211_ATTR_MGMT_SUBTYPE and
  *	%NL80211_ATTR_REASON_CODE can optionally be used to specify which type
  *	of disconnection indication should be sent to the station
  *	(Deauthentication or Disassociation frame and reason code for that
-- 
2.25.1

