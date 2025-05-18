Return-Path: <linux-wireless+bounces-23130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CACABB141
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC643B56C1
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 18:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9631C5F30;
	Sun, 18 May 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i4350nT4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851561D6DBB;
	Sun, 18 May 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592608; cv=none; b=IYf8t4Ri3BOGDS2g7PeyxqJ5KQbilUKCKV0aURkMRYESRT2zPt5ffTFCDu3isKmXJ/DPpjsi+1og94POYAHtDkrI+SqIGu3LIG/jFKu5fBNTmJA7AZFymxANXv4Wo8GodLY5a6DSRP1uQDKDPY57WtW13tjlmsNgKwtu5aUkzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592608; c=relaxed/simple;
	bh=dsjBw3PmODyz58zH9PCQXJg4HkX98omxrycVnmyNtho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IvqSmrYHlgljNeKM4lTWXdqhSF/Hdxu6BE6tH1Yt5aoARumr3PmX9no6Yz92y3sSb7+y3SyszuJGfj5XP8u4Cp6Qp9/L0CS8rzBnycVHB/s/5P3OtRHb6zzty4YQVGX6TJjrBkywD+TRaWydWx7E7Sq1t+SyNAshB7IORrQ9k/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i4350nT4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IGCThw024885;
	Sun, 18 May 2025 18:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cnc37N2e3+pJ2Ag2byaRp/fTFyiZrRf6d4dkcepCPEo=; b=i4350nT4/Y990wIC
	mJMlij2ZzYzWfsqVLz6ueklPSNEA0EJQem+Thq2mJonlZ+028M8bt26xCrcrL+W/
	Ir6JHXhjiAL7tGawYbcFYJCVzme5a59bABFLegzdlHymiTMyO8nrMRe3Ng5XCNVf
	8rxoZlDZrPabfCOtyZXIoI7EXpPOXBEyr5ALzWxpWc3WLQTo0JAu+sWzj2VuQTG1
	suRPU1zJjmRdRvk5NwRufhs/iSsGtsv2LVXlcPc9ND9DwQEY69NlxeYPDtW9aOXR
	dRovEI+lEvyFXc4NB033oNtaSFqGChxhlzMc3XvPDbkVEp/jlfHzJYndoZ/5uwYK
	FCwHSg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pkr9t8ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54IIN5WA002265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:23:05 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 May 2025 11:23:01 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Sun, 18 May 2025 23:52:30 +0530
Subject: [PATCH ath-next v2 3/5] wifi: ath12k: add ath12k_hw_regs for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250518-ath12k-ipq5424-v2-3-ef81b833dc97@quicinc.com>
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
X-Proofpoint-GUID: 5jWUGo-1Ya7FOopAuNQkvKZSnF2Z7moF
X-Proofpoint-ORIG-GUID: 5jWUGo-1Ya7FOopAuNQkvKZSnF2Z7moF
X-Authority-Analysis: v=2.4 cv=DdAXqutW c=1 sm=1 tr=0 ts=682a2589 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=dagU3uUzHk6l2Oo7QSMA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDE3OSBTYWx0ZWRfX62/7zr5odhPC
 a7278YGaIEwjh0VVuqxFFeIXP9D/IDvzPDxDgMKe7Fb6vQXC7JCxGSSjlw08tb0ljBnNI8HXElN
 y26TDLKatNroJP0uAe7jsxj/VQRidC0nMY96c2p7z3KmOqUaszRjyhWqR1uK0Sqr4J3XDn3N7o1
 NBGny19OUKKiMlJzkNltpDGvBSZ2DjOhCqO5dw6BHNmVii/A/bx11Qm1oiRlw50AeTr5Io3RvMR
 fCumP5KuBcI4KkQ3p/cb49hSNb2TbzeYYFhBdsYH0IcToWUxZbAjj6hl3PEnsWCqNDvKQFndhO4
 giI3NG5t5yLhJ1O6NL2MPDbIRAUs807ry88NfCNX81HrFnUU5YIH0qoCWPW7wZLTmm69BKkzXH+
 LVHRJXlr+F5/QqReb8cOY14kCbB1yjamP18Ji4az9qlO+L9C5QUciRDfct7JaHwy1zRc1gNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=940 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505180179

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add register addresses (ath12k_hw_regs) for new ath12k AHB based
WiFi device IPQ5424.

Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.5-01053-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.h |  3 ++
 drivers/net/wireless/ath/ath12k/hw.c  | 87 ++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 0ee9c6b26dab4ef597c95fea6fdb58d9cf1a0941..3239f3a7526b510ca94c2a4ce0e9a26b77cdf914 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -383,6 +383,9 @@ struct ath12k_base;
 #define HAL_IPQ5332_CE_WFSS_REG_BASE	0x740000
 #define HAL_IPQ5332_CE_SIZE		0x100000
 
+#define HAL_IPQ5424_CE_WFSS_REG_BASE	0x200000
+#define HAL_IPQ5424_CE_SIZE		0x100000
+
 enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_REO2SW0 = 0,
 	HAL_SRNG_RING_ID_REO2SW1,
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 866de53f37bb5af94e16c796a0052fda39eb4ea8..05e2010173340bc3c0481aadf710a6894efd92bb 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1132,6 +1132,91 @@ static const struct ath12k_hw_regs ipq5332_regs = {
 		HAL_IPQ5332_CE_WFSS_REG_BASE,
 };
 
+static const struct ath12k_hw_regs ipq5424_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_id = 0x00000918,
+	.hal_tcl1_ring_misc = 0x00000920,
+	.hal_tcl1_ring_tp_addr_lsb = 0x0000092c,
+	.hal_tcl1_ring_tp_addr_msb = 0x00000930,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000940,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000944,
+	.hal_tcl1_ring_msi1_base_lsb = 0x00000958,
+	.hal_tcl1_ring_msi1_base_msb = 0x0000095c,
+	.hal_tcl1_ring_base_lsb = 0x00000910,
+	.hal_tcl1_ring_base_msb = 0x00000914,
+	.hal_tcl1_ring_msi1_data = 0x00000960,
+	.hal_tcl2_ring_base_lsb = 0x00000988,
+	.hal_tcl_ring_base_lsb = 0x00000b68,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x00000d48,
+
+	/* REO DEST ring address */
+	.hal_reo2_ring_base = 0x00000578,
+	.hal_reo1_misc_ctrl_addr = 0x00000b9c,
+	.hal_reo1_sw_cookie_cfg0 = 0x0000006c,
+	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
+	.hal_reo1_qdesc_lut_base0 = 0x00000074,
+	.hal_reo1_qdesc_lut_base1 = 0x00000078,
+	.hal_reo1_ring_base_lsb = 0x00000500,
+	.hal_reo1_ring_base_msb = 0x00000504,
+	.hal_reo1_ring_id = 0x00000508,
+	.hal_reo1_ring_misc = 0x00000510,
+	.hal_reo1_ring_hp_addr_lsb = 0x00000514,
+	.hal_reo1_ring_hp_addr_msb = 0x00000518,
+	.hal_reo1_ring_producer_int_setup = 0x00000524,
+	.hal_reo1_ring_msi1_base_lsb = 0x00000548,
+	.hal_reo1_ring_msi1_base_msb = 0x0000054C,
+	.hal_reo1_ring_msi1_data = 0x00000550,
+	.hal_reo1_aging_thres_ix0 = 0x00000B28,
+	.hal_reo1_aging_thres_ix1 = 0x00000B2C,
+	.hal_reo1_aging_thres_ix2 = 0x00000B30,
+	.hal_reo1_aging_thres_ix3 = 0x00000B34,
+
+	/* REO Exception ring address */
+	.hal_reo2_sw0_ring_base = 0x000008c0,
+
+	/* REO Reinject ring address */
+	.hal_sw2reo_ring_base = 0x00000320,
+	.hal_sw2reo1_ring_base = 0x00000398,
+
+	/* REO cmd ring address */
+	.hal_reo_cmd_ring_base = 0x000002A8,
+
+	/* REO status ring address */
+	.hal_reo_status_ring_base = 0x00000aa0,
+
+	/* WBM idle link ring address */
+	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
+	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
+	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
+	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
+	.hal_wbm_scattered_ring_base_msb = 0x00000254,
+	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.hal_wbm_scattered_desc_head_info_ix1	= 0x00000264,
+	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
+
+	/* SW2WBM release ring address */
+	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
+
+	/* WBM2SW release ring address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
+	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
+
+	/* CE relative address */
+	.hal_umac_ce0_src_reg_base = 0x00200000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.hal_umac_ce0_dest_reg_base = 0x00201000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.hal_umac_ce1_src_reg_base = 0x00202000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.hal_umac_ce1_dest_reg_base = 0x00203000 -
+		HAL_IPQ5424_CE_WFSS_REG_BASE,
+};
+
 static const struct ath12k_hw_regs wcn7850_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_id = 0x00000908,
@@ -1607,7 +1692,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.internal_sleep_clock = false,
 
 		.hw_ops = &qcn9274_ops,
-		.regs = NULL,
+		.regs = &ipq5424_regs,
 		.ring_mask = &ath12k_hw_ring_mask_ipq5332,
 
 		.host_ce_config = ath12k_host_ce_config_ipq5332,

-- 
2.34.1


