Return-Path: <linux-wireless+bounces-6236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492B88A2B78
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01525284512
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 09:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800551C36;
	Fri, 12 Apr 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iqFkaG7W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E885029E
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915117; cv=none; b=t+wKr21wFJfBm41KOFf4b+J9q8khKcAZTh1p9b3WftwqnGi82EpmFtv6E9njg7+GH16kOkq3a14Z9YuXoiTZKeFI5KLeGS+SztGExqB9to9QI8yKByM6w3Evgf8qIuv+zTKzWol5BjdteSv5rOEx2Ge6ginuYdqN+AwZ8M4bLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915117; c=relaxed/simple;
	bh=Yp+f9zkpYM4JPsMVv1X6ks1bgkTGmT3iHlN9kSIuPW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dIjc4yNc+COsVLVNmg3gNKXhWTEMa2NdY6mQxyvvZYS4SohwiUKJpWsUYM6rjiJ2vqPwXh65TjSPMkHdxa76WCgS4be4YZGDpJGLb6xxon8Jmp3+HS3eC1nhTX4L/Be9NNr23vByVYfILUniSmA/FigZoOzxMIu1m3hAP/DZf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iqFkaG7W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C6AJ9p005779;
	Fri, 12 Apr 2024 09:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=yZSEwtp
	iKncEvtUZEUaB9E4qWaa7/BHVEHmQ7IL6Alc=; b=iqFkaG7W2iOXBt5dvOsemjC
	Ebdod7ZdViwxFYJCs2JcRLBbhRiIASaFqMjcIiGnAk3S2BstsSSedW/lDfansTSw
	YdxRWXRN2eTuY+fxKw9iVshhFVZp6KSWjQ/fQBxebmO6CJeWaA753ccvzERiYJ+r
	Hb3tq26U1YH4qJwOZOsWE9lDLa4S9KsJ49YTKy+0ebUFXTQjqmPxwWNixhbZEBF4
	wkCZk+e3G8p0e2eYEMa1MRrk4kIy+yXs6eYDnVeGXy5ulFM0IVdUNsevz9Yzkual
	/i06X2bx+k+eS5JMF0hrZ4ZE/amHxanHM8CBB9op96aRpQL1xPg4Ux1aGxC+qbA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeyev8dkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 09:45:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C9j62G007059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 09:45:06 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Apr 2024 02:45:05 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3] wifi: ath12k: add support to handle beacon miss for WCN7850
Date: Fri, 12 Apr 2024 17:44:47 +0800
Message-ID: <20240412094447.2063-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fxj9UfUehBY67ZXYVpjhDnVepsBsgAoM
X-Proofpoint-GUID: Fxj9UfUehBY67ZXYVpjhDnVepsBsgAoM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120070

From: Kang Yang <quic_kangyang@quicinc.com>

When AP goes down or too far away without indication to STA, beacon miss
will be detected. Then for WCN7850's firmware, it will use roam event
to send beacon miss to host.

If STA doesn't handle the beacon miss, will keep the fake connection
and unable to roam.

So add support for WCN7850 to trigger disconnection from AP when
receiving this event from firmware.

It has to be noted that beacon miss event notification for QCN9274
to be handled in a separate patch as it uses STA kickout WMI event
to notify beacon miss and the current STA kickout event is processed
as low_ack.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v3: move INIT_DELAYED_WORK to add_interface().
v2: rebased on latest tag: ath-202404101413.

---
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 75 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |  2 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 34 ++++++------
 drivers/net/wireless/ath/ath12k/wmi.h  |  3 ++
 5 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 397d8c973265..e125efe20dde 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -46,6 +46,7 @@
 #define ATH12K_SMBIOS_BDF_EXT_MAGIC "BDF_"
 
 #define ATH12K_INVALID_HW_MAC_ID	0xFF
+#define ATH12K_CONNECTION_LOSS_HZ	(3 * HZ)
 #define	ATH12K_RX_RATE_TABLE_NUM	320
 #define	ATH12K_RX_RATE_TABLE_11AX_NUM	576
 
@@ -275,6 +276,7 @@ struct ath12k_vif {
 	u32 aid;
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
+	struct delayed_work connection_loss_work;
 	int num_legacy_stations;
 	int rtscts_prot_mode;
 	int txpower;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f15dcd75157d..e8ce9b940753 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1398,6 +1398,75 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d up\n", arvif->vdev_id);
 }
 
+static void ath12k_mac_handle_beacon_iter(void *data, u8 *mac,
+					  struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = data;
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!ether_addr_equal(mgmt->bssid, vif->bss_conf.bssid))
+		return;
+
+	cancel_delayed_work(&arvif->connection_loss_work);
+}
+
+void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb)
+{
+	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   ath12k_mac_handle_beacon_iter,
+						   skb);
+}
+
+static void ath12k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
+					       struct ieee80211_vif *vif)
+{
+	u32 *vdev_id = data;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+
+	if (arvif->vdev_id != *vdev_id)
+		return;
+
+	if (!arvif->is_up)
+		return;
+
+	ieee80211_beacon_loss(vif);
+
+	/* Firmware doesn't report beacon loss events repeatedly. If AP probe
+	 * (done by mac80211) succeeds but beacons do not resume then it
+	 * doesn't make sense to continue operation. Queue connection loss work
+	 * which can be cancelled when beacon is received.
+	 */
+	ieee80211_queue_delayed_work(hw, &arvif->connection_loss_work,
+				     ATH12K_CONNECTION_LOSS_HZ);
+}
+
+void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id)
+{
+	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   ath12k_mac_handle_beacon_miss_iter,
+						   &vdev_id);
+}
+
+static void ath12k_mac_vif_sta_connection_loss_work(struct work_struct *work)
+{
+	struct ath12k_vif *arvif = container_of(work, struct ath12k_vif,
+						connection_loss_work.work);
+	struct ieee80211_vif *vif = arvif->vif;
+
+	if (!arvif->is_up)
+		return;
+
+	ieee80211_connection_loss(vif);
+}
+
 static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -2570,7 +2639,7 @@ static void ath12k_bss_disassoc(struct ath12k *ar,
 
 	arvif->is_up = false;
 
-	/* TODO: cancel connection_loss_work */
+	cancel_delayed_work(&arvif->connection_loss_work);
 }
 
 static u32 ath12k_mac_get_rate_hw_value(int bitrate)
@@ -6317,6 +6386,8 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	arvif->vif = vif;
 
 	INIT_LIST_HEAD(&arvif->list);
+	INIT_DELAYED_WORK(&arvif->connection_loss_work,
+			  ath12k_mac_vif_sta_connection_loss_work);
 
 	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
 		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
@@ -6449,6 +6520,8 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ar = arvif->ar;
 	ab = ar->ab;
 
+	cancel_delayed_work_sync(&arvif->connection_loss_work);
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 3f5e1be0dff9..bfc655a4dfce 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -78,4 +78,6 @@ enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw b
 enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
 int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable);
 int ath12k_mac_rfkill_config(struct ath12k *ar);
+void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
+void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a5575ce9eed4..4fe39e920902 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5927,10 +5927,8 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 		}
 	}
 
-	/* TODO: Pending handle beacon implementation
-	 *if (ieee80211_is_beacon(hdr->frame_control))
-	 *	ath12k_mac_handle_beacon(ar, skb);
-	 */
+	if (ieee80211_is_beacon(hdr->frame_control))
+		ath12k_mac_handle_beacon(ar, skb);
 
 	ath12k_dbg(ab, ATH12K_DBG_MGMT,
 		   "event mgmt rx skb %pK len %d ftype %02x stype %02x\n",
@@ -6137,42 +6135,44 @@ static void ath12k_roam_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_roam_event roam_ev = {};
 	struct ath12k *ar;
+	u32 vdev_id;
+	u8 roam_reason;
 
 	if (ath12k_pull_roam_ev(ab, skb, &roam_ev) != 0) {
 		ath12k_warn(ab, "failed to extract roam event");
 		return;
 	}
 
+	vdev_id = le32_to_cpu(roam_ev.vdev_id);
+	roam_reason = u32_get_bits(le32_to_cpu(roam_ev.reason),
+				   WMI_ROAM_REASON_MASK);
+
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
-		   "wmi roam event vdev %u reason 0x%08x rssi %d\n",
-		   roam_ev.vdev_id, roam_ev.reason, roam_ev.rssi);
+		   "wmi roam event vdev %u reason %d rssi %d\n",
+		   vdev_id, roam_reason, roam_ev.rssi);
 
 	rcu_read_lock();
-	ar = ath12k_mac_get_ar_by_vdev_id(ab, le32_to_cpu(roam_ev.vdev_id));
+	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
 	if (!ar) {
-		ath12k_warn(ab, "invalid vdev id in roam ev %d",
-			    roam_ev.vdev_id);
+		ath12k_warn(ab, "invalid vdev id in roam ev %d", vdev_id);
 		rcu_read_unlock();
 		return;
 	}
 
-	if (le32_to_cpu(roam_ev.reason) >= WMI_ROAM_REASON_MAX)
+	if (roam_reason >= WMI_ROAM_REASON_MAX)
 		ath12k_warn(ab, "ignoring unknown roam event reason %d on vdev %i\n",
-			    roam_ev.reason, roam_ev.vdev_id);
+			    roam_reason, vdev_id);
 
-	switch (le32_to_cpu(roam_ev.reason)) {
+	switch (roam_reason) {
 	case WMI_ROAM_REASON_BEACON_MISS:
-		/* TODO: Pending beacon miss and connection_loss_work
-		 * implementation
-		 * ath12k_mac_handle_beacon_miss(ar, vdev_id);
-		 */
+		ath12k_mac_handle_beacon_miss(ar, vdev_id);
 		break;
 	case WMI_ROAM_REASON_BETTER_AP:
 	case WMI_ROAM_REASON_LOW_RSSI:
 	case WMI_ROAM_REASON_SUITABLE_AP_FOUND:
 	case WMI_ROAM_REASON_HO_FAILED:
 		ath12k_warn(ab, "ignoring not implemented roam event reason %d on vdev %i\n",
-			    roam_ev.reason, roam_ev.vdev_id);
+			    roam_reason, vdev_id);
 		break;
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 78afc94a815d..ebf73ddcadc6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4182,6 +4182,9 @@ struct wmi_peer_sta_kickout_event {
 	struct ath12k_wmi_mac_addr_params peer_macaddr;
 } __packed;
 
+#define WMI_ROAM_REASON_MASK		GENMASK(3, 0)
+#define WMI_ROAM_SUBNET_STATUS_MASK	GENMASK(5, 4)
+
 enum wmi_roam_reason {
 	WMI_ROAM_REASON_BETTER_AP = 1,
 	WMI_ROAM_REASON_BEACON_MISS = 2,

base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
-- 
2.34.1


