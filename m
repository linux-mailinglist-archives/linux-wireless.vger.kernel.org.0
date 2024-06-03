Return-Path: <linux-wireless+bounces-8392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A18D7ADB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 06:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DEFB218C1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 04:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8310962;
	Mon,  3 Jun 2024 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cpVnII8d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F722EF3
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 04:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389752; cv=none; b=NDN3tn+xZVDHLNT11R+GgjxLtrvnM5ASfK00+ooS92CeXKAf2DhQMOOW9aqJZCvD7/0inWZcIZKc05BjgwGtnH/TVAqxHcJWH3dQOt8BspGq0zoDoRYVDYPnJWipkD38+n979MErNsx/0CEUGThDn08cYOmLEoqDOtp94LTP1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389752; c=relaxed/simple;
	bh=RD1YRB3hKGnZlIVkGQgPcjPJPBMgFK08Pc5CO+ldZ5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSiVlutTDXoCqK/fu9o6XcrWqXKh7tyIZqkA/a8zg9QtyKll4RDkt/ztzqwiGCnp7SHhR0k1LAZheqIR5Za+XQNPbrWrTJeyY2mLSEpwlqploQtexBSNvlVfdgmEI63Pp8uoaACVDHu536PL3oalv46oMrj9v6Q/Fnm15M5L07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cpVnII8d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452Nv5TX028674;
	Mon, 3 Jun 2024 04:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4hu2yX+gUpziPZIuH0Rv8WbWNriUKM+zed6
	63NonFpA=; b=cpVnII8doJT6ugbyRGGgBuIh/kdoEO698JPAI/1aFVfBSRLMXg8
	cg8c6rdzhNVwPyAlnAsg16kUhFCW+s4z7Gv/j6PgD2ndAaY+xEM3m95n6g87y5d4
	1xbGENYyJDJMx/87sSSNPHagsau9bDqf2RJb7yZ99SEwwrgOBzD/YsisGFoDs/4H
	Cvlk6m9Px8Eqy/31YzIFs2cTnfScUMVyxTIhb6Bop3M+IVZbPaGnUWSESingLkuM
	bxdFqFIorEU+1wLn9cxumRmJf/bTGQn2HiIfqEafV09zbqJnV0HFvdUJVzUG1Z8l
	3PdECKPxp8/j05IPYIs6VBfopt2HEpEuyQA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5t2tj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 04:42:26 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4534gM9f020254;
	Mon, 3 Jun 2024 04:42:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yfvqkfu1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 04:42:22 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4534gMsT020248;
	Mon, 3 Jun 2024 04:42:22 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4534gMDT020247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 04:42:22 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 210A14116F; Mon,  3 Jun 2024 10:12:21 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v4 0/5] wifi: ath12k: Add support to enable debugfs_htt_stats
Date: Mon,  3 Jun 2024 10:12:09 +0530
Message-Id: <20240603044214.960261-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-ORIG-GUID: I0nqqU6FltJzNobRzarCyt_6dhxde5-Q
X-Proofpoint-GUID: I0nqqU6FltJzNobRzarCyt_6dhxde5-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030037

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

