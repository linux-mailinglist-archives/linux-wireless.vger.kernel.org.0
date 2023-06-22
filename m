Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAFB73A67F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjFVQwI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjFVQwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E6E48
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57176189F
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 16:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED053C433C8;
        Thu, 22 Jun 2023 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452723;
        bh=g/A59ppwun1FHAY2FbdohrAnX1JewjJne5L16snkIl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFRCCyMI2mwayTW13IIvtCPaSW/nH9Cy4/RI2svqkrRDIk1ehWZYFtPVpgBn6Fz3m
         H09n3mconvBHhEdL1c3tRMCWfzk0o/TgnHWU/S9zmziOfJRyXxdQepmhOi/127z95W
         v80wVZVxQsTNva1ncEsIijImvko/EAQ4Mi5dIvm3oZ8gs/MUK+/z1aTJv/JPP0mf63
         kEnNxEA7kYjztXaI52stzQmqI3MHSa+PLtc7x4G7psDbhOeQSmBt7eXLrxahSmZDnA
         HOK0/bhEbdLyNZH2Ucv/Ah5fYFXk3lxiEMmq7yEX6ArbVHoHzwmtxtJBMADcD936DN
         cDOq7n7pcC74A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, deren.wu@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH v4 14/15] wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h
Date:   Thu, 22 Jun 2023 18:50:31 +0200
Message-ID: <1d6a06aabb43f207758840be3335825a6bbf0b62.1687452202.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687452202.git.lorenzo@kernel.org>
References: <cover.1687452202.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Connac3 mac definitions are shared between WiFi7 chipsets so move them in
mt76_connac3_mac.h

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac3_mac.h | 325 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 315 +----------------
 2 files changed, 326 insertions(+), 314 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
new file mode 100644
index 000000000000..6663a0b46541
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -0,0 +1,325 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT76_CONNAC3_MAC_H
+#define __MT76_CONNAC3_MAC_H
+
+#define MT_CT_PARSE_LEN			72
+#define MT_CT_DMA_BUF_NUM		2
+
+#define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
+#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
+
+#define MT_RXD0_MESH			BIT(18)
+#define MT_RXD0_MHCP			BIT(19)
+#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
+#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
+#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
+
+#define MT_RXD0_SW_PKT_TYPE_MASK	GENMASK(31, 16)
+#define MT_RXD0_SW_PKT_TYPE_MAP		0x380F
+#define MT_RXD0_SW_PKT_TYPE_FRAME	0x3801
+
+/* RXD DW1 */
+#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(11, 0)
+#define MT_RXD1_NORMAL_GROUP_1		BIT(16)
+#define MT_RXD1_NORMAL_GROUP_2		BIT(17)
+#define MT_RXD1_NORMAL_GROUP_3		BIT(18)
+#define MT_RXD1_NORMAL_GROUP_4		BIT(19)
+#define MT_RXD1_NORMAL_GROUP_5		BIT(20)
+#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
+#define MT_RXD1_NORMAL_CM		BIT(23)
+#define MT_RXD1_NORMAL_CLM		BIT(24)
+#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
+#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
+#define MT_RXD1_NORMAL_BAND_IDX		GENMASK(28, 27)
+#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
+#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
+#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
+
+/* RXD DW2 */
+#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
+#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
+#define MT_RXD2_NORMAL_HDR_TRANS	BIT(7)
+#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 13)
+#define MT_RXD2_NORMAL_SEC_MODE		GENMASK(20, 16)
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
+#define MT_RXD3_NORMAL_HTC_VLD		BIT(18)
+#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
+#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
+#define MT_RXD3_NORMAL_CO_ANT		BIT(22)
+#define MT_RXD3_NORMAL_FCS_ERR		BIT(24)
+#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
+
+/* RXD DW4 */
+#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
+
+#define MT_RXV_HDR_BAND_IDX		BIT(24)
+
+/* RXD GROUP4 */
+#define MT_RXD8_FRAME_CONTROL		GENMASK(15, 0)
+
+#define MT_RXD10_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD10_QOS_CTL		GENMASK(31, 16)
+
+#define MT_RXD11_HT_CONTROL		GENMASK(31, 0)
+
+/* P-RXV */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(10, 7)
+#define MT_PRXV_TXBF			BIT(11)
+#define MT_PRXV_HT_AD_CODE		BIT(12)
+#define MT_PRXV_HE_RU_ALLOC		GENMASK(30, 22)
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+#define MT_PRXV_HT_SHORT_GI		GENMASK(4, 3)
+#define MT_PRXV_HT_STBC			GENMASK(10, 9)
+#define MT_PRXV_TX_MODE			GENMASK(14, 11)
+#define MT_PRXV_FRAME_MODE		GENMASK(2, 0)
+#define MT_PRXV_DCM			BIT(5)
+
+/* C-RXV */
+#define MT_CRXV_HE_NUM_USER		GENMASK(26, 20)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(28, 27)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(30)
+
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(1)
+#define MT_CRXV_HE_UPLINK		BIT(2)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(27, 17)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(29)
+
+#define MT_CRXV_HE_DOPPLER		BIT(0)
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(15, 10)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(19, 17)
+
+#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
+#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
+#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
+
+#define MT_CRXV_HE_RU0			GENMASK(8, 0)
+#define MT_CRXV_HE_RU1			GENMASK(17, 9)
+#define MT_CRXV_HE_RU2			GENMASK(26, 18)
+#define MT_CRXV_HE_RU3_L		GENMASK(31, 27)
+#define MT_CRXV_HE_RU3_H		GENMASK(3, 0)
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
+enum tx_mgnt_type {
+	MT_TX_NORMAL,
+	MT_TX_TIMING,
+	MT_TX_ADDBA,
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
+#define MT_TXD1_FIXED_RATE		BIT(31)
+#define MT_TXD1_OWN_MAC			GENMASK(30, 25)
+#define MT_TXD1_TID			GENMASK(24, 21)
+#define MT_TXD1_BIP			BIT(24)
+#define MT_TXD1_ETH_802_3		BIT(20)
+#define MT_TXD1_HDR_INFO		GENMASK(20, 16)
+#define MT_TXD1_HDR_FORMAT		GENMASK(15, 14)
+#define MT_TXD1_TGID			GENMASK(13, 12)
+#define MT_TXD1_WLAN_IDX		GENMASK(11, 0)
+
+#define MT_TXD2_POWER_OFFSET		GENMASK(31, 26)
+#define MT_TXD2_MAX_TX_TIME		GENMASK(25, 16)
+#define MT_TXD2_FRAG			GENMASK(15, 14)
+#define MT_TXD2_HTC_VLD			BIT(13)
+#define MT_TXD2_DURATION		BIT(12)
+#define MT_TXD2_HDR_PAD			GENMASK(11, 10)
+#define MT_TXD2_RTS			BIT(9)
+#define MT_TXD2_OWN_MAC_MAP		BIT(8)
+#define MT_TXD2_BF_TYPE			GENMASK(6, 7)
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
+#define MT_TXD3_HW_AMSDU		BIT(5)
+#define MT_TXD3_BCM			BIT(4)
+#define MT_TXD3_EEOSP			BIT(3)
+#define MT_TXD3_EMRD			BIT(2)
+#define MT_TXD3_PROTECT_FRAME		BIT(1)
+#define MT_TXD3_NO_ACK			BIT(0)
+
+#define MT_TXD4_PN_LOW			GENMASK(31, 0)
+
+#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
+#define MT_TXD5_FL			BIT(15)
+#define MT_TXD5_BYPASS_TBB		BIT(14)
+#define MT_TXD5_BYPASS_RBB		BIT(13)
+#define MT_TXD5_BSS_COLOR_ZERO		BIT(12)
+#define MT_TXD5_TX_STATUS_HOST		BIT(10)
+#define MT_TXD5_TX_STATUS_MCU		BIT(9)
+#define MT_TXD5_TX_STATUS_FMT		BIT(8)
+#define MT_TXD5_PID			GENMASK(7, 0)
+
+#define MT_TXD6_TX_SRC			GENMASK(31, 30)
+#define MT_TXD6_VTA			BIT(28)
+#define MT_TXD6_BW			GENMASK(25, 22)
+#define MT_TXD6_TX_RATE			GENMASK(21, 16)
+#define MT_TXD6_TIMESTAMP_OFS_EN	BIT(15)
+#define MT_TXD6_TIMESTAMP_OFS_IDX	GENMASK(14, 10)
+#define MT_TXD6_MSDU_CNT		GENMASK(9, 4)
+#define MT_TXD6_DIS_MAT			BIT(3)
+#define MT_TXD6_DAS			BIT(2)
+#define MT_TXD6_AMSDU_CAP		BIT(1)
+
+#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
+#define MT_TXD7_IP_SUM			BIT(29)
+#define MT_TXD7_DROP_BY_SDO		BIT(28)
+#define MT_TXD7_MAC_TXD			BIT(27)
+#define MT_TXD7_CTXD			BIT(26)
+#define MT_TXD7_CTXD_CNT		GENMASK(25, 22)
+#define MT_TXD7_UDP_TCP_SUM		BIT(15)
+#define MT_TXD7_TX_TIME			GENMASK(9, 0)
+
+#define MT_TX_RATE_STBC			BIT(14)
+#define MT_TX_RATE_NSS			GENMASK(13, 10)
+#define MT_TX_RATE_MODE			GENMASK(9, 6)
+#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
+#define MT_TX_RATE_DCM			BIT(4)
+/* VHT/HE only use bits 0-3 */
+#define MT_TX_RATE_IDX			GENMASK(5, 0)
+
+#define MT_TXFREE0_PKT_TYPE		GENMASK(31, 27)
+#define MT_TXFREE0_MSDU_CNT		GENMASK(25, 16)
+#define MT_TXFREE0_RX_BYTE		GENMASK(15, 0)
+
+#define MT_TXFREE1_VER			GENMASK(18, 16)
+
+#define MT_TXFREE_INFO_PAIR		BIT(31)
+#define MT_TXFREE_INFO_HEADER		BIT(30)
+#define MT_TXFREE_INFO_WLAN_ID		GENMASK(23, 12)
+#define MT_TXFREE_INFO_MSDU_ID		GENMASK(14, 0)
+#define MT_TXFREE_INFO_COUNT		GENMASK(27, 24)
+#define MT_TXFREE_INFO_STAT		GENMASK(29, 28)
+
+#define MT_TXS0_BW			GENMASK(31, 29)
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
+#define MT_TXS2_BAND			GENMASK(29, 28)
+#define MT_TXS2_WCID			GENMASK(27, 16)
+#define MT_TXS2_TX_DELAY		GENMASK(15, 0)
+
+#define MT_TXS3_PID			GENMASK(31, 24)
+#define MT_TXS3_RATE_STBC		BIT(7)
+#define MT_TXS3_FIXED_RATE		BIT(6)
+#define MT_TXS3_SRC			GENMASK(5, 4)
+#define MT_TXS3_SHARED_ANTENNA		BIT(3)
+#define MT_TXS3_LAST_TX_RATE		GENMASK(2, 0)
+
+#define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
+
+#define MT_TXS5_F0_FINAL_MPDU		BIT(31)
+#define MT_TXS5_F0_QOS			BIT(30)
+#define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
+#define MT_TXS5_F0_FRONT_TIME		GENMASK(24, 0)
+#define MT_TXS5_F1_MPDU_TX_COUNT	GENMASK(31, 24)
+#define MT_TXS5_F1_MPDU_TX_BYTES	GENMASK(23, 0)
+
+#define MT_TXS6_F0_NOISE_3		GENMASK(31, 24)
+#define MT_TXS6_F0_NOISE_2		GENMASK(23, 16)
+#define MT_TXS6_F0_NOISE_1		GENMASK(15, 8)
+#define MT_TXS6_F0_NOISE_0		GENMASK(7, 0)
+#define MT_TXS6_F1_MPDU_FAIL_COUNT	GENMASK(31, 24)
+#define MT_TXS6_F1_MPDU_FAIL_BYTES	GENMASK(23, 0)
+
+#define MT_TXS7_F0_RCPI_3		GENMASK(31, 24)
+#define MT_TXS7_F0_RCPI_2		GENMASK(23, 16)
+#define MT_TXS7_F0_RCPI_1		GENMASK(15, 8)
+#define MT_TXS7_F0_RCPI_0		GENMASK(7, 0)
+#define MT_TXS7_F1_MPDU_RETRY_COUNT	GENMASK(31, 24)
+#define MT_TXS7_F1_MPDU_RETRY_BYTES	GENMASK(23, 0)
+
+#endif /* __MT76_CONNAC3_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index bc4e6c55373e..e629324a5617 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -6,320 +6,7 @@
 #ifndef __MT7996_MAC_H
 #define __MT7996_MAC_H
 
-#define MT_CT_PARSE_LEN			72
-#define MT_CT_DMA_BUF_NUM		2
-
-#define MT_RXD0_LENGTH			GENMASK(15, 0)
-#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
-
-#define MT_RXD0_MESH			BIT(18)
-#define MT_RXD0_MHCP			BIT(19)
-#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
-#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
-#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
-
-#define MT_RXD0_SW_PKT_TYPE_MASK	GENMASK(31, 16)
-#define MT_RXD0_SW_PKT_TYPE_MAP		0x380F
-#define MT_RXD0_SW_PKT_TYPE_FRAME	0x3801
-
-/* RXD DW1 */
-#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(11, 0)
-#define MT_RXD1_NORMAL_GROUP_1		BIT(16)
-#define MT_RXD1_NORMAL_GROUP_2		BIT(17)
-#define MT_RXD1_NORMAL_GROUP_3		BIT(18)
-#define MT_RXD1_NORMAL_GROUP_4		BIT(19)
-#define MT_RXD1_NORMAL_GROUP_5		BIT(20)
-#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
-#define MT_RXD1_NORMAL_CM		BIT(23)
-#define MT_RXD1_NORMAL_CLM		BIT(24)
-#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
-#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
-#define MT_RXD1_NORMAL_BAND_IDX		GENMASK(28, 27)
-#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
-#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
-#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
-
-/* RXD DW2 */
-#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
-#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
-#define MT_RXD2_NORMAL_HDR_TRANS	BIT(7)
-#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 13)
-#define MT_RXD2_NORMAL_SEC_MODE		GENMASK(20, 16)
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
-#define MT_RXD3_NORMAL_HTC_VLD		BIT(18)
-#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
-#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
-#define MT_RXD3_NORMAL_CO_ANT		BIT(22)
-#define MT_RXD3_NORMAL_FCS_ERR		BIT(24)
-#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
-
-/* RXD DW4 */
-#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
-#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
-#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
-#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
-
-#define MT_RXV_HDR_BAND_IDX		BIT(24)
-
-/* RXD GROUP4 */
-#define MT_RXD8_FRAME_CONTROL		GENMASK(15, 0)
-
-#define MT_RXD10_SEQ_CTRL		GENMASK(15, 0)
-#define MT_RXD10_QOS_CTL		GENMASK(31, 16)
-
-#define MT_RXD11_HT_CONTROL		GENMASK(31, 0)
-
-/* P-RXV */
-#define MT_PRXV_TX_RATE			GENMASK(6, 0)
-#define MT_PRXV_TX_DCM			BIT(4)
-#define MT_PRXV_TX_ER_SU_106T		BIT(5)
-#define MT_PRXV_NSTS			GENMASK(10, 7)
-#define MT_PRXV_TXBF			BIT(11)
-#define MT_PRXV_HT_AD_CODE		BIT(12)
-#define MT_PRXV_HE_RU_ALLOC		GENMASK(30, 22)
-#define MT_PRXV_RCPI3			GENMASK(31, 24)
-#define MT_PRXV_RCPI2			GENMASK(23, 16)
-#define MT_PRXV_RCPI1			GENMASK(15, 8)
-#define MT_PRXV_RCPI0			GENMASK(7, 0)
-#define MT_PRXV_HT_SHORT_GI		GENMASK(4, 3)
-#define MT_PRXV_HT_STBC			GENMASK(10, 9)
-#define MT_PRXV_TX_MODE			GENMASK(14, 11)
-#define MT_PRXV_FRAME_MODE		GENMASK(2, 0)
-#define MT_PRXV_DCM			BIT(5)
-
-/* C-RXV */
-#define MT_CRXV_HE_NUM_USER		GENMASK(26, 20)
-#define MT_CRXV_HE_LTF_SIZE		GENMASK(28, 27)
-#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(30)
-
-#define MT_CRXV_HE_PE_DISAMBIG		BIT(1)
-#define MT_CRXV_HE_UPLINK		BIT(2)
-
-#define MT_CRXV_HE_MU_AID		GENMASK(27, 17)
-#define MT_CRXV_HE_BEAM_CHNG		BIT(29)
-
-#define MT_CRXV_HE_DOPPLER		BIT(0)
-#define MT_CRXV_HE_BSS_COLOR		GENMASK(15, 10)
-#define MT_CRXV_HE_TXOP_DUR		GENMASK(19, 17)
-
-#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
-#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
-#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
-#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
-
-#define MT_CRXV_HE_RU0			GENMASK(8, 0)
-#define MT_CRXV_HE_RU1			GENMASK(17, 9)
-#define MT_CRXV_HE_RU2			GENMASK(26, 18)
-#define MT_CRXV_HE_RU3_L		GENMASK(31, 27)
-#define MT_CRXV_HE_RU3_H		GENMASK(3, 0)
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
-enum tx_mgnt_type {
-	MT_TX_NORMAL,
-	MT_TX_TIMING,
-	MT_TX_ADDBA,
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
-#define MT_TXD1_FIXED_RATE		BIT(31)
-#define MT_TXD1_OWN_MAC			GENMASK(30, 25)
-#define MT_TXD1_TID			GENMASK(24, 21)
-#define MT_TXD1_BIP			BIT(24)
-#define MT_TXD1_ETH_802_3		BIT(20)
-#define MT_TXD1_HDR_INFO		GENMASK(20, 16)
-#define MT_TXD1_HDR_FORMAT		GENMASK(15, 14)
-#define MT_TXD1_TGID			GENMASK(13, 12)
-#define MT_TXD1_WLAN_IDX		GENMASK(11, 0)
-
-#define MT_TXD2_POWER_OFFSET		GENMASK(31, 26)
-#define MT_TXD2_MAX_TX_TIME		GENMASK(25, 16)
-#define MT_TXD2_FRAG			GENMASK(15, 14)
-#define MT_TXD2_HTC_VLD			BIT(13)
-#define MT_TXD2_DURATION		BIT(12)
-#define MT_TXD2_HDR_PAD			GENMASK(11, 10)
-#define MT_TXD2_RTS			BIT(9)
-#define MT_TXD2_OWN_MAC_MAP		BIT(8)
-#define MT_TXD2_BF_TYPE			GENMASK(6, 7)
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
-#define MT_TXD3_HW_AMSDU		BIT(5)
-#define MT_TXD3_BCM			BIT(4)
-#define MT_TXD3_EEOSP			BIT(3)
-#define MT_TXD3_EMRD			BIT(2)
-#define MT_TXD3_PROTECT_FRAME		BIT(1)
-#define MT_TXD3_NO_ACK			BIT(0)
-
-#define MT_TXD4_PN_LOW			GENMASK(31, 0)
-
-#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
-#define MT_TXD5_FL			BIT(15)
-#define MT_TXD5_BYPASS_TBB		BIT(14)
-#define MT_TXD5_BYPASS_RBB		BIT(13)
-#define MT_TXD5_BSS_COLOR_ZERO		BIT(12)
-#define MT_TXD5_TX_STATUS_HOST		BIT(10)
-#define MT_TXD5_TX_STATUS_MCU		BIT(9)
-#define MT_TXD5_TX_STATUS_FMT		BIT(8)
-#define MT_TXD5_PID			GENMASK(7, 0)
-
-#define MT_TXD6_TX_SRC			GENMASK(31, 30)
-#define MT_TXD6_VTA			BIT(28)
-#define MT_TXD6_BW			GENMASK(25, 22)
-#define MT_TXD6_TX_RATE			GENMASK(21, 16)
-#define MT_TXD6_TIMESTAMP_OFS_EN	BIT(15)
-#define MT_TXD6_TIMESTAMP_OFS_IDX	GENMASK(14, 10)
-#define MT_TXD6_MSDU_CNT		GENMASK(9, 4)
-#define MT_TXD6_DIS_MAT			BIT(3)
-#define MT_TXD6_DAS			BIT(2)
-#define MT_TXD6_AMSDU_CAP		BIT(1)
-
-#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
-#define MT_TXD7_IP_SUM			BIT(29)
-#define MT_TXD7_DROP_BY_SDO		BIT(28)
-#define MT_TXD7_MAC_TXD			BIT(27)
-#define MT_TXD7_CTXD			BIT(26)
-#define MT_TXD7_CTXD_CNT		GENMASK(25, 22)
-#define MT_TXD7_UDP_TCP_SUM		BIT(15)
-#define MT_TXD7_TX_TIME			GENMASK(9, 0)
-
-#define MT_TX_RATE_STBC			BIT(14)
-#define MT_TX_RATE_NSS			GENMASK(13, 10)
-#define MT_TX_RATE_MODE			GENMASK(9, 6)
-#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
-#define MT_TX_RATE_DCM			BIT(4)
-/* VHT/HE only use bits 0-3 */
-#define MT_TX_RATE_IDX			GENMASK(5, 0)
-
-#define MT_TXFREE0_PKT_TYPE		GENMASK(31, 27)
-#define MT_TXFREE0_MSDU_CNT		GENMASK(25, 16)
-#define MT_TXFREE0_RX_BYTE		GENMASK(15, 0)
-
-#define MT_TXFREE1_VER			GENMASK(18, 16)
-
-#define MT_TXFREE_INFO_PAIR		BIT(31)
-#define MT_TXFREE_INFO_HEADER		BIT(30)
-#define MT_TXFREE_INFO_WLAN_ID		GENMASK(23, 12)
-#define MT_TXFREE_INFO_MSDU_ID		GENMASK(14, 0)
-
-#define MT_TXS0_BW			GENMASK(31, 29)
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
-#define MT_TXS2_BAND			GENMASK(29, 28)
-#define MT_TXS2_WCID			GENMASK(27, 16)
-#define MT_TXS2_TX_DELAY		GENMASK(15, 0)
-
-#define MT_TXS3_PID			GENMASK(31, 24)
-#define MT_TXS3_RATE_STBC		BIT(7)
-#define MT_TXS3_FIXED_RATE		BIT(6)
-#define MT_TXS3_SRC			GENMASK(5, 4)
-#define MT_TXS3_SHARED_ANTENNA		BIT(3)
-#define MT_TXS3_LAST_TX_RATE		GENMASK(2, 0)
-
-#define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
-
-#define MT_TXS5_F0_FINAL_MPDU		BIT(31)
-#define MT_TXS5_F0_QOS			BIT(30)
-#define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
-#define MT_TXS5_F0_FRONT_TIME		GENMASK(24, 0)
-#define MT_TXS5_F1_MPDU_TX_COUNT	GENMASK(31, 24)
-#define MT_TXS5_F1_MPDU_TX_BYTES	GENMASK(23, 0)
-
-#define MT_TXS6_F0_NOISE_3		GENMASK(31, 24)
-#define MT_TXS6_F0_NOISE_2		GENMASK(23, 16)
-#define MT_TXS6_F0_NOISE_1		GENMASK(15, 8)
-#define MT_TXS6_F0_NOISE_0		GENMASK(7, 0)
-#define MT_TXS6_F1_MPDU_FAIL_COUNT	GENMASK(31, 24)
-#define MT_TXS6_F1_MPDU_FAIL_BYTES	GENMASK(23, 0)
-
-#define MT_TXS7_F0_RCPI_3		GENMASK(31, 24)
-#define MT_TXS7_F0_RCPI_2		GENMASK(23, 16)
-#define MT_TXS7_F0_RCPI_1		GENMASK(15, 8)
-#define MT_TXS7_F0_RCPI_0		GENMASK(7, 0)
-#define MT_TXS7_F1_MPDU_RETRY_COUNT	GENMASK(31, 24)
-#define MT_TXS7_F1_MPDU_RETRY_BYTES	GENMASK(23, 0)
+#include "../mt76_connac3_mac.h"
 
 struct mt7996_dfs_pulse {
 	u32 max_width;		/* us */
-- 
2.41.0

