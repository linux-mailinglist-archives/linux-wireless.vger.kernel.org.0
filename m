Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E7317D6AA
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgCHWJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgCHWJY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:24 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F532084E;
        Sun,  8 Mar 2020 22:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705363;
        bh=Z22bYmB4OgZQeqQpkhAWkDzAwKwKzBS8sdY0H6l4Bck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsGTKTPXy2pw+57KBnXe2HKzuiN0e7iHiNSDxOdQq1p8S+Q5HE/e8AQ0wRsGRvdSF
         NhbMmk/Fw7WEOyrskEpNpE/+SneflW+LjZ7ttIyOnrgbck+sEGwvKd1EhRAyeUhOkV
         fPt5BtfsIowOpBBLLKwYNwVedvaNa+Z8GJDmBVJs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 10/25] mt76: mt7615: rely on skb API for mt7615_mcu_set_eeprom
Date:   Sun,  8 Mar 2020 23:08:22 +0100
Message-Id: <5ed0f43f510d7d8e5e2e70f180b4b21269df8555.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on skb API and avoid kmalloc the buffer in mt7615_mcu_set_eeprom
routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2ad8173f95ef..73ec31b20d21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1262,28 +1262,26 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	} __packed req_hdr = {
 		.buffer_mode = 1,
 	};
-	int ret, len, eep_len;
-	u8 *req, *eep = (u8 *)dev->mt76.eeprom.data;
+	u8 *eep = (u8 *)dev->mt76.eeprom.data;
+	struct sk_buff *skb;
+	int eep_len;
 
 	if (is_mt7622(&dev->mt76))
 		eep_len = MT7622_EE_MAX - MT_EE_NIC_CONF_0;
 	else
 		eep_len = MT7615_EE_MAX - MT_EE_NIC_CONF_0;
 
-	len = sizeof(req_hdr) + eep_len;
-	req = kzalloc(len, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
 	req_hdr.len = cpu_to_le16(eep_len);
-	memcpy(req, &req_hdr, sizeof(req_hdr));
-	memcpy(req + sizeof(req_hdr), eep + MT_EE_NIC_CONF_0, eep_len);
 
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
-				  req, len, true);
-	kfree(req);
+	skb = mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) + eep_len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+	skb_put_data(skb, eep + MT_EE_NIC_CONF_0, eep_len);
 
-	return ret;
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
 }
 
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable)
-- 
2.24.1

