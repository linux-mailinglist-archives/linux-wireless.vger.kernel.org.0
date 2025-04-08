Return-Path: <linux-wireless+bounces-21232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A963A7F380
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922213ACAA6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 04:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F551B0F19;
	Tue,  8 Apr 2025 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HRr8jDl3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A3198E91
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086111; cv=none; b=quYpx7jk71Jb6XUYLtufqbTH5wu05r6YnjtzYfywbjd8w66BidrQPxNMDgfzOfvtiC4mfB2wBbqTuon20HTJ2whpufCcnem/F7/JEmdETtNcJvyiotDhsnk95vxxEb6WbvLtd29SpQtt8j4Y8sALXFE3KyDTKXMYr7l2BLgbEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086111; c=relaxed/simple;
	bh=OvN9A58CeyH2fSSCMxZcjglBIYKLaAdgc0Sdx/IX6DA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TdIOKAC1omyOXYfjQECj7CANh8hYlesQm5eoku7uJcIS6rNX+AhX58DNiCjAPZYySK6NjV4CSUzZT/hNoaLf/uYfUVCJoPUqPApHU7tGsgRrKNrA5/RehXrmoViazr2lTRZpkoGJ+R3CbSnSYe0q84T82NkAOz4OH1he2NUG6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HRr8jDl3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382Gd3w015100;
	Tue, 8 Apr 2025 04:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IRVuJZCq4B6HKCSspyhJNN
	grIC7t2BSotBHjmxVv3iE=; b=HRr8jDl3CRw7FxQanFVYApxN+zV4rsIMKLhPdg
	fMPBfm73rVcRG9HlyjDyoZzQcc6CAleaBbpMv4cGYGa7JDDGUgzh5CtYJqCDvOef
	2YhGrO2P07XVMaQwJ61ochA/6VTnGRhMdswbJ5ULBh4neWtIe4/Kmp7vYvEdJebX
	G59ie8ExUoLvxSNtC3ya1oZRebJIa8XldkGFNPjRabWlNErMoVnD4a9AQP2dRwkO
	xZ1KsYMJMND/8Yfp0tN2Z4LYeMqYuhhxMGF2HXtAvzsjN42aQUUYLHQvA97f8VQ7
	mNlhPv02xTgBO0Nmswlq8qAbUhFKrofE0Sm/zOOV6tjrosOw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbueeyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:21:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5384LjPN020841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 04:21:45 GMT
Received: from hu-rajson-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Apr 2025 21:21:44 -0700
From: Rajat Soni <quic_rajson@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH ath-next 0/3] wifi: ath12k: Properly update frequency range
Date: Tue, 8 Apr 2025 09:51:25 +0530
Message-ID: <20250408042128.720263-1-quic_rajson@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lz2h3imQYVH11nt-C5xbVpmGMvoo3sCF
X-Proofpoint-ORIG-GUID: lz2h3imQYVH11nt-C5xbVpmGMvoo3sCF
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f4a45a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=zLfMTeblcGlTlpjJDDwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=743 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1011 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080029

This patch series ensures that frequency range is correctly updated
compliance with regulatory rules.

Aditya Kumar Singh (2):
  wifi: ath12k: Fix frequency range in driver
  wifi: ath12k: Update frequency range if reg rules changes

Rajat Soni (1):
  wifi: ath12k: Add helper function ath12k_mac_update_freq_range()

 drivers/net/wireless/ath/ath12k/core.h |  9 ++++
 drivers/net/wireless/ath/ath12k/mac.c  | 49 +++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |  2 +
 drivers/net/wireless/ath/ath12k/reg.c  | 67 ++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 9 deletions(-)


base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
-- 
2.34.1


