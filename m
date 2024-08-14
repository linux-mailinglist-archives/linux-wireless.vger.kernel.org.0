Return-Path: <linux-wireless+bounces-11406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384979517F2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5781F23667
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7816BE09;
	Wed, 14 Aug 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lW+nsdro"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DCD1684A8
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628675; cv=none; b=fc4PfI2+rf0ONgNU6o5U3+yuojQ5bc+6A7EWkozhymroioEcGDdOst7pZtvDvwatQiW6Y8vQ4XHQsI9kOga0JO2oRaabs5TzWcmoy09vfDu7G5gtK40Cj2Lh+jdApiYKdmd3KwvOlz7xFXifBJBmFuCoDUxdHGjHSe5V3S9iXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628675; c=relaxed/simple;
	bh=z4jtKA46GBzQPwt3QCv56zl8ITi+y957FtSDIMP7C8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5af2D3JpBjbSSeNo3h8+d5PbUEdRq/oJli4ctPg9u3tYp07KQv6sZn+cloiQ03ERTm+jbh6z9hvPwTVzMJl/hK2Gj2BUXEzYzcvqdxcEBL5sPnKY5AzPduANKbeAsKYQlEfGbYOiZby20x+BCv5BcJDsHhPKH9FThIQLPJ/1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lW+nsdro; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNFaWk032013;
	Wed, 14 Aug 2024 09:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fkf4TaOhwForDQnW2djj0UVS/pL2lAjF3/crugvJujY=; b=lW+nsdroF4goOFRW
	sXHsRPgaFqvV1Q28KF9YP2l5mtY4jKCwsZ/Ay3NaXxEaSJBbizokrxoIEB2nGAvS
	H20jRALDvlBbr9zIfRHuoVvNkpbUhgCRRnsDJpQ/KuodSGJcmxT71r5mrQdoNmah
	etydAAm1RbYCfvxFrIZqbjwjdh8HUqG7wVdba7UbVFyoYptBFqZU049DUfCvajom
	/sottNBug/zNj9KeG7ch6R6nOOHBGukWlHCjNfDuO7GfnR/217REz85GSy9dxJGQ
	Q32KOILTAFLW7n4khDp2Z6FAm67fh0YUWP2R1MyruhgDnj1aV/6+B/U5c6i1lGHx
	9kfypg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1682gh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9iU15000564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:30 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:27 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 05/18] wifi: ath12k: add ath12k_hw_regs for IPQ5332
Date: Wed, 14 Aug 2024 15:13:10 +0530
Message-ID: <20240814094323.3927603-6-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: QoKgkpFQMnOm_HCsaH58W4cF2uS4yMDR
X-Proofpoint-ORIG-GUID: QoKgkpFQMnOm_HCsaH58W4cF2uS4yMDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=975 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140067

From: P Praneesh <quic_ppranees@quicinc.com>

Add register addresses (ath12k_hw_regs) for new ath12k AHB based
WiFi device IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Co-developed-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 86 +++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 7944be6a9973..d1c0227cc212 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -777,6 +777,90 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_umac_ce1_dest_reg_base = 0x01b83000,
 };
 
+static const struct ath12k_hw_regs ipq5332_regs = {
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
+	.hal_wbm_scattered_desc_head_info_ix1   = 0x00000264,
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
+	/* PPE release ring address */
+	.hal_ppe_rel_ring_base = 0x0000046c,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x00740000,
+	.hal_umac_ce0_dest_reg_base = 0x00741000,
+	.hal_umac_ce1_src_reg_base = 0x00742000,
+	.hal_umac_ce1_dest_reg_base = 0x00743000,
+};
+
 static const struct ath12k_hw_regs wcn7850_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_id = 0x00000908,
@@ -1123,7 +1207,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.internal_sleep_clock = false,
 
 		.hw_ops = &qcn9274_ops,
-		.regs = NULL,
+		.regs = &ipq5332_regs,
 		.ring_mask = NULL,
 
 		.host_ce_config = NULL,
-- 
2.34.1


