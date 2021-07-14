Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BF3C9344
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhGNVrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 17:47:36 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:37590 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234912AbhGNVrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 17:47:35 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.133])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2FC971C006E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:42 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 043BDB00077
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:41 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A09D013C2B8;
        Wed, 14 Jul 2021 14:44:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A09D013C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626299081;
        bh=iN1QwoEiRlA3mpBWDtG1ch74J17IvRF7J74gLWK7HN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dft3N8DiL8I6p36BSbAOpCCXc9ukFsQfRlf+Q8g3OLVE/tOZbVx/lKJ7pHQRPilDr
         RJWV4/SG7X+e4cFwEuieZrekSD14moopXt3MlYuYJBJolYQ/etBw+SCHKDNVeAY/8V
         07l5VAaSC5v5uLza8gN/fiMtZXm1w1L8szdM+1+M=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 7/8] mt76 - mt7915: Add more MIB registers.
Date:   Wed, 14 Jul 2021 14:44:31 -0700
Message-Id: <20210714214432.15162-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210714214432.15162-1-greearb@candelatech.com>
References: <20210714214432.15162-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626299082-ilHjOmQsMnUH
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add register definitions and read & accumulate them in
the mib polling logic.  Note that some registers should not
be read since firmware is already reading them.  If driver
reads those, they will be cleared-on-read, and so the firmware
stats will be incorrect.

For these 'do-not-read' stats, add them to the registers definition
so that other developers can be aware of these constraints, but do
not actually read them in the driver.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  64 +++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  25 ++++-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 105 ++++++++++++++++++
 3 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cf08138bc183..736651c04814 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1884,6 +1884,70 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
 					   MT_MIB_SDR3_FCS_ERR_MASK);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR4(ext_phy));
+	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR5(ext_phy));
+	mib->rx_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR6(ext_phy));
+	mib->channel_idle_cnt += FIELD_GET(MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR7(ext_phy));
+	mib->rx_vector_mismatch_cnt += FIELD_GET(MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR8(ext_phy));
+	mib->rx_delimiter_fail_cnt += FIELD_GET(MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR11(ext_phy));
+	mib->rx_len_mismatch_cnt += FIELD_GET(MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR12(ext_phy));
+	mib->tx_ampdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR13(ext_phy));
+	mib->tx_stop_q_empty_cnt += FIELD_GET(MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR14(ext_phy));
+	mib->tx_mpdu_attempts_cnt += FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR15(ext_phy));
+	mib->tx_mpdu_success_cnt += FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR22(ext_phy));
+	mib->rx_ampdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR23(ext_phy));
+	mib->rx_ampdu_bytes_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR24(ext_phy));
+	mib->rx_ampdu_valid_subframe_cnt += FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR25(ext_phy));
+	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR27(ext_phy));
+	mib->tx_rwp_fail_cnt += FIELD_GET(MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR28(ext_phy));
+	mib->tx_rwp_need_cnt += FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR29(ext_phy));
+	mib->rx_pfdrop_cnt += FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR30(ext_phy));
+	mib->rx_vec_queue_overflow_drop_cnt += FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR31(ext_phy));
+	mib->rx_ba_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR32(ext_phy));
+	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
+	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK, cnt);
+
 	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
 	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 29a39c24633a..fcc5cd60cfc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -135,7 +135,30 @@ struct mib_stats {
 	u32 tx_bf_fb_cpl_cnt;
 	u32 tx_bf_fb_trig_cnt;
 
-	/* Add more stats here, updated from mac_update_stats */
+	u32 tx_ampdu_cnt;
+	u32 tx_stop_q_empty_cnt;
+	u32 tx_mpdu_attempts_cnt;
+	u32 tx_mpdu_success_cnt;
+	u32 tx_pkt_ebf_cnt;
+	u32 tx_pkt_ibf_cnt;
+
+	u32 tx_rwp_fail_cnt;
+	u32 tx_rwp_need_cnt;
+
+	/* rx stats */
+	u32 rx_fifo_full_cnt;
+	u32 channel_idle_cnt;
+	u32 rx_vector_mismatch_cnt;
+	u32 rx_delimiter_fail_cnt;
+	u32 rx_len_mismatch_cnt;
+	u32 rx_mpdu_cnt;
+	u32 rx_ampdu_cnt;
+	u32 rx_ampdu_bytes_cnt;
+	u32 rx_ampdu_valid_subframe_cnt;
+	u32 rx_ampdu_valid_subframe_bytes_cnt;
+	u32 rx_pfdrop_cnt;
+	u32 rx_vec_queue_overflow_drop_cnt;
+	u32 rx_ba_cnt;
 };
 
 struct mt7915_hif {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index a213b5cb82f8..62cc32a098fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -128,15 +128,120 @@
 #define MT_LPON_TCR_SW_READ		GENMASK(1, 0)
 
 /* MIB: band 0(0x24800), band 1(0xa4800) */
+/* These counters are (mostly?) clear-on-read.  So, some should not
+ * be read at all in case firmware is already reading them.  These
+ * are commented with 'DNR' below.  The DNR stats will be read by querying
+ * the firmware API for the appropriate message.  For counters the driver
+ * does read, the driver should accumulate the counters.
+ */
 #define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
 
+#define MT_MIB_SDR0(_band)		MT_WF_MIB(_band, 0x010)
+#define MT_MIB_SDR0_BERACON_TX_CNT_MASK	GENMASK(15, 0)
+
 #define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
 #define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
 
+#define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, 0x018)
+#define MT_MIB_SDR4_RX_FIFO_FULL_MASK	GENMASK(15, 0)
+
+/* rx mpdu counter, full 32 bits */
+#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x01c)
+
+#define MT_MIB_SDR6(_band)		MT_WF_MIB(_band, 0x020)
+#define MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR7(_band)		MT_WF_MIB(_band, 0x024)
+#define MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR8(_band)		MT_WF_MIB(_band, 0x028)
+#define MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK	GENMASK(15, 0)
+
+/* aka CCA_NAV_TX_TIME */
+#define MT_MIB_SDR9_DNR(_band)		MT_WF_MIB(_band, 0x02c)
+#define MT_MIB_SDR9_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_SDR10_DNR(_band)		MT_WF_MIB(_band, 0x030)
+#define MT_MIB_SDR10_MRDY_COUNT_MASK	GENMASK(25, 0)
+
+#define MT_MIB_SDR11(_band)		MT_WF_MIB(_band, 0x034)
+#define MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK	GENMASK(15, 0)
+
+/* tx ampdu cnt, full 32 bits */
+#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, 0x038)
+
+#define MT_MIB_SDR13(_band)		MT_WF_MIB(_band, 0x03c)
+#define MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK	GENMASK(15, 0)
+
+/* counts all mpdus in ampdu, regardless of success */
+#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, 0x040)
+#define MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK	GENMASK(23, 0)
+
+/* counts all successfully tx'd mpdus in ampdu */
+#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, 0x044)
+#define MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK	GENMASK(23, 0)
+
+/* in units of 'us' */
+#define MT_MIB_SDR16_DNR(_band)		MT_WF_MIB(_band, 0x048)
+#define MT_MIB_SDR16_PRIMARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_SDR17_DNR(_band)		MT_WF_MIB(_band, 0x04c)
+#define MT_MIB_SDR17_SECONDARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_SDR18(_band)		MT_WF_MIB(_band, 0x050)
+#define MT_MIB_SDR18_PRIMARY_ENERGY_DETECT_TIME_MASK	GENMASK(23, 0)
+
+/* units are us */
+#define MT_MIB_SDR19_DNR(_band)		MT_WF_MIB(_band, 0x054)
+#define MT_MIB_SDR19_CCK_MDRDY_TIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_SDR20_DNR(_band)		MT_WF_MIB(_band, 0x058)
+#define MT_MIB_SDR20_OFDM_VHT_MDRDY_TIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_SDR21_DNR(_band)		MT_WF_MIB(_band, 0x05c)
+#define MT_MIB_SDR20_GREEN_MDRDY_TIME_MASK	GENMASK(23, 0)
+
+/* rx ampdu count, 32-bit */
+#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, 0x060)
+
+/* rx ampdu bytes count, 32-bit */
+#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, 0x064)
+
+/* rx ampdu valid subframe count */
+#define MT_MIB_SDR24(_band)		MT_WF_MIB(_band, 0x068)
+#define MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK	GENMASK(23, 0)
+
+/* rx ampdu valid subframe bytes count, 32bits */
+#define MT_MIB_SDR25(_band)		MT_WF_MIB(_band, 0x06c)
+
+/* remaining windows protected stats */
+#define MT_MIB_SDR27(_band)		MT_WF_MIB(_band, 0x074)
+#define MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR28(_band)		MT_WF_MIB(_band, 0x078)
+#define MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR29(_band)		MT_WF_MIB(_band, 0x07c)
+#define MT_MIB_SDR29_RX_PFDROP_CNT_MASK	GENMASK(7, 0)
+
+#define MT_MIB_SDR30(_band)		MT_WF_MIB(_band, 0x080)
+#define MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK	GENMASK(15, 0)
+
+/* rx blockack count, 32 bits */
+#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, 0x084)
+
+#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x088)
+#define MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x08c)
+#define MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK	GENMASK(15, 0)
+
 #define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
 #define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
 
+/* 36, 37 both DNR */
+
 #define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
 #define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
 #define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
-- 
2.20.1

