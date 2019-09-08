Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E1ACB9F
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfIHIjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:39:17 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:51394 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbfIHIjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:39:16 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 04:39:09 EDT
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 08 Sep 2019 10:33:04 +0200
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg03-ams.qualcomm.com with ESMTP; 08 Sep 2019 10:33:01 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 04/11] wil6210: fix PTK re-key race
Date:   Sun,  8 Sep 2019 11:32:48 +0300
Message-Id: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ahmad Masri <amasri@codeaurora.org>

Fix a race between cfg80211 add_key call and transmitting of 4/4 EAP
packet. In case the transmit is delayed until after the add key takes
place, message 4/4 will be encrypted with the new key, and the
receiver side (AP) will drop it due to MIC error.

Wil6210 will monitor and look for the transmitted packet 4/4 eap key.
In case add_key takes place before the transmission completed, then
wil6210 will let the FW store the key and wil6210 will notify the FW
to use the PTK key only after 4/4 eap packet transmission was
completed.

Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c  |  15 ++-
 drivers/net/wireless/ath/wil6210/main.c      |   4 +
 drivers/net/wireless/ath/wil6210/netdev.c    |   3 +
 drivers/net/wireless/ath/wil6210/txrx.c      | 184 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/txrx.h      |  40 ++++++
 drivers/net/wireless/ath/wil6210/txrx_edma.c |   4 +
 drivers/net/wireless/ath/wil6210/wil6210.h   |  15 +++
 drivers/net/wireless/ath/wil6210/wmi.c       |  11 +-
 drivers/net/wireless/ath/wil6210/wmi.h       |   3 +
 9 files changed, 276 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 1883690..c70854e 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -331,6 +331,8 @@ static int wil_rf_sector_set_selected(struct wiphy *wiphy,
 	[WMI_KEY_USE_PAIRWISE]	= "PTK",
 	[WMI_KEY_USE_RX_GROUP]	= "RX_GTK",
 	[WMI_KEY_USE_TX_GROUP]	= "TX_GTK",
+	[WMI_KEY_USE_STORE_PTK]	= "STORE_PTK",
+	[WMI_KEY_USE_APPLY_PTK]	= "APPLY_PTK",
 };
 
 int wil_iftype_nl2wmi(enum nl80211_iftype type)
@@ -542,7 +544,7 @@ static int wil_cfg80211_get_station(struct wiphy *wiphy,
 /*
  * Find @idx-th active STA for specific MID for station dump.
  */
-static int wil_find_cid_by_idx(struct wil6210_priv *wil, u8 mid, int idx)
+int wil_find_cid_by_idx(struct wil6210_priv *wil, u8 mid, int idx)
 {
 	int i;
 
@@ -1554,6 +1556,7 @@ void wil_set_crypto_rx(u8 key_index, enum wmi_key_usage key_usage,
 		return;
 
 	switch (key_usage) {
+	case WMI_KEY_USE_STORE_PTK:
 	case WMI_KEY_USE_PAIRWISE:
 		for (tid = 0; tid < WIL_STA_TID_NUM; tid++) {
 			cc = &cs->tid_crypto_rx[tid].key_id[key_index];
@@ -1651,6 +1654,16 @@ static int wil_cfg80211_add_key(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&wil->eap_lock);
+	if (pairwise && wdev->iftype == NL80211_IFTYPE_STATION &&
+	    (vif->ptk_rekey_state == WIL_REKEY_M3_RECEIVED ||
+	     vif->ptk_rekey_state == WIL_REKEY_WAIT_M4_SENT)) {
+		key_usage = WMI_KEY_USE_STORE_PTK;
+		vif->ptk_rekey_state = WIL_REKEY_WAIT_M4_SENT;
+		wil_dbg_misc(wil, "Store EAPOL key\n");
+	}
+	spin_unlock_bh(&wil->eap_lock);
+
 	rc = wmi_add_cipher_key(vif, key_index, mac_addr, params->key_len,
 				params->key, key_usage);
 	if (!rc && !IS_ERR(cs)) {
diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 0f270b8..2c3a192 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -373,6 +373,7 @@ static void _wil6210_disconnect_complete(struct wil6210_vif *vif,
 		}
 		clear_bit(wil_vif_fwconnecting, vif->status);
 		clear_bit(wil_vif_ft_roam, vif->status);
+		vif->ptk_rekey_state = WIL_REKEY_IDLE;
 
 		break;
 	case NL80211_IFTYPE_AP:
@@ -736,6 +737,8 @@ int wil_priv_init(struct wil6210_priv *wil)
 	INIT_LIST_HEAD(&wil->pending_wmi_ev);
 	spin_lock_init(&wil->wmi_ev_lock);
 	spin_lock_init(&wil->net_queue_lock);
+	spin_lock_init(&wil->eap_lock);
+
 	init_waitqueue_head(&wil->wq);
 	init_rwsem(&wil->mem_lock);
 
@@ -1667,6 +1670,7 @@ int wil_reset(struct wil6210_priv *wil, bool load_fw)
 			cancel_work_sync(&vif->disconnect_worker);
 			wil6210_disconnect(vif, NULL,
 					   WLAN_REASON_DEAUTH_LEAVING);
+			vif->ptk_rekey_state = WIL_REKEY_IDLE;
 		}
 	}
 	wil_bcast_fini_all(wil);
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index 59f041d..a2eca54 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -218,6 +218,7 @@ static void wil_vif_deinit(struct wil6210_vif *vif)
 	cancel_work_sync(&vif->p2p.delayed_listen_work);
 	wil_probe_client_flush(vif);
 	cancel_work_sync(&vif->probe_client_worker);
+	cancel_work_sync(&vif->enable_tx_key_worker);
 }
 
 void wil_vif_free(struct wil6210_vif *vif)
@@ -284,6 +285,7 @@ static void wil_vif_init(struct wil6210_vif *vif)
 	INIT_WORK(&vif->probe_client_worker, wil_probe_client_worker);
 	INIT_WORK(&vif->disconnect_worker, wil_disconnect_worker);
 	INIT_WORK(&vif->p2p.delayed_listen_work, wil_p2p_delayed_listen_work);
+	INIT_WORK(&vif->enable_tx_key_worker, wil_enable_tx_key_worker);
 
 	INIT_LIST_HEAD(&vif->probe_client_pending);
 
@@ -540,6 +542,7 @@ void wil_vif_remove(struct wil6210_priv *wil, u8 mid)
 	cancel_work_sync(&vif->disconnect_worker);
 	wil_probe_client_flush(vif);
 	cancel_work_sync(&vif->probe_client_worker);
+	cancel_work_sync(&vif->enable_tx_key_worker);
 	/* for VIFs, ndev will be freed by destructor after RTNL is unlocked.
 	 * the main interface will be freed in wil_if_free, we need to keep it
 	 * a bit longer so logging macros will work.
diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index b6253fc..cb13652 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -725,6 +725,182 @@ static void wil_get_netif_rx_params(struct sk_buff *skb, int *cid,
 }
 
 /*
+ * Check if skb is ptk eapol key message
+ *
+ * returns a pointer to the start of the eapol key structure, NULL
+ * if frame is not PTK eapol key
+ */
+static struct wil_eapol_key *wil_is_ptk_eapol_key(struct wil6210_priv *wil,
+						  struct sk_buff *skb)
+{
+	u8 *buf;
+	const struct wil_1x_hdr *hdr;
+	struct wil_eapol_key *key;
+	u16 key_info;
+	int len = skb->len;
+
+	if (!skb_mac_header_was_set(skb)) {
+		wil_err(wil, "mac header was not set\n");
+		return NULL;
+	}
+
+	len -= skb_mac_offset(skb);
+
+	if (len < sizeof(struct ethhdr) + sizeof(struct wil_1x_hdr) +
+	    sizeof(struct wil_eapol_key))
+		return NULL;
+
+	buf = skb_mac_header(skb) + sizeof(struct ethhdr);
+
+	hdr = (const struct wil_1x_hdr *)buf;
+	if (hdr->type != WIL_1X_TYPE_EAPOL_KEY)
+		return NULL;
+
+	key = (struct wil_eapol_key *)(buf + sizeof(struct wil_1x_hdr));
+	if (key->type != WIL_EAPOL_KEY_TYPE_WPA &&
+	    key->type != WIL_EAPOL_KEY_TYPE_RSN)
+		return NULL;
+
+	key_info = be16_to_cpu(key->key_info);
+	if (!(key_info & WIL_KEY_INFO_KEY_TYPE)) /* check if pairwise */
+		return NULL;
+
+	return key;
+}
+
+static bool wil_skb_is_eap_3(struct wil6210_priv *wil, struct sk_buff *skb)
+{
+	struct wil_eapol_key *key;
+	u16 key_info;
+
+	key = wil_is_ptk_eapol_key(wil, skb);
+	if (!key)
+		return false;
+
+	key_info = be16_to_cpu(key->key_info);
+	if (key_info & (WIL_KEY_INFO_MIC |
+			WIL_KEY_INFO_ENCR_KEY_DATA)) {
+		/* 3/4 of 4-Way Handshake */
+		wil_dbg_misc(wil, "EAPOL key message 3\n");
+		return true;
+	}
+	/* 1/4 of 4-Way Handshake */
+	wil_dbg_misc(wil, "EAPOL key message 1\n");
+
+	return false;
+}
+
+static bool wil_skb_is_eap_4(struct wil6210_priv *wil, struct sk_buff *skb)
+{
+	struct wil_eapol_key *key;
+	u32 *nonce, i;
+
+	key = wil_is_ptk_eapol_key(wil, skb);
+	if (!key)
+		return false;
+
+	nonce = (u32 *)key->key_nonce;
+	for (i = 0; i < WIL_EAP_NONCE_LEN / sizeof(u32); i++, nonce++) {
+		if (*nonce != 0) {
+			/* message 2/4 */
+			wil_dbg_misc(wil, "EAPOL key message 2\n");
+			return false;
+		}
+	}
+	wil_dbg_misc(wil, "EAPOL key message 4\n");
+
+	return true;
+}
+
+void wil_enable_tx_key_worker(struct work_struct *work)
+{
+	struct wil6210_vif *vif = container_of(work,
+			struct wil6210_vif, enable_tx_key_worker);
+	struct wil6210_priv *wil = vif_to_wil(vif);
+	int rc, cid;
+
+	rtnl_lock();
+	if (vif->ptk_rekey_state != WIL_REKEY_WAIT_M4_SENT) {
+		wil_dbg_misc(wil, "Invalid rekey state = %d\n",
+			     vif->ptk_rekey_state);
+		rtnl_unlock();
+		return;
+	}
+
+	cid =  wil_find_cid_by_idx(wil, vif->mid, 0);
+	if (!wil_cid_valid(wil, cid)) {
+		wil_err(wil, "Invalid cid = %d\n", cid);
+		rtnl_unlock();
+		return;
+	}
+
+	wil_dbg_misc(wil, "Apply PTK key after eapol was sent out\n");
+	rc = wmi_add_cipher_key(vif, 0, wil->sta[cid].addr, 0, NULL,
+				WMI_KEY_USE_APPLY_PTK);
+
+	vif->ptk_rekey_state = WIL_REKEY_IDLE;
+	rtnl_unlock();
+
+	if (rc)
+		wil_err(wil, "Apply PTK key failed %d\n", rc);
+}
+
+void wil_tx_complete_handle_eapol(struct wil6210_vif *vif, struct sk_buff *skb)
+{
+	struct wil6210_priv *wil = vif_to_wil(vif);
+	struct wireless_dev *wdev = vif_to_wdev(vif);
+	bool q = false;
+
+	if (wdev->iftype != NL80211_IFTYPE_STATION ||
+	    !test_bit(WMI_FW_CAPABILITY_SPLIT_REKEY, wil->fw_capabilities))
+		return;
+
+	/* check if skb is an EAP message 4/4 */
+	if (!wil_skb_is_eap_4(wil, skb))
+		return;
+
+	spin_lock_bh(&wil->eap_lock);
+	switch (vif->ptk_rekey_state) {
+	case WIL_REKEY_IDLE:
+		/* ignore idle state, can happen due to M4 retransmission */
+		break;
+	case WIL_REKEY_M3_RECEIVED:
+		vif->ptk_rekey_state = WIL_REKEY_IDLE;
+		break;
+	case WIL_REKEY_WAIT_M4_SENT:
+		q = true;
+		break;
+	default:
+		wil_err(wil, "Unknown rekey state = %d",
+			vif->ptk_rekey_state);
+	}
+	spin_unlock_bh(&wil->eap_lock);
+
+	if (q) {
+		q = queue_work(wil->wmi_wq, &vif->enable_tx_key_worker);
+		wil_dbg_misc(wil, "queue_work of enable_tx_key_worker -> %d\n",
+			     q);
+	}
+}
+
+static void wil_rx_handle_eapol(struct wil6210_vif *vif, struct sk_buff *skb)
+{
+	struct wil6210_priv *wil = vif_to_wil(vif);
+	struct wireless_dev *wdev = vif_to_wdev(vif);
+
+	if (wdev->iftype != NL80211_IFTYPE_STATION ||
+	    !test_bit(WMI_FW_CAPABILITY_SPLIT_REKEY, wil->fw_capabilities))
+		return;
+
+	/* check if skb is a EAP message 3/4 */
+	if (!wil_skb_is_eap_3(wil, skb))
+		return;
+
+	if (vif->ptk_rekey_state == WIL_REKEY_IDLE)
+		vif->ptk_rekey_state = WIL_REKEY_M3_RECEIVED;
+}
+
+/*
  * Pass Rx packet to the netif. Update statistics.
  * Called in softirq context (NAPI poll).
  */
@@ -796,6 +972,10 @@ void wil_netif_rx(struct sk_buff *skb, struct net_device *ndev, int cid,
 	if (skb) { /* deliver to local stack */
 		skb->protocol = eth_type_trans(skb, ndev);
 		skb->dev = ndev;
+
+		if (skb->protocol == cpu_to_be16(ETH_P_PAE))
+			wil_rx_handle_eapol(vif, skb);
+
 		if (gro)
 			rc = napi_gro_receive(&wil->napi_rx, skb);
 		else
@@ -2332,6 +2512,10 @@ int wil_tx_complete(struct wil6210_vif *vif, int ringid)
 					if (stats)
 						stats->tx_errors++;
 				}
+
+				if (skb->protocol == cpu_to_be16(ETH_P_PAE))
+					wil_tx_complete_handle_eapol(vif, skb);
+
 				wil_consume_skb(skb, d->dma.error == 0);
 			}
 			memset(ctx, 0, sizeof(*ctx));
diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireless/ath/wil6210/txrx.h
index fceb251..5120475b 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -423,6 +423,46 @@ struct vring_rx_mac {
 #define RX_DMA_STATUS_PHY_INFO	BIT(6)
 #define RX_DMA_STATUS_FFM	BIT(7) /* EtherType Flex Filter Match */
 
+/* IEEE 802.11, 8.5.2 EAPOL-Key frames */
+#define WIL_KEY_INFO_KEY_TYPE BIT(3) /* val of 1 = Pairwise, 0 = Group key */
+
+#define WIL_KEY_INFO_MIC BIT(8)
+#define WIL_KEY_INFO_ENCR_KEY_DATA BIT(12) /* for rsn only */
+
+#define WIL_EAP_NONCE_LEN 32
+#define WIL_EAP_KEY_RSC_LEN 8
+#define WIL_EAP_REPLAY_COUNTER_LEN 8
+#define WIL_EAP_KEY_IV_LEN 16
+#define WIL_EAP_KEY_ID_LEN 8
+
+enum {
+	WIL_1X_TYPE_EAP_PACKET = 0,
+	WIL_1X_TYPE_EAPOL_START = 1,
+	WIL_1X_TYPE_EAPOL_LOGOFF = 2,
+	WIL_1X_TYPE_EAPOL_KEY = 3,
+};
+
+#define WIL_EAPOL_KEY_TYPE_RSN 2
+#define WIL_EAPOL_KEY_TYPE_WPA 254
+
+struct wil_1x_hdr {
+	u8 version;
+	u8 type;
+	__be16 length;
+	/* followed by data */
+} __packed;
+
+struct wil_eapol_key {
+	u8 type;
+	__be16 key_info;
+	__be16 key_length;
+	u8 replay_counter[WIL_EAP_REPLAY_COUNTER_LEN];
+	u8 key_nonce[WIL_EAP_NONCE_LEN];
+	u8 key_iv[WIL_EAP_KEY_IV_LEN];
+	u8 key_rsc[WIL_EAP_KEY_RSC_LEN];
+	u8 key_id[WIL_EAP_KEY_ID_LEN];
+} __packed;
+
 struct vring_rx_dma {
 	u32 d0;
 	struct wil_ring_dma_addr addr;
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 29a9a24..f313041 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -1257,6 +1257,10 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 					if (stats)
 						stats->tx_errors++;
 				}
+
+				if (skb->protocol == cpu_to_be16(ETH_P_PAE))
+					wil_tx_complete_handle_eapol(vif, skb);
+
 				wil_consume_skb(skb, msg.status == 0);
 			}
 			memset(ctx, 0, sizeof(*ctx));
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 6463310..dd0c87a 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -732,6 +732,12 @@ enum wil_sta_status {
 	wil_sta_connected = 2,
 };
 
+enum wil_rekey_state {
+	WIL_REKEY_IDLE = 0,
+	WIL_REKEY_M3_RECEIVED = 1,
+	WIL_REKEY_WAIT_M4_SENT = 2,
+};
+
 /**
  * struct wil_sta_info - data for peer
  *
@@ -880,6 +886,10 @@ struct wil6210_vif {
 	int net_queue_stopped; /* netif_tx_stop_all_queues invoked */
 	bool fw_stats_ready; /* per-cid statistics are ready inside sta_info */
 	u64 fw_stats_tsf; /* measurement timestamp */
+
+	/* PTK rekey race prevention, this is relevant to station mode only */
+	enum wil_rekey_state ptk_rekey_state;
+	struct work_struct enable_tx_key_worker;
 };
 
 /**
@@ -980,6 +990,7 @@ struct wil6210_priv {
 	 */
 	spinlock_t wmi_ev_lock;
 	spinlock_t net_queue_lock; /* guarding stop/wake netif queue */
+	spinlock_t eap_lock; /* guarding access to eap rekey fields */
 	struct napi_struct napi_rx;
 	struct napi_struct napi_tx;
 	struct net_device napi_ndev; /* dummy net_device serving all VIFs */
@@ -1229,6 +1240,7 @@ int wil_ps_update(struct wil6210_priv *wil,
 void wil_refresh_fw_capabilities(struct wil6210_priv *wil);
 void wil_mbox_ring_le2cpus(struct wil6210_mbox_ring *r);
 int wil_find_cid(struct wil6210_priv *wil, u8 mid, const u8 *mac);
+int wil_find_cid_by_idx(struct wil6210_priv *wil, u8 mid, int idx);
 void wil_set_ethtoolops(struct net_device *ndev);
 
 struct fw_map *wil_find_fw_mapping(const char *section);
@@ -1354,6 +1366,7 @@ void wil6210_disconnect_complete(struct wil6210_vif *vif, const u8 *bssid,
 void wil_probe_client_flush(struct wil6210_vif *vif);
 void wil_probe_client_worker(struct work_struct *work);
 void wil_disconnect_worker(struct work_struct *work);
+void wil_enable_tx_key_worker(struct work_struct *work);
 
 void wil_init_txrx_ops(struct wil6210_priv *wil);
 
@@ -1373,6 +1386,8 @@ void wil_update_net_queues_bh(struct wil6210_priv *wil, struct wil6210_vif *vif,
 			      struct wil_ring *ring, bool check_stop);
 netdev_tx_t wil_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 int wil_tx_complete(struct wil6210_vif *vif, int ringid);
+void wil_tx_complete_handle_eapol(struct wil6210_vif *vif,
+				  struct sk_buff *skb);
 void wil6210_unmask_irq_tx(struct wil6210_priv *wil);
 void wil6210_unmask_irq_tx_edma(struct wil6210_priv *wil);
 
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 5760d14..73fe9bf 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -2438,10 +2438,17 @@ int wmi_add_cipher_key(struct wil6210_vif *vif, u8 key_index,
 		.key_len = key_len,
 	};
 
-	if (!key || (key_len > sizeof(cmd.key)))
+	if (key_len > sizeof(cmd.key))
 		return -EINVAL;
 
-	memcpy(cmd.key, key, key_len);
+	/* key len = 0 is allowed only for usage of WMI_KEY_USE_APPLY */
+	if ((key_len == 0 || !key) &&
+	    key_usage != WMI_KEY_USE_APPLY_PTK)
+		return -EINVAL;
+
+	if (key)
+		memcpy(cmd.key, key, key_len);
+
 	if (mac_addr)
 		memcpy(cmd.mac, mac_addr, WMI_MAC_LEN);
 
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index d75022b..a2f7034 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -109,6 +109,7 @@ enum wmi_fw_capability {
 	WMI_FW_CAPABILITY_CHANNEL_4			= 26,
 	WMI_FW_CAPABILITY_IPA				= 27,
 	WMI_FW_CAPABILITY_TEMPERATURE_ALL_RF		= 30,
+	WMI_FW_CAPABILITY_SPLIT_REKEY			= 31,
 	WMI_FW_CAPABILITY_MAX,
 };
 
@@ -421,6 +422,8 @@ enum wmi_key_usage {
 	WMI_KEY_USE_PAIRWISE	= 0x00,
 	WMI_KEY_USE_RX_GROUP	= 0x01,
 	WMI_KEY_USE_TX_GROUP	= 0x02,
+	WMI_KEY_USE_STORE_PTK	= 0x03,
+	WMI_KEY_USE_APPLY_PTK	= 0x04,
 };
 
 struct wmi_add_cipher_key_cmd {
-- 
1.9.1

