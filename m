Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB1C24A4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfI3PtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 11:49:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfI3PtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 11:49:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5DB73601D4; Mon, 30 Sep 2019 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569858561;
        bh=kDZjUQQPWUFFLx3eI5ztFh1+pHCxCQnj63t+ornQDaE=;
        h=Subject:From:To:Cc:Date:From;
        b=kRLzr3cS30wvBWjiAKUvCq/81/jvcSmpKqN2BQw3oNNkzHbBeDhkeVsiScKve5/Hy
         janqutnfUUz2EJzvaw9Ubn+EyWgHR9rG+G6CklfCvZGgVlgT6la7IzAPJuCDMBLW4j
         inw0Egi3i/pdayy2V2Ztk/BGZ5s5MtR3WRGxw2IQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF3036055C;
        Mon, 30 Sep 2019 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569858560;
        bh=kDZjUQQPWUFFLx3eI5ztFh1+pHCxCQnj63t+ornQDaE=;
        h=Subject:From:To:Cc:Date:From;
        b=fo1ehAz1zNj1JL2AY0Dbe+ARosUTOmyEBIAKyqgBVt3Bc70QzZpLImrFjCCk/vyoW
         FQvkgqPqenenhekErwfqh50RKoeUIbOJAIAVEVPuzgtZwqJ7WG2uqtafWC75G2W/a6
         96eP7jQ71jIkP8HE4B9y5oDFNCIRoMyY7h51vQdc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF3036055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Subject: [PATCH] ath10k: add support for hardware rfkill
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 30 Sep 2019 18:49:17 +0300
Message-ID: <156985855686.10126.201242458794108566.stgit@potku.adurom.net>
User-Agent: StGit/0.17.1-17-ge4e0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

When hardware rfkill is enabled in the firmware it will report the
capability via using WMI_TLV_SYS_CAP_INFO_RFKILL bit in the WMI_SERVICE_READY
event to the host. ath10k will check the capability, and if it is enabled then
ath10k will set the GPIO information to firmware using WMI_PDEV_SET_PARAM. When
the firmware detects hardware rfkill is enabled by the user, it will report it
via WMI_RFKILL_STATE_CHANGE_EVENTID. Once ath10k receives the event it will
send wmi command WMI_PDEV_SET_PARAM to the firmware to enable/disable the radio
and also notifies cfg80211.

We can't power off the device when rfkill is enabled, as otherwise the
firmware would not be able to detect GPIO changes and report them to the
host. So when rfkill is enabled, we need to keep the firmware running.

Tested with QCA6174 PCI with firmware
WLAN.RM.4.4.1-00109-QCARMSWPZ-1.

Signed-off-by: Alan Liu <alanliu@codeaurora.org>
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.h    |    5 ++
 drivers/net/wireless/ath/ath10k/hw.c      |    3 +
 drivers/net/wireless/ath/ath10k/hw.h      |    3 +
 drivers/net/wireless/ath/ath10k/mac.c     |   79 +++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/mac.h     |    1 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |   49 ++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |   27 ++++++++++
 drivers/net/wireless/ath/ath10k/wmi.c     |    9 +++
 drivers/net/wireless/ath/ath10k/wmi.h     |    3 +
 9 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 96c5d0733214..0f2200f3316a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -983,6 +983,11 @@ struct ath10k {
 	u32 low_5ghz_chan;
 	u32 high_5ghz_chan;
 	bool ani_enabled;
+	u32 sys_cap_info;
+
+	/* protected by data_lock */
+	bool hw_rfkill_on;
+
 	/* protected by conf_mutex */
 	u8 ps_state_enable;
 
diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index 2a23bf72a566..09bb6bdc69a2 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -155,6 +155,9 @@ const struct ath10k_hw_values qca6174_values = {
 	.num_target_ce_config_wlan	= 7,
 	.ce_desc_meta_data_mask		= 0xFFFC,
 	.ce_desc_meta_data_lsb		= 2,
+	.rfkill_pin			= 16,
+	.rfkill_cfg			= 0,
+	.rfkill_on_level		= 1,
 };
 
 const struct ath10k_hw_values qca99x0_values = {
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index ddb1d23ec6de..5358da5ff22e 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -379,6 +379,9 @@ struct ath10k_hw_values {
 	u8 num_target_ce_config_wlan;
 	u16 ce_desc_meta_data_mask;
 	u8 ce_desc_meta_data_lsb;
+	u32 rfkill_pin;
+	u32 rfkill_cfg;
+	bool rfkill_on_level;
 };
 
 extern const struct ath10k_hw_values qca988x_values;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 0b666c5cf31d..8fb989e139c9 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -12,6 +12,7 @@
 #include <linux/etherdevice.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 #include "hif.h"
 #include "core.h"
@@ -4769,6 +4770,63 @@ static int __ath10k_fetch_bb_timing_dt(struct ath10k *ar,
 	return 0;
 }
 
+static int ath10k_mac_rfkill_config(struct ath10k *ar)
+{
+	u32 param;
+	int ret;
+
+	if (ar->hw_values->rfkill_pin == 0) {
+		ath10k_warn(ar, "ath10k does not support hardware rfkill with this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC,
+		   "mac rfkill_pin %d rfkill_cfg %d rfkill_on_level %d",
+		   ar->hw_values->rfkill_pin, ar->hw_values->rfkill_cfg,
+		   ar->hw_values->rfkill_on_level);
+
+	param = FIELD_PREP(WMI_TLV_RFKILL_CFG_RADIO_LEVEL,
+			   ar->hw_values->rfkill_on_level) |
+		FIELD_PREP(WMI_TLV_RFKILL_CFG_GPIO_PIN_NUM,
+			   ar->hw_values->rfkill_pin) |
+		FIELD_PREP(WMI_TLV_RFKILL_CFG_PIN_AS_GPIO,
+			   ar->hw_values->rfkill_cfg);
+
+	ret = ath10k_wmi_pdev_set_param(ar,
+					ar->wmi.pdev_param->rfkill_config,
+					param);
+	if (ret) {
+		ath10k_warn(ar,
+			    "failed to set rfkill config 0x%x: %d\n",
+			    param, ret);
+		return ret;
+	}
+	return 0;
+}
+
+int ath10k_mac_rfkill_enable_radio(struct ath10k *ar, bool enable)
+{
+	enum wmi_tlv_rfkill_enable_radio param;
+	int ret;
+
+	if (enable)
+		param = WMI_TLV_RFKILL_ENABLE_RADIO_ON;
+	else
+		param = WMI_TLV_RFKILL_ENABLE_RADIO_OFF;
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac rfkill enable %d", param);
+
+	ret = ath10k_wmi_pdev_set_param(ar, ar->wmi.pdev_param->rfkill_enable,
+					param);
+	if (ret) {
+		ath10k_warn(ar, "failed to set rfkill enable param %d: %d\n",
+			    param, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int ath10k_start(struct ieee80211_hw *hw)
 {
 	struct ath10k *ar = hw->priv;
@@ -4803,6 +4861,16 @@ static int ath10k_start(struct ieee80211_hw *hw)
 		goto err;
 	}
 
+	spin_lock_bh(&ar->data_lock);
+
+	if (ar->hw_rfkill_on) {
+		ar->hw_rfkill_on = false;
+		spin_unlock_bh(&ar->data_lock);
+		goto err;
+	}
+
+	spin_unlock_bh(&ar->data_lock);
+
 	ret = ath10k_hif_power_up(ar, ATH10K_FIRMWARE_MODE_NORMAL);
 	if (ret) {
 		ath10k_err(ar, "Could not init hif: %d\n", ret);
@@ -4816,6 +4884,14 @@ static int ath10k_start(struct ieee80211_hw *hw)
 		goto err_power_down;
 	}
 
+	if (ar->sys_cap_info & WMI_TLV_SYS_CAP_INFO_RFKILL) {
+		ret = ath10k_mac_rfkill_config(ar);
+		if (ret && ret != -EOPNOTSUPP) {
+			ath10k_warn(ar, "failed to configure rfkill: %d", ret);
+			goto err_core_stop;
+		}
+	}
+
 	param = ar->wmi.pdev_param->pmf_qos;
 	ret = ath10k_wmi_pdev_set_param(ar, param, 1);
 	if (ret) {
@@ -4975,7 +5051,8 @@ static void ath10k_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&ar->conf_mutex);
 	if (ar->state != ATH10K_STATE_OFF) {
-		ath10k_halt(ar);
+		if (!ar->hw_rfkill_on)
+			ath10k_halt(ar);
 		ar->state = ATH10K_STATE_OFF;
 	}
 	mutex_unlock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath10k/mac.h b/drivers/net/wireless/ath/ath10k/mac.h
index 17e4d65edbe0..8f3a4af45361 100644
--- a/drivers/net/wireless/ath/ath10k/mac.h
+++ b/drivers/net/wireless/ath/ath10k/mac.h
@@ -75,6 +75,7 @@ struct ieee80211_txq *ath10k_mac_txq_lookup(struct ath10k *ar,
 					    u8 tid);
 int ath10k_mac_ext_resource_config(struct ath10k *ar, u32 val);
 void ath10k_mac_wait_tx_complete(struct ath10k *ar);
+int ath10k_mac_rfkill_enable_radio(struct ath10k *ar, bool enable);
 
 static inline void ath10k_tx_h_seq_no(struct ieee80211_vif *vif,
 				      struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 17b544559048..1630519e0f86 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -415,6 +415,49 @@ static int ath10k_wmi_tlv_event_tx_pause(struct ath10k *ar,
 	return 0;
 }
 
+static void ath10k_wmi_tlv_event_rfkill_state_change(struct ath10k *ar,
+						     struct sk_buff *skb)
+{
+	const struct wmi_tlv_rfkill_state_change_ev *ev;
+	const void **tb;
+	bool radio;
+	int ret;
+
+	tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath10k_warn(ar,
+			    "failed to parse rfkill state change event: %d\n",
+			    ret);
+		return;
+	}
+
+	ev = tb[WMI_TLV_TAG_STRUCT_RFKILL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC,
+		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
+		   __le32_to_cpu(ev->gpio_pin_num),
+		   __le32_to_cpu(ev->int_type),
+		   __le32_to_cpu(ev->radio_state));
+
+	radio = (__le32_to_cpu(ev->radio_state) == WMI_TLV_RFKILL_RADIO_STATE_ON);
+
+	spin_lock_bh(&ar->data_lock);
+
+	if (!radio)
+		ar->hw_rfkill_on = true;
+
+	spin_unlock_bh(&ar->data_lock);
+
+	/* notify cfg80211 radio state change */
+	ath10k_mac_rfkill_enable_radio(ar, radio);
+	wiphy_rfkill_set_hw_state(ar->hw->wiphy, !radio);
+}
+
 static int ath10k_wmi_tlv_event_temperature(struct ath10k *ar,
 					    struct sk_buff *skb)
 {
@@ -809,6 +852,9 @@ static void ath10k_wmi_tlv_op_rx(struct ath10k *ar, struct sk_buff *skb)
 	case WMI_TLV_TX_PAUSE_EVENTID:
 		ath10k_wmi_tlv_event_tx_pause(ar, skb);
 		break;
+	case WMI_TLV_RFKILL_STATE_CHANGE_EVENTID:
+		ath10k_wmi_tlv_event_rfkill_state_change(ar, skb);
+		break;
 	case WMI_TLV_PDEV_TEMPERATURE_EVENTID:
 		ath10k_wmi_tlv_event_temperature(ar, skb);
 		break;
@@ -1397,6 +1443,7 @@ static int ath10k_wmi_tlv_op_pull_svc_rdy_ev(struct ath10k *ar,
 	arg->num_mem_reqs = ev->num_mem_reqs;
 	arg->service_map = svc_bmap;
 	arg->service_map_len = ath10k_wmi_tlv_len(svc_bmap);
+	arg->sys_cap_info = ev->sys_cap_info;
 
 	ret = ath10k_wmi_tlv_iter(ar, mem_reqs, ath10k_wmi_tlv_len(mem_reqs),
 				  ath10k_wmi_tlv_parse_mem_reqs, arg);
@@ -4399,6 +4446,8 @@ static struct wmi_pdev_param_map wmi_tlv_pdev_param_map = {
 	.wapi_mbssid_offset = WMI_PDEV_PARAM_UNSUPPORTED,
 	.arp_srcaddr = WMI_PDEV_PARAM_UNSUPPORTED,
 	.arp_dstaddr = WMI_PDEV_PARAM_UNSUPPORTED,
+	.rfkill_config = WMI_TLV_PDEV_PARAM_HW_RFKILL_CONFIG,
+	.rfkill_enable = WMI_TLV_PDEV_PARAM_RFKILL_ENABLE,
 };
 
 static struct wmi_peer_param_map wmi_tlv_peer_param_map = {
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
index bdf6c433f592..4117b466c85f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -7,6 +7,8 @@
 #ifndef _WMI_TLV_H
 #define _WMI_TLV_H
 
+#include <linux/bitops.h>
+
 #define WMI_TLV_CMD(grp_id) (((grp_id) << 12) | 0x1)
 #define WMI_TLV_EV(grp_id) (((grp_id) << 12) | 0x1)
 #define WMI_TLV_CMD_UNSUPPORTED 0
@@ -2401,6 +2403,31 @@ struct wmi_tlv_tdls_peer_event {
 	__le32 vdev_id;
 } __packed;
 
+enum wmi_tlv_sys_cap_info_flags {
+	WMI_TLV_SYS_CAP_INFO_RXTX_LED	= BIT(0),
+	WMI_TLV_SYS_CAP_INFO_RFKILL	= BIT(1),
+};
+
+#define WMI_TLV_RFKILL_CFG_GPIO_PIN_NUM		GENMASK(5, 0)
+#define WMI_TLV_RFKILL_CFG_RADIO_LEVEL		BIT(6)
+#define WMI_TLV_RFKILL_CFG_PIN_AS_GPIO		GENMASK(10, 7)
+
+enum wmi_tlv_rfkill_enable_radio {
+	WMI_TLV_RFKILL_ENABLE_RADIO_ON	= 0,
+	WMI_TLV_RFKILL_ENABLE_RADIO_OFF	= 1,
+};
+
+enum wmi_tlv_rfkill_radio_state {
+	WMI_TLV_RFKILL_RADIO_STATE_OFF	= 1,
+	WMI_TLV_RFKILL_RADIO_STATE_ON	= 2,
+};
+
+struct wmi_tlv_rfkill_state_change_ev {
+	__le32 gpio_pin_num;
+	__le32 int_type;
+	__le32 radio_state;
+};
+
 void ath10k_wmi_tlv_attach(struct ath10k *ar);
 
 enum wmi_nlo_auth_algorithm {
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 1935acbf0449..92ca25233d7f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5415,6 +5415,12 @@ ath10k_wmi_10x_op_pull_svc_rdy_ev(struct ath10k *ar, struct sk_buff *skb,
 	arg->service_map = ev->wmi_service_bitmap;
 	arg->service_map_len = sizeof(ev->wmi_service_bitmap);
 
+	/* Deliberately skipping ev->sys_cap_info as WMI and WMI-TLV have
+	 * different values. We would need a translation to handle that,
+	 * but as we don't currently need anything from sys_cap_info from
+	 * WMI interface (only from WMI-TLV) safest it to skip it.
+	 */
+
 	n = min_t(size_t, __le32_to_cpu(arg->num_mem_reqs),
 		  ARRAY_SIZE(arg->mem_reqs));
 	for (i = 0; i < n; i++)
@@ -5468,9 +5474,12 @@ static void ath10k_wmi_event_service_ready_work(struct work_struct *work)
 	ar->high_2ghz_chan = __le32_to_cpu(arg.high_2ghz_chan);
 	ar->low_5ghz_chan = __le32_to_cpu(arg.low_5ghz_chan);
 	ar->high_5ghz_chan = __le32_to_cpu(arg.high_5ghz_chan);
+	ar->sys_cap_info = __le32_to_cpu(arg.sys_cap_info);
 
 	ath10k_dbg_dump(ar, ATH10K_DBG_WMI, NULL, "wmi svc: ",
 			arg.service_map, arg.service_map_len);
+	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi sys_cap_info 0x%x\n",
+		   ar->sys_cap_info);
 
 	if (ar->num_rf_chains > ar->max_spatial_stream) {
 		ath10k_warn(ar, "hardware advertises support for more spatial streams than it should (%d > %d)\n",
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 8db2e8a0568e..1fa858f4364e 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3793,6 +3793,8 @@ struct wmi_pdev_param_map {
 	u32 arp_srcaddr;
 	u32 arp_dstaddr;
 	u32 enable_btcoex;
+	u32 rfkill_config;
+	u32 rfkill_enable;
 };
 
 #define WMI_PDEV_PARAM_UNSUPPORTED 0
@@ -6882,6 +6884,7 @@ struct wmi_svc_rdy_ev_arg {
 	__le32 high_2ghz_chan;
 	__le32 low_5ghz_chan;
 	__le32 high_5ghz_chan;
+	__le32 sys_cap_info;
 	const __le32 *service_map;
 	size_t service_map_len;
 	const struct wlan_host_mem_req *mem_reqs[WMI_MAX_MEM_REQS];

