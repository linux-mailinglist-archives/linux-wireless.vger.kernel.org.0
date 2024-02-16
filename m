Return-Path: <linux-wireless+bounces-3681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B8857FB1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E65B236A0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338312F377;
	Fri, 16 Feb 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tv28yeNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25312EBE7
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094806; cv=none; b=GFU/LhqCK1UzbrBVC0s0pSOylRVhJwGgOaVZSFmv4CQa/80+azaRVVe8uPV+qvmSRMHedPSndgAENH9U2MyenuYYtdVZvx4nlLk+s+J1ZvFfDKzMryPOKf3Gn2WPxZgPgjSSHNGjdzychupnc2zIPSos1l+fhggBcx/zJqUaFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094806; c=relaxed/simple;
	bh=L3Frt1sAlvzP0+vXFGyxXcQP1BRTyDqVS44KT/ZhMu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKUFGBiZKjjM67na8+i54lVKf+WXHPvXcQxavzgh0I1H6/5OUaA9DUDt6Fu497cQyDBL9AjfYu63/mD07cVp7NxpIZyR/l4ua1nRT/lyUb8mLUgbsIZuKqVPkIxXix+AAFa91/Ln+Q3s2E9koGOIvxvMJuX4QIEzXt7qljTdkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tv28yeNV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GAciS4012076;
	Fri, 16 Feb 2024 14:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=NkknhrwVhBJuRU/2AEnFLKIJ5eRHIeSAQqL6KeWWGlc=; b=Tv
	28yeNVGCKfE8Wq5/RT3wZdAsZAEOr6WO3BIYnS0BQevxXrJKRiGXl9PzQZxMOnq0
	tMAmuz6h+BNas8NeifVUGx31GtsGhi+I705HFTLH/mgfM8oPnhsiNTrXErRAAjao
	O8jQlFp3yYCZnfecpav600c0CptJhcqGaFgujZyXsrUGovH8/6/qwyBQqlRBkTaq
	H6uniUkiUWdyebOIdrrzOT+4XBpjGjbAi4vGHoF+dCBvYK+NnM+vybjcOaxOiOb+
	GMhmweKYJ001fP6GiKGJygDKXw4lXvDK5XdEjPhlj0kP7MwXBcmjuPJpQnGywqyS
	dMbF3/K9SyEbtmFaTqVg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xdx98b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:46:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GEkesr001452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:46:40 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 06:46:37 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v3 1/2] wifi: mac80211: check beacon countdown is complete on per link basis
Date: Fri, 16 Feb 2024 20:16:20 +0530
Message-ID: <20240216144621.514385-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240216144621.514385-1-quic_adisi@quicinc.com>
References: <20240216144621.514385-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5NcvEctMObPWUayBoBBuOzQoQxknywXe
X-Proofpoint-GUID: 5NcvEctMObPWUayBoBBuOzQoQxknywXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160118

Currently, function to check if beacon countdown is complete uses deflink
to fetch the beacon and check the counter. However, with MLO, there is
a need to check the counter for the beacon in a particular link.

Add support to use link_id in order to fetch the beacon from a particular
link data.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c              |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  2 +-
 drivers/net/wireless/ath/ath9k/beacon.c            |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  4 ++--
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  2 +-
 include/net/mac80211.h                             |  4 +++-
 net/mac80211/tx.c                                  | 14 ++++++++++++--
 12 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 41053219ee95..e322b528baaf 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2034,7 +2034,7 @@ static void ath10k_mac_vif_ap_csa_count_down(struct ath10k_vif *arvif)
 	if (!arvif->is_up)
 		return;
 
-	if (!ieee80211_beacon_cntdwn_is_complete(vif)) {
+	if (!ieee80211_beacon_cntdwn_is_complete(vif, 0)) {
 		ieee80211_beacon_update_cntdwn(vif, 0);
 
 		ret = ath10k_mac_setup_bcn_tmpl(arvif);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index ddf15717d504..2e9661f4bea8 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3884,7 +3884,7 @@ void ath10k_wmi_event_host_swba(struct ath10k *ar, struct sk_buff *skb)
 		 * actual channel switch is done
 		 */
 		if (arvif->vif->bss_conf.csa_active &&
-		    ieee80211_beacon_cntdwn_is_complete(arvif->vif)) {
+		    ieee80211_beacon_cntdwn_is_complete(arvif->vif, 0)) {
 			ieee80211_csa_finish(arvif->vif, 0);
 			continue;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f7cab50bdfd1..a1e2729582e8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1577,7 +1577,7 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 		return;
 
 	if (vif->bss_conf.color_change_active &&
-	    ieee80211_beacon_cntdwn_is_complete(vif)) {
+	    ieee80211_beacon_cntdwn_is_complete(vif, 0)) {
 		arvif->bcca_zero_sent = true;
 		ieee80211_color_change_finish(vif);
 		return;
diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index 4e48407138b2..b399a7926ef5 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -365,7 +365,7 @@ bool ath9k_csa_is_finished(struct ath_softc *sc, struct ieee80211_vif *vif)
 	if (!vif || !vif->bss_conf.csa_active)
 		return false;
 
-	if (!ieee80211_beacon_cntdwn_is_complete(vif))
+	if (!ieee80211_beacon_cntdwn_is_complete(vif, 0))
 		return false;
 
 	ieee80211_csa_finish(vif, 0);
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index 8179d35dc310..547634f82183 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -514,7 +514,7 @@ bool ath9k_htc_csa_is_finished(struct ath9k_htc_priv *priv)
 	if (!vif || !vif->bss_conf.csa_active)
 		return false;
 
-	if (!ieee80211_beacon_cntdwn_is_complete(vif))
+	if (!ieee80211_beacon_cntdwn_is_complete(vif, 0))
 		return false;
 
 	ieee80211_csa_finish(vif, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cc592e288188..123fe9bba982 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1466,7 +1466,7 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 
 	mvmvif->csa_countdown = true;
 
-	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
+	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif, 0)) {
 		int c = ieee80211_beacon_update_cntdwn(csa_vif, 0);
 
 		iwl_mvm_mac_ctxt_beacon_changed(mvm, csa_vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 89b1c7a87660..a59d264a11c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -156,7 +156,7 @@ static void iwl_mvm_csa_noa_start(struct iwl_mvm *mvm)
 	 * So we just do nothing here and the switch
 	 * will be performed on the last TBTT.
 	 */
-	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
+	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif, 0)) {
 		IWL_WARN(mvm, "CSA NOA started too early\n");
 		goto out_unlock;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8bf82755ca4c..758e380fdf1d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1613,7 +1613,7 @@ EXPORT_SYMBOL_GPL(mt76_get_sar_power);
 static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
+	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif, 0))
 		ieee80211_csa_finish(vif, 0);
 }
 
@@ -1638,7 +1638,7 @@ __mt76_csa_check(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!vif->bss_conf.csa_active)
 		return;
 
-	dev->csa_complete |= ieee80211_beacon_cntdwn_is_complete(vif);
+	dev->csa_complete |= ieee80211_beacon_cntdwn_is_complete(vif, 0);
 }
 
 void mt76_csa_check(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 66bf92c164c3..db5041d23938 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5739,7 +5739,7 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 	}
 
 	if (vif->bss_conf.csa_active) {
-		if (ieee80211_beacon_cntdwn_is_complete(vif)) {
+		if (ieee80211_beacon_cntdwn_is_complete(vif, 0)) {
 			ieee80211_csa_finish(vif, 0);
 			return;
 		}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 0554946ed30e..2ea11a86d920 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2305,7 +2305,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 			rcu_dereference(link_conf->chanctx_conf)->def.chan);
 	}
 
-	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
+	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif, link_id))
 		ieee80211_csa_finish(vif, link_id);
 }
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index fc223761e3af..25c892ea9eb3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5566,10 +5566,12 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id);
 /**
  * ieee80211_beacon_cntdwn_is_complete - find out if countdown reached 1
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO
  *
  * This function returns whether the countdown reached zero.
  */
-bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif);
+bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
+					 unsigned int link_id);
 
 /**
  * ieee80211_color_change_finish - notify mac80211 about color change
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f4be4af568be..6bf223e6cd1a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5095,9 +5095,11 @@ void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter)
 }
 EXPORT_SYMBOL(ieee80211_beacon_set_cntdwn);
 
-bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif)
+bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
+					 unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link;
 	struct beacon_data *beacon = NULL;
 	u8 *beacon_data;
 	size_t beacon_data_len;
@@ -5106,9 +5108,17 @@ bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif)
 	if (!ieee80211_sdata_running(sdata))
 		return false;
 
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return 0;
+
 	rcu_read_lock();
+
+	link = rcu_dereference(sdata->link[link_id]);
+	if (!link)
+		goto out;
+
 	if (vif->type == NL80211_IFTYPE_AP) {
-		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
+		beacon = rcu_dereference(link->u.ap.beacon);
 		if (WARN_ON(!beacon || !beacon->tail))
 			goto out;
 		beacon_data = beacon->tail;
-- 
2.25.1


