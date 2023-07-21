Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370A875BC57
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 04:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGUCfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGUCfP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 22:35:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA49272D
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 19:35:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L0coIi007728;
        Fri, 21 Jul 2023 02:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6EOXC4z1qWT71BhMqENtKEjm8CXPtwU4UCz/fVnXJyk=;
 b=CnkgozUwIMbuiLTYW52IqSRmCvbvHhLetuzmHjDzjs9cNmCCqkg+tDhzBKW8nDUbSrzG
 Rq3c6BTy+G0l1KjasKTGG7E2+aJWUKneoa5UAAHAUCrKTce2tj5riRzaloaPUCJ4eFnU
 8qSl74OZ4TZzvj32HD6rPHwFQt5DO1LaH8yVny1jYK5OLXCI6RaBOdxRsq5qzXq+L6cq
 PaF0KJAjLKQ07G+7WKrwly7WC9bVWfPInfHMSzWFtk0Uw46eFzf6EMV9pm94otTe8Ash
 PahS5TrbcjQAXXIYwBe2TxBSmFxNDqS9ZcSUe1yaL3EAJtf8zLTJWKp4krVUdiqIRmFG pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryb040raa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2Z3VR003100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:03 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 19:35:01 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 2/3] wifi: ath12k: Put firmware to WoW state during suspend
Date:   Fri, 21 Jul 2023 10:34:45 +0800
Message-ID: <20230721023446.3706-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721023446.3706-1-quic_bqiang@quicinc.com>
References: <20230721023446.3706-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2DO6hpoyTebhdhlnu5nWRjPVXn1B4WJq
X-Proofpoint-ORIG-GUID: 2DO6hpoyTebhdhlnu5nWRjPVXn1B4WJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At the moment we are not able to shutdown and fully power off
the device due to bugs in MHI subsystem, so WoW (Wake on WLAN)
mode is a workaround for the time being.

In WoW state, firmware will be running on low power mode. This
is important because it could avoid some unexpected activities
like communicating with host while host is in suspend.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/core.c   |  14 ++
 drivers/net/wireless/ath/ath12k/core.h   |   4 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 107 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    | 165 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c    |  74 ++++++++++
 drivers/net/wireless/ath/ath12k/wow.h    |  30 +++++
 7 files changed, 395 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 62c52e733b5e..8a68cbdc4e77 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -22,6 +22,7 @@ ath12k-y += core.o \
 	    dp_mon.o
 
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
+ath12k-$(CONFIG_PM) += wow.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 73065d38be2d..f535ae9e51cd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -14,6 +14,7 @@
 #include "dp_rx.h"
 #include "debug.h"
 #include "hif.h"
+#include "wow.h"
 
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
@@ -45,6 +46,12 @@ int ath12k_core_suspend(struct ath12k_base *ab)
 		return ret;
 	}
 
+	ret = ath12k_wow_enable(ab);
+	if (ret) {
+		ath12k_warn(ab, "failed to enable wow during suspend: %d\n", ret);
+		return ret;
+	}
+
 	ret = ath12k_dp_rx_pktlog_stop(ab, false);
 	if (ret) {
 		ath12k_warn(ab, "failed to stop dp rx pktlog during suspend: %d\n",
@@ -87,6 +94,12 @@ int ath12k_core_resume(struct ath12k_base *ab)
 		return ret;
 	}
 
+	ret = ath12k_wow_wakeup(ab);
+	if (ret) {
+		ath12k_warn(ab, "failed to wakeup wow during resume: %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -931,6 +944,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->reset_work, ath12k_core_reset);
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
+	init_completion(&ab->wow.wakeup_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2f93296db792..fc53bddff773 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -662,6 +662,10 @@ struct ath12k_base {
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
index 6512267ae4ca..1a392dba5ada 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6323,6 +6323,68 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 	kfree(tb);
 }
 
+static int ath12k_wmi_wow_wakeup_host_parse(struct ath12k_base *ab,
+					    u16 tag, u16 len,
+					    const void *ptr, void *data)
+{
+	struct wmi_wow_ev_arg *ev = data;
+	const char *wow_pg_fault;
+	int wow_pg_len;
+
+	switch (tag) {
+	case WMI_TAG_WOW_EVENT_INFO:
+		memcpy(ev, ptr, sizeof(*ev));
+		ath12k_dbg(ab, ATH12K_DBG_WMI, "wow wakeup host reason %d %s\n",
+			   ev->wake_reason, wow_reason(ev->wake_reason));
+		break;
+
+	case WMI_TAG_ARRAY_BYTE:
+		if (ev && ev->wake_reason == WOW_REASON_PAGE_FAULT) {
+			/* the first 4 bytes are length */
+			wow_pg_len = *(int *)ptr;
+			if (!wow_pg_len) {
+				ath12k_warn(ab, "Wake event packet is empty\n");
+				return 0;
+			}
+			if (wow_pg_len > (len - 4)) {
+				ath12k_warn(ab,
+					    "Invalid wow_pg_len: %u, while buf len: %u\n",
+					    wow_pg_len, len);
+				return -EINVAL;
+			}
+			wow_pg_fault = ptr + sizeof(int);
+			ath12k_dbg(ab, ATH12K_DBG_WMI, "wow data_len = %d\n",
+				   wow_pg_len);
+			ath12k_dbg_dump(ab, ATH12K_DBG_WMI,
+					"wow_event_info_type packet present",
+					"wow_pg_fault ",
+					wow_pg_fault,
+					wow_pg_len);
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
+	struct wmi_wow_ev_arg ev = { };
+	int ret;
+
+	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath12k_wmi_wow_wakeup_host_parse,
+				  &ev);
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
@@ -6430,6 +6492,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_VDEV_DELETE_RESP_EVENTID:
 		ath12k_vdev_delete_resp_event(ab, skb);
 		break;
+	case WMI_WOW_WAKEUP_HOST_EVENTID:
+		ath12k_wmi_event_wow_wakeup_host(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
@@ -6639,3 +6704,45 @@ void ath12k_wmi_detach(struct ath12k_base *ab)
 
 	ath12k_wmi_free_dbring_caps(ab);
 }
+
+int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
+{
+	struct wmi_wow_host_wakeup_ind_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_host_wakeup_ind_cmd *)skb->data;
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
index d89c12bfb009..660f05329db2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4680,6 +4680,169 @@ struct ath12k_wmi_base {
 	struct ath12k_wmi_target_cap_arg *targ_cap;
 };
 
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
+struct wmi_wow_host_wakeup_ind_cmd {
+	__le32 tlv_header;
+	u32 reserved;
+} __packed;
+
+struct wmi_wow_ev_arg {
+	u32 vdev_id;
+	u32 flag;
+	enum wmi_wow_wake_reason wake_reason;
+	u32 data_len;
+};
+
 #define ATH12K_FW_STATS_BUF_SIZE (1024 * 1024)
 
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
@@ -4803,5 +4966,7 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl);
 int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
+int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar);
+int ath12k_wmi_wow_enable(struct ath12k *ar);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
new file mode 100644
index 000000000000..9326191640cf
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
+int ath12k_wow_enable(struct ath12k_base *ab)
+{
+	struct ath12k *ar = ath12k_ab_to_ar(ab, 0);
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
+int ath12k_wow_wakeup(struct ath12k_base *ab)
+{
+	struct ath12k *ar = ath12k_ab_to_ar(ab, 0);
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
index 000000000000..aa101f82674a
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wow.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef ATH12K_WOW_H
+#define ATH12K_WOW_H
+
+#define ATH12K_WOW_RETRY_NUM		3
+#define ATH12K_WOW_RETRY_WAIT_MS	200
+
+#ifdef CONFIG_PM
+
+int ath12k_wow_enable(struct ath12k_base *ab);
+int ath12k_wow_wakeup(struct ath12k_base *ab);
+
+#else
+
+static inline int ath12k_wow_enable(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline int ath12k_wow_wakeup(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+#endif /* ATH12K_WOW_H */
-- 
2.25.1

