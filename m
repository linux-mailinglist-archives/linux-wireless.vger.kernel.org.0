Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8F35DAB2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 11:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhDMJJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 05:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhDMJJY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 05:09:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35511613B6;
        Tue, 13 Apr 2021 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618304944;
        bh=WeRIurobnQ3/hlMp5vMAM6xs6GS+WI9TFRpl83nl4/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGtGlKCcru51WCqxCt6g7uJ+qckuZZsbzJzFfo8+L46nsk/vq1pyDJ2soaj5UofrB
         H5hR27iRQczfYo/AY5zEISK5L0vQwiJi9nBgN6VUo/tCLLwVir9A6Ug+//dWRy5hNG
         DeG0mM9AoWsNlbI7RE6TzWskvJ9Jx5cyW5ZVHNxmQWsr3afz0NvAQcYmyHxUy/rY5D
         wlPaLqzz/BvmajwckYj1l8qsHhwZNuSa2YQ0dMtt61onQ8VaP68knH+67aGBa9+k1c
         6YwZBxDxPSxrA1aVQwG+57LGuHNjDRpLY3aJkTN3dBqhyZdz2MjEOVqJdvUaEUDTcQ
         K5bCmaZmcD9wA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v3 5/7] mt76: mt7615: do not use mt7615 single-sku values for mt7663
Date:   Tue, 13 Apr 2021 11:08:39 +0200
Message-Id: <512d1c4c0ee8894ce133968c7e26b47b825b50e3.1618304559.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618304559.git.lorenzo@kernel.org>
References: <cover.1618304559.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7663 mcu relies on different APIs to configure APIs per-rate power limit
respect to mt7615 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8c0a21e243db..195596194b51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2202,6 +2202,11 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 					      &limits, tx_power);
 	mphy->txpower_cur = tx_power;
 
+	if (is_mt7663(mphy->dev)) {
+		memset(sku, tx_power, MT_SKU_4SS_DELTA + 1);
+		return;
+	}
+
 	for (i = 0; i < MT_SKU_1SS_DELTA; i++)
 		sku[i] = limits_array[sku_mapping[i]];
 
-- 
2.30.2

