Return-Path: <linux-wireless+bounces-15512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2389D2AA9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 17:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3E6B29E60
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383051D0E1F;
	Tue, 19 Nov 2024 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KyRaR+p7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6661D0DDF;
	Tue, 19 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031278; cv=none; b=Scz3QzTUdZytx3h7hFdWAIgvC98yEpLfAF0wnRPy5JfJkZMy7a5nzya/LGtzVK6gz7uz5hEJv59jyYRkQLUeTw/vsRIoWCTzuY+nybdhL4cFVkmd4tkBQwqH04tsSW6l2ZDIFoLSIFmfPwKGCB2XsxKbsBxikNvAA+Fi5hlrP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031278; c=relaxed/simple;
	bh=bRURSDiY3w7GUByPvPr2qsRUy9AJ6NMUgpN5fgkGpvI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IOtTbfMiqYvX4TKnGJBZmEraj0D3vKyMqtvC+YjRClAbbNyiXRqQTpCOMDE3qFnaIdAPEAtWn+f04E3gUbtoCiyvxCS2AheatgMT3pY5hGxpqZ0OMcxi7XxWsAPzZ7vCqLS/0Cgfbgg6rLq5vOkXPmHFgssyNp+mRh8WtrtKrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KyRaR+p7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7R1La031135;
	Tue, 19 Nov 2024 15:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vEFoBaUXjlFpcgiY7yt5E6
	skNcokCidJ1aWjIkc2uzo=; b=KyRaR+p7ogxb+VqxYZtVP7Ay76rUkenodM4Q41
	BPm25ND2UiWqvMHqAwnwRPSMvegA3BqgFUEzhYIXybXkIC2QxmHoKSQfGZj3xUAr
	KQIN2deh8ngqktR+gBPcD3WNufKkmlU3ViJ2xVr3K9uim8t6w11lKWlJUPwxg2hJ
	xETieZ54i1JWXBcg0GnXf0q+ejUncxBYOKHh+6881MrDMK8Ghjdy19xw+JIyez54
	W6dHYDcugzrpsMzugxjTLNoScViXfM/4egkff9t8BlkZ4kgH+ebqMjstFrd1DRxm
	kXR9huNhZqgTeMQQJ/33JDQ6Kkra3lRkUN+dEdIC6ZwLKK0g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y6ayus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJFlihU008285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 07:47:44 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/3] wifi: ath11k: Fix clang+KASAN stack frame size
 warnings
Date: Tue, 19 Nov 2024 07:47:37 -0800
Message-ID: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqzPGcC/3WNQQ6CMBBFr0K6dgzTgFRX3sOwKGWwE3WqLRIN4
 e4W9i5f8t/7s0oUmZI6FbOKNHHiIBlwVyjnrVwJuM+sdKkrxNKAHT3iDSSw3FkImqo3VJdYa3d
 U2XpGGvizFS9t5s4mgi5acX7tZB0elmWdek5jiN/te8JV+H8zIZRgDnowPbmGrD6/3uxY3N6Fh
 2qXZfkBW99UpssAAAA=
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Nathan
 Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Arnd Bergmann" <arnd@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p_dPkpeqmS3qQcCw_LEf5pMBOoZKKXke
X-Proofpoint-GUID: p_dPkpeqmS3qQcCw_LEf5pMBOoZKKXke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=840 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190117

Fix the following stack size warnings observed when using clang with
KASAN enabled:

drivers/net/wireless/ath/ath11k/qmi.c:3199:13: warning: stack frame size (1560) exceeds limit (1024) in 'ath11k_qmi_driver_event_work' [-Wframe-larger-than]
drivers/net/wireless/ath/ath11k/dp_rx.c:5244:5: warning: stack frame size (1304) exceeds limit (1024) in 'ath11k_dp_rx_process_mon_status' [-Wframe-larger-than]
drivers/net/wireless/ath/ath11k/wow.c:672:5: warning: stack frame size (1336) exceeds limit (1024) in 'ath11k_wow_op_suspend' [-Wframe-larger-than]

---
Jeff Johnson (3):
      wifi: ath11k: mark some QMI driver event helpers as noinline
      wifi: ath11k: mark ath11k_dp_rx_mon_mpdu_pop() as noinline
      wifi: ath11k: mark ath11k_wow_convert_8023_to_80211() as noinline

 drivers/net/wireless/ath/ath11k/dp_rx.c | 11 ++++++-----
 drivers/net/wireless/ath/ath11k/qmi.c   |  8 ++++++--
 drivers/net/wireless/ath/ath11k/wow.c   |  6 ++++--
 3 files changed, 16 insertions(+), 9 deletions(-)
---
base-commit: 9ee80e341c4e473f6c13af3b529fed4ab073234c
change-id: 20241108-ath11k-noinline-74d8e50152c9


