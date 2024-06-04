Return-Path: <linux-wireless+bounces-8458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969768FAA48
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 07:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA65E1C214B1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F013DDB2;
	Tue,  4 Jun 2024 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EK5+xtit"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C49132135
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480469; cv=none; b=fxMSntqCFrK4vLkEboeGFQQeuVhX5yhFo2ChMejZo/FimxvHH8n0+LblsbpgaNedH6p5R41vX/AWupOB3HKG0mLGVfUZHUwFSgP0Toiu351SAVNefP2pBeh2mfrjqNVhgjuAVhMadrYaQqBJKlj1UHkosjcBv/aKQ605pPK6X94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480469; c=relaxed/simple;
	bh=3uSJLSAF4H9OyCXeiFBlje4H37VP0lwh1ptktXlLpZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ44Soxzg/KIz0ujD0zUMLMfxj7X3rCjkP6WxdOnEvq+MDV05l4Rhu7pMUwQeeQtNG2sVKig2yUg2lUqG3Pp7VrQuqD/N7sZJxLtX2FEr4QiECeY02SFll+0Wytowj4MWzkfl3Cz/rWv1XDiECd0fPUeQAOS4KVtFdIcAoARYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EK5+xtit; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4542jh3O017720;
	Tue, 4 Jun 2024 05:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7KsFUGgrYyvqIW2FnV40r/3/m42qHt0XYYcBZdy/UzU=; b=EK5+xtitEG++cUeW
	tpxuSNxfhPcN0AsutGYq91uymjmDMkeMo+JhWPDAvy/yM3M6EhMtwK2pAx2w3Gds
	iLnVrkAqqW/3e7tMvQDCl6wy4TRfSHKlSBadt9jkWfHKLbNmFMefpDCrVor3T2wS
	D/VlW2Em+Qj7ia6GMmaohw2Xs7tI/WmozMrelHCRssG3woKEDcp0owRDqRjo4XuR
	GQ3+hDRqBM0FWP30xBLTsQWmxl4cdxUCfFc1v/eeYs9WkDnlSZ/Id/U06XfiD8Gm
	1eJFZFVnsXDvr16msb1SxrOv0mqVb0U5UT01Xq0ErzAun399sKYImJqLRrsGanPV
	ufHa8Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw59nmvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 05:54:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4545sMb5018032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 05:54:22 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 22:54:20 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v4 2/8] wifi: ath12k: implement WoW enable and wakeup commands
Date: Tue, 4 Jun 2024 13:54:01 +0800
Message-ID: <20240604055407.12506-3-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: Te5G1uj-3CeRrLmoe4Dh7Ct3hDo4fTVf
X-Proofpoint-ORIG-GUID: Te5G1uj-3CeRrLmoe4Dh7Ct3hDo4fTVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040046

Implement WoW enable and WoW wakeup commands which are needed
for suspend/resume.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/core.c   |   2 +
 drivers/net/wireless/ath/ath12k/core.h   |   4 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 104 ++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    | 174 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c    |  74 ++++++++++
 drivers/net/wireless/ath/ath12k/wow.h    |  30 ++++
 7 files changed, 389 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index d42480db7463..f0dcc933aa95 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -26,6 +26,7 @@ ath12k-y += core.o \
 ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o
 ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
+ath12k-$(CONFIG_PM) += wow.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 4c3eab4686c2..27702bae642e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -16,6 +16,7 @@
 #include "hif.h"
 #include "fw.h"
 #include "debugfs.h"
+#include "wow.h"
 
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
@@ -1288,6 +1289,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->restart_completed);
+	init_completion(&ab->wow.wakeup_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d03326a68a9f..656e61cef10a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -766,6 +766,10 @@ struct ath12k_base {
 		const struct ath12k_hif_ops *ops;
 	} hif;
 
+	struct {
+		struct completion wakeup_completed;
+	} wow;
+
 	struct ath12k_ce ce;
 	struct timer_list rx_replenish_retry;
 	struct ath12k_hal hal;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d6e1d1398cdb..1a67f69529ea 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7030,6 +7030,65 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
 	kfree(tb);
 }
 
+static int ath12k_wmi_wow_wakeup_host_parse(struct ath12k_base *ab,
+					    u16 tag, u16 len,
+					    const void *ptr, void *data)
+{
+	const struct wmi_wow_ev_pg_fault_param *pf_param;
+	const struct wmi_wow_ev_param *param;
+	struct wmi_wow_ev_arg *arg = data;
+	int pf_len;
+
+	switch (tag) {
+	case WMI_TAG_WOW_EVENT_INFO:
+		param = ptr;
+		arg->wake_reason = le32_to_cpu(param->wake_reason);
+		ath12k_dbg(ab, ATH12K_DBG_WMI, "wow wakeup host reason %d %s\n",
+			   arg->wake_reason, wow_reason(arg->wake_reason));
+		break;
+
+	case WMI_TAG_ARRAY_BYTE:
+		if (arg && arg->wake_reason == WOW_REASON_PAGE_FAULT) {
+			pf_param = ptr;
+			pf_len = le32_to_cpu(pf_param->len);
+			if (pf_len > len - sizeof(pf_len) ||
+			    pf_len < 0) {
+				ath12k_warn(ab, "invalid page fault buffer len %d\n",
+					    pf_len);
+				return -EINVAL;
+			}
+			ath12k_dbg(ab, ATH12K_DBG_WMI, "wow data_len = %d\n",
+				   pf_len);
+			ath12k_dbg_dump(ab, ATH12K_DBG_WMI,
+					"wow_event_info_type packet present",
+					"wow_pg_fault ",
+					pf_param->data,
+					pf_len);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void ath12k_wmi_event_wow_wakeup_host(struct ath12k_base *ab, struct sk_buff *skb)
+{
+	struct wmi_wow_ev_arg arg = { };
+	int ret;
+
+	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath12k_wmi_wow_wakeup_host_parse,
+				  &arg);
+	if (ret) {
+		ath12k_warn(ab, "failed to parse wmi wow tlv: %d\n", ret);
+		return;
+	}
+
+	complete(&ab->wow.wakeup_completed);
+}
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -7150,6 +7209,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_DIAG_EVENTID:
 		ath12k_wmi_diag_event(ab, skb);
 		break;
+	case WMI_WOW_WAKEUP_HOST_EVENTID:
+		ath12k_wmi_event_wow_wakeup_host(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
@@ -7359,3 +7421,45 @@ void ath12k_wmi_detach(struct ath12k_base *ab)
 
 	ath12k_wmi_free_dbring_caps(ab);
 }
+
+int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
+{
+	struct wmi_wow_host_wakeup_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_host_wakeup_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_WOW_HOSTWAKEUP_FROM_SLEEP_CMD,
+						 sizeof(*cmd));
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow host wakeup ind\n");
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+}
+
+int ath12k_wmi_wow_enable(struct ath12k *ar)
+{
+	struct wmi_wow_enable_cmd *cmd;
+	struct sk_buff *skb;
+	int len;
+
+	len = sizeof(*cmd);
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_enable_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_WOW_ENABLE_CMD,
+						 sizeof(*cmd));
+
+	cmd->enable = cpu_to_le32(1);
+	cmd->pause_iface_config = cpu_to_le32(WOW_IFACE_PAUSE_ENABLED);
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow enable\n");
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c2b86e187a03..9cee3a114645 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4902,6 +4902,178 @@ struct wmi_twt_disable_event {
 	__le32 status;
 } __packed;
 
+/* WOW structures */
+enum wmi_wow_wakeup_event {
+	WOW_BMISS_EVENT = 0,
+	WOW_BETTER_AP_EVENT,
+	WOW_DEAUTH_RECVD_EVENT,
+	WOW_MAGIC_PKT_RECVD_EVENT,
+	WOW_GTK_ERR_EVENT,
+	WOW_FOURWAY_HSHAKE_EVENT,
+	WOW_EAPOL_RECVD_EVENT,
+	WOW_NLO_DETECTED_EVENT,
+	WOW_DISASSOC_RECVD_EVENT,
+	WOW_PATTERN_MATCH_EVENT,
+	WOW_CSA_IE_EVENT,
+	WOW_PROBE_REQ_WPS_IE_EVENT,
+	WOW_AUTH_REQ_EVENT,
+	WOW_ASSOC_REQ_EVENT,
+	WOW_HTT_EVENT,
+	WOW_RA_MATCH_EVENT,
+	WOW_HOST_AUTO_SHUTDOWN_EVENT,
+	WOW_IOAC_MAGIC_EVENT,
+	WOW_IOAC_SHORT_EVENT,
+	WOW_IOAC_EXTEND_EVENT,
+	WOW_IOAC_TIMER_EVENT,
+	WOW_DFS_PHYERR_RADAR_EVENT,
+	WOW_BEACON_EVENT,
+	WOW_CLIENT_KICKOUT_EVENT,
+	WOW_EVENT_MAX,
+};
+
+enum wmi_wow_interface_cfg {
+	WOW_IFACE_PAUSE_ENABLED,
+	WOW_IFACE_PAUSE_DISABLED
+};
+
+#define C2S(x) case x: return #x
+
+static inline const char *wow_wakeup_event(enum wmi_wow_wakeup_event ev)
+{
+	switch (ev) {
+	C2S(WOW_BMISS_EVENT);
+	C2S(WOW_BETTER_AP_EVENT);
+	C2S(WOW_DEAUTH_RECVD_EVENT);
+	C2S(WOW_MAGIC_PKT_RECVD_EVENT);
+	C2S(WOW_GTK_ERR_EVENT);
+	C2S(WOW_FOURWAY_HSHAKE_EVENT);
+	C2S(WOW_EAPOL_RECVD_EVENT);
+	C2S(WOW_NLO_DETECTED_EVENT);
+	C2S(WOW_DISASSOC_RECVD_EVENT);
+	C2S(WOW_PATTERN_MATCH_EVENT);
+	C2S(WOW_CSA_IE_EVENT);
+	C2S(WOW_PROBE_REQ_WPS_IE_EVENT);
+	C2S(WOW_AUTH_REQ_EVENT);
+	C2S(WOW_ASSOC_REQ_EVENT);
+	C2S(WOW_HTT_EVENT);
+	C2S(WOW_RA_MATCH_EVENT);
+	C2S(WOW_HOST_AUTO_SHUTDOWN_EVENT);
+	C2S(WOW_IOAC_MAGIC_EVENT);
+	C2S(WOW_IOAC_SHORT_EVENT);
+	C2S(WOW_IOAC_EXTEND_EVENT);
+	C2S(WOW_IOAC_TIMER_EVENT);
+	C2S(WOW_DFS_PHYERR_RADAR_EVENT);
+	C2S(WOW_BEACON_EVENT);
+	C2S(WOW_CLIENT_KICKOUT_EVENT);
+	C2S(WOW_EVENT_MAX);
+	default:
+		return NULL;
+	}
+}
+
+enum wmi_wow_wake_reason {
+	WOW_REASON_UNSPECIFIED = -1,
+	WOW_REASON_NLOD = 0,
+	WOW_REASON_AP_ASSOC_LOST,
+	WOW_REASON_LOW_RSSI,
+	WOW_REASON_DEAUTH_RECVD,
+	WOW_REASON_DISASSOC_RECVD,
+	WOW_REASON_GTK_HS_ERR,
+	WOW_REASON_EAP_REQ,
+	WOW_REASON_FOURWAY_HS_RECV,
+	WOW_REASON_TIMER_INTR_RECV,
+	WOW_REASON_PATTERN_MATCH_FOUND,
+	WOW_REASON_RECV_MAGIC_PATTERN,
+	WOW_REASON_P2P_DISC,
+	WOW_REASON_WLAN_HB,
+	WOW_REASON_CSA_EVENT,
+	WOW_REASON_PROBE_REQ_WPS_IE_RECV,
+	WOW_REASON_AUTH_REQ_RECV,
+	WOW_REASON_ASSOC_REQ_RECV,
+	WOW_REASON_HTT_EVENT,
+	WOW_REASON_RA_MATCH,
+	WOW_REASON_HOST_AUTO_SHUTDOWN,
+	WOW_REASON_IOAC_MAGIC_EVENT,
+	WOW_REASON_IOAC_SHORT_EVENT,
+	WOW_REASON_IOAC_EXTEND_EVENT,
+	WOW_REASON_IOAC_TIMER_EVENT,
+	WOW_REASON_ROAM_HO,
+	WOW_REASON_DFS_PHYERR_RADADR_EVENT,
+	WOW_REASON_BEACON_RECV,
+	WOW_REASON_CLIENT_KICKOUT_EVENT,
+	WOW_REASON_PAGE_FAULT = 0x3a,
+	WOW_REASON_DEBUG_TEST = 0xFF,
+};
+
+static inline const char *wow_reason(enum wmi_wow_wake_reason reason)
+{
+	switch (reason) {
+	C2S(WOW_REASON_UNSPECIFIED);
+	C2S(WOW_REASON_NLOD);
+	C2S(WOW_REASON_AP_ASSOC_LOST);
+	C2S(WOW_REASON_LOW_RSSI);
+	C2S(WOW_REASON_DEAUTH_RECVD);
+	C2S(WOW_REASON_DISASSOC_RECVD);
+	C2S(WOW_REASON_GTK_HS_ERR);
+	C2S(WOW_REASON_EAP_REQ);
+	C2S(WOW_REASON_FOURWAY_HS_RECV);
+	C2S(WOW_REASON_TIMER_INTR_RECV);
+	C2S(WOW_REASON_PATTERN_MATCH_FOUND);
+	C2S(WOW_REASON_RECV_MAGIC_PATTERN);
+	C2S(WOW_REASON_P2P_DISC);
+	C2S(WOW_REASON_WLAN_HB);
+	C2S(WOW_REASON_CSA_EVENT);
+	C2S(WOW_REASON_PROBE_REQ_WPS_IE_RECV);
+	C2S(WOW_REASON_AUTH_REQ_RECV);
+	C2S(WOW_REASON_ASSOC_REQ_RECV);
+	C2S(WOW_REASON_HTT_EVENT);
+	C2S(WOW_REASON_RA_MATCH);
+	C2S(WOW_REASON_HOST_AUTO_SHUTDOWN);
+	C2S(WOW_REASON_IOAC_MAGIC_EVENT);
+	C2S(WOW_REASON_IOAC_SHORT_EVENT);
+	C2S(WOW_REASON_IOAC_EXTEND_EVENT);
+	C2S(WOW_REASON_IOAC_TIMER_EVENT);
+	C2S(WOW_REASON_ROAM_HO);
+	C2S(WOW_REASON_DFS_PHYERR_RADADR_EVENT);
+	C2S(WOW_REASON_BEACON_RECV);
+	C2S(WOW_REASON_CLIENT_KICKOUT_EVENT);
+	C2S(WOW_REASON_PAGE_FAULT);
+	C2S(WOW_REASON_DEBUG_TEST);
+	default:
+		return NULL;
+	}
+}
+
+#undef C2S
+
+struct wmi_wow_enable_cmd {
+	__le32 tlv_header;
+	__le32 enable;
+	__le32 pause_iface_config;
+	__le32 flags;
+}  __packed;
+
+struct wmi_wow_host_wakeup_cmd {
+	__le32 tlv_header;
+	__le32 reserved;
+} __packed;
+
+struct wmi_wow_ev_param {
+	__le32 vdev_id;
+	__le32 flag;
+	__le32 wake_reason;
+	__le32 data_len;
+} __packed;
+
+struct wmi_wow_ev_pg_fault_param {
+	__le32 len;
+	u8 data[];
+} __packed;
+
+struct wmi_wow_ev_arg {
+	enum wmi_wow_wake_reason wake_reason;
+};
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5054,4 +5226,6 @@ ath12k_wmi_mac_phy_get_hw_link_id(const struct ath12k_wmi_mac_phy_caps_params *p
 			     WMI_CAPS_PARAMS_HW_LINK_ID);
 }
 
+int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar);
+int ath12k_wmi_wow_enable(struct ath12k *ar);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
new file mode 100644
index 000000000000..98e36fc87fa6
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/delay.h>
+
+#include "mac.h"
+#include "core.h"
+#include "hif.h"
+#include "debug.h"
+#include "wmi.h"
+#include "wow.h"
+
+int ath12k_wow_enable(struct ath12k *ar)
+{
+	struct ath12k_base *ab = ar->ab;
+	int i, ret;
+
+	clear_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
+
+	for (i = 0; i < ATH12K_WOW_RETRY_NUM; i++) {
+		reinit_completion(&ab->htc_suspend);
+
+		ret = ath12k_wmi_wow_enable(ar);
+		if (ret) {
+			ath12k_warn(ab, "failed to issue wow enable: %d\n", ret);
+			return ret;
+		}
+
+		ret = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
+		if (ret == 0) {
+			ath12k_warn(ab,
+				    "timed out while waiting for htc suspend completion\n");
+			return -ETIMEDOUT;
+		}
+
+		if (test_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags))
+			/* success, suspend complete received */
+			return 0;
+
+		ath12k_warn(ab, "htc suspend not complete, retrying (try %d)\n",
+			    i);
+		msleep(ATH12K_WOW_RETRY_WAIT_MS);
+	}
+
+	ath12k_warn(ab, "htc suspend not complete, failing after %d tries\n", i);
+
+	return -ETIMEDOUT;
+}
+
+int ath12k_wow_wakeup(struct ath12k *ar)
+{
+	struct ath12k_base *ab = ar->ab;
+	int ret;
+
+	reinit_completion(&ab->wow.wakeup_completed);
+
+	ret = ath12k_wmi_wow_host_wakeup_ind(ar);
+	if (ret) {
+		ath12k_warn(ab, "failed to send wow wakeup indication: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ret = wait_for_completion_timeout(&ab->wow.wakeup_completed, 3 * HZ);
+	if (ret == 0) {
+		ath12k_warn(ab, "timed out while waiting for wow wakeup completion\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wow.h b/drivers/net/wireless/ath/ath12k/wow.h
new file mode 100644
index 000000000000..6817ceaa4cfe
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wow.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_WOW_H
+#define ATH12K_WOW_H
+
+#define ATH12K_WOW_RETRY_NUM		10
+#define ATH12K_WOW_RETRY_WAIT_MS	200
+
+#ifdef CONFIG_PM
+
+int ath12k_wow_enable(struct ath12k *ar);
+int ath12k_wow_wakeup(struct ath12k *ar);
+
+#else
+
+static inline int ath12k_wow_enable(struct ath12k *ar)
+{
+	return 0;
+}
+
+static inline int ath12k_wow_wakeup(struct ath12k *ar)
+{
+	return 0;
+}
+#endif /* CONFIG_PM */
+#endif /* ATH12K_WOW_H */
-- 
2.25.1


