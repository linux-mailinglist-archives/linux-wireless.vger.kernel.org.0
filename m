Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1973AFC96
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 17:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfD3PRe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 11:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfD3PRe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 11:17:34 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4056420835;
        Tue, 30 Apr 2019 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556637454;
        bh=Y5djLhtv8ZAsAFHcRjQjfJE+rhBRFhDGrr3rkU+tsqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeB3pHpRlBXyjdCWk9HSVb0j2C45aPcPZpe+vvE9X4I15Zx2il6bb789hZ6iWhuK2
         ZlwxMmcXpU1dJ8VzMxmzQqVxN280rFphJKZEpd9R4xokVWpDqnSJ4EddOcOYqabAzy
         d5l875mrUxq4kCaAnVWrFRGUa8BT/rx7IEsQKDXY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7603: dynamically alloc mcu req in mt7603_mcu_set_eeprom
Date:   Tue, 30 Apr 2019 17:17:23 +0200
Message-Id: <3ab690290daabe3a574f9661c6a613eaacc25f6e.1556637012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556637012.git.lorenzo@kernel.org>
References: <cover.1556637012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not allocate mcu requests on the stack in mt7603_mcu_set_eeprom
in order to avoid the following warning:

Warning: the frame size of 1032 bytes is larger than 1024 bytes
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 766d968671b3..6357b5658a32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -354,24 +354,34 @@ int mt7603_mcu_set_eeprom(struct mt7603_dev *dev)
 		u8 buffer_mode;
 		u8 len;
 		u8 pad[2];
-		struct req_data data[255];
-	} req = {
+	} req_hdr = {
 		.buffer_mode = 1,
 		.len = ARRAY_SIZE(req_fields) - 1,
 	};
-	u8 *eep = (u8 *)dev->mt76.eeprom.data;
-	int i;
+	const int size = 0xff * sizeof(struct req_data);
+	u8 *req, *eep = (u8 *)dev->mt76.eeprom.data;
+	int i, ret, len = sizeof(req_hdr) + size;
+	struct req_data *data;
 
-	BUILD_BUG_ON(ARRAY_SIZE(req_fields) > ARRAY_SIZE(req.data));
+	BUILD_BUG_ON(ARRAY_SIZE(req_fields) * sizeof(*data) > size);
+
+	req = kmalloc(len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
+	memcpy(req, &req_hdr, sizeof(req_hdr));
+	data = (struct req_data *)(req + sizeof(req_hdr));
+	memset(data, 0, size);
 	for (i = 0; i < ARRAY_SIZE(req_fields); i++) {
-		req.data[i].addr = cpu_to_le16(req_fields[i]);
-		req.data[i].val = eep[req_fields[i]];
-		req.data[i].pad = 0;
+		data[i].addr = cpu_to_le16(req_fields[i]);
+		data[i].val = eep[req_fields[i]];
 	}
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
-				   &req, sizeof(req), true);
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+				  req, len, true);
+	kfree(req);
+
+	return ret;
 }
 
 static int mt7603_mcu_set_tx_power(struct mt7603_dev *dev)
-- 
2.20.1

