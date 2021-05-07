Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E73763A7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhEGK1P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 06:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234400AbhEGK1O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 06:27:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BB366145D;
        Fri,  7 May 2021 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620383175;
        bh=Mbw+8owFLWs4xmIu7qzgT/jhkef9dYDarAtMd5JrW2o=;
        h=From:To:Cc:Subject:Date:From;
        b=oLRToiZB59kqEV3KXpAoHLDzhQdy2cuRcUX+3GGLX4jqjBWTF/2sv5My4xZu7eTgw
         hoX0BzZRdcGB/pWIdZdDUuTQ/hK2gwnEIe8NpuQ9rYzvYxzfwJr6uDpRHRbc0N3zDI
         okXJIwgRhGUTULgKzOiSzldWAmLiawa7KOYab6T+7TT4HEqh2pg/O/4KeBnZgkvXEE
         8GGfUC6Fc2kfgoLEXPBbgrfCepGes+Wej6PdS5tZL6lWzwm9rihvcgnhBErP8SAP01
         qF9QddZ+N4mz66H9dVhm+jmAeOXOl5VgZrAwOCqN3RFbLWIqxXFquMEmLSql7K2Mrx
         GyYkYfTMe7law==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76x0: use dev_debug instead of dev_err for hw_rf_ctrl
Date:   Fri,  7 May 2021 12:26:11 +0200
Message-Id: <8b311203e353d7415c4cff568201309fcb3b48e6.1620382900.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BIT(0) in MT_EE_NIC_CONF_1 is use to notify the driver if the radio RF
switch is controlled through a gpio. Use dev_debug instead of dev_err
to log this info.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index dd66fd12a2e6..cea24213186c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -68,7 +68,7 @@ static void mt76x0_set_chip_cap(struct mt76x02_dev *dev)
 		nic_conf1 &= 0xff00;
 
 	if (nic_conf1 & MT_EE_NIC_CONF_1_HW_RF_CTRL)
-		dev_err(dev->mt76.dev,
+		dev_dbg(dev->mt76.dev,
 			"driver does not support HW RF ctrl\n");
 
 	if (!mt76x02_field_valid(nic_conf0 >> 8))
-- 
2.30.2

