Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820AD1408C
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2019 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfEEPRI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 May 2019 11:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfEEPRI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 May 2019 11:17:08 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C705208C0;
        Sun,  5 May 2019 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557069427;
        bh=NGhq3lbHAvY4MqEIotn35c7uRMvT5Y+NLTPhUXTmf1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAfxqD6jOZLnpROF1bzESk15jlj/v2Z3411v7I8LKFrv+7ib8yeXPap9UUdNbVG8O
         61y67kagAy/9ah6XTwajeyyWMqshzI5CnwEM2Ah5FXjJCulVs1eLsZR8j7Tc5k+1t9
         648eQ+nn/CCLxCelJmEi2BkInuftC80jdO1FaD2k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: rearrange cleanup operations in mt7615_unregister_device
Date:   Sun,  5 May 2019 17:17:00 +0200
Message-Id: <2523f264daef250a141d8047f5f92a60ac6acc69.1557059004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557059004.git.lorenzo@kernel.org>
References: <cover.1557059004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cleanup tx/rx napi before releasing pending idrs.
Moreover unmap txwi_cache running mt76_free_device routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 3ab3ff553ef2..59f604f3161f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -212,6 +212,10 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 	struct mt76_txwi_cache *txwi;
 	int id;
 
+	mt76_unregister_device(&dev->mt76);
+	mt7615_dma_cleanup(dev);
+	mt7615_mcu_exit(dev);
+
 	spin_lock_bh(&dev->token_lock);
 	idr_for_each_entry(&dev->token, txwi, id) {
 		mt7615_txp_skb_unmap(&dev->mt76, txwi);
@@ -221,9 +225,6 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 	}
 	spin_unlock_bh(&dev->token_lock);
 	idr_destroy(&dev->token);
-	mt76_unregister_device(&dev->mt76);
-	mt7615_mcu_exit(dev);
-	mt7615_dma_cleanup(dev);
 
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(&dev->mt76);
 }
-- 
2.20.1

