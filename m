Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F12DD815
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgLQSPR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 13:15:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41759 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731100AbgLQSPP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 13:15:15 -0500
X-UUID: 10826ca49bfb42c98bcc2b03b20c7631-20201218
X-UUID: 10826ca49bfb42c98bcc2b03b20c7631-20201218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 958225091; Fri, 18 Dec 2020 02:13:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Dec 2020 02:13:22 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 02:13:21 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <Eric.Liang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v3 2/8] mt76: mt7921: add MCU support
Date:   Fri, 18 Dec 2020 02:13:15 +0800
Message-ID: <740629bc7489245aad025444916d8ee0b179bfc1.1608227863.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1608227863.git.objelf@gmail.com>
References: <cover.1608227863.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7921 contains a microprocessor with which the host can use command/event
to communicate to implement offload features such as establish connection,
hardware scan and so on. The host has to download the ROM patch, RAM
firmware and finally activate the MCU to complete the MT7921
initialization.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  333 +++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 2391 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 1075 ++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  352 +++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  413 +++
 6 files changed, 4565 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regs.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index fa7b42721631..85fd49cd23ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_MT7921E) += mt7921e.o
 
-mt7921e-y := pci.o
+mt7921e-y := pci.o mcu.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
new file mode 100644
index 000000000000..a0c1fa0f20e4
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_MAC_H
+#define __MT7921_MAC_H
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
+#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
+#define MT_RXD4_NORMAL_CLS		BIT(10)
+#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
+#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
+#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
+#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
+#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
+#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
+
+/* P-RXV */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(9, 7)
+#define MT_PRXV_HT_AD_CODE		BIT(11)
+#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
+#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+
+/* C-RXV */
+#define MT_CRXV_HT_STBC			GENMASK(1, 0)
+#define MT_CRXV_TX_MODE			GENMASK(7, 4)
+#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
+#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_UPLINK		BIT(31)
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
+#define MT_TX_RATE_IDX			GENMASK(3, 0)
+
+#define MT_TXP_MAX_BUF_NUM		6
+
+struct mt7921_txp {
+	__le16 flags;
+	__le16 token;
+	u8 bss_idx;
+	__le16 rept_wds_wcid;
+	u8 nbuf;
+	__le32 buf[MT_TXP_MAX_BUF_NUM];
+	__le16 len[MT_TXP_MAX_BUF_NUM];
+} __packed __aligned(4);
+
+struct mt7921_tx_free {
+	__le16 rx_byte_cnt;
+	__le16 ctrl;
+	u8 txd_cnt;
+	u8 rsv[3];
+	__le32 info[];
+} __packed __aligned(4);
+
+#define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
+#define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
+#define MT_TX_FREE_LATENCY		GENMASK(12, 0)
+/* 0: success, others: dropped */
+#define MT_TX_FREE_STATUS		GENMASK(14, 13)
+#define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
+#define MT_TX_FREE_PAIR			BIT(31)
+/* will support this field in further revision */
+#define MT_TX_FREE_RATE			GENMASK(13, 0)
+
+static inline struct mt7921_txp_common *
+mt7921_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	u8 *txwi;
+
+	if (!t)
+		return NULL;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	return (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
+}
+
+#define MT_HW_TXP_MAX_MSDU_NUM		4
+#define MT_HW_TXP_MAX_BUF_NUM		4
+
+#define MT_MSDU_ID_VALID		BIT(15)
+
+#define MT_TXD_LEN_MASK			GENMASK(11, 0)
+#define MT_TXD_LEN_MSDU_LAST		BIT(14)
+#define MT_TXD_LEN_AMSDU_LAST		BIT(15)
+#define MT_TXD_LEN_LAST			BIT(15)
+
+struct mt7921_txp_ptr {
+	__le32 buf0;
+	__le16 len0;
+	__le16 len1;
+	__le32 buf1;
+} __packed __aligned(4);
+
+struct mt7921_hw_txp {
+	__le16 msdu_id[MT_HW_TXP_MAX_MSDU_NUM];
+	struct mt7921_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
+} __packed __aligned(4);
+
+struct mt7921_txp_common {
+	union {
+		struct mt7921_hw_txp hw;
+	};
+};
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
new file mode 100644
index 000000000000..ac78d40fd4a2
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -0,0 +1,2391 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include "mt7921.h"
+#include "mcu.h"
+#include "mac.h"
+
+struct mt7921_patch_hdr {
+	char build_date[16];
+	char platform[4];
+	__be32 hw_sw_ver;
+	__be32 patch_ver;
+	__be16 checksum;
+	u16 reserved;
+	struct {
+		__be32 patch_ver;
+		__be32 subsys;
+		__be32 feature;
+		__be32 n_region;
+		__be32 crc;
+		u32 reserved[11];
+	} desc;
+} __packed;
+
+struct mt7921_patch_sec {
+	__be32 type;
+	__be32 offs;
+	__be32 size;
+	union {
+		__be32 spec[13];
+		struct {
+			__be32 addr;
+			__be32 len;
+			__be32 sec_key_idx;
+			__be32 align_len;
+			u32 reserved[9];
+		} info;
+	};
+} __packed;
+
+struct mt7921_fw_trailer {
+	u8 chip_id;
+	u8 eco_code;
+	u8 n_region;
+	u8 format_ver;
+	u8 format_flag;
+	u8 reserved[2];
+	char fw_ver[10];
+	char build_date[15];
+	u32 crc;
+} __packed;
+
+struct mt7921_fw_region {
+	__le32 decomp_crc;
+	__le32 decomp_len;
+	__le32 decomp_blk_sz;
+	u8 reserved[4];
+	__le32 addr;
+	__le32 len;
+	u8 feature_set;
+	u8 reserved1[15];
+} __packed;
+
+#define MCU_PATCH_ADDRESS		0x200000
+
+#define MT_STA_BFER			BIT(0)
+#define MT_STA_BFEE			BIT(1)
+
+#define FW_FEATURE_SET_ENCRYPT		BIT(0)
+#define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
+#define FW_FEATURE_ENCRY_MODE		BIT(4)
+#define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
+
+#define DL_MODE_ENCRYPT			BIT(0)
+#define DL_MODE_KEY_IDX			GENMASK(2, 1)
+#define DL_MODE_RESET_SEC_IV		BIT(3)
+#define DL_MODE_WORKING_PDA_CR4		BIT(4)
+#define DL_CONFIG_ENCRY_MODE_SEL	BIT(6)
+#define DL_MODE_NEED_RSP		BIT(31)
+
+#define FW_START_OVERRIDE		BIT(0)
+#define FW_START_WORKING_PDA_CR4	BIT(2)
+
+#define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
+#define PATCH_SEC_TYPE_INFO		0x2
+
+#define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
+#define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
+
+#define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
+#define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
+
+static enum mt7921_cipher_type
+mt7921_mcu_get_cipher(int cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return MT_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return MT_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return MT_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return MT_CIPHER_BIP_CMAC_128;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return MT_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return MT_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return MT_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return MT_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return MT_CIPHER_WAPI;
+	default:
+		return MT_CIPHER_NONE;
+	}
+}
+
+static u8 mt7921_mcu_chan_bw(struct cfg80211_chan_def *chandef)
+{
+	static const u8 width_to_bw[] = {
+		[NL80211_CHAN_WIDTH_40] = CMD_CBW_40MHZ,
+		[NL80211_CHAN_WIDTH_80] = CMD_CBW_80MHZ,
+		[NL80211_CHAN_WIDTH_80P80] = CMD_CBW_8080MHZ,
+		[NL80211_CHAN_WIDTH_160] = CMD_CBW_160MHZ,
+		[NL80211_CHAN_WIDTH_5] = CMD_CBW_5MHZ,
+		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
+		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
+		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
+	};
+
+	if (chandef->width >= ARRAY_SIZE(width_to_bw))
+		return 0;
+
+	return width_to_bw[chandef->width];
+}
+
+static const struct ieee80211_sta_he_cap *
+mt7921_get_he_phy_cap(struct mt7921_phy *phy, struct ieee80211_vif *vif)
+{
+	struct ieee80211_supported_band *sband;
+	enum nl80211_band band;
+
+	band = phy->mt76->chandef.chan->band;
+	sband = phy->mt76->hw->wiphy->bands[band];
+
+	return ieee80211_get_he_iftype_cap(sband, vif->type);
+}
+
+static u8
+mt7921_get_phy_mode(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		    enum nl80211_band band, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 mode = 0;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+		struct mt7921_phy *phy = &dev->phy;
+
+		sband = phy->mt76->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_MODE_B | PHY_MODE_G;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_GN;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_24G;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_MODE_A;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_AN;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_MODE_AC;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_5G;
+	}
+
+	return mode;
+}
+
+static u8
+mt7921_get_phy_mode_v2(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       enum nl80211_band band, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 mode = 0;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+		struct mt7921_phy *phy = &dev->phy;
+
+		sband = phy->mt76->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_TYPE_BIT_HR_DSSS | PHY_TYPE_BIT_ERP;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_TYPE_BIT_OFDM;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_TYPE_BIT_VHT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	}
+
+	return mode;
+}
+
+static int
+mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_eeprom_info *res;
+	u8 *buf;
+
+	if (!skb)
+		return -EINVAL;
+
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	buf = dev->eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+
+	return 0;
+}
+
+static int
+mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			  struct sk_buff *skb, int seq)
+{
+	struct mt7921_mcu_rxd *rxd;
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
+			cmd, seq);
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7921_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	switch (cmd) {
+	case MCU_CMD_PATCH_SEM_CONTROL:
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+		break;
+	case MCU_EXT_CMD_THERMAL_CTRL:
+		skb_pull(skb, sizeof(*rxd) + 4);
+		ret = le32_to_cpu(*(__le32 *)skb->data);
+		break;
+	case MCU_EXT_CMD_EFUSE_ACCESS:
+		ret = mt7921_mcu_parse_eeprom(mdev, skb);
+		break;
+	case MCU_UNI_CMD_DEV_INFO_UPDATE:
+	case MCU_UNI_CMD_BSS_INFO_UPDATE:
+	case MCU_UNI_CMD_STA_REC_UPDATE:
+	case MCU_UNI_CMD_HIF_CTRL:
+	case MCU_UNI_CMD_OFFLOAD:
+	case MCU_UNI_CMD_SUSPEND: {
+		struct mt7921_mcu_uni_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		break;
+	}
+	case MCU_CMD_REG_READ: {
+		struct mt7921_mcu_reg_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_reg_event *)skb->data;
+		ret = (int)le32_to_cpu(event->val);
+		break;
+	}
+	default:
+		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *wait_seq)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
+	enum mt76_txq_id txq = MT_MCUQ_WM;
+	struct mt7921_uni_txd *uni_txd;
+	struct mt7921_mcu_txd *mcu_txd;
+	u8 seq, pkt_fmt, qidx;
+	__le32 *txd;
+	u32 val;
+
+	/* TODO: make dynamic based on msg type */
+	mdev->mcu.timeout = 20 * HZ;
+
+	seq = ++dev->mt76.mcu.msg_seq & 0xf;
+	if (!seq)
+		seq = ++dev->mt76.mcu.msg_seq & 0xf;
+
+	if (cmd == MCU_CMD_FW_SCATTER) {
+		txq = MT_MCUQ_FWDL;
+		goto exit;
+	}
+
+	txd_len = cmd & MCU_UNI_PREFIX ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd = (__le32 *)skb_push(skb, txd_len);
+
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
+		qidx = MT_TX_MCU_PORT_RX_Q0;
+		pkt_fmt = MT_TX_TYPE_CMD;
+	} else {
+		qidx = MT_TX_MCU_PORT_RX_Q0;
+		pkt_fmt = MT_TX_TYPE_CMD;
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, pkt_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, qidx);
+	txd[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
+	txd[1] = cpu_to_le32(val);
+
+	if (cmd & MCU_UNI_PREFIX) {
+		uni_txd = (struct mt7921_uni_txd *)txd;
+		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
+		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+		uni_txd->cid = cpu_to_le16(mcu_cmd);
+		uni_txd->s2d_index = MCU_S2D_H2N;
+		uni_txd->pkt_type = MCU_PKT_ID;
+		uni_txd->seq = seq;
+
+		goto exit;
+	}
+
+	mcu_txd = (struct mt7921_mcu_txd *)txd;
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU, qidx));
+	mcu_txd->pkt_type = MCU_PKT_ID;
+	mcu_txd->seq = seq;
+
+	switch (cmd & ~MCU_CMD_MASK) {
+	case MCU_FW_PREFIX:
+		mcu_txd->set_query = MCU_Q_NA;
+		mcu_txd->cid = mcu_cmd;
+		break;
+	case MCU_CE_PREFIX:
+		if (cmd & MCU_QUERY_MASK)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->cid = mcu_cmd;
+		break;
+	default:
+		mcu_txd->cid = MCU_CMD_EXT_CID;
+		if (cmd & MCU_QUERY_PREFIX || cmd == MCU_EXT_CMD_EFUSE_ACCESS)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->ext_cid = mcu_cmd;
+		mcu_txd->ext_cid_ack = 1;
+		break;
+	}
+
+	mcu_txd->s2d_index = MCU_S2D_H2N;
+	WARN_ON(cmd == MCU_EXT_CMD_EFUSE_ACCESS &&
+		mcu_txd->set_query != MCU_Q_QUERY);
+
+exit:
+	if (wait_seq)
+		*wait_seq = seq;
+
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+}
+
+static void
+mt7921_mcu_tx_rate_parse(struct mt76_phy *mphy,
+			 struct mt7921_mcu_peer_cap *peer,
+			 struct rate_info *rate, u16 r)
+{
+	struct ieee80211_supported_band *sband;
+	u16 flags = 0;
+	u8 txmode = FIELD_GET(MT_WTBL_RATE_TX_MODE, r);
+	u8 gi = 0;
+	u8 bw = 0;
+
+	rate->mcs = FIELD_GET(MT_WTBL_RATE_MCS, r);
+	rate->nss = FIELD_GET(MT_WTBL_RATE_NSS, r) + 1;
+
+	switch (peer->bw) {
+	case IEEE80211_STA_RX_BW_160:
+		gi = peer->g16;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		gi = peer->g8;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		gi = peer->g4;
+		break;
+	default:
+		gi = peer->g2;
+		break;
+	}
+
+	gi = txmode >= MT_PHY_TYPE_HE_SU ?
+		FIELD_GET(MT_WTBL_RATE_HE_GI, gi) :
+		FIELD_GET(MT_WTBL_RATE_GI, gi);
+
+	switch (txmode) {
+	case MT_PHY_TYPE_CCK:
+	case MT_PHY_TYPE_OFDM:
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate->legacy = sband->bitrates[rate->mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		flags |= RATE_INFO_FLAGS_MCS;
+
+		if (gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+		if (gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		rate->he_gi = gi;
+		rate->he_dcm = FIELD_GET(MT_RA_RATE_DCM_EN, r);
+
+		flags |= RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		break;
+	}
+	rate->flags = flags;
+
+	bw = mt7921_mcu_chan_bw(&mphy->chandef) - FIELD_GET(MT_RA_RATE_BW, r);
+
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_160:
+		rate->bw = RATE_INFO_BW_160;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate->bw = RATE_INFO_BW_40;
+		break;
+	default:
+		rate->bw = RATE_INFO_BW_20;
+		break;
+	}
+}
+
+static void
+mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
+			  u16 wlan_idx)
+{
+	struct mt7921_mcu_wlan_info_event *wtbl_info =
+		(struct mt7921_mcu_wlan_info_event *)(skb->data);
+	struct rate_info rate = {};
+	u8 curr_idx = wtbl_info->rate_info.rate_idx;
+	u16 curr = le16_to_cpu(wtbl_info->rate_info.rate[curr_idx]);
+	struct mt7921_mcu_peer_cap peer = wtbl_info->peer_cap;
+	struct mt76_phy *mphy = &dev->mphy;
+	struct mt7921_sta_stats *stats;
+	struct mt7921_sta *msta;
+	struct mt76_wcid *wcid;
+
+	if (wlan_idx >= MT76_N_WCIDS)
+		return;
+	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+	if (!wcid) {
+		stats->tx_rate = rate;
+		return;
+	}
+
+	msta = container_of(wcid, struct mt7921_sta, wcid);
+	stats = &msta->stats;
+
+	/* current rate */
+	mt7921_mcu_tx_rate_parse(mphy, &peer, &rate, curr);
+	stats->tx_rate = rate;
+}
+
+static void
+mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+
+	spin_lock_bh(&dev->mt76.lock);
+	__skb_queue_tail(&phy->scan_event_list, skb);
+	spin_unlock_bh(&dev->mt76.lock);
+
+	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
+				     MT7921_HW_SCAN_TIMEOUT);
+}
+
+static void
+mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_mcu_bss_event *event;
+
+	event = (struct mt7921_mcu_bss_event *)(skb->data +
+						sizeof(struct mt7921_mcu_rxd));
+	if (event->is_absent)
+		ieee80211_stop_queues(mphy->hw);
+	else
+		ieee80211_wake_queues(mphy->hw);
+}
+
+static void
+mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+	struct debug_msg {
+		__le16 id;
+		u8 type;
+		u8 flag;
+		__le32 value;
+		__le16 len;
+		u8 content[512];
+	} __packed * debug_msg;
+	u16 cur_len;
+	int i;
+
+	skb_pull(skb, sizeof(*rxd));
+	debug_msg = (struct debug_msg *)skb->data;
+
+	cur_len = min_t(u16, le16_to_cpu(debug_msg->len), 512);
+
+	if (debug_msg->type == 0x3) {
+		for (i = 0 ; i < cur_len; i++)
+			if (!debug_msg->content[i])
+				debug_msg->content[i] = ' ';
+
+		dev_dbg(dev->mt76.dev, "%s", debug_msg->content);
+	}
+}
+
+static void
+mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_EVENT_BSS_BEACON_LOSS:
+		break;
+	case MCU_EVENT_SCHED_SCAN_DONE:
+	case MCU_EVENT_SCAN_DONE:
+		mt7921_mcu_scan_event(dev, skb);
+		return;
+	case MCU_EVENT_BSS_ABSENCE:
+		mt7921_mcu_bss_event(dev, skb);
+		break;
+	case MCU_EVENT_DBG_MSG:
+		mt7921_mcu_debug_msg_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+
+	if (rxd->eid == 0x6) {
+		mt76_mcu_rx_event(&dev->mt76, skb);
+		return;
+	}
+
+	if (rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
+	    rxd->eid == MCU_EVENT_BSS_BEACON_LOSS ||
+	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
+	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_DBG_MSG ||
+	    !rxd->seq)
+		mt7921_mcu_rx_unsolicited_event(dev, skb);
+	else
+		mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
+static struct sk_buff *
+mt7921_mcu_alloc_sta_req(struct mt7921_dev *dev, struct mt7921_vif *mvif,
+			 struct mt7921_sta *msta, int len)
+{
+	struct sta_req_hdr hdr = {
+		.bss_idx = mvif->idx,
+		.wlan_idx_lo = msta ? to_wcid_lo(msta->wcid.idx) : 0,
+		.wlan_idx_hi = msta ? to_wcid_hi(msta->wcid.idx) : 0,
+		.muar_idx = msta ? mvif->omac_idx : 0,
+		.is_tlv_append = 1,
+	};
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	return skb;
+}
+
+static struct wtbl_req_hdr *
+mt7921_mcu_alloc_wtbl_req(struct mt7921_dev *dev, struct mt7921_sta *msta,
+			  int cmd, void *sta_wtbl, struct sk_buff **skb)
+{
+	struct tlv *sta_hdr = sta_wtbl;
+	struct wtbl_req_hdr hdr = {
+		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
+		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
+		.operation = cmd,
+	};
+	struct sk_buff *nskb = *skb;
+
+	if (!nskb) {
+		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+					  MT7921_WTBL_UPDATE_BA_SIZE);
+		if (!nskb)
+			return ERR_PTR(-ENOMEM);
+
+		*skb = nskb;
+	}
+
+	if (sta_hdr)
+		sta_hdr->len = cpu_to_le16(sizeof(hdr));
+
+	return skb_put_data(nskb, &hdr, sizeof(hdr));
+}
+
+static struct tlv *
+mt7921_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
+			  void *sta_ntlv, void *sta_wtbl)
+{
+	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
+	struct tlv *sta_hdr = sta_wtbl;
+	struct tlv *ptlv, tlv = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(len),
+	};
+	u16 ntlv;
+
+	ptlv = skb_put(skb, len);
+	memcpy(ptlv, &tlv, sizeof(tlv));
+
+	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
+	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
+
+	if (sta_hdr) {
+		u16 size = le16_to_cpu(sta_hdr->len);
+
+		sta_hdr->len = cpu_to_le16(size + len);
+	}
+
+	return ptlv;
+}
+
+static struct tlv *
+mt7921_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
+{
+	return mt7921_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
+}
+
+static void
+mt7921_mcu_uni_bss_he_tlv(struct tlv *tlv, struct ieee80211_vif *vif,
+			  struct mt7921_phy *phy)
+{
+#define DEFAULT_HE_PE_DURATION		4
+#define DEFAULT_HE_DURATION_RTS_THRES	1023
+	const struct ieee80211_sta_he_cap *cap;
+	struct bss_info_uni_he *he;
+
+	cap = mt7921_get_he_phy_cap(phy, vif);
+
+	he = (struct bss_info_uni_he *)tlv;
+	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	if (!he->he_pe_duration)
+		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
+
+	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	if (!he->he_rts_thres)
+		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
+	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
+	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+/** starec & wtbl **/
+static int
+mt7921_mcu_sta_key_tlv(struct sk_buff *skb, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd)
+{
+	struct sta_rec_sec *sec;
+	struct tlv *tlv;
+	u32 len = sizeof(*sec);
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+
+	sec = (struct sta_rec_sec *)tlv;
+	sec->add = cmd;
+
+	if (cmd == SET_KEY) {
+		struct sec_key *sec_key;
+		u8 cipher;
+
+		cipher = mt7921_mcu_get_cipher(key->cipher);
+		if (cipher == MT_CIPHER_NONE)
+			return -EOPNOTSUPP;
+
+		sec_key = &sec->key[0];
+		sec_key->cipher_len = sizeof(*sec_key);
+		sec_key->key_id = key->keyidx;
+
+		if (cipher == MT_CIPHER_BIP_CMAC_128) {
+			sec_key->cipher_id = MT_CIPHER_AES_CCMP;
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key, 16);
+
+			sec_key = &sec->key[1];
+			sec_key->cipher_id = MT_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_len = sizeof(*sec_key);
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key + 16, 16);
+
+			sec->n_cipher = 2;
+		} else {
+			sec_key->cipher_id = cipher;
+			sec_key->key_len = key->keylen;
+			memcpy(sec_key->key, key->key, key->keylen);
+
+			if (cipher == MT_CIPHER_TKIP) {
+				/* Rx/Tx MIC keys are swapped */
+				memcpy(sec_key->key + 16, key->key + 24, 8);
+				memcpy(sec_key->key + 24, key->key + 16, 8);
+			}
+
+			len -= sizeof(*sec_key);
+			sec->n_cipher = 1;
+		}
+	} else {
+		len -= sizeof(sec->key);
+		sec->n_cipher = 0;
+	}
+	sec->len = cpu_to_le16(len);
+
+	return 0;
+}
+
+int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct sk_buff *skb;
+	int len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_sec);
+	int ret;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = mt7921_mcu_sta_key_tlv(skb, key, cmd);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD_STA_REC_UPDATE, true);
+}
+
+static void
+mt7921_mcu_sta_ba_tlv(struct sk_buff *skb,
+		      struct ieee80211_ampdu_params *params,
+		      bool enable, bool tx)
+{
+	struct sta_rec_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+
+	ba = (struct sta_rec_ba *)tlv;
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT,
+	ba->winsize = cpu_to_le16(params->buf_size);
+	ba->ssn = cpu_to_le16(params->ssn);
+	ba->ba_en = enable << params->tid;
+	ba->amsdu = params->amsdu;
+	ba->tid = params->tid;
+}
+
+static void
+mt7921_mcu_wtbl_ba_tlv(struct sk_buff *skb,
+		       struct ieee80211_ampdu_params *params,
+		       bool enable, bool tx, void *sta_wtbl,
+		       void *wtbl_tlv)
+{
+	struct wtbl_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
+					wtbl_tlv, sta_wtbl);
+
+	ba = (struct wtbl_ba *)tlv;
+	ba->tid = params->tid;
+
+	if (tx) {
+		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
+		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
+		ba->ba_en = enable;
+	} else {
+		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
+		ba->ba_type = MT_BA_TYPE_RECIPIENT;
+		ba->rst_ba_tid = params->tid;
+		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
+		ba->rst_ba_sb = 1;
+	}
+
+	if (enable && tx)
+		ba->ba_winsize = cpu_to_le16(params->buf_size);
+}
+
+static int
+mt7921_mcu_sta_ba(struct mt7921_dev *dev,
+		  struct ieee80211_ampdu_params *params,
+		  bool enable, bool tx, int cmd)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
+	struct mt7921_vif *mvif = msta->vif;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int ret;
+
+	if (enable && tx && !params->amsdu)
+		msta->wcid.amsdu = false;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
+					     &skb);
+	mt7921_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
+
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+	if (ret)
+		return ret;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7921_mcu_sta_ba_tlv(skb, params, enable, tx);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+}
+
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	return mt7921_mcu_sta_ba(dev, params, enable, true, MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	return mt7921_mcu_sta_ba(dev, params, enable, false, MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+static void
+mt7921_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, void *sta_wtbl,
+			    void *wtbl_tlv)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct wtbl_generic *generic;
+	struct wtbl_rx *rx;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_GENERIC, sizeof(*generic),
+					wtbl_tlv, sta_wtbl);
+
+	generic = (struct wtbl_generic *)tlv;
+
+	if (sta) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
+		else
+			generic->partial_aid = cpu_to_le16(sta->aid);
+		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
+		generic->muar_idx = mvif->omac_idx;
+		generic->qos = sta->wme;
+	} else {
+		/* use BSSID in station mode */
+		if (vif->type == NL80211_IFTYPE_STATION)
+			memcpy(generic->peer_addr, vif->bss_conf.bssid,
+			       ETH_ALEN);
+		else
+			eth_broadcast_addr(generic->peer_addr);
+
+		generic->muar_idx = 0xe;
+	}
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
+					wtbl_tlv, sta_wtbl);
+
+	rx = (struct wtbl_rx *)tlv;
+	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
+	rx->rca2 = 1;
+	rx->rv = 1;
+}
+
+static void
+mt7921_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, bool enable)
+{
+#define EXTRA_INFO_VER          BIT(0)
+#define EXTRA_INFO_NEW          BIT(1)
+	struct sta_rec_basic *basic;
+	struct tlv *tlv;
+	int conn_type;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
+
+	basic = (struct sta_rec_basic *)tlv;
+	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
+
+	if (enable) {
+		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
+		basic->conn_state = CONN_STATE_PORT_SECURE;
+	} else {
+		basic->conn_state = CONN_STATE_DISCONNECT;
+	}
+
+	if (!sta) {
+		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
+		eth_broadcast_addr(basic->peer_addr);
+		return;
+	}
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(vif->bss_conf.aid);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
+	basic->qos = sta->wme;
+}
+
+static void
+mt7921_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct sta_rec_he *he;
+	struct tlv *tlv;
+	u32 cap = 0;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
+
+	he = (struct sta_rec_he *)tlv;
+
+	if (elem->mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
+		cap |= STA_REC_HE_CAP_HTC;
+
+	if (elem->mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
+		cap |= STA_REC_HE_CAP_BSR;
+
+	if (elem->mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
+		cap |= STA_REC_HE_CAP_OM;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU)
+		cap |= STA_REC_HE_CAP_AMSDU_IN_AMPDU;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
+		cap |= STA_REC_HE_CAP_BQR;
+
+	if (elem->phy_cap_info[0] &
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G |
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
+		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
+		cap |= STA_REC_HE_CAP_LDPC;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US)
+		cap |= STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US)
+		cap |= STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_TX_STBC;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
+
+	if (elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
+		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_TX_STBC;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_RX_STBC;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK)
+		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242;
+
+	he->he_cap = cpu_to_le32(cap);
+
+	switch (sta->bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+
+		he->max_nss_mcs[CMD_HE_MCS_BW160] =
+				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		fallthrough;
+	default:
+		he->max_nss_mcs[CMD_HE_MCS_BW80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		break;
+	}
+
+	he->t_frame_dur =
+		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
+	he->max_ampdu_exp =
+		HE_MAC(CAP3_MAX_AMPDU_LEN_EXP_MASK, elem->mac_cap_info[3]);
+
+	he->bw_set =
+		HE_PHY(CAP0_CHANNEL_WIDTH_SET_MASK, elem->phy_cap_info[0]);
+	he->device_class =
+		HE_PHY(CAP1_DEVICE_CLASS_A, elem->phy_cap_info[1]);
+	he->punc_pream_rx =
+		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
+
+	he->dcm_tx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_TX_MASK, elem->phy_cap_info[3]);
+	he->dcm_tx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_TX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_RX_MASK, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_RX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP8_DCM_MAX_RU_MASK, elem->phy_cap_info[8]);
+
+	he->pkt_ext = 2;
+}
+
+static void
+mt7921_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			 struct ieee80211_vif *vif)
+{
+	struct sta_rec_uapsd *uapsd;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
+		return;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
+	uapsd = (struct sta_rec_uapsd *)tlv;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
+		uapsd->dac_map |= BIT(3);
+		uapsd->tac_map |= BIT(3);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
+		uapsd->dac_map |= BIT(2);
+		uapsd->tac_map |= BIT(2);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
+		uapsd->dac_map |= BIT(1);
+		uapsd->tac_map |= BIT(1);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
+		uapsd->dac_map |= BIT(0);
+		uapsd->tac_map |= BIT(0);
+	}
+	uapsd->max_sp = sta->max_sp;
+}
+
+static void
+mt7921_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (!sta->max_amsdu_len)
+		return;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+	amsdu->max_mpdu_size = sta->max_amsdu_len >=
+			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
+	msta->wcid.amsdu = true;
+}
+
+static bool
+mt7921_hw_amsdu_supported(struct ieee80211_vif *vif)
+{
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_STATION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void
+mt7921_mcu_sta_tlv(struct mt7921_dev *dev, struct sk_buff *skb,
+		   struct ieee80211_sta *sta, struct ieee80211_vif *vif)
+{
+	struct tlv *tlv;
+	struct sta_rec_state *state;
+	struct sta_rec_phy *phy;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	enum nl80211_band band = chandef->chan->band;
+	u32 supp_rate = sta->supp_rates[band];
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+
+	/* starec ht */
+	if (sta->ht_cap.ht_supported) {
+		struct sta_rec_ht *ht;
+
+		tlv = mt7921_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+		ht = (struct sta_rec_ht *)tlv;
+		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+
+		if (mt7921_hw_amsdu_supported(vif))
+			mt7921_mcu_sta_amsdu_tlv(skb, sta);
+	}
+
+	/* starec vht */
+	if (sta->vht_cap.vht_supported) {
+		struct sta_rec_vht *vht;
+
+		tlv = mt7921_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
+		vht = (struct sta_rec_vht *)tlv;
+		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
+		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
+		vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
+	}
+
+	/* starec he */
+	if (sta->he_cap.has_he)
+		mt7921_mcu_sta_he_tlv(skb, sta);
+
+	/* starec uapsd */
+	mt7921_mcu_sta_uapsd_tlv(skb, sta, vif);
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
+	phy = (struct sta_rec_phy *)tlv;
+	phy->legacy = supp_rate;
+	phy->phy_type = mt7921_get_phy_mode_v2(dev, vif, band, sta);
+	phy->basic_rate = vif->bss_conf.basic_rates;
+
+	if (sta->ht_cap.ht_supported) {
+		memcpy(phy->rx_mcs_bitmask, sta->ht_cap.mcs.rx_mask,
+		       HT_MCS_MASK_NUM);
+	}
+
+	if (sta->he_cap.has_he) {
+		memcpy(phy->he_mac_cap, elem->mac_cap_info, HE_MAC_CAP_BYTE_NUM);
+		memcpy(phy->he_phy_cap, elem->phy_cap_info, HE_PHY_CAP_BYTE_NUM);
+	}
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
+	state = (struct sta_rec_state *)tlv;
+	state->state = 2;
+
+	if (sta->vht_cap.vht_supported) {
+		state->vht_opmode = sta->bandwidth;
+		state->vht_opmode |= (sta->rx_nss - 1) <<
+			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
+	}
+}
+
+static void
+mt7921_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			 void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_smps *smps;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
+					wtbl_tlv, sta_wtbl);
+	smps = (struct wtbl_smps *)tlv;
+
+	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
+		smps->smps = true;
+}
+
+static void
+mt7921_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+		       void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_ht *ht = NULL;
+	struct tlv *tlv;
+
+	/* wtbl ht */
+	if (sta->ht_cap.ht_supported) {
+		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
+						wtbl_tlv, sta_wtbl);
+		ht = (struct wtbl_ht *)tlv;
+		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+		ht->af = sta->ht_cap.ampdu_factor;
+		ht->mm = sta->ht_cap.ampdu_density;
+		ht->ht = true;
+	}
+
+	/* wtbl vht */
+	if (sta->vht_cap.vht_supported) {
+		struct wtbl_vht *vht;
+		u8 af;
+
+		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
+						wtbl_tlv, sta_wtbl);
+		vht = (struct wtbl_vht *)tlv;
+		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->vht = true;
+
+		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			       sta->vht_cap.cap);
+		if (ht)
+			ht->af = max_t(u8, ht->af, af);
+	}
+
+	mt7921_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
+}
+
+static void
+mt7921_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      void *sta_wtbl, void *wtbl_tlv)
+{
+	struct mt7921_sta *msta;
+	struct wtbl_hdr_trans *htr = NULL;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS, sizeof(*htr),
+					wtbl_tlv, sta_wtbl);
+	htr = (struct wtbl_hdr_trans *)tlv;
+	htr->no_rx_trans = true;
+	if (vif->type == NL80211_IFTYPE_STATION)
+		htr->to_ds = true;
+	else
+		htr->from_ds = true;
+
+	if (!sta)
+		return;
+
+	msta = (struct mt7921_sta *)sta->drv_priv;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)) {
+		htr->to_ds = true;
+		htr->from_ds = true;
+	}
+}
+
+int mt7921_mcu_sta_update_hdr_trans(struct mt7921_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, MT7921_WTBL_UPDATE_MAX_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	mt7921_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				     true);
+}
+
+static int mt7921_mcu_start_firmware(struct mt7921_dev *dev, u32 addr,
+				     u32 option)
+{
+	struct {
+		__le32 option;
+		__le32 addr;
+	} req = {
+		.option = cpu_to_le32(option),
+		.addr = cpu_to_le32(addr),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_mcu_restart(struct mt76_dev *dev)
+{
+	struct {
+		u8 power_mode;
+		u8 rsv[3];
+	} req = {
+		.power_mode = 1,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_NIC_POWER_CTRL, &req,
+				 sizeof(req), false);
+}
+
+static int mt7921_mcu_patch_sem_ctrl(struct mt7921_dev *dev, bool get)
+{
+	struct {
+		__le32 op;
+	} req = {
+		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_mcu_start_patch(struct mt7921_dev *dev)
+{
+	struct {
+		u8 check_crc;
+		u8 reserved[3];
+	} req = {
+		.check_crc = 0,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_driver_own(struct mt7921_dev *dev)
+{
+	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
+			    0, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for driver own\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mt7921_mcu_init_download(struct mt7921_dev *dev, u32 addr,
+				    u32 len, u32 mode)
+{
+	struct {
+		__le32 addr;
+		__le32 len;
+		__le32 mode;
+	} req = {
+		.addr = cpu_to_le32(addr),
+		.len = cpu_to_le32(len),
+		.mode = cpu_to_le32(mode),
+	};
+	int attr;
+
+	if (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS) || addr == 0x900000)
+		attr = MCU_CMD_PATCH_START_REQ;
+	else
+		attr = MCU_CMD_TARGET_ADDRESS_LEN_REQ;
+
+	return mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
+}
+
+static int mt7921_load_patch(struct mt7921_dev *dev)
+{
+	const struct mt7921_patch_hdr *hdr;
+	const struct firmware *fw = NULL;
+	int i, ret, sem;
+
+	sem = mt7921_mcu_patch_sem_ctrl(dev, 1);
+	switch (sem) {
+	case PATCH_IS_DL:
+		return 0;
+	case PATCH_NOT_DL_SEM_SUCCESS:
+		break;
+	default:
+		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
+		return -EAGAIN;
+	}
+
+	ret = request_firmware(&fw, MT7921_ROM_PATCH, dev->mt76.dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7921_patch_hdr *)(fw->data);
+
+	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
+
+	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
+		struct mt7921_patch_sec *sec;
+		const u8 *dl;
+		u32 len, addr;
+
+		sec = (struct mt7921_patch_sec *)(fw->data + sizeof(*hdr) +
+						  i * sizeof(*sec));
+		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
+		    PATCH_SEC_TYPE_INFO) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		addr = be32_to_cpu(sec->info.addr);
+		len = be32_to_cpu(sec->info.len);
+		dl = fw->data + be32_to_cpu(sec->offs);
+
+		ret = mt7921_mcu_init_download(dev, addr, len,
+					       DL_MODE_NEED_RSP);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			goto out;
+		}
+
+		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     dl, len);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Failed to send patch\n");
+			goto out;
+		}
+	}
+
+	ret = mt7921_mcu_start_patch(dev);
+	if (ret)
+		dev_err(dev->mt76.dev, "Failed to start patch\n");
+
+out:
+	sem = mt7921_mcu_patch_sem_ctrl(dev, 0);
+	switch (sem) {
+	case PATCH_REL_SEM_SUCCESS:
+		break;
+	default:
+		ret = -EAGAIN;
+		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
+		goto out;
+	}
+	release_firmware(fw);
+
+	return ret;
+}
+
+static u32 mt7921_mcu_gen_dl_mode(u8 feature_set, bool is_wa)
+{
+	u32 ret = 0;
+
+	ret |= (feature_set & FW_FEATURE_SET_ENCRYPT) ?
+	       (DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV) : 0;
+	ret |= (feature_set & FW_FEATURE_ENCRY_MODE) ?
+	       DL_CONFIG_ENCRY_MODE_SEL : 0;
+	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
+			  FIELD_GET(FW_FEATURE_SET_KEY_IDX, feature_set));
+	ret |= DL_MODE_NEED_RSP;
+	ret |= is_wa ? DL_MODE_WORKING_PDA_CR4 : 0;
+
+	return ret;
+}
+
+static int
+mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
+			     const struct mt7921_fw_trailer *hdr,
+			     const u8 *data, bool is_wa)
+{
+	int i, offset = 0;
+	u32 override = 0, option = 0;
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt7921_fw_region *region;
+		int err;
+		u32 len, addr, mode;
+
+		region = (const struct mt7921_fw_region *)((const u8 *)hdr -
+			 (hdr->n_region - i) * sizeof(*region));
+		mode = mt7921_mcu_gen_dl_mode(region->feature_set, is_wa);
+		len = le32_to_cpu(region->len);
+		addr = le32_to_cpu(region->addr);
+
+		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
+			override = addr;
+
+		err = mt7921_mcu_init_download(dev, addr, len, mode);
+		if (err) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			return err;
+		}
+
+		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     data + offset, len);
+		if (err) {
+			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
+			return err;
+		}
+
+		offset += len;
+	}
+
+	if (override)
+		option |= FW_START_OVERRIDE;
+
+	if (is_wa)
+		option |= FW_START_WORKING_PDA_CR4;
+
+	return mt7921_mcu_start_firmware(dev, override, option);
+}
+
+static int mt7921_load_ram(struct mt7921_dev *dev)
+{
+	const struct mt7921_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, MT7921_FIRMWARE_WM, dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7921_fw_trailer *)(fw->data + fw->size -
+					sizeof(*hdr));
+
+	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt7921_mcu_send_ram_firmware(dev, hdr, fw->data, false);
+	if (ret) {
+		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->mt76.hw->wiphy->fw_version,
+		 sizeof(dev->mt76.hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int mt7921_load_firmware(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
+	if (ret) {
+		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
+		return -EIO;
+	}
+
+	ret = mt7921_load_patch(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_load_ram(dev);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
+			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+
+		return -EIO;
+	}
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
+
+	dev_err(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
+{
+	struct {
+		u8 ctrl_val;
+		u8 pad[3];
+	} data = {
+		.ctrl_val = ctrl
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FWLOG_2_HOST, &data,
+				 sizeof(data), false);
+}
+
+int mt7921_mcu_init(struct mt7921_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7921_mcu_ops = {
+		.headroom = sizeof(struct mt7921_mcu_txd),
+		.mcu_skb_send_msg = mt7921_mcu_send_message,
+		.mcu_parse_response = mt7921_mcu_parse_response,
+		.mcu_restart = mt7921_mcu_restart,
+	};
+	int ret;
+
+	dev->mt76.mcu_ops = &mt7921_mcu_ops;
+
+	ret = mt7921_driver_own(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_load_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	mt7921_mcu_fw_log_2_host(dev, 1);
+
+	return 0;
+}
+
+void mt7921_mcu_exit(struct mt7921_dev *dev)
+{
+	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_MISC);
+
+	__mt76_mcu_restart(&dev->mt76);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE,
+			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
+				       FW_STATE_FW_DOWNLOAD), 1000)) {
+		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
+		return;
+	}
+
+	reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_FW_OWN);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+}
+
+int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band,
+		       bool enable, bool hdr_trans)
+{
+	struct {
+		u8 operation;
+		u8 enable;
+		u8 check_bssid;
+		u8 insert_vlan;
+		u8 remove_vlan;
+		u8 tid;
+		u8 mode;
+		u8 rsv;
+	} __packed req_trans = {
+		.enable = hdr_trans,
+	};
+	struct {
+		u8 enable;
+		u8 band;
+		u8 rsv[2];
+	} __packed req_mac = {
+		.enable = enable,
+		.band = band,
+	};
+	int ret;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
+				&req_trans, sizeof(req_trans), false);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
+				 &req_mac, sizeof(req_mac), true);
+}
+
+int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 prot_idx;
+		u8 band;
+		u8 rsv[2];
+		__le32 len_thresh;
+		__le32 pkt_thresh;
+	} __packed req = {
+		.prot_idx = 1,
+		.band = phy != &dev->phy,
+		.len_thresh = cpu_to_le32(val),
+		.pkt_thresh = cpu_to_le32(0x2),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+#define WMM_AIFS_SET		BIT(0)
+#define WMM_CW_MIN_SET		BIT(1)
+#define WMM_CW_MAX_SET		BIT(2)
+#define WMM_TXOP_SET		BIT(3)
+#define WMM_PARAM_SET		GENMASK(3, 0)
+#define TX_CMD_MODE		1
+	struct edca {
+		u8 queue;
+		u8 set;
+		u8 aifs;
+		u8 cw_min;
+		__le16 cw_max;
+		__le16 txop;
+	};
+	struct mt7921_mcu_tx {
+		u8 total;
+		u8 action;
+		u8 valid;
+		u8 mode;
+
+		struct edca edca[IEEE80211_NUM_ACS];
+	} __packed req = {
+		.valid = true,
+		.mode = TX_CMD_MODE,
+		.total = IEEE80211_NUM_ACS,
+	};
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct edca *e = &req.edca[ac];
+
+		e->set = WMM_PARAM_SET;
+		e->queue = ac + mvif->wmm_idx * MT7921_MAX_WMM_SETS;
+		e->aifs = q->aifs;
+		e->txop = cpu_to_le16(q->txop);
+
+		if (q->cw_min)
+			e->cw_min = fls(q->cw_min);
+		else
+			e->cw_min = 5;
+
+		if (q->cw_max)
+			e->cw_max = cpu_to_le16(fls(q->cw_max));
+		else
+			e->cw_max = cpu_to_le16(10);
+	}
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1;
+	struct {
+		u8 control_ch;
+		u8 center_ch;
+		u8 bw;
+		u8 tx_streams_num;
+		u8 rx_streams;	/* mask or num */
+		u8 switch_reason;
+		u8 band_idx;
+		u8 center_ch2;	/* for 80+80 only */
+		__le16 cac_case;
+		u8 channel_band;
+		u8 rsv0;
+		__le32 outband_freq;
+		u8 txpower_drop;
+		u8 ap_bw;
+		u8 ap_center_ch;
+		u8 rsv1[57];
+	} __packed req = {
+		.control_ch = chandef->chan->hw_value,
+		.center_ch = ieee80211_frequency_to_channel(freq1),
+		.bw = mt7921_mcu_chan_bw(chandef),
+		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
+		.rx_streams = phy->mt76->antenna_mask,
+		.band_idx = phy != &dev->phy,
+		.channel_band = chandef->chan->band,
+	};
+
+	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
+	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+		req.switch_reason = CH_SWITCH_DFS;
+	else
+		req.switch_reason = CH_SWITCH_NORMAL;
+
+	if (cmd == MCU_EXT_CMD_CHANNEL_SWITCH)
+		req.rx_streams = hweight8(req.rx_streams);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		int freq2 = chandef->center_freq2;
+
+		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+}
+
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
+{
+	struct req_hdr {
+		u8 buffer_mode;
+		u8 format;
+		__le16 len;
+	} __packed req = {
+		.buffer_mode = EE_MODE_EFUSE,
+		.format = EE_FORMAT_WHOLE,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+				 &req, sizeof(req), true);
+}
+
+int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
+{
+	struct mt7921_mcu_eeprom_info req = {
+		.addr = cpu_to_le32(round_down(offset, 16)),
+	};
+	struct mt7921_mcu_eeprom_info *res;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
+					sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int
+mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
+		       struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 pad;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_bss_basic_tlv basic;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = enable,
+			.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.sta_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.conn_state = 1,
+		},
+	};
+	int err, idx, cmd, len;
+	void *data;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		break;
+	case NL80211_IFTYPE_STATION:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+
+	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
+	data = enable ? (void *)&dev_req : (void *)&basic_req;
+	len = enable ? sizeof(dev_req) : sizeof(basic_req);
+
+	err = mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+	if (err < 0)
+		return err;
+
+	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
+	data = enable ? (void *)&basic_req : (void *)&dev_req;
+	len = enable ? sizeof(basic_req) : sizeof(dev_req);
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+}
+
+int
+mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	struct mt7921_dev *dev = phy->dev;
+	enum nl80211_band band = chandef->chan->band;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_bss_basic_tlv basic;
+		struct mt7921_bss_qos_tlv qos;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = true, /* keep bss deactivated */
+			.phymode = mt7921_get_phy_mode(phy->dev, vif, band, NULL),
+		},
+		.qos = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_qos_tlv)),
+			.qos = vif->bss_conf.qos,
+		},
+	};
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bss_info_uni_he he;
+	} he_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.he = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_HE_BASIC),
+			.len = cpu_to_le16(sizeof(struct bss_info_uni_he)),
+		},
+	};
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct rlm_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 control_channel;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw;
+			u8 tx_streams;
+			u8 rx_streams;
+			u8 short_st;
+			u8 ht_op_info;
+			u8 sco;
+			u8 pad[3];
+		} __packed rlm;
+	} __packed rlm_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.rlm = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
+			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
+			.control_channel = chandef->chan->hw_value,
+			.center_chan = ieee80211_frequency_to_channel(freq1),
+			.center_chan2 = ieee80211_frequency_to_channel(freq2),
+			.tx_streams = hweight8(phy->mt76->antenna_mask),
+			.rx_streams = phy->chainmask,
+			.short_st = true,
+		},
+	};
+	int err, conn_type;
+	u8 idx;
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
+	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx);
+	basic_req.basic.sta_idx = cpu_to_le16(mvif->sta.wcid.idx);
+	basic_req.basic.conn_state = !enable;
+
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				&basic_req, sizeof(basic_req), true);
+	if (err < 0)
+		return err;
+
+	if (vif->bss_conf.he_support) {
+		mt7921_mcu_uni_bss_he_tlv((struct tlv *)&he_req.he, vif, phy);
+
+		err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+					&he_req, sizeof(he_req), true);
+		if (err < 0)
+			return err;
+	}
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		rlm_req.rlm.bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		rlm_req.rlm.bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		rlm_req.rlm.bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		rlm_req.rlm.bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		rlm_req.rlm.bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		break;
+	}
+
+	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 1; /* SCA */
+	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				 &rlm_req, sizeof(rlm_req), true);
+}
+
+static int
+mt7921_mcu_add_sta_cmd(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable, int cmd)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct mt7921_sta *msta;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+
+	msta = sta ? (struct mt7921_sta *)sta->drv_priv : &mvif->sta;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7921_mcu_sta_basic_tlv(skb, vif, sta, enable);
+	if (enable && sta)
+		mt7921_mcu_sta_tlv(dev, skb, sta, vif);
+
+	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
+					     sta_wtbl, &skb);
+	if (enable) {
+		mt7921_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
+		if (sta)
+			mt7921_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+}
+
+int
+mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable)
+{
+	return mt7921_mcu_add_sta_cmd(dev, vif, sta, enable,
+				      MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+#define MT7921_SCAN_CHANNEL_TIME	60
+int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int n_ssids = 0, err, i, duration = MT7921_SCAN_CHANNEL_TIME;
+	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt7921_dev *dev = phy->dev;
+	struct mt7921_mcu_scan_channel *chan;
+	struct mt7921_hw_scan_req *req;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(*req));
+	if (!skb)
+		return -ENOMEM;
+
+	set_bit(MT76_HW_SCANNING, &phy->mt76->state);
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt7921_hw_scan_req *)skb_put(skb, sizeof(*req));
+
+	req->seq_num = mvif->scan_seq_num;
+	req->bss_idx = mvif->idx;
+	req->scan_type = sreq->n_ssids ? 1 : 0;
+	req->probe_req_num = sreq->n_ssids ? 2 : 0;
+	req->version = 1;
+
+	for (i = 0; i < sreq->n_ssids; i++) {
+		if (!sreq->ssids[i].ssid_len)
+			continue;
+
+		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		       sreq->ssids[i].ssid_len);
+		n_ssids++;
+	}
+	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
+	req->ssids_num = n_ssids;
+
+	/* increase channel time for passive scan */
+	if (!sreq->n_ssids)
+		duration *= 2;
+	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
+	req->channel_min_dwell_time = cpu_to_le16(duration);
+	req->channel_dwell_time = cpu_to_le16(duration);
+
+	req->channels_num = min_t(u8, sreq->n_channels, 32);
+	req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
+		if (i >= 32)
+			chan = &req->ext_channels[i - 32];
+		else
+			chan = &req->channels[i];
+
+		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+	req->channel_type = sreq->n_channels ? 4 : 0;
+
+	if (sreq->ie_len > 0) {
+		memcpy(req->ies, sreq->ie, sreq->ie_len);
+		req->ies_len = cpu_to_le16(sreq->ie_len);
+	}
+
+	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func = 1;
+	}
+
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_START_HW_SCAN,
+				    false);
+	if (err < 0)
+		clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+
+	return err;
+}
+
+int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 seq_num;
+		u8 is_ext_channel;
+		u8 rsv[2];
+	} __packed req = {
+		.seq_num = mvif->scan_seq_num,
+	};
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->mt76->state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(phy->mt76->hw, &info);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
+				 sizeof(req), false);
+}
+
+u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx)
+{
+	struct mt7921_mcu_wlan_info wtbl_info = {
+		.wlan_idx = wlan_idx,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_GET_WTBL,
+					&wtbl_info, sizeof(wtbl_info), true,
+					&skb);
+	if (ret)
+		return ret;
+
+	mt7921_mcu_tx_rate_report(dev, skb, wlan_idx);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
new file mode 100644
index 000000000000..399ffc8fa671
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -0,0 +1,1075 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_MCU_H
+#define __MT7921_MCU_H
+
+struct mt7921_mcu_txd {
+	__le32 txd[8];
+
+	__le16 len;
+	__le16 pq_id;
+
+	u8 cid;
+	u8 pkt_type;
+	u8 set_query; /* FW don't care */
+	u8 seq;
+
+	u8 uc_d2b0_rev;
+	u8 ext_cid;
+	u8 s2d_index;
+	u8 ext_cid_ack;
+
+	u32 reserved[5];
+} __packed __aligned(4);
+
+/**
+ * struct mt7921_uni_txd - mcu command descriptor for firmware v3
+ * @txd: hardware descriptor
+ * @len: total length not including txd
+ * @cid: command identifier
+ * @pkt_type: must be 0xa0 (cmd packet by long format)
+ * @frag_n: fragment number
+ * @seq: sequence number
+ * @checksum: 0 mean there is no checksum
+ * @s2d_index: index for command source and destination
+ *  Definition              | value | note
+ *  CMD_S2D_IDX_H2N         | 0x00  | command from HOST to WM
+ *  CMD_S2D_IDX_C2N         | 0x01  | command from WA to WM
+ *  CMD_S2D_IDX_H2C         | 0x02  | command from HOST to WA
+ *  CMD_S2D_IDX_H2N_AND_H2C | 0x03  | command from HOST to WA and WM
+ *
+ * @option: command option
+ *  BIT[0]: UNI_CMD_OPT_BIT_ACK
+ *          set to 1 to request a fw reply
+ *          if UNI_CMD_OPT_BIT_0_ACK is set and UNI_CMD_OPT_BIT_2_SET_QUERY
+ *          is set, mcu firmware will send response event EID = 0x01
+ *          (UNI_EVENT_ID_CMD_RESULT) to the host.
+ *  BIT[1]: UNI_CMD_OPT_BIT_UNI_CMD
+ *          0: original command
+ *          1: unified command
+ *  BIT[2]: UNI_CMD_OPT_BIT_SET_QUERY
+ *          0: QUERY command
+ *          1: SET command
+ */
+struct mt7921_uni_txd {
+	__le32 txd[8];
+
+	/* DW1 */
+	__le16 len;
+	__le16 cid;
+
+	/* DW2 */
+	u8 reserved;
+	u8 pkt_type;
+	u8 frag_n;
+	u8 seq;
+
+	/* DW3 */
+	__le16 checksum;
+	u8 s2d_index;
+	u8 option;
+
+	/* DW4 */
+	u8 reserved2[4];
+} __packed __aligned(4);
+
+/* event table */
+enum {
+	MCU_EVENT_REG_ACCESS = 0x05,
+	MCU_EVENT_SCAN_DONE = 0x0d,
+	MCU_EVENT_BSS_ABSENCE  = 0x11,
+	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
+	MCU_EVENT_CH_PRIVILEGE = 0x18,
+	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
+	MCU_EVENT_DBG_MSG = 0x27,
+};
+
+/* ext event table */
+enum {
+	MCU_EXT_EVENT_RATE_REPORT = 0x87,
+};
+
+struct mt7921_mcu_rxd {
+	__le32 rxd[6];
+
+	__le16 len;
+	__le16 pkt_type_id;
+
+	u8 eid;
+	u8 seq;
+	__le16 __rsv;
+
+	u8 ext_eid;
+	u8 __rsv1[2];
+	u8 s2d_index;
+};
+
+struct mt7921_mcu_eeprom_info {
+	__le32 addr;
+	__le32 valid;
+	u8 data[16];
+} __packed;
+
+#define MT_RA_RATE_NSS			GENMASK(8, 6)
+#define MT_RA_RATE_MCS			GENMASK(3, 0)
+#define MT_RA_RATE_TX_MODE		GENMASK(12, 9)
+#define MT_RA_RATE_DCM_EN		BIT(4)
+#define MT_RA_RATE_BW			GENMASK(14, 13)
+
+#define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
+#define MCU_PKT_ID			0xa0
+
+enum {
+	MCU_Q_QUERY,
+	MCU_Q_SET,
+	MCU_Q_RESERVED,
+	MCU_Q_NA
+};
+
+enum {
+	MCU_S2D_H2N,
+	MCU_S2D_C2N,
+	MCU_S2D_H2C,
+	MCU_S2D_H2CN
+};
+
+#define MCU_FW_PREFIX		BIT(31)
+#define MCU_UNI_PREFIX		BIT(30)
+#define MCU_CE_PREFIX		BIT(29)
+#define MCU_QUERY_PREFIX	BIT(28)
+#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
+				  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
+
+#define MCU_QUERY_MASK		BIT(16)
+
+enum {
+	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
+	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
+	MCU_CMD_NIC_POWER_CTRL = MCU_FW_PREFIX | 0x4,
+	MCU_CMD_PATCH_START_REQ = MCU_FW_PREFIX | 0x05,
+	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
+	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
+	MCU_CMD_EXT_CID = 0xED,
+	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xEE,
+};
+
+enum {
+	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
+	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
+	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
+	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
+	MCU_EXT_CMD_THERMAL_CTRL = 0x2c,
+	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
+	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
+	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
+	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
+	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+};
+
+enum {
+	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
+	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
+	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
+	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
+	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
+};
+
+struct mt7921_mcu_uni_event {
+	u8 cid;
+	u8 pad[3];
+	__le32 status; /* 0: success, others: fail */
+} __packed;
+
+/* offload mcu commands */
+enum {
+	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
+	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
+	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
+	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
+	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
+	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
+	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
+	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
+	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
+	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
+	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
+	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
+};
+
+#define MCU_CMD_ACK		BIT(0)
+#define MCU_CMD_UNI		BIT(1)
+#define MCU_CMD_QUERY		BIT(2)
+
+#define MCU_CMD_UNI_EXT_ACK	(MCU_CMD_ACK | MCU_CMD_UNI | MCU_CMD_QUERY)
+
+enum {
+	UNI_BSS_INFO_BASIC = 0,
+	UNI_BSS_INFO_RLM = 2,
+	UNI_BSS_INFO_HE_BASIC = 5,
+	UNI_BSS_INFO_BCN_CONTENT = 7,
+	UNI_BSS_INFO_QBSS = 15,
+	UNI_BSS_INFO_UAPSD = 19,
+};
+
+enum {
+	UNI_SUSPEND_MODE_SETTING,
+	UNI_SUSPEND_WOW_CTRL,
+	UNI_SUSPEND_WOW_GPIO_PARAM,
+	UNI_SUSPEND_WOW_WAKEUP_PORT,
+	UNI_SUSPEND_WOW_PATTERN,
+};
+
+enum {
+	UNI_OFFLOAD_OFFLOAD_ARP,
+	UNI_OFFLOAD_OFFLOAD_ND,
+	UNI_OFFLOAD_OFFLOAD_GTK_REKEY,
+	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
+};
+
+enum {
+	PATCH_SEM_RELEASE,
+	PATCH_SEM_GET
+};
+
+enum {
+	PATCH_NOT_DL_SEM_FAIL,
+	PATCH_IS_DL,
+	PATCH_NOT_DL_SEM_SUCCESS,
+	PATCH_REL_SEM_SUCCESS
+};
+
+enum {
+	FW_STATE_INITIAL,
+	FW_STATE_FW_DOWNLOAD,
+	FW_STATE_NORMAL_OPERATION,
+	FW_STATE_NORMAL_TRX,
+	FW_STATE_WACPU_RDY        = 7
+};
+
+enum {
+	EE_MODE_EFUSE,
+	EE_MODE_BUFFER,
+};
+
+enum {
+	EE_FORMAT_BIN,
+	EE_FORMAT_WHOLE,
+	EE_FORMAT_MULTIPLE,
+};
+
+enum {
+	MCU_PHY_STATE_TX_RATE,
+	MCU_PHY_STATE_RX_RATE,
+	MCU_PHY_STATE_RSSI,
+	MCU_PHY_STATE_CONTENTION_RX_RATE,
+	MCU_PHY_STATE_OFDMLQ_CNINFO,
+};
+
+#define STA_TYPE_STA			BIT(0)
+#define STA_TYPE_AP			BIT(1)
+#define STA_TYPE_ADHOC			BIT(2)
+#define STA_TYPE_WDS			BIT(4)
+#define STA_TYPE_BC			BIT(5)
+
+#define NETWORK_INFRA			BIT(16)
+#define NETWORK_P2P			BIT(17)
+#define NETWORK_IBSS			BIT(18)
+#define NETWORK_WDS			BIT(21)
+
+#define CONNECTION_INFRA_STA		(STA_TYPE_STA | NETWORK_INFRA)
+#define CONNECTION_INFRA_AP		(STA_TYPE_AP | NETWORK_INFRA)
+#define CONNECTION_P2P_GC		(STA_TYPE_STA | NETWORK_P2P)
+#define CONNECTION_P2P_GO		(STA_TYPE_AP | NETWORK_P2P)
+#define CONNECTION_IBSS_ADHOC		(STA_TYPE_ADHOC | NETWORK_IBSS)
+#define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
+#define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
+
+#define CONN_STATE_DISCONNECT		0
+#define CONN_STATE_CONNECT		1
+#define CONN_STATE_PORT_SECURE		2
+
+enum {
+	DEV_INFO_ACTIVE,
+	DEV_INFO_MAX_NUM
+};
+
+enum {
+	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
+	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
+	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
+	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
+	CMD_CBW_10MHZ,
+	CMD_CBW_5MHZ,
+	CMD_CBW_8080MHZ,
+
+	CMD_HE_MCS_BW80 = 0,
+	CMD_HE_MCS_BW160,
+	CMD_HE_MCS_BW8080,
+	CMD_HE_MCS_BW_NUM
+};
+
+struct tlv {
+	__le16 tag;
+	__le16 len;
+} __packed;
+
+struct bss_info_uni_he {
+	__le16 tag;
+	__le16 len;
+	__le16 he_rts_thres;
+	u8 he_pe_duration;
+	u8 su_disable;
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+	u8 rsv[2];
+} __packed;
+
+enum {
+	WTBL_RESET_AND_SET = 1,
+	WTBL_SET,
+	WTBL_QUERY,
+	WTBL_RESET_ALL
+};
+
+struct wtbl_req_hdr {
+	u8 wlan_idx_lo;
+	u8 operation;
+	__le16 tlv_num;
+	u8 wlan_idx_hi;
+	u8 rsv[3];
+} __packed;
+
+struct wtbl_generic {
+	__le16 tag;
+	__le16 len;
+	u8 peer_addr[ETH_ALEN];
+	u8 muar_idx;
+	u8 skip_tx;
+	u8 cf_ack;
+	u8 qos;
+	u8 mesh;
+	u8 adm;
+	__le16 partial_aid;
+	u8 baf_en;
+	u8 aad_om;
+} __packed;
+
+struct wtbl_rx {
+	__le16 tag;
+	__le16 len;
+	u8 rcid;
+	u8 rca1;
+	u8 rca2;
+	u8 rv;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_ht {
+	__le16 tag;
+	__le16 len;
+	u8 ht;
+	u8 ldpc;
+	u8 af;
+	u8 mm;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_vht {
+	__le16 tag;
+	__le16 len;
+	u8 ldpc;
+	u8 dyn_bw;
+	u8 vht;
+	u8 txop_ps;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_hdr_trans {
+	__le16 tag;
+	__le16 len;
+	u8 to_ds;
+	u8 from_ds;
+	u8 no_rx_trans;
+	u8 _rsv;
+};
+
+enum {
+	MT_BA_TYPE_INVALID,
+	MT_BA_TYPE_ORIGINATOR,
+	MT_BA_TYPE_RECIPIENT
+};
+
+enum {
+	RST_BA_MAC_TID_MATCH,
+	RST_BA_MAC_MATCH,
+	RST_BA_NO_MATCH
+};
+
+struct wtbl_ba {
+	__le16 tag;
+	__le16 len;
+	/* common */
+	u8 tid;
+	u8 ba_type;
+	u8 rsv0[2];
+	/* originator only */
+	__le16 sn;
+	u8 ba_en;
+	u8 ba_winsize_idx;
+	__le16 ba_winsize;
+	/* recipient only */
+	u8 peer_addr[ETH_ALEN];
+	u8 rst_ba_tid;
+	u8 rst_ba_sel;
+	u8 rst_ba_sb;
+	u8 band_idx;
+	u8 rsv1[4];
+} __packed;
+
+struct wtbl_smps {
+	__le16 tag;
+	__le16 len;
+	u8 smps;
+	u8 rsv[3];
+} __packed;
+
+enum {
+	WTBL_GENERIC,
+	WTBL_RX,
+	WTBL_HT,
+	WTBL_VHT,
+	WTBL_PEER_PS,		/* not used */
+	WTBL_TX_PS,
+	WTBL_HDR_TRANS,
+	WTBL_SEC_KEY,
+	WTBL_BA,
+	WTBL_RDG,		/* obsoleted */
+	WTBL_PROTECT,		/* not used */
+	WTBL_CLEAR,		/* not used */
+	WTBL_BF,
+	WTBL_SMPS,
+	WTBL_RAW_DATA,		/* debug only */
+	WTBL_PN,
+	WTBL_SPE,
+	WTBL_MAX_NUM
+};
+
+struct sta_ntlv_hdr {
+	u8 rsv[2];
+	__le16 tlv_num;
+} __packed;
+
+struct sta_req_hdr {
+	u8 bss_idx;
+	u8 wlan_idx_lo;
+	__le16 tlv_num;
+	u8 is_tlv_append;
+	u8 muar_idx;
+	u8 wlan_idx_hi;
+	u8 rsv;
+} __packed;
+
+struct sta_rec_basic {
+	__le16 tag;
+	__le16 len;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 qos;
+	__le16 aid;
+	u8 peer_addr[ETH_ALEN];
+	__le16 extra_info;
+} __packed;
+
+struct sta_rec_ht {
+	__le16 tag;
+	__le16 len;
+	__le16 ht_cap;
+	u16 rsv;
+} __packed;
+
+struct sta_rec_vht {
+	__le16 tag;
+	__le16 len;
+	__le32 vht_cap;
+	__le16 vht_rx_mcs_map;
+	__le16 vht_tx_mcs_map;
+	u8 rts_bw_sig;
+	u8 rsv[3];
+} __packed;
+
+struct sta_rec_uapsd {
+	__le16 tag;
+	__le16 len;
+	u8 dac_map;
+	u8 tac_map;
+	u8 max_sp;
+	u8 rsv0;
+	__le16 listen_interval;
+	u8 rsv1[2];
+} __packed;
+
+struct sta_rec_he {
+	__le16 tag;
+	__le16 len;
+
+	__le32 he_cap;
+
+	u8 t_frame_dur;
+	u8 max_ampdu_exp;
+	u8 bw_set;
+	u8 device_class;
+	u8 dcm_tx_mode;
+	u8 dcm_tx_max_nss;
+	u8 dcm_rx_mode;
+	u8 dcm_rx_max_nss;
+	u8 dcm_max_ru;
+	u8 punc_pream_rx;
+	u8 pkt_ext;
+	u8 rsv1;
+
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+
+	u8 rsv2[2];
+} __packed;
+
+struct sta_rec_ba {
+	__le16 tag;
+	__le16 len;
+	u8 tid;
+	u8 ba_type;
+	u8 amsdu;
+	u8 ba_en;
+	__le16 ssn;
+	__le16 winsize;
+} __packed;
+
+struct sta_rec_amsdu {
+	__le16 tag;
+	__le16 len;
+	u8 max_amsdu_num;
+	u8 max_mpdu_size;
+	u8 amsdu_en;
+	u8 rsv;
+} __packed;
+
+struct sec_key {
+	u8 cipher_id;
+	u8 cipher_len;
+	u8 key_id;
+	u8 key_len;
+	u8 key[32];
+} __packed;
+
+struct sta_rec_sec {
+	__le16 tag;
+	__le16 len;
+	u8 add;
+	u8 n_cipher;
+	u8 rsv[2];
+
+	struct sec_key key[2];
+} __packed;
+
+struct sta_rec_state {
+	__le16 tag;
+	__le16 len;
+	__le32 flags;
+	u8 state;
+	u8 vht_opmode;
+	u8 action;
+	u8 rsv[1];
+} __packed;
+
+#define HE_MAC_CAP_BYTE_NUM 6
+#define HE_PHY_CAP_BYTE_NUM 11
+#define HT_MCS_MASK_NUM 10
+
+struct ht_vht_ba_size {
+	u8 tx_ba;
+	u8 rx_ba;
+	u8 rsv[2];
+} __packed;
+
+struct he_ba_size {
+	__le16 tx_ba;
+	__le16 rx_ba;
+} __packed;
+
+union BA_SIZE {
+	struct ht_vht_ba_size ht_vht;
+	struct he_ba_size he;
+};
+
+struct sta_rec_phy {
+	__le16 tag;
+	__le16 len;
+	__le16 legacy;
+	__le16 he_6g_cap;
+	__le32 tx_max_amsdu_len;
+	__le16 basic_rate;
+	u8 phy_type;
+	u8 ampdu;
+	u8 tx_ampdu;
+	u8 rx_ampdu;
+	u8 tx_amsdu_in_ampdu;
+	u8 rx_amsdu_in_ampdu;
+	u8 rts_policy;
+	u8 rcpi;
+	u8 uapsd_ac;
+	u8 uapsd_sp;
+	u8 he_mac_cap[HE_MAC_CAP_BYTE_NUM];
+	u8 he_phy_cap[HE_PHY_CAP_BYTE_NUM];
+	u8 rx_mcs_bitmask[HT_MCS_MASK_NUM];
+	u8 rsv[1];
+	union BA_SIZE ba_size;
+} __packed;
+
+enum {
+	STA_REC_BASIC,
+	STA_REC_RA,
+	STA_REC_RA_CMM_INFO,
+	STA_REC_RA_UPDATE,
+	STA_REC_BF,
+	STA_REC_AMSDU,
+	STA_REC_BA,
+	STA_REC_STATE,
+	STA_REC_TX_PROC,	/* for hdr trans and CSO in CR4 */
+	STA_REC_HT,
+	STA_REC_VHT,
+	STA_REC_APPS,
+	STA_REC_KEY,
+	STA_REC_WTBL,
+	STA_REC_HE,
+	STA_REC_HW_AMSDU,
+	STA_REC_WTBL_AADOM,
+	STA_REC_KEY_V2,
+	STA_REC_MURU,
+	STA_REC_MUEDCA,
+	STA_REC_BFEE,
+	STA_REC_PHY = 0x15,
+	STA_REC_MAX_NUM
+};
+
+enum mt7921_cipher_type {
+	MT_CIPHER_NONE,
+	MT_CIPHER_WEP40,
+	MT_CIPHER_WEP104,
+	MT_CIPHER_WEP128,
+	MT_CIPHER_TKIP,
+	MT_CIPHER_AES_CCMP,
+	MT_CIPHER_CCMP_256,
+	MT_CIPHER_GCMP,
+	MT_CIPHER_GCMP_256,
+	MT_CIPHER_WAPI,
+	MT_CIPHER_BIP_CMAC_128,
+};
+
+enum {
+	CH_SWITCH_NORMAL = 0,
+	CH_SWITCH_SCAN = 3,
+	CH_SWITCH_MCC = 4,
+	CH_SWITCH_DFS = 5,
+	CH_SWITCH_BACKGROUND_SCAN_START = 6,
+	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
+	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
+	CH_SWITCH_SCAN_BYPASS_DPD = 9
+};
+
+enum {
+	THERMAL_SENSOR_TEMP_QUERY,
+	THERMAL_SENSOR_MANUAL_CTRL,
+	THERMAL_SENSOR_INFO_QUERY,
+	THERMAL_SENSOR_TASK_CTRL,
+};
+
+enum {
+	MT_EBF = BIT(0),	/* explicit beamforming */
+	MT_IBF = BIT(1)		/* implicit beamforming */
+};
+
+#define MT7921_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
+					 sizeof(struct wtbl_generic) +	\
+					 sizeof(struct wtbl_rx) +	\
+					 sizeof(struct wtbl_ht) +	\
+					 sizeof(struct wtbl_vht) +	\
+					 sizeof(struct wtbl_hdr_trans) +\
+					 sizeof(struct wtbl_ba) +	\
+					 sizeof(struct wtbl_smps))
+
+#define MT7921_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
+					 sizeof(struct sta_rec_basic) +	\
+					 sizeof(struct sta_rec_ht) +	\
+					 sizeof(struct sta_rec_he) +	\
+					 sizeof(struct sta_rec_ba) +	\
+					 sizeof(struct sta_rec_vht) +	\
+					 sizeof(struct sta_rec_uapsd) + \
+					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct tlv) +		\
+					 MT7921_WTBL_UPDATE_MAX_SIZE)
+
+#define MT7921_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
+					 sizeof(struct wtbl_ba))
+
+#define PHY_MODE_A			BIT(0)
+#define PHY_MODE_B			BIT(1)
+#define PHY_MODE_G			BIT(2)
+#define PHY_MODE_GN			BIT(3)
+#define PHY_MODE_AN			BIT(4)
+#define PHY_MODE_AC			BIT(5)
+#define PHY_MODE_AX_24G			BIT(6)
+#define PHY_MODE_AX_5G			BIT(7)
+#define PHY_MODE_AX_6G			BIT(8)
+
+#define MODE_CCK			BIT(0)
+#define MODE_OFDM			BIT(1)
+#define MODE_HT				BIT(2)
+#define MODE_VHT			BIT(3)
+#define MODE_HE				BIT(4)
+
+#define STA_CAP_WMM			BIT(0)
+#define STA_CAP_SGI_20			BIT(4)
+#define STA_CAP_SGI_40			BIT(5)
+#define STA_CAP_TX_STBC			BIT(6)
+#define STA_CAP_RX_STBC			BIT(7)
+#define STA_CAP_VHT_SGI_80		BIT(16)
+#define STA_CAP_VHT_SGI_160		BIT(17)
+#define STA_CAP_VHT_TX_STBC		BIT(18)
+#define STA_CAP_VHT_RX_STBC		BIT(19)
+#define STA_CAP_VHT_LDPC		BIT(23)
+#define STA_CAP_LDPC			BIT(24)
+#define STA_CAP_HT			BIT(26)
+#define STA_CAP_VHT			BIT(27)
+#define STA_CAP_HE			BIT(28)
+
+/* HE MAC */
+#define STA_REC_HE_CAP_HTC			BIT(0)
+#define STA_REC_HE_CAP_BQR			BIT(1)
+#define STA_REC_HE_CAP_BSR			BIT(2)
+#define STA_REC_HE_CAP_OM			BIT(3)
+#define STA_REC_HE_CAP_AMSDU_IN_AMPDU		BIT(4)
+/* HE PHY */
+#define STA_REC_HE_CAP_DUAL_BAND		BIT(5)
+#define STA_REC_HE_CAP_LDPC			BIT(6)
+#define STA_REC_HE_CAP_TRIG_CQI_FK		BIT(7)
+#define STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE	BIT(8)
+/* STBC */
+#define STA_REC_HE_CAP_LE_EQ_80M_TX_STBC	BIT(9)
+#define STA_REC_HE_CAP_LE_EQ_80M_RX_STBC	BIT(10)
+#define STA_REC_HE_CAP_GT_80M_TX_STBC		BIT(11)
+#define STA_REC_HE_CAP_GT_80M_RX_STBC		BIT(12)
+/* GI */
+#define STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI	BIT(13)
+#define STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI	BIT(14)
+#define STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI	BIT(15)
+#define STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI	BIT(16)
+#define STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI	BIT(17)
+/* 242 TONE */
+#define STA_REC_HE_CAP_BW20_RU242_SUPPORT	BIT(18)
+#define STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242	BIT(19)
+#define STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242	BIT(20)
+
+struct mt7921_mcu_reg_event {
+	__le32 reg;
+	__le32 val;
+} __packed;
+
+struct mt7921_bss_basic_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 active;
+	u8 omac_idx;
+	u8 hw_bss_idx;
+	u8 band_idx;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 wmm_idx;
+	u8 bssid[ETH_ALEN];
+	__le16 bmc_tx_wlan_idx;
+	__le16 bcn_interval;
+	u8 dtim_period;
+	u8 phymode; /* bit(0): A
+		     * bit(1): B
+		     * bit(2): G
+		     * bit(3): GN
+		     * bit(4): AN
+		     * bit(5): AC
+		     */
+	__le16 sta_idx;
+	u8 nonht_basic_phy;
+	u8 pad[3];
+} __packed;
+
+struct mt7921_bss_qos_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 qos;
+	u8 pad[3];
+} __packed;
+
+struct mt7921_mcu_scan_ssid {
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+} __packed;
+
+struct mt7921_mcu_scan_channel {
+	u8 band; /* 1: 2.4GHz
+		  * 2: 5.0GHz
+		  * Others: Reserved
+		  */
+	u8 channel_num;
+} __packed;
+
+struct mt7921_mcu_scan_match {
+	__le32 rssi_th;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	u8 rsv[3];
+} __packed;
+
+struct mt7921_hw_scan_req {
+	u8 seq_num;
+	u8 bss_idx;
+	u8 scan_type; /* 0: PASSIVE SCAN
+		       * 1: ACTIVE SCAN
+		       */
+	u8 ssid_type; /* BIT(0) wildcard SSID
+		       * BIT(1) P2P wildcard SSID
+		       * BIT(2) specified SSID + wildcard SSID
+		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
+		       */
+	u8 ssids_num;
+	u8 probe_req_num; /* Number of probe request for each SSID */
+	u8 scan_func; /* BIT(0) Enable random MAC scan
+		       * BIT(1) Disable DBDC scan type 1~3.
+		       * BIT(2) Use DBDC scan type 3 (dedicated one RF to scan).
+		       */
+	u8 version; /* 0: Not support fields after ies.
+		     * 1: Support fields after ies.
+		     */
+	struct mt7921_mcu_scan_ssid ssids[4];
+	__le16 probe_delay_time;
+	__le16 channel_dwell_time; /* channel Dwell interval */
+	__le16 timeout_value;
+	u8 channel_type; /* 0: Full channels
+			  * 1: Only 2.4GHz channels
+			  * 2: Only 5GHz channels
+			  * 3: P2P social channel only (channel #1, #6 and #11)
+			  * 4: Specified channels
+			  * Others: Reserved
+			  */
+	u8 channels_num; /* valid when channel_type is 4 */
+	/* valid when channels_num is set */
+	struct mt7921_mcu_scan_channel channels[32];
+	__le16 ies_len;
+	u8 ies[MT7921_SCAN_IE_LEN];
+	/* following fields are valid if version > 0 */
+	u8 ext_channels_num;
+	u8 ext_ssids_num;
+	__le16 channel_min_dwell_time;
+	struct mt7921_mcu_scan_channel ext_channels[32];
+	struct mt7921_mcu_scan_ssid ext_ssids[6];
+	u8 bssid[ETH_ALEN];
+	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
+	u8 pad[63];
+	u8 ssid_type_ext;
+} __packed;
+
+#define SCAN_DONE_EVENT_MAX_CHANNEL_NUM	64
+struct mt7921_hw_scan_done {
+	u8 seq_num;
+	u8 sparse_channel_num;
+	struct mt7921_mcu_scan_channel sparse_channel;
+	u8 complete_channel_num;
+	u8 current_state;
+	u8 version;
+	u8 pad;
+	__le32 beacon_scan_num;
+	u8 pno_enabled;
+	u8 pad2[3];
+	u8 sparse_channel_valid_num;
+	u8 pad3[3];
+	u8 channel_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* idle format for channel_idle_time
+	 * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
+	 * 1: first bytes: idle time(8ms) 2nd byte: dwell time(8ms)
+	 * 2: dwell time (16us)
+	 */
+	__le16 channel_idle_time[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* beacon and probe response count */
+	u8 beacon_probe_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	u8 mdrdy_count[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	__le32 beacon_2g_num;
+	__le32 beacon_5g_num;
+} __packed;
+
+struct mt7921_mcu_bss_event {
+	u8 bss_idx;
+	u8 is_absent;
+	u8 free_quota;
+	u8 pad;
+} __packed;
+
+enum {
+	PHY_TYPE_HR_DSSS_INDEX = 0,
+	PHY_TYPE_ERP_INDEX,
+	PHY_TYPE_ERP_P2P_INDEX,
+	PHY_TYPE_OFDM_INDEX,
+	PHY_TYPE_HT_INDEX,
+	PHY_TYPE_VHT_INDEX,
+	PHY_TYPE_HE_INDEX,
+	PHY_TYPE_INDEX_NUM
+};
+
+#define PHY_TYPE_BIT_HR_DSSS    BIT(PHY_TYPE_HR_DSSS_INDEX)
+#define PHY_TYPE_BIT_ERP        BIT(PHY_TYPE_ERP_INDEX)
+#define PHY_TYPE_BIT_OFDM       BIT(PHY_TYPE_OFDM_INDEX)
+#define PHY_TYPE_BIT_HT         BIT(PHY_TYPE_HT_INDEX)
+#define PHY_TYPE_BIT_VHT        BIT(PHY_TYPE_VHT_INDEX)
+#define PHY_TYPE_BIT_HE         BIT(PHY_TYPE_HE_INDEX)
+
+#define MT_WTBL_RATE_TX_MODE	GENMASK(9, 6)
+#define MT_WTBL_RATE_MCS	GENMASK(5, 0)
+#define MT_WTBL_RATE_NSS	GENMASK(12, 10)
+#define MT_WTBL_RATE_HE_GI	GENMASK(7, 4)
+#define MT_WTBL_RATE_GI		GENMASK(3, 0)
+
+struct mt7921_mcu_tx_config {
+	u8 peer_addr[ETH_ALEN];
+	u8 sw;
+	u8 dis_rx_hdr_tran;
+
+	u8 aad_om;
+	u8 pfmu_idx;
+	__le16 partial_aid;
+
+	u8 ibf;
+	u8 ebf;
+	u8 is_ht;
+	u8 is_vht;
+
+	u8 mesh;
+	u8 baf_en;
+	u8 cf_ack;
+	u8 rdg_ba;
+
+	u8 rdg;
+	u8 pm;
+	u8 rts;
+	u8 smps;
+
+	u8 txop_ps;
+	u8 not_update_ipsm;
+	u8 skip_tx;
+	u8 ldpc;
+
+	u8 qos;
+	u8 from_ds;
+	u8 to_ds;
+	u8 dyn_bw;
+
+	u8 amdsu_cross_lg;
+	u8 amdsu_lg;
+	u8 check_per;
+	u8 gid_63;
+	u8 he;
+
+	u8 vht_ibf;
+	u8 vht_ebf;
+	u8 vht_ldpc;
+	u8 he_ldpc;
+} __packed;
+
+struct mt7921_mcu_sec_config {
+	u8 wpi_flag;
+	u8 rv;
+	u8 ikv;
+	u8 rkv;
+
+	u8 rcid;
+	u8 rca1;
+	u8 rca2;
+	u8 even_pn;
+
+	u8 key_id;
+	u8 muar_idx;
+	u8 cipher_suit;
+	u8 rsv[1];
+} __packed;
+
+struct mt7921_mcu_key_config {
+	u8 key[32];
+} __packed;
+
+struct mt7921_mcu_rate_info {
+	u8 mpdu_fail;
+	u8 mpdu_tx;
+	u8 rate_idx;
+	u8 rsv[1];
+	__le16 rate[8];
+} __packed;
+
+struct mt7921_mcu_ba_config {
+	u8 ba_en;
+	u8 rsv[3];
+	__le32 ba_winsize;
+} __packed;
+
+struct mt7921_mcu_ant_id_config {
+	u8 ant_id[4];
+} __packed;
+
+struct mt7921_mcu_peer_cap {
+	struct mt7921_mcu_ant_id_config ant_id_config;
+
+	u8 power_offset;
+	u8 bw_selector;
+	u8 change_bw_rate_n;
+	u8 bw;
+	u8 spe_idx;
+
+	u8 g2;
+	u8 g4;
+	u8 g8;
+	u8 g16;
+
+	u8 mmss;
+	u8 ampdu_factor;
+	u8 rsv[1];
+} __packed;
+
+struct mt7921_mcu_rx_cnt {
+	u8 rx_rcpi[4];
+	u8 rx_cc[4];
+	u8 rx_cc_sel;
+	u8 ce_rmsd;
+	u8 rsv[2];
+} __packed;
+
+struct mt7921_mcu_tx_cnt {
+	__le16 rate1_cnt;
+	__le16 rate1_fail_cnt;
+	__le16 rate2_cnt;
+	__le16 rate3_cnt;
+	__le16 cur_bw_tx_cnt;
+	__le16 cur_bw_tx_fail_cnt;
+	__le16 other_bw_tx_cnt;
+	__le16 other_bw_tx_fail_cnt;
+} __packed;
+
+struct mt7921_mcu_wlan_info_event {
+	struct mt7921_mcu_tx_config tx_config;
+	struct mt7921_mcu_sec_config sec_config;
+	struct mt7921_mcu_key_config key_config;
+	struct mt7921_mcu_rate_info rate_info;
+	struct mt7921_mcu_ba_config ba_config;
+	struct mt7921_mcu_peer_cap peer_cap;
+	struct mt7921_mcu_rx_cnt rx_cnt;
+	struct mt7921_mcu_tx_cnt tx_cnt;
+} __packed;
+
+struct mt7921_mcu_wlan_info {
+	__le32 wlan_idx;
+	struct mt7921_mcu_wlan_info_event event;
+} __packed;
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
new file mode 100644
index 000000000000..78c715166ef2
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -0,0 +1,352 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_H
+#define __MT7921_H
+
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include "../mt76.h"
+#include "regs.h"
+
+#define MT7921_MAX_INTERFACES		4
+#define MT7921_MAX_WMM_SETS		4
+#define MT7921_WTBL_SIZE		20
+#define MT7921_WTBL_RESERVED		(MT7921_WTBL_SIZE - 1)
+#define MT7921_WTBL_STA			(MT7921_WTBL_RESERVED - \
+					 MT7921_MAX_INTERFACES)
+
+#define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
+#define MT7921_WATCHDOG_TIME		(HZ / 10)
+#define MT7921_RESET_TIMEOUT		(30 * HZ)
+
+#define MT7921_TX_RING_SIZE		2048
+#define MT7921_TX_MCU_RING_SIZE		256
+#define MT7921_TX_FWDL_RING_SIZE	128
+
+#define MT7921_RX_RING_SIZE		1536
+#define MT7921_RX_MCU_RING_SIZE		512
+
+#define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
+#define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
+
+#define MT7921_EEPROM_SIZE		3584
+#define MT7921_TOKEN_SIZE		8192
+#define MT7921_TOKEN_FREE_THR		64
+
+#define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+#define MT7921_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
+#define MT7921_2G_RATE_DEFAULT		0x0	/* CCK 1M */
+
+#define MT7921_SKU_RATE_NUM		161
+#define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
+#define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
+
+#define MT7921_SCAN_IE_LEN		600
+
+struct mt7921_vif;
+struct mt7921_sta;
+
+enum mt7921_txq_id {
+	MT7921_TXQ_BAND0,
+	MT7921_TXQ_BAND1,
+	MT7921_TXQ_FWDL = 16,
+	MT7921_TXQ_MCU_WM,
+};
+
+enum mt7921_rxq_id {
+	MT7921_RXQ_BAND0 = 0,
+	MT7921_RXQ_BAND1,
+	MT7921_RXQ_MCU_WM = 0,
+};
+
+struct mt7921_sta_stats {
+	struct rate_info prob_rate;
+	struct rate_info tx_rate;
+
+	unsigned long per;
+	unsigned long changed;
+	unsigned long jiffies;
+};
+
+struct mt7921_sta {
+	struct mt76_wcid wcid; /* must be first */
+
+	struct mt7921_vif *vif;
+
+	struct list_head stats_list;
+	struct list_head poll_list;
+	u32 airtime_ac[8];
+
+	struct mt7921_sta_stats stats;
+
+	unsigned long ampdu_state;
+};
+
+struct mt7921_vif {
+	u16 idx;
+	u8 omac_idx;
+	u8 band_idx;
+	u8 wmm_idx;
+	u8 scan_seq_num;
+
+	struct mt7921_sta sta;
+	struct mt7921_phy *phy;
+
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+};
+
+struct mib_stats {
+	u16 ack_fail_cnt;
+	u16 fcs_err_cnt;
+	u16 rts_cnt;
+	u16 rts_retries_cnt;
+	u16 ba_miss_cnt;
+};
+
+struct mt7921_phy {
+	struct mt76_phy *mt76;
+	struct mt7921_dev *dev;
+
+	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
+
+	struct ieee80211_vif *monitor_vif;
+
+	u32 rxfilter;
+	u64 omac_mask;
+
+	u16 noise;
+	u16 chainmask;
+
+	s16 coverage_class;
+	u8 slottime;
+
+	__le32 rx_ampdu_ts;
+	u32 ampdu_ref;
+
+	struct mib_stats mib;
+	struct list_head stats_list;
+
+	struct delayed_work mac_work;
+	u8 mac_work_count;
+	u8 sta_work_count;
+
+	struct sk_buff_head scan_event_list;
+	struct delayed_work scan_work;
+};
+
+struct mt7921_dev {
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
+	const struct mt76_bus_ops *bus_ops;
+	struct mt7921_phy phy;
+	struct tasklet_struct irq_tasklet;
+
+	u16 chainmask;
+
+	struct work_struct init_work;
+	struct work_struct reset_work;
+	wait_queue_head_t reset_wait;
+	u32 reset_state;
+
+	struct list_head sta_poll_list;
+	spinlock_t sta_poll_lock;
+
+	spinlock_t token_lock;
+	int token_count;
+	struct idr token;
+
+	u8 fw_debug;
+};
+
+enum {
+	HW_BSSID_0 = 0x0,
+	HW_BSSID_1,
+	HW_BSSID_2,
+	HW_BSSID_3,
+	HW_BSSID_MAX = HW_BSSID_3,
+	EXT_BSSID_START = 0x10,
+	EXT_BSSID_1,
+	EXT_BSSID_15 = 0x1f,
+	EXT_BSSID_MAX = EXT_BSSID_15,
+	REPEATER_BSSID_START = 0x20,
+	REPEATER_BSSID_MAX = 0x3f,
+};
+
+enum {
+	MT_LMAC_AC00,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+};
+
+static inline struct mt7921_phy *
+mt7921_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
+static inline struct mt7921_dev *
+mt7921_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt7921_dev, mt76);
+}
+
+static inline u8 mt7921_lmac_mapping(struct mt7921_dev *dev, u8 ac)
+{
+	/* LMAC uses the reverse order of mac80211 AC indexes */
+	return 3 - ac;
+}
+
+extern const struct ieee80211_ops mt7921_ops;
+extern struct pci_driver mt7921_pci_driver;
+
+u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
+
+int mt7921_register_device(struct mt7921_dev *dev);
+void mt7921_unregister_device(struct mt7921_dev *dev);
+int mt7921_eeprom_init(struct mt7921_dev *dev);
+void mt7921_eeprom_parse_band_config(struct mt7921_phy *phy);
+int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
+				   struct ieee80211_channel *chan,
+				   u8 chain_idx);
+void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
+int mt7921_dma_init(struct mt7921_dev *dev);
+void mt7921_dma_prefetch(struct mt7921_dev *dev);
+void mt7921_dma_cleanup(struct mt7921_dev *dev);
+int mt7921_mcu_init(struct mt7921_dev *dev);
+int mt7921_mcu_add_bss_info(struct mt7921_phy *phy,
+			    struct ieee80211_vif *vif, int enable);
+int mt7921_mcu_sta_update_hdr_trans(struct mt7921_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta);
+int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd);
+int mt7921_set_channel(struct mt7921_phy *phy);
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
+int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset);
+int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band, bool enable,
+		       bool hdr_trans);
+int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val);
+int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate);
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mcu_exit(struct mt7921_dev *dev);
+
+static inline bool is_mt7921(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7961;
+}
+
+static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
+{
+	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
+
+	tasklet_schedule(&dev->irq_tasklet);
+}
+
+static inline u32
+mt7921_reg_map_l1(struct mt7921_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	/* use read to push write */
+	mt76_rr(dev, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static inline u32
+mt7921_l1_rr(struct mt7921_dev *dev, u32 addr)
+{
+	return mt76_rr(dev, mt7921_reg_map_l1(dev, addr));
+}
+
+static inline void
+mt7921_l1_wr(struct mt7921_dev *dev, u32 addr, u32 val)
+{
+	mt76_wr(dev, mt7921_reg_map_l1(dev, addr), val);
+}
+
+static inline u32
+mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 mask, u32 val)
+{
+	val |= mt7921_l1_rr(dev, addr) & ~mask;
+	mt7921_l1_wr(dev, addr, val);
+
+	return val;
+}
+
+#define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
+#define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
+
+bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
+void mt7921_mac_reset_counters(struct mt7921_phy *phy);
+void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, bool beacon);
+void mt7921_mac_set_timing(struct mt7921_phy *phy);
+int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mac_fill_rx_vector(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb);
+int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7921_mac_work(struct work_struct *work);
+void mt7921_mac_reset_work(struct work_struct *work);
+int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info);
+void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc);
+void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb);
+void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
+void mt7921_stats_work(struct work_struct *work);
+void mt7921_txp_skb_unmap(struct mt76_dev *dev,
+			  struct mt76_txwi_cache *txwi);
+void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
+void mt7921_update_channel(struct mt76_dev *mdev);
+int mt7921_init_debugfs(struct mt7921_dev *dev);
+int
+mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
+		       struct ieee80211_vif *vif, bool enable);
+int
+mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       bool enable);
+
+int
+mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable);
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+void mt7921_scan_work(struct work_struct *work);
+int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req);
+int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif);
+u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
new file mode 100644
index 000000000000..08e248c586bd
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -0,0 +1,413 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_REGS_H
+#define __MT7921_REGS_H
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
+#define MT_PLE_BASE			0x8000
+#define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
+
+#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
+#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
+#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x1b8)
+#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x1bc)
+
+#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x300 + 0x10 * (ac) + \
+					       ((n) << 2))
+#define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
+
+#define MT_MDP_BASE			0xf000
+#define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
+
+#define MT_MDP_DCR0			MT_MDP(0x000)
+#define MT_MDP_DCR0_DAMSDU_EN		BIT(15)
+
+#define MT_MDP_DCR1			MT_MDP(0x004)
+#define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
+
+#define MT_MDP_BNRCFR0(_band)		MT_MDP(0x070 + ((_band) << 8))
+#define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
+#define MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR	GENMASK(7, 6)
+#define MT_MDP_RCFR0_MCU_RX_CTL_BAR	GENMASK(9, 8)
+
+#define MT_MDP_BNRCFR1(_band)		MT_MDP(0x074 + ((_band) << 8))
+#define MT_MDP_RCFR1_MCU_RX_BYPASS	GENMASK(23, 22)
+#define MT_MDP_RCFR1_RX_DROPPED_UCAST	GENMASK(28, 27)
+#define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
+#define MT_MDP_TO_HIF			0
+#define MT_MDP_TO_WM			1
+
+/* TMAC: band 0(0x21000), band 1(0xa1000) */
+#define MT_WF_TMAC_BASE(_band)		((_band) ? 0xa1000 : 0x21000)
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
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
+#define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
+
+#define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
+#define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
+#define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
+
+/* LPON: band 0(0x24200), band 1(0xa4200) */
+#define MT_WF_LPON_BASE(_band)		((_band) ? 0xa4200 : 0x24200)
+#define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
+
+#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
+#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, 0x084)
+
+#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
+#define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
+#define MT_LPON_TCR_SW_WRITE		BIT(0)
+
+/* MIB: band 0(0x24800), band 1(0xa4800) */
+#define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
+#define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
+
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
+#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
+#define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, 0x048)
+#define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
+#define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
+
+#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x098)
+#define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x09c)
+#define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
+#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
+#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
+
+#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, 0x100 + ((n) << 4))
+#define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
+#define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
+
+#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, 0x104 + ((n) << 4))
+#define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
+#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
+
+#define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
+#define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
+
+#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x0a8 + ((n) << 2))
+#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x164 + ((n) << 2))
+#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
+#define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
+
+#define MT_WTBLON_TOP_BASE		0x34000
+#define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x0)
+#define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
+
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x030)
+#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
+#define MT_WTBL_UPDATE_BUSY		BIT(31)
+
+#define MT_WTBL_BASE			0x38000
+#define MT_WTBL_LMAC_ID			GENMASK(14, 8)
+#define MT_WTBL_LMAC_DW			GENMASK(7, 2)
+#define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
+					FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+
+/* AGG: band 0(0x20800), band 1(0xa0800) */
+#define MT_WF_AGG_BASE(_band)		((_band) ? 0xa0800 : 0x20800)
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
+#define MT_WF_ARB_BASE(_band)		((_band) ? 0xa0c00 : 0x20c00)
+#define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
+
+#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
+#define MT_ARB_SCR_TX_DISABLE		BIT(8)
+#define MT_ARB_SCR_RX_DISABLE		BIT(9)
+
+#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
+
+/* RMAC: band 0(0x21400), band 1(0xa1400) */
+#define MT_WF_RMAC_BASE(_band)		((_band) ? 0xa1400 : 0x21400)
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
+#define MT_MCU_CMD                     MT_WFDMA0(0x1f0)
+#define MT_MCU_CMD_STOP_DMA_FW_RELOAD  BIT(1)
+#define MT_MCU_CMD_STOP_DMA            BIT(2)
+#define MT_MCU_CMD_RESET_DONE          BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE       BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE	       BIT(5)
+#define MT_MCU_CMD_ERROR_MASK          GENMASK(5, 1)
+
+#define MT_WFDMA0_HOST_INT_STA		MT_WFDMA0(0x200)
+#define HOST_RX_DONE_INT_STS0		BIT(0)	/* Rx mcu */
+#define HOST_RX_DONE_INT_STS2		BIT(2)	/* Rx data */
+#define HOST_RX_DONE_INT_STS4		BIT(22)	/* Rx mcu after fw downloaded */
+#define HOST_TX_DONE_INT_STS16		BIT(26)
+#define HOST_TX_DONE_INT_STS17		BIT(27) /* MCU tx done*/
+
+#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
+#define HOST_RX_DONE_INT_ENA0		BIT(0)
+#define HOST_RX_DONE_INT_ENA1		BIT(1)
+#define HOST_RX_DONE_INT_ENA2		BIT(2)
+#define HOST_RX_DONE_INT_ENA3		BIT(3)
+#define HOST_TX_DONE_INT_ENA0		BIT(4)
+#define HOST_TX_DONE_INT_ENA1		BIT(5)
+#define HOST_TX_DONE_INT_ENA2		BIT(6)
+#define HOST_TX_DONE_INT_ENA3		BIT(7)
+#define HOST_TX_DONE_INT_ENA4		BIT(8)
+#define HOST_TX_DONE_INT_ENA5		BIT(9)
+#define HOST_TX_DONE_INT_ENA6		BIT(10)
+#define HOST_TX_DONE_INT_ENA7		BIT(11)
+#define HOST_TX_DONE_INT_ENA8		BIT(12)
+#define HOST_TX_DONE_INT_ENA9		BIT(13)
+#define HOST_TX_DONE_INT_ENA10		BIT(14)
+#define HOST_TX_DONE_INT_ENA11		BIT(15)
+#define HOST_TX_DONE_INT_ENA12		BIT(16)
+#define HOST_TX_DONE_INT_ENA13		BIT(17)
+#define HOST_TX_DONE_INT_ENA14		BIT(18)
+#define HOST_RX_COHERENT_EN		BIT(20)
+#define HOST_TX_COHERENT_EN		BIT(21)
+#define HOST_RX_DONE_INT_ENA4		BIT(22)
+#define HOST_RX_DONE_INT_ENA5		BIT(23)
+#define HOST_TX_DONE_INT_ENA16		BIT(26)
+#define HOST_TX_DONE_INT_ENA17		BIT(27)
+#define MCU2HOST_SW_INT_ENA		BIT(29)
+#define HOST_TX_DONE_INT_ENA18		BIT(30)
+
+/* WFDMA interrupt */
+#define MT_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
+#define MT_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA0
+#define MT_INT_RX_DONE_WM2		HOST_RX_DONE_INT_ENA4
+#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_DATA | \
+					 MT_INT_RX_DONE_WM | \
+					 MT_INT_RX_DONE_WM2)
+#define MT_INT_TX_DONE_MCU_WM		HOST_TX_DONE_INT_ENA17
+#define MT_INT_TX_DONE_FWDL		HOST_TX_DONE_INT_ENA16
+#define MT_INT_TX_DONE_BAND0		HOST_TX_DONE_INT_ENA0
+#define MT_INT_MCU_CMD			MCU2HOST_SW_INT_ENA
+
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_FWDL)
+#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_BAND0 |	\
+					GENMASK(18, 4))
+
+#define MT_WFDMA0_GLO_CFG		MT_WFDMA0(0x208)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_EN	BIT(0)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_BUSY	BIT(1)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
+#define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
+#define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
+#define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
+#define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
+
+#define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
+#define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
+#define MT_WFDMA0_CSR_TX_DMASHDL_ENABLE	BIT(6)
+#define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
+
+#define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x520)
+
+#define MT_WFDMA0_TX_RING0_EXT_CTRL	MT_WFDMA0(0x600)
+#define MT_WFDMA0_TX_RING1_EXT_CTRL	MT_WFDMA0(0x604)
+#define MT_WFDMA0_TX_RING2_EXT_CTRL	MT_WFDMA0(0x608)
+#define MT_WFDMA0_TX_RING3_EXT_CTRL	MT_WFDMA0(0x60c)
+#define MT_WFDMA0_TX_RING4_EXT_CTRL	MT_WFDMA0(0x610)
+#define MT_WFDMA0_TX_RING5_EXT_CTRL	MT_WFDMA0(0x614)
+#define MT_WFDMA0_TX_RING6_EXT_CTRL	MT_WFDMA0(0x618)
+#define MT_WFDMA0_TX_RING16_EXT_CTRL	MT_WFDMA0(0x640)
+#define MT_WFDMA0_TX_RING17_EXT_CTRL	MT_WFDMA0(0x644)
+
+#define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
+#define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
+#define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
+#define MT_WFDMA0_RX_RING3_EXT_CTRL	MT_WFDMA0(0x68c)
+#define MT_WFDMA0_RX_RING4_EXT_CTRL	MT_WFDMA0(0x690)
+#define MT_WFDMA0_RX_RING5_EXT_CTRL	MT_WFDMA0(0x694)
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
+#define MT_INFRA_CFG_BASE		0xfe000
+#define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
+
+#define MT_HIF_REMAP_L1			MT_INFRA(0x260)
+#define MT_HIF_REMAP_L1_MASK		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L1		0xe0000
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
+#define MT_HW_BOUND			0x70010020
+#define MT_HW_CHIPID			0x70010200
+#define MT_HW_REV			0x70010204
+
+#define MT_PCIE_MAC_BASE		0x74030000
+#define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
+#define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
+
+#define MT_DMA_SHDL(ofs)		(0xd6000 + (ofs))
+#define MT_DMASHDL_SW_CONTROL		MT_DMA_SHDL(0x004)
+#define MT_DMASHDL_DMASHDL_BYPASS	BIT(28)
+#define MT_DMASHDL_OPTIONAL		MT_DMA_SHDL(0x008)
+#define MT_DMASHDL_PAGE			MT_DMA_SHDL(0x00c)
+#define MT_DMASHDL_REFILL		MT_DMA_SHDL(0x010)
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
+#define MT_CONN_ON_MISC			0x7c0600f0
+#define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
+
+#endif
-- 
2.25.1

