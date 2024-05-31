Return-Path: <linux-wireless+bounces-8365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E127C8D6AA4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 22:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7AA1C2204E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D8F7442D;
	Fri, 31 May 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NamcFr8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AF537E9
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187167; cv=none; b=gQiiSGH2KtLiQGECvxRmMB/d0ST/Oskk4HT6LzjkgBYD5iSx06PzCgBOMRsGdGA4kO3ZWusB3WzM1+eFx034BZDPYi4dPG5Zi69wvMuzx3d8bgitiqNlGbGux4NjnwE+yQDDsdOmyiVDd+ZAvzUSgZJAKxSZhJQFFhMLgbn63KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187167; c=relaxed/simple;
	bh=XQH6ngmjd26r047byxBTyRPQe3LULBNb5+YZV9bW02I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPrYRBqElBgCQ+HV41kcDNT2AlrcgE5pff0yCvqOt+6/9TTDij73iZJ5/TrOpq2TyA++HNd5Et7ciFhHvC0XIuDSi1IIHWeBk/hnzkodhPnku7Am6qcfYsWxNcn7secwoHUJTd0JPsbeE38dfMTiu84tuLY2JsRKUch3cR+NIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NamcFr8/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VJ2Kxl023295;
	Fri, 31 May 2024 20:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GZ0RZFs20OEEIJoeIXKXEB15DGrZXj4ZUdr
	DMX8OafE=; b=NamcFr8/RR2v1DTjTYWS76huo3tOPdf1ypf/2M9FvVS5zEEd1X/
	x+ePGnDPQnOJft6bi3jJCmXp1+E9O1XZMaKXCgtixdqUprRrt1TcboIai0D7zb7V
	UMdQiJPgrvAXRo/IwCOuHjXIU3uWH+U4ZPty3TIO7coImtEHclKRvjCgkPrLjD08
	4m8D4y/yw0r6av21kHuoeq92nbZ3tSr49NVcR5LLtPrGFU9vDPnqq/L1jFo/wjZ/
	vQDq6xKrM6jx6aj2zj/lCm2bLUzz2MBr01WUy/YgQtIX8XUhot5QqT3lhLpyRRyQ
	6uYB8X5Orzej0XqMxRDuiJeLn7cJ1H2q42w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qr79y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 20:25:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44VKPo5R023933;
	Fri, 31 May 2024 20:25:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3yf34np19d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 20:25:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44VKPoUK023927;
	Fri, 31 May 2024 20:25:50 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44VKPoh9023926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 20:25:50 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id C327241148; Sat,  1 Jun 2024 01:55:49 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v3 0/5] wifi: ath12k: Add support to enable debugfs_htt_stats
Date: Sat,  1 Jun 2024 01:55:40 +0530
Message-Id: <20240531202545.2021028-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: RYme7eswOSjIBaMbEgC2ex4XTMM8CI8R
X-Proofpoint-ORIG-GUID: RYme7eswOSjIBaMbEgC2ex4XTMM8CI8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310154

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

Dinesh Karthikeyan (3):
  wifi: ath12k: Add support to enable debugfs_htt_stats
  wifi: ath12k: Add htt_stats_dump file ops support
  wifi: ath12k: Add support to parse requested stats_type

Lingbo Kong (1):
  wifi: ath12k: Fix Pdev id in HTT stats request for WCN7850

Ramya Gnanasekar (1):
  wifi: ath12k: Dump additional Tx PDEV HTT stats

 drivers/net/wireless/ath/ath12k/Makefile      |   2 +-
 drivers/net/wireless/ath/ath12k/core.h        |  11 +
 drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 714 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 300 ++++++++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
 drivers/net/wireless/ath/ath12k/dp_tx.c       |   8 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  61 ++
 drivers/net/wireless/ath/ath12k/mac.h         |   3 +
 10 files changed, 1110 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h


base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130
-- 
2.34.1

---
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

