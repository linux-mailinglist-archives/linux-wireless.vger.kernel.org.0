Return-Path: <linux-wireless+bounces-27961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B039CBD716B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B4054EF7EC
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075CDDAB;
	Tue, 14 Oct 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXqgRj4a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B23132117
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409047; cv=none; b=SHe0vWERDv5MeptC0157pl58oThFVKZ92YCbWhw6l5B7NBgGh39UxNlynZkQ9hOmjRAQwSZA3vesFPVI2ESLCZxxtiEuXdx4ho60jF7oH46jn+ZtNDMEHqswxp3AVRsLEq+2FI0elWDq27rTRjO7KigvYJU5bKd8tE8JttuXWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409047; c=relaxed/simple;
	bh=rrbae/kgHTRQaeisa35dqCdkcy/H6ijayNEU1ZgTJFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ke7z7HM+RnNrq8sapDHabcExn6vZ41YrIdLncmzNuo4BlYX1tEEzCKhMYjFthF7kVypf/Q814uXWGKaXbHUIJJ2+IPnRaRudT+jXUwBxusD7X1o4h8x1upywL5hKBhmHRuz1+4U1pgQ5HlMTMdTPCewVXylAIEa1Kom8oAtsE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXqgRj4a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHD7G4005522
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 02:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zJcWT4YZkXLG586SXAcGSj
	1QTbSwkWBb4nWk0Km2Ipc=; b=nXqgRj4aRoTh3V0UAYKL14M7btT+OtBIIm4x80
	DjfW1WoVYoXeVydi3ZgVOt4VBCOz+4OKRFDeJYAuVEAcQYH2mMJpzFXjo1u+22S3
	FmyvCyetLFxj0H3DBNmA2BRWsn9esBIW+URgsp1Uzl1+/NV5WvzLKKfUU0clr2Db
	jaOIqC+8BhW9A/8vlhxzRWmXZgSKUVRMyLV3JQqii5/9S/XpLoggVr9MYWfL/5HK
	DTJXrLQtk1ifxts2Afy5LDZ+1wpT3x+0AgLh9TCZ787hdzXvZU7n7tBimguxpAQX
	YH9iqXvE6iX/x48qpwbUKQoE3vKY/Si0POHL1bR20m7xGuXg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa86v9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 02:30:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2681642efd9so86268045ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 19:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409043; x=1761013843;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJcWT4YZkXLG586SXAcGSj1QTbSwkWBb4nWk0Km2Ipc=;
        b=AbxLoam+cd/+SHAcmodtnoVcggCkLwsbu9Im8tPwAEE8QIobSKhG5PncyyRCylKz/j
         ekf1LmvT026PoNO6J6QycpPzvTPQcVmBq/q83y15vZhSZo/wrUtnAyIKcx0RhH5DuLxD
         hM8iJLJXRnKBCCVLFY1HvjwlhVmDU7zJLxARDyuTLCKq3fAUjky64ECSf31UQF0im9Lu
         Y4FF3LpSIq6SwjHSOKmKTgA49nEK5AczRdwePlkrazasnBGLYfVu5fKvaMqotnwpF5mM
         dhPXdB/FuM3FWvXMrpL0gz7UmViJcKEG9eEDHnGJL+pVMoJ4Yt3nZhNOvf/4RZknUm9Y
         DeNg==
X-Gm-Message-State: AOJu0YzfbceUA5NzGlHKp5pxPLlWriu+yEM/VNQCsIrBWO2Qi//AB1Ps
	MOLpPaIIEAlh7wnegOgvPGMTReyjs5vLi8xr+AdusoEDa2lsdfWdBBOxqD1fob4r1EwrSObIYSz
	e5XP3Htcb7i+j6T4AklMXmxA+qZwgYMVAE3ZcGAgqRu9tibFme89QKZWDT4emH4nRnFwmRA==
X-Gm-Gg: ASbGncseo8vdntCscqyO4a9jmMXHGFPDYXkRrIiQOLLJPPsnbFPIhkMcLwlanN+rX2T
	sMlz+VpoVl/XvV0EtBiIaXBB7G21c1YO4HeMQx8W9oazRJ3HEkhC1NKDIaj26qYQQgydU7B5lNj
	HVrS6AkRl+vevEEhnJ8iiv4wmJChI5Mjfxf22N0R7WJg3y3zPbWt9S+tYLCEsdUg2kGkgKqMLY6
	XQ86RpuRZYbgxBIoHhUZd+xR9m0bQY4WtWVV4Kuey3K4N86EXAILcNp9W12LtAJVljxTEtOxceZ
	ABAAV7hkQIqkRz96JURkrFzKMouMk7FdJ2CPeuaAgGTehCrfe3XuxSKlfZn4tx8n1c2YIN2/1Ne
	v8Dj4+2HujGS2uTw+5Q==
X-Received: by 2002:a17:902:e945:b0:269:8f2d:5221 with SMTP id d9443c01a7336-29027290222mr261697035ad.9.1760409043192;
        Mon, 13 Oct 2025 19:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg6GyZJookUaidvGFEfNAkvOYWYnzVC9xYSFslCJHqyUACD4cXLWUWUM082/t51M/TwXw2sQ==
X-Received: by 2002:a17:902:e945:b0:269:8f2d:5221 with SMTP id d9443c01a7336-29027290222mr261696645ad.9.1760409042592;
        Mon, 13 Oct 2025 19:30:42 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060754sm13388487b3a.13.2025.10.13.19.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 19:30:42 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:30:20 +0800
Subject: [PATCH ath-next] wifi: ath11k: restore register window after
 global reset
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-ath11k-reset-window-cache-v1-1-b85271b111dd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALy17WgC/42NQQ6CMBBFr0Jm7RCmIKgr72FYFDrYRmm1rYAh3
 N2GE7j5yc/Lf3+FwN5wgEu2gufJBONsKnTIoNfS3hmNSh1EIY5FUxLKqIke6DlwxNlY5WbsZa8
 Zq7Oo1XAibjoFaf/yPJhld98gzdDyEqFNRJsQnf/upxPt/A//REjY1VRXshSqE/LqQsjfH/ns3
 TjmKaDdtu0HbgF40dMAAAA=
X-Change-ID: 20250731-ath11k-reset-window-cache-4926df81e7bd
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 3ap5N6GE_Xmm4kUL_9LLx7xLuPIRvlAl
X-Proofpoint-ORIG-GUID: 3ap5N6GE_Xmm4kUL_9LLx7xLuPIRvlAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX/F5j+fFX5vE0
 IYqBUTr54Y+DHTBT3OYP/t12sML4GK0p+OHINTEjrCK2/UJFFrKOMth//XUxW6OY48iYb6y13EA
 xm+KfN3ptNSwnLBNuZbhuZSyLS7gEFi87swSdkTr1OshcTlYeToBUCplJjpvcdBRsTaxKbUBj9o
 PiKL8hc+LSLrJXvqyKjyyOeHc0zcNRSleawvybdpLnWKRix5eSP3T4Nf5CrOgyYcBA2GTe5fagE
 toWLm4eBT2I72puQn8erGC275+TVnABqmJrYBZmY/4Mn70Y/G4ePb3Yp+NQaDnfoQoyyUBeb1eR
 IyRnkkDanbzMzoi9OalfIE8gmY+H/lU5qp8NZg0jzROwlz6EZPjv5oQnrq1pEGyUfqTA9s7W8oN
 ay8y8ZjskSB6G0FdZQMMmtjtAOhQXA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68edb5d4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=n-cauTe5lKxIj1BHfEsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

Hardware target implements an address space larger than that PCI BAR can
map. In order to be able to access the whole target address space, the BAR
space is split into 4 segments, of which the last 3, called windows, can
be dynamically mapped to the desired area. This is achieved by updating
window register with appropriate window value. Currently each time when
accessing a register that beyond ATH11K_PCI_WINDOW_START, host calculates
the window value and caches it after window update, this way next time
when accessing a register falling in the same window, host knows that the
window is already good hence no additional update needed.

However this mechanism breaks after global reset is triggered in
ath11k_pci_soc_global_reset(), because with global reset hardware resets
window register hence the window is not properly mapped any more. Current
host does nothing about this, as a result a subsequent register access may
not work as expected if it falls in a window same as before.

Although there is no obvious issue seen now, better to fix it to avoid
future problem. The fix is done by restoring the window register after
global reset.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d8655badd96d0f4b6946f8af927d878aaa3147ad..7114eca8810dbfac895eebfefe2e48673d065347 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
@@ -177,6 +177,19 @@ static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
 		  ab_pci->ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
 }
 
+static void ath11k_pci_restore_window(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	spin_lock_bh(&ab_pci->window_lock);
+
+	iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | ab_pci->register_window,
+		  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+	ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+
+	spin_unlock_bh(&ab_pci->window_lock);
+}
+
 static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 {
 	u32 val, delay;
@@ -201,6 +214,11 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 	val = ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
 	if (val == 0xffffffff)
 		ath11k_warn(ab, "link down error during global reset\n");
+
+	/* Restore window register as its content is cleared during
+	 * hardware global reset, such that it aligns with host cache.
+	 */
+	ath11k_pci_restore_window(ab);
 }
 
 static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)

---
base-commit: de7674ee69a0023a2dd1c6f0cb66f3cbbba89923
change-id: 20250731-ath11k-reset-window-cache-4926df81e7bd

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


