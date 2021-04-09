Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C135A904
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 00:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhDIWwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 18:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235105AbhDIWwc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 18:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E46C610D1;
        Fri,  9 Apr 2021 22:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618008738;
        bh=WeRIurobnQ3/hlMp5vMAM6xs6GS+WI9TFRpl83nl4/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BP7EYWRqFCrVIu4aGS7XRPCH88xJWmHHe8/exp+HnCQgMICAvVmEyMcxU3YaAAFkU
         mNc3h9jUBcnxr514pUprPCnAr7WRAcrSN9mWlwyhMOhHCdwc2WGBXxqYPpFYCaq/nh
         khPeMMHOg3FU3oU9LL5zg8xlz/Q8PAbCg44Ap0zfW82D/jSwyUNX9MjWqifS41BAAM
         vjG+poC+l++YlL1Zll0I3EGHBeHERJjUPqF1H8eoWgGU2QDrWkBWhGhDo9pQpKy3Ab
         YzuhjyBBmtTAxA4YU1MBvEEOCOdMjt9BlOlBg6QDw4ktYVJxJehvPQLiDdfjYGIDK8
         BqgHpYj48lxjQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v2 5/7] mt76: mt7615: do not use mt7615 single-sku values for mt7663
Date:   Sat, 10 Apr 2021 00:51:50 +0200
Message-Id: <acd1451c44cf5f2a8f09095491acbef736b8c9a2.1618008449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618008449.git.lorenzo@kernel.org>
References: <cover.1618008449.git.lorenzo@kernel.org>
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

