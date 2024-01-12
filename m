Return-Path: <linux-wireless+bounces-1794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A6782BD35
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 10:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D861B2881C5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B05D8FB;
	Fri, 12 Jan 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jD48Zzz7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9E5D905
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C4gSKf011641;
	Fri, 12 Jan 2024 09:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=hUN7dui
	/7gftfnHdJmO4yUp6F03k3vaeMRYyTVDvBAo=; b=jD48Zzz7iHJpwh4NhCcQN9r
	ki0RqxpLtaS6is2S0Zhp09Mv2yuKUtjAtbpgae5hfXfbIc+0gDCNVHOwtJb44tDt
	wfvMRtmTebX29Pf0HitAuTUNyjOnv75GNpCOrdFVkZFBvjuWn2ZkdhIL0sevRLzr
	yvgT8O5vHgnVJPLBx2gjx7oW3gBsllpMhHopLDZB7+NUJsKaoaQG9kXtQJhvNlzD
	79lXQmXU2L8VEf8/Zy77EvHMOTo/XTFjMeVTnD2FoqCqgHLIpSi2qGWZppoy5MHG
	kETjW+qRIazLs2I7B87FOAhQIj8b1MmhImKi4Px76XYrqCfSUSyrtIkqNs+dPFA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjxm60sqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 09:28:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C9SdRn021296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 09:28:39 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 01:28:37 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 00/10] wifi: ath12k: P2P support for WCN7850
Date: Fri, 12 Jan 2024 17:28:14 +0800
Message-ID: <20240112092824.7664-1-quic_kangyang@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1aBKouzTxKl_tcOf3XgJg6ksmmdokOeG
X-Proofpoint-GUID: 1aBKouzTxKl_tcOf3XgJg6ksmmdokOeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=790 clxscore=1015
 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401120072

Add P2P support for WCN7850.

Kang Yang (10):
  wifi: ath12k: change interface combination for P2P mode
  wifi: ath12k: add P2P IE in beacon template
  wifi: ath12k: implement handling of P2P NoA event
  wifi: ath12k: implement remain on channel for P2P mode
  wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
  wifi: ath12k: allow specific mgmt frame tx while vdev is not up
  wifi: ath12k: fix broken structure wmi_vdev_create_cmd
  wifi: ath12k: move peer delete after vdev stop of station for WCN7850
  wifi: ath12k: designating channel frequency for ROC scan
  wifi: ath12k: advertise P2P dev support for WCN7850

v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright in patch #1, #2, #4 and #10.

 drivers/net/wireless/ath/ath12k/Makefile |   3 +-
 drivers/net/wireless/ath/ath12k/core.c   |   3 +-
 drivers/net/wireless/ath/ath12k/hw.c     |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 360 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/p2p.c    | 142 +++++++++
 drivers/net/wireless/ath/ath12k/p2p.h    |  23 ++
 drivers/net/wireless/ath/ath12k/wmi.c    | 118 +++++++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  50 +++-
 8 files changed, 638 insertions(+), 68 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h


base-commit: dc1702f7b1340dd741bca1005ab52a2c92cc6c84
-- 
2.34.1


