Return-Path: <linux-wireless+bounces-3637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC1856991
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 17:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA94B22BEB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B013173F;
	Thu, 15 Feb 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="peeP86bS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1F66B2D
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014513; cv=none; b=qmoUN27oHGgIz7KnqQAmtYI/TSG+Cdme7XHSn1Ug8DMKCKKDeiGfGgX8plrldWJOQ8/3M3fzGeWFMNwHuoPlILXWnSl+5GNfKs64FK1qULAo8KBOqTiY6Cb8x9fDVXAA0/3u2SoPZPHJU8xKJkK1Bi7mT2fdDcDeLjIF/XGGGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014513; c=relaxed/simple;
	bh=N9ObpoWnhpNHI0yUN3P7aDepjVLRHkTVsUFJkiOkliQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Za8cHFi0J5of6rjmyS9Dl2MImiit0rhkIcjJqXhgjORNnRgjAfHdgceTRRx05DvepSgcPYfsWC3HwBlntFOL+isrORuyGqDkIrubt87UbJV8+pcqGvHFrTeaGORhlZ9CS4Ys3it8Ue/SkKiXqx7Ema1arsBGVMa4WG+/b2Iqtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=peeP86bS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FB9afO005039;
	Thu, 15 Feb 2024 16:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=/oB0OND
	GvOqUc6roC5fA+j23KfttRLWpZTEKe/TNHXg=; b=peeP86bS0MJ4QzO/ye9cOWu
	vWn7qj26E5mElcZ2vXuDGaO0Cl9pVhoSIwN+Fr4PYDaKCwCk8FhqHUE2LItOp78a
	AHLDqAbpz20G6+kOyuhx3UKJRn5gJunB5QhAQKAIvKn4YIN4jJOuv4+bIEBTwOT/
	hFqc+jzkt/lu0FMpRW2R+qspxzazGxk96b8E0XLVPyZi5FCdTIrS2MPrKtVXe+Mg
	kHtP4RWxHt9IEj4mggPsG1tfEAyXRlcJoM5DLl6GwDAJOnyr1q1Rr6GyN5A2qQS7
	6155vRP85nZcxbFOQ/DYUDtRIXCX17zK97CziD1Es2MN5U/sOSFqd2w6hX8zjdA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9cd49gbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:28:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FGSR4r026602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:28:27 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 08:28:25 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211/mac80211_hwsim: support MLO CSA test case
Date: Thu, 15 Feb 2024 21:58:09 +0530
Message-ID: <20240215162811.506065-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 6FV5HvdxY0sdZBB9Fz-87Bw_JSgWaUOU
X-Proofpoint-ORIG-GUID: 6FV5HvdxY0sdZBB9Fz-87Bw_JSgWaUOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=853 clxscore=1015
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150133

Recently MLO CSA is enabled on the stack. Add test infra support in
mac80211_hwsim in order to support basic MLO CSA test case.

Aditya Kumar Singh (2):
  wifi: mac80211: check beacon countdown is complete on per link basis
  wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
---
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |  2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +--
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c | 35 +++++++++++++++++--
 include/net/mac80211.h                        |  4 ++-
 net/mac80211/tx.c                             | 14 ++++++--
 12 files changed, 58 insertions(+), 15 deletions(-)


base-commit: 42ffccd0a36e099dea3d3272c5d62a0454ded1f0
-- 
2.25.1


