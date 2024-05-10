Return-Path: <linux-wireless+bounces-7434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E68C1E5F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07634285587
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99294158A3A;
	Fri, 10 May 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NkjljSWT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC620309
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323693; cv=none; b=PPtj+d9xS2kcU/r6hHvFpdQny6IT0qqq51Ge1eyCfT3l8+AuIssE19Ww/8ImJy+MmuKq29gZ46lwmVUp9qFMEa1SjY6qvzl6XHus72iT68ACjb8d7anHMQfCocFH0FolScon1LcZ/05hKfltz0k3tPNpaxegeazho/9lEr3J9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323693; c=relaxed/simple;
	bh=mLSHCRt0XeKXE5B//EmFkxQRWejOQFR17KDnelA8l0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAKaxJ5C6X2Y8aXt35d2cF9QVFjI4kDWjZBC9X9t3JtJDrsV4iFvw6IPihKaU5MI52MyvDeYTOQWsofUAi04ngp63CYDHK0m8plL7y8iL58W/L9O2j7+GJ9ORUu73a+DU/m3QMtL/YXPkKbL/oKKq2zEY0vlEHSIeIx1bUIT3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NkjljSWT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tudY003593;
	Fri, 10 May 2024 06:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=8Gg8Hn/YNXkxZUnATMVe65xrgJXtz4/4XGUafdUt/CY=; b=Nk
	jljSWTb7kc5P0y43sTawPKcBX5SV9QAVnPSGt+XIruWcMsOIpyCaP5IjkNvn1E1j
	BTx7VINzL8eZWxtlGb9IUTpEMZMls4GTiqp5Pj2+LOCYYc+UKxHHwMfP0mcFbsby
	LikU16wikIYLT59QwBbxm+Mz1ZE18X4xdeWdnEeYsGkGWLSEzWDKTuxkiOSVX/fk
	g30tY/xu1S5xzhcYMqtpcffiClClLL2mWr1q9e/Oxk4FbHkvokRlAMKUrs2Vesqq
	0wMYky8PK8H4abTxRuBMlQjonv9ZZvJBfeXU78AvkNgV4mGq9EUAowvq4Piz3g7M
	Ky1+VTaXLw91LLRSMgsg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w10t27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:48:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A6m7Kw023368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:48:07 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 May 2024 23:48:05 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 5/7] wifi: ath12k: support ARP and NS offload
Date: Fri, 10 May 2024 14:47:46 +0800
Message-ID: <20240510064748.369452-6-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510064748.369452-1-quic_bqiang@quicinc.com>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: RFyhj3VeD1K6zt7od2wXO8VD_u5LyDnm
X-Proofpoint-ORIG-GUID: RFyhj3VeD1K6zt7od2wXO8VD_u5LyDnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=532 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405100047

Support ARP and NS offload in WoW state.

Tested this way: put machine A with QCA6390 to WoW state,
ping/ping6 machine A from another machine B, check sniffer to see
any ARP response and Neighbor Advertisement from machine A.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  18 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 157 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c  | 151 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  47 ++++++++
 drivers/net/wireless/ath/ath12k/wow.c  |  51 ++++++++
 5 files changed, 423 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index acd4db7daafb..6ab1a2962ff4 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -231,6 +231,23 @@ struct ath12k_vif_cache {
 	u32 bss_conf_changed;
 };
 
+#define ATH12K_IPV6_UC_TYPE     0
+#define ATH12K_IPV6_AC_TYPE     1
+
+#define ATH12K_IPV6_MAX_COUNT   16
+#define ATH12K_IPV4_MAX_COUNT   2
+
+struct ath12k_arp_ns_offload {
+	u8  ipv4_addr[ATH12K_IPV4_MAX_COUNT][4];
+	u32 ipv4_count;
+	u32 ipv6_count;
+	u8  ipv6_addr[ATH12K_IPV6_MAX_COUNT][16];
+	u8  self_ipv6_addr[ATH12K_IPV6_MAX_COUNT][16];
+	u8  ipv6_type[ATH12K_IPV6_MAX_COUNT];
+	bool ipv6_valid[ATH12K_IPV6_MAX_COUNT];
+	u8  mac_addr[ETH_ALEN];
+};
+
 struct ath12k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -287,6 +304,7 @@ struct ath12k_vif {
 	u32 punct_bitmap;
 	bool ps;
 	struct ath12k_vif_cache *cache;
+	struct ath12k_arp_ns_offload *arp_ns_offload;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 37d4b72df4c5..7a9b75adae60 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4,8 +4,13 @@
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <net/mac80211.h>
+#include <linux/bitfield.h>
 #include <linux/etherdevice.h>
+#include <linux/inetdevice.h>
+#include <net/if_inet6.h>
+#include <net/ipv6.h>
+#include <net/mac80211.h>
+
 #include "mac.h"
 #include "core.h"
 #include "debug.h"
@@ -2801,6 +2806,22 @@ static void ath12k_mac_vif_setup_ps(struct ath12k_vif *arvif)
 			    psmode, arvif->vdev_id, ret);
 }
 
+static struct ath12k_arp_ns_offload *
+ath12k_mac_arvif_get_arp_ns_offload(struct ath12k_vif *arvif)
+{
+	if (!arvif->arp_ns_offload)
+		arvif->arp_ns_offload = kzalloc(sizeof(*arvif->arp_ns_offload),
+						GFP_KERNEL);
+
+	return arvif->arp_ns_offload;
+}
+
+static void ath12k_mac_arvif_put_arp_ns_offload(struct ath12k_vif *arvif)
+{
+	kfree(arvif->arp_ns_offload);
+	arvif->arp_ns_offload = NULL;
+}
+
 static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 					struct ath12k_vif *arvif,
 					struct ieee80211_bss_conf *info,
@@ -2808,11 +2829,13 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
+	struct ath12k_arp_ns_offload *offload;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
 	u32 vdev_param;
 	int mcast_rate;
+	u32 ipv4_cnt;
 	u32 preamble;
 	u16 hw_value;
 	u16 bitrate;
@@ -3083,6 +3106,25 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 		arvif->ps = vif_cfg->ps;
 		ath12k_mac_vif_setup_ps(arvif);
 	}
+
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		offload = ath12k_mac_arvif_get_arp_ns_offload(arvif);
+		if (offload) {
+			ipv4_cnt = min(vif_cfg->arp_addr_cnt, ATH12K_IPV4_MAX_COUNT);
+			memcpy(offload->ipv4_addr, vif_cfg->arp_addr_list,
+			       ipv4_cnt * sizeof(u32));
+			memcpy(offload->mac_addr, vif->addr, ETH_ALEN);
+			offload->ipv4_count = ipv4_cnt;
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "mac arp_addr_cnt %d vif->addr %pM, offload_addr %pI4\n",
+				   vif_cfg->arp_addr_cnt,
+				   vif->addr, offload->ipv4_addr);
+		} else {
+			ath12k_warn(ar->ab, "failed to get arp ns offload for vdev %u\n",
+				    arvif->vdev_id);
+		}
+	}
 }
 
 static struct ath12k_vif_cache *ath12k_arvif_get_cache(struct ath12k_vif *arvif)
@@ -6528,6 +6570,8 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	int ret;
 
+	ath12k_mac_arvif_put_arp_ns_offload(arvif);
+
 	if (!arvif->is_created) {
 		/* if we cached some config but never received assign chanctx,
 		 * free the allocated cache.
@@ -8214,6 +8258,113 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static void ath12k_mac_generate_ns_mc_addr(struct ath12k *ar,
+					   struct ath12k_arp_ns_offload *offload)
+{
+	int i;
+
+	for (i = 0; i < offload->ipv6_count; i++) {
+		offload->self_ipv6_addr[i][0] = 0xff;
+		offload->self_ipv6_addr[i][1] = 0x02;
+		offload->self_ipv6_addr[i][11] = 0x01;
+		offload->self_ipv6_addr[i][12] = 0xff;
+		offload->self_ipv6_addr[i][13] =
+					offload->ipv6_addr[i][13];
+		offload->self_ipv6_addr[i][14] =
+					offload->ipv6_addr[i][14];
+		offload->self_ipv6_addr[i][15] =
+					offload->ipv6_addr[i][15];
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "NS solicited addr %pI6\n",
+			   offload->self_ipv6_addr[i]);
+	}
+}
+
+static __maybe_unused void ath12k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
+						      struct ieee80211_vif *vif,
+						      struct inet6_dev *idev)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	struct ath12k_arp_ns_offload *offload;
+	struct inet6_ifaddr *ifa6;
+	struct ifacaddr6 *ifaca6;
+	struct list_head *p;
+	u32 count, scope;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac op ipv6 changed\n");
+
+	offload = ath12k_mac_arvif_get_arp_ns_offload(arvif);
+	if (!offload) {
+		ath12k_warn(ar->ab, "failed to get arp ns offload for vdev %u\n",
+			    arvif->vdev_id);
+		return;
+	}
+
+	count = 0;
+
+	memset(offload->ipv6_addr, 0, sizeof(offload->ipv6_addr));
+	memset(offload->self_ipv6_addr, 0, sizeof(offload->self_ipv6_addr));
+	memcpy(offload->mac_addr, vif->addr, ETH_ALEN);
+
+	read_lock_bh(&idev->lock);
+
+	/* get unicast address */
+	list_for_each(p, &idev->addr_list) {
+		if (count >= ATH12K_IPV6_MAX_COUNT)
+			goto unlock;
+
+		ifa6 = list_entry(p, struct inet6_ifaddr, if_list);
+		if (ifa6->flags & IFA_F_DADFAILED)
+			continue;
+
+		scope = ipv6_addr_src_scope(&ifa6->addr);
+		if (scope != IPV6_ADDR_SCOPE_LINKLOCAL &&
+		    scope != IPV6_ADDR_SCOPE_GLOBAL) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "Unsupported ipv6 scope: %d\n", scope);
+			continue;
+		}
+
+		memcpy(offload->ipv6_addr[count], &ifa6->addr.s6_addr,
+		       sizeof(ifa6->addr.s6_addr));
+		offload->ipv6_type[count] = ATH12K_IPV6_UC_TYPE;
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac count %d ipv6 uc %pI6 scope %d\n",
+			   count, offload->ipv6_addr[count],
+			   scope);
+		count++;
+	}
+
+	/* get anycast address */
+	for (ifaca6 = rcu_dereference(idev->ac_list); ifaca6;
+	     ifaca6 = rcu_dereference(ifaca6->aca_next)) {
+		if (count >= ATH12K_IPV6_MAX_COUNT)
+			goto unlock;
+
+		scope = ipv6_addr_src_scope(&ifaca6->aca_addr);
+		if (scope != IPV6_ADDR_SCOPE_LINKLOCAL &&
+		    scope != IPV6_ADDR_SCOPE_GLOBAL) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "Unsupported ipv scope: %d\n", scope);
+			continue;
+		}
+
+		memcpy(offload->ipv6_addr[count], &ifaca6->aca_addr,
+		       sizeof(ifaca6->aca_addr));
+		offload->ipv6_type[count] = ATH12K_IPV6_AC_TYPE;
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac count %d ipv6 ac %pI6 scope %d\n",
+			   count, offload->ipv6_addr[count],
+			   scope);
+		count++;
+	}
+
+unlock:
+	read_unlock_bh(&idev->lock);
+
+	offload->ipv6_count = count;
+	ath12k_mac_generate_ns_mc_addr(ar, offload);
+}
+
 static const struct ieee80211_ops ath12k_ops = {
 	.tx				= ath12k_mac_op_tx,
 	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
@@ -8256,6 +8407,10 @@ static const struct ieee80211_ops ath12k_ops = {
 	.resume				= ath12k_wow_op_resume,
 	.set_wakeup			= ath12k_wow_op_set_wakeup,
 #endif
+
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change		= ath12k_mac_op_ipv6_changed,
+#endif
 };
 
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b59949cc1a93..6e4e02640198 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7750,3 +7750,154 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
 
 	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
 }
+
+static void ath12k_wmi_fill_ns_offload(struct ath12k *ar,
+				       struct ath12k_arp_ns_offload *offload,
+				       void **ptr,
+				       bool enable,
+				       bool ext)
+{
+	struct wmi_ns_offload_params *ns;
+	struct wmi_tlv *tlv;
+	void *buf_ptr = *ptr;
+	u32 ns_cnt, ns_ext_tuples;
+	int i, max_offloads;
+
+	ns_cnt = offload->ipv6_count;
+
+	tlv  = buf_ptr;
+
+	if (ext) {
+		ns_ext_tuples = offload->ipv6_count - WMI_MAX_NS_OFFLOADS;
+		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+						 ns_ext_tuples * sizeof(*ns));
+		i = WMI_MAX_NS_OFFLOADS;
+		max_offloads = offload->ipv6_count;
+	} else {
+		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+						 WMI_MAX_NS_OFFLOADS * sizeof(*ns));
+		i = 0;
+		max_offloads = WMI_MAX_NS_OFFLOADS;
+	}
+
+	buf_ptr += sizeof(*tlv);
+
+	for (; i < max_offloads; i++) {
+		ns = buf_ptr;
+		ns->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_NS_OFFLOAD_TUPLE,
+							sizeof(*ns));
+
+		if (enable) {
+			if (i < ns_cnt)
+				ns->flags |= cpu_to_le32(WMI_NSOL_FLAGS_VALID);
+
+			memcpy(ns->target_ipaddr[0], offload->ipv6_addr[i], 16);
+			memcpy(ns->solicitation_ipaddr, offload->self_ipv6_addr[i], 16);
+
+			if (offload->ipv6_type[i])
+				ns->flags |= cpu_to_le32(WMI_NSOL_FLAGS_IS_IPV6_ANYCAST);
+
+			memcpy(ns->target_mac.addr, offload->mac_addr, ETH_ALEN);
+
+			if (!is_zero_ether_addr(ns->target_mac.addr))
+				ns->flags |= cpu_to_le32(WMI_NSOL_FLAGS_MAC_VALID);
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+				   "wmi index %d ns_solicited %pI6 target %pI6",
+				   i, ns->solicitation_ipaddr,
+				   ns->target_ipaddr[0]);
+		}
+
+		buf_ptr += sizeof(*ns);
+	}
+
+	*ptr = buf_ptr;
+}
+
+static void ath12k_wmi_fill_arp_offload(struct ath12k *ar,
+					struct ath12k_arp_ns_offload *offload,
+					void **ptr,
+					bool enable)
+{
+	struct wmi_arp_offload_params *arp;
+	struct wmi_tlv *tlv;
+	void *buf_ptr = *ptr;
+	int i;
+
+	/* fill arp tuple */
+	tlv = buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+					 WMI_MAX_ARP_OFFLOADS * sizeof(*arp));
+	buf_ptr += sizeof(*tlv);
+
+	for (i = 0; i < WMI_MAX_ARP_OFFLOADS; i++) {
+		arp = buf_ptr;
+		arp->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_ARP_OFFLOAD_TUPLE,
+							 sizeof(*arp));
+
+		if (enable && i < offload->ipv4_count) {
+			/* Copy the target ip addr and flags */
+			arp->flags = cpu_to_le32(WMI_ARPOL_FLAGS_VALID);
+			memcpy(arp->target_ipaddr, offload->ipv4_addr[i], 4);
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi arp offload address %pI4",
+				   arp->target_ipaddr);
+		}
+
+		buf_ptr += sizeof(*arp);
+	}
+
+	*ptr = buf_ptr;
+}
+
+int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
+			      struct ath12k_vif *arvif, bool enable)
+{
+	struct ath12k_arp_ns_offload *offload;
+	struct wmi_set_arp_ns_offload_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	void *buf_ptr;
+	size_t len;
+	u8 ns_cnt, ns_ext_tuples = 0;
+
+	offload = arvif->arp_ns_offload;
+	if (!offload)
+		return 0;
+
+	ns_cnt = offload->ipv6_count;
+
+	len = sizeof(*cmd) +
+	      sizeof(*tlv) +
+	      WMI_MAX_NS_OFFLOADS * sizeof(struct wmi_ns_offload_params) +
+	      sizeof(*tlv) +
+	      WMI_MAX_ARP_OFFLOADS * sizeof(struct wmi_arp_offload_params);
+
+	if (ns_cnt > WMI_MAX_NS_OFFLOADS) {
+		ns_ext_tuples = ns_cnt - WMI_MAX_NS_OFFLOADS;
+		len += sizeof(*tlv) +
+		       ns_ext_tuples * sizeof(struct wmi_ns_offload_params);
+	}
+
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	buf_ptr = skb->data;
+	cmd = buf_ptr;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_SET_ARP_NS_OFFLOAD_CMD,
+						 sizeof(*cmd));
+	cmd->flags = cpu_to_le32(0);
+	cmd->vdev_id = cpu_to_le32(arvif->vdev_id);
+	cmd->num_ns_ext_tuples = cpu_to_le32(ns_ext_tuples);
+
+	buf_ptr += sizeof(*cmd);
+
+	ath12k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 0);
+	ath12k_wmi_fill_arp_offload(ar, offload, &buf_ptr, enable);
+
+	if (ns_ext_tuples)
+		ath12k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 1);
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 96460116c072..57707b741f80 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -24,6 +24,7 @@
 
 struct ath12k_base;
 struct ath12k;
+struct ath12k_vif;
 
 /* There is no signed version of __le32, so for a temporary solution come
  * up with our own version. The idea is from fs/ntfs/endian.h.
@@ -5282,6 +5283,49 @@ struct wmi_hw_data_filter_arg {
 	u32 hw_filter_bitmap;
 };
 
+#define WMI_MAX_NS_OFFLOADS           2
+#define WMI_MAX_ARP_OFFLOADS          2
+
+#define WMI_ARPOL_FLAGS_VALID              BIT(0)
+#define WMI_ARPOL_FLAGS_MAC_VALID          BIT(1)
+#define WMI_ARPOL_FLAGS_REMOTE_IP_VALID    BIT(2)
+
+struct wmi_arp_offload_params {
+	__le32 tlv_header;
+	__le32 flags;
+	u8 target_ipaddr[4];
+	u8 remote_ipaddr[4];
+	struct ath12k_wmi_mac_addr_params target_mac;
+} __packed;
+
+#define WMI_NSOL_FLAGS_VALID               BIT(0)
+#define WMI_NSOL_FLAGS_MAC_VALID           BIT(1)
+#define WMI_NSOL_FLAGS_REMOTE_IP_VALID     BIT(2)
+#define WMI_NSOL_FLAGS_IS_IPV6_ANYCAST     BIT(3)
+
+#define WMI_NSOL_MAX_TARGET_IPS    2
+
+struct wmi_ns_offload_params {
+	__le32 tlv_header;
+	__le32 flags;
+	u8 target_ipaddr[WMI_NSOL_MAX_TARGET_IPS][16];
+	u8 solicitation_ipaddr[16];
+	u8 remote_ipaddr[16];
+	struct ath12k_wmi_mac_addr_params target_mac;
+} __packed;
+
+struct wmi_set_arp_ns_offload_cmd {
+	__le32 tlv_header;
+	__le32 flags;
+	__le32 vdev_id;
+	__le32 num_ns_ext_tuples;
+	/* The TLVs follow:
+	 * wmi_ns_offload_params  ns[WMI_MAX_NS_OFFLOADS];
+	 * wmi_arp_offload_params arp[WMI_MAX_ARP_OFFLOADS];
+	 * wmi_ns_offload_params  ns_ext[num_ns_ext_tuples];
+	 */
+} __packed;
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5447,4 +5491,7 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
 			      struct wmi_pno_scan_req_arg  *pno_scan);
 int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar,
 				  struct wmi_hw_data_filter_arg *arg);
+int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
+			      struct ath12k_vif *arvif, bool enable);
+
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 968bd884687f..d15e1a5ee8c4 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -591,6 +591,42 @@ static int ath12k_wow_clear_hw_filter(struct ath12k *ar)
 	return 0;
 }
 
+static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
+{
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+			continue;
+
+		ret = ath12k_wmi_arp_ns_offload(ar, arvif, enable);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set arp ns offload vdev %i: enable %d, ret %d\n",
+				    arvif->vdev_id, enable, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath12k_wow_protocol_offload(struct ath12k *ar, bool enable)
+{
+	int ret;
+
+	ret = ath12k_wow_arp_ns_offload(ar, enable);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to offload ARP and NS %d %d\n",
+			    enable, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -614,6 +650,14 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 		goto cleanup;
 	}
 
+	ret = ath12k_wow_protocol_offload(ar, true);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set wow protocol offload events: %d\n",
+			    ret);
+		goto cleanup;
+	}
+
+	ath12k_mac_drain_tx(ar);
 	ret = ath12k_mac_wait_tx_complete(ar);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
@@ -700,6 +744,13 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 		goto exit;
 	}
 
+	ret = ath12k_wow_protocol_offload(ar, false);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to clear wow protocol offload events: %d\n",
+			    ret);
+		goto exit;
+	}
+
 exit:
 	if (ret) {
 		switch (ah->state) {
-- 
2.25.1


