Return-Path: <linux-wireless+bounces-30674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF493D10E85
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FDD30443DB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970B30CD82;
	Mon, 12 Jan 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RLsdF8yO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrWkWmps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56204331A70
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203417; cv=none; b=uxzE5vL73/9u0efKg/lEcLGoyIfBlfRqURech9QBTiKlPSuXPvBTrI1SeczOhotRX6yBVdgudhdoereogtfYvX30VsJkNHNgOCDCcZui2zcpJhuLu4un83y2wNEAux/F1kvTU10cygrf4FMyonERzlOFsOjQ0cKV22+2j942Eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203417; c=relaxed/simple;
	bh=8e+hV1B5Csn1m3XxN2WT/AAKp6hisMvjCD3OKy+f4OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZX6v5lzzASo+9Ps9UsDuthZ5TKUwiEcLPS2WbwedULXZI2XO/2/EIhuRLdsotO6OEcLfTSgELikyjJFqT60hxuby3/++l6KveN5BPb0emaSFuMDzEWz/OETNqn56tkqtgxyC5uYILXsy23DNRIkTYmjUpXHBacJkH9MfW+zsqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RLsdF8yO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrWkWmps; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNq4S63312808
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/upX7u/ox6ptfKPVj84C91zINBCjJs8pyXWX07cFxbM=; b=RLsdF8yOHnjTSNGz
	24bX/pc/X8co+SniaR2gGSCtCOWZpJ1DgEldEvmr6Ovw8r5POPvHo8hJj+mGVoib
	30Z0NTPIbuNb09AfaasdpnZt7MmcVZjGjJH4vkyzMRxHn/bgZDXXf7Vw5oHKeAq1
	zPA6gM5klA7Dw91BkuvXX62IQytDevs16boYsP3gRXgcPUZGb01as5d12X0KKofy
	weIpUjk83Yc3j3slra9DU6vU/NoGsM/wnty94ZAhoGqycKI2aGNffRyEorGgNXep
	DBP20oLUxuZzlJUG0dqZjGeqZjdz9OYa3Okfp9kVlrZatsLa7oPj+jHneFZR5G85
	WoGsxA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkntukdbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc88eca7eso6528748a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203415; x=1768808215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/upX7u/ox6ptfKPVj84C91zINBCjJs8pyXWX07cFxbM=;
        b=ZrWkWmpsl0FKJpz4wm43fhjtFKBZ4jIHXW19CyZlS1HwWQOntDpKPdkgEp5kMEuwQ0
         S6+VEH8SWSZSWsbCWghH/5mJp09xISoZki0nW7JqyH+Pk1zBvwOz0XCe8+/g+RMAQb2K
         BkmmcPPEN+LTDqLsj+h5eaeJ5bJk8eOa2qkOuZPyAlpX3nXX4+TYf6BYpK1Smsy+RrW2
         gJoqhdmFcNGsH2+TnuAfYsG4L5TCassJw2HPWpGqr0k7pXaSvJPvALXKAmlNRxMiDjCF
         OLLZMou+Q5DvEtXxZn2dePcB/biPasljdKwLlDt9CQ/VJblrNxwiMg+c7qc0dZf8xJiK
         0YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203415; x=1768808215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/upX7u/ox6ptfKPVj84C91zINBCjJs8pyXWX07cFxbM=;
        b=i02NybjluyusZlsDHDUD6e9gYhQwSund8f3f1TNXIoAxK7eD6CJF0hdWEh9k31Eg5n
         DAbkzLi7zxiOXqFSVWBsnPNKkxVKEm2an3MxjxzCUFhFKLwJKiPPeX4RAYreDlJAAk3U
         Pyfy53Vs/SUueGiQ+vCNH5IRqQeP8swkq3pOfLM5Z+YDiRrhYNBcSwkmUyOpuqk8n3Ew
         cw3cgaJo/RzEOq15o6ZT1MpiuD3kS2QhUnA77DdWbYQdn6ljZueaimfa7yV6dtxCwPq8
         ZZVDP3G+NwwU53AfEPw13jJSJMYAIjXLruHSQxnfU5uKxBwqN5F7wic6QvpoN1wqLEvB
         dJUg==
X-Gm-Message-State: AOJu0YwYUWmuOGki8x4HeghpOi8xKjyZ7J7pEIXN8QvGj/SCkz6g3lGz
	Radohgoyj3EYtdcSOJab5sn5doczILHsvm6duww3jxBQsTX02ERFr7DoXdX1cfVwEqA+SgiZvYt
	yJ9tccRqO7RCrJeeA/9tv0YNhOikixiV8YsqudKFZjxjleL3c7Z/mzYBR8YWAurnKK+7EDg==
X-Gm-Gg: AY/fxX6xGzK96NHZxjOwVdSiHbD1U5ZUEVn6ZoGz9oSMP4lia+XjZ5TEKK7FPYW+rwy
	ID0JVlN4X3GRXLRljb9grQ0thX2B5nBrjdZ3jnaJyA1naOZ9/MMd+RBXagQSLPY0MSraXf2eAwj
	/YklojY23t2LySATXDSgvFLfd+P16OGz1ADAxNTZIpnaQ0MSKJ5dVBCP876e5w6SRoHVl4Zs9eL
	EbwXQoBJf2Nu8yVD4ub+zUOQen3IuM4TBtOrw25PCTEsB9HwukLgnjRSB/5VywZSlVR0JJQ0HOG
	OEiyc2HmdYg2EGyqoSRIiLnDi9ofiKVw5FjiL2k2LjznpZYHSkotHERBJqQRk5qru4yZ7xpVgKR
	e9TrqtCcAjfwHoh0Etug3e0ZEf6g/kiPnLIbEnnD9dbE1S+ca1s+heU1q549foww=
X-Received: by 2002:a17:90b:57f0:b0:341:2b78:61b8 with SMTP id 98e67ed59e1d1-34f68ca4536mr15104174a91.20.1768203414911;
        Sun, 11 Jan 2026 23:36:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKO/IgN3gfVBpIG9a2C5e6ZTDabLs4QW2+nni/OACwLimm9UaLCQW3e7aIs0vh7DN9xeyJrg==
X-Received: by 2002:a17:90b:57f0:b0:341:2b78:61b8 with SMTP id 98e67ed59e1d1-34f68ca4536mr15104160a91.20.1768203414370;
        Sun, 11 Jan 2026 23:36:54 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:36:54 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:21 +0800
Subject: [PATCH ath-next v2 01/18] wifi: ath12k: refactor PCI window
 register access
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-1-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX8kOpv1BpGBnA
 giA8TIgR6WqjTX5beNknhURRRc/ELjm3wkQHOjrSPC8HBoBqb4E/k96lp72lHExq+p9TPhI+SHv
 2AWkE7UVRK4xXzvB/1B33XMwK3ZXa02LtMPFJCCuG+qmv2w3V102vz9OevCnDYeV+o759JiHS2a
 WdpShUtZHi4S1zJfSz8cMMSGn7m4TTUH8jY+odDXJfwZkk0rgVDDwKMvCAB2smtj//MobGAOllI
 XlDmIDWWeBQ6zGtfkBvKH0795gfkxQAhwoKlY3vVDqM/IYjVN1Xv19LP7i9NG29aWdyz+OCFjtP
 9iJExlMXF4R51pFubvjMJP9BOKP8taZ6PYqyN0XxrBpFCR0i4uiDWLYUhJ03cj1r37kYv/o8k2H
 MhnU1gLSqg8iN8L/XQ1ldYTJI10fiZmZABAS/v6YooP13iRhYSaPDs09p8J8mtH70JjGdPUFHld
 xiqk3gWAQF7zD8Y8MZQ==
X-Authority-Analysis: v=2.4 cv=R6AO2NRX c=1 sm=1 tr=0 ts=6964a497 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-0iOq_zPj34lsyxnQQ0A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 8r7uoZus4y4CHRRzg8_CF2kojVtqgwEv
X-Proofpoint-GUID: 8r7uoZus4y4CHRRzg8_CF2kojVtqgwEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

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


