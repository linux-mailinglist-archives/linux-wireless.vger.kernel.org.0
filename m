Return-Path: <linux-wireless+bounces-14825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80649B942E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18FB8B21C7D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AE61C8FD2;
	Fri,  1 Nov 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuD07xwl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186F1C8FCF
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474236; cv=none; b=hfelFrrE62JUmcpQYgtVLsxQKsaKS4PGhMSfX3E4ptpYVduesCn6T3L6rMTM392hLphuL7nxPReKQoNjDdEAoj5tNPnr1Uxm10l2LjNBX4vDczLg69QY86fBLxNAz+P1qGcc4jnOL0oXUK49RiBUIEJdW+DLkl91YKR8mKRrRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474236; c=relaxed/simple;
	bh=tfq9Ab2IckfJmbTJNfD5MEiiUcMTK0T4a5m1D0lr4wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgFC53KiICpMfpV0UI/6vOiZierAwU3A4VvVa/uM+Bdhn27awU1SUUh6bh5ovj8uxys8TFFJi2pp0ZkTThV46I/vynRIrpKDvd7K6UkMQdYAnLDHb2psdmwTLFufaoaVX0BLl9SexKAbbFJtEo+LpCD0g6n+bIsI2yTHh8rHuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuD07xwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC20C4CED2;
	Fri,  1 Nov 2024 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474236;
	bh=tfq9Ab2IckfJmbTJNfD5MEiiUcMTK0T4a5m1D0lr4wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuD07xwlU+xZPt5Fs53/CNlHISX3U/ESQaBX0kZ10ONS5355dn2F8692roTMZv/mN
	 Cjp8tlcX7Px4tRr3KUGgEi3c/HwlLI3jdH30efyGD1yzDVBVNuYSD0Eap1h63MJnsx
	 arZ2Gy1RPJXogCxwYHzxO7di0yrhk56m1T+oA5KCZ+Nckg5sGV1/2jyjA73IqwBoca
	 l4Tv5hy2txXQfDbkvVqFB6BaeS8uJnEPMErGLhk0PTlt5M94Nk0KZffVSdEX11XEpU
	 ivmggvGTOkkaRRaTP3Z/1oBFd6b1w62/wHhWDAEZsNfyJ2ryVkXI5K3Jv8Cqiex2Or
	 tP1fmAGhdC61A==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 8/8] wifi: ath12k: Add MLO peer assoc command support
Date: Fri,  1 Nov 2024 17:17:05 +0200
Message-Id: <20241101151705.165987-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101151705.165987-1-kvalo@kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Add changes to send MLO peer assoc command with partner link details and
primary umac details

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  7 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 62 ++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.c  | 79 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h  | 46 +++++++++++++++
 4 files changed, 188 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0a0c1a1594f2..e7a2d43e7b8a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -487,9 +487,16 @@ struct ath12k_link_sta {
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
+
+	/* For now the assoc link will be considered primary */
+	bool is_assoc_link;
+
+	 /* for firmware use only */
+	u8 link_idx;
 };
 
 struct ath12k_sta {
+	struct ath12k_vif *ahvif;
 	enum hal_pn_type pn_type;
 	struct ath12k_link_sta deflink;
 	struct ath12k_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b12682547410..84535cf80016 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2873,6 +2873,67 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	arg->punct_bitmap = ~arvif->punct_bitmap;
 }
 
+static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
+				    struct ath12k_wmi_peer_assoc_arg *arg)
+{
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
+	struct peer_assoc_mlo_params *ml = &arg->ml;
+	struct ath12k_sta *ahsta = arsta->ahsta;
+	struct ath12k_link_sta *arsta_p;
+	struct ath12k_link_vif *arvif;
+	unsigned long links;
+	u8 link_id;
+	int i;
+
+	if (!sta->mlo || ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID)
+		return;
+
+	ml->enabled = true;
+	ml->assoc_link = arsta->is_assoc_link;
+
+	/* For now considering the primary umac based on assoc link */
+	ml->primary_umac = arsta->is_assoc_link;
+	ml->peer_id_valid = true;
+	ml->logical_link_idx_valid = true;
+
+	ether_addr_copy(ml->mld_addr, sta->addr);
+	ml->logical_link_idx = arsta->link_idx;
+	ml->ml_peer_id = ahsta->ml_peer_id;
+	ml->ieee_link_id = arsta->link_id;
+	ml->num_partner_links = 0;
+	links = ahsta->links_map;
+
+	rcu_read_lock();
+
+	i = 0;
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (i >= ATH12K_WMI_MLO_MAX_LINKS)
+			break;
+
+		arsta_p = rcu_dereference(ahsta->link[link_id]);
+		arvif = rcu_dereference(ahsta->ahvif->link[link_id]);
+
+		if (arsta_p == arsta)
+			continue;
+
+		if (!arvif->is_started)
+			continue;
+
+		ml->partner_info[i].vdev_id = arvif->vdev_id;
+		ml->partner_info[i].hw_link_id = arvif->ar->pdev->hw_link_id;
+		ml->partner_info[i].assoc_link = arsta_p->is_assoc_link;
+		ml->partner_info[i].primary_umac = arsta_p->is_assoc_link;
+		ml->partner_info[i].logical_link_idx_valid = true;
+		ml->partner_info[i].logical_link_idx = arsta_p->link_idx;
+		ml->num_partner_links++;
+
+		i++;
+	}
+
+	rcu_read_unlock();
+}
+
 static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 				      struct ath12k_link_vif *arvif,
 				      struct ath12k_link_sta *arsta,
@@ -2897,6 +2958,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_qos(ar, arvif, arsta, arg);
 	ath12k_peer_assoc_h_phymode(ar, arvif, arsta, arg);
 	ath12k_peer_assoc_h_smps(arsta, arg);
+	ath12k_peer_assoc_h_mlo(arsta, arg);
 
 	/* TODO: amsdu_disable req? */
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 0583d832fac7..50ed7e72f178 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2101,12 +2101,15 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	struct ath12k_wmi_vht_rate_set_params *mcs;
 	struct ath12k_wmi_he_rate_set_params *he_mcs;
 	struct ath12k_wmi_eht_rate_set_params *eht_mcs;
+	struct wmi_peer_assoc_mlo_params *ml_params;
+	struct wmi_peer_assoc_mlo_partner_info_params *partner_info;
 	struct sk_buff *skb;
 	struct wmi_tlv *tlv;
 	void *ptr;
 	u32 peer_legacy_rates_align;
 	u32 peer_ht_rates_align;
 	int i, ret, len;
+	__le32 v;
 
 	peer_legacy_rates_align = roundup(arg->peer_legacy_rates.num_rates,
 					  sizeof(u32));
@@ -2118,8 +2121,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	      TLV_HDR_SIZE + (peer_ht_rates_align * sizeof(u8)) +
 	      sizeof(*mcs) + TLV_HDR_SIZE +
 	      (sizeof(*he_mcs) * arg->peer_he_mcs_count) +
-	      TLV_HDR_SIZE + (sizeof(*eht_mcs) * arg->peer_eht_mcs_count) +
-	      TLV_HDR_SIZE + TLV_HDR_SIZE;
+	      TLV_HDR_SIZE + (sizeof(*eht_mcs) * arg->peer_eht_mcs_count);
+
+	if (arg->ml.enabled)
+		len += TLV_HDR_SIZE + sizeof(*ml_params) +
+		       TLV_HDR_SIZE + (arg->ml.num_partner_links * sizeof(*partner_info));
+	else
+		len += (2 * TLV_HDR_SIZE);
 
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -2243,12 +2251,38 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		ptr += sizeof(*he_mcs);
 	}
 
-	/* MLO header tag with 0 length */
-	len = 0;
 	tlv = ptr;
+	len = arg->ml.enabled ? sizeof(*ml_params) : 0;
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
 	ptr += TLV_HDR_SIZE;
+	if (!len)
+		goto skip_ml_params;
 
+	ml_params = ptr;
+	ml_params->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_ASSOC_PARAMS,
+						       len);
+	ml_params->flags = cpu_to_le32(ATH12K_WMI_FLAG_MLO_ENABLED);
+
+	if (arg->ml.assoc_link)
+		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_ASSOC_LINK);
+
+	if (arg->ml.primary_umac)
+		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_PRIMARY_UMAC);
+
+	if (arg->ml.logical_link_idx_valid)
+		ml_params->flags |=
+			cpu_to_le32(ATH12K_WMI_FLAG_MLO_LOGICAL_LINK_IDX_VALID);
+
+	if (arg->ml.peer_id_valid)
+		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_PEER_ID_VALID);
+
+	ether_addr_copy(ml_params->mld_addr.addr, arg->ml.mld_addr);
+	ml_params->logical_link_idx = cpu_to_le32(arg->ml.logical_link_idx);
+	ml_params->ml_peer_id = cpu_to_le32(arg->ml.ml_peer_id);
+	ml_params->ieee_link_id = cpu_to_le32(arg->ml.ieee_link_id);
+	ptr += sizeof(*ml_params);
+
+skip_ml_params:
 	/* Loop through the EHT rate set */
 	len = arg->peer_eht_mcs_count * sizeof(*eht_mcs);
 	tlv = ptr;
@@ -2265,12 +2299,45 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		ptr += sizeof(*eht_mcs);
 	}
 
-	/* ML partner links tag with 0 length */
-	len = 0;
 	tlv = ptr;
+	len = arg->ml.enabled ? arg->ml.num_partner_links * sizeof(*partner_info) : 0;
+	/* fill ML Partner links */
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
 	ptr += TLV_HDR_SIZE;
 
+	if (len == 0)
+		goto send;
+
+	for (i = 0; i < arg->ml.num_partner_links; i++) {
+		u32 cmd = WMI_TAG_MLO_PARTNER_LINK_PARAMS_PEER_ASSOC;
+
+		partner_info = ptr;
+		partner_info->tlv_header = ath12k_wmi_tlv_cmd_hdr(cmd,
+								  sizeof(*partner_info));
+		partner_info->vdev_id = cpu_to_le32(arg->ml.partner_info[i].vdev_id);
+		partner_info->hw_link_id =
+			cpu_to_le32(arg->ml.partner_info[i].hw_link_id);
+		partner_info->flags = cpu_to_le32(ATH12K_WMI_FLAG_MLO_ENABLED);
+
+		if (arg->ml.partner_info[i].assoc_link)
+			partner_info->flags |=
+				cpu_to_le32(ATH12K_WMI_FLAG_MLO_ASSOC_LINK);
+
+		if (arg->ml.partner_info[i].primary_umac)
+			partner_info->flags |=
+				cpu_to_le32(ATH12K_WMI_FLAG_MLO_PRIMARY_UMAC);
+
+		if (arg->ml.partner_info[i].logical_link_idx_valid) {
+			v = cpu_to_le32(ATH12K_WMI_FLAG_MLO_LINK_ID_VALID);
+			partner_info->flags |= v;
+		}
+
+		partner_info->logical_link_idx =
+			cpu_to_le32(arg->ml.partner_info[i].logical_link_idx);
+		ptr += sizeof(*partner_info);
+	}
+
+send:
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x peer_flags_ext %x eht mac_cap %x %x eht phy_cap %x %x %x\n",
 		   cmd->vdev_id, cmd->peer_associd, arg->peer_mac,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 2378d94b2409..05aa9754118a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3687,6 +3687,24 @@ struct wmi_vdev_install_key_arg {
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_160		1
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_80_80	2
 
+#define ATH12K_WMI_MLO_MAX_PARTNER_LINKS \
+	(ATH12K_WMI_MLO_MAX_LINKS + ATH12K_MAX_NUM_BRIDGE_LINKS - 1)
+
+struct peer_assoc_mlo_params {
+	bool enabled;
+	bool assoc_link;
+	bool primary_umac;
+	bool peer_id_valid;
+	bool logical_link_idx_valid;
+	bool bridge_peer;
+	u8 mld_addr[ETH_ALEN];
+	u32 logical_link_idx;
+	u32 ml_peer_id;
+	u32 ieee_link_id;
+	u8 num_partner_links;
+	struct wmi_ml_partner_info partner_info[ATH12K_WMI_MLO_MAX_LINKS];
+};
+
 struct wmi_rate_set_arg {
 	u32 num_rates;
 	u8 rates[WMI_MAX_SUPPORTED_RATES];
@@ -3761,8 +3779,36 @@ struct ath12k_wmi_peer_assoc_arg {
 	u32 peer_eht_tx_mcs_set[WMI_MAX_EHTCAP_RATE_SET];
 	struct ath12k_wmi_ppe_threshold_arg peer_eht_ppet;
 	u32 punct_bitmap;
+	bool is_assoc;
+	struct peer_assoc_mlo_params ml;
 };
 
+#define ATH12K_WMI_FLAG_MLO_ENABLED			BIT(0)
+#define ATH12K_WMI_FLAG_MLO_ASSOC_LINK			BIT(1)
+#define ATH12K_WMI_FLAG_MLO_PRIMARY_UMAC		BIT(2)
+#define ATH12K_WMI_FLAG_MLO_LINK_ID_VALID		BIT(3)
+#define ATH12K_WMI_FLAG_MLO_PEER_ID_VALID		BIT(4)
+
+struct wmi_peer_assoc_mlo_partner_info_params {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 hw_link_id;
+	__le32 flags;
+	__le32 logical_link_idx;
+} __packed;
+
+struct wmi_peer_assoc_mlo_params {
+	__le32 tlv_header;
+	__le32 flags;
+	struct ath12k_wmi_mac_addr_params mld_addr;
+	__le32 logical_link_idx;
+	__le32 ml_peer_id;
+	__le32 ieee_link_id;
+	__le32 emlsr_trans_timeout_us;
+	__le32 emlsr_trans_delay_us;
+	__le32 emlsr_padding_delay_us;
+} __packed;
+
 struct wmi_peer_assoc_complete_cmd {
 	__le32 tlv_header;
 	struct ath12k_wmi_mac_addr_params peer_macaddr;
-- 
2.39.5


