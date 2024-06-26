Return-Path: <linux-wireless+bounces-9591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8F917B8E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 10:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDA61F269D4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 08:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BE16A94A;
	Wed, 26 Jun 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lsvtywjN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314F1684A4
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392360; cv=none; b=YZzvvXwQUm9cHjOCCw7vX9oNjQXI/jPdlZ56Zn0y3IaXi8o4XrYzPSLCKKCdLAvcNnW/69I6FfGimrLkmwzAwcQSk75/aTIAHC4pkkGBMRPn5ooJ2lvrSXs7LaqslnlSviVfKZm8t0nNCP9DyoBw+Ad3S4pz/gY8NqWj6WbsY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392360; c=relaxed/simple;
	bh=vBO4Hmw8zAvhBSPqqkywAcsa4oXewonFQR/wnw/Gv4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0RyLzXX/dUjfaMG93DqVRtpK+uE1m6zywofjXfissjXnJljrT+pM0IYQGIBp9V3UNouehH2CDzfbKxi9T/nqaliNKVITFcdT4xeG8aRKDYFUQ9P/lRsRgBV+99Gg+KdFabTySfpXn65dFIB3xyUcolkKRP782kohkHFsSaXPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lsvtywjN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q7fmrd018108;
	Wed, 26 Jun 2024 08:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NKqlMR0DyeY9kxTXRdc4fU1XGRuZ9marili
	jyXMo7Z8=; b=lsvtywjN40HClFJ1KoDd7wVJF8SbL1mcpq16lATmxpCVOCpzNKe
	bl2kp9mwmI15oLCTJdh67qmUYQtQRTRHp0N470apFO1sdgTnUQQagDFSal3BYuLK
	T+1Qi9C/ngH95x8IVy3bYVrbtEkzfen3YYoKQmbc/Fc6+zcTO6eqoEaEBFHILOXP
	OSF1ekejKPW2iFYoeMBGR9n3LGxBLNpvkC/y2vA8prgoVV/aUUZGgvjMvHRFKrmc
	4171uvHU15VGK0x93cAtGaT/FQD8Pw2uA2phbGYyChtr6QYIPPyt+89oW2W1QW6u
	4cx5sRNyXyogb95XMTGJQikjvkhRWkdz/zg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6rqxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 08:59:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q8x6aj004728;
	Wed, 26 Jun 2024 08:59:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ywqpktwcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 08:59:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45Q8uDRo002182;
	Wed, 26 Jun 2024 08:59:06 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 45Q8x6OA004721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 08:59:06 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 3321B41136; Wed, 26 Jun 2024 14:29:05 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v7 0/4]  wifi: ath12k: Add support to enable debugfs_htt_stats
Date: Wed, 26 Jun 2024 14:28:50 +0530
Message-Id: <20240626085854.2500681-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ukqiX1ph6NXDVlqXa62ICxaY9k9_KNZv
X-Proofpoint-ORIG-GUID: ukqiX1ph6NXDVlqXa62ICxaY9k9_KNZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260067

Bring in the basic infrastructure necessary for enabling htt_stats via debugfs.
Patch series bring support to request stats type to firmware, dump the stats
and request to reset the stats from firmware.

Schema with one ath12k device:

ath12k
`-- pci-0000:06:00.0
    |-- mac0
        `-- htt_stats
        |-- htt_stats_type
        |-- htt_stats_reset

---
Depends-On: [PATCH v2] wifi: ath12k: Fix pdev id sent to firmware for single phy devices
Link: https://lore.kernel.org/linux-wireless/20240621102809.3984004-1-quic_rgnanase@quicinc.com/T

v7:
 - Addressed Jeff's comments on print_array_to_buf()

v6:
 - Error code changes while writing type to htt_stats_type debugfs
 - Added new line as an argument to print_array_to_buf()
 - Rebased on ToT

v5:
 - Addressed Jeff comments
   - Changed sizeof type with data structure pointer.
 - Pulled out patch #3 from series.
 - Rebased on ToT

v4:
 - No changes. Re-sending due to mail issue.

v3:
 - Addressed Kalle's comments
   - Locking is taken care. ar::data_lock is used to protect stats
     request completion and other HTT debug entities protected using
     ar::conf_mutex.
   - Fixed KASAN warning from WCN7580 during stats type write.
   - Changed header style for MU PPDU stats printing routine
   - Renamed function ath12k_debugfs_htt_stats_init() to
     ath12k_debugfs_htt_stats_register()

 - Added expected length check while parsing each tag to prevent
   buffer overread.

v2:
 - Handled pdev id sent in HTT stats request command for WCN7850
   Added changes as a separate patch #3
 - Tested in WCN7850 and added Tested-on tag
 - Rebased on ToT
---

Dinesh Karthikeyan (3):
  wifi: ath12k: Add support to enable debugfs_htt_stats
  wifi: ath12k: Add htt_stats_dump file ops support
  wifi: ath12k: Add support to parse requested stats_type

Ramya Gnanasekar (1):
  wifi: ath12k: Dump additional Tx PDEV HTT stats

 drivers/net/wireless/ath/ath12k/Makefile      |   2 +-
 drivers/net/wireless/ath/ath12k/core.h        |   9 +
 drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 756 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 300 +++++++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
 drivers/net/wireless/ath/ath12k/dp_tx.c       |   4 +-
 8 files changed, 1082 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h


base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
prerequisite-patch-id: b3fff34c0192e5d1f5b242eca8aa10fd0d715b50
-- 
2.34.1


