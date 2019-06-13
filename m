Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA98A44490
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfFMQhn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:37:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38240 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730636AbfFMHNo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 03:13:44 -0400
X-UUID: 7fb525a94b8241e492dc70d5b7f83123-20190613
X-UUID: 7fb525a94b8241e492dc70d5b7f83123-20190613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 140816244; Thu, 13 Jun 2019 15:13:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Jun 2019 15:13:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Jun 2019 15:13:33 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7615: fix incorrect settings in mesh mode
Date:   Thu, 13 Jun 2019 15:13:30 +0800
Message-ID: <3065a01998dfa04a5d2d680e820a17cb5c110d0f.1560330906.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <ec6ccb9ad8e083bbc960c84adcb3164a4e190c7c.1560338170.git.ryder.lee@mediatek.com>
References: <ec6ccb9ad8e083bbc960c84adcb3164a4e190c7c.1560338170.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5533815261F40B873B0FE936DC543BA5DEA8548223FBF6ED8A830DDCA412B28B2000:8
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

