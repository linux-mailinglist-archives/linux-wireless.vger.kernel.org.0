Return-Path: <linux-wireless+bounces-19329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1EA4096E
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38EB7016F9
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225E19CCFA;
	Sat, 22 Feb 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q7YJTfpV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D713AD38
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237592; cv=none; b=hY20Rmx/YpFHByW8XjQCXiUJ9bG4iIr8Myc/Axuq93sZvsjxhSgpBqbsNGxCz7dJtid5lFJKqrN+a3pCaoFAs9wLfe56y8k94jbuYR8ZHtnRz9HoyuAtWu/GEpq1SYPMhtmc162EA6cxGqs5MBxbZ7De/f/0dBNx4M8Z5EZr2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237592; c=relaxed/simple;
	bh=3o74VHhiXJtGWMwZExlOrIZhizdaa8I8kFNUm0ShR6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PYA2Y7wha3CzNdlsqFpS19q8DdVMdqTb52spdHQYpWC2sP1C9Nu2S9y8XVWtK3310Rwn0M6Qsuc8eJ9T5MhLv7Eq/iA1dj4DIDxOPwxeQCURdLlwSGm/8LcmRHX1Q9sLt7CPcLNtEZ4ukZ+ju+iGKCnY8UMH2S6OnBywDEHKUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q7YJTfpV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MCFxun027838;
	Sat, 22 Feb 2025 15:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pwTebS8dIRFKtjUHZqgpMK
	RTS3I9njRO8PO0eahTyXU=; b=Q7YJTfpVk/TcSlvdYgimln32Dq8qmItUPX2501
	jC8QF+e+4tLdKxfSblhrJdOkhKxMDarylOHe1flX18jVklepbtT/IiIytRczJ4Up
	Y4NNI17zHpPhdml8UIvjqyBTxpxAV00yJwl7gW2lIxzz0gJJ/gSLW2wNKrDTzAI7
	IHypGANk6S3UvcZhLCQckvdKXb8WLOj2j6eMjKQUilhOWUF4Xs4wu5XHmIHXSaYe
	xL64VmoBDmrBE38NHRvWC/Io13nPCwJxnJHk5QbO5akZ/8VxFrG9oJOuJdf9IHm8
	kjPJgDTQvq/VkOzQZmTUSzTYP7MTUofsoeoPu+3lVsdaYNsA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6ntruqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 15:19:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51MFJgsO028214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 15:19:42 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 22 Feb 2025 07:19:41 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v8 0/9] wifi: ath12k: Add monitor interface support on QCN9274
Date: Sat, 22 Feb 2025 20:49:17 +0530
Message-ID: <20250222151926.379652-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lla-wRK0SuREN6Cu4D6n5CAN5GI2vdAF
X-Proofpoint-GUID: lla-wRK0SuREN6Cu4D6n5CAN5GI2vdAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502220122

Currently, monitor interface not supported. Therefore, add the missed TLV
tags parsing in the monitor parser, configure the monitor vdev state
identifier with HTT filter setup.

v8:
 wifi: ath12k: add monitor interface support on QCN9274
  - Added comment section for restricting one monitor i/f in each radio
v7:
 wifi: ath12k: Refactor the monitor channel context procedure
  - Added new patch to avoid multiple change in a patch
 wifi: ath12k: fix NULL access in assign channel context handler
  - Added fixes tag
v6:
 wifi: ath12k: fix NULL access in assign channel context handler
  - Added new patch
 wifi: ath12k: add monitor interface support on QCN9274
  - Moved to NO_VIRTUAL_MONITOR mac80211 feature for adapting single wiphy usecase
  - Removed tags
v5:
 - updated the s-o-b as a last tag
v4:
 - Rebased on ToT
 wifi: ath12k: Replace band define G with GHZ where appropriate
  - Dropped the tags due to rebase changes
v3:
 - rebased to ToT
v2:
 wifi: ath12k: add monitor interface support on QCN9274
  - remove redundant filter setting in ath12k_mac_monitor_start()
  - set the default filter when the htt monitor configuration get disable

Hari Chandrakanthan (1):
  wifi: ath12k: fix link valid field initialization in the monitor Rx

Karthikeyan Periyasamy (3):
  wifi: ath12k: Replace band define G with GHZ where appropriate
  wifi: ath12k: fix NULL access in assign channel context handler
  wifi: ath12k: Refactor the monitor channel context procedure

P Praneesh (5):
  wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
  wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
  wifi: ath12k: change the status update in the monitor Rx
  wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
  wifi: ath12k: add monitor interface support on QCN9274

 drivers/net/wireless/ath/ath12k/core.c    |   5 +
 drivers/net/wireless/ath/ath12k/core.h    |  18 +-
 drivers/net/wireless/ath/ath12k/debugfs.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp.h      |   2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c  | 362 ++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/dp_mon.h  |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   |   6 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c   |   6 +
 drivers/net/wireless/ath/ath12k/hal_rx.h  |  15 +-
 drivers/net/wireless/ath/ath12k/hw.c      |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 112 ++++---
 drivers/net/wireless/ath/ath12k/wmi.c     |  36 +--
 drivers/net/wireless/ath/ath12k/wmi.h     |  16 +-
 13 files changed, 455 insertions(+), 136 deletions(-)


base-commit: 2dba67975394b47249189fcf975352105306962b
-- 
2.34.1


