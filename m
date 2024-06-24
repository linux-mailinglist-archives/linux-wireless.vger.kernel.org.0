Return-Path: <linux-wireless+bounces-9475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60EC91412B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 06:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9089FB2260F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 04:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F97D502;
	Mon, 24 Jun 2024 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DGGmlM3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B7CA64
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203938; cv=none; b=FWwiwFo0vnPtOa9uRPjXmX3Z/dEMcjjzUr7JFuuMSmZedU4Z3P/bV5Xyh55Flc/AGHJmE0WqPAJTOzHkwrYzVcH2a98/KRSagO8gavwr0PkXYmNoy2SWO77ArOzsNl/84FAJ+tlzRRyUmh6UyoY6zgN/8Ps2xqkin5iY+RQaP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203938; c=relaxed/simple;
	bh=brKt2Ns1ILr4/K66H7bTDjttcWgkz29/jsOjKloyA60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnP8YN6qZjugh5UqRHkQS4RIUlkung4C5Q2Hs0GJPWhNZI03huNZEM1tk9nPHoZqy6pfIL7yjSVPeD52HR68ZLNVrHsc5v567vwQLN6LTSnRIPLFSj1kUsXpk3lPlt9uTolFo47gu+dP0we3ZqeznE67NS0kChnz75xRSY07QEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DGGmlM3m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NNDDip008065;
	Mon, 24 Jun 2024 04:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7/1gp5A9ZTqxnEr/Mc8oSl4ymogVpMZl/Va
	/RyOLKxI=; b=DGGmlM3mjvt58QJj8FSBAfQCj5fFSakzw1j2TGDlNw+nuju0yna
	PZAPzFnTw+aTE9RGvhT5B22yeSqx4UUAT17MRUs0rwNfxYRdn/CJQZxe+mb/gFbg
	8Pq/t4Eoj4P2oC0T4s6JlU9oTp4ZATOc234ec9fa+vN5f3vuegp3gIHDypnlkbev
	8JpyQBsfiRYqPpj8fQGTBFM3QtUz+WqmgCZ90tiTaectm5Cdr3phzNIdzrGDjy4L
	990SvNpfjNkhhT3O/56ypXbzNIj7t3ylCiu69KDmBEBQlbVUhqT/3PdtVwLnJcHx
	coEiwAXm4QTPQL7Ov37RVAoNelMYBHP60ww==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnjrts77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 04:38:52 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45O4cnVw000400;
	Mon, 24 Jun 2024 04:38:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ywqpkq171-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 04:38:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45O4cn82000345;
	Mon, 24 Jun 2024 04:38:49 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45O4cmNB000344
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 04:38:49 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 2DD8241112; Mon, 24 Jun 2024 10:08:48 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v6 0/4] wifi: ath12k: Add support to enable debugfs_htt_stats
Date: Mon, 24 Jun 2024 10:08:41 +0530
Message-Id: <20240624043845.3502520-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: Pl_rs6_ytSOaNwdsm1rCJTvrfdJ2wvOc
X-Proofpoint-ORIG-GUID: Pl_rs6_ytSOaNwdsm1rCJTvrfdJ2wvOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240035

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
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 752 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 300 +++++++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
 drivers/net/wireless/ath/ath12k/dp_tx.c       |   4 +-
 8 files changed, 1078 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h


base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
prerequisite-patch-id: b3fff34c0192e5d1f5b242eca8aa10fd0d715b50
-- 
2.34.1


