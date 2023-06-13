Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B694172D99F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 08:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjFMGDh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 02:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjFMGDg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 02:03:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E426B10DA
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 23:03:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D5xLD7014555;
        Tue, 13 Jun 2023 06:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=h0l6VuIX3ndIjPxoMOlvVia5ujcUiNo7cZ95Nd/6ImU=;
 b=ExPnIFqmlaywnQloN0EdFVati9CdXU9tJj41lL+pBr41V1jpbtEhtjSeV0qRi9W+lBWf
 P3nQK8xrP05hXTtP3BuOq2SIIO1/iErolmOd//WZ++wPbnckM2OvDhj6a3M/1NnurSjr
 JjJSAMu0f4jErxZY0+3JH4jfYoSUHfvKKyI2hM/vD7GRarhXiZliQBlb6Fcy2KVoQ4W3
 OMSGtnCyYt09ZfPNvmKqgExEhjOK66VmHbEHxesQsVB+NohIQidoymPosJ1d1DDpDFEx
 COVXFjDHEaY55ZL7+vXzdDkc/uz7/wrgDNXOAFx/do8RYBHCBD3Clj0bOQ5m8w3KOaRU jw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r61q21y3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 06:03:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35D63Rm7023976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 06:03:27 GMT
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 23:03:25 -0700
From:   Hari Chandrakanthan <quic_haric@quicinc.com>
To:     <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH v2] wifi: ath11k: add tx delay to TSF
Date:   Tue, 13 Jun 2023 11:33:03 +0530
Message-ID: <1686636183-1026-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _ppadUDxnG4FKGEDwXIhcjvSkSBSZwZ1
X-Proofpoint-ORIG-GUID: _ppadUDxnG4FKGEDwXIhcjvSkSBSZwZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_03,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In ath11k AP, the TSF timestamp mod the beacon interval does not vary
and is close to 0.
It is expected to be around 384us for 2 GHz and  54us for 5 GHz/6 GHz.

The value of the TSF timer at TBTT is a multiple of the beacon interval,
while the value of the TSF timestamp in the beacon accounts for medium access
delay and physical implementation-specific delays through the PHY,
which could cause the value of the TSF timestamp mod the beacon interval
to vary.

An AP sending a beacon frame shall set the value of the beacon frame’s
timestamp so that it equals the value of the STA’s TSF timer at the
time that the data symbol containing the first bit of the timestamp
is transmitted to the PHY plus the transmitting STA’s delays through
its local PHY from the MAC-PHY interface to its interface with the WM.

In ath11k the physical implementation-specific delays were not accounted
for TSF timer and it resulted in incorrent TSF timer values.

Add the physical implementation-specific delays in the TSF of beacon
template and probe response, so that the TSF holds proper values in the
beacon and probe response.

tx delay for 5 GHz/6 GHz:
20(lsig)+2(service)+32(6mbps, 24 bytes) = 54us + 2us(MAC/BB DELAY)
tx delay for 2.4 GHz:
144 us (LPREAMBLE) + 48 (PLCP Header) + 192 (1Mbps, 24 bytes)
= 384 us + 2us(MAC/BB DELAY)

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
v2:
Fixed warning : no previous prototype for 'ath11k_wmi_event_tbttoffset_update'
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/net/wireless/ath/ath11k/core.h |   3 +-
 drivers/net/wireless/ath/ath11k/mac.c  |  36 ++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 102 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  |  18 ++++++
 4 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9d15b4390b9c..d937eff876d8 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -365,7 +365,8 @@ struct ath11k_vif {
 	struct ieee80211_chanctx_conf chanctx;
 	struct ath11k_arp_ns_offload arp_ns_offload;
 	struct ath11k_rekey_data rekey_data;
-
+	u64 tbtt_offset;
+	struct work_struct update_bcn_template_work;
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct dentry *debugfs_twt;
 #endif /* CONFIG_ATH11K_DEBUGFS */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a31b8e89684b..51d2f73be06e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1437,6 +1437,7 @@ static void ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
 {
 	struct ieee80211_mgmt *mgmt;
 	u8 *ies;
+	u64 adjusted_tsf;
 
 	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
 	mgmt = (struct ieee80211_mgmt *)bcn->data;
@@ -1453,6 +1454,15 @@ static void ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
 		arvif->wpaie_present = true;
 	else
 		arvif->wpaie_present = false;
+
+	/* Make the TSF offset negative so beacons in the same
+	 * staggered batch have the same TSF.
+	 */
+	if (arvif->tbtt_offset) {
+		adjusted_tsf = cpu_to_le64(0ULL - arvif->tbtt_offset);
+		memcpy(&mgmt->u.beacon.timestamp, &adjusted_tsf, sizeof(adjusted_tsf));
+	}
+
 }
 
 static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
@@ -6173,9 +6183,11 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ath11k_sta *arsta = NULL;
+	struct ieee80211_mgmt *mgmt;
 	u32 info_flags = info->flags;
 	bool is_prb_rsp;
 	int ret;
+	u64 adjusted_tsf;
 
 	memset(skb_cb, 0, sizeof(*skb_cb));
 	skb_cb->vif = vif;
@@ -6189,6 +6201,12 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 		skb_cb->flags |= ATH11K_SKB_HW_80211_ENCAP;
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
+		if (is_prb_rsp && arvif->tbtt_offset) {
+			mgmt = (struct ieee80211_mgmt *)skb->data;
+			adjusted_tsf = cpu_to_le64(0ULL - arvif->tbtt_offset);
+			memcpy(&mgmt->u.probe_resp.timestamp, &adjusted_tsf,
+			       sizeof(adjusted_tsf));
+		}
 		ret = ath11k_mac_mgmt_tx(ar, skb, is_prb_rsp);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to queue management frame %d\n",
@@ -6400,6 +6418,22 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
+static void ath11k_update_bcn_template_work(struct work_struct *work)
+{
+	struct ath11k_vif *arvif = container_of(work, struct ath11k_vif,
+						update_bcn_template_work);
+	struct ath11k *ar = arvif->ar;
+	int ret = 0;
+
+	mutex_lock(&ar->conf_mutex);
+	if (arvif->is_up)
+		ret = ath11k_mac_setup_bcn_tmpl(arvif);
+	mutex_unlock(&ar->conf_mutex);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to submit beacon template for vdev_id : %d ret : %d\n",
+			    arvif->vdev_id, ret);
+}
+
 static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath11k *ar = hw->priv;
@@ -6761,6 +6795,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	INIT_LIST_HEAD(&arvif->list);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
 			  ath11k_mac_vif_sta_connection_loss_work);
+	INIT_WORK(&arvif->update_bcn_template_work, ath11k_update_bcn_template_work);
 
 	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
 		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
@@ -6986,6 +7021,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	int i;
 
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
+	cancel_work_sync(&arvif->update_bcn_template_work);
 
 	mutex_lock(&ar->conf_mutex);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 68622a850527..ca413e54e9f8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8521,6 +8521,104 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 	kfree(tb);
 }
 
+static int ath11k_wmi_tbtt_offset_subtlv_parser(struct ath11k_base *ab, u16 tag,
+						u16 len, const void *ptr,
+						void *data)
+{
+	int ret = 0;
+	struct ath11k *ar;
+	u64 tx_delay = 0;
+	struct wmi_tbtt_offset_info *tbtt_offset_info;
+	struct ieee80211_chanctx_conf *conf;
+	struct ath11k_vif *arvif;
+
+	tbtt_offset_info = (struct wmi_tbtt_offset_info *)ptr;
+
+	rcu_read_lock();
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, tbtt_offset_info->vdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "ar not found, vdev_id %d\n", tbtt_offset_info->vdev_id);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	arvif = ath11k_mac_get_arvif(ar, tbtt_offset_info->vdev_id);
+	if (!arvif) {
+		ath11k_warn(ab, "arvif not found, vdev_id %d\n",
+			    tbtt_offset_info->vdev_id);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (arvif->vdev_type != WMI_VDEV_TYPE_AP) {
+		ret = 0;
+		goto exit;
+	}
+
+	arvif->tbtt_offset = tbtt_offset_info->tbtt_offset;
+	conf = rcu_dereference(arvif->vif->bss_conf.chanctx_conf);
+	if (conf && conf->def.chan->band == NL80211_BAND_2GHZ) {
+		/* 1Mbps Beacon: */
+		/* 144 us ( LPREAMBLE) + 48 (PLCP Header)
+		 * + 192 (1Mbps, 24 ytes)
+		 * = 384 us + 2us(MAC/BB DELAY
+		 */
+		tx_delay = 386;
+	} else if (conf && (conf->def.chan->band == NL80211_BAND_5GHZ ||
+			    conf->def.chan->band == NL80211_BAND_6GHZ)) {
+		/* 6Mbps Beacon: */
+		/* 20(lsig)+2(service)+32(6mbps, 24 bytes)
+		 * = 54us + 2us(MAC/BB DELAY)
+		 */
+		tx_delay = 56;
+	}
+	arvif->tbtt_offset -= tx_delay;
+
+	ieee80211_queue_work(ar->hw, &arvif->update_bcn_template_work);
+exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int ath11k_wmi_tbtt_offset_event_parser(struct ath11k_base *ab,
+					       u16 tag, u16 len,
+					       const void *ptr, void *data)
+{
+	int ret = 0;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi tbtt offset event tag 0x%x of len %d rcvd\n",
+		   tag, len);
+
+	switch (tag) {
+	case WMI_TAG_TBTT_OFFSET_EXT_EVENT:
+		break;
+	case WMI_TAG_ARRAY_STRUCT:
+		ret = ath11k_wmi_tlv_iter(ab, ptr, len,
+					  ath11k_wmi_tbtt_offset_subtlv_parser,
+					  data);
+		break;
+	default:
+		ath11k_warn(ab, "Received invalid tag for wmi tbtt offset event\n");
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static void ath11k_wmi_event_tbttoffset_update(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	struct wmi_tbtt_offset_info tbtt_offset_info;
+	int ret;
+
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tbtt_offset_event_parser,
+				  &tbtt_offset_info);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse tbtt tlv %d\n", ret);
+	}
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -8627,8 +8725,10 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_TWT_ADD_DIALOG_EVENTID:
 		ath11k_wmi_twt_add_dialog_event(ab, skb);
 		break;
-	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
+		ath11k_wmi_event_tbttoffset_update(ab, skb);
+		break;
+	/* add Unsupported events here */
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
 	case WMI_TWT_ENABLE_EVENTID:
 	case WMI_TWT_DISABLE_EVENTID:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 100bb816b592..534710146e18 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4541,6 +4541,24 @@ struct wmi_pdev_bss_chan_info_event {
 	u32 pdev_id;
 } __packed;
 
+struct wmi_tbtt_offset_info {
+	u32 vdev_id;
+	u32 tbtt_offset;
+	u32 tbtt_qtime_low_us;
+	u32 tbtt_qtime_high_us;
+} __packed;
+
+struct wmi_tbtt_offset_event {
+	u32 num_vdevs;
+} __packed;
+
+struct wmi_tbtt_offset_ev_arg {
+	u32 vdev_id;
+	u32 tbtt_offset;
+	u32 tbtt_qtime_low_us;
+	u32 tbtt_qtime_high_us;
+} __packed;
+
 #define WMI_VDEV_INSTALL_KEY_COMPL_STATUS_SUCCESS 0
 
 struct wmi_vdev_install_key_compl_event {
-- 
2.7.4

