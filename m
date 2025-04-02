Return-Path: <linux-wireless+bounces-21047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D678EA7868A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C233AD8C7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2AF142E83;
	Wed,  2 Apr 2025 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nB7Uf2M9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FAF13D8B2;
	Wed,  2 Apr 2025 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743561999; cv=none; b=FrSUOZe9vkSDmIDeRw6Bih+zdkkPuhE5cXfdpNrU35SzajSymE+wZqouSNYhMtm+LSjpj/3OBdquycKIBGCxn4ZPl12X7j/M3AdXeFPRbzqRbI9blCgstqUUW7qprX14hdDc6O6HSBhsc4QNY1XZ/gD08cPQanq1FAno3MNddAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743561999; c=relaxed/simple;
	bh=IVupeRXInyROFU3iaL/kgkLA9DYgirFZJk6yDTEKq0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bf4MG7XVzMbRf0GRvrsd+EHykGIonnU0s+CC/SvE7WBDjiKcIN2c8GaL3WX0WY00D4KcJBOG1OJ/2ign+LkgLw0EdtSHzIXoRKIRWqBBV5trWRIqpTh7J61IL0OqrizrymzsrJi+QgVXY/btnFyU1R7PBEeaKLjlunGkTdTZRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nB7Uf2M9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53218K3n023292;
	Wed, 2 Apr 2025 02:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	18Ex138EkfIUKLdaGwIhfHBs9wqFVmZ+17f1exzbNUM=; b=nB7Uf2M9OLeGlbJ3
	jZhRg8WuDNiEyN/PHa1aNh3gDJg9Km2ssEfGwC87frZr7R5djDJ5hFRCehl4XB37
	0GKOcOkYapQQJmvszVYGJhBXtDnT1KKl/6Ki847hZgwnOW+sFFaPZn1gsWBu0b9d
	JujTdZvzHrjJJB/nHuAxxB0Zt5WtbB0RuHjZVUHoJG6IT7/YjbKahUJFmFT4lTJA
	1mPXGSilUlZbuHmwr98uN/BoRk7Ts48ZvWhv1baDtHHDAAlERVT24vij8e3wU41/
	X8kphTC5v/G+JSp03Mif8unljZTBFtqHzHEqc0faqJp+77JuRqxsaoQWDfVzBCC3
	myE8sw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ruadr6ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kGkT006122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:16 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:14 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 2 Apr 2025 10:45:41 +0800
Subject: [PATCH ath-next 2/9] wifi: ath12k: use fw_features only when it is
 valid
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-2-bad47cf00704@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=VI/dn8PX c=1 sm=1 tr=0 ts=67eca4f8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=aOhJHzjgUxcndhPc63EA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -0LnMFtntGnWKNTKOV-JJCbYrDwuo6y-
X-Proofpoint-GUID: -0LnMFtntGnWKNTKOV-JJCbYrDwuo6y-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=836 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020017

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
index 4c0bc9647619aeed717034cf0819b7b3db495f30..2a7d7a185aef1052b5644a9181d8a8e31bd25897 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1068,6 +1068,7 @@ struct ath12k_base {
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


