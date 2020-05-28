Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B5F1E592F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgE1Hn5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 03:43:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgE1Hn4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 03:43:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73442EA7C2AF01ED7ACC;
        Thu, 28 May 2020 15:43:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 15:43:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-wireless@vger.kernel.org>, "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH] mt76: mt7915: remove set but not used variable 'msta'
Date:   Thu, 28 May 2020 07:48:29 +0000
Message-ID: <20200528074829.118156-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cc: linux-wireless@vger.kernel.org,
    linux-arm-kernel@lists.infradead.org,
    linux-mediatek@lists.infradead.org,
    netdev@vger.kernel.org,
    kernel-janitors@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/wireless/mediatek/mt76/mt7915/mcu.c: In function 'mt7915_mcu_sta_txbf_type':
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1805:21: warning:
 variable 'msta' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 99eeea42478f..7e803a5c94ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1802,15 +1802,12 @@ static u8
 mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta)
 {
-	struct mt7915_sta *msta;
 	u8 type = 0;
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
 		return 0;
 
-	msta = (struct mt7915_sta *)sta->drv_priv;
-
 	if (sta->he_cap.has_he) {
 		struct ieee80211_he_cap_elem *pe;
 		const struct ieee80211_he_cap_elem *ve;



