Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365C07409D8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjF1Hw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:28 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38820 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230108AbjF1HwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:25 -0400
X-UUID: 69395d96158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w38f/fRMxmxiegKROlzCwh4aOcow11qLMppJ2oFzKco=;
        b=BuLVNrxf570y6rQMPsVxbAc4uyUHmqB3BO6i82Lo7kDYMUi0ihWp/xB+1gEx71B1ADKPCzBDZk6eDgAXSXIvtYE5k/YfqSlTQDpgeCThAGlfc4Ad/NC9UIazo6kEy0qCptGRGuVixzN41IzspkCRo87F7j7y82j1FHjkd/kZ2Ds=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:b7073ac7-6bc1-46f5-97c4-e3935535af5a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:b7073ac7-6bc1-46f5-97c4-e3935535af5a,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:9c7b9b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230628150716R3EPWWF3,BulkQuantity:1,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 69395d96158211ee9cb5633481061a41-20230628
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 691345480; Wed, 28 Jun 2023 15:07:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
Subject: [PATCH 01/16] wifi: mt76: mt7921: move common register definition in mt792x_regs.h
Date:   Wed, 28 Jun 2023 15:05:47 +0800
Message-ID: <5b48528a224d9cbb3835612f10982b350f150d89.1687919628.git.deren.wu@mediatek.com>
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

This is a preliminary patch in order to support new WiFi7 chips.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 443 +----------------
 .../net/wireless/mediatek/mt76/mt792x_regs.h  | 460 ++++++++++++++++++
 2 files changed, 463 insertions(+), 440 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_regs.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index b180142562a2..fefc10539586 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -4,26 +4,7 @@
 #ifndef __MT7921_REGS_H
 #define __MT7921_REGS_H
 
-/* MCU WFDMA1 */
-#define MT_MCU_WFDMA1_BASE		0x3000
-#define MT_MCU_WFDMA1(ofs)		(MT_MCU_WFDMA1_BASE + (ofs))
-
-#define MT_MCU_INT_EVENT		MT_MCU_WFDMA1(0x108)
-#define MT_MCU_INT_EVENT_DMA_STOPPED	BIT(0)
-#define MT_MCU_INT_EVENT_DMA_INIT	BIT(1)
-#define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
-#define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
-
-#define MT_PLE_BASE			0x820c0000
-#define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
-
-#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x3e0)
-#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x3e4)
-#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x3e8)
-#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x3ec)
-
-#define MT_PLE_AC_QEMPTY(_n)		MT_PLE(0x500 + 0x40 * (_n))
-#define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
+#include "../mt792x_regs.h"
 
 #define MT_MDP_BASE			0x820cd000
 #define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
@@ -47,266 +28,6 @@
 #define MT_MDP_TO_HIF			0
 #define MT_MDP_TO_WM			1
 
-/* TMAC: band 0(0x21000), band 1(0xa1000) */
-#define MT_WF_TMAC_BASE(_band)		((_band) ? 0x820f4000 : 0x820e4000)
-#define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
-
-#define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
-#define MT_TMAC_TCR0_TBTT_STOP_CTRL	BIT(25)
-
-#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, 0x090)
-#define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, 0x094)
-#define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
-#define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
-
-#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
-#define MT_IFS_EIFS			GENMASK(8, 0)
-#define MT_IFS_RIFS			GENMASK(14, 10)
-#define MT_IFS_SIFS			GENMASK(22, 16)
-#define MT_IFS_SLOT			GENMASK(30, 24)
-
-#define MT_TMAC_CTCR0(_band)			MT_WF_TMAC(_band, 0x0f4)
-#define MT_TMAC_CTCR0_INS_DDLMT_REFTIME		GENMASK(5, 0)
-#define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
-#define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
-
-#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
-#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
-
-#define MT_WF_DMA_BASE(_band)		((_band) ? 0x820f7000 : 0x820e7000)
-#define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
-
-#define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
-#define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
-#define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
-
-/* WTBLOFF TOP: band 0(0x820e9000),band 1(0x820f9000) */
-#define MT_WTBLOFF_TOP_BASE(_band)	((_band) ? 0x820f9000 : 0x820e9000)
-#define MT_WTBLOFF_TOP(_band, ofs)	(MT_WTBLOFF_TOP_BASE(_band) + (ofs))
-
-#define MT_WTBLOFF_TOP_RSCR(_band)	MT_WTBLOFF_TOP(_band, 0x008)
-#define MT_WTBLOFF_TOP_RSCR_RCPI_MODE	GENMASK(31, 30)
-#define MT_WTBLOFF_TOP_RSCR_RCPI_PARAM	GENMASK(25, 24)
-
-/* LPON: band 0(0x24200), band 1(0xa4200) */
-#define MT_WF_LPON_BASE(_band)		((_band) ? 0x820fb000 : 0x820eb000)
-#define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
-
-#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
-#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, 0x084)
-
-#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
-#define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
-#define MT_LPON_TCR_SW_WRITE		BIT(0)
-
-/* ETBF: band 0(0x24000), band 1(0xa4000) */
-#define MT_WF_ETBF_BASE(_band)		((_band) ? 0x820fa000 : 0x820ea000)
-#define MT_WF_ETBF(_band, ofs)		(MT_WF_ETBF_BASE(_band) + (ofs))
-
-#define MT_ETBF_TX_APP_CNT(_band)	MT_WF_ETBF(_band, 0x150)
-#define MT_ETBF_TX_IBF_CNT		GENMASK(31, 16)
-#define MT_ETBF_TX_EBF_CNT		GENMASK(15, 0)
-
-#define MT_ETBF_RX_FB_CNT(_band)	MT_WF_ETBF(_band, 0x158)
-#define MT_ETBF_RX_FB_ALL		GENMASK(31, 24)
-#define MT_ETBF_RX_FB_HE		GENMASK(23, 16)
-#define MT_ETBF_RX_FB_VHT		GENMASK(15, 8)
-#define MT_ETBF_RX_FB_HT		GENMASK(7, 0)
-
-/* MIB: band 0(0x24800), band 1(0xa4800) */
-#define MT_WF_MIB_BASE(_band)		((_band) ? 0x820fd000 : 0x820ed000)
-#define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
-
-#define MT_MIB_SCR1(_band)		MT_WF_MIB(_band, 0x004)
-#define MT_MIB_TXDUR_EN			BIT(8)
-#define MT_MIB_RXDUR_EN			BIT(9)
-
-#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x698)
-#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(31, 16)
-
-#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x780)
-
-#define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
-#define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
-
-#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, 0x558)
-#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, 0x564)
-#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, 0x568)
-
-#define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, 0x048)
-#define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
-
-#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, 0x770)
-#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, 0x774)
-#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, 0x55c)
-
-#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x7a8)
-#define MT_MIB_SDR9_IBF_CNT_MASK	GENMASK(31, 16)
-#define MT_MIB_SDR9_EBF_CNT_MASK	GENMASK(15, 0)
-
-#define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
-#define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
-
-#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x054)
-#define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
-#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x058)
-#define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
-
-#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
-#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
-#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
-
-#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, 0x100 + ((n) << 4))
-#define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
-
-#define MT_MIB_MB_BSDR0(_band)		MT_WF_MIB(_band, 0x688)
-#define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
-#define MT_MIB_MB_BSDR1(_band)		MT_WF_MIB(_band, 0x690)
-#define MT_MIB_RTS_FAIL_COUNT_MASK	GENMASK(15, 0)
-#define MT_MIB_MB_BSDR2(_band)		MT_WF_MIB(_band, 0x518)
-#define MT_MIB_BA_FAIL_COUNT_MASK	GENMASK(15, 0)
-#define MT_MIB_MB_BSDR3(_band)		MT_WF_MIB(_band, 0x520)
-#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(15, 0)
-
-#define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
-#define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
-
-#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x7dc + ((n) << 2))
-#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x7ec + ((n) << 2))
-#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
-#define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
-
-#define MT_WTBLON_TOP_BASE		0x820d4000
-#define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
-#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
-#define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
-
-#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x230)
-#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
-#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
-#define MT_WTBL_UPDATE_BUSY		BIT(31)
-
-#define MT_WTBL_BASE			0x820d8000
-#define MT_WTBL_LMAC_ID			GENMASK(14, 8)
-#define MT_WTBL_LMAC_DW			GENMASK(7, 2)
-#define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
-					FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
-					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
-
-/* AGG: band 0(0x20800), band 1(0xa0800) */
-#define MT_WF_AGG_BASE(_band)		((_band) ? 0x820f2000 : 0x820e2000)
-#define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
-
-#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
-#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, 0x06c + (_n) * 4)
-#define MT_AGG_PCR0_MM_PROT		BIT(0)
-#define MT_AGG_PCR0_GF_PROT		BIT(1)
-#define MT_AGG_PCR0_BW20_PROT		BIT(2)
-#define MT_AGG_PCR0_BW40_PROT		BIT(4)
-#define MT_AGG_PCR0_BW80_PROT		BIT(6)
-#define MT_AGG_PCR0_ERP_PROT		GENMASK(12, 8)
-#define MT_AGG_PCR0_VHT_PROT		BIT(13)
-#define MT_AGG_PCR0_PTA_WIN_DIS		BIT(15)
-
-#define MT_AGG_PCR1_RTS0_NUM_THRES	GENMASK(31, 23)
-#define MT_AGG_PCR1_RTS0_LEN_THRES	GENMASK(19, 0)
-
-#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, 0x084)
-#define MT_AGG_ACR_CFEND_RATE		GENMASK(13, 0)
-#define MT_AGG_ACR_BAR_RATE		GENMASK(29, 16)
-
-#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, 0x098)
-#define MT_AGG_MRCR_BAR_CNT_LIMIT	GENMASK(15, 12)
-#define MT_AGG_MRCR_LAST_RTS_CTS_RN	BIT(6)
-#define MT_AGG_MRCR_RTS_FAIL_LIMIT	GENMASK(11, 7)
-#define MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT	GENMASK(28, 24)
-
-#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, 0x0f0)
-#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
-
-/* ARB: band 0(0x20c00), band 1(0xa0c00) */
-#define MT_WF_ARB_BASE(_band)		((_band) ? 0x820f3000 : 0x820e3000)
-#define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
-
-#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
-#define MT_ARB_SCR_TX_DISABLE		BIT(8)
-#define MT_ARB_SCR_RX_DISABLE		BIT(9)
-
-#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
-
-/* RMAC: band 0(0x21400), band 1(0xa1400) */
-#define MT_WF_RMAC_BASE(_band)		((_band) ? 0x820f5000 : 0x820e5000)
-#define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
-
-#define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
-#define MT_WF_RFCR_DROP_STBC_MULTI	BIT(0)
-#define MT_WF_RFCR_DROP_FCSFAIL		BIT(1)
-#define MT_WF_RFCR_DROP_VERSION		BIT(3)
-#define MT_WF_RFCR_DROP_PROBEREQ	BIT(4)
-#define MT_WF_RFCR_DROP_MCAST		BIT(5)
-#define MT_WF_RFCR_DROP_BCAST		BIT(6)
-#define MT_WF_RFCR_DROP_MCAST_FILTERED	BIT(7)
-#define MT_WF_RFCR_DROP_A3_MAC		BIT(8)
-#define MT_WF_RFCR_DROP_A3_BSSID	BIT(9)
-#define MT_WF_RFCR_DROP_A2_BSSID	BIT(10)
-#define MT_WF_RFCR_DROP_OTHER_BEACON	BIT(11)
-#define MT_WF_RFCR_DROP_FRAME_REPORT	BIT(12)
-#define MT_WF_RFCR_DROP_CTL_RSV		BIT(13)
-#define MT_WF_RFCR_DROP_CTS		BIT(14)
-#define MT_WF_RFCR_DROP_RTS		BIT(15)
-#define MT_WF_RFCR_DROP_DUPLICATE	BIT(16)
-#define MT_WF_RFCR_DROP_OTHER_BSS	BIT(17)
-#define MT_WF_RFCR_DROP_OTHER_UC	BIT(18)
-#define MT_WF_RFCR_DROP_OTHER_TIM	BIT(19)
-#define MT_WF_RFCR_DROP_NDPA		BIT(20)
-#define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
-
-#define MT_WF_RFCR1(_band)		MT_WF_RMAC(_band, 0x004)
-#define MT_WF_RFCR1_DROP_ACK		BIT(4)
-#define MT_WF_RFCR1_DROP_BF_POLL	BIT(5)
-#define MT_WF_RFCR1_DROP_BA		BIT(6)
-#define MT_WF_RFCR1_DROP_CFEND		BIT(7)
-#define MT_WF_RFCR1_DROP_CFACK		BIT(8)
-
-#define MT_WF_RMAC_MIB_TIME0(_band)	MT_WF_RMAC(_band, 0x03c4)
-#define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
-#define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
-
-#define MT_WF_RMAC_MIB_AIRTIME14(_band)	MT_WF_RMAC(_band, 0x03b8)
-#define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
-#define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
-
-/* WFDMA0 */
-#define MT_WFDMA0_BASE			0xd4000
-#define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
-
-#define MT_WFDMA0_RST			MT_WFDMA0(0x100)
-#define MT_WFDMA0_RST_LOGIC_RST		BIT(4)
-#define MT_WFDMA0_RST_DMASHDL_ALL_RST	BIT(5)
-
-#define MT_WFDMA0_BUSY_ENA		MT_WFDMA0(0x13c)
-#define MT_WFDMA0_BUSY_ENA_TX_FIFO0	BIT(0)
-#define MT_WFDMA0_BUSY_ENA_TX_FIFO1	BIT(1)
-#define MT_WFDMA0_BUSY_ENA_RX_FIFO	BIT(2)
-
-#define MT_MCU_CMD			MT_WFDMA0(0x1f0)
-#define MT_MCU_CMD_WAKE_RX_PCIE		BIT(0)
-#define MT_MCU_CMD_STOP_DMA_FW_RELOAD	BIT(1)
-#define MT_MCU_CMD_STOP_DMA		BIT(2)
-#define MT_MCU_CMD_RESET_DONE		BIT(3)
-#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
-#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
-#define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
-
-#define MT_MCU2HOST_SW_INT_ENA		MT_WFDMA0(0x1f4)
-
-#define MT_WFDMA0_HOST_INT_STA		MT_WFDMA0(0x200)
-#define HOST_RX_DONE_INT_STS0		BIT(0)	/* Rx mcu */
-#define HOST_RX_DONE_INT_STS2		BIT(2)	/* Rx data */
-#define HOST_RX_DONE_INT_STS4		BIT(22)	/* Rx mcu after fw downloaded */
-#define HOST_TX_DONE_INT_STS16		BIT(26)
-#define HOST_TX_DONE_INT_STS17		BIT(27) /* MCU tx done*/
-
 #define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
 #define HOST_RX_DONE_INT_ENA0		BIT(0)
 #define HOST_RX_DONE_INT_ENA1		BIT(1)
@@ -354,56 +75,8 @@
 					 MT_INT_TX_DONE_BAND0 |	\
 					GENMASK(18, 4))
 
-#define MT_WFDMA0_GLO_CFG		MT_WFDMA0(0x208)
-#define MT_WFDMA0_GLO_CFG_TX_DMA_EN	BIT(0)
-#define MT_WFDMA0_GLO_CFG_TX_DMA_BUSY	BIT(1)
-#define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
-#define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
-#define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
-#define MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL BIT(9)
-#define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
-#define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
-#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
-#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
-#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
-#define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
-
-#define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
-#define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
-#define MT_WFDMA0_CSR_TX_DMASHDL_ENABLE	BIT(6)
-#define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
-
 #define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x520)
 
-#define MT_WFDMA0_TX_RING0_EXT_CTRL	MT_WFDMA0(0x600)
-#define MT_WFDMA0_TX_RING1_EXT_CTRL	MT_WFDMA0(0x604)
-#define MT_WFDMA0_TX_RING2_EXT_CTRL	MT_WFDMA0(0x608)
-#define MT_WFDMA0_TX_RING3_EXT_CTRL	MT_WFDMA0(0x60c)
-#define MT_WFDMA0_TX_RING4_EXT_CTRL	MT_WFDMA0(0x610)
-#define MT_WFDMA0_TX_RING5_EXT_CTRL	MT_WFDMA0(0x614)
-#define MT_WFDMA0_TX_RING6_EXT_CTRL	MT_WFDMA0(0x618)
-#define MT_WFDMA0_TX_RING16_EXT_CTRL	MT_WFDMA0(0x640)
-#define MT_WFDMA0_TX_RING17_EXT_CTRL	MT_WFDMA0(0x644)
-
-#define MT_WPDMA0_MAX_CNT_MASK		GENMASK(7, 0)
-#define MT_WPDMA0_BASE_PTR_MASK		GENMASK(31, 16)
-
-#define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
-#define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
-#define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
-#define MT_WFDMA0_RX_RING3_EXT_CTRL	MT_WFDMA0(0x68c)
-#define MT_WFDMA0_RX_RING4_EXT_CTRL	MT_WFDMA0(0x690)
-#define MT_WFDMA0_RX_RING5_EXT_CTRL	MT_WFDMA0(0x694)
-
-#define MT_TX_RING_BASE			MT_WFDMA0(0x300)
-#define MT_RX_EVENT_RING_BASE		MT_WFDMA0(0x500)
-
-/* WFDMA CSR */
-#define MT_WFDMA_EXT_CSR_BASE          0xd7000
-#define MT_WFDMA_EXT_CSR(ofs)          (MT_WFDMA_EXT_CSR_BASE + (ofs))
-#define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
-#define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
-
 #define MT_INFRA_CFG_BASE		0xfe000
 #define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
 
@@ -413,121 +86,11 @@
 #define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
 #define MT_HIF_REMAP_BASE_L1		0x40000
 
-#define MT_SWDEF_BASE			0x41f200
-#define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
-#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
-#define MT_SWDEF_NORMAL_MODE		0
-#define MT_SWDEF_ICAP_MODE		1
-#define MT_SWDEF_SPECTRUM_MODE		2
-
-#define MT_TOP_BASE			0x18060000
-#define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
-
-#define MT_TOP_LPCR_HOST_BAND0		MT_TOP(0x10)
-#define MT_TOP_LPCR_HOST_FW_OWN		BIT(0)
-#define MT_TOP_LPCR_HOST_DRV_OWN	BIT(1)
-
-#define MT_TOP_MISC			MT_TOP(0xf0)
-#define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
-
-#define MT_MCU_WPDMA0_BASE		0x54000000
-#define MT_MCU_WPDMA0(ofs)		(MT_MCU_WPDMA0_BASE + (ofs))
-
-#define MT_WFDMA_DUMMY_CR		MT_MCU_WPDMA0(0x120)
-#define MT_WFDMA_NEED_REINIT		BIT(1)
-
-#define MT_CBTOP_RGU(ofs)		(0x70002000 + (ofs))
-#define MT_CBTOP_RGU_WF_SUBSYS_RST	MT_CBTOP_RGU(0x600)
-#define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
-
-#define MT_HW_BOUND			0x70010020
-#define MT_HW_CHIPID			0x70010200
-#define MT_HW_REV			0x70010204
-
-#define MT_PCIE_MAC_BASE		0x10000
-#define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
-#define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
-#define MT_PCIE_MAC_PM			MT_PCIE_MAC(0x194)
-#define MT_PCIE_MAC_PM_L0S_DIS		BIT(8)
-
-#define MT_DMA_SHDL(ofs)		(0x7c026000 + (ofs))
-#define MT_DMASHDL_SW_CONTROL		MT_DMA_SHDL(0x004)
-#define MT_DMASHDL_DMASHDL_BYPASS	BIT(28)
-#define MT_DMASHDL_OPTIONAL		MT_DMA_SHDL(0x008)
-#define MT_DMASHDL_PAGE			MT_DMA_SHDL(0x00c)
-#define MT_DMASHDL_GROUP_SEQ_ORDER	BIT(16)
-#define MT_DMASHDL_REFILL		MT_DMA_SHDL(0x010)
-#define MT_DMASHDL_REFILL_MASK		GENMASK(31, 16)
-#define MT_DMASHDL_PKT_MAX_SIZE		MT_DMA_SHDL(0x01c)
-#define MT_DMASHDL_PKT_MAX_SIZE_PLE	GENMASK(11, 0)
-#define MT_DMASHDL_PKT_MAX_SIZE_PSE	GENMASK(27, 16)
-
-#define MT_DMASHDL_GROUP_QUOTA(_n)	MT_DMA_SHDL(0x020 + ((_n) << 2))
-#define MT_DMASHDL_GROUP_QUOTA_MIN	GENMASK(11, 0)
-#define MT_DMASHDL_GROUP_QUOTA_MAX	GENMASK(27, 16)
-
-#define MT_DMASHDL_Q_MAP(_n)		MT_DMA_SHDL(0x060 + ((_n) << 2))
-#define MT_DMASHDL_Q_MAP_MASK		GENMASK(3, 0)
-#define MT_DMASHDL_Q_MAP_SHIFT(_n)	(4 * ((_n) % 8))
-
-#define MT_DMASHDL_SCHED_SET(_n)	MT_DMA_SHDL(0x070 + ((_n) << 2))
-
-#define MT_WFDMA_HOST_CONFIG		0x7c027030
-#define MT_WFDMA_HOST_CONFIG_USB_RXEVT_EP4_EN	BIT(6)
-
-#define MT_UMAC(ofs)			(0x74000000 + (ofs))
-#define MT_UDMA_TX_QSEL			MT_UMAC(0x008)
-#define MT_FW_DL_EN			BIT(3)
-
-#define MT_UDMA_WLCFG_1			MT_UMAC(0x00c)
-#define MT_WL_RX_AGG_PKT_LMT		GENMASK(7, 0)
-#define MT_WL_TX_TMOUT_LMT		GENMASK(27, 8)
-
-#define MT_UDMA_WLCFG_0			MT_UMAC(0x18)
-#define MT_WL_RX_AGG_TO			GENMASK(7, 0)
-#define MT_WL_RX_AGG_LMT		GENMASK(15, 8)
-#define MT_WL_TX_TMOUT_FUNC_EN		BIT(16)
-#define MT_WL_TX_DPH_CHK_EN		BIT(17)
-#define MT_WL_RX_MPSZ_PAD0		BIT(18)
-#define MT_WL_RX_FLUSH			BIT(19)
-#define MT_TICK_1US_EN			BIT(20)
-#define MT_WL_RX_AGG_EN			BIT(21)
-#define MT_WL_RX_EN			BIT(22)
-#define MT_WL_TX_EN			BIT(23)
-#define MT_WL_RX_BUSY			BIT(30)
-#define MT_WL_TX_BUSY			BIT(31)
-
-#define MT_UDMA_CONN_INFRA_STATUS	MT_UMAC(0xa20)
-#define MT_UDMA_CONN_WFSYS_INIT_DONE	BIT(22)
-#define MT_UDMA_CONN_INFRA_STATUS_SEL	MT_UMAC(0xa24)
-
-#define MT_SSUSB_EPCTL_CSR(ofs)		(0x74011800 + (ofs))
-#define MT_SSUSB_EPCTL_CSR_EP_RST_OPT	MT_SSUSB_EPCTL_CSR(0x090)
-
-#define MT_UWFDMA0(ofs)			(0x7c024000 + (ofs))
-#define MT_UWFDMA0_GLO_CFG		MT_UWFDMA0(0x208)
-#define MT_UWFDMA0_GLO_CFG_EXT0		MT_UWFDMA0(0x2b0)
-#define MT_UWFDMA0_TX_RING_EXT_CTRL(_n)	MT_UWFDMA0(0x600 + ((_n) << 2))
-
-#define MT_CONN_STATUS			0x7c053c10
-#define MT_WIFI_PATCH_DL_STATE		BIT(0)
-
-#define MT_CONN_ON_LPCTL		0x7c060010
-#define PCIE_LPCR_HOST_OWN_SYNC		BIT(2)
-#define PCIE_LPCR_HOST_CLR_OWN		BIT(1)
-#define PCIE_LPCR_HOST_SET_OWN		BIT(0)
-
 #define MT_WFSYS_SW_RST_B		0x18000140
 #define WFSYS_SW_RST_B			BIT(0)
 #define WFSYS_SW_INIT_DONE		BIT(4)
 
-#define MT_CONN_ON_MISC			0x7c0600f0
-#define MT_TOP_MISC2_FW_PWR_ON		BIT(0)
-#define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
-
-#define MT_WF_SW_DEF_CR(ofs)		(0x401a00 + (ofs))
-#define MT_WF_SW_DEF_CR_USB_MCU_EVENT	MT_WF_SW_DEF_CR(0x028)
-#define MT_WF_SW_SER_TRIGGER_SUSPEND	BIT(6)
-#define MT_WF_SW_SER_DONE_SUSPEND	BIT(7)
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
+#define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
new file mode 100644
index 000000000000..aa6a677427a4
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -0,0 +1,460 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT792X_REGS_H
+#define __MT792X_REGS_H
+
+/* MCU WFDMA1 */
+#define MT_MCU_WFDMA1_BASE		0x3000
+#define MT_MCU_WFDMA1(ofs)		(MT_MCU_WFDMA1_BASE + (ofs))
+
+#define MT_MCU_INT_EVENT		MT_MCU_WFDMA1(0x108)
+#define MT_MCU_INT_EVENT_DMA_STOPPED	BIT(0)
+#define MT_MCU_INT_EVENT_DMA_INIT	BIT(1)
+#define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
+#define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
+
+#define MT_PLE_BASE			0x820c0000
+#define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
+
+#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x3e0)
+#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x3e4)
+#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x3e8)
+#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x3ec)
+
+#define MT_PLE_AC_QEMPTY(_n)		MT_PLE(0x500 + 0x40 * (_n))
+#define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
+
+/* TMAC: band 0(0x21000), band 1(0xa1000) */
+#define MT_WF_TMAC_BASE(_band)		((_band) ? 0x820f4000 : 0x820e4000)
+#define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
+
+#define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
+#define MT_TMAC_TCR0_TBTT_STOP_CTRL	BIT(25)
+
+#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, 0x090)
+#define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, 0x094)
+#define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
+#define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
+
+#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
+#define MT_IFS_EIFS			GENMASK(8, 0)
+#define MT_IFS_RIFS			GENMASK(14, 10)
+#define MT_IFS_SIFS			GENMASK(22, 16)
+#define MT_IFS_SLOT			GENMASK(30, 24)
+
+#define MT_TMAC_CTCR0(_band)			MT_WF_TMAC(_band, 0x0f4)
+#define MT_TMAC_CTCR0_INS_DDLMT_REFTIME		GENMASK(5, 0)
+#define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
+#define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
+
+#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
+#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
+
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0x820f7000 : 0x820e7000)
+#define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
+
+#define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
+#define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
+#define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
+
+/* WTBLOFF TOP: band 0(0x820e9000),band 1(0x820f9000) */
+#define MT_WTBLOFF_TOP_BASE(_band)	((_band) ? 0x820f9000 : 0x820e9000)
+#define MT_WTBLOFF_TOP(_band, ofs)	(MT_WTBLOFF_TOP_BASE(_band) + (ofs))
+
+#define MT_WTBLOFF_TOP_RSCR(_band)	MT_WTBLOFF_TOP(_band, 0x008)
+#define MT_WTBLOFF_TOP_RSCR_RCPI_MODE	GENMASK(31, 30)
+#define MT_WTBLOFF_TOP_RSCR_RCPI_PARAM	GENMASK(25, 24)
+
+/* LPON: band 0(0x24200), band 1(0xa4200) */
+#define MT_WF_LPON_BASE(_band)		((_band) ? 0x820fb000 : 0x820eb000)
+#define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
+
+#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
+#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, 0x084)
+
+#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
+#define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
+#define MT_LPON_TCR_SW_WRITE		BIT(0)
+
+/* ETBF: band 0(0x24000), band 1(0xa4000) */
+#define MT_WF_ETBF_BASE(_band)		((_band) ? 0x820fa000 : 0x820ea000)
+#define MT_WF_ETBF(_band, ofs)		(MT_WF_ETBF_BASE(_band) + (ofs))
+
+#define MT_ETBF_TX_APP_CNT(_band)	MT_WF_ETBF(_band, 0x150)
+#define MT_ETBF_TX_IBF_CNT		GENMASK(31, 16)
+#define MT_ETBF_TX_EBF_CNT		GENMASK(15, 0)
+
+#define MT_ETBF_RX_FB_CNT(_band)	MT_WF_ETBF(_band, 0x158)
+#define MT_ETBF_RX_FB_ALL		GENMASK(31, 24)
+#define MT_ETBF_RX_FB_HE		GENMASK(23, 16)
+#define MT_ETBF_RX_FB_VHT		GENMASK(15, 8)
+#define MT_ETBF_RX_FB_HT		GENMASK(7, 0)
+
+/* MIB: band 0(0x24800), band 1(0xa4800) */
+#define MT_WF_MIB_BASE(_band)		((_band) ? 0x820fd000 : 0x820ed000)
+#define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
+
+#define MT_MIB_SCR1(_band)		MT_WF_MIB(_band, 0x004)
+#define MT_MIB_TXDUR_EN			BIT(8)
+#define MT_MIB_RXDUR_EN			BIT(9)
+
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x698)
+#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(31, 16)
+
+#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x780)
+
+#define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
+#define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, 0x558)
+#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, 0x564)
+#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, 0x568)
+
+#define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, 0x048)
+#define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, 0x770)
+#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, 0x774)
+#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, 0x55c)
+
+#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x7a8)
+#define MT_MIB_SDR9_IBF_CNT_MASK	GENMASK(31, 16)
+#define MT_MIB_SDR9_EBF_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
+#define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
+
+#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x054)
+#define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x058)
+#define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
+#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
+#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
+
+#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, 0x100 + ((n) << 4))
+#define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
+
+#define MT_MIB_MB_BSDR0(_band)		MT_WF_MIB(_band, 0x688)
+#define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
+#define MT_MIB_MB_BSDR1(_band)		MT_WF_MIB(_band, 0x690)
+#define MT_MIB_RTS_FAIL_COUNT_MASK	GENMASK(15, 0)
+#define MT_MIB_MB_BSDR2(_band)		MT_WF_MIB(_band, 0x518)
+#define MT_MIB_BA_FAIL_COUNT_MASK	GENMASK(15, 0)
+#define MT_MIB_MB_BSDR3(_band)		MT_WF_MIB(_band, 0x520)
+#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
+#define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
+
+#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x7dc + ((n) << 2))
+#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x7ec + ((n) << 2))
+#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
+#define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
+
+#define MT_WTBLON_TOP_BASE		0x820d4000
+#define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
+
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x230)
+#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
+#define MT_WTBL_UPDATE_BUSY		BIT(31)
+
+#define MT_WTBL_ITCR			MT_WTBLON_TOP(0x3b0)
+#define MT_WTBL_ITCR_WR			BIT(16)
+#define MT_WTBL_ITCR_EXEC		BIT(31)
+#define MT_WTBL_ITDR0			MT_WTBLON_TOP(0x3b8)
+#define MT_WTBL_ITDR1			MT_WTBLON_TOP(0x3bc)
+#define MT_WTBL_SPE_IDX_SEL		BIT(6)
+
+#define MT_WTBL_BASE			0x820d8000
+#define MT_WTBL_LMAC_ID			GENMASK(14, 8)
+#define MT_WTBL_LMAC_DW			GENMASK(7, 2)
+#define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
+					 FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+					 FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+
+/* AGG: band 0(0x20800), band 1(0xa0800) */
+#define MT_WF_AGG_BASE(_band)		((_band) ? 0x820f2000 : 0x820e2000)
+#define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
+
+#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
+#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, 0x06c + (_n) * 4)
+#define MT_AGG_PCR0_MM_PROT		BIT(0)
+#define MT_AGG_PCR0_GF_PROT		BIT(1)
+#define MT_AGG_PCR0_BW20_PROT		BIT(2)
+#define MT_AGG_PCR0_BW40_PROT		BIT(4)
+#define MT_AGG_PCR0_BW80_PROT		BIT(6)
+#define MT_AGG_PCR0_ERP_PROT		GENMASK(12, 8)
+#define MT_AGG_PCR0_VHT_PROT		BIT(13)
+#define MT_AGG_PCR0_PTA_WIN_DIS		BIT(15)
+
+#define MT_AGG_PCR1_RTS0_NUM_THRES	GENMASK(31, 23)
+#define MT_AGG_PCR1_RTS0_LEN_THRES	GENMASK(19, 0)
+
+#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, 0x084)
+#define MT_AGG_ACR_CFEND_RATE		GENMASK(13, 0)
+#define MT_AGG_ACR_BAR_RATE		GENMASK(29, 16)
+
+#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, 0x098)
+#define MT_AGG_MRCR_BAR_CNT_LIMIT	GENMASK(15, 12)
+#define MT_AGG_MRCR_LAST_RTS_CTS_RN	BIT(6)
+#define MT_AGG_MRCR_RTS_FAIL_LIMIT	GENMASK(11, 7)
+#define MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT	GENMASK(28, 24)
+
+#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, 0x0f0)
+#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
+
+/* ARB: band 0(0x20c00), band 1(0xa0c00) */
+#define MT_WF_ARB_BASE(_band)		((_band) ? 0x820f3000 : 0x820e3000)
+#define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
+
+#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
+#define MT_ARB_SCR_TX_DISABLE		BIT(8)
+#define MT_ARB_SCR_RX_DISABLE		BIT(9)
+
+#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
+
+/* RMAC: band 0(0x21400), band 1(0xa1400) */
+#define MT_WF_RMAC_BASE(_band)		((_band) ? 0x820f5000 : 0x820e5000)
+#define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
+
+#define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
+#define MT_WF_RFCR_DROP_STBC_MULTI	BIT(0)
+#define MT_WF_RFCR_DROP_FCSFAIL		BIT(1)
+#define MT_WF_RFCR_DROP_VERSION		BIT(3)
+#define MT_WF_RFCR_DROP_PROBEREQ	BIT(4)
+#define MT_WF_RFCR_DROP_MCAST		BIT(5)
+#define MT_WF_RFCR_DROP_BCAST		BIT(6)
+#define MT_WF_RFCR_DROP_MCAST_FILTERED	BIT(7)
+#define MT_WF_RFCR_DROP_A3_MAC		BIT(8)
+#define MT_WF_RFCR_DROP_A3_BSSID	BIT(9)
+#define MT_WF_RFCR_DROP_A2_BSSID	BIT(10)
+#define MT_WF_RFCR_DROP_OTHER_BEACON	BIT(11)
+#define MT_WF_RFCR_DROP_FRAME_REPORT	BIT(12)
+#define MT_WF_RFCR_DROP_CTL_RSV		BIT(13)
+#define MT_WF_RFCR_DROP_CTS		BIT(14)
+#define MT_WF_RFCR_DROP_RTS		BIT(15)
+#define MT_WF_RFCR_DROP_DUPLICATE	BIT(16)
+#define MT_WF_RFCR_DROP_OTHER_BSS	BIT(17)
+#define MT_WF_RFCR_DROP_OTHER_UC	BIT(18)
+#define MT_WF_RFCR_DROP_OTHER_TIM	BIT(19)
+#define MT_WF_RFCR_DROP_NDPA		BIT(20)
+#define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
+
+#define MT_WF_RFCR1(_band)		MT_WF_RMAC(_band, 0x004)
+#define MT_WF_RFCR1_DROP_ACK		BIT(4)
+#define MT_WF_RFCR1_DROP_BF_POLL	BIT(5)
+#define MT_WF_RFCR1_DROP_BA		BIT(6)
+#define MT_WF_RFCR1_DROP_CFEND		BIT(7)
+#define MT_WF_RFCR1_DROP_CFACK		BIT(8)
+
+#define MT_WF_RMAC_MIB_TIME0(_band)	MT_WF_RMAC(_band, 0x03c4)
+#define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
+#define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
+
+#define MT_WF_RMAC_MIB_AIRTIME14(_band)	MT_WF_RMAC(_band, 0x03b8)
+#define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
+#define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
+
+/* WFDMA0 */
+#define MT_WFDMA0_BASE			0xd4000
+#define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
+
+#define MT_WFDMA0_RST			MT_WFDMA0(0x100)
+#define MT_WFDMA0_RST_LOGIC_RST		BIT(4)
+#define MT_WFDMA0_RST_DMASHDL_ALL_RST	BIT(5)
+
+#define MT_WFDMA0_BUSY_ENA		MT_WFDMA0(0x13c)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO0	BIT(0)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO1	BIT(1)
+#define MT_WFDMA0_BUSY_ENA_RX_FIFO	BIT(2)
+
+#define MT_MCU_CMD			MT_WFDMA0(0x1f0)
+#define MT_MCU_CMD_WAKE_RX_PCIE		BIT(0)
+#define MT_MCU_CMD_STOP_DMA_FW_RELOAD	BIT(1)
+#define MT_MCU_CMD_STOP_DMA		BIT(2)
+#define MT_MCU_CMD_RESET_DONE		BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
+#define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
+
+#define MT_MCU2HOST_SW_INT_ENA		MT_WFDMA0(0x1f4)
+
+#define MT_WFDMA0_HOST_INT_STA		MT_WFDMA0(0x200)
+#define HOST_RX_DONE_INT_STS0		BIT(0)	/* Rx mcu */
+#define HOST_RX_DONE_INT_STS2		BIT(2)	/* Rx data */
+#define HOST_RX_DONE_INT_STS4		BIT(22)	/* Rx mcu after fw downloaded */
+#define HOST_TX_DONE_INT_STS16		BIT(26)
+#define HOST_TX_DONE_INT_STS17		BIT(27) /* MCU tx done*/
+
+#define MT_WFDMA0_GLO_CFG		MT_WFDMA0(0x208)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_EN	BIT(0)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_BUSY	BIT(1)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
+#define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
+#define MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL BIT(9)
+#define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
+#define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
+#define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
+
+#define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
+#define MT_WFDMA0_RST_DRX_PTR		MT_WFDMA0(0x280)
+#define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
+#define MT_WFDMA0_CSR_TX_DMASHDL_ENABLE	BIT(6)
+#define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
+
+#define MT_WFDMA0_TX_RING0_EXT_CTRL	MT_WFDMA0(0x600)
+#define MT_WFDMA0_TX_RING1_EXT_CTRL	MT_WFDMA0(0x604)
+#define MT_WFDMA0_TX_RING2_EXT_CTRL	MT_WFDMA0(0x608)
+#define MT_WFDMA0_TX_RING3_EXT_CTRL	MT_WFDMA0(0x60c)
+#define MT_WFDMA0_TX_RING4_EXT_CTRL	MT_WFDMA0(0x610)
+#define MT_WFDMA0_TX_RING5_EXT_CTRL	MT_WFDMA0(0x614)
+#define MT_WFDMA0_TX_RING6_EXT_CTRL	MT_WFDMA0(0x618)
+#define MT_WFDMA0_TX_RING15_EXT_CTRL	MT_WFDMA0(0x63c)
+#define MT_WFDMA0_TX_RING16_EXT_CTRL	MT_WFDMA0(0x640)
+#define MT_WFDMA0_TX_RING17_EXT_CTRL	MT_WFDMA0(0x644)
+
+#define MT_WPDMA0_MAX_CNT_MASK		GENMASK(7, 0)
+#define MT_WPDMA0_BASE_PTR_MASK		GENMASK(31, 16)
+
+#define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
+#define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
+#define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
+#define MT_WFDMA0_RX_RING3_EXT_CTRL	MT_WFDMA0(0x68c)
+#define MT_WFDMA0_RX_RING4_EXT_CTRL	MT_WFDMA0(0x690)
+#define MT_WFDMA0_RX_RING5_EXT_CTRL	MT_WFDMA0(0x694)
+#define MT_WFDMA0_RX_RING6_EXT_CTRL	MT_WFDMA0(0x698)
+#define MT_WFDMA0_RX_RING7_EXT_CTRL	MT_WFDMA0(0x69c)
+
+#define MT_TX_RING_BASE			MT_WFDMA0(0x300)
+#define MT_RX_EVENT_RING_BASE		MT_WFDMA0(0x500)
+
+/* WFDMA CSR */
+#define MT_WFDMA_EXT_CSR_BASE          0xd7000
+#define MT_WFDMA_EXT_CSR(ofs)          (MT_WFDMA_EXT_CSR_BASE + (ofs))
+#define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
+#define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
+
+#define MT_SWDEF_BASE			0x41f200
+#define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
+#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
+#define MT_SWDEF_NORMAL_MODE		0
+#define MT_SWDEF_ICAP_MODE		1
+#define MT_SWDEF_SPECTRUM_MODE		2
+
+#define MT_TOP_BASE			0x18060000
+#define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
+
+#define MT_TOP_LPCR_HOST_BAND0		MT_TOP(0x10)
+#define MT_TOP_LPCR_HOST_FW_OWN		BIT(0)
+#define MT_TOP_LPCR_HOST_DRV_OWN	BIT(1)
+
+#define MT_TOP_MISC			MT_TOP(0xf0)
+#define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
+
+#define MT_MCU_WPDMA0_BASE		0x54000000
+#define MT_MCU_WPDMA0(ofs)		(MT_MCU_WPDMA0_BASE + (ofs))
+
+#define MT_WFDMA_DUMMY_CR		MT_MCU_WPDMA0(0x120)
+#define MT_WFDMA_NEED_REINIT		BIT(1)
+
+#define MT_CBTOP_RGU(ofs)		(0x70002000 + (ofs))
+#define MT_CBTOP_RGU_WF_SUBSYS_RST	MT_CBTOP_RGU(0x600)
+#define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
+
+#define MT_HW_BOUND			0x70010020
+#define MT_HW_CHIPID			0x70010200
+#define MT_HW_REV			0x70010204
+
+#define MT_PCIE_MAC_BASE		0x10000
+#define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
+#define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
+#define MT_PCIE_MAC_PM			MT_PCIE_MAC(0x194)
+#define MT_PCIE_MAC_PM_L0S_DIS		BIT(8)
+
+#define MT_DMA_SHDL(ofs)		(0x7c026000 + (ofs))
+#define MT_DMASHDL_SW_CONTROL		MT_DMA_SHDL(0x004)
+#define MT_DMASHDL_DMASHDL_BYPASS	BIT(28)
+#define MT_DMASHDL_OPTIONAL		MT_DMA_SHDL(0x008)
+#define MT_DMASHDL_PAGE			MT_DMA_SHDL(0x00c)
+#define MT_DMASHDL_GROUP_SEQ_ORDER	BIT(16)
+#define MT_DMASHDL_REFILL		MT_DMA_SHDL(0x010)
+#define MT_DMASHDL_REFILL_MASK		GENMASK(31, 16)
+#define MT_DMASHDL_PKT_MAX_SIZE		MT_DMA_SHDL(0x01c)
+#define MT_DMASHDL_PKT_MAX_SIZE_PLE	GENMASK(11, 0)
+#define MT_DMASHDL_PKT_MAX_SIZE_PSE	GENMASK(27, 16)
+
+#define MT_DMASHDL_GROUP_QUOTA(_n)	MT_DMA_SHDL(0x020 + ((_n) << 2))
+#define MT_DMASHDL_GROUP_QUOTA_MIN	GENMASK(11, 0)
+#define MT_DMASHDL_GROUP_QUOTA_MAX	GENMASK(27, 16)
+
+#define MT_DMASHDL_Q_MAP(_n)		MT_DMA_SHDL(0x060 + ((_n) << 2))
+#define MT_DMASHDL_Q_MAP_MASK		GENMASK(3, 0)
+#define MT_DMASHDL_Q_MAP_SHIFT(_n)	(4 * ((_n) % 8))
+
+#define MT_DMASHDL_SCHED_SET(_n)	MT_DMA_SHDL(0x070 + ((_n) << 2))
+
+#define MT_WFDMA_HOST_CONFIG		0x7c027030
+#define MT_WFDMA_HOST_CONFIG_USB_RXEVT_EP4_EN	BIT(6)
+
+#define MT_UMAC(ofs)			(0x74000000 + (ofs))
+#define MT_UDMA_TX_QSEL			MT_UMAC(0x008)
+#define MT_FW_DL_EN			BIT(3)
+
+#define MT_UDMA_WLCFG_1			MT_UMAC(0x00c)
+#define MT_WL_RX_AGG_PKT_LMT		GENMASK(7, 0)
+#define MT_WL_TX_TMOUT_LMT		GENMASK(27, 8)
+
+#define MT_UDMA_WLCFG_0			MT_UMAC(0x18)
+#define MT_WL_RX_AGG_TO			GENMASK(7, 0)
+#define MT_WL_RX_AGG_LMT		GENMASK(15, 8)
+#define MT_WL_TX_TMOUT_FUNC_EN		BIT(16)
+#define MT_WL_TX_DPH_CHK_EN		BIT(17)
+#define MT_WL_RX_MPSZ_PAD0		BIT(18)
+#define MT_WL_RX_FLUSH			BIT(19)
+#define MT_TICK_1US_EN			BIT(20)
+#define MT_WL_RX_AGG_EN			BIT(21)
+#define MT_WL_RX_EN			BIT(22)
+#define MT_WL_TX_EN			BIT(23)
+#define MT_WL_RX_BUSY			BIT(30)
+#define MT_WL_TX_BUSY			BIT(31)
+
+#define MT_UDMA_CONN_INFRA_STATUS	MT_UMAC(0xa20)
+#define MT_UDMA_CONN_WFSYS_INIT_DONE	BIT(22)
+#define MT_UDMA_CONN_INFRA_STATUS_SEL	MT_UMAC(0xa24)
+
+#define MT_SSUSB_EPCTL_CSR(ofs)		(0x74011800 + (ofs))
+#define MT_SSUSB_EPCTL_CSR_EP_RST_OPT	MT_SSUSB_EPCTL_CSR(0x090)
+
+#define MT_UWFDMA0(ofs)			(0x7c024000 + (ofs))
+#define MT_UWFDMA0_GLO_CFG		MT_UWFDMA0(0x208)
+#define MT_UWFDMA0_GLO_CFG_EXT0		MT_UWFDMA0(0x2b0)
+#define MT_UWFDMA0_GLO_CFG_EXT1		MT_UWFDMA0(0x2b4)
+#define MT_UWFDMA0_TX_RING_EXT_CTRL(_n)	MT_UWFDMA0(0x600 + ((_n) << 2))
+
+#define MT_CONN_STATUS			0x7c053c10
+#define MT_WIFI_PATCH_DL_STATE		BIT(0)
+
+#define MT_CONN_ON_LPCTL		0x7c060010
+#define PCIE_LPCR_HOST_SET_OWN		BIT(0)
+#define PCIE_LPCR_HOST_CLR_OWN		BIT(1)
+#define PCIE_LPCR_HOST_OWN_SYNC		BIT(2)
+
+#define MT_CONN_ON_MISC			0x7c0600f0
+#define MT_TOP_MISC2_FW_PWR_ON		BIT(0)
+#define MT_TOP_MISC2_FW_N9_ON		BIT(1)
+#define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
+
+#define MT_WF_SW_DEF_CR(ofs)		(0x401a00 + (ofs))
+#define MT_WF_SW_DEF_CR_USB_MCU_EVENT	MT_WF_SW_DEF_CR(0x028)
+#define MT_WF_SW_SER_TRIGGER_SUSPEND	BIT(6)
+#define MT_WF_SW_SER_DONE_SUSPEND	BIT(7)
+
+#endif /* __MT792X_REGS_H */
-- 
2.18.0

