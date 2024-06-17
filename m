Return-Path: <linux-wireless+bounces-9043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1A90A351
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 07:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A8D281A01
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 05:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72207181BA1;
	Mon, 17 Jun 2024 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OeEgnKJL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6494181326
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602169; cv=none; b=jczpNIW1M3ZOztKVZC9TABv+zoZJkdWyUpwHPkHIKxmaCkmOEU/MC87TaUcvNLtv22vs9HpDukKtB9B8cd9gGcRWpzCR9yGV7MssjEvMUEJXLmRcGpXRmllQgZsrm98hRZlblDNsSK23zy4Ch8Y3PM1w2xdREXXgRQbyMrQculY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602169; c=relaxed/simple;
	bh=CfO4uJmdHsXgD/UaDOEMpYJO1FTP/rPb1Ej6Yk9X6O4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJLswmKUXMlsVbuj6vbqmdQtoGGYJ48dsBu09R0/yA5ItyZpxX5AC3irIkWu+Tiuqf70BPHaf782JTzNvkB22zBeRj8QcXPZgiZEXjQvZ6XHKuTHPmuJnDxLnRYypRO/t9JZ6jw1aftHagoYFxRqUxSK7azcZ2tXJsltHW9Inyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OeEgnKJL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GNjkZh027199;
	Mon, 17 Jun 2024 05:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zhQTc8rjUY5sd4r9+YL86T
	CXAwM6mhGUsL6JqExZ9hg=; b=OeEgnKJLYUhpmfi8chNiz5+x58R2zdUFzvAA6o
	W309WH9uL7sPdw+mWzK/uwUIaqundsDYlufZIK6yLSi5SP99dzPDSMJaCAuuVOEG
	7SxvIS4Sv9eiFi1FV92ZRHQ1iHcQtjMguK9CGlGipyND2pKye7ZIK3dsNf0o+cJK
	m/CJPMDAsEv4VhGsiHTgetyS1uIPWbB6llg2UUPkYxKCu4SQMTuQrONnpvlhjcHh
	4bzoENWjVvMPThfEMDmMz69vJQp/hDYDm8WLX/OQDGZpSSDiftn7yzSL0JWZY+dN
	nh4wMy0BWrhCync36TLFj8Kgf0peGCFyMI/U2cpdWSpJalkA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3b72s4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 05:29:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H5TL5v011235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 05:29:21 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 16 Jun 2024 22:29:19 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v4 0/4] wifi: ath12k: Factory test mode support
Date: Mon, 17 Jun 2024 10:58:59 +0530
Message-ID: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-GUID: 4q1xBhxP5YeR4Dj9DHv3iHsRjcVXxowN
X-Proofpoint-ORIG-GUID: 4q1xBhxP5YeR4Dj9DHv3iHsRjcVXxowN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_04,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170038

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
v4:
  -Rebased on latest ToT.
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
 .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
 13 files changed, 635 insertions(+), 75 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)


base-commit: e72048809ec7355a947415ae6836d2eb7fdcda39
-- 
2.34.1


