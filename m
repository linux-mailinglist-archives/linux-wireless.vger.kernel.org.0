Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E438BA79
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2019 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfHMNhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Aug 2019 09:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfHMNg6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Aug 2019 09:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7068315C007;
        Tue, 13 Aug 2019 13:36:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D31F821FF;
        Tue, 13 Aug 2019 13:36:57 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH 5.3] mt76: mt76x0e: disable 5GHz band for MT7630E
Date:   Tue, 13 Aug 2019 15:36:56 +0200
Message-Id: <1565703416-10669-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 13 Aug 2019 13:36:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7630E hardware does support 5GHz, but we do not properly configure phy
for 5GHz channels. Scanning at this band not only do not show any APs
but also can hang the firmware.

Since vendor reference driver do not support 5GHz we don't know how
properly configure 5GHz channels. So disable this band for MT7630E .

Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index ab6dfc026acb..36918b1bd653 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -67,6 +67,11 @@ static void mt76x0_set_chip_cap(struct mt76x02_dev *dev)
 		dev_dbg(dev->mt76.dev, "mask out 2GHz support\n");
 	}
 
+	if (is_mt7630(dev)) {
+		dev->mt76.cap.has_5ghz = false;
+		dev_dbg(dev->mt76.dev, "mask out 5GHz support\n");
+	}
+
 	if (!mt76x02_field_valid(nic_conf1 & 0xff))
 		nic_conf1 &= 0xff00;
 
-- 
1.9.3

