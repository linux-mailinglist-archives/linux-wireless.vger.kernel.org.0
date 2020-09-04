Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1013D25D5C1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Sep 2020 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgIDKPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Sep 2020 06:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDKPr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Sep 2020 06:15:47 -0400
Received: from lore-desk.redhat.com (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099E4206D4;
        Fri,  4 Sep 2020 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599214547;
        bh=HNZrp2eIHtaSEEWfmzi8lYkBtGXRPcZ5Efwx6LBTnEg=;
        h=From:To:Cc:Subject:Date:From;
        b=Lp7auLFl6GCaIBSrKMRVzMtQF2TFpbU2BxD4X3DS5fWhIApMNiaLMgjv6KGYRggVc
         iowz4I8JmBTfl2qZjjz0YZQf1GAXuC2/VOFMpfvG2NNpg8PL1/HRzR/s2NUEZLJRj4
         gSoLIothfOf/bFHK2a5jd29uILTkd7F2vja4F4Qk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH] mt76: mt7622: fix fw hang on mt7622
Date:   Fri,  4 Sep 2020 12:15:42 +0200
Message-Id: <ed18061d7e144c00de689c43b050a954d8a55468.1599214363.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set poll timeout to 3s for mt7622 devices in order to avoid fw hangs.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Fixes: 757b0e7fd6f4 ("mt76: mt7615: avoid polling in fw_own for mt7663")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 074cdefba8aa..77595bc1f1ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -386,7 +386,7 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 
 	if (is_mt7622(&dev->mt76) &&
 	    !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN,
-			    MT_CFG_LPCR_HOST_FW_OWN, 300)) {
+			    MT_CFG_LPCR_HOST_FW_OWN, 3000)) {
 		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
 		clear_bit(MT76_STATE_PM, &mphy->state);
 		err = -EIO;
-- 
2.26.2

