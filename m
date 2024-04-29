Return-Path: <linux-wireless+bounces-6996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461CB8B603F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 19:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057971F217B0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6BA126F02;
	Mon, 29 Apr 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nDOxaLnj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D098627D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412319; cv=none; b=gLTP17WDC0vtcsxRbY+kfgwsE4n2yvSXJs40OiV6ohNtVAgkgp+Qpcuj679QoleHHkCcHzrllFpYXra8DEA9Tv8EC4bF/wKroq3MclzJy+KARJi5uh8jOUNheq5fU1VvbUrvz4XAj+Sad03aA89icNYCbQWeywHrA/EoIYM4GLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412319; c=relaxed/simple;
	bh=r/+9LqIUt/M9dh5+10LY+J//y9W5X0tN+LnC14C5PUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gLT+LfSw/DSSlaDaClp8nxcFSb+y7I9PLtg/F9ctjnmytzvSPZ3y4ijA+pHuqfjGgEUqReVF3dq0npyDKGmXEHe01lYQMYsNeZWWUhEQTuEyV38M6eI45bcTwaP+Zd6otIdFmROHuEzk7/Z29gkjqUnxRJP5Zi6v6Fl/adLF4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nDOxaLnj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43THOj4F009535;
	Mon, 29 Apr 2024 17:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=zDslRiKG30+N4HJXGjof
	7AUIBxgayl4YlcmyzHS+1YM=; b=nDOxaLnjrkGmlYT2aX+zSPvCUQ+clBre3Mk6
	cOLD5zHmLoD4qZbdBUOp/HA44fVmX4AeHISHCHl7XK0Ag8K5boCIRNr+1QTOLDsg
	CCFtpkU0jEk82GJWJAIJ5O7SANoJ6Y8Lq6+9V7ZD0fnx8GckcpbPplSpdUJjOd9h
	cdZZqtzTiTF6PxSA11OQvsGsd6JsX13JO/GI1cRUNT27EQo72/dn65aKF+euYem7
	r34Nc5/IfoBI/qZNse9Vpytuvq2kOMCiyz5wjkRp/hwGR0KjFQ3smfk/eqyDN3DX
	4JUiYOnEG8KfuaBTekXOGw7JQ/sYmx+sTu20zrlqVLYCui/gHQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt5xkaym5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43THcR8C032224;
	Mon, 29 Apr 2024 17:38:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xrtekh4xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43THcRlu032195;
	Mon, 29 Apr 2024 17:38:27 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 43THcRTH032184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:27 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 493874111F; Mon, 29 Apr 2024 23:08:26 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Add support to enable debugfs_htt_stats
Date: Mon, 29 Apr 2024 23:08:21 +0530
Message-Id: <20240429173825.2369355-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GW0b4pYCtKr_bESMSqCl4dNJzRd_UlTu
X-Proofpoint-GUID: GW0b4pYCtKr_bESMSqCl4dNJzRd_UlTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=899
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290113

Bring in the basic infrastructure necessary for enabling htt_stats via debugfs.
Patch series bring support to request stats type to firmware,
dump the stats and request to reset the stats from firmware.

Schema with one ath12k device:

ath12k
`-- pci-0000:06:00.0
    |-- mac0
        `-- htt_stats
        |-- htt_stats_type
        |-- htt_stats_reset

Dinesh Karthikeyan (3):
  wifi: ath12k: Add support to enable debugfs_htt_stats
  wifi: ath12k: Add htt_stats_dump file ops support
  wifi: ath12k: Add support to parse requested stats_type

Ramya Gnanasekar (1):
  wifi: ath12k: Dump additional Tx PDEV HTT stats

 drivers/net/wireless/ath/ath12k/Makefile      |   2 +-
 drivers/net/wireless/ath/ath12k/core.h        |  11 +
 drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 713 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 300 ++++++++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
 7 files changed, 1038 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h


base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717
-- 
2.34.1

