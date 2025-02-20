Return-Path: <linux-wireless+bounces-19187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3599DA3D50B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD1E17CE34
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3CE1B87EE;
	Thu, 20 Feb 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XKxfOPPk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD61F12E7
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044546; cv=none; b=UqmQqQGloj6oGZ73WZ6ycK+/ejZXlccGxCXw/jPdnT6lVTZqE73K/LG/r1QcwyjgidrS8CU0hcJ5pnLSegxycXaDt1yq0vL1TcgPMpnFtlB+8L2nfzZuGTzuv86GWv6PkutkZYgwRYZnWnmFFR2SOs4Vhk2DAMEb9wD0SeeRi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044546; c=relaxed/simple;
	bh=XHcDvB3Uc7CK2nES/8CU5k642FBnDGhY1lbECelYAWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uz4SkHAYfVnsAzacXsEYqMixwnJHAFxPTnib6tq5iD/th/9KlADKD2rOsDUHiJI5oe/67z9NQo2f+CBCWfzpCOWuKjw2YV6BAY/yctx8uuszcshfsZeL78baOKoC3vszdQnLk7CpmRBWg/GYK6g0vGNl90Cn8aBcayh4mx4/uoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XKxfOPPk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6VfJP009730
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LR2M3r4Qw3jzfTGn7g1ZdStQCqlIY9oK4gL
	MTdorMp8=; b=XKxfOPPktzeR2AAjkyOpbhKl+ii09V3//JRQvH2W2nLUl6BA2b8
	fIikqNiHGSmkRKaJV3JTZ3/nTi23zgEqXHwGBKCx5GjSDOR0t5u/7jR8lpaUADka
	FtfcBPiTviKa249eECoyWsgjV8Q8DDGgsAUU/AGKSdU5Nxv2NoVC3ILQxost5Ba1
	xvah5o0M91rxuEa/Ot2jALe4kTCN3jBxhPVgg2jCOYiSSAMIprhhPc9NX/wy5Fjx
	7A0pkqYmKXb/J8Uq65oYUXwhm8UDKcYMiBgqyvOb7UzQjHHIN1hLUR4cJli6wyv7
	ug7tkkaV3nlQCxj838P4Fd5oQlQVP0ztpug==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1wqhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:42:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220d6018858so16284715ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 01:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044542; x=1740649342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LR2M3r4Qw3jzfTGn7g1ZdStQCqlIY9oK4gLMTdorMp8=;
        b=FszZ3xItp5DlCRq2ueOjINCik3PYgfPhAcPPy/KS2iqqwqOj3yuqUf0S2sSwpu3aEj
         GAOfGb/B0lJPW3JrCx/3BJHYtKlHrYomRbAD8tYdbdRVCv6M0lKmosqFwGoByuTfum71
         iiS80apqkDScW7QtU7DKiNJp4hgCofaQPngqnGVyBRQkPHqqnPutmKq4ZqMDjXZVszTL
         J1Ep9VLxGVfQbcXvs4YvJY0YtFBRARZ/28kDoBi1R2U0hsJXGIpLyaruGJg5IHMnxXI8
         N2enkG6dDvyrPXxXZojG6y2WS/JlPUlVnwU6dNCnRkp8UJ/U218Z07vSv9mhQ1aVVUym
         Q+zA==
X-Gm-Message-State: AOJu0Yx/q4AlmOQu7ZbgexXsQlNkCmQzI3aUznanA7aTt6xlzxF5r1EC
	BctMrMgdR0eyvDrcy8DGOUlOY0lmniHc8Crhf54nCpUjx6HOSGqhq4OapJ+bHNgJr/c/eEHxsx9
	9AVNDu5V8+xMpEes09c5L22dZSjfuphrEiF7r9gIV8lSCpPhFjKzGnrJTHrXzt+rqLQ==
X-Gm-Gg: ASbGncsuh0YHFnzs0Zx/mB2aN4YNp/SVWnuexg3VzOYLBoODv6hgRPx7gM0/GqEwk2+
	Vu0ZsWyVHBTcT6kBs4qgo1vduWgstexY1R5AYxQNvAM28+gqom5zSFjshX2ZuJJToMMm3FQfdhR
	vWEhJD92dndBytgJa+SSv1awghiE19LEhZcD45QUBojd4GES9hamauf/dt5K6OfuFCq6itW9UMP
	hsISumdqp94ePztc1ipvoTLlyFKjFk031OYcqLCe0wTKqmwj8Gc6tJItr3kQTLwo3sQobJsQjft
	v/A/Bsu4K0c5SYac79udE1mwhw7GKJ5GuaCsMKqovU1Wv7jBPr2Q4Nar2464fVDdKSv9Y/7bLeS
	wYyI5rIfUcYFh1w+iwG7RQbY=
X-Received: by 2002:a17:903:22c7:b0:216:6901:d588 with SMTP id d9443c01a7336-22104034f22mr362288285ad.15.1740044542645;
        Thu, 20 Feb 2025 01:42:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHAFrsQCsrhnXkXShXrGtgzKREm8ND/PlDw2E4ELTjPoILnIMyAHV/W9gwhM2IKoy/z/ryxg==
X-Received: by 2002:a17:903:22c7:b0:216:6901:d588 with SMTP id d9443c01a7336-22104034f22mr362288025ad.15.1740044542231;
        Thu, 20 Feb 2025 01:42:22 -0800 (PST)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220dacfc769sm115526905ad.201.2025.02.20.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:42:21 -0800 (PST)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath12k: Fix double budget decrement while reaping monitor ring
Date: Thu, 20 Feb 2025 15:12:11 +0530
Message-Id: <20250220094211.2445395-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NmVuNLRqoe8SCMwF4wNwIiy4qxYjkjKA
X-Proofpoint-ORIG-GUID: NmVuNLRqoe8SCMwF4wNwIiy4qxYjkjKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200070

Currently, the budget for monitor ring is reduced during each ring entry
reaping and again when the end reason is HAL_MON_END_OF_PPDU, leading to
inefficient budget use. The below mentioned commit intended to decrement
the budget only for HAL_MON_END_OF_PPDU but did not remove the other
decrement. Fix this by eliminating the budget decrement for each ring entry
reaping, ensuring the driver always reaps one full PPDU worth of entries
from the monitor destination ring.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 394a3fa7c538 ("wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
v2:
	- Corrected version log.
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d22800e89485..6d1fa6a6c9bb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3259,7 +3259,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	ath12k_hal_srng_access_begin(ab, srng);
 
 	while (likely(*budget)) {
-		*budget -= 1;
 		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
 		if (unlikely(!mon_dst_desc))
 			break;

base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28
-- 
2.34.1


