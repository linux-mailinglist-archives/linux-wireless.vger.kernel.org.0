Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF337422AB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjF2Iwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjF2IwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 04:52:09 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D935BF
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 01:51:51 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1d21:0:640:c9e4:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id BBB7160023;
        Thu, 29 Jun 2023 11:51:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ipIxcZ1DSeA0-L0RnnBoy;
        Thu, 29 Jun 2023 11:51:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688028709;
        bh=lRNb0vhgA7lDOn3efwzkRAqW2F4EsHu4+8yk/WhuG/g=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=k+bUrGCnjucKCugVDeU4nQdoGxRNAP+2wa59ViLkKlMTiyhVMiV30/YJYdQdQHwzf
         xH8JUWE/cXu56bkMXh/vhQFwmp33Z1NVkG2a+n7XhEE8bXIYV+noNu1VZMYKUYjnNk
         K7CxdUVO1YxI3ZKcJ0ALQVgpOfIurXmf65DRACvk=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v4] wifi: mwifiex: drop BUG_ON() from TX error handling
Date:   Thu, 29 Jun 2023 11:51:02 +0300
Message-ID: <20230629085115.180499-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629085115.180499-1-dmantipov@yandex.ru>
References: <20230629085115.180499-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove 'BUG_ON()' from 'mwifiex_process_sta_txpd()' and
'mwifiex_process_uap_txpd()'. In case of insufficient
headrom, issue warning and return NULL, which should be
gracefully handled in 'mwifiex_process_tx()'. Also mark
error handling branches with 'unlikely()' and adjust
format specifiers to match actual 'unsigned int' type.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: initial version to match series
---
 drivers/net/wireless/marvell/mwifiex/sta_tx.c   | 13 +++++++++----
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 13c0e67ededf..d43f6ec1ad37 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -39,14 +39,19 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
+	if (unlikely(!skb->len)) {
 		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
+			    "Tx: bad packet length: %u\n", skb->len);
 		tx_info->status_code = -1;
 		return skb->data;
 	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
+	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "Tx: insufficient skb headroom: %u\n",
+			    skb_headroom(skb));
+		tx_info->status_code = -1;
+		return NULL;
+	}
 
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index e495f7eaea03..b27266742795 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -452,14 +452,19 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
+	if (unlikely(!skb->len)) {
 		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
+			    "Tx: bad packet length: %u\n", skb->len);
 		tx_info->status_code = -1;
 		return skb->data;
 	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
+	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "Tx: insufficient skb headroom: %u\n",
+			    skb_headroom(skb));
+		tx_info->status_code = -1;
+		return NULL;
+	}
 
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
-- 
2.41.0

