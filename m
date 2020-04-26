Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEAC1B90EF
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2020 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDZOm6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Apr 2020 10:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgDZOm6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Apr 2020 10:42:58 -0400
Received: from lore-desk.lan (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D926F2070A;
        Sun, 26 Apr 2020 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587912178;
        bh=NXYM3L+3ZO9mSO7fCqAAA0UGT7d1mpBH/cItSd4rtRQ=;
        h=From:To:Cc:Subject:Date:From;
        b=shxz4H1rYWhSta5+14M/u2jHbPrlKhBK0At09zNV4EEDmXcFuoqPzV16gW+N24NlR
         GpNt0rGQZF06RA8WVkwtNwtuiQLxoB1Qqu3cOfmJXehaE8pQie02pyDnzZsjm7Miwu
         ePZGh4c9JAtmCBx9VTcZQ+KU1OAqOnGCmf2KuML8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7663: remove check in mt7663_load_n9
Date:   Sun, 26 Apr 2020 16:42:52 +0200
Message-Id: <0fe3daeeb4ab8721697bc799fd4a02dca9925b50.1587912071.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of useless check in mt7663_load_n9 since it is used only for
mt7663 devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2e6ffe5afeeb..a438f30778d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2000,7 +2000,7 @@ int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl)
 
 static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 {
-	u32 offset = 0, override_addr = 0, flag = 0;
+	u32 offset = 0, override_addr = 0, flag = FW_START_DLYCAL;
 	const struct mt7663_fw_trailer *hdr;
 	const struct mt7663_fw_buf *buf;
 	const struct firmware *fw;
@@ -2056,14 +2056,11 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 		}
 	}
 
-	if (is_mt7663(&dev->mt76)) {
-		flag |= FW_START_DLYCAL;
-		if (override_addr)
-			flag |= FW_START_OVERRIDE;
+	if (override_addr)
+		flag |= FW_START_OVERRIDE;
 
-		dev_info(dev->mt76.dev, "override_addr = 0x%08x, option = %d\n",
-			 override_addr, flag);
-	}
+	dev_info(dev->mt76.dev, "override_addr = 0x%08x, option = %d\n",
+		 override_addr, flag);
 
 	ret = mt7615_mcu_start_firmware(dev, override_addr, flag);
 	if (ret) {
-- 
2.25.4

