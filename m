Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651B07A588B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 06:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjISEta (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 00:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjISEt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 00:49:28 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3ECBC115;
        Mon, 18 Sep 2023 21:49:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 866E3602B36DD;
        Tue, 19 Sep 2023 12:49:17 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     chunkeey@googlemail.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary (void*) conversions
Date:   Tue, 19 Sep 2023 12:49:16 +0800
Message-Id: <20230919044916.523308-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No need cast (void *) to (struct ar9170 *), (u8 *) or (void*).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/ath/carl9170/usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index e4eb666c6eea..c4edf8355941 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -178,7 +178,7 @@ static void carl9170_usb_tx_data_complete(struct urb *urb)
 	switch (urb->status) {
 	/* everything is fine */
 	case 0:
-		carl9170_tx_callback(ar, (void *)urb->context);
+		carl9170_tx_callback(ar, urb->context);
 		break;
 
 	/* disconnect */
@@ -369,7 +369,7 @@ void carl9170_usb_handle_tx_err(struct ar9170 *ar)
 	struct urb *urb;
 
 	while ((urb = usb_get_from_anchor(&ar->tx_err))) {
-		struct sk_buff *skb = (void *)urb->context;
+		struct sk_buff *skb = urb->context;
 
 		carl9170_tx_drop(ar, skb);
 		carl9170_tx_callback(ar, skb);
@@ -397,7 +397,7 @@ static void carl9170_usb_tasklet(struct tasklet_struct *t)
 
 static void carl9170_usb_rx_complete(struct urb *urb)
 {
-	struct ar9170 *ar = (struct ar9170 *)urb->context;
+	struct ar9170 *ar = urb->context;
 	int err;
 
 	if (WARN_ON_ONCE(!ar))
@@ -559,7 +559,7 @@ static int carl9170_usb_flush(struct ar9170 *ar)
 	int ret, err = 0;
 
 	while ((urb = usb_get_from_anchor(&ar->tx_wait))) {
-		struct sk_buff *skb = (void *)urb->context;
+		struct sk_buff *skb = urb->context;
 		carl9170_tx_drop(ar, skb);
 		carl9170_tx_callback(ar, skb);
 		usb_free_urb(urb);
@@ -668,7 +668,7 @@ int carl9170_exec_cmd(struct ar9170 *ar, const enum carl9170_cmd_oids cmd,
 		memcpy(ar->cmd.data, payload, plen);
 
 	spin_lock_bh(&ar->cmd_lock);
-	ar->readbuf = (u8 *)out;
+	ar->readbuf = out;
 	ar->readlen = outlen;
 	spin_unlock_bh(&ar->cmd_lock);
 
-- 
2.30.2

