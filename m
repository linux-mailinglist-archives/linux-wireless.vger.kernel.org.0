Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0E3ABC2C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhFQSzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 14:55:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43616 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231992AbhFQSzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 14:55:21 -0400
X-UUID: e52f94d6565e44acae78ef579c2ea172-20210618
X-UUID: e52f94d6565e44acae78ef579c2ea172-20210618
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1232563317; Fri, 18 Jun 2021 02:53:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 02:53:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 02:53:08 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/4] mt76: connac: explicitly check vif->offload_flags
Date:   Fri, 18 Jun 2021 02:53:04 +0800
Message-ID: <61c1bc26142c8ed62d5d8a59d3f1d50dad89ffc0.1623955182.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <4718d8041f908cb3249ec68c59a6854919f00752.1623955182.git.ryder.lee@mediatek.com>
References: <4718d8041f908cb3249ec68c59a6854919f00752.1623955182.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check vif->offload_flags for encap offload in case of unsupported interfaces.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index b155e7b8d89d..e56713425860 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -406,10 +406,12 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 	htr = (struct wtbl_hdr_trans *)tlv;
 	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		htr->to_ds = true;
-	else
-		htr->from_ds = true;
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			htr->to_ds = true;
+		else
+			htr->from_ds = true;
+	}
 
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
 		htr->to_ds = true;
-- 
2.18.0

