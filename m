Return-Path: <linux-wireless+bounces-6208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D218A23EB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 04:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF111C208F2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 02:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA810957;
	Fri, 12 Apr 2024 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YlOYmswA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66A17F5
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890339; cv=none; b=Uj36m5ZUmJdVRxnGqUhVd3AU00lOFamYybu6s3HjHQfXzMZpPPQBe0aR4LXG2LoY1wbAsVorSuY9tHBmvpSH/tyZk5tcRe3HOfDxrtOMwcMmG2DYfpaWxadMxWGrBhQZsii5WvATFtMOL4PKEPtdUIcjh1zgvMB5qAOm3cMBmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890339; c=relaxed/simple;
	bh=ki0MslnTkE7Sax90SawRogPVJZ5/L+J6GwOO7h2SikI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UoQfJI/jnjviZnxQxuJEghJ6qbj0JBuwYuEdLHOkmWZA1gM9XajhMGIM+RwtePj3iX3P8PSdx5qe1Hx+yYv7kbWQx/P0Cli/Jgo6cYmBNn7vUZe+s4xgFHNmCt8QA9uPkuc7ZzCd6hXeGrPuxv1Bj6ytUmOR4aqkmypqepkmCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YlOYmswA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C0g7qM026629;
	Fri, 12 Apr 2024 02:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=G1zmxMa
	P2AI1KYP0mqY2mYlwn4SIfXBNAbvFcvD36sg=; b=YlOYmswAr8Uj9zqqoutnSzu
	IRQd2Gm5XT7icNVUok4/gq8xuGS4x9CKBc1f7NlefPfwXbBZmiuJeL9hCBB+7Dx2
	bB+PcQz0cjLnlwsafG7PlbneNF6p5YEbxn905F8UuBHgQ8ou73aIvW6TtzTHNJ2c
	Iy9jIuMXewlC4vNBPKr0JbctfR5Gt7I0UzXa2HP+sM847oLApHdHYOZS4LvfVXiv
	1EsXjvMuXy1mnczdby5G1HVHab5LbCI6AAtNZha3nF/3CHzuvVwf+hoFqXD/e7wI
	N2tshRpO6XsQ1Rvw0pt016IctiQvCQz67L4eFJkdUDmF7JJ+ArpsiEfD9HSnwRg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xer070ejb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 02:52:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C2qCKC026256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 02:52:12 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 19:52:10 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: add support to handle beacon miss for WCN7850
Date: Fri, 12 Apr 2024 10:51:49 +0800
Message-ID: <20240412025149.1211-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: kPpqAJNgX4kc4RetuhQ7QMhSr5WQWgVo
X-Proofpoint-GUID: kPpqAJNgX4kc4RetuhQ7QMhSr5WQWgVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120019

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

v2: rebased on latest tag: ath-202404101413.

---
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 97 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h  |  2 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 34 ++++-----
 drivers/net/wireless/ath/ath12k/wmi.h  |  3 +
 5 files changed, 110 insertions(+), 28 deletions(-)

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
index f15dcd75157d..decd7f2840d5 100644
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
@@ -5986,6 +6055,20 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	lockdep_assert_held(&ar->conf_mutex);
 
 	arvif->ar = ar;
+	arvif->vif = vif;
+
+	INIT_LIST_HEAD(&arvif->list);
+	INIT_DELAYED_WORK(&arvif->connection_loss_work,
+			  ath12k_mac_vif_sta_connection_loss_work);
+
+	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
+		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
+		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
+		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
+	}
+
 	vdev_id = __ffs64(ab->free_vdev_map);
 	arvif->vdev_id = vdev_id;
 	arvif->vdev_subtype = WMI_VDEV_SUBTYPE_NONE;
@@ -6316,16 +6399,6 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	arvif->vif = vif;
 
-	INIT_LIST_HEAD(&arvif->list);
-
-	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
-		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
-		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
-		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
-	}
-
 	/* Allocate Default Queue now and reassign during actual vdev create */
 	vif->cab_queue = ATH12K_HW_DEFAULT_QUEUE;
 	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
@@ -6451,6 +6524,8 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
+	cancel_delayed_work_sync(&arvif->connection_loss_work);
+
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
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


