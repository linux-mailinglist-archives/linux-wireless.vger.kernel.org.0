Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB6453F9CF
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiFGJa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiFGJ3f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 05:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F859A5029
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 02:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 914CF611EA
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 09:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C446BC3411C;
        Tue,  7 Jun 2022 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654594141;
        bh=PnwILKdxWjcIYg/UTe8Y/ax4rEh+w1Boa29sGH0AxCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPPEB9fW1a9ceDxuPuBR24onrTsjbtTraH8I7/lmimK/A7V1c+Js8hknrFTz8rK6X
         9ULV2AjPwAgm+khMjRR/+wMFgewoab48oq8KmI3YBCy2GqQVmr7/yBoF6r1UmHwPC6
         UUyR8QLXl31REQVPi295q7Rwj2SsCBY8+wIKAhGqek3dpPWOo7f26WcumQS92MqAwA
         eIDoDVX43H2d0V3b9PAUKo2J+tiHA5ybcs4Wp46UTc8/e7B727uxcFeFQu3ZBk4LtR
         WfcHLtC9d4NMF9O977krO+NyWy8knFr9hNxFpIXHaoInKh7md2LORhe/cev+//dw6o
         BtEpfX5BxLFug==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 3/5] mt76: connac: move mac connac2 defs in mt76_connac2_mac.h
Date:   Tue,  7 Jun 2022 11:28:39 +0200
Message-Id: <5c7862a8f0c902c9c015fb1f9b30e3b6839b81ed.1654593918.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654593918.git.lorenzo@kernel.org>
References: <cover.1654593918.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to share connac2 mac txwi code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 167 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 142 +--------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  14 --
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 123 +------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  10 --
 5 files changed, 171 insertions(+), 285 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
new file mode 100644
index 000000000000..c9d9c8475a38
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -0,0 +1,167 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2022 MediaTek Inc. */
+
+#ifndef __MT76_CONNAC2_MAC_H
+#define __MT76_CONNAC2_MAC_H
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
+enum {
+	MT_CTX0,
+	MT_HIF0 = 0x0,
+
+	MT_LMAC_AC00 = 0x0,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+	MT_LMAC_PSMP0,
+};
+
+#define MT_TXD_SIZE			(8 * 4)
+#define MT_SDIO_TXD_SIZE		(MT_TXD_SIZE + 8 * 4)
+#define MT_SDIO_TAIL_SIZE		8
+#define MT_SDIO_HDR_SIZE		4
+#define MT_USB_TAIL_SIZE		4
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
+#define MT_TXD7_TYPE			GENMASK(21, 20)
+#define MT_TXD7_SUB_TYPE		GENMASK(19, 16)
+
+#define MT_TXD7_PSE_FID			GENMASK(27, 16)
+#define MT_TXD7_SPE_IDX			GENMASK(15, 11)
+#define MT_TXD7_HW_AMSDU		BIT(10)
+#define MT_TXD7_TX_TIME			GENMASK(9, 0)
+
+#define MT_TXD8_L_TYPE			GENMASK(5, 4)
+#define MT_TXD8_L_SUB_TYPE		GENMASK(3, 0)
+
+#define MT_TX_RATE_STBC			BIT(13)
+#define MT_TX_RATE_NSS			GENMASK(12, 10)
+#define MT_TX_RATE_MODE			GENMASK(9, 6)
+#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
+#define MT_TX_RATE_DCM			BIT(4)
+/* VHT/HE only use bits 0-3 */
+#define MT_TX_RATE_IDX			GENMASK(5, 0)
+
+#define MT_TXS0_FIXED_RATE		BIT(31)
+#define MT_TXS0_BW			GENMASK(30, 29)
+#define MT_TXS0_TID			GENMASK(28, 26)
+#define MT_TXS0_AMPDU			BIT(25)
+#define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
+#define MT_TXS0_BA_ERROR		BIT(22)
+#define MT_TXS0_PS_FLAG			BIT(21)
+#define MT_TXS0_TXOP_TIMEOUT		BIT(20)
+#define MT_TXS0_BIP_ERROR		BIT(19)
+
+#define MT_TXS0_QUEUE_TIMEOUT		BIT(18)
+#define MT_TXS0_RTS_TIMEOUT		BIT(17)
+#define MT_TXS0_ACK_TIMEOUT		BIT(16)
+#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+
+#define MT_TXS0_TX_STATUS_HOST		BIT(15)
+#define MT_TXS0_TX_STATUS_MCU		BIT(14)
+#define MT_TXS0_TX_RATE			GENMASK(13, 0)
+
+#define MT_TXS1_SEQNO			GENMASK(31, 20)
+#define MT_TXS1_RESP_RATE		GENMASK(19, 16)
+#define MT_TXS1_RXV_SEQNO		GENMASK(15, 8)
+#define MT_TXS1_TX_POWER_DBM		GENMASK(7, 0)
+
+#define MT_TXS2_BF_STATUS		GENMASK(31, 30)
+#define MT_TXS2_LAST_TX_RATE		GENMASK(29, 27)
+#define MT_TXS2_SHARED_ANTENNA		BIT(26)
+#define MT_TXS2_WCID			GENMASK(25, 16)
+#define MT_TXS2_TX_DELAY		GENMASK(15, 0)
+
+#define MT_TXS3_PID			GENMASK(31, 24)
+#define MT_TXS3_ANT_ID			GENMASK(23, 0)
+
+#define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
+
+#endif /* __MT76_CONNAC2_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index c5fd1a618ae7..f581ae27375b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -4,6 +4,8 @@
 #ifndef __MT7915_MAC_H
 #define __MT7915_MAC_H
 
+#include "../mt76_connac2_mac.h"
+
 #define MT_CT_PARSE_LEN			72
 #define MT_CT_DMA_BUF_NUM		2
 
@@ -166,20 +168,6 @@ enum rx_pkt_type {
 #define MT_CRXV_FOE_HI		GENMASK(6, 0)
 #define MT_CRXV_FOE_SHIFT	13
 
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
 enum tx_port_idx {
 	MT_TX_PORT_IDX_LMAC,
 	MT_TX_PORT_IDX_MCU
@@ -200,97 +188,6 @@ enum tx_mcu_port_q_idx {
 #define MT_CT_INFO_HSR2_TX		BIT(4)
 #define MT_CT_INFO_FROM_HOST		BIT(7)
 
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
-/* VHT/HE only use bits 0-3 */
-#define MT_TX_RATE_IDX			GENMASK(5, 0)
-
 #define MT_TXP_MAX_BUF_NUM		6
 
 struct mt7915_txp {
@@ -324,41 +221,6 @@ struct mt7915_tx_free {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-#define MT_TXS0_FIXED_RATE		BIT(31)
-#define MT_TXS0_BW			GENMASK(30, 29)
-#define MT_TXS0_TID			GENMASK(28, 26)
-#define MT_TXS0_AMPDU			BIT(25)
-#define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
-#define MT_TXS0_BA_ERROR		BIT(22)
-#define MT_TXS0_PS_FLAG			BIT(21)
-#define MT_TXS0_TXOP_TIMEOUT		BIT(20)
-#define MT_TXS0_BIP_ERROR		BIT(19)
-
-#define MT_TXS0_QUEUE_TIMEOUT		BIT(18)
-#define MT_TXS0_RTS_TIMEOUT		BIT(17)
-#define MT_TXS0_ACK_TIMEOUT		BIT(16)
-#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
-
-#define MT_TXS0_TX_STATUS_HOST		BIT(15)
-#define MT_TXS0_TX_STATUS_MCU		BIT(14)
-#define MT_TXS0_TX_RATE			GENMASK(13, 0)
-
-#define MT_TXS1_SEQNO			GENMASK(31, 20)
-#define MT_TXS1_RESP_RATE		GENMASK(19, 16)
-#define MT_TXS1_RXV_SEQNO		GENMASK(15, 8)
-#define MT_TXS1_TX_POWER_DBM		GENMASK(7, 0)
-
-#define MT_TXS2_BF_STATUS		GENMASK(31, 30)
-#define MT_TXS2_LAST_TX_RATE		GENMASK(29, 27)
-#define MT_TXS2_SHARED_ANTENNA		BIT(26)
-#define MT_TXS2_WCID			GENMASK(25, 16)
-#define MT_TXS2_TX_DELAY		GENMASK(15, 0)
-
-#define MT_TXS3_PID			GENMASK(31, 24)
-#define MT_TXS3_ANT_ID			GENMASK(23, 0)
-
-#define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
-
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
 #define MT_TXS5_F0_QOS			BIT(30)
 #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index e0049ab777b8..fbd5f123c6a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -348,20 +348,6 @@ enum {
 	__MT_WFDMA_MAX,
 };
 
-enum {
-	MT_CTX0,
-	MT_HIF0 = 0x0,
-
-	MT_LMAC_AC00 = 0x0,
-	MT_LMAC_AC01,
-	MT_LMAC_AC02,
-	MT_LMAC_AC03,
-	MT_LMAC_ALTX0 = 0x10,
-	MT_LMAC_BMC0,
-	MT_LMAC_BCN0,
-	MT_LMAC_PSMP0,
-};
-
 enum {
 	MT_RX_SEL0,
 	MT_RX_SEL1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 79447e2d0143..556e687bd235 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -4,6 +4,8 @@
 #ifndef __MT7921_MAC_H
 #define __MT7921_MAC_H
 
+#include "../mt76_connac2_mac.h"
+
 #define MT_CT_PARSE_LEN			72
 #define MT_CT_DMA_BUF_NUM		2
 
@@ -163,20 +165,6 @@ enum rx_pkt_type {
 #define MT_CRXV_FOE_HI		GENMASK(6, 0)
 #define MT_CRXV_FOE_SHIFT	13
 
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
 enum tx_port_idx {
 	MT_TX_PORT_IDX_LMAC,
 	MT_TX_PORT_IDX_MCU
@@ -197,104 +185,6 @@ enum tx_mcu_port_q_idx {
 #define MT_CT_INFO_HSR2_TX		BIT(4)
 #define MT_CT_INFO_FROM_HOST		BIT(7)
 
-#define MT_TXD_SIZE			(8 * 4)
-
-#define MT_SDIO_TXD_SIZE		(MT_TXD_SIZE + 8 * 4)
-#define MT_SDIO_TAIL_SIZE		8
-#define MT_SDIO_HDR_SIZE		4
-#define MT_USB_TAIL_SIZE		4
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
-#define MT_TXD8_L_TYPE			GENMASK(5, 4)
-#define MT_TXD8_L_SUB_TYPE		GENMASK(3, 0)
-
-#define MT_TX_RATE_STBC			BIT(13)
-#define MT_TX_RATE_NSS			GENMASK(12, 10)
-#define MT_TX_RATE_MODE			GENMASK(9, 6)
-#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
-#define MT_TX_RATE_DCM			BIT(4)
-#define MT_TX_RATE_IDX			GENMASK(3, 0)
-
 #define MT_TXP_MAX_BUF_NUM		6
 
 struct mt7921_txp {
@@ -325,15 +215,6 @@ struct mt7921_tx_free {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-#define MT_TXS0_BW			GENMASK(30, 29)
-#define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
-#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
-#define MT_TXS0_TX_RATE			GENMASK(13, 0)
-
-#define MT_TXS2_WCID			GENMASK(25, 16)
-
-#define MT_TXS3_PID			GENMASK(31, 24)
-
 static inline struct mt7921_txp_common *
 mt7921_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 1e4a45e60913..8015764997bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -251,16 +251,6 @@ struct mt7921_txpwr {
 	} data[TXPWR_MAX_NUM];
 };
 
-enum {
-	MT_LMAC_AC00,
-	MT_LMAC_AC01,
-	MT_LMAC_AC02,
-	MT_LMAC_AC03,
-	MT_LMAC_ALTX0 = 0x10,
-	MT_LMAC_BMC0,
-	MT_LMAC_BCN0,
-};
-
 static inline struct mt7921_phy *
 mt7921_hw_phy(struct ieee80211_hw *hw)
 {
-- 
2.35.3

