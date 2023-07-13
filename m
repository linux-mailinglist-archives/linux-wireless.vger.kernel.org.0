Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5279C751BAC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjGMIfT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 04:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjGMIeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 04:34:46 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4929F3595
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 01:26:47 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5e29:0:640:21c5:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 7B06460159;
        Thu, 13 Jul 2023 11:26:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hQWpE79DRCg0-uIPIyc9A;
        Thu, 13 Jul 2023 11:26:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689236803;
        bh=8xHOZ0Y89F+H+pG8f6PrlCHGO2j5xdRlpIn1SiyTxoQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=LZ4i66lIqpj4iRg7gzkryJBsPuhjpJFVKohvRq66LgIUoVQmNz/yan1U3aoNS8+zi
         E2J6JUq//0hgLnOtUr25xuiEwGWt9eDoZj7rJqwl1ljP7xS8oPyONQIihGWxm35tK4
         JtIyUE03qjfnGK07xY7LKwnMaErHXorrBzQosmIg=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Amisha Patel <amisha.patel@microchip.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: wilc1000: simplify TX callback functions
Date:   Thu, 13 Jul 2023 11:26:09 +0300
Message-ID: <20230713082616.112160-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
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

Drop unused second argument of TX callback functions and use
'struct txq_entry_t *' as the only argument, thus removing
'struct wilc_p2p_mgmt_data', 'struct tx_complete_mon_data'
and 'struct tx_complete_data' (actually intended just to
pass callbacks parameters) as well. This also shrinks
'struct txq_entry_t' by 'priv' field and eliminates a few
'kmalloc()/kfree()' calls (at the cost of having dummy
stack-allocated 'struct txq_entry_t' instances).

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 33 +++---------
 drivers/net/wireless/microchip/wilc1000/mon.c | 32 +++---------
 .../net/wireless/microchip/wilc1000/netdev.c  | 24 ++-------
 .../net/wireless/microchip/wilc1000/wlan.c    | 50 +++++++++----------
 .../net/wireless/microchip/wilc1000/wlan.h    | 22 +++-----
 5 files changed, 50 insertions(+), 111 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index b545d93c6e37..4490713a963b 100644
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
@@ -1086,12 +1081,9 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
 	cfg80211_rx_mgmt(&priv->wdev, freq, 0, buff, size, 0);
 }
 
-static void wilc_wfi_mgmt_tx_complete(void *priv, int status)
+static void wilc_wfi_mgmt_tx_complete(struct txq_entry_t *tqe)
 {
-	struct wilc_p2p_mgmt_data *pv_data = priv;
-
-	kfree(pv_data->buff);
-	kfree(pv_data);
+	kfree(tqe->buffer);
 }
 
 static void wilc_wfi_remain_on_channel_expired(void *data, u64 cookie)
@@ -1172,7 +1164,6 @@ static int mgmt_tx(struct wiphy *wiphy,
 	const u8 *buf = params->buf;
 	size_t len = params->len;
 	const struct ieee80211_mgmt *mgmt;
-	struct wilc_p2p_mgmt_data *mgmt_tx;
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 	struct host_if_drv *wfi_drv = priv->hif_drv;
@@ -1181,6 +1172,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 	int ie_offset = offsetof(struct ieee80211_mgmt, u) + sizeof(*d);
 	const u8 *vendor_ie;
 	int ret = 0;
+	u8 *copy;
 
 	*cookie = get_random_u32();
 	priv->tx_cookie = *cookie;
@@ -1189,21 +1181,12 @@ static int mgmt_tx(struct wiphy *wiphy,
 	if (!ieee80211_is_mgmt(mgmt->frame_control))
 		goto out;
 
-	mgmt_tx = kmalloc(sizeof(*mgmt_tx), GFP_KERNEL);
-	if (!mgmt_tx) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	mgmt_tx->buff = kmemdup(buf, len, GFP_KERNEL);
-	if (!mgmt_tx->buff) {
+	copy = kmemdup(buf, len, GFP_KERNEL);
+	if (!copy) {
 		ret = -ENOMEM;
-		kfree(mgmt_tx);
 		goto out;
 	}
 
-	mgmt_tx->size = len;
-
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		wilc_set_mac_chnl_num(vif, chan->hw_value);
 		vif->wilc->op_ch = chan->hw_value;
@@ -1230,8 +1213,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 		goto out_set_timeout;
 
 	vendor_ie = cfg80211_find_vendor_ie(WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P,
-					    mgmt_tx->buff + ie_offset,
-					    len - ie_offset);
+					    copy + ie_offset, len - ie_offset);
 	if (!vendor_ie)
 		goto out_set_timeout;
 
@@ -1243,8 +1225,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 
 out_txq_add_pkt:
 
-	wilc_wlan_txq_add_mgmt_pkt(wdev->netdev, mgmt_tx,
-				   mgmt_tx->buff, mgmt_tx->size,
+	wilc_wlan_txq_add_mgmt_pkt(wdev->netdev, NULL, copy, len,
 				   wilc_wfi_mgmt_tx_complete);
 
 out:
diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wireless/microchip/wilc1000/mon.c
index 03b7229a0ff5..05e0af133dd3 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -95,45 +95,25 @@ void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size)
 	netif_rx(skb);
 }
 
-struct tx_complete_mon_data {
-	int size;
-	void *buff;
-};
-
-static void mgmt_tx_complete(void *priv, int status)
+static void mgmt_tx_complete(struct txq_entry_t *tqe)
 {
-	struct tx_complete_mon_data *pv_data = priv;
-	/*
-	 * in case of fully hosting mode, the freeing will be done
-	 * in response to the cfg packet
-	 */
-	kfree(pv_data->buff);
-
-	kfree(pv_data);
+	kfree(tqe->buffer);
 }
 
 static int mon_mgmt_tx(struct net_device *dev, const u8 *buf, size_t len)
 {
-	struct tx_complete_mon_data *mgmt_tx = NULL;
+	u8 *buff;
 
 	if (!dev)
 		return -EFAULT;
 
 	netif_stop_queue(dev);
-	mgmt_tx = kmalloc(sizeof(*mgmt_tx), GFP_ATOMIC);
-	if (!mgmt_tx)
-		return -ENOMEM;
 
-	mgmt_tx->buff = kmemdup(buf, len, GFP_ATOMIC);
-	if (!mgmt_tx->buff) {
-		kfree(mgmt_tx);
+	buff = kmemdup(buf, len, GFP_ATOMIC);
+	if (!buff)
 		return -ENOMEM;
-	}
-
-	mgmt_tx->size = len;
 
-	wilc_wlan_txq_add_mgmt_pkt(dev, mgmt_tx, mgmt_tx->buff, mgmt_tx->size,
-				   mgmt_tx_complete);
+	wilc_wlan_txq_add_mgmt_pkt(dev, NULL, buff, len, mgmt_tx_complete);
 
 	netif_wake_queue(dev);
 	return 0;
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..74864505ea22 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -713,19 +713,15 @@ static void wilc_set_multicast_list(struct net_device *dev)
 		kfree(mc_list);
 }
 
-static void wilc_tx_complete(void *priv, int status)
+static void wilc_tx_complete(struct txq_entry_t *tqe)
 {
-	struct tx_complete_data *pv_data = priv;
-
-	dev_kfree_skb(pv_data->skb);
-	kfree(pv_data);
+	dev_kfree_skb(tqe->skb);
 }
 
 netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct wilc_vif *vif = netdev_priv(ndev);
 	struct wilc *wilc = vif->wilc;
-	struct tx_complete_data *tx_data = NULL;
 	int queue_count;
 
 	if (skb->dev != ndev) {
@@ -734,21 +730,9 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_OK;
 	}
 
-	tx_data = kmalloc(sizeof(*tx_data), GFP_ATOMIC);
-	if (!tx_data) {
-		dev_kfree_skb(skb);
-		netif_wake_queue(ndev);
-		return NETDEV_TX_OK;
-	}
-
-	tx_data->buff = skb->data;
-	tx_data->size = skb->len;
-	tx_data->skb  = skb;
-
 	vif->netstats.tx_packets++;
-	vif->netstats.tx_bytes += tx_data->size;
-	queue_count = wilc_wlan_txq_add_net_pkt(ndev, tx_data,
-						tx_data->buff, tx_data->size,
+	vif->netstats.tx_bytes += skb->len;
+	queue_count = wilc_wlan_txq_add_net_pkt(ndev, skb, skb->data, skb->len,
 						wilc_tx_complete);
 
 	if (queue_count > FLOW_CONTROL_UPPER_THRESHOLD) {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 58bbf50081e4..19561a807137 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -221,8 +221,7 @@ static void wilc_wlan_txq_filter_dup_tcp_ack(struct net_device *dev)
 				wilc_wlan_txq_remove(wilc, tqe->q_num, tqe);
 				tqe->status = 1;
 				if (tqe->tx_complete_func)
-					tqe->tx_complete_func(tqe->priv,
-							      tqe->status);
+					tqe->tx_complete_func(tqe);
 				kfree(tqe);
 				dropped++;
 			}
@@ -270,10 +269,10 @@ static int wilc_wlan_txq_add_cfg_pkt(struct wilc_vif *vif, u8 *buffer,
 	}
 
 	tqe->type = WILC_CFG_PKT;
+	tqe->skb = NULL;
 	tqe->buffer = buffer;
 	tqe->buffer_size = buffer_size;
 	tqe->tx_complete_func = NULL;
-	tqe->priv = NULL;
 	tqe->q_num = AC_VO_Q;
 	tqe->ack_idx = NOT_TCP_ACK;
 	tqe->vif = vif;
@@ -410,12 +409,12 @@ static inline u8 ac_change(struct wilc *wilc, u8 *ac)
 	return 1;
 }
 
-int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
-			      struct tx_complete_data *tx_data, u8 *buffer,
-			      u32 buffer_size,
-			      void (*tx_complete_fn)(void *, int))
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev, struct sk_buff *skb,
+			      u8 *buffer, u32 buffer_size,
+			      void (*tx_complete_fn)(struct txq_entry_t *))
 {
-	struct txq_entry_t *tqe;
+	struct txq_entry_t *tqe, dummy = { .skb = skb, .buffer = buffer,
+					   .buffer_size = buffer_size };
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc;
 	u8 q_num;
@@ -423,32 +422,32 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
 	wilc = vif->wilc;
 
 	if (wilc->quit) {
-		tx_complete_fn(tx_data, 0);
+		tx_complete_fn(&dummy);
 		return 0;
 	}
 
 	if (!wilc->initialized) {
-		tx_complete_fn(tx_data, 0);
+		tx_complete_fn(&dummy);
 		return 0;
 	}
 
 	tqe = kmalloc(sizeof(*tqe), GFP_ATOMIC);
 
 	if (!tqe) {
-		tx_complete_fn(tx_data, 0);
+		tx_complete_fn(&dummy);
 		return 0;
 	}
 	tqe->type = WILC_NET_PKT;
+	tqe->skb = skb;
 	tqe->buffer = buffer;
 	tqe->buffer_size = buffer_size;
 	tqe->tx_complete_func = tx_complete_fn;
-	tqe->priv = tx_data;
 	tqe->vif = vif;
 
-	q_num = ac_classify(wilc, tx_data->skb);
+	q_num = ac_classify(wilc, skb);
 	tqe->q_num = q_num;
 	if (ac_change(wilc, &q_num)) {
-		tx_complete_fn(tx_data, 0);
+		tx_complete_fn(tqe);
 		kfree(tqe);
 		return 0;
 	}
@@ -459,43 +458,44 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
 			tcp_process(dev, tqe);
 		wilc_wlan_txq_add_to_tail(dev, q_num, tqe);
 	} else {
-		tx_complete_fn(tx_data, 0);
+		tx_complete_fn(tqe);
 		kfree(tqe);
 	}
 
 	return wilc->txq_entries;
 }
 
-int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buffer,
-			       u32 buffer_size,
-			       void (*tx_complete_fn)(void *, int))
+int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, struct sk_buff *skb,
+			       u8 *buffer, u32 buffer_size,
+			       void (*tx_complete_fn)(struct txq_entry_t *))
 {
-	struct txq_entry_t *tqe;
+	struct txq_entry_t *tqe, dummy = { .skb = skb, .buffer = buffer,
+					   .buffer_size = buffer_size };
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc;
 
 	wilc = vif->wilc;
 
 	if (wilc->quit) {
-		tx_complete_fn(priv, 0);
+		tx_complete_fn(&dummy);
 		return 0;
 	}
 
 	if (!wilc->initialized) {
-		tx_complete_fn(priv, 0);
+		tx_complete_fn(&dummy);
 		return 0;
 	}
 	tqe = kmalloc(sizeof(*tqe), GFP_ATOMIC);
 
 	if (!tqe) {
-		tx_complete_fn(priv, 0);
+		tx_complete_fn(&dummy);
 		return 0;
 	}
 	tqe->type = WILC_MGMT_PKT;
+	tqe->skb = skb;
 	tqe->buffer = buffer;
 	tqe->buffer_size = buffer_size;
 	tqe->tx_complete_func = tx_complete_fn;
-	tqe->priv = priv;
 	tqe->q_num = AC_BE_Q;
 	tqe->ack_idx = NOT_TCP_ACK;
 	tqe->vif = vif;
@@ -918,7 +918,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 		i++;
 		tqe->status = 1;
 		if (tqe->tx_complete_func)
-			tqe->tx_complete_func(tqe->priv, tqe->status);
+			tqe->tx_complete_func(tqe);
 		if (tqe->ack_idx != NOT_TCP_ACK &&
 		    tqe->ack_idx < MAX_PENDING_ACKS)
 			vif->ack_filter.pending_acks[tqe->ack_idx].txqe = NULL;
@@ -1244,7 +1244,7 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	for (ac = 0; ac < NQUEUES; ac++) {
 		while ((tqe = wilc_wlan_txq_remove_from_head(wilc, ac))) {
 			if (tqe->tx_complete_func)
-				tqe->tx_complete_func(tqe->priv, 0);
+				tqe->tx_complete_func(tqe);
 			kfree(tqe);
 		}
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index a72cd5cac81d..ecccd43baaa3 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -328,10 +328,10 @@ struct txq_entry_t {
 	int ack_idx;
 	u8 *buffer;
 	int buffer_size;
-	void *priv;
+	struct sk_buff *skb;
 	int status;
 	struct wilc_vif *vif;
-	void (*tx_complete_func)(void *priv, int status);
+	void (*tx_complete_func)(struct txq_entry_t *tqe);
 };
 
 struct txq_fw_recv_queue_stat {
@@ -378,12 +378,6 @@ struct wilc_hif_func {
 
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
@@ -407,10 +401,9 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
 int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif);
-int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
-			      struct tx_complete_data *tx_data, u8 *buffer,
-			      u32 buffer_size,
-			      void (*tx_complete_fn)(void *, int));
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev, struct sk_buff *skb,
+			      u8 *buffer, u32 buffer_size,
+			      void (*tx_complete_fn)(struct txq_entry_t *));
 int wilc_wlan_handle_txq(struct wilc *wl, u32 *txq_count);
 void wilc_handle_isr(struct wilc *wilc);
 void wilc_wlan_cleanup(struct net_device *dev);
@@ -418,8 +411,9 @@ int wilc_wlan_cfg_set(struct wilc_vif *vif, int start, u16 wid, u8 *buffer,
 		      u32 buffer_size, int commit, u32 drv_handler);
 int wilc_wlan_cfg_get(struct wilc_vif *vif, int start, u16 wid, int commit,
 		      u32 drv_handler);
-int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buffer,
-			       u32 buffer_size, void (*func)(void *, int));
+int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, struct sk_buff *skb,
+			       u8 *buffer, u32 buffer_size,
+			       void (*tx_complete_fn)(struct txq_entry_t *));
 void wilc_enable_tcp_ack_filter(struct wilc_vif *vif, bool value);
 int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
 netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
-- 
2.41.0

