Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D892F21360A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGCIQV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCIQV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:21 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66A4206A1;
        Fri,  3 Jul 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764181;
        bh=SMzFQ+DaQGVrufwH/LTf8U0k7pJKTYyPrLJWYFEvxD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqzzLu7KGUkv5WsbTdeyM5zLPR2zyPk5CM3vpP3Om1fgKugpVO2uFlCcYMF7qA3lj
         y8ljX4v7XKGwDdq2tyEPzWYqi2FIXN73V6/shLG86ku+4YgXIpBgV3PkOtKCGXh9Yv
         XQsObGqBTw/kLtTCwtQW3dxs12yjb6Jmm/KMKPhs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 01/22] mt76: mt7615: avoid polling in fw_own for mt7663
Date:   Fri,  3 Jul 2020 10:15:40 +0200
Message-Id: <b30cd73dc1c62a646dabd6a16248c73407c2ec16.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to the vendor sdk, mt7663 does not need to poll register after
firmware own. Since just mt7622 polls status register, set proper
timeout value according to the vendor sdk

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 156cf68c5419..89a09745df08 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1945,9 +1945,9 @@ int mt7615_firmware_own(struct mt7615_dev *dev)
 
 	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_FW_OWN);
 
-	if (!is_mt7615(&dev->mt76) &&
+	if (is_mt7622(&dev->mt76) &&
 	    !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN,
-			    MT_CFG_LPCR_HOST_FW_OWN, 3000)) {
+			    MT_CFG_LPCR_HOST_FW_OWN, 300)) {
 		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
 		return -EIO;
 	}
-- 
2.26.2

