Return-Path: <linux-wireless+bounces-6365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CCA8A62B4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD79A1C21809
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E3381C4;
	Tue, 16 Apr 2024 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TSjgKGYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BF3839D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243624; cv=none; b=QPa6+mEEIWTnDrEWxA3zd3oR7kk4ZwBpzUjvWzbdvnDh3xwxRovjLLULFxf0elp4SecMvkRcXVTWyUT+m2CJwTO9xW/uRHEHQQdaeeFVtIllJ+WSp1FLOHE+xTvavFJPTD46R5o4C6vjzdB1TNhWTqKD0Lppf7kkH0gQsmzCdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243624; c=relaxed/simple;
	bh=T3siPaHYfAJAnMDULOIyViw5MqCb9DFB/92xb+UGgPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSTV3xdEAmedLguK0WvUHm849nLu/IgqTLu3MICICtydVaI4Qsm06zecl6kLSJKA+n3RfFlmcsqlnpBTdAaRVYCuInxvxJNUJCG6h61byQrK91LauuWlkT1PGC5gm/SYanqCf8JR5PwH84Tt5oNlLsGTB3n8x0HW64F4JY8S4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TSjgKGYL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G2FWrj031887;
	Tue, 16 Apr 2024 05:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=AGpAkcuwbU8DK4OYdf1TBbxfwS9h075hrUKnuLy3KMU=; b=TS
	jgKGYLywvzwWPu9MA6KD+SO3Ifl9v+vyjL8DRIRn6nma6dXy60jOHqQw/VeyVibU
	gGPM+C7m0BmnLX/2mHFdTnuNK5J+kGNhYFPf4e8zsnlQ1LoCRtBsDeOYPMbl1U1D
	Sk7sfMSITR3gWvIcnmwvUs1xf4UuyECkllLCGGwO/rMVWvYO8UFAa4OjE5MXu8yQ
	XiYPhgRlB/HydIex6IHvtGkxquQ8kSW5JDk4cKzRCpBFOoBeD3JwtsRTCk7p7VhT
	a+5Wy7bFTZQCOzlsPLYJfy0+rg39XnnWCbb7C75iFtmC7NE1G2TY4EghH/MPlakN
	iTp2d4Y4OysNEmgxXeZw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh8v5h58s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G50DCW000401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:13 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 22:00:11 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 6/7] wifi: mac80211: add support to call color_change and OBSS collision on a link
Date: Tue, 16 Apr 2024 10:29:42 +0530
Message-ID: <20240416045943.576656-7-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416045943.576656-1-quic_adisi@quicinc.com>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: Ii-XIcrHoNibJ3hiLV3jYObYbpHaCQAU
X-Proofpoint-ORIG-GUID: Ii-XIcrHoNibJ3hiLV3jYObYbpHaCQAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160028

Currently ieee80211_color_change_finish() function finalizes color change
by scheduling a finalizing worker using the deflink. Similarly, function
ieee80211_obss_color_collision_notify() notifies the mac80211 about color
collision on deflink. With MLO, there is a need to do it on a given link
basis.

Pass link ID of the link on which color change needs to be finalized or
OBSS color collision is detected.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 include/net/mac80211.h                        |  6 ++-
 net/mac80211/cfg.c                            | 37 ++++++++++++++++---
 net/mac80211/rx.c                             |  7 ++--
 7 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c32be587000d..40c3ba6c445b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1659,7 +1659,7 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 	if (vif->bss_conf.color_change_active &&
 	    ieee80211_beacon_cntdwn_is_complete(vif, 0)) {
 		arvif->bcca_zero_sent = true;
-		ieee80211_color_change_finish(vif);
+		ieee80211_color_change_finish(vif, 0);
 		return;
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c74aa3f95658..3761dfce1f64 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4064,7 +4064,8 @@ ath11k_wmi_obss_color_collision_event(struct ath11k_base *ab, struct sk_buff *sk
 
 	switch (ev->evt_type) {
 	case WMI_BSS_COLOR_COLLISION_DETECTION:
-		ieee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap);
+		ieee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap,
+						      0);
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "OBSS color collision detected vdev:%d, event:%d, bitmap:%08llx\n",
 			   ev->vdev_id, ev->evt_type, ev->obss_color_bitmap);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d90f98c50039..6442e3e5d45b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -331,7 +331,7 @@ mt7915_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!vif->bss_conf.color_change_active || vif->type == NL80211_IFTYPE_STATION)
 		return;
 
-	ieee80211_color_change_finish(vif);
+	ieee80211_color_change_finish(vif, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index b44abe2acc81..163b822a477c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -418,7 +418,7 @@ mt7996_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!vif->bss_conf.color_change_active || vif->type == NL80211_IFTYPE_STATION)
 		return;
 
-	ieee80211_color_change_finish(vif);
+	ieee80211_color_change_finish(vif, 0);
 }
 
 static void
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 41f135a793ab..6be62cc2caf6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5612,12 +5612,13 @@ bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
 /**
  * ieee80211_color_change_finish - notify mac80211 about color change
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO
  *
  * After a color change announcement was scheduled and the counter in this
  * announcement hits 1, this function must be called by the driver to
  * notify mac80211 that the color can be changed
  */
-void ieee80211_color_change_finish(struct ieee80211_vif *vif);
+void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id);
 
 /**
  * ieee80211_proberesp_get - retrieve a Probe Response template
@@ -7530,6 +7531,7 @@ ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
 /**
  * ieee80211_obss_color_collision_notify - notify userland about a BSS color
  * collision.
+ * @link_id: valid link_id during MLO or 0 for non-MLO
  *
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @color_bitmap: a 64 bit bitmap representing the colors that the local BSS is
@@ -7537,7 +7539,7 @@ ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
  */
 void
 ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
-				      u64 color_bitmap);
+				      u64 color_bitmap, u8 link_id);
 
 /**
  * ieee80211_is_tx_data - check if frame is a data frame
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fcba6d28ea36..d654b1900252 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4820,23 +4820,48 @@ void ieee80211_color_collision_detection_work(struct work_struct *work)
 					     link->link_id);
 }
 
-void ieee80211_color_change_finish(struct ieee80211_vif *vif)
+void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link;
+
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return;
+
+	rcu_read_lock();
+
+	link = rcu_dereference(sdata->link[link_id]);
+	if (WARN_ON(!link)) {
+		rcu_read_unlock();
+		return;
+	}
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
-			 &sdata->deflink.color_change_finalize_work);
+			 &link->color_change_finalize_work);
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(ieee80211_color_change_finish);
 
 void
 ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
-				      u64 color_bitmap)
+				      u64 color_bitmap, u8 link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_link_data *link = &sdata->deflink;
+	struct ieee80211_link_data *link;
 
-	if (sdata->vif.bss_conf.color_change_active || sdata->vif.bss_conf.csa_active)
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return;
+
+	rcu_read_lock();
+
+	link = rcu_dereference(sdata->link[link_id]);
+	if (WARN_ON(!link)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (link->conf->color_change_active || link->conf->csa_active)
 		return;
 
 	if (delayed_work_pending(&link->color_collision_detect_work))
@@ -4849,6 +4874,8 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 	ieee80211_queue_delayed_work(&sdata->local->hw,
 				     &link->color_collision_detect_work,
 				     msecs_to_jiffies(500));
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(ieee80211_obss_color_collision_notify);
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4b4cbd8bf35d..e2b561a9a751 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3361,7 +3361,7 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 	if (ieee80211_hw_check(&rx->local->hw, DETECTS_COLOR_COLLISION))
 		return;
 
-	if (rx->sdata->vif.bss_conf.csa_active)
+	if (rx->link->conf->csa_active)
 		return;
 
 	baselen = mgmt->u.beacon.variable - rx->skb->data;
@@ -3373,7 +3373,7 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 				    rx->skb->len - baselen);
 	if (ie && ie->datalen >= sizeof(struct ieee80211_he_operation) &&
 	    ie->datalen >= ieee80211_he_oper_size(ie->data + 1)) {
-		struct ieee80211_bss_conf *bss_conf = &rx->sdata->vif.bss_conf;
+		struct ieee80211_bss_conf *bss_conf = rx->link->conf;
 		const struct ieee80211_he_operation *he_oper;
 		u8 color;
 
@@ -3386,7 +3386,8 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
 		if (color == bss_conf->he_bss_color.color)
 			ieee80211_obss_color_collision_notify(&rx->sdata->vif,
-							      BIT_ULL(color));
+							      BIT_ULL(color),
+							      bss_conf->link_id);
 	}
 }
 
-- 
2.25.1


