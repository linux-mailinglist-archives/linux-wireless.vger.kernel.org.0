Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F189748E7D1
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiANJtt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 04:49:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43454 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240107AbiANJtt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 04:49:49 -0500
X-UUID: b7200c202ff64b68ac80d10f9811539f-20220114
X-UUID: b7200c202ff64b68ac80d10f9811539f-20220114
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 896732081; Fri, 14 Jan 2022 17:49:47 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Jan 2022 17:49:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Jan
 2022 17:49:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Jan 2022 17:49:45 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: set bssinfo/starec command when adding interface
Date:   Fri, 14 Jan 2022 17:49:11 +0800
Message-ID: <20220114094911.30561-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

bssinfo/starec disabled commands are sent during removing interface.
However, if we don't set corresponding enabled commands before
removing interface, the fw may enter an exception state due to
some NULL structs.
For example, the following commands can cause fw timeout in our newer
chips:
    ifconfig wlan0/mon0 up
    ifconfig wlan0/mon0 down

Fix this by setting enabled commands once interface added.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b45b75f..41b0a4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -257,6 +257,9 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	mt7915_init_bitrate_mask(vif);
 	memset(&mvif->cap, -1, sizeof(mvif->cap));
 
+	mt7915_mcu_add_bss_info(phy, vif, true);
+	mt7915_mcu_add_sta(dev, vif, NULL, true);
+
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
-- 
2.25.1

