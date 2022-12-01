Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837BA63E80B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 03:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLACwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 21:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLACw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 21:52:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A849839D
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 18:52:27 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12kfOI024855;
        Thu, 1 Dec 2022 02:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Gc2S0dJUIa34vCMw1GHfTu7httUkczYJbzaKcc5c6bc=;
 b=k+N4Mys+o2xbYJ4zY0Ip7uBCc78AqyvfbA99sOMTwVGYwWX9wlpM8jFXej7Yr3Wnn+Ga
 9IDWqa9HCcJ4fT78bu6vZevJsvQiLELTxDJUvzGAoo51fJ47RYQhVhVKQ/7CbNeII+Ub
 58Yga761ait88J8IzCqzgqQZNxl0WC3EDLe+AufD9o1AXK587HaGjuMKaajS8tcW8c1U
 c/6rmh4w7315ckBz3FAcIcWGBfsxU/Qeb09XkZUvlAgHsv4dPg2I2i1ABKqy1hmURwl8
 Y74AhL+GhPvaFJ+GySlnl+jOqGiHctBvYW+/AbAhz7cRqiX5DVE2DxbOpzB5QoDt/Glx sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k3yg2gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 02:52:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B12qNbQ014150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 02:52:23 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 18:52:22 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: mac80211_hwsim: EMA support
Date:   Wed, 30 Nov 2022 18:52:08 -0800
Message-ID: <20221201025208.23800-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221201025208.23800-1-quic_alokad@quicinc.com>
References: <20221201025208.23800-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C9cHXXuS3fvWGEs8FIA8-s7qbHKYFDaP
X-Proofpoint-ORIG-GUID: C9cHXXuS3fvWGEs8FIA8-s7qbHKYFDaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=925 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support enhanced multi-BSS advertisements (EMA)
for profile periodicity up to 3 beacons.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v1: depends on following
https://patchwork.kernel.org/project/linux-wireless/patch/20221114201912.22893-2-quic_alokad@quicinc.com/

 drivers/net/wireless/mac80211_hwsim.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 7cf9a7a364be..00b92d2936de 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2124,11 +2124,27 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	if (vif->mbssid_tx_vif && vif->mbssid_tx_vif != vif)
 		return;

-	skb = ieee80211_beacon_get(hw, vif, link_id);
-	if (!skb)
-		return;
+	if (vif->bss_conf.ema_ap) {
+		struct ieee80211_ema_beacons *ema;
+		u8 i = 0;
+
+		ema = ieee80211_beacon_get_template_ema_list(hw, vif, link_id);
+		if (!ema || !ema->cnt)
+			return;
+
+		for (i = 0; i < ema->cnt; i++) {
+			__mac80211_hwsim_beacon_tx(link_conf, data, hw, vif,
+						   ema->bcn[i].skb);
+			ema->bcn[i].skb = NULL; /* Already freed */
+		}
+		ieee80211_beacon_free_ema_list(ema);
+	} else {
+		skb = ieee80211_beacon_get(hw, vif, link_id);
+		if (!skb)
+			return;

-	__mac80211_hwsim_beacon_tx(link_conf, data, hw, vif, skb);
+		__mac80211_hwsim_beacon_tx(link_conf, data, hw, vif, skb);
+	}

 	while ((skb = ieee80211_get_buffered_bc(hw, vif)) != NULL) {
 		mac80211_hwsim_tx_frame(hw, skb,
@@ -4408,6 +4424,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	}

 	hw->wiphy->mbssid_max_interfaces = 8;
+	hw->wiphy->ema_max_profile_periodicity = 3;

 	data->rx_rssi = DEFAULT_RX_RSSI;

--
2.25.1

