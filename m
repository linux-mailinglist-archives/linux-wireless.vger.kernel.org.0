Return-Path: <linux-wireless+bounces-21297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A471AA81B02
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD81886178
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76CF1DDA1E;
	Wed,  9 Apr 2025 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NUPHQ1cV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A81DC994;
	Wed,  9 Apr 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165662; cv=none; b=ehupHxcX7pQYt6S7hiTV5xGlkXmctzcdn1Ks3Ko7AJVXne7jUIm8SfeN1tD0y8DxI8ZwdKyuGBRhfTzlMxzrWdeB2ADdm2WpVYbGuQHfqVJB2yBceH7NDAboTTj9Spkr/Hcm71QbaBqSfk+h2s//2AtKzl6pnsXaEAzhdpm6rVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165662; c=relaxed/simple;
	bh=vTERchSMbPXnDXvIUDxNM8KwP6K9+Qg2yc85dcqrmyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ym+V1Q0CFE6Fj6ZloTVkbS6h8X6P/TXxEYQBolF2FOWYCR32WLYWeKPFBrBstzJol17SP2qBvIIh+tgFyLUHeZzc32+srDpLE+Pqm7ld6MlK8u+EPvAMgqBGKa0zzK2zt7vSedg+I1X+2fxqWWBnWfw6M7PyldghSbiT1nB4+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NUPHQ1cV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYuC1002276;
	Wed, 9 Apr 2025 02:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kblOBgep6gQ5/QGu8qfiBTUh3VUI/YUVbJDl1VsbaF8=; b=NUPHQ1cVt6cOqski
	BiDzH2Mw5rxRSCAx4eJPGS41LEZoOxrRFzzhh8SHG9UC+aFGXCg5XIsXdtlV8j9C
	7q0rlrr/5alnZwClxyv122ECRuqdfLWWdwJjFkt+7rl+IdLWDJgesuUdnlv/ahUQ
	4wayPA/Czqsmk6nCMRYKVjYt8e8BbbaL6q0R9POicQ/3nCk5uz/E+rLu78MhIUEa
	p2HT3rm8J3GlARjKYy+p2wSBCvVHkbNg7GEy3KH4lSJM+mQNoqhat/q7e67m7N6z
	v5OGY5RkE8Kx68tZ8P0qliAuCmisLUQRHq+amHc0iuypt8vNegpffdn5jsStxwZp
	A+KJIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1hp8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392RTLV024671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:29 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:27 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 9 Apr 2025 10:26:42 +0800
Subject: [PATCH ath-next v2 9/9] wifi: ath12k: support 2 channels for
 single pdev device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-9-3801132ca2c3@quicinc.com>
References: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
In-Reply-To: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: auX4VBG--qoT2tspE2mw4xa-Iyx4fb-q
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f5db12 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=TnHeXv7htJ03pNrsuFYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: auX4VBG--qoT2tspE2mw4xa-Iyx4fb-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

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
index 699772a471f5f81c42009b529e756fa75bca0779..ac15527571dda60c69c898488ee06a21aa635163 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11082,13 +11082,18 @@ ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
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


