Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC919C1B5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbgDBNIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNIL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:08:11 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E440020678;
        Thu,  2 Apr 2020 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832891;
        bh=yPX4IuwqHA9Lbu17ttmIVQKFbFHxaiHTbKg2XP0pdac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRCzPkogRaeqEbgQtp3JM08PG2P4wtRx9uNQYHMr5S/gfXv326pqlKG+lVfJHmJUO
         hLU+P24UaQRpD6UdUzMj+6SEMtxijEtQurXm9/Ak0xciCynqhTozs2eWbAe1BxzPBY
         yBOizwEgxKvX+yNFta48K3OzvLQe1sQTYcNzwkmo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 12/12] mt76: mt7615: remove unnecessary register operations
Date:   Thu,  2 Apr 2020 15:06:42 +0200
Message-Id: <786c751acbec509cefe9e3c0c3014b7555190f42.1585832459.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Remove mt76_wr(dev, MT_CSR(0x010), 0x8208) that would cause
MT_PCIE_IRQ_ENABLE to be disabled; MT_PCIE_IRQ_ENABLE should always keep
on enabled when the driver is running.

0x44064 is a not existing address

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index f4775945e3d7..be0f3a77e22f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -117,8 +117,6 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072) |
 		MT_DMA_DCR0_RX_VEC_DROP);
 	if (is_mt7663(&dev->mt76)) {
-		mt76_wr(dev, MT_CSR(0x010), 0x8208);
-		mt76_wr(dev, 0x44064, 0x2000000);
 		mt76_wr(dev, MT_WF_AGG(0x160), 0x5c341c02);
 		mt76_wr(dev, MT_WF_AGG(0x164), 0x70708040);
 	} else {
-- 
2.25.1

