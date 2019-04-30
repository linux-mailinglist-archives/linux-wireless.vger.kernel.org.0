Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008D3FADB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfD3Nz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 09:55:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36067 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725938AbfD3Nz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 09:55:57 -0400
X-UUID: 22f4d06481c74227b1a782e889908a5d-20190430
X-UUID: 22f4d06481c74227b1a782e889908a5d-20190430
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 705396054; Tue, 30 Apr 2019 21:55:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Apr 2019 21:55:50 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Apr 2019 21:55:50 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3] mt76: add TX/RX antenna pattern capabilities
Date:   Tue, 30 Apr 2019 21:55:38 +0800
Message-ID: <1e054441bab22ee28fdad597ca36d891500b4a66.1556624322.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 773063FDE1F70878361AFD26064A2C2E185522FBBD99B1D7194B6634151CC7CF2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Announce antenna pattern cap to adapt PHY and baseband settings.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v3:
- Move these flags to common code.
Changes since v2:
- Add a prefix mt76 in the title.
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 851caabbecda..26a336ef86c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -214,6 +214,8 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 	vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC |
 			IEEE80211_VHT_CAP_RXSTBC_1 |
 			IEEE80211_VHT_CAP_SHORT_GI_80 |
+			IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN |
+			IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN |
 			(3 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
 
 	return 0;
-- 
2.18.0

