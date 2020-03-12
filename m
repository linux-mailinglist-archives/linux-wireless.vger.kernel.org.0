Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54401829DC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 08:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbgCLHkh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 03:40:37 -0400
Received: from nbd.name ([46.4.11.11]:50198 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387898AbgCLHkh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 03:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oh+DQLBH2PhGeB4NntLsLFH5LYUaqABrhl86gxjgfww=; b=mDgJ27H94QPilVoP6Rstt7/PKb
        fjh1qbQMMbW0MDy3PutCIaCHC2B8G5JwaiX6pjuOX32WQDGBBgjeRm0tsimD4+8sQGkZvCYqYyDlm
        EnukL5P9sfbvUHHrm7S8Ixk188grob9JYD1Rcgg+WiJ4Ec7q3h0CVXcUtr7ugk47L2+c=;
Received: from [80.255.7.108] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jCISK-0007SK-AH
        for linux-wireless@vger.kernel.org; Thu, 12 Mar 2020 08:40:36 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 2CDD97FC4F5B; Thu, 12 Mar 2020 08:40:34 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76x02: reset MCU timeout counter earlier in watchdog reset
Date:   Thu, 12 Mar 2020 08:40:34 +0100
Message-Id: <20200312074034.76741-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ensure that MCU commands issued right after hardware reset are not dropped
and treated as failed.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index c7f028e73b6b..7dcc5d342e9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -461,6 +461,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	dev->mcu_timeout = 0;
 	if (restart)
 		mt76x02_reset_state(dev);
 
@@ -544,10 +545,6 @@ static void mt76x02_check_tx_hang(struct mt76x02_dev *dev)
 restart:
 	mt76x02_watchdog_reset(dev);
 
-	mutex_lock(&dev->mt76.mcu.mutex);
-	dev->mcu_timeout = 0;
-	mutex_unlock(&dev->mt76.mcu.mutex);
-
 	dev->tx_hang_reset++;
 	dev->tx_hang_check = 0;
 	memset(dev->mt76.tx_dma_idx, 0xff,
-- 
2.24.0

