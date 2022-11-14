Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68B6628A56
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiKNUTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiKNUT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6139665B6
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:27 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEHIxTY011758;
        Mon, 14 Nov 2022 20:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sXdG+H81RMYB0ikFa49YTLX1rrZQ5AjO3sCsHWQLqMY=;
 b=TmXWULk4pfV5JV0MqyztI38mn7zkAa6QC8G5O6PcIGzFxy7cFplmUjedg8eXG5j0j8yl
 Vib5CY6MSy+oPDoRvSrwpyfs7WQ1R1hqA6ba+ui+NoTnbSn3OJ3b2kKDil0Myny93gup
 7GiLC3Fc4iC/q3RL1/XS43V47QJbZQ2biw7eOM1hm7E851SmJQ953nCOI/RPZn4QRAvb
 +vL2J90a8r1qpTk5R5WrqJOL9s85uxbt5/UW6vZ5fq/5w+eslZxUqw+a2jtv8pMpCcY6
 jQE9hE8/JjZr8psEcrk8dxf3rTFfO/QQL9IJoUJE1+wGaOuReE32q8rj7vTkyUSxlgfh 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kusye0h30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJN54028462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:23 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:22 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 05/10] ath11k: create a structure for WMI vdev up parameters
Date:   Mon, 14 Nov 2022 12:19:07 -0800
Message-ID: <20221114201912.22893-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114201912.22893-1-quic_alokad@quicinc.com>
References: <20221114201912.22893-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W3EJJGgmHpqft-uA6yf5JxleVuYGsX6R
X-Proofpoint-ORIG-GUID: W3EJJGgmHpqft-uA6yf5JxleVuYGsX6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include an instance of the structure instead of individual parameters
as input to ath11k_wmi_vdev_up().

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
v2: Renaming of struct wmi_vdev_up_cmd parameters and additions in struct
vdev_up_params moved to separate patches.

drivers/net/wireless/ath/ath11k/mac.c | 31 +++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/wmi.c | 13 +++++------
 drivers/net/wireless/ath/ath11k/wmi.h |  9 ++++++--
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2b96205e996e..d4b87d4de22a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -923,6 +923,7 @@ static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
 	struct ieee80211_channel *channel;
 	struct wmi_vdev_start_req_arg arg = {};
 	int ret;
+	struct vdev_up_params params = { 0 };
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -963,7 +964,9 @@ static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
 		return ret;
 	}
 
-	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	params.vdev_id = vdev_id,
+	params.bssid = ar->mac_addr,
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -1423,6 +1426,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 {
 	struct ath11k *ar = arvif->ar;
 	int ret = 0;
+	struct vdev_up_params params = { 0 };
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
 
@@ -1450,8 +1454,10 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -2709,6 +2715,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	struct ath11k_peer *peer;
 	bool is_auth = false;
 	int ret;
+	struct vdev_up_params params = { 0 };
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -2757,7 +2764,10 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->aid = vif->cfg.aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -7011,6 +7021,8 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
+		struct vdev_up_params params = { 0 };
+
 		arvif = (void *)vifs[i].vif->drv_priv;
 
 		if (WARN_ON(!arvif->is_started))
@@ -7051,8 +7063,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-					 arvif->bssid);
+		params.vdev_id = arvif->vdev_id;
+		params.aid = arvif->aid;
+		params.bssid = arvif->bssid;
+		ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed to bring vdev up %d: %d\n",
 				    arvif->vdev_id, ret);
@@ -7144,6 +7158,7 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	int ret;
+	struct vdev_up_params params = { 0 };
 
 	if (WARN_ON(arvif->is_started))
 		return -EBUSY;
@@ -7170,7 +7185,9 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	}
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
-		ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, 0, ar->mac_addr);
+		params.vdev_id = arvif->vdev_id,
+		params.bssid = ar->mac_addr,
+		ret = ath11k_wmi_vdev_up(ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed put monitor up: %d\n", ret);
 			return ret;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6a1d9ad699e2..f589569fec0d 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -992,7 +992,7 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -1001,7 +1001,7 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 	struct sk_buff *skb;
 	int ret;
 
-	arvif = ath11k_mac_get_arvif(ar, vdev_id);
+	arvif = ath11k_mac_get_arvif(ar, params->vdev_id);
 
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
@@ -1011,10 +1011,11 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_VDEV_UP_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
-	cmd->vdev_id = vdev_id;
-	cmd->vdev_assoc_id = aid;
 
-	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
+	cmd->vdev_id = params->vdev_id;
+	cmd->vdev_assoc_id = params->aid;
+
+	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
 
 	if (arvif && arvif->vif->type == NL80211_IFTYPE_STATION) {
 		bss_conf = &arvif->vif->bss_conf;
@@ -1035,7 +1036,7 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
 		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
-		   vdev_id, aid, bssid);
+		   params->vdev_id, params->aid, params->bssid);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 5d915adfe90c..425ca6da84d7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2612,6 +2612,12 @@ struct wmi_vdev_delete_cmd {
 	u32 vdev_id;
 } __packed;
 
+struct vdev_up_params {
+	u32 vdev_id;
+	u32 aid;
+	const u8 *bssid;
+};
+
 struct wmi_vdev_up_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -6013,8 +6019,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);
-- 
2.17.1

