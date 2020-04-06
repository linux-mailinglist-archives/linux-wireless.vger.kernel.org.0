Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC64F19F57F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 14:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgDFMFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 08:05:02 -0400
Received: from nbd.name ([46.4.11.11]:35486 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgDFMFB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 08:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EiyfoY+LzndWncjUsp/QkyR+kHtde9ADtmPh5GRnAtQ=; b=X5PhHe3JYZZuRtBqtofHG0Jqfk
        tAkBqDRJjSaImO+kSIDj+UYg7CFc37euQPMwYszOppbkM7Ae9GNc8TX+v+53REyD3BrlBDNioMWLj
        fTitc+N6640DXhjT/mNyf3pF49D52h1SOrbhX9/rIxNFXc2XoCEyxzvr7mNeodWVz3Mg=;
Received: from [80.255.7.105] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jLQUu-0008NR-Nb
        for linux-wireless@vger.kernel.org; Mon, 06 Apr 2020 14:05:00 +0200
Received: by maeck.local (Postfix, from userid 501)
        id F0F2281E97B2; Mon,  6 Apr 2020 14:04:59 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt76x2: disable merge of OTP ROM data by default
Date:   Mon,  6 Apr 2020 14:04:59 +0200
Message-Id: <20200406120459.61713-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406120459.61713-1-nbd@nbd.name>
References: <20200406120459.61713-1-nbd@nbd.name>
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
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 4a748a6f0ce2..410ffce3baff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of.h>
 #include <asm/unaligned.h>
 #include "mt76x2.h"
 #include "eeprom.h"
@@ -76,6 +77,7 @@ mt76x2_apply_cal_free_data(struct mt76x02_dev *dev, u8 *efuse)
 		MT_EE_RF_5G_GRP4_5_RX_HIGH_GAIN,
 		MT_EE_RF_5G_GRP4_5_RX_HIGH_GAIN + 1,
 	};
+	struct device_node *np = dev->mt76.dev->of_node;
 	u8 *eeprom = dev->mt76.eeprom.data;
 	u8 prev_grp0[4] = {
 		eeprom[MT_EE_TX_POWER_0_START_5G],
@@ -86,6 +88,9 @@ mt76x2_apply_cal_free_data(struct mt76x02_dev *dev, u8 *efuse)
 	u16 val;
 	int i;
 
+	if (!np || !of_property_read_bool(np, "mediatek,eeprom-merge-otp"))
+		return;
+
 	if (!mt76x2_has_cal_free_data(dev, efuse))
 		return;
 
-- 
2.24.0

