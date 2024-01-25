Return-Path: <linux-wireless+bounces-2481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B8083C2F2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877F2290A4B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5C4F8AD;
	Thu, 25 Jan 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J7QlDphf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE24F8A5
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187570; cv=none; b=iNdHftHvg+HCdXv2PTZb+9vaEDXt1z7Y3Z3VtsYrlSoqci0hJ8QOJrpOfgUBWR396cYxJ7ZRPsvsrqfHHGwo4lqineFEzB/w8zmif5oUGRvcIzk7iVSZewsjM/W+YgwLjntTuOFkzDARSI9EzozI+fBM/+zTngLvWeezlRudRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187570; c=relaxed/simple;
	bh=LOVo47arA/oVmCIu3z4GRVdVC7N6YzKTtX3932Wbets=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8Y6rGfdm68wLL4IOTd/fQlgqLUKp1KEI/qbxiK9CesZFPmx03Dox1XiO83FA+cXYIFKjHMng2X6U0v7yek/wIIr/PK63lRDB/jnreI/DLvrU2ihBVGamVODsNBrduykM13yIfZ3CzAxRVntshiICK42w0ghdl39xkxReGcIXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J7QlDphf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P8i9Rv029574;
	Thu, 25 Jan 2024 12:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rwEnVVgVkEdTdnuXItpvd+rWCcfhuOIU+ptf0nEdPeg=; b=J7
	QlDphfAaCJLykQkYzgMWVfP55OPp68hLobVZbFHQUrw9BF0rjhC1LqiJCTzXHmvS
	QJBm3sQ440/6/bBMOKviW3A7eOj/l1bxBBUpTjY3MWBRz3lyCpXKjTHmouEse8YK
	VorSdg6DauseBNzFmBKNMCSVyxawUONNvG33j6klKqe71WGPWc1kEhzQUO4tB506
	7JZyluIYvqKxjxKZFRO5yqFWTzXOhO6IjugmMfChmLawnyD+7TtV/ty08Lc1XINv
	T+snY735DCr7IaWe6TRWLdyjuILvbdwobTdXIQMt3+IICjK42GD21UqfrlBzmD+L
	Rsg7M8lnAyV/Hk4LeX7Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumcwrphs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PCxNrR009164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:23 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 04:59:21 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 2/3] wifi: mac80211: add support for AP channel switch with MLO
Date: Thu, 25 Jan 2024 18:28:54 +0530
Message-ID: <20240125125855.827619-7-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125125855.827619-1-quic_adisi@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z3rIeWsrrF6AUp7whUI2BZQgL43fIpaR
X-Proofpoint-GUID: z3rIeWsrrF6AUp7whUI2BZQgL43fIpaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401250090

Currently, during channel switch, deflink (or link_id 0) is always
considered. However, with Multi-Link Operation (MLO), there is a
need to handle link specific data structures based on the actual
operational link_id during channel switch operation.

Hence, add support for the same. Non-MLO based operations will use
link_id as 0 or deflink member as applicable

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
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   2 +-
 drivers/net/wireless/ti/wlcore/event.c        |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   2 +-
 include/net/mac80211.h                        |   3 +-
 net/mac80211/cfg.c                            | 110 +++++++++++-------
 17 files changed, 86 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 090bcf148d0c..07c5c51ff7b2 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2047,7 +2047,7 @@ static void ath10k_mac_vif_ap_csa_count_down(struct ath10k_vif *arvif)
 			ath10k_warn(ar, "failed to update prb tmpl during csa: %d\n",
 				    ret);
 	} else {
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 88befe92f95d..7ba3ef805fc5 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3885,7 +3885,7 @@ void ath10k_wmi_event_host_swba(struct ath10k *ar, struct sk_buff *skb)
 		 */
 		if (arvif->vif->bss_conf.csa_active &&
 		    ieee80211_beacon_cntdwn_is_complete(arvif->vif)) {
-			ieee80211_csa_finish(arvif->vif);
+			ieee80211_csa_finish(arvif->vif, 0);
 			continue;
 		}
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8a65fa04b48d..3944a4d2e4d2 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8267,7 +8267,7 @@ ath11k_wmi_process_csa_switch_count_event(struct ath11k_base *ab,
 		}
 
 		if (arvif->is_up && arvif->vif->bss_conf.csa_active)
-			ieee80211_csa_finish(arvif->vif);
+			ieee80211_csa_finish(arvif->vif, 0);
 	}
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 11cc3005c0f9..d505aa8c2225 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6446,7 +6446,7 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
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
index c4f96125cf33..3b6819f75430 100644
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
index 218fdf1ed530..b2f9771ae713 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -168,7 +168,7 @@ static void iwl_mvm_csa_noa_start(struct iwl_mvm *mvm)
 		goto out_unlock;
 	}
 
-	ieee80211_csa_finish(csa_vif);
+	ieee80211_csa_finish(csa_vif, 0);
 
 	rcu_read_unlock();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8a3a90d1bfac..8bf82755ca4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1614,7 +1614,7 @@ static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, 0);
 }
 
 void mt76_csa_finish(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index ae34d019e588..c807bd8d928d 100644
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
index c67c4f6ca2aa..f1522c7f0597 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -228,7 +228,7 @@ mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!vif->bss_conf.csa_active || vif->type == NL80211_IFTYPE_STATION)
 		return;
 
-	ieee80211_csa_finish(vif);
+	ieee80211_csa_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 3c729b563edc..0eeaf428179b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -341,7 +341,7 @@ mt7996_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!vif->bss_conf.csa_active || vif->type == NL80211_IFTYPE_STATION)
 		return;
 
-	ieee80211_csa_finish(vif);
+	ieee80211_csa_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3b954c2fe448..6b01876e23f3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5737,7 +5737,7 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 
 	if (vif->bss_conf.csa_active) {
 		if (ieee80211_beacon_cntdwn_is_complete(vif)) {
-			ieee80211_csa_finish(vif);
+			ieee80211_csa_finish(vif, 0);
 			return;
 		}
 		schedule_delayed_work(&priv->update_beacon_work,
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
index a84340c2075f..a410ecdca6d1 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2285,7 +2285,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	}
 
 	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
-		ieee80211_csa_finish(vif);
+		ieee80211_csa_finish(vif, link_id);
 }
 
 static enum hrtimer_restart
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d400fe2e8668..850053ed2366 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5482,12 +5482,13 @@ void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter);
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
index 489dd97f5172..a5d1c7b043db 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1588,6 +1588,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		link->csa_block_tx = false;
 	}
 
+	wiphy_work_cancel(wiphy, &link->csa_finalize_work);
+
 	ieee80211_free_next_beacon(link);
 
 	/* turn off carrier for this interface and dependent VLANs */
@@ -3540,13 +3542,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
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
@@ -3565,7 +3578,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 					 &iter->deflink.csa_finalize_work);
 		}
 	}
-	wiphy_work_queue(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
+	wiphy_work_queue(local->hw.wiphy, &link_data->csa_finalize_work);
 
 	rcu_read_unlock();
 }
@@ -3583,20 +3596,21 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
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
@@ -3625,6 +3639,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 {
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *link_conf = link_data->conf;
 	u64 changed = 0;
 	int err;
 
@@ -3646,22 +3661,21 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
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
 
@@ -3689,7 +3703,8 @@ static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 
 	if (__ieee80211_csa_finalize(link_data)) {
-		sdata_info(sdata, "failed to finalize CSA, disconnecting\n");
+		sdata_info(sdata, "failed to finalize CSA on link %d, disconnecting\n",
+			   link_data->link_id);
 		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
 				    GFP_KERNEL);
 	}
@@ -3714,18 +3729,19 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
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
@@ -3751,7 +3767,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link_data);
 			return -EINVAL;
 		}
 
@@ -3761,11 +3777,11 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
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
 
@@ -3864,7 +3880,10 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_channel_switch ch_switch;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_data *link_data;
 	u64 changed = 0;
+	u8 link_id = params->link_id;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3875,16 +3894,23 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->wdev.cac_started)
 		return -EBUSY;
 
-	if (cfg80211_chandef_identical(&params->chandef,
-				       &sdata->vif.bss_conf.chandef))
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return -EINVAL;
+
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
@@ -3908,7 +3934,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &params->chandef,
+	err = ieee80211_link_reserve_chanctx(link_data, &params->chandef,
 					     chanctx->mode,
 					     params->radar_required);
 	if (err)
@@ -3917,44 +3943,44 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
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
2.25.1


