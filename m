Return-Path: <linux-wireless+bounces-28492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F92C2B4AA
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC6F4EE790
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4C2ED84A;
	Mon,  3 Nov 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nkJ3cjYe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694532E8B6C
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168901; cv=none; b=PSS5Bp5c3GVnTc21t2Gq+XZktx/uMd2+vCuDypBWt5y3ZPwTay4TEKIDG4r2FbLEOU87A8cTGZQMVnzHrNJzVh0MxEiMSgVVFLTdWC7HMZ43hx2rbADid5b7hjRNqhHQu1cuksQHnjnEGNLcCl7EBHlA3rAdknyem0h853XXVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168901; c=relaxed/simple;
	bh=GNO2fs3EDRRrSlKeD/bqQQZ+dPh5VDhm85zKd1VfE5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=doyVFtMAxhXso9mg3TZryq91BuQlnxeDjy9HRIJ7AIO4y46UannQM1KyR9WHWehivlrB7/jeeGg/piknom7NFS8GrJg5UtvTPDrflC5PKxXWEbR4/B+tE7SRCF+0o0xfgQRdAqc5KTfGYGx+5TQZmibs93MQ3/u+TS713hKTYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nkJ3cjYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38xgIQ1046162;
	Mon, 3 Nov 2025 11:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3FqmSusuwmKQMJ3++Y7C01
	LO/L3CXcKxkPAzseleGk4=; b=nkJ3cjYeAKt2eEgesI7x9JCVJtysU3I0P/4sSP
	UFDax9e6+CNdgLtKSPmiSmEIBiqa7OxZpy+6yv6409pDa51mQNx3YcvW32k06n2L
	LaLG6qVJOt4PBlE5VsBjzj60KTjOd5QN1M/LajVvaV1wfnJn9uNvu6PjUkpKVaVk
	FKx2WcjuxSfssxt0n4dC8DdKQgKBr7YgW6ctLzZpYNvasQac472TEWDQ8IBToRak
	5x41OWghtNOYYgiEdjfuhHNEJFznXeTu6yhj/PFMhvHKhni9jNCrL6yrGWGe/b+7
	QyOEI+2gBi18QTUrM6dopnC3ArTgBhILfjgUaEH0uXLtwX6Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5bcm4bfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLZ82017867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:35 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:34 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 00/12] wifi: ath12k: Modularize Wi-Fi 7 components and refactor data path structures
Date: Mon, 3 Nov 2025 16:50:59 +0530
Message-ID: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMyBTYWx0ZWRfX4uP22+LyY/pk
 N42PHnxrZLH1sRR5s1u8o4sRMUedGRSteVawUXXQvwN2YWQlL5E7DyYgye/llFPJBT2yGiiBnR0
 kmJLV59oYtN/3fbeNuDV/aZs/LM1hTUlZnkD2YqEqjAk145w9mJTaF9k3Oo3H+3ac1YAHvCRHsB
 sQHO4gH9fWFMLsGE5eFdQE948FUQbaZ/NajU0mrV0ALVgH+0VCzdJ1hGvjBCIpsCmEjiyj/uhXH
 Q+koz63J4d3tCi6+xyzWeKmWKmH5srgO6YwI8kmArWG85fdjr4Lt7mEYn6tr+CX3lfAn0hDvM8X
 UJjams+S15oLn1OBuYKoaSbiT5fT6qFe+r2xejBfQCQDdxZUFjUOmlkkONjY9lnbGPtEEctQtiw
 szC2V1BOM1ZP5T6HehW65vjecFvF9g==
X-Authority-Analysis: v=2.4 cv=EszfbCcA c=1 sm=1 tr=0 ts=69089040 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HZCR_3gHG9tIfSccJ0UA:9
X-Proofpoint-GUID: Cqy8cAEVPMwgxSwmSwSgGN9MMKfrPzH8
X-Proofpoint-ORIG-GUID: Cqy8cAEVPMwgxSwmSwSgGN9MMKfrPzH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030103

This patch series introduces a comprehensive set of changes aimed at enhancing
the modularity and maintainability of the ath12k driver, in the context of
Wi-Fi 7 support. The key updates include:

* Callback Integration for Wi-Fi 7 RX APIs:

   Introduces callbacks in arch_ops for RX-related APIs defined in the Wi-Fi 7
   module. Adds wrapper functions to invoke these callbacks from the common
   code. Enables seamless interaction between ath12k.ko and ath12k_wifi7.ko by
   leveraging the ops mechanism.

* Data Path Modularization:

   Macro Refactoring: Moves shared macro definitions from dp.h to cmn_defs.h to
   improve code organization.

   Device Stats Consolidation: Relocates device stats from ath12k_base to
   ath12k_dp, centralizing all SOC-level stats within the data path module.

   Peer Stats Modularization: Relocates data path stats from ath12_link_sta to
   ath12k_dp_link_peer, aligning with the modular peer architecture and
   improving maintainability.

* Wi-Fi 7 Specific File Reorganization:

   Moves the following files to be built as part of ath12k_wifi7.ko:

   wifi7/hal_tx.c
   wifi7/hal_rx.c
   wifi7/dp_rx.c
   wifi7/dp_tx.c
   wifi7/dp.c
   wifi7/hal.c
   wifi7/hal_qcn9274.c
   wifi7/hal_wcn7850.c

   Adds necessary symbol exports to support this modularization.

* Optimization in Data Path:

  Refactors TX and RX data paths to utilize DP-specific objects, reducing
  pointer indirection and enhancing cache efficiency. Removes Wi-Fi 7-specific
  headers from common code, with exceptions for dp_mon.c which will be addressed
  in a subsequent patch series.

These changes collectively improve the modular structure of the driver
by separating common and architecture specific modules and further optimize
performance-critical paths.
---
Harsh Kumar Bijlani (1):
  wifi: ath12k: Move DP specific link stats to DP link peer

Pavankumar Nandeshwar (9):
  wifi: ath12k: Add callbacks in arch_ops for rx APIs
  wifi: ath12k: Move DP device stats to ath12k_dp
  wifi: ath12k: Add helper to free DP link peer
  wifi: ath12k: Remove the wifi7 header inclusions in common code
  wifi: ath12k: Move ath12k_dp_rx_frags_cleanup API to Wi-Fi 7
  wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
  wifi: ath12k: Remove arch-specific HAL dependencies from common DP
  wifi: ath12k: Build all the files in wifi7 directory into
    ath12k_wifi7.ko
  wifi: ath12k: Use dp objects in performance critical paths

Ripan Deuri (2):
  wifi: ath12k: Move ieee80211_ops callback to the arch specific module
  wifi: ath12k: Replace lock/unlock with guard()

 drivers/net/wireless/ath/ath12k/Makefile      |   9 -
 drivers/net/wireless/ath/ath12k/ahb.c         |   1 -
 drivers/net/wireless/ath/ath12k/core.c        |   3 +-
 drivers/net/wireless/ath/ath12k/core.h        |  86 -----
 drivers/net/wireless/ath/ath12k/debug.c       |   4 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c |  59 ++-
 drivers/net/wireless/ath/ath12k/dp.c          |  35 +-
 drivers/net/wireless/ath/ath12k/dp.h          | 143 ++++++-
 drivers/net/wireless/ath/ath12k/dp_cmn.h      |  12 +
 drivers/net/wireless/ath/ath12k/dp_htt.c      |  64 ++--
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 102 +++--
 drivers/net/wireless/ath/ath12k/dp_mon.h      |   2 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c     |  69 +++-
 drivers/net/wireless/ath/ath12k/dp_peer.h     |  57 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 146 +++----
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  53 +--
 drivers/net/wireless/ath/ath12k/dp_tx.c       |  33 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h       |   5 +-
 drivers/net/wireless/ath/ath12k/hal.c         |  26 ++
 drivers/net/wireless/ath/ath12k/hal.h         |  75 +++-
 drivers/net/wireless/ath/ath12k/mac.c         | 357 ++++--------------
 drivers/net/wireless/ath/ath12k/mac.h         |  15 +-
 drivers/net/wireless/ath/ath12k/peer.c        |   4 +-
 .../net/wireless/ath/ath12k/wifi7/Makefile    |  10 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  80 ++--
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 266 +++++++------
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  20 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 158 ++++----
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   |   2 +-
 .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |  50 ---
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |   3 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  35 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |  22 +-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    | 208 +++++++++-
 37 files changed, 1234 insertions(+), 988 deletions(-)


base-commit: 6633dca572d8f599b0a1ead0f145a52049ec7709
-- 
2.34.1


