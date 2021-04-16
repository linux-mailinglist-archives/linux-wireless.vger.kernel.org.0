Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147863623F4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbhDPPbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 11:31:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35305 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235540AbhDPPbH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 11:31:07 -0400
X-UUID: 99dcbcbaa1f74beaaabae0e5ddfcb9c0-20210416
X-UUID: 99dcbcbaa1f74beaaabae0e5ddfcb9c0-20210416
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1112333094; Fri, 16 Apr 2021 23:30:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 23:30:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 23:30:37 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/2] mt76: mt7921: abort uncompleted scan by wifi reset
Date:   Fri, 16 Apr 2021 23:30:36 +0800
Message-ID: <1618587036-17143-2-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618587036-17143-1-git-send-email-sean.wang@mediatek.com>
References: <1618587036-17143-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Scan abort should be required for the uncompleted hardware scan
interrupted by wifi reset. Otherwise, it is possible that the scan
request after wifi reset gets error code -EBUSY from mac80211 and
then blocks the reconnectting to the access point.

Fixes: 215bb6737bef ("mt76: mt7921: add wifi reset support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: no change
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 572bab82315a..3145880df6e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1413,6 +1413,14 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	if (i == 10)
 		dev_err(dev->mt76.dev, "chip reset failed\n");
 
+	if (test_and_clear_bit(MT76_HW_SCANNING, &dev->mphy.state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(dev->mphy.hw, &info);
+	}
+
 	ieee80211_wake_queues(hw);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
-- 
2.25.1

