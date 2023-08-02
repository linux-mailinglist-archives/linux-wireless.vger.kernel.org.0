Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144F76D34E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjHBQHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjHBQHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:07:40 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2162B1706
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:07:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26a7:0:640:a2d5:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id E2B8C46C4F;
        Wed,  2 Aug 2023 19:07:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id S7VxvrADR8c0-vQJ3JVFL;
        Wed, 02 Aug 2023 19:07:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690992452;
        bh=aJ9l3fGd6T06lT/AFrMURtiY842p5buWm4YiebZ41+s=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=MlkBRumO4P0srWUblvcLIuSP+1P6sm9I9IAXJkhWMRipNCTPs6ZN7Vkoti/QLUN0i
         bj4gjUL7iU7e9ZXxYsKFMwelzeRpSLnEFl56NLtGXnXDdmCRFQUjsLApu9laeppmUM
         4lzvIX61jm0ixDYYDvZ/W/zucA2+jiCFhfXtKv7E=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 5/5] [v3] wifi: mwifiex: drop BUG_ON from TX paths
Date:   Wed,  2 Aug 2023 19:07:19 +0300
Message-ID: <20230802160726.85545-5-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802160726.85545-1-dmantipov@yandex.ru>
References: <ZMlHCmjf2ZovExsP@google.com>
 <20230802160726.85545-1-dmantipov@yandex.ru>
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

In 'mwifiex_process_sta_txpd()' and 'mwifiex_process_uap_txpd()',
replace 'BUG_ON()' with runtime check, and move all these checks
to 'mwifiex_process_tx()'. This way, both callees may be converted
to 'void', and the caller may be simplified as well.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: drop some overengineered bits, fix a few nits reported by
checkpatch.pl, and reorder series by making this patch the last
one, thus hopefully simplify the landing
---
 drivers/net/wireless/marvell/mwifiex/main.h   |  6 ++-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c | 14 +-----
 drivers/net/wireless/marvell/mwifiex/txrx.c   | 44 +++++++++++--------
 .../net/wireless/marvell/mwifiex/uap_txrx.c   | 14 +-----
 4 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 7421e9bf8650..97e7c835d729 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1144,8 +1144,10 @@ int mwifiex_process_uap_event(struct mwifiex_private *);
 void mwifiex_delete_all_station_list(struct mwifiex_private *priv);
 void mwifiex_wmm_del_peer_ra_list(struct mwifiex_private *priv,
 				  const u8 *ra_addr);
-void *mwifiex_process_sta_txpd(struct mwifiex_private *, struct sk_buff *skb);
-void *mwifiex_process_uap_txpd(struct mwifiex_private *, struct sk_buff *skb);
+void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
+			      struct sk_buff *skb);
+void mwifiex_process_uap_txpd(struct mwifiex_private *priv,
+			      struct sk_buff *skb);
 int mwifiex_sta_init_cmd(struct mwifiex_private *, u8 first_sta, bool init);
 int mwifiex_cmd_802_11_scan(struct host_cmd_ds_command *cmd,
 			    struct mwifiex_scan_cmd_config *scan_cfg);
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index d27b6e6493f3..70c2790b8e35 100644
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
@@ -39,14 +39,6 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
-		return skb->data;
-	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
-
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
 	pad = ((uintptr_t)skb->data - (sizeof(*local_tx_pd) + hroom)) &
@@ -108,8 +100,6 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	if (!local_tx_pd->tx_control)
 		/* TxCtrl set by user or default */
 		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
-
-	return skb->data;
 }
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index 54c204608dab..bd91678d26b4 100644
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
@@ -88,33 +93,31 @@ int mwifiex_process_tx(struct mwifiex_private *priv, struct sk_buff *skb,
 			dest_node->stats.tx_packets++;
 		}
 
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
 	mwifiex_dbg_dump(adapter, DAT_D, "tx pkt:", skb->data,
 			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
-
+out:
 	switch (ret) {
 	case -ENOSR:
 		mwifiex_dbg(adapter, DATA, "data: -ENOSR is returned\n");
@@ -137,6 +140,11 @@ int mwifiex_process_tx(struct mwifiex_private *priv, struct sk_buff *skb,
 		break;
 	case -EINPROGRESS:
 		break;
+	case -EINVAL:
+		mwifiex_dbg(adapter, ERROR,
+			    "malformed skb (length: %u, headroom: %u)\n",
+			    skb->len, skb_headroom(skb));
+		fallthrough;
 	case 0:
 		mwifiex_write_data_complete(adapter, skb, 0, ret);
 		break;
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 360d36ceeb1d..caff442399f3 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -461,8 +461,8 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
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
@@ -471,14 +471,6 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
-		return skb->data;
-	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
-
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
 	pad = ((uintptr_t)skb->data - (sizeof(*txpd) + hroom)) &
@@ -526,6 +518,4 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 	if (!txpd->tx_control)
 		/* TxCtrl set by user or default */
 		txpd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
-
-	return skb->data;
 }
-- 
2.41.0

