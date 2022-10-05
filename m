Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B25F5BF9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 23:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJEVzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJEVy6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 17:54:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A5193FE
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 14:54:57 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295LQ75Q016677;
        Wed, 5 Oct 2022 21:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NwfQS78moHCWBC+5PlAlAB+26yTow3esMo4Pwz+G0Ns=;
 b=Qbr6zRgCdsEIOMnKPCMQ2FlvNMJAW91K3tVr/L9macG60n89RW8yvQTEtBJo0Eyy0rpK
 p8wvBOJRibDVY6W7VV/KCWniIpUt880yd1Iq5RFSoSgv5aAnd3wUYR+hBpuTbaJjHa30
 agCOT+cnyuw+1ieCn6nyQH3EmfIfaQLGbOzdV1BKNMhTj8uzCa6IpmNzg7wtnpru9r9x
 hSXCLH4SKMua+3amM2GgnYKSjAOEzTcgR1ivbV9vCNrbodzQi2wy6CigoZtNm/FsH7aR
 n/Z78n922QvX1vd8V1sJJY6P59gr0CQV5GyGcQ3C7vIQeWwIvem1dHkd5RUgBk5JWjtR vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0rhdjpp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 21:54:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 295LsrqY022242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Oct 2022 21:54:53 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 14:54:53 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v4 1/2] mac80211: Add VHT MU-MIMO related flags in ieee80211_bss_conf
Date:   Wed, 5 Oct 2022 14:54:45 -0700
Message-ID: <1665006886-23874-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OOmQkZBKxz4D7a_iLWDREVR_3HlRo9Ji
X-Proofpoint-GUID: OOmQkZBKxz4D7a_iLWDREVR_3HlRo9Ji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 mlxlogscore=875
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

Adding flags for SU Beamformer, SU Beamformee, MU Beamformer and
MU Beamformee for VHT. This is utilized to pass MU-MIMO
configurations from user space to driver in AP mode.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/mac80211.h | 13 +++++++++++++
 net/mac80211/cfg.c     | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac2bad57933f..d30cb1e9d180 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -652,6 +652,14 @@ struct ieee80211_fils_discovery {
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
  * @color_change_color: the bss color that will be used after the change.
+ * @vht_su_beamformer: in AP-mode, does this BSS support operation as an VHT SU
+ *	beamformer
+ * @vht_su_beamformee: in AP-mode, does this BSS support operation as an VHT SU
+ *	beamformee
+ * @vht_mu_beamformer: in AP-mode, does this BSS support operation as an VHT MU
+ *	beamformer
+ * @vht_mu_beamformee: in AP-mode, does this BSS support operation as an VHT MU
+ *	beamformee
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -725,6 +733,11 @@ struct ieee80211_bss_conf {
 
 	bool color_change_active;
 	u8 color_change_color;
+
+	bool vht_su_beamformer;
+	bool vht_su_beamformee;
+	bool vht_mu_beamformer;
+	bool vht_mu_beamformee;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 687b4c878d4a..293640b9da13 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1251,6 +1251,21 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	prev_beacon_int = link_conf->beacon_int;
 	link_conf->beacon_int = params->beacon_interval;
 
+	if (params->vht_cap) {
+		link_conf->vht_su_beamformer =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
+		link_conf->vht_su_beamformee =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
+		link_conf->vht_mu_beamformer =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE));
+		link_conf->vht_mu_beamformee =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE));
+	}
+
 	if (params->he_cap && params->he_oper) {
 		link_conf->he_support = true;
 		link_conf->htc_trig_based_pkt_ext =
-- 
2.7.4

