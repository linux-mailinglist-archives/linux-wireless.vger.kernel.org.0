Return-Path: <linux-wireless+bounces-3826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDC85CE46
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 03:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220411F21B61
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7679FD;
	Wed, 21 Feb 2024 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QLgmCdDW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34246A4
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483666; cv=none; b=StQsZac2cXUOggatWI2Dnbq+FQeT+xOHUMgw46rGBiJd9gW95ZZv1PRdHcyzm8B2TJevIJoRKG77/IsGVee/oW8PllFPC8W+a5Qu+ah1+Ydypd3FbLuB7HCfpfeS2NUEZsk6kOOyqzfTzXr9fu7IS0KYcfESX81/iDsWHa5NpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483666; c=relaxed/simple;
	bh=R2Qo3/hv24zc8jGSgUbo1hiXe2o3V7lua6z8W9xicWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NZzhli+bi25dXPtTgNKuvuctJft8A7HeGBizj7vNeRG0F1YSpp8UE80WLvWxEiVgaMwhX1ysGA+HiJKoN5C8Yho40zbo12DCXe3Er0eMHSvs/l7cq0OOp6FxRlbZMdUttNqXcyf36zzQ1YsZC7xXoY+DRhDhotEHN/mfd9xOiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QLgmCdDW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L0wCqG021654;
	Wed, 21 Feb 2024 02:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=xifyS9o
	6esMWtyWRg9qMDPPuumLYutmJZbuYukfXBqM=; b=QLgmCdDWfYzdJOi7DqDa4bK
	oGNccqZkd1OMmxzdMppXkENod5aBGxIAlp6D2YRMy9UxK5Mvbfb4J6b0cmmPIW3/
	LLJQIcI5fx2wdu6EA/MCxq0YJZltVfwRQuCTgOLJD8eQzlgbj9GJxvRVlrnNv02a
	3XRPsX6MokE20anVYEyF0ar2SnsNmJ+zgo3Am9L8gh9SwwLSitfAdzWmLsVrT0LQ
	2k5pEptMqbkzKocUlXDjfTYe+ZC6bEY6YyzoUfPrPGeDNIB5MTqDeK3036bMqkm7
	gbqcBRqM8p5EyIWjn/psuuQ/rRpKIj5P4ngS+BYyxGpfDD0drcR3+kUtp0+hFnw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21urs4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L2le30020094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:40 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 18:47:38 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 0/5] wifi: ath11k: prepare for hibernation support
Date: Wed, 21 Feb 2024 10:47:20 +0800
Message-ID: <20240221024725.10057-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: 3WqrfY_CAsbxDrkq91t9O1A5sEOaQCkB
X-Proofpoint-ORIG-GUID: 3WqrfY_CAsbxDrkq91t9O1A5sEOaQCkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=536 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210018

This is to do some prepare work for hibernation, the final hibernation
support comes in a following patch set.

Baochen Qiang (4):
  wifi: ath11k: rearrange IRQ enable/disable in reset path
  wifi: ath11k: remove MHI LOOPBACK channels
  wifi: ath11k: do not dump SRNG statistics during resume
  wifi: ath11k: fix warning on DMA ring capabilities event

Kalle Valo (1):
  wifi: ath11k: thermal: don't try to register multiple times

 drivers/net/wireless/ath/ath11k/core.c    |  8 ++--
 drivers/net/wireless/ath/ath11k/mhi.c     | 56 -----------------------
 drivers/net/wireless/ath/ath11k/qmi.c     |  5 +-
 drivers/net/wireless/ath/ath11k/thermal.c |  5 +-
 drivers/net/wireless/ath/ath11k/wmi.c     |  3 +-
 5 files changed, 14 insertions(+), 63 deletions(-)


base-commit: 707e306f3573fa321ae197d77366578e4566cff5
-- 
2.25.1


