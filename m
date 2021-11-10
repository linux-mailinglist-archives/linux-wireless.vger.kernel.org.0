Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA0344BA7A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 03:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhKJC5A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 21:57:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52574 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229952AbhKJC47 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 21:56:59 -0500
X-UUID: 736958458df74ebabc521acaa0ca030e-20211110
X-UUID: 736958458df74ebabc521acaa0ca030e-20211110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xing.song@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 370560232; Wed, 10 Nov 2021 10:54:11 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 10 Nov 2021 10:54:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Nov
 2021 10:54:07 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 10 Nov 2021 10:54:07 +0800
From:   Xing Song <xing.song@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Xing Song <xing.song@mediatek.com>
Subject: [PATCH v2] mt76: do not pass the received frame with decryption error
Date:   Wed, 10 Nov 2021 10:54:04 +0800
Message-ID: <20211110025404.174080-1-xing.song@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop the received frame if decryption failed and mac80211 can not
handle it.

Signed-off-by: Xing Song <xing.song@mediatek.com>
---
v2: check for cipher mismatch or frame format error
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 +++++++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index fe03e31989bb..b6f2366d155e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -525,6 +525,10 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (rxd2 & MT_RXD2_NORMAL_TKIP_MIC_ERR)
 		status->flag |= RX_FLAG_MMIC_ERROR;
 
+	/* ICV error or CCMP/BIP/WPI MIC error */
+	if (rxd2 & MT_RXD2_NORMAL_ICV_ERR)
+		return -EINVAL;
+
 	if (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2) != 0 &&
 	    !(rxd2 & (MT_RXD2_NORMAL_CLM | MT_RXD2_NORMAL_CM))) {
 		status->flag |= RX_FLAG_DECRYPTED;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 423f69015e3e..10896cb35dd5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -286,9 +286,15 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
 		return -EINVAL;
 
+	hdr_trans = rxd1 & MT_RXD1_NORMAL_HDR_TRANS;
+
+	/* MT_RXD2_NORMAL_ICV_ERR: ICV error or CCMP/BIP/WPI MIC error */
+	if ((rxd2 & MT_RXD2_NORMAL_ICV_ERR) ||
+	    (hdr_trans && (rxd2 & (MT_RXD2_NORMAL_CLM | MT_RXD2_NORMAL_CM))))
+		return -EINVAL;
+
 	unicast = (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) == MT_RXD1_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
-	hdr_trans = rxd1 & MT_RXD1_NORMAL_HDR_TRANS;
 	status->wcid = mt7615_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5fcf35f2d9fb..02e5ce4cc71d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -426,9 +426,15 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
 		return -EINVAL;
 
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
+
+	/* MT_RXD1_NORMAL_ICV_ERR: ICV error or CCMP/BIP/WPI MIC error */
+	if ((rxd1 & MT_RXD1_NORMAL_ICV_ERR) ||
+	    (hdr_trans && (rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))))
+		return -EINVAL;
+
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
-	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
 	status->wcid = mt7915_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index db3302b1576a..9c814ef9c0ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -428,10 +428,16 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
 		return -EINVAL;
 
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
+
+	/* MT_RXD1_NORMAL_ICV_ERR: ICV error or CCMP/BIP/WPI MIC error */
+	if ((rxd1 & MT_RXD1_NORMAL_ICV_ERR) ||
+	    (hdr_trans && (rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))))
+		return -EINVAL;
+
 	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
-	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
 	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-- 
2.18.0

