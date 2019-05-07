Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80ADB16012
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEGJDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 05:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfEGJDl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 05:03:41 -0400
Received: from localhost.localdomain (unknown [151.66.63.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32037204FD;
        Tue,  7 May 2019 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557219821;
        bh=N8MHVEG3QXhN3Il/nzkdnb1xCbPK8TonnTx9JdM7aRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQnrPZGW312WKZqfjJDeHN3AlS/UeiXVEKMUG1Y6yMAZmX5641RdqBiAFbD0xYLmx
         lWcUNmioaOEZXoRMUv6EL+EcHPS+YHH6Ej57ZoWDbHH36u6ZUIhD58ZoqdGw6vXqoT
         wSqmRk5EVrKo58mwshPoXmlC9yH8Deayn2TFciP4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: add static qualifier to mt7615_rx_poll_complete
Date:   Tue,  7 May 2019 11:03:33 +0200
Message-Id: <bc9f70d1975df2890df58606ade7d8a783ea8ec8.1557219723.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557219723.git.lorenzo@kernel.org>
References: <cover.1557219723.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make mt7615_rx_poll_complete static since it is used just in pci.c
to initialize rx_poll_complete function pointer

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c    | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 895c2904d7eb..be09a6e9f15b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -180,7 +180,6 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
-void mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q);
 void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 10a249e13a43..7a41faac997a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -27,7 +27,8 @@ u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
 	return MT_PCIE_REMAP_BASE_2 + offset;
 }
 
-void mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
+static void
+mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
-- 
2.20.1

