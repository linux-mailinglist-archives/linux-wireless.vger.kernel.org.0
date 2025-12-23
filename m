Return-Path: <linux-wireless+bounces-30083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE7DCD8945
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 10:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 880C7301673A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44C322B8A;
	Tue, 23 Dec 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6bLbQAw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j2TSS6JM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5BEDDC5
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482063; cv=none; b=C+8GRzU2qadMU4yMjZLjwHZBOmdP+Kv7MfbJcS3ut4LXFYyyhAAUdPdyM6AhjqBVDGntq3Bqolm2NhdmGM17/hmptXgg7KqE2wFjaJHjZO7UmTkrP4SmcCHrhC6qBBSO7qIdyQh5e2C4s7QpvoYx+EjcjYhlcC/yBipIbohSqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482063; c=relaxed/simple;
	bh=qATZpC8uZ/cWfqRfBVBzw/kr5WemkBE8cgv4++vXBcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQfuFat+UkHCSurYeEXcqkzuISjwIq10n5sxTBZCKruYwhwISMPs3ED9titl6sUO+a3uYPfQUlnbZMEcgodscMtMkibijt3lbjj+IKppNMbXfEytPlIo9KdXiRH8PkSzxCThmrtD8Ix9DmFhLsQeebhQN3nMcAUUipR47ufY0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O6bLbQAw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j2TSS6JM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN8HfeF3044900
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WrRrP5GLTbz
	KHlDctyucA+nBWzW3CaNcyST72dqkTmA=; b=O6bLbQAwZrYW/1JFUivwVt3DNh8
	O/MPJ3nfyczghBqN1kHZkHRKE5DOngvhx7f8k6otcT4O+sqqSYEecDZ0xBPxGDjm
	wqaPVyHyu4Nols097rnhnsPQgGB4SQNULmV5i5ph1dEKFY33myXPooAZy200xGUZ
	XK5v7PBqABozPQpIlxi2tfdayYw+WB+eJD3p9ISGbdZEsCpDvHe1o/QRHjgryukz
	8MBx1t+EM58OCUOg3K9srikOw+xLWdoRI7FvcQG8nCfb5vC5AjDXPM7aIxR/cdR5
	WUA9lilL8FJXPBuJAnOZqOneFGPAQtrgMmZ8nHCN821KFFT9baYJerbSCzg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b74takan3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62da7602a0so4948387a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 01:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766482059; x=1767086859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrRrP5GLTbzKHlDctyucA+nBWzW3CaNcyST72dqkTmA=;
        b=j2TSS6JMRwmWDUV/TgS1tWbfa6V/591rLfcX2vpoEkByjzSDz1L4z837JBpig0PkSy
         PCazTNs9C7aSH30hTiu9y9wdf746/PpxcLp0+ArFrKevXDAG48WfH3FjICwEK8b6/k40
         67PEIPs5+UHK45caId71I+YHRH4pCKpflOKl42XxK6iJkeaOEZ6Gd8xoyWrX2PlkRvDH
         ZBO1/CpMEtCZ7miiA+eowTwEn7C7fNi5WOMBER7v5UleVAwwaPTMkB1hoAqF3svLFmgB
         zvp/RRF7ayHK9PsTfJ/dffMf85vHj+wv/9gKN2bJLJPDf/dXbUidRK3KM0Oc9xvrrEKb
         716A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766482059; x=1767086859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WrRrP5GLTbzKHlDctyucA+nBWzW3CaNcyST72dqkTmA=;
        b=b8qxaGtPMqby+nyECkQrG4rnoxCweq9jcACQvdksuuzzEjQJRcrz4I65ZlBdCmkiTX
         9QasuHLGODpsvgkkmgfVPjqzq7JKUNQYq58dQpZIoxbOlhhT5MSmlVMbNh3RtIHxYblr
         cwDxZN2e1u7OV7NQ8E7ZNXwb7KmivXzUSRGGT20hBxWemZ2TgNiuzTVRY4Zio4cRMGKO
         aikE75qQb4IfFibw6caUsuuFaXfb4urk0BlnRfTMHrirTs+lVEIbQe2qqvU/SZYzYyMP
         xvh+Em45Ta4vd7kUiDFCyEKn23n2FqBc+AWDDe4OGvqofK8KV+TbqSDvdhx6k91oSIxC
         qHKg==
X-Gm-Message-State: AOJu0Yyy78R00LZ4NKl9Zhj0Km6kiBLUn+oGz6KWz6rTAQFsUtKg/ngW
	1J35M3GrnEh3VGDWc/45rGAnwIySilWU1lPtocyBwFdckjdj8iZ5edznoI6q6bypRgfJG4pIroN
	1Ma22585jyybAC1TTC9YRGtHk8DpmU6gRik+2Mus1VpMeTkN/BdoXoBs+FE0L+uKMSRF1TQ==
X-Gm-Gg: AY/fxX7mapeOdEVT00/t/sQ3dK8gPOh1bBLro/NL5VhGhLiJXMpEXMx1inDUvrISSw0
	hEsO2xuwmTR5pFE4owUrkdof8iOTUkjLzoooBMEbLQzSP0NIQlZGRsj5eyCDIA5WA9pA9emnl6c
	OxpFbyK3H0BbCmpAY1ilnkqZosqHanuB5WtxLfXFOi8NYv7TI102reI2xIAM5EL/lE8J5DUZvvt
	Gl+bgeYw272CDEAkU6kJkC8wNlf7/BVKC4AQCDDz6WynnZemlz3vIdANU6OeKiZUAHzFQqiJEoA
	ZnND+subLvthWMjcXN7Mq6KVoFwC00GYRz/lr5qa62caQVYns/n/q66LrwnFzK7gcdymID8awyc
	4H57tFsLnvAtfkxh1F0ebocaaKvLVk0YTKno=
X-Received: by 2002:a05:7022:428b:b0:11b:94ab:be03 with SMTP id a92af1059eb24-121722ab5efmr15613843c88.20.1766482058858;
        Tue, 23 Dec 2025 01:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmR/a5Qzk5XuXhjCBEDHSc9T+j13LLotnJ9/R9wHBHX6fZk8JT/XDvRzrRLRoFiih5Rkg2Rg==
X-Received: by 2002:a05:7022:428b:b0:11b:94ab:be03 with SMTP id a92af1059eb24-121722ab5efmr15613814c88.20.1766482058101;
        Tue, 23 Dec 2025 01:27:38 -0800 (PST)
Received: from hu-zhangq-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm56130940c88.0.2025.12.23.01.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:27:37 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Qian Zhang <qian.zhang@oss.qualcomm.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v4 1/6] wifi: ath11k: Add initialization and deinitialization sequence for CFR module
Date: Tue, 23 Dec 2025 14:57:23 +0530
Message-Id: <20251223092728.1950017-2-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DPiCIiNb c=1 sm=1 tr=0 ts=694a608c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=sTJiG90S0w3vqaoQ0_0A:9
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: j9rnuI6GaQWJncPd7BObTVt9KCyhHUla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NSBTYWx0ZWRfX948SEbyn4o/s
 X8N8RjWutdctqdV6V+WjW1q7iVN4cJGjSnUM+3KNMD5FqEuLNn78TYQ+czHPUjOc6p/vqD8yuON
 U1gH2lw3ve+CtQJosT+RHAEy3wzhyHsa4mMeA2gJ5cb6dLa42ex/KmERjPVJxU/g/cbJAyh0hPj
 uQiXs+6dxmHhuj4kG26885inRxb0NpG+IqEc4Cdr5rTlPkhvIGIXRA7M5yZ2zWEZm6EO1ImlIAQ
 MD/arLAb0tqyjooKxenIO7bGO1bgdM1AqWvksmia2D6JVE5NOiaJK3epC+6PhjYkNEtLZYbOCeB
 ADa6kHeYOpIAbR0GbU1JVBDEtS1ic+y/FM95uIh2dN8pVHV8uG3RAWPno3jN5Z0GcTjOnoVis7S
 CHC+tPQHfSNwo6N5+EeHM1khet6D+FW/E2rdDTJ282QthDicjsbmVPyFGOB5itujoLhpfq66Ktv
 i9QLmbQIfNeWVv0jX2w==
X-Proofpoint-ORIG-GUID: j9rnuI6GaQWJncPd7BObTVt9KCyhHUla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230075

Channel Frequency Response (CFR) module will be initialized only when
the following criteria passes:
 * Enabled CFR support for the hardware through the hardware param
   'cfr_support'
 * WMI service enabled for the CFR support
   'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'

Also, provide a configuration option CONFIG_ATH11K_CFR to enable CFR
feature support during the compilation time.

CFR module initialization includes Direct Buffer(DB) ring initialization
where hardware uses the DB ring buffers to copy CFR data to host.
Number of buffers and buffer size of the ring is based on the DB ring
capabilities advertised by the firmware through WMI service ready.
Also ring configurations are sent to firmware through
ath11k_dbring_wmi_cfg_setup().

Predefine ath11k_cfr_dma_hdr, ath11k_look_up_table, and ath11k_cfr
structs and fields for subsequent patches.

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig  |  11 ++
 drivers/net/wireless/ath/ath11k/Makefile |   1 +
 drivers/net/wireless/ath/ath11k/cfr.c    | 170 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h    |  85 ++++++++++++
 drivers/net/wireless/ath/ath11k/core.c   |  41 +++++-
 drivers/net/wireless/ath/ath11k/core.h   |   8 +-
 drivers/net/wireless/ath/ath11k/dbring.c |  40 ++++--
 drivers/net/wireless/ath/ath11k/dbring.h |   6 +-
 drivers/net/wireless/ath/ath11k/hal.c    |   3 +-
 drivers/net/wireless/ath/ath11k/hw.h     |   5 +-
 drivers/net/wireless/ath/ath11k/wmi.h    |   1 +
 11 files changed, 354 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 659ef134ef16..47dfd39caa89 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -58,3 +58,14 @@ config ATH11K_SPECTRAL
 	  Enable ath11k spectral scan support
 
 	  Say Y to enable access to the FFT/spectral data via debugfs.
+
+config ATH11K_CFR
+	bool "ath11k channel frequency response support"
+	depends on ATH11K_DEBUGFS
+	depends on RELAY
+	help
+	  Enable ath11k channel frequency response dump support.
+	  This option exposes debugfs nodes that will allow the user
+	  to enable, disable, and dump data.
+
+	  Say Y to enable CFR data dump collection via debugfs.
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index d9092414b362..b1435fcf3e1b 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -28,6 +28,7 @@ ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 ath11k-$(CONFIG_PM) += wow.o
 ath11k-$(CONFIG_DEV_COREDUMP) += coredump.o
+ath11k-$(CONFIG_ATH11K_CFR) += cfr.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
new file mode 100644
index 000000000000..78e356672eba
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/relay.h>
+#include "core.h"
+#include "debug.h"
+
+static int ath11k_cfr_process_data(struct ath11k *ar,
+				   struct ath11k_dbring_data *param)
+{
+	return 0;
+}
+
+void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
+				 u32 buf_id)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	if (cfr->lut)
+		cfr->lut[buf_id].dbr_address = paddr;
+}
+
+static void ath11k_cfr_ring_free(struct ath11k *ar)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
+	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
+}
+
+static int ath11k_cfr_ring_alloc(struct ath11k *ar,
+				 struct ath11k_dbring_cap *db_cap)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	int ret;
+
+	ret = ath11k_dbring_srng_setup(ar, &cfr->rx_ring,
+				       ATH11K_CFR_NUM_RING_ENTRIES,
+				       db_cap->min_elem);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring: %d\n", ret);
+		return ret;
+	}
+
+	ath11k_dbring_set_cfg(ar, &cfr->rx_ring,
+			      ATH11K_CFR_NUM_RESP_PER_EVENT,
+			      ATH11K_CFR_EVENT_TIMEOUT_MS,
+			      ath11k_cfr_process_data);
+
+	ret = ath11k_dbring_buf_setup(ar, &cfr->rx_ring, db_cap);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring buffer: %d\n", ret);
+		goto srng_cleanup;
+	}
+
+	ret = ath11k_dbring_wmi_cfg_setup(ar, &cfr->rx_ring, WMI_DIRECT_BUF_CFR);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring cfg: %d\n", ret);
+		goto buffer_cleanup;
+	}
+
+	return 0;
+
+buffer_cleanup:
+	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
+srng_cleanup:
+	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
+	return ret;
+}
+
+void ath11k_cfr_deinit(struct ath11k_base *ab)
+{
+	struct ath11k_cfr *cfr;
+	struct ath11k *ar;
+	int i;
+
+	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
+	    !ab->hw_params.cfr_support)
+		return;
+
+	for (i = 0; i <  ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		cfr = &ar->cfr;
+
+		if (!cfr->enabled)
+			continue;
+
+		ath11k_cfr_ring_free(ar);
+
+		spin_lock_bh(&cfr->lut_lock);
+		kfree(cfr->lut);
+		cfr->lut = NULL;
+		cfr->enabled = false;
+		spin_unlock_bh(&cfr->lut_lock);
+	}
+}
+
+int ath11k_cfr_init(struct ath11k_base *ab)
+{
+	struct ath11k_dbring_cap db_cap;
+	struct ath11k_cfr *cfr;
+	u32 num_lut_entries;
+	struct ath11k *ar;
+	int i, ret;
+
+	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
+	    !ab->hw_params.cfr_support)
+		return 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		cfr = &ar->cfr;
+
+		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
+					    WMI_DIRECT_BUF_CFR, &db_cap);
+		if (ret)
+			continue;
+
+		idr_init(&cfr->rx_ring.bufs_idr);
+		spin_lock_init(&cfr->rx_ring.idr_lock);
+		spin_lock_init(&cfr->lock);
+		spin_lock_init(&cfr->lut_lock);
+
+		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);
+		cfr->lut = kcalloc(num_lut_entries, sizeof(*cfr->lut),
+				   GFP_KERNEL);
+		if (!cfr->lut) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = ath11k_cfr_ring_alloc(ar, &db_cap);
+		if (ret) {
+			ath11k_warn(ab, "failed to init cfr ring for pdev %d: %d\n",
+				    i, ret);
+			spin_lock_bh(&cfr->lut_lock);
+			kfree(cfr->lut);
+			cfr->lut = NULL;
+			cfr->enabled = false;
+			spin_unlock_bh(&cfr->lut_lock);
+			goto err;
+		}
+
+		cfr->lut_num = num_lut_entries;
+		cfr->enabled = true;
+	}
+
+	return 0;
+
+err:
+	for (i = i - 1; i >= 0; i--) {
+		ar = ab->pdevs[i].ar;
+		cfr = &ar->cfr;
+
+		if (!cfr->enabled)
+			continue;
+
+		ath11k_cfr_ring_free(ar);
+
+		spin_lock_bh(&cfr->lut_lock);
+		kfree(cfr->lut);
+		cfr->lut = NULL;
+		cfr->enabled = false;
+		spin_unlock_bh(&cfr->lut_lock);
+	}
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
new file mode 100644
index 000000000000..3534176c3e01
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH11K_CFR_H
+#define ATH11K_CFR_H
+
+#include "dbring.h"
+#include "wmi.h"
+
+#define ATH11K_CFR_NUM_RESP_PER_EVENT   1
+#define ATH11K_CFR_EVENT_TIMEOUT_MS     1
+#define ATH11K_CFR_NUM_RING_ENTRIES     1
+
+#define CFR_MAX_LUT_ENTRIES 136
+
+#define HOST_MAX_CHAINS 8
+
+struct ath11k_cfr_dma_hdr {
+	u16 info0;
+	u16 info1;
+	u16 sw_peer_id;
+	u16 phy_ppdu_id;
+};
+
+struct ath11k_look_up_table {
+	bool dbr_recv;
+	bool tx_recv;
+	u8 *data;
+	u32 data_len;
+	u16 dbr_ppdu_id;
+	u16 tx_ppdu_id;
+	dma_addr_t dbr_address;
+	struct ath11k_cfr_dma_hdr hdr;
+	u64 txrx_tstamp;
+	u64 dbr_tstamp;
+	u32 header_length;
+	u32 payload_length;
+	struct ath11k_dbring_element *buff;
+};
+
+struct ath11k_cfr {
+	struct ath11k_dbring rx_ring;
+	/* Protects cfr data */
+	spinlock_t lock;
+	/* Protect for lut entries */
+	spinlock_t lut_lock;
+	struct ath11k_look_up_table *lut;
+	u32 lut_num;
+	u64 tx_evt_cnt;
+	u64 dbr_evt_cnt;
+	u64 release_cnt;
+	u64 tx_peer_status_cfr_fail;
+	u64 tx_evt_status_cfr_fail;
+	u64 tx_dbr_lookup_fail;
+	u64 last_success_tstamp;
+	u64 flush_dbr_cnt;
+	u64 clear_txrx_event;
+	u64 cfr_dma_aborts;
+	bool enabled;
+};
+
+#ifdef CONFIG_ATH11K_CFR
+int ath11k_cfr_init(struct ath11k_base *ab);
+void ath11k_cfr_deinit(struct ath11k_base *ab);
+void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
+				 u32 buf_id);
+#else
+static inline int ath11k_cfr_init(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_cfr_deinit(struct ath11k_base *ab)
+{
+}
+
+static inline void ath11k_cfr_lut_update_paddr(struct ath11k *ar,
+					       dma_addr_t paddr, u32 buf_id)
+{
+}
+#endif /* CONFIG_ATH11K_CFR */
+#endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 812686173ac8..6a6bf6316ac9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -126,6 +125,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = true,
+		.cfr_num_stream_bufs = 255,
+		.cfr_stream_buf_size = 8200,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -211,6 +213,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -301,6 +306,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -385,6 +393,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -475,6 +486,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -563,6 +577,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = true,
+		.cfr_num_stream_bufs = 255,
+		.cfr_stream_buf_size = 8200,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -646,6 +663,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = false,
 		.pdev_suspend = true,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ5018_HW10,
@@ -729,6 +749,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
 		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qca2066 hw2.1",
@@ -818,6 +841,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qca6698aq hw2.1",
@@ -906,6 +932,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
 		.pdev_suspend = false,
+		.cfr_support = true,
+		.cfr_num_stream_bufs = 255,
+		.cfr_stream_buf_size = 8200,
 	},
 };
 
@@ -1987,8 +2016,16 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 		goto err_thermal_unregister;
 	}
 
+	ret = ath11k_cfr_init(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init cfr %d\n", ret);
+		goto err_spectral_unregister;
+	}
+
 	return 0;
 
+err_spectral_unregister:
+	ath11k_spectral_deinit(ab);
 err_thermal_unregister:
 	ath11k_thermal_unregister(ab);
 err_mac_unregister:
@@ -2038,6 +2075,7 @@ static void ath11k_core_pdev_suspend_target(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
+	ath11k_cfr_deinit(ab);
 	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
@@ -2250,6 +2288,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_lock(&ab->core_lock);
 	ath11k_thermal_unregister(ab);
 	ath11k_dp_pdev_free(ab);
+	ath11k_cfr_deinit(ab);
 	ath11k_spectral_deinit(ab);
 	ath11k_ce_cleanup_pipes(ab);
 	ath11k_wmi_detach(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e8780b05ce11..40fb7cee3e43 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_CORE_H
@@ -35,6 +35,7 @@
 #include "wow.h"
 #include "fw.h"
 #include "coredump.h"
+#include "cfr.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -795,6 +796,11 @@ struct ath11k {
 	bool ps_state_enable;
 	bool ps_timekeeper_enable;
 	s8 max_allowed_tx_power;
+
+#ifdef CONFIG_ATH11K_CFR
+	struct ath11k_cfr cfr;
+#endif
+	bool cfr_enabled;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 520d8b8662a2..ed2b781a6bab 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -37,10 +36,10 @@ static void ath11k_dbring_fill_magic_value(struct ath11k *ar,
 	memset32(buffer, ATH11K_DB_MAGIC_VALUE, size);
 }
 
-static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
-					struct ath11k_dbring *ring,
-					struct ath11k_dbring_element *buff,
-					enum wmi_direct_buffer_module id)
+int ath11k_dbring_bufs_replenish(struct ath11k *ar,
+				 struct ath11k_dbring *ring,
+				 struct ath11k_dbring_element *buff,
+				 enum wmi_direct_buffer_module id)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_srng *srng;
@@ -80,6 +79,9 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 		goto err_idr_remove;
 	}
 
+	if (id == WMI_DIRECT_BUF_CFR)
+		ath11k_cfr_lut_update_paddr(ar, paddr, buf_id);
+
 	buff->paddr = paddr;
 
 	cookie = FIELD_PREP(DP_RXDMA_BUF_COOKIE_PDEV_ID, ar->pdev_idx) |
@@ -155,12 +157,11 @@ int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 				enum wmi_direct_buffer_module id)
 {
 	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd param = {};
-	int ret;
+	int ret, i;
 
 	if (id >= WMI_DIRECT_BUF_MAX)
 		return -EINVAL;
 
-	param.pdev_id		= DP_SW2HW_MACID(ring->pdev_id);
 	param.module_id		= id;
 	param.base_paddr_lo	= lower_32_bits(ring->refill_srng.paddr);
 	param.base_paddr_hi	= upper_32_bits(ring->refill_srng.paddr);
@@ -173,10 +174,23 @@ int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 	param.num_resp_per_event = ring->num_resp_per_event;
 	param.event_timeout_ms	= ring->event_timeout_ms;
 
-	ret = ath11k_wmi_pdev_dma_ring_cfg(ar, &param);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
-		return ret;
+	/* For single pdev, 2GHz and 5GHz use one DBR. */
+	if (ar->ab->hw_params.single_pdev_only) {
+		for (i = 0; i < ar->ab->target_pdev_count; i++) {
+			param.pdev_id = ar->ab->target_pdev_ids[i].pdev_id;
+			ret = ath11k_wmi_pdev_dma_ring_cfg(ar, &param);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
+				return ret;
+			}
+		}
+	} else {
+		param.pdev_id = DP_SW2HW_MACID(ring->pdev_id);
+		ret = ath11k_wmi_pdev_dma_ring_cfg(ar, &param);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -285,6 +299,10 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	pdev_idx = ev->fixed.pdev_id;
 	module_id = ev->fixed.module_id;
 
+	if (ab->hw_params.single_pdev_only &&
+	    pdev_idx < ab->target_pdev_count)
+		pdev_idx = 0;
+
 	if (pdev_idx >= ab->num_radios) {
 		ath11k_warn(ab, "Invalid pdev id %d\n", pdev_idx);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
index 2f93b78a50df..0a380120f7a0 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.h
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_DBRING_H
@@ -61,6 +61,10 @@ int ath11k_dbring_set_cfg(struct ath11k *ar,
 			  u32 event_timeout_ms,
 			  int (*handler)(struct ath11k *,
 					 struct ath11k_dbring_data *));
+int ath11k_dbring_bufs_replenish(struct ath11k *ar,
+				 struct ath11k_dbring *ring,
+				 struct ath11k_dbring_element *buff,
+				 enum wmi_direct_buffer_module id);
 int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 				struct ath11k_dbring *ring,
 				enum wmi_direct_buffer_module id);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 0c797b8d0a27..e821e5a62c1c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/dma-mapping.h>
@@ -184,7 +183,7 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 	},
 	{ /* RXDMA DIR BUF */
 		.start_ring_id = HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
-		.max_rings = 1,
+		.max_rings = 2,
 		.entry_size = 8 >> 2, /* TODO: Define the struct */
 		.lmac_ring = true,
 		.ring_dir = HAL_SRNG_DIR_SRC,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 52d9f4c13b13..e13ca02a9d05 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_HW_H
@@ -228,6 +228,9 @@ struct ath11k_hw_params {
 	bool support_fw_mac_sequence;
 	bool support_dual_stations;
 	bool pdev_suspend;
+	bool cfr_support;
+	u32 cfr_num_stream_bufs;
+	u32 cfr_stream_buf_size;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0f0de24a3840..7a55fe0879c0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -981,6 +981,7 @@ enum wmi_tlv_pdev_param {
 	WMI_PDEV_PARAM_RADIO_CHAN_STATS_ENABLE,
 	WMI_PDEV_PARAM_RADIO_DIAGNOSIS_ENABLE,
 	WMI_PDEV_PARAM_MESH_MCAST_ENABLE,
+	WMI_PDEV_PARAM_PER_PEER_CFR_ENABLE = 0xa8,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_THRESHOLD = 0xbc,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_PER_AC = 0xbe,
 	WMI_PDEV_PARAM_ENABLE_SR_PROHIBIT = 0xc6,

base-commit: 25f833fff81de4fbb9b5382806860b63768567e8
-- 
2.34.1


