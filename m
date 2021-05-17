Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3738238A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhEQErh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 00:47:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41051 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230144AbhEQErg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 00:47:36 -0400
X-UUID: 2b67079de89f4c9da34125aa8be43013-20210517
X-UUID: 2b67079de89f4c9da34125aa8be43013-20210517
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2135576648; Mon, 17 May 2021 12:46:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 May 2021 12:46:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 May 2021 12:46:01 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix MT_EE_CAL_GROUP_SIZE
Date:   Mon, 17 May 2021 12:45:58 +0800
Message-ID: <66c4bb0c6f4b1abcd0e17680ad42f742e2c1a528.1621198865.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1da08f158e6784da6727779550f96f7a9c958b19.1621198865.git.ryder.lee@mediatek.com>
References: <1da08f158e6784da6727779550f96f7a9c958b19.1621198865.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix wrong offset for pre-calibration data.

Fixes: 495184ac91bb ("mt76: mt7915: add support for applying pre-calibration data")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 033fb592bdf0..30bf41b8ed15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -33,7 +33,7 @@ enum mt7915_eeprom_field {
 #define MT_EE_WIFI_CAL_GROUP			BIT(0)
 #define MT_EE_WIFI_CAL_DPD			GENMASK(2, 1)
 #define MT_EE_CAL_UNIT				1024
-#define MT_EE_CAL_GROUP_SIZE			(44 * MT_EE_CAL_UNIT)
+#define MT_EE_CAL_GROUP_SIZE			(49 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_DPD_SIZE			(54 * MT_EE_CAL_UNIT)
 
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
-- 
2.18.0

