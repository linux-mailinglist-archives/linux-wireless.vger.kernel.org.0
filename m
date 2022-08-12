Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF7590C17
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 08:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiHLGqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 02:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiHLGqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 02:46:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE889A99A
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 23:46:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C4oToa021881;
        Fri, 12 Aug 2022 06:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=38/KgcEJicRx6M+fzc7oyCC5XhE2iLkkmal4Nz01F7c=;
 b=JOcgI8eQdGZHuPy8Y0fNdtlVW7AQvblJy6AFLvBhAi7w6jKr/EnIYq/DhGVtYrM1shvU
 yM3losjyB560mFJACySwqvrKjVJXRIY1uIVEefbNF4SjoMcT5ZOKadm6PPHdBDGcsWP7
 dTWzHcW3aQXXgFoTh23ffdRMgBH5NJi9UaEISYKIshf5WzhPWOEKHxUAZYE6Om/zkHeA
 VXZhjRDXtkiZsGEZRwCWd8C6gvQKxx0JzRV6V6zefqf8XYvlqtOp7T0/ErvV4MjTKN8P
 YhLcRt4fiklS1ADgC8Z0rPC25Hd9gyJ44A1lw/J2z/fnnYwMSndN0Cjnt9IrNmPMusHx JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hwf728aeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 06:46:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27C6kF3K029946
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 06:46:15 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 11 Aug 2022 23:46:15 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v3 2/2] mac80211: Add HE MU-MIMO related flags in ieee80211_bss_conf
Date:   Thu, 11 Aug 2022 23:46:07 -0700
Message-ID: <1660286767-11853-2-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660286767-11853-1-git-send-email-quic_msinada@quicinc.com>
References: <1660286767-11853-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8t3kYaCJs07K7ZmfwP0NXYBBFRk3ZIpb
X-Proofpoint-GUID: 8t3kYaCJs07K7ZmfwP0NXYBBFRk3ZIpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=784 phishscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding flags for SU Beamformer, SU Beamformee, MU Beamformer and Full
Bandwidth UL MU-MIMO for HE. This is utilized to pass MU-MIMO
configurations from user space to driver.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/mac80211.h | 10 ++++++++++
 net/mac80211/cfg.c     | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 893cc7b98448..a3a655fa1958 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -655,6 +655,12 @@ struct ieee80211_fils_discovery {
  * @vht_su_beamformee: does this BSS support operation as an VHT SU beamformee
  * @vht_mu_beamformer: does this BSS support operation as an VHT MU beamformer
  * @vht_mu_beamformee: does this BSS support operation as an VHT MU beamformee
+ * @he_su_beamformer: does this BSS support operation as an HE SU beamformer
+ * @he_su_beamformee: does this BSS support operation as an HE SU beamformee
+ * @he_mu_beamformer: does this BSS support operation as an HE MU beamformer
+ * @he_full_ul_mumimo: does this BSS support the reception (AP) or transmission
+ *	(non-AP STA) of an HE TB PPDU on an RU that spans the entire PPDU
+ *	bandwidth
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -733,6 +739,10 @@ struct ieee80211_bss_conf {
 	bool vht_su_beamformee;
 	bool vht_mu_beamformer;
 	bool vht_mu_beamformee;
+	bool he_su_beamformer;
+	bool he_su_beamformee;
+	bool he_mu_beamformer;
+	bool he_full_ul_mumimo;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b13ce9ecfda8..727f5559a6da 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1208,6 +1208,21 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (params->he_cap) {
+		sdata->vif.bss_conf.he_su_beamformer =
+					!!(params->he_cap->phy_cap_info[3] &
+					   IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER);
+		sdata->vif.bss_conf.he_su_beamformee =
+					!!(params->he_cap->phy_cap_info[4] &
+					   IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE);
+		sdata->vif.bss_conf.he_mu_beamformer =
+					!!(params->he_cap->phy_cap_info[4] &
+					   IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER);
+		sdata->vif.bss_conf.he_full_ul_mumimo =
+				   !!(params->he_cap->phy_cap_info[2] &
+				      IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
-- 
2.7.4

