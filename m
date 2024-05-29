Return-Path: <linux-wireless+bounces-8250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30308D2BBA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 06:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AADF1F23395
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14615AAB8;
	Wed, 29 May 2024 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Eh6FXN+F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31FA55
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957077; cv=none; b=JtueRV2rkQAQ+mJa2H5JQueR7cw8r4aw8s5kxFsJfkH5lfcLqR/Fk1crWd1qfJQKhswbywndLrOkRxoYKj0vGmvHbmUAtnW21YDfRiu8swvR7/D1F/816fwcGnD8EM+P4naB6jhX+BQzhHu4SYek/cOUieVvw2Bi5d6GfG/YiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957077; c=relaxed/simple;
	bh=RMqB9zfbl3TU02r0RQN3OaKVnky36cEw6kbSbi2VuzI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IalWBQS2oRTA8J7x/eMm7MJRVA7rPMdKcNtkBS9nb++/WDbbOQAxmLVU58bwKc/tOJqk+ipA2SYXuVRz2vneqrf1lj/0GuL5/joiDQlGlL1L6hNJ1yDlHrdlJ+od5/PVLsEvnMCQ3A50X4W1l/2u5NkRvZJMYV9Z/8cnQPPjSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Eh6FXN+F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SMkTO2031447;
	Wed, 29 May 2024 04:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yHgqGoN25zrVNCa+C/gtyF
	LsCc5jVlsAgHO0VVRQisQ=; b=Eh6FXN+Fzz0D38VxDexD0LAJ8qehes7kFlX2nv
	e33yH0yB+MFWwVjEbGHwtLQbb14pjH1xuWcEjrEqCBISLcFU3BcgD9PV165dj4r1
	LUFm/DKp94akKbipij0IDs3L5tNM+fOJrZZB0ZPfpFv/YseUpBC1xj/iVvQmznoX
	FHxHb/5AsHu4EeExBKadR82Nb0Rt4KJ5k8GkmSvf7q5HQyKDOAsjPTd0ck+L6gKA
	4nHvZfdT3fay0aoMLm3G5j0HNe1QvxpP9wtgppcSqePiA5CCmwL8bgf3pdw3sAMg
	Ipy/8zmW8QRdXt8kr9p8TtuEnWBAJkHyU3uLvQc1eGOmm+Lg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0x7yxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T4V7Lb024239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:07 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 21:31:04 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: fixes for per pdev debugfs
Date: Wed, 29 May 2024 10:00:40 +0530
Message-ID: <20240529043043.2488031-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: D2L5rd_UpzSu7gNyb2Zoq9cBS2J0gRE2
X-Proofpoint-ORIG-GUID: D2L5rd_UpzSu7gNyb2Zoq9cBS2J0gRE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=531 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290025

This series aims to fix a few minor issues in per pdev debugfs handling.
More details in each patch.

Aditya Kumar Singh (3):
  wifi: ath12k: fix per pdev debugfs registration
  wifi: ath12k: unregister per pdev debugfs
  wifi: ath12k: handle symlink cleanup for per pdev debugfs dentry
---
 drivers/net/wireless/ath/ath12k/core.h    |  1 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 16 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/debugfs.h |  6 +++++-
 drivers/net/wireless/ath/ath12k/mac.c     | 11 ++++++++---
 4 files changed, 29 insertions(+), 5 deletions(-)


base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130
-- 
2.34.1


