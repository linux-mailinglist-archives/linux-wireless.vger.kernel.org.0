Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423CB48FCCF
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiAPMoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiAPMoA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:44:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91070C061574
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 04:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB5DAB80CBD
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 12:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55889C36AE3;
        Sun, 16 Jan 2022 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337037;
        bh=bHO/0HsvS4wj8+7BPFStk2d7sJbjQlWyHWx2KrJkHtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyiZ63qUMEOY9vz10X2vNM+cehlyb+bBX+RqkJKafwzDdQyXCC5vS1NvY8KkOF0nz
         uzspm+25Z5MRc9mYazDIEZJ25YnjFAHAMR6WGJqPTps9DqwV8U9ZQYSoNfrcSPpc+p
         0RZRI9tPyiYBTRWxN/DdlVlENLI7/++e1tQIRCagHPAay7rg73L5UlG1sfr6y9+Vu8
         B+JZlbE0crWctpqOczsqCNCt3EMUohi7T6P4zsspvDON/Q/jp/uyli6Wo3YVcG7fZT
         dqXwSyC4f5OAqi8LMBRpHwVfl8cbfU21iiIWwMqcEChaK7oGBEWdNg2R0iVVAC+XlG
         +qSayZ6kr2IfQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 2/5] mt76: connac: move common mac defs in mt76_connac_mac.h
Date:   Sun, 16 Jan 2022 13:43:15 +0100
Message-Id: <39e05054ccb5fc9123bea06f45833348c5b08d4d.1642336806.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642336806.git.lorenzo@kernel.org>
References: <cover.1642336806.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mac definitions shared between mt7921 and mt7915 in
mt76_connac_mac.h header.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mac.h  | 292 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 279 +----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 293 +-----------------
 4 files changed, 296 insertions(+), 572 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h
new file mode 100644
index 000000000000..0c73875ba9a6
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h
@@ -0,0 +1,292 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#ifndef __MT76_CONNAC_MAC_H
+#define __MT76_CONNAC_MAC_H
+
+#define MT_CT_PARSE_LEN			72
+#define MT_CT_DMA_BUF_NUM		2
+
+#define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
+#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
+
+#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
+#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
+#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
+
+enum rx_pkt_type {
+	PKT_TYPE_TXS,
+	PKT_TYPE_TXRXV,
+	PKT_TYPE_NORMAL,
+	PKT_TYPE_RX_DUP_RFB,
+	PKT_TYPE_RX_TMR,
+	PKT_TYPE_RETRIEVE,
+	PKT_TYPE_TXRX_NOTIFY,
+	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_NORMAL_MCU,
+	PKT_TYPE_RX_FW_MONITOR = 0x0c,
+};
+
+/* RXD DW1 */
+#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
+#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
+#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
+#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
+#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
+#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
+#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
+#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
+#define MT_RXD1_NORMAL_CM		BIT(23)
+#define MT_RXD1_NORMAL_CLM		BIT(24)
+#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
+#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
+#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
+#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
+#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
+#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
+#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
+
+/* RXD DW2 */
+#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
+#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
+#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
+#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
+#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
+#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
+#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
+#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
+#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
+#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
+#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
+#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
+#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
+#define MT_RXD2_NORMAL_FRAG		BIT(27)
+#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
+#define MT_RXD2_NORMAL_NDATA		BIT(29)
+#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
+#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
+
+/* RXD DW3 */
+#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
+#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
+#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
+#define MT_RXD3_NORMAL_U2M		BIT(0)
+#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
+#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
+#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
+#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
+#define MT_RXD3_NORMAL_AMSDU		BIT(22)
+#define MT_RXD3_NORMAL_MESH		BIT(23)
+#define MT_RXD3_NORMAL_MHCP		BIT(24)
+#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
+#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
+#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
+#define MT_RXD3_NORMAL_MORE		BIT(28)
+#define MT_RXD3_NORMAL_UNWANT		BIT(29)
+#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
+#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
+
+/* RXD DW4 */
+#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
+#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
+#define MT_RXD4_NORMAL_CLS		BIT(10)
+#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
+#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
+#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
+#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
+#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
+#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
+
+/* RXD GROUP4 */
+#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
+#define MT_RXD6_TA_LO			GENMASK(31, 16)
+
+#define MT_RXD7_TA_HI			GENMASK(31, 0)
+
+#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
+
+#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
+
+/* P-RXV DW0 */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(9, 7)
+#define MT_PRXV_TXBF			BIT(10)
+#define MT_PRXV_HT_AD_CODE		BIT(11)
+#define MT_PRXV_FRAME_MODE		GENMASK(14, 12)
+#define MT_PRXV_HT_SHORT_GI		GENMASK(16, 15)
+#define MT_PRXV_HT_STBC			GENMASK(23, 22)
+#define MT_PRXV_TX_MODE			GENMASK(27, 24)
+#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
+
+/* P-RXV DW1 */
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+
+#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+
+/* C-RXV */
+#define MT_CRXV_HT_STBC			GENMASK(1, 0)
+#define MT_CRXV_TX_MODE			GENMASK(7, 4)
+#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
+#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
+#define MT_CRXV_HE_UPLINK		BIT(31)
+
+#define MT_CRXV_HE_RU0			GENMASK(7, 0)
+#define MT_CRXV_HE_RU1			GENMASK(15, 8)
+#define MT_CRXV_HE_RU2			GENMASK(23, 16)
+#define MT_CRXV_HE_RU3			GENMASK(31, 24)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
+
+#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
+#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
+#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
+
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
+#define MT_CRXV_HE_DOPPLER		BIT(16)
+
+#define MT_CRXV_SNR		GENMASK(18, 13)
+#define MT_CRXV_FOE_LO		GENMASK(31, 19)
+#define MT_CRXV_FOE_HI		GENMASK(6, 0)
+#define MT_CRXV_FOE_SHIFT	13
+
+enum tx_header_format {
+	MT_HDR_FORMAT_802_3,
+	MT_HDR_FORMAT_CMD,
+	MT_HDR_FORMAT_802_11,
+	MT_HDR_FORMAT_802_11_EXT,
+};
+
+enum tx_pkt_type {
+	MT_TX_TYPE_CT,
+	MT_TX_TYPE_SF,
+	MT_TX_TYPE_CMD,
+	MT_TX_TYPE_FW,
+};
+
+enum tx_port_idx {
+	MT_TX_PORT_IDX_LMAC,
+	MT_TX_PORT_IDX_MCU
+};
+
+enum tx_mcu_port_q_idx {
+	MT_TX_MCU_PORT_RX_Q0 = 0x20,
+	MT_TX_MCU_PORT_RX_Q1,
+	MT_TX_MCU_PORT_RX_Q2,
+	MT_TX_MCU_PORT_RX_Q3,
+	MT_TX_MCU_PORT_RX_FWDL = 0x3e
+};
+
+#define MT_CT_INFO_APPLY_TXD		BIT(0)
+#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
+#define MT_CT_INFO_MGMT_FRAME		BIT(2)
+#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
+#define MT_CT_INFO_HSR2_TX		BIT(4)
+#define MT_CT_INFO_FROM_HOST		BIT(7)
+
+#define MT_TXD_SIZE			(8 * 4)
+
+#define MT_TXD0_Q_IDX			GENMASK(31, 25)
+#define MT_TXD0_PKT_FMT			GENMASK(24, 23)
+#define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
+#define MT_TXD0_TX_BYTES		GENMASK(15, 0)
+
+#define MT_TXD1_LONG_FORMAT		BIT(31)
+#define MT_TXD1_TGID			BIT(30)
+#define MT_TXD1_OWN_MAC			GENMASK(29, 24)
+#define MT_TXD1_AMSDU			BIT(23)
+#define MT_TXD1_TID			GENMASK(22, 20)
+#define MT_TXD1_HDR_PAD			GENMASK(19, 18)
+#define MT_TXD1_HDR_FORMAT		GENMASK(17, 16)
+#define MT_TXD1_HDR_INFO		GENMASK(15, 11)
+#define MT_TXD1_ETH_802_3		BIT(15)
+#define MT_TXD1_VTA			BIT(10)
+#define MT_TXD1_WLAN_IDX		GENMASK(9, 0)
+
+#define MT_TXD2_FIX_RATE		BIT(31)
+#define MT_TXD2_FIXED_RATE		BIT(30)
+#define MT_TXD2_POWER_OFFSET		GENMASK(29, 24)
+#define MT_TXD2_MAX_TX_TIME		GENMASK(23, 16)
+#define MT_TXD2_FRAG			GENMASK(15, 14)
+#define MT_TXD2_HTC_VLD			BIT(13)
+#define MT_TXD2_DURATION		BIT(12)
+#define MT_TXD2_BIP			BIT(11)
+#define MT_TXD2_MULTICAST		BIT(10)
+#define MT_TXD2_RTS			BIT(9)
+#define MT_TXD2_SOUNDING		BIT(8)
+#define MT_TXD2_NDPA			BIT(7)
+#define MT_TXD2_NDP			BIT(6)
+#define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
+#define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
+
+#define MT_TXD3_SN_VALID		BIT(31)
+#define MT_TXD3_PN_VALID		BIT(30)
+#define MT_TXD3_SW_POWER_MGMT		BIT(29)
+#define MT_TXD3_BA_DISABLE		BIT(28)
+#define MT_TXD3_SEQ			GENMASK(27, 16)
+#define MT_TXD3_REM_TX_COUNT		GENMASK(15, 11)
+#define MT_TXD3_TX_COUNT		GENMASK(10, 6)
+#define MT_TXD3_TIMING_MEASURE		BIT(5)
+#define MT_TXD3_DAS			BIT(4)
+#define MT_TXD3_EEOSP			BIT(3)
+#define MT_TXD3_EMRD			BIT(2)
+#define MT_TXD3_PROTECT_FRAME		BIT(1)
+#define MT_TXD3_NO_ACK			BIT(0)
+
+#define MT_TXD4_PN_LOW			GENMASK(31, 0)
+
+#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
+#define MT_TXD5_MD			BIT(15)
+#define MT_TXD5_ADD_BA			BIT(14)
+#define MT_TXD5_TX_STATUS_HOST		BIT(10)
+#define MT_TXD5_TX_STATUS_MCU		BIT(9)
+#define MT_TXD5_TX_STATUS_FMT		BIT(8)
+#define MT_TXD5_PID			GENMASK(7, 0)
+
+#define MT_TXD6_TX_IBF			BIT(31)
+#define MT_TXD6_TX_EBF			BIT(30)
+#define MT_TXD6_TX_RATE			GENMASK(29, 16)
+#define MT_TXD6_SGI			GENMASK(15, 14)
+#define MT_TXD6_HELTF			GENMASK(13, 12)
+#define MT_TXD6_LDPC			BIT(11)
+#define MT_TXD6_SPE_ID_IDX		BIT(10)
+#define MT_TXD6_ANT_ID			GENMASK(7, 4)
+#define MT_TXD6_DYN_BW			BIT(3)
+#define MT_TXD6_FIXED_BW		BIT(2)
+#define MT_TXD6_BW			GENMASK(1, 0)
+
+#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
+#define MT_TXD7_UDP_TCP_SUM		BIT(29)
+#define MT_TXD7_IP_SUM			BIT(28)
+
+#define MT_TXD7_TYPE			GENMASK(21, 20)
+#define MT_TXD7_SUB_TYPE		GENMASK(19, 16)
+
+#define MT_TXD7_PSE_FID			GENMASK(27, 16)
+#define MT_TXD7_SPE_IDX			GENMASK(15, 11)
+#define MT_TXD7_HW_AMSDU		BIT(10)
+#define MT_TXD7_TX_TIME			GENMASK(9, 0)
+
+#define MT_TX_RATE_STBC			BIT(13)
+#define MT_TX_RATE_NSS			GENMASK(12, 10)
+#define MT_TX_RATE_MODE			GENMASK(9, 6)
+#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
+#define MT_TX_RATE_DCM			BIT(4)
+
+#endif /* __MT76_CONNAC_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 5add1dd36dbe..4237adcabf7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -4,294 +4,17 @@
 #ifndef __MT7915_MAC_H
 #define __MT7915_MAC_H
 
-#define MT_CT_PARSE_LEN			72
-#define MT_CT_DMA_BUF_NUM		2
-
-#define MT_RXD0_LENGTH			GENMASK(15, 0)
-#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
-
-#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
-#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
-#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
-
-enum rx_pkt_type {
-	PKT_TYPE_TXS,
-	PKT_TYPE_TXRXV,
-	PKT_TYPE_NORMAL,
-	PKT_TYPE_RX_DUP_RFB,
-	PKT_TYPE_RX_TMR,
-	PKT_TYPE_RETRIEVE,
-	PKT_TYPE_TXRX_NOTIFY,
-	PKT_TYPE_RX_EVENT,
-	PKT_TYPE_RX_FW_MONITOR = 0x0c,
-};
-
-/* RXD DW1 */
-#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
-#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
-#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
-#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
-#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
-#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
-#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
-#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
-#define MT_RXD1_NORMAL_CM		BIT(23)
-#define MT_RXD1_NORMAL_CLM		BIT(24)
-#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
-#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
-#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
-#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
-#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
-#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
-#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
-
-/* RXD DW2 */
-#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
-#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
-#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
-#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
-#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
-#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
-#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
-#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
-#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
-#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
-#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
-#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
-#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
-#define MT_RXD2_NORMAL_FRAG		BIT(27)
-#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
-#define MT_RXD2_NORMAL_NDATA		BIT(29)
-#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
-#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
-
-/* RXD DW3 */
-#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
-#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
-#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
-#define MT_RXD3_NORMAL_U2M		BIT(0)
-#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
-#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
-#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
-#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
-#define MT_RXD3_NORMAL_AMSDU		BIT(22)
-#define MT_RXD3_NORMAL_MESH		BIT(23)
-#define MT_RXD3_NORMAL_MHCP		BIT(24)
-#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
-#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
-#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
-#define MT_RXD3_NORMAL_MORE		BIT(28)
-#define MT_RXD3_NORMAL_UNWANT		BIT(29)
-#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
-#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
-
-/* RXD DW4 */
-#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
-#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
-#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
-#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
-
-#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
-#define MT_RXD4_NORMAL_CLS		BIT(10)
-#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
-#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
-#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
-#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
-#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
-#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
+#include "../mt76_connac_mac.h"
 
 #define MT_RXV_HDR_BAND_IDX		BIT(24)
 
-/* RXD GROUP4 */
-#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
-#define MT_RXD6_TA_LO			GENMASK(31, 16)
-
-#define MT_RXD7_TA_HI			GENMASK(31, 0)
-
-#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
-#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
-
-#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
-
-/* P-RXV */
-#define MT_PRXV_TX_RATE			GENMASK(6, 0)
-#define MT_PRXV_TX_DCM			BIT(4)
-#define MT_PRXV_TX_ER_SU_106T		BIT(5)
-#define MT_PRXV_NSTS			GENMASK(9, 7)
-#define MT_PRXV_TXBF			BIT(10)
-#define MT_PRXV_HT_AD_CODE		BIT(11)
-#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
-#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
-#define MT_PRXV_RCPI3			GENMASK(31, 24)
-#define MT_PRXV_RCPI2			GENMASK(23, 16)
-#define MT_PRXV_RCPI1			GENMASK(15, 8)
-#define MT_PRXV_RCPI0			GENMASK(7, 0)
-#define MT_PRXV_HT_SHORT_GI		GENMASK(16, 15)
-#define MT_PRXV_HT_STBC			GENMASK(23, 22)
-#define MT_PRXV_TX_MODE			GENMASK(27, 24)
-#define MT_PRXV_FRAME_MODE		GENMASK(14, 12)
 #define MT_PRXV_DCM			BIT(17)
 #define MT_PRXV_NUM_RX			BIT(20, 18)
 
-/* C-RXV */
-#define MT_CRXV_HT_STBC			GENMASK(1, 0)
-#define MT_CRXV_TX_MODE			GENMASK(7, 4)
-#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
-#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
-#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
-#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
-#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
-#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
-#define MT_CRXV_HE_UPLINK		BIT(31)
-#define MT_CRXV_HE_RU0			GENMASK(7, 0)
-#define MT_CRXV_HE_RU1			GENMASK(15, 8)
-#define MT_CRXV_HE_RU2			GENMASK(23, 16)
-#define MT_CRXV_HE_RU3			GENMASK(31, 24)
-
-#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
-
-#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
-#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
-#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
-#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
-
-#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
-#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
-#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
-#define MT_CRXV_HE_DOPPLER		BIT(16)
-
-#define MT_CRXV_SNR		GENMASK(18, 13)
-#define MT_CRXV_FOE_LO		GENMASK(31, 19)
-#define MT_CRXV_FOE_HI		GENMASK(6, 0)
-#define MT_CRXV_FOE_SHIFT	13
-
-enum tx_header_format {
-	MT_HDR_FORMAT_802_3,
-	MT_HDR_FORMAT_CMD,
-	MT_HDR_FORMAT_802_11,
-	MT_HDR_FORMAT_802_11_EXT,
-};
-
-enum tx_pkt_type {
-	MT_TX_TYPE_CT,
-	MT_TX_TYPE_SF,
-	MT_TX_TYPE_CMD,
-	MT_TX_TYPE_FW,
-};
-
-enum tx_port_idx {
-	MT_TX_PORT_IDX_LMAC,
-	MT_TX_PORT_IDX_MCU
-};
-
-enum tx_mcu_port_q_idx {
-	MT_TX_MCU_PORT_RX_Q0 = 0x20,
-	MT_TX_MCU_PORT_RX_Q1,
-	MT_TX_MCU_PORT_RX_Q2,
-	MT_TX_MCU_PORT_RX_Q3,
-	MT_TX_MCU_PORT_RX_FWDL = 0x3e
-};
-
-#define MT_CT_INFO_APPLY_TXD		BIT(0)
-#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
-#define MT_CT_INFO_MGMT_FRAME		BIT(2)
-#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
-#define MT_CT_INFO_HSR2_TX		BIT(4)
-#define MT_CT_INFO_FROM_HOST		BIT(7)
-
-#define MT_TXD_SIZE			(8 * 4)
-
-#define MT_TXD0_Q_IDX			GENMASK(31, 25)
-#define MT_TXD0_PKT_FMT			GENMASK(24, 23)
-#define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
-#define MT_TXD0_TX_BYTES		GENMASK(15, 0)
-
-#define MT_TXD1_LONG_FORMAT		BIT(31)
-#define MT_TXD1_TGID			BIT(30)
-#define MT_TXD1_OWN_MAC			GENMASK(29, 24)
-#define MT_TXD1_AMSDU			BIT(23)
-#define MT_TXD1_TID			GENMASK(22, 20)
-#define MT_TXD1_HDR_PAD			GENMASK(19, 18)
-#define MT_TXD1_HDR_FORMAT		GENMASK(17, 16)
-#define MT_TXD1_HDR_INFO		GENMASK(15, 11)
-#define MT_TXD1_ETH_802_3		BIT(15)
-#define MT_TXD1_VTA			BIT(10)
-#define MT_TXD1_WLAN_IDX		GENMASK(9, 0)
-
-#define MT_TXD2_FIX_RATE		BIT(31)
-#define MT_TXD2_FIXED_RATE		BIT(30)
-#define MT_TXD2_POWER_OFFSET		GENMASK(29, 24)
-#define MT_TXD2_MAX_TX_TIME		GENMASK(23, 16)
-#define MT_TXD2_FRAG			GENMASK(15, 14)
-#define MT_TXD2_HTC_VLD			BIT(13)
-#define MT_TXD2_DURATION		BIT(12)
-#define MT_TXD2_BIP			BIT(11)
-#define MT_TXD2_MULTICAST		BIT(10)
-#define MT_TXD2_RTS			BIT(9)
-#define MT_TXD2_SOUNDING		BIT(8)
-#define MT_TXD2_NDPA			BIT(7)
-#define MT_TXD2_NDP			BIT(6)
-#define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
-#define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
-
-#define MT_TXD3_SN_VALID		BIT(31)
-#define MT_TXD3_PN_VALID		BIT(30)
-#define MT_TXD3_SW_POWER_MGMT		BIT(29)
-#define MT_TXD3_BA_DISABLE		BIT(28)
-#define MT_TXD3_SEQ			GENMASK(27, 16)
-#define MT_TXD3_REM_TX_COUNT		GENMASK(15, 11)
-#define MT_TXD3_TX_COUNT		GENMASK(10, 6)
-#define MT_TXD3_TIMING_MEASURE		BIT(5)
-#define MT_TXD3_DAS			BIT(4)
-#define MT_TXD3_EEOSP			BIT(3)
-#define MT_TXD3_EMRD			BIT(2)
-#define MT_TXD3_PROTECT_FRAME		BIT(1)
-#define MT_TXD3_NO_ACK			BIT(0)
-
-#define MT_TXD4_PN_LOW			GENMASK(31, 0)
-
-#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
-#define MT_TXD5_MD			BIT(15)
-#define MT_TXD5_ADD_BA			BIT(14)
-#define MT_TXD5_TX_STATUS_HOST		BIT(10)
-#define MT_TXD5_TX_STATUS_MCU		BIT(9)
-#define MT_TXD5_TX_STATUS_FMT		BIT(8)
-#define MT_TXD5_PID			GENMASK(7, 0)
-
-#define MT_TXD6_TX_IBF			BIT(31)
-#define MT_TXD6_TX_EBF			BIT(30)
-#define MT_TXD6_TX_RATE			GENMASK(29, 16)
-#define MT_TXD6_SGI			GENMASK(15, 14)
-#define MT_TXD6_HELTF			GENMASK(13, 12)
-#define MT_TXD6_LDPC			BIT(11)
-#define MT_TXD6_SPE_ID_IDX		BIT(10)
-#define MT_TXD6_ANT_ID			GENMASK(7, 4)
-#define MT_TXD6_DYN_BW			BIT(3)
-#define MT_TXD6_FIXED_BW		BIT(2)
-#define MT_TXD6_BW			GENMASK(1, 0)
-
-#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
-#define MT_TXD7_UDP_TCP_SUM		BIT(29)
-#define MT_TXD7_IP_SUM			BIT(28)
-
-#define MT_TXD7_TYPE			GENMASK(21, 20)
-#define MT_TXD7_SUB_TYPE		GENMASK(19, 16)
-
-#define MT_TXD7_PSE_FID			GENMASK(27, 16)
-#define MT_TXD7_SPE_IDX			GENMASK(15, 11)
-#define MT_TXD7_HW_AMSDU		BIT(10)
-#define MT_TXD7_TX_TIME			GENMASK(9, 0)
-
-#define MT_TX_RATE_STBC			BIT(13)
-#define MT_TX_RATE_NSS			GENMASK(12, 10)
-#define MT_TX_RATE_MODE			GENMASK(9, 6)
-#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
-#define MT_TX_RATE_DCM			BIT(4)
 /* VHT/HE only use bits 0-3 */
 #define MT_TX_RATE_IDX			GENMASK(5, 0)
 
 #define MT_TXP_MAX_BUF_NUM		6
-
 struct mt7915_txp {
 	__le16 flags;
 	__le16 token;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index dc7a2f5caf67..0d3f6bbc0c5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -668,8 +668,8 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		if (status->signal == -128)
 			status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
-		stbc = FIELD_GET(MT_PRXV_STBC, v0);
-		gi = FIELD_GET(MT_PRXV_SGI, v0);
+		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
+		gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v0);
 		cck = false;
 
 		idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 544a1c33126a..15173088c66d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -4,305 +4,14 @@
 #ifndef __MT7921_MAC_H
 #define __MT7921_MAC_H
 
-#define MT_CT_PARSE_LEN			72
-#define MT_CT_DMA_BUF_NUM		2
-
-#define MT_RXD0_LENGTH			GENMASK(15, 0)
-#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
-#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
-
-#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
-#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
-#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
-
-enum rx_pkt_type {
-	PKT_TYPE_TXS,
-	PKT_TYPE_TXRXV,
-	PKT_TYPE_NORMAL,
-	PKT_TYPE_RX_DUP_RFB,
-	PKT_TYPE_RX_TMR,
-	PKT_TYPE_RETRIEVE,
-	PKT_TYPE_TXRX_NOTIFY,
-	PKT_TYPE_RX_EVENT,
-	PKT_TYPE_NORMAL_MCU,
-};
-
-/* RXD DW1 */
-#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
-#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
-#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
-#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
-#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
-#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
-#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
-#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
-#define MT_RXD1_NORMAL_CM		BIT(23)
-#define MT_RXD1_NORMAL_CLM		BIT(24)
-#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
-#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
-#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
-#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
-#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
-#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
-#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
-
-/* RXD DW2 */
-#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
-#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
-#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
-#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
-#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
-#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
-#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
-#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
-#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
-#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
-#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
-#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
-#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
-#define MT_RXD2_NORMAL_FRAG		BIT(27)
-#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
-#define MT_RXD2_NORMAL_NDATA		BIT(29)
-#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
-#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
-
-/* RXD DW3 */
-#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
-#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
-#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
-#define MT_RXD3_NORMAL_U2M		BIT(0)
-#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
-#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
-#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
-#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
-#define MT_RXD3_NORMAL_AMSDU		BIT(22)
-#define MT_RXD3_NORMAL_MESH		BIT(23)
-#define MT_RXD3_NORMAL_MHCP		BIT(24)
-#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
-#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
-#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
-#define MT_RXD3_NORMAL_MORE		BIT(28)
-#define MT_RXD3_NORMAL_UNWANT		BIT(29)
-#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
-#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
-
-/* RXD DW4 */
-#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
-#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
-#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
-#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
-#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
-#define MT_RXD4_NORMAL_CLS		BIT(10)
-#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
-#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
-#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
-#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
-#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
-#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
-
-/* RXD GROUP4 */
-#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
-#define MT_RXD6_TA_LO			GENMASK(31, 16)
-
-#define MT_RXD7_TA_HI			GENMASK(31, 0)
-
-#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
-#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
-
-#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
-
-/* P-RXV DW0 */
-#define MT_PRXV_TX_RATE			GENMASK(6, 0)
-#define MT_PRXV_TX_DCM			BIT(4)
-#define MT_PRXV_TX_ER_SU_106T		BIT(5)
-#define MT_PRXV_NSTS			GENMASK(9, 7)
-#define MT_PRXV_TXBF			BIT(10)
-#define MT_PRXV_HT_AD_CODE		BIT(11)
-#define MT_PRXV_FRAME_MODE		GENMASK(14, 12)
-#define MT_PRXV_SGI			GENMASK(16, 15)
-#define MT_PRXV_STBC			GENMASK(23, 22)
-#define MT_PRXV_TX_MODE			GENMASK(27, 24)
-#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
-
-/* P-RXV DW1 */
-#define MT_PRXV_RCPI3			GENMASK(31, 24)
-#define MT_PRXV_RCPI2			GENMASK(23, 16)
-#define MT_PRXV_RCPI1			GENMASK(15, 8)
-#define MT_PRXV_RCPI0			GENMASK(7, 0)
-#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
-
-/* C-RXV */
-#define MT_CRXV_HT_STBC			GENMASK(1, 0)
-#define MT_CRXV_TX_MODE			GENMASK(7, 4)
-#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
-#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
-#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
-#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
-#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
-#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
-#define MT_CRXV_HE_UPLINK		BIT(31)
-
-#define MT_CRXV_HE_RU0			GENMASK(7, 0)
-#define MT_CRXV_HE_RU1			GENMASK(15, 8)
-#define MT_CRXV_HE_RU2			GENMASK(23, 16)
-#define MT_CRXV_HE_RU3			GENMASK(31, 24)
-#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
-
-#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
-#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
-#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
-#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
-
-#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
-#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
-#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
-#define MT_CRXV_HE_DOPPLER		BIT(16)
-
-#define MT_CRXV_SNR		GENMASK(18, 13)
-#define MT_CRXV_FOE_LO		GENMASK(31, 19)
-#define MT_CRXV_FOE_HI		GENMASK(6, 0)
-#define MT_CRXV_FOE_SHIFT	13
-
-enum tx_header_format {
-	MT_HDR_FORMAT_802_3,
-	MT_HDR_FORMAT_CMD,
-	MT_HDR_FORMAT_802_11,
-	MT_HDR_FORMAT_802_11_EXT,
-};
-
-enum tx_pkt_type {
-	MT_TX_TYPE_CT,
-	MT_TX_TYPE_SF,
-	MT_TX_TYPE_CMD,
-	MT_TX_TYPE_FW,
-};
-
-enum tx_port_idx {
-	MT_TX_PORT_IDX_LMAC,
-	MT_TX_PORT_IDX_MCU
-};
-
-enum tx_mcu_port_q_idx {
-	MT_TX_MCU_PORT_RX_Q0 = 0x20,
-	MT_TX_MCU_PORT_RX_Q1,
-	MT_TX_MCU_PORT_RX_Q2,
-	MT_TX_MCU_PORT_RX_Q3,
-	MT_TX_MCU_PORT_RX_FWDL = 0x3e
-};
-
-#define MT_CT_INFO_APPLY_TXD		BIT(0)
-#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
-#define MT_CT_INFO_MGMT_FRAME		BIT(2)
-#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
-#define MT_CT_INFO_HSR2_TX		BIT(4)
-#define MT_CT_INFO_FROM_HOST		BIT(7)
-
-#define MT_TXD_SIZE			(8 * 4)
+#include "../mt76_connac_mac.h"
 
 #define MT_SDIO_TXD_SIZE		(MT_TXD_SIZE + 8 * 4)
 #define MT_SDIO_TAIL_SIZE		8
 #define MT_SDIO_HDR_SIZE		4
 
-#define MT_TXD0_Q_IDX			GENMASK(31, 25)
-#define MT_TXD0_PKT_FMT			GENMASK(24, 23)
-#define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
-#define MT_TXD0_TX_BYTES		GENMASK(15, 0)
-
-#define MT_TXD1_LONG_FORMAT		BIT(31)
-#define MT_TXD1_TGID			BIT(30)
-#define MT_TXD1_OWN_MAC			GENMASK(29, 24)
-#define MT_TXD1_AMSDU			BIT(23)
-#define MT_TXD1_TID			GENMASK(22, 20)
-#define MT_TXD1_HDR_PAD			GENMASK(19, 18)
-#define MT_TXD1_HDR_FORMAT		GENMASK(17, 16)
-#define MT_TXD1_HDR_INFO		GENMASK(15, 11)
-#define MT_TXD1_ETH_802_3		BIT(15)
-#define MT_TXD1_VTA			BIT(10)
-#define MT_TXD1_WLAN_IDX		GENMASK(9, 0)
-
-#define MT_TXD2_FIX_RATE		BIT(31)
-#define MT_TXD2_FIXED_RATE		BIT(30)
-#define MT_TXD2_POWER_OFFSET		GENMASK(29, 24)
-#define MT_TXD2_MAX_TX_TIME		GENMASK(23, 16)
-#define MT_TXD2_FRAG			GENMASK(15, 14)
-#define MT_TXD2_HTC_VLD			BIT(13)
-#define MT_TXD2_DURATION		BIT(12)
-#define MT_TXD2_BIP			BIT(11)
-#define MT_TXD2_MULTICAST		BIT(10)
-#define MT_TXD2_RTS			BIT(9)
-#define MT_TXD2_SOUNDING		BIT(8)
-#define MT_TXD2_NDPA			BIT(7)
-#define MT_TXD2_NDP			BIT(6)
-#define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
-#define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
-
-#define MT_TXD3_SN_VALID		BIT(31)
-#define MT_TXD3_PN_VALID		BIT(30)
-#define MT_TXD3_SW_POWER_MGMT		BIT(29)
-#define MT_TXD3_BA_DISABLE		BIT(28)
-#define MT_TXD3_SEQ			GENMASK(27, 16)
-#define MT_TXD3_REM_TX_COUNT		GENMASK(15, 11)
-#define MT_TXD3_TX_COUNT		GENMASK(10, 6)
-#define MT_TXD3_TIMING_MEASURE		BIT(5)
-#define MT_TXD3_DAS			BIT(4)
-#define MT_TXD3_EEOSP			BIT(3)
-#define MT_TXD3_EMRD			BIT(2)
-#define MT_TXD3_PROTECT_FRAME		BIT(1)
-#define MT_TXD3_NO_ACK			BIT(0)
-
-#define MT_TXD4_PN_LOW			GENMASK(31, 0)
-
-#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
-#define MT_TXD5_MD			BIT(15)
-#define MT_TXD5_ADD_BA			BIT(14)
-#define MT_TXD5_TX_STATUS_HOST		BIT(10)
-#define MT_TXD5_TX_STATUS_MCU		BIT(9)
-#define MT_TXD5_TX_STATUS_FMT		BIT(8)
-#define MT_TXD5_PID			GENMASK(7, 0)
-
-#define MT_TXD6_TX_IBF			BIT(31)
-#define MT_TXD6_TX_EBF			BIT(30)
-#define MT_TXD6_TX_RATE			GENMASK(29, 16)
-#define MT_TXD6_SGI			GENMASK(15, 14)
-#define MT_TXD6_HELTF			GENMASK(13, 12)
-#define MT_TXD6_LDPC			BIT(11)
-#define MT_TXD6_SPE_ID_IDX		BIT(10)
-#define MT_TXD6_ANT_ID			GENMASK(7, 4)
-#define MT_TXD6_DYN_BW			BIT(3)
-#define MT_TXD6_FIXED_BW		BIT(2)
-#define MT_TXD6_BW			GENMASK(1, 0)
-
-#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
-#define MT_TXD7_UDP_TCP_SUM		BIT(29)
-#define MT_TXD7_IP_SUM			BIT(28)
-
-#define MT_TXD7_TYPE			GENMASK(21, 20)
-#define MT_TXD7_SUB_TYPE		GENMASK(19, 16)
-
-#define MT_TXD7_PSE_FID			GENMASK(27, 16)
-#define MT_TXD7_SPE_IDX			GENMASK(15, 11)
-#define MT_TXD7_HW_AMSDU		BIT(10)
-#define MT_TXD7_TX_TIME			GENMASK(9, 0)
-
-#define MT_TX_RATE_STBC			BIT(13)
-#define MT_TX_RATE_NSS			GENMASK(12, 10)
-#define MT_TX_RATE_MODE			GENMASK(9, 6)
-#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
-#define MT_TX_RATE_DCM			BIT(4)
 #define MT_TX_RATE_IDX			GENMASK(3, 0)
 
-#define MT_TXP_MAX_BUF_NUM		6
-
-struct mt7921_txp {
-	__le16 flags;
-	__le16 token;
-	u8 bss_idx;
-	__le16 rept_wds_wcid;
-	u8 nbuf;
-	__le32 buf[MT_TXP_MAX_BUF_NUM];
-	__le16 len[MT_TXP_MAX_BUF_NUM];
-} __packed __aligned(4);
-
 struct mt7921_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
-- 
2.34.1

