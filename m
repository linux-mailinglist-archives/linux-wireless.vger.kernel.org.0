Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27AD6541A2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiLVNSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 08:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiLVNSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 08:18:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196612B273
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 05:17:53 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMD79iA029538;
        Thu, 22 Dec 2022 13:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=y3JX71rxIgnm8nw9luwtEjhpjJ1Mu5f9AxtFjcwkcuw=;
 b=Ns9N7CI5L40fTg5pQYczusZKijOEgv13DpNjJB+1da+dWakSYQrKtYbgkkkXk5aQVwJK
 nMugtDh04coN24wZoGio2VPTLvd6yvuqzZ+q8TuYJmNRLYsUNmexK4TYQftiXW/rX/gB
 gUDirQ19HVGA4/sm7Bazu5O+Ut7oqApuMjcpZvqJXkGuzILcVrWsVkU5HlKjtYiACAm+
 fxMDYQwk7oRoAt4mZ9kQJCaVPVcgnnOicHe1grqxTd5zsx1axlNfCStERUtqOU+vD0jI
 qylvZz1uENwOSnJEXfGB5Shgw0wPXNK+TyFvvaZpLIacf5G2E3jrMEDwwsoCxrJmASjP 5g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm0wfjsnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 13:17:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMDHiqJ030920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 13:17:44 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 05:17:42 -0800
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH] wifi: ath11k: Set ext passive scan flag to adjust passive scan start time
Date:   Thu, 22 Dec 2022 18:47:20 +0530
Message-ID: <20221222131720.11368-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2BPrJSY2EgvAWivaEdVY7Yf27wFZvgnG
X-Proofpoint-GUID: 2BPrJSY2EgvAWivaEdVY7Yf27wFZvgnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_06,2022-12-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set the WMI_SCAN_FLAG_EXT_PASSIVE_SCAN_START_TIME_ENHANCE flag
while sending the scan command.  If this flag is enabled when the
incoming scan request comes with a strict start time and its duration
overlaps with next TBTT, then target adjust the start time accordingly
for passive scan. Target supporting this feature will advertise
WMI_TLV_SERVICE_PASSIVE_SCAN_START_TIME_ENHANCE.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 7 +++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2a8a3e3dcff6..c786c5097ae3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2068,6 +2068,11 @@ void ath11k_wmi_start_scan_init(struct ath11k *ar,
 				  WMI_SCAN_EVENT_FOREIGN_CHAN |
 				  WMI_SCAN_EVENT_DEQUEUED;
 	arg->scan_flags |= WMI_SCAN_CHAN_STAT_EVENT;
+
+	if (test_bit(WMI_TLV_SERVICE_PASSIVE_SCAN_START_TIME_ENHANCE,
+		     ar->ab->wmi_ab.svc_map))
+		arg->scan_ctrl_flags_ext |= WMI_SCAN_FLAG_EXT_PASSIVE_SCAN_START_TIME_ENHANCE;
+
 	arg->num_bssid = 1;
 
 	/* fill bssid_list[0] with 0xff, otherwise bssid and RA will be
@@ -2149,6 +2154,8 @@ ath11k_wmi_copy_scan_event_cntrl_flags(struct wmi_start_scan_cmd *cmd,
 	/* for adaptive scan mode using 3 bits (21 - 23 bits) */
 	WMI_SCAN_SET_DWELL_MODE(cmd->scan_ctrl_flags,
 				param->adaptive_dwell_time_mode);
+
+	cmd->scan_ctrl_flags_ext = param->scan_ctrl_flags_ext;
 }
 
 int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8f2c07d70a4a..5583582b8afa 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2092,6 +2092,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT = 246,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
+	WMI_TLV_SERVICE_PASSIVE_SCAN_START_TIME_ENHANCE = 263,
 
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
@@ -3222,6 +3223,7 @@ struct  wmi_start_scan_cmd {
 
 #define WMI_SCAN_DWELL_MODE_MASK 0x00E00000
 #define WMI_SCAN_DWELL_MODE_SHIFT        21
+#define WMI_SCAN_FLAG_EXT_PASSIVE_SCAN_START_TIME_ENHANCE   0x00000800
 
 enum {
 	WMI_SCAN_DWELL_MODE_DEFAULT      = 0,
@@ -3269,6 +3271,7 @@ struct scan_req_params {
 		};
 		u32 scan_events;
 	};
+	u32 scan_ctrl_flags_ext;
 	u32 dwell_time_active;
 	u32 dwell_time_active_2g;
 	u32 dwell_time_passive;
-- 
2.17.1

