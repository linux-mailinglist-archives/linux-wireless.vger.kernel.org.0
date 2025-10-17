Return-Path: <linux-wireless+bounces-28002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B68BE61D3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061815850D1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6B224AF3;
	Fri, 17 Oct 2025 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vh1qiGO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F7749C
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668618; cv=none; b=d/MVmfKJfRnhL9MWdEe6d3Yr2grT4XsvH1AyuelVK98n2O8kif8Wt2TyLDiYSqHrQf17UPQBxKqwx7Xvo5f1FNp/TcO1b3qyxXCPYarU8V1JyzZFV79one2DWJKJGeDl5csfd3dS3K500bDrNy20lsUI/vCv0AAMasBlgQlAoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668618; c=relaxed/simple;
	bh=ihCAmJlHRzt/RNuI4rJ9SYWWxNMuRQ48jG3Ofq5bb20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U0sf9FWUqC82HJ5n3uF5VUWf7sIu8wzYee1rNeFe4w4pQJ4DkSB72761nepTuGti36wAwABp7xhGe34h/vQtUm7KZAXOyKu7Zr1EzX53MbaW1CHb3JnCoxcLKkLznZSQ2IWS+jjji/zMmAUkRkkmZ1lGTQ01Vs+7QGu2teeNtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vh1qiGO9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLTvn020341
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 02:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t+rnK2SBkgejW+h2uc2RN8
	cqumDO4qAqva6fj75dOAw=; b=Vh1qiGO9qQmAs7zxKWcIOb0d7MB5McPiaQY90h
	lEb/Wv35exkI4OiLH0c+NANKGBGWOfP1SGCBgS9ett4uVd5qF4SEHvdLJUZyajFA
	CJqPSlchRx1mwgj6HMuD15YEnXY4V3isE2OpcTItb7UPMqnh/udNFepNQtFHdjxf
	JPPTmbbLxga9n67QrvBKPgUgkX3327Dj0oJsTqlNx1Odc7ng8eNP3k2gevTI8jYG
	9SsVyWfY7DtW6XKyfkmILVwXxDeo9GIjWEXX4mr9sDhl4t3UvaOFHSY9VApmfHi7
	5SPRy0a8ITzDwplsGOLzfP//Mnf/6h+/OlLtsPdAIL07zFqQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8s8x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 02:36:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2909e6471a9so11465785ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 19:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760668614; x=1761273414;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+rnK2SBkgejW+h2uc2RN8cqumDO4qAqva6fj75dOAw=;
        b=DcWm4h5ux93nKeZ8Ds/H+FUe5+/tj8C4aPdAlW+oQTSpZ9q2SyvMCrMCMC7spdLBqs
         VX1xrrkJJBdf+RU+Dji5MdzsQdb0KhwUZU1CBCi30msRSR7B/Q9717LBNQXeZ/XE7ufB
         LHkrnOfZzMi9lnm0kCd3R0111ZVbCNm0aDE8nuU9J6gFw9k3FB36H/q692iX2KyLVQy6
         EpP6Xq2T6qAQ4fv+C8Q+i4epPZy8iJsMOLL8XzGblYk4qtSaLiefJUXUjwZhnyo4hO4+
         4sChoPUMCCd597+xtByouJKL8j0xPpa8AZFJsox6eD5KMoJHgA9IoTp93zZTzqwXW0cU
         Ehpg==
X-Gm-Message-State: AOJu0YzQjC6sytQqsTB+Ek1G0lXzxcZgUY0+k985piMp4/WF2RxlVrYB
	FoBoKyOiQ0dViLEDLReFBcMbeN+tTq3jZMo6fK+5CDaAVIG3hmi/z3wLBY/fI+2WyPW6B9JBIJY
	+HO1DwNA6jdmZRIRcCnohgMGKefju43dJ8+vw0PAFiLwaFdy0DSeaVOIlRAcSxUkWveX/Cw==
X-Gm-Gg: ASbGncuOU2WX7TQfVpdrbRaHaS6IMubtrUuuvRIkFgB7YV32aRvqLVYzcPYReScY8mq
	K7DI+PUmJn+GX1gAIGTjSupTU9Pvju4kL8zm49/P5/1g3Mg8OeGjtvToVitqqlENNWhsn1tM5hA
	Z0sEpJbSuLv86GabFqss75wX2cDIL+bcp/fqWRwh0wZiGi6Nh9Rb0uD/gseZXfzPVxb59ipJ6U3
	MA5H+R4NESh0yBoO6n83hpbzMvfyOSkt4kuasDEyGrT3SvTNeg61+L2mSjd2W8TcY+WEhMiqjAu
	QYnd8bziOt2bxTESXqrESrBsbqi5DQQ4/hMuGSi955HFTRmDoWWGiQWiVzCX7wi22bMtgjv1F0F
	quMdi3suMbWSfd6oNowq8rRyrGej1QY7N0osv4GTOZstYek0YtY2b
X-Received: by 2002:a17:903:3c24:b0:269:8f2d:5221 with SMTP id d9443c01a7336-290c9c89cd4mr27124255ad.9.1760668613951;
        Thu, 16 Oct 2025 19:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELcgfI37vYNA6c0ZgvfiHA4l6S2SN/1iT0YUV3kI/I7bcIFYFC9cdrph4t3DVpoN4KCVVzLg==
X-Received: by 2002:a17:903:3c24:b0:269:8f2d:5221 with SMTP id d9443c01a7336-290c9c89cd4mr27124015ad.9.1760668613476;
        Thu, 16 Oct 2025 19:36:53 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afd74esm45706065ad.113.2025.10.16.19.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:36:53 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:36:36 +0800
Subject: [PATCH ath-next] wifi: ath12k: restore register window after
 global reset
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-ath12k-reset-window-cache-v1-1-29e0e751deed@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALOr8WgC/32NQQ6CMBREr0L+2k/aBhBdeQ/DorS/tlGothUwh
 LvbENduJplM3psVIgVHEc7FCoEmF50fc+GHApSV443Q6dxBMFGzo6hQJsvFHQNFSji7UfsZlVS
 WsD/1FZlGsLoVkPlnIOOW3X2FjOFIS4IuL9bF5MNnP534vv/87R//xJGjZIZq0roxil18jOXrL
 R/KD0OZA7pt277u0Be00wAAAA==
X-Change-ID: 20250724-ath12k-reset-window-cache-b9b4ef620582
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: aQUyDOuJ64vcGtdxw-1z3_PTrC709kPc
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f1abc7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=qHv5NdDvAEshpcKH2xcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX5jzFTwUNjt7a
 ju3IN9S50MQ8jTy2/1egxG7hfzoh37ZpdZQjCjYeDKRB/fk1TSif6nBsyKw/cMZEe2HEZ6RwkiX
 RRB1Jirp+I083b9/6FWQ15qvOxZn7IFa+jCN6/LwjCCWhxhUCWAEt3cF5QxuLFjk956Un9qdOdi
 3Fw8iCfFhUsYEuQPiIa7ZhusGyxQXc8gs6zfnTojTJOccx/aQweh1U5s/FebJL9d5vza9zgOWoo
 y4qcfm0/ZJyaP60tkA9aYgvxdtkFm+T1Hl6AQjrDFXUUNyU2Bqlf++Wrg2kQHw63bNdgll78yml
 yBT5obV3QIUUjvUNfqrgCz79NVK/FSZ/1Dg0AE07PA7x3tNHwY4uMB7LE1HoRYg+aKP6uMyEAHT
 kpaxDcI50c5EezEaXM07BDprDBwLuQ==
X-Proofpoint-ORIG-GUID: aQUyDOuJ64vcGtdxw-1z3_PTrC709kPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

Hardware target implements an address space larger than that PCI BAR can
map. In order to be able to access the whole target address space, the
BAR space is split into 4 segments, of which the last 3, called windows,
can be dynamically mapped to the desired area. This is achieved by
updating WINDOW_REG_ADDRESS register with appropriate window value.
Currently each time when accessing a register that beyond WINDOW_START,
host calculates the window value and caches it after window update,
this way next time when accessing a register falling in the same window,
host knows that the window is already good hence no additional update
needed.

However this mechanism breaks after global reset is triggered in
ath12k_pci_soc_global_reset(), because with global reset hardware resets
WINDOW_REG_ADDRESS register hence the window is not properly mapped any
more. Current host does nothing about this, as a result a subsequent
register access may not work as expected if it falls in a window same as
before.

Although there is no obvious issue seen now, better to fix it to avoid
future problem. The fix is done by restoring the window register after
global reset.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index c729d5526c753d2b7b7542b6f2a145e71b335a43..60b8f7361b7f63704cee79e0013804e71ac42d7b 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
@@ -218,6 +218,19 @@ static inline bool ath12k_pci_is_offset_within_mhi_region(u32 offset)
 	return (offset >= PCI_MHIREGLEN_REG && offset <= PCI_MHI_REGION_END);
 }
 
+static void ath12k_pci_restore_window(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+
+	spin_lock_bh(&ab_pci->window_lock);
+
+	iowrite32(WINDOW_ENABLE_BIT | ab_pci->register_window,
+		  ab->mem + WINDOW_REG_ADDRESS);
+	ioread32(ab->mem + WINDOW_REG_ADDRESS);
+
+	spin_unlock_bh(&ab_pci->window_lock);
+}
+
 static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 {
 	u32 val, delay;
@@ -242,6 +255,11 @@ static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 	val = ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
 	if (val == 0xffffffff)
 		ath12k_warn(ab, "link down error during global reset\n");
+
+	/* Restore window register as its content is cleared during
+	 * hardware global reset, such that it aligns with host cache.
+	 */
+	ath12k_pci_restore_window(ab);
 }
 
 static void ath12k_pci_clear_dbg_registers(struct ath12k_base *ab)

---
base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3
change-id: 20250724-ath12k-reset-window-cache-b9b4ef620582

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


