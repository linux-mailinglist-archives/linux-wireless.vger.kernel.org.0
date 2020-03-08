Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29F17D6A3
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCHWJM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCHWJM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:12 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041D220848;
        Sun,  8 Mar 2020 22:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705352;
        bh=ee4CdzPkqqS3Vv4Jtz4BnEZRZPxTLKDEYOS911I5/lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nupzFAqF7UiYjxetoiIb/QODMxr+09dx5/bU3/smX3lDqDkvb0YbsxD4acP123cfJ
         EW0BAOMIt14ACgoh8GgjRtlNZSPGBPG8JlQRwpATarPAxE/hFpS9at2AuFYSvFT1q7
         hZ5kTEV1VI+RZl+JPGxyJ8s0DfyuFuGy8fYiSbDg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 03/25] mt76: mt7615: cleanup fw queue just for mmio devices
Date:   Sun,  8 Mar 2020 23:08:15 +0100
Message-Id: <7b4ffbb13e9b5674e2a58d526b849d6d0f254a04.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reuse mt7615_mcu_send_firmware routine adding support for
usb devices, clean fw hw queue just for mmio devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a4e971d7f6a7..b24240f90a7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -321,7 +321,9 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 
 		data += cur_len;
 		len -= cur_len;
-		mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
+
+		if (mt76_is_mmio(&dev->mt76))
+			mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
 	}
 
 	return ret;
-- 
2.24.1

