Return-Path: <linux-wireless+bounces-17399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE52A0B03E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE31881D1F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76063C1F;
	Mon, 13 Jan 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QL/KAnJ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA9231A37
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754507; cv=none; b=VSu1fS8tdaE6cXDfnpkGCP/r0je/2mjIMo+f6jtQLBao7xfjVik1csRiceMP3gR+JsxR4GHa630VojmbIoQ3T4z+pGuVn8+hOTdAffz5ZjGKwrrRg/Sf04NsHAhyMtm9Hc9BkV3RpR0ZNQiX/Dsix+mQuatYTONzxuUgQg6Hup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754507; c=relaxed/simple;
	bh=7rWAtGIVp/0U1d5eAyz5xYWFnRVHTVx8p8n1Wk1NVh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xh3U/Pmtjtoiqfily8oX8f7Aqgf0B4v5XTLsum+/RR0vj/LPiXcL7x9UO0uUV23+UhRkfIYjqKhYKnp6BxS/x13IJhbd4dn4P3Sx1gvA9CcoK0N6dlm0Rn9tgQ9nXA4Ao6K4X5qyN+Gy5kz9RSeYiasihZhPLvUgsx0z5BORJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QL/KAnJ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D5UXCM013139;
	Mon, 13 Jan 2025 07:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jFdsP4j+uiy0hkzirS9s1L
	dEbo9qt2QOXpLaDHXjjdI=; b=QL/KAnJ/e/D5jyf3UrDCYu5a84te3j5Hx6AmAJ
	YV8TorzmDkYrqfa/Sj44SUgCrFZKdNwzT7DBULcrYjY2YNMyEaSNiYVwtL+HEkS4
	h58VcPtFuFqfnD0VZTFZyIyT6ZoYO6u/6PelWGs0rV2KR0KjoN+IQGZlnfwmDJOW
	lBiOMDxKGx+33kfddbHah1KmwSy95VYzt2U5lGZseBMMrNwxlDUNYyHHXZzkX/yN
	I1NeieRuatRmN9yFkAV9MxaDzReITjTqZBe1wM/gb8+qD0efv4LnoToFdoKtmpaG
	/yeOPY1xjvASuLkkrWI3RGuJvWLrmJ0Pu0bc5Wct3ug8Btgw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444vqyg9f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7mLoo008884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:21 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:48:20 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v4 0/4] wifi: ath12k: Add new features to ACPI
Date: Mon, 13 Jan 2025 15:48:06 +0800
Message-ID: <20250113074810.29729-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QHQeDTf7Gkj4AXBh8B27QvStAMonExEf
X-Proofpoint-GUID: QHQeDTf7Gkj4AXBh8B27QvStAMonExEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=827
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130066

By reading ACPI tables, implement a method to obtain the ACPI functions
Bitmap, enable or disable specific features based on ACPI Bitflags and
download board data files based on ACPI board data filename extensions.

v4:
1.rebase to 0c5fcd9069dd

v3:
1.change some function name.

v2:
1.support functions for cases where CONFIG_ACPI is disabled

Lingbo Kong (4):
  wifi: ath12k: Add support for obtaining the buffer type ACPI function
    bitmap
  wifi: ath12k: Add Support for enabling or disabling specific features
    based on ACPI bitflag
  wifi: ath12k: Adjust the timing to access ACPI table
  wifi: ath12k: Add support for reading variant from ACPI to download
    board data file

 drivers/net/wireless/ath/ath12k/acpi.c | 200 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/acpi.h |  38 +++++
 drivers/net/wireless/ath/ath12k/core.c |   8 +-
 drivers/net/wireless/ath/ath12k/core.h |   7 +
 drivers/net/wireless/ath/ath12k/mac.c  |   3 +-
 drivers/net/wireless/ath/ath12k/qmi.c  |   9 ++
 6 files changed, 217 insertions(+), 48 deletions(-)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.34.1


