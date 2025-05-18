Return-Path: <linux-wireless+bounces-23132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D04ABB147
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 20:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815E116E837
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5C22128E;
	Sun, 18 May 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D7dGIE4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27C20D509;
	Sun, 18 May 2025 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592609; cv=none; b=A93vzBhZt/nBV6np20BH16xrhHWQXpDlKEq4y3GqYRC1bhn8VgA/nXsPdpQoxPX+5f9efxb9Hc6jf+y8W3cTsyoqr0vmrhdpxYKMpRUtc/WhsutPPVMEQJ5kuxwTCjD5lBsgLcX14yhx72ZYJL2il4ytPJOSRblHXC7CMwz1AiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592609; c=relaxed/simple;
	bh=536Tuzvzvha6zeRlaxBJCzpsBBHN9FlgJEYTLT56Ql8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=quoqvzzlwTy6F9QpYppp/HV8kUmiahMGoAj1NCOXIyO824SPZE1KN/HZjnpx3SMp2BILpvLbzt4zslvfh2aMFaGLL9V72xLXEhuYl0QT7OnrKqz9w2vjvHSQMbMZNFzB7kXDTe+e/+0wILSyHfwDlop3+WXhg/SdIwYtXMy9+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D7dGIE4v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IHWuA1024893;
	Sun, 18 May 2025 18:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uYaUhtINZcWT6JkhUGSbCfjmleK1bBZQc/aVQAQWx2w=; b=D7dGIE4vISG7AN1m
	VhWSttbeVTUlcwpBAl2OMzk2uwCrnJOB1lIb1QNNEelr6qBikiktKctp5Dmm8L0d
	uUtv7ySr7EdGSrVZq0vhta6ztL3nklYe3Q02/2TNHtYRxKsBCFy3yyatxC8VaUS0
	GrckT6Eg0GjzO2g7N98geGGsKCT1ROnjJU52VC28UB8nuMYtA5HMRk8QWl2uG67i
	KKw0OQxkMGVEV3lX28bwhYaz0VXZuW7gB1VsnjS027JdWxq9eux6QYBWknHwppK1
	uC/tiOZW4cu6sdtLlnZeocus4YuXkvTfNsrt5tWr85U2M9RRwoNjxrrDMm3ywYZT
	QFqZ3Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4ta3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54IIN8OO005499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:08 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 May 2025 11:23:05 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Sun, 18 May 2025 23:52:31 +0530
Subject: [PATCH ath-next v2 4/5] wifi: ath12k: Add CE remap hardware
 parameters for IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250518-ath12k-ipq5424-v2-4-ef81b833dc97@quicinc.com>
References: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
In-Reply-To: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Saravanakumar
 Duraisamy" <quic_saradura@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=dIimmPZb c=1 sm=1 tr=0 ts=682a258d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=m1Vj78-zd62aTB8gf0QA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sjMMSo02zXP1ejqrRlkUf_fOlg56C4fl
X-Proofpoint-GUID: sjMMSo02zXP1ejqrRlkUf_fOlg56C4fl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDE3OSBTYWx0ZWRfX7y+vpzVT8IAC
 J9LDwVmJwklvKR5iRFn+n3yhtLEfMpu9WLmG597Stq+E8duG9fqnE17PeHs8gAklTGnHs9z1kmQ
 kIiDWfyfIYDYdZlvYAZYitzSMJbRr5F5wG/wI4fMbnNkXqWer1uwoAcYrWOEG4eKhK3FJLKI01i
 y8eFZykrnpdxio8WDpMeRX/WzIL39wpAQ+H4Dc8PgsCm37Kunk0+LhwNYIgXcTscSBAcSZauf//
 lQRw0OKhS7cUDJ4T2z/dewBD2xOvzfGKM+W80GdHZkzNG0W/7iDc5Vj7firwt51Vo4Jm5c6mn2q
 XsW8Txt1tb+l+FanceV/OVuj+HaR9D//NKDUaFhsjvVsl1v3iffAcXrDwL4m2moZ38L9MlV85IG
 5Dj/YisBFmF6w/B+spqSgpsE07agdbIAFG0hUCXwckOtdzN7txplKV4GwSRBEn9o7iVQnbqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505180179

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add CE remap hardware parameters for new Ath12k AHB device IPQ5424.

Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.5-01053-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c |  2 +-
 drivers/net/wireless/ath/ath12k/ce.h  | 13 +++++++++----
 drivers/net/wireless/ath/ath12k/hw.c  | 21 ++++++++++++++++-----
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 636dfe237a7946c621b304268d057c1a6228b1c8..40690cef7e57d121c6c41765048d8e64c9320b02 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -935,7 +935,7 @@ static int ath12k_ahb_resource_init(struct ath12k_base *ab)
 			goto err_mem_unmap;
 		}
 		ab->ce_remap = true;
-		ab->ce_remap_base_addr = HAL_IPQ5332_CE_WFSS_REG_BASE;
+		ab->ce_remap_base_addr = ce_remap->base;
 	}
 
 	ab_ahb->xo_clk = devm_clk_get(ab->dev, "xo");
diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 57f75899ee03d63479698011fc081936677f8698..3ac7f28d2c9282e95ee731b86232f71ca06679c1 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -38,10 +38,15 @@
 #define PIPEDIR_INOUT		3 /* bidirectional */
 #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
 
-/* CE address/mask */
-#define CE_HOST_IE_ADDRESS	0x75804C
-#define CE_HOST_IE_2_ADDRESS	0x758050
-#define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
+/* IPQ5332 CE address/mask */
+#define CE_HOST_IPQ5332_IE_ADDRESS	0x75804C
+#define CE_HOST_IPQ5332_IE_2_ADDRESS	0x758050
+#define CE_HOST_IPQ5332_IE_3_ADDRESS	CE_HOST_IPQ5332_IE_ADDRESS
+
+/* IPQ5424 CE address/mask */
+#define CE_HOST_IPQ5424_IE_ADDRESS	0x21804C
+#define CE_HOST_IPQ5424_IE_2_ADDRESS	0x218050
+#define CE_HOST_IPQ5424_IE_3_ADDRESS	CE_HOST_IPQ5424_IE_ADDRESS
 
 #define CE_HOST_IE_3_SHIFT	0xC
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 05e2010173340bc3c0481aadf710a6894efd92bb..75042298888ca70ca55a2793b12891e45db618e4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1329,9 +1329,15 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
 };
 
 static const struct ce_ie_addr ath12k_ce_ie_addr_ipq5332 = {
-	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie1_reg_addr = CE_HOST_IPQ5332_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5332_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5332_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+};
+
+static const struct ce_ie_addr ath12k_ce_ie_addr_ipq5424 = {
+	.ie1_reg_addr = CE_HOST_IPQ5424_IE_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5424_IE_2_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5424_IE_3_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
 };
 
 static const struct ce_remap ath12k_ce_remap_ipq5332 = {
@@ -1339,6 +1345,11 @@ static const struct ce_remap ath12k_ce_remap_ipq5332 = {
 	.size = HAL_IPQ5332_CE_SIZE,
 };
 
+static const struct ce_remap ath12k_ce_remap_ipq5424 = {
+	.base = HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.size = HAL_IPQ5424_CE_SIZE,
+};
+
 static const struct ath12k_hw_params ath12k_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -1749,8 +1760,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.iova_mask = 0,
 		.supports_aspm = false,
 
-		.ce_ie_addr = NULL,
-		.ce_remap = NULL,
+		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5424,
+		.ce_remap = &ath12k_ce_remap_ipq5424,
 		.bdf_addr_offset = 0x940000,
 
 		.dp_primary_link_only = true,

-- 
2.34.1


