Return-Path: <linux-wireless+bounces-7979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D848CCB2B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A0C1F22B35
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21220319;
	Thu, 23 May 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iDayTmNH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BCF8005C
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435137; cv=none; b=G9bFMyy9ytfs19Ob0zWeFf5JZJSOJEcxecmOHaJxcdNyeQqIa5rN1GJyq13Fc+s/RijHuoagcdyqJLmhId6T8HanaSeG5oD89sP4d9dKQRKYTUQFKDfGZphmTM/7ozYqeI2cZSkIQUuzsdvwHQr3/C4zU2osnoecBtWW3SK/yOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435137; c=relaxed/simple;
	bh=xJdNHdCR1lzlWhOyJXzy8iiVSrYhyH2zpsdBzP5BFZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmdHBIAU7Dri4hQagEGHH0tqjFpFFKbvLo4r8IvX+xjbZL5x+fuXSTGVVwYnKeEeK0hSHkN7WwyC/ALCcaK0Vt4ylRZsXfqnhx9cTX2W05xzxZ2nCnu01qFzWZ4BlCYL17suMe81xJtUoRYIquBrmlQsT3YEzqKYp64sTp71NSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iDayTmNH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MLg4gj025900;
	Thu, 23 May 2024 03:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kcEjnZM02CgocpYGvpoSrXd9npLj2QR//EXgCGJ337c=; b=iD
	ayTmNH+3dDbHd301uYyWt5IcSxBs/mZOCbU/W46NdnaNFfS9xlRS4D35Y6/+6r0k
	pBlKL/H7tJliz9nx3Cu3Bw87m4ZTOkNv19PbWGXfn2CwIpVYKVdZN/a09OWxFa97
	s3fFyCo1+XAG5HBR/Xak8RhxQEiApgKGCjEU1R90Za3B2rp4DnME/tW8oprb6QAc
	deNqaQ3RMF5SB8u6xJTTryAknp45qVSDoG3cKv4HkPsmYZFPgFXvc6qG/I7BARQ/
	KOU4a/hlHhFYEazEltAMOCXqYn6HhS32e2UqmNzNExx20MY44q5yP5w6fOO14s3R
	GlhNU24F6fV8kzgGCcqQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqatdkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N3W7oq009746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:07 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 20:32:06 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 6/7] wifi: ath12k: support GTK rekey offload
Date: Thu, 23 May 2024 11:31:42 +0800
Message-ID: <20240523033143.21677-7-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523033143.21677-1-quic_bqiang@quicinc.com>
References: <20240523033143.21677-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: gzJTj2PYYAVROZ-c6IWyXqq-EvygAyZI
X-Proofpoint-ORIG-GUID: gzJTj2PYYAVROZ-c6IWyXqq-EvygAyZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405230023

Host sets GTK related info to firmware before WoW is enabled, and
gets rekey replay_count and then disables GTK rekey when WoW quits.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   8 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  38 +++++++++
 drivers/net/wireless/ath/ath12k/wmi.c  | 108 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  39 +++++++++
 drivers/net/wireless/ath/ath12k/wow.c  |  46 ++++++++++-
 5 files changed, 238 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0556ea5f83be..2ea19204a2de 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -246,6 +246,13 @@ struct ath12k_arp_ns_offload {
 	u8  mac_addr[ETH_ALEN];
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
@@ -303,6 +310,7 @@ struct ath12k_vif {
 	bool ps;
 	struct ath12k_vif_cache *cache;
 	struct ath12k_arp_ns_offload *arp_ns_offload;
+	struct ath12k_rekey_data rekey_data;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 82c6cec3f8d6..098ffe5750c7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2841,6 +2841,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	}
 
 	arvif->is_up = true;
+	arvif->rekey_data.enable_offload = false;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "mac vdev %d up (associated) bssid %pM aid %d\n",
@@ -2888,6 +2889,8 @@ static void ath12k_bss_disassoc(struct ath12k *ar,
 
 	arvif->is_up = false;
 
+	memset(&arvif->rekey_data, 0, sizeof(arvif->rekey_data));
+
 	cancel_delayed_work(&arvif->connection_loss_work);
 }
 
@@ -8656,6 +8659,40 @@ static __maybe_unused void ath12k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	ath12k_mac_generate_ns_mc_addr(ar, offload);
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
@@ -8671,6 +8708,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.hw_scan                        = ath12k_mac_op_hw_scan,
 	.cancel_hw_scan                 = ath12k_mac_op_cancel_hw_scan,
 	.set_key                        = ath12k_mac_op_set_key,
+	.set_rekey_data	                = ath12k_mac_op_set_rekey_data,
 	.sta_state                      = ath12k_mac_op_sta_state,
 	.sta_set_txpwr			= ath12k_mac_op_sta_set_txpwr,
 	.sta_rc_update			= ath12k_mac_op_sta_rc_update,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 76f749a1889f..ebbac036b330 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7089,6 +7089,52 @@ static void ath12k_wmi_event_wow_wakeup_host(struct ath12k_base *ab, struct sk_b
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
+	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, le32_to_cpu(ev->vdev_id));
+	if (!arvif) {
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
+	kfree(tb);
+}
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -7212,6 +7258,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_WOW_WAKEUP_HOST_EVENTID:
 		ath12k_wmi_event_wow_wakeup_host(ab, skb);
 		break;
+	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
+		ath12k_wmi_gtk_offload_status_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
@@ -7931,3 +7980,62 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
 
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
index 8f898aa0db45..be8c4117708c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5360,6 +5360,41 @@ struct wmi_set_arp_ns_offload_cmd {
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
@@ -5527,5 +5562,9 @@ int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar,
 				  struct wmi_hw_data_filter_arg *arg);
 int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
 			      struct ath12k_vif *arvif, bool enable);
+int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
+				 struct ath12k_vif *arvif, bool enable);
+int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
+				 struct ath12k_vif *arvif);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 9463f95a34ab..8e30201f6a89 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -17,7 +17,9 @@
 
 static const struct wiphy_wowlan_support ath12k_wowlan_support = {
 	.flags = WIPHY_WOWLAN_DISCONNECT |
-		 WIPHY_WOWLAN_MAGIC_PKT,
+		 WIPHY_WOWLAN_MAGIC_PKT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
+		 WIPHY_WOWLAN_GTK_REKEY_FAILURE,
 	.pattern_min_len = WOW_MIN_PATTERN_SIZE,
 	.pattern_max_len = WOW_MAX_PATTERN_SIZE,
 	.max_pkt_offset = WOW_MAX_PKT_OFFSET,
@@ -613,6 +615,41 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
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
@@ -624,6 +661,13 @@ static int ath12k_wow_protocol_offload(struct ath12k *ar, bool enable)
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


