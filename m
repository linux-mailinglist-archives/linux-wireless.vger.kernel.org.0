Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3723710ABD
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEAQIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfEAQIT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:19 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B917621783;
        Wed,  1 May 2019 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726898;
        bh=ZjyVvbyfEtQKS0JqFClzRwfyHu+g+Q9sRNBsiGB22F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvDeUSjRZm3NlzY+d9PXe63ujDPpc7+DwO/VTAhv9waexyevPjcOUH+2jcGcale4F
         oVQ+K3qO6U3LjOgSCx5+gkdOIsm/Fi73tK7djPnaWEBtfzxO34ehVhHtloYJa/PstD
         ycIUyEqx17oS7G/WfjU+ycUeBapiJhgvfav9RRPo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 17/17] mt7615: mcu: run __mt76_mcu_send_msg in mt7615_mcu_send_firmware
Date:   Wed,  1 May 2019 18:07:39 +0200
Message-Id: <cac129d30dd938a65f5e117db378167c4c2518ee.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
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
index ec05bd805f42..6e4c294de2c4 100644
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

