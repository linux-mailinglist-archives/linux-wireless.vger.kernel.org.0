Return-Path: <linux-wireless+bounces-25424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFFBB04DAA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 04:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AD717E4FA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31C42512EE;
	Tue, 15 Jul 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3ukXhLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2E2BAF7
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545265; cv=none; b=A56wv0j3/Kwq2eTyVzYFSEoHm63IuC0DxyxV+4+q0WLLiivY8KYOQ/g2joPR9LojaZDRNkzArSkJeZHmTq9ZnA7W+W5XKK9F2GvB3m7tzLq8w6vSxmuXbWp5jjvCELqzZVMtsBUiZavhzF+NLaQJQ3/8NWdSfB09byycmTA2c8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545265; c=relaxed/simple;
	bh=HThEJMzKwJYDztky44ZA/c1WrXlLoJhAkNszWLwz0Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b0999M0RSw3QuQIkuj6ldrbHo0OSgZ3/ygRLqYczj8troSGvbqIWv/FaupvI9sHLNdBxeQsGpOb74o+kW2olTQ3t2uWxYCHaIsC94dqV2Dj4sC1Fd6yxb31ECafTNkw5iI28EiZHL9uPfIjp3isMszjJT0oKERAqOOCzDO8/CAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O3ukXhLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGbTbs006253
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PSVwncDU6Dys5JEA52xmdL
	uexYAaayc7t0DglVd9hSU=; b=O3ukXhLZxqN3YiATmr03C6jdAR5sbb8uS33RiV
	rCNRTDFsRf/Qkp6J1FTpCntkw6oKwRQR3SsOyBC++4eIqVAWPGYjjJd5iD39s4LX
	K6fzyNx9JbdpUsUpRFUNjzay2zjgex1g6ykqCz5sC7jn1FIWfhrQ14ANCiQ6+e+p
	eMsp6GpBqkhxY0QyyL/3aa0EDw7hr7Txb7VNuzOXu2y3rOkn2di8908qhvcdqC7h
	8Bsuqs18+0RAv49g4DasyP3TN9LsHct3mhbdcYcEcCa2z6s3Im03L93lAC9BHLBW
	UFk+HudJ01u2OrIP4BAZurSKcy7Qe13a3VsfrkPfKPYm+m/A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxaxhga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:07:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23536f7c2d7so79573295ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 19:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752545261; x=1753150061;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSVwncDU6Dys5JEA52xmdLuexYAaayc7t0DglVd9hSU=;
        b=jhOzkSvh9MGku+Aofzh1oLenqnhvCz9hYAsdkVZWxPN7cDQnD1EMp+YJKe+F6mweDz
         F6g99lKIIV8ydQAQJ88rM1h2gZdaR1ZJk3ourZHHsHJphxUCcmSvXZIgenMyKC5ZSSMP
         G0IrVfmA/YDaXgxJ/gkeo/g5/rIaMAXf+F2sDKu/DLHqxrOh3U7FdbAGIJDzXzWlIkft
         euioc2VNmz+SNBTRRDEWN+YIgya+GJ2Jo0l3DJrrGMAZSrSwiSEPgi8UKLTFdD18Sa7s
         K2bdKHYPeMCeURmq1PM7C5uzXQ5k+ttW9872996FBSiYAc8O1myQuX/284MUwK3Wv5RR
         ekdg==
X-Gm-Message-State: AOJu0YwucENg1E1WT9EFcO2YFcoxvaAQ18qGckVLu/ZR+WgYAMLkXEhF
	xGKSKlasOldppnxm3DYp3/q1E/vcz0myTxW/GP2h2L2Ug/ccToqWx25cFsRKmzz5t5k6q244owZ
	nO/ObEC+Zg5GQsLrLJZJCXLd+9TVqDRT85Y1lp3/6QzY48lMnKs3baHqyKgS3sle4ZSN7Ow==
X-Gm-Gg: ASbGncthPSYpkKt/Hs7zYwVJlZaA95r5IXgyNTbmRNea1UHVV3oECtNTRRYhijMEIbv
	+ZQ8UFGcrDa4ItO21/Jf1ZedkCHNeDrq19uxq9DbKm9p8KbdrJNfSx9MgWQ7KMJ51CJuquhGy0K
	6pQvwCht6jkFb8NQkKRpt6gDxrNhbcGNmz6hephpNaR7nCEtjuqVUt2N0u9PR9BYaKpWR7/kF8e
	qjSb95OYVIiIxfK1Npv0/lrDBcqPg7Ella7A4XWp9dTGhfyj91C3QgErbxq/7ONt0mKOn84Qq8S
	e4Emz7qioVkO5FJH9G2f+wSdyaSE89hWOEGKUf8jR1F63o7YMREtLVr25/EBboLbQmftEo+sHQr
	o8RQhWBRNI7xZmoR5FQ==
X-Received: by 2002:a17:903:1ac5:b0:234:db06:ac0 with SMTP id d9443c01a7336-23dee264f3emr234356475ad.45.1752545261205;
        Mon, 14 Jul 2025 19:07:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJcKH2/xSIW5sa5dra/KGf3NPul0JNAK8Fy/Ps1y4FVsqv9aC49irxSUQ7qZWB9zBprTyTsA==
X-Received: by 2002:a17:903:1ac5:b0:234:db06:ac0 with SMTP id d9443c01a7336-23dee264f3emr234356015ad.45.1752545260784;
        Mon, 14 Jul 2025 19:07:40 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42abd8esm99760635ad.54.2025.07.14.19.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 19:07:40 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 10:07:35 +0800
Subject: [PATCH ath-next] wifi: ath12k: remove unneeded semicolon in
 ath12k_mac_parse_tx_pwr_env()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-ath12k-unneed-semicolon-v1-1-9972fd4cef07@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOe3dWgC/43OwQ6CMAwG4FchOzvCJgh48j2MhzI6WYRNN1gwh
 He32dlEL03+NP/XbiygNxjYOduYx2iCcZaCOGRMDWDvyE1PmclCVkUtSg7zIOSDL9Yi9jzgZJQ
 bneVNe9JdV1agQTFqPz1qsyb5yqjELa4zu9FmMGF2/p1ORpH2P/UouOCNxg4lAHZFe3Eh5K8FR
 uWmKaeR6Cj/5CRxIPojPYtlDeoLt+/7B1EfIXIeAQAA
X-Change-ID: 20250714-ath12k-unneed-semicolon-896fbb45afac
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: zFfxlMWHBUlAoENA5_elWA1ToJUsMHxc
X-Proofpoint-ORIG-GUID: zFfxlMWHBUlAoENA5_elWA1ToJUsMHxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxOCBTYWx0ZWRfX4ZPi3awngkht
 3pR8OrqwDCqdTrKJ0k0JdE9ygBU2AnXMm7yiu4j+gL4MZF+aEZq+mJpdQTeHI5W5HBIXa02ung1
 H/bjVXRkGHEDg3LED75mhwif/mraII/pW8s3EuYT8dsJZEymToJMHh5DLGzFrEWmnLax24sBECf
 v48noKLeR2VXyTF1yP5nqSOwLMbpF4qktPoWs7bpKbiLyBtLR/mnZ7ifdxyxG1NJFDZQrqGj66x
 /P9pIdRJMNrJGCmSxlLVGwtvkgosfehioHAnG51z7imvPo6DmaTLPHi6zv6ggcSb3Gg4uItMAqF
 3pXUBE57T4o1pUrvPSQaDRLtEMaJFY7I0N0LHv89KPRKx/mW18sorVdyUW2gidQUxW7tEdptycM
 JIwnuX6vk8brze/r3R52F903oxhiWfLXwX6c009LQIVl4kfmYWZHUJZFTLwG190+5ntq/CX4
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6875b7ee cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kzacFtwYidqRY08iEG8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=844
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150018

Kernel bot warns about this unneeded semicolon:

	drivers/net/wireless/ath/ath12k/mac.c:9785:2-3: Unneeded semicolon

Remove it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507132355.ljWuxxjd-lkp@intel.com/
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5333da9cac1b2cae4a71c975bf927de8182c357b..a5fb917812c1ed2e60a3ceba32d092d7198e6054 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11424,7 +11424,7 @@ static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
 			    "no transmit power envelope match client power type %d\n",
 			    client_type);
 		return;
-	};
+	}
 
 	if (psd_valid) {
 		tpc_info->is_psd_power = true;

---
base-commit: 3a6df1678acc3687d49ce94e23df7b6a289f27f9
change-id: 20250714-ath12k-unneed-semicolon-896fbb45afac

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


