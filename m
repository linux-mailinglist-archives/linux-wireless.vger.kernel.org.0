Return-Path: <linux-wireless+bounces-18643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6BA2CA2B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 18:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC4A169BB7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3951885A1;
	Fri,  7 Feb 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aF6A/fOH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106115E5B8
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949444; cv=none; b=f/CEIzolR9kFCtlmizA/Ka0+BpN/h+2qxzPSWwyxKL7AkG1QY8HaeN7t98rwk+lvMhD8iRpJMeG/UajdjLihK23ZAz762Y/M4+7BjmuUCvTEeTnOBsCAdCEmLrfvcVvMbsiLGq3R+F/0i455lg/Vq/jVBCGpKJNNbMcHBzPqrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949444; c=relaxed/simple;
	bh=A4+BYFDJU9DInHdr8Mm39GPxYFK9D97oMdxGqf8g80s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J7DsEW8i7kyyT51LE54RQSFQm6iKirv+h3nVA5CaPv3JPeimoX0HkxRVIunHyunj5Aq2lDCqYXRQcdN8J0zJR+ipi7kXx8vj8dMsmlUYilcMUhQfafAJYUZDGsp/MVtOkBHhN0POTKN0XgGL4wLuYHgDj46j5IL0YMXQCeMXvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aF6A/fOH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517B2v5f003388;
	Fri, 7 Feb 2025 17:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=wPsTY3sNXWP3uvk5SMbkRdW3o4gL3SSjfuXs9hCV9i0=; b=aF
	6A/fOH1Atixaa/0mS+L2DF3J5tZG0IZwVFCgWMv9Wpa9Ugk3PAZZ6rkiNVJkxBAm
	7wTQRgW9aHYVxriCZ5Ak7O5xsSJVTWWS6iQPJ6jfGr2ZVPAob0ps6tXFSDG07Acn
	4abog4x/RC8iHfsvchRqFEBvvlXvCE8BW6xCrwvH6VjU6KXkMRZ1PBOctbveUvgz
	JP5OCNP/6vulbCLjsIst26trql3qPN85Jk04bU0pjkLF8ygeEEfBBUwkNU5M8Dgx
	A7tdpWZcAPnSkr+jrW/ZVfXplmPlOJIH3w/JYkwPnKLHMhm+ImtUFz/k8sl7Zfb4
	UNzkltL5XzHjOz912G7g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ngy10xnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 17:30:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 517HUeKf013474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 17:30:40 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Feb 2025 09:30:38 -0800
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath12k: Enable REO queue lookup table on QCN9274
Date: Fri, 7 Feb 2025 23:00:20 +0530
Message-ID: <20250207173023.3856217-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CgXuGK-JfzZBmbXsOUgNkSWR76OL71Qg
X-Proofpoint-GUID: CgXuGK-JfzZBmbXsOUgNkSWR76OL71Qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=553
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070131

Instead of storing the REO queue address inside peer entries, REO
hardware module prefers them to be stored in SRAM which could be
directly accessed by REO using peer_ID/TID based Lookup table(LUT)
mechanism. This feature is expected to improve stability by reduced
interaction between host and firmware during both MLO and non-MLO
operations.This feature is enabled only for the QCN9274, so it does
not impact the WCN7850.

v2:
- Removed junk version histories in cover letter

Balamurugan S (1):
  wifi: ath12k: Add support to clear qdesc array in REO cache

Nithyanantham Paramasivam (1):
  wifi: ath12k: Enable REO queue lookup table feature on QCN9274

Sriram R (1):
  wifi: ath12k: Fix the enabling of REO queue lookup table feature

 drivers/net/wireless/ath/ath12k/dp.c     | 79 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h     |  7 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 11 +++-
 drivers/net/wireless/ath/ath12k/hal.h    | 10 ++-
 drivers/net/wireless/ath/ath12k/hal_rx.c | 19 +++++-
 drivers/net/wireless/ath/ath12k/hw.c     |  6 +-
 drivers/net/wireless/ath/ath12k/hw.h     |  5 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  8 ++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  1 +
 9 files changed, 110 insertions(+), 36 deletions(-)


base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
-- 
2.17.1


