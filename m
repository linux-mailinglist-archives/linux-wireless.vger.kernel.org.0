Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74D45F28D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKZRAx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 12:00:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56692 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231902AbhKZQ6x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:58:53 -0500
X-UUID: 5085afb1127d4aa28501a6903edc1b19-20211127
X-UUID: 5085afb1127d4aa28501a6903edc1b19-20211127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2137549975; Sat, 27 Nov 2021 00:55:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 27 Nov 2021 00:55:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Nov 2021 00:55:37 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7921: use correct iftype data on 6GHz cap init
Date:   Sat, 27 Nov 2021 00:53:16 +0800
Message-ID: <20211126165316.1662-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set 6GHz cap to iftype data which is matched to the type of
current interface.

Fixes: 50ac15a511e3 ("mt76: mt7921: add 6GHz support")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5a64126..5540b2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -178,7 +178,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 			if (vht_cap->cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
 				cap |= IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
 
-			data->he_6ghz_capa.capa = cpu_to_le16(cap);
+			data[idx].he_6ghz_capa.capa = cpu_to_le16(cap);
 		}
 		idx++;
 	}
-- 
2.25.1

