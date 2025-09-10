Return-Path: <linux-wireless+bounces-27223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAAEB5200D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361753AD010
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0A31D362;
	Wed, 10 Sep 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TxVM9FM2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AB255F24
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528077; cv=none; b=IgLqJIKdBIkDudNHi1xSqiZpYdYscBLHvqgcEGWjizebSLjKcy0vKsV9u7tVKJDJOsNmZkS3sTouz/PhotqhooWjHZnBnVZMYXWnnLw+aOsJolS3dDGGipxieTKasrzohhW1gnB/FV6ed407zWZDI8uxZmDmMJGLiLwRyloLlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528077; c=relaxed/simple;
	bh=ApflV7HZe2ULh0AI6+if+T5ta7YrINas0ZlhRnyorDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvxFzzL4JuENmSYN83OCUllmsLJnDgUa7HRaODA1n9nVGjilWSqH7PJT4wn09t2ejiz9gRh+qGfzPL2XMWTaCqgFZjwJOA55dPh1H8rkvV/szFpmoGhHkIj7ygI/OwoRYT4tlCt9lfxHAsCMLjO/f7r04pdpZF3kOnxigE3W+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TxVM9FM2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGEo6g017247;
	Wed, 10 Sep 2025 18:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hJVMXluzV5jrKEAvFYeLHK
	tyJf0CmW5bI4+IXkxNtdQ=; b=TxVM9FM2ECN4NrzaLXnCFut4SCUPCZUOd3Qft1
	3/iONrp5wMZO5UUuBgVWt5eOnlv9k4mpRpkF2ucanXN6VTWxswm52INJiuDal1Hz
	2NVoC749MuT8SSC8L1Urz+vt+s0L/M5Jm9UZKifIttzsby1Jv34n7H848+DUXHHO
	XrxOPSd1wG1YpfPA5f6QPuOrRp2iuJomk1px4DI5DfIzBP3lVLrPjK8bpKOZ291+
	O9IDWbJnbzGsnaNviaKyfcmDH8nl2Ayv7XGunevZGxyKhwwnNj8bGiQCRsOAG99C
	aVnjVacpK23X0atb/KE03lZeJERESfse0zfhOh3vj5BklplQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493cpb0cbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:14:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58AIEUSj032703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:14:30 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 10 Sep 2025 11:14:29 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v2 0/8] wifi: ath12k: Improve hal APIs usage in rx path
Date: Wed, 10 Sep 2025 23:44:06 +0530
Message-ID: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE1MCBTYWx0ZWRfX/NqEzjZcu4gK
 i5chEmB7BpNXhx09dc/ezFT1LVOHSWHs8uJnLITRzHmPpTyvu8ZP0ZQYBMhXHtmOzAW0hq5qk8l
 qI8pmWQowITxuHxTAY67/qzj4FaApOxp8wNGhke6h5CJuXW5yOn2wxgsqADNmUc8AzBlVnuTv96
 HNnnfjYfSeXUAy6caCsPCPAW5Pavia47gJRYvLUGtmdxxAf1l5H+nlf+dB53zmau/S6Mbc/VhNc
 TXI2ADZjHqqjxjXznFuKN+xNRFmLXsC8P+qzTVaubdxUSQmzn+rI6xluq/Og7I3oooqMzteghF8
 rZpecR9t9TIjRkuQaHNFDWkc8xcAhxor+yYj4bgs6eHylrGD5y+T71eabHtNnG5iKTve03+jOfO
 bqJUaM3A
X-Proofpoint-ORIG-GUID: CIf0pcdqt6O6Zra6xk4TfvvqZKASYkVW
X-Proofpoint-GUID: CIf0pcdqt6O6Zra6xk4TfvvqZKASYkVW
X-Authority-Analysis: v=2.4 cv=P4k6hjAu c=1 sm=1 tr=0 ts=68c1c007 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=rgJ7dQ7m1Pf861PDhsMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100150

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
Changes in v2:
     - Update commit messages in patch 1/8 and 7/8
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


