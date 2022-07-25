Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA39D57F93F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiGYF4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 01:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiGYF4V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 01:56:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62027DC8
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 22:56:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P4tUfY029155;
        Mon, 25 Jul 2022 05:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NOqkEubAoyp1Ev+EWNy3qvCSk60XVjX4/dfvqanxdz8=;
 b=INgVaqr50qPpdp7R9vIQT8aKLXjgrRGSboFAp5tRzqmJ3o3Ee5FQzTXxkzCM7wIPbh0v
 K85758Bwsi9vzXjH7gG4yUlmEp3BURzCMIJiBz8GEGXPpT+8FGwUoso6fyg+Z7AY+aKK
 EPHioK2FXtA2AVirIRiAq77Kwmpzmvi9ej7SF/Nfz4FPGZPYT5cBRABvaogbfXMNPRWs
 aHn3tRrlzkWSJIWRW18BXPJUcjH05ZZ0/IOYJ8E5NbNeWZm4ol6M1AIN15rQS/O2xd1M
 QJdSKPwEgDzAe+oRBCSetnp5OqvOV4IJmYO/qANxsqySPyx0X81SKdVy04FBJhSwPtj1 /g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hga5sk71c-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 05:56:15 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26P5oS7X016373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 05:50:28 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Jul 2022 22:50:28 -0700
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Jul 2022 22:50:26 -0700
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCHv2] ath11k: Add spectral scan support for 160 MHz
Date:   Mon, 25 Jul 2022 11:20:01 +0530
Message-ID: <20220725055001.15194-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uvcCWOcxD2BOAI0gJrguLnDalW_gV1Qs
X-Proofpoint-GUID: uvcCWOcxD2BOAI0gJrguLnDalW_gV1Qs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207250025
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two types of 160 MHz spectral scan support mentioned below

1. Fragmented approach
2. Single event approach

In this fragmented approach, single 160 MHz will be split as two
80 MHz buffer. First fft sample buffer will contain spectral scan
result of primary 80 MHz and the second fft sample buffer will contain
secondary 80 MHz and here cfreq1 and cfreq2 will be mentioned.
In case of 160 MHz on 36th channel will contain cfreq1 as 5210 and
cfreq2 as 5290. Chipsets which support this approach are IPQ8074/IPQ6018.

Replacing freq1 with freq2 in every secondary sepctral scan event to
distinguish between two different 80 MHz spectral event data.

In the 2nd approach each fft sample buffer will contain spectral scan
result for whole 160 MHz by mentioning cfreq1 as 5250 which is center
frequency of whole 160 MHz. Chipset which support this approach is QCN9074.

Host will receive spectral event from target for every 5 fft samples.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01120-QCAHKSWPL-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01120-QCAHKSWP

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
v2:
  * CC to linux-wireless 

 drivers/net/wireless/ath/ath11k/core.c     |  7 +++++++
 drivers/net/wireless/ath/ath11k/hw.h       |  1 +
 drivers/net/wireless/ath/ath11k/spectral.c | 21 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/spectral.h |  1 +
 4 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c8e0bc935838..1b1ff26cdfca 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -73,6 +73,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.summary_pad_sz = 0,
 			.fft_hdr_len = 16,
 			.max_fft_bins = 512,
+			.fragment_160mhz = true,
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -149,6 +150,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.summary_pad_sz = 0,
 			.fft_hdr_len = 16,
 			.max_fft_bins = 512,
+			.fragment_160mhz = true,
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -225,6 +227,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.summary_pad_sz = 0,
 			.fft_hdr_len = 0,
 			.max_fft_bins = 0,
+			.fragment_160mhz = false,
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -299,6 +302,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.summary_pad_sz = 16,
 			.fft_hdr_len = 24,
 			.max_fft_bins = 1024,
+			.fragment_160mhz = false,
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -375,6 +379,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.summary_pad_sz = 0,
 			.fft_hdr_len = 0,
 			.max_fft_bins = 0,
+			.fragment_160mhz = false,
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -450,6 +455,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.summary_pad_sz = 0,
 			.fft_hdr_len = 0,
 			.max_fft_bins = 0,
+			.fragment_160mhz = false,
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -524,6 +530,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.summary_pad_sz = 0,
 			.fft_hdr_len = 0,
 			.max_fft_bins = 0,
+			.fragment_160mhz = false,
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 77dc5c851c9b..cd0e18acc250 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -169,6 +169,7 @@ struct ath11k_hw_params {
 		u8 summary_pad_sz;
 		u8 fft_hdr_len;
 		u16 max_fft_bins;
+		bool fragment_160mhz;
 	} spectral;
 
 	u16 interface_modes;
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 516a7b4cd180..8fdcb161a1e4 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -30,6 +30,7 @@
 #define ATH11K_SPECTRAL_20MHZ			20
 #define ATH11K_SPECTRAL_40MHZ			40
 #define ATH11K_SPECTRAL_80MHZ			80
+#define ATH11K_SPECTRAL_160MHZ			160
 
 #define ATH11K_SPECTRAL_SIGNATURE		0xFA
 
@@ -183,6 +184,8 @@ static int ath11k_spectral_scan_trigger(struct ath11k *ar)
 	if (ar->spectral.mode == ATH11K_SPECTRAL_DISABLED)
 		return 0;
 
+	ar->spectral.is_primary = true;
+
 	ret = ath11k_wmi_vdev_spectral_enable(ar, arvif->vdev_id,
 					      ATH11K_WMI_SPECTRAL_TRIGGER_CMD_CLEAR,
 					      ATH11K_WMI_SPECTRAL_ENABLE_CMD_ENABLE);
@@ -585,6 +588,7 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 	u8 chan_width_mhz, bin_sz;
 	int ret;
 	u32 check_length;
+	bool fragment_sample = false;
 
 	lockdep_assert_held(&ar->spectral.lock);
 
@@ -639,6 +643,13 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 	case ATH11K_SPECTRAL_80MHZ:
 		fft_sample->chan_width_mhz = chan_width_mhz;
 		break;
+	case ATH11K_SPECTRAL_160MHZ:
+		if (ab->hw_params.spectral.fragment_160mhz) {
+			chan_width_mhz /= 2;
+			fragment_sample = true;
+		}
+		fft_sample->chan_width_mhz = chan_width_mhz;
+		break;
 	default:
 		ath11k_warn(ab, "invalid channel width %d\n", chan_width_mhz);
 		return -EINVAL;
@@ -663,6 +674,16 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 	freq = summary->meta.freq2;
 	fft_sample->freq2 = __cpu_to_be16(freq);
 
+	/* If freq2 is available then the spectral scan results are fragmented
+	 * as primary and secondary
+	 */
+	if (fragment_sample && freq) {
+		if (!ar->spectral.is_primary)
+			fft_sample->freq1 = freq;
+		/* We have to toggle the is_primary to handle the next report */
+		ar->spectral.is_primary = !ar->spectral.is_primary;
+	}
+
 	ath11k_spectral_parse_fft(fft_sample->data, fft_report->bins, num_bins,
 				  ab->hw_params.spectral.fft_sz);
 
diff --git a/drivers/net/wireless/ath/ath11k/spectral.h b/drivers/net/wireless/ath/ath11k/spectral.h
index 081744265f2a..96bfa16e18e9 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.h
+++ b/drivers/net/wireless/ath/ath11k/spectral.h
@@ -35,6 +35,7 @@ struct ath11k_spectral {
 	u16 count;
 	u8 fft_size;
 	bool enabled;
+	bool is_primary;
 };
 
 #ifdef CONFIG_ATH11K_SPECTRAL
-- 
2.17.1

