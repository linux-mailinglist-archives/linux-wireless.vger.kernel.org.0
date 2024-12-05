Return-Path: <linux-wireless+bounces-15906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01D9E4B9A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 02:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7802D16A33C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54614286;
	Thu,  5 Dec 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cpj9toML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669C17579
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360896; cv=none; b=O/ehmdlmUtSjbqPYoahBkxHud0wioBVLVXO94Y0QnFWJwpeu59gqt5U0Y9slBhigoWcoyGPIhdGA7Op8MLEVfFAG3kYxvmOms0zQw0mLZhSgY6lqV3bKjqXSh+VtDrZX4c5LtaAYpb+cXWhkBAdS8nj9xz+o0BhlZqIbmWdeW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360896; c=relaxed/simple;
	bh=lW2r4pfhQdV9ItKP8O2AJYPKJEwhMxCKiDzeqiIWv6Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GDFxxbaRIxIilGcKdtcoPhTIo06JRqDD5V2xkQ9O2pbKCoFcu170rM1tkmh85JNQHT5hoKIfGtsDBvpow7HjYQJCZazKK0OHmm7HLamd/5D9Zjaa7eYLodqD1JbhA+0di43D1ofgLl+Fg3xpZfNtLkvTzlnUjWgZvvIZ9hNe86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cpj9toML; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FZrYW005906;
	Thu, 5 Dec 2024 01:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N2im+N74cnd63qB0sJXmja
	gBxwyZgBACmr1oI19/asE=; b=Cpj9toMLpSWbZCP8N51jo2Z0+akYUly/DVuO78
	N/EA0Y48Wy7bpDQpn0PTTGYz89G+P04N0tT6xliwSypnkz/t39ZHzXuR/8NmW0P0
	2xv1fl6yHxUTCWyenLW6fWwNxTtWsc5LoikGCtmlC10n/+hweKPG+DpMfthyZ1oz
	vXCgM4zRK3Yi55cHgkW/QqmZRQ54bUtwlRo4j9B+FyFcJbLGgdxNbqOdKRWYWtee
	YAEOndCR9aYy8V09d+KIKn7DKWD+AWyk2dTGnkPE3DsWXf+ZuZAYlU5PSjVz9KY5
	6gsZ+xV0MMw6cIqxeAIx0O0Eq56Jgl+wfeyfqv7hg8tHFMZw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w3envvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 01:08:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B518A9t031141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 01:08:10 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 17:08:08 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/8] wifi: ath12k: Refactor the monitor status Rx path
Date: Thu, 5 Dec 2024 06:37:46 +0530
Message-ID: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ttqA-RL0osbgiPlg6PPZS7KZm8cSdEzP
X-Proofpoint-ORIG-GUID: ttqA-RL0osbgiPlg6PPZS7KZm8cSdEzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=708
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050006

Currently, the monitor status Rx path was inherited from ath11k but has
not been updated for the ath12k 802.11be hardware. Also there is no issue
at present since the monitor status Rx path is not enabled. However, in
the future, the monitor status Rx path will be enabled. Therefore, it is
necessary to update the TLV structures, bitmask definitions, remove the
unused bitmask, change the Tx monitor SRNG ring ID and refactor the
monitor status parse handler.

v2:
 - Rebsed to ToT

Karthikeyan Periyasamy (8):
  wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
  wifi: ath12k: Refactor monitor status TLV structure
  wifi: ath12k: cleanup Rx peer statistics structure
  wifi: ath12k: Fix the misspelled of hal TLV tag
    HAL_PHYRX_GENERICHT_SIG
  wifi: ath12k: fix incorrect TID updation in DP monitor status path
  wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
  wifi: ath12k: Change the Tx monitor SRNG ring ID
  wifi: ath12k: Avoid explicit type cast in monitor status parse handler

 drivers/net/wireless/ath/ath12k/core.h     |   4 -
 drivers/net/wireless/ath/ath12k/dp.h       |  14 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c   | 134 ++++++++-------------
 drivers/net/wireless/ath/ath12k/hal.c      |   2 +-
 drivers/net/wireless/ath/ath12k/hal.h      |   2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h |   2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h   |  14 ++-
 7 files changed, 72 insertions(+), 100 deletions(-)


base-commit: 3b2ab397d31f926523f2781d7f0a14a387415bf4
-- 
2.34.1


