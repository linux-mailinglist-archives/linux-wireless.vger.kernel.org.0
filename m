Return-Path: <linux-wireless+bounces-29862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA7CCA027
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B401B301595B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557626E6F0;
	Thu, 18 Dec 2025 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5ZZjfiH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ExdCYTIN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723526FA57
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022910; cv=none; b=WBTvu1CuQU4ChfRJ6J1eV8nFFO1RrO7HhvqFsABDKFADXhtdHOOcXmb58ms85P1xvHPpEKoCVqZezfkOlI1SrEzl9enAQRKKxKjn6RKuyriC9wwWclmeuYuXjQ1MOlqJgWkJa3H/6EfQ1NrHhror7CHf0T8TwglWjxo30KUYzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022910; c=relaxed/simple;
	bh=8e+hV1B5Csn1m3XxN2WT/AAKp6hisMvjCD3OKy+f4OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BK85rYZ2KIrD3vfwN4Ojrt4Cnuj8i7x4Z4Qo9Jv3fxZoH66SsnDCnZ80g8I2R0fx+9FOFOpB8o3WyPccEgvSLdfhsm+y6fwx+mhr0NkdQQFT7n9kwMjnAQGJh85tsffNoCpSTREpgt8gT1fcZEqyDKe+bi/w0HgX+rfdbJ/P4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5ZZjfiH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ExdCYTIN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YSLY527626
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/upX7u/ox6ptfKPVj84C91zINBCjJs8pyXWX07cFxbM=; b=f5ZZjfiHJMHD2zAr
	W1VWIMb3ByzbiVagw7SequKoRRjOrdRxsA2yBr5JFyZaxD+B07G3EnOp68It55xn
	rOyZmOETyzRVG8MZq33SA56o/cfW9KjBo25M4bB+8yFxHvtTTk3O/UGB7/BhR0Ci
	MvUfzQSomyU8mbyyLSU5b7p9V85ja0QPA6tbUH+3ad0SlGzyZ0/iYKYAPDvcTPdz
	I7ctBE96cb5HReDJX7xAvHNyTg/GpomKF8aK5GCkhatXIa71gANP0jAZUJxRgWDo
	SpRYrwGfUpvgXgnV5+L0o/eArHnHHz+o1ia2fLZ+ZU/Himt9V8muO48NlZIDOK62
	uuND/Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43mb0qfp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0e952f153so3967595ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022907; x=1766627707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/upX7u/ox6ptfKPVj84C91zINBCjJs8pyXWX07cFxbM=;
        b=ExdCYTIN3DK3pKbelA52TKiAlt+081XW1VWf+2cIj6/oB1qFyXw8IlYbq6/WGOT7Dg
         /epdcHOBWN8jpAFnFLl5zDNDSpjtJuxE+vQcL3kHdhN+6RjeDqJvvr31tHjuZOgJb716
         veJwnaNfJybfvfFsvMzYHnow4AJPf7o6GF7e60H3igVZQLeevShrdK1YaSjiIrmbN30/
         PSU+k+51rlNFKmYidxzFj2afPHsdNbWLt785bac847VMURvMjCbcgekZ+cJpdh2UnH9w
         bmSnzpaEb1lbK+PKN6fcNpL0ahiAMcNJOeW+qOZAa3Mp8bO2i6zCmerGip+VzZnaJFTa
         F9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022907; x=1766627707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/upX7u/ox6ptfKPVj84C91zINBCjJs8pyXWX07cFxbM=;
        b=tMTpZroslDWkXkFtYka3HaqaDG4MZ0uTkgdKOJY5Tjn7F0tCNcLr3yNddvC3tm2NZZ
         Z3eJG2qUqEbhhVCyfda+O3tGTooizocwX0yQELELr7I5842qJHdEHjuAZ1+tzOmwe7XZ
         3LbytbjVZXsU6JLznnOOzKTdL+R4m5qwdgwBtlajWARMMABTWqY18MUFCBAjKKDDwHXw
         FjiPdzKb7LTOCWxScFWGK3xxbX2XvNwbzSiAamRYAGrS1rErAolB2TPLJ7TWl+AKII9Q
         qhRonHwq8noO+lPpyidKd9zxJZJbVm2RCIbiuOCDcS3DtEcWLTGUEAPxxrgJnCKXwmya
         qevg==
X-Gm-Message-State: AOJu0Yz7HAjWX7ZsorRi9vGsecgG5TLyfQJPlhPLBoplTD8D8+tcdsvR
	6H97f6F4DImavU/5LywWTF7KagiluJfB15eLiT7xiqRRCGdTJ5pnmHfnlwJ2SKPjND/oshkDMN+
	M/UEtciDdkabOBpxS0INqZpQ/0cy0UvpOtEEPDSYIih2UgtrMDByZEtdbvKZua2elfrR8lw==
X-Gm-Gg: AY/fxX5+mBCegvf3ZVhL1U96kRdvIZtDfSmXZj0eiXO+kFCMBoENQQLk0dHLNkYmP4B
	p9DyY4nqTQiwljbAyFtWDEU/YgEo7giPKHaYW49twMUYRGqzHaNDX9dMqI1Hrbfp8Krf1rcN1QJ
	9A75CZpSblEkE2yyx2AvK3WFWdvxp19Tf4pAZ5GeguK/P8sNsPZStFBeGG3gWbGEHUVOOAmFFE9
	6bcScPiihZJ5R1y+DFtrm6rr5Im7n/ejdXK89HDXcq/y4C8aGlklz0FIX41uzoXOLpDI2tbz/HY
	W4uzwuSaLVfp0lKXEp4/bwXHekH4FNUeQdJT75csAs4XyMiUQqpDsKGDKcOWt/bsikOVdU0Qpia
	1jeB3nZUjBt5KB88ZbpuZOmMl6iaaKGomh0xni3ejWryHBu7PXsRduXZOqCYqLro=
X-Received: by 2002:a17:903:2281:b0:2a1:e19:ff5 with SMTP id d9443c01a7336-2a10e191134mr108645225ad.38.1766022906749;
        Wed, 17 Dec 2025 17:55:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7QhesR5V/o10Y3N2o2l+EIjy+4iv99E6ChHjfBebKH7Oi6EAVuZApjK1p4qRrSOQXvP3rqw==
X-Received: by 2002:a17:903:2281:b0:2a1:e19:ff5 with SMTP id d9443c01a7336-2a10e191134mr108644995ad.38.1766022906171;
        Wed, 17 Dec 2025 17:55:06 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:05 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:15 +0800
Subject: [PATCH ath-next 01/19] wifi: ath12k: refactor PCI window register
 access
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-1-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: nfQVmQmMzWTqSHhspNhSu1l5t6RxtPSq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfXx6ENLB0vs7d0
 iPeQrODWKI5lw03fitJUeupsWOATqJWGT50EWB8Cyg/u6U9S+V1SyjWfpgQb9Y+52MV9ORBypp1
 V8zNt5iBoK7Kv2DgCfpfw1PC5zdAVEXuOu3hxrxy/urKmel+nNJj/uXiHjqAAL3Iri/chUch8nz
 +uu6RGoFih2/OjzSSTMdyGoC6TvSDk5UQNZjiLT80LthIPsjzmT70NUALWuxEXtO24YFm+4SgTD
 SCDjaTRY+kL73Fap6Bc6/3aHdgsWG1ipKnQyeWt7t30mECw3q73M4zFVM7nAJoCJlMQcOrDGH0c
 C6OCAtyYNSfiQPkZe4zytBt31nt2XprFKOquYRRtj/S78AuHb8sPMgzQrBQDZtaFmaoJw4LowT3
 QpJSGYXCcU7ABavzh54IC8mu2JfoIA==
X-Authority-Analysis: v=2.4 cv=NPHYOk6g c=1 sm=1 tr=0 ts=69435efb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-0iOq_zPj34lsyxnQQ0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: nfQVmQmMzWTqSHhspNhSu1l5t6RxtPSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

Currently offset of PCI window register address is defined as 0x310c which
is same across existing chips. However QCC2072 has a different offset
0x3278.

In order to make the window selection logic work for QCC2072 as well,
change to initialize this parameter per device at the probe time.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/pci.c       | 11 +++++------
 drivers/net/wireless/ath/ath12k/pci.h       |  2 ++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c | 12 ++++++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index a42c4289c6b2..4bc30d86c1a7 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -23,7 +23,6 @@
 #define ATH12K_PCI_IRQ_CE0_OFFSET		3
 
 #define WINDOW_ENABLE_BIT		0x40000000
-#define WINDOW_REG_ADDRESS		0x310c
 #define WINDOW_VALUE_MASK		GENMASK(24, 19)
 #define WINDOW_START			0x80000
 #define WINDOW_RANGE_MASK		GENMASK(18, 0)
@@ -125,8 +124,8 @@ static void ath12k_pci_select_window(struct ath12k_pci *ab_pci, u32 offset)
 
 	if (window != ab_pci->register_window) {
 		iowrite32(WINDOW_ENABLE_BIT | window,
-			  ab->mem + WINDOW_REG_ADDRESS);
-		ioread32(ab->mem + WINDOW_REG_ADDRESS);
+			  ab->mem + ab_pci->window_reg_addr);
+		ioread32(ab->mem + ab_pci->window_reg_addr);
 		ab_pci->register_window = window;
 	}
 }
@@ -145,7 +144,7 @@ static void ath12k_pci_select_static_window(struct ath12k_pci *ab_pci)
 	ab_pci->register_window = window;
 	spin_unlock_bh(&ab_pci->window_lock);
 
-	iowrite32(WINDOW_ENABLE_BIT | window, ab_pci->ab->mem + WINDOW_REG_ADDRESS);
+	iowrite32(WINDOW_ENABLE_BIT | window, ab_pci->ab->mem + ab_pci->window_reg_addr);
 }
 
 static u32 ath12k_pci_get_window_start(struct ath12k_base *ab,
@@ -178,8 +177,8 @@ static void ath12k_pci_restore_window(struct ath12k_base *ab)
 	spin_lock_bh(&ab_pci->window_lock);
 
 	iowrite32(WINDOW_ENABLE_BIT | ab_pci->register_window,
-		  ab->mem + WINDOW_REG_ADDRESS);
-	ioread32(ab->mem + WINDOW_REG_ADDRESS);
+		  ab->mem + ab_pci->window_reg_addr);
+	ioread32(ab->mem + ab_pci->window_reg_addr);
 
 	spin_unlock_bh(&ab_pci->window_lock);
 }
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 1cc4f0e050f9..a74b09d23a6a 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -130,6 +130,8 @@ struct ath12k_pci {
 	u64 dma_mask;
 	const struct ath12k_pci_device_family_ops *device_family_ops;
 	const struct ath12k_pci_reg_base *reg_base;
+
+	u32 window_reg_addr;
 };
 
 struct ath12k_pci_driver {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index dedc88858bb0..6c477fe97298 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -27,6 +27,8 @@
 #define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(11, 8)
 #define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 4)
 
+#define WINDOW_REG_ADDRESS		0x310c
+
 static const struct pci_device_id ath12k_wifi7_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
@@ -104,6 +106,11 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
 		ab->static_window_map = true;
 		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_qcn9274;
+		/*
+		 * init window reg addr before reading hardware version
+		 * as it will be used there
+		 */
+		ab_pci->window_reg_addr = WINDOW_REG_ADDRESS;
 		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
 						 &soc_hw_version_minor);
 		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
@@ -126,6 +133,11 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
 		ab->static_window_map = false;
 		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_wcn7850;
+		/*
+		 * init window reg addr before reading hardware version
+		 * as it will be used there
+		 */
+		ab_pci->window_reg_addr = WINDOW_REG_ADDRESS;
 		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
 						 &soc_hw_version_minor);
 		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;

-- 
2.25.1


