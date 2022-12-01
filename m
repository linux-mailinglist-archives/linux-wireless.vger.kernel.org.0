Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA263E809
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 03:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLACw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 21:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLACw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 21:52:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B64983A8
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 18:52:26 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B125LiV032067;
        Thu, 1 Dec 2022 02:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kEF06RjCjx4psyqvWs/4ymhbm3hsg5iAyoU71u6vdZY=;
 b=QnjPwVZHJoGfAjGXDUUGlwqD/Mrfc9BsYCX9CoKbecYoLd5yDyyym5dGowMNnko54azt
 fUZBr5KB8F1J2qN4YixOT/k/LFeuQcAFIgSO8kCrfnHdybkAEFMuVSeYQUmOU3ba7HPZ
 uNwVgpQnYXJAqFU/zU+YpRZV67mBklutO1VlN/U+y6poLQX7/xQd1FeCu9YgC9NimIN/
 vbsnLgsqUC4KQwgeT8Z46nkEXP1CcHr0utP0+WuTWWz7s4skmok9zN3iG03EzW6+RNfP
 arLNSrmOhHchUaTu0cYFcVJKrx0UFlx5hMP7uhBhVVaAtJ/MefwKZ4GSSFsERKxr8EaA kA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k5t82ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 02:52:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B12qMu0020738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 02:52:22 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 18:52:22 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: mac80211_hwsim: move beacon transmission to a separate function
Date:   Wed, 30 Nov 2022 18:52:06 -0800
Message-ID: <20221201025208.23800-2-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: XAJOqO-vN25bBkcSIywJrilDyb7Eb1y6
X-Proofpoint-ORIG-GUID: XAJOqO-vN25bBkcSIywJrilDyb7Eb1y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

base-commit: eceb024ee3eed1bacb5c32a4847269f2685e2ea4
prerequisite-patch-id: fcf54cc59b71b15010a88a080ee2b5f91d815d51
-- 
2.25.1

