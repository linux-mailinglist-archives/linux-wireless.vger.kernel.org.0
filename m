Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9574643266
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiLET0N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 14:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiLETZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 14:25:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FD431E
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 11:22:03 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FZdxc030238;
        Mon, 5 Dec 2022 19:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=uuhLWlp/9QDhbHbJC3SWG70kjxMkLuQJO3+PK9XydoE=;
 b=GqTN8e5XpIhmJ7eeS+wObxHOsw92pTFYOOWiIGzsAwPl2i+eThDAA/Io21gNut7Cv7IP
 zK5wZ1ImHFZm95jXAgXKHkmfnDLkpMNP4X4r5YIaLcKG7U3HF7aUYo20egjvfNeEfMUg
 956eozXVXx0qE8KPJi6j5K9JELPvNBWQAqGyI0pytHeMH5G+irCgd8+Hug470BqAlzaE
 sgWROKrcTTA4C8jpRpp1++hUFncJrDviV8//NHCEbViuoQmhhtmXbpX8AVOJ7F4rjHWG
 YeJNA7hbPy/6lboI0M/HzOr9Q/kq0FsXrMzpIsws2zCjtqeY9lGtxtSHNzv+fZOPLLd3 7g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7xp8n36m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 19:21:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B5JLvwn016778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 19:21:57 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 11:21:55 -0800
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCH] ath11k: Fix scan request param frame size warning
Date:   Tue, 6 Dec 2022 00:51:25 +0530
Message-ID: <20221205192125.13533-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XSk4yg9ReYygzjzuI_Ahs8yfr5zmt6G-
X-Proofpoint-GUID: XSk4yg9ReYygzjzuI_Ahs8yfr5zmt6G-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=988 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212050161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Following warning was observed

drivers/net/wireless/ath/ath11k/mac.c:2351:1: warning: the frame
size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]

A local variable is declared with a size larger than 1024 bytes
this causing a compilation warning. Change the local variable to
heap memory to fix the warning.

Tested-on: IPQ8074 AHB WLAN.HK.2.7.0.1-01701-QCAHKSWPL_SILICONZ-1 v2

Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 81 +++++++++++++++------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9e923ecb0891..34a497cb26bf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3612,7 +3612,7 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_scan_request *req = &hw_req->req;
-	struct scan_req_params arg;
+	struct scan_req_params *arg = NULL;
 	int ret = 0;
 	int i;
 	u32 scan_timeout;
@@ -3640,72 +3640,78 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;
 
-	memset(&arg, 0, sizeof(arg));
-	ath11k_wmi_start_scan_init(ar, &arg);
-	arg.vdev_id = arvif->vdev_id;
-	arg.scan_id = ATH11K_SCAN_ID;
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+
+	if (!arg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ath11k_wmi_start_scan_init(ar, arg);
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH11K_SCAN_ID;
 
 	if (req->ie_len) {
-		arg.extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
-		if (!arg.extraie.ptr) {
+		arg->extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
+		if (!arg->extraie.ptr) {
 			ret = -ENOMEM;
 			goto exit;
 		}
-		arg.extraie.len = req->ie_len;
+		arg->extraie.len = req->ie_len;
 	}
 
 	if (req->n_ssids) {
-		arg.num_ssids = req->n_ssids;
-		for (i = 0; i < arg.num_ssids; i++) {
-			arg.ssid[i].length  = req->ssids[i].ssid_len;
-			memcpy(&arg.ssid[i].ssid, req->ssids[i].ssid,
+		arg->num_ssids = req->n_ssids;
+		for (i = 0; i < arg->num_ssids; i++) {
+			arg->ssid[i].length  = req->ssids[i].ssid_len;
+			memcpy(&arg->ssid[i].ssid, req->ssids[i].ssid,
 			       req->ssids[i].ssid_len);
 		}
 	} else {
-		arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+		arg->scan_flags |= WMI_SCAN_FLAG_PASSIVE;
 	}
 
 	if (req->n_channels) {
-		arg.num_chan = req->n_channels;
-		arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
+		arg->num_chan = req->n_channels;
+		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
 					GFP_KERNEL);
 
-		if (!arg.chan_list) {
+		if (!arg->chan_list) {
 			ret = -ENOMEM;
 			goto exit;
 		}
 
-		for (i = 0; i < arg.num_chan; i++)
-			arg.chan_list[i] = req->channels[i]->center_freq;
+		for (i = 0; i < arg->num_chan; i++)
+			arg->chan_list[i] = req->channels[i]->center_freq;
 	}
 
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-		arg.scan_f_add_spoofed_mac_in_probe = 1;
-		ether_addr_copy(arg.mac_addr.addr, req->mac_addr);
-		ether_addr_copy(arg.mac_mask.addr, req->mac_addr_mask);
+		arg->scan_f_add_spoofed_mac_in_probe = 1;
+		ether_addr_copy(arg->mac_addr.addr, req->mac_addr);
+		ether_addr_copy(arg->mac_mask.addr, req->mac_addr_mask);
 	}
 
 	/* if duration is set, default dwell times will be overwritten */
 	if (req->duration) {
-		arg.dwell_time_active = req->duration;
-		arg.dwell_time_active_2g = req->duration;
-		arg.dwell_time_active_6g = req->duration;
-		arg.dwell_time_passive = req->duration;
-		arg.dwell_time_passive_6g = req->duration;
-		arg.burst_duration = req->duration;
-
-		scan_timeout = min_t(u32, arg.max_rest_time *
-				(arg.num_chan - 1) + (req->duration +
+		arg->dwell_time_active = req->duration;
+		arg->dwell_time_active_2g = req->duration;
+		arg->dwell_time_active_6g = req->duration;
+		arg->dwell_time_passive = req->duration;
+		arg->dwell_time_passive_6g = req->duration;
+		arg->burst_duration = req->duration;
+
+		scan_timeout = min_t(u32, arg->max_rest_time *
+				(arg->num_chan - 1) + (req->duration +
 				ATH11K_SCAN_CHANNEL_SWITCH_WMI_EVT_OVERHEAD) *
-				arg.num_chan, arg.max_scan_time);
+				arg->num_chan, arg->max_scan_time);
 	} else {
-		scan_timeout = arg.max_scan_time;
+		scan_timeout = arg->max_scan_time;
 	}
 
 	/* Add a margin to account for event/command processing */
 	scan_timeout += ATH11K_MAC_SCAN_CMD_EVT_OVERHEAD;
 
-	ret = ath11k_start_scan(ar, &arg);
+	ret = ath11k_start_scan(ar, arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
 		spin_lock_bh(&ar->data_lock);
@@ -3717,10 +3723,11 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				     msecs_to_jiffies(scan_timeout));
 
 exit:
-	kfree(arg.chan_list);
-
-	if (req->ie_len)
-		kfree(arg.extraie.ptr);
+	if (arg) {
+		kfree(arg->chan_list);
+		kfree(arg->extraie.ptr);
+		kfree(arg);
+	}
 
 	mutex_unlock(&ar->conf_mutex);
 

base-commit: 245927cb443050dd693ff26528d1e76a958cc7c2
-- 
2.38.0

