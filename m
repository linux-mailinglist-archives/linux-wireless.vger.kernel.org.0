Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5540B3CE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 17:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhINP4u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 11:56:50 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:25562 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhINP4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 11:56:50 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2021 11:56:50 EDT
X-UUID: a13246075cc945eb9b68afac2e006ecd-20210914
X-UUID: a13246075cc945eb9b68afac2e006ecd-20210914
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 320159456; Tue, 14 Sep 2021 08:50:28 -0700
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 08:50:26 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 23:50:25 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] mt76: mt7921: fix retrying release semaphore without end
Date:   Tue, 14 Sep 2021 23:50:22 +0800
Message-ID: <b3b18e00b76699342af5f8a841221022a66a2f4c.1631633959.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <b3d4a17bdbb819424a6493f14b9cd3d7a6bbc588.1631633959.git.objelf@gmail.com>
References: <b3d4a17bdbb819424a6493f14b9cd3d7a6bbc588.1631633959.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

We should pass the error code to the caller immediately
to avoid the possible infinite retry to release the semaphore.

Fixes: 1c099ab44727 ("mt76: mt7921: add MCU support")
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 9b35b5da3619..db33506567dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -876,7 +876,7 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 	default:
 		ret = -EAGAIN;
 		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
-		goto out;
+		break;
 	}
 	release_firmware(fw);
 
-- 
2.25.1

