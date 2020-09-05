Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB31A25E6B0
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIEJ0S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIEJ0S (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:18 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE39F20757;
        Sat,  5 Sep 2020 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297977;
        bh=FXrJfxbMWk8s8N/MakKjCLApr3kebpI1J4vYqNHhl64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9lGQDEsbt7FfrM/VMYdryklUvLjvi7Z0l14hbt6EcBJXEcsT4P6zznrzbVzo5gNb
         Fj0wkwqtdz7hVwAB715xS8y46AOgaQkfo7BlG0Mj5GWBeh+m1kd26Ds4fHgXNuG+oz
         mAJ5vnzJMOPZ1JuKbLgZNT4J4J90aawfhdV+zvJE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 1/7] mt76: mt7663s: do not use altx for ctl/mgmt traffic
Date:   Sat,  5 Sep 2020 11:26:01 +0200
Message-Id: <9cc863c3d8e9b36af2add3c42474f14adbdc2df1.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599297449.git.lorenzo@kernel.org>
References: <cover.1599297449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since the sdio engine does not report quota for altx queue, move
ctl/mgmt traffic to standard data queues

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c     |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio_txrx.c    | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index e0603e82e33d..8621c6f579aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -323,7 +323,7 @@ static int mt7663s_probe(struct sdio_func *func,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = MT_USB_TXD_SIZE,
-		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ,
+		.drv_flags = MT_DRV_RX_DMA_HDR,
 		.tx_prepare_skb = mt7663_usb_sdio_tx_prepare_skb,
 		.tx_complete_skb = mt7663_usb_sdio_tx_complete_skb,
 		.tx_status_data = mt7663_usb_sdio_tx_status_data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 3557df52846f..b2b528cba7f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -124,16 +124,14 @@ static int mt7663s_tx_update_sched(struct mt76_dev *dev,
 				   bool mcu)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
-	struct mt76_phy *mphy = &dev->phy;
-	struct ieee80211_hdr *hdr;
 	int size, ret = -EBUSY;
 
+	if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+		return 0;
+
 	size = DIV_ROUND_UP(e->buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
 
 	if (mcu) {
-		if (!test_bit(MT76_STATE_MCU_RUNNING, &mphy->state))
-			return 0;
-
 		mutex_lock(&sdio->sched.lock);
 		if (sdio->sched.pse_mcu_quota > size) {
 			sdio->sched.pse_mcu_quota -= size;
@@ -144,10 +142,6 @@ static int mt7663s_tx_update_sched(struct mt76_dev *dev,
 		return ret;
 	}
 
-	hdr = (struct ieee80211_hdr *)(e->skb->data + MT_USB_TXD_SIZE);
-	if (ieee80211_is_ctl(hdr->frame_control))
-		return 0;
-
 	mutex_lock(&sdio->sched.lock);
 	if (sdio->sched.pse_data_quota > size &&
 	    sdio->sched.ple_data_quota > 0) {
-- 
2.26.2

