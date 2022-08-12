Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240B4590C16
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 08:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiHLGqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLGqR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 02:46:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4289E99B7C
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 23:46:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C5Hl33014789;
        Fri, 12 Aug 2022 06:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WMpV9Lko5UMI+fKM8Q6IwB1l7hE0ktIsbYXswOT6HOw=;
 b=OCaNWp4Kkn5tzahVry/qra6ZmjkDRMeVAG0+wb/OJlkyB34bM3t02AYpQxkRPugS2LNr
 IA5Im54oAncaRgDfVxF/zbbiCZDWiDNBQDrdWL0nlL6DeafT2KLb8+M0NpF/oRXhrbvV
 yy+CGQszmJu2mjEhTP9y/NIvKXkBvyamCMzSh0r05eUF51F308VhYPqPPGKr5yqdjRSq
 hPlL5Jh4SW2zDmIaTag0+D3xFhjapyR8LECRKWrz9W6EcwTDOMKqiPUSU7NCLq5vqbNi
 pkelCjlM0dTMhNNnBTWhGYR+4fuzj8Poh2G1fU3wCi1DS4+gHEoGa7v6A82KoMG6zdXu LA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hw89x13su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 06:46:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27C6kDQb027923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 06:46:13 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 11 Aug 2022 23:46:12 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v3 1/2] mac80211: Add VHT MU-MIMO related flags in ieee80211_bss_conf
Date:   Thu, 11 Aug 2022 23:46:06 -0700
Message-ID: <1660286767-11853-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j8TxB570TbI26938-YmS6IYwzbtPxECi
X-Proofpoint-ORIG-GUID: j8TxB570TbI26938-YmS6IYwzbtPxECi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=897 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120017
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding flags for SU Beamformer, SU Beamformee, MU Beamformer and
MU Beamformee for VHT. This is utilized to pass MU-MIMO
configurations from user space to driver.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/mac80211.h |  9 +++++++++
 net/mac80211/cfg.c     | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f198af600b5e..893cc7b98448 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -651,6 +651,10 @@ struct ieee80211_fils_discovery {
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
  * @color_change_color: the bss color that will be used after the change.
+ * @vht_su_beamformer: does this BSS support operation as an VHT SU beamformer
+ * @vht_su_beamformee: does this BSS support operation as an VHT SU beamformee
+ * @vht_mu_beamformer: does this BSS support operation as an VHT MU beamformer
+ * @vht_mu_beamformee: does this BSS support operation as an VHT MU beamformee
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -724,6 +728,11 @@ struct ieee80211_bss_conf {
 
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
index a4f6971b7a19..b13ce9ecfda8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1179,6 +1179,21 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	prev_beacon_int = link_conf->beacon_int;
 	link_conf->beacon_int = params->beacon_interval;
 
+	if (params->vht_cap) {
+		sdata->vif.bss_conf.vht_su_beamformer =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
+		sdata->vif.bss_conf.vht_su_beamformee =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
+		sdata->vif.bss_conf.vht_mu_beamformer =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE));
+		sdata->vif.bss_conf.vht_mu_beamformee =
+		       !!(params->vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE));
+	}
+
 	if (params->he_cap && params->he_oper) {
 		link_conf->he_support = true;
 		link_conf->htc_trig_based_pkt_ext =
-- 
2.7.4

