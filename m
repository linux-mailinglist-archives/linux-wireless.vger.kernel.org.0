Return-Path: <linux-wireless+bounces-28205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5DC03F1F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 02:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42DC6351C45
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED2EEB3;
	Fri, 24 Oct 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfQ2IRvd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7304A32
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265178; cv=none; b=GKoH1sdw0He4CXAz4oZO4CueSLK7ToqHhMhjCYhKjskHATy7ESvPgZE2XdTWEbbWCxzXUOGpWBGMRPNtv0nMlv+iJ84BVNvfpAuMUHzmUbOrC2Lz16ShmxclIg3CRxdipYmmP/K6yG6ynb5INS/RpO/FlGlW7xYFyjKGzZ1lmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265178; c=relaxed/simple;
	bh=lZf+jV2TZVhjRQo8XGbWo1JiYPaihkXxgXlT/lC5MfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PntnzYM4S2Fq83430lsRT0p3X7ThMyHHXWpmC6k9MVqjTGfnB/bNMw5OwKos0D9whTBbn+KbcAWV2BKMg38rrD0+n3RsHUQ5RxzqikgUKltu2UVMoIJlgwnuIk9UZoB79N4B8EUIQDBoV1N3/2AW7+R4fJdk8Q75dNGkk4VR6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dfQ2IRvd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEXsBp007444
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ian0X17PCBEpR7XIWg1U5JGbosj94lRWoIU
	AocF34vk=; b=dfQ2IRvdZKyhgj0TTCQgntpzxC7LUTD0fexh1swXaI01+3wF7vB
	z8WTyA9zfvM6L0QcmyCTexMi0103JfKx6DLePtrbnt1tx2oVwJjrtVJXLjcfuiZW
	dCwl9FEkYNmyhuwrqvbH23Wp5PQQWPMUqddhu80m/Pfltwc7jPAdNLDyAsdqDDsR
	edg3t+onHFy6vUqxGJZejLCY2zL7ibiMccIKlt+CXfOQNm/0+6gwnIiN9uz6TVTr
	y2SD0BC0JzHXUCEivyUTyHxiawwC4xhLKpiPz3g1F7N5K9R2KTNZVxpg8bWYYxnH
	i3OfrhoEz453u0cVKYb/RYeEiNvRynVBF4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344ab1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so1426031a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761265175; x=1761869975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ian0X17PCBEpR7XIWg1U5JGbosj94lRWoIUAocF34vk=;
        b=sKKRpnKs+GwQ+YQeeTeWTt34DeRLvSVi11wsxGaCU6qd1qSIwm1vyyBSDeZnHfM9Id
         +s0GKV+feMyjdm5UXWJYqWdMY8P4D67Y5YNj782GG42Q9pGSpVP3Kezxi5wYeESND9Jb
         XW4qNNkuudVKgTCmDQ47sZ+VNt9DaxaOcNl0BD/LKX35zge1l1gJycXTVA1kXIfy3SZV
         KD+TDSvVXAmnv4f6xxn181Vr3bRg7OipJnYCJ0RR22DzxSFS39+RQenPpKfWi+r8PEjW
         +k4fHKkJtWUuaPiE6ECHA5Ebnj51w0TTZfAsZTrflRawys9ku7yQKbBvl5tjsEyUnShx
         zoXw==
X-Gm-Message-State: AOJu0YyBl7iXpY1Fj6lbYBniE4/0Y4Je2u79i2w4zTrDMkgaACPNcWfz
	iSsmemVoyB2IMrdKUyXK93rPS5kViQJsZWMbVkVuK9vTwz19FFkUXUhjDBo4YnaACa0scOsXPon
	52WswwnAy5dOUQyreV7WS/Rm6rzU0JJ/DE1Ww5xzV47oupd4Du3B9XQJsuFgeKTckVssPKYwYMK
	VmSA==
X-Gm-Gg: ASbGncvhMFcPOzkFYQKpQgXHTk5UNRbqUM9erPk66y+A8y0/UVE0JyM7JQnElEtzMup
	FZTrjNnrZ2g2SYajFWT6ML+iiNfpdBOyl1i7LGa+hBnmdY4OZN38Ixavn1kMpOKoeZ4ypMhd33W
	eblFFpszUt9y2g2U1q7pRuMyzvgadoU3MzzwcJbC8BrUJ4ZtIRFByKuSNU/LvqOknSDm8tnhr1F
	+4zCyhfYyKamoJs8PMbDMCAnTcUE1l6fdySC0RRkBGvew3zBcud5dAFQPGZctXIBFHCU0VNToXf
	8YKNQaJk7T4qhwBmbwWqmph9U3LPerEEp8BQkKw6sbgE6sAlAzq6lTGQJQS1ydjFgZY/I8BDIGq
	6ODgne0uy1DfQtOe+u/wYxCVB4azP5FWzHACBbOrQLbc+Femxx7ay8WM=
X-Received: by 2002:a17:90b:3803:b0:332:250e:eec8 with SMTP id 98e67ed59e1d1-33fd65fe245mr375930a91.15.1761265174622;
        Thu, 23 Oct 2025 17:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGP6BDRLhTXu8nx6xxdniJdhKWROM+z5+g49pAorS7OxXt+mV4BYjS316O8lwYeaCAB8jR5g==
X-Received: by 2002:a17:90b:3803:b0:332:250e:eec8 with SMTP id 98e67ed59e1d1-33fd65fe245mr375901a91.15.1761265174138;
        Thu, 23 Oct 2025 17:19:34 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb65b3sm3296264a12.8.2025.10.23.17.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:19:33 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next 0/6] wifi: ath12k: Add support for EHT fixed rate
Date: Thu, 23 Oct 2025 17:19:22 -0700
Message-Id: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X7_CYLiMaXYrv1z9uulXg0slsnKb-Wdd
X-Proofpoint-ORIG-GUID: X7_CYLiMaXYrv1z9uulXg0slsnKb-Wdd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXylms8atzJVsf
 3hBlPSwOTbFU6F2akk6B6e5LqTPkmAGpOHm+UjyGwtTjARCOzRgsOCdms28EoGd0OmZxgVgQWg4
 CQAhqMeCqYFqNkoywvqcq55lIHeppygZjXm8g9nXHuyLaWaiNySqmtfxa94dNxA2hA12fhtAeNT
 wm0IRUuqJi8y3wHK1IroVYII2VP4j0wqXg1POSff6V0gpY+WZ5URMCMDxDM1Bb7vSZz3+NTtgxU
 ucRxRR8dgYPXUG2ioDuo0/mpae3C5kMgHFWf0/CdLMRc4DSpilcvy7dgp6suJZm8WYLXWSwGnAr
 XN9fI1EPgKC7TLPZtQ7O5A3zq6p6RArNWPhktdNCYrFR5b8/p9zxWmZAhVFTozC/5oSkoGHBeEJ
 TS7Rv+Oiu5pPddiGf+JzNxPdfprrPw==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fac617 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8Ar4_4e5b34ZrmqIgSoA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

Add support for setting EHT fixed rate for mcs, nss, GI and LTF.

Before adding EHT fixed rate support, generalize GI and LTF setting
functions to allow additional modes besides HE to utilize the
functions.

---
Muna Sinada (6):
  wifi: ath12k: generalize GI and LTF fixed rate functions
  wifi: ath12k: add EHT rate handling to existing set rate functions
  wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc
  wifi: ath12k: Add EHT fixed GI/LTF
  wifi: ath12k: add EHT rates to ath12k_mac_op_set_bitrate_mask()
  wifi: ath12k: Set EHT fixed rates for associated STAs

 drivers/net/wireless/ath/ath12k/mac.c | 579 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h |  14 +-
 drivers/net/wireless/ath/ath12k/wmi.h |  13 +-
 3 files changed, 504 insertions(+), 102 deletions(-)


base-commit: 50cb7ccab8176cbce4e32420f9fc2d6d80e69a09
-- 
2.34.1


