Return-Path: <linux-wireless+bounces-6214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21088A2625
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8211F220A8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9BD1DFF9;
	Fri, 12 Apr 2024 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FG2XOm2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB81BF24
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902003; cv=none; b=MGv994dK21vbgxasxkVZRUsWJSQAdZqzztPCnfx+/khQ0NMyBnl54YOGP8m0/d8Bhi/oJeo6kampw5dNCb4KnevcrsDGakL6pUoHlqVp9hVWawAmWXCb0LnNFXMWIOxiywd+XSyHsY5EkUz0VMayt3SmqDEiG/Of9Y+ifv6KGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902003; c=relaxed/simple;
	bh=DeCju9b5Z8pU7eIcFs0HDDmP5mcx05q11TXaseLKKZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ce1gkqyYAr6345pkk1UngbxLz8bcIZ2X/us+LlTu+27gRze/CybaF6mYndztpfj/OQ9V0zAiGll/Ctq+5N+YVgM6vxxU1MbQotMADsif8ZSW7ToWtlkb++QDiYck109UlMP20YOwnV/I1c/QFLi1x9Stucl+PmVAsgmnpfq/xR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FG2XOm2E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C0vsgc022665;
	Fri, 12 Apr 2024 06:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=NHDj1o/
	0mqo/xcSeW1qZ4eFrjjPF4O9GEsa6ZxNWsUM=; b=FG2XOm2EZ4YguABWwNmkg33
	EABEwBr4fZTI4YAIb05hiVvuFZh+3TyP8osmUoJVjCJl1DHTkG0UHu4mu7KAvSGa
	E0eS8TiPLzC23HvEYls+5jvt2g/8N8atEIz2Dn5sLA7KLuxXIeiStez+jASg6yZS
	sdYQHC5F/asKylz4s6rUoqhIZQQKfiyGIKYpkrtIVkq4xObmVgr1Qle/mKKUuyhl
	rs1WeJ13YP3bWkCbV3OmcN2caKlEv5d0cuUIC8eVHTfxOc4rkM8eslxaney9pqtA
	6MeXDV0BWIXjmoK2HJfSGPa3locP+qJKbnyeekJDYH4jhryDDI21L279VsoTJpA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xebqxb5k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C66aCP031834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:36 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 23:06:35 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 00/10] wifi: ath12k: support suspend/resume
Date: Fri, 12 Apr 2024 14:06:10 +0800
Message-ID: <20240412060620.27519-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: gijXp6JxPuRFufzPbYL1blaOXssypmI8
X-Proofpoint-ORIG-GUID: gijXp6JxPuRFufzPbYL1blaOXssypmI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=875 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120042

Now that the MHI&QRTR patches [1] are merged, we can add
suspend/resume support for ath12k.

The whole design is quite similar to that in ath11k: firmware
is powered down when going to suspend and powered up when
resume, this makes hibernation work as well in addition to
suspend.

To summary, this series first does some preparations in the
first 8 patches. Then in patch [9/10] suspend/resume callbacks
are implemented. And at last in [10/10] we enable suspend/resume
functionality for WCN7850 because it's the only chip supporting
it for now.

[1] https://lore.kernel.org/linux-wireless/20240305021320.3367-1-quic_bqiang@quicinc.com/

Baochen Qiang (10):
  wifi: ath12k: rearrange IRQ enable/disable in reset path
  wifi: ath12k: remove MHI LOOPBACK channels
  wifi: ath12k: do not dump SRNG statistics during resume
  wifi: ath12k: fix warning on DMA ring capabilities event
  wifi: ath12k: decrease MHI channel buffer length to 8KB
  wifi: ath12k: flush all packets before suspend
  wifi: ath12k: no need to handle pktlog during suspend/resume
  wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
  wifi: ath12k: support suspend/resume
  wifi: ath12k: change supports_suspend to true for WCN7850

 drivers/net/wireless/ath/ath12k/core.c  | 108 ++++++++++++++----------
 drivers/net/wireless/ath/ath12k/core.h  |   4 +
 drivers/net/wireless/ath/ath12k/dp_rx.c |  48 -----------
 drivers/net/wireless/ath/ath12k/dp_rx.h |   2 -
 drivers/net/wireless/ath/ath12k/hif.h   |  14 ++-
 drivers/net/wireless/ath/ath12k/hw.c    |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c   |  28 ++++--
 drivers/net/wireless/ath/ath12k/mac.h   |   1 +
 drivers/net/wireless/ath/ath12k/mhi.c   |  91 +++++++-------------
 drivers/net/wireless/ath/ath12k/mhi.h   |   5 +-
 drivers/net/wireless/ath/ath12k/pci.c   |  41 +++++++--
 drivers/net/wireless/ath/ath12k/pci.h   |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.c   |   3 +-
 drivers/net/wireless/ath/ath12k/wmi.c   |   1 +
 14 files changed, 175 insertions(+), 175 deletions(-)


base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
-- 
2.25.1


