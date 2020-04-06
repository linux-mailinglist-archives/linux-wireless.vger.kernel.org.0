Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0519F373
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 12:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDFKWH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 06:22:07 -0400
Received: from nbd.name ([46.4.11.11]:57842 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgDFKWH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gSUMq6rvkPPyxjf1Y8nxReIv4JswMYaw3La2yp/B9Is=; b=VhUOJt1x2a0MyVDPhnvuigaMe1
        RyUjx+OjlXLO5ujK179OGZE7fLHbT7uxawa/9mZas3dkOximt1FHdXwtO2HrlZeG9deTtdhBxSYuz
        NXUAzGp7BCLPzJNjVk0wbHV/WcIRuF/HmeQ41o5uUd9dvWAAiFFR+HLeF8JPDE8MdhTY=;
Received: from [80.255.7.105] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jLOtJ-0001ga-OP
        for linux-wireless@vger.kernel.org; Mon, 06 Apr 2020 12:22:05 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 97DF881E8915; Mon,  6 Apr 2020 12:22:03 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: mt7615: disable merge of OTP ROM data by default
Date:   Mon,  6 Apr 2020 12:22:01 +0200
Message-Id: <20200406102203.54450-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406102203.54450-1-nbd@nbd.name>
References: <20200406102203.54450-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The reference driver does not seem to enable it by default, only under certain
conditions, e.g. when a .bin file is loaded.
Make it opt-in via a device tree property for now, in case it is needed on some
boards.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 23ed20553de2..34c33d23d79f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -5,6 +5,7 @@
  *         Felix Fietkau <nbd@nbd.name>
  */
 
+#include <linux/of.h>
 #include "mt7615.h"
 #include "eeprom.h"
 
@@ -255,6 +256,11 @@ static void mt7622_apply_cal_free_data(struct mt7615_dev *dev)
 
 static void mt7615_cal_free_data(struct mt7615_dev *dev)
 {
+	struct device_node *np = dev->mt76.dev->of_node;
+
+	if (!np || !of_property_read_bool(np, "mediatek,eeprom-merge-otp"))
+		return;
+
 	switch (mt76_chip(&dev->mt76)) {
 	case 0x7622:
 		mt7622_apply_cal_free_data(dev);
-- 
2.24.0

