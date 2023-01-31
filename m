Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2595682070
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 01:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAaAMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 19:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjAaAMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 19:12:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729181A94C
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 16:12:45 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UMGAwl021005;
        Tue, 31 Jan 2023 00:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=uvw3bJA8oV8onJLwNwfsN9Lz3uNTd0nrMyUDKDzmbuk=;
 b=W1jDTOpGA7jB+bUls1goxAXDDV+p71rYpCWXWC+DfY+WjmOno78ZQ5h0cyy2B/l4xXUk
 hQyUaGgUVaTtqpQaG7L39lWklVAI5TMGhHFigXcUaQxwRag85ki+WhFK1mtcXySlw+o8
 wICBuwgvuUy/uqpt3WAT6n+vxMKqdpB2d+FmeqMVU3JHy2RyrZXJSrK1j42Ussn/WkKh
 441gozwv+gzb3R2eXdSBQWwSiHn1OS4JJXB0j99cU66cFZqN2KHxUqetGz5K5cy+U+9n
 ULXSHTLNBV+LU3YoyS6C1g6f9BL/tRb2aeLL/46rwJZnDk8kGPWH1/1ap/Ow164IhTSt eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpcu6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V0CfWv019559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:41 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 16:12:41 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v4 4/4] wifi: mac80211: configure puncturing bitmap
Date:   Mon, 30 Jan 2023 16:12:27 -0800
Message-ID: <20230131001227.25014-5-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131001227.25014-1-quic_alokad@quicinc.com>
References: <20230131001227.25014-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OorB2U6GXd0losBiajQG4g5omsL-Pel4
X-Proofpoint-ORIG-GUID: OorB2U6GXd0losBiajQG4g5omsL-Pel4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_18,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=893 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300218
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Configure the bitmap in link_conf and notify the driver.
- Modify 'change' in ieee80211_start_ap() from u32 to u64 to support
BSS_CHANGED_EHT_PUNCTURING.
- Propagate the bitmap in channel switch events to userspace.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/mac80211.h |  3 +++
 net/mac80211/cfg.c     | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 54ffc0cc2918..9fbbaf8e9a85 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -645,6 +645,7 @@ struct ieee80211_fils_discovery {
  * @csa_active: marks whether a channel switch is going on. Internally it is
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
+ * @csa_punct_bitmap: new puncturing bitmap for channel switch
  * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
  *	when it is not assigned. This pointer is RCU-protected due to the TX
@@ -741,6 +742,8 @@ struct ieee80211_bss_conf {
 	u16 eht_puncturing;
 
 	bool csa_active;
+	u16 csa_punct_bitmap;
+
 	bool mu_mimo_owner;
 	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6e830d1b82b2..5cd7ae4deb84 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1220,7 +1220,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct beacon_data *old;
 	struct ieee80211_sub_if_data *vlan;
-	u32 changed = BSS_CHANGED_BEACON_INT |
+	u64 changed = BSS_CHANGED_BEACON_INT |
 		      BSS_CHANGED_BEACON_ENABLED |
 		      BSS_CHANGED_BEACON |
 		      BSS_CHANGED_P2P_PS |
@@ -1296,6 +1296,11 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 	}
 
+	if (params->eht_cap) {
+		link_conf->eht_puncturing = params->punct_bitmap;
+		changed |= BSS_CHANGED_EHT_PUNCTURING;
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
@@ -3546,6 +3551,12 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
+	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
+		sdata->vif.bss_conf.eht_puncturing =
+					sdata->vif.bss_conf.csa_punct_bitmap;
+		changed |= BSS_CHANGED_EHT_PUNCTURING;
+	}
+
 	/*
 	 * using reservation isn't immediate as it may be deferred until later
 	 * with multi-vif. once reservation is complete it will re-schedule the
@@ -3588,7 +3599,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 		return err;
 
 	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0,
-				  0);
+				  sdata->vif.bss_conf.eht_puncturing);
 
 	return 0;
 }
@@ -3850,9 +3861,13 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	if (params->punct_bitmap && !sdata->vif.bss_conf.eht_support)
+		goto out;
+
 	sdata->deflink.csa_chandef = params->chandef;
 	sdata->deflink.csa_block_tx = params->block_tx;
 	sdata->vif.bss_conf.csa_active = true;
+	sdata->vif.bss_conf.csa_punct_bitmap = params->punct_bitmap;
 
 	if (sdata->deflink.csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
@@ -3860,7 +3875,8 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &sdata->deflink.csa_chandef, 0,
-					  params->count, params->block_tx, 0);
+					  params->count, params->block_tx,
+					  sdata->vif.bss_conf.csa_punct_bitmap);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-- 
2.39.0

