Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84A41A95
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 05:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408549AbfFLDMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 23:12:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52245 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2408538AbfFLDMp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 23:12:45 -0400
X-UUID: 4f80c4c4ccd3475f87596ca4a0de9668-20190612
X-UUID: 4f80c4c4ccd3475f87596ca4a0de9668-20190612
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 516540313; Wed, 12 Jun 2019 11:12:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 11:12:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 11:12:39 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7615: fix incorrect settings in mesh mode
Date:   Wed, 12 Jun 2019 11:12:33 +0800
Message-ID: <3065a01998dfa04a5d2d680e820a17cb5c110d0f.1560221172.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <22e5caff3581dc92fd6fec2f25966d86b7276bba.1560220443.git.ryder.lee@mediatek.com>
References: <22e5caff3581dc92fd6fec2f25966d86b7276bba.1560220443.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix wrong settings that will drop packets due to hardware's RX table
searching flow.

Fixes: f072c7ba2150 ("mt76: mt7615: enable support for mesh")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 76431d00a8ac..e82086eb8aa4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -970,7 +970,7 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		.rx_wtbl = {
 			.tag = cpu_to_le16(WTBL_RX),
 			.len = cpu_to_le16(sizeof(struct wtbl_rx)),
-			.rca1 = vif->type == NL80211_IFTYPE_STATION,
+			.rca1 = vif->type != NL80211_IFTYPE_AP,
 			.rca2 = 1,
 			.rv = 1,
 		},
-- 
2.18.0

