Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF0755A1F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 05:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGQDfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 23:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjGQDe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 23:34:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EC1A2
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 20:34:52 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H3Os0K009510;
        Mon, 17 Jul 2023 03:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=/Z8riPn3ScbJN5rDM32TSeD0fLCyWVrQNthAHxLN05A=;
 b=J2xDK3iePDClmf+Ei6s1R3vqTrZmDl8ZBx25vAU2AJ8PhsyAUu+mLOorZoJM8diHGJOC
 aW3l2HzaQ/D3CbIZVefmWQsgw2Wyv2wp1s1aOj1S+9cLwf2o57wiT/OwnHIcgVyn5JhV
 3g8KAtmMo4HVBn55KSF7zqEVRyu7141R58FoLX8n79RVtFzkz8j13USe85s/Y0DDrx9d
 89TpA8QC4b/zwv2U43ovvpyOV2+OlIUGaBPZX16lWR66/TyDSS7NMp9jcWWmsXFzFFHo
 xTTzL2dL3RYwUoJ2IClfuM327JJVOFEBN0Xm8o17JABhfJXlznK3o708UZaGR0FvJZJf ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0cabbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 03:34:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H3YkgI003397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 03:34:46 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 20:34:45 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: change to use dynamic memory for channel list of scan
Date:   Sun, 16 Jul 2023 23:34:31 -0400
Message-ID: <20230717033431.21983-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zUPQ0eN5ZfK-5Hbzi8prw-3ujUWPpIn4
X-Proofpoint-ORIG-GUID: zUPQ0eN5ZfK-5Hbzi8prw-3ujUWPpIn4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=833 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently there are about 60 channels for 6 GHz, then the size of
chan_list in struct scan_req_params which is 40 is not enough to
fill all the channel list of 6 GHz.

Use dynamic memory to save the channel list of scan.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 10 ++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ee792822b411..e3ba84f5dd68 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2767,6 +2767,14 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	if (req->n_channels) {
 		arg.num_chan = req->n_channels;
+		arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
+					GFP_KERNEL);
+
+		if (!arg.chan_list) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
 		for (i = 0; i < arg.num_chan; i++)
 			arg.chan_list[i] = req->channels[i]->center_freq;
 	}
@@ -2785,6 +2793,8 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 						      ATH12K_MAC_SCAN_TIMEOUT_MSECS));
 
 exit:
+	kfree(arg.chan_list);
+
 	if (req->ie_len)
 		kfree(arg.extraie.ptr);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 08a8c9e0f59f..0048f6a8e502 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3030,7 +3030,6 @@ enum scan_dwelltime_adaptive_mode {
 
 #define WLAN_SCAN_MAX_NUM_SSID          10
 #define WLAN_SCAN_MAX_NUM_BSSID         10
-#define WLAN_SCAN_MAX_NUM_CHANNELS      40
 
 struct ath12k_wmi_element_info_arg {
 	u32 len;
@@ -3239,7 +3238,7 @@ struct ath12k_wmi_scan_req_arg {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 chan_list[WLAN_SCAN_MAX_NUM_CHANNELS];
+	u32 *chan_list;
 	u32 notify_scan_events;
 	struct cfg80211_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
 	struct ath12k_wmi_mac_addr_params bssid_list[WLAN_SCAN_MAX_NUM_BSSID];

base-commit: 0a00db612b6df1fad80485e3642529d1f28ea084
-- 
2.40.1

