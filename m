Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C357F99
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0Jui (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 05:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfF0Jui (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 05:50:38 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E62B32080C;
        Thu, 27 Jun 2019 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561629037;
        bh=pG+Y2CSCbQ1asnLFdqbuV3K/dZ26IiUcrmzVTT0cHEw=;
        h=From:To:Cc:Subject:Date:From;
        b=t8nz2O+VyRISh8Ih7MPA1UcqMZq3erwd7pHWpfsJiKOnPC6f/t/27pONJqd9fWHul
         jsJ2I6HNKB9dsHPffQnvdyEm037snrxLLqf9S6j1KpEx/q4Q0K9WA5Az2ZN6sF7fYZ
         V78n00znt9HyS1ySz/HTHrwBuZIjFtUmBQPOOskQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: fix sparse warnings: warning: cast from restricted __le16
Date:   Thu, 27 Jun 2019 11:50:25 +0200
Message-Id: <218b80be3fd83986f657deda1e9a1d122624436d.1561628486.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not convert {tx,rx}_mcs_map to little-endian since it is already done
by mac80211. This patch fix the following sparse warning:

drivers/net/wireless/mediatek/mt76/mt7615/mcu.c:1497:25: sparse:
warning: cast from restricted __le16
drivers/net/wireless/mediatek/mt76/mt7615/mcu.c:1499:25: sparse:
warning: cast from restricted __le16

Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Fixes: 3ca0a6f6e9df ("mt7615: mcu: use standard signature for mt7615_mcu_msg_send")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index bf23e796bc06..beee25e69053 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1493,10 +1493,8 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		sta_vht->tag = cpu_to_le16(STA_REC_VHT);
 		sta_vht->len = cpu_to_le16(sizeof(*sta_vht));
 		sta_vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
-		sta_vht->vht_rx_mcs_map =
-			cpu_to_le16(sta->vht_cap.vht_mcs.rx_mcs_map);
-		sta_vht->vht_tx_mcs_map =
-			cpu_to_le16(sta->vht_cap.vht_mcs.tx_mcs_map);
+		sta_vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
+		sta_vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
 	}
 
 	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
-- 
2.21.0

