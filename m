Return-Path: <linux-wireless+bounces-21053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C87A78694
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E74416E842
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858A1925A0;
	Wed,  2 Apr 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mp2xI/sF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA07191F66;
	Wed,  2 Apr 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562009; cv=none; b=sxo+ha5ystgKTtym1VCDptE5HwX9HuYLW/L4huBW7BkL5spi39hAi1ruqtOVT8DBGb70fIMxkSmbHGrxnmt/TEfG7wcwndsGhGMVmThVBzdlsM8+fLpHRD9OIH+C2qNJfyiCCr8M/9B0Qh1W79M2ufxf911IiNbUjcfbciTnLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562009; c=relaxed/simple;
	bh=uu/FegJsB7dpd9wwwzCMc53ucsF3L57vLMQ1/7MEZxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gVMW8gKBWKy40JP/iPpu+PS71UVpomnh6prZP0ewUpNIoJcYfdM32w30hPp2TJPcvfFOMgC7QlWNqUMpEC7+yAC/sJrhR4wSwYhMR3iJ8rZZ4165qRdh75003weYCjm/pmelQHUyklafXlh3urhBYEujUsh2c0aXLC9h6nBfhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mp2xI/sF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531NfYAg002553;
	Wed, 2 Apr 2025 02:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LQB/8Xwxn+GI2VQUG0gc9ANTGXkv5eT88f7DvRvlduw=; b=mp2xI/sFcSpLWYMW
	XAvZ4e0rVJBM1gJEc9ewk3nmUQWkhcFqMdQAER+H8UvGjCj2Pzl0eoOvcS3Uofue
	4aPCcvix7jpPH12f8BVDHFbxVg3ROBsVK8PGx9RKANNAHl+DicpIAw1YRKenfvfm
	j8B46u57BUT/JPRXkLLA5lYkOIb8OVm1nRbvz4Nq0Y/D4OhG6m2HjO9z4poDMXDh
	t8po0Vt/AdI3q0zWSD+cssNwSQuRxhdcRCJv2k6ZEJVCoB83vSYd7noAcY5Cio12
	+tq/PXPPISyxIAccp+icGu3N22kHkVwUf/4gh65tSQqtuNLXAYiXBFIt1/Y2hh8m
	CDA2WA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45pa5bsu3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kUZX006272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:30 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:28 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 2 Apr 2025 10:45:48 +0800
Subject: [PATCH ath-next 9/9] wifi: ath12k: support 2 channels for single
 pdev device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-9-bad47cf00704@quicinc.com>
References: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
In-Reply-To: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1AXIsSK52P7JRn1XWVo6tzMzjXNr8bHj
X-Authority-Analysis: v=2.4 cv=YqcPR5YX c=1 sm=1 tr=0 ts=67eca507 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=TnHeXv7htJ03pNrsuFYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1AXIsSK52P7JRn1XWVo6tzMzjXNr8bHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=865 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020017

For single pdev device, radio number of a device is forced as 1 in
ath12k_wmi_ext_soc_hal_reg_caps_parse(). This leads to ah->num_radio == 1
and then in ath12k_mac_setup_iface_combinations() we report to
mac/cfg80211 that only 1 channel is supported. In MLO case, it finally
results in failing to bring up the second link as it is in another
channel.

Change num_different_channels to 2 to allow a second link. Since DFS on
multiple channels are not supported yet, remove radar_detect_widths.

For now WCN7850 is the only single pdev device, so others should not be
affected.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d1695432168bb3db054f0c65797a2d32413034ad..353f6341e1b96e533bdae5fa5697949b72f00921 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10915,13 +10915,18 @@ ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
 	comb[0].limits = limits;
 	comb[0].n_limits = n_limits;
 	comb[0].max_interfaces = max_interfaces;
-	comb[0].num_different_channels = 1;
 	comb[0].beacon_int_infra_match = true;
 	comb[0].beacon_int_min_gcd = 100;
-	comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-					BIT(NL80211_CHAN_WIDTH_20) |
-					BIT(NL80211_CHAN_WIDTH_40) |
-					BIT(NL80211_CHAN_WIDTH_80);
+
+	if (ar->ab->hw_params->single_pdev_only) {
+		comb[0].num_different_channels = 2;
+	} else {
+		comb[0].num_different_channels = 1;
+		comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+						BIT(NL80211_CHAN_WIDTH_20) |
+						BIT(NL80211_CHAN_WIDTH_40) |
+						BIT(NL80211_CHAN_WIDTH_80);
+	}
 
 	return 0;
 }

-- 
2.25.1


