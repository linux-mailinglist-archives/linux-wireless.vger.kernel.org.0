Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7348AD2E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 12:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiAKL7k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 06:59:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56434 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239045AbiAKL7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 06:59:31 -0500
X-UUID: 816fe01bd7254827abafa9fe415ee132-20220111
X-UUID: 816fe01bd7254827abafa9fe415ee132-20220111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 608407957; Tue, 11 Jan 2022 19:59:27 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 19:59:26 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Jan
 2022 19:59:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 11 Jan 2022 19:59:25 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v2 2/5] mt76: redefine mt76_for_each_q_rx to adapt mt7986 changes
Date:   Tue, 11 Jan 2022 19:59:18 +0800
Message-ID: <16ea7aa40bf245d69a09b8ad1620044aca716b43.1641901681.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1641901681.git.Bo.Jiao@mediatek.com>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Check ndesc of q_rx to avoid potential hole in iteration.
This is an intermediate patch to add mt7986 support.

Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2:
- redefine mt76_for_each_q_rx().
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 14f60fc..af6f9fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -899,8 +899,8 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76_queue_reset(dev, ...)	(dev)->mt76.queue_ops->reset_q(&((dev)->mt76), __VA_ARGS__)
 
 #define mt76_for_each_q_rx(dev, i)	\
-	for (i = 0; i < ARRAY_SIZE((dev)->q_rx) && \
-		    (dev)->q_rx[i].ndesc; i++)
+	for (i = 0; i < ARRAY_SIZE((dev)->q_rx); i++)	\
+		if ((dev)->q_rx[i].ndesc)
 
 struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int size,
 				   const struct ieee80211_ops *ops,
-- 
2.18.0

