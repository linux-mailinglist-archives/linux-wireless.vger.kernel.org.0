Return-Path: <linux-wireless+bounces-16436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC29F4169
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 04:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42891188A49E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 03:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BED13B590;
	Tue, 17 Dec 2024 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ldKrAtHL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BAD4A23
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407984; cv=none; b=RLOn5hxN+uTDQWIbh0HKJUNUg609GdKiWzkwmDrREvGdbg6spIvW2lPsFt2uuS8oY92bsi2WS1hZJxEq+8JXPOaV7DxCqYLFJ2w1+nc6AgDLJRrSVlp0gjwmgAN1BNyklF15qZ/E8XpxLD8JXoWUPfrFpps1CIhF2xwJ2UdGqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407984; c=relaxed/simple;
	bh=TLjF0mWCPCa5JZtZUUZgJsa7JxE9peLtDY17V7lbDD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpm9ZidoC4PCERBm24fPGSrZWqzahHHQl4IKY3Qq0Mh6vDlEh0yCDZJF+igQ/VbwoPcqisqWDo9OW0nsifi8aSRJBefzG8Z8xZkrSQ9+3wonnDEE7C4ndwZlTc3NCFxJGY+KshfJl1DBx6Y1BxCbIsv1iWcNu3/MZc9ZNRD+FuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ldKrAtHL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGNt1CC003554;
	Tue, 17 Dec 2024 03:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ohgre86f/RjxmC96Or9Gka
	yA8Fx0HwkxCKWNRjpRebE=; b=ldKrAtHL2FNxgiOU/XaggnACXHh1cX2DeUMJqr
	arN4UvgWpdGc1bocLPtapqzSZX2kjI6q0lql7s0DnFiYRtEPOUBOmi4DkLNGInHy
	bCe0Rqe9a9PcQvNJgjczd1e+8AIJG2CQtePdQvBL98n6BoDGVoiADKMk4W6cy4R1
	98GuN11P/OPuRl3KBDDkZsDqMXEvVAcVXoRYCSYXOJ52KJf4Xt2kk3vvg2ysbURC
	aUeXQ56U3cX345XRHIbYkeYnoeektwjmaGawWgRMkmeOtXV0QvcbWACLuUrQYfUb
	Zpvvu/vhnb/IlZP3VHxm3miyu2rOak8wnKx9TnQVWF+sF2kQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jx9ygfdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH3xaA8025401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 19:59:35 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: Fix the static checker warning
Date: Tue, 17 Dec 2024 09:29:16 +0530
Message-ID: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: nl7S_1iENJ3Pds_Plnfe1qrO5emdEb8m
X-Proofpoint-ORIG-GUID: nl7S_1iENJ3Pds_Plnfe1qrO5emdEb8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=488
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170030

This patch series fix the below Smatch static checker warnings

Warnings:
mac.c:10941 ath12k_mac_destroy() error: we previously assumed 'ab' could be null (see line 10930)
mac.c:11007 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
mac.c:11013 ath12k_mac_allocate() error: uninitialized symbol 'ab'.

v2:
 - Rebased on ToT

Karthikeyan Periyasamy (4):
  wifi: ath12k: Refactor ath12k_hw set helper function argument
  wifi: ath12k: Refactor the ath12k_hw get helper function argument
  wifi: ath12k: Refactor ath12k_get_num_hw() helper function argument
  wifi: ath12k: Fix uninitialized variable access in
    ath12k_mac_allocate() function

 drivers/net/wireless/ath/ath12k/core.c | 16 ++++-----
 drivers/net/wireless/ath/ath12k/core.h | 12 +++----
 drivers/net/wireless/ath/ath12k/mac.c  | 47 +++++++++++++++++---------
 3 files changed, 45 insertions(+), 30 deletions(-)

-- 
2.34.1


