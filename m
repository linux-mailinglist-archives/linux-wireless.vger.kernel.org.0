Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7277E96E8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 08:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjKMHHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 02:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjKMHHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 02:07:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3884210F1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 23:07:34 -0800 (PST)
X-UUID: 4eb587b481f311ee8051498923ad61e6-20231113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NA6LYzpY1mbWRHVhVWlgLNvJwKLoJmdyJB5RWUv+vaw=;
        b=FprsBy44mX7qlXKF/r+vxlINNZ+n+wjKfm/kBEiedgWEJihRoBYPHAoHt4uBXAnUWSBFZKB4U45iHjL2zPONXZCvUuBlp5KvQPL9opNtYWE/t0MKHOEz1bRMBz5tN4Idymc9QdQt9F2WmyZx28XpoLRom7s4zyU0lI4ATSNbfPc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:1ed658c5-a72b-4df8-b304-70b295804ae0,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:8bb1fd5f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4eb587b481f311ee8051498923ad61e6-20231113
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1236172700; Mon, 13 Nov 2023 15:07:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 Nov 2023 15:07:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 Nov 2023 15:07:27 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 5/8] wifi: mt76: mt7996: support mt7992 eeprom loading
Date:   Mon, 13 Nov 2023 15:06:16 +0800
Message-ID: <20231113070619.19964-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231113070619.19964-1-shayne.chen@mediatek.com>
References: <20231113070619.19964-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Add the default eeprom and 0x7992 check to mt7996_check_eeprom().
This is a preliminary patch for mt7992 chipsets support.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/eeprom.c    | 15 ++++++++++++---
 .../net/wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 9db7e531076d..9c3735bed50c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -12,9 +12,12 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
 	u8 *eeprom = dev->mt76.eeprom.data;
 	u16 val = get_unaligned_le16(eeprom);
 
+#define CHECK_EEPROM_ERR(match)	(match ? 0 : -EINVAL)
 	switch (val) {
 	case 0x7990:
-		return 0;
+		return CHECK_EEPROM_ERR(is_mt7996(&dev->mt76));
+	case 0x7992:
+		return CHECK_EEPROM_ERR(is_mt7992(&dev->mt76));
 	default:
 		return -EINVAL;
 	}
@@ -22,8 +25,14 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
 
 static char *mt7996_eeprom_name(struct mt7996_dev *dev)
 {
-	/* reserve for future variants */
-	return MT7996_EEPROM_DEFAULT;
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7990:
+		return MT7996_EEPROM_DEFAULT;
+	case 0x7992:
+		return MT7992_EEPROM_DEFAULT;
+	default:
+		return MT7996_EEPROM_DEFAULT;
+	}
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 87822663870f..5cdde28ce83f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -39,6 +39,7 @@
 #define MT7992_ROM_PATCH		"mediatek/mt7996/mt7992_rom_patch.bin"
 
 #define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
+#define MT7992_EEPROM_DEFAULT		"mediatek/mt7996/mt7992_eeprom.bin"
 #define MT7996_EEPROM_SIZE		7680
 #define MT7996_EEPROM_BLOCK_SIZE	16
 #define MT7996_TOKEN_SIZE		16384
-- 
2.39.2

