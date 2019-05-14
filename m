Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1477F1C869
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENMVI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 08:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENMVI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 08:21:08 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6612B208CA;
        Tue, 14 May 2019 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557836467;
        bh=FIskaekUMUAgKGVB8rG8kIBE3kmMFUJUiXEPt7jwyn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRKiJh24m4cEiAjBKegDb3IWIgubpz+/dG/BPA/nao6TQVtyG2DUN4De3bueSyWdy
         Ib6pnwcJ5LYrdW5mfQ+Uuf0lIwz0p+/md8XzUaBUPk0Q7vRcks3feLlVtT3WUvnZkC
         n7oeCgMmfIETnWu4OP10q5RJKZ56fcoXbpZS1G2g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: stop mcu first in mt7615_unregister_device
Date:   Tue, 14 May 2019 14:20:45 +0200
Message-Id: <e145d9f42b1cfcf525300d583c99773132381c34.1557836235.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557836235.git.lorenzo@kernel.org>
References: <cover.1557836235.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stop mcu engine and then dma one in mt7615_unregister_device
in order to avoid a mcu hang in mt7615_unregister_device

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch ca be squashed with 'mt76: mt7615: rearrange cleanup operations in
mt7615_unregister_device' since it is not upstream yet
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 59f604f3161f..369b9a8e07be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -213,8 +213,8 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 	int id;
 
 	mt76_unregister_device(&dev->mt76);
-	mt7615_dma_cleanup(dev);
 	mt7615_mcu_exit(dev);
+	mt7615_dma_cleanup(dev);
 
 	spin_lock_bh(&dev->token_lock);
 	idr_for_each_entry(&dev->token, txwi, id) {
-- 
2.20.1

