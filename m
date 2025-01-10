Return-Path: <linux-wireless+bounces-17288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B73A08830
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 07:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA9F3AC227
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BD206F01;
	Fri, 10 Jan 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LzTkECx/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D124207667
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489569; cv=none; b=KTBsAZrvuG1XGeJpqDe+V64jq4T4OhUSmvH8ff/vBI/45AP8jz1wAa1oYJ5d0Adcfqd+mJhSYlyujXnwCCRh0DnSsJ27WIJMG4focVi+5nb0ZgBnhsZYLezbasnMMj4LsHjj8kA7uQX5C7W0UOOsrzRbnfL9Hiic/nIGUiBTtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489569; c=relaxed/simple;
	bh=PMaZbLQJPEtLsI5TFBNXEDkGQZzPCYmrPCrYEV+CxCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fD+pB8yiIcFMg2NDQL+IxZRQMeOiGrvufnN1lT/DEmzxzHHq+CPCVAmL0OIwElQzJTowR//SsxaVz5c7GyCaYcDGjhMLEMLGW0dfhAFHtv64qcxScp5by+VsWts3PyCgdCku5vJH5nZu9sF29Sg7iljOAO+mFyNv3oE5ni8Y8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LzTkECx/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3bvRx002811;
	Fri, 10 Jan 2025 06:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3iS9Iloeshpk4CAshP3Zw4
	m3Jk+Wr6pCfQ/7Wt9Lpng=; b=LzTkECx/pcwPzj4ZrTx7XB6k6xOLtHzX7e0Jbt
	NjndJX3CCMKvIZRMHWIAplOMBEwrKPO324PJ8yzR+2ciT4743bnzFerz6tC/tSZU
	kYU2B91ZD+a1u1FLPDyoOzh3TZFkQLkzWdsgKPSGa+itpFjHtxMkVmNjnS+LD15J
	+CuEno699QqvI6KZRFOnSxvC7eYdhnxj3tD2i2JO7CXH8mKcJpN+PxC7ErD8/Yck
	dkT50A0xam9HSPkrvFD4tDxoy/XVdxcVIUyECsKqxzlQpYJTfbaGwucxOB0SM6Xn
	L8liHQLbrCXbxK+PTRrqJH3D0SDPSvxggROt6GEwkY/dS03w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442uteg9db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A6ChiM024425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:43 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 22:12:41 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v7 0/5] wifi: ath12k: Factory test mode support
Date: Fri, 10 Jan 2025 11:42:19 +0530
Message-ID: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-GUID: cDL4JuwF_vvcljkL__qAsssaOiGYvt4e
X-Proofpoint-ORIG-GUID: cDL4JuwF_vvcljkL__qAsssaOiGYvt4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100049

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
 drivers/net/wireless/ath/ath12k/core.c        |  30 +-
 drivers/net/wireless/ath/ath12k/core.h        |  13 +-
 drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
 drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  17 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
 drivers/net/wireless/ath/ath12k/testmode.c    | 394 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
 drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
 drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
 .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
 14 files changed, 622 insertions(+), 85 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)


base-commit: dbe50a7420e22954c747e79e72df2750d795ea77
-- 
2.34.1


