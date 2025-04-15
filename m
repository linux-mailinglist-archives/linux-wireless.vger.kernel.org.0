Return-Path: <linux-wireless+bounces-21567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4EA8A8AB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C7179A03
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36D121B9D8;
	Tue, 15 Apr 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6v1sZAH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D02356A6
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747135; cv=none; b=e/cKOdR3j6M6qM59Dpwv0Vdc9vgfbLjtTbGDh8PKtkoN5Ru8qFMOTQwVeAKbm4tbgrTb2OdTdfc5gADbFSxAOMCgJi+s3j4aq8jq3PVbjfHku25JmUU7R6mpXXIhoW/MZbyrr1iVSXcQBFmSmP7cNWT4tjzJ57BLqGb/L9JXbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747135; c=relaxed/simple;
	bh=oBy8t2dIfT+DAq0icBkeRZrZ6uw/77wyVhIC7KaBfXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KTCDg2KVDmNutS273ayWvUbLW+xq9uKq90BGkLxrsfzssFGZOq63U/a8ZATIhFKWeLIv5vTtoY9CBPPFo8iZVwlsqY3xu8nsDwKVtOWpT3YKT6/hScBlOAx2qJm0p41p9ujY9IvKOG5ncl3vwp6Foji9cjnsRwmkETnW/oNsdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b6v1sZAH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FI8IAk023344
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mwVlsTSvEzFjs5QjXxa/ElYdsw1CyTATtQL
	r5FKwOjg=; b=b6v1sZAHhT1qe9dJ/WhCYFjzNg9ofQJ+EThSqcpepnTmALwPI2+
	rCk8wjOEGxg3a8Ak8oNDJ+GWkDMqlHqE+7fcXLvpp5tUyDCLqUgzFiH9F1srMFBE
	YLUgqSJRlBOXaoDL2aOzMw3tDLo8TLwTtmHRrNIZqDPcFueTfH6o3QPOc9W9G7YC
	bBmiOCSahlG3ld0+uT27bFJ10dzJ3Uq1AAsfMpvCWQVMfTLEsBINIK6/0I5C05rx
	NPoQD4tYwA4Umv3i4NQzYb8qiMpVlmI1e7ez2KcxHPkjg29HJBJP76Z+nYL1K5XW
	5vp4Z15dadwMTlsgqd1LmbsPj7fIP4bXx6Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj99872-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22410053005so95582435ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 12:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744747125; x=1745351925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwVlsTSvEzFjs5QjXxa/ElYdsw1CyTATtQLr5FKwOjg=;
        b=oyWjmZrj08YSYGbSCfw6099wjjf2cWUFarZwaDTKGeDHBaFfdNZZcLVvVbO1mol/y9
         Sy/yAi1tfkYzKXdTYCrt6k0qo/PJGUpiTeR/ViizGFpLqMHM/O+Ve/GVsRMcn2X5kz3e
         48JnXU7J79qob/3NI9wyON0xbHmwxg0DR0cjUtAqbXk8+R4+qzDtYHwhUX4KPShY+1ig
         kdcvLyLoq2YMWMy321/BRukpf2ljPilU725GeGHLB2XYWwrvqrrpXnyugfu72VLqB3B0
         Y6OspKH8jMdYUkbPW+3IkjRvBjI1Stl57+S8Z+TC4MhsYDd+BMugMU9tMRBzQYyqvY55
         mB9g==
X-Gm-Message-State: AOJu0YxElLfg1kkdj16KO5AFtf3ylfpzyoRmaO66wnBd3KkZrB6/kIV0
	Q9UWSJqtDMEtPNViy0FpQhLrvADgnohQ82h2LIS/ofRlmiE1c1M4VTVnnhqw2csS+2paWGOGwzp
	R2pdOmpKpvFclq0pa3kFxlJAiMewfW7pnpaMysXe2iOw7345Wghnpsuteokcgag6BTA==
X-Gm-Gg: ASbGncs2t4E5nKdmgL+dZ9FlPSsdWAQMCl7HC5Py9OERxUrlmUc+Iq5H2RYGcRmZ1HW
	vKthrnPt1mkD8x89EDBURXDuJUFHVNKF6x7CvsoLixlz3XbeNgt7ftFYVbkoAjaQB3DDtLB9OF+
	xxPyPaHMlg8A69Awsfd4VG+TCtegUJrplNP4DaK61fsIgGYCXOX7q48KI1gQ+pcKcboCKjaJcW0
	QxgTH2jaM2j8xmbSsZSpAV3Kiaq3GeNP/YsuBkvlQJNDbIp89X7ohMu9Jp2lFzH4zTruewo0HfN
	FeCzYA4Ead/4NfllX6AziBRiKMw+NY2WfsXRgIAT/LsN0uS8cnEj97RREkiXsDELhlpb3pSpHhd
	fuUY4lo+lTrM9PZHOGV/d+m6EUL8KFcnPGSy1NMLj
X-Received: by 2002:a17:903:2a8f:b0:21d:dfae:300c with SMTP id d9443c01a7336-22c318a9320mr6713245ad.3.1744747124775;
        Tue, 15 Apr 2025 12:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGVwNmLKffAoWRaj/s7d9ar5DCXyaNmUkGN8fD4QrSVC/+5n2gqUOTY2ZCcy6Q8KayUHYUUw==
X-Received: by 2002:a17:903:2a8f:b0:21d:dfae:300c with SMTP id d9443c01a7336-22c318a9320mr6713035ad.3.1744747124418;
        Tue, 15 Apr 2025 12:58:44 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8ea61sm121626265ad.103.2025.04.15.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:58:44 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/2] wifi: ath12k: set proper key flags and MIC space for CCMP256 and GCMP ciphers 
Date: Wed, 16 Apr 2025 01:28:10 +0530
Message-Id: <20250415195812.2633923-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7oJQ4rSUdBAHM0xQZozHEUCbMTtxdu8N
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67feba76 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=Hc_DSzY3qiiTP8U-yMkA:9 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 7oJQ4rSUdBAHM0xQZozHEUCbMTtxdu8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150140

Currently for CCMP256, GCMP128 and GCMP256 ciphers, Management key flags
are not set properly and MIC space is not added based on the cipher used.

This results in unexpected drop of protected management frames in case
either of above 3 ciphers is used.
Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag for above
ciphers and by reserving proper MIC length for those ciphers.

*v2:
 - Rebased on ToT

Rameshkumar Sundaram (2):
  wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers
  wifi: ath12k: avoid multiple skb_cb fetch in ath12k_mac_mgmt_tx_wmi()

 drivers/net/wireless/ath/ath12k/dp_rx.c |  3 +--
 drivers/net/wireless/ath/ath12k/dp_rx.h |  3 +++
 drivers/net/wireless/ath/ath12k/mac.c   | 22 +++++++++++++---------
 3 files changed, 17 insertions(+), 11 deletions(-)


base-commit: d0bcc5eaaa611aacbffe6b2cc2fb64bfc3bdfcbc
-- 
2.34.1


