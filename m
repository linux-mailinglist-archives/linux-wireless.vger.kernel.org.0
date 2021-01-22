Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C883000A3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 11:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbhAVKsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 05:48:40 -0500
Received: from mx3.wp.pl ([212.77.101.9]:9304 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbhAVKol (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 05:44:41 -0500
Received: (wp-smtpd smtp.wp.pl 3191 invoked from network); 22 Jan 2021 11:43:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1611312223; bh=Hniz8g8ytC6LDKB/ulg7Znii0SXHdowB53vEx5IW4c8=;
          h=From:To:Cc:Subject;
          b=SdsyyA9O0woks4n/004WWGFaa+JvQTqaeetVNUXINLVyBxg7nvKiUnObVDlL/Ym4y
           GN7lSrYq/hiriFfEuAnnL1lSLqU5dui/pAomLwdlEmQTGeZtf0JWO/+dAeIFJNd6wB
           Rz3KsU91PYBZf+wgOtRu/VEgQlkm8qP8fzaCBgZI=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-usb@vger.kernel.org>; 22 Jan 2021 11:43:43 +0100
From:   stf_xl@wp.pl
To:     linux-usb@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
Subject: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
Date:   Fri, 22 Jan 2021 11:43:42 +0100
Message-Id: <20210122104342.12451-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3064d5032e842dfcedc2651dbe6c1ee4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AXPk]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stanislaw Gruszka <stf_xl@wp.pl>

Since f8f80be501aa ("xhci: Use soft retry to recover faster from transaction
errors") on some systems rt2800usb devices are unable to operate. Looks
that due to firmware or hardware limitations of those devices, they
require full recovery from USB Transaction Errors.

To avoid the problem add URB transfer flag, that restore pre f8f80be501aa
xhci behaviour when the flag is set. For now only add it only to rt2800usb
driver.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202541
Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
Reported-and-tested-by: Bernhard <bernhard.gebetsberger@gmx.at>
Bisected-by: Bernhard <bernhard.gebetsberger@gmx.at>
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 3 +++
 drivers/usb/core/urb.c                         | 2 +-
 drivers/usb/host/xhci-ring.c                   | 3 ++-
 include/linux/usb.h                            | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index e4473a551241..f1d82b3e6bba 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -214,6 +214,7 @@ void rt2x00usb_register_read_async(struct rt2x00_dev *rt2x00dev,
 	usb_fill_control_urb(urb, usb_dev, usb_rcvctrlpipe(usb_dev, 0),
 			     (unsigned char *)(&rd->cr), &rd->reg, sizeof(rd->reg),
 			     rt2x00usb_register_read_async_cb, rd);
+	urb->transfer_flags |= URB_SOFT_RETRY_NOT_OK;
 	usb_anchor_urb(urb, rt2x00dev->anchor);
 	if (usb_submit_urb(urb, GFP_ATOMIC) < 0) {
 		usb_unanchor_urb(urb);
@@ -323,6 +324,7 @@ static bool rt2x00usb_kick_tx_entry(struct queue_entry *entry, void *data)
 			  usb_sndbulkpipe(usb_dev, entry->queue->usb_endpoint),
 			  entry->skb->data, length,
 			  rt2x00usb_interrupt_txdone, entry);
+	entry_priv->urb->transfer_flags |= URB_SOFT_RETRY_NOT_OK;
 
 	status = usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
 	if (status) {
@@ -409,6 +411,7 @@ static bool rt2x00usb_kick_rx_entry(struct queue_entry *entry, void *data)
 			  usb_rcvbulkpipe(usb_dev, entry->queue->usb_endpoint),
 			  entry->skb->data, entry->skb->len,
 			  rt2x00usb_interrupt_rxdone, entry);
+	entry_priv->urb->transfer_flags |= URB_SOFT_RETRY_NOT_OK;
 
 	status = usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
 	if (status) {
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 357b149b20d3..140bac59dc32 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -495,7 +495,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 	/* Check against a simple/standard policy */
 	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |
-			URB_FREE_BUFFER);
+		   URB_SOFT_RETRY_NOT_OK | URB_FREE_BUFFER);
 	switch (xfertype) {
 	case USB_ENDPOINT_XFER_BULK:
 	case USB_ENDPOINT_XFER_INT:
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5677b81c0915..6712e1a7735c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2302,7 +2302,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
 		remaining	= 0;
 		break;
 	case COMP_USB_TRANSACTION_ERROR:
-		if ((ep_ring->err_count++ > MAX_SOFT_RETRY) ||
+		if (td->urb->transfer_flags & URB_SOFT_RETRY_NOT_OK ||
+		    (ep_ring->err_count++ > MAX_SOFT_RETRY) ||
 		    le32_to_cpu(slot_ctx->tt_info) & TT_SLOT)
 			break;
 		*status = 0;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7d72c4e0713c..dcdac2f03263 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1329,6 +1329,7 @@ extern int usb_disabled(void);
 #define URB_ISO_ASAP		0x0002	/* iso-only; use the first unexpired
 					 * slot in the schedule */
 #define URB_NO_TRANSFER_DMA_MAP	0x0004	/* urb->transfer_dma valid on submit */
+#define URB_SOFT_RETRY_NOT_OK	0x0008	/* Avoid XHCI Soft Retry */
 #define URB_ZERO_PACKET		0x0040	/* Finish bulk OUT with short packet */
 #define URB_NO_INTERRUPT	0x0080	/* HINT: no non-error interrupt
 					 * needed */
-- 
2.25.4

