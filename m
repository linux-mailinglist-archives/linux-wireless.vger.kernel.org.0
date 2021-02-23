Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2A322734
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 09:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhBWIoX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 03:44:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40138 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232206AbhBWIoT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 03:44:19 -0500
X-UUID: 864402f6301546c78d1de292aae76298-20210223
X-UUID: 864402f6301546c78d1de292aae76298-20210223
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1063770531; Tue, 23 Feb 2021 16:43:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Feb 2021 16:43:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Feb 2021 16:43:16 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7615: remove hdr->fw_ver check
Date:   Tue, 23 Feb 2021 16:43:12 +0800
Message-ID: <d0ed6b4f2dbac66ac9e31f3725bc4db5cc50f1f3.1614058187.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <61d40a20375f888c122ee0e186168fc2db863fc3.1614058187.git.ryder.lee@mediatek.com>
References: <61d40a20375f888c122ee0e186168fc2db863fc3.1614058187.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only mt7615 uses v1 version. Also, some of released firmware doesn't
have hdr->fw_ver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 393ce09d3956..65c6ab14fe6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1449,8 +1449,7 @@ static int mt7615_load_n9(struct mt7615_dev *dev, const char *name)
 		 sizeof(dev->mt76.hw->wiphy->fw_version),
 		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
 
-	if (!is_mt7615(&dev->mt76) &&
-	    !strncmp(hdr->fw_ver, "2.0", sizeof(hdr->fw_ver))) {
+	if (!is_mt7615(&dev->mt76)) {
 		dev->fw_ver = MT7615_FIRMWARE_V2;
 		dev->mcu_ops = &sta_update_ops;
 	} else {
-- 
2.18.0

