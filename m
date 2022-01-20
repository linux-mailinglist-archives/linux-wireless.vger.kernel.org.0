Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7EF494B7B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jan 2022 11:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359794AbiATKOF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jan 2022 05:14:05 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:4178 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359789AbiATKOF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jan 2022 05:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642673645; x=1674209645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7JcXIAgKrhaNqqWlTv6Hl87FuFCgVnT4SRel5aqFJ/0=;
  b=TGav15FX8cG5SLpXPJfzOwHtuuRO2s43CygJSrPvuEIAPB7635/7/n6o
   fjikkyqk0MIrTnCusmERzstrSL0KQGdeXxd+C/hZDR4yz+mnZDRzlgw/Z
   RFTKFO70fyq7OWk2FMM2XbFFconDOq9FTmgwGTl22xe8t0lScWkcavTrQ
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jan 2022 02:14:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 02:14:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 02:14:04 -0800
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 02:14:03 -0800
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/6] ath11k: support ARP and NS offload
Date:   Thu, 20 Jan 2022 18:13:26 +0800
Message-ID: <1642673607-8896-6-git-send-email-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642673607-8896-1-git-send-email-quic_cjhuang@quicinc.com>
References: <1642673607-8896-1-git-send-email-quic_cjhuang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support ARP and NS offload in WoW state.

Tested this way: put machine A with QCA6390 to WoW state,
ping/ping6 machine A from another machine B, check sniffer to see
any ARP response and Neighbour advertisement from machine A.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  18 ++++
 drivers/net/wireless/ath/ath11k/mac.c  | 114 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 149 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  46 ++++++++++
 drivers/net/wireless/ath/ath11k/wow.c  |  52 ++++++++++++
 5 files changed, 379 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6010c0b..b37782f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -212,6 +212,23 @@ enum ath11k_monitor_flags {
 	ATH11K_FLAG_MONITOR_VDEV_CREATED,
 };
 
+#define ATH11K_IPV6_UC_TYPE     0
+#define ATH11K_IPV6_AC_TYPE     1
+
+#define ATH11K_IPV6_MAX_COUNT   16
+#define ATH11K_IPV4_MAX_COUNT   2
+
+struct ath11k_arp_ns_offload {
+	u8  ipv4_addr[ATH11K_IPV4_MAX_COUNT][4];
+	u32 ipv4_count;
+	u32 ipv6_count;
+	u8  ipv6_addr[ATH11K_IPV6_MAX_COUNT][16];
+	u8  self_ipv6_addr[ATH11K_IPV6_MAX_COUNT][16];
+	u8  ipv6_type[ATH11K_IPV6_MAX_COUNT];
+	bool ipv6_valid[ATH11K_IPV6_MAX_COUNT];
+	u8  mac_addr[ETH_ALEN];
+};
+
 struct ath11k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -263,6 +280,7 @@ struct ath11k_vif {
 	bool bcca_zero_sent;
 	bool do_not_send_tmpl;
 	struct ieee80211_chanctx_conf chanctx;
+	struct ath11k_arp_ns_offload arp_ns_offload;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2474772..a773c9d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6,6 +6,11 @@
 
 #include <net/mac80211.h>
 #include <linux/etherdevice.h>
+#include <linux/bitfield.h>
+#include <linux/inetdevice.h>
+#include <net/if_inet6.h>
+#include <net/ipv6.h>
+
 #include "mac.h"
 #include "core.h"
 #include "debug.h"
@@ -2994,6 +2999,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	int ret = 0;
 	u8 rateidx;
 	u32 rate;
+	u32 ipv4_cnt;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3286,6 +3292,18 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
 		ath11k_mac_fils_discovery(arvif, info);
 
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		ipv4_cnt = min(info->arp_addr_cnt, ATH11K_IPV4_MAX_COUNT);
+		memcpy(arvif->arp_ns_offload.ipv4_addr, info->arp_addr_list,
+		       ipv4_cnt * sizeof(u32));
+		memcpy(arvif->arp_ns_offload.mac_addr, vif->addr, ETH_ALEN);
+		arvif->arp_ns_offload.ipv4_count = ipv4_cnt;
+
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "arp_addr_cnt:%d, %pM, %pI4\n",
+			   info->arp_addr_cnt,
+			   vif->addr, arvif->arp_ns_offload.ipv4_addr);
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -7826,6 +7844,97 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 }
 
+static void ath11k_generate_ns_mc_addr(struct ath11k *ar, struct ath11k_arp_ns_offload *offload)
+{
+	int i;
+
+	for (i = 0; i < offload->ipv6_count; i++) {
+		offload->self_ipv6_addr[i][0] = 0xFF;
+		offload->self_ipv6_addr[i][1] = 0x02;
+		offload->self_ipv6_addr[i][11] = 0x01;
+		offload->self_ipv6_addr[i][12] = 0xFF;
+		offload->self_ipv6_addr[i][13] =
+					offload->ipv6_addr[i][13];
+		offload->self_ipv6_addr[i][14] =
+					offload->ipv6_addr[i][14];
+		offload->self_ipv6_addr[i][15] =
+					offload->ipv6_addr[i][15];
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "NS solicited addr %pI6\n",
+			   offload->self_ipv6_addr[i]);
+	}
+}
+
+static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct inet6_dev *idev)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_arp_ns_offload *offload;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct inet6_ifaddr *ifa6;
+	struct ifacaddr6 *ifaca6;
+	struct list_head *p;
+	u32 count, scope;
+
+	offload = &arvif->arp_ns_offload;
+	count = 0;
+
+	read_lock_bh(&idev->lock);
+
+	memset(offload->ipv6_addr, 0, sizeof(offload->ipv6_addr));
+	memset(offload->self_ipv6_addr, 0, sizeof(offload->self_ipv6_addr));
+	memcpy(offload->mac_addr, vif->addr, ETH_ALEN);
+
+	/* get unicast address */
+	list_for_each(p, &idev->addr_list) {
+		if (count >= ATH11K_IPV6_MAX_COUNT)
+			goto generate;
+
+		ifa6 = list_entry(p, struct inet6_ifaddr, if_list);
+		if (ifa6->flags & IFA_F_DADFAILED)
+			continue;
+		scope = ipv6_addr_src_scope(&ifa6->addr);
+		if (scope == IPV6_ADDR_SCOPE_LINKLOCAL ||
+		    scope == IPV6_ADDR_SCOPE_GLOBAL) {
+			memcpy(offload->ipv6_addr[count], &ifa6->addr.s6_addr,
+			       sizeof(ifa6->addr.s6_addr));
+			offload->ipv6_type[count] = ATH11K_IPV6_UC_TYPE;
+			ath11k_dbg(ar->ab, ATH11K_DBG_DATA, "Count %d, Ipv6 UC %pI6, scope:%s\n",
+				   count, offload->ipv6_addr[count],
+				   scope == IPV6_ADDR_SCOPE_LINKLOCAL ? "LOCAL" : "GLOBAL");
+			count++;
+		} else {
+			ath11k_info(ar->ab, "Not supported scope %d\n", scope);
+		}
+	}
+
+	/* get anycast address */
+	for (ifaca6 = idev->ac_list; ifaca6; ifaca6 = ifaca6->aca_next) {
+		if (count >= ATH11K_IPV6_MAX_COUNT)
+			goto generate;
+
+		scope = ipv6_addr_src_scope(&ifaca6->aca_addr);
+		if (scope == IPV6_ADDR_SCOPE_LINKLOCAL ||
+		    scope == IPV6_ADDR_SCOPE_GLOBAL) {
+			memcpy(offload->ipv6_addr[count], &ifaca6->aca_addr,
+			       sizeof(ifaca6->aca_addr));
+			offload->ipv6_type[count] = ATH11K_IPV6_AC_TYPE;
+			ath11k_dbg(ar->ab, ATH11K_DBG_DATA, "Count %d, Ipv6 AC %pI6, scope:%s\n",
+				   count, offload->ipv6_addr[count],
+				   scope == IPV6_ADDR_SCOPE_LINKLOCAL ? "LOCAL" : "GLOBAL");
+			count++;
+		} else {
+			ath11k_info(ar->ab, "Not supported scope %d\n", scope);
+		}
+	}
+
+generate:
+	offload->ipv6_count = count;
+	read_unlock_bh(&idev->lock);
+	/* generate ns multicast address */
+	ath11k_generate_ns_mc_addr(ar, offload);
+}
+
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
 	.start                          = ath11k_mac_op_start,
@@ -7871,6 +7980,11 @@ static const struct ieee80211_ops ath11k_ops = {
 #ifdef CONFIG_ATH11K_DEBUGFS
 	.sta_add_debugfs		= ath11k_debugfs_sta_op_add,
 #endif
+
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change = ath11k_mac_op_ipv6_changed,
+#endif
+
 };
 
 static void ath11k_mac_update_ch_list(struct ath11k *ar,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 706dcd8..da30824 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8084,3 +8084,152 @@ int ath11k_wmi_wow_config_pno(struct ath11k *ar, u32 vdev_id,
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
 }
 
+static void ath11k_wmi_fill_ns_offload(struct ath11k *ar,
+				       struct ath11k_arp_ns_offload *offload,
+				       u8 **ptr,
+				       bool enable,
+				       bool ext)
+{
+	struct wmi_ns_offload_tuple *ns;
+	struct wmi_tlv *tlv;
+	u8 *buf_ptr = *ptr;
+	u32 ns_cnt, ns_ext_tuples;
+	int i, max_offloads;
+
+	ns_cnt = offload->ipv6_count;
+
+	tlv  = (struct wmi_tlv *)buf_ptr;
+	if (ext) {
+		ns_ext_tuples = offload->ipv6_count - WMI_MAX_NS_OFFLOADS;
+		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+			      FIELD_PREP(WMI_TLV_LEN, ns_ext_tuples * sizeof(*ns));
+		i = WMI_MAX_NS_OFFLOADS;
+		max_offloads = offload->ipv6_count;
+	} else {
+		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+			      FIELD_PREP(WMI_TLV_LEN, WMI_MAX_NS_OFFLOADS * sizeof(*ns));
+		i = 0;
+		max_offloads = WMI_MAX_NS_OFFLOADS;
+	}
+
+	buf_ptr += sizeof(*tlv);
+	for (; i < max_offloads; i++) {
+		ns = (struct wmi_ns_offload_tuple *)buf_ptr;
+		ns->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_NS_OFFLOAD_TUPLE) |
+				 FIELD_PREP(WMI_TLV_LEN, sizeof(*ns) - TLV_HDR_SIZE);
+
+		if (enable) {
+			if (i < ns_cnt)
+				ns->flags |= WMI_NSOL_FLAGS_VALID;
+
+			memcpy(ns->target_ipaddr[0], offload->ipv6_addr[i], 16);
+			memcpy(ns->solicitation_ipaddr, offload->self_ipv6_addr[i], 16);
+			ath11k_ce_byte_swap(ns->target_ipaddr[0], 16);
+			ath11k_ce_byte_swap(ns->solicitation_ipaddr, 16);
+
+			if (offload->ipv6_type[i]) {
+				ns->flags |=
+					WMI_NSOL_FLAGS_IS_IPV6_ANYCAST;
+			}
+
+			memcpy(ns->target_mac.addr, offload->mac_addr, ETH_ALEN);
+			ath11k_ce_byte_swap(ns->target_mac.addr, 8);
+			if (ns->target_mac.word0 != 0 ||
+			    ns->target_mac.word1 != 0) {
+				ns->flags |= WMI_NSOL_FLAGS_MAC_VALID;
+			}
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+				   "Index %d NS solicited %pI6, target %pI6",
+				   i, ns->solicitation_ipaddr,
+				   ns->target_ipaddr[0]);
+		}
+		buf_ptr += sizeof(*ns);
+	}
+	*ptr = buf_ptr;
+}
+
+static void ath11k_wmi_fill_arp_offload(struct ath11k *ar,
+					struct ath11k_arp_ns_offload *offload,
+					u8 **ptr,
+					bool enable)
+{
+	struct wmi_arp_offload_tuple *arp;
+	struct wmi_tlv *tlv;
+	u8 *buf_ptr = *ptr;
+	int i;
+
+	/* fill arp tuple */
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, WMI_MAX_ARP_OFFLOADS * sizeof(*arp));
+	buf_ptr += sizeof(*tlv);
+
+	for (i = 0; i < WMI_MAX_ARP_OFFLOADS; i++) {
+		arp = (struct wmi_arp_offload_tuple *)buf_ptr;
+		arp->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARP_OFFLOAD_TUPLE) |
+				  FIELD_PREP(WMI_TLV_LEN, sizeof(*arp) - TLV_HDR_SIZE);
+
+		if (enable && i < offload->ipv4_count) {
+			/* Copy the target ip addr and flags */
+			arp->flags = WMI_ARPOL_FLAGS_VALID;
+			memcpy(arp->target_ipaddr, offload->ipv4_addr[i], 4);
+			ath11k_ce_byte_swap(arp->target_ipaddr, 4);
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "arp offload IP4 address: %pI4",
+				   arp->target_ipaddr);
+		}
+		buf_ptr += sizeof(*arp);
+	}
+	*ptr = buf_ptr;
+}
+
+int ath11k_wmi_arp_ns_offload(struct ath11k *ar,
+			      struct ath11k_vif *arvif, bool enable)
+{
+	struct ath11k_arp_ns_offload *offload;
+	struct wmi_set_arp_ns_offload_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u8 *buf_ptr;
+	size_t len;
+	u8 ns_cnt, ns_ext_tuples = 0;
+
+	offload = &arvif->arp_ns_offload;
+	ns_cnt = offload->ipv6_count;
+
+	len = sizeof(*cmd) +
+	      sizeof(*tlv) +
+	      WMI_MAX_NS_OFFLOADS * sizeof(struct wmi_ns_offload_tuple) +
+	      sizeof(*tlv) +
+	      WMI_MAX_ARP_OFFLOADS * sizeof(struct wmi_arp_offload_tuple);
+
+	if (ns_cnt > WMI_MAX_NS_OFFLOADS) {
+		ns_ext_tuples = ns_cnt - WMI_MAX_NS_OFFLOADS;
+		len += sizeof(*tlv) +
+		       ns_ext_tuples * sizeof(struct wmi_ns_offload_tuple);
+	}
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	buf_ptr = skb->data;
+	cmd = (struct wmi_set_arp_ns_offload_cmd *)buf_ptr;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_SET_ARP_NS_OFFLOAD_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->flags = 0;
+	cmd->vdev_id = arvif->vdev_id;
+	cmd->num_ns_ext_tuples = ns_ext_tuples;
+
+	buf_ptr += sizeof(*cmd);
+
+	ath11k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 0);
+	ath11k_wmi_fill_arp_offload(ar, offload, &buf_ptr, enable);
+	if (ns_ext_tuples)
+		ath11k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 1);
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 3019882..eccb0f02 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -12,6 +12,7 @@
 struct ath11k_base;
 struct ath11k;
 struct ath11k_fw_stats;
+struct ath11k_vif;
 
 #define PSOC_HOST_MAX_NUM_SS (8)
 
@@ -5638,6 +5639,49 @@ struct wmi_wow_nlo_config_cmd {
 	 */
 } __packed;
 
+#define WMI_MAX_NS_OFFLOADS           2
+#define WMI_MAX_ARP_OFFLOADS          2
+
+#define WMI_ARPOL_FLAGS_VALID              BIT(0)
+#define WMI_ARPOL_FLAGS_MAC_VALID          BIT(1)
+#define WMI_ARPOL_FLAGS_REMOTE_IP_VALID    BIT(2)
+
+struct wmi_arp_offload_tuple {
+	u32 tlv_header;
+	u32 flags;
+	u8 target_ipaddr[4];
+	u8 remote_ipaddr[4];
+	struct wmi_mac_addr target_mac;
+} __packed;
+
+#define WMI_NSOL_FLAGS_VALID               BIT(0)
+#define WMI_NSOL_FLAGS_MAC_VALID           BIT(1)
+#define WMI_NSOL_FLAGS_REMOTE_IP_VALID     BIT(2)
+#define WMI_NSOL_FLAGS_IS_IPV6_ANYCAST     BIT(3)
+
+#define WMI_NSOL_MAX_TARGET_IPS    2
+
+struct wmi_ns_offload_tuple {
+	u32 tlv_header;
+	u32 flags;
+	u8 target_ipaddr[WMI_NSOL_MAX_TARGET_IPS][16];
+	u8 solicitation_ipaddr[16];
+	u8 remote_ipaddr[16];
+	struct wmi_mac_addr target_mac;
+} __packed;
+
+struct wmi_set_arp_ns_offload_cmd {
+	u32 tlv_header;
+	u32 flags;
+	u32 vdev_id;
+	u32 num_ns_ext_tuples;
+	/* The TLVs follow:
+	 * wmi_ns_offload_tuple  ns_tuples[WMI_MAX_NS_OFFLOADS];
+	 * wmi_arp_offload_tuple arp_tuples[WMI_MAX_ARP_OFFLOADS];
+	 * wmi_ns_offload_tuple  ns_ext_tuples[num_ns_ext_tuples];
+	 */
+} __packed;
+
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
@@ -5800,4 +5844,6 @@ int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
 				    u32 enable);
 int ath11k_wmi_send_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
 				       u32 filter_bitmap, bool enable);
+int ath11k_wmi_arp_ns_offload(struct ath11k *ar,
+			      struct ath11k_vif *arvif, bool enable);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index f798b5c..a57f2ff 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -555,6 +555,43 @@ static int ath11k_wow_clear_hw_filter(struct ath11k *ar)
 	return 0;
 }
 
+static int ath11k_wow_arp_ns_offload(struct ath11k *ar, bool enable)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+			continue;
+
+		ret = ath11k_wmi_arp_ns_offload(ar, arvif, enable);
+
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set arp ns offload vdev %i: enable %d, ret %d\n",
+				    arvif->vdev_id, enable, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath11k_wow_protocol_offload(struct ath11k *ar, bool enable)
+{
+	int ret;
+
+	ret = ath11k_wow_arp_ns_offload(ar, enable);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to offload ARP and NS %d %d\n",
+			    enable, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -585,6 +622,14 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 		goto cleanup;
 	}
 
+	ret = ath11k_wow_protocol_offload(ar, true);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set wow protocol offload events: %d\n",
+			    ret);
+		goto cleanup;
+	}
+
+	ath11k_mac_drain_tx(ar);
 	ret = ath11k_mac_wait_tx_complete(ar);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
@@ -686,6 +731,13 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 		goto exit;
 	}
 
+	ret = ath11k_wow_protocol_offload(ar, false);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to clear wow protocol offload events: %d\n",
+			    ret);
+		goto exit;
+	}
+
 exit:
 	if (ret) {
 		switch (ar->state) {
-- 
2.7.4

