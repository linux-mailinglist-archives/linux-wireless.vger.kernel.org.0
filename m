Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197D7AE8C1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjIZJRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjIZJRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 05:17:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F265110A
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 02:17:13 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q1qm4Y022178;
        Tue, 26 Sep 2023 09:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sYAsQ0fFYTjwMvfZBPFe+bgvX6AS780xbxxpXkQjydw=;
 b=kSuXIj7ZEZPalgAycj9mSWbxoNC1ncFQcEn/e0hfSnu9WYfzPk66ez5NBSjjziiAA/DJ
 fMvH2fJnMxDmjNoOmlJCsSptxS3GWt1IYed/aADJxauUdpHBFVb9ZpW8RJMzpRcBL8P/
 oHzttx5Est5DYJ9EpB97IAqOuMDFMqvMjJZS58yFEGoFhyHj74o+Ygb8kxCoyKSWj7U6
 MO7MWosW6nHe5oZXL74LdBxMKmmlMi8tIBSeFiG8/g+1sNRH+e7fTmtYGxEKu3iUWKxe
 o1aX2iulHWl9xd6gHjtuhxz2tbviioK5/RN4aLOvY88CYxLIhVFR9TiqbVbGt7a1nII/ +w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbmwwrxgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:17:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q9H9Np001273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:17:09 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 02:17:07 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 2/3] wifi: mac80211: add support for AP channel switch with MLO
Date:   Tue, 26 Sep 2023 14:46:47 +0530
Message-ID: <20230926091648.17184-3-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 46fIRCRbfjRc8SwD2vcqR4_RGeAAqHpJ
X-Proofpoint-ORIG-GUID: 46fIRCRbfjRc8SwD2vcqR4_RGeAAqHpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, during channel switch, deflink (or link_id 0) is always
considered. However, with Multi-Link Operation (MLO), there is a
need to handle link specific data structures based on the actual
operational link_id during channel switch operation.

Hence, add support for the same. Non-MLO based operations will use
link_id as 0 or deflink member as applicable.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |   2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   4 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 drivers/net/wireless/ti/wlcore/event.c        |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   2 +-
 include/net/mac80211.h                        |   3 +-
 net/mac80211/cfg.c                            | 106 +++++++++++-------
 17 files changed, 83 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 03e7bc5b6c0b..d7c5bfec7283 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2053,7 +2053,7 @@ static void ath10k_mac_vif_ap_csa_count_down(struct ath10k_vif *arvif)
 			ath10k_warn(ar, "failed to update prb tmpl during csa: %d\n",
 				    ret);
 	} else {
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 05fa7d4c0e1a..2ffc9bed4f49 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3884,7 +3884,7 @@ void ath10k_wmi_event_host_swba(struct ath10k *ar, struct sk_buff *skb)
 		 */
 		if (arvif->vif->bss_conf.csa_active &&
 		    ieee80211_beacon_cntdwn_is_complete(arvif->vif)) {
-			ieee80211_csa_finish(arvif->vif);
+			ieee80211_csa_finish(arvif->vif, 0);
 			continue;
 		}
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 23ad6825e5be..4f7f73323579 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8268,7 +8268,7 @@ ath11k_wmi_process_csa_switch_count_event(struct ath11k_base *ab,
 		}
 
 		if (arvif->is_up && arvif->vif->bss_conf.csa_active)
-			ieee80211_csa_finish(arvif->vif);
+			ieee80211_csa_finish(arvif->vif, 0);
 	}
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ef0f3cf35cfd..108865abb7e8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6407,7 +6407,7 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 		}
 
 		if (arvif->is_up && arvif->vif->bss_conf.csa_active)
-			ieee80211_csa_finish(arvif->vif);
+			ieee80211_csa_finish(arvif->vif, 0);
 	}
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index ee72faac2f1d..4e48407138b2 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -368,7 +368,7 @@ bool ath9k_csa_is_finished(struct ath_softc *sc, struct ieee80211_vif *vif)
 	if (!ieee80211_beacon_cntdwn_is_complete(vif))
 		return false;
 
-	ieee80211_csa_finish(vif);
+	ieee80211_csa_finish(vif, 0);
 	return true;
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index 533471e69400..8179d35dc310 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -517,7 +517,7 @@ bool ath9k_htc_csa_is_finished(struct ath9k_htc_priv *priv)
 	if (!ieee80211_beacon_cntdwn_is_complete(vif))
 		return false;
 
-	ieee80211_csa_finish(vif);
+	ieee80211_csa_finish(vif, 0);
 
 	priv->csa_vif = NULL;
 	return true;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 06bbd6212df0..b69f8af47d14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1486,7 +1486,7 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 		}
 	} else if (!iwl_mvm_te_scheduled(&mvmvif->time_event_data)) {
 		/* we don't have CSA NoA scheduled yet, switch now */
-		ieee80211_csa_finish(csa_vif);
+		ieee80211_csa_finish(csa_vif, 0);
 		RCU_INIT_POINTER(mvm->csa_vif, NULL);
 	}
 }
@@ -1832,7 +1832,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 				      msecs_to_jiffies(IWL_MVM_CS_UNBLOCK_TX_TIMEOUT *
 						       csa_vif->bss_conf.beacon_int));
 
-		ieee80211_csa_finish(csa_vif);
+		ieee80211_csa_finish(csa_vif, 0);
 
 		rcu_read_unlock();
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index e1f6cea649c3..e07da17cd638 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -146,7 +146,7 @@ static void iwl_mvm_csa_noa_start(struct iwl_mvm *mvm)
 		goto out_unlock;
 	}
 
-	ieee80211_csa_finish(csa_vif);
+	ieee80211_csa_finish(csa_vif, 0);
 
 	rcu_read_unlock();
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 7a15ea8072e6..c2ce5bf0e630 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3961,7 +3961,8 @@ mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 
 static int
 mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-				struct cfg80211_csa_settings *params)
+				struct cfg80211_csa_settings *params,
+				unsigned int link_id)
 {
 	struct ieee_types_header *chsw_ie;
 	struct ieee80211_channel_sw_ie *channel_sw;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d158320bc15d..34faf6d3a5d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1556,7 +1556,7 @@ static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 void mt76_csa_finish(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8d745c9730c7..8b0d9f4b3f76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -353,7 +353,7 @@ static void
 mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active)
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 50ae7bf3af91..600471c76632 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -226,7 +226,7 @@ static void
 mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active)
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 4a30db49ef33..6b6c34b4219b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -325,7 +325,7 @@ static void
 mt7996_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active)
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/ti/wlcore/event.c b/drivers/net/wireless/ti/wlcore/event.c
index 1e082d039b82..2499dc908305 100644
--- a/drivers/net/wireless/ti/wlcore/event.c
+++ b/drivers/net/wireless/ti/wlcore/event.c
@@ -233,7 +233,7 @@ void wlcore_event_channel_switch(struct wl1271 *wl,
 			cancel_delayed_work(&wlvif->channel_switch_work);
 		} else {
 			set_bit(WLVIF_FLAG_BEACON_DISABLED, &wlvif->flags);
-			ieee80211_csa_finish(vif);
+			ieee80211_csa_finish(vif, 0);
 		}
 	}
 }
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index c7b4414cc6c3..8a94a3eb08ed 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2270,7 +2270,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	}
 
 	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, link_id);
 }
 
 static enum hrtimer_restart
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 72375eceb786..bce7102a439c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5462,12 +5462,13 @@ void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter);
 /**
  * ieee80211_csa_finish - notify mac80211 about channel switch
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO
  *
  * After a channel switch announcement was scheduled and the counter in this
  * announcement hits 1, this function must be called by the driver to
  * notify mac80211 that the channel can be changed.
  */
-void ieee80211_csa_finish(struct ieee80211_vif *vif);
+void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id);
 
 /**
  * ieee80211_beacon_cntdwn_is_complete - find out if countdown reached 1
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ac977aaad58e..250e03ad2d13 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1582,6 +1582,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		link->csa_block_tx = false;
 	}
 
+	wiphy_work_cancel(wiphy, &link->csa_finalize_work);
+
 	ieee80211_free_next_beacon(link);
 
 	/* turn off carrier for this interface and dependent VLANs */
@@ -3527,13 +3529,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 	return new_beacon;
 }
 
-void ieee80211_csa_finish(struct ieee80211_vif *vif)
+void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link_data;
+
+	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
+		return;
 
 	rcu_read_lock();
 
+	link_data = rcu_dereference(sdata->link[link_id]);
+	if (WARN_ON(!link_data)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* TODO: MBSSID with MLO changes */
 	if (vif->mbssid_tx_vif == vif) {
 		/* Trigger ieee80211_csa_finish() on the non-transmitting
 		 * interfaces when channel switch is received on
@@ -3552,7 +3565,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 					 &iter->deflink.csa_finalize_work);
 		}
 	}
-	wiphy_work_queue(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
+	wiphy_work_queue(local->hw.wiphy, &link_data->csa_finalize_work);
 
 	rcu_read_unlock();
 }
@@ -3570,20 +3583,21 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 }
 EXPORT_SYMBOL(ieee80211_channel_switch_disconnect);
 
-static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_after_csa_beacon(struct ieee80211_link_data *link_data,
 					  u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link_data->u.ap.next_beacon)
 			return -EINVAL;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
-					      sdata->deflink.u.ap.next_beacon,
+		err = ieee80211_assign_beacon(sdata, link_data,
+					      link_data->u.ap.next_beacon,
 					      NULL, NULL, changed);
-		ieee80211_free_next_beacon(&sdata->deflink);
+		ieee80211_free_next_beacon(link_data);
 
 		if (err < 0)
 			return err;
@@ -3612,6 +3626,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 {
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *link_conf = link_data->conf;
 	u64 changed = 0;
 	int err;
 
@@ -3633,22 +3648,21 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 		if (link_data->reserved_ready)
 			return 0;
 
-		return ieee80211_link_use_reserved_context(&sdata->deflink);
+		return ieee80211_link_use_reserved_context(link_data);
 	}
 
-	if (!cfg80211_chandef_identical(&link_data->conf->chandef,
+	if (!cfg80211_chandef_identical(&link_conf->chandef,
 					&link_data->csa_chandef))
 		return -EINVAL;
 
-	sdata->vif.bss_conf.csa_active = false;
+	link_conf->csa_active = false;
 
-	err = ieee80211_set_after_csa_beacon(sdata, &changed);
+	err = ieee80211_set_after_csa_beacon(link_data, &changed);
 	if (err)
 		return err;
 
-	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
-		sdata->vif.bss_conf.eht_puncturing =
-					sdata->vif.bss_conf.csa_punct_bitmap;
+	if (link_conf->eht_puncturing != link_conf->csa_punct_bitmap) {
+		link_conf->eht_puncturing = link_conf->csa_punct_bitmap;
 		changed |= BSS_CHANGED_EHT_PUNCTURING;
 	}
 
@@ -3676,7 +3690,8 @@ static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 
 	if (__ieee80211_csa_finalize(link_data)) {
-		sdata_info(sdata, "failed to finalize CSA, disconnecting\n");
+		sdata_info(sdata, "failed to finalize CSA on link %d, disconnecting\n",
+			   link_data->link_id);
 		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
 				    GFP_KERNEL);
 	}
@@ -3701,18 +3716,19 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 	ieee80211_csa_finalize(link);
 }
 
-static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_csa_beacon(struct ieee80211_link_data *link_data,
 				    struct cfg80211_csa_settings *params,
 				    u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	struct ieee80211_csa_settings csa = {};
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		sdata->deflink.u.ap.next_beacon =
+		link_data->u.ap.next_beacon =
 			cfg80211_beacon_dup(&params->beacon_after);
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link_data->u.ap.next_beacon)
 			return -ENOMEM;
 
 		/*
@@ -3738,7 +3754,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link_data);
 			return -EINVAL;
 		}
 
@@ -3748,11 +3764,11 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.n_counter_offsets_presp = params->n_counter_offsets_presp;
 		csa.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
+		err = ieee80211_assign_beacon(sdata, link_data,
 					      &params->beacon_csa, &csa,
 					      NULL, changed);
 		if (err < 0) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link_data);
 			return err;
 		}
 
@@ -3852,6 +3868,8 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_channel_switch ch_switch;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_data *link_data;
 	u64 changed = 0;
 	int err;
 
@@ -3866,16 +3884,20 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->wdev.cac_started)
 		return -EBUSY;
 
-	if (cfg80211_chandef_identical(&params->chandef,
-				       &sdata->vif.bss_conf.chandef))
+	link_data = wiphy_dereference(wiphy, sdata->link[link_id]);
+	if (!link_data)
+		return -ENOLINK;
+
+	link_conf = link_data->conf;
+
+	if (cfg80211_chandef_identical(&params->chandef, &link_conf->chandef))
 		return -EINVAL;
 
 	/* don't allow another channel switch if one is already active. */
-	if (sdata->vif.bss_conf.csa_active)
+	if (link_conf->csa_active)
 		return -EBUSY;
 
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
-					 lockdep_is_held(&local->hw.wiphy->mtx));
+	conf = wiphy_dereference(wiphy, link_conf->chanctx_conf);
 	if (!conf) {
 		err = -EBUSY;
 		goto out;
@@ -3899,7 +3921,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &params->chandef,
+	err = ieee80211_link_reserve_chanctx(link_data, &params->chandef,
 					     chanctx->mode,
 					     params->radar_required);
 	if (err)
@@ -3908,44 +3930,44 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	/* if reservation is invalid then this will fail */
 	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(&sdata->deflink);
+		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
 	}
 
 	/* if there is a color change in progress, abort it */
-	if (sdata->vif.bss_conf.color_change_active)
+	if (link_conf->color_change_active)
 		ieee80211_color_change_abort(sdata);
 
-	err = ieee80211_set_csa_beacon(sdata, params, &changed);
+	err = ieee80211_set_csa_beacon(link_data, params, &changed);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(&sdata->deflink);
+		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
 	}
 
-	if (params->punct_bitmap && !sdata->vif.bss_conf.eht_support)
+	if (params->punct_bitmap && link_conf->eht_support)
 		goto out;
 
-	sdata->deflink.csa_chandef = params->chandef;
-	sdata->deflink.csa_block_tx = params->block_tx;
-	sdata->vif.bss_conf.csa_active = true;
-	sdata->vif.bss_conf.csa_punct_bitmap = params->punct_bitmap;
+	link_data->csa_chandef = params->chandef;
+	link_data->csa_block_tx = params->block_tx;
+	link_conf->csa_active = true;
+	link_conf->csa_punct_bitmap = params->punct_bitmap;
 
-	if (sdata->deflink.csa_block_tx)
+	if (link_data->csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
-					  &sdata->deflink.csa_chandef, 0,
+					  &link_data->csa_chandef, link_id,
 					  params->count, params->block_tx,
-					  sdata->vif.bss_conf.csa_punct_bitmap);
+					  link_conf->csa_punct_bitmap);
 
 	if (changed) {
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-						  changed);
+		ieee80211_link_info_change_notify(sdata, link_data, changed);
+		/* link_id to be passed here? */
 		drv_channel_switch_beacon(sdata, &params->chandef);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
-		ieee80211_csa_finalize(&sdata->deflink);
+		ieee80211_csa_finalize(link_data);
 	}
 
 out:
-- 
2.17.1

