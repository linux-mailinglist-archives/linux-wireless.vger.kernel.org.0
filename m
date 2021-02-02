Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331F530BAB0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhBBJNL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 04:13:11 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:60508 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhBBJKd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 04:10:33 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 04:10:33 EST
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaff:9701:8183:afed:2a80:18d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B26CB1C8498;
        Tue,  2 Feb 2021 10:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1612256409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Qx9YhWNjebHbL2xX7G7GD8UUDbiyzfGmq18uR54F0U=;
        b=Grmxc+c9tP6nQlLGkt4KrdgvScU2zOi9q+uZyz6+dZ+bHOfV4J+CZguT2xF1oo00bE3d+4
        mP9Z+1YCA3aEhl2ucutcHNcLwgrpxbk/OHjH+INCUFB871r5EvjP3S7v5C9K0omWWzo2HH
        eP4btqOYAVXE43+5FJBYhryo6LODh1qmwo+nfQZpPyn/yAzzZqOez/gju20lbE62vG5RKk
        jhywtZnvqE0bdMEfMRS4aiJQHHy5VuPgeh6zeVldiMSSNaoCOOITk9o/o/u7Jfi9iRlQUb
        xqQoRV+CKJ2BCChotGViHIj4+gShZwH6FmuUEM/vP5SNDxIdclUYBiIOIWJ1qw==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sander Vanheule <sander@svanheule.net>,
        Georgi Vlaev <georgi.vlaev@konsulko.com>,
        Stijn Segers <foss@volatilesystems.org>
Subject: [PATCH] mt76: mt7615: support loading EEPROM for MT7613BE
Date:   Tue,  2 Feb 2021 09:59:53 +0100
Message-Id: <20210202085953.9564-1-sander@svanheule.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

EEPROM blobs for MT7613BE radios start with (little endian) 0x7663,
which is also the PCI device ID for this device. The EEPROM is required
for the radio to work at useful power levels, otherwise only the lowest
power level is available.

Suggested-by: Georgi Vlaev <georgi.vlaev@konsulko.com>
Tested-by: Stijn Segers <foss@volatilesystems.org>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 3232ebd5eda6..a31fa2017f52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -86,6 +86,7 @@ static int mt7615_check_eeprom(struct mt76_dev *dev)
 	switch (val) {
 	case 0x7615:
 	case 0x7622:
+	case 0x7663:
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.29.2

