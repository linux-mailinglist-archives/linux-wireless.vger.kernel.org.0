Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF9792540
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjIEQCA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354045AbjIEJ1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 05:27:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4414C12E
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 02:27:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3858TwOQ018983;
        Tue, 5 Sep 2023 09:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=OVD3tOsTZBwEEYJx4oMjDGQ7uO7rttFGcX1N5yuM9eQ=;
 b=oJ6vtuSGnXMAtd5Nr/1wwoBxBdAl+ep7sgSW95Pssdf8tTIe+ZBSHFIcIAcSLUUAJgjs
 Rf/wWkhV2aE7N721KScC6JKOIJObjm5gBqvLSVv9FCy+7zpPBeaht9nTunlabtgVLNJT
 Q3Gs4Q7gCi5rC1gAL3gBleFsAj3FlcnKcCRqQeTELHSo8HNnq8HQOYcsDvEXdunYv6VB
 t81mY1RDxBM7A4F2SUzX32MdA6TWQ20uy02Bm44lWcuVOxVGZ1vYHEBLEGkjJWBLNrrJ
 hbfZ6InIywR74wmNnQhRyx6JTe1PqWVEux5IBu4XwUrizJbWJE8eH9p79TymNjM3O373 jQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swvj60kkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 09:27:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3859RXF1008098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 09:27:33 GMT
Received: from lingbok-HP-EliteBook-8460p.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 02:27:31 -0700
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: ath12k: add support for hardware rfkill for WCN7850
Date:   Tue, 5 Sep 2023 17:27:20 +0800
Message-ID: <20230905092720.3533-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iVM5m_if1USbzjer-HBmtsfzReNzSQGa
X-Proofpoint-ORIG-GUID: iVM5m_if1USbzjer-HBmtsfzReNzSQGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When hardware rfkill is enabled in the firmware, it will report the
capability via using WMI_SYS_CAP_INFO_RFKILL bit in the WMI_SERVICE_READY
event to the host. ath12k will check the capability if it is enabled then
ath12k will set the GPIO information to firmware using WMI_PDEV_SET_PARAM.
When the firmware detects hardware rfkill is enabled by the user, it will
report it via WMI_RFKILL_STATE_CHANGE_EVENTID. Once ath12k receive the
event it will send wmi command WMI_PDEV_SET_PARAM to the firmware and
also notify cfg80211.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 52 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/core.h |  4 ++
 drivers/net/wireless/ath/ath12k/hw.c   | 12 ++++++
 drivers/net/wireless/ath/ath12k/hw.h   |  4 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 58 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h  |  2 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 39 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  | 25 +++++++++++
 8 files changed, 196 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3df8059d5512..cae1ab9982cd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -19,6 +19,27 @@ unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
+static int ath12k_core_rfkill_config(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	int ret = 0, i;
+
+	if (!(ab->target_caps.sys_cap_info & WMI_SYS_CAP_INFO_RFKILL))
+		return 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+
+		ret = ath12k_mac_rfkill_config(ar);
+		if (ret && ret != -EOPNOTSUPP) {
+			ath12k_warn(ab, "failed to configure rfkill: %d", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 int ath12k_core_suspend(struct ath12k_base *ab)
 {
 	int ret;
@@ -603,6 +624,13 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 		goto err_core_stop;
 	}
 	ath12k_hif_irq_enable(ab);
+
+	ret = ath12k_core_rfkill_config(ab);
+	if (ret && ret != -EOPNOTSUPP) {
+		ath12k_err(ab, "failed to config rfkill: %d\n", ret);
+		goto err_core_stop;
+	}
+
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -655,6 +683,27 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
 	return ret;
 }
 
+static void ath12k_rfkill_work(struct work_struct *work)
+{
+	struct ath12k_base *ab = container_of(work, struct ath12k_base, rfkill_work);
+	struct ath12k *ar;
+	bool rfkill_radio_on;
+	int i;
+
+	spin_lock_bh(&ab->base_lock);
+	rfkill_radio_on = ab->rfkill_radio_on;
+	spin_unlock_bh(&ab->base_lock);
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		if (!ar)
+			continue;
+
+		ath12k_mac_rfkill_enable_radio(ar, rfkill_radio_on);
+		wiphy_rfkill_set_hw_state(ar->hw->wiphy, !rfkill_radio_on);
+	}
+}
+
 void ath12k_core_halt(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -668,6 +717,7 @@ void ath12k_core_halt(struct ath12k *ar)
 	ath12k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
+	cancel_work_sync(&ab->rfkill_work);
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
@@ -922,6 +972,8 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	init_waitqueue_head(&ab->wmi_ab.tx_credits_wq);
 	INIT_WORK(&ab->restart_work, ath12k_core_restart);
 	INIT_WORK(&ab->reset_work, ath12k_core_reset);
+	INIT_WORK(&ab->rfkill_work, ath12k_rfkill_work);
+
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d873b573dac6..3f5f0471f640 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -771,6 +771,10 @@ struct ath12k_base {
 	u64 fw_soc_drop_count;
 	bool static_window_map;
 
+	struct work_struct rfkill_work;
+	/* true means radio is on */
+	bool rfkill_radio_on;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 5991cc91cd00..f69649f58e82 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -907,6 +907,10 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -964,6 +968,10 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
 					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
+
+		.rfkill_pin = 48,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 1,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1019,6 +1027,10 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e6c4223c283c..1b4912bf57ad 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -186,6 +186,10 @@ struct ath12k_hw_params {
 	const struct hal_ops *hal_ops;
 
 	u64 qmi_cnss_feature_bitmap;
+
+	u32 rfkill_pin;
+	u32 rfkill_cfg;
+	u32 rfkill_on_level;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 85602d64b607..486d062b0a76 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5108,6 +5108,63 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
+int ath12k_mac_rfkill_config(struct ath12k *ar)
+{
+	struct ath12k_base *ab = ar->ab;
+	u32 param;
+	int ret;
+
+	if (ab->hw_params->rfkill_pin == 0)
+		return -EOPNOTSUPP;
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC,
+		   "mac rfkill_pin %d rfkill_cfg %d rfkill_on_level %d",
+		   ab->hw_params->rfkill_pin, ab->hw_params->rfkill_cfg,
+		   ab->hw_params->rfkill_on_level);
+
+	param = u32_encode_bits(ab->hw_params->rfkill_on_level,
+				WMI_RFKILL_CFG_RADIO_LEVEL) |
+		u32_encode_bits(ab->hw_params->rfkill_pin,
+				WMI_RFKILL_CFG_GPIO_PIN_NUM) |
+		u32_encode_bits(ab->hw_params->rfkill_cfg,
+				WMI_RFKILL_CFG_PIN_AS_GPIO);
+
+	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_HW_RFKILL_CONFIG,
+					param, ar->pdev->pdev_id);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to set rfkill config 0x%x: %d\n",
+			    param, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable)
+{
+	enum wmi_rfkill_enable_radio param;
+	int ret;
+
+	if (enable)
+		param = WMI_RFKILL_ENABLE_RADIO_ON;
+	else
+		param = WMI_RFKILL_ENABLE_RADIO_OFF;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac %d rfkill enable %d",
+		   ar->pdev_idx, param);
+
+	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_RFKILL_ENABLE,
+					param, ar->pdev->pdev_id);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set rfkill enable param %d: %d\n",
+			    param, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath12k *ar = hw->priv;
@@ -5128,6 +5185,7 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
+	cancel_work_sync(&ar->ab->rfkill_work);
 
 	spin_lock_bh(&ar->data_lock);
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 7b16b70df4fa..59b4e8f5eee0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -73,4 +73,6 @@ int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 enum rate_info_bw ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw);
 enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw bw);
 enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
+int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable);
+int ath12k_mac_rfkill_config(struct ath12k *ar);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ef0f3cf35cfd..4ac05cd7a1a5 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -152,6 +152,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_service_available_event) },
 	[WMI_TAG_PEER_ASSOC_CONF_EVENT] = {
 		.min_len = sizeof(struct wmi_peer_assoc_conf_event) },
+	[WMI_TAG_RFKILL_EVENT] = {
+		.min_len = sizeof(struct wmi_rfkill_state_change_event) },
 	[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT] = {
 		.min_len = sizeof(struct wmi_pdev_ctl_failsafe_chk_event) },
 	[WMI_TAG_HOST_SWFDA_EVENT] = {
@@ -6580,6 +6582,40 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 	kfree(tb);
 }
 
+static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
+					     struct sk_buff *skb)
+{
+	const struct wmi_rfkill_state_change_event *ev;
+	const void **tb;
+	int ret;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_RFKILL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC,
+		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
+		   le32_to_cpu(ev->gpio_pin_num),
+		   le32_to_cpu(ev->int_type),
+		   le32_to_cpu(ev->radio_state));
+
+	spin_lock_bh(&ab->base_lock);
+	ab->rfkill_radio_on = (le32_to_cpu(ev->radio_state) == WMI_RFKILL_RADIO_STATE_ON);
+	spin_unlock_bh(&ab->base_lock);
+
+	queue_work(ab->workqueue, &ab->rfkill_work);
+	kfree(tb);
+}
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -6672,6 +6708,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_OFFLOAD_PROB_RESP_TX_STATUS_EVENTID:
 		ath12k_probe_resp_tx_status_event(ab, skb);
 		break;
+	case WMI_RFKILL_STATE_CHANGE_EVENTID:
+		ath12k_rfkill_state_change_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c75a6fa1f7e0..965755b4cbfd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4793,6 +4793,31 @@ struct ath12k_wmi_base {
 
 #define ATH12K_FW_STATS_BUF_SIZE (1024 * 1024)
 
+enum wmi_sys_cap_info_flags {
+	WMI_SYS_CAP_INFO_RXTX_LED	= BIT(0),
+	WMI_SYS_CAP_INFO_RFKILL		= BIT(1),
+};
+
+#define WMI_RFKILL_CFG_GPIO_PIN_NUM		GENMASK(5, 0)
+#define WMI_RFKILL_CFG_RADIO_LEVEL		BIT(6)
+#define WMI_RFKILL_CFG_PIN_AS_GPIO		GENMASK(10, 7)
+
+enum wmi_rfkill_enable_radio {
+	WMI_RFKILL_ENABLE_RADIO_ON	= 0,
+	WMI_RFKILL_ENABLE_RADIO_OFF	= 1,
+};
+
+enum wmi_rfkill_radio_state {
+	WMI_RFKILL_RADIO_STATE_OFF	= 1,
+	WMI_RFKILL_RADIO_STATE_ON	= 2,
+};
+
+struct wmi_rfkill_state_change_event {
+	__le32 gpio_pin_num;
+	__le32 int_type;
+	__le32 radio_state;
+} __packed;
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,

base-commit: 4d4739971f44150b3dcb75f188a1a3cbc22889a3
-- 
2.34.1

