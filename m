Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADC51B562
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 03:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiEEBur (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiEEBuq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 21:50:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6364C7A8
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651715228; x=1683251228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nAdAMktDyWBP9kpeVaz5LfBErwfdA4sghpbxdKoohgQ=;
  b=zO/hhhWzR0ZzwMS1nRyZRyOcG0ETkFFu2fLp2CFbUP/g/vF28o/u5JxG
   ZTYcvR63O3iEAWory/QunNwIATyzRBlKX8gSPDuT/hgvO3CjuAr8BHSgP
   XCB9e8JTYi5pkoiZfXuqzgmlQJO5EOTAOOqPm8auQyD31Cd9QNKlq8d27
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 May 2022 18:47:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:47:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 18:47:07 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 18:47:06 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Handle keepalive during wowlan suspend and resume
Date:   Thu, 5 May 2022 09:46:57 +0800
Message-ID: <20220505014657.1549947-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With wowlan enabled and after sleeping for a rather long time,
we are seeing that with some APs, it is not able to wake up
the STA though the correct wake up pattern has been configured.
This is because the host doesn't send keepalive command to
firmware, thus firmware will not send any packet to the AP and
after a specific time the AP kicks out the DUT.

Fix this issue by enabling keepalive before going to suspend
and disabling it after resume back.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 31 ++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h |  4 +++
 drivers/net/wireless/ath/ath11k/wmi.c | 40 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 41 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.c | 34 ++++++++++++++++++++++
 5 files changed, 150 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1957e1713548..6e0484708d6b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9026,3 +9026,34 @@ void ath11k_mac_destroy(struct ath11k_base *ab)
 		pdev->ar = NULL;
 	}
 }
+
+int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
+				 enum wmi_sta_keepalive_method method,
+				 u32 interval)
+{
+	struct ath11k *ar = arvif->ar;
+	struct wmi_sta_keepalive_arg arg = {};
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+		return 0;
+
+	if (!test_bit(WMI_TLV_SERVICE_STA_KEEP_ALIVE, ar->ab->wmi_ab.svc_map))
+		return 0;
+
+	arg.vdev_id = arvif->vdev_id;
+	arg.enabled = 1;
+	arg.method = method;
+	arg.interval = interval;
+
+	ret = ath11k_wmi_sta_keepalive(ar, &arg);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set keepalive on vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 7f93e3a9ca23..57ebfc592b00 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -8,6 +8,7 @@
 
 #include <net/mac80211.h>
 #include <net/cfg80211.h>
+#include "wmi.h"
 
 struct ath11k;
 struct ath11k_base;
@@ -173,4 +174,7 @@ void ath11k_mac_handle_beacon(struct ath11k *ar, struct sk_buff *skb);
 void ath11k_mac_handle_beacon_miss(struct ath11k *ar, u32 vdev_id);
 void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif);
 int ath11k_mac_wait_tx_complete(struct ath11k *ar);
+int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
+				 enum wmi_sta_keepalive_method method,
+				 u32 interval);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 1410114d1d5c..bd8b2f1d4c1e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8959,3 +8959,43 @@ int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar)
 
 	return ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID);
 }
+
+int ath11k_wmi_sta_keepalive(struct ath11k *ar,
+			     const struct wmi_sta_keepalive_arg *arg)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_sta_keepalive_cmd *cmd;
+	struct wmi_sta_keepalive_arp_resp *arp;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd) + sizeof(*arp);
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_sta_keepalive_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_STA_KEEPALIVE_CMD) |
+				     FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = arg->vdev_id;
+	cmd->enabled = arg->enabled;
+	cmd->interval = arg->interval;
+	cmd->method = arg->method;
+
+	if (arg->method == WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE ||
+	    arg->method == WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST) {
+		arp = (struct wmi_sta_keepalive_arp_resp *)(cmd + 1);
+		arp->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_STA_KEEPALVE_ARP_RESPONSE) |
+				 FIELD_PREP(WMI_TLV_LEN, sizeof(*arp) - TLV_HDR_SIZE);
+		arp->src_ip4_addr = arg->src_ip4_addr;
+		arp->dest_ip4_addr = arg->dest_ip4_addr;
+		ether_addr_copy(arp->dest_mac_addr.addr, arg->dest_mac_addr);
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi sta keepalive vdev %d enabled %d method %d interval %d\n",
+		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
+
+	return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 7600e9a52da8..0b53599a3743 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5907,6 +5907,45 @@ struct wmi_pdev_set_geo_table_cmd {
 	u32 rsvd_len;
 } __packed;
 
+struct wmi_sta_keepalive_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 enabled;
+	u32 method; /* WMI_STA_KEEPALIVE_METHOD_ */
+	u32 interval; /* in seconds */
+	/* NOTE: following this structure is the TLV for ARP Response:
+	 * WMI_STA_KEEPALVE_ARP_RESPONSE arp_resp; <-- ARP response
+	 */
+} __packed;
+
+struct wmi_sta_keepalive_arp_resp {
+	u32 tlv_header;
+	u32 src_ip4_addr;
+	u32 dest_ip4_addr;
+	struct wmi_mac_addr dest_mac_addr;
+} __packed;
+
+struct wmi_sta_keepalive_arg {
+	u32 vdev_id;
+	u32 enabled;
+	u32 method;
+	u32 interval;
+	u32 src_ip4_addr;
+	u32 dest_ip4_addr;
+	const u8 dest_mac_addr[ETH_ALEN];
+};
+
+enum wmi_sta_keepalive_method {
+	WMI_STA_KEEPALIVE_METHOD_NULL_FRAME = 1, /* 802.11 NULL frame */
+	WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE = 2, /* ARP response */
+	WMI_STA_KEEPALIVE_METHOD_ETHERNET_LOOPBACK = 3, /*ETHERNET LOOPBACK*/
+	WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST = 4, /* gratuitous ARP req*/
+	WMI_STA_KEEPALIVE_METHOD_MGMT_VENDOR_ACTION = 5, /* vendor action frame */
+};
+
+#define WMI_STA_KEEPALIVE_INTERVAL_DEFAULT	30
+#define WMI_STA_KEEPALIVE_INTERVAL_DISABLE	0
+
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
@@ -6087,5 +6126,7 @@ int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
 				 struct ath11k_vif *arvif);
 int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_val);
 int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar);
+int ath11k_wmi_sta_keepalive(struct ath11k *ar,
+			     const struct wmi_sta_keepalive_arg *arg);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 9d088cebef03..b3e65cd13d83 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -640,6 +640,24 @@ static int ath11k_wow_protocol_offload(struct ath11k *ar, bool enable)
 	return 0;
 }
 
+static int ath11k_wow_set_keepalive(struct ath11k *ar,
+				    enum wmi_sta_keepalive_method method,
+				    u32 interval)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_mac_vif_set_keepalive(arvif, method, interval);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -691,6 +709,14 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 		goto cleanup;
 	}
 
+	ret = ath11k_wow_set_keepalive(ar,
+				       WMI_STA_KEEPALIVE_METHOD_NULL_FRAME,
+				       WMI_STA_KEEPALIVE_INTERVAL_DEFAULT);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to enable wow keepalive: %d\n", ret);
+		goto cleanup;
+	}
+
 	ret = ath11k_wow_enable(ar->ab);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start wow: %d\n", ret);
@@ -786,6 +812,14 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 		goto exit;
 	}
 
+	ret = ath11k_wow_set_keepalive(ar,
+				       WMI_STA_KEEPALIVE_METHOD_NULL_FRAME,
+				       WMI_STA_KEEPALIVE_INTERVAL_DISABLE);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to disable wow keepalive: %d\n", ret);
+		goto exit;
+	}
+
 exit:
 	if (ret) {
 		switch (ar->state) {

base-commit: b04efb72cd9d2d471a14f0a5758873f6c78923c2
-- 
2.25.1

