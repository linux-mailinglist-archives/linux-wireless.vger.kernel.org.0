Return-Path: <linux-wireless+bounces-29870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF4CCA031
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E72083047F8C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889A626E6F0;
	Thu, 18 Dec 2025 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8BSgiN3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c3i6pZFQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C351926E6F4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022926; cv=none; b=P44UdbMyOJOVfoVryRixwYA6rUFrIKZPeD7hNmkh3x18gJrEVPe0mqsATjwrs6wqrTjw+FvWRrJqJKzgKcML4BTAn9swf/vsdPauxOUDoVs1TE/852ehO1eQtv+6C36t5oIJ83HqHgB1qnYXksYYfCFWPyIEUhHkYrNgUos/LNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022926; c=relaxed/simple;
	bh=rf8id2r3TYEQ4Ri1vkRTzbYVyoO1jpGE0+ws235rfw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/fZaK/3wKukr3bLI1O7KGiO5QBw+N5IQUpqcbhDpsEwJxrMS49h79b3DYvCKTDWj5OlrcE3/u4COTENwrJ56cXkcQ2fUHmklbOrUe9CnI+JSD90ORYpqDtlcxg4ga62uTk+V0h8YNOdvjRgX2v9H/rJ/YP1HVOUXOfooxVvpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8BSgiN3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c3i6pZFQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YoAZ493184
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	30aA6gD1tuQbNqYfFrlJb+qmjCTZS+zgVkUUAhS3NGc=; b=k8BSgiN3XYZf/OYv
	E7UeaQ0XWFD8st7tgEz74S75wITSVGCLRxmIa8OfiYeaMV/As7EIBNrGntVxSFEn
	a4xxhn8raxT1TeYv/esWzLFoWPjasOfKUNqJtOltYOagUJGTU+Lmq5raxwdHgf6w
	7fv0sbEbTlTFRufifkmcjPoDetNdV26J2FO/3Lp2sEwcXR9dbu9ty02Asr01HyNx
	+peI3LyEhrM5ejdkfD+JZEMVN0+NqsNbv74QYbIeJu2ZfSGTimbzgJgDxcFxJULR
	HX09htaW28hNHzNTkaJVPU56ZPaPBukYLLDK8K3y57y7B8X521FLMtX9a1Y0jl8V
	tN9CEA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3n333qyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0dabc192eso2864775ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022922; x=1766627722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30aA6gD1tuQbNqYfFrlJb+qmjCTZS+zgVkUUAhS3NGc=;
        b=c3i6pZFQWNM09RkAvtgRYKvGahcihpqQ78vo2VyGftJoIPq17Bxgcp4AgrJDSq9U5+
         8BWhQ6BsbJMkCxlOX21OXQwM5FdF9u6q5CP3KAgTn9PFV0cbBjLYVR4B6zVS6rZ1CFBs
         sQkmbV3HQZCCqmy722dfxpTkT3LRZOJgwbrEQFu7dyuae1qaVON+cwWRPsicNHImqzrJ
         qYKKnalok2kmgb3TsHgGpCm2A+waponm5dTVko5kvvF5SXuI9FNyVjevdq53CYycqr4L
         4TVGiuzJbkfK823w+uSZ0SrOq4O6hnVpNe7UM0X8zYzyMU0H11Wk7xJ0LiHGEDHd3U8R
         DQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022922; x=1766627722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=30aA6gD1tuQbNqYfFrlJb+qmjCTZS+zgVkUUAhS3NGc=;
        b=O8trsiBmDtpaYk4IYVeD4buDeZ4TfCOjD9ibRv//fOxboZzdtuclkgL9yNYIGc7lUn
         h6AoDLSmBDkhyDL5GZDtExK+OTjuN+b6X6DXt63EK49Soe2RTQ+bKaqclVx9GClNcEYH
         +gaqiQ+C1M7b8xZeWjDvZxmXsVJpuegD0N2e4OPBm9xuDUIwBlgj+BJthAALqO3XghEU
         zEIYefYNiPOGQ93rgnAmYG1Xk5+UynKp9XoL6q7Dl5YQepBNsrtvFRViYvuY4hr8LqMF
         y+QE7d550MEqeKtdBm41zToV0xW3HZP4hDIAPvZjjq0jsFnGMJO46Tqny9EtShd5cYWh
         LHNg==
X-Gm-Message-State: AOJu0Yzaljo6BKEQJFB3MwP4G6sDw+bCg7rvlP9koFjrJtaQRUnLRPxf
	Do1FmrKhAjmg+fttA2AhBW4S2Z9FTssVM1mbkSetRFd0whXcZl4ZdPhRk4w3aE5G2Mq4o5FCrsr
	A1CUskgbzzzFyVIycPCwDtq38srmX7vOIje3mxxsA5L5yzXuO3rzZWBrVQTqZZQn76vnrDQ==
X-Gm-Gg: AY/fxX6m0ayco+5m62KksgiJS+ugp5qetUMzD1T0DXZMmTUntxQ7oAKen7k+mZ0Ta0o
	aL1FIDyOYznYBtRxVNRXMam8euclZT4shGGQmrH2oh8Ymf7AXs6KCclF8zthj4tLiR5GR8dyS6N
	RSD9ze/xT4BOvkfQHj4zetLY1n9rd+PTjjnV9WOn1vmA/he1hn79C6jzHL+9wQTwAAPFEqDhRhX
	Dszicg+19m5QU7VF4Bd44VugDefEMb8F5sCdgH2LskMouzxiW8XDCOh6HhMj+xKAM2zB0HcVUUz
	7u+OXtTSafNogn802Vb+mTVWVMysSHJqlurYPVLF8HfPHBP4ZOjfKn1vKPX9yyPvOto95QKHhcX
	wEXBIY+pBhcbtCvfWdXdVHfrc/lPGCHChPj+FkVS2q2O6nh+ghqlZDKjVVK7utGM=
X-Received: by 2002:a17:902:cf0a:b0:2a0:9d0f:b1ed with SMTP id d9443c01a7336-2a09d0fb39dmr138647655ad.24.1766022922500;
        Wed, 17 Dec 2025 17:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCee2zl5DoStsriVI7/UW4iY/jxtKTEXgSwVamDJ+ZWgIohTcQcllIDeLRhEWaLiC9llh5rw==
X-Received: by 2002:a17:902:cf0a:b0:2a0:9d0f:b1ed with SMTP id d9443c01a7336-2a09d0fb39dmr138647395ad.24.1766022922017;
        Wed, 17 Dec 2025 17:55:22 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:21 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:23 +0800
Subject: [PATCH ath-next 09/19] wifi: ath12k: advertise standard ELF image
 format for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-9-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX994LmzHtLQuD
 YntzEAidmGSsKDArAj7X0MBZIYFbc7Vp5nGxu4ezykJF4cUeTzWQfLju/QtJ1PbGm53KjTAC+34
 g6xAyrximUGEf2ECzhICWcxf2AP+OfD+iDKbYh9ctiObrJ8Q7/c7mnEiI/ku0a8tG9jco4jLDLo
 4mNq848Wcw8aiQbiHALJlAaG72B/YsKCMK0acgWxZPBDbO0Qc/5K4u8qwcv+18lnQBxbuO4nqKD
 Wb4KhPJFcG3nTN3SGzkNPz2EKRdy5xFzEQTQhiEqPzpP3e+0gev/cp1KMMQZPszu9MzZBu9OyMk
 aL/deP3KOC18PdvnkT4mWk/ZPwqdylyNE9Z5CZFTW1zgoUBrQsyoyNY3hrHgQ0gjRbDqjttgS1W
 jSmmXVSrD9t54B4rhhRE4INdjgggxA==
X-Proofpoint-GUID: -8z7pE5Gfj_DgavUxv2L8n_jbxc0UJ1Q
X-Proofpoint-ORIG-GUID: -8z7pE5Gfj_DgavUxv2L8n_jbxc0UJ1Q
X-Authority-Analysis: v=2.4 cv=U82fzOru c=1 sm=1 tr=0 ts=69435f0b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RlVu0IYx6P6Gi_hgVqUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

Firmware (amss.bin) of QCC2072 is a standard ELF image, however those of
other chips are not. MHI subsystem supports both format, but by default
takes it as non-standard.

Flag this to MHI subsystem to avoid firmware loading failure.

Also refine hardware parameter dereferencing by defining a new local
pointer.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hw.h       |  1 +
 drivers/net/wireless/ath/ath12k/mhi.c      | 10 ++++++----
 drivers/net/wireless/ath/ath12k/wifi7/hw.c |  5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 655753d0413a..85da4e43cf61 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -142,6 +142,7 @@ struct ath12k_hw_params {
 		size_t board_size;
 		size_t cal_offset;
 		enum ath12k_m3_fw_loaders m3_loader;
+		bool std_elf_img:1;
 	} fw;
 
 	u8 max_radios;
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 45c0f66dcc5e..7698a098c088 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -187,6 +187,7 @@ static void ath12k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
 int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 {
 	struct ath12k_base *ab = ab_pci->ab;
+	const struct ath12k_hw_params *hw_params = ab->hw_params;
 	struct mhi_controller *mhi_ctrl;
 	unsigned int board_id;
 	int ret;
@@ -201,11 +202,12 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->cntrl_dev = ab->dev;
 	mhi_ctrl->regs = ab->mem;
 	mhi_ctrl->reg_len = ab->mem_len;
-	mhi_ctrl->rddm_size = ab->hw_params->rddm_size;
+	mhi_ctrl->rddm_size = hw_params->rddm_size;
+	mhi_ctrl->standard_elf_image = hw_params->fw.std_elf_img;
 
-	if (ab->hw_params->otp_board_id_register) {
+	if (hw_params->otp_board_id_register) {
 		board_id =
-			ath12k_pci_read32(ab, ab->hw_params->otp_board_id_register);
+			ath12k_pci_read32(ab, hw_params->otp_board_id_register);
 		board_id = u32_get_bits(board_id, OTP_BOARD_ID_MASK);
 
 		if (!board_id || (board_id == OTP_INVALID_BOARD_ID)) {
@@ -262,7 +264,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->read_reg = ath12k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath12k_mhi_op_write_reg;
 
-	ret = mhi_register_controller(mhi_ctrl, ab->hw_params->mhi_config);
+	ret = mhi_register_controller(mhi_ctrl, hw_params->mhi_config);
 	if (ret) {
 		ath12k_err(ab, "failed to register to mhi bus, err = %d\n", ret);
 		goto free_controller;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index ef0a59f6339c..bfa111968676 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -339,6 +339,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.std_elf_img = false,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
@@ -421,6 +422,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 256 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.std_elf_img = false,
 		},
 
 		.max_radios = 1,
@@ -505,6 +507,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.std_elf_img = false,
 		},
 		.max_radios = 2,
 		.single_pdev_only = false,
@@ -586,6 +589,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_remoteproc,
+			.std_elf_img = false,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
@@ -661,6 +665,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.board_size = 256 * 1024,
 			.cal_offset = 256 * 1024,
 			.m3_loader = ath12k_m3_fw_loader_driver,
+			.std_elf_img = true,
 		},
 
 		.max_radios = 1,

-- 
2.25.1


