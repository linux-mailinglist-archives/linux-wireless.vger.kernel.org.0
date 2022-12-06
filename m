Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E2643A70
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 01:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiLFAu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 19:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiLFAu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 19:50:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACEA1B1EB
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 16:50:53 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B60C2Sq012202;
        Tue, 6 Dec 2022 00:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+uZ0f0BED1zClMdqbgESQ5CTlLKItjtIeCmAJ3RuElw=;
 b=mcfeBdgXa3wBpKy/+in14faigKzirur+JQyHJThePGq6KMUalwwUJaYEdfkbQIkO8Tj1
 Hvkfv/bcmBYCfcdGKh1bdFWRBZXDd4Ymg51IZ6d9ORAiYlWzq/r6AIBzk6O0tvhv3RkL
 TKnmbrgDWPpUh7UZf+hfcv0aTtM3sRN/7v9VkGKYjwaSOOKtbKfbgjhtIbIikHe33bIb
 igx2Fnzkw1a0AbQ6fL7z1gfXT7Ba6xreQMe9FsUAnWC4DaQoOoKLE67IfVax+YXpq09s
 hegjn6nfLyC2uAkKDdFOhnTB7jJE8FFhduIhOousiE4n9xb7Q14GQBPWl5/7gVthA5uW Og== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9trk03at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 00:50:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B60onpF003654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 00:50:49 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 16:50:49 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 2/4] wifi: mac80211_hwsim: move beacon transmission to a separate function
Date:   Mon, 5 Dec 2022 16:50:38 -0800
Message-ID: <20221206005040.3177-3-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: J4mXrvO2QOSYHY8mi-OCesIf8MKJXbTq
X-Proofpoint-ORIG-GUID: J4mXrvO2QOSYHY8mi-OCesIf8MKJXbTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move the beacon transmission to a separate function to facilitate
addition of EMA beacon transmission.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 61 ++++++++++++++++-----------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index c57c8903b7c0..b18f992b6276 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2054,38 +2054,18 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 	dev_kfree_skb(skb);
 }
 
-static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
-				     struct ieee80211_vif *vif)
+static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
+				       struct mac80211_hwsim_data *data,
+				       struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct sk_buff *skb)
 {
-	struct mac80211_hwsim_link_data *link_data = arg;
-	u32 link_id = link_data->link_id;
-	struct ieee80211_bss_conf *link_conf;
-	struct mac80211_hwsim_data *data =
-		container_of(link_data, struct mac80211_hwsim_data,
-			     link_data[link_id]);
-	struct ieee80211_hw *hw = data->hw;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_rate *txrate;
 	struct ieee80211_mgmt *mgmt;
-	struct sk_buff *skb;
 	/* TODO: get MCS */
 	int bitrate = 100;
 
-	hwsim_check_magic(vif);
-
-	link_conf = rcu_dereference(vif->link_conf[link_id]);
-	if (!link_conf)
-		return;
-
-	if (vif->type != NL80211_IFTYPE_AP &&
-	    vif->type != NL80211_IFTYPE_MESH_POINT &&
-	    vif->type != NL80211_IFTYPE_ADHOC &&
-	    vif->type != NL80211_IFTYPE_OCB)
-		return;
-
-	skb = ieee80211_beacon_get(hw, vif, link_data->link_id);
-	if (skb == NULL)
-		return;
 	info = IEEE80211_SKB_CB(skb);
 	if (ieee80211_hw_check(hw, SUPPORTS_RC_TABLE))
 		ieee80211_get_tx_rates(vif, NULL, skb,
@@ -2115,6 +2095,37 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 
 	mac80211_hwsim_tx_frame(hw, skb,
 			rcu_dereference(link_conf->chanctx_conf)->def.chan);
+}
+
+static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
+				     struct ieee80211_vif *vif)
+{
+	struct mac80211_hwsim_link_data *link_data = arg;
+	u32 link_id = link_data->link_id;
+	struct ieee80211_bss_conf *link_conf;
+	struct mac80211_hwsim_data *data =
+		container_of(link_data, struct mac80211_hwsim_data,
+			     link_data[link_id]);
+	struct ieee80211_hw *hw = data->hw;
+	struct sk_buff *skb;
+
+	hwsim_check_magic(vif);
+
+	link_conf = rcu_dereference(vif->link_conf[link_id]);
+	if (!link_conf)
+		return;
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    vif->type != NL80211_IFTYPE_MESH_POINT &&
+	    vif->type != NL80211_IFTYPE_ADHOC &&
+	    vif->type != NL80211_IFTYPE_OCB)
+		return;
+
+	skb = ieee80211_beacon_get(hw, vif, link_id);
+	if (!skb)
+		return;
+
+	__mac80211_hwsim_beacon_tx(link_conf, data, hw, vif, skb);
 
 	while ((skb = ieee80211_get_buffered_bc(hw, vif)) != NULL) {
 		mac80211_hwsim_tx_frame(hw, skb,
-- 
2.34.1

