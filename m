Return-Path: <linux-wireless+bounces-27100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39908B49535
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EC31899031
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8C2F7AA9;
	Mon,  8 Sep 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cGwOF3M5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C722256F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348907; cv=none; b=km2x0Wrbba483//G7U9lrDe7SqvrAtmfmT9oIj3iVEaB6+qXfccWp5TosjbAEYHadAoMfoXq6c2FD7oDdrdlMRPIN+eOZQ2mf2yUcAdzI/WzPUNYhDaEtjh2fXY4zOISP9e2FytjGARG4lhnTclvA/bBOXnb2o4SMrJuclFY/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348907; c=relaxed/simple;
	bh=gzqYdjUasSzhZ5t9Aa8dDpAFvupBN/0Kc5DeXCAtbHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MPaIDLXXyJ4NlngsT7ab+rbad6Te+kXa3oTYi8wcJnhH2O23ydcE4z8aiNomRVbfNqk35n7uWtMoq33BstfLmvSjfcuhX71Pw6z49kFf3Mmgc7IFCCBSX7HPO//5tpmig82sTlbdZ8hWdnIHrDbEfYdc1ECH/DFGaL2VK0BUvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cGwOF3M5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GICTi022845;
	Mon, 8 Sep 2025 16:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UIyZecrc9q1u+B01XKRPD2
	3/KXVZAKIngYp1w7xP5G4=; b=cGwOF3M5+CzDSolVsKjP/PbuT1jrfPb0DCwpCi
	bz/FM5OpGjDZ1VmPaWLF1tvS0U0+bk//Zs5Zg2mgVJkBJgxN43/P5u6ENTwDIE4G
	p/KuUJl38ew9h4DcjJ83nBmBytBxoLF4R1+vsGgvUSFUvDtltN/dtL2Dd5faLUma
	5e9gpnZZNTwRf2VMgK/t1F4IJhwDILmhQGrc24pNcpJZQoe858pAfG3JoRy47SMC
	ac/L9XfzFJzfKEOfgOiM3MwVyikJn911LtE+iEkIrNOUhXXOT3ze0zZktBkdVNDJ
	4+xSumImBk+UWecbN/YMY2M1qJrx1ink/OFdlgdU3BRbheaw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j5ct6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:28:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588GSKmI019892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 16:28:20 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 09:28:18 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 0/8] wifi: ath12k: Improve hal APIs usage in rx path
Date: Mon, 8 Sep 2025 21:57:49 +0530
Message-ID: <20250908162757.2938849-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX8KBBPL8IsPpt
 ZSyO7307llyv2YCZaUA5WRMrVhuBuyE5OetHMwRzD+cAxstcnDUBrqTyxAJl1MOeWVNIpSVMMin
 LPaMDssrkxgZC2QLGlTGbBawsXTz5IruowX4tMVdulkdflwNpbdZ6uqX1Q1dyfOeM3GfngL0Fbf
 +BVtW6M8C5rSoy81ur3SxTmpaj/ebAM6SefceQKPkOgFU+TUj6JnFl0DVwSyCtrsXsVuCG1jJN0
 B99NgZCsMZBbH8LhriXFVL63FqPpyvFBhgS7XV2gpW+xjtM7x/pigKuaFFaHgA10L5eTkcqAg44
 XQDbvWkAra53Z5hArSLKBlVZ8tRk+VF2oG1QHLEgRMmjcTPjD1ublIpDiJIdK7hCaxYTNY7jrbt
 bMfCxv+U
X-Proofpoint-ORIG-GUID: WFgAu491kHbgf2FY-TE2UDotPlxOGlXA
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bf0425 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=rgJ7dQ7m1Pf861PDhsMA:9
X-Proofpoint-GUID: WFgAu491kHbgf2FY-TE2UDotPlxOGlXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

The existing usage of rx_ops to reach the hal_apis at multiple places uses
function pointer indirections. In order to avoid such multiple function
pointer indirection, extract the required hal parameters in the rx path
right at the beginning and store them in a structure which is then
leveraged by the rest of the rx path.

Move remaining rx_ops APIs to hal_ops to simplify hal API usage.

Also, make compact tlvs as default mode and remove the non-compact tlvs
as they are unused. Since there is no need to maintain multiple versions
of tlv extraction APIs, move the rx_ops callbacks to hal_ops.

----

Pavankumar Nandeshwar (5):
  wifi: ath12k: Remove non-compact TLV support from QCN
  wifi: ath12k: Replace ops with direct calls for rxdma ring mask
  wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
  wifi: ath12k: Add new infra for the rx path
  wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx

Ripan Deuri (3):
  wifi: ath12k: Move the hal APIs to hardware specific files
  wifi: ath12k: unify HAL ops naming across chips
  wifi: ath12k: Remove hal_rx_ops and merge into hal_ops

 drivers/net/wireless/ath/ath12k/Makefile      |    4 +-
 drivers/net/wireless/ath/ath12k/ahb.c         |    2 +-
 drivers/net/wireless/ath/ath12k/core.c        |    2 +-
 drivers/net/wireless/ath/ath12k/core.h        |    2 -
 drivers/net/wireless/ath/ath12k/dbring.c      |    5 +-
 drivers/net/wireless/ath/ath12k/dp.c          |   31 +-
 drivers/net/wireless/ath/ath12k/dp.h          |    1 -
 drivers/net/wireless/ath/ath12k/dp_mon.c      |   36 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  128 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  204 +---
 drivers/net/wireless/ath/ath12k/hal.c         | 1048 +----------------
 drivers/net/wireless/ath/ath12k/hal.h         |  106 +-
 drivers/net/wireless/ath/ath12k/mac.c         |    6 +-
 drivers/net/wireless/ath/ath12k/pci.c         |    2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   19 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.h    |    5 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  501 ++++----
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   74 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |   49 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |    8 +-
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  369 ++++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   35 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  161 +--
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   82 +-
 .../wireless/ath/ath12k/wifi7/hal_rx_desc.h   |    7 -
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   13 +-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   18 +-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  364 ++++++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |   32 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.c   |    2 -
 30 files changed, 1452 insertions(+), 1864 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h


base-commit: d637c58a29475d646f8decfbbc1d27fae999a449
-- 
2.34.1


