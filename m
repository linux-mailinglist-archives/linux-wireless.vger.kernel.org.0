Return-Path: <linux-wireless+bounces-2821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D28426AD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4699728CD79
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C9A6DD13;
	Tue, 30 Jan 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nWdS4p9w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C57317D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623797; cv=none; b=ZZC9efQnJbJhJAwu4S4PpisfMFoH15cfAUTX51C0uhlDjTAFBFxxjJhTX+h8uJk5yM2d3TFnXkE+rIBiYe+/f5McmyidttjC8unnd4WOLrHsOdX6YoDT/dkFkG6X40RkzlC6MZS5edI58M9FswBFJUqhsZpiO0yw2NoyqIpLD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623797; c=relaxed/simple;
	bh=Rp4jRhjNV4WzcE7Q1oU6MoQklcHC/wgHgBIqqNPXBaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1cafUE2vXKcvh0FMIHrwTrTHqBwP2nHZlXMTN+K9c46N4NPu7QEn9lo/8an/qgF3aCo/AaigNw1r0RcEczkkt5ewHFtQaJYHWc0qvBgITNcNgtOgAfPyGCNwlfkQTefoPeD0QATvbziNmtFU5ihNFQrT9X+fDWBFX2Wzs+KZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nWdS4p9w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UBWXjv008057;
	Tue, 30 Jan 2024 14:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9Jj0g3Uc6WsOXA0srHBV/Dve81qY8IqgT5qAPhLU/lU=; b=nW
	dS4p9w65ku8xahnrqaRHdbPsudRuen/6b8HP5YJ1sCnQIiJRpes1KB1LL1z2c0Ob
	NPqRZRY+09Kuj3d63phVvOjWwctQXzefJiEwHj3hVQEO5WkJwehpfaptMyvr1Q6F
	MNlxSTCGo9nrVttGkZvtdXHbndU+tHE8Vus7nKdLgLsEnGdIkDkyHD3rW1fJHG6p
	mQRo4CXGgW+Uc0qNUvWkQYiqYSy2uBkTM+cwGWtILh82fBUOlwKrnNuSv/eqYW5R
	0jK3AFtlT7JNVPazrXJntNDPRR9huzi5fk3biGJudk1OAnmAzZX21pCj7vXJ0oKe
	7GcR69ZO3G5/Utd6yJ3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxydh0fw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:09:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UE9pYt010482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:09:51 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 06:09:49 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v8 5/5] wifi: mac80211: add support to call csa_finish on a link
Date: Tue, 30 Jan 2024 19:39:18 +0530
Message-ID: <20240130140918.1172387-6-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130140918.1172387-1-quic_adisi@quicinc.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RDJ6bxNR1VxxdsW0UnXFQDP3QLAblPae
X-Proofpoint-GUID: RDJ6bxNR1VxxdsW0UnXFQDP3QLAblPae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300104

Currently ieee80211_csa_finish() function finalizes CSA by scheduling a
finalizing worker using the deflink. With MLO, there is a need to do it
on a given link basis.

Pass link ID of the link on which CSA needs to be finalized.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c             |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c             |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c             |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c             |  2 +-
 drivers/net/wireless/ath/ath9k/beacon.c           |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  4 ++--
 .../net/wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  2 +-
 drivers/net/wireless/ti/wlcore/event.c            |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c     |  2 +-
 include/net/mac80211.h                            |  3 ++-
 net/mac80211/cfg.c                                | 15 +++++++++++++--
 17 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e32e8c70986d..8847cfc6030e 100644
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
index 581c2d3fc534..57a94ffb12d7 100644
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
index aceab96bcb97..885d22ca6f2d 100644
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
index 403d892c0468..0a7664c0a672 100644
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
index ad70dea96a46..9ab79bedde3d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5536,12 +5536,13 @@ void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter);
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
index 4427259154e2..d3c637f12e26 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3543,13 +3543,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 	return new_beacon;
 }
 
-void ieee80211_csa_finish(struct ieee80211_vif *vif)
+void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link_data;
+
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
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
@@ -3568,7 +3579,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 					 &iter->deflink.csa_finalize_work);
 		}
 	}
-	wiphy_work_queue(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
+	wiphy_work_queue(local->hw.wiphy, &link_data->csa_finalize_work);
 
 	rcu_read_unlock();
 }
-- 
2.25.1


