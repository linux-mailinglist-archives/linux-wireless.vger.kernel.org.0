Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9B1CC4C0
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 23:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgEIVkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 May 2020 17:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgEIVkU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 May 2020 17:40:20 -0400
Received: from localhost.localdomain (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD852184D;
        Sat,  9 May 2020 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589060420;
        bh=j9g47KUToEDxu1rlAQPmDfHif0zgqOzBlcFKMtbLH8I=;
        h=From:To:Cc:Subject:Date:From;
        b=BU4tJAAobUuV5MbcW9r4zPEFSvg02Jlhe0JYCjSEIpyq6FMNoEay6ae8qdSINCjzw
         x8j2SQBbDw8QF3vi7u1ZOeOkZsZQvI659Bpqg8s69Eis9tQskD3kEUv3KthXj+isH3
         V51Ok5LA1TTOC8RPOQqmunaSZuu89UNrmciTpPtY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: usb: cancel ps work stopping the vif
Date:   Sat,  9 May 2020 23:40:05 +0200
Message-Id: <3b72fb4bba652befa41b879189644053abd458f7.1589060358.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cancel possible power_save work before stopping the mt7663u interface

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 01d60c02512e..d74253319622 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -51,6 +51,7 @@ static void mt7663u_stop(struct ieee80211_hw *hw)
 	struct mt7615_dev *dev = hw->priv;
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
+	cancel_work_sync(&phy->ps_work);
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mac_work);
 	mt76u_stop_tx(&dev->mt76);
-- 
2.26.2

