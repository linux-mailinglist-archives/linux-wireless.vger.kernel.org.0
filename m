Return-Path: <linux-wireless+bounces-15474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF259D1C90
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EA7B2256B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83CF17BA3;
	Tue, 19 Nov 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hgr5jJxn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6489171BB
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976392; cv=none; b=Z5WOCudLASj04ZkK7IhObi1V2JQR6Y7s7bWMvxEUMvSEvYGCQVFzZg/EsKfXeuJfbf3UMprVAp7xWvIIp95S8VkYDpGrcmv746C0IEgCmaQ3wp1sISRGNLZeVAd/4eKpwh+pL4xeHe6Ex3C9mMoYauqgTZLhEg9To3Jy1APkLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976392; c=relaxed/simple;
	bh=Oboqh6EXfh13IkLC3mWZId1IztGfyzGOWjD0sxhq+IM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rw+jCfuuaG2+gg36yqPXeTRFgjwQWUt9fxkqflI6CijYGK6WbrhmRgE40/ABaURvGKgNgfX1xg/4gfMTbLM2OB/M+jOQCvKfwwgSzYilcuvTM5aOV3/yXUbiW0AP5aWBDCI3DI+44f25Gj7nyv/MAzngPyUkhTK0dJMRjyzA4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hgr5jJxn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGLp9B011453;
	Tue, 19 Nov 2024 00:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ud7zDprQjyjQRz+mUG/dse
	tGiz5B0cJLXidw/JuFK0s=; b=hgr5jJxn9kOaj/k8ysZKpH7scr7N/2tPTkBMw7
	cQvzSt/T2O2CKGYnhYtvs4uzvccsafZji6HKW6JS/HP1BZgxxFTZ+sfa9QeBuEnF
	R2S/qvJEHF0KIbmEngk1z5wTn7JCZpYyIYUXfxaik8Gmzl9VaeC2LQlWefr56A3u
	J45NXEeIlC43OT/Qsq/wlYPY548Pe7szL10+DCo5bD5GLMJLejgnbk+kLjeldohf
	xEmTyCt2/DDN1szjoDUyi+2lYc01Z+RusXNzhMh7ItVhrDH7gayxztOmxnQeQD3e
	UdUlSQv8xWK7419M3gZBbjh9fiPuu0p3J1nTsafz9DMwjpGg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43091m8xbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0X4A6012791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:04 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:03 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/8] wifi: ath12k: Refactor the monitor status Rx path
Date: Tue, 19 Nov 2024 06:02:40 +0530
Message-ID: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -Ijw_KPwTkTr0Tttl6-NoZ7wQUWFeMNv
X-Proofpoint-GUID: -Ijw_KPwTkTr0Tttl6-NoZ7wQUWFeMNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxlogscore=685 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190003

Currently, the monitor status Rx path was inherited from ath11k but has
not been updated for the ath12k 802.11be hardware. Also there is no issue
at present since the monitor status Rx path is not enabled. However, in
the future, the monitor status Rx path will be enabled. Therefore, it is
necessary to update the TLV structures, bitmask definitions, remove the
unused bitmask, change the Tx monitor SRNG ring ID and refactor the
monitor status parse handler.

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

-- 
2.34.1


