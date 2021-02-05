Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10652310463
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 06:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBEFNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 00:13:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59373 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229586AbhBEFNu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 00:13:50 -0500
X-UUID: ad4a54f2fe0a46fab3fb45cd25694174-20210205
X-UUID: ad4a54f2fe0a46fab3fb45cd25694174-20210205
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1966953423; Fri, 05 Feb 2021 13:13:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Feb 2021 13:13:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Feb 2021 13:13:02 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: always use WTBL_MAX_SIZE for tlv allocation
Date:   Fri, 5 Feb 2021 13:13:01 +0800
Message-ID: <83ac342b16fbe9a97c91fffa00e5b04644daae9f.1612501861.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6E98898A79103BD3DCE0A041DCCD3BA9A652525557F73286FCC57A4D724CF8C12000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify WTBL defines.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 24 -------------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 ---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  3 ---
 5 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 3874f45da9eb..411ebb56baef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -362,30 +362,6 @@ enum {
 	BSS_INFO_MAX_NUM
 };
 
-#define MT7615_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
-					 sizeof(struct wtbl_generic) +	\
-					 sizeof(struct wtbl_rx) +	\
-					 sizeof(struct wtbl_ht) +	\
-					 sizeof(struct wtbl_vht) +	\
-					 sizeof(struct wtbl_tx_ps) +	\
-					 sizeof(struct wtbl_hdr_trans) +\
-					 sizeof(struct wtbl_ba) +	\
-					 sizeof(struct wtbl_bf) +	\
-					 sizeof(struct wtbl_smps) +	\
-					 sizeof(struct wtbl_pn) +	\
-					 sizeof(struct wtbl_spe))
-
-#define MT7615_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
-					 sizeof(struct sta_rec_basic) +	\
-					 sizeof(struct sta_rec_ht) +	\
-					 sizeof(struct sta_rec_vht) +	\
-					 sizeof(struct sta_rec_uapsd) + \
-					 sizeof(struct tlv) +	\
-					 MT7615_WTBL_UPDATE_MAX_SIZE)
-
-#define MT7615_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
-					 sizeof(struct wtbl_ba))
-
 enum {
 	CH_SWITCH_NORMAL = 0,
 	CH_SWITCH_SCAN = 3,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6cbccfb05f8b..e6ad6cbeb803 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -287,7 +287,7 @@ mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
 				     &hdr.wlan_idx_hi);
 	if (!nskb) {
 		nskb = mt76_mcu_msg_alloc(dev, NULL,
-					  MT76_CONNAC_WTBL_UPDATE_BA_SIZE);
+					  MT76_CONNAC_WTBL_UPDATE_MAX_SIZE);
 		if (!nskb)
 			return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index c1e1df5f7cd7..9c26b90655a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -304,9 +304,6 @@ struct wtbl_raw {
 					 sizeof(struct tlv) +		\
 					 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE)
 
-#define MT76_CONNAC_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
-					 sizeof(struct wtbl_ba))
-
 enum {
 	STA_REC_BASIC,
 	STA_REC_RA,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0296f2aa7997..e0aff0ea2f75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -592,7 +592,7 @@ mt7915_mcu_alloc_wtbl_req(struct mt7915_dev *dev, struct mt7915_sta *msta,
 
 	if (!nskb) {
 		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-					  MT7915_WTBL_UPDATE_BA_SIZE);
+					  MT7915_WTBL_UPDATE_MAX_SIZE);
 		if (!nskb)
 			return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 2d584142c27b..2a2f7bf2c94b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1080,9 +1080,6 @@ enum {
 					 sizeof(struct tlv) +		\
 					 MT7915_WTBL_UPDATE_MAX_SIZE)
 
-#define MT7915_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
-					 sizeof(struct wtbl_ba))
-
 #define MT7915_BSS_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
 					 sizeof(struct bss_info_omac) +	\
 					 sizeof(struct bss_info_basic) +\
-- 
2.18.0

