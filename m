Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004F4B28B9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 16:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351236AbiBKPIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 10:08:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351227AbiBKPIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 10:08:20 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF030B
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 07:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644592098; x=1676128098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1HTrnLoDiU6zGl44ur4neYq6HYQLgWlmEY2RFWQvPDI=;
  b=gY/3NEY0xYNbuglwowvtg4vXgS4F823pn6IwigwciTnpH3mLzmuqB98B
   LJZhJHPaRjb5rAwF136/3ZXcqCrEWmEotvPN+N7BbBN5XuhM32H6ouVsh
   tMqISWdYDDkRsGzsGVdkBCPpvWOMb2NbpYEyDMiY+MDuymfa4qRhhRhVE
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Feb 2022 07:08:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:08:18 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 07:08:17 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 07:08:15 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH 5/6] ath11k: Register DBR event handler for CFR data
Date:   Fri, 11 Feb 2022 20:37:54 +0530
Message-ID: <1644592075-27082-6-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware sends an WMI event WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT
to host to indicate the CFR data availability in the DB ring.

Host will reap the CFR data from the DB ring buffers and invoke
correlate_and_relay API to correlate the CFR data with the meta
data coming from the other WMI event WMI_PEER_CFR_CAPTURE_EVENT.

If correlate and relay function returns success then release the
buffer to user space through relayfs, otherwise hold the buffer
until other WMI event comes from the firmware.

Tested-on: IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c    | 235 ++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/cfr.h    |  80 +++++++++++
 drivers/net/wireless/ath/ath11k/dbring.c |  10 +-
 drivers/net/wireless/ath/ath11k/dbring.h |   2 +
 drivers/net/wireless/ath/ath11k/debug.h  |   2 +
 drivers/net/wireless/ath/ath11k/wmi.h    |   2 +-
 6 files changed, 328 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index 658b920..e2ad690 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -8,10 +8,243 @@
 #include "core.h"
 #include "debug.h"
 
+struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar)
+{
+	if (ar->cfr_enabled)
+		return &ar->cfr.rx_ring;
+
+	return NULL;
+}
+
+static int cfr_calculate_tones_from_dma_hdr(struct ath11k_cfir_dma_hdr *hdr)
+{
+	u8 bw = FIELD_GET(CFIR_DMA_HDR_INFO1_UPLOAD_PKT_BW, hdr->info1);
+	u8 preamble = FIELD_GET(CFIR_DMA_HDR_INFO1_PREAMBLE_TYPE, hdr->info1);
+
+	switch (preamble) {
+	case ATH11K_CFR_PREAMBLE_TYPE_LEGACY:
+	case ATH11K_CFR_PREAMBLE_TYPE_VHT:
+		switch (bw) {
+		case 0:
+			return TONES_IN_20MHZ;
+		case 1: /* DUP40/VHT40 */
+			return TONES_IN_40MHZ;
+		case 2: /* DUP80/VHT80 */
+			return TONES_IN_80MHZ;
+		case 3: /* DUP160/VHT160 */
+			return TONES_IN_160MHZ;
+		default:
+			break;
+		}
+
+	case ATH11K_CFR_PREAMBLE_TYPE_HT:
+		switch (bw) {
+		case 0:
+			return TONES_IN_20MHZ;
+		case 1:
+			return TONES_IN_40MHZ;
+		}
+	}
+
+	return TONES_INVALID;
+}
+
+void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut)
+{
+	memset(lut, 0, sizeof(*lut));
+}
+
+static void ath11k_cfr_rfs_write(struct ath11k *ar, const void *head,
+				 u32 head_len, const void *data, u32 data_len,
+				 const void *tail, int tail_data)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	if (!ar->cfr.rfs_cfr_capture)
+		return;
+
+	relay_write(cfr->rfs_cfr_capture, head, head_len);
+	relay_write(cfr->rfs_cfr_capture, data, data_len);
+	relay_write(cfr->rfs_cfr_capture, tail, tail_data);
+	relay_flush(cfr->rfs_cfr_capture);
+}
+
+static void ath11k_cfr_free_pending_dbr_events(struct ath11k *ar)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct ath11k_look_up_table *lut;
+	int i;
+
+	if (!cfr->lut)
+		return;
+
+	for (i = 0; i < cfr->lut_num; i++) {
+		lut = &cfr->lut[i];
+		if (lut->dbr_recv && !lut->tx_recv &&
+		    lut->dbr_tstamp < cfr->last_success_tstamp) {
+			ath11k_dbring_bufs_replenish(ar, &cfr->rx_ring, lut->buff,
+						     WMI_DIRECT_BUF_CFR);
+			ath11k_cfr_release_lut_entry(lut);
+			cfr->flush_dbr_cnt++;
+		}
+	}
+}
+
+/* Correlate and relay: This function correlate the data coming from
+ * WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT(DBR event) and
+ * WMI_PEER_CFR_CAPTURE_EVENT(Tx capture event).
+ * If both the events are received and PPDU id matches from both the
+ * events, return CORRELATE_STATUS_RELEASE which means relay the
+ * correlated data to user space. Otherwise return CORRELATE_STATUS_HOLD
+ * which means wait for the second event to come.
+ *
+ * It also check for the pending DBR events and clear those events
+ * in case of corresponding TX capture event is not received for
+ * the PPDU.
+ */
+
+static enum ath11k_cfr_correlate_status
+ath11k_cfr_correlate_and_relay(struct ath11k *ar,
+			       struct ath11k_look_up_table *lut,
+			       u8 event_type)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	enum ath11k_cfr_correlate_status status;
+	u64 diff;
+
+	if (event_type == ATH11K_CORRELATE_TX_EVENT) {
+		if (lut->tx_recv)
+			cfr->cfr_dma_aborts++;
+		cfr->tx_evt_cnt++;
+		lut->tx_recv = true;
+	} else if (event_type == ATH11K_CORRELATE_DBR_EVENT) {
+		cfr->dbr_evt_cnt++;
+		lut->dbr_recv = true;
+	}
+
+	if (lut->dbr_recv && lut->tx_recv) {
+		if (lut->dbr_ppdu_id == lut->tx_ppdu_id) {
+			/* We are using 64-bit counters here. So, it may take
+			 * several year to hit wraparound. Hence, not handling
+			 * the wraparound condition.
+			 */
+			cfr->last_success_tstamp = lut->dbr_tstamp;
+			if (lut->dbr_tstamp > lut->txrx_tstamp) {
+				diff = lut->dbr_tstamp - lut->txrx_tstamp;
+				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
+					   "txrx event -> dbr event delay = %u ms",
+					   jiffies_to_msecs(diff));
+			} else if (lut->txrx_tstamp > lut->dbr_tstamp) {
+				diff = lut->txrx_tstamp - lut->dbr_tstamp;
+				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
+					   "dbr event -> txrx event delay = %u ms",
+					   jiffies_to_msecs(diff));
+			}
+
+			ath11k_cfr_free_pending_dbr_events(ar);
+
+			cfr->release_cnt++;
+			status = ATH11K_CORRELATE_STATUS_RELEASE;
+		} else {
+			/* When there is a ppdu id mismatch, discard the TXRX
+			 * event since multiple PPDUs are likely to have same
+			 * dma addr, due to ucode aborts.
+			 */
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
+				   "Received dbr event twice for the same lut entry");
+			lut->tx_recv = false;
+			lut->tx_ppdu_id = 0;
+			cfr->clear_txrx_event++;
+			cfr->cfr_dma_aborts++;
+			status = ATH11K_CORRELATE_STATUS_HOLD;
+		}
+	} else {
+		status = ATH11K_CORRELATE_STATUS_HOLD;
+	}
+
+	return status;
+}
+
 static int ath11k_cfr_process_data(struct ath11k *ar,
 				   struct ath11k_dbring_data *param)
 {
-	return 0;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct ath11k_look_up_table *lut;
+	struct ath11k_csi_cfr_header *header;
+	struct ath11k_cfir_dma_hdr *dma_hdr;
+	u8 *data;
+	u32 end_magic = ATH11K_CFR_END_MAGIC;
+	u32 buf_id;
+	u32 tones;
+	u32 length;
+	int status;
+	u8 num_chains;
+
+	data = param->data;
+	buf_id = param->buf_id;
+
+	if (param->data_sz < sizeof(*dma_hdr))
+		return -EINVAL;
+
+	dma_hdr = (struct ath11k_cfir_dma_hdr *)data;
+
+	tones = cfr_calculate_tones_from_dma_hdr(dma_hdr);
+	if (tones == TONES_INVALID) {
+		ath11k_warn(ar->ab, "Number of tones received is invalid");
+		return -EINVAL;
+	}
+
+	num_chains = FIELD_GET(CFIR_DMA_HDR_INFO1_NUM_CHAINS,
+			       dma_hdr->info1);
+
+	length = sizeof(*dma_hdr);
+	length += tones * (num_chains + 1);
+
+	spin_lock_bh(&cfr->lut_lock);
+
+	if (!cfr->lut) {
+		spin_unlock_bh(&cfr->lut_lock);
+		return -EINVAL;
+	}
+
+	lut = &cfr->lut[buf_id];
+
+	ath11k_dbg_dump(ab, ATH11K_DBG_CFR_DUMP, "data_from_buf_rel:", "",
+			data, length);
+
+	lut->buff = param->buff;
+	lut->data = data;
+	lut->data_len = length;
+	lut->dbr_ppdu_id = dma_hdr->phy_ppdu_id;
+	lut->dbr_tstamp = jiffies;
+
+	memcpy(&lut->hdr, dma_hdr, sizeof(*dma_hdr));
+
+	header = &lut->header;
+	header->meta_data.channel_bw = FIELD_GET(CFIR_DMA_HDR_INFO1_UPLOAD_PKT_BW,
+						 dma_hdr->info1);
+	header->meta_data.length = length;
+
+	status = ath11k_cfr_correlate_and_relay(ar, lut,
+						ATH11K_CORRELATE_DBR_EVENT);
+	if (status == ATH11K_CORRELATE_STATUS_RELEASE) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "releasing CFR data to user space");
+		ath11k_cfr_rfs_write(ar, &lut->header,
+				     sizeof(struct ath11k_csi_cfr_header),
+				     lut->data, lut->data_len,
+				     &end_magic, sizeof(u32));
+		ath11k_cfr_release_lut_entry(lut);
+	} else if (status == ATH11K_CORRELATE_STATUS_HOLD) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "tx event is not yet received holding the buf");
+	}
+
+	spin_unlock_bh(&cfr->lut_lock);
+
+	return status;
 }
 
 /* Helper function to check whether the given peer mac address
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index e209dc0..7ea4bb8 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -13,6 +13,9 @@
 #define ATH11K_CFR_NUM_RESP_PER_EVENT   1
 #define ATH11K_CFR_EVENT_TIMEOUT_MS     1
 
+#define ATH11K_CORRELATE_TX_EVENT 1
+#define ATH11K_CORRELATE_DBR_EVENT 0
+
 #define ATH11K_MAX_CFR_ENABLED_CLIENTS 10
 #define CFR_MAX_LUT_ENTRIES 136
 
@@ -21,6 +24,70 @@
 struct ath11k_sta;
 struct ath11k_per_peer_cfr_capture;
 
+#define ATH11K_CFR_END_MAGIC 0xBEAFDEAD
+
+enum ath11k_cfr_correlate_status {
+	ATH11K_CORRELATE_STATUS_RELEASE,
+	ATH11K_CORRELATE_STATUS_HOLD,
+	ATH11K_CORRELATE_STATUS_ERR,
+};
+
+enum ath11k_cfr_preamble_type {
+	ATH11K_CFR_PREAMBLE_TYPE_LEGACY,
+	ATH11K_CFR_PREAMBLE_TYPE_HT,
+	ATH11K_CFR_PREAMBLE_TYPE_VHT,
+};
+
+struct cfr_metadata {
+	u8 peer_addr[ETH_ALEN];
+	u8 status;
+	u8 capture_bw;
+	u8 channel_bw;
+	u8 phy_mode;
+	u16 prim20_chan;
+	u16 center_freq1;
+	u16 center_freq2;
+	u8 capture_mode;
+	u8 capture_type;
+	u8 sts_count;
+	u8 num_rx_chain;
+	u32 timestamp;
+	u32 length;
+	u32 chain_rssi[HOST_MAX_CHAINS];
+	u16 chain_phase[HOST_MAX_CHAINS];
+	u32 cfo_measurement;
+	u8 agc_gain[HOST_MAX_CHAINS];
+	u32 rx_start_ts;
+} __packed;
+
+struct ath11k_csi_cfr_header {
+	u32 start_magic_num;
+	u32 vendorid;
+	u8 cfr_metadata_version;
+	u8 cfr_data_version;
+	u8 chip_type;
+	u8 platform_type;
+	u32 reserved;
+	struct cfr_metadata meta_data;
+} __packed;
+
+#define TONES_IN_20MHZ  256
+#define TONES_IN_40MHZ  512
+#define TONES_IN_80MHZ  1024
+#define TONES_IN_160MHZ 2048 /* 160 MHz isn't supported yet */
+#define TONES_INVALID   0
+
+#define CFIR_DMA_HDR_INFO0_TAG GENMASK(7, 0)
+#define CFIR_DMA_HDR_INFO0_LEN GENMASK(13, 8)
+
+#define CFIR_DMA_HDR_INFO1_UPLOAD_DONE	GENMASK(0, 0)
+#define CFIR_DMA_HDR_INFO1_CAPTURE_TYPE	GENMASK(3, 1)
+#define CFIR_DMA_HDR_INFO1_PREAMBLE_TYPE GENMASK(5, 4)
+#define CFIR_DMA_HDR_INFO1_NSS		GENMASK(8, 6)
+#define CFIR_DMA_HDR_INFO1_NUM_CHAINS	GENMASK(11, 9)
+#define CFIR_DMA_HDR_INFO1_UPLOAD_PKT_BW GENMASK(14, 12)
+#define CFIR_DMA_HDR_INFO1_SW_PEER_ID_VALID GENMASK(15, 15)
+
 struct ath11k_cfir_dma_hdr {
 	u16 info0;
 	u16 info1;
@@ -38,6 +105,7 @@ struct ath11k_look_up_table {
 	dma_addr_t dbr_address;
 	u32 tx_address1;
 	u32 tx_address2;
+	struct ath11k_csi_cfr_header header;
 	struct ath11k_cfir_dma_hdr hdr;
 	u64 txrx_tstamp;
 	u64 dbr_tstamp;
@@ -113,6 +181,8 @@ int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 					 struct ath11k_sta *arsta,
 					 struct ath11k_per_peer_cfr_capture *params,
 					 const u8 *peer_mac);
+struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar);
+void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut);
 
 #else
 static inline int ath11k_cfr_init(struct ath11k_base *ab)
@@ -160,5 +230,15 @@ ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 {
 	return 0;
 }
+
+static inline void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut)
+{
+}
+
+static inline
+struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar)
+{
+	return NULL;
+}
 #endif /* CONFIG_ATH11K_CFR */
 #endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 1dea4a5..bcfdd0f 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -282,6 +282,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	int size;
 	dma_addr_t paddr;
 	int ret = 0;
+	int status;
 
 	pdev_idx = ev->fixed.pdev_id;
 	module_id = ev->fixed.module_id;
@@ -311,6 +312,9 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	case WMI_DIRECT_BUF_SPECTRAL:
 		ring = ath11k_spectral_get_dbring(ar);
 		break;
+	case WMI_DIRECT_BUF_CFR:
+		ring = ath11k_cfr_get_dbring(ar);
+		break;
 	default:
 		ring = NULL;
 		ath11k_warn(ab, "Recv dma buffer release ev on unsupp module %d\n",
@@ -358,8 +362,12 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 			handler_data.data = PTR_ALIGN(vaddr_unalign,
 						      ring->buf_align);
 			handler_data.data_sz = ring->buf_sz;
+			handler_data.buff = buff;
+			handler_data.buf_id = buf_id;
 
-			ring->handler(ar, &handler_data);
+			status = ring->handler(ar, &handler_data);
+			if (status == ATH11K_CORRELATE_STATUS_HOLD)
+				continue;
 		}
 
 		buff->paddr = 0;
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
index 0c3683a..cd7d647 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.h
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -21,6 +21,8 @@ struct ath11k_dbring_data {
 	void *data;
 	u32 data_sz;
 	struct wmi_dma_buf_release_meta_data meta;
+	struct ath11k_dbring_element *buff;
+	u32 buf_id;
 };
 
 struct ath11k_dbring_buf_release_event {
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index fbbd5fe..e03b0b3 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -25,6 +25,8 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_PCI		= 0x00001000,
 	ATH11K_DBG_DP_TX	= 0x00001000,
 	ATH11K_DBG_DP_RX	= 0x00002000,
+	ATH11K_DBG_CFR		= 0x00004000,
+	ATH11K_DBG_CFR_DUMP	= 0x00008000,
 	ATH11K_DBG_ANY		= 0xffffffff,
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 3fe195f..15357a0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3377,7 +3377,7 @@ struct wmi_peer_cfr_capture_cmd_fixed_param {
 #define WMI_PEER_CFR_CAPTURE_DISABLE  0
 
 /*periodicity in ms */
-#define WMI_PEER_CFR_PERIODICITY_MAX  (10 * 60 * 1000)
+#define WMI_PEER_CFR_PERIODICITY_MAX  600000
 
 struct wmi_start_scan_arg {
 	u32 scan_id;
-- 
2.7.4

