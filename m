Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5140655618
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 19:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfFYRlA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 13:41:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34522 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfFYRk6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 13:40:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so9324519pgn.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qObNmbNGw5KriFEegIgXpV14jLgXOv4uYBya5X/6nZE=;
        b=IyYT5zUgrPrbvy/z5y9C68xpBlIstWIWrmNfCziC8KKYkOtZDtIgNwvlvDGkad7yKu
         9ImC41oaiQaOdDaAJbCW0UU/LYlWTzT0p5abyKT8HvRMaaWRjSETQkC6q/M1jh5AUjH5
         BXqA8Rw+cdLpz4YLtE7s9f+8LS81lqjctcUeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qObNmbNGw5KriFEegIgXpV14jLgXOv4uYBya5X/6nZE=;
        b=mJlN5jPeoP1xk5WmYCYIvkp/0RQ6V7Ks1+3wenkcfWLpIanI9+yJcESeyGQ0Vnk5/7
         n6XG5nlXFPHqJVSdjoskdNuQyvSOeTNQf/NxaZwQ+KL5nz4y0QJKWUFISjn6ZocJEmEQ
         fMSujdz+Y6Ak9cQuEB/IDlKYDngN+aiymDkN7mk2AFkc2cuFPsR1oObIhnBCuAcFOC06
         7SdyRW9Iqg6p16atvJw3VnkNct8q18kjtcfSbQyS6rnbeRuj4pYOZbjeJ8gt8OjI4yTP
         zsR8V9+1Zhwsq1XRs7IP6YP8rc/cNVSn3WQmTclD+G2ONve3CQHGw9BTcuqtT1BJ377Z
         a39g==
X-Gm-Message-State: APjAAAXLUjwnnef/g/IzR0Dw3QXAXfmap0iv39bsQRxJEN5AeatUoNQn
        2WaVxLMjAckF7rMp462u/jS4Mg==
X-Google-Smtp-Source: APXvYqxiPIBhEf/fH9AINTqGlq4fhQUjIqLjLUbTkeOso1O3fn72FXumyfLLpSaLFn+WiH3fAbm12Q==
X-Received: by 2002:a17:90a:350c:: with SMTP id q12mr29094pjb.46.1561484458044;
        Tue, 25 Jun 2019 10:40:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 85sm20872129pfv.130.2019.06.25.10.40.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 10:40:57 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/2] mwifiex: dispatch/rotate from reorder table atomically
Date:   Tue, 25 Jun 2019 10:40:44 -0700
Message-Id: <20190625174045.125223-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190625174045.125223-1-briannorris@chromium.org>
References: <20190625174045.125223-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mwifiex_11n_scan_and_dispatch() and
mwifiex_11n_dispatch_pkt_until_start_win() share similar patterns, where
they perform a few different actions on the same table, using the same
lock, but non-atomically. There have been other attempts to clean up
this sort of behavior, but they have had problems (incomplete;
introducing new deadlocks).

We can improve these functions' atomicity by queueing up our RX packets
in a list, to dispatch at the end of the function. This avoids problems
of another operation modifying the table in between our dispatch and
rotation operations.

This was inspired by investigations around this:

  http://lkml.kernel.org/linux-wireless/20181130175957.167031-1-briannorris@chromium.org
  Subject: [4.20 PATCH] Revert "mwifiex: restructure rx_reorder_tbl_lock usage"

While the original (now-reverted) patch had good intentions in
restructuring some of the locking patterns in this driver, it missed an
important detail: we cannot defer to softirq contexts while already in
an atomic context. We can help avoid this sort of problem by separating
the two steps of:
(1) iterating / clearing the mwifiex reordering table
(2) dispatching received packets to upper layers

This makes it much harder to make lock recursion mistakes, as these
two steps no longer need to hold the same locks.

Testing: I've played with a variety of stress tests, including download
stress tests on the same APs which caught regressions with commit
5188d5453bc9 ("mwifiex: restructure rx_reorder_tbl_lock usage"). I've
primarily tested on Marvell 8997 / PCIe, although I've given 8897 / SDIO
a quick spin as well.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Ganapathi Bhat <gbhat@marvell.com>
---
v2: no change
---
 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 5380fba652cc..77bdf16d6573 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -76,7 +76,8 @@ static int mwifiex_11n_dispatch_amsdu_pkt(struct mwifiex_private *priv,
 /* This function will process the rx packet and forward it to kernel/upper
  * layer.
  */
-static int mwifiex_11n_dispatch_pkt(struct mwifiex_private *priv, void *payload)
+static int mwifiex_11n_dispatch_pkt(struct mwifiex_private *priv,
+				    struct sk_buff *payload)
 {
 
 	int ret;
@@ -109,27 +110,26 @@ mwifiex_11n_dispatch_pkt_until_start_win(struct mwifiex_private *priv,
 					 struct mwifiex_rx_reorder_tbl *tbl,
 					 int start_win)
 {
+	struct sk_buff_head list;
+	struct sk_buff *skb;
 	int pkt_to_send, i;
-	void *rx_tmp_ptr;
 	unsigned long flags;
 
+	__skb_queue_head_init(&list);
+	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+
 	pkt_to_send = (start_win > tbl->start_win) ?
 		      min((start_win - tbl->start_win), tbl->win_size) :
 		      tbl->win_size;
 
 	for (i = 0; i < pkt_to_send; ++i) {
-		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
-		rx_tmp_ptr = NULL;
 		if (tbl->rx_reorder_ptr[i]) {
-			rx_tmp_ptr = tbl->rx_reorder_ptr[i];
+			skb = tbl->rx_reorder_ptr[i];
+			__skb_queue_tail(&list, skb);
 			tbl->rx_reorder_ptr[i] = NULL;
 		}
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
-		if (rx_tmp_ptr)
-			mwifiex_11n_dispatch_pkt(priv, rx_tmp_ptr);
 	}
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	/*
 	 * We don't have a circular buffer, hence use rotation to simulate
 	 * circular buffer
@@ -141,6 +141,9 @@ mwifiex_11n_dispatch_pkt_until_start_win(struct mwifiex_private *priv,
 
 	tbl->start_win = start_win;
 	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+
+	while ((skb = __skb_dequeue(&list)))
+		mwifiex_11n_dispatch_pkt(priv, skb);
 }
 
 /*
@@ -155,24 +158,22 @@ static void
 mwifiex_11n_scan_and_dispatch(struct mwifiex_private *priv,
 			      struct mwifiex_rx_reorder_tbl *tbl)
 {
+	struct sk_buff_head list;
+	struct sk_buff *skb;
 	int i, j, xchg;
-	void *rx_tmp_ptr;
 	unsigned long flags;
 
+	__skb_queue_head_init(&list);
+	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
+
 	for (i = 0; i < tbl->win_size; ++i) {
-		spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
-		if (!tbl->rx_reorder_ptr[i]) {
-			spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock,
-					       flags);
+		if (!tbl->rx_reorder_ptr[i])
 			break;
-		}
-		rx_tmp_ptr = tbl->rx_reorder_ptr[i];
+		skb = tbl->rx_reorder_ptr[i];
+		__skb_queue_tail(&list, skb);
 		tbl->rx_reorder_ptr[i] = NULL;
-		spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
-		mwifiex_11n_dispatch_pkt(priv, rx_tmp_ptr);
 	}
 
-	spin_lock_irqsave(&priv->rx_reorder_tbl_lock, flags);
 	/*
 	 * We don't have a circular buffer, hence use rotation to simulate
 	 * circular buffer
@@ -185,7 +186,11 @@ mwifiex_11n_scan_and_dispatch(struct mwifiex_private *priv,
 		}
 	}
 	tbl->start_win = (tbl->start_win + i) & (MAX_TID_VALUE - 1);
+
 	spin_unlock_irqrestore(&priv->rx_reorder_tbl_lock, flags);
+
+	while ((skb = __skb_dequeue(&list)))
+		mwifiex_11n_dispatch_pkt(priv, skb);
 }
 
 /*
-- 
2.22.0.410.gd8fdbe21b5-goog

