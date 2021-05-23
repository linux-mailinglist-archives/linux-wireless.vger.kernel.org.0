Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078D38DD0D
	for <lists+linux-wireless@lfdr.de>; Sun, 23 May 2021 23:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhEWVLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 May 2021 17:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhEWVLr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 May 2021 17:11:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC046115C;
        Sun, 23 May 2021 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621804220;
        bh=Ke6C6FSUZPvNm8d+fgoJ9SxaMboKfwRiskany4b9b28=;
        h=From:To:Cc:Subject:Date:From;
        b=D9DtP2+jWfiA1e87KVa/BOSU1nfK3B/z0p+AgZrpdpgv7u6rsEMaEB4Ab2/IUUfqZ
         jNtbdOGOfFMP9f6la8MpFMfHNRLkTN3siJHg346OexcMLI3A/huqqkAaHBkIG/XnO9
         2heprUEXTx4VFK7GtUgUcIoEbY7kkMWHYLIr/xqVpwWvn//jr5qA5LFsvtTckISXlc
         OaKAAjYq7HjVjv4HFcXTFHW3KuqOi8OQMm1sk7IWuYAqX+8tgtTFyzmGvhXLQCU2C4
         gPWaUZ2cfCDbiZCCHDSgTDV9fbubIgzVwtvUbPNUPENm+eDmvI1XcxPmxthbV5KyQC
         GLbJnv/Fj8CfA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: reset wfsys during hw probe
Date:   Sun, 23 May 2021 23:10:12 +0200
Message-Id: <95460c02cce327d43337afc72c431757fb42ecb5.1621804119.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes a mcu hang during device probe on
Marvell ESPRESSObin after a hot reboot.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index bd9143dc865f..7fca7dc466b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -402,6 +402,10 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7921_wfsys_reset(dev);
+	if (ret)
+		return ret;
+
 	/* init tx queue */
 	ret = mt7921_init_tx_queues(&dev->phy, MT7921_TXQ_BAND0,
 				    MT7921_TX_RING_SIZE);
-- 
2.31.1

