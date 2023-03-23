Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C76C5F7D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 07:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWGJs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 02:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCWGJr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 02:09:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD837ECD
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 23:09:45 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MNfKi9012910;
        Thu, 23 Mar 2023 06:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=M4ItVk8QfVYfrnAt2kBh+adacs4UMT/3Iy5qeCUC51s=;
 b=GAOMmWFipJzn2Ixh1PN1U5F+UjUh5S/jqglhfpndh+5zyAVTS1CubGAxeEUvs6o+8cld
 Y+P+lbW8/ABHNZ6IDg+O+po4CocnE3nU5hchD5xRwbb3wwNmagYK+KQ/46Yl+HeuE9xM
 RBPfYI+Way70Hx1NGM76atdo4quASPHRIStXiohAbDGPPKFk4FsLQ7YZYTR2AWctQd91
 YziE2MfFucIq6QSTDjkM4HQOlJ4PyDr7kWYz1e1f2gRALuhuXb6J+cM/4QKBatC++WfM
 MEaPyEqbYZj/vD/oJ06dVmBuCK1YN1hbM4ewJlcnCOCQxn8wZjH1+e9nv147Ld++e6+1 /Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfyy72fnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:09:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N69W4F012128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:09:32 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 23:09:30 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v4] wifi: ath11k: Optimize 6 GHz scan time
Date:   Thu, 23 Mar 2023 11:39:13 +0530
Message-ID: <20230323060913.10097-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZO7n91GgyhER3IHT8F2W1w0ZUayWxLBN
X-Proofpoint-ORIG-GUID: ZO7n91GgyhER3IHT8F2W1w0ZUayWxLBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230047
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
V4:
 - s/WMI_SCAN_CONF_PER_CH_CHANNEL_MASK/WMI_SCAN_CONFIG_PER_CHANNEL_MASK
 - Rebased on ToT

V3:
 - Rebased on ToT

V2:
 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.h |  4 ++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cad832e0e6b8..c81b238d0d91 100644
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
+							WMI_SCAN_CONFIG_PER_CHANNEL_MASK);
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
index b23b7a22bc9a..86b22f2cec12 100644
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
 
+#define WMI_SCAN_CONFIG_PER_CHANNEL_MASK	GENMASK(19, 0)
+#define WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND	BIT(20)
+
 enum {
 	WMI_SCAN_DWELL_MODE_DEFAULT      = 0,
 	WMI_SCAN_DWELL_MODE_CONSERVATIVE = 1,

base-commit: 584e56beffc20c9f6f3dd624137b217558b07cfa
-- 
2.17.1

