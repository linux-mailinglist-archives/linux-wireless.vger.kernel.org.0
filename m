Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD944EA9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 23:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFMVna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 17:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVn3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 17:43:29 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E7482173C;
        Thu, 13 Jun 2019 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560462208;
        bh=mzeZgKnTOCsgbQV6nL4NoSLUHHgMat7u7IleyNMFfMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpyHxHx0vwDe9nMsbXxtC8GYkkyOL6W2yqS4cR4u6JJvXN2m10Cn9+s4p1VWd6hlY
         7cLXeTQn8f/1zuLFYYEo4DNdAk0N1tvDZ8+Ilk/W+ijIeCv2Xwgo/og8WBsEE65XoA
         qylS2Y+d78wGq61bzyXBQm+yhODkWOBUasdRV+TQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH v3 wireless-drivers 2/3] mt76: mt76u: introduce mt76u_ep data structure
Date:   Thu, 13 Jun 2019 23:43:12 +0200
Message-Id: <3bdefc9a473fa07c070be5e396435c9d0e02c5e8.1560461404.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560461404.git.lorenzo@kernel.org>
References: <cover.1560461404.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_ep data structure as a container for usb endpoint info.
This is a preliminary patch to compute proper usb buffer size and avoid
always copy the first part of received frames

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 16 ++++++++++------
 drivers/net/wireless/mediatek/mt76/usb.c  | 15 +++++++++------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 889b76deb703..1c51d6d48e60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -382,6 +382,11 @@ enum mt76u_out_ep {
 	__MT_EP_OUT_MAX,
 };
 
+struct mt76u_ep {
+	u16 max_packet;
+	u8 ep;
+};
+
 #define MT_SG_MAX_SIZE		8
 #define MT_NUM_TX_ENTRIES	256
 #define MT_NUM_RX_ENTRIES	128
@@ -393,10 +398,8 @@ struct mt76_usb {
 	struct tasklet_struct rx_tasklet;
 	struct delayed_work stat_work;
 
-	u8 out_ep[__MT_EP_OUT_MAX];
-	u16 out_max_packet;
-	u8 in_ep[__MT_EP_IN_MAX];
-	u16 in_max_packet;
+	struct mt76u_ep out_ep[__MT_EP_OUT_MAX];
+	struct mt76u_ep in_ep[__MT_EP_IN_MAX];
 	bool sg_en;
 
 	struct mt76u_mcu {
@@ -786,9 +789,10 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	unsigned int pipe;
 
 	if (actual_len)
-		pipe = usb_rcvbulkpipe(udev, usb->in_ep[MT_EP_IN_CMD_RESP]);
+		pipe = usb_rcvbulkpipe(udev, usb->in_ep[MT_EP_IN_CMD_RESP].ep);
 	else
-		pipe = usb_sndbulkpipe(udev, usb->out_ep[MT_EP_OUT_INBAND_CMD]);
+		pipe = usb_sndbulkpipe(udev,
+				       usb->out_ep[MT_EP_OUT_INBAND_CMD].ep);
 
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 12d60d31cb51..1ee54a9b302e 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -260,19 +260,22 @@ mt76u_set_endpoints(struct usb_interface *intf,
 	struct usb_host_interface *intf_desc = intf->cur_altsetting;
 	struct usb_endpoint_descriptor *ep_desc;
 	int i, in_ep = 0, out_ep = 0;
+	struct mt76u_ep *ep;
 
 	for (i = 0; i < intf_desc->desc.bNumEndpoints; i++) {
 		ep_desc = &intf_desc->endpoint[i].desc;
 
 		if (usb_endpoint_is_bulk_in(ep_desc) &&
 		    in_ep < __MT_EP_IN_MAX) {
-			usb->in_ep[in_ep] = usb_endpoint_num(ep_desc);
-			usb->in_max_packet = usb_endpoint_maxp(ep_desc);
+			ep = &usb->in_ep[in_ep];
+			ep->max_packet = usb_endpoint_maxp(ep_desc);
+			ep->ep = usb_endpoint_num(ep_desc);
 			in_ep++;
 		} else if (usb_endpoint_is_bulk_out(ep_desc) &&
 			   out_ep < __MT_EP_OUT_MAX) {
-			usb->out_ep[out_ep] = usb_endpoint_num(ep_desc);
-			usb->out_max_packet = usb_endpoint_maxp(ep_desc);
+			ep = &usb->out_ep[out_ep];
+			ep->max_packet = usb_endpoint_maxp(ep_desc);
+			ep->ep = usb_endpoint_num(ep_desc);
 			out_ep++;
 		}
 	}
@@ -386,9 +389,9 @@ mt76u_fill_bulk_urb(struct mt76_dev *dev, int dir, int index,
 	unsigned int pipe;
 
 	if (dir == USB_DIR_IN)
-		pipe = usb_rcvbulkpipe(udev, dev->usb.in_ep[index]);
+		pipe = usb_rcvbulkpipe(udev, dev->usb.in_ep[index].ep);
 	else
-		pipe = usb_sndbulkpipe(udev, dev->usb.out_ep[index]);
+		pipe = usb_sndbulkpipe(udev, dev->usb.out_ep[index].ep);
 
 	urb->dev = udev;
 	urb->pipe = pipe;
-- 
2.21.0

