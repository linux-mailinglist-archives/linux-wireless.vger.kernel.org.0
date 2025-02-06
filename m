Return-Path: <linux-wireless+bounces-18563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A7A29F7B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 04:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B88167361
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 03:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D42B9BF;
	Thu,  6 Feb 2025 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TFe57Uc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFD376
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738814067; cv=none; b=S5eQCNsLIrf5T0KIaCNgaymbU+BhKZK0vIGRr2qouEsCIMoA23XvA7emIWlSx2SK6hWSPHvVYxhsFvYtNWPFICLPnudqn5yS+2ieHqz0EUYMb97AeTlC/qzxEBl1oCm+EGBotLHbeH1NB1MbVh6/C9FUvBV0708UjfdsIkWoUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738814067; c=relaxed/simple;
	bh=4aYw+hlQj78RL2WaJi6lXvy8qRoWuQRMLFUSnmUDGX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ov0b7i7gPAXPNgb32l8iQxrACMa9whqr720Z/J55MoJ3iPxf4kRVCMAHE8WdV4dXMPnGSd8JveVFddC6j9DVWtnMU0nsuLOHiTuCfA0S4vfMXspA7NC4+XqhV4JnmA3R17c4DZ9nz0VG9xCD5dHU30GEnXlBrZjaz4R5JHAhpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TFe57Uc2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5163JokD017540;
	Thu, 6 Feb 2025 03:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bNFOxhW5mH5uFFbZyqnkk1
	XuS/GmqTd6SpHxwVcHc9I=; b=TFe57Uc2Flrc1+VoyQwW8+B+sy3+LLcxlAusKO
	Topt/utzhh1w1/3xDAjzfm/TM4gZbQuYXp2Z3hf5Yp2myQw6mytOOdv+eMSFvDQn
	aBBXy7/MsfsIcp+RkQlHBjsYwk+nmNzh/ZTm/Iw4MqGCin5J0pEST5GQATTQgzm7
	t/0Zd2OqDiPyc72kA3EC1HETideqEGCsGr+9leMq/l2HX1zlWBGOTssQOgILkleD
	i6+RC3AXirHug5v/VfzLRuD1r3Fc5FLd4S3ZQpavKPw1NHYnXgYu3RfE193d0tyL
	Pmh6X22Zzsk7Sl3WTiBIaAn2Pn4gWpwdiJpZqY/Bhibm/2bA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mn2yg244-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 03:54:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5163sLlT031132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 03:54:22 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 19:54:20 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v5 0/7] wifi: ath12k: Add monitor interface support on QCN9274
Date: Thu, 6 Feb 2025 09:23:50 +0530
Message-ID: <20250206035357.310868-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MEtuqXUDgArTXtoCtdFNX5Ukbfv15iyj
X-Proofpoint-GUID: MEtuqXUDgArTXtoCtdFNX5Ukbfv15iyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 spamscore=0 mlxlogscore=998 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502060029

Currently, monitor interface not supported. Therefore, add the missed TLV
tags parsing in the monitor parser, configure the monitor vdev state
identifier with HTT filter setup.

Depends-On:
	[PATCH v9 0/9] wifi: ath12k: Add peer extended Rx statistics debugfs support
	https://lore.kernel.org/all/20250206013854.174765-1-quic_periyasa@quicinc.com/

v5:
 - updated the s-o-b as a last tag
v4:
 - Rebased on ToT
 wifi: ath12k: Replace band define G with GHZ where appropriate
  - Dropped the tags due to rebase changes
v3:
 - rebased to ToT
v2:
 wifi: ath12k: add monitor interface support on QCN9274
  - remove redundant filter setting in ath12k_mac_monitor_start()
  - set the default filter when the htt monitor configuration get disable

Hari Chandrakanthan (1):
  wifi: ath12k: fix link valid field initialization in the monitor Rx

Karthikeyan Periyasamy (1):
  wifi: ath12k: Replace band define G with GHZ where appropriate

P Praneesh (5):
  wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
  wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
  wifi: ath12k: change the status update in the monitor Rx
  wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
  wifi: ath12k: add monitor interface support on QCN9274

 drivers/net/wireless/ath/ath12k/core.c    |   5 +
 drivers/net/wireless/ath/ath12k/core.h    |  18 +-
 drivers/net/wireless/ath/ath12k/debugfs.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp.h      |   4 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c  | 362 ++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/dp_mon.h  |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   |   5 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c   |   8 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h  |  15 +-
 drivers/net/wireless/ath/ath12k/hw.c      |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c     |  74 +++--
 drivers/net/wireless/ath/ath12k/wmi.c     |  36 +--
 drivers/net/wireless/ath/ath12k/wmi.h     |  16 +-
 13 files changed, 435 insertions(+), 121 deletions(-)


base-commit: d132a72d768bae74d10e6539fcf6522dfdbd1115
prerequisite-patch-id: e5e05751e1a2a54b5c705222ef05a5f76cbd6858
prerequisite-patch-id: f503436fb6fa4e65cbbb0b52dcb1ab41b65d6e2b
prerequisite-patch-id: 5651ab3bfa84c40524c70a55f821b6a884908de7
prerequisite-patch-id: 4b6f75cfa4d25f974f8fa61adbc85fff35a187fa
prerequisite-patch-id: 6a015b7d89f3d61adb5d60eff2d63fea10d9c3b0
prerequisite-patch-id: afba80a88de0869ade8954c32ebbec407608a1c0
prerequisite-patch-id: 12367e8ecdccf254c41bd0518cea6877e4673bb3
prerequisite-patch-id: d94f4a9c9b0b3bdc9e709efcae0cba4983bf440f
prerequisite-patch-id: d777e315103b196f906c853881ca666a0423c8f6
-- 
2.34.1


