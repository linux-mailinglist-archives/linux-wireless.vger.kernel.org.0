Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E57409E8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjF1Hw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:57 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39066 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231156AbjF1Hwf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:35 -0400
X-UUID: 68f1df34158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DGHtdpSUNUDyjMIFfafiis6/Zc8Lw3Xy/RPktQszF7A=;
        b=ITnebdL7cmjWxDMMGkQKv/QtBbm9YyC7Gbxar6Ywf/kLFLvt6d8c4wLayvaTaV7RduCFKSpysKauuz1coCaE9QFTEzKfpyBE2JNw2GpA+wJyyWTONo6yAWeC7zQHsJICMnb7ZHyNDd3/VFmvIyikYtWTZJXNpC7XqL0P5U5LZDY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:73b099ca-267f-41ef-8b27-47594304d9ea,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.27,REQID:73b099ca-267f-41ef-8b27-47594304d9ea,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:01c9525,CLOUDID:4bd05eda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:230628150716P39NL0UG,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_SNR
X-UUID: 68f1df34158211ee9cb5633481061a41-20230628
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 247521921; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:13 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 02/16] wifi: mt76: mt7921: convert acpisar and clc pointers to void
Date:   Wed, 28 Jun 2023 15:05:48 +0800
Message-ID: <57707f32913ae0c3870153110f28d01c4f28ce80.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Convert acpisar and clc pointers in mt7921_dev structure to void.
This is a preliminary patch to add WiFi7 chipset support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
index 48dd0decac5d..6feea2e515b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
@@ -308,6 +308,7 @@ int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
 
 u8 mt7921_acpi_get_flags(struct mt7921_phy *phy)
 {
+	struct mt7921_acpi_sar *acpisar = phy->acpisar;
 	struct mt7921_asar_fg *fg;
 	struct {
 		u8 acpi_idx;
@@ -319,10 +320,10 @@ u8 mt7921_acpi_get_flags(struct mt7921_phy *phy)
 	u8 flags = BIT(0);
 	int i, j;
 
-	if (!phy->acpisar)
+	if (!acpisar)
 		return 0;
 
-	fg = phy->acpisar->fg;
+	fg = acpisar->fg;
 	if (!fg)
 		return flags;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index ec9879650174..2e29a6bda7ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -222,10 +222,9 @@ struct mt7921_phy {
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
 #ifdef CONFIG_ACPI
-	struct mt7921_acpi_sar *acpisar;
+	void *acpisar;
 #endif
-
-	struct mt7921_clc *clc[MT7921_CLC_MAX_NUM];
+	void *clc[MT7921_CLC_MAX_NUM];
 
 	struct work_struct roc_work;
 	struct timer_list roc_timer;
-- 
2.18.0

