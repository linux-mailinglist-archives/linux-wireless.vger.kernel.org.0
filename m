Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281C36D1FC0
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCaMLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 08:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjCaMLO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 08:11:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D91C1F3
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 05:11:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1piDaw-0007FB-28; Fri, 31 Mar 2023 14:11:02 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1piDas-007zAD-5q; Fri, 31 Mar 2023 14:10:58 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1piDar-001AIe-HS; Fri, 31 Mar 2023 14:10:57 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Pkshih <pkshih@realtek.com>, Tim K <tpkuester@gmail.com>,
        "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>, kernel@pengutronix.de,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] wifi: rtw88: usb: fix priority queue to endpoint mapping
Date:   Fri, 31 Mar 2023 14:10:53 +0200
Message-Id: <20230331121054.112758-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331121054.112758-1-s.hauer@pengutronix.de>
References: <20230331121054.112758-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The RTW88 chipsets have four different priority queues in hardware. For
the USB type chipsets the packets destined for a specific priority queue
must be sent through the endpoint corresponding to the queue. This was
not fully understood when porting from the RTW88 USB out of tree driver
and thus violated.

This patch implements the qsel to endpoint mapping as in
get_usb_bulkout_id_88xx() in the downstream driver.

Without this the driver often issues "timed out to flush queue 3"
warnings and often TX stalls completely.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 70 ++++++++++++++++--------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 2a8336b1847a5..a10d6fef4ffaf 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -118,6 +118,22 @@ static void rtw_usb_write32(struct rtw_dev *rtwdev, u32 addr, u32 val)
 	rtw_usb_write(rtwdev, addr, val, 4);
 }
 
+static int dma_mapping_to_ep(enum rtw_dma_mapping dma_mapping)
+{
+	switch (dma_mapping) {
+	case RTW_DMA_MAPPING_HIGH:
+		return 0;
+	case RTW_DMA_MAPPING_NORMAL:
+		return 1;
+	case RTW_DMA_MAPPING_LOW:
+		return 2;
+	case RTW_DMA_MAPPING_EXTRA:
+		return 3;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int rtw_usb_parse(struct rtw_dev *rtwdev,
 			 struct usb_interface *interface)
 {
@@ -129,6 +145,8 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
 	int num_out_pipes = 0;
 	int i;
 	u8 num;
+	const struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_rqpn *rqpn;
 
 	for (i = 0; i < interface_desc->bNumEndpoints; i++) {
 		endpoint = &host_interface->endpoint[i].desc;
@@ -183,31 +201,34 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
 
 	rtwdev->hci.bulkout_num = num_out_pipes;
 
-	switch (num_out_pipes) {
-	case 4:
-	case 3:
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID0] = 2;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID1] = 2;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID2] = 2;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID3] = 2;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID4] = 1;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID5] = 1;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID6] = 0;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID7] = 0;
-		break;
-	case 2:
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID0] = 1;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID1] = 1;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID2] = 1;
-		rtwusb->qsel_to_ep[TX_DESC_QSEL_TID3] = 1;
-		break;
-	case 1:
-		break;
-	default:
-		rtw_err(rtwdev, "failed to get out_pipes(%d)\n", num_out_pipes);
+	if (num_out_pipes < 1 || num_out_pipes > 4) {
+		rtw_err(rtwdev, "invalid number of endpoints %d\n", num_out_pipes);
 		return -EINVAL;
 	}
 
+	rqpn = &chip->rqpn_table[num_out_pipes];
+
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID0] = dma_mapping_to_ep(rqpn->dma_map_be);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID1] = dma_mapping_to_ep(rqpn->dma_map_bk);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID2] = dma_mapping_to_ep(rqpn->dma_map_bk);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID3] = dma_mapping_to_ep(rqpn->dma_map_be);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID4] = dma_mapping_to_ep(rqpn->dma_map_vi);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID5] = dma_mapping_to_ep(rqpn->dma_map_vi);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID6] = dma_mapping_to_ep(rqpn->dma_map_vo);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID7] = dma_mapping_to_ep(rqpn->dma_map_vo);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID8] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID9] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID10] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID11] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID12] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID13] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID14] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_TID15] = -EINVAL;
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_BEACON] = dma_mapping_to_ep(rqpn->dma_map_hi);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_HIGH] = dma_mapping_to_ep(rqpn->dma_map_hi);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_MGMT] = dma_mapping_to_ep(rqpn->dma_map_mg);
+	rtwusb->qsel_to_ep[TX_DESC_QSEL_H2C] = dma_mapping_to_ep(rqpn->dma_map_hi);
+
 	return 0;
 }
 
@@ -250,7 +271,7 @@ static void rtw_usb_write_port_tx_complete(struct urb *urb)
 static int qsel_to_ep(struct rtw_usb *rtwusb, unsigned int qsel)
 {
 	if (qsel >= ARRAY_SIZE(rtwusb->qsel_to_ep))
-		return 0;
+		return -EINVAL;
 
 	return rtwusb->qsel_to_ep[qsel];
 }
@@ -265,6 +286,9 @@ static int rtw_usb_write_port(struct rtw_dev *rtwdev, u8 qsel, struct sk_buff *s
 	int ret;
 	int ep = qsel_to_ep(rtwusb, qsel);
 
+	if (ep < 0)
+		return ep;
+
 	pipe = usb_sndbulkpipe(usbd, rtwusb->out_ep[ep]);
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
-- 
2.39.2

