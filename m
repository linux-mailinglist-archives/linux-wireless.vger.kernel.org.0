Return-Path: <linux-wireless+bounces-16712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B853F9FAA23
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CD7164C28
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5992F3E;
	Mon, 23 Dec 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="er0kDIdF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007495914C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933713; cv=none; b=Ds38728Xq8DcFO6tSgQmOUTMK44nIIzCHcbe05HkzLJQzZsfuDf8XHHBotinrJ2bmx0+iX+rCUalxCMhbCRESJxZbqvuof79XnAnVu1nxAxR7s5122uhaU1awZ4Ui767PdPjGkhotbI6C1qH/AVYu2CbKWsYWPMN0fZmGkrjc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933713; c=relaxed/simple;
	bh=YJJV8QbqpOdoGNy3b0uk2zo/laDEb2uerW8BQYuauIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sE75HZ7NJ/xP3Q+uJscSrS8iQN6sZGXunvi1JX9ohLKwQL+wRD5rX9HENjKYZFPGu9EOEQZC/Qny+Vy6U6t8yCDjkyqUHqlzyctlEuwiRgIa+KlAFXSLKpcBsE0ordyUgWmuI5uYE1hFOhVlz/tMtR9YGkOdDJ29k2t9R8yKtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=er0kDIdF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN2riUK024819;
	Mon, 23 Dec 2024 06:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jXxJKeikwHLj1FY4QuWLSa
	vKVaOc1OT4uYYLVlaOffw=; b=er0kDIdFwBnfswml2sSOOTA4HNcZL0keyVqKpD
	KAgYVuiSPr+JuPCcuePafm8oPR/36Y2nVYAse+GSzR879RfUhzMocoeTbs7jOL3u
	tTZNFGEFwLBCWjN0ij1Dl7z+3gbCi9uCzKjkXMpT8UGDKMPxq8HdqpYMINAsxmqg
	1D9cCgo+FxHZamzfCz9KVKj/hL3U5rC5Zyvoxk/yLXO+p7JgvEP3o01uXoIoiZ0X
	CywM7YzDeu3oi7PfuKgy+i76DYbPQ534JZlPpbQmBTXnAxm2WN8sABOdcMkCYM7s
	36GN0VU2Ub4wltVunLRmztDO4ePHWPEB35tgzplKIfWhXpHQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyft0jy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN61mws030066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:48 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 22:01:47 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2 00/14] wifi: ath12k: Enable monitor ring for updating station dump in QCN9274
Date: Mon, 23 Dec 2024 11:31:18 +0530
Message-ID: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nNRrdA-7n2cIOBE1Ou31MTkHR_HsW-8E
X-Proofpoint-GUID: nNRrdA-7n2cIOBE1Ou31MTkHR_HsW-8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=639
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230051

This series enables the monitor related rings for the QCN9274 and
configures filters to collect statistics such as RSSI, which are
required for updating the station dump. Also, this series does
not impact WCN7850.

Depends-On:
	[PATCH 0/3] wifi: ath12k: Refactor monitor Rx handler
	https://lore.kernel.org/all/20241219001006.1036495-1-quic_periyasa@quicinc.com/

v2:
	- set rxmon_disable flag to true to disable monitor destination
	  ring in patch 3/14.

P Praneesh (14):
  wifi: ath12k: Add HTT source ring ID for monitor rings
  wifi: ath12k: Enable filter config for monitor destination ring
  wifi: ath12k: Avoid multiple times configuring monitor filter
  wifi: ath12k: Avoid code duplication in monitor ring processing
  wifi: ath12k: Restructure the code for monitor ring processing
  wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
  wifi: ath12k: Fix end offset bit definition in monitor ring descriptor
  wifi: ath12k: Add drop descriptor handling for monitor ring
  wifi: ath12k: Handle end reason for the monitor destination ring
  wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing
  wifi: ath12k: Handle PPDU spread across multiple buffers
  wifi: ath12k: Avoid memory leak while enabling statistics
  wifi: ath12k: Handle monitor drop TLVs scenario
  wifi: ath12k: Enable monitor ring mask for QCN9274

 drivers/net/wireless/ath/ath12k/core.h     |   1 +
 drivers/net/wireless/ath/ath12k/dp.h       |  55 +++-
 drivers/net/wireless/ath/ath12k/dp_mon.c   | 348 ++++++++-------------
 drivers/net/wireless/ath/ath12k/dp_mon.h   |   6 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c    |  79 ++++-
 drivers/net/wireless/ath/ath12k/hal_desc.h |   5 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h   |   4 +
 drivers/net/wireless/ath/ath12k/hw.c       |   8 +-
 drivers/net/wireless/ath/ath12k/mac.c      |  57 ++--
 9 files changed, 284 insertions(+), 279 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
prerequisite-patch-id: 5f5721a4c9f1c26659fd8f09a8eda648d8ecccf5
prerequisite-patch-id: 59cc2121e734e4e1e7e461a3ae24f3f1f9d0fa02
prerequisite-patch-id: fdc512e43ea7cb6c097ba4c0d9c661a74c0c2a6f
-- 
2.34.1


