Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69692D7D16
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395394AbgLKRiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:38:13 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:27575 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395315AbgLKRhA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:37:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708195; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=gYPWwtYrllA9zok31wUQ9NC1blUWbSVd/DPJF/5+WQk=; b=rmTsmjhmBSGubKG99yZNVfzeAw+oV76I8330xAggQtt7cClEAvduGE9ooftXDOHf03tqRf5R
 WuieHCtjbU9rn9zX/bnOXz19zhD6qVVwqYAxwRW5n6UOLV7mHKfZHX0PIY6cmBhXlRLUKV69
 qCBUAyfOZBk5AjNbp8bCeS/w80g=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fd3ae0835a25d1b16de70ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5CE98C43462; Fri, 11 Dec 2020 17:36:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A972C433ED;
        Fri, 11 Dec 2020 17:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A972C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/10] ath11k: implement WoW enable and wakeup commands
Date:   Fri, 11 Dec 2020 19:35:48 +0200
Message-Id: <1607708150-21066-9-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Implement wow enable ane wow wakeup commands which are needed for suspend.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/core.c   |   1 +
 drivers/net/wireless/ath/ath11k/core.h   |   5 +
 drivers/net/wireless/ath/ath11k/wmi.c    |  99 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h    | 165 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.c    |  73 ++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.h    |  10 ++
 7 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath11k/wow.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index c41d87bd025a..c1fce4159f1f 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -16,7 +16,8 @@ ath11k-y += core.o \
 	    ce.o \
 	    peer.o \
 	    dbring.o \
-	    hw.o
+	    hw.o \
+	    wow.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 1c2789ce6239..451748fa8fff 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -969,6 +969,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
+	init_completion(&ab->wow.wakeup_completed);
 
 	ab->dev = dev;
 	ab->bus_params = *bus_params;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 689aa24fe28f..ba8f2222169d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -466,6 +466,7 @@ struct ath11k {
 		struct ieee80211_sband_iftype_data
 			iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 	} mac;
+
 	unsigned long dev_flags;
 	unsigned int filter_flags;
 	unsigned long monitor_flags;
@@ -672,6 +673,10 @@ struct ath11k_base {
 		const struct ath11k_hif_ops *ops;
 	} hif;
 
+	struct {
+		struct completion wakeup_completed;
+	} wow;
+
 	struct ath11k_ce ce;
 	struct timer_list rx_replenish_retry;
 	struct ath11k_hal hal;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 95ebb105dfd7..da4b546b62cb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6700,6 +6700,59 @@ static void ath11k_probe_resp_tx_status_event(struct ath11k_base *ab,
 	kfree(tb);
 }
 
+static int ath11k_wmi_tlv_wow_wakeup_host_parse(struct ath11k_base *ab,
+						u16 tag, u16 len,
+						const void *ptr, void *data)
+{
+	struct wmi_wow_ev_arg *ev = data;
+	const char *wow_pg_fault;
+	int wow_pg_len;
+
+	switch (tag) {
+	case WMI_TAG_WOW_EVENT_INFO:
+		memcpy(ev, ptr, sizeof(*ev));
+		ath11k_dbg(ab, ATH11K_DBG_WMI, "wow wakeup host reason %d %s\n",
+			   ev->wake_reason, wow_reason(ev->wake_reason));
+		break;
+
+	case WMI_TAG_ARRAY_BYTE:
+		if (ev && ev->wake_reason == WOW_REASON_PAGE_FAULT) {
+			wow_pg_fault = ptr;
+			/* the first 4 bytes are length */
+			wow_pg_len = *(int *)wow_pg_fault;
+			wow_pg_fault += sizeof(int);
+			ath11k_dbg(ab, ATH11K_DBG_WMI, "wow data_len = %d\n",
+				   wow_pg_len);
+			ath11k_dbg_dump(ab, ATH11K_DBG_WMI,
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
+static void ath11k_wmi_event_wow_wakeup_host(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	struct wmi_wow_ev_arg ev = { };
+	int ret;
+
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tlv_wow_wakeup_host_parse,
+				  &ev);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse wmi wow tlv: %d\n", ret);
+		return;
+	}
+
+	complete(&ab->wow.wakeup_completed);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -6807,6 +6860,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_VDEV_DELETE_RESP_EVENTID:
 		ath11k_vdev_delete_resp_event(ab, skb);
 		break;
+	case WMI_WOW_WAKEUP_HOST_EVENTID:
+		ath11k_wmi_event_wow_wakeup_host(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
@@ -7021,3 +7077,46 @@ void ath11k_wmi_detach(struct ath11k_base *ab)
 
 	ath11k_wmi_free_dbring_caps(ab);
 }
+
+int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
+{
+	struct wmi_wow_host_wakeup_ind *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_host_wakeup_ind *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_WOW_HOSTWAKEUP_FROM_SLEEP_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow host wakeup ind\n");
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+}
+
+int ath11k_wmi_wow_enable(struct ath11k *ar)
+{
+	struct wmi_wow_enable_cmd *cmd;
+	struct sk_buff *skb;
+	int len;
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_enable_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_WOW_ENABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->enable = 1;
+	cmd->pause_iface_config = WOW_IFACE_PAUSE_ENABLED;
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow enable\n");
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 62840717a946..993674228c9e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5044,6 +5044,169 @@ struct ath11k_wmi_base {
 	struct ath11k_targ_cap *targ_cap;
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
+	u32 tlv_header;
+	u32 enable;
+	u32 pause_iface_config;
+	u32 flags;
+}  __packed;
+
+struct wmi_wow_host_wakeup_ind {
+	u32 tlv_header;
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
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
@@ -5173,5 +5336,7 @@ int ath11k_wmi_probe_resp_tmpl(struct ath11k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl);
 int ath11k_wmi_set_hw_mode(struct ath11k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
+int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar);
+int ath11k_wmi_wow_enable(struct ath11k *ar);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
new file mode 100644
index 000000000000..43c62e99dd0e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
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
+int ath11k_wow_enable(struct ath11k_base *ab)
+{
+	struct ath11k *ar = ath11k_ab_to_ar(ab, 0);
+	int i, ret;
+
+	clear_bit(ATH11K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
+
+	for (i = 0; i < ATH11K_WOW_RETRY_NUM; i++) {
+		reinit_completion(&ab->htc_suspend);
+
+		ret = ath11k_wmi_wow_enable(ar);
+		if (ret) {
+			ath11k_warn(ab, "failed to issue wow enable: %d\n", ret);
+			return ret;
+		}
+
+		ret = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
+		if (ret == 0) {
+			ath11k_warn(ab,
+				    "timed out while waiting for htc suspend completion\n");
+			return -ETIMEDOUT;
+		}
+
+		if (test_bit(ATH11K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags))
+			/* success, suspend complete received */
+			return 0;
+
+		ath11k_warn(ab, "htc suspend not complete, retrying (try %d)\n",
+			    i);
+		msleep(ATH11K_WOW_RETRY_WAIT_MS);
+	}
+
+	ath11k_warn(ab, "htc suspend not complete, failing after %d tries\n", i);
+
+	return -ETIMEDOUT;
+}
+
+int ath11k_wow_wakeup(struct ath11k_base *ab)
+{
+	struct ath11k *ar = ath11k_ab_to_ar(ab, 0);
+	int ret;
+
+	reinit_completion(&ab->wow.wakeup_completed);
+
+	ret = ath11k_wmi_wow_host_wakeup_ind(ar);
+	if (ret) {
+		ath11k_warn(ab, "failed to send wow wakeup indication: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ret = wait_for_completion_timeout(&ab->wow.wakeup_completed, 3 * HZ);
+	if (ret == 0) {
+		ath11k_warn(ab, "timed out while waiting for wow wakeup completion\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/wow.h b/drivers/net/wireless/ath/ath11k/wow.h
new file mode 100644
index 000000000000..dabc4ee63cf6
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/wow.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#define ATH11K_WOW_RETRY_NUM		3
+#define ATH11K_WOW_RETRY_WAIT_MS	200
+
+int ath11k_wow_enable(struct ath11k_base *ab);
+int ath11k_wow_wakeup(struct ath11k_base *ab);
-- 
2.7.4

