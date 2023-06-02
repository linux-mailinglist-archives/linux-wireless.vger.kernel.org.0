Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC83720C73
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjFBX6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 19:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjFBX6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 19:58:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B6E49
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 16:58:42 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352NwdV7017578;
        Fri, 2 Jun 2023 23:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=HKFNgguN6XFqxKWKiDZw+KNOjqx2xX7N6hxkiuSj1os=;
 b=C7Djq4ofBbF+hl+WHpmBkr7RyWjGRzV6m/Jrq7wQ8GcohwbjKCrAGV/ze1YUR7omBAUu
 qcJrF1uNx0it2bp2uuSoWahCtNc/2Jk34RQcFZCA2/JpPpmFZecvIcDYGU3h0z8d+aOK
 QuSTQweB077VJ4Cz64UIwG7Xj4f/iHpsHt/zem8cZ5gxZ6QuRp5i3l+b1IaLHVZgZtp+
 VVhxTSlLi3aEwYI7CkkM31GJ5Y9062q5HAO7Jw+zcSJWoH3nHcUDP577YrZ2XhKr1WFr
 whQd6q+A+PT3TelIuRROfeVuwDKGE0j+bvC8o5WvncbwQQTKk+78NkeRGdMDfV9yq9Vm rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qydr5hq13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 23:58:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352NwcMv022988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 23:58:38 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 16:58:37 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH v4 07/11] wifi: ath12k: add WMI support for EHT peer
Date:   Fri, 2 Jun 2023 16:58:16 -0700
Message-ID: <20230602235820.23912-8-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230602235820.23912-1-quic_alokad@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vAEdctyytCvFU_39mEbQv7bmIxziH2Ri
X-Proofpoint-GUID: vAEdctyytCvFU_39mEbQv7bmIxziH2Ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_18,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new WMI tag and pass the EHT parameters for peer association
to firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
v4: No change from v3.
v3: No change from v2.
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/wmi.c | 40 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h | 20 ++++++++++++++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7b82e7240594..358aac5802bc 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1801,6 +1801,7 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 				       bool hw_crypto_disabled)
 {
 	cmd->peer_flags = 0;
+	cmd->peer_flags_ext = 0;
 
 	if (arg->is_wme_set) {
 		if (arg->qos_flag)
@@ -1842,6 +1843,8 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_TWT_REQ);
 		if (arg->twt_responder)
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_TWT_RESP);
+		if (arg->eht_flag)
+			cmd->peer_flags_ext |= cpu_to_le32(WMI_PEER_EXT_EHT);
 	}
 
 	/* Suppress authorization for all AUTH modes that need 4-way handshake
@@ -1886,6 +1889,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	struct wmi_peer_assoc_complete_cmd *cmd;
 	struct ath12k_wmi_vht_rate_set_params *mcs;
 	struct ath12k_wmi_he_rate_set_params *he_mcs;
+	struct ath12k_wmi_eht_rate_set_params *eht_mcs;
 	struct sk_buff *skb;
 	struct wmi_tlv *tlv;
 	void *ptr;
@@ -1902,7 +1906,8 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	      TLV_HDR_SIZE + (peer_legacy_rates_align * sizeof(u8)) +
 	      TLV_HDR_SIZE + (peer_ht_rates_align * sizeof(u8)) +
 	      sizeof(*mcs) + TLV_HDR_SIZE +
-	      (sizeof(*he_mcs) * arg->peer_he_mcs_count);
+	      (sizeof(*he_mcs) * arg->peer_he_mcs_count) +
+	      TLV_HDR_SIZE + (sizeof(*eht_mcs) * arg->peer_eht_mcs_count);
 
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -1949,6 +1954,16 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		cmd->peer_ppet.ppet16_ppet8_ru3_ru0[i] =
 			cpu_to_le32(arg->peer_ppet.ppet16_ppet8_ru3_ru0[i]);
 
+	/* Update 11be capabilities */
+	memcpy_and_pad(cmd->peer_eht_cap_mac, sizeof(cmd->peer_eht_cap_mac),
+		       arg->peer_eht_cap_mac, sizeof(arg->peer_eht_cap_mac),
+		       0);
+	memcpy_and_pad(cmd->peer_eht_cap_phy, sizeof(cmd->peer_eht_cap_phy),
+		       arg->peer_eht_cap_phy, sizeof(arg->peer_eht_cap_phy),
+		       0);
+	memcpy_and_pad(&cmd->peer_eht_ppet, sizeof(cmd->peer_eht_ppet),
+		       &arg->peer_eht_ppet, sizeof(arg->peer_eht_ppet), 0);
+
 	/* Update peer legacy rate information */
 	ptr += sizeof(*cmd);
 
@@ -2015,8 +2030,24 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		ptr += sizeof(*he_mcs);
 	}
 
+	/* Loop through the EHT rate set */
+	len = arg->peer_eht_mcs_count * sizeof(*eht_mcs);
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
+	ptr += TLV_HDR_SIZE;
+
+	for (i = 0; i < arg->peer_eht_mcs_count; i++) {
+		eht_mcs = ptr;
+		eht_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
+							     sizeof(*eht_mcs));
+
+		eht_mcs->rx_mcs_set = cpu_to_le32(arg->peer_eht_rx_mcs_set[i]);
+		eht_mcs->tx_mcs_set = cpu_to_le32(arg->peer_eht_tx_mcs_set[i]);
+		ptr += sizeof(*eht_mcs);
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
-		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x\n",
+		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x peer_flags_ext %x eht mac_cap %x %x eht phy_cap %x %x %x\n",
 		   cmd->vdev_id, cmd->peer_associd, arg->peer_mac,
 		   cmd->peer_flags, cmd->peer_rate_caps, cmd->peer_caps,
 		   cmd->peer_listen_intval, cmd->peer_ht_caps,
@@ -2026,7 +2057,10 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		   cmd->peer_he_ops, cmd->peer_he_cap_info_ext,
 		   cmd->peer_he_cap_phy[0], cmd->peer_he_cap_phy[1],
 		   cmd->peer_he_cap_phy[2],
-		   cmd->peer_bw_rxnss_override);
+		   cmd->peer_bw_rxnss_override, cmd->peer_flags_ext,
+		   cmd->peer_eht_cap_mac[0], cmd->peer_eht_cap_mac[1],
+		   cmd->peer_eht_cap_phy[0], cmd->peer_eht_cap_phy[1],
+		   cmd->peer_eht_cap_phy[2]);
 
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_PEER_ASSOC_CMDID);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index d88d1575443d..f0877dbfc5fd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1167,6 +1167,10 @@ enum wmi_tlv_peer_flags {
 
 };
 
+enum wmi_tlv_peer_flags_ext {
+	WMI_PEER_EXT_EHT = 0x00000001,
+};
+
 /** Enum list of TLV Tags for each parameter structure type. */
 enum wmi_tlv_tag {
 	WMI_TAG_LAST_RESERVED = 15,
@@ -1924,6 +1928,7 @@ enum wmi_tlv_tag {
 	WMI_TAG_MAC_PHY_CAPABILITIES_EXT = 0x36F,
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
+	WMI_TAG_EHT_RATE_SET = 0x3C4,
 	WMI_TAG_MAX
 };
 
@@ -3613,6 +3618,15 @@ struct wmi_peer_assoc_complete_cmd {
 	__le32 peer_he_cap_info_internal;
 	__le32 min_data_rate;
 	__le32 peer_he_caps_6ghz;
+	__le32 sta_type;
+	__le32 bss_max_idle_option;
+	__le32 auth_mode;
+	__le32 peer_flags_ext;
+	__le32 puncture_20mhz_bitmap;
+	__le32 peer_eht_cap_mac[WMI_MAX_EHTCAP_MAC_SIZE];
+	__le32 peer_eht_cap_phy[WMI_MAX_EHTCAP_PHY_SIZE];
+	__le32 peer_eht_ops;
+	struct ath12k_wmi_ppe_threshold_params peer_eht_ppet;
 } __packed;
 
 struct wmi_stop_scan_cmd {
@@ -3840,6 +3854,12 @@ struct ath12k_wmi_he_rate_set_params {
 	__le32 tx_mcs_set;
 } __packed;
 
+struct ath12k_wmi_eht_rate_set_params {
+	__le32 tlv_header;
+	__le32 rx_mcs_set;
+	__le32 tx_mcs_set;
+} __packed;
+
 #define MAX_REG_RULES 10
 #define REG_ALPHA2_LEN 2
 #define MAX_6G_REG_RULES 5
-- 
2.39.0

