Return-Path: <linux-wireless+bounces-16667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3CB9F9E3B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8797716ACED
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 04:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9622C2FB;
	Sat, 21 Dec 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BisA7/zH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEA1B07AE
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734755467; cv=none; b=HBBRo41p3wHUhPlLtD992nJ35e3VDiQEiYGII07x28n4G6uZZBc7hsRO7xorUBwIGQEWHSXBYIqtEvwwKQItchonpPtqDv5X1RlBjPNBe7uVAb3V1zQ4QGbtC4fLnB3SZgHiJmSxUVca+ThgeElTdYTKZ0K0CmAKsNhGOliyj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734755467; c=relaxed/simple;
	bh=X5TOm+cdoYfBGXnIvNAmmkeUX4+VRUsSKymrIKYDa9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sww57qcxELXVUVwSui8UhR1Jt+xHG7B0Jrw8dn2nBTYn28JlifeZvkCAMQ9pKHQPn/gv0No1enUysh5MvxDxhnZcF20zANvJr3Cx9/PB6EfsMGKcFPZvkbIOs8HKXSNPPvA4N75M552Me6FHW7dm5bamKBsEwxI9bidiIDXIeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BisA7/zH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL2A6pW000422;
	Sat, 21 Dec 2024 04:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/SAQ866Iuwg43VSP1tuKke
	k5l1mj0sd2fx/CEkXcpnU=; b=BisA7/zHZQ5h3SDNlRdxV9+DbR9IjDXUjRZium
	wP1q70qJqAXRzSWSMuqzDCvFM23RZ8YUnFzcE7dGf7Z4aICGSsTLoc8o/nv8Zfh0
	eMqagIFIRZEEOuOgB0FZGVkDHnjI8/TjUJgWqAmNebUiV3gYL1zPWyp6yCl4M716
	xjvJlPx3F6z3Z5cCbb581xT0q05hm8AaLc37gNkksyO7tjk2spbF6TetY1B9d4Dt
	EO6HH37F9IGiypHV36viqQEa5P2kWHskhoStlALgAkllICFfUKkH7nJUm6egaf2i
	rZxcENRMAUuOJZszBKBK7b8asT6gks9uB84+2tqhRUaX+z+Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43nmmqg9k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:30:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL4UonZ007957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:30:50 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 20:30:49 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 00/14] wifi: ath12k: Enable monitor ring for updating station dump in QCN9274
Date: Sat, 21 Dec 2024 10:00:00 +0530
Message-ID: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nNYZ1lmTL--dhcTml1O3DpEWrufB9C7E
X-Proofpoint-ORIG-GUID: nNYZ1lmTL--dhcTml1O3DpEWrufB9C7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=554 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210035

This series enables the monitor related rings for the QCN9274 and
configures filters to collect statistics such as RSSI, which are
required for updating the station dump. Also, this series does
not impact WCN7850.

Depends-On:
	[PATCH 0/3] wifi: ath12k: Refactor monitor Rx handler
	https://lore.kernel.org/all/20241219001006.1036495-1-quic_periyasa@quicinc.com/

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
 drivers/net/wireless/ath/ath12k/mac.c      |  55 ++--
 9 files changed, 282 insertions(+), 279 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
prerequisite-patch-id: 5f5721a4c9f1c26659fd8f09a8eda648d8ecccf5
prerequisite-patch-id: 59cc2121e734e4e1e7e461a3ae24f3f1f9d0fa02
prerequisite-patch-id: fdc512e43ea7cb6c097ba4c0d9c661a74c0c2a6f
-- 
2.34.1


