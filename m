Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426233F578
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Mar 2021 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhCQQ2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Mar 2021 12:28:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36730 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232547AbhCQQ1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Mar 2021 12:27:44 -0400
X-UUID: cab759e53d7a4d7099d82dd2afcc5c96-20210318
X-UUID: cab759e53d7a4d7099d82dd2afcc5c96-20210318
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 378509917; Thu, 18 Mar 2021 00:27:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Mar 2021 00:27:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 00:27:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7622: add ePA/eLNA support
Date:   Thu, 18 Mar 2021 00:27:36 +0800
Message-ID: <1fb0ff65cb7d8c4f3197a87b43c26c5925e973ea.1615997929.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7D846F657E33A424517F43A1E3D6A28EA76700F69B8EB68FF761DD751EA164682000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch pinmux to enable ePA/eLNA support.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    | 29 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/eeprom.h    |  4 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 6dbaaf95ee38..d3182573163c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include "mt7615.h"
 #include "eeprom.h"
 
@@ -136,12 +137,40 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 	}
 }
 
+static void mt7615_eeprom_parse_hw_epa_cap(struct mt7615_dev *dev)
+{
+	struct pinctrl_state *state;
+	struct pinctrl *pinctrl;
+	u8 i, *eeprom = dev->mt76.eeprom.data;
+
+	if (!is_mt7622(&dev->mt76))
+		return;
+
+	i = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_PALNA, eeprom[MT_EE_WIFI_CONF]);
+	if (i != MT_EE_NIC_WIFI_CONF_EPA_ELNA &&
+	    i != MT_EE_NIC_WIFI_CONF_IPA_ELNA)
+		return;
+
+	pinctrl = devm_pinctrl_get(dev->mt76.dev);
+	if (IS_ERR(pinctrl))
+		return;
+
+	state = pinctrl_lookup_state(pinctrl, "epa-state");
+	if (IS_ERR(state))
+		goto out;
+
+	pinctrl_select_state(pinctrl, state);
+out:
+	devm_pinctrl_put(pinctrl);
+}
+
 static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 {
 	u8 *eeprom = dev->mt76.eeprom.data;
 	u8 tx_mask, max_nss;
 
 	mt7615_eeprom_parse_hw_band_cap(dev);
+	mt7615_eeprom_parse_hw_epa_cap(dev);
 
 	if (is_mt7663(&dev->mt76)) {
 		max_nss = 2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index a024dee10362..a609c4bb108c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -64,7 +64,11 @@ enum mt7615_eeprom_field {
 #define MT_EE_NIC_CONF_TSSI_2G			BIT(5)
 #define MT_EE_NIC_CONF_TSSI_5G			BIT(6)
 
+#define MT_EE_NIC_WIFI_CONF_BAND_PALNA		GENMASK(3, 2)
+#define MT_EE_NIC_WIFI_CONF_IPA_ELNA		0x1
+#define MT_EE_NIC_WIFI_CONF_EPA_ELNA		0x2
 #define MT_EE_NIC_WIFI_CONF_BAND_SEL		GENMASK(5, 4)
+
 enum mt7615_eeprom_band {
 	MT_EE_DUAL_BAND,
 	MT_EE_5GHZ,
-- 
2.18.0

