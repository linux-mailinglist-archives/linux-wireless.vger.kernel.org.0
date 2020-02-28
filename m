Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E758173856
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 14:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgB1N3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 08:29:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgB1N3k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 08:29:40 -0500
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74609246A8;
        Fri, 28 Feb 2020 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582896580;
        bh=q1v0uaAwmXeSc2SBPs0Pyq2gvzi2dB/Y28BZb+ikqf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKToyO4JqBAN5n5SpoV4acqF0z1Jj4vC67XMRgYEy46b/7l26rAsdhsIPgENwctOl
         ByTeIdWq/P/3T9sINZ2JeZHRHDjvZ/j/ayzrv1j51baSooOfEa0cGtQw+x4tR2bl4b
         I/btsFLrdJLWUd6MeXYqfCpAx+1v23MVEuyiRwI4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 4/6] mt76: mt7615: cleanup fw queue just for mmio devices
Date:   Fri, 28 Feb 2020 14:29:25 +0100
Message-Id: <59ea8135306064e6c93d832f8d6e59e9c2a3b66e.1582893136.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582893136.git.lorenzo@kernel.org>
References: <cover.1582893136.git.lorenzo@kernel.org>
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
index 43a376814be7..e3b4248d2b16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -351,7 +351,9 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 
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

