Return-Path: <linux-wireless+bounces-8464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055C8FAA4E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 07:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A3D283A65
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E9713E40E;
	Tue,  4 Jun 2024 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fe78HAyh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A413DDB2
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480477; cv=none; b=Uo/muWUqmC0AKtvZ3D7hEEcDBYMX4RWHlKvOO66IvCBXyLuS4k7pG2qO6lTFdIolKZ8vW1wkbJ2OeflCsKDjVT7gyX+4EwKYZxckZivg0Tz5AAZv8rQyXZ5orii3xMnvB8E1FO/l7iE8zFbCo9Yij5aZzgY1wDxoDHU654jg/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480477; c=relaxed/simple;
	bh=aL5YdrdpYJ827KhP62nx6SGbw0aOWLcP+MaTNZFSbE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owimCiA6iXaNPDWa4UupOieYZTHv19/pz3w3MhLiGvhb1nI6ohmha6u0iTZqyI0/TAYvocpoB1eOwe+3Wn4Kp0L2dLxGAcRT7RVyMo9lVeWR1f4rsYzUJEZONGM6CvzFo+Rt+zR6przIXUy7AT54wEF5pQmdKD+yoiIaBK6ZniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fe78HAyh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4540EB7c028503;
	Tue, 4 Jun 2024 05:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D9R5/2nweCxjO8Gco9SUsnBQ+d0h+Lbl3greayJwnnw=; b=fe78HAyhGAMAa3Kv
	Yit+SCYFu1EAFoOCYGJ7VGJ/yOqUFfc5UL1YzFTJ4AeL8vBbfWcnwc4yNOneT4/S
	dVZQqtYm3B2mNM4uhZGXjGZ5bDF1BGA2yPhTUsdXHHcWIxRPkFEyYo373jiTcf29
	8HDtsJj0Gb+MQIHeWXhOsUuEjlCROlDXAkQI/l0n1KRUiN+KRFfLoWRefT6S6MGI
	BV4jB0GVI87BMxETtMWXGwZXNPoTMkBK8MuTzoipb9+qFktle2M+hHu99mmD6veC
	065ImFei8tclvpXNITVs8MopMajQV2BgNnQCBqdhulY4lZFgW/d8brlWaOUhKZpW
	gUZASQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d616p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 05:54:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4545sTRK016794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 05:54:29 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 22:54:28 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v4 7/8] wifi: ath12k: support GTK rekey offload
Date: Tue, 4 Jun 2024 13:54:06 +0800
Message-ID: <20240604055407.12506-8-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604055407.12506-1-quic_bqiang@quicinc.com>
References: <20240604055407.12506-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6qDQde-kqzyHBwAOirZdT5xPywqf8zlz
X-Proofpoint-GUID: 6qDQde-kqzyHBwAOirZdT5xPywqf8zlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040045

Host sets GTK related info to firmware before WoW is enabled, and
gets rekey replay_count and then disables GTK rekey when WoW quits.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   8 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  38 +++++++++
 drivers/net/wireless/ath/ath12k/wmi.c  | 112 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  39 +++++++++
 drivers/net/wireless/ath/ath12k/wow.c  |  46 +++++++++-
 5 files changed, 242 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 34c54295a35e..3508bc717195 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -230,6 +230,13 @@ struct ath12k_vif_cache {
 	u32 bss_conf_changed;
 };
 
+struct ath12k_rekey_data {
+	u8 kck[NL80211_KCK_LEN];
+	u8 kek[NL80211_KCK_LEN];
+	u64 replay_ctr;
+	bool enable_offload;
+};
+
 struct ath12k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -286,6 +293,7 @@ struct ath12k_vif {
 	u32 punct_bitmap;
 	bool ps;
 	struct ath12k_vif_cache *cache;
+	struct ath12k_rekey_data rekey_data;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e400a9a29e0e..7d7757ff5e51 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2837,6 +2837,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	}
 
 	arvif->is_up = true;
+	arvif->rekey_data.enable_offload = false;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "mac vdev %d up (associated) bssid %pM aid %d\n",
@@ -2884,6 +2885,8 @@ static void ath12k_bss_disassoc(struct ath12k *ar,
 
 	arvif->is_up = false;
 
+	memset(&arvif->rekey_data, 0, sizeof(arvif->rekey_data));
+
 	cancel_delayed_work(&arvif->connection_loss_work);
 }
 
@@ -8506,6 +8509,40 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct cfg80211_gtk_rekey_data *data)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_rekey_data *rekey_data = &arvif->rekey_data;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac set rekey data vdev %d\n",
+		   arvif->vdev_id);
+
+	mutex_lock(&ar->conf_mutex);
+
+	memcpy(rekey_data->kck, data->kck, NL80211_KCK_LEN);
+	memcpy(rekey_data->kek, data->kek, NL80211_KEK_LEN);
+
+	/* The supplicant works on big-endian, the firmware expects it on
+	 * little endian.
+	 */
+	rekey_data->replay_ctr = get_unaligned_be64(data->replay_ctr);
+
+	arvif->rekey_data.enable_offload = true;
+
+	ath12k_dbg_dump(ar->ab, ATH12K_DBG_MAC, "kck", NULL,
+			rekey_data->kck, NL80211_KCK_LEN);
+	ath12k_dbg_dump(ar->ab, ATH12K_DBG_MAC, "kek", NULL,
+			rekey_data->kck, NL80211_KEK_LEN);
+	ath12k_dbg_dump(ar->ab, ATH12K_DBG_MAC, "replay ctr", NULL,
+			&rekey_data->replay_ctr, sizeof(rekey_data->replay_ctr));
+
+	mutex_unlock(&ar->conf_mutex);
+}
+
 static const struct ieee80211_ops ath12k_ops = {
 	.tx				= ath12k_mac_op_tx,
 	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
@@ -8521,6 +8558,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.hw_scan                        = ath12k_mac_op_hw_scan,
 	.cancel_hw_scan                 = ath12k_mac_op_cancel_hw_scan,
 	.set_key                        = ath12k_mac_op_set_key,
+	.set_rekey_data	                = ath12k_mac_op_set_rekey_data,
 	.sta_state                      = ath12k_mac_op_sta_state,
 	.sta_set_txpwr			= ath12k_mac_op_sta_set_txpwr,
 	.sta_rc_update			= ath12k_mac_op_sta_rc_update,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index aa920af4310a..877ba231830b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7090,6 +7090,56 @@ static void ath12k_wmi_event_wow_wakeup_host(struct ath12k_base *ab, struct sk_b
 	complete(&ab->wow.wakeup_completed);
 }
 
+static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
+						struct sk_buff *skb)
+{
+	const struct wmi_gtk_offload_status_event *ev;
+	struct ath12k_vif *arvif;
+	__be64 replay_ctr_be;
+	u64 replay_ctr;
+	const void **tb;
+	int ret;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_GTK_OFFLOAD_STATUS_EVENT];
+	if (!ev) {
+		ath12k_warn(ab, "failed to fetch gtk offload status ev");
+		kfree(tb);
+		return;
+	}
+
+	rcu_read_lock();
+	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, le32_to_cpu(ev->vdev_id));
+	if (!arvif) {
+		rcu_read_unlock();
+		ath12k_warn(ab, "failed to get arvif for vdev_id:%d\n",
+			    le32_to_cpu(ev->vdev_id));
+		kfree(tb);
+		return;
+	}
+
+	replay_ctr = le64_to_cpu(ev->replay_ctr);
+	arvif->rekey_data.replay_ctr = replay_ctr;
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "wmi gtk offload event refresh_cnt %d replay_ctr %llu\n",
+		   le32_to_cpu(ev->refresh_cnt), replay_ctr);
+
+	/* supplicant expects big-endian replay counter */
+	replay_ctr_be = cpu_to_be64(replay_ctr);
+
+	ieee80211_gtk_rekey_notify(arvif->vif, arvif->bssid,
+				   (void *)&replay_ctr_be, GFP_ATOMIC);
+
+	rcu_read_unlock();
+
+	kfree(tb);
+}
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -7213,6 +7263,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_WOW_WAKEUP_HOST_EVENTID:
 		ath12k_wmi_event_wow_wakeup_host(ab, skb);
 		break;
+	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
+		ath12k_wmi_gtk_offload_status_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
@@ -7929,3 +7982,62 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
 
 	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
 }
+
+int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
+				 struct ath12k_vif *arvif, bool enable)
+{
+	struct ath12k_rekey_data *rekey_data = &arvif->rekey_data;
+	struct wmi_gtk_rekey_offload_cmd *cmd;
+	struct sk_buff *skb;
+	__le64 replay_ctr;
+	int len;
+
+	len = sizeof(*cmd);
+	skb =  ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_gtk_rekey_offload_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_GTK_OFFLOAD_CMD, sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(arvif->vdev_id);
+
+	if (enable) {
+		cmd->flags = cpu_to_le32(GTK_OFFLOAD_ENABLE_OPCODE);
+
+		/* the length in rekey_data and cmd is equal */
+		memcpy(cmd->kck, rekey_data->kck, sizeof(cmd->kck));
+		memcpy(cmd->kek, rekey_data->kek, sizeof(cmd->kek));
+
+		replay_ctr = cpu_to_le64(rekey_data->replay_ctr);
+		memcpy(cmd->replay_ctr, &replay_ctr,
+		       sizeof(replay_ctr));
+	} else {
+		cmd->flags = cpu_to_le32(GTK_OFFLOAD_DISABLE_OPCODE);
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "offload gtk rekey vdev: %d %d\n",
+		   arvif->vdev_id, enable);
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+}
+
+int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
+				 struct ath12k_vif *arvif)
+{
+	struct wmi_gtk_rekey_offload_cmd *cmd;
+	struct sk_buff *skb;
+	int len;
+
+	len = sizeof(*cmd);
+	skb =  ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_gtk_rekey_offload_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_GTK_OFFLOAD_CMD, sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(arvif->vdev_id);
+	cmd->flags = cpu_to_le32(GTK_OFFLOAD_REQUEST_STATUS_OPCODE);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "get gtk rekey vdev_id: %d\n",
+		   arvif->vdev_id);
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0542d599d33d..0188dc78139b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5377,6 +5377,41 @@ struct wmi_set_arp_ns_offload_cmd {
 	 */
 } __packed;
 
+#define GTK_OFFLOAD_OPCODE_MASK             0xFF000000
+#define GTK_OFFLOAD_ENABLE_OPCODE           0x01000000
+#define GTK_OFFLOAD_DISABLE_OPCODE          0x02000000
+#define GTK_OFFLOAD_REQUEST_STATUS_OPCODE   0x04000000
+
+#define GTK_OFFLOAD_KEK_BYTES       16
+#define GTK_OFFLOAD_KCK_BYTES       16
+#define GTK_REPLAY_COUNTER_BYTES    8
+#define WMI_MAX_KEY_LEN             32
+#define IGTK_PN_SIZE                6
+
+struct wmi_gtk_offload_status_event {
+	__le32 vdev_id;
+	__le32 flags;
+	__le32 refresh_cnt;
+	__le64 replay_ctr;
+	u8 igtk_key_index;
+	u8 igtk_key_length;
+	u8 igtk_key_rsc[IGTK_PN_SIZE];
+	u8 igtk_key[WMI_MAX_KEY_LEN];
+	u8 gtk_key_index;
+	u8 gtk_key_length;
+	u8 gtk_key_rsc[GTK_REPLAY_COUNTER_BYTES];
+	u8 gtk_key[WMI_MAX_KEY_LEN];
+} __packed;
+
+struct wmi_gtk_rekey_offload_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 flags;
+	u8 kek[GTK_OFFLOAD_KEK_BYTES];
+	u8 kck[GTK_OFFLOAD_KCK_BYTES];
+	u8 replay_ctr[GTK_REPLAY_COUNTER_BYTES];
+} __packed;
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5546,5 +5581,9 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
 			      struct ath12k_vif *arvif,
 			      struct wmi_arp_ns_offload_arg *offload,
 			      bool enable);
+int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
+				 struct ath12k_vif *arvif, bool enable);
+int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
+				 struct ath12k_vif *arvif);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 39092f71b6a2..85fe6a9dab37 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -21,7 +21,9 @@
 
 static const struct wiphy_wowlan_support ath12k_wowlan_support = {
 	.flags = WIPHY_WOWLAN_DISCONNECT |
-		 WIPHY_WOWLAN_MAGIC_PKT,
+		 WIPHY_WOWLAN_MAGIC_PKT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
+		 WIPHY_WOWLAN_GTK_REKEY_FAILURE,
 	.pattern_min_len = WOW_MIN_PATTERN_SIZE,
 	.pattern_max_len = WOW_MAX_PATTERN_SIZE,
 	.max_pkt_offset = WOW_MAX_PKT_OFFSET,
@@ -754,6 +756,41 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 	return 0;
 }
 
+static int ath12k_gtk_rekey_offload(struct ath12k *ar, bool enable)
+{
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type != WMI_VDEV_TYPE_STA ||
+		    !arvif->is_up ||
+		    !arvif->rekey_data.enable_offload)
+			continue;
+
+		/* get rekey info before disable rekey offload */
+		if (!enable) {
+			ret = ath12k_wmi_gtk_rekey_getinfo(ar, arvif);
+			if (ret) {
+				ath12k_warn(ar->ab, "failed to request rekey info vdev %i, ret %d\n",
+					    arvif->vdev_id, ret);
+				return ret;
+			}
+		}
+
+		ret = ath12k_wmi_gtk_rekey_offload(ar, arvif, enable);
+
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to offload gtk reky vdev %i: enable %d, ret %d\n",
+				    arvif->vdev_id, enable, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int ath12k_wow_protocol_offload(struct ath12k *ar, bool enable)
 {
 	int ret;
@@ -765,6 +802,13 @@ static int ath12k_wow_protocol_offload(struct ath12k *ar, bool enable)
 		return ret;
 	}
 
+	ret = ath12k_gtk_rekey_offload(ar, enable);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to offload gtk rekey %d %d\n",
+			    enable, ret);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.25.1


