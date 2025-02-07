Return-Path: <linux-wireless+bounces-18610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF087A2BA77
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 06:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A67165F5B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 05:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDF17BA6;
	Fri,  7 Feb 2025 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uabcbop9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2C2417D5
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904640; cv=none; b=PoKYtnuVNwZUY24XoWI/qBi5TJxbEatpdAnKilJWhEVtRy8Ars1JYQWGAHjRRoniXmHfPkB061OcJ5uk+/bF+rmXPOYL5msLC4g/naqEtRk9YIncQnbWMTPFmajOx/K6Wei3eBVVoLQpmiE44NnZkR6M+FoF92b6quhhdz7n5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904640; c=relaxed/simple;
	bh=9cqOX2JonG9yqono3aP4wx5QBtJEJC8H1fTON6ISEGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fg+6A1gkFrbcZGIvqtjP3mL2sGocXGpD2Q5mc3PrlqgRKIdH6ztXshNaa0JJ2Tn/y/H7uJAikR1dDHOn7cOBka8p3mNlJkliFRgbPY2kKNjuumvpRrzwvkK0CwdkrxGS59vkQdQwjt8qGK9pChRo7zwA3q6UZX5WOv2B+M1aW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uabcbop9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5172xlXi014297;
	Fri, 7 Feb 2025 05:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FsadaE/ss3PMP/OsdyT7bV
	lZLChuHO9tl87MCpHq/ok=; b=Uabcbop9wvwA+GmLfSIQewjQdRbTrfl954DDg0
	Tll18VuTjNyYGAr0QhUlIOxL3GvofeqyIsTXakKLTiVqO4A8CbdlTKYxsBHH+T7z
	SuM6OIpFOKTawi/BlOt4Of3ghanKu04ivzRleLqJDMJ+VCWVOwgZp73xdBns1pXG
	ex4pMfjFLTVvNSpNrQWkRDBDg/DQyqulu2+yxHTkRCODACf1NYwMpS5SEi8c5rWX
	nQ1sn2/p/GzAKjj+wqRI6JM1r9ru3t4XofgIQCGLY6Z/4X/7M73dxtoCbAcY3N2B
	6UQ2/8dW3vd+H4UeJTzkxxi58JDKWx/74MXaKb9ZuQwWueDg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n9vq08b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 05:03:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51753lvA009501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 05:03:47 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Feb 2025 21:03:45 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: MLO setup for single split-phy PCI device
Date: Fri, 7 Feb 2025 10:33:24 +0530
Message-ID: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Af6hsPy0w2z2B7lURiUPWi9ljRdEKzqF
X-Proofpoint-ORIG-GUID: Af6hsPy0w2z2B7lURiUPWi9ljRdEKzqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_02,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxlogscore=466 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070038

The single split-phy PCI device can establish multi-link operation(MLO)
within its own radios.

Therefore, enables MLO for single split-phy PCI device.

Aaradhana Sahu (3):
  wifi: ath12k: Enable MLO setup ready and teardown commands for single
    split-phy device
  wifi: ath12k: Remove dependency on single_chip_mlo_support for
    mlo_capable flag
  wifi: ath12k: Enable MLO for single split-phy PCI device

 drivers/net/wireless/ath/ath12k/core.c | 46 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/core.h |  4 +--
 drivers/net/wireless/ath/ath12k/mac.c  |  9 +++++
 drivers/net/wireless/ath/ath12k/qmi.c  | 12 ++-----
 4 files changed, 49 insertions(+), 22 deletions(-)


base-commit: d132a72d768bae74d10e6539fcf6522dfdbd1115
-- 
2.34.1


