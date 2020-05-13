Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7130E1D1679
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbgEMNxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 09:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgEMNxI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 09:53:08 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414552054F;
        Wed, 13 May 2020 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589377988;
        bh=bZ0LxAT9+DpaEBdHxvWgLx0zVngOV7bl4fINJ+QWK4c=;
        h=From:To:Cc:Subject:Date:From;
        b=sjZ1IQHnMGv+siG3Gu0ff4zC3X7QUGuf/Y8lcHLKMZhAEwOmxoBWQPFPn7jQwkVn6
         mU4kYZ7x+0uLTGzldu33qomY0s7pyeSj946MCO6XBs4kaUhuxBzBnGTYNP96tOeMrH
         HX1M5mKAe0IhCiTdTgSMZBcA5zpKsqh1lX0PeMAo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7615: fix typo defining ps work
Date:   Wed, 13 May 2020 15:53:04 +0200
Message-Id: <d4cae59bd7b65905d7d2fd4a2d9a78240c1bebf9.1589377803.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix typo defining ps_work in mt7615_register_ext_phy(). This is not a
real issue since 802.11 power save is not yet support by the external phy

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index b5bbe9f5f7dd..1d8fdc7e062b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -372,7 +372,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
 	skb_queue_head_init(&phy->scan_event_list);
 
-	INIT_WORK(&dev->phy.ps_work, mt7615_ps_work);
+	INIT_WORK(&phy->ps_work, mt7615_ps_work);
 
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
-- 
2.26.2

