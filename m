Return-Path: <linux-wireless+bounces-7978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D732A8CCB2A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534AF1F21E47
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DC039FEB;
	Thu, 23 May 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QOaTaChh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F620319
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435135; cv=none; b=AaxvXW99jFo7DJ2zncMo8RBqlODe5Tus8F3I+H9jXU0VPjozndSrumgvibpSxkWfd2OfXJYAF2GeLiZvstBIoqZnOs9IjJsI/VOOMe6IGohhiJ+sV3LUKUgnoRz4JhXT0qu3x45Q6bnHs2wylIXbtGwvpcUYx8hoxdYP0B8s4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435135; c=relaxed/simple;
	bh=JBjAnAkDGO8IohjYLSqbKvYd0voaQ0BB6e7gx1XXODs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXHcJm3z5iuK15bj2IYw124JqXUaKXRP7qUZxLw9UZm3Hwij0kcpCckONmS6U4A3T+aIeShA1VO0MugBVvdZhGaRZa0/27e92YFw0BCzTW2QdNkFE6jjvHPPQcEpSptBh3UIVuTD6IOCO2Ao6qHtn1uiE2tr5CySbs0qymnvd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QOaTaChh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MD7OYk026426;
	Thu, 23 May 2024 03:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=syxO9SW2QIspbQeap8QV/qp6o3eXFnERYZ24mBn2MM4=; b=QO
	aTaChhv46XbrPkwXX2Q61EONSxPvw4/p3J658EgbZ81F/YQC02riN7cbgSdjai3x
	I4MYCKdkJGcy5QfuysNH0PkHy4ZM8MBM+/T0ZR/GitkUq8JKxVrMEyItLhSvac4q
	TJ5dJCmHINethu0JdWwIj3yTZlq6G/AMimLjJLPM+xagekRZjKToa/MTMElsfO9w
	QgWTSF0GQluc3uyN0sfRxft1Kl6DmXr8qtIoKxFwH4vxw4jKpBkbW7hiNWnneZNm
	4JtrZkWSD6upuG2rwFbA/+BAzebmd/rMEN+vgm5IplbXFY6xcoprAlKXZB7EvDLc
	H/cHi22sEWChkHFXDFyQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gjmf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N3W2xL026687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:02 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 20:32:00 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 2/7] wifi: ath12k: add basic WoW functionalities
Date: Thu, 23 May 2024 11:31:38 +0800
Message-ID: <20240523033143.21677-3-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: 5veE8ZmMp39XQV0GarhQCKANxX9deLi1
X-Proofpoint-ORIG-GUID: 5veE8ZmMp39XQV0GarhQCKANxX9deLi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230023

Implement basic WoW functionalities such as magic-packet, disconnect
and pattern. The logic is very similar to ath11k.

When WoW is configured, ath12k_core_suspend and ath12k_core_resume
are skipped (by checking ar->state) as we are not allowed to power
cycle firmware.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  46 ++-
 drivers/net/wireless/ath/ath12k/core.h |   5 +
 drivers/net/wireless/ath/ath12k/htc.c  |   6 +
 drivers/net/wireless/ath/ath12k/mac.c  |  14 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 143 +++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  63 ++++
 drivers/net/wireless/ath/ath12k/wow.c  | 416 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.h  |  32 ++
 8 files changed, 717 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3b1ad175a36a..9a7a18825562 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -43,14 +43,38 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 	return ret;
 }
 
-int ath12k_core_suspend(struct ath12k_base *ab)
+/* Check if we need to continue with suspend/resume operation.
+ * Return:
+ *	a negative value: error happens and don't continue.
+ *	0:  no error but don't continue.
+ *	positive value: no error and do continue.
+ */
+static int ath12k_core_continue_suspend_resume(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
-	int ret, i;
 
 	if (!ab->hw_params->supports_suspend)
 		return -EOPNOTSUPP;
 
+	/* so far single_pdev_only chips have supports_suspend as true
+	 * so pass 0 as a dummy pdev_id here.
+	 */
+	ar = ab->pdevs[0].ar;
+	if (!ar || !ar->ah || ar->ah->state != ATH12K_HW_STATE_OFF)
+		return 0;
+
+	return 1;
+}
+
+int ath12k_core_suspend(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	int ret, i;
+
+	ret = ath12k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 		if (!ar)
@@ -81,8 +105,11 @@ EXPORT_SYMBOL(ath12k_core_suspend);
 
 int ath12k_core_suspend_late(struct ath12k_base *ab)
 {
-	if (!ab->hw_params->supports_suspend)
-		return -EOPNOTSUPP;
+	int ret;
+
+	ret = ath12k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
 
 	ath12k_hif_irq_disable(ab);
 	ath12k_hif_ce_irq_disable(ab);
@@ -97,8 +124,9 @@ int ath12k_core_resume_early(struct ath12k_base *ab)
 {
 	int ret;
 
-	if (!ab->hw_params->supports_suspend)
-		return -EOPNOTSUPP;
+	ret = ath12k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
 
 	reinit_completion(&ab->restart_completed);
 	ret = ath12k_hif_power_up(ab);
@@ -112,9 +140,11 @@ EXPORT_SYMBOL(ath12k_core_resume_early);
 int ath12k_core_resume(struct ath12k_base *ab)
 {
 	long time_left;
+	int ret;
 
-	if (!ab->hw_params->supports_suspend)
-		return -EOPNOTSUPP;
+	ret = ath12k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
 
 	time_left = wait_for_completion_timeout(&ab->restart_completed,
 						ATH12K_RESET_TIMEOUT_HZ);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d94d1527b276..40b4f9b4d570 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -27,6 +27,7 @@
 #include "dbring.h"
 #include "fw.h"
 #include "acpi.h"
+#include "wow.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -605,6 +606,9 @@ struct ath12k {
 	struct work_struct wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
 
+	struct ath12k_wow wow;
+	struct completion target_suspend;
+	bool target_suspend_ack;
 	struct ath12k_per_peer_tx_stats peer_tx_stats;
 	struct list_head ppdu_stats_info;
 	u32 ppdu_stat_list_depth;
@@ -766,6 +770,7 @@ struct ath12k_base {
 
 	struct {
 		struct completion wakeup_completed;
+		u32 wmi_conf_rx_decap_mode;
 	} wow;
 
 	struct ath12k_ce ce;
diff --git a/drivers/net/wireless/ath/ath12k/htc.c b/drivers/net/wireless/ath/ath12k/htc.c
index 2f2230f565bb..d13616bf07f4 100644
--- a/drivers/net/wireless/ath/ath12k/htc.c
+++ b/drivers/net/wireless/ath/ath12k/htc.c
@@ -244,6 +244,11 @@ static void ath12k_htc_suspend_complete(struct ath12k_base *ab, bool ack)
 	complete(&ab->htc_suspend);
 }
 
+static void ath12k_htc_wakeup_from_suspend(struct ath12k_base *ab)
+{
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot wakeup from suspend is received\n");
+}
+
 void ath12k_htc_rx_completion_handler(struct ath12k_base *ab,
 				      struct sk_buff *skb)
 {
@@ -349,6 +354,7 @@ void ath12k_htc_rx_completion_handler(struct ath12k_base *ab,
 			ath12k_htc_suspend_complete(ab, false);
 			break;
 		case ATH12K_HTC_MSG_WAKEUP_FROM_SUSPEND_ID:
+			ath12k_htc_wakeup_from_suspend(ab);
 			break;
 		default:
 			ath12k_warn(ab, "ignoring unsolicited htc ep0 event %u\n",
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..43ee52524b3d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -15,6 +15,8 @@
 #include "dp_rx.h"
 #include "peer.h"
 #include "debugfs.h"
+#include "hif.h"
+#include "wow.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -8539,6 +8541,12 @@ static const struct ieee80211_ops ath12k_ops = {
 	.sta_statistics			= ath12k_mac_op_sta_statistics,
 	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
 	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
+
+#ifdef CONFIG_PM
+	.suspend			= ath12k_wow_op_suspend,
+	.resume				= ath12k_wow_op_resume,
+	.set_wakeup			= ath12k_wow_op_set_wakeup,
+#endif
 };
 
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
@@ -9056,6 +9064,12 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	}
 
+	ret = ath12k_wow_init(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to init wow: %d\n", ret);
+		goto err_free_if_combs;
+	}
+
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7142d71de5f0..7f3d4ce93cb4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3716,6 +3716,7 @@ int ath12k_wmi_cmd_init(struct ath12k_base *ab)
 		arg.res_cfg.is_reg_cc_ext_event_supported = true;
 
 	ab->hw_params->wmi_init(ab, &arg.res_cfg);
+	ab->wow.wmi_conf_rx_decap_mode = arg.res_cfg.rx_decap_mode;
 
 	arg.num_mem_chunks = wmi_ab->num_mem_chunks;
 	arg.hw_mode_id = wmi_ab->preferred_hw_mode;
@@ -7462,3 +7463,145 @@ int ath12k_wmi_wow_enable(struct ath12k *ar)
 
 	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
 }
+
+int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
+				    enum wmi_wow_wakeup_event event,
+				    u32 enable)
+{
+	struct wmi_wow_add_del_event_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_add_del_event_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_WOW_ADD_DEL_EVT_CMD,
+						 sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->is_add = cpu_to_le32(enable);
+	cmd->event_bitmap = cpu_to_le32((1 << event));
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow add wakeup event %s enable %d vdev_id %d\n",
+		   wow_wakeup_event(event), enable, vdev_id);
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
+}
+
+int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
+			       const u8 *pattern, const u8 *mask,
+			       int pattern_len, int pattern_offset)
+{
+	struct wmi_wow_add_pattern_cmd *cmd;
+	struct wmi_wow_bitmap_pattern_params *bitmap;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	void *ptr;
+	size_t len;
+
+	len = sizeof(*cmd) +
+	      sizeof(*tlv) +			/* array struct */
+	      sizeof(*bitmap) +			/* bitmap */
+	      sizeof(*tlv) +			/* empty ipv4 sync */
+	      sizeof(*tlv) +			/* empty ipv6 sync */
+	      sizeof(*tlv) +			/* empty magic */
+	      sizeof(*tlv) +			/* empty info timeout */
+	      sizeof(*tlv) + sizeof(u32);	/* ratelimit interval */
+
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	/* cmd */
+	ptr = skb->data;
+	cmd = ptr;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_WOW_ADD_PATTERN_CMD,
+						 sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->pattern_id = cpu_to_le32(pattern_id);
+	cmd->pattern_type = cpu_to_le32(WOW_BITMAP_PATTERN);
+
+	ptr += sizeof(*cmd);
+
+	/* bitmap */
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, sizeof(*bitmap));
+
+	ptr += sizeof(*tlv);
+
+	bitmap = ptr;
+	bitmap->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_WOW_BITMAP_PATTERN_T,
+						    sizeof(*bitmap));
+	memcpy(bitmap->patternbuf, pattern, pattern_len);
+	memcpy(bitmap->bitmaskbuf, mask, pattern_len);
+	bitmap->pattern_offset = cpu_to_le32(pattern_offset);
+	bitmap->pattern_len = cpu_to_le32(pattern_len);
+	bitmap->bitmask_len = cpu_to_le32(pattern_len);
+	bitmap->pattern_id = cpu_to_le32(pattern_id);
+
+	ptr += sizeof(*bitmap);
+
+	/* ipv4 sync */
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* ipv6 sync */
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* magic */
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* pattern info timeout */
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* ratelimit interval */
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, sizeof(u32));
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow add pattern vdev_id %d pattern_id %d pattern_offset %d pattern_len %d\n",
+		   vdev_id, pattern_id, pattern_offset, pattern_len);
+
+	ath12k_dbg_dump(ar->ab, ATH12K_DBG_WMI, NULL, "wow pattern: ",
+			bitmap->patternbuf, pattern_len);
+	ath12k_dbg_dump(ar->ab, ATH12K_DBG_WMI, NULL, "wow bitmask: ",
+			bitmap->bitmaskbuf, pattern_len);
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
+}
+
+int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
+{
+	struct wmi_wow_del_pattern_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_del_pattern_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_WOW_DEL_PATTERN_CMD,
+						 sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->pattern_id = cpu_to_le32(pattern_id);
+	cmd->pattern_type = cpu_to_le32(WOW_BITMAP_PATTERN);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow del pattern vdev_id %d pattern_id %d\n",
+		   vdev_id, pattern_id);
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 9cee3a114645..6cb06f6f7df4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5046,6 +5046,62 @@ static inline const char *wow_reason(enum wmi_wow_wake_reason reason)
 
 #undef C2S
 
+#define WOW_DEFAULT_BITMAP_PATTERN_SIZE		148
+#define WOW_DEFAULT_BITMASK_SIZE		148
+
+#define WOW_MIN_PATTERN_SIZE	1
+#define WOW_MAX_PATTERN_SIZE	148
+#define WOW_MAX_PKT_OFFSET	128
+#define WOW_HDR_LEN	(sizeof(struct ieee80211_hdr_3addr) + \
+	sizeof(struct rfc1042_hdr))
+#define WOW_MAX_REDUCE	(WOW_HDR_LEN - sizeof(struct ethhdr) - \
+	offsetof(struct ieee80211_hdr_3addr, addr1))
+
+struct wmi_wow_bitmap_pattern_params {
+	__le32 tlv_header;
+	u8 patternbuf[WOW_DEFAULT_BITMAP_PATTERN_SIZE];
+	u8 bitmaskbuf[WOW_DEFAULT_BITMASK_SIZE];
+	__le32 pattern_offset;
+	__le32 pattern_len;
+	__le32 bitmask_len;
+	__le32 pattern_id;
+} __packed;
+
+struct wmi_wow_add_pattern_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 pattern_id;
+	__le32 pattern_type;
+} __packed;
+
+struct wmi_wow_del_pattern_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 pattern_id;
+	__le32 pattern_type;
+} __packed;
+
+enum wmi_tlv_pattern_type {
+	WOW_PATTERN_MIN = 0,
+	WOW_BITMAP_PATTERN = WOW_PATTERN_MIN,
+	WOW_IPV4_SYNC_PATTERN,
+	WOW_IPV6_SYNC_PATTERN,
+	WOW_WILD_CARD_PATTERN,
+	WOW_TIMER_PATTERN,
+	WOW_MAGIC_PATTERN,
+	WOW_IPV6_RA_PATTERN,
+	WOW_IOAC_PKT_PATTERN,
+	WOW_IOAC_TMR_PATTERN,
+	WOW_PATTERN_MAX
+};
+
+struct wmi_wow_add_del_event_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 is_add;
+	__le32 event_bitmap;
+} __packed;
+
 struct wmi_wow_enable_cmd {
 	__le32 tlv_header;
 	__le32 enable;
@@ -5228,4 +5284,11 @@ ath12k_wmi_mac_phy_get_hw_link_id(const struct ath12k_wmi_mac_phy_caps_params *p
 
 int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar);
 int ath12k_wmi_wow_enable(struct ath12k *ar);
+int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id);
+int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
+			       const u8 *pattern, const u8 *mask,
+			       int pattern_len, int pattern_offset);
+int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
+				    enum wmi_wow_wakeup_event event,
+				    u32 enable);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 98e36fc87fa6..2965c9ad2462 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -7,12 +7,22 @@
 #include <linux/delay.h>
 
 #include "mac.h"
+
+#include <net/mac80211.h>
 #include "core.h"
 #include "hif.h"
 #include "debug.h"
 #include "wmi.h"
 #include "wow.h"
 
+static const struct wiphy_wowlan_support ath12k_wowlan_support = {
+	.flags = WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_MAGIC_PKT,
+	.pattern_min_len = WOW_MIN_PATTERN_SIZE,
+	.pattern_max_len = WOW_MAX_PATTERN_SIZE,
+	.max_pkt_offset = WOW_MAX_PKT_OFFSET,
+};
+
 int ath12k_wow_enable(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -72,3 +82,409 @@ int ath12k_wow_wakeup(struct ath12k *ar)
 
 	return 0;
 }
+
+static int ath12k_wow_vif_cleanup(struct ath12k_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	int i, ret;
+
+	for (i = 0; i < WOW_EVENT_MAX; i++) {
+		ret = ath12k_wmi_wow_add_wakeup_event(ar, arvif->vdev_id, i, 0);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to issue wow wakeup for event %s on vdev %i: %d\n",
+				    wow_wakeup_event(i), arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ar->wow.max_num_patterns; i++) {
+		ret = ath12k_wmi_wow_del_pattern(ar, arvif->vdev_id, i);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to delete wow pattern %d for vdev %i: %d\n",
+				    i, arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath12k_wow_cleanup(struct ath12k *ar)
+{
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath12k_wow_vif_cleanup(arvif);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to clean wow wakeups on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* Convert a 802.3 format to a 802.11 format.
+ *         +------------+-----------+--------+----------------+
+ * 802.3:  |dest mac(6B)|src mac(6B)|type(2B)|     body...    |
+ *         +------------+-----------+--------+----------------+
+ *                |__         |_______    |____________  |________
+ *                   |                |                |          |
+ *         +--+------------+----+-----------+---------------+-----------+
+ * 802.11: |4B|dest mac(6B)| 6B |src mac(6B)|  8B  |type(2B)|  body...  |
+ *         +--+------------+----+-----------+---------------+-----------+
+ */
+static void
+ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
+				 const struct cfg80211_pkt_pattern *eth_pattern,
+				 struct ath12k_pkt_pattern *i80211_pattern)
+{
+	size_t r1042_eth_ofs = offsetof(struct rfc1042_hdr, eth_type);
+	size_t a1_ofs = offsetof(struct ieee80211_hdr_3addr, addr1);
+	size_t a3_ofs = offsetof(struct ieee80211_hdr_3addr, addr3);
+	size_t i80211_hdr_len = sizeof(struct ieee80211_hdr_3addr);
+	size_t prot_ofs = offsetof(struct ethhdr, h_proto);
+	size_t src_ofs = offsetof(struct ethhdr, h_source);
+	u8 eth_bytemask[WOW_MAX_PATTERN_SIZE] = {};
+	const u8 *eth_pat = eth_pattern->pattern;
+	size_t eth_pat_len = eth_pattern->pattern_len;
+	size_t eth_pkt_ofs = eth_pattern->pkt_offset;
+	u8 *bytemask = i80211_pattern->bytemask;
+	u8 *pat = i80211_pattern->pattern;
+	size_t pat_len = 0;
+	size_t pkt_ofs = 0;
+	size_t delta;
+	int i;
+
+	/* convert bitmask to bytemask */
+	for (i = 0; i < eth_pat_len; i++)
+		if (eth_pattern->mask[i / 8] & BIT(i % 8))
+			eth_bytemask[i] = 0xff;
+
+	if (eth_pkt_ofs < ETH_ALEN) {
+		pkt_ofs = eth_pkt_ofs + a1_ofs;
+
+		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
+			memcpy(pat, eth_pat, eth_pat_len);
+			memcpy(bytemask, eth_bytemask, eth_pat_len);
+
+			pat_len = eth_pat_len;
+		} else if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
+			memcpy(pat, eth_pat, ETH_ALEN - eth_pkt_ofs);
+			memcpy(bytemask, eth_bytemask, ETH_ALEN - eth_pkt_ofs);
+
+			delta = eth_pkt_ofs + eth_pat_len - src_ofs;
+			memcpy(pat + a3_ofs - pkt_ofs,
+			       eth_pat + ETH_ALEN - eth_pkt_ofs,
+			       delta);
+			memcpy(bytemask + a3_ofs - pkt_ofs,
+			       eth_bytemask + ETH_ALEN - eth_pkt_ofs,
+			       delta);
+
+			pat_len = a3_ofs - pkt_ofs + delta;
+		} else {
+			memcpy(pat, eth_pat, ETH_ALEN - eth_pkt_ofs);
+			memcpy(bytemask, eth_bytemask, ETH_ALEN - eth_pkt_ofs);
+
+			memcpy(pat + a3_ofs - pkt_ofs,
+			       eth_pat + ETH_ALEN - eth_pkt_ofs,
+			       ETH_ALEN);
+			memcpy(bytemask + a3_ofs - pkt_ofs,
+			       eth_bytemask + ETH_ALEN - eth_pkt_ofs,
+			       ETH_ALEN);
+
+			delta = eth_pkt_ofs + eth_pat_len - prot_ofs;
+			memcpy(pat + i80211_hdr_len + r1042_eth_ofs - pkt_ofs,
+			       eth_pat + prot_ofs - eth_pkt_ofs,
+			       delta);
+			memcpy(bytemask + i80211_hdr_len + r1042_eth_ofs - pkt_ofs,
+			       eth_bytemask + prot_ofs - eth_pkt_ofs,
+			       delta);
+
+			pat_len = i80211_hdr_len + r1042_eth_ofs - pkt_ofs + delta;
+		}
+	} else if (eth_pkt_ofs < prot_ofs) {
+		pkt_ofs = eth_pkt_ofs - ETH_ALEN + a3_ofs;
+
+		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
+			memcpy(pat, eth_pat, eth_pat_len);
+			memcpy(bytemask, eth_bytemask, eth_pat_len);
+
+			pat_len = eth_pat_len;
+		} else {
+			memcpy(pat, eth_pat, prot_ofs - eth_pkt_ofs);
+			memcpy(bytemask, eth_bytemask, prot_ofs - eth_pkt_ofs);
+
+			delta = eth_pkt_ofs + eth_pat_len - prot_ofs;
+			memcpy(pat + i80211_hdr_len + r1042_eth_ofs - pkt_ofs,
+			       eth_pat +  prot_ofs - eth_pkt_ofs,
+			       delta);
+			memcpy(bytemask + i80211_hdr_len + r1042_eth_ofs - pkt_ofs,
+			       eth_bytemask + prot_ofs - eth_pkt_ofs,
+			       delta);
+
+			pat_len =  i80211_hdr_len + r1042_eth_ofs - pkt_ofs + delta;
+		}
+	} else {
+		pkt_ofs = eth_pkt_ofs - prot_ofs + i80211_hdr_len + r1042_eth_ofs;
+
+		memcpy(pat, eth_pat, eth_pat_len);
+		memcpy(bytemask, eth_bytemask, eth_pat_len);
+
+		pat_len = eth_pat_len;
+	}
+
+	i80211_pattern->pattern_len = pat_len;
+	i80211_pattern->pkt_offset = pkt_ofs;
+}
+
+static int ath12k_vif_wow_set_wakeups(struct ath12k_vif *arvif,
+				      struct cfg80211_wowlan *wowlan)
+{
+	const struct cfg80211_pkt_pattern *patterns = wowlan->patterns;
+	struct ath12k *ar = arvif->ar;
+	unsigned long wow_mask = 0;
+	int pattern_id = 0;
+	int ret, i;
+
+	/* Setup requested WOW features */
+	switch (arvif->vdev_type) {
+	case WMI_VDEV_TYPE_IBSS:
+		__set_bit(WOW_BEACON_EVENT, &wow_mask);
+		fallthrough;
+	case WMI_VDEV_TYPE_AP:
+		__set_bit(WOW_DEAUTH_RECVD_EVENT, &wow_mask);
+		__set_bit(WOW_DISASSOC_RECVD_EVENT, &wow_mask);
+		__set_bit(WOW_PROBE_REQ_WPS_IE_EVENT, &wow_mask);
+		__set_bit(WOW_AUTH_REQ_EVENT, &wow_mask);
+		__set_bit(WOW_ASSOC_REQ_EVENT, &wow_mask);
+		__set_bit(WOW_HTT_EVENT, &wow_mask);
+		__set_bit(WOW_RA_MATCH_EVENT, &wow_mask);
+		break;
+	case WMI_VDEV_TYPE_STA:
+		if (wowlan->disconnect) {
+			__set_bit(WOW_DEAUTH_RECVD_EVENT, &wow_mask);
+			__set_bit(WOW_DISASSOC_RECVD_EVENT, &wow_mask);
+			__set_bit(WOW_BMISS_EVENT, &wow_mask);
+			__set_bit(WOW_CSA_IE_EVENT, &wow_mask);
+		}
+
+		if (wowlan->magic_pkt)
+			__set_bit(WOW_MAGIC_PKT_RECVD_EVENT, &wow_mask);
+		break;
+	default:
+		break;
+	}
+
+	for (i = 0; i < wowlan->n_patterns; i++) {
+		const struct cfg80211_pkt_pattern *eth_pattern = &patterns[i];
+		struct ath12k_pkt_pattern new_pattern = {};
+
+		if (WARN_ON(eth_pattern->pattern_len > WOW_MAX_PATTERN_SIZE))
+			return -EINVAL;
+
+		if (ar->ab->wow.wmi_conf_rx_decap_mode ==
+		    ATH12K_HW_TXRX_NATIVE_WIFI) {
+			ath12k_wow_convert_8023_to_80211(ar, eth_pattern,
+							 &new_pattern);
+
+			if (WARN_ON(new_pattern.pattern_len > WOW_MAX_PATTERN_SIZE))
+				return -EINVAL;
+		} else {
+			memcpy(new_pattern.pattern, eth_pattern->pattern,
+			       eth_pattern->pattern_len);
+
+			/* convert bitmask to bytemask */
+			for (i = 0; i < eth_pattern->pattern_len; i++)
+				if (eth_pattern->mask[i / 8] & BIT(i % 8))
+					new_pattern.bytemask[i] = 0xff;
+
+			new_pattern.pattern_len = eth_pattern->pattern_len;
+			new_pattern.pkt_offset = eth_pattern->pkt_offset;
+		}
+
+		ret = ath12k_wmi_wow_add_pattern(ar, arvif->vdev_id,
+						 pattern_id,
+						 new_pattern.pattern,
+						 new_pattern.bytemask,
+						 new_pattern.pattern_len,
+						 new_pattern.pkt_offset);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to add pattern %i to vdev %i: %d\n",
+				    pattern_id,
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+
+		pattern_id++;
+		__set_bit(WOW_PATTERN_MATCH_EVENT, &wow_mask);
+	}
+
+	for (i = 0; i < WOW_EVENT_MAX; i++) {
+		if (!test_bit(i, &wow_mask))
+			continue;
+		ret = ath12k_wmi_wow_add_wakeup_event(ar, arvif->vdev_id, i, 1);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to enable wakeup event %s on vdev %i: %d\n",
+				    wow_wakeup_event(i), arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath12k_wow_set_wakeups(struct ath12k *ar,
+				  struct cfg80211_wowlan *wowlan)
+{
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath12k_vif_wow_set_wakeups(arvif, wowlan);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set wow wakeups on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan)
+{
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret =  ath12k_wow_cleanup(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to clear wow wakeup events: %d\n",
+			    ret);
+		goto exit;
+	}
+
+	ret = ath12k_wow_set_wakeups(ar, wowlan);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set wow wakeup events: %d\n",
+			    ret);
+		goto cleanup;
+	}
+
+	ret = ath12k_mac_wait_tx_complete(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
+		goto cleanup;
+	}
+
+	ret = ath12k_wow_enable(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to start wow: %d\n", ret);
+		goto cleanup;
+	}
+
+	ath12k_hif_irq_disable(ar->ab);
+	ath12k_hif_ce_irq_disable(ar->ab);
+
+	ret = ath12k_hif_suspend(ar->ab);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to suspend hif: %d\n", ret);
+		goto wakeup;
+	}
+
+	goto exit;
+
+wakeup:
+	ath12k_wow_wakeup(ar);
+
+cleanup:
+	ath12k_wow_cleanup(ar);
+
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret ? 1 : 0;
+}
+
+void ath12k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+
+	mutex_lock(&ar->conf_mutex);
+	device_set_wakeup_enable(ar->ab->dev, enabled);
+	mutex_unlock(&ar->conf_mutex);
+}
+
+int ath12k_wow_op_resume(struct ieee80211_hw *hw)
+{
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret = ath12k_hif_resume(ar->ab);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to resume hif: %d\n", ret);
+		goto exit;
+	}
+
+	ath12k_hif_ce_irq_enable(ar->ab);
+	ath12k_hif_irq_enable(ar->ab);
+
+	ret = ath12k_wow_wakeup(ar);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to wakeup from wow: %d\n", ret);
+
+exit:
+	if (ret) {
+		switch (ah->state) {
+		case ATH12K_HW_STATE_ON:
+			ah->state = ATH12K_HW_STATE_RESTARTING;
+			ret = 1;
+			break;
+		case ATH12K_HW_STATE_OFF:
+		case ATH12K_HW_STATE_RESTARTING:
+		case ATH12K_HW_STATE_RESTARTED:
+		case ATH12K_HW_STATE_WEDGED:
+			ath12k_warn(ar->ab, "encountered unexpected device state %d on resume, cannot recover\n",
+				    ah->state);
+			ret = -EIO;
+			break;
+		}
+	}
+
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+int ath12k_wow_init(struct ath12k *ar)
+{
+	if (WARN_ON(!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map)))
+		return -EINVAL;
+
+	ar->wow.wowlan_support = ath12k_wowlan_support;
+
+	if (ar->ab->wow.wmi_conf_rx_decap_mode == ATH12K_HW_TXRX_NATIVE_WIFI) {
+		ar->wow.wowlan_support.pattern_max_len -= WOW_MAX_REDUCE;
+		ar->wow.wowlan_support.max_pkt_offset -= WOW_MAX_REDUCE;
+	}
+
+	ar->wow.max_num_patterns = ATH12K_WOW_PATTERNS;
+	ar->wow.wowlan_support.n_patterns = ar->wow.max_num_patterns;
+	ar->ah->hw->wiphy->wowlan = &ar->wow.wowlan_support;
+
+	device_set_wakeup_capable(ar->ab->dev, true);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wow.h b/drivers/net/wireless/ath/ath12k/wow.h
index 6817ceaa4cfe..af9be5fadcc3 100644
--- a/drivers/net/wireless/ath/ath12k/wow.h
+++ b/drivers/net/wireless/ath/ath12k/wow.h
@@ -9,14 +9,46 @@
 
 #define ATH12K_WOW_RETRY_NUM		10
 #define ATH12K_WOW_RETRY_WAIT_MS	200
+#define ATH12K_WOW_PATTERNS		22
+
+struct ath12k_wow {
+	u32 max_num_patterns;
+	struct completion wakeup_completed;
+	struct wiphy_wowlan_support wowlan_support;
+};
+
+struct ath12k_pkt_pattern {
+	u8 pattern[WOW_MAX_PATTERN_SIZE];
+	u8 bytemask[WOW_MAX_PATTERN_SIZE];
+	int pattern_len;
+	int pkt_offset;
+};
+
+struct rfc1042_hdr {
+	u8 llc_dsap;
+	u8 llc_ssap;
+	u8 llc_ctrl;
+	u8 snap_oui[3];
+	__be16 eth_type;
+} __packed;
 
 #ifdef CONFIG_PM
 
+int ath12k_wow_init(struct ath12k *ar);
+int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan);
+int ath12k_wow_op_resume(struct ieee80211_hw *hw);
+void ath12k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled);
 int ath12k_wow_enable(struct ath12k *ar);
 int ath12k_wow_wakeup(struct ath12k *ar);
 
 #else
 
+static inline int ath12k_wow_init(struct ath12k *ar)
+{
+	return 0;
+}
+
 static inline int ath12k_wow_enable(struct ath12k *ar)
 {
 	return 0;
-- 
2.25.1


