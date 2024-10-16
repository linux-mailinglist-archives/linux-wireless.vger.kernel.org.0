Return-Path: <linux-wireless+bounces-14043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA189A01DF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140D528184E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406319AA5D;
	Wed, 16 Oct 2024 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XAsXsWRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887011B2185
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061854; cv=none; b=BQp7F11DuKC8HyS5FJUcClCrl5Q/B2NGWFFbN+CYjEb90l4walQZdg7xVJ42tMx9vYqXQpVt4fOMaeKQOhtWUjyif3Q99AFi98t3Aj6EuhTHtRxebV8uzN4GhvkRnBjT7z1vhZiKCo0Ztn/1QrpqvBiupfZ4+uta/ERXaxM/kxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061854; c=relaxed/simple;
	bh=InGQwgRUwRmq0nZmxhopByRtt0CM2zTE2LiNtiWP0b0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJf8teqxWWtlVG4HeArDLcYthloxwUHCTNUnhCDDrQdKBdfQi4ZDQHDV5kPSKATp4aIf7zqshnUJIakPGhTeLwUlB2J7UHlraE8mxfsSaRyEwDzXz63znQTefW5cB/MeY2jF2NpssdasgP5jB14zvHxTz98QOooZfTjYAKytKiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XAsXsWRH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6uYXb023604;
	Wed, 16 Oct 2024 06:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wWfzjLw4U6Jo1db/Aj6CiD
	zNuFC62h0y6qerJMx2sI0=; b=XAsXsWRHx+i4C5UbLx3XhTPNb7rGlQMR1q7JPH
	Dm5ZwkFOTxydmzTcLRaRLj1tgLmuYY2BaN6DjyRm6tB7pCb1doITbSAmGWCOqhKc
	cA4XV4i3xu+0+FG8H2bR3MQEqLJpivuYh2BeYIKxaddsYtzVbwzg7qaTHvLMkz3+
	QDIGL0mFNcmMZpvKiLgHWBP7U5YWWBHrNXMDC4rY24gCukRS/H/AKuwcsbK1whYG
	h1s4/ydGv2cq07obWlVQXESlc7gVgah9LVNh9l6BEIxkODawjjINZKwyltFZx4fG
	lyoaBntAT8VXGQrNrqUBbTyLshxliYnUZq6o5RhCq1yu3w7Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq002c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6vO31031142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:24 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:57:22 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 00/11] wifi: ath12k: some fixes and clean up for monitor mode
Date: Wed, 16 Oct 2024 14:56:49 +0800
Message-ID: <20241016065700.1090-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Z8xA1wfw39QT1nmorU9fXUuh9EtCJg8b
X-Proofpoint-GUID: Z8xA1wfw39QT1nmorU9fXUuh9EtCJg8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=846 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160044

This patch set does some fixes and clean up for monitor mode.

v3: rebase on tag: ath/main(ath-202410111606).
v2: rebase on tag: ath-202410072115.

Kang Yang (11):
  wifi: ath12k: remove unused variable monitor_present
  wifi: ath12k: optimize storage size for struct ath12k
  wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
  wifi: ath12k: fix struct hal_rx_ppdu_start
  wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
  wifi: ath12k: fix struct hal_rx_mpdu_start
  wifi: ath12k: properly handling the state variables of monitor mode
  wifi: ath12k: delete NSS and TX power setting for monitor vdev
  wifi: ath12k: use tail MSDU to get MSDU information
  wifi: ath12k: fix A-MSDU indication in monitor mode
  wifi: ath12k: delete mon reap timer

 drivers/net/wireless/ath/ath12k/core.c   |   5 ++
 drivers/net/wireless/ath/ath12k/core.h   |  23 +++--
 drivers/net/wireless/ath/ath12k/dp.c     |  25 ------
 drivers/net/wireless/ath/ath12k/dp_mon.c | 107 +++++++++++++----------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
 drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
 6 files changed, 115 insertions(+), 122 deletions(-)


base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
-- 
2.34.1


