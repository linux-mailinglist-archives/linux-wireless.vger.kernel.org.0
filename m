Return-Path: <linux-wireless+bounces-8783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5A903697
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0CD1F21F29
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E1174EF4;
	Tue, 11 Jun 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JJBXKsAk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CB174EE4
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094894; cv=none; b=ECr1emW2nHnSadK70faEvS0qT30xlhqS5QEFhEgLyXEKrUgulwPEr2co9hOjJbmbmZ3kC8E4nZMxUnl1WWFEaIRpLLxl60l9IPwp9vQEfxfgB4zumLXLGEdCcTFzepeJodyfR4ge97jxlKtPaKwxCYuaWSDQN9nceruvpiIIH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094894; c=relaxed/simple;
	bh=N6TIQneVpCwWIxCgye6l99yPSyzKe1w5EQc/Uff8HMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O3uLHoyj8oaqTBjoLAf6oVqD9DPJw5r4AD0JNiRglaKnAFuT4lMjm8JrJLVotyMCn3mS/wqZesWcubrSfFIZBQAUWiw4H6DkE/d4MeJLJu1siCqVk9rvqgyakQB+gbxp5OATcHnnY4ZMd3FogTsCWJwAqyUROPeU/JswFN1sgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JJBXKsAk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B2XQTU019744;
	Tue, 11 Jun 2024 08:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tDPsjPzJ9VCj/2mjLljN9/
	JYw5dtDHCFaig4AQ3sK/I=; b=JJBXKsAkPZNp+os/WElcbu4KGu6S05SV0mKjTY
	MHbQPKIklaDy30m/4qZQwW6EYOB04BRgyCPFU9DoN1H5QYYuqnWO3+/U5nfrnNhE
	FhDjEKTHAZ0sou2g51Bewjaa8mLPR1aK4anKERVFvaFNTKXM80C1yIrAMZb/rv0f
	DiWSZwB5w5/D9QSUFqVHd8W6PT26Yz3f4Q6urBVXJhRgDoy7s9+g+LRLpz66a1x+
	RtcdWukLbI6mUTfcq3x9E3hQAtY2YsZkDdDR7KuY5Ee63TSxJNwC+KglCdyrBCwP
	+0lLwIS7SdgXm9T9nOOV5ByUE9pq8+RiLJx+AP/2n+HKGN3g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmwpq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:34:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B8YjQ4000714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:34:45 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 01:34:43 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v3 0/4] ath12k: Factory test mode support
Date: Tue, 11 Jun 2024 14:04:23 +0530
Message-ID: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f2wyKBGN6JOOXzP83xGhNH4e98TleOea
X-Proofpoint-ORIG-GUID: f2wyKBGN6JOOXzP83xGhNH4e98TleOea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110062

Device is booted in factory test mode for calibration.
The commands are sent from userspace application, which
is sent to firmware using wmi commands. Firmware sends
the response to driver as wmi events and driver sends
these events to the application via netlink message.

Also added changes related to correct pdev id access for
fw test cmd.

Aaradhana Sahu (3):
  wifi: ath: create common testmode_i.h file for ath drivers
  wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
  wifi: ath12k: add factory test mode support

Rajat Soni (1):
  wifi: ath12k: Fill pdev id for fw test cmd

---
v3:
  -Rebased on latest ToT
  -Updated Tested-on Tag
  -Removed second parameter of ath12k_core_start()
  -Updated copyright
v2:
  -Rebased on latest ath ToT
---

 drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/core.c        |  22 +-
 drivers/net/wireless/ath/ath12k/core.h        |  13 +
 drivers/net/wireless/ath/ath12k/debug.h       |   1 +
 drivers/net/wireless/ath/ath12k/dp.c          |   3 +
 drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   1 +
 drivers/net/wireless/ath/ath12k/testmode.c    | 422 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
 drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
 .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
 13 files changed, 634 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)


base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
-- 
2.34.1


