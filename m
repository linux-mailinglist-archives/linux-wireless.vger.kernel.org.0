Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3AE128D5E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLVKdk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:40 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829322070A;
        Sun, 22 Dec 2019 10:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010819;
        bh=bvU7wkQdt4UOB+0Jgsw9qNjgbBWdZM1rw2bd0KnbOZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYUIRCQt0FOknfdgZyzHfBWVQ34rZTNzNHDKrhR9Gz+UmEpbe4vI/ILcsW1fqSHPo
         Xs4NdHvEZd6zvGhuHSUoDGlFAc9zV6zRGy8QsRkZaJkDGoKZh0IyPZEMuyfi7L9aOL
         ohgtU8shtxZ6eO7V3ANmlhWWrXnEiH8X8GjybvUg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 01/18] mt76: mt76u: check tx_status_data pointer in mt76u_tx_tasklet
Date:   Sun, 22 Dec 2019 11:33:03 +0100
Message-Id: <427d8776ae285e16427159dd56c1aeb6a9ce0d3c.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New devices (e.g. mt7663u) do not rely on stats workqueue to load tx
statistics but will be reported by the firmware. Check tx_status_data
pointer in mt76u_tx_tasklet in order to reuse tx tasklet for new devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index e89b38b0445c..5d71a4b2728d 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -708,7 +708,8 @@ static void mt76u_tx_tasklet(unsigned long data)
 
 		mt76_txq_schedule(&dev->phy, i);
 
-		if (!test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+		if (dev->drv->tx_status_data &&
+		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
 			queue_work(dev->usb.stat_wq, &dev->usb.stat_work);
 		if (wake)
 			ieee80211_wake_queue(dev->hw, i);
-- 
2.24.1

