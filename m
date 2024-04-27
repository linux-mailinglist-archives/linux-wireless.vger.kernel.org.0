Return-Path: <linux-wireless+bounces-6940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596018B4719
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817B41C20B2C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120021D688;
	Sat, 27 Apr 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B3WSxw1v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127511CD21
	for <linux-wireless@vger.kernel.org>; Sat, 27 Apr 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714235232; cv=none; b=sLelSsn86J8hNyldWCndERUGBMmZqCfoeQQCB+fqgrMXorX7WvvDtWT/aiYSXSe111R8WjpnwzJrG0dLUhLeHHU8yCsAcuMdIzVavQ8pgwRVxeUJ4JFUYatOUFDqPkFZnpgw2/l5Ykd4FYvE9wk9m+lElO0H3WE8CQ+pgcWEHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714235232; c=relaxed/simple;
	bh=a2WMb86Hs0x0UlmXaKdW4iaJSPfyX4G5EosACllCbQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=alcfFg0NEbrFL8qjWNo7lFoyZvAEfv8JJl3kFUMqp0XkC0861NegJ7cVtQuZBMVbuFtULsad7kRmoems4EmsURRvDCKMASP/U3IBqHTvO/ziKchecnxAe7mIEuIGIUZcYhBJqHkOA6cWckNH097jD7IwJy8aGFbDC+XrN4w1C9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B3WSxw1v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43RGQNIa029512;
	Sat, 27 Apr 2024 16:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=4ioZUz6
	4SAYmX1rfKc3OPl/bfAwK4ChG/nHj1J/WXA4=; b=B3WSxw1vxAiTVMckSci+9vZ
	DVh47Q3TJlx/GC+O0YFV1xndp7ldTO3YcjOsldU9QHV7Q25sHPb+EP/uiNpB/EnV
	Wa/oMoeKkzD2KbdeJAQr4gxlWoNAWsxMikwTpRMpXiGFxuvmCAmuuP8ZKsRA1Sit
	TBpOO88q7Gy2BIs4DP5zIsqrcmuy0X2mRNik5umczMQqE+yImLO9aiMvKRuG0ZFX
	CTSm6IIhYewS2xOrKoYdNfJOvrbpp6YI7rAkySrbbfDuNFCHBQI8zSmwI3bfJBmi
	AmiL9EQWHfl2Yuc3M/FGZndQRSf87igFvvB63AsFFwCw6473Z104f/g9vUMor3g=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrrpq0qva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:26:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43RGQukC013429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:26:57 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 27 Apr 2024 09:26:55 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv2 0/3] wifi: ath12k: Remove unsupported and unused ring configurations
Date: Sat, 27 Apr 2024 21:56:41 +0530
Message-ID: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
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
X-Proofpoint-GUID: ysHqXzGyjGOXNqRb1LAb9PwFEFpLjTAH
X-Proofpoint-ORIG-GUID: ysHqXzGyjGOXNqRb1LAb9PwFEFpLjTAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=745 adultscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404270120

Currently in driver doing memory allocation for tx_monitor,
tcl_cmd_ring and tcl_status ring. Here driver support for
tx_monitor mode is not there and memory for tcl_cmd and tcl_status
rings are allocated by firmware and it uses that memory instead of
host allocated. So avoid these unused ring setup configuration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Tamizh Chelvam Raja (3):
  wifi: ath12k: fix calling correct function for rx monitor mode
  wifi: ath12k: Remove unsupported tx monitor handling
  wifi: ath12k: Remove unused tcl_*_ring configuration

v2:
  * Rebased on top of ToT

 drivers/net/wireless/ath/ath12k/dp.c     | 16 -------
 drivers/net/wireless/ath/ath12k/dp.h     |  2 -
 drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ------------------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 44 +------------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
 6 files changed, 2 insertions(+), 157 deletions(-)


base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df
-- 
2.34.1


