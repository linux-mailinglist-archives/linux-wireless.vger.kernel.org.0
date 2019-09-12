Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF54B0AEF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfILJG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 05:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730489AbfILJG4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 05:06:56 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E50208E4;
        Thu, 12 Sep 2019 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568279215;
        bh=/HJhrevhXAYqPmnBYnZjcK5p73mDkvaL6tpvqZdlt1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrwOXceFW26EtN3ngiCngYTYN/wdmdlE6aatYMW1razV+00O03HFi521MvWG91nAf
         pxWL2qw8x8/GB4TpaxnrAfqOF2YqKqYZ6aY+c8F1xSe0sRFdZjAoE1QibgrjjvRKz1
         YaFvjhn1aSZVzc+GabKsLnnnDxoqzBaqxVRjwtbs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 3/4] mt76: mt76x0u: reset counter starting the device
Date:   Thu, 12 Sep 2019 11:06:37 +0200
Message-Id: <8bb1e2b3f6b7a06bc0ec0eab1ca7067331da9819.1568278771.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568278771.git.lorenzo@kernel.org>
References: <cover.1568278771.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mt76x02_mac_reset_counters from mt76x0_init_hardware since
it will be run starting the device

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index 541e81deba83..d7bac4961c7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -152,6 +152,7 @@ static void mt76x0_init_mac_registers(struct mt76x02_dev *dev)
 
 int mt76x0_mac_start(struct mt76x02_dev *dev)
 {
+	mt76x02_mac_reset_counters(dev);
 	mt76_wr(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
 
 	if (!mt76x02_wait_for_wpdma(&dev->mt76, 200000))
@@ -234,8 +235,6 @@ int mt76x0_init_hardware(struct mt76x02_dev *dev)
 	for (i = 0; i < 256; i++)
 		mt76x02_mac_wcid_setup(dev, i, 0, NULL);
 
-	mt76x02_mac_reset_counters(dev);
-
 	ret = mt76x0_eeprom_init(dev);
 	if (ret)
 		return ret;
-- 
2.21.0

