Return-Path: <linux-wireless+bounces-10295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED1933BE3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 13:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11D3284851
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05517F4E1;
	Wed, 17 Jul 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ceQL6L9V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96B17F38D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214645; cv=none; b=Eadpv9G1EnpCRbNdBOUjuA/iakrrCClmaKK0iGE4OFxGX4k1FYrTv/oCYkm2IzJFTUaORlxDaCdVL/ypKaHvTR1tIu11XceecGUWGi57h6BFrKv+Lb50QRM+THxpfb5hEOoBNirEi4S+Uodsw7egngwKS03miydow+Ms60GY5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214645; c=relaxed/simple;
	bh=K/8TqlQ4jp6wUoHYqahOezLgmrjJff3D4LkMwYb2fg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+OtMW/TM45GVLaVgMc+6jvyqFRQMUlFONDSLa1fvDFT7Gm02mj0ZhSx3tBGsp87t7GDP/9BM3b2AP5vpna17dUl6sTbiWA9g2ty2kYY8SJnRf1anV1KatnldE4jyTH2RfIUiGPWYPgPI0iw51xkU9Wj5TNuYCjvXQBVWy/QsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ceQL6L9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HA3f3a029089;
	Wed, 17 Jul 2024 11:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E04ZKLOlXxgqXdW+fo+vPg
	LIbfIHBVnn7D2L/zU6R14=; b=ceQL6L9VBbhhzTrP3cx8G3pyhqQ7w1/+bPVRcB
	jCZGzkPR2DLJW4y7wFRe65bVlt+urWb7q26qQSMopqX5NV5UBn/utBBP4bq+ptJm
	aAUaEPw6Fik2pC7Cdx7BO1gggSu3vkarTbiFnEJ9OWIZ5fiuqc4NR/cjpyd06h/A
	4oPxqF+Q5wINGfeuIJ5mSsJgD/6Z6G5RzIiEOmVtR5kOUUooRfQUp5xX49on4XBQ
	vXBphz9E2lwf5/Ayl84MPb5Vcd2marBX13V7rFiGqXvYKbQajj61oeVTsLYG0eYg
	/Di4yI17rhs7c1xHJ/Kw2xMkKSQXxbIwSZNltmNTJ5P9X1bQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs256m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HBAZLK014204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:35 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 04:10:34 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Add new features to ACPI
Date: Wed, 17 Jul 2024 19:10:19 +0800
Message-ID: <20240717111023.78798-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1_y74AHeQuTF9gDQgGsgj3JGmA0_tZyh
X-Proofpoint-GUID: 1_y74AHeQuTF9gDQgGsgj3JGmA0_tZyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=691
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170086

By reading ACPI tables, implement a method to obtain the ACPI functions
Bitmap, enable or disable specific features based on ACPI Bitflags and
download board data files based on ACPI board data filename extensions.

Lingbo Kong (4):
  wifi: ath12k: Add support for obtaining the buffer type ACPI function
    bitmap
  wifi: ath12k: Add Support for enabling or disabling specific features
    based on ACPI bitflag
  wifi: ath12k: Adjust the timing to access ACPI table
  wifi: ath12k: Add support for reading variant from ACPI to download
    board data file

 drivers/net/wireless/ath/ath12k/acpi.c | 175 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/acpi.h |  20 +++
 drivers/net/wireless/ath/ath12k/core.c |  29 +++-
 drivers/net/wireless/ath/ath12k/core.h |   8 ++
 drivers/net/wireless/ath/ath12k/mac.c  |   3 +-
 drivers/net/wireless/ath/ath12k/qmi.c  |   5 +
 6 files changed, 192 insertions(+), 48 deletions(-)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.34.1


