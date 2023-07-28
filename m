Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097E4766788
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjG1Iol (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 04:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjG1IoV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 04:44:21 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9842A2113
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 01:44:19 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a712:0:640:d986:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 2844660064;
        Fri, 28 Jul 2023 11:44:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiIwG59DYW20-GMot7wYL;
        Fri, 28 Jul 2023 11:44:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690533856;
        bh=gHFBIW65PDYbsQSZZDEXtb+Qle37sEoXUTDvWvwVWRM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=epeAgbZIv+/GYVRhGAMldp2SlRPDyDbeZm35WMh5tMI4BFMbRDeyyrewfVXsX4pfb
         5UKBIV8w6l7dWS4yuNPNO75+0yjID2SNhJWDM8psrkoT68cjNJJyRbnCgXDRtY1/ul
         uRraKFrePIYnmVvtxE3McRksoB6s7uQ1Oc9dNhk4=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] [v2] wifi: mwifiex: cleanup TX error handling
Date:   Fri, 28 Jul 2023 11:43:43 +0300
Message-ID: <20230728084407.101930-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728084407.101930-1-dmantipov@yandex.ru>
References: <ZMFzBStAKemf+dLL@google.com>
 <20230728084407.101930-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'mwifiex_process_tx()' is the only place from where both
'mwifiex_process_sta_txpd()' and 'mwifiex_process_uap_txpd()'
are called, these functions may be converted to 'void' after
moving skb layout check to the caller, which may be simplified
as well. Also adjust somewhat obfuscating error messages and
add 'mwifiex_interface_name()' to make them a bit more useful.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: some redesign in attempt to integrate Brian's feedback
---
 .../net/wireless/marvell/mwifiex/11n_aggr.c   |  4 +-
 drivers/net/wireless/marvell/mwifiex/main.h   | 18 ++++++-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c | 26 ++-------
 drivers/net/wireless/marvell/mwifiex/txrx.c   | 53 ++++++++++---------
 .../net/wireless/marvell/mwifiex/uap_txrx.c   | 15 +-----
 drivers/net/wireless/marvell/mwifiex/wmm.c    |  3 +-
 6 files changed, 55 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
index 34b4b34276d6..4de2ff688cc3 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
@@ -273,8 +273,8 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 		mwifiex_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
 		break;
 	case -1:
-		mwifiex_dbg(adapter, ERROR, "%s: host_to_card failed: %#x\n",
-			    __func__, ret);
+		mwifiex_dbg(adapter, ERROR, "%s: %s interface error\n",
+			    __func__, mwifiex_interface_name(adapter));
 		adapter->dbg.num_tx_host_to_card_failure++;
 		mwifiex_write_data_complete(adapter, skb_aggr, 1, ret);
 		return 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index b95886e1413e..24b07256e822 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1155,8 +1155,8 @@ int mwifiex_process_uap_event(struct mwifiex_private *);
 void mwifiex_delete_all_station_list(struct mwifiex_private *priv);
 void mwifiex_wmm_del_peer_ra_list(struct mwifiex_private *priv,
 				  const u8 *ra_addr);
-void *mwifiex_process_sta_txpd(struct mwifiex_private *, struct sk_buff *skb);
-void *mwifiex_process_uap_txpd(struct mwifiex_private *, struct sk_buff *skb);
+void mwifiex_process_sta_txpd(struct mwifiex_private *priv, struct sk_buff *skb);
+void mwifiex_process_uap_txpd(struct mwifiex_private *priv, struct sk_buff *skb);
 int mwifiex_sta_init_cmd(struct mwifiex_private *, u8 first_sta, bool init);
 int mwifiex_cmd_802_11_scan(struct host_cmd_ds_command *cmd,
 			    struct mwifiex_scan_cmd_config *scan_cfg);
@@ -1471,6 +1471,20 @@ static inline void mwifiex_enable_wake(struct mwifiex_adapter *adapter)
 	}
 }
 
+static inline char *mwifiex_interface_name(struct mwifiex_adapter *adapter)
+{
+	switch (adapter->iface_type) {
+	case MWIFIEX_SDIO:
+		return "SDIO";
+	case MWIFIEX_PCIE:
+		return "PCIE";
+	case MWIFIEX_USB:
+		return "USB";
+	default:
+		return "<unknown>";
+	}
+}
+
 int mwifiex_init_shutdown_fw(struct mwifiex_private *priv,
 			     u32 func_init_shutdown);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 13c0e67ededf..918a6f444ae4 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -29,8 +29,8 @@
  *      - Priority specific Tx control
  *      - Flags
  */
-void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
-				struct sk_buff *skb)
+void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
+			      struct sk_buff *skb)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct txpd *local_tx_pd;
@@ -39,15 +39,6 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
-		tx_info->status_code = -1;
-		return skb->data;
-	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
-
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
 	pad = ((uintptr_t)skb->data - (sizeof(*local_tx_pd) + hroom)) &
@@ -109,8 +100,6 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	if (!local_tx_pd->tx_control)
 		/* TxCtrl set by user or default */
 		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
-
-	return skb->data;
 }
 
 /*
@@ -176,17 +165,10 @@ int mwifiex_send_null_packet(struct mwifiex_private *priv, u8 flags)
 	}
 	switch (ret) {
 	case -EBUSY:
-		dev_kfree_skb_any(skb);
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: host_to_card failed: ret=%d\n",
-			    __func__, ret);
-		adapter->dbg.num_tx_host_to_card_failure++;
-		break;
 	case -1:
 		dev_kfree_skb_any(skb);
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: host_to_card failed: ret=%d\n",
-			    __func__, ret);
+		mwifiex_dbg(adapter, ERROR, "%s: %s interface error\n",
+			    __func__, mwifiex_interface_name(adapter));
 		adapter->dbg.num_tx_host_to_card_failure++;
 		break;
 	case 0:
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index 54c204608dab..3e176502ced3 100644
--- a/drivers/net/wireless/marvell/mwifiex/txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
@@ -72,13 +72,18 @@ EXPORT_SYMBOL_GPL(mwifiex_handle_rx_packet);
 int mwifiex_process_tx(struct mwifiex_private *priv, struct sk_buff *skb,
 		       struct mwifiex_tx_param *tx_param)
 {
-	int hroom, ret = -1;
+	int hroom, ret;
 	struct mwifiex_adapter *adapter = priv->adapter;
-	u8 *head_ptr;
 	struct txpd *local_tx_pd = NULL;
 	struct mwifiex_sta_node *dest_node;
 	struct ethhdr *hdr = (void *)skb->data;
 
+	if (unlikely(!skb->len ||
+		     skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	hroom = adapter->intf_hdr_len;
 
 	if (priv->bss_role == MWIFIEX_BSS_ROLE_UAP) {
@@ -87,34 +92,32 @@ int mwifiex_process_tx(struct mwifiex_private *priv, struct sk_buff *skb,
 			dest_node->stats.tx_bytes += skb->len;
 			dest_node->stats.tx_packets++;
 		}
-
-		head_ptr = mwifiex_process_uap_txpd(priv, skb);
+		mwifiex_process_uap_txpd(priv, skb);
 	} else {
-		head_ptr = mwifiex_process_sta_txpd(priv, skb);
+		mwifiex_process_sta_txpd(priv, skb);
 	}
 
-	if ((adapter->data_sent || adapter->tx_lock_flag) && head_ptr) {
+	if (adapter->data_sent || adapter->tx_lock_flag) {
 		skb_queue_tail(&adapter->tx_data_q, skb);
 		atomic_inc(&adapter->tx_queued);
 		return 0;
 	}
 
-	if (head_ptr) {
-		if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA)
-			local_tx_pd = (struct txpd *)(head_ptr + hroom);
-		if (adapter->iface_type == MWIFIEX_USB) {
-			ret = adapter->if_ops.host_to_card(adapter,
-							   priv->usb_port,
-							   skb, tx_param);
-		} else {
-			ret = adapter->if_ops.host_to_card(adapter,
-							   MWIFIEX_TYPE_DATA,
-							   skb, tx_param);
-		}
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(skb->data + hroom);
+	if (adapter->iface_type == MWIFIEX_USB) {
+		ret = adapter->if_ops.host_to_card(adapter,
+						   priv->usb_port,
+						   skb, tx_param);
+	} else {
+		ret = adapter->if_ops.host_to_card(adapter,
+						   MWIFIEX_TYPE_DATA,
+						   skb, tx_param);
 	}
+
 	mwifiex_dbg_dump(adapter, DAT_D, "tx pkt:", skb->data,
 			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
-
+out:
 	switch (ret) {
 	case -ENOSR:
 		mwifiex_dbg(adapter, DATA, "data: -ENOSR is returned\n");
@@ -129,14 +132,16 @@ int mwifiex_process_tx(struct mwifiex_private *priv, struct sk_buff *skb,
 		mwifiex_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
 		break;
 	case -1:
-		mwifiex_dbg(adapter, ERROR,
-			    "mwifiex_write_data_async failed: 0x%X\n",
-			    ret);
+		mwifiex_dbg(adapter, ERROR, "%s: %s interface error\n",
+			    __func__, mwifiex_interface_name(adapter));
 		adapter->dbg.num_tx_host_to_card_failure++;
 		mwifiex_write_data_complete(adapter, skb, 0, ret);
 		break;
 	case -EINPROGRESS:
 		break;
+	case -EINVAL:
+		mwifiex_dbg(adapter, ERROR, "%s: malformed skb\n", __func__);
+		fallthrough;
 	case 0:
 		mwifiex_write_data_complete(adapter, skb, 0, ret);
 		break;
@@ -199,8 +204,8 @@ static int mwifiex_host_to_card(struct mwifiex_adapter *adapter,
 		mwifiex_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
 		break;
 	case -1:
-		mwifiex_dbg(adapter, ERROR,
-			    "mwifiex_write_data_async failed: 0x%X\n", ret);
+		mwifiex_dbg(adapter, ERROR, "%s: %s interface error\n",
+			    __func__, mwifiex_interface_name(adapter));
 		adapter->dbg.num_tx_host_to_card_failure++;
 		mwifiex_write_data_complete(adapter, skb, 0, ret);
 		break;
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index e495f7eaea03..fe26dcc23120 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -442,8 +442,8 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
  *      - Priority specific Tx control
  *      - Flags
  */
-void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
-			       struct sk_buff *skb)
+void mwifiex_process_uap_txpd(struct mwifiex_private *priv,
+			      struct sk_buff *skb)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct uap_txpd *txpd;
@@ -452,15 +452,6 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
-		tx_info->status_code = -1;
-		return skb->data;
-	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
-
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
 	pad = ((uintptr_t)skb->data - (sizeof(*txpd) + hroom)) &
@@ -508,6 +499,4 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 	if (!txpd->tx_control)
 		/* TxCtrl set by user or default */
 		txpd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
-
-	return skb->data;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 00a5679b5c51..050ce183f507 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -1376,7 +1376,8 @@ mwifiex_send_processed_packet(struct mwifiex_private *priv,
 		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
 		break;
 	case -1:
-		mwifiex_dbg(adapter, ERROR, "host_to_card failed: %#x\n", ret);
+		mwifiex_dbg(adapter, ERROR, "%s: %s interface error\n",
+			    __func__, mwifiex_interface_name(adapter));
 		adapter->dbg.num_tx_host_to_card_failure++;
 		mwifiex_write_data_complete(adapter, skb, 0, ret);
 		break;
-- 
2.41.0

