Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2077DC271
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjJ3W2B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjJ3W2A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:28:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58DDD
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMO69G024334;
        Mon, 30 Oct 2023 22:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7tK/o1+TXZ14SkMStTyCo99ms1jWhIc0CiWyDdIBa38=;
 b=BBlGdifmxWpd59IIkhQPvydHHTQj+MZTPBT0Rxto0sCBQNFVpcGifuUypwcM955bewM9
 3pmSLRij0DxihEOS1wH84CBnzy9vH+IEbLAbKFbzyGqorxx00+N+VCzfgdKN3CjEUXaH
 iyWGTJV8dCQBZtuxuqbb86t/dbqVPkwRUzjM1e87yumI6qEqQpQrz4jdI5m5CFYlbAdY
 zFvgxKE4pBqtIPmTY/RZajw/UKGQAzP1acegNo7DeuIkJTXkrZwEtcnyj0roL9O9DUok
 uKluzyobaEF3obSfSEr07935fvPe6FG5dcUqURXzBPrG+3yJfMHJ5CEpxqJrMNTHJpEf 6Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2b2qsjcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRoUU020745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:50 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:48 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 08/13] wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
Date:   Tue, 31 Oct 2023 03:56:55 +0530
Message-ID: <20231030222700.18914-9-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JGApF0j9LDY0_zWgEV6Gs_gbi_mk2a81
X-Proofpoint-ORIG-GUID: JGApF0j9LDY0_zWgEV6Gs_gbi_mk2a81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With word mask subscription support, the rx_desc structure will
change. The fields in this structure rx_desc will be reduced to only
the required fields. To make word mask subscription changes compatible
with the older firmware version (firmware that does not support word
mask subscription), two different structures of rx_desc will be
required for the same hardware.

Most of the hal_ops are directly related to rx_desc.

Hence, split hal_ops into operations that are independent of rx_desc
(hal_ops) and the operations that are directly dependent on rx_desc
(hal_rx_ops). These hal_rx_ops depend on both hardware and firmware
hence move them out of hw_params.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   |  2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c |  3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 73 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal.c    | 18 ++++--
 drivers/net/wireless/ath/ath12k/hal.h    | 10 +++-
 drivers/net/wireless/ath/ath12k/pci.c    |  2 +
 6 files changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8f5ead445..9243ba460 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -792,6 +792,8 @@ struct ath12k_base {
 	/* true means radio is on */
 	bool rfkill_radio_on;
 
+	const struct hal_rx_ops *hal_rx_ops;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f44bc5494..90dffd7df 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -917,7 +917,8 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		u8 qos_pkt = 0;
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
-		hdr_desc = ab->hw_params->hal_ops->rx_desc_get_msdu_payload(rx_desc);
+		hdr_desc =
+			ab->hal_rx_ops->rx_desc_get_msdu_payload(rx_desc);
 
 		/* Base size */
 		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 3543fadac..581316ffa 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -23,34 +23,34 @@
 static enum hal_encrypt_type ath12k_dp_rx_h_enctype(struct ath12k_base *ab,
 						    struct hal_rx_desc *desc)
 {
-	if (!ab->hw_params->hal_ops->rx_desc_encrypt_valid(desc))
+	if (!ab->hal_rx_ops->rx_desc_encrypt_valid(desc))
 		return HAL_ENCRYPT_TYPE_OPEN;
 
-	return ab->hw_params->hal_ops->rx_desc_get_encrypt_type(desc);
+	return ab->hal_rx_ops->rx_desc_get_encrypt_type(desc);
 }
 
 u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_decap_type(desc);
+	return ab->hal_rx_ops->rx_desc_get_decap_type(desc);
 }
 
 static u8 ath12k_dp_rx_h_mesh_ctl_present(struct ath12k_base *ab,
 					  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mesh_ctl(desc);
+	return ab->hal_rx_ops->rx_desc_get_mesh_ctl(desc);
 }
 
 static bool ath12k_dp_rx_h_seq_ctrl_valid(struct ath12k_base *ab,
 					  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_seq_ctl_vld(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_seq_ctl_vld(desc);
 }
 
 static bool ath12k_dp_rx_h_fc_valid(struct ath12k_base *ab,
 				    struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_fc_valid(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_fc_valid(desc);
 }
 
 static bool ath12k_dp_rx_h_more_frags(struct ath12k_base *ab,
@@ -74,149 +74,149 @@ static u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
 static u16 ath12k_dp_rx_h_seq_no(struct ath12k_base *ab,
 				 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_start_seq_no(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_start_seq_no(desc);
 }
 
 static bool ath12k_dp_rx_h_msdu_done(struct ath12k_base *ab,
 				     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_msdu_done(desc);
+	return ab->hal_rx_ops->dp_rx_h_msdu_done(desc);
 }
 
 static bool ath12k_dp_rx_h_l4_cksum_fail(struct ath12k_base *ab,
 					 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_l4_cksum_fail(desc);
+	return ab->hal_rx_ops->dp_rx_h_l4_cksum_fail(desc);
 }
 
 static bool ath12k_dp_rx_h_ip_cksum_fail(struct ath12k_base *ab,
 					 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_ip_cksum_fail(desc);
+	return ab->hal_rx_ops->dp_rx_h_ip_cksum_fail(desc);
 }
 
 static bool ath12k_dp_rx_h_is_decrypted(struct ath12k_base *ab,
 					struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_is_decrypted(desc);
+	return ab->hal_rx_ops->dp_rx_h_is_decrypted(desc);
 }
 
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_mpdu_err(desc);
+	return ab->hal_rx_ops->dp_rx_h_mpdu_err(desc);
 }
 
 static u16 ath12k_dp_rx_h_msdu_len(struct ath12k_base *ab,
 				   struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_len(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_len(desc);
 }
 
 static u8 ath12k_dp_rx_h_sgi(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_sgi(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_sgi(desc);
 }
 
 static u8 ath12k_dp_rx_h_rate_mcs(struct ath12k_base *ab,
 				  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_rate_mcs(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_rate_mcs(desc);
 }
 
 static u8 ath12k_dp_rx_h_rx_bw(struct ath12k_base *ab,
 			       struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_rx_bw(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_rx_bw(desc);
 }
 
 static u32 ath12k_dp_rx_h_freq(struct ath12k_base *ab,
 			       struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_freq(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_freq(desc);
 }
 
 static u8 ath12k_dp_rx_h_pkt_type(struct ath12k_base *ab,
 				  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_pkt_type(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_pkt_type(desc);
 }
 
 static u8 ath12k_dp_rx_h_nss(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return hweight8(ab->hw_params->hal_ops->rx_desc_get_msdu_nss(desc));
+	return hweight8(ab->hal_rx_ops->rx_desc_get_msdu_nss(desc));
 }
 
 static u8 ath12k_dp_rx_h_tid(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_tid(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_tid(desc);
 }
 
 static u16 ath12k_dp_rx_h_peer_id(struct ath12k_base *ab,
 				  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_peer_id(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_peer_id(desc);
 }
 
 u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 			struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_l3_pad_bytes(desc);
+	return ab->hal_rx_ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
 static bool ath12k_dp_rx_h_first_msdu(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_first_msdu(desc);
+	return ab->hal_rx_ops->rx_desc_get_first_msdu(desc);
 }
 
 static bool ath12k_dp_rx_h_last_msdu(struct ath12k_base *ab,
 				     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_last_msdu(desc);
+	return ab->hal_rx_ops->rx_desc_get_last_msdu(desc);
 }
 
 static void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
 					   struct hal_rx_desc *fdesc,
 					   struct hal_rx_desc *ldesc)
 {
-	ab->hw_params->hal_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
+	ab->hal_rx_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
 }
 
 static void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 					  struct hal_rx_desc *desc,
 					  u16 len)
 {
-	ab->hw_params->hal_ops->rx_desc_set_msdu_len(desc, len);
+	ab->hal_rx_ops->rx_desc_set_msdu_len(desc, len);
 }
 
 static bool ath12k_dp_rx_h_is_da_mcbc(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
 	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
-		ab->hw_params->hal_ops->rx_desc_is_da_mcbc(desc));
+		ab->hal_rx_ops->rx_desc_is_da_mcbc(desc));
 }
 
 static bool ath12k_dp_rxdesc_mac_addr2_valid(struct ath12k_base *ab,
 					     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_mac_addr2_valid(desc);
+	return ab->hal_rx_ops->rx_desc_mac_addr2_valid(desc);
 }
 
 static u8 *ath12k_dp_rxdesc_get_mpdu_start_addr2(struct ath12k_base *ab,
 						 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_mpdu_start_addr2(desc);
+	return ab->hal_rx_ops->rx_desc_mpdu_start_addr2(desc);
 }
 
 static void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
 					    struct hal_rx_desc *desc,
 					    struct ieee80211_hdr *hdr)
 {
-	ab->hw_params->hal_ops->rx_desc_get_dot11_hdr(desc, hdr);
+	ab->hal_rx_ops->rx_desc_get_dot11_hdr(desc, hdr);
 }
 
 static void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
@@ -224,13 +224,14 @@ static void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
 						u8 *crypto_hdr,
 						enum hal_encrypt_type enctype)
 {
-	ab->hw_params->hal_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
+	ab->hal_rx_ops->rx_desc_get_crypto_header(desc, crypto_hdr,
+								  enctype);
 }
 
 static u16 ath12k_dp_rxdesc_get_mpdu_frame_ctrl(struct ath12k_base *ab,
 						struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_frame_ctl(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_frame_ctl(desc);
 }
 
 static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
@@ -3959,9 +3960,9 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
 
 	tlv_filter.rx_mpdu_start_offset =
-			ab->hw_params->hal_ops->rx_desc_get_mpdu_start_offset();
+		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
 	tlv_filter.rx_msdu_end_offset =
-		ab->hw_params->hal_ops->rx_desc_get_msdu_end_offset();
+		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
 
 	/* TODO: Selectively subscribe to required qwords within msdu_end
 	 * and mpdu_start and setup the mask in below msg
@@ -3997,9 +3998,9 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	tlv_filter.rx_header_offset = offsetof(struct hal_rx_desc_wcn7850, pkt_hdr_tlv);
 
 	tlv_filter.rx_mpdu_start_offset =
-			ab->hw_params->hal_ops->rx_desc_get_mpdu_start_offset();
+		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
 	tlv_filter.rx_msdu_end_offset =
-		ab->hw_params->hal_ops->rx_desc_get_msdu_end_offset();
+		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
 
 	/* TODO: Selectively subscribe to required qwords within msdu_end
 	 * and mpdu_start and setup the mask in below msg
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index e3b06a5ff..4dbe5f8bb 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -680,7 +680,7 @@ static u32 ath12k_hw_qcn9274_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
-const struct hal_ops hal_qcn9274_ops = {
+const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_rx_desc_get_last_msdu,
 	.rx_desc_get_l3_pad_bytes = ath12k_hw_qcn9274_rx_desc_get_l3_pad_bytes,
@@ -712,8 +712,6 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl,
-	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
-	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
 	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_ip_cksum_fail,
@@ -721,6 +719,11 @@ const struct hal_ops hal_qcn9274_ops = {
 	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_dp_rx_h_mpdu_err,
 };
 
+const struct hal_ops hal_qcn9274_ops = {
+	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
+	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
+};
+
 static bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
@@ -1134,7 +1137,7 @@ static u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
-const struct hal_ops hal_wcn7850_ops = {
+const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_wcn7850_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_wcn7850_rx_desc_get_last_msdu,
 	.rx_desc_get_l3_pad_bytes = ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes,
@@ -1167,8 +1170,6 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_get_dot11_hdr = ath12k_hw_wcn7850_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_wcn7850_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl,
-	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
-	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
 	.dp_rx_h_msdu_done = ath12k_hw_wcn7850_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail,
@@ -1176,6 +1177,11 @@ const struct hal_ops hal_wcn7850_ops = {
 	.dp_rx_h_mpdu_err = ath12k_hw_wcn7850_dp_rx_h_mpdu_err,
 };
 
+const struct hal_ops hal_wcn7850_ops = {
+	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
+	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
+};
+
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 66035a787..a989ea121 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1031,7 +1031,7 @@ struct ath12k_hal_tcl_to_wbm_rbm_map  {
 	u8 rbm_id;
 };
 
-struct hal_ops {
+struct hal_rx_ops {
 	bool (*rx_desc_get_first_msdu)(struct hal_rx_desc *desc);
 	bool (*rx_desc_get_last_msdu)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
@@ -1070,18 +1070,24 @@ struct hal_ops {
 	void (*rx_desc_get_crypto_header)(struct hal_rx_desc *desc,
 					  u8 *crypto_hdr,
 					  enum hal_encrypt_type enctype);
-	int (*create_srng_config)(struct ath12k_base *ab);
 	bool (*dp_rx_h_msdu_done)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_l4_cksum_fail)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_ip_cksum_fail)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_is_decrypted)(struct hal_rx_desc *desc);
 	u32 (*dp_rx_h_mpdu_err)(struct hal_rx_desc *desc);
+};
+
+struct hal_ops {
+	int (*create_srng_config)(struct ath12k_base *ab);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 };
 
 extern const struct hal_ops hal_qcn9274_ops;
 extern const struct hal_ops hal_wcn7850_ops;
 
+extern const struct hal_rx_ops hal_rx_qcn9274_ops;
+extern const struct hal_rx_ops hal_rx_wcn7850_ops;
+
 u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 				int tid, u32 ba_window_size,
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 9567251d1..3d77abd2d 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1242,6 +1242,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = true;
 		ab_pci->pci_ops = &ath12k_pci_ops_qcn9274;
+		ab->hal_rx_ops = &hal_rx_qcn9274_ops;
 		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
@@ -1263,6 +1264,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = false;
 		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
+		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
 		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
-- 
2.17.1

