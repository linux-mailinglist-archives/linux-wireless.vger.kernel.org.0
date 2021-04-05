Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF54635421D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhDEMlF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 08:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235591AbhDEMlE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 08:41:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90B4C6138A;
        Mon,  5 Apr 2021 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617626458;
        bh=TmNJI++LcbfC5qLEvfmyL6EFaNTAGjCF3JiB5uUpYW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4wn7aB4CowjbkH5AH8NXP/Y152Sfsw//hQhEUlAMXes1j3plgyv0EoumSVs0dbo+
         zDVNm8QM8AyFmK9Gdp9sYwJcoSerPO0X6xonFSWP0Di7qXD6EtZ9fdzfMO0aoKneM4
         QtIST4igP1uB0ftQecuw7eP2zZD2gbdzCPj60joN7WAqfcKPDwp4JrUt55xvaqdu7k
         srjsQ1q8ECGBwYWR1jWTcl80RyG20zaYU6DBS/TiTxzbfbrDWDVbO1hTDa9NbKb1BN
         oQ4g3LeX/7pR7ZFY9F45uWeSb4UbIIPK6qlsS37UvTSwb5/RXGiAuQS9oY8o1yc5Vf
         WJf5Dp8uITsrg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH 6/8] mt76: mt7615: do not use mt7615 single-sku values for mt7663
Date:   Mon,  5 Apr 2021 14:40:30 +0200
Message-Id: <068ed97fb7c7e51b13aefc9be4127e9b2f831904.1617625912.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617625912.git.lorenzo@kernel.org>
References: <cover.1617625912.git.lorenzo@kernel.org>
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
index 7ca7d239b53d..19b408b6badb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2194,6 +2194,11 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
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

