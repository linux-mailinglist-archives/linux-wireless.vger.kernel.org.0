Return-Path: <linux-wireless+bounces-7349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516908C0342
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062491F22811
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AEB38F9A;
	Wed,  8 May 2024 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ab2EFthF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CC1C6AD
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189841; cv=none; b=usVFd0u7FiJdLXQ5j+IYUZDaSznprbkLH6tgX8p7gFMAv7fnxSMvj09nliyTgfKMtFMqC3YJwo/XD/42hH6zx3D4FQ7KzUWEHiokaVWFGg2yfTtGD3WR9FA98Vd0LG8l12B9UI46poVPkBSXuoqpKjowNnBGWYaPMhWuesZH4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189841; c=relaxed/simple;
	bh=Axj5pk5/asVJ9TXF42fqj5ai041778l59nyuGCAfjkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=djWTWqAoQQcPE7H1VTVe175uyCBpyyra6Ch251Hj3Z80e26/Ms/Rcnh/jF9x17urmr9aohN0zVdQ6682zf9GSZfJSikiLsWf3c5Ngg55+ViTDxMKHrYKcTDZ3WYr5FtlX2blx8dCkzjyAnR/0PzxR3JpJhC/8zc2MNV4s8S90A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ab2EFthF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448AiLEI006645;
	Wed, 8 May 2024 17:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=tlHSrKHW/bkhBx4e3jrASEpXIdGjrGwuavKa/JJWfVU=; b=Ab
	2EFthF4IGVAhes3dhGyv74i2It7d/kJhdlB8beq34TX/I6JA22Y/sdZWFLdRG88v
	wQK5syp2NWYlKPl+2mh2ovwTnvyjxL1Clrp23tB42CrucCh0xm8MAwGegG8WBPYm
	isnAwh4k3BaicERPb2ceI7LG3qIFV34dPjshA0LCoe7GKt+s2tkapx5Tpq/RvAS0
	EKh5yyGlzJinesYyATkWGh39FllCiGk7RvqTI9UIUQM84ZpZtBwlFVus4mGDoawL
	knZkUeVE4qf/Dt0rkASfoP4y5M8iUol5cl56NA1SWtocZpTZIbZiKdoO9CWvKuML
	ObZRb9tbNgTuQkb5/OEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07wfryuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 17:37:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448Hb66r009051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 17:37:06 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 10:37:06 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V5 0/6] bug fixes and enhancements to 6 GHz band support
Date: Wed, 8 May 2024 10:36:49 -0700
Message-ID: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JlN_jJU3zWklfUd22Uv0z6FCGn22KauT
X-Proofpoint-ORIG-GUID: JlN_jJU3zWklfUd22Uv0z6FCGn22KauT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080127

In 6 GHz band, add support for
1. channel 2.
2. Fix packet drop issues.
3. AMPDU aggregation
4. SMPS configuration

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v5:
 - update commit desscription in patch 5/6
 - rebase

changes in V4:
 - add back missed changes between V2 and V3 - details below
 - add acked-by tag for patches 1/6, 2/6, 3/6, 4/6
 - add back missed tested-by tags per patch in V3
 - Add back missed patch portion to handle disabling SMPS
   configuration in 6GHz for WCN7850 in 6 GHz band in 6/6.
 - capitilize smps to SMPS in patch 5/6

changes in v3:
 - address review comments for fixing ath12k-check issues.

changes in v2:
 - Disable smps for WCN7850 after review comment from Boachen
 - Added Tested-on tag for WCN7850

Pradeep Kumar Chitrapu (6):
  wifi: ath12k: add channel 2 into 6 GHz channel list
  wifi: ath12k: Correct 6 GHz frequency value in rx status
  wifi: ath12k: fix survey dump collection in 6 GHz
  wifi: ath12k: add 6 GHz params in peer assoc command
  wifi: ath12k: refactor SMPS configuration
  wifi: ath12k: support SMPS configuration for 6 GHz

 drivers/net/wireless/ath/ath12k/core.h  |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |   9 +-
 drivers/net/wireless/ath/ath12k/hw.c    |   3 +
 drivers/net/wireless/ath/ath12k/hw.h    |   1 +
 drivers/net/wireless/ath/ath12k/mac.c   | 122 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.c   |  10 +-
 6 files changed, 122 insertions(+), 25 deletions(-)


base-commit: 69b8a1a48efe2f1d921336cf00dc70db68873550
-- 
2.17.1


