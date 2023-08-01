Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE776B7A7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjHAOfz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjHAOfx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:35:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15BC10C3
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:35:51 -0700 (PDT)
X-UUID: b2162d76307811eeb20a276fd37b9834-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MngREa3tzTztuZpub6LB7rywTQ1g699xg/PwMcMxFuM=;
        b=BrWXNwXcNauJsZUegaMk/2xHtMV6ChK1mP0F18Ekz5zmAHqEOb+yN8iJbQ0X/7lClwMuuJVXZs1ibDBhvzG4bVSLpo1xkKBdFAlSINAQSCpd2nM3U3ZKI26b+6ofmEaK+evc4hT5rznRE59MZqQ6Oe1VL1UVaE6O3Ro9PAnm6vE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:e97c4d22-a506-4433-9016-23f5b118042b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:e97c4d22-a506-4433-9016-23f5b118042b,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:e08e91d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230801223546HGRJFCTL,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: b2162d76307811eeb20a276fd37b9834-20230801
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 930468485; Tue, 01 Aug 2023 22:35:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:35:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:35:42 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 04/17] wifi: mt76: mt7925: add regs.h
Date:   Tue, 1 Aug 2023 22:34:20 +0800
Message-ID: <2b31c82a7bef889f7ac1ff328fec75ec5d5aeb8a.1690864199.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690864199.git.deren.wu@mediatek.com>
References: <cover.1690864199.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/regs.h  | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regs.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
new file mode 100644
index 000000000000..985794a40c1a
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT7925_REGS_H
+#define __MT7925_REGS_H
+
+#include "../mt792x_regs.h"
+
+#define MT_MDP_BASE			0x820cc800
+#define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
+
+#define MT_MDP_DCR0			MT_MDP(0x000)
+#define MT_MDP_DCR0_DAMSDU_EN		BIT(15)
+#define MT_MDP_DCR0_RX_HDR_TRANS_EN	BIT(19)
+
+#define MT_MDP_DCR1			MT_MDP(0x004)
+#define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
+
+#define MT_MDP_BNRCFR0(_band)		MT_MDP(0x090 + ((_band) << 8))
+#define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
+#define MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR	GENMASK(7, 6)
+#define MT_MDP_RCFR0_MCU_RX_CTL_BAR	GENMASK(9, 8)
+
+#define MT_MDP_BNRCFR1(_band)		MT_MDP(0x094 + ((_band) << 8))
+#define MT_MDP_RCFR1_MCU_RX_BYPASS	GENMASK(23, 22)
+#define MT_MDP_RCFR1_RX_DROPPED_UCAST	GENMASK(28, 27)
+#define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
+#define MT_MDP_TO_HIF			0
+#define MT_MDP_TO_WM			1
+
+#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x228)
+#define MT_WFDMA0_HOST_INT_DIS		MT_WFDMA0(0x22c)
+#define HOST_RX_DONE_INT_ENA4		BIT(12)
+#define HOST_RX_DONE_INT_ENA5		BIT(13)
+#define HOST_RX_DONE_INT_ENA6		BIT(14)
+#define HOST_RX_DONE_INT_ENA7		BIT(15)
+#define HOST_RX_DONE_INT_ENA8		BIT(16)
+#define HOST_RX_DONE_INT_ENA9		BIT(17)
+#define HOST_RX_DONE_INT_ENA10		BIT(18)
+#define HOST_RX_DONE_INT_ENA11		BIT(19)
+#define HOST_TX_DONE_INT_ENA15		BIT(25)
+#define HOST_TX_DONE_INT_ENA16		BIT(26)
+#define HOST_TX_DONE_INT_ENA17		BIT(27)
+
+/* WFDMA interrupt */
+#define MT_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
+#define MT_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA0
+#define MT_INT_RX_DONE_WM2		HOST_RX_DONE_INT_ENA1
+#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_DATA | \
+					 MT_INT_RX_DONE_WM | \
+					 MT_INT_RX_DONE_WM2)
+
+#define MT_INT_TX_DONE_MCU_WM		(HOST_TX_DONE_INT_ENA15 | \
+					 HOST_TX_DONE_INT_ENA17)
+
+#define MT_INT_TX_DONE_FWDL		HOST_TX_DONE_INT_ENA16
+#define MT_INT_TX_DONE_BAND0		HOST_TX_DONE_INT_ENA0
+
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_FWDL)
+#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_BAND0 |	\
+					GENMASK(18, 4))
+
+#define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x500)
+
+#define MT_INFRA_CFG_BASE		0xd1000
+#define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
+
+#define MT_HIF_REMAP_L1			0x155024
+#define MT_HIF_REMAP_L1_MASK		GENMASK(31, 16)
+#define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L1		0x130000
+
+#define MT_HIF_REMAP_L2			0x0120
+#if IS_ENABLED(CONFIG_MT76_DEV)
+#define MT_HIF_REMAP_BASE_L2		(0x7c500000 - (0x7c000000 - 0x18000000))
+#else
+#define MT_HIF_REMAP_BASE_L2		0x18500000
+#endif
+
+#define MT_WFSYS_SW_RST_B		0x7c000140
+
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x370)
+#define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(4, 0)
+
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x380)
+#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(11, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(14)
+
+#endif
-- 
2.18.0

