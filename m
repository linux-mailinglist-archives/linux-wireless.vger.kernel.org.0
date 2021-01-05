Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A02EA4FC
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 06:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAEFmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 00:42:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48595 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725298AbhAEFmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 00:42:03 -0500
X-UUID: 8adb03f8b2104378908320709ffaf947-20210105
X-UUID: 8adb03f8b2104378908320709ffaf947-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 690612232; Tue, 05 Jan 2021 13:41:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 13:41:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 13:41:07 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: force ldpc for bw larger than 20MHz in testmode
Date:   Tue, 5 Jan 2021 13:41:00 +0800
Message-ID: <20210105054100.5905-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 88B7FD876DFEA7D8934A83C7DA8550940EC305058A3E12EC643712A684710EB92000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LDPC should be set when bw is larger than 20MHz to make
testmode tx work normally.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index dc1f56fb823d..e8787c336a55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -700,7 +700,7 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 	if (mode >= MT_PHY_TYPE_HE_SU)
 		val |= FIELD_PREP(MT_TXD6_HELTF, td->tx_ltf);
 
-	if (td->tx_rate_ldpc)
+	if (td->tx_rate_ldpc || bw > 0)
 		val |= MT_TXD6_LDPC;
 
 	txwi[6] |= cpu_to_le32(val);
-- 
2.29.2

