Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275C3C8159
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhGNJVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 05:21:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40602 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238291AbhGNJVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 05:21:48 -0400
X-UUID: 9dd61a7b90fd4f889a1089211f52885b-20210714
X-UUID: 9dd61a7b90fd4f889a1089211f52885b-20210714
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1640123618; Wed, 14 Jul 2021 17:18:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 17:18:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 17:18:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/4] mt76 mt7915: take RCU read lock when calling ieee80211_bss_get_elem()
Date:   Wed, 14 Jul 2021 17:18:48 +0800
Message-ID: <50730853fe09fb75418484770a0c95c23b44deb5.1626253920.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As ieee80211_bss_get_elem() derefences an RCU to return ie, both
the call to this function and any operation on this variable need
protection by the RCU read lock.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - fix typo in commit message
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 863aa18b3024..4d2e5b5e6389 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -923,12 +923,15 @@ static void mt7915_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
 	struct mt7915_he_obss_narrow_bw_ru_data *data = _data;
 	const struct element *elem;
 
+	rcu_read_lock();
 	elem = ieee80211_bss_get_elem(bss, WLAN_EID_EXT_CAPABILITY);
 
 	if (!elem || elem->datalen < 10 ||
 	    !(elem->data[10] &
 	      WLAN_EXT_CAPA10_OBSS_NARROW_BW_RU_TOLERANCE_SUPPORT))
 		data->tolerated = false;
+
+	rcu_read_unlock();
 }
 
 static bool mt7915_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
-- 
2.29.2

