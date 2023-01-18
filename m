Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7069A67210C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 16:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjARPUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 10:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjARPUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 10:20:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33893755F
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 07:16:44 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ICeqoK025432;
        Wed, 18 Jan 2023 15:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NI7KeLWwxQBCqeArGHQ43izEjangsOL3nnfZIeTkKrs=;
 b=kt96d4YpfI/OY3IKgDat632PiH6iETsFzKl0KH167NwYLnkXGA1750CimOppFbwq+/px
 5vHXgWRmezNWEl0z2i0AY3cRrOHkLr0mliPBiXfsHUkPfci3gHeBf9Ll/Eq6H6f7Gdw9
 3bl4/AKMQVfy+XuBQHG7CKOwKZaOu98QNYz8+hF0OJe9uFpRXY6Qx/kVnvz9Z6NSS0lA
 X79kp33d8jh/rfOBEVPnYUyXfrosFQp4xjA1NIsJKiXSamb8FYeqEpXrpFDnehuJnXzY
 Kgms0g5ER2QeOMKJse6OClW88LCLNnlNlExpFtSle79OyeBgZcp6blwPKqE3/y3kmQev XQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6e4r0p4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:16:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30IFGf6o029442
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:16:41 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 07:16:39 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: update beacon counters per link basis
Date:   Wed, 18 Jan 2023 20:46:04 +0530
Message-ID: <20230118151604.1278-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230118151604.1278-1-quic_adisi@quicinc.com>
References: <20230118151604.1278-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 60R-bgKra_llnuktJHrMHLFFiD59rkeM
X-Proofpoint-ORIG-GUID: 60R-bgKra_llnuktJHrMHLFFiD59rkeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=637 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180129
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, function to update beacon counter uses deflink to fetch
the beacon and then update the counter. However, with MLO, there is
a need to update the counter for the beacon in a particular link.

Add support to use link_id in order to fetch the beacon from a particular
link data during beacon update counter.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c             |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c             |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 include/net/mac80211.h                            |  4 +++-
 net/mac80211/tx.c                                 | 14 +++++++++++---
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a1c17b9b4390..49dc372770d4 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2041,7 +2041,7 @@ static void ath10k_mac_vif_ap_csa_count_down(struct ath10k_vif *arvif)
 		return;
 
 	if (!ieee80211_beacon_cntdwn_is_complete(vif)) {
-		ieee80211_beacon_update_cntdwn(vif);
+		ieee80211_beacon_update_cntdwn(vif, 0);
 
 		ret = ath10k_mac_setup_bcn_tmpl(arvif);
 		if (ret)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9e923ecb0891..3a6a24eb1e35 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1414,7 +1414,7 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 	arvif->bcca_zero_sent = false;
 
 	if (vif->bss_conf.color_change_active)
-		ieee80211_beacon_update_cntdwn(vif);
+		ieee80211_beacon_update_cntdwn(vif, 0);
 	ath11k_mac_setup_bcn_tmpl(arvif);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index f281326cb357..a909c2921d36 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1310,7 +1310,7 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 	mvmvif->csa_countdown = true;
 
 	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
-		int c = ieee80211_beacon_update_cntdwn(csa_vif);
+		int c = ieee80211_beacon_update_cntdwn(csa_vif, 0);
 
 		iwl_mvm_mac_ctxt_beacon_changed(mvm, csa_vif);
 		if (csa_vif->p2p &&
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d0010153f324..904105cb086f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5274,6 +5274,7 @@ static inline struct sk_buff *ieee80211_beacon_get(struct ieee80211_hw *hw,
 /**
  * ieee80211_beacon_update_cntdwn - request mac80211 to decrement the beacon countdown
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO
  *
  * The beacon counter should be updated after each beacon transmission.
  * This function is called implicitly when
@@ -5283,7 +5284,8 @@ static inline struct sk_buff *ieee80211_beacon_get(struct ieee80211_hw *hw,
  *
  * Return: new countdown value
  */
-u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif);
+u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif,
+				  unsigned int link_id);
 
 /**
  * ieee80211_beacon_set_cntdwn - request mac80211 to set beacon countdown
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index defe97a31724..41d27de0cc78 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4994,16 +4994,24 @@ static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
 	return beacon->cntdwn_current_counter;
 }
 
-u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif)
+u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link;
 	struct beacon_data *beacon = NULL;
 	u8 count = 0;
 
+	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
+		return 0;
+
 	rcu_read_lock();
 
+	link = rcu_dereference(sdata->link[link_id]);
+	if (!link)
+		goto unlock;
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
+		beacon = rcu_dereference(link->u.ap.beacon);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		beacon = rcu_dereference(sdata->u.ibss.presp);
 	else if (ieee80211_vif_is_mesh(&sdata->vif))
@@ -5217,7 +5225,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 
 	if (beacon->cntdwn_counter_offsets[0]) {
 		if (!is_template)
-			ieee80211_beacon_update_cntdwn(vif);
+			ieee80211_beacon_update_cntdwn(vif, link->link_id);
 
 		ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 	}
-- 
2.17.1

