Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998D21B75EF
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgDXMvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 08:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgDXMvj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 08:51:39 -0400
Received: from localhost.localdomain.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EAF620706;
        Fri, 24 Apr 2020 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587732698;
        bh=acTCKRQtc8GdP2hfA8pb2wBMyI3c/xByzORhk33F4+M=;
        h=From:To:Cc:Subject:Date:From;
        b=RwsJIdQZnBnzL7i9BruN7sIPvkKiLJgHY+CzWGCjQu6X9h1uQHytXMDkaNQR2C8wz
         tEU1/+d8wKxw4W7O4+paBCZGkm1WJ9rh/6LUKyn4Y9tjwnG9K1G8UMGDIrVy19Qg+T
         KBoYK+hFTZDT7QKZ+PBp/famj6Yned3Cn1emLPss=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix event report in mt7615_mcu_bss_event
Date:   Fri, 24 Apr 2020 14:51:29 +0200
Message-Id: <19823f332eb49c3d0ab5177137e3b67c21e27a7b.1587732526.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently mt7663 devices do not support DBDC so fw events have no info
about it. Fix mt7615_mcu_bss_event that wrongly use bss_idx as DBDC
band_idx while it is vif index.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 476f674fe2e7..aee9ee43436f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -356,11 +356,12 @@ mt7615_mcu_bss_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt7615_mcu_bss_event *event;
 	struct mt76_phy *mphy;
+	u8 band_idx = 0; /* DBDC support */
 
 	event = (struct mt7615_mcu_bss_event *)(skb->data +
 						sizeof(struct mt7615_mcu_rxd));
 
-	if (event->bss_idx && dev->mt76.phy2)
+	if (band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 	else
 		mphy = &dev->mt76.phy;
-- 
2.25.3

