Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93E57B7F3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiGTNwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiGTNwM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:52:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311245FAEC
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:52:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KDgir5018209;
        Wed, 20 Jul 2022 13:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=37wQ7gctN25fAdd8LzhqTr9ypQWWNl6sGZxtBwItJDk=;
 b=CBep+ky/mDN6pWFaNXM2Z7LbBJfymrLpO8LeBlbDWb8T8WyIfmKUlr5ur/iHsiQ5pNoM
 SuXVXBK8rd1emkbI3h7l8ZvrDYLjEVLyooY66cI4t1DxTCv6GR3O3198FIa4jzppX8aE
 zJeU0y4p/Gf2P0ZjEYaAvHx48j3PLHAv98pks+1V4ZqSdnfxAe75q4yQqcsgAtGISrpE
 pDgcVIPSGNOCPYxTGQepTtyTbUmS2JIcJ5UrrBnMvkyk1ocn0DhIZFXdSiB12dfQCtSb
 yaQF6nwutpa6NARi6HqTbFezVPbg6C36N+cPo1xUP5ZQNWekydXFGgubhu25aIn6mkca pA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hebfv15yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:52:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KDq7s9007738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:52:07 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:52:07 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:52:05 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 1/2] ath11k: Add TWT debugfs support for STA interface
Date:   Wed, 20 Jul 2022 19:21:49 +0530
Message-ID: <20220720135150.22193-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720135150.22193-1-quic_mpubbise@quicinc.com>
References: <20220720135150.22193-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h-holAhdmTogB3JdlNo4Re5BLcTYeXHk
X-Proofpoint-ORIG-GUID: h-holAhdmTogB3JdlNo4Re5BLcTYeXHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_08,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently TWT debugfs files required for manually testing the
TWT feature are created only for the AP interfaces; these debugfs
hooks are also required for the station interfaces in order to
test the TWT feature manually, therefore create these debugfs
hooks for station iftype as well.

In the case of station interfaces, TWT is entirely handled in the
firmware based on input parameters passed to it during association
via TWT enable WMI command. In order to manually test this feature,
firmware expects to first disable the TWT feature and then send the
enable command with sta_cong_timer_ms parameter set to 0.
This is true for WCN6750, QCA6390 & WCN6855 hardwares.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 57 ++++++++++++++++---
 drivers/net/wireless/ath/ath11k/mac.c     | 11 +++-
 drivers/net/wireless/ath/ath11k/wmi.c     | 68 +++++++++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.h     | 23 +++++++-
 4 files changed, 123 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 9648e0017393..3861616b48c8 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1456,11 +1456,13 @@ static ssize_t ath11k_write_twt_add_dialog(struct file *file,
 {
 	struct ath11k_vif *arvif = file->private_data;
 	struct wmi_twt_add_dialog_params params = { 0 };
+	struct wmi_twt_enable_params twt_params = {0};
+	struct ath11k *ar = arvif->ar;
 	u8 buf[128] = {0};
 	int ret;
 
-	if (arvif->ar->twt_enabled == 0) {
-		ath11k_err(arvif->ar->ab, "twt support is not enabled\n");
+	if (ar->twt_enabled == 0) {
+		ath11k_err(ar->ab, "twt support is not enabled\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1490,13 +1492,38 @@ static ssize_t ath11k_write_twt_add_dialog(struct file *file,
 	if (ret != 16)
 		return -EINVAL;
 
+	/* In the case of station vif, TWT is entirely handled by
+	 * the firmware based on the input parameters in the TWT enable
+	 * WMI command that is sent to the target during assoc.
+	 * For manually testing the TWT feature, we need to first disable
+	 * TWT and send enable command again with TWT input parameter
+	 * sta_cong_timer_ms set to 0.
+	 */
+	if (arvif->vif->type == NL80211_IFTYPE_STATION) {
+		ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
+
+		ath11k_wmi_fill_default_twt_params(&twt_params);
+		twt_params.sta_cong_timer_ms = 0;
+
+		ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id, &twt_params);
+	}
+
 	params.vdev_id = arvif->vdev_id;
 
 	ret = ath11k_wmi_send_twt_add_dialog_cmd(arvif->ar, &params);
 	if (ret)
-		return ret;
+		goto err_twt_add_dialog;
 
 	return count;
+
+err_twt_add_dialog:
+	if (arvif->vif->type == NL80211_IFTYPE_STATION) {
+		ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
+		ath11k_wmi_fill_default_twt_params(&twt_params);
+		ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id, &twt_params);
+	}
+
+	return ret;
 }
 
 static ssize_t ath11k_write_twt_del_dialog(struct file *file,
@@ -1505,11 +1532,13 @@ static ssize_t ath11k_write_twt_del_dialog(struct file *file,
 {
 	struct ath11k_vif *arvif = file->private_data;
 	struct wmi_twt_del_dialog_params params = { 0 };
+	struct wmi_twt_enable_params twt_params = {0};
+	struct ath11k *ar = arvif->ar;
 	u8 buf[64] = {0};
 	int ret;
 
-	if (arvif->ar->twt_enabled == 0) {
-		ath11k_err(arvif->ar->ab, "twt support is not enabled\n");
+	if (ar->twt_enabled == 0) {
+		ath11k_err(ar->ab, "twt support is not enabled\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1535,6 +1564,12 @@ static ssize_t ath11k_write_twt_del_dialog(struct file *file,
 	if (ret)
 		return ret;
 
+	if (arvif->vif->type == NL80211_IFTYPE_STATION) {
+		ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
+		ath11k_wmi_fill_default_twt_params(&twt_params);
+		ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id, &twt_params);
+	}
+
 	return count;
 }
 
@@ -1640,12 +1675,18 @@ static const struct file_operations ath11k_fops_twt_resume_dialog = {
 
 int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
 {
-	if (arvif->vif->type == NL80211_IFTYPE_AP && !arvif->debugfs_twt) {
+	struct ath11k_base *ab = arvif->ar->ab;
+
+	if (arvif->vif->type != NL80211_IFTYPE_AP &&
+	    !(arvif->vif->type == NL80211_IFTYPE_STATION &&
+	      test_bit(WMI_TLV_SERVICE_STA_TWT, ab->wmi_ab.svc_map)))
+		return 0;
+
+	if (!arvif->debugfs_twt) {
 		arvif->debugfs_twt = debugfs_create_dir("twt",
 							arvif->vif->debugfs_dir);
 		if (!arvif->debugfs_twt || IS_ERR(arvif->debugfs_twt)) {
-			ath11k_warn(arvif->ar->ab,
-				    "failed to create directory %p\n",
+			ath11k_warn(ab, "failed to create directory %p\n",
 				    arvif->debugfs_twt);
 			arvif->debugfs_twt = NULL;
 			return -1;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d83d3c944594..3746c839efe0 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3350,10 +3350,15 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_recalculate_mgmt_rate(ar, vif, &def);
 
 	if (changed & BSS_CHANGED_TWT) {
-		if (info->twt_requester || info->twt_responder)
-			ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id);
-		else
+		struct wmi_twt_enable_params twt_params = {0};
+
+		if (info->twt_requester || info->twt_responder) {
+			ath11k_wmi_fill_default_twt_params(&twt_params);
+			ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id,
+						       &twt_params);
+		} else {
 			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
+		}
 	}
 
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5d9437ea92cf..7c146784f06b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3068,8 +3068,34 @@ int ath11k_wmi_pdev_pktlog_disable(struct ath11k *ar)
 	return ret;
 }
 
-int
-ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id)
+void ath11k_wmi_fill_default_twt_params(struct wmi_twt_enable_params *twt_params)
+{
+	twt_params->sta_cong_timer_ms = ATH11K_TWT_DEF_STA_CONG_TIMER_MS;
+	twt_params->default_slot_size = ATH11K_TWT_DEF_DEFAULT_SLOT_SIZE;
+	twt_params->congestion_thresh_setup = ATH11K_TWT_DEF_CONGESTION_THRESH_SETUP;
+	twt_params->congestion_thresh_teardown =
+		ATH11K_TWT_DEF_CONGESTION_THRESH_TEARDOWN;
+	twt_params->congestion_thresh_critical =
+		ATH11K_TWT_DEF_CONGESTION_THRESH_CRITICAL;
+	twt_params->interference_thresh_teardown =
+		ATH11K_TWT_DEF_INTERFERENCE_THRESH_TEARDOWN;
+	twt_params->interference_thresh_setup =
+		ATH11K_TWT_DEF_INTERFERENCE_THRESH_SETUP;
+	twt_params->min_no_sta_setup = ATH11K_TWT_DEF_MIN_NO_STA_SETUP;
+	twt_params->min_no_sta_teardown = ATH11K_TWT_DEF_MIN_NO_STA_TEARDOWN;
+	twt_params->no_of_bcast_mcast_slots = ATH11K_TWT_DEF_NO_OF_BCAST_MCAST_SLOTS;
+	twt_params->min_no_twt_slots = ATH11K_TWT_DEF_MIN_NO_TWT_SLOTS;
+	twt_params->max_no_sta_twt = ATH11K_TWT_DEF_MAX_NO_STA_TWT;
+	twt_params->mode_check_interval = ATH11K_TWT_DEF_MODE_CHECK_INTERVAL;
+	twt_params->add_sta_slot_interval = ATH11K_TWT_DEF_ADD_STA_SLOT_INTERVAL;
+	twt_params->remove_sta_slot_interval =
+		ATH11K_TWT_DEF_REMOVE_STA_SLOT_INTERVAL;
+	/* TODO add MBSSID support */
+	twt_params->mbss_support = 0;
+}
+
+int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id,
+				   struct wmi_twt_enable_params *params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct ath11k_base *ab = wmi->wmi_ab->ab;
@@ -3087,28 +3113,22 @@ ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id)
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_ENABLE_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
 	cmd->pdev_id = pdev_id;
-	cmd->sta_cong_timer_ms = ATH11K_TWT_DEF_STA_CONG_TIMER_MS;
-	cmd->default_slot_size = ATH11K_TWT_DEF_DEFAULT_SLOT_SIZE;
-	cmd->congestion_thresh_setup = ATH11K_TWT_DEF_CONGESTION_THRESH_SETUP;
-	cmd->congestion_thresh_teardown =
-		ATH11K_TWT_DEF_CONGESTION_THRESH_TEARDOWN;
-	cmd->congestion_thresh_critical =
-		ATH11K_TWT_DEF_CONGESTION_THRESH_CRITICAL;
-	cmd->interference_thresh_teardown =
-		ATH11K_TWT_DEF_INTERFERENCE_THRESH_TEARDOWN;
-	cmd->interference_thresh_setup =
-		ATH11K_TWT_DEF_INTERFERENCE_THRESH_SETUP;
-	cmd->min_no_sta_setup = ATH11K_TWT_DEF_MIN_NO_STA_SETUP;
-	cmd->min_no_sta_teardown = ATH11K_TWT_DEF_MIN_NO_STA_TEARDOWN;
-	cmd->no_of_bcast_mcast_slots = ATH11K_TWT_DEF_NO_OF_BCAST_MCAST_SLOTS;
-	cmd->min_no_twt_slots = ATH11K_TWT_DEF_MIN_NO_TWT_SLOTS;
-	cmd->max_no_sta_twt = ATH11K_TWT_DEF_MAX_NO_STA_TWT;
-	cmd->mode_check_interval = ATH11K_TWT_DEF_MODE_CHECK_INTERVAL;
-	cmd->add_sta_slot_interval = ATH11K_TWT_DEF_ADD_STA_SLOT_INTERVAL;
-	cmd->remove_sta_slot_interval =
-		ATH11K_TWT_DEF_REMOVE_STA_SLOT_INTERVAL;
-	/* TODO add MBSSID support */
-	cmd->mbss_support = 0;
+	cmd->sta_cong_timer_ms = params->sta_cong_timer_ms;
+	cmd->default_slot_size = params->default_slot_size;
+	cmd->congestion_thresh_setup = params->congestion_thresh_setup;
+	cmd->congestion_thresh_teardown = params->congestion_thresh_teardown;
+	cmd->congestion_thresh_critical = params->congestion_thresh_critical;
+	cmd->interference_thresh_teardown = params->interference_thresh_teardown;
+	cmd->interference_thresh_setup = params->interference_thresh_setup;
+	cmd->min_no_sta_setup = params->min_no_sta_setup;
+	cmd->min_no_sta_teardown = params->min_no_sta_teardown;
+	cmd->no_of_bcast_mcast_slots = params->no_of_bcast_mcast_slots;
+	cmd->min_no_twt_slots = params->min_no_twt_slots;
+	cmd->max_no_sta_twt = params->max_no_sta_twt;
+	cmd->mode_check_interval = params->mode_check_interval;
+	cmd->add_sta_slot_interval = params->add_sta_slot_interval;
+	cmd->remove_sta_slot_interval = params->remove_sta_slot_interval;
+	cmd->mbss_support = params->mbss_support;
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_ENABLE_CMDID);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b1fad4707dc6..a19fbee99586 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4933,6 +4933,25 @@ struct wmi_wmm_params_all_arg {
 #define ATH11K_TWT_DEF_ADD_STA_SLOT_INTERVAL		1000
 #define ATH11K_TWT_DEF_REMOVE_STA_SLOT_INTERVAL		5000
 
+struct wmi_twt_enable_params {
+	u32 sta_cong_timer_ms;
+	u32 mbss_support;
+	u32 default_slot_size;
+	u32 congestion_thresh_setup;
+	u32 congestion_thresh_teardown;
+	u32 congestion_thresh_critical;
+	u32 interference_thresh_teardown;
+	u32 interference_thresh_setup;
+	u32 min_no_sta_setup;
+	u32 min_no_sta_teardown;
+	u32 no_of_bcast_mcast_slots;
+	u32 min_no_twt_slots;
+	u32 max_no_sta_twt;
+	u32 mode_check_interval;
+	u32 add_sta_slot_interval;
+	u32 remove_sta_slot_interval;
+};
+
 struct wmi_twt_enable_params_cmd {
 	u32 tlv_header;
 	u32 pdev_id;
@@ -6064,7 +6083,9 @@ void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 			      struct ath11k_fw_stats *fw_stats, u32 stats_id,
 			      char *buf);
 int ath11k_wmi_simulate_radar(struct ath11k *ar);
-int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
+void ath11k_wmi_fill_default_twt_params(struct wmi_twt_enable_params *twt_params);
+int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id,
+				   struct wmi_twt_enable_params *params);
 int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
 int ath11k_wmi_send_twt_add_dialog_cmd(struct ath11k *ar,
 				       struct wmi_twt_add_dialog_params *params);
-- 
2.35.1

