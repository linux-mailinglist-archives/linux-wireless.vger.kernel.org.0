Return-Path: <linux-wireless+bounces-13996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0399F576
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150771F254CF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851F1FE0FA;
	Tue, 15 Oct 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eousoP5t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CF1FE0EC;
	Tue, 15 Oct 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016911; cv=none; b=GfN1VVo5JRiszdbmrUH4y/SOKcbDLL1t4nLYvihAnv0jpDKaH7f8r6x7VfWy3v6Q+C5U6GZ2BSQuR81Oqu2sjp5E6z2tusI635tx8JhG+4OyH6BhuHLNan21pwb0Grc1lzDJyVr51CBm39DEBrPidenjhttpEkDPCuvMCoFA624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016911; c=relaxed/simple;
	bh=6lHkQxtaTIIqWG+SCYbSyO9ZJI19A1Aus4WHjY0UCLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoP/xhIr/acEUE4eTf1vsVlAoy969kv3Cx64HZEKVLVabovZW4Vy/lw8THv71unFVLV8BZONiUnBIJ1iznLCZ3Dl43QyYA26PANBFw52m4MielhkYd5wfIcIq69bOfHJxyTy613aL6fOHn8M3OQE2HuoLDE1Mp1ibsl0laceY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eousoP5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FEQkwq025512;
	Tue, 15 Oct 2024 18:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nEZqn7it0PL6ftdvoyHGFbWI7+LjfBRa+WzBcBcTrnU=; b=eousoP5tHn1iXIxP
	htdGyEA2n1tG54XP5L/Vao/RVR9drAZJ6rLtStAA4bdE61Twis7guV/PrbYHLWMv
	8ahOa0FMi6pPC5op4B72afeK24PzwFVN5P5p0LTVXkks6NLRCSLKN1NdeZd2hha6
	rmp41Gw7+cX+UQlQMxSVagJDBtvo1ZEAzH5zaM1ONTczkFX85nB+FM6RrLLUEgBL
	JvG/70QlnrNU+9vtElOuoB9LF682IZkUXpw+zF5br0RHYJR3HeQOWC4pu8EBd5iU
	jzL3xiKrIOuJ6wOh094b+/enclGeaN7FEyR8am/1AqOk3Fhx7w93P+3HxgIMs8P1
	83F2DQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429t5kgstk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FISP7t005196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:25 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:28:21 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 15/22] wifi: ath12k: add BDF address in hardware parameter
Date: Tue, 15 Oct 2024 23:56:30 +0530
Message-ID: <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 09zG3Kabjjx7tvdD_j7SAYIVs-s-wLts
X-Proofpoint-GUID: 09zG3Kabjjx7tvdD_j7SAYIVs-s-wLts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150125

The Ath2k AHB device (IPQ5332) firmware requests BDF_MEM_REGION_TYPE
memory during QMI memory requests. This memory is part of the
HOST_DDR_REGION_TYPE. Therefore, add the BDF memory address to the
hardware parameter and provide this memory address to the firmware
during QMI memory requests.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  | 4 ++++
 drivers/net/wireless/ath/ath12k/hw.h  | 1 +
 drivers/net/wireless/ath/ath12k/qmi.c | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 4117a4b718e3..8fc191b0b467 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1320,6 +1320,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.cmem_remap = NULL,
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
+		.bdf_addr = 0,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1405,6 +1406,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.cmem_remap = NULL,
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
+		.bdf_addr = 0,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1486,6 +1488,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.cmem_remap = NULL,
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
+		.bdf_addr = 0,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1562,6 +1565,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.cmem_remap = &ath12k_cmem_remap_ipq5332,
 		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5332,
 		.ce_remap = &ath12k_ce_remap_ipq5332,
+		.bdf_addr = 0x4B500000,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 580c7be109e0..038fe1b30d11 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -225,6 +225,7 @@ struct ath12k_hw_params {
 	const struct cmem_remap *cmem_remap;
 	const struct ce_ie_addr *ce_ie_addr;
 	const struct ce_remap *ce_remap;
+	u32 bdf_addr;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index ec8859031824..b5cad6656722 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2491,6 +2491,14 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
 			idx++;
 			break;
+		case BDF_MEM_REGION_TYPE:
+			ab->qmi.target_mem[idx].paddr = ab->hw_params->bdf_addr;
+			ab->qmi.target_mem[idx].v.ioaddr = NULL;
+			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
+			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			idx++;
+			break;
+
 		case CALDB_MEM_REGION_TYPE:
 			/* Cold boot calibration is not enabled in Ath12k. Hence,
 			 * assign paddr = 0.
-- 
2.34.1


