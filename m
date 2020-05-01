Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B501C2126
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 01:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgEAXQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 19:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAXQ1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 19:16:27 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493082166E;
        Fri,  1 May 2020 23:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588374987;
        bh=JHOG9KXVITuJTdpFdkSLOpp47cYOYsV+QxiylIY+xKw=;
        h=From:To:Cc:Subject:Date:From;
        b=I9SbjvATWIH8jx0N85OZ4wZL5di1wR5F8TINRQNB5/7LFfVt8657J/x3bdkW+/qeM
         qV2LrlgNFEBNwop4pZAtIpF9nQTorne2FQCDx8hPVilL1rCkCeJSjGHSSNYpTQ9O0C
         mAPg487HF7mEVPwzVLQ3zU+8Bl8/QLGbgWUEAvNA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: check return value of mt7615_eeprom_get_power_index
Date:   Sat,  2 May 2020 01:16:10 +0200
Message-Id: <9f2e5027dec463c32c29b6047eb3250e20389d1f.1588374866.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7615_eeprom_get_power_index can return negative error value.
Check mt7615_eeprom_get_power_index return value before using it

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 81294bb2b06b..d831d647d237 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -247,6 +247,9 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 			int index;
 
 			index = mt7615_eeprom_get_power_index(dev, chan, j);
+			if (index < 0)
+				continue;
+
 			target_power = max(target_power, eep[index]);
 		}
 
-- 
2.25.4

