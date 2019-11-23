Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26421080ED
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2019 23:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKWWmj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Nov 2019 17:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfKWWmj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Nov 2019 17:42:39 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 228C920706;
        Sat, 23 Nov 2019 22:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574548958;
        bh=uEyNnuYMBvNQHpDK/zx1GEKa6aPWUSeWE/ZuzTB/5Qw=;
        h=From:To:Cc:Subject:Date:From;
        b=DQa0fpbS9MY+veAApVu4F415hFUYYkhyRJpC4JmIlTWocvtZFmLoUjwSV+yCuv+G9
         /BZyLE5Xl5s2SzP7KpFRd5haf9bdqCV5qkBxuiLSAmeFzByuMlhfyL2UjN25zilI31
         0jCR5ejIlJrJRgYRkce3H+RE1no41b2IQKEbptaY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kevin.patrick.schmidt@googlemail.com
Subject: [PATCH] mt76: mt76x0: fix default mac address overwrite
Date:   Sun, 24 Nov 2019 00:42:22 +0200
Message-Id: <567a7cda15f641acb6eab5970370c9bfac96793e.1574548832.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current implementation always use default eeprom mac address to
configure device registers even if it is updated using
mt76_eeprom_override. Fix it initializing macaddr filed of mt76_dev data
structure with eeprom mac address and running mt76_eeprom_override
before mt76x02_mac_setaddr

Fixes: d1bc9bf2072c ("mt76: mt76x0: eeprom: add support for MAC address from OF")
Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index a03e2d01fba7..d1405528b504 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -342,8 +342,11 @@ int mt76x0_eeprom_init(struct mt76x02_dev *dev)
 	dev_info(dev->mt76.dev, "EEPROM ver:%02hhx fae:%02hhx\n",
 		 version, fae);
 
-	mt76x02_mac_setaddr(dev, dev->mt76.eeprom.data + MT_EE_MAC_ADDR);
+	memcpy(dev->mt76.macaddr, (u8 *)dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+	       ETH_ALEN);
 	mt76_eeprom_override(&dev->mt76);
+	mt76x02_mac_setaddr(dev, dev->mt76.macaddr);
+
 	mt76x0_set_chip_cap(dev);
 	mt76x0_set_freq_offset(dev);
 	mt76x0_set_temp_offset(dev);
-- 
2.21.0

