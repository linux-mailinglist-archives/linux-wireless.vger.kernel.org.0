Return-Path: <linux-wireless+bounces-26813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5832EB3A83D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4743166F27
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C79338F45;
	Thu, 28 Aug 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QHRppqoi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BF322C78
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402579; cv=none; b=oVXqQFkmB/QyofavRfHMShE6XShxSI0SPO9mwJhVcKJS0TzbNHQPUQ5DGG/myaLwVgdL6/GYWINz+YFVS/ryuOnPHc5Ss+uXirHJewNowIqMaVzlSjZ2gVEvCsRAaxuR3j+2iWIC1fmD0h7ZqYvLZiccMk0RuC3buJzofCX30ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402579; c=relaxed/simple;
	bh=mo9+HUFCEt/mIXAJPMpgmT7CitfJNi5NyTspQiN6WeQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+XALV5pzHd3FGr05EEABfqXCVkyUEOe1ETlsMEVUNRMCzzrXzoHsAuhEAyB+/jFpBc2+H2BieK2vyhWkOlc4Lrj8tK0mXjbN6g9/rvXekcIDU1m/PtdNf1z92eYfRPN27Fv3MaYz2dcb6Do1JnyYUhUVB4HTqV9Vxz2TgnuYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QHRppqoi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDt4lH014780;
	Thu, 28 Aug 2025 17:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=60zZXsREg4tKp6jScus3Kn
	JlQUy2Xkdbuj23g5peQS8=; b=QHRppqoioauYdO0gw3sx5wTRFi04cjMXQwNJqt
	A/OHuXMR0UkOIqhNt+GskXL8ddkVKxqJZ1fLnxAGeSscTBFUdju5sbcQumUGls/c
	qea/Gji5TBEzwFBx44lXI/jm4JOc+XpSudXbGi5SUg+b3nPG/aUH0xh4iRsM37hE
	P3T5ewgV93sxnf+mJfQkkHqcDR/dfo+EW3bobToxV1qFdrkhiu+ljT2vqDUKKltl
	LnaQkNQgQ5T7lnS1sz4y6VVk67qsTjmIDV7Cd5QpwKy4Wtg+3N0wW4V/NgWqF27k
	Z37DnYJWmels8xA5ja1cgN5q2Dl7th6xUv3QBN4xwZO7dBUg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we8uqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHa9W3008905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:09 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:08 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 00/20] wifi: ath12k: ath12k file re-organization
Date: Thu, 28 Aug 2025 23:05:33 +0530
Message-ID: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: MtOvjqcd_bYfhk8P_KRmBwyPcEMHK_ik
X-Proofpoint-ORIG-GUID: MtOvjqcd_bYfhk8P_KRmBwyPcEMHK_ik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX/GpVaHrHq7J6
 8d8ypgEYzYFW4veBIuZ1u4oZebMlgOR1PwHyl8OcUPQP7zNv81qdtikI9/Y+b/ZLDlnUEVQmMSB
 p7/NvQ1bjgASYZTUMNRpkUsBV1u18oyddj7ZMmOS8mGJ4cLeZnTLRuvoObu7nE8aQoBNuI6nCzm
 6l1CISkr//GDwxiLjfav+zCO28ouHgcJ3rNNaJaMZEh6RfQgF6/yK0yMXWFNYLVnc4NT06LurpJ
 pTD+/TMFVTDpBQPczmhUtoRiOqGhVSDPe6Fa37fzxDE5aO51PbRgoYK0jqnf1aGz/WQ5Ja6iLgq
 WRlA1hhX66qOqmcOwzn0DGqCE6RZU9WYyvyYW7+urS93pq+3KwNAv7bQJr8yZPH0V7NfHxozXwf
 ++FsYbN7
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b0938a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=j3GBNpuh4D3sRHNEf8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

This patch series continues the modularization work described in the
https://lore.kernel.org/linux-wireless/20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com
("wifi: ath12k: Ath12k modularization changes") series, which established
the foundation for the Next Generation (NG) ath12k driver framework.
That series introduced the foundational split of the original ath12k.ko
into two distinct modules: a common module (ath12k.ko) and an architecture-
specific module (ath12k_wifi7.ko) for Wi-Fi 7 devices as depicted below.

                                     +-----------------+
                                     |                 |
                                     |   ath12k.ko     |
                                     |    (common)     |
   +---------------+                 |                 |
   |               |                 +-----------------+
   |   ath12k.ko   |  ===========>
   |               |                 +------------------+
   +---------------+                 |                  |
                                     | ath12k_wifi7.ko  |
                                     | (wifi7 family)   |
                                     |                  |
                                     +------------------+

Building on that framework, this series focuses on modularizing the Data Path
(DP) of the ath12k driver, allowing the common DP to be reused across different
hardware architectures.

The patches included here support the NG framework objective by reorganizing
DP-specific files and the directory structure as outlined below.

Existing file org             New file org
-----------------             ------------
├── dp.c                  ├── dp.c
├── dp.h                  ├── dp.h
├── dp_rx.c               ├── dp_htt.c
├── dp_rx.h               ├── dp_htt.h
├── dp_tx.c               ├── dp_rx.c
├── dp_tx.h               ├── dp_rx.h
├── hal.c                 ├── dp_tx.c
├── hal_desc.h            ├── dp_tx.h
├── hal.h                 ├── hal.c
├── hal_rx.c              ├── hal.h
├── hal_rx.h              ├── wifi7
├── hal_tx.c              │   ├── dp.c
├── hal_tx.h              │   ├── dp_rx.c
                          │   ├── dp_rx.h
                          │   ├── dp_tx.c
                          │   ├── dp_tx.h
                          │   ├── hal_desc.h
                          │   ├── hal_qcn9274.c
                          │   ├── hal_qcn9274.h
                          │   ├── hal_rx.c
                          │   ├── hal_rx.h
                          │   ├── hal_tx.c
                          │   ├── hal_tx.h
                          │   ├── hal_wcn7850.c
                          │   ├── hal_wcn7850.h
                          │   ├── rx_desc.h


Note: While common files are not intended to include architecture-specific
headers, a few Wi-Fi 7 headers are temporarily included in common files
across patches to simplify patch splitting. This will be resolved in a
later series.

---
Harsh Kumar Bijlani (4):
  wifi: ath12k: Move HTT code in dp.h to newly introduced files
  wifi: ath12k: Move HTT Rx specific code to newly introduced files
  wifi: ath12k: Move HTT Tx specific code to newly introduced files
  wifi: ath12k: Move HTT specific code from dp.c to newly introduced
    files

Pavankumar Nandeshwar (16):
  wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
  wifi: ath12k: Move hal_tx.h file to wifi7 directory
  wifi: ath12k: Move hal_rx.h file to wifi7 directory
  wifi: ath12k: Move HAL Rx wrapper APIs to dp_rx.h
  wifi: ath12k: Move Rx error related functions to wifi7 directory
  wifi: ath12k: Move hal_desc.h file to wifi7 directory
  wifi: ath12k: Move rx_desc.h file to wifi7 directory
  wifi: ath12k: Move rxdma ring config functions to wifi7 directory
  wifi: ath12k: Move rx error and defrag functions to wifi7 directory
  wifi: ath12k: Move regular msdu processing functions to wifi7
    directory
  wifi: ath12k: Move srng processing to wifi7 directory
  wifi: ath12k: Separate arch specific part of RX APIs
  wifi: ath12k: Move arch specific REO functions to wifi7 directory
  wifi: ath12k: Move arch specific rx tid and related functions to wifi7
    directory
  wifi: ath12k: Move arch specific tx APIs to wifi7 directory
  wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory

 drivers/net/wireless/ath/ath12k/Makefile      |    9 +-
 drivers/net/wireless/ath/ath12k/ahb.c         |    3 +-
 drivers/net/wireless/ath/ath12k/core.h        |    4 +-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |    4 +-
 drivers/net/wireless/ath/ath12k/dp.c          |  159 +-
 drivers/net/wireless/ath/ath12k/dp.h          | 1518 +-------
 drivers/net/wireless/ath/ath12k/dp_htt.c      | 1354 ++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h      | 1546 +++++++++
 drivers/net/wireless/ath/ath12k/dp_mon.c      |    4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 3056 +----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  297 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c       | 1609 +--------
 drivers/net/wireless/ath/ath12k/dp_tx.h       |   41 +-
 drivers/net/wireless/ath/ath12k/hal.c         |    8 +-
 drivers/net/wireless/ath/ath12k/hal.h         |  501 ++-
 drivers/net/wireless/ath/ath12k/mac.c         |    3 +-
 drivers/net/wireless/ath/ath12k/pci.c         |    3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  137 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   15 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 2043 +++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   47 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  908 +++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   14 +
 .../ath/ath12k/{ => wifi7}/hal_desc.h         |  149 +-
 .../wireless/ath/ath12k/{ => wifi7}/hal_rx.c  |    8 +-
 .../wireless/ath/ath12k/{ => wifi7}/hal_rx.h  |  299 +-
 .../ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} |   48 +-
 .../wireless/ath/ath12k/{ => wifi7}/hal_tx.c  |    6 +-
 .../wireless/ath/ath12k/{ => wifi7}/hal_tx.h  |   11 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |    4 +-
 30 files changed, 6993 insertions(+), 6815 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h (95%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c (99%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h (83%)
 rename drivers/net/wireless/ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} (97%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c (97%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h (96%)


base-commit: 0e487f03c6e5d8dd5b076b8b061e50e736ab2196
-- 
2.34.1


