Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CFA1CB4F3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHQ0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 12:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEHQ0s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 12:26:48 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D29208CA;
        Fri,  8 May 2020 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588955207;
        bh=phOZA1uZBh+/NR3KYX8b+ifwAOlYupiFbNzaQ9+oDRo=;
        h=From:To:Cc:Subject:Date:From;
        b=FkfxU6hp1ZdPUKmkzY0LKiUpFsFMQ5y4tUB86SoyRb71MBRm2ZD0njMGLIFtDhPTw
         e0jNwHADALe1Lxl9ujrpzIJncpLSylzsW1T1uj1Br5mz05MVMloVfMsWE2VuPD8fLu
         OfkW8UIimyEv0KErgai/2raxFXE0PppMVxIpS5QE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        johannes@sipsolutions.net, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7663u: copy key pointer in mt7663u_mac_write_txwi
Date:   Fri,  8 May 2020 18:26:29 +0200
Message-Id: <74d083291baa3016b0ceb2bb5cd607b85197d511.1588955102.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Copy key pointer value before running mt76_tx_status_skb_add() in
mt7663u_mac_write_txwi since it will be overwritten setting
mt76_tx_cb for probing frames

Co-developed-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index f2825b8f4539..06235f83f903 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -66,6 +66,7 @@ mt7663u_mac_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 		       struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
 	__le32 *txwi;
 	int pid;
 
@@ -76,8 +77,7 @@ mt7663u_mac_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 	txwi = (__le32 *)(skb->data - MT_USB_TXD_SIZE);
 	memset(txwi, 0, MT_USB_TXD_SIZE);
-	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta,
-			      pid, info->control.hw_key, false);
+	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta, pid, key, false);
 	skb_push(skb, MT_USB_TXD_SIZE);
 }
 
-- 
2.26.2

