Return-Path: <linux-wireless+bounces-19174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B68A3D316
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD44189CBDA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7D1E8345;
	Thu, 20 Feb 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i4sIkZDt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC81E991B
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039904; cv=none; b=qS4u4OnljczBwa9WchKhGQDzd2/0VfgP7XZgkoQ5ufy6hHlEvGoHuMBJJD4P0NGRZz2deTvFhmUK3VktdbJ8jg4qYVeoT1ebNZoMwIUZs/LOtLX1VyZwLN8lFqWcw/2TTNtrQ/AwtNx8DwyHxEYrF7Os5pAnWrB5S1jQMLmQgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039904; c=relaxed/simple;
	bh=6EP9SbxEcy9fOEhHJ4LBQRgG/0f4jmljk8StCbMmgJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ni4jS64krk2ykbOmhALP1S2jEgJXDQvtFFormCFn57OOuHLhvrEXKFD1PyLypZc8LnLlAHyP6jaSbmnwdBeWQE6Pvi8Pv4iIj34Q7fMZDq2TZ5+/Rmdmba0niATrWKdsJEVtiZ6sf3ETvrDxS3anim59fBw/7R3DfROttUsuigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i4sIkZDt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6kSFw014898;
	Thu, 20 Feb 2025 08:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0jtJypVsFSlFOpuITqFT3B
	PvBLSgaQs8m8BF0GOjEB4=; b=i4sIkZDtobIiBLjh7UTr6FJVociCJhTL/FkwwQ
	RbmkjpiAt7m/UErtDz/0lxhOHlyH8aYMoVYZZ0o3gPqqwURpLXRdxDcjNmaMKhRk
	viPXMbfTNuEp3EJRBXcpNbmKP5rHJA98dxNqOD4GC1KPJdiGFd96gW40UU/YhcZe
	ApNwj1iQ/mvYzVnqMNBHO3L47Dg8iB6CFa0XlkYGmaSq0Lcop4L+grdDgYlVzQGv
	sQZD2xOby4KN2Klq/J+XEC/qHspfNYEEi2xwPurhiOMVYk+VQRqfCPHm2bZ3Zfkw
	T0WLxwo/3XuOv6KaEF/MSb/CDY5SHim5+MhPrnvfYwE/iNzg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy15cuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:24:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8Oxvp003615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:24:59 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 00:24:57 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 0/7] wifi: ath11k: fixes and refactor to firmware stats related functions
Date: Thu, 20 Feb 2025 16:24:41 +0800
Message-ID: <20250220082448.31039-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: KqUTI7X9b2RzIVMyK_5vT6uKPek98Wmx
X-Proofpoint-ORIG-GUID: KqUTI7X9b2RzIVMyK_5vT6uKPek98Wmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502200060

We get report [1] that CPU is running in hot loop while requesting firmware stats,
fix it in patch [1/6]. While at it, fix potential failures due to static variables
in patch [2/6]. patch [3/6] fix potential issues in cases ath11k debugfs is not
enabled. patch [4/6] fix lock symmetry issue. and the last two patches refactor
firmware stats request helpers such that we can remove some redundant code.

[1] https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com

v2:
 - rebased on ToT
 - use completion mechanism in patch "wifi: ath11k: avoid burning CPU in
   ath11k_debugfs_fw_stats_request()"
 - add new patch: "wifi: ath11k: don't wait when there is no vdev started"
 - update copyright where applicable
	
Link to v1:
	https://lore.kernel.org/linux-wireless/20241113015631.3105-1-quic_bqiang@quicinc.com/

Baochen Qiang (7):
  wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
  wifi: ath11k: don't use static variables in
    ath11k_debugfs_fw_stats_process()
  wifi: ath11k: don't wait when there is no vdev started
  wifi: ath11k: move some firmware stats related functions outside of
    debugfs
  wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
  wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
  wifi: ath11k: consistently use ath11k_mac_get_fw_stats()

 drivers/net/wireless/ath/ath11k/core.c    |   1 +
 drivers/net/wireless/ath/ath11k/core.h    |   4 +-
 drivers/net/wireless/ath/ath11k/debugfs.c | 148 ++--------------------
 drivers/net/wireless/ath/ath11k/debugfs.h |  10 +-
 drivers/net/wireless/ath/ath11k/mac.c     | 127 ++++++++++++-------
 drivers/net/wireless/ath/ath11k/mac.h     |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c     |  49 ++++++-
 7 files changed, 147 insertions(+), 196 deletions(-)


base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28
-- 
2.25.1


