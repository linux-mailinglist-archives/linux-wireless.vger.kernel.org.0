Return-Path: <linux-wireless+bounces-21288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A31A81AEC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D43B3A6BCD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C3A192B74;
	Wed,  9 Apr 2025 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JtWFgiU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83086347;
	Wed,  9 Apr 2025 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165642; cv=none; b=TISlbLIJfJGnodwgQ+S6KI9BUapnSCISby8ovnksvTGKNgw7uCz7T4bKxzBB9OujPhIsjxoen4HXwm81XKZgRzwoNvMKBdkDxy5xpVh+13c6RPdJjLisg0Rp8w1CS4sm1gj9ktNRkmX7hYm+nVtwbSxLOffNhYwiEHGAv+jSegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165642; c=relaxed/simple;
	bh=cOQKJJUN0ZUxztgM0eKlTKhYfUoWSTxU9xmqweYIUcI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HG+Q2dgetMSzvkFWMJE0R+icp6F2YXlOWOMSrbOVsY99PJY0RRmZfwDRR+CyW72hFPxK1FdMzFq4nU5O74RvTy8FcdMA8RvFOZxWUCgxHzzNfXCafP5NsjZAcwpiepp61QfbX3ZwVHq6w2xOyOU4oafRxkqOLyWwAEvzLm9vZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JtWFgiU1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYwbf015755;
	Wed, 9 Apr 2025 02:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7V4DAPO81kQa2KrxRoWP3B
	yu/nrWhYhVsqeLtvyh9SY=; b=JtWFgiU1yH1velhJQsOc2phK/hrMj2mWCopPMT
	XtY5MXWJdO0QZ6NVyBAaWuHiPUcvQSs9DVqyvPXXZ9oTRSXQhj1XuKMRb7FEsIf9
	kqe9F3vrxLOGyXJ+RVb5Sr9aOckYeksNoAETWOP+0u8/JBQhRVTd6O1U8Qw1vGIz
	ELII7eYgKydCi6vZJJ2RR5stXLX4C9F/kfKcIvPK4Xt2tYLaPxWPhXEWz3IMbtrt
	WUDHO/vJNkkbXLMncZnnGGXzDtT5eA5JdOWz3WRAh79wKspwed1ZLSlhdvqmdSFi
	yefvwSsO5qWN7/0DYt7aAJoc2E16kqs8NZ2pDCadJ+twsKDw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2ssma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392RB8u000881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:11 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:08 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next v2 0/9] wifi: ath12k: support MLO for WCN7850
Date: Wed, 9 Apr 2025 10:26:33 +0800
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANra9WcC/43NzWrDMBAE4FcJOnfLSrKzdk55j9KDfta1aCM5k
 uOmBL97hS8hFEqOwzDf3EThHLiIw+4mMi+hhBRrUC874UYTPxiCr1koVC1qRWDmUapP+HaRuhb
 h9JWgXKYp5RnswL7tlZe6t6ICU+YhXDf8TdQdRL7O4r02Yyhzyj/b60Jb/8zBQoCA+0GbHpnI2
 +P5ElyI7tWl0wYv3fNYVzHTW91oYiv37V9M3rEG1b+YrJg1viE3IBI2j9i6rr+ObOTWagEAAA=
 =
X-Change-ID: 20250327-ath12k-wcn7850-mlo-support-bfed592d139b
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XuOXCbZeLa9vstrAXzMSmcihv9AaQI4d
X-Proofpoint-GUID: XuOXCbZeLa9vstrAXzMSmcihv9AaQI4d
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f5daff cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=S8qQzX23J8qjeTGorjwA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=891 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

WCN7850 firmware uses API-1 so it can not advertise MLO support via
firmware IE, but instead it uses single_chip_mlo_support flag in QMI
message, the first three patches serve for this purpose.

Currently ml_arg->assoc_link flag is not set in
WMI_VDEV_START_REQUEST_CMDID, this result in WCN7850 firmware crash
in MLO case, so patch [04/9] sets it for assoc link.

Patch [05/9] makes sure we do assoc for assoc link before any other
links, as requested by WCN7850 firmware.

Patch [08/9] change to send REO queue configuration to firmware
for all links including non-primary link. For that purpose, preparation
is done in patch [06,07/9].

The last patch increases number of different channels to 2 for single
pdev device, to avoid failing in bringup the second link.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
Changes in v2:
- rebase on ToT
- Link to v1: https://lore.kernel.org/r/20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com

---
Baochen Qiang (9):
      wifi: ath12k: introduce ath12k_fw_feature_supported()
      wifi: ath12k: use fw_features only when it is valid
      wifi: ath12k: support MLO as well if single_chip_mlo_support flag is set
      wifi: ath12k: identify assoc link vif in station mode
      wifi: ath12k: make assoc link associate first
      wifi: ath12k: group REO queue buffer parameters together
      wifi: ath12k: alloc REO queue per station
      wifi: ath12k: don't skip non-primary links for WCN7850
      wifi: ath12k: support 2 channels for single pdev device

 drivers/net/wireless/ath/ath12k/core.c  |  23 ++---
 drivers/net/wireless/ath/ath12k/core.h  |  15 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c | 178 ++++++++++++++++++--------------
 drivers/net/wireless/ath/ath12k/dp_rx.h |   4 +-
 drivers/net/wireless/ath/ath12k/fw.c    |   9 +-
 drivers/net/wireless/ath/ath12k/fw.h    |   3 +-
 drivers/net/wireless/ath/ath12k/hw.c    |   8 ++
 drivers/net/wireless/ath/ath12k/hw.h    |   3 +
 drivers/net/wireless/ath/ath12k/mac.c   |  62 ++++++++++-
 drivers/net/wireless/ath/ath12k/pci.c   |   4 +-
 drivers/net/wireless/ath/ath12k/qmi.c   |   6 +-
 11 files changed, 213 insertions(+), 102 deletions(-)
---
base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
change-id: 20250327-ath12k-wcn7850-mlo-support-bfed592d139b

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


