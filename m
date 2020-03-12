Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11C1835B7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgCLQCw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgCLQCw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:02:52 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1317720716;
        Thu, 12 Mar 2020 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584028972;
        bh=ee4CdzPkqqS3Vv4Jtz4BnEZRZPxTLKDEYOS911I5/lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DctWdiZFcDyTiLDhgq+LvbM45PEXse5vB0areJmRY88z7g5rYAWuEze5H/Mtr2fux
         a2fqhE+n57piKvMecuIRK47Fi3U1TrJKE3MJfF/xbx+lplP2DesaFUYs6/xJ0Xhmj0
         a+gJyQzGmgkn9QBcBDJMdL86Pc7KCbZCa2hJN9S4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3 03/25] mt76: mt7615: cleanup fw queue just for mmio devices
Date:   Thu, 12 Mar 2020 17:02:13 +0100
Message-Id: <7b4ffbb13e9b5674e2a58d526b849d6d0f254a04.1584028319.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584028319.git.lorenzo@kernel.org>
References: <cover.1584028319.git.lorenzo@kernel.org>
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

