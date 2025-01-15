Return-Path: <linux-wireless+bounces-17523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B84A11876
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 05:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9F9164DAB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 04:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73058157485;
	Wed, 15 Jan 2025 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YzbrScIo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE48488
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915155; cv=none; b=RMfrr+JZWPVfnJo6bVuDG4B9j5EtE7UODVIr5UnSUrLqLLk/S2jotiw/PQefiHc00uwaBswDJSqsnf9/7Pqzcsul/w+RTxm78VjA7+6K6Qkkn6kWnkxLtDyQpy7CgjEeDjtCfMWsVJCc8j8TrDuP5TMeOm6vRyCbvgmINg861N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915155; c=relaxed/simple;
	bh=/3KXYebdXDKmMi5LLlDIwhuSMMcKHVaZcERR8tpxYic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tMyX4MN2RFqJedo9FuYKeAY8/aIOB7S0FDChYgl2ynI0HiSeAFkXc8c5+GQlbXLu2kKyvGq4BM8FTP14vONFIcO3nkovWmb67Hie/n+fYXs+eEFv5NW/vG7Xod6yggSSsOtHxMFIFAHfYY0tcHqqP+GpJ+xR8MChsRZEFf2nSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YzbrScIo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EGjocb024794;
	Wed, 15 Jan 2025 04:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WBUgZdkKaBMW2fpdvNTz8g
	g0qsYKDcgDY3nUbFDtC1A=; b=YzbrScIoSsdYHuqz+C3XjCbZ7FHLiy2ssCMZF6
	oqUljXiP9HS68vi4D5StI9k754AE1epeahZocax8ziSzJBdJY810Xg5Gqf7FGmHf
	r2NXnt23Gws+XWVPuCRg6lK0SsuKxzqTmyaJZkFPscbUR9KhW94z8ZL0efC78Wdp
	Y/uLcGCeBwHMZTXn0msPGkZZltfMug07rNPep2bDw0IGKbXYiJB36Ro+4VxTdwY7
	sIpFCYNeQFpz0K7SldtJuNEqBCihDrLK/pkR614br8vgRdYuXMj1Us3rfXBRoY91
	7gnboU+/biJ/xqme9BywLW/fnejjNb0Vn/ovC4zv9NGbhZEA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445uqs1cqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 04:25:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F4PnnN019993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 04:25:49 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 20:25:48 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v9 0/5] wifi: ath12k: Factory test mode support
Date: Wed, 15 Jan 2025 09:55:27 +0530
Message-ID: <20250115042532.1509956-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FFGhuPsY1Q-rcCgpZ9bX37-p6aVR01vq
X-Proofpoint-ORIG-GUID: FFGhuPsY1Q-rcCgpZ9bX37-p6aVR01vq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_01,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150028

Device is booted in factory test mode for calibration.
The commands are sent from userspace application, which
is sent to firmware using wmi commands. Firmware sends
the response to driver as wmi events and driver sends
these events to the application via netlink message.

Also added changes related to correct pdev id access for
fw test cmd.

Aaradhana Sahu (5):
  wifi: ath: create common testmode_i.h file for ath drivers
  wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
  wifi: ath12k: add factory test mode support
  wifi: ath12k: Fill pdev id for fw test cmd
  wifi: ath12k: Disable MLO in Factory Test Mode

---
v9:
  -Rebased on master-pending
v8:
  -Included change for assigning seg_hdr.pdev_id.
  -Moved if block to start of ath12k_core_hw_group_set_mlo_capable()
v7:
  -Updated copyright
  -Moved ath12k_ftm_check in ath12k_core_hw_group_set_mlo_capable()
v6:
  -Rebased on ToT
  -Updated copyright
  -Added patch[5/5]
v5:
  -Updated copyright
  -Fixed line length within 90 char
v4:
  -Rebased on latest ToT
v3:
  -Rebased on latest ToT
  -Updated Tested-on Tag
  -Removed second parameter of ath12k_core_start()
  -Updated copyright
v2:
  -Rebased on latest ath ToT
---

 drivers/net/wireless/ath/ath11k/testmode.c    |  80 ++--
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/core.c        |  28 +-
 drivers/net/wireless/ath/ath12k/core.h        |  11 +
 drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
 drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
 drivers/net/wireless/ath/ath12k/testmode.c    | 395 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
 drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
 drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
 .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
 14 files changed, 620 insertions(+), 82 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)


base-commit: 2d17dd7f1c17c36e0354a7e14c00875424506be6
-- 
2.34.1


