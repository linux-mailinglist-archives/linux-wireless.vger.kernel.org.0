Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6F13AF9
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfEDP34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfEDP3z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:55 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4412086C;
        Sat,  4 May 2019 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983794;
        bh=mo48v3iLxBWZ+hSXLiJXmH0RSKO8pC3YyybL8DbsTKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIBqK90zH70DIpnip8Ekcd+pPFRWZTSWOd53t8IVh4kjmeuAt6GMYg78R/UGg9w/e
         3dV0obgzn3/B+O8Z4YOYJKbBirUM3mmB7zk+FTSJn2lgGGb1j5pPGtaJhoH+lRet7C
         4ZoMBQtAHyIDxNZTomgqY3QySfaN6g0CE+rTLTu0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 17/17] mt7615: mcu: run __mt76_mcu_send_msg in mt7615_mcu_send_firmware
Date:   Sat,  4 May 2019 17:29:09 +0200
Message-Id: <2966df64054c472bd8cf8453af5b2b5236f96adb.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run __mt76_mcu_send_msg instead of __mt7615_mcu_msg_send and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 4fa41e2c5f77..5b01abe7aecf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -179,19 +179,14 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 				    int len)
 {
-	struct sk_buff *skb;
-	int ret = 0;
+	int ret = 0, cur_len;
 
 	while (len > 0) {
-		int cur_len = min_t(int, 4096 - sizeof(struct mt7615_mcu_txd),
-				    len);
-
-		skb = mt7615_mcu_msg_alloc(data, cur_len);
-		if (!skb)
-			return -ENOMEM;
+		cur_len = min_t(int, 4096 - sizeof(struct mt7615_mcu_txd),
+				len);
 
-		ret = __mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_SCATTER,
-					    NULL);
+		ret = __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER,
+					  data, cur_len, false);
 		if (ret)
 			break;
 
-- 
2.20.1

