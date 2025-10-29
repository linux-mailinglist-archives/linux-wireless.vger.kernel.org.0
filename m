Return-Path: <linux-wireless+bounces-28350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945AC1800A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 03:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E2B3A7B6F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF32820DB;
	Wed, 29 Oct 2025 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eG+lj6EG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGqBLl3/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9922367DF
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703657; cv=none; b=L1sqL7awKvbZNSiQ8ddQniRNlN848j00i4JVGVmH1vLF2vU2/hxlbpmmOE5JBZVvKRpUsH98PUKT/X6faQAY7Fz2MMT1PURv/DPxuVPuFSPbV6mQojyjkOfee6EsP461YIZ3U16a5qpaLRUQUuga1VVAltFW16OHXbZppUCSLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703657; c=relaxed/simple;
	bh=dukLJ8qr6RnpgDE8Dd4ybgF6t8jY79MiNUxGQ2vSHtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RDUTGSEylOLAr4m/brk/OHMduBhVdyJ+O8T2Us7UWEPGRwL1lzK7fNr43omz5R2Qp9RdIJkYoqUsfgGUmW6ip1t13l5iL3NTNgMoaDQGKLdRsNqq+n13xYLt2DuNIFYoVuilaLxGzWG9oz50e7tVRmerO7xsW46g8nQmHexxr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eG+lj6EG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hGqBLl3/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlMg62539303
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=F/iu6iGjXVw2O/5Detpz/z
	aQ4O1XGKDWpUnpe03APtA=; b=eG+lj6EGkXe/fjjkFi1c+nnHkPMlNiywUvYUEq
	UzXq0PgPYOkKvngQua8se5ts66vyxRrNBPf9DxIlmyZEaFORmQuuiLjJqEkzEJyg
	xMA+RL6yGAmN9DJucpC+aw2nEiRGRY0eO4hC9mMU7mfvn0hpoN79sYHZIvHWK5PS
	hd6US86nn9CNxqo3ovXa2ZjBJQ+hYG6nAf4nrBbsLyo9OUmPq1hXErAlrVJ5Hsyq
	yYcYDeXTO9/5ZdJlUKjMtX76DqMxGzgVAhmpsU76NmBGEPTnlpNcAqLXbx9+Q9/p
	kBla4dUejxgBCLyDPYhZh2ogbikSIW9RLF7ptoxv8P6QTA+A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1gtjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:07:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810289cd5eso14247220b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 19:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761703653; x=1762308453; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/iu6iGjXVw2O/5Detpz/zaQ4O1XGKDWpUnpe03APtA=;
        b=hGqBLl3/X5U1/Ytc0VFMJoKhTwiJiIDKQF0CfZSCgc4c1PkGqg6iLMkUc4dFq8d2ZN
         tt3aMHSbxXVrPNpTWMeoxtPnZ3+WZ9EhHPYHlGL0cxaPK5dGJxjYF4O2jcJeJNaVyvfA
         xUmHfNLUTXTKkRiAbxzgoqas4B+bo4mbrdyFNI3ERcTKJ0ltK02B16dqfJlrNCd13ApP
         Iw7TwGLlh1t3higKKMJHosa5zG1W4c3gEqgO1RNuxaUGG1a4VkjSnCqxLMN6gPCCeWVX
         kT8ucnkFPQYLQ3ttbRdf/BAS4vcY2e8nqYGeIgrJQesT5VpkIW1t9VeuC0iMy9NrAFUO
         pD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703653; x=1762308453;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/iu6iGjXVw2O/5Detpz/zaQ4O1XGKDWpUnpe03APtA=;
        b=PcWeTkigcZERQKlfjEGCokGL3roYr4UwPQyDVqEP9SFpNBWkbx/m/RBWPPVU41FMe3
         ZHgXIstHWLqiHXvPipIdo8hEvIBaUf/ciKeGFXiyCCZgSkLX8PS6NXSE9HLdDnW1JnHF
         87DbCch7czAfgyvj8hJHsbt1KoIdRHE9STyZZi/UsL5CbOgNqzHA7K0NADgP91AihoDN
         xwFVaoSAiI+SABoNT7d7uuQYD1nB1EqFW7KHD4GCJiS/eQinGNQelG/aUadlarS6WGeW
         +47QH6yfclwh6oewHuPs1i+amaW8DskVtvWNNMT+ZguM/V9tRwj8aLZmCQyGkGu3lLgo
         euKw==
X-Gm-Message-State: AOJu0YzuWpBMx6WSPHZ8QymuBVQUcCEd+vtEHqQ8DZOtiDJK2D7TBXbr
	EJYkK6HOE1uCL6+mhJWTGcqbENx0tA9sH4YkMkcHPZri8GXq51eSLCT/Sl6b+tAXFz1Y9td5NRX
	trbG0LzThaGarT+rd0HEiDVS0Sivuyko96sIhAMzuQGl9JoMYicopxVU+Dhj6micH3Of9j3x/0g
	0iIA==
X-Gm-Gg: ASbGncup5fGfNjTvj+ZMyTx/NjMHq3EpMAswfDYAjx7cZ0v8zJxuSbX71yvvl3u9yCY
	YE7sjFVIvyG9iJr+rLdrz4AKT6ntw8h1RlOi2Awg66QxqwkZTfN4WPBhC3s9Tr7Rz8lcFk4gksO
	mCYcF0BCQATXnoXeDEFg0lrko7J89ScyndKdbJeHO4zvismkduP+hQ7qkAfyvFGeeOuNwpWQ5xG
	5yUjy9ZC1FT2S99w8UT6VMSxvbjLYGl8yDTBFIFDNjxIG/4oWBmbU8n7LSwEkps5nCH1GsWrfQw
	QHcrEFi64G8zKhdUhVy8uFBPTtNIflLH4M95U5eIokVjatEjnyFZYLI8h6kSuqKsTefZpSdDG4F
	HlkrNCRYkyLWjH/haOwVgFbzNmdZoNta3AXHWNaYO2JFNU+t13cAO
X-Received: by 2002:a05:6a00:1786:b0:7a2:8649:5ab7 with SMTP id d2e1a72fcca58-7a4e2fe7764mr1698655b3a.14.1761703653157;
        Tue, 28 Oct 2025 19:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUvjVwtp3NwrQWxnAVxZgwMjhqYYTsjLFFZpyhtM+DKRTN/RtILgRk2ESDH14aq7koiopgfg==
X-Received: by 2002:a05:6a00:1786:b0:7a2:8649:5ab7 with SMTP id d2e1a72fcca58-7a4e2fe7764mr1698625b3a.14.1761703652606;
        Tue, 28 Oct 2025 19:07:32 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm13369697b3a.45.2025.10.28.19.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:07:32 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:07:14 +0800
Subject: [PATCH ath-next] wifi: ath12k: fix reusing m3 memory
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ath12k-fix-m3-reuse-v1-1-69225bacfc5d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANF2AWkC/32NQQ6CMBBFr0Jm7ZBOSRFdeQ/DAuhUGoVqBwiGc
 HcbDuDmJz8v7/8NhKNngWu2QeTFiw9jKnTKoOub8cHobeqglTakdIXN1JN+ovMrDgVGnoWRjLO
 2UmWrLg6S+Y6c+LF6hyTgyOsEdSK9lynE73G30MH/Li+EhOWFrDGtLuzZ3YJI/pmbVxeGIU8B9
 b7vP3MetW3HAAAA
X-Change-ID: 20251028-ath12k-fix-m3-reuse-15fdd806b09f
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=690176e7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1qHGFEiZaCHBQHMGWPoA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: -kEhAydT6qtztz1o60Hy2qnXmchvIeBj
X-Proofpoint-ORIG-GUID: -kEhAydT6qtztz1o60Hy2qnXmchvIeBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAxNSBTYWx0ZWRfX3OzQMCbaFG8c
 7IqTF0K+zM4PkrccfLfNsnBFqegDEfxVGgb7ddcc/wsRMx+wyhW7RfdXIgz2LtZyxMPzYy/8s2T
 XwQGkck0KIua+6wEjh5p/4Cl4UXish0j6Eg/u8B3x1bGyr0eoY9DmkO9hJIRIhUEG//DFftvc2Y
 opoUqTar+xS1XRab+GDmI5qxTVqyeT/sq51MNLdFILV4svohcg1tLIAymwH0ZL0///3kerKNLai
 7Mz54xV+5ff47fK4Uq9/v9vBnv82OxdADj11oIJp04vEFicAzSjIdAtRmusJOD5rHO9HEuTHbb6
 3pR4Nzw4/0uD02u/qWFjMoGyYXu8TZx7Xw2EbLUXYhjfNj88hvGZZ1ypN5vEa9F+TDS5KGvSX8t
 tKodNYynLqGhNAHzlcDG4ZrZYKCSiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290015

During firmware recovery or suspend/resume, m3 memory could be reused if
the size of the new m3 binary is equal to or less than that of the
existing memory. There will be issues for the latter case, since
m3_mem->size will be updated with a smaller value and this value is
eventually used in the free path, where the original total size should be
used instead.

To fix it, add a new member in m3_mem_region structure to track the original
memory size and use it in free path.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 05090ae82f44 ("wifi: ath12k: check M3 buffer size as well whey trying to reuse it")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 11 +++++++----
 drivers/net/wireless/ath/ath12k/qmi.h |  5 ++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 36325e62aa2423fcc091d6d447700d6598a16317..8de9aee2498ec55e2065f655993d929ddf696e82 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/elf.h>
@@ -3114,9 +3114,10 @@ static void ath12k_qmi_m3_free(struct ath12k_base *ab)
 	if (!m3_mem->vaddr)
 		return;
 
-	dma_free_coherent(ab->dev, m3_mem->size,
+	dma_free_coherent(ab->dev, m3_mem->total_size,
 			  m3_mem->vaddr, m3_mem->paddr);
 	m3_mem->vaddr = NULL;
+	m3_mem->total_size = 0;
 	m3_mem->size = 0;
 }
 
@@ -3152,7 +3153,7 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 
 	/* In recovery/resume cases, M3 buffer is not freed, try to reuse that */
 	if (m3_mem->vaddr) {
-		if (m3_mem->size >= m3_len)
+		if (m3_mem->total_size >= m3_len)
 			goto skip_m3_alloc;
 
 		/* Old buffer is too small, free and reallocate */
@@ -3164,11 +3165,13 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 					   GFP_KERNEL);
 	if (!m3_mem->vaddr) {
 		ath12k_err(ab, "failed to allocate memory for M3 with size %zu\n",
-			   fw->size);
+			   m3_len);
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	m3_mem->total_size = m3_len;
+
 skip_m3_alloc:
 	memcpy(m3_mem->vaddr, m3_data, m3_len);
 	m3_mem->size = m3_len;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 4767d9a2e309e48e4a9939296ec99513536af953..7a88268aa1e9e99a13034003cf2ca7d21ccb7573 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_QMI_H
@@ -120,6 +120,9 @@ struct target_info {
 };
 
 struct m3_mem_region {
+	/* total memory allocated */
+	u32 total_size;
+	/* actual memory being used */
 	u32 size;
 	dma_addr_t paddr;
 	void *vaddr;

---
base-commit: a6199e69fc9ce2da461aad389a875cfdf99fc283
change-id: 20251028-ath12k-fix-m3-reuse-15fdd806b09f

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


