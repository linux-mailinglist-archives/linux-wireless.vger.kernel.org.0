Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956345F5BFA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 23:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJEVzD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJEVzB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 17:55:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014C1A20D
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 14:54:59 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295LQ5fC005595;
        Wed, 5 Oct 2022 21:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qZqgN1MHfDjrMghGR4TdXGwsX1vARVnbwLWXqkR3Bzc=;
 b=U53iK/cxwoObX7NSL3QGQvdwcRg94gk+zg8vQxDYyz7Q6Ub/4itxZNHa1dIcNpfOERzV
 wwa9UZbFHQtYBuHOdXttJz1VuqOiTWFHpTDWaiJx9v6+/WYMZmyh7xibGLO32DGG5TYI
 /+t5pHrBoJ1HEpnXQDr2RlAHHdjJDiP3BOXapvPMEH3Tk7NsebmBP5iWblJ/bjGKq5V5
 /Fx4yHPJsGFnxzEeW+KMJ+I3zDtwRbl4NrkTPQsmbbxszkF7J7o05Gn6Pb/hPHbntYMc
 D90+DMD6yZnB2tRAiqj7ZS6ZWRVKDhB3y4YErP9IYADNdzPU/bEg6D2gkl6R/yic9Z02 bA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0sq5thcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 21:54:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 295LstZT002371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Oct 2022 21:54:55 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 14:54:54 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v4 2/2] mac80211: Add HE MU-MIMO related flags in ieee80211_bss_conf
Date:   Wed, 5 Oct 2022 14:54:46 -0700
Message-ID: <1665006886-23874-2-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665006886-23874-1-git-send-email-quic_msinada@quicinc.com>
References: <1665006886-23874-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XNk9Y8ZsSCBFF4s8iGEOEASqeufTC8_o
X-Proofpoint-GUID: XNk9Y8ZsSCBFF4s8iGEOEASqeufTC8_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=763 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050134
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding flags for SU Beamformer, SU Beamformee, MU Beamformer and Full
Bandwidth UL MU-MIMO for HE. This is utilized to pass MU-MIMO
configurations from user space to driver in AP mode.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/mac80211.h | 13 +++++++++++++
 net/mac80211/cfg.c     | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d30cb1e9d180..073b555c1097 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -660,6 +660,15 @@ struct ieee80211_fils_discovery {
  *	beamformer
  * @vht_mu_beamformee: in AP-mode, does this BSS support operation as an VHT MU
  *	beamformee
+ * @he_su_beamformer: in AP-mode, does this BSS support operation as an HE SU
+ *	beamformer
+ * @he_su_beamformee: in AP-mode, does this BSS support operation as an HE SU
+ *	beamformee
+ * @he_mu_beamformer: in AP-mode, does this BSS support operation as an HE MU
+ *	beamformer
+ * @he_full_ul_mumimo: does this BSS support the reception (AP) or transmission
+ *	(non-AP STA) of an HE TB PPDU on an RU that spans the entire PPDU
+ *	bandwidth
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -738,6 +747,10 @@ struct ieee80211_bss_conf {
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
index 293640b9da13..810822f1a7f7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1280,6 +1280,21 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (params->he_cap) {
+		link_conf->he_su_beamformer =
+					!!(params->he_cap->phy_cap_info[3] &
+					   IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER);
+		link_conf->he_su_beamformee =
+					!!(params->he_cap->phy_cap_info[4] &
+					   IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE);
+		link_conf->he_mu_beamformer =
+					!!(params->he_cap->phy_cap_info[4] &
+					   IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER);
+		link_conf->he_full_ul_mumimo =
+				   !!(params->he_cap->phy_cap_info[2] &
+				      IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
-- 
2.7.4

