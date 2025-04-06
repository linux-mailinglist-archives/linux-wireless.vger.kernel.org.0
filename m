Return-Path: <linux-wireless+bounces-21167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FBEA7CD72
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 11:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6D216A608
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24619D88B;
	Sun,  6 Apr 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVvGt+B+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD80186E20
	for <linux-wireless@vger.kernel.org>; Sun,  6 Apr 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743931344; cv=none; b=SREKp68JmBEjclVjUSUcystgst3sVbMEusuIJdOeU9AWg0bMEQHYhuTf0TkSkgUwgCnXahaZ65P/0H0uEgSzeMKaFw50/QnNUuhVBqD8y2mMOrcILbQcYYJcv7GxcWaaUw3MJH/tDKRTnVsEO2RN3hKTzx0ghAyjVYT9NImgc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743931344; c=relaxed/simple;
	bh=+JtmvO9jBKsXsBZ69PM2rSKxaIseg/KxNEmjg/mkRuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GWBCRkIwe5/AuwCziRR8M11Cr39UqAejCY6TDdrcm8vNG+7pFAQdzHNc5Z4C+qSiJXJ7/8euvLT5Ipt9OsjDWrSBUjmULGarsWQ9BJ24JJQLzRsVSXXkg6jSvcQBFR5kUz4U7+/tJ1Ps3LpjXQ2Gtl2v9oniQqIoWNlckD7TQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVvGt+B+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53660xZF030027
	for <linux-wireless@vger.kernel.org>; Sun, 6 Apr 2025 09:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=D8NIhl8RiGPqvmTbq49KwxZpuxvM1Pwnqgq
	oar0qyI8=; b=YVvGt+B+IglXYZL8zCwvNDAL5M0ABPSRA2WULzlDiC3Ezh6t4s9
	KBQqol9Y7i60jadBO/+FJSAneuM3rcWVlaLhezRjgvrjC7W2tgHsCHlcYmu7v2kz
	tBLz6S+Ipdj/JSKHY7yL7XknICfjGTZAoML0nN07Pmogc08gVJKTGRlmwtWIFR10
	5XFsze0vKHSZyjay0FO9vhZBGFJtax9FL3xoIryjX6JR7N0Rb3iqVERsRydysEqF
	+AjydwbBiTNfwC0MnKQAn0C9JaQtHv9ctjIX/+LN6nriGW32re4IIUuq3D0TAZk+
	YUptZGDEWFi0fc1SsJFG/qG74jRstbKRGbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe1p5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 06 Apr 2025 09:22:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22651aca434so32750695ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 06 Apr 2025 02:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743931340; x=1744536140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8NIhl8RiGPqvmTbq49KwxZpuxvM1Pwnqgqoar0qyI8=;
        b=e8Vp9FygnriXGnj1CNMlqi8yeES5BaGHJd2eUXmHTBj9WAdPUXQa94yd0/Y57tOJHF
         VgzA07bNU9eb42g9ln/UqWqkf4PObFrV4BFpVIl2OOFfVhWCam3lz4RAy5whFrLqJrGC
         d4/pjX8haC3rBz1ETcY91s5QnyFOCqAFRkZ4s8EvTHRyhWh+rYIPhnoyShd/zG7qprCE
         sMgD7CvYoN2buvMunK52Asiif6U4QfylqfGZbEQly5dhSEmKGo+ricNKeD4EalCPR6+m
         lfGepFeXzS27BmmS7q6O8iZs4ajhBnvVKRS/gRxHbt9YxJQdeD+NzGXuYpAgOTvVBkbr
         zJ6A==
X-Gm-Message-State: AOJu0Yyl25x2okGzDEFUXvYZSRU1V+Bv00DaBq4j5PbN48rtbgDMYBbF
	efZ2BcuJljJUp/UdjmWpUu4UiOqDbydxjBtSROClBtcoWx3mGuCdG6+WN2XyliNMunPuybtQbdj
	BzPAsBdOw9AGByamMCeAgsE3t+gjAt2+A3MbyGXDo36xKFioW1boHe25XdnXcAO0ZAXFnYdtVcg
	==
X-Gm-Gg: ASbGncvTdINDldKKB2HYa/3I+8yVGhyFVE6aAnszjonoX3Bv+rxeXuv8RDrFuqbhl+w
	EZKU1bdZYUtlkwcAF4qHi1QH0p+OK8NpUq3C2h80ENDMXRAGGDQ5d55xC5XZmkLLct/swNAeIeh
	3f4uiJV6hwgwVeuVQ+ebA9XZrEu3Nrp5TGKPdDFe6z0kBH1A2NwL7ufEgkARjHDgpQydi0YVbkv
	Ze9CG48QkOJXs6cqHeAIjJjqwtgXaSVkR327eeEBKvzNMMqR1ynUcF6BEj7hQraDNmZaQfxKMGr
	2ZlLhGyoSxiReMKgIr475S9T/I8Gdt3rMOahr/yvbMpsvAgRFMtdD+CFgEy43TaNBHuVDuXAlYS
	6iOvkzdlcgZON1/FWPTsrlW0WD/tPu4M1hluzGLAALEml
X-Received: by 2002:a17:902:f541:b0:224:23ab:b88b with SMTP id d9443c01a7336-22a8a8594b1mr99055525ad.8.1743931340388;
        Sun, 06 Apr 2025 02:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENTWoJbSRuOi2E8nXYcMKsJqRxMRlY/R9s4FFf8M2I3af31vRVESQ8We6BaWaHFq2GjRwTZg==
X-Received: by 2002:a17:902:f541:b0:224:23ab:b88b with SMTP id d9443c01a7336-22a8a8594b1mr99055345ad.8.1743931339947;
        Sun, 06 Apr 2025 02:22:19 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb5e75asm6857311a91.37.2025.04.06.02.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 02:22:19 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: set proper key flags and MIC space for CCMP256 and GCMP ciphers
Date: Sun,  6 Apr 2025 14:52:12 +0530
Message-Id: <20250406092214.3602182-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sLBX_7wezM2AMDaSNbLXNtTkQqg5BvRe
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f247cd cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=Hc_DSzY3qiiTP8U-yMkA:9 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: sLBX_7wezM2AMDaSNbLXNtTkQqg5BvRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-06_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504060066

Currently for CCMP256, GCMP128 and GCMP256 ciphers, Management key flags
are not set properly and MIC space is not added based on the cipher used.

This results in unexpected drop of protected management frames in case
either of above 3 ciphers is used.
Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag for above
ciphers and by reserving proper MIC length for those ciphers.

Rameshkumar Sundaram (2):
  wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers
  wifi: ath12k: avoid multiple skb_cb fetch in ath12k_mac_mgmt_tx_wmi()

 drivers/net/wireless/ath/ath12k/dp_rx.c |  3 +--
 drivers/net/wireless/ath/ath12k/dp_rx.h |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c   | 22 +++++++++++++---------
 3 files changed, 16 insertions(+), 11 deletions(-)

base-commit: 12b93f7c6d101d22e0ea3bf4a240699746c79117
-- 
2.34.1


