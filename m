Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE903643A73
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 01:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiLFAvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 19:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiLFAu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 19:50:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8E1B7AC
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 16:50:54 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Nk2Ao001015;
        Tue, 6 Dec 2022 00:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rM3bJgfIU7neMnG15eQrqp0Fi/+aDlgIVbYcl5TjFL0=;
 b=ngtZSYHnlXpwP7DchzTdhEpPmOUdH+Lp9CePrRmD8R95NdcauLLgJpLiRksnVU2ZKc6A
 n694xwwkfJ4DRUjKykqNbU1TEOnLlTpuvmcVtwztP1U4Nmk5o/PQ0Bq9O08U14EfG/ot
 XcaXHHpaiItqIt1Z3AOepwk1QwBFn4dj2OdsBnxlNlSQ4GeQmtIiKzB3O4abkC79QFPp
 FCex4dB3F1DYJuUuK+0iEpMx2/ovUsSuzJlAUEd7Zi+yYgg+9zr7Sscf3baSWZ2SpgYk
 yN3w4wyd+Jn0Im/bmWOyqlD6y+JN4ikPFObvgRNisMDaEEdSB6fpZ8tHZwS5nTpFO4vh pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7v5me0g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 00:50:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B60oojp016109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 00:50:50 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 16:50:50 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 4/4] wifi: mac80211_hwsim: EMA support
Date:   Mon, 5 Dec 2022 16:50:40 -0800
Message-ID: <20221206005040.3177-5-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221206005040.3177-1-quic_alokad@quicinc.com>
References: <20221206005040.3177-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e8crt6BaWzg7iKGhsCzcBoT1e_sw00Ki
X-Proofpoint-GUID: e8crt6BaWzg7iKGhsCzcBoT1e_sw00Ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060001
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support enhanced multi-BSS advertisements (EMA)
for profile periodicity up to 3 beacons.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
Corresponding hostapd test: test_he_ap_ema

 drivers/net/wireless/mac80211_hwsim.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 7cf9a7a364be..43f35b88c20c 100644
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
2.34.1

