Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC796B34
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfHTVMA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 17:12:00 -0400
Received: from gesmail.globaledgesoft.com ([182.73.204.242]:55133 "EHLO
        gesmail.globaledgesoft.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728283AbfHTVL7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 17:11:59 -0400
Received: from mail.globaledgesoft.com (mail.globaledgesoft.com [172.16.2.30])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gesmail.globaledgesoft.com (Postfix) with ESMTP id D7B8E7C8865;
        Wed, 21 Aug 2019 02:41:07 +0530 (IST)
Received: from mail.globaledgesoft.com (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTPS id 8B755B8086B;
        Wed, 21 Aug 2019 02:47:36 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTP id 6E102B80855;
        Wed, 21 Aug 2019 02:47:36 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mail.globaledgesoft.com
Received: from mail.globaledgesoft.com ([127.0.0.1])
        by localhost (mail.globaledgesoft.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ecdx_M2iykvc; Wed, 21 Aug 2019 02:47:36 +0530 (IST)
Received: from localhost.localdomain (unknown [172.16.2.250])
        by mail.globaledgesoft.com (Postfix) with ESMTPSA id 425D5B8071C;
        Wed, 21 Aug 2019 02:47:36 +0530 (IST)
From:   Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
To:     lorenzo.bianconi83@gmail.com
Cc:     linux-wireless@vger.kernel.org,
        Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Subject: [PATCH 1/1] [PATCH] Mt76 enabling data pkt transmission.
Date:   Wed, 21 Aug 2019 02:41:38 +0530
Message-Id: <1566335498-10977-1-git-send-email-b.balakrishna@globaledgesoft.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Data Packet transmission was disabled during scanning in mt76 driver.

Fix to be, enabling data packet transmission during scanning.

Note:
Mac80211 will handle channel switching. During scanning, it handles
stopping the data transmission on off channel and enabling data
transmission on operating channel also. It does not require to stop data
transmission in mt76 driver during scanning. Verified with other driver
ath9k and rt2x00 driver, data transmission was not stopped during
scanning

Signed-off-by: Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5397827..376720d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -438,8 +438,7 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb)
 		if (probe)
 			break;
 
-		if (test_bit(MT76_OFFCHANNEL, &dev->state) ||
-		    test_bit(MT76_RESET, &dev->state))
+		if (test_bit(MT76_RESET, &dev->state))
 			return -EBUSY;
 
 		skb = mt76_txq_dequeue(dev, mtxq, false);
-- 
1.9.1

Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.

