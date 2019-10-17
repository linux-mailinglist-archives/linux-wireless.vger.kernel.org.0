Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7164CDB9E5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 00:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503751AbfJQWuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 18:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438306AbfJQWuP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 18:50:15 -0400
Received: from localhost.lan (unknown [151.66.3.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3488021A49;
        Thu, 17 Oct 2019 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571352615;
        bh=EkYJmZOw/RNYX9uOPjxixwXg0oexEnmnEaPBRViLjCU=;
        h=From:To:Cc:Subject:Date:From;
        b=wFoXZpjbIxFAkzFFpsNoniszZDlQZj3N1eNUAV+8kapx8eqpN72hVBtYCUlgADYlg
         /73kmgAH2unIcySKtu+UJgMONgLVA2cmx7KpqAfj9owW2GAgFXb8w9B3oRXA/H3sr/
         4ZeozMPI7MQro2KFhjt/UVPGZ5s30uxoae1iGyCs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76x02u: update ewma pkt len in mt76x02u_tx_prepare_skb
Date:   Fri, 18 Oct 2019 00:50:04 +0200
Message-Id: <7cbd3748566ccde72766c4365f325e6dd2538099.1571352322.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update ewma packet length in mt76x02u_tx_prepare_skb as it is
done for pci counterpart in order to properly estimate tx time on
current channel

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 4294ffc0478b..d03d3c8e296c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -120,6 +120,12 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 	if (!wcid || wcid->hw_key_idx == 0xff || wcid->sw_iv)
 		flags |= MT_TXD_INFO_WIV;
 
+	if (sta) {
+		struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
+
+		ewma_pktlen_add(&msta->pktlen, tx_info->skb->len);
+	}
+
 	return mt76x02u_skb_dma_info(tx_info->skb, WLAN_PORT, flags);
 }
 EXPORT_SYMBOL_GPL(mt76x02u_tx_prepare_skb);
-- 
2.21.0

