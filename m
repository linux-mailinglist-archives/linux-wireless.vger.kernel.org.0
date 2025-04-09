Return-Path: <linux-wireless+bounces-21290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E29A81AF0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CB71B66150
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FDC1B85F8;
	Wed,  9 Apr 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RA3Bs1bF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D51ADC83;
	Wed,  9 Apr 2025 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165646; cv=none; b=ssvWdjeVyqcAgyu3rkh9b1aUcEX8iijoRMAtqoUemBElIz0u81Ui+Sr45CB6JHAi3kP9eF7I0EXVspd3qQq63GHlta3Co6w0IhcAeL84/AwpMEqALqJA1eWWC2Rd94obcQhRT7owu5oTgorroqPyitVKmYLBjLYcOEyYxAbK/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165646; c=relaxed/simple;
	bh=vJPtwy1fudiRzB66VjroHXKc8VJEq96NylYneV4KwT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SSbKaAtcqQ1ZpTj45eR3eTtY/2w6LKrdyjxZUfFHG1TuJJIO+P9JX66FHo3PfjH5Xhy1jGMk0blV7EAz84YYER62rtU0JWtQ8oPKqBvM8tJh+gVGKUFLx24XFMRB7xDue5hjthWNOVFD/kl34k7yq7vvYSA1XfT1w5K+28nQSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RA3Bs1bF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYrBh010454;
	Wed, 9 Apr 2025 02:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	orBq9rjMYLgNfF+XZOAKa7+A5KZQuBAQGmmGraSUlzE=; b=RA3Bs1bF/qcFI4tZ
	U1FZqSOGbHWF6SgnzOMXw57EjNYRBcRfFccBtT3yAntp8Lm0IfE3OrSApq2Z13mo
	/27a4UsHGXGXlA/bT5Btxwd2SF1XsO/cz+qMphlPQCueT/7H7uJk6PpZKSkNW/Yt
	Pd6I5oChXa/HHhb7AVFwybt9K2ZeSOaIeRgmBcuZlRCyTIc0PQpyAUydebLryW40
	fK6EEfRD5e5XBdbmVhauXca1wWT30CfaWXWAvi5mg3mjzZUKYn2RYEJH2sgUhNCU
	bi2NIG+sK4UoiEXjonkPJYihlzhIR04BX6otI2ihc4f0SMCzF9k6YTuegN8pzrEP
	w/OynQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfthmy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392REkQ000936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:14 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:13 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 9 Apr 2025 10:26:35 +0800
Subject: [PATCH ath-next v2 2/9] wifi: ath12k: use fw_features only when it
 is valid
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-2-3801132ca2c3@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f5db03 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=aOhJHzjgUxcndhPc63EA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UUDtJ7yFuNE0UIbaOoqQAse_HklZWriS
X-Proofpoint-ORIG-GUID: UUDtJ7yFuNE0UIbaOoqQAse_HklZWriS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=829
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

Currently fw_features is used to check if a specific feature is supported
or not: if the feature bit is set the feature is believed to be supported,
otherwise not supported. Since fw_features is populated only when using
firmware API-2, and by default it is zero, in case of API-1 such as
WCN7850 firmware it is possible that a feature is not enabled by host
while actually firmware supports it.

To avoid this, add a new flag indicating whether fw_features has been ever
populated or not, and only when that flag is true we choose to believe
fw_features. This benefits firmware MLO capability validation in an
upcoming patch.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 1 +
 drivers/net/wireless/ath/ath12k/fw.c   | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e8d2a0c859f6260d48c4c636793cf3a24c1c61b6..eebfb20cb089db0ce126ecf7f658bb15861d38c0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1085,6 +1085,7 @@ struct ath12k_base {
 		size_t m3_len;
 
 		DECLARE_BITMAP(fw_features, ATH12K_FW_FEATURE_COUNT);
+		bool fw_features_valid;
 	} fw;
 
 	const struct hal_rx_ops *hal_rx_ops;
diff --git a/drivers/net/wireless/ath/ath12k/fw.c b/drivers/net/wireless/ath/ath12k/fw.c
index af8b87ca4ccbe748974d17955397b4b23b52e8a8..5ac497f80cad8718fff5979f2a9cdd9116c7d01e 100644
--- a/drivers/net/wireless/ath/ath12k/fw.c
+++ b/drivers/net/wireless/ath/ath12k/fw.c
@@ -99,6 +99,8 @@ static int ath12k_fw_request_firmware_api_n(struct ath12k_base *ab,
 					__set_bit(i, ab->fw.fw_features);
 			}
 
+			ab->fw.fw_features_valid = true;
+
 			ath12k_dbg_dump(ab, ATH12K_DBG_BOOT, "features", "",
 					ab->fw.fw_features,
 					sizeof(ab->fw.fw_features));
@@ -172,5 +174,5 @@ void ath12k_fw_unmap(struct ath12k_base *ab)
 
 bool ath12k_fw_feature_supported(struct ath12k_base *ab, enum ath12k_fw_features feat)
 {
-	return test_bit(feat, ab->fw.fw_features);
+	return ab->fw.fw_features_valid && test_bit(feat, ab->fw.fw_features);
 }

-- 
2.25.1


