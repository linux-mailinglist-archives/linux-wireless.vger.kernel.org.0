Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A980B10ABC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEAQIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfEAQIS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:18 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379E0208C3;
        Wed,  1 May 2019 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726897;
        bh=IaDJLsHVRaIfBEAWZmX76h6uOPR4xbkd0iwmK91DVbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exdbz5rxe2bTF4fpUZfnJVCAjMIbRc8yGSI5BXY848hlcupbYJnG7LdgdPQlcM2jz
         R0SaHvYlt1SLFHxMJY4uX+Yr4KnNmR+JHp9A99+WUiECidFBRL5nJlunsQV3WWaVnm
         l4eK0Yg+BQQAuIOZBzyYLGrVwzyykQ4XLir9UYoI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 16/17] mt7615: mcu: init mcu_restart function pointer
Date:   Wed,  1 May 2019 18:07:38 +0200
Message-Id: <48217ba5e8a8bd5d4869d5f9877e427863298838.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use common function wrapper in mt7615_mcu_exit since the code is shared
with m7603 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d01f1a8bdd57..ec05bd805f42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -217,10 +217,10 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 				   &req, sizeof(req), true);
 }
 
-static int mt7615_mcu_restart(struct mt7615_dev *dev)
+static int mt7615_mcu_restart(struct mt76_dev *dev)
 {
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_RESTART_DL_REQ,
-				   NULL, 0, true);
+	return __mt76_mcu_send_msg(dev, -MCU_CMD_RESTART_DL_REQ, NULL,
+				   0, true);
 }
 
 static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
@@ -483,6 +483,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7615_mcu_ops = {
 		.mcu_send_msg = mt7615_mcu_msg_send,
+		.mcu_restart = mt7615_mcu_restart,
 	};
 	int ret;
 
@@ -503,7 +504,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 
 void mt7615_mcu_exit(struct mt7615_dev *dev)
 {
-	mt7615_mcu_restart(dev);
+	__mt76_mcu_restart(&dev->mt76);
 	mt76_wr(dev, MT_CFG_LPCR_HOST, MT_CFG_LPCR_HOST_FW_OWN);
 	skb_queue_purge(&dev->mt76.mmio.mcu.res_q);
 }
-- 
2.20.1

