Return-Path: <linux-wireless+bounces-4876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8B87F577
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 03:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82E9282B52
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9595A70CCD;
	Tue, 19 Mar 2024 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fdopob5d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE46FE29
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815475; cv=none; b=OcmMTV+PC9/DPyeDR2auZawTEH1SUhqYxop5yGCvZZb1JcNSnJHOBFHKkS9j5wykAaEyajjsMuYcMFGEYjhDBCDl8nIcDE2KvtV2sK9Vi9FYPoM5mSYDumCMhNJVes6H179w5wGDpc00cklqNmrJd90LCBjtpFCyAWlQgww//24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815475; c=relaxed/simple;
	bh=qImercF9zK8SUkY7FBdkguatqRjXITXv2VlBgxgFDVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FIjSpaSEBGiiWmHQWYr3x7ycI/o+w6M6w3KDTucjg9IBM/vMUv4mUl2mZ1jgJS10H0Q4JdAzWOXfuIsF8ZZOaB6H2nJtPKXtsPvtZdWTW90YQbGOGg2G3YGAp0XeTYaKzmfQJ5CBQbD5xeiNt5BFICXiBqsvmVQTSq2+Lpe0m9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fdopob5d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J1fU5O024752;
	Tue, 19 Mar 2024 02:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Vk6at8d
	H12/gePTZr7/aAsXSkaDtgCz9Hs7axk9lPzQ=; b=fdopob5dBtJedwJnnr9OfGi
	hItLdoX/IAo/2ui88IGflJg0MxzFOnXrsWMWzLNWmhNcGfFdQb2SxD0cpEGZtDzy
	AxtMACXIPcG9qgiErX/KzWkcegzdzV2cxLkPQ9EwxxRWOhP4Z8Gxu81CIJrzAjg5
	eiSyJHxrODRhfiEgg/O8IoBD8INvP42Dn2sqU1z8qz4aLyxRMduVqvhVoBT/AHHQ
	JAR6Y1v0Sk16mN5k6LrP7OZPrBx8/1XWIOC9IbMQgpw+ivCRO1jG+rzFMJbt9WdD
	VkWTSLDFiWUGmKrdXkbm2NAABAdg8DIzfXsXYxNa42hmMrft1LvQeb4XmNz+ObA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxmtcsqt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 02:30:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J2UvZx015637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 02:30:58 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Mar 2024 19:30:55 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH] wifi: ath12k: add support to handle beacon miss for WCN7850
Date: Tue, 19 Mar 2024 10:30:32 +0800
Message-ID: <20240319023032.719-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y-kG5HTcFAvrvGTMK-HWX2K9DF0OXVy4
X-Proofpoint-GUID: Y-kG5HTcFAvrvGTMK-HWX2K9DF0OXVy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403190018

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
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 79 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/mac.h  |  2 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 34 +++++------
 drivers/net/wireless/ath/ath12k/wmi.h  |  3 +
 5 files changed, 98 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..9b82e98375aa 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -46,6 +46,7 @@
 #define ATH12K_SMBIOS_BDF_EXT_MAGIC "BDF_"
 
 #define ATH12K_INVALID_HW_MAC_ID	0xFF
+#define ATH12K_CONNECTION_LOSS_HZ	(3 * HZ)
 #define	ATH12K_RX_RATE_TABLE_NUM	320
 #define	ATH12K_RX_RATE_TABLE_11AX_NUM	576
 
@@ -256,6 +257,7 @@ struct ath12k_vif {
 	u32 aid;
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
+	struct delayed_work connection_loss_work;
 	int num_legacy_stations;
 	int rtscts_prot_mode;
 	int txpower;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 52a5fb8b03e9..67f1242412dd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1345,6 +1345,75 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
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
@@ -2517,7 +2586,7 @@ static void ath12k_bss_disassoc(struct ath12k *ar,
 
 	arvif->is_up = false;
 
-	/* TODO: cancel connection_loss_work */
+	cancel_delayed_work(&arvif->connection_loss_work);
 }
 
 static u32 ath12k_mac_get_rate_hw_value(int bitrate)
@@ -5774,10 +5843,8 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	arvif->vif = vif;
 
 	INIT_LIST_HEAD(&arvif->list);
-
-	/* Should we initialize any worker to handle connection loss indication
-	 * from firmware in sta mode?
-	 */
+	INIT_DELAYED_WORK(&arvif->connection_loss_work,
+			  ath12k_mac_vif_sta_connection_loss_work);
 
 	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
 		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
@@ -6020,6 +6087,8 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ar = ath12k_ah_to_ar(ah);
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
index 9d69a1769926..30de5ebde648 100644
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
index 2492082b4524..27904a4deb18 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4186,6 +4186,9 @@ struct wmi_peer_sta_kickout_event {
 	struct ath12k_wmi_mac_addr_params peer_macaddr;
 } __packed;
 
+#define WMI_ROAM_REASON_MASK		GENMASK(3, 0)
+#define WMI_ROAM_SUBNET_STATUS_MASK	GENMASK(5, 4)
+
 enum wmi_roam_reason {
 	WMI_ROAM_REASON_BETTER_AP = 1,
 	WMI_ROAM_REASON_BEACON_MISS = 2,

base-commit: a2a4cf3541db8066af7e6d4eb6e9e6445f6d9658
-- 
2.34.1


