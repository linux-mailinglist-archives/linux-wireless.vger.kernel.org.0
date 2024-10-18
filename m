Return-Path: <linux-wireless+bounces-14192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728269A3478
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC871F23C9F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 05:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E8184535;
	Fri, 18 Oct 2024 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RUm34Rq6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1917DFF1
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230422; cv=none; b=jdpYWZBxuPmGACgegTzOh5+qnA4TB4zrC7vOwu/h3nmKQstjJqES79kn79rsQX9sAws50F/+ye7GA+JHhDGxXIc5e7KTj4tlAnZdHLKgKeO18vAZNYZHZy2qew3a+0kiMwYtXgko4pzh6kOtZzE7rCDmZpVJQCfaakXtoGrWY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230422; c=relaxed/simple;
	bh=JwiWxhM9elTfxL2SCdh2y6K3oXIodSZUFViOKTf5qQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bh3bw6YaypOp99c8vgW211vBAWyA95jMQqHrA4U0xPhgJxhG79/4v06XsPN1Zgi8gJJxNJwz0M46KA83ZrZBdKKMKdGGkByidUv8z5hCq7Vvp166naOaPgndCAjDFneOT9EkJeF4M4wFSDGc3lkibnw8pN61DkOK2KEmAk7mezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RUm34Rq6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJRXgV005787;
	Fri, 18 Oct 2024 05:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Dh+GayoOqHCW3PVuKVozml
	ZrjnUsOIy6Xqsqpjb1/hw=; b=RUm34Rq6F6emyBLWGSCH4sJu10C+Jm0eWNhKbp
	l09TyBciSLxyQEqiw6R0vn3Sl1WOPPCVHY7tM9p+KOhzc5EF7A3oMe3K8rOQU8Kx
	LjPPE7lxSwVtRfRGyGJopchkdBcEszgh4xbV784zqpWHInF7IBvsxK4dQQdjUn7S
	LMpJAV0WZWPmbgBO3grT4aVmNDmp22m2ba1QLCyBTljdesWcaOj1SpTWuFwgMLhc
	DM+/l+AWlgrVRbtspsqYTUnO/V1rzbVXZGUF1O8oO23elvJCi0vI60n5NJfsUo/X
	9cp6i+G6nZ8tEiQHdcmi94wnW32sgpr555FL4mqVeeg/D8Rg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b8rr16j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 05:46:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49I5kgxg002078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 05:46:42 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 22:46:40 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 0/8] wifi: ath12k: some fixes and clean up for monitor mode
Date: Fri, 18 Oct 2024 13:46:12 +0800
Message-ID: <20241018054620.2080-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: _vhW-nJvzijJdicOwyA5hPh-X5f1GhJR
X-Proofpoint-ORIG-GUID: _vhW-nJvzijJdicOwyA5hPh-X5f1GhJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=962 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180034

This patch set does some fixes and clean up for monitor mode.

v5:
    1. rebase on tag: ath/ath12k-mlo.
    2. remove patches which have conflicts with MLO branch.
v4: rebase on tag: ath/main(ath-202410161539).
v3: rebase on tag: ath/main(ath-202410111606).
v2: rebase on tag: ath-202410072115.

Kang Yang (8):
  wifi: ath12k: remove unused variable monitor_present
  wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
  wifi: ath12k: fix struct hal_rx_ppdu_start
  wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
  wifi: ath12k: fix struct hal_rx_mpdu_start
  wifi: ath12k: delete NSS and TX power setting for monitor vdev
  wifi: ath12k: use tail MSDU to get MSDU information
  wifi: ath12k: fix A-MSDU indication in monitor mode

 drivers/net/wireless/ath/ath12k/core.h        |   9 +-
 .../wireless/ath/ath12k/debugfs_htt_stats.c   |   8 --
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 107 ++++++++++--------
 drivers/net/wireless/ath/ath12k/hal_rx.h      |  53 +++++----
 drivers/net/wireless/ath/ath12k/mac.c         |  14 ---
 5 files changed, 98 insertions(+), 93 deletions(-)


base-commit: f7ffb7753c52eb06feaebb62c5f392e05fa3412b
-- 
2.34.1


