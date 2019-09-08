Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F597ACBA1
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfIHIjU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:39:20 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:7549 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfIHIjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:39:16 -0400
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 08 Sep 2019 10:33:04 +0200
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg03-ams.qualcomm.com with ESMTP; 08 Sep 2019 10:33:01 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 05/11] wil6210: make sure DR bit is read before rest of the status message
Date:   Sun,  8 Sep 2019 11:32:49 +0300
Message-Id: <1567931575-27984-6-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dedy Lansky <dlansky@codeaurora.org>

Due to compiler optimization, it's possible that dr_bit (descriptor
ready) is read last from the status message.
Due to race condition between HW writing the status message and
driver reading it, other fields that were read earlier (before dr_bit)
could have invalid values.

Fix this by explicitly reading the dr_bit first and then using rmb
before reading the rest of the status message.

Signed-off-by: Dedy Lansky <dlansky@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 30 +++++++++++++++++-----------
 drivers/net/wireless/ath/wil6210/txrx_edma.h |  6 ------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index f313041..f21b2fa 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -221,10 +221,17 @@ static int wil_ring_alloc_skb_edma(struct wil6210_priv *wil,
 }
 
 static inline
-void wil_get_next_rx_status_msg(struct wil_status_ring *sring, void *msg)
+void wil_get_next_rx_status_msg(struct wil_status_ring *sring, u8 *dr_bit,
+				void *msg)
 {
-	memcpy(msg, (void *)(sring->va + (sring->elem_size * sring->swhead)),
-	       sring->elem_size);
+	struct wil_rx_status_compressed *_msg;
+
+	_msg = (struct wil_rx_status_compressed *)
+		(sring->va + (sring->elem_size * sring->swhead));
+	*dr_bit = WIL_GET_BITS(_msg->d0, 31, 31);
+	/* make sure dr_bit is read before the rest of status msg */
+	rmb();
+	memcpy(msg, (void *)_msg, sring->elem_size);
 }
 
 static inline void wil_sring_advance_swhead(struct wil_status_ring *sring)
@@ -587,8 +594,7 @@ static bool wil_is_rx_idle_edma(struct wil6210_priv *wil)
 		if (!sring->va)
 			continue;
 
-		wil_get_next_rx_status_msg(sring, msg);
-		dr_bit = wil_rx_status_get_desc_rdy_bit(msg);
+		wil_get_next_rx_status_msg(sring, &dr_bit, msg);
 
 		/* Check if there are unhandled RX status messages */
 		if (dr_bit == sring->desc_rdy_pol)
@@ -878,8 +884,7 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
 	BUILD_BUG_ON(sizeof(struct wil_rx_status_extended) > sizeof(skb->cb));
 
 again:
-	wil_get_next_rx_status_msg(sring, msg);
-	dr_bit = wil_rx_status_get_desc_rdy_bit(msg);
+	wil_get_next_rx_status_msg(sring, &dr_bit, msg);
 
 	/* Completed handling all the ready status messages */
 	if (dr_bit != sring->desc_rdy_pol)
@@ -1135,12 +1140,15 @@ static int wil_tx_desc_map_edma(union wil_tx_desc *desc,
 }
 
 static inline void
-wil_get_next_tx_status_msg(struct wil_status_ring *sring,
+wil_get_next_tx_status_msg(struct wil_status_ring *sring, u8 *dr_bit,
 			   struct wil_ring_tx_status *msg)
 {
 	struct wil_ring_tx_status *_msg = (struct wil_ring_tx_status *)
 		(sring->va + (sring->elem_size * sring->swhead));
 
+	*dr_bit = _msg->desc_ready >> TX_STATUS_DESC_READY_POS;
+	/* make sure dr_bit is read before the rest of status msg */
+	rmb();
 	*msg = *_msg;
 }
 
@@ -1169,8 +1177,7 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 	int used_before_complete;
 	int used_new;
 
-	wil_get_next_tx_status_msg(sring, &msg);
-	dr_bit = msg.desc_ready >> TX_STATUS_DESC_READY_POS;
+	wil_get_next_tx_status_msg(sring, &dr_bit, &msg);
 
 	/* Process completion messages while DR bit has the expected polarity */
 	while (dr_bit == sring->desc_rdy_pol) {
@@ -1293,8 +1300,7 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 
 		wil_sring_advance_swhead(sring);
 
-		wil_get_next_tx_status_msg(sring, &msg);
-		dr_bit = msg.desc_ready >> TX_STATUS_DESC_READY_POS;
+		wil_get_next_tx_status_msg(sring, &dr_bit, &msg);
 	}
 
 	/* shall we wake net queues? */
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.h b/drivers/net/wireless/ath/wil6210/txrx_edma.h
index 724d223..136c51c 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.h
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.h
@@ -421,12 +421,6 @@ static inline u8 wil_rx_status_get_tid(void *msg)
 		return val & WIL_RX_EDMA_DLPF_LU_MISS_CID_TID_MASK;
 }
 
-static inline int wil_rx_status_get_desc_rdy_bit(void *msg)
-{
-	return WIL_GET_BITS(((struct wil_rx_status_compressed *)msg)->d0,
-			    31, 31);
-}
-
 static inline int wil_rx_status_get_eop(void *msg) /* EoP = End of Packet */
 {
 	return WIL_GET_BITS(((struct wil_rx_status_compressed *)msg)->d0,
-- 
1.9.1

