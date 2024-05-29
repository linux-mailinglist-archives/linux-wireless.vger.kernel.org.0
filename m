Return-Path: <linux-wireless+bounces-8255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D1C8D2CF6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 08:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2991C25447
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C415CD7D;
	Wed, 29 May 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="no4hvDh0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9E1D531
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963005; cv=none; b=kR6sVSVfgMHFxhgw90BvrT0/VJFTZkC8hrULgxmRfNnNkTg8yO1mbkctK26pI/GxIb8iQakualBCeRTbHV+XVVa5a2K+uavFCJE90uhHi80Sv5a+qlYMYag4dil/GEV6rzVAaMKLcd4ItJDf1DzvkCpjJ/p00wBpX4zcOpqJ8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963005; c=relaxed/simple;
	bh=ZWDKqMqjwgTZY2pdiL4NopTviMKwc6ufxlGxkD6hlB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K1kx3R6UPwfCzv5JNenY2uPixvK0tvsjjh9Unn2Q2C3Ql1RYpxN38V1RjAniMUFRT7TnRJgBXKNQq39Mr60pCM6+WgbSAtgy7stVT+tBb4rnOu3LpvI44Nlr9+cKazONqAYxXUcRiktzvhvTvI1NikEmaQdAFi042Fbe1oMP2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=no4hvDh0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SLiHeb001343;
	Wed, 29 May 2024 06:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/nrFBocH5YO70efEgQ4M5RDCiqHQZABygAI
	Fr5dWbqM=; b=no4hvDh0mVRbvrFxyOwaAucOJ7ePwBlQPc15R+Fh1JOnDEA8J0m
	jxVSuBUfrTJfb3x65i83M54JnA5dOmyyV3CIGUb5Kd1JSOIS3r6+xMwwAhTXPrSG
	GY79/GUnLsczpy3W8Fdkhf6H83UwItiT4z620pbeL/1+n6hz+2PF389+oNl2znQl
	dkTf0d0sRK9lKD0Pmuu/VGXgwmYa3lDMP89Hk2YKXZhsECZa4CnsqOIZ0W7Bc5L5
	qGFbafv6aYlS6riAQhlwwrGoLaLkM1idnUZflceYbNFKj2r6nwjdLWMydtHljcuM
	2bCECGyRXOEGP526UA4lCPu19ppPw5a9XtA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0pr2xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 06:10:00 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44T657Rr031331;
	Wed, 29 May 2024 06:09:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3yb92kuh6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 06:09:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44T69ghr003286;
	Wed, 29 May 2024 06:09:42 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44T69g2l003284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 06:09:42 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 5B7C8410F6; Wed, 29 May 2024 11:39:41 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH] wifi: ath12k: Remove unused ath12k_base from ath12k_hw
Date: Wed, 29 May 2024 11:39:39 +0530
Message-Id: <20240529060939.4156281-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dC7I4iKlKBPmPzY3J354cR_KttdIt0Dm
X-Proofpoint-GUID: dC7I4iKlKBPmPzY3J354cR_KttdIt0Dm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290038

Currently, device (ab) reference in hardware abstraction (ah)
is not used anywhere. Also, with multiple device group abstraction,
hardware abstraction would be coupled with device group abstraction
rather than single device.

Hence, remove the ab reference from hardware abstraction.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
Depends-On: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in split-phy
Link: https://lore.kernel.org/ath12k/20240529034405.2863150-1-quic_aarasahu@quicinc.com/
---
 drivers/net/wireless/ath/ath12k/core.h | 2 --
 drivers/net/wireless/ath/ath12k/mac.c  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 96fafa0e05dc..1d8837bdacf6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -628,8 +628,6 @@ struct ath12k {
 
 struct ath12k_hw {
 	struct ieee80211_hw *hw;
-	struct ath12k_base *ab;
-
 	/* Protect the write operation of the hardware state ath12k_hw::state
 	 * between hardware start<=>reconfigure<=>stop transitions.
 	 */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 33616ab795af..b3127df5a702 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9193,7 +9193,6 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 
 	ah = ath12k_hw_to_ah(hw);
 	ah->hw = hw;
-	ah->ab = ab;
 	ah->num_radio = num_pdev_map;
 
 	mutex_init(&ah->hw_mutex);

base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130
prerequisite-patch-id: 7e8274d96448b7b4bd2d22057a31d95431be6662
-- 
2.34.1


