Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67478755EAF
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjGQIoP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQIoO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 04:44:14 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCA1A5
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 01:44:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:128d:0:640:d574:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id BD45B6005C;
        Mon, 17 Jul 2023 11:44:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7iabn8dDXW20-4xiu79ED;
        Mon, 17 Jul 2023 11:44:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689583448;
        bh=iLZT15uhzqY83WC82QEf5qbFz+O1K8/wGzQBmfl/0Ek=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=HXhymOfgAFGYXWbZHgF2LnPESgQHWhTlaVOvjvQ/4jDPFYrgpUNIP3NJGfiu/ug/g
         Kv02xQ3LJLyTgE+xoLorgA0s5vQiNjlXdB8OpQ9FXbfumFsF7U+kkpJPxlcrnkdFpk
         9Qc+jDEhp/GxMT+07PgrmkDGS2adf5n8ZFFDkLi0=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ajay.Kathat@microchip.com
Cc:     Amisha.Patel@microchip.com, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: wilc1000: simplify and cleanup TX paths
Date:   Mon, 17 Jul 2023 11:43:49 +0300
Message-ID: <20230717084400.57882-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cd0d3efb-95fb-61b5-1f82-fc996048b391@microchip.com>
References: <cd0d3efb-95fb-61b5-1f82-fc996048b391@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Redesign 'struct txq_entry_t' to avoid callback functions and
replace 'wilc_wfi_mgmt_tx_complete()/mgmt_tx_complete()' with
'wilc_tx_complete()' which operates on 'struct txq_entry_t'
directly. Drop callback-specific 'struct wilc_p2p_mgmt_data',
'struct tx_complete_mon_data' and 'struct tx_complete_data'
with related 'kmalloc()/kfree()' calls, adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: drop unused function arguments and use convenient error codes
    (Ajay Kathat)
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 37 ++-------
 drivers/net/wireless/microchip/wilc1000/mon.c | 47 +++--------
 .../net/wireless/microchip/wilc1000/netdev.c  | 34 ++++----
 .../net/wireless/microchip/wilc1000/netdev.h  |  1 +
 .../net/wireless/microchip/wilc1000/wlan.c    | 80 +++++--------------
 .../net/wireless/microchip/wilc1000/wlan.h    | 25 ++----
 6 files changed, 66 insertions(+), 158 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index b545d93c6e37..7d244c6c1a92 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -54,11 +54,6 @@ static const struct wiphy_wowlan_support wowlan_support = {
 };
 #endif
 
-struct wilc_p2p_mgmt_data {
-	int size;
-	u8 *buff;
-};
-
 struct wilc_p2p_pub_act_frame {
 	u8 category;
 	u8 action;
@@ -1086,14 +1081,6 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
 	cfg80211_rx_mgmt(&priv->wdev, freq, 0, buff, size, 0);
 }
 
-static void wilc_wfi_mgmt_tx_complete(void *priv, int status)
-{
-	struct wilc_p2p_mgmt_data *pv_data = priv;
-
-	kfree(pv_data->buff);
-	kfree(pv_data);
-}
-
 static void wilc_wfi_remain_on_channel_expired(void *data, u64 cookie)
 {
 	struct wilc_vif *vif = data;
@@ -1172,7 +1159,6 @@ static int mgmt_tx(struct wiphy *wiphy,
 	const u8 *buf = params->buf;
 	size_t len = params->len;
 	const struct ieee80211_mgmt *mgmt;
-	struct wilc_p2p_mgmt_data *mgmt_tx;
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 	struct host_if_drv *wfi_drv = priv->hif_drv;
@@ -1181,6 +1167,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 	int ie_offset = offsetof(struct ieee80211_mgmt, u) + sizeof(*d);
 	const u8 *vendor_ie;
 	int ret = 0;
+	u8 *copy;
 
 	*cookie = get_random_u32();
 	priv->tx_cookie = *cookie;
@@ -1189,21 +1176,12 @@ static int mgmt_tx(struct wiphy *wiphy,
 	if (!ieee80211_is_mgmt(mgmt->frame_control))
 		goto out;
 
-	mgmt_tx = kmalloc(sizeof(*mgmt_tx), GFP_KERNEL);
-	if (!mgmt_tx) {
+	copy = kmemdup(buf, len, GFP_KERNEL);
+	if (!copy) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	mgmt_tx->buff = kmemdup(buf, len, GFP_KERNEL);
-	if (!mgmt_tx->buff) {
-		ret = -ENOMEM;
-		kfree(mgmt_tx);
-		goto out;
-	}
-
-	mgmt_tx->size = len;
-
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		wilc_set_mac_chnl_num(vif, chan->hw_value);
 		vif->wilc->op_ch = chan->hw_value;
@@ -1230,8 +1208,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 		goto out_set_timeout;
 
 	vendor_ie = cfg80211_find_vendor_ie(WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P,
-					    mgmt_tx->buff + ie_offset,
-					    len - ie_offset);
+					    copy + ie_offset, len - ie_offset);
 	if (!vendor_ie)
 		goto out_set_timeout;
 
@@ -1243,10 +1220,8 @@ static int mgmt_tx(struct wiphy *wiphy,
 
 out_txq_add_pkt:
 
-	wilc_wlan_txq_add_mgmt_pkt(wdev->netdev, mgmt_tx,
-				   mgmt_tx->buff, mgmt_tx->size,
-				   wilc_wfi_mgmt_tx_complete);
-
+	if (wilc_wlan_txq_add_mgmt_pkt(wdev->netdev, copy, len) < 0)
+		kfree(copy);
 out:
 
 	return ret;
diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wireless/microchip/wilc1000/mon.c
index 03b7229a0ff5..28c642af943d 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -95,48 +95,25 @@ void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size)
 	netif_rx(skb);
 }
 
-struct tx_complete_mon_data {
-	int size;
-	void *buff;
-};
-
-static void mgmt_tx_complete(void *priv, int status)
-{
-	struct tx_complete_mon_data *pv_data = priv;
-	/*
-	 * in case of fully hosting mode, the freeing will be done
-	 * in response to the cfg packet
-	 */
-	kfree(pv_data->buff);
-
-	kfree(pv_data);
-}
-
-static int mon_mgmt_tx(struct net_device *dev, const u8 *buf, size_t len)
+static int mon_mgmt_tx(struct net_device *dev, const u8 *buf, u32 len)
 {
-	struct tx_complete_mon_data *mgmt_tx = NULL;
+	u8 *copy;
+	int ret = -EFAULT;
 
 	if (!dev)
-		return -EFAULT;
+		return ret;
 
 	netif_stop_queue(dev);
-	mgmt_tx = kmalloc(sizeof(*mgmt_tx), GFP_ATOMIC);
-	if (!mgmt_tx)
-		return -ENOMEM;
-
-	mgmt_tx->buff = kmemdup(buf, len, GFP_ATOMIC);
-	if (!mgmt_tx->buff) {
-		kfree(mgmt_tx);
-		return -ENOMEM;
+	copy = kmemdup(buf, len, GFP_ATOMIC);
+	if (!copy) {
+		ret = -ENOMEM;
+	} else {
+		if (wilc_wlan_txq_add_mgmt_pkt(dev, copy, len) < 0)
+			kfree(copy);
+		ret = 0;
 	}
-
-	mgmt_tx->size = len;
-
-	wilc_wlan_txq_add_mgmt_pkt(dev, mgmt_tx, mgmt_tx->buff, mgmt_tx->size,
-				   mgmt_tx_complete);
-
 	netif_wake_queue(dev);
-	return 0;
+	return ret;
 }
 
 static netdev_tx_t wilc_wfi_mon_xmit(struct sk_buff *skb,
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..82143d4d16e1 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -713,19 +713,28 @@ static void wilc_set_multicast_list(struct net_device *dev)
 		kfree(mc_list);
 }
 
-static void wilc_tx_complete(void *priv, int status)
+void wilc_tx_complete(struct txq_entry_t *tqe)
 {
-	struct tx_complete_data *pv_data = priv;
-
-	dev_kfree_skb(pv_data->skb);
-	kfree(pv_data);
+	switch (tqe->type) {
+	case WILC_NET_PKT:
+		dev_kfree_skb(tqe->skb);
+		break;
+	case WILC_MGMT_PKT:
+		kfree(tqe->buffer);
+		break;
+	case WILC_CFG_PKT:
+		/* nothing */
+		break;
+	default:
+		netdev_err(tqe->vif->ndev, "bad packet type %d\n", tqe->type);
+		break;
+	}
 }
 
 netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct wilc_vif *vif = netdev_priv(ndev);
 	struct wilc *wilc = vif->wilc;
-	struct tx_complete_data *tx_data = NULL;
 	int queue_count;
 
 	if (skb->dev != ndev) {
@@ -734,22 +743,15 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_OK;
 	}
 
-	tx_data = kmalloc(sizeof(*tx_data), GFP_ATOMIC);
-	if (!tx_data) {
+	queue_count = wilc_wlan_txq_add_net_pkt(ndev, skb);
+	if (queue_count < 0) {
 		dev_kfree_skb(skb);
 		netif_wake_queue(ndev);
 		return NETDEV_TX_OK;
 	}
 
-	tx_data->buff = skb->data;
-	tx_data->size = skb->len;
-	tx_data->skb  = skb;
-
 	vif->netstats.tx_packets++;
-	vif->netstats.tx_bytes += tx_data->size;
-	queue_count = wilc_wlan_txq_add_net_pkt(ndev, tx_data,
-						tx_data->buff, tx_data->size,
-						wilc_tx_complete);
+	vif->netstats.tx_bytes += skb->len;
 
 	if (queue_count > FLOW_CONTROL_UPPER_THRESHOLD) {
 		int srcu_idx;
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index bb1a315a7b7e..b3ba87bd3581 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -277,6 +277,7 @@ struct wilc_wfi_mon_priv {
 	struct net_device *real_ndev;
 };
 
+void wilc_tx_complete(struct txq_entry_t *tqe);
 void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size, u32 pkt_offset);
 void wilc_mac_indicate(struct wilc *wilc);
 void wilc_netdev_cleanup(struct wilc *wilc);
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 58bbf50081e4..7493fe053efd 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -219,10 +219,7 @@ static void wilc_wlan_txq_filter_dup_tcp_ack(struct net_device *dev)
 			tqe = f->pending_acks[i].txqe;
 			if (tqe) {
 				wilc_wlan_txq_remove(wilc, tqe->q_num, tqe);
-				tqe->status = 1;
-				if (tqe->tx_complete_func)
-					tqe->tx_complete_func(tqe->priv,
-							      tqe->status);
+				wilc_tx_complete(tqe);
 				kfree(tqe);
 				dropped++;
 			}
@@ -272,8 +269,6 @@ static int wilc_wlan_txq_add_cfg_pkt(struct wilc_vif *vif, u8 *buffer,
 	tqe->type = WILC_CFG_PKT;
 	tqe->buffer = buffer;
 	tqe->buffer_size = buffer_size;
-	tqe->tx_complete_func = NULL;
-	tqe->priv = NULL;
 	tqe->q_num = AC_VO_Q;
 	tqe->ack_idx = NOT_TCP_ACK;
 	tqe->vif = vif;
@@ -410,45 +405,30 @@ static inline u8 ac_change(struct wilc *wilc, u8 *ac)
 	return 1;
 }
 
-int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
-			      struct tx_complete_data *tx_data, u8 *buffer,
-			      u32 buffer_size,
-			      void (*tx_complete_fn)(void *, int))
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev, struct sk_buff *skb)
 {
 	struct txq_entry_t *tqe;
 	struct wilc_vif *vif = netdev_priv(dev);
-	struct wilc *wilc;
+	struct wilc *wilc = vif->wilc;
 	u8 q_num;
 
-	wilc = vif->wilc;
-
-	if (wilc->quit) {
-		tx_complete_fn(tx_data, 0);
-		return 0;
-	}
-
-	if (!wilc->initialized) {
-		tx_complete_fn(tx_data, 0);
-		return 0;
-	}
+	if (wilc->quit || !wilc->initialized)
+		return -EINVAL;
 
 	tqe = kmalloc(sizeof(*tqe), GFP_ATOMIC);
+	if (!tqe)
+		return -ENOMEM;
 
-	if (!tqe) {
-		tx_complete_fn(tx_data, 0);
-		return 0;
-	}
 	tqe->type = WILC_NET_PKT;
-	tqe->buffer = buffer;
-	tqe->buffer_size = buffer_size;
-	tqe->tx_complete_func = tx_complete_fn;
-	tqe->priv = tx_data;
+	tqe->skb = skb;
+	tqe->buffer = skb->data;
+	tqe->buffer_size = skb->len;
 	tqe->vif = vif;
 
-	q_num = ac_classify(wilc, tx_data->skb);
+	q_num = ac_classify(wilc, skb);
 	tqe->q_num = q_num;
 	if (ac_change(wilc, &q_num)) {
-		tx_complete_fn(tx_data, 0);
+		wilc_tx_complete(tqe);
 		kfree(tqe);
 		return 0;
 	}
@@ -459,43 +439,30 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
 			tcp_process(dev, tqe);
 		wilc_wlan_txq_add_to_tail(dev, q_num, tqe);
 	} else {
-		tx_complete_fn(tx_data, 0);
+		wilc_tx_complete(tqe);
 		kfree(tqe);
 	}
 
 	return wilc->txq_entries;
 }
 
-int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buffer,
-			       u32 buffer_size,
-			       void (*tx_complete_fn)(void *, int))
+int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, u8 *buffer,
+			       u32 buffer_size)
 {
 	struct txq_entry_t *tqe;
 	struct wilc_vif *vif = netdev_priv(dev);
-	struct wilc *wilc;
-
-	wilc = vif->wilc;
+	struct wilc *wilc = vif->wilc;
 
-	if (wilc->quit) {
-		tx_complete_fn(priv, 0);
-		return 0;
-	}
+	if (wilc->quit || !wilc->initialized)
+		return -EINVAL;
 
-	if (!wilc->initialized) {
-		tx_complete_fn(priv, 0);
-		return 0;
-	}
 	tqe = kmalloc(sizeof(*tqe), GFP_ATOMIC);
+	if (!tqe)
+		return -ENOMEM;
 
-	if (!tqe) {
-		tx_complete_fn(priv, 0);
-		return 0;
-	}
 	tqe->type = WILC_MGMT_PKT;
 	tqe->buffer = buffer;
 	tqe->buffer_size = buffer_size;
-	tqe->tx_complete_func = tx_complete_fn;
-	tqe->priv = priv;
 	tqe->q_num = AC_BE_Q;
 	tqe->ack_idx = NOT_TCP_ACK;
 	tqe->vif = vif;
@@ -916,9 +883,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 		       tqe->buffer, tqe->buffer_size);
 		offset += vmm_sz;
 		i++;
-		tqe->status = 1;
-		if (tqe->tx_complete_func)
-			tqe->tx_complete_func(tqe->priv, tqe->status);
+		wilc_tx_complete(tqe);
 		if (tqe->ack_idx != NOT_TCP_ACK &&
 		    tqe->ack_idx < MAX_PENDING_ACKS)
 			vif->ack_filter.pending_acks[tqe->ack_idx].txqe = NULL;
@@ -1243,8 +1208,7 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	wilc->quit = 1;
 	for (ac = 0; ac < NQUEUES; ac++) {
 		while ((tqe = wilc_wlan_txq_remove_from_head(wilc, ac))) {
-			if (tqe->tx_complete_func)
-				tqe->tx_complete_func(tqe->priv, 0);
+			wilc_tx_complete(tqe);
 			kfree(tqe);
 		}
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index a72cd5cac81d..f5ba836c595a 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -323,15 +323,13 @@ enum ip_pkt_priority {
 
 struct txq_entry_t {
 	struct list_head list;
-	int type;
+	u8 type;
 	u8 q_num;
-	int ack_idx;
+	s16 ack_idx;
+	struct sk_buff *skb;
 	u8 *buffer;
-	int buffer_size;
-	void *priv;
-	int status;
+	u32 buffer_size;
 	struct wilc_vif *vif;
-	void (*tx_complete_func)(void *priv, int status);
 };
 
 struct txq_fw_recv_queue_stat {
@@ -378,12 +376,6 @@ struct wilc_hif_func {
 
 #define WILC_MAX_CFG_FRAME_SIZE		1468
 
-struct tx_complete_data {
-	int size;
-	void *buff;
-	struct sk_buff *skb;
-};
-
 struct wilc_cfg_cmd_hdr {
 	u8 cmd_type;
 	u8 seq_no;
@@ -407,10 +399,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
 int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif);
-int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
-			      struct tx_complete_data *tx_data, u8 *buffer,
-			      u32 buffer_size,
-			      void (*tx_complete_fn)(void *, int));
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev, struct sk_buff *skb);
 int wilc_wlan_handle_txq(struct wilc *wl, u32 *txq_count);
 void wilc_handle_isr(struct wilc *wilc);
 void wilc_wlan_cleanup(struct net_device *dev);
@@ -418,8 +407,8 @@ int wilc_wlan_cfg_set(struct wilc_vif *vif, int start, u16 wid, u8 *buffer,
 		      u32 buffer_size, int commit, u32 drv_handler);
 int wilc_wlan_cfg_get(struct wilc_vif *vif, int start, u16 wid, int commit,
 		      u32 drv_handler);
-int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buffer,
-			       u32 buffer_size, void (*func)(void *, int));
+int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, u8 *buffer,
+			       u32 buffer_size);
 void wilc_enable_tcp_ack_filter(struct wilc_vif *vif, bool value);
 int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
 netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
-- 
2.41.0

