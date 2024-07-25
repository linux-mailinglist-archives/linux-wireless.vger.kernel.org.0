Return-Path: <linux-wireless+bounces-10504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A040493C154
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 14:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1682833DB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44066198E75;
	Thu, 25 Jul 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fuBHopfw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7B22089
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908871; cv=none; b=c4KBp4I+s+qaLPHPn6qlqALsjTg1SqnGNWSlvfQ/xD8a/bwc0BGgmaT5DB2kgqcvPH5d9jEvQ+gmqzLSu7fZ4U0kYrCaygFEnV9qdgMIMeI5M3ehFQrS39mN16Bic4RfnWn5Y9IwzgkWX1/YZcPJcHwst5+IQKvboHHheOO+0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908871; c=relaxed/simple;
	bh=rqRBBcg3aSl+I61JJ/HYS/jdBqMp9/ZbxeaCI2zS064=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+HnWC2gQA+gY5tlJEHdGWWPplA6QZ4fv0gt4NFyheTrzsbFYqx3tyFEH8owqEXb7DGdVI2quYNI5Ui3GLyCMeG6NcTn55/9wMOn5ygFUBl0lHyF/dM3/sKgOPggaYS+V+rdS5ADc7wPxY8/6UD7/L+V8qqO0pJ+V6UL4A3vSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fuBHopfw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P7FoGm003701;
	Thu, 25 Jul 2024 12:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bIKLHfdNJXtWsXRTjDlb/L
	GCciquef0/wZ3XoVwTIeA=; b=fuBHopfwM42Hv7eN5wc7CP2v1mg5zPONO4/1Jq
	Q+SZLjWsK4xKubzJ7+WGUkgvwsY8RAcr89AqU/gmnY9t3LmNkY41hyIHtfwputTS
	PvGl2TABMNGATelf0SkqdKrrG6LybMzb73sNXqW57EhZU7MCq4F/bxStoZPb7axS
	fwFXg9RPCUfV5oKsX3pVJNP8xUyOjPpXWddIPVTta9FDk+I/5wQ5xAxWpKFKSYQM
	T/AqmWDMzqMqRC3eOH6ITO2lRcHH9hIGu9gAy8MDr7Zz2OcUw/cJrKRFnD2l3HdV
	yHZxFDA1VwiL7MbqNCSTU8WksBqCCY770ybSMQ8n+bKOocLA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5auw5mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PC10uE019158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:00 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 05:00:58 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 00/11] wifi: ath12k: some fixes and clean up for monitor mode
Date: Thu, 25 Jul 2024 20:00:24 +0800
Message-ID: <20240725120035.493-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bu0indDI7mztIJs7TPKd-yEqouyqeG8R
X-Proofpoint-GUID: Bu0indDI7mztIJs7TPKd-yEqouyqeG8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1011 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=824
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250082

From: Kang Yang <quic_kangyang@quicinc.com>

This patch set does some fixes and clean up for monitor mode.

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
 drivers/net/wireless/ath/ath12k/dp_mon.c | 108 ++++++++++++-----------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
 drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
 6 files changed, 114 insertions(+), 124 deletions(-)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.34.1


