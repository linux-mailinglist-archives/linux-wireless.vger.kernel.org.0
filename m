Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E994045596B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbhKRKyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 05:54:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343530AbhKRKxf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 05:53:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DEE36138F;
        Thu, 18 Nov 2021 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637232635;
        bh=Lvk+Log5U6PbbZjxH6w0Rcl77z/T8W5v4Oq1neO7ZnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DAvcd8fp9dTjkMKlb+SToa6hJkvSE8r9/JPQutDnKGrU2sPgGvr9voqQmxpGlCNE9
         AjmpZHTvMF1F+fEvfnV0WRnUxWAq2qDel+HwHtEe3yYixUWVsgS513b2QIjdTSXXT1
         Ae1v4WezdVrxdZ9xYcnWIfgJHY9IQazEvpVo74z+OxQm2DrZvNugpTeZ12clVuZzHP
         Hd1z6fgMUmrcnOLOlPC1AZpvSWUaBb4FztFwwGIZWhtFNuh5awMxRXPyqokNZNQjbt
         1QGfrxbc6cFjrh2kJaN9K7/dqwRWLtap+A0deUJygHqjVdTIYNHPo3kOWIToMFuzLo
         OM3q81evsVUGw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: fix possible NULL pointer dereference in mt7921_mac_write_txwi
Date:   Thu, 18 Nov 2021 11:50:27 +0100
Message-Id: <3df5cebf50da1dbe512450fcc2709fd21a479153.1637232546.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible NULL pointer deference issue in mt7921_mac_write_txwi
routine if vif is NULL.

Fixes: 33920b2bf0483 ("mt76: add support for setting mcast rate")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index d7ab41773035..583d5cd29bb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -987,7 +987,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		mt7921_mac_write_txwi_80211(dev, txwi, skb, key);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
-		int rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+		int rateidx = vif ? ffs(vif->bss_conf.basic_rates) - 1 : 0;
 		u16 rate, mode;
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
-- 
2.31.1

