Return-Path: <linux-wireless+bounces-17620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE3A14999
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7063161362
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 06:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E757F1F758F;
	Fri, 17 Jan 2025 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gVUgP/od"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7C1F5602
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094696; cv=none; b=AfeXwcIR3Qjhi6efz52ZZfzy7tzFnG9h6rG2m1c90Mb6aziTavyU2QpZWOpP5gYX2iS8btVTKxKcGe20JPUTbdVJDB8X3enW0KT7wiiiPeYv27Er0aa4uLmv46X6aUt5BRFTxH57w88YpQnauTsDFzlaB790elrwfhcQX9ytvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094696; c=relaxed/simple;
	bh=gbf91EbQqxzTzWnSki22SvqCpiuRbbFN2zPYynmuelk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rm6P1S1LQfcr6yMb5IXGi4j3RYPsy5eWsP/gcTcNn7mQNqxEK7gvZ0ygyqcIvloDXzWgAWbT1mRFlULLehk/pHXPan0q+FydkuxEN/IjH6LSW0CrvdSr1PDJt+WcfVmLhLyKxqAJXUGd6AP6d761Lp941y+qjpGtDydr6+JmPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gVUgP/od; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H37dE1026615;
	Fri, 17 Jan 2025 06:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LG8YA/lAeU2Ubx5gCdigeZ
	IkFmtEj/8lPzkFgqSX7gk=; b=gVUgP/odg0E5IcA1rRWAM21vxzH2zsHKyBLNVO
	CYrhglZpz6GwqBMgjxggn3o8OAAv5ZHi/m6FUOv//YBzRwHuwkkjE8ZzNy2sKg8Z
	R6kPgZlIhXU6mwoT9T4qFm9oxRbQpAwwDl+2VvJ05f4yRqjrn0ASUEfwmEkx7Kjk
	Zu8DCYw7mRUNN4RT6a5F8p2wzBcTtn8QMjUR4QNM8rxlKOPAjYMuyuIRA0E2X5Ea
	En+D3Z16LeLEuxaLObk+LVg9SON/6YpNoKUIutANm8qOHyvEoXBIhqvbMNhDqqz2
	GBS3BUYvyJ9XT4ivJ9B23gSvaIu5olu/uUon/8gobKO7Gccg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447f1egbfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 06:18:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50H6I90Y018988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 06:18:09 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 Jan 2025 22:18:08 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 0/2] wifi: ath11k: fix data out of sync for channel list for reg update
Date: Fri, 17 Jan 2025 14:17:35 +0800
Message-ID: <20250117061737.1921-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HPUtjAEBcbYzFjE8gwH54DqZCOHASh-c
X-Proofpoint-GUID: HPUtjAEBcbYzFjE8gwH54DqZCOHASh-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_02,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170048

Currently there are two threads to updating/fetch data of channel
list, and there are no synchronization for the data, it leads data out
of sync for channel list when doing reg update.

So change the call flow to make sure the fetch data running after the
update data finished, then data of channel list become synchronization.

Note: This patch-set is an old patch-set in public review written by
Wen Gong. Just continue sending it for him.
Link: https://lore.kernel.org/linux-wireless/20230329091235.19500-1-quic_wgong@quicinc.com/

v5: 
    1. rewrite commit message in patch#1.
    2. update copyright in patch#1, #2.
v4:
    1. rewrite commit message in patch#1, #2.
    2. use list_splice_tail_init() to move list entry.
    3. use data_lock instead of adding a new lock.
v3:
    1. rebase on tag ath-202411251703.
    2. add KASAN BUG report in patch #1.
v2:
    1. rewrite commit message for patch #1 and #2.
    2. use a local list without the spinlock held for patch #2.

Wen Gong (2):
  wifi: ath11k: update channel list in reg notifier instead reg worker
  wifi: ath11k: update channel list in worker when wait flag is set

 drivers/net/wireless/ath/ath11k/core.c |   3 +-
 drivers/net/wireless/ath/ath11k/core.h |   7 +-
 drivers/net/wireless/ath/ath11k/mac.c  |  16 +++-
 drivers/net/wireless/ath/ath11k/reg.c  | 107 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/reg.h  |   3 +-
 drivers/net/wireless/ath/ath11k/wmi.h  |   3 +-
 6 files changed, 100 insertions(+), 39 deletions(-)


base-commit: d7bef42fc98f2d8f67546d1ea1a3f2c2932fd72b
-- 
2.34.1


