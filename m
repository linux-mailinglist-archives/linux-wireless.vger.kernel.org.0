Return-Path: <linux-wireless+bounces-15225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D79C66F0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4697DB22B87
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FF502BE;
	Wed, 13 Nov 2024 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FpUGdnwC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258418654
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463009; cv=none; b=bjsqE4gR8uxeEf61ULu8NFZsY0maffZKT+76b6JlYa+2xFz0SUXLcinlcF9o8d6AD1+TcjR9+VKI4t+hsvR+6an4VAyVQrCqx1L9OWt2LLNu8Jec9kwd2k9H2mIh08j0y+y19etvlK8jr05S3HT9xW3EkVrLnSgwWvY34NFdmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463009; c=relaxed/simple;
	bh=IcW+LqHs3cgifdu6gfNVAIkrnTh+ud6RDbD2xo89pIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WR1SLDxwIgcfaebTyqsPSOkuXL/BkiqWPTlvkVkfR+viG8Xb3MD0E5kTkTliDaru1dlYlnpmI/7uS8RY8CNC62SADEf3T2+qrIphGk7Nv6egMsuThsroMbMaa7t0kEMevc1tXHtoYfIOzmiJcSyi/NDUkwOZoajyX8ujcMaGiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FpUGdnwC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRTId019579;
	Wed, 13 Nov 2024 01:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MvYtrtYxpjQGb6VvJMn+6x
	zx13Vs+ggyDsTHj5CiR/U=; b=FpUGdnwCmp3rJMm6ld401gDjZF2LJTUBZVy9k1
	7IV6IjIz38KrU4LnSWangHTyfiioFCEvOpItKM/HbSLZNJg0Bm/vO4juVGOhnZVw
	jflpo8A9yWlo/caPFqdQJ7ibevrYD15zE6QFwZd2xlLSglfL9laOdML0FDEFYk23
	bHbirr3coX1ZOl4S3WsWfhoKm6iKJeRksqQjVHB6/I9h5teEPAxu1SpF22y0DKQh
	1AHgrdTTQwalFh/VdwZK9RWv5qqK1Md2ro8powMeVGZAJQI9rD5oLjpc4uRACScp
	++9lmBmGgmWWYt3I65JJ46UzShfxmd6L8xFGGrKj4olmIJXQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v1h6jw5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD1uhC6028144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:43 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 17:56:42 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 0/6] wifi: ath11k: fixes and refactor to firmware stats related functions
Date: Wed, 13 Nov 2024 09:56:25 +0800
Message-ID: <20241113015631.3105-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: Q7lEXP1xCF0XYX_rFupAT3237aZUOgo3
X-Proofpoint-GUID: Q7lEXP1xCF0XYX_rFupAT3237aZUOgo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130016

We get report [1] that CPU is running in hot loop while requesting firmware stats,
fix it in patch [1/6]. While at it, fix potential failures due to static variables
in patch [2/6]. patch [3/6] fix potential issues in cases ath11k debugfs is not
enabled. patch [4/6] fix lock symmetry issue. and the last two patches refactor
firmware stats request helpers such that we can remove some redundant code.

[1] https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com

Baochen Qiang (6):
  wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
  wifi: ath11k: don't use static variables in
    ath11k_debugfs_fw_stats_process()
  wifi: ath11k: move some firmware stats related functions outside of
    debugfs
  wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
  wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
  wifi: ath11k: consistently use ath11k_mac_get_fw_stats()

 drivers/net/wireless/ath/ath11k/core.h    |   2 +
 drivers/net/wireless/ath/ath11k/debugfs.c | 139 ++-------------------
 drivers/net/wireless/ath/ath11k/debugfs.h |  10 +-
 drivers/net/wireless/ath/ath11k/mac.c     | 140 +++++++++++++++-------
 drivers/net/wireless/ath/ath11k/mac.h     |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c     |  45 ++++++-
 6 files changed, 150 insertions(+), 190 deletions(-)


base-commit: fc6f018eda7f9054e427f731db1e8b200f22873c
-- 
2.25.1


