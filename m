Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605EB433380
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhJSKce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJSKcd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:32:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E4C06161C
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H6etdgLap+Ib+Wz26aP6m4LI3IrnP0FO9dl5zaiagmQ=; b=I3T6K58JrrTCxA8SP7ZvV/yIpC
        iNRaqQqqjnMuWTLR9rPvgv9h45b1ZCfq9epAWhmSu0hO9d2VVmWJc3Bvz8qoGlNFN4CiXrZBVIPjF
        sLgBuHDb5x1Gtz89lh1QBIpAw2LGVwNDv0jrJZeH++PHcuAEFZEkA7MQdFvbOyKr9OCE=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mcmNu-0003w5-1D; Tue, 19 Oct 2021 12:30:18 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Richard Huynh <voxlympha@gmail.com>
Subject: [PATCH] mt76: mt76x0: correct VHT MCS 8/9 tx power eeprom offset
Date:   Tue, 19 Oct 2021 12:30:15 +0200
Message-Id: <20211019103015.99599-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Richard Huynh <voxlympha@gmail.com>

Appears to have incorrectly offset 0x120 + 0x12 instead of 12 decimal,
leading to bogus power values being used.

Signed-off-by: Richard Huynh <voxlympha@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index cea24213186c..da2ca2563ac9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -201,7 +201,7 @@ void mt76x0_get_tx_power_per_rate(struct mt76x02_dev *dev,
 	t->stbc[6] = t->stbc[7] = s6_to_s8(val >> 8);
 
 	/* vht mcs 8, 9 5GHz */
-	val = mt76x02_eeprom_get(dev, 0x132);
+	val = mt76x02_eeprom_get(dev, 0x12c);
 	t->vht[8] = s6_to_s8(val);
 	t->vht[9] = s6_to_s8(val >> 8);
 
-- 
2.30.1

