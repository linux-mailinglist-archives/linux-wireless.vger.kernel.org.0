Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8836E7AE8C2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjIZJRZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjIZJRX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 05:17:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4ABF
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 02:17:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q8jRnK026406;
        Tue, 26 Sep 2023 09:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=63tai+1vk2FHPXqExoulcghxVIUuypAOFSXVN0CfajQ=;
 b=BWCD5R6Jbr/qccnsgZaiEKnfQbgXrgd0W8xK4YSJSEc1CVbEmLXLZVbXARQy8fp0mXpe
 zDjAo2mi5lIUoSzHDaQH6t/C2SIG7vxMNikiuYrIujtHcurPZFxM/pxWUblD71PwIldJ
 k+yLEjwBZO28rJ+9q6g3tYwII/ln/B+mv1zNn/TS/Vjrxr1vm85Es0wnoksp2XZm88ba
 3JtxsLNBTr64147cm2vz4hDQOADgU1cDpM/PrKBJ8QV3qvBI2jn7fZhWegyZLWzPnEO4
 pmkEkKHL7GtlFt3KDJHuVVR/l70vEOyA8gjV6PgSutoag4QlFohZKTX/IaoDur+NZkLu Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbgfv1cwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:17:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q9HBk2031492
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:17:11 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 02:17:09 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 3/3] wifi: mac80211: update beacon counters per link basis
Date:   Tue, 26 Sep 2023 14:46:48 +0530
Message-ID: <20230926091648.17184-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230926091648.17184-1-quic_adisi@quicinc.com>
References: <20230926091648.17184-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -fQnCBHpEsSS82FaEUINxe9DGPr-_4CC
X-Proofpoint-ORIG-GUID: -fQnCBHpEsSS82FaEUINxe9DGPr-_4CC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_06,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=818 mlxscore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index d7c5bfec7283..555dab53dee7 100644
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
index 6ed036b51dba..46dd7b1c6d6e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1588,7 +1588,7 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 	arvif->bcca_zero_sent = false;
 
 	if (vif->bss_conf.color_change_active)
-		ieee80211_beacon_update_cntdwn(vif);
+		ieee80211_beacon_update_cntdwn(vif, 0);
 	ath11k_mac_setup_bcn_tmpl(arvif);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b69f8af47d14..12243d413d19 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1467,7 +1467,7 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 	mvmvif->csa_countdown = true;
 
 	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
-		int c = ieee80211_beacon_update_cntdwn(csa_vif);
+		int c = ieee80211_beacon_update_cntdwn(csa_vif, 0);
 
 		iwl_mvm_mac_ctxt_beacon_changed(mvm, csa_vif,
 						&csa_vif->bss_conf);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index bce7102a439c..ce6a7eb74f0e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5435,6 +5435,7 @@ static inline struct sk_buff *ieee80211_beacon_get(struct ieee80211_hw *hw,
 /**
  * ieee80211_beacon_update_cntdwn - request mac80211 to decrement the beacon countdown
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO
  *
  * The beacon counter should be updated after each beacon transmission.
  * This function is called implicitly when
@@ -5444,7 +5445,8 @@ static inline struct sk_buff *ieee80211_beacon_get(struct ieee80211_hw *hw,
  *
  * Return: new countdown value
  */
-u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif);
+u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif,
+				  unsigned int link_id);
 
 /**
  * ieee80211_beacon_set_cntdwn - request mac80211 to set beacon countdown
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a984fc54644e..ab259647dd27 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5032,16 +5032,24 @@ static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
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
@@ -5282,7 +5290,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 
 	if (beacon->cntdwn_counter_offsets[0]) {
 		if (!is_template)
-			ieee80211_beacon_update_cntdwn(vif);
+			ieee80211_beacon_update_cntdwn(vif, link->link_id);
 
 		ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 	}
-- 
2.17.1

