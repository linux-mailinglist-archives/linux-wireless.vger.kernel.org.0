Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3404B8525
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiBPKGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 05:06:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiBPKGD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 05:06:03 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6B2B73C2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 02:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645005947; x=1676541947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZhlDeYh9XmDb3G7LXTnryFi07D13Y10oOAbzcYk2We8=;
  b=m2ZhBHC/SzDEC/gjQQ42Wux6s6nzPXmchrFoMaaU2v841pmTFrUVLa7S
   KLX8bgucPxTgpN1GBmqH0jVwK91QqmPOOLSsunMWPM3LAN7ZLE8DkFjXP
   PMQMRr/dBX3O9MTYZkNdU3TcO1md03cFWBaVdt4WXTNYi4hdGV8Miv2OQ
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 16 Feb 2022 02:05:46 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 02:05:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 02:05:45 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 02:05:44 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCHv2 6/6] ath11k: Register handler for CFR capture event
Date:   Wed, 16 Feb 2022 15:35:22 +0530
Message-ID: <1645005922-7252-7-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com>
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

Firmware sends CFR meta data through the WMI event
WMI_PEER_CFR_CAPTURE_EVENT. Parse the meta data coming from the
firmware and invoke correlate_and_relay function to correlate the
CFR meta data with the CFR payload coming from the other WMI event
WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT.

Release the buffer to user space once correlate and relay return
success.

Tested-on: IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 152 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  62 +++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.c |  90 ++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  44 ++++++++++
 4 files changed, 347 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index b7dd7d3..8f98477 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -248,6 +248,158 @@ static int ath11k_cfr_process_data(struct ath11k *ar,
 	return status;
 }
 
+static void ath11k_cfr_fill_hdr_info(struct ath11k *ar,
+				     struct ath11k_csi_cfr_header *header,
+				     struct ath11k_cfr_peer_tx_param *params)
+{
+	header->cfr_metadata_version = ATH11K_CFR_META_VERSION_4;
+	header->cfr_data_version = ATH11K_CFR_DATA_VERSION_1;
+	header->cfr_metadata_len = sizeof(struct cfr_metadata);
+	header->chip_type = ar->ab->hw_rev;
+	header->meta_data.status = FIELD_GET(WMI_CFR_PEER_CAPTURE_STATUS,
+					     params->status);
+	header->meta_data.capture_bw = params->bandwidth;
+	header->meta_data.phy_mode = params->phy_mode;
+	header->meta_data.prim20_chan = params->primary_20mhz_chan;
+	header->meta_data.center_freq1 = params->band_center_freq1;
+	header->meta_data.center_freq2 = params->band_center_freq2;
+
+	/* Currently CFR data is captured on ACK of a Qos NULL frame.
+	 * For 20 MHz, ACK is Legacy and for 40/80/160, ACK is DUP Legacy.
+	 */
+	header->meta_data.capture_mode = params->bandwidth ?
+		ATH11K_CFR_CAPTURE_DUP_LEGACY_ACK : ATH11K_CFR_CAPTURE_LEGACY_ACK;
+	header->meta_data.capture_type = params->capture_method;
+	header->meta_data.num_rx_chain = ar->num_rx_chains;
+	header->meta_data.sts_count = params->spatial_streams;
+	header->meta_data.timestamp = params->timestamp_us;
+	ether_addr_copy(header->meta_data.peer_addr, params->peer_mac_addr);
+	memcpy(header->meta_data.chain_rssi, params->chain_rssi,
+	       sizeof(params->chain_rssi));
+	memcpy(header->meta_data.chain_phase, params->chain_phase,
+	       sizeof(params->chain_phase));
+	memcpy(header->meta_data.agc_gain, params->agc_gain,
+	       sizeof(params->agc_gain));
+}
+
+int ath11k_process_cfr_capture_event(struct ath11k_base *ab,
+				     struct ath11k_cfr_peer_tx_param *params)
+{
+	struct ath11k *ar;
+	struct ath11k_cfr *cfr;
+	struct ath11k_vif *arvif;
+	struct ath11k_look_up_table *lut = NULL;
+	struct ath11k_dbring_element *buff;
+	struct ath11k_csi_cfr_header *header;
+	dma_addr_t buf_addr;
+	u32 end_magic = ATH11K_CFR_END_MAGIC;
+	u8 tx_status;
+	int status;
+	int i;
+
+	rcu_read_lock();
+	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, params->vdev_id);
+	if (!arvif) {
+		rcu_read_unlock();
+		ath11k_warn(ab, "Failed to get arvif for vdev id %d\n",
+			    params->vdev_id);
+		return -ENOENT;
+	}
+
+	ar = arvif->ar;
+	cfr = &ar->cfr;
+	rcu_read_unlock();
+
+	if (WMI_CFR_CAPTURE_STATUS_PEER_PS & params->status) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "CFR capture failed as peer %pM is in powersave",
+			   params->peer_mac_addr);
+		return -EINVAL;
+	}
+
+	if (!(WMI_CFR_PEER_CAPTURE_STATUS & params->status)) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "CFR capture failed for the peer : %pM",
+			   params->peer_mac_addr);
+		cfr->tx_peer_status_cfr_fail++;
+		return -EINVAL;
+	}
+
+	tx_status = FIELD_GET(WMI_CFR_FRAME_TX_STATUS, params->status);
+
+	if (tx_status != WMI_FRAME_TX_STATUS_OK) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "WMI tx status %d for the peer %pM",
+			   tx_status, params->peer_mac_addr);
+		cfr->tx_evt_status_cfr_fail++;
+		return -EINVAL;
+	}
+
+	buf_addr = (((u64)FIELD_GET(WMI_CFR_CORRELATION_INFO2_BUF_ADDR_HIGH,
+				    params->correlation_info_2)) << 32) |
+		   params->correlation_info_1;
+
+	spin_lock_bh(&cfr->lut_lock);
+
+	if (!cfr->lut) {
+		spin_unlock_bh(&cfr->lut_lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < cfr->lut_num; i++) {
+		struct ath11k_look_up_table *temp = &cfr->lut[i];
+
+		if (temp->dbr_address == buf_addr) {
+			lut = &cfr->lut[i];
+			break;
+		}
+	}
+
+	if (!lut) {
+		spin_unlock_bh(&cfr->lut_lock);
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "lut failure to process tx event\n");
+		cfr->tx_dbr_lookup_fail++;
+		return -EINVAL;
+	}
+
+	lut->tx_ppdu_id = FIELD_GET(WMI_CFR_CORRELATION_INFO2_PPDU_ID,
+				    params->correlation_info_2);
+	lut->tx_address1 = params->correlation_info_1;
+	lut->tx_address2 = params->correlation_info_2;
+	lut->txrx_tstamp = jiffies;
+
+	header = &lut->header;
+	header->start_magic_num = ATH11K_CFR_START_MAGIC;
+	header->vendorid = VENDOR_QCA;
+	header->platform_type = PLATFORM_TYPE_ARM;
+
+	ath11k_cfr_fill_hdr_info(ar, header, params);
+
+	status = ath11k_cfr_correlate_and_relay(ar, lut,
+						ATH11K_CORRELATE_TX_EVENT);
+	if (status == ATH11K_CORRELATE_STATUS_RELEASE) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "Releasing CFR data to user space");
+		ath11k_cfr_rfs_write(ar, &lut->header,
+				     sizeof(struct ath11k_csi_cfr_header),
+				     lut->data, lut->data_len,
+				     &end_magic, sizeof(u32));
+		buff = lut->buff;
+		ath11k_cfr_release_lut_entry(lut);
+
+		ath11k_dbring_bufs_replenish(ar, &cfr->rx_ring, buff,
+					     WMI_DIRECT_BUF_CFR);
+	} else if (status == ATH11K_CORRELATE_STATUS_HOLD) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "dbr event is not yet received holding buf\n");
+	}
+
+	spin_unlock_bh(&cfr->lut_lock);
+
+	return 0;
+}
+
 /* Helper function to check whether the given peer mac address
  * is in unassociated peer pool or not.
  */
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index 7ea4bb8..ca45632 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -24,8 +24,37 @@
 struct ath11k_sta;
 struct ath11k_per_peer_cfr_capture;
 
+#define ATH11K_CFR_START_MAGIC 0xDEADBEAF
 #define ATH11K_CFR_END_MAGIC 0xBEAFDEAD
 
+#define VENDOR_QCA 0x8cfdf0
+#define PLATFORM_TYPE_ARM 2
+
+enum ath11k_cfr_meta_version {
+	ATH11K_CFR_META_VERSION_NONE,
+	ATH11K_CFR_META_VERSION_1,
+	ATH11K_CFR_META_VERSION_2,
+	ATH11K_CFR_META_VERSION_3,
+	ATH11K_CFR_META_VERSION_4,
+	ATH11K_CFR_META_VERSION_MAX = 0xFF,
+};
+
+enum ath11k_cfr_data_version {
+	ATH11K_CFR_DATA_VERSION_NONE,
+	ATH11K_CFR_DATA_VERSION_1,
+	ATH11K_CFR_DATA_VERSION_MAX = 0xFF,
+};
+
+enum ath11k_cfr_capture_ack_mode {
+	ATH11K_CFR_CAPTURE_LEGACY_ACK,
+	ATH11K_CFR_CAPTURE_DUP_LEGACY_ACK,
+	ATH11K_CFR_CAPTURE_HT_ACK,
+	ATH11K_CFR_CAPTURE_VHT_ACK,
+
+	/*Always keep this at last*/
+	ATH11K_CFR_CAPTURE_INVALID_ACK
+};
+
 enum ath11k_cfr_correlate_status {
 	ATH11K_CORRELATE_STATUS_RELEASE,
 	ATH11K_CORRELATE_STATUS_HOLD,
@@ -38,6 +67,28 @@ enum ath11k_cfr_preamble_type {
 	ATH11K_CFR_PREAMBLE_TYPE_VHT,
 };
 
+struct ath11k_cfr_peer_tx_param {
+	u32 capture_method;
+	u32 vdev_id;
+	u8 peer_mac_addr[ETH_ALEN];
+	u32 primary_20mhz_chan;
+	u32 bandwidth;
+	u32 phy_mode;
+	u32 band_center_freq1;
+	u32 band_center_freq2;
+	u32 spatial_streams;
+	u32 correlation_info_1;
+	u32 correlation_info_2;
+	u32 status;
+	u32 timestamp_us;
+	u32 counter;
+	u32 chain_rssi[WMI_MAX_CHAINS];
+	u16 chain_phase[WMI_MAX_CHAINS];
+	u32 cfo_measurement;
+	u8 agc_gain[HOST_MAX_CHAINS];
+	u32 rx_start_ts;
+};
+
 struct cfr_metadata {
 	u8 peer_addr[ETH_ALEN];
 	u8 status;
@@ -67,7 +118,7 @@ struct ath11k_csi_cfr_header {
 	u8 cfr_data_version;
 	u8 chip_type;
 	u8 platform_type;
-	u32 reserved;
+	u32 cfr_metadata_len;
 	struct cfr_metadata meta_data;
 } __packed;
 
@@ -183,6 +234,8 @@ int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 					 const u8 *peer_mac);
 struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar);
 void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut);
+int ath11k_process_cfr_capture_event(struct ath11k_base *ab,
+				     struct ath11k_cfr_peer_tx_param *params);
 
 #else
 static inline int ath11k_cfr_init(struct ath11k_base *ab)
@@ -240,5 +293,12 @@ struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar)
 {
 	return NULL;
 }
+
+static inline
+int ath11k_process_cfr_capture_event(struct ath11k_base *ab,
+				     struct ath11k_cfr_peer_tx_param *params)
+{
+	return 0;
+}
 #endif /* CONFIG_ATH11K_CFR */
 #endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index f945d45..e273db2 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7819,6 +7819,93 @@ static void ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab,
 	kfree(tb);
 }
 
+static void ath11k_wmi_tlv_cfr_capture_event_fixed_param(const void *ptr,
+							 void *data)
+{
+	struct ath11k_cfr_peer_tx_param *tx_params = data;
+	const struct ath11k_wmi_cfr_peer_tx_event_param *params = ptr;
+
+	tx_params->capture_method = params->capture_method;
+	tx_params->vdev_id = params->vdev_id;
+	ether_addr_copy(tx_params->peer_mac_addr, params->mac_addr.addr);
+	tx_params->primary_20mhz_chan = params->chan_mhz;
+	tx_params->bandwidth = params->bandwidth;
+	tx_params->phy_mode = params->phy_mode;
+	tx_params->band_center_freq1 = params->band_center_freq1;
+	tx_params->band_center_freq2 = params->band_center_freq2;
+	tx_params->spatial_streams = params->sts_count;
+	tx_params->correlation_info_1 = params->correlation_info_1;
+	tx_params->correlation_info_2 = params->correlation_info_2;
+	tx_params->status = params->status;
+	tx_params->timestamp_us = params->timestamp_us;
+	tx_params->counter = params->counter;
+	tx_params->rx_start_ts = params->rx_start_ts;
+
+	memcpy(tx_params->chain_rssi, params->chain_rssi,
+	       sizeof(tx_params->chain_rssi));
+
+	if (WMI_CFR_CFO_MEASUREMENT_VALID & params->cfo_measurement)
+		tx_params->cfo_measurement = FIELD_GET(WMI_CFR_CFO_MEASUREMENT_RAW_DATA,
+						       params->cfo_measurement);
+}
+
+static void ath11k_wmi_tlv_cfr_capture_phase_fixed_param(const void *ptr,
+							 void *data)
+{
+	struct ath11k_cfr_peer_tx_param *tx_params = data;
+	const struct ath11k_wmi_cfr_peer_tx_event_phase_param *params = ptr;
+	int i;
+
+	for (i = 0; i < WMI_MAX_CHAINS; i++) {
+		tx_params->chain_phase[i] = params->chain_phase[i];
+		tx_params->agc_gain[i] = params->agc_gain[i];
+	}
+}
+
+static int ath11k_wmi_tlv_cfr_capture_evt_parse(struct ath11k_base *ab,
+						u16 tag, u16 len,
+						const void *ptr, void *data)
+{
+	switch (tag) {
+	case WMI_TAG_PEER_CFR_CAPTURE_EVENT:
+		ath11k_wmi_tlv_cfr_capture_event_fixed_param(ptr, data);
+		break;
+	case WMI_TAG_CFR_CAPTURE_PHASE_PARAM:
+		ath11k_wmi_tlv_cfr_capture_phase_fixed_param(ptr, data);
+		break;
+	default:
+		ath11k_warn(ab, "Invalid tag received tag %d len %d\n",
+			    tag, len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void ath11k_wmi_parse_cfr_capture_event(struct ath11k_base *ab,
+					       struct sk_buff *skb)
+{
+	struct ath11k_cfr_peer_tx_param params = {};
+	int ret;
+
+	ath11k_dbg_dump(ab, ATH11K_DBG_CFR_DUMP, "cfr_dump:", "",
+			skb->data, skb->len);
+
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tlv_cfr_capture_evt_parse,
+				  &params);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse cfr capture event tlv %d\n",
+			    ret);
+		return;
+	}
+
+	ret = ath11k_process_cfr_capture_event(ab, &params);
+	if (ret)
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "failed to process cfr capture ret = %d\n", ret);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -7950,6 +8037,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_DIAG_EVENTID:
 		ath11k_wmi_diag_event(ab, skb);
 		break;
+	case WMI_PEER_CFR_CAPTURE_EVENTID:
+		ath11k_wmi_parse_cfr_capture_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 15357a0..1e22052 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1857,6 +1857,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_NDP_EVENT,
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_CMD = 0x301,
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_INFO,
+	WMI_TAG_PEER_CFR_CAPTURE_EVENT = 0x317,
+	WMI_TAG_CFR_CAPTURE_PHASE_PARAM = 0x33b,
 	WMI_TAG_FILS_DISCOVERY_TMPL_CMD = 0x344,
 	WMI_TAG_PDEV_SRG_BSS_COLOR_BITMAP_CMD = 0x37b,
 	WMI_TAG_PDEV_SRG_PARTIAL_BSSID_BITMAP_CMD,
@@ -3354,6 +3356,48 @@ enum ath11k_wmi_cfr_capture_method {
 	WMI_CFR_CAPTURE_METHOD_MAX,
 };
 
+#define WMI_CFR_FRAME_TX_STATUS GENMASK(1, 0)
+#define WMI_CFR_CAPTURE_STATUS_PEER_PS BIT(30)
+#define WMI_CFR_PEER_CAPTURE_STATUS BIT(31)
+
+#define WMI_CFR_CORRELATION_INFO2_BUF_ADDR_HIGH GENMASK(3, 0)
+#define WMI_CFR_CORRELATION_INFO2_PPDU_ID GENMASK(31, 16)
+
+#define WMI_CFR_CFO_MEASUREMENT_VALID BIT(0)
+#define WMI_CFR_CFO_MEASUREMENT_RAW_DATA GENMASK(14, 1)
+
+struct ath11k_wmi_cfr_peer_tx_event_param {
+	u32 capture_method;
+	u32 vdev_id;
+	struct wmi_mac_addr mac_addr;
+	u32 chan_mhz;
+	u32 bandwidth;
+	u32 phy_mode;
+	u32 band_center_freq1;
+	u32 band_center_freq2;
+	u32 sts_count;
+	u32 correlation_info_1;
+	u32 correlation_info_2;
+	u32 status;
+	u32 timestamp_us;
+	u32 counter;
+	u32 chain_rssi[WMI_MAX_CHAINS];
+	u32 cfo_measurement;
+	u32 rx_start_ts;
+} __packed;
+
+struct ath11k_wmi_cfr_peer_tx_event_phase_param {
+	u32 chain_phase[WMI_MAX_CHAINS];
+	u8 agc_gain[WMI_MAX_CHAINS];
+} __packed;
+
+enum ath11k_wmi_frame_tx_status {
+	WMI_FRAME_TX_STATUS_OK,
+	WMI_FRAME_TX_STATUS_XRETRY,
+	WMI_FRAME_TX_STATUS_DROP,
+	WMI_FRAME_TX_STATUS_FILTERED,
+};
+
 struct wmi_peer_cfr_capture_conf_arg {
 	enum ath11k_wmi_cfr_capture_bw bw;
 	enum ath11k_wmi_cfr_capture_method method;
-- 
2.7.4

