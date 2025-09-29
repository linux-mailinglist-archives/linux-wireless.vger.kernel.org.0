Return-Path: <linux-wireless+bounces-27699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B7BA91F5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428B51881CF6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13EA2FC871;
	Mon, 29 Sep 2025 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E6rHFSJv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00571224893
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146684; cv=none; b=uEcdPHXjWTR2SNI5YRrlmUtqmPtWBVV3B62cpJ0RoMxBmke3oRVyzWDarxY4y5oCeUtRtNIW9CDOnp0++uWi/xwCggn6qlc5c/z150TULu8XmJlbn3zaK+uGWNqtx9IVm66n6rjgRfU17/t2X620bQa0QdWZfSDzs/7/WDULocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146684; c=relaxed/simple;
	bh=s4naWZl6RSd4+lUwN08okwduTpHCNnFtpMCqOFsWpfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkovTbo/TT+p7JEXrSIB543w7O+Usamo4bx+su3wRDYf8ezO50HJ+YR75TxMybZo6koPvXKH8UyKWhfHww8Epqj9k6atjcnAdtm5Cv2vz7GmPOjw6tHOlcp2M+A+zqrDulfBbQCY1U2HJHhG0HRLvT6ijclbsmFMAvW8mS0Xkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E6rHFSJv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TA444k017780;
	Mon, 29 Sep 2025 11:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eYpFuXzYWTLqJDzv7SHe3H
	bdHd3pZubHW253JkkZ7iw=; b=E6rHFSJvqOFOm7JDZ7Avytwa9BgiPUhPEK2r7D
	EEolyYpCalXkarN9g+8LKTfeNdGLMzLVYCxECLLNe6RNbYLcbtrIRtZ20JFUPVR+
	U1dIByNEk/7LK08qmeJL4v/MYz9E+OuUe4a81mBIb1nLa4hakgtc0dnBWCdcMATr
	ZIpBqF7AJjxqNy4T1bVSAyH+fUvk+VTO4UZ+wrXIubJDaUE6WWd4ge4wZiFzs/BE
	LKrIy9zael7IjRhg11Ig4KqunqgB4LeznIzQh6c1+YB+Z5/r6ZnXf2iO6tQSPAap
	4NpHVIJodDwehEbjt6jRl5rVdZD+8LBajslhM6ie+/zKFXEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tn2mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 11:51:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58TBpIl8008357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 11:51:18 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 29 Sep 2025 04:51:17 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v3 0/6] wifi: ath12k: Modularization of objects for Next Generation Driver
Date: Mon, 29 Sep 2025 17:20:56 +0530
Message-ID: <20250929115102.512719-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX5MwEkhVj33VF
 Rw2VRorbTxdDvl6HBfIsmXAed+X4KVfTf4k1aPtaXs7WrG8VqtFEADMrvKN0zI9yHn1d/iYF3X1
 qUiTg1gVwcXG6+0f4JZ+aKTAg6fHK1HPKdS2qO637FRHRDTa+mbBNQVp0XeJIu+aFvxtmDqlK/N
 yk/dTD5rd53w8QDu665P+XvGv+y0l3A5F1gsXO4u0za2pv561ka89sxyvWOJhEKEIhI98tK6A0r
 HL/U6EKUTdrHljEnwTupdlkKx4hqmuRSQ5sLuTsufm8ixzBZBO3ReBHdcmQHrE/IjT/4iJDSSqf
 +/WL501tXa121t5xRDbQ/yIp9zXbzAP733Uvm71BQG9aN0eUOIpo8OCPYyThob6ben8/9TunSKX
 6RAJ+VeNejtfc2EEnD2hTMTDNxsgiQ==
X-Proofpoint-GUID: Ii21EqGZPYqeRpOCcJj68Sr5gEzkHttj
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68da72b7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=ZmDZ8v0v9Rlbw9gN6qoA:9
X-Proofpoint-ORIG-GUID: Ii21EqGZPYqeRpOCcJj68Sr5gEzkHttj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

The primary purpose of the patches in this series is modularization of
object structures along with their allocation and initialization APIs.

Patches in this series are made to achieve the following:
1. Modularization of device object to have a separate DP object in order
   to support chipsets of different hardware architectures
2. Refactor hardware group and vif structures to optimize data
   path operations for future extensions
3. Add framework to support architecture specific interrupt handling and
   ieee80211_ops registration

These changes are intended to provide a base framework for the data path,
allowing the data path to remain flexible for future extensions in Next
Generation driver development.
---
Changes in v3:
     - Use dp arch ops to invoke arch specific service srng handler
Changes in v2:
     - Invoke ext irq setup/cleanup from dp device alloc/free to fix
     suspend and resume call trace for wcn7850 in patch 5/6
---
Harsh Kumar Bijlani (1):
  wifi: ath12k: Refactor ath12k_vif structure

Ripan Deuri (5):
  wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
  wifi: ath12k: Support arch-specific DP device allocation
  wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
  wifi: ath12k: Add framework for hardware specific ieee80211_ops
    registration
  wifi: ath12k: Add framework for hardware specific DP interrupt handler

 drivers/net/wireless/ath/ath12k/ahb.c         |  22 +-
 drivers/net/wireless/ath/ath12k/ahb.h         |   4 +-
 drivers/net/wireless/ath/ath12k/cmn_defs.h    |  19 +
 drivers/net/wireless/ath/ath12k/core.c        |  19 +-
 drivers/net/wireless/ath/ath12k/core.h        |  39 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c |   3 +-
 drivers/net/wireless/ath/ath12k/dp.c          | 143 +++++---
 drivers/net/wireless/ath/ath12k/dp.h          |  32 +-
 drivers/net/wireless/ath/ath12k/dp_cmn.h      |  50 +++
 drivers/net/wireless/ath/ath12k/dp_htt.c      |  22 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |  15 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  20 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 339 +++++++++---------
 drivers/net/wireless/ath/ath12k/mac.h         | 131 ++++++-
 drivers/net/wireless/ath/ath12k/pci.c         |  23 +-
 drivers/net/wireless/ath/ath12k/pci.h         |   4 +-
 drivers/net/wireless/ath/ath12k/peer.c        |   8 +-
 drivers/net/wireless/ath/ath12k/testmode.c    |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c   |   4 +
 drivers/net/wireless/ath/ath12k/wifi7/core.c  |  24 ++
 drivers/net/wireless/ath/ath12k/wifi7/core.h  |  11 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  40 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   9 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  88 +++--
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  29 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  62 ++++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c   |   4 +
 drivers/net/wireless/ath/ath12k/wmi.c         |   5 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |   5 +-
 drivers/net/wireless/ath/ath12k/wow.c         |   5 +-
 31 files changed, 845 insertions(+), 340 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h


base-commit: 972f34d54015a4a16aa9e6a081bafabb6f9bf95c
-- 
2.34.1


