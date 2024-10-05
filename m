Return-Path: <linux-wireless+bounces-13548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2DB9915EC
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 12:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554AC1F2361B
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C32132139;
	Sat,  5 Oct 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gsyMOOf/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4C8F70
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123523; cv=none; b=Hmyla+C54sVvrCdhp/+XhT9D7X1wpC/tIE8Ccrxz2p43G58g4FGxYKGNOl1eZ/Ytuh8Gkxg++29QoQt4q94II3WNrBxzsXM5e6XzU1yIi8tGZ0cspWAhTz7pVpEmiHQVE2T4s+FGAHt8l0Bpu414fHRLeGqJ0wDULI9S+Vw6ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123523; c=relaxed/simple;
	bh=Ze4eOJRK81zvV0iyRzcukVWAbnNH1igb78F48u/RRhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCXO8gQBcswKxQMKktBfTspsgi4qY78GLoStLIxpBfki4FotHwxQnCtapJxG+WnVautq52Ss2FB4q/2FJudeBiMjlm84hMdtUpnZskgDmv44Qa1Wws8GUT7Q2f3T+LUan6Xmq7fLvg8f5qbLtejTHrgjlwjh+jfbcjr3zIwdnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gsyMOOf/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4959nESH020625;
	Sat, 5 Oct 2024 10:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YzlJ2EaVnqtnOHyG2PD7Kn
	WWoZS/TX1ctzTn0ibzukc=; b=gsyMOOf/ccr5tnSmp8X5kjaZ0uIcfP1JCl/xZV
	GpV3CJ6jBUfIY7TGkRiDoUOPHJy1XkukrjbQExN2RaoZxoeUBtGzDVckEGg3lzIz
	VW0vZ62QGF6deOQmvnPk8PPnJiHPO4Myn9RY/4Id2egB/DPEcNnsSHkpqzMwRO6a
	DA4IxXWijaxfN2COWElQ6+q71SDGOH6OrTETko3bVbW8BBmO9YulHZCIJK88dIoQ
	6jG5L0KjCF6ZlBlWrwB7DIES1bxmww1PPhig8oJlPi4hm7kGTlHq0Sl/Xn0eqCZP
	CEeFMHdc5WE4c+7PD16rpGc2id+QD/KykC/BnBl+RVY6YQvw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xv88bxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 10:18:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495AIZB7022347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 10:18:35 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 03:18:34 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Date: Sat, 5 Oct 2024 15:48:12 +0530
Message-ID: <20241005101816.3314728-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DkbC4oVDfr5pllO0a65BLyzhakz-WAqB
X-Proofpoint-GUID: DkbC4oVDfr5pllO0a65BLyzhakz-WAqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=583 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410050076

Add support to request HTT stats type 12, 15, 16, 17 and 19 from
firmware. These stats give self-generated transmit stats, ring stats,
SFM stats, transmit multi-user stats and CCA stats, respectively.

v2:
 - Modified the API print_array_to_buf_v2() to print_array_to_buf_index().

Depends-on:
[PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Self-Generated Transmit stats
  wifi: ath12k: Support Ring and SFM stats
  wifi: ath12k: Support pdev Transmit Multi-user stats
  wifi: ath12k: Support pdev CCA Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 1047 +++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  346 +++++-
 2 files changed, 1387 insertions(+), 6 deletions(-)


base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
prerequisite-patch-id: faf46024c8b5c094e201d392109e7f94dcecdd49
-- 
2.25.1


