Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9DF389C02
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 05:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhETDsM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 23:48:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44331 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229554AbhETDsL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 23:48:11 -0400
X-UUID: 646cb2251ae7492298d48e1015fafb46-20210520
X-UUID: 646cb2251ae7492298d48e1015fafb46-20210520
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 103525911; Thu, 20 May 2021 11:46:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 11:46:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 11:46:46 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>,
        Leon Yen <leon.yen@mediatek.com>,
        YN Chen <yn.chen@mediatek.com>
Subject: [PATCH 2/7] mt76: connac: update BA win size in Rx direction
Date:   Thu, 20 May 2021 11:46:36 +0800
Message-ID: <1621482401-29025-2-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
References: <1621482401-29025-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Update BA size used data transimission in the Rx direction to improve Rx
throughput.

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index e0d6bdadf5b1..73359defa176 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -931,8 +931,10 @@ void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		ba->rst_ba_sb = 1;
 	}
 
-	if (is_mt7921(dev))
+	if (is_mt7921(dev)) {
+		ba->ba_winsize = enable ? cpu_to_le16(params->buf_size) : 0;
 		return;
+	}
 
 	if (enable && tx) {
 		u8 ba_range[] = { 4, 8, 12, 24, 36, 48, 54, 64 };
-- 
2.25.1

