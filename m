Return-Path: <linux-wireless+bounces-13969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B9899F3C1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285A4B2290E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747781F9413;
	Tue, 15 Oct 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUUwvyuG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E817335C
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012461; cv=none; b=Owxv7f9acX4fe/C+NSDpWIcQ5cVbNzunSC3NkrAQdaU4g4LAmXLEfytQX28Bn1mCzyozbgo1be+45DoC5Iv9Pt/Xqh+96ZkXepQ77j5KHN4JAMR4z6ZCNNfCKNkWLY6ETXCWOaYMZ5xOa/xfmquj577T6bc1kQ4BdKYxFcoCuVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012461; c=relaxed/simple;
	bh=Vd5/XO8Tadw5wtwTZwzTddOQUMZPZfSbzfr+NQ4GijQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2vsRMwb0aa5vaR6Y3QdAaXuM5JAq7ILzZpTH7n3r2kOomnZGkf2YvJO7P66WKWAgvNnTAbar5V92tNg5NY1mkepMTcYPIF9Kk+ke15SAFHha0iQ48VL4jFcs1dxye9S30XY1qVgc9zoddhW3LBCwBjlYgOVYRD6aXtp9VYY1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUUwvyuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED318C4CECD;
	Tue, 15 Oct 2024 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012461;
	bh=Vd5/XO8Tadw5wtwTZwzTddOQUMZPZfSbzfr+NQ4GijQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUUwvyuGGYILT2Zhc6BoDzPIL2oIEDtSPswUiQthCi3ghEHlekugHWYLu+ErihtW/
	 XmwrfV63LMxY1DL0Co0bKUrW65aSM/5CUdL50q5KnVnyhbv3ZMeE7ZQe5l6N2BGmNk
	 Yz2TDnTi2XzzHD/sXk4qZIR3WynCJBaEWe2Sv1jnOyCELu5xvOIp4VHGlQr74ywBUa
	 9RtZZKIy0duaCo9bFkd/qEaJX4yTh2xGO0g87N1rsFBALuFYIzjLrlBUel8A+/Skdr
	 ZYjYGOLYgppRVl+ZArd96WoUglEVu+i8Z3+6RjsWMTDlT14jPRKoHT4Fn6gtFFgBOX
	 5MQ1AWSY8aDGg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 01/11] wifi: ath12k: prepare vif data structure for MLO handling
Date: Tue, 15 Oct 2024 20:14:06 +0300
Message-Id: <20241015171416.518022-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015171416.518022-1-kvalo@kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

To prepare the driver for MLO support, split the driver vif data structure to
scale for multiple links. This requires changing the use of arvif to per link
and not per hw which can now comprise of multiple links. Also since most
configurations from mac80211 are done per link, do refactoring of the driver
functions to apply these configurations at link level.

Split ath12k_vif which is the driver private of ieee80211_vif to store link
specific information as ath12k_link_vif. For default use cases the ath12k vif
will have a preallocated link vif called deflink which will be used by non ML
and the first link vif of ML vif.

With MLO support to be added, remaining link vifs will be allocated during
channel assignment where vdev create/start happens. These link vifs will be
freed during interface down.

       		Current ath12k_vif(arvif) structure

             +---------------+      +---------------+     +---------------+
             | ieee80211_vif |      | ieee80211_vif |     | ieee80211_vif |
             | private data  |      | private data  |     | private data  |
             |               |      |               |     |               |
             |  ath12k_vif   |      |  ath12k_vif   |     |  ath12k_vif   |
             |  (arvif)      |      |  (arvif)      |     |  (arvif)      |
             |               |      |               |     |               |
             |  +----------+ |      |  +----------+ |     |  +----------+ |
             |  |*ar (2GHz)| |      |  |*ar (5GHz)| |     |  |*ar (2GHz)| |
             |  +----------+ |      |  +----------+ |     |  +----------+ |
             |               |      |               |     |               |
             +---------------+      +---------------+     +---------------+

The new ath12k_vif (ahvif) containing ath12k_link_vif(s) (arvif) (deflink is
preallocated member which is always the first link if ieee80211_vif is MLD and
is the only link otherwise):

       			+---------------------------------+
       			|     ieee80211_vif               |
       			|     private data                |
       			|                                 |
       			|   ath12k_vif(ahvif)             |
       			|                                 |
       			| +-------------------------------+
       			| |ath12k_link_vif deflink (arvif)|
       			| |        +---------------+      |
       			| |        | *ar(2GHz)     |      |
       			| +-------------------------------+
       			| +-------------------------------+
       			| |  ath12k_link_vif *link (arvif)|
       			| |        +---------------+      |
       			| |        | *ar(5GHz)     |      |
       			| +-------------------------------+
       			| +-------------------------------+
       			| |  ath12k_link_vif *link (arvif)|
       			| |        +---------------+      |
       			| |        | *ar(6GHz)     |      |
       			| +-------------------------------+
       			|                                 |
       			+---------------------------------+

To refactor existing ath12k_vif to make use of link vifs, following
changes are made:

 1. ath12k_vif now called by variable name ahvif storing multiple
    arvifs (struct ah12k_link_vif) and also has a back pointer to ieee80211_vif.

 2. In this patch set, only deflink is used to be on par with the
    existing code. When MLO support is added the link id will be used to fetch
    the arvif.

 3. For mac80211 ops which doesn't use specific link_id, the config or info
    is common for the vif, hence apply the config to all link vifs.
    The links_map in the ahvif, will be used to identify all the link vifs that
    are setup.

 4. Change ath12k_vif_to_arvif() as ath12k_vif_to_ahvif() to fetch the
    hw level vif. The link vif can be fetched from ahvif->link[], or the
    deflink can be accessed via ahvif->deflink. API to access link
    vif (arvif) by passing link_id can be introduced with MLO Support.

 5. The ieee80211_vif can be accessed from ahvif using ath12k_ahvif_to_vif().

The locking continues to use wiphy_lock() for protecting access to most data in
struct ath12k&co, there are no changes in that regard. Though struct
ath12k_vif::link[] is protected with RCU.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  |  66 ++-
 drivers/net/wireless/ath/ath12k/dp.c    |  21 +-
 drivers/net/wireless/ath/ath12k/dp.h    |   3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h |   2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c |   9 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 726 +++++++++++++++---------
 drivers/net/wireless/ath/ath12k/mac.h   |  11 +-
 drivers/net/wireless/ath/ath12k/p2p.c   |  17 +-
 drivers/net/wireless/ath/ath12k/p2p.h   |   2 +-
 drivers/net/wireless/ath/ath12k/peer.c  |   5 +-
 drivers/net/wireless/ath/ath12k/peer.h  |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c   |  22 +-
 drivers/net/wireless/ath/ath12k/wmi.h   |   8 +-
 drivers/net/wireless/ath/ath12k/wow.c   |  59 +-
 16 files changed, 605 insertions(+), 354 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ebfc1e370acc..2672bca7dc29 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -238,10 +238,8 @@ struct ath12k_rekey_data {
 	bool enable_offload;
 };
 
-struct ath12k_vif {
+struct ath12k_link_vif {
 	u32 vdev_id;
-	enum wmi_vdev_type vdev_type;
-	enum wmi_vdev_subtype vdev_subtype;
 	u32 beacon_interval;
 	u32 dtim_period;
 	u16 ast_hash;
@@ -251,13 +249,39 @@ struct ath12k_vif {
 	u8 search_type;
 
 	struct ath12k *ar;
-	struct ieee80211_vif *vif;
 
 	int bank_id;
 	u8 vdev_id_check_en;
 
 	struct wmi_wmm_params_all_arg wmm_params;
 	struct list_head list;
+
+	bool is_created;
+	bool is_started;
+	bool is_up;
+	u8 bssid[ETH_ALEN];
+	struct cfg80211_bitrate_mask bitrate_mask;
+	struct delayed_work connection_loss_work;
+	int num_legacy_stations;
+	int rtscts_prot_mode;
+	int txpower;
+	bool rsnie_present;
+	bool wpaie_present;
+	struct ieee80211_chanctx_conf chanctx;
+	u8 vdev_stats_id;
+	u32 punct_bitmap;
+	u8 link_id;
+	struct ath12k_vif *ahvif;
+	struct ath12k_vif_cache *cache;
+	struct ath12k_rekey_data rekey_data;
+};
+
+struct ath12k_vif {
+	enum wmi_vdev_type vdev_type;
+	enum wmi_vdev_subtype vdev_subtype;
+	struct ieee80211_vif *vif;
+	struct ath12k_hw *ah;
+
 	union {
 		struct {
 			u32 uapsd;
@@ -275,25 +299,15 @@ struct ath12k_vif {
 		} ap;
 	} u;
 
-	bool is_created;
-	bool is_started;
-	bool is_up;
 	u32 aid;
-	u8 bssid[ETH_ALEN];
-	struct cfg80211_bitrate_mask bitrate_mask;
-	struct delayed_work connection_loss_work;
-	int num_legacy_stations;
-	int rtscts_prot_mode;
-	int txpower;
-	bool rsnie_present;
-	bool wpaie_present;
 	u32 key_cipher;
 	u8 tx_encap_type;
-	u8 vdev_stats_id;
-	u32 punct_bitmap;
 	bool ps;
-	struct ath12k_vif_cache *cache;
-	struct ath12k_rekey_data rekey_data;
+
+	struct ath12k_link_vif deflink;
+	struct ath12k_link_vif __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	/* indicates bitmap of link vif created in FW */
+	u16 links_map;
 
 	/* Must be last - ends in a flexible-array member.
 	 *
@@ -306,7 +320,7 @@ struct ath12k_vif {
 struct ath12k_vif_iter {
 	u32 vdev_id;
 	struct ath12k *ar;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 };
 
 #define HAL_AST_IDX_INVALID	0xFFFF
@@ -442,7 +456,7 @@ struct ath12k_wbm_tx_stats {
 };
 
 struct ath12k_sta {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 
 	/* the following are protected by ar->data_lock */
 	u32 changed; /* IEEE80211_RC_* */
@@ -564,7 +578,7 @@ struct ath12k {
 	bool monitor_present;
 
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
-	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_vif info,
+	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_link_vif info,
 	 * channel context data, survey info, test mode data.
 	 */
 	spinlock_t data_lock;
@@ -663,6 +677,7 @@ struct ath12k_hw {
 	enum ath12k_hw_state state;
 	bool regd_updated;
 	bool use_6ghz_regd;
+
 	u8 num_radio;
 
 	/* Keep last */
@@ -1021,7 +1036,7 @@ static inline struct ath12k_skb_rxcb *ATH12K_SKB_RXCB(struct sk_buff *skb)
 	return (struct ath12k_skb_rxcb *)skb->cb;
 }
 
-static inline struct ath12k_vif *ath12k_vif_to_arvif(struct ieee80211_vif *vif)
+static inline struct ath12k_vif *ath12k_vif_to_ahvif(struct ieee80211_vif *vif)
 {
 	return (struct ath12k_vif *)vif->drv_priv;
 }
@@ -1031,6 +1046,11 @@ static inline struct ath12k_sta *ath12k_sta_to_arsta(struct ieee80211_sta *sta)
 	return (struct ath12k_sta *)sta->drv_priv;
 }
 
+static inline struct ieee80211_vif *ath12k_ahvif_to_vif(struct ath12k_vif *ahvif)
+{
+	return container_of((void *)ahvif, struct ieee80211_vif, drv_priv);
+}
+
 static inline struct ath12k *ath12k_ab_to_ar(struct ath12k_base *ab,
 					     int mac_id)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 2ab2a7d45be9..1125362bfea6 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -327,20 +327,22 @@ int ath12k_dp_srng_setup(struct ath12k_base *ab, struct dp_srng *ring,
 }
 
 static
-u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab, struct ath12k_vif *arvif)
+u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
+				      struct ath12k_link_vif *arvif)
 {
 	u32 bank_config = 0;
+	struct ath12k_vif *ahvif = arvif->ahvif;
 
 	/* Only valid for raw frames with HW crypto enabled.
 	 * With SW crypto, mac80211 sets key per packet
 	 */
-	if (arvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
+	if (ahvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
 	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		bank_config |=
-			u32_encode_bits(ath12k_dp_tx_get_encrypt_type(arvif->key_cipher),
+			u32_encode_bits(ath12k_dp_tx_get_encrypt_type(ahvif->key_cipher),
 					HAL_TX_BANK_CONFIG_ENCRYPT_TYPE);
 
-	bank_config |= u32_encode_bits(arvif->tx_encap_type,
+	bank_config |= u32_encode_bits(ahvif->tx_encap_type,
 					HAL_TX_BANK_CONFIG_ENCAP_TYPE);
 	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_SRC_BUFFER_SWAP) |
 			u32_encode_bits(0, HAL_TX_BANK_CONFIG_LINK_META_SWAP) |
@@ -355,7 +357,7 @@ u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab, struct ath12k_vif
 					HAL_TX_ADDRY_EN),
 					HAL_TX_BANK_CONFIG_ADDRY_EN);
 
-	bank_config |= u32_encode_bits(ieee80211_vif_is_mesh(arvif->vif) ? 3 : 0,
+	bank_config |= u32_encode_bits(ieee80211_vif_is_mesh(ahvif->vif) ? 3 : 0,
 					HAL_TX_BANK_CONFIG_MESH_EN) |
 			u32_encode_bits(arvif->vdev_id_check_en,
 					HAL_TX_BANK_CONFIG_VDEV_ID_CHECK_EN);
@@ -365,7 +367,8 @@ u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab, struct ath12k_vif
 	return bank_config;
 }
 
-static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab, struct ath12k_vif *arvif,
+static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab,
+					 struct ath12k_link_vif *arvif,
 					 struct ath12k_dp *dp)
 {
 	int bank_id = DP_INVALID_BANK_ID;
@@ -1099,9 +1102,9 @@ int ath12k_dp_htt_connect(struct ath12k_dp *dp)
 	return 0;
 }
 
-static void ath12k_dp_update_vdev_search(struct ath12k_vif *arvif)
+static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
 {
-	switch (arvif->vdev_type) {
+	switch (arvif->ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_STA:
 		/* TODO: Verify the search type and flags since ast hash
 		 * is not part of peer mapv3
@@ -1120,7 +1123,7 @@ static void ath12k_dp_update_vdev_search(struct ath12k_vif *arvif)
 	}
 }
 
-void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_vif *arvif)
+void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif)
 {
 	struct ath12k_base *ab = ar->ab;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 07180eec8f26..2e05fc19410e 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -16,6 +16,7 @@ struct ath12k_base;
 struct ath12k_peer;
 struct ath12k_dp;
 struct ath12k_vif;
+struct ath12k_link_vif;
 struct hal_tcl_status_ring;
 struct ath12k_ext_irq_grp;
 
@@ -1799,7 +1800,7 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 			   struct ath12k_ext_irq_grp *irq_grp,
 			   int budget);
 int ath12k_dp_htt_connect(struct ath12k_dp *dp);
-void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_vif *arvif);
+void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
 void ath12k_dp_free(struct ath12k_base *ab);
 int ath12k_dp_alloc(struct ath12k_base *ab);
 void ath12k_dp_cc_config(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 91e3393f7b5f..941bbbd4e777 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1091,7 +1091,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 	return ret;
 }
 
-int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_vif *arvif,
+int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 				       const u8 *peer_addr,
 				       enum set_key_cmd key_cmd,
 				       struct ieee80211_key_conf *key)
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index eb1f92559179..bfd4f814553e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -88,7 +88,7 @@ int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params);
 int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 			    struct ieee80211_ampdu_params *params);
-int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_vif *arvif,
+int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 				       const u8 *peer_addr,
 				       enum set_key_cmd key_cmd,
 				       struct ieee80211_key_conf *key);
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 44406e0b4a34..a8d341a6df01 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -10,7 +10,7 @@
 #include "hw.h"
 
 static enum hal_tcl_encap_type
-ath12k_dp_tx_get_encap_type(struct ath12k_vif *arvif, struct sk_buff *skb)
+ath12k_dp_tx_get_encap_type(struct ath12k_link_vif *arvif, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ath12k_base *ab = arvif->ar->ab;
@@ -216,7 +216,7 @@ static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 	return ret;
 }
 
-int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
+int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		 struct sk_buff *skb)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -230,6 +230,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 	struct sk_buff *skb_ext_desc;
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct dp_tx_ring *tx_ring;
 	u8 pool_id;
 	u8 hal_ring_id;
@@ -274,7 +275,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 	ti.bank_id = arvif->bank_id;
 	ti.meta_data_flags = arvif->tcl_metadata;
 
-	if (arvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
+	if (ahvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
 	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
 		if (skb_cb->flags & ATH12K_SKB_CIPHER_SET) {
 			ti.encrypt_type =
@@ -376,7 +377,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 	ti.desc_id = tx_desc->desc_id;
 	ti.data_len = skb->len;
 	skb_cb->paddr = ti.paddr;
-	skb_cb->vif = arvif->vif;
+	skb_cb->vif = ahvif->vif;
 	skb_cb->ar = ar;
 
 	if (msdu_ext_desc) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 55ff8cc721e3..46dce23501f3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -16,7 +16,7 @@ struct ath12k_dp_htt_wbm_tx_status {
 };
 
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
-int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
+int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		 struct sk_buff *skb);
 void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d3c37b895b69..92f05bc7c7fa 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -250,7 +250,7 @@ static const u32 ath12k_smps_map[] = {
 };
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
-				   struct ath12k_vif *arvif);
+				   struct ath12k_link_vif *arvif);
 static void ath12k_mac_stop(struct ath12k *ar);
 static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif);
 static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif);
@@ -539,18 +539,22 @@ static void ath12k_get_arvif_iter(void *data, u8 *mac,
 				  struct ieee80211_vif *vif)
 {
 	struct ath12k_vif_iter *arvif_iter = data;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif = &ahvif->deflink;
 
 	if (arvif->vdev_id == arvif_iter->vdev_id &&
 	    arvif->ar == arvif_iter->ar)
 		arvif_iter->arvif = arvif;
 }
 
-struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
+struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 {
 	struct ath12k_vif_iter arvif_iter = {};
 	u32 flags;
 
+	/* To use the arvif returned, caller must have held rcu read lock.
+	 */
+	WARN_ON(!rcu_read_lock_any_held());
 	arvif_iter.vdev_id = vdev_id;
 	arvif_iter.ar = ar;
 
@@ -567,12 +571,12 @@ struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 	return arvif_iter.arvif;
 }
 
-struct ath12k_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
-						   u32 vdev_id)
+struct ath12k_link_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
+							u32 vdev_id)
 {
 	int i;
 	struct ath12k_pdev *pdev;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = rcu_dereference(ab->pdevs_active[i]);
@@ -658,7 +662,8 @@ static struct ath12k *ath12k_get_ar_by_ctx(struct ieee80211_hw *hw,
 static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif = &ahvif->deflink;
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 
 	/* If there is one pdev within ah, then we return
@@ -673,9 +678,9 @@ static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 	return NULL;
 }
 
-static struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar)
+static struct ath12k_link_vif *ath12k_mac_get_vif_up(struct ath12k *ar)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -706,11 +711,11 @@ static bool ath12k_mac_band_match(enum nl80211_band band1, enum WMI_HOST_WLAN_BA
 	return false;
 }
 
-static u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif)
+static u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_link_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	u8 pdev_id = ab->fw_pdev[0].pdev_id;
@@ -731,7 +736,7 @@ static u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif)
 
 u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	struct ath12k_base *ab = ar->ab;
 
 	if (!ab->hw_params->single_pdev_only)
@@ -771,7 +776,7 @@ static void ath12k_pdev_caps_update(struct ath12k *ar)
 static int ath12k_mac_txpower_recalc(struct ath12k *ar)
 {
 	struct ath12k_pdev *pdev = ar->pdev;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret, txpower = -1;
 	u32 param;
 
@@ -825,7 +830,7 @@ static int ath12k_mac_txpower_recalc(struct ath12k *ar)
 	return ret;
 }
 
-static int ath12k_recalc_rtscts_prot(struct ath12k_vif *arvif)
+static int ath12k_recalc_rtscts_prot(struct ath12k_link_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
 	u32 vdev_param, rts_cts;
@@ -864,7 +869,7 @@ static int ath12k_recalc_rtscts_prot(struct ath12k_vif *arvif)
 	return ret;
 }
 
-static int ath12k_mac_set_kickout(struct ath12k_vif *arvif)
+static int ath12k_mac_set_kickout(struct ath12k_link_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
 	u32 param;
@@ -1230,8 +1235,9 @@ static int ath12k_mac_monitor_stop(struct ath12k *ar)
 	return ret;
 }
 
-static int ath12k_mac_vdev_stop(struct ath12k_vif *arvif)
+static int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
 {
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1257,7 +1263,7 @@ static int ath12k_mac_vdev_stop(struct ath12k_vif *arvif)
 
 	ar->num_started_vdevs--;
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "vdev %pM stopped, vdev_id %d\n",
-		   arvif->vif->addr, arvif->vdev_id);
+		   ahvif->vif->addr, arvif->vdev_id);
 
 	if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
 		clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
@@ -1324,7 +1330,7 @@ static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	return ret;
 }
 
-static int ath12k_mac_setup_bcn_p2p_ie(struct ath12k_vif *arvif,
+static int ath12k_mac_setup_bcn_p2p_ie(struct ath12k_link_vif *arvif,
 				       struct sk_buff *bcn)
 {
 	struct ath12k *ar = arvif->ar;
@@ -1381,7 +1387,7 @@ static int ath12k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
 	return 0;
 }
 
-static void ath12k_mac_set_arvif_ies(struct ath12k_vif *arvif, struct sk_buff *bcn,
+static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_buff *bcn,
 				     u8 bssid_index, bool *nontx_profile_found)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)bcn->data;
@@ -1473,19 +1479,22 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_vif *arvif, struct sk_buff *b
 	}
 }
 
-static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_vif *arvif)
+static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 {
-	struct ieee80211_bss_conf *bss_conf = &arvif->vif->bss_conf;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_bss_conf *bss_conf = &ahvif->vif->bss_conf;
 	struct ath12k_wmi_bcn_tmpl_ema_arg ema_args;
 	struct ieee80211_ema_beacons *beacons;
-	struct ath12k_vif *tx_arvif;
+	struct ath12k_link_vif *tx_arvif;
 	bool nontx_profile_found = false;
+	struct ath12k_vif *tx_ahvif;
 	int ret = 0;
 	u8 i;
 
-	tx_arvif = ath12k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	tx_ahvif = ath12k_vif_to_ahvif(ahvif->vif->mbssid_tx_vif);
+	tx_arvif = &tx_ahvif->deflink;
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
-							 tx_arvif->vif, 0);
+							 tx_ahvif->vif, 0);
 	if (!beacons || !beacons->cnt) {
 		ath12k_warn(arvif->ar->ab,
 			    "failed to get ema beacon templates from mac80211\n");
@@ -1523,22 +1532,25 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_vif *arvif)
 	return ret;
 }
 
-static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
+static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 {
-	struct ath12k_vif *tx_arvif = arvif;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ath12k_link_vif *tx_arvif = arvif;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
+	struct ath12k_vif *tx_ahvif = ahvif;
 	bool nontx_profile_found = false;
 	struct sk_buff *bcn;
 	int ret;
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
+	if (ahvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return 0;
 
 	if (vif->mbssid_tx_vif) {
-		tx_arvif = ath12k_vif_to_arvif(vif->mbssid_tx_vif);
+		tx_ahvif = ath12k_vif_to_ahvif(vif->mbssid_tx_vif);
+		tx_arvif = &tx_ahvif->deflink;
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
 
@@ -1546,7 +1558,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 			return ath12k_mac_setup_bcn_tmpl_ema(arvif);
 	}
 
-	bcn = ieee80211_beacon_get_template(ath12k_ar_to_hw(tx_arvif->ar), tx_arvif->vif,
+	bcn = ieee80211_beacon_get_template(ath12k_ar_to_hw(tx_arvif->ar), tx_ahvif->vif,
 					    &offs, 0);
 	if (!bcn) {
 		ath12k_warn(ab, "failed to get beacon template from mac80211\n");
@@ -1557,14 +1569,14 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 		ath12k_mac_set_arvif_ies(arvif, bcn, 0, NULL);
 	} else {
 		ath12k_mac_set_arvif_ies(arvif, bcn,
-					 arvif->vif->bss_conf.bssid_index,
+					 ahvif->vif->bss_conf.bssid_index,
 					 &nontx_profile_found);
 		if (!nontx_profile_found)
 			ath12k_warn(ab,
 				    "nontransmitted profile not found in beacon template\n");
 	}
 
-	if (arvif->vif->type == NL80211_IFTYPE_AP && arvif->vif->p2p) {
+	if (ahvif->vif->type == NL80211_IFTYPE_AP && ahvif->vif->p2p) {
 		ret = ath12k_mac_setup_bcn_p2p_ie(arvif, bcn);
 		if (ret) {
 			ath12k_warn(ab, "failed to setup P2P GO bcn ie: %d\n",
@@ -1598,10 +1610,11 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 	return ret;
 }
 
-static void ath12k_control_beaconing(struct ath12k_vif *arvif,
+static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath12k_wmi_vdev_up_params params = {};
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1625,15 +1638,19 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 		return;
 	}
 
-	arvif->aid = 0;
+	ahvif->aid = 0;
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
 	params.vdev_id = arvif->vdev_id;
-	params.aid = arvif->aid;
+	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
-	if (arvif->vif->mbssid_tx_vif) {
-		params.tx_bssid = ath12k_vif_to_arvif(arvif->vif->mbssid_tx_vif)->bssid;
+	if (ahvif->vif->mbssid_tx_vif) {
+		struct ath12k_vif *tx_ahvif =
+			ath12k_vif_to_ahvif(ahvif->vif->mbssid_tx_vif);
+		struct ath12k_link_vif *tx_arvif = &tx_ahvif->deflink;
+
+		params.tx_bssid = tx_arvif->bssid;
 		params.nontx_profile_idx = info->bssid_index;
 		params.nontx_profile_cnt = 1 << info->bssid_indicator;
 	}
@@ -1654,7 +1671,8 @@ static void ath12k_mac_handle_beacon_iter(void *data, u8 *mac,
 {
 	struct sk_buff *skb = data;
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif = &ahvif->deflink;
 
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
@@ -1677,7 +1695,8 @@ static void ath12k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
 					       struct ieee80211_vif *vif)
 {
 	u32 *vdev_id = data;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif = &ahvif->deflink;
 	struct ath12k *ar = arvif->ar;
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 
@@ -1708,9 +1727,9 @@ void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id)
 
 static void ath12k_mac_vif_sta_connection_loss_work(struct work_struct *work)
 {
-	struct ath12k_vif *arvif = container_of(work, struct ath12k_vif,
-						connection_loss_work.work);
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k_link_vif *arvif = container_of(work, struct ath12k_link_vif,
+						     connection_loss_work.work);
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
 
 	if (!arvif->is_up)
 		return;
@@ -1723,12 +1742,14 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 				      struct ieee80211_sta *sta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ath12k_link_vif *arvif;
 	u32 aid;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
 	if (vif->type == NL80211_IFTYPE_STATION)
 		aid = vif->cfg.aid;
 	else
@@ -1749,16 +1770,18 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 				       struct ieee80211_sta *sta,
 				       struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ieee80211_bss_conf *info = &vif->bss_conf;
+	struct ath12k_link_vif *arvif;
 	struct cfg80211_chan_def def;
 	struct cfg80211_bss *bss;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	const u8 *rsnie = NULL;
 	const u8 *wpaie = NULL;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -1811,12 +1834,13 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 				      struct ieee80211_sta *sta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
 	struct cfg80211_chan_def def;
 	const struct ieee80211_supported_band *sband;
 	const struct ieee80211_rate *rates;
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ath12k_link_vif *arvif;
 	enum nl80211_band band;
 	u32 ratemask;
 	u8 rate;
@@ -1824,6 +1848,7 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -1874,8 +1899,9 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 				   struct ieee80211_sta *sta,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -1885,6 +1911,7 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -2035,8 +2062,9 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 				    struct ieee80211_sta *sta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u16 *vht_mcs_mask;
@@ -2045,6 +2073,10 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	u8 max_nss, vht_mcs;
 	int i;
 
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	arvif = &ahvif->deflink;
+
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -2383,9 +2415,9 @@ static void ath12k_peer_assoc_h_qos(struct ath12k *ar,
 				    struct ieee80211_sta *sta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 
-	switch (arvif->vdev_type) {
+	switch (ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
 		if (sta->wme) {
 			/* TODO: Check WME vs QoS */
@@ -2415,7 +2447,7 @@ static void ath12k_peer_assoc_h_qos(struct ath12k *ar,
 }
 
 static int ath12k_peer_assoc_qos_ap(struct ath12k *ar,
-				    struct ath12k_vif *arvif,
+				    struct ath12k_link_vif *arvif,
 				    struct ieee80211_sta *sta)
 {
 	struct ath12k_wmi_ap_ps_arg arg;
@@ -2581,13 +2613,17 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 					struct ieee80211_sta *sta,
 					struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
 	enum wmi_phy_mode phymode = MODE_UNKNOWN;
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -2726,13 +2762,17 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 				    struct ieee80211_sta *sta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	const struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20;
 	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_link_vif *arvif;
 	u32 *rx_mcs, *tx_mcs;
 
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	arvif = &ahvif->deflink;
 	if (!sta->deflink.he_cap.has_he || !eht_cap->has_eht)
 		return;
 
@@ -2832,7 +2872,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	/* TODO: amsdu_disable req? */
 }
 
-static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
+static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_link_vif *arvif,
 				  const u8 *addr,
 				  const struct ieee80211_sta_ht_cap *ht_cap,
 				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa)
@@ -2852,10 +2892,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
 }
 
 static void ath12k_bss_assoc(struct ath12k *ar,
-			     struct ath12k_vif *arvif,
+			     struct ath12k_link_vif *arvif,
 			     struct ieee80211_bss_conf *bss_conf)
 {
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	struct ieee80211_sta *ap_sta;
@@ -2866,7 +2907,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %i assoc bssid %pM aid %d\n",
-		   arvif->vdev_id, arvif->bssid, arvif->aid);
+		   arvif->vdev_id, arvif->bssid, ahvif->aid);
 
 	rcu_read_lock();
 
@@ -2906,11 +2947,11 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 
 	WARN_ON(arvif->is_up);
 
-	arvif->aid = vif->cfg.aid;
+	ahvif->aid = vif->cfg.aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
 	params.vdev_id = arvif->vdev_id;
-	params.aid = arvif->aid;
+	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
 	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
@@ -2952,7 +2993,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 }
 
 static void ath12k_bss_disassoc(struct ath12k *ar,
-				struct ath12k_vif *arvif)
+				struct ath12k_link_vif *arvif)
 {
 	int ret;
 
@@ -3002,9 +3043,10 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 					 struct ieee80211_vif *vif,
 					 struct cfg80211_chan_def *def)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	const struct ieee80211_supported_band *sband;
+	struct ath12k_link_vif *arvif;
 	u8 basic_rate_idx;
 	int hw_rate_code;
 	u32 vdev_param;
@@ -3013,6 +3055,7 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
 	sband = hw->wiphy->bands[def->chan->band];
 	basic_rate_idx = ffs(vif->bss_conf.basic_rates) - 1;
 	bitrate = sband->bitrates[basic_rate_idx].bitrate;
@@ -3036,9 +3079,10 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 		ath12k_warn(ar->ab, "failed to set beacon tx rate %d\n", ret);
 }
 
-static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
+static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ath12k *ar = arvif->ar;
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct sk_buff *tmpl;
@@ -3049,7 +3093,7 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 	if (info->fils_discovery.max_interval) {
 		interval = info->fils_discovery.max_interval;
 
-		tmpl = ieee80211_get_fils_discovery_tmpl(hw, arvif->vif);
+		tmpl = ieee80211_get_fils_discovery_tmpl(hw, vif);
 		if (tmpl)
 			ret = ath12k_wmi_fils_discovery_tmpl(ar, arvif->vdev_id,
 							     tmpl);
@@ -3057,8 +3101,7 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 		unsol_bcast_probe_resp_enabled = 1;
 		interval = info->unsol_bcast_probe_resp_interval;
 
-		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw,
-								 arvif->vif);
+		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
 		if (tmpl)
 			ret = ath12k_wmi_probe_resp_tmpl(ar, arvif->vdev_id,
 							 tmpl);
@@ -3083,10 +3126,10 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 	return ret;
 }
 
-static void ath12k_mac_vif_setup_ps(struct ath12k_vif *arvif)
+static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
 	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
 	enum wmi_sta_powersave_param param;
 	enum wmi_sta_ps_mode psmode;
@@ -3099,7 +3142,7 @@ static void ath12k_mac_vif_setup_ps(struct ath12k_vif *arvif)
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	enable_ps = arvif->ps;
+	enable_ps = arvif->ahvif->ps;
 	if (enable_ps) {
 		psmode = WMI_STA_PS_MODE_ENABLED;
 		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
@@ -3131,11 +3174,12 @@ static void ath12k_mac_vif_setup_ps(struct ath12k_vif *arvif)
 }
 
 static void ath12k_mac_bss_info_changed(struct ath12k *ar,
-					struct ath12k_vif *arvif,
+					struct ath12k_link_vif *arvif,
 					struct ieee80211_bss_conf *info,
 					u64 changed)
 {
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
@@ -3205,10 +3249,10 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 
 	if (changed & BSS_CHANGED_SSID &&
 	    vif->type == NL80211_IFTYPE_AP) {
-		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
+		ahvif->u.ap.ssid_len = vif->cfg.ssid_len;
 		if (vif->cfg.ssid_len)
-			memcpy(arvif->u.ap.ssid, vif->cfg.ssid, vif->cfg.ssid_len);
-		arvif->u.ap.hidden_ssid = info->hidden_ssid;
+			memcpy(ahvif->u.ap.ssid, vif->cfg.ssid, vif->cfg.ssid_len);
+		ahvif->u.ap.hidden_ssid = info->hidden_ssid;
 	}
 
 	if (changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid))
@@ -3319,7 +3363,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	if (changed & BSS_CHANGED_MCAST_RATE &&
-	    !ath12k_mac_vif_chan(arvif->vif, &def)) {
+	    !ath12k_mac_vif_chan(vif, &def)) {
 		band = def.chan->band;
 		mcast_rate = vif->bss_conf.mcast_rate[band];
 
@@ -3363,7 +3407,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	if (changed & BSS_CHANGED_BASIC_RATES &&
-	    !ath12k_mac_vif_chan(arvif->vif, &def))
+	    !ath12k_mac_vif_chan(vif, &def))
 		ath12k_recalculate_mgmt_rate(ar, vif, &def);
 
 	if (changed & BSS_CHANGED_TWT) {
@@ -3409,12 +3453,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 
 	if (changed & BSS_CHANGED_PS &&
 	    ar->ab->hw_params->supports_sta_ps) {
-		arvif->ps = vif_cfg->ps;
+		ahvif->ps = vif_cfg->ps;
 		ath12k_mac_vif_setup_ps(arvif);
 	}
 }
 
-static struct ath12k_vif_cache *ath12k_arvif_get_cache(struct ath12k_vif *arvif)
+static struct ath12k_vif_cache *ath12k_arvif_get_cache(struct ath12k_link_vif *arvif)
 {
 	if (!arvif->cache)
 		arvif->cache = kzalloc(sizeof(*arvif->cache), GFP_KERNEL);
@@ -3422,7 +3466,7 @@ static struct ath12k_vif_cache *ath12k_arvif_get_cache(struct ath12k_vif *arvif)
 	return arvif->cache;
 }
 
-static void ath12k_arvif_put_cache(struct ath12k_vif *arvif)
+static void ath12k_arvif_put_cache(struct ath12k_link_vif *arvif)
 {
 	kfree(arvif->cache);
 	arvif->cache = NULL;
@@ -3434,11 +3478,16 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   u64 changed)
 {
 	struct ath12k *ar;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_vif_cache *cache;
+	struct ath12k_link_vif *arvif;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	/* TODO use info->link_id and fetch corresponding ahvif->link[]
+	 * with MLO support.
+	 */
+	arvif = &ahvif->deflink;
 	ar = ath12k_get_ar_by_vif(hw, vif);
 
 	/* if the vdev is not created on a certain radio,
@@ -3446,10 +3495,16 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	 */
 
 	if (!ar) {
+		/* TODO Once link vif is fetched based on link id from
+		 * info, avoid using the deflink above and cache the link
+		 * configs in ahvif per link.
+		 */
 		cache = ath12k_arvif_get_cache(arvif);
 		if (!cache)
 			return;
+
 		arvif->cache->bss_conf_changed |= changed;
+
 		return;
 	}
 
@@ -3662,7 +3717,8 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar, *prev_ar;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct cfg80211_scan_request *req = &hw_req->req;
 	struct ath12k_wmi_scan_req_arg *arg = NULL;
 	int ret;
@@ -3671,6 +3727,8 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	if (ah->num_radio == 1) {
 		WARN_ON(!arvif->is_created);
 		ar = ath12k_ah_to_ar(ah, 0);
@@ -3808,11 +3866,14 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct ath12k *ar;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	if (!arvif->is_created)
 		return;
 
@@ -3823,7 +3884,7 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&ar->scan.timeout);
 }
 
-static int ath12k_install_key(struct ath12k_vif *arvif,
+static int ath12k_install_key(struct ath12k_link_vif *arvif,
 			      struct ieee80211_key_conf *key,
 			      enum set_key_cmd cmd,
 			      const u8 *macaddr, u32 flags)
@@ -3838,6 +3899,8 @@ static int ath12k_install_key(struct ath12k_vif *arvif,
 		.key_flags = flags,
 		.macaddr = macaddr,
 	};
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -3890,13 +3953,13 @@ static int ath12k_install_key(struct ath12k_vif *arvif,
 	if (!wait_for_completion_timeout(&ar->install_key_done, 1 * HZ))
 		return -ETIMEDOUT;
 
-	if (ether_addr_equal(macaddr, arvif->vif->addr))
-		arvif->key_cipher = key->cipher;
+	if (ether_addr_equal(macaddr, vif->addr))
+		ahvif->key_cipher = key->cipher;
 
 	return ar->install_key_status ? -EINVAL : 0;
 }
 
-static int ath12k_clear_peer_keys(struct ath12k_vif *arvif,
+static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 				  const u8 *addr)
 {
 	struct ath12k *ar = arvif->ar;
@@ -3942,8 +4005,9 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 			      struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 			      struct ieee80211_key_conf *key)
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
 	const u8 *peer_addr;
@@ -3952,12 +4016,13 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	arvif = &ahvif->deflink;
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
 
 	if (sta)
 		peer_addr = sta->addr;
-	else if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
+	else if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
 		peer_addr = vif->bss_conf.bssid;
 	else
 		peer_addr = vif->addr;
@@ -4051,19 +4116,23 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct ath12k_vif_cache *cache;
 	struct ath12k *ar;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	/* BIP needs to be done in software */
 	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
-	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
+	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256) {
 		return 1;
+	}
 
 	if (key->keyidx > WMI_MAX_KEY_INDEX)
 		return -ENOSPC;
@@ -4079,13 +4148,21 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		cache = ath12k_arvif_get_cache(arvif);
 		if (!cache)
 			return -ENOSPC;
+
 		cache->key_conf.cmd = cmd;
 		cache->key_conf.key = key;
 		cache->key_conf.changed = true;
+
 		return 0;
 	}
 
+	/* Note: Currently only deflink of ahvif is used here, once MLO
+	 * support is added the allocated links (i.e ahvif->links[])
+	 * should be use based on link id passed from mac80211 and such link
+	 * access needs to be protected with ah->conf_mutex.
+	 */
 	ret = ath12k_mac_set_key(ar, cmd, vif, sta, key);
+
 	return ret;
 }
 
@@ -4104,7 +4181,7 @@ ath12k_mac_bitrate_mask_num_vht_rates(struct ath12k *ar,
 }
 
 static int
-ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_vif *arvif,
+ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 				   struct ieee80211_sta *sta,
 				   const struct cfg80211_bitrate_mask *mask,
 				   enum nl80211_band band)
@@ -4154,16 +4231,18 @@ static int ath12k_station_assoc(struct ath12k *ar,
 				struct ieee80211_sta *sta,
 				bool reassoc)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	int ret;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
+	struct ath12k_link_vif *arvif;
 	struct cfg80211_bitrate_mask *mask;
 	u8 num_vht_rates;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return -EPERM;
 
@@ -4242,11 +4321,13 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	arvif = &ahvif->deflink;
 	if (!sta->wme) {
 		arvif->num_legacy_stations--;
 		ret = ath12k_recalc_rtscts_prot(arvif);
@@ -4266,8 +4347,8 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 {
 	struct ath12k *ar;
-	struct ath12k_vif *arvif;
 	struct ath12k_sta *arsta;
+	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
@@ -4278,15 +4359,17 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	const struct cfg80211_bitrate_mask *mask;
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
+	struct ieee80211_vif *vif;
 
 	lockdep_assert_wiphy(wiphy);
 
 	arsta = container_of(wk, struct ath12k_sta, update_wk);
 	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
 	arvif = arsta->arvif;
+	vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	ar = arvif->ar;
 
-	if (WARN_ON(ath12k_mac_vif_chan(arvif->vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
 	band = def.chan->band;
@@ -4310,7 +4393,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		ath12k_peer_assoc_h_phymode(ar, arvif->vif, sta, &peer_arg);
+		ath12k_peer_assoc_h_phymode(ar, vif, sta, &peer_arg);
 		peer_phymode = peer_arg.peer_phymode;
 
 		if (bw > bw_prev) {
@@ -4405,7 +4488,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			 * is provided in the new bitrate mask we set the
 			 * other rates using peer_assoc command.
 			 */
-			ath12k_peer_assoc_prepare(ar, arvif->vif, sta,
+			ath12k_peer_assoc_prepare(ar, vif, sta,
 						  &peer_arg, true);
 
 			err = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
@@ -4420,14 +4503,14 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	}
 }
 
-static int ath12k_mac_inc_num_stations(struct ath12k_vif *arvif,
+static int ath12k_mac_inc_num_stations(struct ath12k_link_vif *arvif,
 				       struct ieee80211_sta *sta)
 {
 	struct ath12k *ar = arvif->ar;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_STA && !sta->tdls)
+	if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_STA && !sta->tdls)
 		return 0;
 
 	if (ar->num_stations >= ar->max_num_stations)
@@ -4438,14 +4521,14 @@ static int ath12k_mac_inc_num_stations(struct ath12k_vif *arvif,
 	return 0;
 }
 
-static void ath12k_mac_dec_num_stations(struct ath12k_vif *arvif,
+static void ath12k_mac_dec_num_stations(struct ath12k_link_vif *arvif,
 					struct ieee80211_sta *sta)
 {
 	struct ath12k *ar = arvif->ar;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_STA && !sta->tdls)
+	if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_STA && !sta->tdls)
 		return;
 
 	ar->num_stations--;
@@ -4456,20 +4539,21 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 				  struct ieee80211_sta *sta)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_wmi_peer_create_arg peer_param;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	arvif = &ahvif->deflink;
 	ret = ath12k_mac_inc_num_stations(arvif, sta);
 	if (ret) {
 		ath12k_warn(ab, "refusing to associate station: too many connected already (%d)\n",
 			    ar->max_num_stations);
 		goto exit;
 	}
-
 	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
 	if (!arsta->rx_stats) {
 		ret = -ENOMEM;
@@ -4510,7 +4594,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 
 	if (ab->hw_params->vdev_start_delay &&
 	    !arvif->is_started &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
+	    arvif->ahvif->vdev_type != WMI_VDEV_TYPE_AP) {
 		ret = ath12k_start_vdev_delay(ar, arvif);
 		if (ret) {
 			ath12k_warn(ab, "failed to delay vdev start: %d\n", ret);
@@ -4565,14 +4649,17 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   enum ieee80211_sta_state old_state,
 				   enum ieee80211_sta_state new_state)
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k *ar;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	struct ath12k_link_vif *arvif;
 	struct ath12k_peer *peer;
 	int ret = 0;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
 		WARN_ON_ONCE(1);
@@ -4593,7 +4680,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		    new_state == IEEE80211_STA_NOTEXIST)) {
 		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
 
-		if (arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+		if (ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
 			ath12k_bss_disassoc(ar, arvif);
 			ret = ath12k_mac_vdev_stop(arvif);
 			if (ret)
@@ -4689,22 +4776,29 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	int ret;
 	s16 txpwr;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	if (sta->deflink.txpwr.type == NL80211_TX_POWER_AUTOMATIC) {
 		txpwr = 0;
 	} else {
 		txpwr = sta->deflink.txpwr.power;
-		if (!txpwr)
-			return -EINVAL;
+		if (!txpwr) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
-	if (txpwr > ATH12K_TX_POWER_MAX_VAL || txpwr < ATH12K_TX_POWER_MIN_VAL)
-		return -EINVAL;
+	if (txpwr > ATH12K_TX_POWER_MAX_VAL || txpwr < ATH12K_TX_POWER_MIN_VAL) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
@@ -4713,9 +4807,10 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set tx power for station ret: %d\n",
 			    ret);
-		return ret;
+		goto out;
 	}
 
+out:
 	return ret;
 }
 
@@ -4726,9 +4821,14 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct ath12k_peer *peer;
 	u32 bw, smps;
+	/* TODO: use proper link id once link sta specific rc update support is
+	 * available in mac80211.
+	 */
+	u8 link_id = ATH12K_DEFAULT_LINK_ID;
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
@@ -4736,11 +4836,20 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 		return;
 	}
 
+	rcu_read_lock();
+	arvif = rcu_dereference(ahvif->link[link_id]);
+	if (!arvif) {
+		ath12k_warn(ar->ab, "mac sta rc update failed to fetch link vif on link id %u for peer %pM\n",
+			    link_id, sta->addr);
+		rcu_read_unlock();
+		return;
+	}
 	spin_lock_bh(&ar->ab->base_lock);
 
 	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
 	if (!peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
+		rcu_read_unlock();
 		ath12k_warn(ar->ab, "mac sta rc update failed to find peer %pM on vdev %i\n",
 			    sta->addr, arvif->vdev_id);
 		return;
@@ -4793,16 +4902,19 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	wiphy_work_queue(hw->wiphy, &arsta->update_wk);
+
+	rcu_read_unlock();
 }
 
-static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
+static int ath12k_conf_tx_uapsd(struct ath12k_link_vif *arvif,
 				u16 ac, bool enable)
 {
 	struct ath12k *ar = arvif->ar;
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	u32 value;
 	int ret;
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+	if (ahvif->vdev_type != WMI_VDEV_TYPE_STA)
 		return 0;
 
 	switch (ac) {
@@ -4825,19 +4937,19 @@ static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
 	}
 
 	if (enable)
-		arvif->u.sta.uapsd |= value;
+		ahvif->u.sta.uapsd |= value;
 	else
-		arvif->u.sta.uapsd &= ~value;
+		ahvif->u.sta.uapsd &= ~value;
 
 	ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id,
 					  WMI_STA_PS_PARAM_UAPSD,
-					  arvif->u.sta.uapsd);
+					  ahvif->u.sta.uapsd);
 	if (ret) {
 		ath12k_warn(ar->ab, "could not set uapsd params %d\n", ret);
 		goto exit;
 	}
 
-	if (arvif->u.sta.uapsd)
+	if (ahvif->u.sta.uapsd)
 		value = WMI_STA_PS_RX_WAKE_POLICY_POLL_UAPSD;
 	else
 		value = WMI_STA_PS_RX_WAKE_POLICY_WAKE;
@@ -4852,7 +4964,7 @@ static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
 	return ret;
 }
 
-static int ath12k_mac_conf_tx(struct ath12k_vif *arvif,
+static int ath12k_mac_conf_tx(struct ath12k_link_vif *arvif,
 			      unsigned int link_id, u16 ac,
 			      const struct ieee80211_tx_queue_params *params)
 {
@@ -4910,22 +5022,26 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 				 unsigned int link_id, u16 ac,
 				 const struct ieee80211_tx_queue_params *params)
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
+	struct ath12k_vif_cache *cache;
 	struct ath12k *ar;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_vif_cache *cache = arvif->cache;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
 		/* cache the info and apply after vdev is created */
 		cache = ath12k_arvif_get_cache(arvif);
 		if (!cache)
 			return -ENOSPC;
+
 		cache->tx_conf.changed = true;
 		cache->tx_conf.ac = ac;
 		cache->tx_conf.tx_queue_params = *params;
+
 		return 0;
 	}
 
@@ -5000,10 +5116,11 @@ ath12k_create_ht_cap(struct ath12k *ar, u32 ar_ht_cap, u32 rate_cap_rx_chainmask
 	return ht_cap;
 }
 
-static int ath12k_mac_set_txbf_conf(struct ath12k_vif *arvif)
+static int ath12k_mac_set_txbf_conf(struct ath12k_link_vif *arvif)
 {
 	u32 value = 0;
 	struct ath12k *ar = arvif->ar;
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	int nsts;
 	int sound_dim;
 	u32 vht_cap = ar->pdev->cap.vht_cap;
@@ -5031,7 +5148,7 @@ static int ath12k_mac_set_txbf_conf(struct ath12k_vif *arvif)
 		value |= WMI_VDEV_PARAM_TXBF_SU_TX_BFER;
 
 		if ((vht_cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) &&
-		    arvif->vdev_type == WMI_VDEV_TYPE_AP)
+		    ahvif->vdev_type == WMI_VDEV_TYPE_AP)
 			value |= WMI_VDEV_PARAM_TXBF_MU_TX_BFER;
 	}
 
@@ -5039,7 +5156,7 @@ static int ath12k_mac_set_txbf_conf(struct ath12k_vif *arvif)
 		value |= WMI_VDEV_PARAM_TXBF_SU_TX_BFEE;
 
 		if ((vht_cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE) &&
-		    arvif->vdev_type == WMI_VDEV_TYPE_STA)
+		    ahvif->vdev_type == WMI_VDEV_TYPE_STA)
 			value |= WMI_VDEV_PARAM_TXBF_MU_TX_BFEE;
 	}
 
@@ -5700,7 +5817,7 @@ static int ath12k_mac_vif_txmgmt_idr_remove(int buf_id, void *skb, void *ctx)
 	return 0;
 }
 
-static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_vif *arvif,
+static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arvif,
 				  struct sk_buff *skb)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -5768,7 +5885,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
 {
 	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
 	struct ath12k_skb_cb *skb_cb;
-	struct ath12k_vif *arvif;
+	struct ath12k_vif *ahvif;
+	struct ath12k_link_vif *arvif;
 	struct sk_buff *skb;
 	int ret;
 
@@ -5780,8 +5898,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
 			continue;
 		}
 
-		arvif = ath12k_vif_to_arvif(skb_cb->vif);
-
+		ahvif = ath12k_vif_to_ahvif(skb_cb->vif);
+		arvif = &ahvif->deflink;
 		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
 			ret = ath12k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
@@ -5836,18 +5954,18 @@ static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
 				      struct sk_buff *skb,
 				      bool is_prb_rsp)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 
 	if (likely(!is_prb_rsp))
 		return;
 
 	spin_lock_bh(&ar->data_lock);
 
-	if (arvif->u.ap.noa_data &&
-	    !pskb_expand_head(skb, 0, arvif->u.ap.noa_len,
+	if (ahvif->u.ap.noa_data &&
+	    !pskb_expand_head(skb, 0, ahvif->u.ap.noa_len,
 			      GFP_ATOMIC))
-		skb_put_data(skb, arvif->u.ap.noa_data,
-			     arvif->u.ap.noa_len);
+		skb_put_data(skb, ahvif->u.ap.noa_data,
+			     ahvif->u.ap.noa_len);
 
 	spin_unlock_bh(&ar->data_lock);
 }
@@ -5859,7 +5977,8 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif = &ahvif->deflink;
 	struct ath12k *ar = arvif->ar;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
@@ -6188,7 +6307,7 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 }
 
 static u8
-ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
+ath12k_mac_get_vdev_stats_id(struct ath12k_link_vif *arvif)
 {
 	struct ath12k_base *ab = arvif->ar->ab;
 	u8 vdev_stats_id = 0;
@@ -6210,19 +6329,22 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
 	return vdev_stats_id;
 }
 
-static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_vif *arvif,
+static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 					       u32 *flags, u32 *tx_vdev_id)
 {
-	struct ieee80211_vif *tx_vif = arvif->vif->mbssid_tx_vif;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *tx_vif = ahvif->vif->mbssid_tx_vif;
 	struct ath12k *ar = arvif->ar;
-	struct ath12k_vif *tx_arvif;
+	struct ath12k_link_vif *tx_arvif;
+	struct ath12k_vif *tx_ahvif;
 
 	if (!tx_vif)
 		return 0;
 
-	tx_arvif = ath12k_vif_to_arvif(tx_vif);
+	tx_ahvif = ath12k_vif_to_ahvif(tx_vif);
+	tx_arvif = &tx_ahvif->deflink;
 
-	if (arvif->vif->bss_conf.nontransmitted) {
+	if (ahvif->vif->bss_conf.nontransmitted) {
 		if (ar->ah->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
 			return -EINVAL;
 
@@ -6234,22 +6356,23 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_vif *arvif,
 		return -EINVAL;
 	}
 
-	if (arvif->vif->bss_conf.ema_ap)
+	if (ahvif->vif->bss_conf.ema_ap)
 		*flags |= WMI_VDEV_MBSSID_FLAGS_EMA_MODE;
 
 	return 0;
 }
 
-static int ath12k_mac_setup_vdev_create_arg(struct ath12k_vif *arvif,
+static int ath12k_mac_setup_vdev_create_arg(struct ath12k_link_vif *arvif,
 					    struct ath12k_wmi_vdev_create_arg *arg)
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_pdev *pdev = ar->pdev;
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	int ret;
 
 	arg->if_id = arvif->vdev_id;
-	arg->type = arvif->vdev_type;
-	arg->subtype = arvif->vdev_subtype;
+	arg->type = ahvif->vdev_type;
+	arg->subtype = ahvif->vdev_subtype;
 	arg->pdev_id = pdev->pdev_id;
 
 	arg->mbssid_flags = WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP;
@@ -6316,14 +6439,15 @@ ath12k_mac_prepare_he_mode(struct ath12k_pdev *pdev, u32 viftype)
 }
 
 static int ath12k_set_he_mu_sounding_mode(struct ath12k *ar,
-					  struct ath12k_vif *arvif)
+					  struct ath12k_link_vif *arvif)
 {
 	u32 param_id, param_value;
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	int ret;
 
 	param_id = WMI_VDEV_PARAM_SET_HEMU_MODE;
-	param_value = ath12k_mac_prepare_he_mode(ar->pdev, arvif->vif->type);
+	param_value = ath12k_mac_prepare_he_mode(ar->pdev, ahvif->vif->type);
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param_id, param_value);
 	if (ret) {
@@ -6346,9 +6470,10 @@ static int ath12k_set_he_mu_sounding_mode(struct ath12k *ar,
 	return ret;
 }
 
-static void ath12k_mac_update_vif_offload(struct ath12k_vif *arvif)
+static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 {
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
 	u32 param_id, param_value;
@@ -6361,14 +6486,14 @@ static void ath12k_mac_update_vif_offload(struct ath12k_vif *arvif)
 					IEEE80211_OFFLOAD_DECAP_ENABLED);
 
 	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
-		arvif->tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
+		ahvif->tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
 	else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
-		arvif->tx_encap_type = ATH12K_HW_TXRX_RAW;
+		ahvif->tx_encap_type = ATH12K_HW_TXRX_RAW;
 	else
-		arvif->tx_encap_type = ATH12K_HW_TXRX_NATIVE_WIFI;
+		ahvif->tx_encap_type = ATH12K_HW_TXRX_NATIVE_WIFI;
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    param_id, arvif->tx_encap_type);
+					    param_id, ahvif->tx_encap_type);
 	if (ret) {
 		ath12k_warn(ab, "failed to set vdev %d tx encap mode: %d\n",
 			    arvif->vdev_id, ret);
@@ -6395,21 +6520,22 @@ static void ath12k_mac_update_vif_offload(struct ath12k_vif *arvif)
 static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	ath12k_mac_update_vif_offload(arvif);
+	ath12k_mac_update_vif_offload(&ahvif->deflink);
 }
 
-static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
+int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 {
 	struct ath12k_hw *ah = ar->ah;
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hw *hw = ah->hw;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param;
+	struct ath12k_link_vif *arvif;
 	u32 param_id, param_value;
 	u16 nss;
 	int i;
@@ -6417,37 +6543,38 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
 	arvif->ar = ar;
 	vdev_id = __ffs64(ab->free_vdev_map);
 	arvif->vdev_id = vdev_id;
-	arvif->vdev_subtype = WMI_VDEV_SUBTYPE_NONE;
+	ahvif->vdev_subtype = WMI_VDEV_SUBTYPE_NONE;
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_STATION:
-		arvif->vdev_type = WMI_VDEV_TYPE_STA;
+		ahvif->vdev_type = WMI_VDEV_TYPE_STA;
 
 		if (vif->p2p)
-			arvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_CLIENT;
+			ahvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_CLIENT;
 
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
-		arvif->vdev_subtype = WMI_VDEV_SUBTYPE_MESH_11S;
+		ahvif->vdev_subtype = WMI_VDEV_SUBTYPE_MESH_11S;
 		fallthrough;
 	case NL80211_IFTYPE_AP:
-		arvif->vdev_type = WMI_VDEV_TYPE_AP;
+		ahvif->vdev_type = WMI_VDEV_TYPE_AP;
 
 		if (vif->p2p)
-			arvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_GO;
+			ahvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_GO;
 
 		break;
 	case NL80211_IFTYPE_MONITOR:
-		arvif->vdev_type = WMI_VDEV_TYPE_MONITOR;
+		ahvif->vdev_type = WMI_VDEV_TYPE_MONITOR;
 		ar->monitor_vdev_id = vdev_id;
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
-		arvif->vdev_type = WMI_VDEV_TYPE_STA;
-		arvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_DEVICE;
+		ahvif->vdev_type = WMI_VDEV_TYPE_STA;
+		ahvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_DEVICE;
 		break;
 	default:
 		WARN_ON(1);
@@ -6455,7 +6582,7 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev create id %d type %d subtype %d map %llx\n",
-		   arvif->vdev_id, arvif->vdev_type, arvif->vdev_subtype,
+		   arvif->vdev_id, ahvif->vdev_type, ahvif->vdev_subtype,
 		   ab->free_vdev_map);
 
 	vif->cab_queue = arvif->vdev_id % (ATH12K_HW_MAX_QUEUES - 1);
@@ -6498,7 +6625,7 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 		goto err_vdev_del;
 	}
 
-	switch (arvif->vdev_type) {
+	switch (ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
 		peer_param.vdev_id = arvif->vdev_id;
 		peer_param.peer_addr = vif->addr;
@@ -6574,15 +6701,21 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	}
 
 	ath12k_dp_vdev_tx_attach(ar, arvif);
-
 	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
 		ath12k_mac_monitor_vdev_create(ar);
 
 	arvif->ar = ar;
+	/* TODO use appropriate link id once MLO support is added.
+	 */
+	arvif->link_id = ATH12K_DEFAULT_LINK_ID;
+	rcu_assign_pointer(ahvif->link[arvif->link_id], arvif);
+	ahvif->links_map = BIT(arvif->link_id);
+	synchronize_rcu();
+
 	return ret;
 
 err_peer_del:
-	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		reinit_completion(&ar->peer_delete_done);
 
 		ret = ath12k_wmi_send_peer_delete_cmd(ar, vif->addr,
@@ -6618,16 +6751,18 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	return ret;
 }
 
-static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ieee80211_vif *vif)
+static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_vif_cache *cache = arvif->cache;
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_vif_cache *cache;
 	struct ath12k_base *ab = ar->ab;
-
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	arvif = &ahvif->deflink;
+	cache = arvif->cache;
 	if (!cache)
 		return;
 
@@ -6659,7 +6794,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 						    struct ieee80211_vif *vif,
 						    struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct ath12k_hw *ah = hw->priv;
 	struct ath12k *ar, *prev_ar;
 	struct ath12k_base *ab;
@@ -6667,6 +6803,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	if (ah->num_radio == 1)
 		ar = ah->radio;
 	else if (ctx)
@@ -6742,14 +6880,19 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	int i;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	memset(arvif, 0, sizeof(*arvif));
+	memset(ahvif, 0, sizeof(*ahvif));
 
-	arvif->vif = vif;
+	ahvif->ah = ah;
+	ahvif->vif = vif;
+	arvif = &ahvif->deflink;
+	arvif->ahvif = ahvif;
 
 	INIT_LIST_HEAD(&arvif->list);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
@@ -6776,6 +6919,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	 * vdev needs to be created
 	 */
 	ath12k_mac_assign_vif_to_vdev(hw, vif, NULL);
+
 	return 0;
 }
 
@@ -6806,12 +6950,15 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
 
 static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_link_vif *arvif;
 	unsigned long time_left;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	arvif = &ahvif->deflink;
 	reinit_completion(&ar->vdev_delete_done);
 
 	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
@@ -6832,7 +6979,7 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ar->num_created_vdevs--;
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ar->monitor_vdev_id = -1;
 		ar->monitor_vdev_created = false;
 	} else if (ar->monitor_vdev_created && !ar->monitor_started) {
@@ -6862,6 +7009,12 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 	/* TODO: recal traffic pause state based on the available vdevs */
 	arvif->is_created = false;
 	arvif->ar = NULL;
+	if (arvif->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+		rcu_assign_pointer(ahvif->link[arvif->link_id], NULL);
+		synchronize_rcu();
+		ahvif->links_map &= ~(BIT(arvif->link_id));
+		arvif->link_id = ATH12K_INVALID_LINK_ID;
+	}
 
 	return ret;
 }
@@ -6869,13 +7022,16 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct ath12k_base *ab;
 	struct ath12k *ar;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	if (!arvif->is_created) {
 		/* if we cached some config but never received assign chanctx,
 		 * free the allocated cache.
@@ -6892,7 +7048,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		ret = ath12k_peer_delete(ar, arvif->vdev_id, vif->addr);
 		if (ret)
 			ath12k_warn(ab, "failed to submit AP self-peer removal on vdev %d: %d\n",
@@ -6989,7 +7145,7 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
 	return ret;
 }
 
-static int ath12k_mac_ampdu_action(struct ath12k_vif *arvif,
+static int ath12k_mac_ampdu_action(struct ath12k_link_vif *arvif,
 				   struct ieee80211_ampdu_params *params)
 {
 	struct ath12k *ar = arvif->ar;
@@ -7025,7 +7181,8 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	int ret = -EINVAL;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -7035,6 +7192,7 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 		return -EINVAL;
 
 	ar = ath12k_ah_to_ar(ah, 0);
+	arvif = &ahvif->deflink;
 
 	ret = ath12k_mac_ampdu_action(arvif, params);
 	if (ret)
@@ -7162,7 +7320,7 @@ ath12k_mac_check_down_grade_phy_mode(struct ath12k *ar,
 }
 
 static int
-ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
+ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 			      struct ieee80211_chanctx_conf *ctx,
 			      bool restart)
 {
@@ -7170,7 +7328,8 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	struct ath12k_base *ab = ar->ab;
 	struct wmi_vdev_start_req_arg arg = {};
 	const struct cfg80211_chan_def *chandef = &ctx->def;
-	int he_support = arvif->vif->bss_conf.he_support;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	int he_support = ahvif->vif->bss_conf.he_support;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -7189,7 +7348,7 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 
 	arg.mode = ath12k_mac_check_down_grade_phy_mode(ar, arg.mode,
 							chandef->chan->band,
-							arvif->vif->type);
+							ahvif->vif->type);
 	arg.min_power = 0;
 	arg.max_power = chandef->chan->max_power * 2;
 	arg.max_reg_power = chandef->chan->max_reg_power * 2;
@@ -7209,10 +7368,10 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 			return ret;
 	}
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
-		arg.ssid = arvif->u.ap.ssid;
-		arg.ssid_len = arvif->u.ap.ssid_len;
-		arg.hidden_ssid = arvif->u.ap.hidden_ssid;
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
+		arg.ssid = ahvif->u.ap.ssid;
+		arg.ssid_len = ahvif->u.ap.ssid_len;
+		arg.hidden_ssid = ahvif->u.ap.hidden_ssid;
 
 		/* For now allow DFS for AP mode */
 		arg.chan_radar = !!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
@@ -7259,7 +7418,7 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 
 	ar->num_started_vdevs++;
 	ath12k_dbg(ab, ATH12K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
-		   arvif->vif->addr, arvif->vdev_id);
+		   ahvif->vif->addr, arvif->vdev_id);
 
 	/* Enable CAC Flag in the driver by checking the channel DFS cac time,
 	 * i.e dfs_cac_ms value which will be valid only for radar channels
@@ -7268,7 +7427,7 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	 * during CAC.
 	 */
 	/* TODO: Set the flag for other interface types as required */
-	if (arvif->vdev_type == WMI_VDEV_TYPE_AP &&
+	if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP &&
 	    chandef->chan->dfs_cac_ms &&
 	    chandef->chan->dfs_state == NL80211_DFS_USABLE) {
 		set_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
@@ -7285,13 +7444,13 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	return 0;
 }
 
-static int ath12k_mac_vdev_start(struct ath12k_vif *arvif,
+static int ath12k_mac_vdev_start(struct ath12k_link_vif *arvif,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	return ath12k_mac_vdev_start_restart(arvif, ctx, false);
 }
 
-static int ath12k_mac_vdev_restart(struct ath12k_vif *arvif,
+static int ath12k_mac_vdev_restart(struct ath12k_link_vif *arvif,
 				   struct ieee80211_chanctx_conf *ctx)
 {
 	return ath12k_mac_vdev_start_restart(arvif, ctx, true);
@@ -7309,8 +7468,13 @@ static void
 ath12k_mac_change_chanctx_cnt_iter(void *data, u8 *mac,
 				   struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
+	struct ath12k_link_vif *arvif;
+
+	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
+
+	arvif = &ahvif->deflink;
 
 	if (arvif->ar != arg->ar)
 		return;
@@ -7325,9 +7489,14 @@ static void
 ath12k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
 	struct ieee80211_chanctx_conf *ctx;
+	struct ath12k_link_vif *arvif;
+
+	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
+
+	arvif = &ahvif->deflink;
 
 	if (arvif->ar != arg->ar)
 		return;
@@ -7371,13 +7540,13 @@ static u32 ath12k_mac_nlwidth_to_wmiwidth(enum nl80211_chan_width width)
 }
 
 static int ath12k_mac_update_peer_puncturing_width(struct ath12k *ar,
-						   struct ath12k_vif *arvif,
+						   struct ath12k_link_vif *arvif,
 						   struct cfg80211_chan_def def)
 {
 	u32 param_id, param_value;
 	int ret;
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+	if (arvif->ahvif->vdev_type != WMI_VDEV_TYPE_STA)
 		return 0;
 
 	param_id = WMI_PEER_CHWIDTH_PUNCTURE_20MHZ_BITMAP;
@@ -7403,8 +7572,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_link_vif *arvif;
 	struct ieee80211_vif *vif;
-	struct ath12k_vif *arvif;
+	struct ath12k_vif *ahvif;
 	int ret;
 	int i;
 	bool monitor_vif = false;
@@ -7413,7 +7583,8 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 
 	for (i = 0; i < n_vifs; i++) {
 		vif = vifs[i].vif;
-		arvif = ath12k_vif_to_arvif(vif);
+		ahvif = ath12k_vif_to_ahvif(vif);
+		arvif = &ahvif->deflink;
 
 		if (vif->type == NL80211_IFTYPE_MONITOR)
 			monitor_vif = true;
@@ -7463,10 +7634,14 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 
 		memset(&params, 0, sizeof(params));
 		params.vdev_id = arvif->vdev_id;
-		params.aid = arvif->aid;
+		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
 		if (vif->mbssid_tx_vif) {
-			params.tx_bssid = ath12k_vif_to_arvif(vif->mbssid_tx_vif)->bssid;
+			struct ath12k_vif *ahvif =
+				ath12k_vif_to_ahvif(vif->mbssid_tx_vif);
+			struct ath12k_link_vif *arvif = &ahvif->deflink;
+
+			params.tx_bssid = arvif->bssid;
 			params.nontx_profile_idx = vif->bss_conf.bssid_index;
 			params.nontx_profile_cnt = 1 << vif->bss_conf.bssid_indicator;
 		}
@@ -7559,10 +7734,11 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 }
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
-				   struct ath12k_vif *arvif)
+				   struct ath12k_link_vif *arvif)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	int ret;
 
 	if (WARN_ON(arvif->is_started))
@@ -7576,7 +7752,7 @@ static int ath12k_start_vdev_delay(struct ath12k *ar,
 		return ret;
 	}
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_monitor_vdev_up(ar, arvif->vdev_id);
 		if (ret) {
 			ath12k_warn(ab, "failed put monitor up: %d\n", ret);
@@ -7598,7 +7774,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 	struct ath12k_base *ab;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -7606,10 +7783,12 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	/* For multi radio wiphy, the vdev was not created during add_interface
 	 * create now since we have a channel ctx now to assign to a specific ar/fw
 	 */
+	arvif = &ahvif->deflink;
+
 	ar = ath12k_mac_assign_vif_to_vdev(hw, vif, ctx);
-	if (!ar) {
-		WARN_ON(1);
-		return -EINVAL;
+	if (WARN_ON(!ar)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	ab = ar->ab;
@@ -7622,22 +7801,26 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	/* for some targets bss peer must be created before vdev_start */
 	if (ab->hw_params->vdev_start_delay &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
+	    ahvif->vdev_type != WMI_VDEV_TYPE_AP &&
+	    ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    !ath12k_peer_exist_by_vdev_id(ab, arvif->vdev_id)) {
 		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
-	if (WARN_ON(arvif->is_started))
-		return -EBUSY;
+	if (WARN_ON(arvif->is_started)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_mac_monitor_start(ar);
 		if (ret)
-			return ret;
+			goto out;
+
 		arvif->is_started = true;
-		return ret;
+		goto out;
 	}
 
 	ret = ath12k_mac_vdev_start(arvif, ctx);
@@ -7645,16 +7828,17 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
 			    ctx->def.chan->center_freq, ret);
-		return ret;
+		goto out;
 	}
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
+	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
 		ath12k_mac_monitor_start(ar);
 
 	arvif->is_started = true;
 
 	/* TODO: Setup ps and cts/rts protection */
 
+out:
 	return ret;
 }
 
@@ -7666,11 +7850,14 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 	struct ath12k_base *ab;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	/* The vif is expected to be attached to an ar's VDEV.
 	 * We leave the vif/vdev in this function as is
 	 * and not delete the vdev symmetric to assign_vif_chanctx()
@@ -7690,7 +7877,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	WARN_ON(!arvif->is_started);
 
-	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_mac_monitor_stop(ar);
 		if (ret)
 			return;
@@ -7698,8 +7885,8 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		arvif->is_started = false;
 	}
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_STA &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
+	if (ahvif->vdev_type != WMI_VDEV_TYPE_STA &&
+	    ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
 		ath12k_bss_disassoc(ar, arvif);
 		ret = ath12k_mac_vdev_stop(arvif);
 		if (ret)
@@ -7708,7 +7895,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 	arvif->is_started = false;
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
+	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
 }
@@ -7742,7 +7929,7 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 static int
 ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret = 0;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -7985,7 +8172,7 @@ ath12k_mac_get_single_legacy_rate(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_mac_set_fixed_rate_params(struct ath12k_vif *arvif,
+static int ath12k_mac_set_fixed_rate_params(struct ath12k_link_vif *arvif,
 					    u32 rate, u8 nss, u8 sgi, u8 ldpc)
 {
 	struct ath12k *ar = arvif->ar;
@@ -8064,7 +8251,7 @@ ath12k_mac_vht_mcs_range_present(struct ath12k *ar,
 static void ath12k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
-	struct ath12k_vif *arvif = data;
+	struct ath12k_link_vif *arvif = data;
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k *ar = arvif->ar;
 
@@ -8081,8 +8268,8 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
 					       struct ieee80211_sta *sta)
 {
+	struct ath12k_link_vif *arvif = data;
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
-	struct ath12k_vif *arvif = data;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -8104,9 +8291,10 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       const struct cfg80211_bitrate_mask *mask)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
 	struct cfg80211_chan_def def;
-	struct ath12k *ar = arvif->ar;
+	struct ath12k *ar;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
@@ -8120,8 +8308,13 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	if (ath12k_mac_vif_chan(vif, &def))
-		return -EPERM;
+	arvif = &ahvif->deflink;
+
+	ar = arvif->ar;
+	if (ath12k_mac_vif_chan(vif, &def)) {
+		ret = -EPERM;
+		goto out;
+	}
 
 	band = def.chan->band;
 	ht_mcs_mask = mask->control[band].ht_mcs;
@@ -8129,8 +8322,10 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
-	if (sgi == NL80211_TXRATE_FORCE_LGI)
-		return -EINVAL;
+	if (sgi == NL80211_TXRATE_FORCE_LGI) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing at least one of used basic rates along with them.
@@ -8146,7 +8341,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to get single legacy rate for vdev %i: %d\n",
 				    arvif->vdev_id, ret);
-			return ret;
+			goto out;
 		}
 		ieee80211_iterate_stations_mtx(hw,
 					       ath12k_mac_disable_peer_fixed_rate,
@@ -8210,6 +8405,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 	}
 
+out:
 	return ret;
 }
 
@@ -8220,7 +8416,8 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
-	struct ath12k_vif *arvif;
+	struct ath12k_vif *ahvif;
+	struct ath12k_link_vif *arvif;
 	int recovery_count, i;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -8261,11 +8458,12 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		}
 
 		list_for_each_entry(arvif, &ar->arvifs, list) {
+			ahvif = arvif->ahvif;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "reconfig cipher %d up %d vdev type %d\n",
-				   arvif->key_cipher,
+				   ahvif->key_cipher,
 				   arvif->is_up,
-				   arvif->vdev_type);
+				   ahvif->vdev_type);
 
 			/* After trigger disconnect, then upper layer will
 			 * trigger connect again, then the PN number of
@@ -8273,9 +8471,9 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			 * side, hence PN number mismatch will not happen.
 			 */
 			if (arvif->is_up &&
-			    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
-			    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE) {
-				ieee80211_hw_restart_disconnect(arvif->vif);
+			    ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+			    ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE) {
+				ieee80211_hw_restart_disconnect(ahvif->vif);
 
 				ath12k_dbg(ab, ATH12K_DBG_BOOT,
 					   "restart disconnect\n");
@@ -8435,9 +8633,10 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 					   int duration,
 					   enum ieee80211_roc_type type)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_wmi_scan_req_arg arg;
+	struct ath12k_link_vif *arvif;
 	struct ath12k *ar, *prev_ar;
 	u32 scan_time_msec;
 	bool create = true;
@@ -8445,6 +8644,8 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+
 	if (ah->num_radio == 1) {
 		WARN_ON(!arvif->is_created);
 		ar = ath12k_ah_to_ar(ah, 0);
@@ -8452,8 +8653,10 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	}
 
 	ar = ath12k_mac_select_scan_device(hw, vif, chan->center_freq);
-	if (!ar)
-		return -EINVAL;
+	if (!ar) {
+		ret = -EINVAL;
+		goto exit;
+	}
 
 	/* If the vif is already assigned to a specific vdev of an ar,
 	 * check whether its already started, vdev which is started
@@ -8465,11 +8668,15 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	 * always on the same band for the vif
 	 */
 	if (arvif->is_created) {
-		if (WARN_ON(!arvif->ar))
-			return -EINVAL;
+		if (WARN_ON(!arvif->ar)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 
-		if (ar != arvif->ar && arvif->is_started)
-			return -EBUSY;
+		if (ar != arvif->ar && arvif->is_started) {
+			ret = -EBUSY;
+			goto exit;
+		}
 
 		if (ar != arvif->ar) {
 			/* backup the previously used ar ptr, since the vdev delete
@@ -8481,7 +8688,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 				ath12k_warn(prev_ar->ab,
 					    "unable to delete scan vdev for roc: %d\n",
 					    ret);
-				return ret;
+				goto exit;
 			}
 		} else {
 			create = false;
@@ -8493,7 +8700,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev for roc: %d\n",
 				    ret);
-			return -EINVAL;
+			goto exit;
 		}
 	}
 
@@ -8522,7 +8729,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	if (ret)
-		return ret;
+		goto exit;
 
 	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
 
@@ -8531,8 +8738,10 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	arg.num_chan = 1;
 	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
 				GFP_KERNEL);
-	if (!arg.chan_list)
-		return -ENOMEM;
+	if (!arg.chan_list) {
+		ret = -ENOMEM;
+		goto exit;
+	}
 
 	arg.vdev_id = arvif->vdev_id;
 	arg.scan_id = ATH12K_SCAN_ID;
@@ -8571,6 +8780,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 free_chan_list:
 	kfree(arg.chan_list);
 
+exit:
 	return ret;
 }
 
@@ -8578,13 +8788,17 @@ static void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct cfg80211_gtk_rekey_data *data)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_rekey_data *rekey_data = &arvif->rekey_data;
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_rekey_data *rekey_data;
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	struct ath12k_link_vif *arvif;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	arvif = &ahvif->deflink;
+	rekey_data = &arvif->rekey_data;
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac set rekey data vdev %d\n",
 		   arvif->vdev_id);
 
@@ -9444,7 +9658,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 	return ret;
 }
 
-int ath12k_mac_vif_set_keepalive(struct ath12k_vif *arvif,
+int ath12k_mac_vif_set_keepalive(struct ath12k_link_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval)
 {
@@ -9454,7 +9668,7 @@ int ath12k_mac_vif_set_keepalive(struct ath12k_vif *arvif,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+	if (arvif->ahvif->vdev_type != WMI_VDEV_TYPE_STA)
 		return 0;
 
 	if (!test_bit(WMI_TLV_SERVICE_STA_KEEP_ALIVE, ar->ab->wmi_ab.svc_map))
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 5efbb6822628..d382337ba649 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -41,6 +41,9 @@ struct ath12k_generic_iter {
 #define ATH12K_TX_POWER_MAX_VAL	70
 #define ATH12K_TX_POWER_MIN_VAL	0
 
+#define ATH12K_DEFAULT_LINK_ID	0
+#define ATH12K_INVALID_LINK_ID	255
+
 enum ath12k_supported_bw {
 	ATH12K_BW_20    = 0,
 	ATH12K_BW_40    = 1,
@@ -65,9 +68,9 @@ u8 ath12k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
 void __ath12k_mac_scan_finish(struct ath12k *ar);
 void ath12k_mac_scan_finish(struct ath12k *ar);
 
-struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id);
-struct ath12k_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
-						   u32 vdev_id);
+struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id);
+struct ath12k_link_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
+							u32 vdev_id);
 struct ath12k *ath12k_mac_get_ar_by_vdev_id(struct ath12k_base *ab, u32 vdev_id);
 struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id);
 
@@ -82,7 +85,7 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
 int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
 void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
-int ath12k_mac_vif_set_keepalive(struct ath12k_vif *arvif,
+int ath12k_mac_vif_set_keepalive(struct ath12k_link_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
 u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index 3a851ee15b2f..84cccf7d91e7 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -69,20 +69,20 @@ static size_t ath12k_p2p_noa_ie_len_compute(const struct ath12k_wmi_p2p_noa_info
 	return len;
 }
 
-static void ath12k_p2p_noa_ie_assign(struct ath12k_vif *arvif, void *ie,
+static void ath12k_p2p_noa_ie_assign(struct ath12k_link_vif *arvif, void *ie,
 				     size_t len)
 {
 	struct ath12k *ar = arvif->ar;
 
 	lockdep_assert_held(&ar->data_lock);
 
-	kfree(arvif->u.ap.noa_data);
+	kfree(arvif->ahvif->u.ap.noa_data);
 
-	arvif->u.ap.noa_data = ie;
-	arvif->u.ap.noa_len = len;
+	arvif->ahvif->u.ap.noa_data = ie;
+	arvif->ahvif->u.ap.noa_len = len;
 }
 
-static void __ath12k_p2p_noa_update(struct ath12k_vif *arvif,
+static void __ath12k_p2p_noa_update(struct ath12k_link_vif *arvif,
 				    const struct ath12k_wmi_p2p_noa_info *noa)
 {
 	struct ath12k *ar = arvif->ar;
@@ -105,7 +105,7 @@ static void __ath12k_p2p_noa_update(struct ath12k_vif *arvif,
 	ath12k_p2p_noa_ie_assign(arvif, ie, len);
 }
 
-void ath12k_p2p_noa_update(struct ath12k_vif *arvif,
+void ath12k_p2p_noa_update(struct ath12k_link_vif *arvif,
 			   const struct ath12k_wmi_p2p_noa_info *noa)
 {
 	struct ath12k *ar = arvif->ar;
@@ -118,9 +118,12 @@ void ath12k_p2p_noa_update(struct ath12k_vif *arvif,
 static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
 					    struct ieee80211_vif *vif)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_p2p_noa_arg *arg = data;
+	struct ath12k_link_vif *arvif;
 
+	WARN_ON(!rcu_read_lock_any_held());
+	arvif = &ahvif->deflink;
 	if (arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
 		return;
 
diff --git a/drivers/net/wireless/ath/ath12k/p2p.h b/drivers/net/wireless/ath/ath12k/p2p.h
index b2eec51a9900..03ee877e6d6b 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.h
+++ b/drivers/net/wireless/ath/ath12k/p2p.h
@@ -16,7 +16,7 @@ struct ath12k_p2p_noa_arg {
 	const struct ath12k_wmi_p2p_noa_info *noa;
 };
 
-void ath12k_p2p_noa_update(struct ath12k_vif *arvif,
+void ath12k_p2p_noa_update(struct ath12k_link_vif *arvif,
 			   const struct ath12k_wmi_p2p_noa_info *noa);
 void ath12k_p2p_noa_update_by_vdev_id(struct ath12k *ar, u32 vdev_id,
 				      const struct ath12k_wmi_p2p_noa_info *noa);
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 404fb7ff7154..7a62665b8af9 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -261,10 +261,11 @@ static int ath12k_wait_for_peer_created(struct ath12k *ar, int vdev_id, const u8
 	return ath12k_wait_for_peer_common(ar->ab, vdev_id, addr, true);
 }
 
-int ath12k_peer_create(struct ath12k *ar, struct ath12k_vif *arvif,
+int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       struct ieee80211_sta *sta,
 		       struct ath12k_wmi_peer_create_arg *arg)
 {
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ath12k_peer *peer;
 	int ret;
 
@@ -326,7 +327,7 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_vif *arvif,
 	peer->pdev_idx = ar->pdev_idx;
 	peer->sta = sta;
 
-	if (arvif->vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION) {
 		arvif->ast_hash = peer->ast_hash;
 		arvif->ast_idx = peer->hw_peer_id;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 7b3500b5c8c2..b955f0cdf598 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_PEER_H
@@ -59,7 +59,7 @@ struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
 struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab, int peer_id);
 void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id);
 int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr);
-int ath12k_peer_create(struct ath12k *ar, struct ath12k_vif *arvif,
+int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       struct ieee80211_sta *sta,
 		       struct ath12k_wmi_peer_create_arg *arg);
 int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 190439ad7f23..dced2aa9ba1a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6687,7 +6687,8 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 					  const u32 *vdev_ids)
 {
 	int i;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_vif *ahvif;
 
 	/* Finish CSA once the switch count becomes NULL */
 	if (ev->current_switch_count)
@@ -6702,9 +6703,10 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 				    vdev_ids[i]);
 			continue;
 		}
+		ahvif = arvif->ahvif;
 
-		if (arvif->is_up && arvif->vif->bss_conf.csa_active)
-			ieee80211_csa_finish(arvif->vif, 0);
+		if (arvif->is_up && ahvif->vif->bss_conf.csa_active)
+			ieee80211_csa_finish(ahvif->vif, 0);
 	}
 	rcu_read_unlock();
 }
@@ -7098,7 +7100,7 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 						struct sk_buff *skb)
 {
 	const struct wmi_gtk_offload_status_event *ev;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	__be64 replay_ctr_be;
 	u64 replay_ctr;
 	const void **tb;
@@ -7136,7 +7138,7 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 	/* supplicant expects big-endian replay counter */
 	replay_ctr_be = cpu_to_be64(replay_ctr);
 
-	ieee80211_gtk_rekey_notify(arvif->vif, arvif->bssid,
+	ieee80211_gtk_rekey_notify(arvif->ahvif->vif, arvif->bssid,
 				   (void *)&replay_ctr_be, GFP_ATOMIC);
 
 	rcu_read_unlock();
@@ -7374,13 +7376,13 @@ ath12k_wmi_send_unit_test_cmd(struct ath12k *ar,
 
 int ath12k_wmi_simulate_radar(struct ath12k *ar)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	u32 dfs_args[DFS_MAX_TEST_ARGS];
 	struct wmi_unit_test_cmd wmi_ut;
 	bool arvif_found = false;
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (arvif->is_started && arvif->vdev_type == WMI_VDEV_TYPE_AP) {
+		if (arvif->is_started && arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
 			arvif_found = true;
 			break;
 		}
@@ -7942,7 +7944,7 @@ static void ath12k_wmi_fill_arp_offload(struct ath12k *ar,
 }
 
 int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
-			      struct ath12k_vif *arvif,
+			      struct ath12k_link_vif *arvif,
 			      struct wmi_arp_ns_offload_arg *offload,
 			      bool enable)
 {
@@ -7991,7 +7993,7 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
 }
 
 int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
-				 struct ath12k_vif *arvif, bool enable)
+				 struct ath12k_link_vif *arvif, bool enable)
 {
 	struct ath12k_rekey_data *rekey_data = &arvif->rekey_data;
 	struct wmi_gtk_rekey_offload_cmd *cmd;
@@ -8028,7 +8030,7 @@ int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
 }
 
 int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
-				 struct ath12k_vif *arvif)
+				 struct ath12k_link_vif *arvif)
 {
 	struct wmi_gtk_rekey_offload_cmd *cmd;
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6a913f9b8315..6f55dbdf629d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -24,7 +24,7 @@
 
 struct ath12k_base;
 struct ath12k;
-struct ath12k_vif;
+struct ath12k_link_vif;
 
 /* There is no signed version of __le32, so for a temporary solution come
  * up with our own version. The idea is from fs/ntfs/endian.h.
@@ -5627,13 +5627,13 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
 int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar,
 				  struct wmi_hw_data_filter_arg *arg);
 int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
-			      struct ath12k_vif *arvif,
+			      struct ath12k_link_vif *arvif,
 			      struct wmi_arp_ns_offload_arg *offload,
 			      bool enable);
 int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
-				 struct ath12k_vif *arvif, bool enable);
+				 struct ath12k_link_vif *arvif, bool enable);
 int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
-				 struct ath12k_vif *arvif);
+				 struct ath12k_link_vif *arvif);
 int ath12k_wmi_sta_keepalive(struct ath12k *ar,
 			     const struct wmi_sta_keepalive_arg *arg);
 
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index a6bb860a4eaa..9e1c0bfd212f 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -29,11 +29,11 @@ static const struct wiphy_wowlan_support ath12k_wowlan_support = {
 	.max_pkt_offset = WOW_MAX_PKT_OFFSET,
 };
 
-static inline bool ath12k_wow_is_p2p_vdev(struct ath12k_vif *arvif)
+static inline bool ath12k_wow_is_p2p_vdev(struct ath12k_vif *ahvif)
 {
-	return (arvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_DEVICE ||
-		arvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_CLIENT ||
-		arvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_GO);
+	return (ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_DEVICE ||
+		ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_CLIENT ||
+		ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_GO);
 }
 
 int ath12k_wow_enable(struct ath12k *ar)
@@ -101,7 +101,7 @@ int ath12k_wow_wakeup(struct ath12k *ar)
 	return 0;
 }
 
-static int ath12k_wow_vif_cleanup(struct ath12k_vif *arvif)
+static int ath12k_wow_vif_cleanup(struct ath12k_link_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
 	int i, ret;
@@ -129,7 +129,7 @@ static int ath12k_wow_vif_cleanup(struct ath12k_vif *arvif)
 
 static int ath12k_wow_cleanup(struct ath12k *ar)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -354,7 +354,7 @@ ath12k_wow_pno_check_and_convert(struct ath12k *ar, u32 vdev_id,
 	return 0;
 }
 
-static int ath12k_wow_vif_set_wakeups(struct ath12k_vif *arvif,
+static int ath12k_wow_vif_set_wakeups(struct ath12k_link_vif *arvif,
 				      struct cfg80211_wowlan *wowlan)
 {
 	const struct cfg80211_pkt_pattern *patterns = wowlan->patterns;
@@ -364,7 +364,7 @@ static int ath12k_wow_vif_set_wakeups(struct ath12k_vif *arvif,
 	int ret, i, j;
 
 	/* Setup requested WOW features */
-	switch (arvif->vdev_type) {
+	switch (arvif->ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_IBSS:
 		__set_bit(WOW_BEACON_EVENT, &wow_mask);
 		fallthrough;
@@ -473,13 +473,13 @@ static int ath12k_wow_vif_set_wakeups(struct ath12k_vif *arvif,
 static int ath12k_wow_set_wakeups(struct ath12k *ar,
 				  struct cfg80211_wowlan *wowlan)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (ath12k_wow_is_p2p_vdev(arvif))
+		if (ath12k_wow_is_p2p_vdev(arvif->ahvif))
 			continue;
 		ret = ath12k_wow_vif_set_wakeups(arvif, wowlan);
 		if (ret) {
@@ -518,11 +518,11 @@ static int ath12k_wow_vdev_clean_nlo(struct ath12k *ar, u32 vdev_id)
 	return ret;
 }
 
-static int ath12k_wow_vif_clean_nlo(struct ath12k_vif *arvif)
+static int ath12k_wow_vif_clean_nlo(struct ath12k_link_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
 
-	switch (arvif->vdev_type) {
+	switch (arvif->ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_STA:
 		return ath12k_wow_vdev_clean_nlo(ar, arvif->vdev_id);
 	default:
@@ -532,13 +532,13 @@ static int ath12k_wow_vif_clean_nlo(struct ath12k_vif *arvif)
 
 static int ath12k_wow_nlo_cleanup(struct ath12k *ar)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (ath12k_wow_is_p2p_vdev(arvif))
+		if (ath12k_wow_is_p2p_vdev(arvif->ahvif))
 			continue;
 
 		ret = ath12k_wow_vif_clean_nlo(arvif);
@@ -555,13 +555,13 @@ static int ath12k_wow_nlo_cleanup(struct ath12k *ar)
 static int ath12k_wow_set_hw_filter(struct ath12k *ar)
 {
 	struct wmi_hw_data_filter_arg arg;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+		if (arvif->ahvif->vdev_type != WMI_VDEV_TYPE_STA)
 			continue;
 
 		arg.vdev_id = arvif->vdev_id;
@@ -581,13 +581,13 @@ static int ath12k_wow_set_hw_filter(struct ath12k *ar)
 static int ath12k_wow_clear_hw_filter(struct ath12k *ar)
 {
 	struct wmi_hw_data_filter_arg arg;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+		if (arvif->ahvif->vdev_type != WMI_VDEV_TYPE_STA)
 			continue;
 
 		arg.vdev_id = arvif->vdev_id;
@@ -626,10 +626,10 @@ static void ath12k_wow_generate_ns_mc_addr(struct ath12k_base *ab,
 	}
 }
 
-static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif,
+static void ath12k_wow_prepare_ns_offload(struct ath12k_link_vif *arvif,
 					  struct wmi_arp_ns_offload_arg *offload)
 {
-	struct net_device *ndev = ieee80211_vif_to_wdev(arvif->vif)->netdev;
+	struct net_device *ndev = ieee80211_vif_to_wdev(arvif->ahvif->vif)->netdev;
 	struct ath12k_base *ab = arvif->ar->ab;
 	struct inet6_ifaddr *ifa6;
 	struct ifacaddr6 *ifaca6;
@@ -710,10 +710,10 @@ static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif,
 	ath12k_wow_generate_ns_mc_addr(ab, offload);
 }
 
-static void ath12k_wow_prepare_arp_offload(struct ath12k_vif *arvif,
+static void ath12k_wow_prepare_arp_offload(struct ath12k_link_vif *arvif,
 					   struct wmi_arp_ns_offload_arg *offload)
 {
-	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
 	struct ieee80211_vif_cfg vif_cfg = vif->cfg;
 	struct ath12k_base *ab = arvif->ar->ab;
 	u32 ipv4_cnt;
@@ -732,7 +732,8 @@ static void ath12k_wow_prepare_arp_offload(struct ath12k_vif *arvif,
 static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 {
 	struct wmi_arp_ns_offload_arg *offload;
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_vif *ahvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -742,12 +743,14 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 		return -ENOMEM;
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+		ahvif = arvif->ahvif;
+
+		if (ahvif->vdev_type != WMI_VDEV_TYPE_STA)
 			continue;
 
 		memset(offload, 0, sizeof(*offload));
 
-		memcpy(offload->mac_addr, arvif->vif->addr, ETH_ALEN);
+		memcpy(offload->mac_addr, ahvif->vif->addr, ETH_ALEN);
 		ath12k_wow_prepare_ns_offload(arvif, offload);
 		ath12k_wow_prepare_arp_offload(arvif, offload);
 
@@ -766,13 +769,13 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 
 static int ath12k_gtk_rekey_offload(struct ath12k *ar, bool enable)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (arvif->vdev_type != WMI_VDEV_TYPE_STA ||
+		if (arvif->ahvif->vdev_type != WMI_VDEV_TYPE_STA ||
 		    !arvif->is_up ||
 		    !arvif->rekey_data.enable_offload)
 			continue;
@@ -824,7 +827,7 @@ static int ath12k_wow_set_keepalive(struct ath12k *ar,
 				    enum wmi_sta_keepalive_method method,
 				    u32 interval)
 {
-	struct ath12k_vif *arvif;
+	struct ath12k_link_vif *arvif;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
-- 
2.39.5


