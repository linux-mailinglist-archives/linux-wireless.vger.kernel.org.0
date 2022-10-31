Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C4613B79
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiJaQkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiJaQkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 12:40:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC12BC3
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 09:40:19 -0700 (PDT)
X-UUID: c86cb0e97aa1404ca78c3866a77dcbe1-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Kn5ON56E+2GGeTfZAHdKpdblBG6mvoErQSTcFC+fO0g=;
        b=irmIwhzlSIuDPdSt7VnuNfjqJjNm1KDtqxQc3PVAOCahaNKlwmaXKq90uYWjEruSVRZfpGYwPK201ZmPelSOPnznHjaDXBFAVhqO7T/GlX2/Ara0PRLqf/J3zVhBATkagDUxc6PHaz5QWcJXrQYMiaJXzD2sGE/VQD/IguH39LU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:fec8abca-d3f9-46bd-8e1f-601a8dad0bd3,IP:0,U
        RL:0,TC:0,Content:26,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:26
X-CID-META: VersionHash:62cd327,CLOUDID:edee2390-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c86cb0e97aa1404ca78c3866a77dcbe1-20221101
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1237564921; Tue, 01 Nov 2022 00:40:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 00:40:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 00:40:12 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 07/10] wifi: mt76: connac: add more bss info command tags
Date:   Tue, 1 Nov 2022 00:39:57 +0800
Message-ID: <20221031164000.17063-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221031164000.17063-1-shayne.chen@mediatek.com>
References: <20221031164000.17063-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add bss info tags which will be used in new chipset.
This is a preliminary patch to add mt7996 chipset support.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 909b2ba67c11..ed1d24822c37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1255,14 +1255,23 @@ enum {
 
 enum {
 	UNI_BSS_INFO_BASIC = 0,
+	UNI_BSS_INFO_RA = 1,
 	UNI_BSS_INFO_RLM = 2,
 	UNI_BSS_INFO_BSS_COLOR = 4,
 	UNI_BSS_INFO_HE_BASIC = 5,
 	UNI_BSS_INFO_BCN_CONTENT = 7,
+	UNI_BSS_INFO_BCN_CSA = 8,
+	UNI_BSS_INFO_BCN_BCC = 9,
+	UNI_BSS_INFO_BCN_MBSSID = 10,
+	UNI_BSS_INFO_RATE = 11,
 	UNI_BSS_INFO_QBSS = 15,
+	UNI_BSS_INFO_SEC = 16,
+	UNI_BSS_INFO_TXCMD = 18,
 	UNI_BSS_INFO_UAPSD = 19,
 	UNI_BSS_INFO_PS = 21,
 	UNI_BSS_INFO_BCNFT = 22,
+	UNI_BSS_INFO_OFFLOAD = 25,
+	UNI_BSS_INFO_MLD = 26,
 };
 
 enum {
-- 
2.25.1

