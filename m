Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5255CC94
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 11:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGBJZF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 05:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBJZE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 05:25:04 -0400
Received: from localhost.localdomain (unknown [151.66.29.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E614B20659;
        Tue,  2 Jul 2019 09:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562059504;
        bh=eaGRDVupL31RiLjYar/kVh1fywu52XByko8NdWVttR8=;
        h=From:To:Cc:Subject:Date:From;
        b=0003GoQISqLPzEVxQJ3L+Istqvjnqykb0LS8ghnqhDsIyWR3R3Dn5waekWdmmb6jG
         TxOAntSKFZ/qXYRl0zNbOwYKGKZusAQycaXx/qNGUhQTaWGogyww7KXh57GzlV7xGA
         Kk+KxJGJRictxuUJrdyUgFUu1IplzMoj2ZsQyZl8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: always release sem in mt7615_load_patch
Date:   Tue,  2 Jul 2019 11:24:51 +0200
Message-Id: <80c710250f7d0ac0a5bfb56723c40d224698f00d.1562059328.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Release patch semaphore even if request_firmware fails in
mt7615_load_patch

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a010c138f52b..0e72cda52343 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -314,9 +314,9 @@ static int mt7615_driver_own(struct mt7615_dev *dev)
 
 static int mt7615_load_patch(struct mt7615_dev *dev)
 {
-	const struct firmware *fw;
-	const struct mt7615_patch_hdr *hdr;
 	const char *firmware = MT7615_ROM_PATCH;
+	const struct mt7615_patch_hdr *hdr;
+	const struct firmware *fw = NULL;
 	int len, ret, sem;
 
 	sem = mt7615_mcu_patch_sem_ctrl(dev, 1);
@@ -332,7 +332,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev)
 
 	ret = request_firmware(&fw, firmware, dev->mt76.dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
 		dev_err(dev->mt76.dev, "Invalid firmware\n");
-- 
2.21.0

