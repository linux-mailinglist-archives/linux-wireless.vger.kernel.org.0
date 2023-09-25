Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480A7AD756
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjIYL65 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYL6z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 07:58:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D9A3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 04:58:47 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PAao8C012430;
        Mon, 25 Sep 2023 11:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QoFbup8iknRWP8IWlSP1fjbCykKOBKWAbTlsdwBKimY=;
 b=KPG7ANwLOThQxZN5BftfMwNCOD8cY8VDYdDV19gb2m5T/dTyewLtRj0XhaMEiKO2/pb+
 M166nPaOcS0VC81GoDy+ws26H82XTs9yYXTGy0KkYyrBLkoHO/CHOVG4vD2rpF6o59rN
 Lfop44UKB2L+D2q+lv4IhCLdmr7WHUaK894Qesm70kQVCpA9gl3AR27VI8uQbIliJZBv
 fC7xGqWO2wUDOa2+m2HOAzP/ORNAbL/NmvWkLqw25RT+ib4cNDGr7Bv/9+T+dWwNi6wQ
 r4D9kt2NqdWn6G4VHieRdQAqGAZ0TXKVuGjYDOdilFuC1al3r3agHnnTI6QwquZf/6Oh Lw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9rddbpdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 11:58:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PBwgG6003683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 11:58:42 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 25 Sep 2023 04:58:40 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2 1/2] wifi: cfg80211/mac80211: add support for AP channel switch with MLO
Date:   Mon, 25 Sep 2023 17:28:21 +0530
Message-ID: <20230925115822.12131-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230925115822.12131-1-quic_adisi@quicinc.com>
References: <20230925115822.12131-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Sbv99VVf8lPbAypgTonfQrbjk1zXxS6T
X-Proofpoint-ORIG-GUID: Sbv99VVf8lPbAypgTonfQrbjk1zXxS6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/net/cfg80211.h                        |   3 +-
 include/net/mac80211.h                        |   3 +-
 net/mac80211/cfg.c                            | 113 +++++++++++-------
 net/mac80211/ibss.c                           |   2 +-
 net/mac80211/ieee80211_i.h                    |   3 +-
 net/mac80211/mesh.c                           |   2 +-
 net/wireless/nl80211.c                        |   2 +-
 net/wireless/rdev-ops.h                       |   7 +-
 net/wireless/trace.h                          |  12 +-
 24 files changed, 107 insertions(+), 73 deletions(-)

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
index 70473be42d7b..d96f94428a32 100644
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
index 36f2d2388ddd..08ac08879b6c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2270,7 +2270,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	}
 
 	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, link_id);
 }
 
 static enum hrtimer_restart
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9af714431b22..ba32036b078f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4743,7 +4743,8 @@ struct cfg80211_ops {
 
 	int	(*channel_switch)(struct wiphy *wiphy,
 				  struct net_device *dev,
-				  struct cfg80211_csa_settings *params);
+				  struct cfg80211_csa_settings *params,
+				  unsigned int link_id);
 
 	int     (*set_qos_map)(struct wiphy *wiphy,
 			       struct net_device *dev,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8d993f6ab919..6ecc54c61ae9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5452,12 +5452,13 @@ void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter);
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
index e751d4eba8f5..1467ccba900b 100644
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
 
@@ -3844,13 +3860,16 @@ static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 
 static int
 __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			   struct cfg80211_csa_settings *params)
+			   struct cfg80211_csa_settings *params,
+			   unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_channel_switch ch_switch;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_data *link_data;
 	u64 changed = 0;
 	int err;
 
@@ -3862,15 +3881,20 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->wdev.cac_started)
 		return -EBUSY;
 
-	if (cfg80211_chandef_identical(&params->chandef,
-				       &sdata->vif.bss_conf.chandef))
+	link_data = sdata_dereference(sdata->link[link_id], sdata);
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
+	conf = rcu_dereference_protected(link_conf->chanctx_conf,
 					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (!conf) {
 		err = -EBUSY;
@@ -3895,7 +3919,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &params->chandef,
+	err = ieee80211_link_reserve_chanctx(link_data, &params->chandef,
 					     chanctx->mode,
 					     params->radar_required);
 	if (err)
@@ -3904,44 +3928,44 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
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
@@ -3949,14 +3973,15 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 }
 
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			     struct cfg80211_csa_settings *params)
+			     struct cfg80211_csa_settings *params,
+			     unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return __ieee80211_channel_switch(wiphy, dev, params);
+	return __ieee80211_channel_switch(wiphy, dev, params, link_id);
 }
 
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local)
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index a7736acadf3c..c72449d0fe1a 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -871,7 +871,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	params.block_tx = !!csa_ie.mode;
 
 	if (ieee80211_channel_switch(sdata->local->hw.wiphy, sdata->dev,
-				     &params))
+				     &params, 0))
 		goto disconnect;
 
 	ieee80211_ibss_csa_mark_radar(sdata);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d5c5f865323c..bb954992bd3c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1928,7 +1928,8 @@ int ieee80211_mgmt_tx_cancel_wait(struct wiphy *wiphy,
 /* channel switch handling */
 void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			     struct cfg80211_csa_settings *params);
+			     struct cfg80211_csa_settings *params,
+			     unsigned int link_id);
 
 /* color change handling */
 void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 0d0fbae51b61..7e63ccea6c22 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1391,7 +1391,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_REPEATER;
 
 	if (ieee80211_channel_switch(sdata->local->hw.wiphy, sdata->dev,
-				     &params) < 0)
+				     &params, 0) < 0)
 		return false;
 
 	return true;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e64bf2a58b36..51700c3f841c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10241,7 +10241,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 	}
 
-	err = rdev_channel_switch(rdev, dev, &params);
+	err = rdev_channel_switch(rdev, dev, &params, link_id);
 
 free:
 	kfree(params.beacon_after.mbssid_ies);
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index c6a2c07e380b..bd1635cb7b53 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1099,12 +1099,13 @@ static inline void rdev_crit_proto_stop(struct cfg80211_registered_device *rdev,
 
 static inline int rdev_channel_switch(struct cfg80211_registered_device *rdev,
 				      struct net_device *dev,
-				      struct cfg80211_csa_settings *params)
+				      struct cfg80211_csa_settings *params,
+				      unsigned int link_id)
 {
 	int ret;
 
-	trace_rdev_channel_switch(&rdev->wiphy, dev, params);
-	ret = rdev->ops->channel_switch(&rdev->wiphy, dev, params);
+	trace_rdev_channel_switch(&rdev->wiphy, dev, params, link_id);
+	ret = rdev->ops->channel_switch(&rdev->wiphy, dev, params, link_id);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1557dc1d58e2..ee5134153ba1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2311,8 +2311,9 @@ TRACE_EVENT(rdev_crit_proto_stop,
 
 TRACE_EVENT(rdev_channel_switch,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_csa_settings *params),
-	TP_ARGS(wiphy, netdev, params),
+		 struct cfg80211_csa_settings *params,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, netdev, params, link_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
@@ -2322,6 +2323,7 @@ TRACE_EVENT(rdev_channel_switch,
 		__field(u8, count)
 		__dynamic_array(u16, bcn_ofs, params->n_counter_offsets_beacon)
 		__dynamic_array(u16, pres_ofs, params->n_counter_offsets_presp)
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2339,11 +2341,13 @@ TRACE_EVENT(rdev_channel_switch,
 			memcpy(__get_dynamic_array(pres_ofs),
 			       params->counter_offsets_presp,
 			       params->n_counter_offsets_presp * sizeof(u16));
+		__entry->link_id = link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT
-		  ", block_tx: %d, count: %u, radar_required: %d",
+		  ", block_tx: %d, count: %u, radar_required: %d link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
-		  __entry->block_tx, __entry->count, __entry->radar_required)
+		  __entry->block_tx, __entry->count, __entry->radar_required,
+		  __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_qos_map,
-- 
2.17.1

