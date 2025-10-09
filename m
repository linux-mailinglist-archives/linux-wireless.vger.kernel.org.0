Return-Path: <linux-wireless+bounces-27899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8600BC8B44
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723DF4E2DEB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51CB2DE715;
	Thu,  9 Oct 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V1SDFZ/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543C19E967
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008269; cv=none; b=Gdp21crmSRLI7CIpW/jW58x9No6Of4KQ4Z5hdu+WGhgFfkaEPbOVahYP24YEfmPgje+ZQ7POH3a4eDrdG34eWVcGZyh+j+PdDA0xBCNLTgRw7U0oSzJi8NzGhCZeJg+TMD5UbwMtZrGZ2baJ3cAWHywR9vzs20HxLOxUkpK2Ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008269; c=relaxed/simple;
	bh=6Yi3OKWrxBT4fd1qdCKT/WeGxi1khfbl+gqup/1oV7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IqyZWO8sfqGTS/bcbX6Nn3ybEHAtvowuzkYn75tMaHmRlfzCuojfpOChjq7+oI+6RbTcsAbNgGO/5kGhfxiFLtbbYHQgzjDhmX3lRB2729UI2Rj4FbONUCW2u3+0QZTYyrcE9O1fmE4jSXbA1VSMTYRE/MPWuDhnBct8xnmikjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V1SDFZ/q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EHU0028481;
	Thu, 9 Oct 2025 11:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tLCiPtJEDc89OHfySc8+X1
	cEftpfYpCKYHDmJJLHH4I=; b=V1SDFZ/qVI1qdmCniTh/+cB9GMAUKMUzBFbX3g
	yGfPzYZMDAOXXD8vypPKSw043z2/QN2fM9fpc01NlMmdqeVOxoTgoAQeSKyV5yMT
	16kJH86umCciNokJoK1XAi+fN6BZD4Hxzd7Poo758ItwsRfBlURTOtuVUDDYve7B
	dfcMK0TePv58O+/hUicJ5ku6Wm3u03cShyFiQ3qbL2N/vJlffVcF3QXclPQ2Ly5/
	1ndiRfAfL9XpoWqxYP53jF/WpfAuWbBQ8QcduBf3YutY2r8vMZ9OIacQeoz4XMAz
	YG9EjJt6Uxq6P5KhtFvzTLm/PxzijBoOG0bUsjuASQIBOq/g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ktgc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BB1H7008173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:01 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:10:59 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 00/18] wifi: ath12k: HAL changes for Next Generation Driver
Date: Thu, 9 Oct 2025 16:40:27 +0530
Message-ID: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwCvcQrC1A/ON
 h2BiGtQG8fkpYUQcPcLxD+9fDQOQxUwsIBXx5Qw/Nne8xe2WExPQ9el5M0ScRKPRh4RZfcl7b8L
 pj0fkzVh3bSi3b3cRLBPOV/HKdCk7nt9HPgAoG/w38XaZ/16+1Q3MxIBdn4jIdRQ6XmxY8F3w4O
 IZJ59/EcynKOY6YBQKkgWr4i1Etkn+g2vSyxAziI6e4QWMLHA6c/PmDPPICbv4T/1ZbuBJcNbaX
 49+iPrBua1ASA+sw+5lpcT0H0maFaD0rPGOZxYyRzsdNMilbpVKWhLmd5moVH4o2t5m9JCwettw
 TUqxqrAx6fj8bLAaassvpMutM7V5RqGGo4+fgEVBYinBEZuwyLMFh6cBkNZLACINDjqdOB4Se7D
 I5XpBodMsYnCp6obgCxxPoA0bWJpvQ==
X-Proofpoint-GUID: _WUCp2BpVAQNgTpyJrvwZnhFZgvzJY4B
X-Proofpoint-ORIG-GUID: _WUCp2BpVAQNgTpyJrvwZnhFZgvzJY4B
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e79845 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=kC_oOdxAx1Sgq7Ku93UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

The primary objective of this set is to modify the HAL layer
to suit the multi-KO model. The HAL APIs will be implemented
differently as required by different chipsets and these
implementations will be abstracted using an ops mechanism
(by registering function pointer callbacks). The hw specific
implementations will be registered as callbacks in the hal_ops.

			common hal API
				|
				|
				|
				|
	=============================================
			     hal_ops
	=============================================
	 _______________              _______________
	|       |       |            |       |       |
	|       |       |            |       |       |
	| qcn   | wcn   |            | qcn   | wcn   |
	| device| device|            | device| device|
	|_______|_______|            |_______|_______|

	  ath12k_wifi7.ko             ath12k_wifi8.ko

Also, the hal structures that are specific to HW (wifi7) are
kept within hal headers in wifi7 directory and the structures
that are common are placed in the headers present in the ath12k
directory.
---
Pavankumar Nandeshwar (16):
  wifi: ath12k: Move srng config and hal_ops to hw specific hal files
  wifi: ath12k: Initialize desc_size through hal_init
  wifi: ath12k: Initialize hal_ops through hal_init
  wifi: ath12k: Move wbm_rbm_map to hw specific hal files
  wifi: ath12k: Move hal_params and regs to hal from hw
  wifi: ath12k: Add direct HAL pointer in ath12k_dp
  wifi: ath12k: Use hal handle instead of ab handle
  wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7
    directory
  wifi: ath12k: Move HAL SRNG shadow config and get ring id APIs to
    wifi7 directory
  wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
  wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7
    directory
  wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to
    wifi7 directory
  wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
  wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7
    directory
  wifi: ath12k: Segregate the common and wifi7 specific structures
  wifi: ath12k: Remove the unused ring inits in wcn

Ripan Deuri (2):
  wifi: ath12k: Rename hal_ops to ops
  wifi: ath12k: Drop hal_ prefix from hardware register names

 drivers/net/wireless/ath/ath12k/Makefile      |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c         |    4 +-
 drivers/net/wireless/ath/ath12k/ce.c          |   25 +-
 drivers/net/wireless/ath/ath12k/cmn_defs.h    |    1 +
 drivers/net/wireless/ath/ath12k/core.c        |    4 +-
 drivers/net/wireless/ath/ath12k/core.h        |    2 +-
 drivers/net/wireless/ath/ath12k/dbring.c      |    5 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |    2 +-
 drivers/net/wireless/ath/ath12k/dp.c          |  178 +--
 drivers/net/wireless/ath/ath12k/dp.h          |   17 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |    6 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h      |    1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c       |    7 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   17 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h       |    1 -
 drivers/net/wireless/ath/ath12k/hal.c         | 1114 ++---------------
 drivers/net/wireless/ath/ath12k/hal.h         |  804 ++++--------
 drivers/net/wireless/ath/ath12k/hw.h          |   92 +-
 drivers/net/wireless/ath/ath12k/pci.c         |    2 +-
 drivers/net/wireless/ath/ath12k/pci.h         |   10 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |    3 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |    2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |    5 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |   54 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |    2 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   |  705 +++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   |  563 +++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |   80 --
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  661 ++++++++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   10 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   22 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   10 +
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   10 +-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |    7 +-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  439 +++++++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |    7 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  404 +-----
 drivers/net/wireless/ath/ath12k/wifi7/pci.c   |    1 +
 38 files changed, 2949 insertions(+), 2329 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.h


base-commit: c57176c0dad91a00bd20feb5f6dc4e8d575f4628
-- 
2.34.1


