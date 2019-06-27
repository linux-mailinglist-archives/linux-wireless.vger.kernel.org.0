Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D0584DA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfF0Otz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 10:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF0Otz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 10:49:55 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3FD320644;
        Thu, 27 Jun 2019 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561646994;
        bh=12Z6MhPmXV/NZ6/y8pPTcSxuFN6lBpbyxl0ojiwKQR0=;
        h=From:To:Cc:Subject:Date:From;
        b=Dp6ODelksRF/Gzz+X81tfqqdfqMkkcTJUHNjltfvjVnLlC6UbwPspmRWAgCaOPZm/
         HfAuf9REyYXAGrSbg9e4/DkNwD/741MdRDJ80gFy/lYpLQdtEY7SSvdJ11yf7VH+hq
         e1118xzebJPY9EUEdzNQyVRetzkd42iUn+Q8DYnc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: fix sparse warnings: warning: restricted __le16 degrades to integer
Date:   Thu, 27 Jun 2019 16:49:44 +0200
Message-Id: <fcfc54a6c129d513cce029fa8f2a5a01fab89091.1561644460.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in __mt7615_mcu_msg_send:
drivers/net/wireless/mediatek/mt76/mt7615/mcu.c:78:15: sparse: warning:
restricted __le16 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7615/mcu.c:78:15: sparse: warning:
cast from restricted __le16

Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index beee25e69053..cc6da5145d12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -75,7 +75,7 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 
 	txd = mcu_txd->txd;
 
-	val = FIELD_PREP(MT_TXD0_TX_BYTES, cpu_to_le16(skb->len)) |
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
 	      FIELD_PREP(MT_TXD0_P_IDX, MT_TX_PORT_IDX_MCU) |
 	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
 	txd[0] = cpu_to_le32(val);
-- 
2.21.0

