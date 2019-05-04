Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0913AF8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfEDP3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfEDP3y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:54 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261C620644;
        Sat,  4 May 2019 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983793;
        bh=6/pYSvQ0thXSJ5sUH9SMuLvoWb/OPHmd+1383Iw2o+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIZaqBQ9MBDgDyA8vQ2MwSEh/q2q9QevX+r4DFmxpfkHEPtR4MRaDkAgEvjK4aa8m
         I9+H5JmqC9Co7u1lfGHzTdHQBMtispkJJapnGBA52/KW+3o9hQKkJX/+SAHHV9hHPS
         IO07AZbmX1XU/6S4iVT35mOs/q30FOEJf/TfqN5c=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 16/17] mt7615: mcu: init mcu_restart function pointer
Date:   Sat,  4 May 2019 17:29:08 +0200
Message-Id: <f7c625bc2a715b481886b6eb5b5c79c932896f2f.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
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
index 775421fddb7c..4fa41e2c5f77 100644
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

