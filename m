Return-Path: <linux-wireless+bounces-16273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBEF9EDCD5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 01:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE281880755
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 00:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D11A3C39;
	Thu, 12 Dec 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aBBtGqHP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E38558BA
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964570; cv=none; b=Em8QY5+WNYqq1WY87M1jOOqzLC+p1VsjLM0pU5bapgmcU/lpP+YJuf52tX9uN5h0khlIldTjaPCEslwwQbv3SzDEULvCTHuwnV/4w9jUe2atOyV8fVpweZKswpbFDHxCiYCHehFlkMPcCq+ejLc/R+IJ1dtDJPv1J5tZ2XMphw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964570; c=relaxed/simple;
	bh=7vq49Ulxac/8q5k9vO23LJHbDEUDA8e7Ba0zwKkCZpc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HVxCqqEB9YkBBPISMD1LdOXqe5mICtBgkSzyggVFKQenBuREUxK/rnm8N73oXw7Cuezaq8bCrvpIJgD2wz+bVDVJAIwcSiuGJb7+G/E2ZkUo4S8gE0mthKFesWFVEV2mf0ER+MXhY7xGyfWwSX94HGzqV+ZId4mfDvWYiTPWTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aBBtGqHP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHD1mq028278;
	Thu, 12 Dec 2024 00:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f+pKBFcvnNf7Yk68ACy5WP
	K5b/pzWqG3PCSE7wSBthg=; b=aBBtGqHPvArrOM5j8kWSPEJk0ZB93HzfcC5VI8
	Bq1F+CFZY9/bR4odkaTetHUledqkqxrxbihKavBimsXoDaPDZmWxWVSc2gxgBlAJ
	Hm/5fMAEbhkFuZRS/wXsvrmvYZN641O4K+w1tCNcwPd3a+dcHDXebgJ8/bcvez6j
	btL8tab1WdFmuBNVg1a1sB2QGXDtHWd8+AmwkdIHPz51CaiLNdHlgwA2UulQA/4f
	9O7HC4hskhHo3yeoEIfVv4rmASJaAmeyrYzXlCyEcPRvEZQzrHL4YfwjpM8Nc0DT
	syvCQebkzDiZS/Y69gSDyYWpELS8XaH9KHECVkXN06tgpr5w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xs9ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:49:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC0nMj1021383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:49:22 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 16:49:20 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Fix the static checker warning
Date: Thu, 12 Dec 2024 06:19:02 +0530
Message-ID: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fXAQTSjukuBRL-0uCvwouO8cl_0Ofikm
X-Proofpoint-GUID: fXAQTSjukuBRL-0uCvwouO8cl_0Ofikm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=498 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120004

This patch series fix the below Smatch static checker warnings

Warnings:
mac.c:10941 ath12k_mac_destroy() error: we previously assumed 'ab' could be null (see line 10930)
mac.c:11007 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
mac.c:11013 ath12k_mac_allocate() error: uninitialized symbol 'ab'.

Karthikeyan Periyasamy (4):
  wifi: ath12k: Refactor ath12k_hw set helper function argument
  wifi: ath12k: Refactor the ath12k_hw get helper function argument
  wifi: ath12k: Refactor ath12k_get_num_hw() helper function argument
  wifi: ath12k: Fix uninitialized variable access in
    ath12k_mac_allocate() function

 drivers/net/wireless/ath/ath12k/core.c | 16 ++++-----
 drivers/net/wireless/ath/ath12k/core.h | 12 +++----
 drivers/net/wireless/ath/ath12k/mac.c  | 47 +++++++++++++++++---------
 3 files changed, 45 insertions(+), 30 deletions(-)


base-commit: 4d762e0043789e3608ad28c102131b232bd04377
-- 
2.34.1


