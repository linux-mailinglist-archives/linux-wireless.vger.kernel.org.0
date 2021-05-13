Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E341537F97A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhEMOPK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 10:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234284AbhEMOPD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 10:15:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DA7B613C3;
        Thu, 13 May 2021 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620915234;
        bh=CIPayx8+X1M7N/pFYBH3+YrQvRUJbPaHpfs53S6tnpM=;
        h=From:To:Cc:Subject:Date:From;
        b=qRnwGQzVoY72zzH+/wG/4AHf/uY/K8JS0MYDxrLGLbtKi0lzm3TprnoGAsa+ZnejG
         nMHhvxE7yqskj8P3LO1YmkUG2wgfyQQ6sy6BMUcwiMKhWfa7oBNC8PBJRmVjD49Ixf
         YTGyHZpHV1IsKmtEnc/4WH80LcSu9f+H7BngmsrXGnKcpwy+1Z72M5ljG1LAG2mihy
         PUL8vS7TZmHRXgHUahvORelNCpzGaZjINmkUpry/PkLjN1lKrSxEipj0SMr9oyqwGV
         rmLdjH0F0+ldim0bsoL7HCv5D68vnXOT8HSeD83C/IQEo9R3yXY+HI4dfPGJox/c3s
         pRVwdnCVIEBIg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: set MT76_RESET during mac reset
Date:   Thu, 13 May 2021 16:13:49 +0200
Message-Id: <3bdd3cada045a2d31c18c80cc40da97b0cec1af9.1620914781.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set MT76_RESET during mt7921_mac_reset in order to avoid packet
transmissions

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index b0b59d5a1011..d8df2b9b94af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1255,6 +1255,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
+	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -1274,6 +1275,9 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	if (err)
 		return err;
 
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
@@ -1283,8 +1287,6 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	napi_schedule(&dev->mt76.tx_napi);
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
-
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
 		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
 		MT_INT_MCU_CMD);
-- 
2.31.1

