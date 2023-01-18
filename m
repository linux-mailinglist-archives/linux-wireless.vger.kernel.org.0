Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BFD67210D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjARPUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 10:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjARPUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 10:20:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE4D3756D
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 07:16:43 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ICeqHj006008;
        Wed, 18 Jan 2023 15:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ENL/h4gBkYn+tyqsBpcPTU/POq+cVz/2oF1COEHH36U=;
 b=Znn7b8nYvk8x4JWubvVJ9NJJMoS3BcZpZf+TOnpbrWSeduwjLflS3vAJ94PKW11r1Oal
 m+UroIirYawVb9BNi6oFT7ZtXFcw5rQNI5q1K0w3XleBXEZrsEHl5YoobowRlvVZse0x
 adsUIyAj9pMdQoegij0WyLeiwTgG0hxECxF1DJ4HE6+pXwHQtrvsh2yv2B1ekRsG9Qtv
 WtDmsOlDQoZ55MvU0fWsGLXS+spSPLWg+WqhQX6NwIAd83oOHw9UW0hhS3IwJFXahOx8
 AgzEDdL1Mydp2ecoiENtCUOGDd/Q259HIHqHJJYOyudsL//TbkdUgDeKI8qULP7etMlS nQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n69dph6na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:16:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30IFGdnB031513
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:16:39 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 07:16:37 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 1/2] wifi: cfg80211/mac80211: add support for channel switch with MLO
Date:   Wed, 18 Jan 2023 20:46:03 +0530
Message-ID: <20230118151604.1278-2-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: R1amCVaoJednz5ev_aOCp-2oPSH5DCrr
X-Proofpoint-ORIG-GUID: R1amCVaoJednz5ev_aOCp-2oPSH5DCrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180129
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/wireless/ath/ath9k/beacon.c       |   2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   4 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   2 +-
 drivers/net/wireless/mac80211_hwsim.c         |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 drivers/net/wireless/ti/wlcore/event.c        |   2 +-
 include/net/cfg80211.h                        |   3 +-
 include/net/mac80211.h                        |   3 +-
 net/mac80211/cfg.c                            | 151 +++++++++++-------
 net/mac80211/ibss.c                           |   2 +-
 net/mac80211/ieee80211_i.h                    |   3 +-
 net/mac80211/mesh.c                           |   2 +-
 net/wireless/nl80211.c                        |   2 +-
 net/wireless/rdev-ops.h                       |   7 +-
 net/wireless/trace.h                          |  12 +-
 23 files changed, 133 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index ec8d5b29bc72..a1c17b9b4390 100644
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
index 980d4124fa28..d6204010fbe2 100644
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
index 2a8a3e3dcff6..a55805465168 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7655,7 +7655,7 @@ ath11k_wmi_process_csa_switch_count_event(struct ath11k_base *ab,
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
index aa791dbc3066..f281326cb357 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1328,7 +1328,7 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 		}
 	} else if (!iwl_mvm_te_scheduled(&mvmvif->time_event_data)) {
 		/* we don't have CSA NoA scheduled yet, switch now */
-		ieee80211_csa_finish(csa_vif);
+		ieee80211_csa_finish(csa_vif, 0);
 		RCU_INIT_POINTER(mvm->csa_vif, NULL);
 	}
 }
@@ -1618,7 +1618,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 				      msecs_to_jiffies(IWL_MVM_CS_UNBLOCK_TX_TIMEOUT *
 						       csa_vif->bss_conf.beacon_int));
 
-		ieee80211_csa_finish(csa_vif);
+		ieee80211_csa_finish(csa_vif, 0);
 
 		rcu_read_unlock();
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index e403a240a82f..92172b0b3e0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -139,7 +139,7 @@ static void iwl_mvm_csa_noa_start(struct iwl_mvm *mvm)
 		goto out_unlock;
 	}
 
-	ieee80211_csa_finish(csa_vif);
+	ieee80211_csa_finish(csa_vif, 0);
 
 	rcu_read_unlock();
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index c57c8903b7c0..c070f3572507 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2122,7 +2122,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	}
 
 	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, link_id);
 }
 
 static enum hrtimer_restart
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index bcd564dc3554..75a998a8144f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3960,7 +3960,8 @@ mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 
 static int
 mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-				struct cfg80211_csa_settings *params)
+				struct cfg80211_csa_settings *params,
+				unsigned int link_id)
 {
 	struct ieee_types_header *chsw_ie;
 	struct ieee80211_channel_sw_ie *channel_sw;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7fe7f68acc24..31cb802b67cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1497,7 +1497,7 @@ static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 void mt76_csa_finish(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 83f30305414d..370576b185d5 100644
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
index 37a3c1f082d9..c7c4a95f94ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -221,7 +221,7 @@ static void
 mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active)
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index a88fc7680b1a..a677061f6ad1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -324,7 +324,7 @@ static void
 mt7996_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active)
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/ti/wlcore/event.c b/drivers/net/wireless/ti/wlcore/event.c
index 46ab69eab26a..20717c8788b7 100644
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
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03d4f4deadae..ef5429ce3ccb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4547,7 +4547,8 @@ struct cfg80211_ops {
 
 	int	(*channel_switch)(struct wiphy *wiphy,
 				  struct net_device *dev,
-				  struct cfg80211_csa_settings *params);
+				  struct cfg80211_csa_settings *params,
+				  unsigned int link_id);
 
 	int     (*set_qos_map)(struct wiphy *wiphy,
 			       struct net_device *dev,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b5b80f943e82..d0010153f324 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5301,12 +5301,13 @@ void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter);
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
index 7f549862c83e..1d907863a36b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1488,6 +1488,13 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	mutex_unlock(&local->mtx);
 
+	/* The below work requires sdata lock which we have already acquired
+	 * here. But before that, it will check whether link_conf->csa_active
+	 * is true, which we have made false above. Hence, it will not proceed
+	 * to acquire the sdata lock and deadlock will be avoided.
+	 */
+	cancel_work_sync(&link->csa_finalize_work);
+
 	ieee80211_free_next_beacon(link);
 
 	/* turn off carrier for this interface and dependent VLANs */
@@ -3422,13 +3429,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 	return new_beacon;
 }
 
-void ieee80211_csa_finish(struct ieee80211_vif *vif)
+void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link;
+
+	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
+		return;
 
 	rcu_read_lock();
 
+	link = rcu_dereference(sdata->link[link_id]);
+	if (WARN_ON(!link)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* TODO: MBSSID with MLO changes */
 	if (vif->mbssid_tx_vif == vif) {
 		/* Trigger ieee80211_csa_finish() on the non-transmitting
 		 * interfaces when channel switch is received on
@@ -3447,7 +3465,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 					     &iter->deflink.csa_finalize_work);
 		}
 	}
-	ieee80211_queue_work(&local->hw, &sdata->deflink.csa_finalize_work);
+	ieee80211_queue_work(&local->hw, &link->csa_finalize_work);
 
 	rcu_read_unlock();
 }
@@ -3465,20 +3483,21 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 }
 EXPORT_SYMBOL(ieee80211_channel_switch_disconnect);
 
-static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_after_csa_beacon(struct ieee80211_link_data *link,
 					  u32 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link->u.ap.next_beacon)
 			return -EINVAL;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
-					      sdata->deflink.u.ap.next_beacon,
+		err = ieee80211_assign_beacon(sdata, link,
+					      link->u.ap.next_beacon,
 					      NULL, NULL);
-		ieee80211_free_next_beacon(&sdata->deflink);
+		ieee80211_free_next_beacon(link);
 
 		if (err < 0)
 			return err;
@@ -3506,9 +3525,11 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
+static int __ieee80211_csa_finalize(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *link_conf = link->conf;
 	u32 changed = 0;
 	int err;
 
@@ -3523,49 +3544,53 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	 * completed successfully
 	 */
 
-	if (sdata->deflink.reserved_chanctx) {
+	if (link->reserved_chanctx) {
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
 		 * reservations
 		 */
-		if (sdata->deflink.reserved_ready)
+		if (link->reserved_ready)
 			return 0;
 
-		return ieee80211_link_use_reserved_context(&sdata->deflink);
+		return ieee80211_link_use_reserved_context(link);
 	}
 
-	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
-					&sdata->deflink.csa_chandef))
+	if (!cfg80211_chandef_identical(&link_conf->chandef,
+					&link->csa_chandef))
 		return -EINVAL;
 
-	sdata->vif.bss_conf.csa_active = false;
+	link_conf->csa_active = false;
 
-	err = ieee80211_set_after_csa_beacon(sdata, &changed);
+	err = ieee80211_set_after_csa_beacon(link, &changed);
 	if (err)
 		return err;
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
+	ieee80211_link_info_change_notify(sdata, link, changed);
 
-	if (sdata->deflink.csa_block_tx) {
+	if (link->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->deflink.csa_block_tx = false;
+		link->csa_block_tx = false;
 	}
 
 	err = drv_post_channel_switch(sdata);
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &link->csa_chandef,
+				  link->link_id);
 
 	return 0;
 }
 
-static void ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
+static void ieee80211_csa_finalize(struct ieee80211_link_data *link)
 {
-	if (__ieee80211_csa_finalize(sdata)) {
-		sdata_info(sdata, "failed to finalize CSA, disconnecting\n");
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
+	if (__ieee80211_csa_finalize(link)) {
+		sdata_info(sdata, "failed to finalize CSA on link_id %d, disconnecting\n",
+			   link->link_id);
 		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
 				    GFP_KERNEL);
 	}
@@ -3573,42 +3598,47 @@ static void ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 
 void ieee80211_csa_finalize_work(struct work_struct *work)
 {
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data,
-			     deflink.csa_finalize_work);
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data,
+			     csa_finalize_work);
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *link_conf = link->conf;
 
-	sdata_lock(sdata);
 	mutex_lock(&local->mtx);
 	mutex_lock(&local->chanctx_mtx);
 
 	/* AP might have been stopped while waiting for the lock. */
-	if (!sdata->vif.bss_conf.csa_active)
+	if (!link_conf->csa_active)
 		goto unlock;
 
+	sdata_lock(sdata);
+
 	if (!ieee80211_sdata_running(sdata))
-		goto unlock;
+		goto unlock_all;
 
-	ieee80211_csa_finalize(sdata);
+	ieee80211_csa_finalize(link);
 
+unlock_all:
+	sdata_unlock(sdata);
 unlock:
 	mutex_unlock(&local->chanctx_mtx);
 	mutex_unlock(&local->mtx);
-	sdata_unlock(sdata);
 }
 
-static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_csa_beacon(struct ieee80211_link_data *link,
 				    struct cfg80211_csa_settings *params,
 				    u32 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_csa_settings csa = {};
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		sdata->deflink.u.ap.next_beacon =
+		link->u.ap.next_beacon =
 			cfg80211_beacon_dup(&params->beacon_after);
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link->u.ap.next_beacon)
 			return -ENOMEM;
 
 		/*
@@ -3634,7 +3664,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link);
 			return -EINVAL;
 		}
 
@@ -3644,13 +3674,14 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.n_counter_offsets_presp = params->n_counter_offsets_presp;
 		csa.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
+		err = ieee80211_assign_beacon(sdata, link,
 					      &params->beacon_csa, &csa,
 					      NULL);
 		if (err < 0) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link);
 			return err;
 		}
+
 		*changed |= err;
 
 		break;
@@ -3743,13 +3774,16 @@ static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 
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
+	struct ieee80211_link_data *link;
 	u32 changed = 0;
 	int err;
 
@@ -3762,16 +3796,21 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->wdev.cac_started)
 		return -EBUSY;
 
-	if (cfg80211_chandef_identical(&params->chandef,
-				       &sdata->vif.bss_conf.chandef))
+	link = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link)
+		return -ENOLINK;
+
+	link_conf = link->conf;
+
+	if (cfg80211_chandef_identical(&params->chandef, &link_conf->chandef))
 		return -EINVAL;
 
 	/* don't allow another channel switch if one is already active. */
-	if (sdata->vif.bss_conf.csa_active)
+	if (link_conf->csa_active)
 		return -EBUSY;
 
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(link_conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf) {
 		err = -EBUSY;
@@ -3796,7 +3835,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &params->chandef,
+	err = ieee80211_link_reserve_chanctx(link, &params->chandef,
 					     chanctx->mode,
 					     params->radar_required);
 	if (err)
@@ -3805,39 +3844,40 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	/* if reservation is invalid then this will fail */
 	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(&sdata->deflink);
+		ieee80211_link_unreserve_chanctx(link);
 		goto out;
 	}
 
 	/* if there is a color change in progress, abort it */
-	if (sdata->vif.bss_conf.color_change_active)
+	if (link_conf->color_change_active)
 		ieee80211_color_change_abort(sdata);
 
-	err = ieee80211_set_csa_beacon(sdata, params, &changed);
+	err = ieee80211_set_csa_beacon(link, params, &changed);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(&sdata->deflink);
+		ieee80211_link_unreserve_chanctx(link);
 		goto out;
 	}
 
-	sdata->deflink.csa_chandef = params->chandef;
-	sdata->deflink.csa_block_tx = params->block_tx;
-	sdata->vif.bss_conf.csa_active = true;
+	link->csa_chandef = params->chandef;
+	link->csa_block_tx = params->block_tx;
+	link_conf->csa_active = true;
 
-	if (sdata->deflink.csa_block_tx)
+	if (link->csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
-					  &sdata->deflink.csa_chandef, 0,
+					  &link->csa_chandef, link_id,
 					  params->count, params->block_tx);
 
 	if (changed) {
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+		ieee80211_link_info_change_notify(sdata, link,
 						  changed);
+		/* link_id to be passed here? */
 		drv_channel_switch_beacon(sdata, &params->chandef);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
-		ieee80211_csa_finalize(sdata);
+		ieee80211_csa_finalize(link);
 	}
 
 out:
@@ -3846,14 +3886,15 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 }
 
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			     struct cfg80211_csa_settings *params)
+			     struct cfg80211_csa_settings *params,
+			     unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 	int err;
 
 	mutex_lock(&local->mtx);
-	err = __ieee80211_channel_switch(wiphy, dev, params);
+	err = __ieee80211_channel_switch(wiphy, dev, params, link_id);
 	mutex_unlock(&local->mtx);
 
 	return err;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 9dffc3079588..d4e47d02f02c 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -886,7 +886,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	params.block_tx = !!csa_ie.mode;
 
 	if (ieee80211_channel_switch(sdata->local->hw.wiphy, sdata->dev,
-				     &params))
+				     &params, 0))
 		goto disconnect;
 
 	ieee80211_ibss_csa_mark_radar(sdata);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d16606e84e22..a5af8bd32e5b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1925,7 +1925,8 @@ int ieee80211_mgmt_tx_cancel_wait(struct wiphy *wiphy,
 /* channel switch handling */
 void ieee80211_csa_finalize_work(struct work_struct *work);
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			     struct cfg80211_csa_settings *params);
+			     struct cfg80211_csa_settings *params,
+			     unsigned int link_id);
 
 /* color change handling */
 void ieee80211_color_change_finalize_work(struct work_struct *work);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5a99b8f6e465..42f0eb18e13b 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1232,7 +1232,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_REPEATER;
 
 	if (ieee80211_channel_switch(sdata->local->hw.wiphy, sdata->dev,
-				     &params) < 0)
+				     &params, 0) < 0)
 		return false;
 
 	return true;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33a82ecab9d5..3dec07da91ca 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10058,7 +10058,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		params.block_tx = true;
 
 	wdev_lock(wdev);
-	err = rdev_channel_switch(rdev, dev, &params);
+	err = rdev_channel_switch(rdev, dev, &params, link_id);
 	wdev_unlock(wdev);
 
 free:
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 13b209a8db28..60233107d27b 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1086,12 +1086,13 @@ static inline void rdev_crit_proto_stop(struct cfg80211_registered_device *rdev,
 
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
index a405c3edbc47..2ac4855976e9 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2297,8 +2297,9 @@ TRACE_EVENT(rdev_crit_proto_stop,
 
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
@@ -2308,6 +2309,7 @@ TRACE_EVENT(rdev_channel_switch,
 		__field(u8, count)
 		__dynamic_array(u16, bcn_ofs, params->n_counter_offsets_beacon)
 		__dynamic_array(u16, pres_ofs, params->n_counter_offsets_presp)
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2325,11 +2327,13 @@ TRACE_EVENT(rdev_channel_switch,
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

