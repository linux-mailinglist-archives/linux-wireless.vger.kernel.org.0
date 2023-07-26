Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC8762D32
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjGZHYS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjGZHX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:23:27 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230C4204
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:21:50 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:a497:0:640:fcbf:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 6886760052;
        Wed, 26 Jul 2023 10:21:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kLF1MPmWs8c0-TD3Eyigc;
        Wed, 26 Jul 2023 10:21:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690356107;
        bh=Xekw69DB5UQpqiXmVWr1qk7CKBlJBthEe4TyQ0zSaEs=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=tCx4/XC2snK6Z9RLRpI/j+iOs1xIDF8CisHdr6eeDuZb9//gBxz1W/nQmtatuLOdy
         TFSC4xpLOa3d+ytruI2SglHy4jyDkLSFIR0on1x/dYWESwxVvlIT7lzDFdwE6o5d47
         IL4bquOdiHGsoE5RZyzl209rJbIfLNja+xXTGp3w=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/5] wifi: mwifiex: drop BUG_ON() from TX error handling
Date:   Wed, 26 Jul 2023 10:20:53 +0300
Message-ID: <20230726072114.51964-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726072114.51964-1-dmantipov@yandex.ru>
References: <20230726072114.51964-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove 'BUG_ON()' from 'mwifiex_process_sta_txpd()' and
'mwifiex_process_uap_txpd()'. In case of insufficient
headrom, issue warning and return NULL, which should be
gracefully handled in 'mwifiex_process_tx()'. Also mark
error handling branches with 'unlikely()' and simplify
error messages (there is no need to use formatted output
to print the value which is known to be zero).

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/sta_tx.c   | 13 ++++++++-----
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 13c0e67ededf..5995a81f1ce9 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -39,14 +39,17 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
+	if (unlikely(!skb->len)) {
+		mwifiex_dbg(adapter, ERROR, "Tx: empty skb\n");
 		tx_info->status_code = -1;
 		return skb->data;
 	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
+	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "Tx: insufficient skb headroom: %u < %u\n",
+			    skb_headroom(skb), MWIFIEX_MIN_DATA_HEADER_LEN);
+		return NULL;
+	}
 
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index e495f7eaea03..ff953e8e7413 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -452,14 +452,17 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 	u16 pkt_type, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
-	if (!skb->len) {
-		mwifiex_dbg(adapter, ERROR,
-			    "Tx: bad packet length: %d\n", skb->len);
+	if (unlikely(!skb->len)) {
+		mwifiex_dbg(adapter, ERROR, "Tx: empty skb\n");
 		tx_info->status_code = -1;
 		return skb->data;
 	}
-
-	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
+	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "Tx: insufficient skb headroom: %u < %u\n",
+			    skb_headroom(skb), MWIFIEX_MIN_DATA_HEADER_LEN);
+		return NULL;
+	}
 
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
-- 
2.41.0

