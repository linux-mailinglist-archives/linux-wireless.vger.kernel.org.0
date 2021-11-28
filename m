Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53915460527
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Nov 2021 08:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356105AbhK1HtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 02:49:23 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:46080 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233974AbhK1HrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 02:47:23 -0500
X-UUID: a9a49d129a35481d992045401b9145db-20211128
X-UUID: a9a49d129a35481d992045401b9145db-20211128
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1194869968; Sun, 28 Nov 2021 15:44:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 28 Nov 2021 15:44:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 28 Nov 2021 15:44:00 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921s: fix bus hang with wrong privilege
Date:   Sun, 28 Nov 2021 15:43:59 +0800
Message-ID: <430016f5be77f69b047271081ed891f164bfe65d.1638081217.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Accroding to chip hw flow, mt7921s need to re-acquire privilege
again before normal running. Otherwise, the bus may be stuck in
an abnormal status.

Tested-by: Leon Yen <Leon.Yen@mediatek.com>
Co-developed-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
Signed-off-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 6ada1ebe7d68..1227d626e9d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -720,6 +720,17 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 	if (ret)
 		dev_err(dev->mt76.dev, "Failed to start patch\n");
 
+	if (mt76_is_sdio(&dev->mt76)) {
+		/* activate again */
+		ret = __mt7921_mcu_fw_pmctrl(dev);
+		if (ret)
+			return ret;
+
+		ret = __mt7921_mcu_drv_pmctrl(dev);
+		if (ret)
+			return ret;
+	}
+
 out:
 	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
 	switch (sem) {
-- 
2.18.0

