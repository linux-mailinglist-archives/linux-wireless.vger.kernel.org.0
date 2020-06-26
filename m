Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844FB20BB6B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFZVZd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZVZc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:25:32 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243EA20B80;
        Fri, 26 Jun 2020 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593206732;
        bh=SMzFQ+DaQGVrufwH/LTf8U0k7pJKTYyPrLJWYFEvxD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJjxVCnPyimfZKXdvIByGjwVT4qWpqJTiuQAyWxd2T4pgIU65+g5ccEiYDLtZbq9f
         WsCWIzMPEcY2OfN74B/+IQUCwBoIJuIGG5zfDurcWny4+BpNgeT/V0eQpyZr61k2RD
         KD5lC2qvidcN5Kw5JSk+lhBVpCXnv/2phrDkF+A0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 01/17] mt76: mt7615: avoid polling in fw_own for mt7663
Date:   Fri, 26 Jun 2020 23:25:01 +0200
Message-Id: <128d5e09efee2ba2652daf7a5512ca78e6739616.1593204577.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593204577.git.lorenzo@kernel.org>
References: <cover.1593204577.git.lorenzo@kernel.org>
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

