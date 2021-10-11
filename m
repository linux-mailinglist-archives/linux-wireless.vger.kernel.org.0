Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4079B428C21
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhJKLjd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:39:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59453 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233943AbhJKLjc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:39:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633952253; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KUFJhiZY8m6w+YTzvIEogRS/pB1gskeqUYPk78U8Sio=; b=W5eQ4uauTsPLlOtXLlTBsyPW/Meol+VCOIFBfK1cQLgnOCl5ByHxWcDk9wAxu6EqGnBjnZJ8
 14o3/MJczEeX6azojWfYYpYVnRh/A5NLGWuP/OJeba37l0n7m9xaTriR/1K2ftD+sv/G1W0A
 ZA9rPUEdyXoOSszVPOidKlg3tgc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 616421fc22fe3a98e5af1a3a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:37:32
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD25CC4360C; Mon, 11 Oct 2021 11:37:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EF6BC4338F;
        Mon, 11 Oct 2021 11:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3EF6BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] ath11k: support ARP and NS offload
Date:   Mon, 11 Oct 2021 15:37:49 -0400
Message-Id: <20211011193750.4891-6-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011193750.4891-1-cjhuang@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support ARP and NS offload in WoW state.

Tested this way: put machineA with QCA6390 to WoW state,
ping/ping6 machineA from another machineB, check sniffer to see
any ARP response and Neighbour advertisement from machineA.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  18 ++++
 drivers/net/wireless/ath/ath11k/mac.c  | 114 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 145 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  46 +++++++++++
 drivers/net/wireless/ath/ath11k/wow.c  |  49 ++++++++++-
 5 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6e40a33..d9c6c1d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -239,6 +239,23 @@ struct ath11k_reg_tpc_power_info {
 	struct chan_power_info chan_power_info[MAX_NUM_PWR_LEVEL];
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
@@ -289,6 +306,7 @@ struct ath11k_vif {
 	bool wpaie_present;
 	struct ieee80211_chanctx_conf chanctx;
 	struct ath11k_reg_tpc_power_info reg_tpc_info;
+	struct ath11k_arp_ns_offload arp_ns_offload;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ce235ca..e3dc998 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5,6 +5,11 @@
 
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
@@ -2515,6 +2520,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	int ret = 0;
 	u8 rateidx;
 	u32 rate;
+	u32 ipv4_cnt;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -2790,6 +2796,18 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
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
 
@@ -7342,6 +7360,97 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	}
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
@@ -7386,6 +7495,11 @@ static const struct ieee80211_ops ath11k_ops = {
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
index be880dc..1e276d51 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8728,3 +8728,148 @@ int ath11k_wmi_wow_config_pno(struct ath11k *ar, u32 vdev_id,
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
+
+			if (offload->ipv6_type[i]) {
+				ns->flags |=
+					WMI_NSOL_FLAGS_IS_IPV6_ANYCAST;
+			}
+
+			memcpy(ns->target_mac.addr, offload->mac_addr, ETH_ALEN);
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
index 1301b17..c2e5557 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -13,6 +13,7 @@ struct ath11k_base;
 struct ath11k;
 struct ath11k_fw_stats;
 struct ath11k_reg_tpc_power_info;
+struct ath11k_vif;
 
 #define PSOC_HOST_MAX_NUM_SS (8)
 
@@ -5806,6 +5807,49 @@ struct wmi_wow_nlo_config_cmd {
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
@@ -5971,4 +6015,6 @@ int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
 				    u32 enable);
 int ath11k_wmi_send_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
 				       u32 filter_bitmap, bool enable);
+int ath11k_wmi_arp_ns_offload(struct ath11k *ar,
+			      struct ath11k_vif *arvif, bool enable);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 8bd2ca2..c1bef84 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -550,6 +550,38 @@ static int ath11k_wow_clear_hw_filter(struct ath11k *ar)
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
+
+	return ret;
+}
+
 int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -580,6 +612,14 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
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
@@ -672,8 +712,15 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 	}
 
 	ret = ath11k_wow_clear_hw_filter(ar);
-	if (ret)
+	if (ret) {
 		ath11k_warn(ar->ab, "failed to clear hw filter: %d\n", ret);
+		goto exit;
+	}
+
+	ret = ath11k_wow_protocol_offload(ar, false);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to clear wow protocol offload events: %d\n",
+			    ret);
 
 exit:
 	if (ret) {
-- 
2.7.4

