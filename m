Return-Path: <linux-wireless+bounces-14382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813FD9ACB40
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC49283E44
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952761BE223;
	Wed, 23 Oct 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3EvMymJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D81BDA8F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690209; cv=none; b=SZTX5V1AFlkRYAF7sVDHeAcb27qyV1TixBekgpWrFeqmSfJHuWCxFEY+I5tLW2mXrwBCZjMSI6qz4n88hhhnMGZJOJwW5JlsvYaMqadisvX6LUvIm08P4MIyxN1wssenmkl2MXkO/+0Iyn5TZb69EoUDP/RTeUZSETS1+/CmBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690209; c=relaxed/simple;
	bh=OqTpJ2jbbFEu+BeFpWXTXmtDDAU9NbrUBZsTbn6ltMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lB7Sk0l5ZoBWnZM97DAHlKcFAfB6KwkMAHI8CnZNA7H/7L6DfGiDW/GnlhyqdSC6Vpg6dpBsd+fEbSzmXOIkVHGzZWsZU1Q3mZev2mW51nnJ7G2RfGj/PSDGV5B2CazKdQ8e9Yd9ZS9JpUwGgQPvoMIv0nE1IXI8UM8xk1cjfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3EvMymJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB9EC4CECD;
	Wed, 23 Oct 2024 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690209;
	bh=OqTpJ2jbbFEu+BeFpWXTXmtDDAU9NbrUBZsTbn6ltMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3EvMymJhK2CrrmCnP7mK+SUVsa9Ihe4VyBLvbyh/r139paUWhKn7zPxz3PJHqAEG
	 0BFB16FGRcfccIrd7NcpOzvSgjfcAJzSId/42Si3viEH6tNNEQEQT5wlHX8jcbwjYa
	 u3BbNGluqFt7xmLx79+plOKfULaMf9U4CvT7z8C70UZT2pEWdJ0XU9V+VrewpQigJN
	 YINbpwcS2upQDIn8lOFXT0bWU7eMa8JDXNAbYnkaapGp/0IqjxjUhC0blLKcCZki4g
	 C8bhbb/a+Gj4KOB+Wz20PQxoug5q2zXXv/wf+5XauFgTL8laIaTP6Xr6UE/BENNqsr
	 5lW1oDZlYZ94g==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/8] wifi: ath12k: MLO vdev bringup changes
Date: Wed, 23 Oct 2024 16:29:58 +0300
Message-Id: <20241023133004.2253830-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023133004.2253830-1-kvalo@kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Add changes to add the link vdevs dynamically whenever a channel is assigned
from mac80211 for a link vdev. During vdev create, update ML address of the
vdev to firmware using the new WMI parameter (WMI_TAG_MLO_VDEV_CREATE_PARAMS).

During vdev start, notify the firmware that this link vdev is newly added and
also indicate all its known partners so that the firmware can take necessary
actions to internally update the partners on the new link being added.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 90 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c | 85 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h | 74 ++++++++++++++++++++++
 3 files changed, 244 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f45f32f3b5f6..d4aa4540c8e6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -648,6 +648,18 @@ struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id)
 	return NULL;
 }
 
+static bool ath12k_mac_is_ml_arvif(struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+
+	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
+
+	if (ahvif->vif->valid_links & BIT(arvif->link_id))
+		return true;
+
+	return false;
+}
+
 static struct ath12k *ath12k_mac_get_ar_by_chan(struct ieee80211_hw *hw,
 						struct ieee80211_channel *channel)
 {
@@ -1512,7 +1524,8 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 	tx_ahvif = ath12k_vif_to_ahvif(ahvif->vif->mbssid_tx_vif);
 	tx_arvif = &tx_ahvif->deflink;
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
-							 tx_ahvif->vif, 0);
+							 tx_ahvif->vif,
+							 tx_arvif->link_id);
 	if (!beacons || !beacons->cnt) {
 		ath12k_warn(arvif->ar->ab,
 			    "failed to get ema beacon templates from mac80211\n");
@@ -1577,7 +1590,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 	}
 
 	bcn = ieee80211_beacon_get_template(ath12k_ar_to_hw(tx_arvif->ar), tx_ahvif->vif,
-					    &offs, 0);
+					    &offs, tx_arvif->link_id);
 	if (!bcn) {
 		ath12k_warn(ab, "failed to get beacon template from mac80211\n");
 		return -EPERM;
@@ -1658,7 +1671,7 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 
 	ahvif->aid = 0;
 
-	ether_addr_copy(arvif->bssid, info->bssid);
+	ether_addr_copy(arvif->bssid, info->addr);
 
 	params.vdev_id = arvif->vdev_id;
 	params.aid = ahvif->aid;
@@ -6671,6 +6684,8 @@ static int ath12k_mac_setup_vdev_create_arg(struct ath12k_link_vif *arvif,
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	int ret;
 
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
 	arg->if_id = arvif->vdev_id;
 	arg->type = ahvif->vdev_type;
 	arg->subtype = ahvif->vdev_subtype;
@@ -6702,6 +6717,17 @@ static int ath12k_mac_setup_vdev_create_arg(struct ath12k_link_vif *arvif,
 	}
 
 	arg->if_stats_id = ath12k_mac_get_vdev_stats_id(arvif);
+
+	if (ath12k_mac_is_ml_arvif(arvif)) {
+		if (hweight16(ahvif->vif->valid_links) > ATH12K_WMI_MLO_MAX_LINKS) {
+			ath12k_warn(ar->ab, "too many MLO links during setting up vdev: %d",
+				    ahvif->vif->valid_links);
+			return -EINVAL;
+		}
+
+		ether_addr_copy(arg->mld_addr, ahvif->vif->addr);
+	}
+
 	return 0;
 }
 
@@ -7639,6 +7665,61 @@ ath12k_mac_check_down_grade_phy_mode(struct ath12k *ar,
 	return down_mode;
 }
 
+static void
+ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
+			     struct wmi_ml_arg *ml_arg)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct wmi_ml_partner_info *partner_info;
+	struct ieee80211_bss_conf *link_conf;
+	struct ath12k_link_vif *arvif_p;
+	unsigned long links;
+	u8 link_id;
+
+	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
+
+	if (!ath12k_mac_is_ml_arvif(arvif))
+		return;
+
+	if (hweight16(ahvif->vif->valid_links) > ATH12K_WMI_MLO_MAX_LINKS)
+		return;
+
+	rcu_read_lock();
+
+	ml_arg->enabled = true;
+
+	/* Driver always add a new link via VDEV START, FW takes
+	 * care of internally adding this link to existing
+	 * link vdevs which are advertised as partners below
+	 */
+	ml_arg->link_add = true;
+	partner_info = ml_arg->partner_info;
+
+	links = ahvif->links_map;
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif_p = rcu_dereference(ahvif->link[link_id]);
+
+		if (WARN_ON(!arvif_p))
+			continue;
+
+		if (arvif == arvif_p)
+			continue;
+
+		link_conf = rcu_dereference(ahvif->vif->link_conf[arvif_p->link_id]);
+
+		if (!link_conf)
+			continue;
+
+		partner_info->vdev_id = arvif_p->vdev_id;
+		partner_info->hw_link_id = arvif_p->ar->pdev->hw_link_id;
+		ether_addr_copy(partner_info->addr, link_conf->addr);
+		ml_arg->num_partner_links++;
+		partner_info++;
+	}
+
+	rcu_read_unlock();
+}
+
 static int
 ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 			      struct ieee80211_chanctx_conf *ctx,
@@ -7717,6 +7798,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 
 	arg.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
 
+	if (!restart)
+		ath12k_mac_mlo_get_vdev_args(arvif, &arg.ml);
+
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac vdev %d start center_freq %d phymode %s punct_bitmap 0x%x\n",
 		   arg.vdev_id, arg.freq,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index dced2aa9ba1a..e089b58bbea1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -821,6 +821,8 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
 	struct wmi_vdev_create_cmd *cmd;
 	struct sk_buff *skb;
 	struct ath12k_wmi_vdev_txrx_streams_params *txrx_streams;
+	bool is_ml_vdev = is_valid_ether_addr(args->mld_addr);
+	struct wmi_vdev_create_mlo_params *ml_params;
 	struct wmi_tlv *tlv;
 	int ret, len;
 	void *ptr;
@@ -830,7 +832,8 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
 	 * both the bands.
 	 */
 	len = sizeof(*cmd) + TLV_HDR_SIZE +
-		(WMI_NUM_SUPPORTED_BAND_MAX * sizeof(*txrx_streams));
+		(WMI_NUM_SUPPORTED_BAND_MAX * sizeof(*txrx_streams)) +
+		(is_ml_vdev ? TLV_HDR_SIZE + sizeof(*ml_params) : 0);
 
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -879,6 +882,21 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
 	txrx_streams->supported_rx_streams =
 				cpu_to_le32(args->chains[NL80211_BAND_5GHZ].rx);
 
+	ptr += WMI_NUM_SUPPORTED_BAND_MAX * sizeof(*txrx_streams);
+
+	if (is_ml_vdev) {
+		tlv = ptr;
+		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+						 sizeof(*ml_params));
+		ptr += TLV_HDR_SIZE;
+		ml_params = ptr;
+
+		ml_params->tlv_header =
+			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_VDEV_CREATE_PARAMS,
+					       sizeof(*ml_params));
+		ether_addr_copy(ml_params->mld_macaddr.addr, args->mld_addr);
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "WMI vdev create: id %d type %d subtype %d macaddr %pM pdevid %d\n",
 		   args->if_id, args->type, args->subtype,
@@ -1020,19 +1038,27 @@ static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart)
 {
+	struct wmi_vdev_start_mlo_params *ml_params;
+	struct wmi_partner_link_info *partner_info;
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_vdev_start_request_cmd *cmd;
 	struct sk_buff *skb;
 	struct ath12k_wmi_channel_params *chan;
 	struct wmi_tlv *tlv;
 	void *ptr;
-	int ret, len;
+	int ret, len, i, ml_arg_size = 0;
 
 	if (WARN_ON(arg->ssid_len > sizeof(cmd->ssid.ssid)))
 		return -EINVAL;
 
 	len = sizeof(*cmd) + sizeof(*chan) + TLV_HDR_SIZE;
 
+	if (!restart && arg->ml.enabled) {
+		ml_arg_size = TLV_HDR_SIZE + sizeof(*ml_params) +
+			      TLV_HDR_SIZE + (arg->ml.num_partner_links *
+					      sizeof(*partner_info));
+		len += ml_arg_size;
+	}
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
@@ -1085,6 +1111,61 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 
 	ptr += sizeof(*tlv);
 
+	if (ml_arg_size) {
+		tlv = ptr;
+		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+						 sizeof(*ml_params));
+		ptr += TLV_HDR_SIZE;
+
+		ml_params = ptr;
+
+		ml_params->tlv_header =
+			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_VDEV_START_PARAMS,
+					       sizeof(*ml_params));
+
+		ml_params->flags = le32_encode_bits(arg->ml.enabled,
+						    ATH12K_WMI_FLAG_MLO_ENABLED) |
+				   le32_encode_bits(arg->ml.assoc_link,
+						    ATH12K_WMI_FLAG_MLO_ASSOC_LINK) |
+				   le32_encode_bits(arg->ml.mcast_link,
+						    ATH12K_WMI_FLAG_MLO_MCAST_VDEV) |
+				   le32_encode_bits(arg->ml.link_add,
+						    ATH12K_WMI_FLAG_MLO_LINK_ADD);
+
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %d start ml flags 0x%x\n",
+			   arg->vdev_id, ml_params->flags);
+
+		ptr += sizeof(*ml_params);
+
+		tlv = ptr;
+		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+						 arg->ml.num_partner_links *
+						 sizeof(*partner_info));
+		ptr += TLV_HDR_SIZE;
+
+		partner_info = ptr;
+
+		for (i = 0; i < arg->ml.num_partner_links; i++) {
+			partner_info->tlv_header =
+				ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PARTNER_LINK_PARAMS,
+						       sizeof(*partner_info));
+			partner_info->vdev_id =
+				cpu_to_le32(arg->ml.partner_info[i].vdev_id);
+			partner_info->hw_link_id =
+				cpu_to_le32(arg->ml.partner_info[i].hw_link_id);
+			ether_addr_copy(partner_info->vdev_addr.addr,
+					arg->ml.partner_info[i].addr);
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %d hw_link_id %d macaddr%pM\n",
+				   partner_info->vdev_id, partner_info->hw_link_id,
+				   partner_info->vdev_addr.addr);
+
+			partner_info++;
+		}
+
+		ptr = partner_info;
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %s id 0x%x freq 0x%x mode 0x%x\n",
 		   restart ? "restart" : "start", arg->vdev_id,
 		   arg->freq, arg->mode);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6f55dbdf629d..33b9643644c6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1929,6 +1929,19 @@ enum wmi_tlv_tag {
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
+	WMI_TAG_DCS_AWGN_INT_TYPE = 0x3C5,
+	WMI_TAG_MLO_TX_SEND_PARAMS,
+	WMI_TAG_MLO_PARTNER_LINK_PARAMS,
+	WMI_TAG_MLO_PARTNER_LINK_PARAMS_PEER_ASSOC,
+	WMI_TAG_MLO_SETUP_CMD = 0x3C9,
+	WMI_TAG_MLO_SETUP_COMPLETE_EVENT,
+	WMI_TAG_MLO_READY_CMD,
+	WMI_TAG_MLO_TEARDOWN_CMD,
+	WMI_TAG_MLO_TEARDOWN_COMPLETE,
+	WMI_TAG_MLO_PEER_ASSOC_PARAMS = 0x3D0,
+	WMI_TAG_MLO_PEER_CREATE_PARAMS = 0x3D5,
+	WMI_TAG_MLO_VDEV_START_PARAMS = 0x3D6,
+	WMI_TAG_MLO_VDEV_CREATE_PARAMS = 0x3D7,
 	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
 	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD = 0x3D9,
 	WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD = 0x3FB,
@@ -2740,6 +2753,7 @@ struct ath12k_wmi_vdev_create_arg {
 	u8 if_stats_id;
 	u32 mbssid_flags;
 	u32 mbssid_tx_vdev_id;
+	u8 mld_addr[ETH_ALEN];
 };
 
 #define ATH12K_MAX_VDEV_STATS_ID	0x30
@@ -2766,6 +2780,44 @@ struct ath12k_wmi_vdev_txrx_streams_params {
 	__le32 supported_rx_streams;
 } __packed;
 
+/* 2 word representation of MAC addr */
+struct wmi_mac_addr {
+	union {
+		u8 addr[6];
+		struct {
+			u32 word0;
+			u32 word1;
+		} __packed;
+	} __packed;
+} __packed;
+
+struct wmi_vdev_create_mlo_params {
+	__le32 tlv_header;
+	struct wmi_mac_addr mld_macaddr;
+} __packed;
+
+#define ATH12K_WMI_FLAG_MLO_ENABLED			BIT(0)
+#define ATH12K_WMI_FLAG_MLO_ASSOC_LINK			BIT(1)
+#define ATH12K_WMI_FLAG_MLO_PRIMARY_UMAC		BIT(2)
+#define ATH12K_WMI_FLAG_MLO_LOGICAL_LINK_IDX_VALID	BIT(3)
+#define ATH12K_WMI_FLAG_MLO_PEER_ID_VALID		BIT(4)
+#define ATH12K_WMI_FLAG_MLO_MCAST_VDEV			BIT(5)
+#define ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT		BIT(6)
+#define ATH12K_WMI_FLAG_MLO_FORCED_INACTIVE		BIT(7)
+#define ATH12K_WMI_FLAG_MLO_LINK_ADD			BIT(8)
+
+struct wmi_vdev_start_mlo_params {
+	__le32 tlv_header;
+	__le32 flags;
+} __packed;
+
+struct wmi_partner_link_info {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 hw_link_id;
+	struct wmi_mac_addr vdev_addr;
+} __packed;
+
 struct wmi_vdev_delete_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
@@ -2909,6 +2961,27 @@ enum wmi_phy_mode {
 	MODE_MAX = 33,
 };
 
+#define ATH12K_WMI_MLO_MAX_LINKS 4
+
+struct wmi_ml_partner_info {
+	u32 vdev_id;
+	u32 hw_link_id;
+	u8 addr[ETH_ALEN];
+	bool assoc_link;
+	bool primary_umac;
+	bool logical_link_idx_valid;
+	u32 logical_link_idx;
+};
+
+struct wmi_ml_arg {
+	bool enabled;
+	bool assoc_link;
+	bool mcast_link;
+	bool link_add;
+	u8 num_partner_links;
+	struct wmi_ml_partner_info partner_info[ATH12K_WMI_MLO_MAX_LINKS];
+};
+
 struct wmi_vdev_start_req_arg {
 	u32 vdev_id;
 	u32 freq;
@@ -2946,6 +3019,7 @@ struct wmi_vdev_start_req_arg {
 	u32 mbssid_flags;
 	u32 mbssid_tx_vdev_id;
 	u32 punct_bitmap;
+	struct wmi_ml_arg ml;
 };
 
 struct ath12k_wmi_peer_create_arg {
-- 
2.39.5


