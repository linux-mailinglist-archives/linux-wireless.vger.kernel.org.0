Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7966BAF26
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 12:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCOLXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 07:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjCOLW7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 07:22:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6C27494
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 04:21:58 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALWEN020426;
        Wed, 15 Mar 2023 11:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=mk0gViEScbC7HRTZi71iZA9jTnxSr2RtgBhSccdKyV0=;
 b=h/LlMfeFd5GaN4q2rMQYA8TmoEmGyFG2dwA+G6tz6F26hFt6Ua7kgaJR2juoxdWlbMot
 ZWHNnz5fHNTG2nQwf8hDy2/oUeNcIJeJsil0+/V4hS2Qe8Y8VAPpA75HfzIifEvhmbZL
 VdlyiTvMqPojgEgWFgfq7HUFFy9zkflcu0CyC/lpak4Gybs6vTYAk5yAFfSpYHII2qUh
 Zbz8SelxTWz+oDzMbx7jXktDnHNPJjzOvFlx7e010E+wHKanrbjbW2rPpKDrspXpUwXt
 LrYdKxmkOyeGug12oE7BOgkhBa24cZ6pXVdvd4p+F/EDjj20HoCOexOmCvLpNzWWP8Lh JA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c5sar7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 11:21:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FBLN4C025353
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 11:21:23 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 04:21:21 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3] wifi: ath11k: Optimize 6 GHz scan time
Date:   Wed, 15 Mar 2023 16:51:03 +0530
Message-ID: <20230315112103.18426-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zNVjKvB6kUm7DWQIRqyqvWyiZw1m_3vJ
X-Proofpoint-GUID: zNVjKvB6kUm7DWQIRqyqvWyiZw1m_3vJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, time taken to scan all supported channels on WCN6750
is ~8 seconds and connection time is almost 10 seconds. WCN6750
supports three Wi-Fi bands (i.e., 2.4/5/6 GHz) and the numbers of
channels for scan come around ~100 channels (default case).
Since the chip doesn't have support for DBS (Dual Band Simultaneous),
scans cannot be parallelized resulting in longer scan times.

Among the 100 odd channels, ~60 channels are in 6 GHz band. Therefore,
optimizing the scan for 6 GHz channels will bring down the overall
scan time.

WCN6750 firmware has support to scan a 6 GHz channel based on co-located
AP information i.e., RNR IE which is found in the legacy 2.4/5 GHz scan
results. When a scan request with all supported channel list is enqueued
to the firmware, then based on WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND
scan channel flag, firmware will scan only those 6 GHz channels for which
RNR IEs are found in the legacy scan results.

In the proposed design, based on NL80211_SCAN_FLAG_COLOCATED_6GHZ scan
flag, driver will set the WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND flag
for non-PSC channels. Since there is high probability to find 6 GHz APs
on PSC channels, these channels are always scanned. Only non-PSC channels
are selectively scanned based on cached RNR information from the legacy
scan results.

If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set in the scan flags,
then scan will happen on all supported channels (default behavior).

With these optimizations, scan time is improved by 1.5-1.8 seconds on
WCN6750. Similar savings have been observed on WCN6855.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
V3:
 - Rebased on ToT

V2:
 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.h |  4 ++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cad832e0e6b8..ce5a7a912a10 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3819,8 +3819,29 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 			goto exit;
 		}
 
-		for (i = 0; i < arg->num_chan; i++)
-			arg->chan_list[i] = req->channels[i]->center_freq;
+		for (i = 0; i < arg->num_chan; i++) {
+			if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
+				     ar->ab->wmi_ab.svc_map)) {
+				arg->chan_list[i] =
+					u32_encode_bits(req->channels[i]->center_freq,
+							WMI_SCAN_CONF_PER_CH_CHANNEL_MASK);
+
+				/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
+				 * flags, then scan all PSC channels in 6 GHz band and
+				 * those non-PSC channels where RNR IE is found during
+				 * the legacy 2.4/5 GHz scan.
+				 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
+				 * then all channels in 6 GHz will be scanned.
+				 */
+				if (req->channels[i]->band == NL80211_BAND_6GHZ &&
+				    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
+				    !cfg80211_channel_is_psc(req->channels[i]))
+					arg->chan_list[i] |=
+						WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
+			} else {
+				arg->chan_list[i] = req->channels[i]->center_freq;
+			}
+		}
 	}
 
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b23b7a22bc9a..dddd279233ec 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2100,6 +2100,7 @@ enum wmi_tlv_service {
 
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
+	WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL = 265,
 	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
 	WMI_TLV_SERVICE_BIOS_SAR_SUPPORT = 326,
 
@@ -3249,6 +3250,9 @@ struct  wmi_start_scan_cmd {
 #define WMI_SCAN_DWELL_MODE_SHIFT        21
 #define WMI_SCAN_FLAG_EXT_PASSIVE_SCAN_START_TIME_ENHANCE   0x00000800
 
+#define WMI_SCAN_CONF_PER_CH_CHANNEL_MASK	GENMASK(19, 0)
+#define WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND	BIT(20)
+
 enum {
 	WMI_SCAN_DWELL_MODE_DEFAULT      = 0,
 	WMI_SCAN_DWELL_MODE_CONSERVATIVE = 1,

base-commit: 3df3715e556027e94246b2cb30986563362a65f4
-- 
2.17.1

