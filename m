Return-Path: <linux-wireless+bounces-14343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DA9ABBC2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 04:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5271F24341
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 02:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C639ACC;
	Wed, 23 Oct 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aCcS57sg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE817F7
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651631; cv=none; b=Gpj6RM3h/Q66PrzCLpXumKuPCHbpYOQJ5Ps6mQ8tsYmc4ZF2qYNJu70iispGEje7pS73Xszt/kYXT6u/rZYedPapidB2NQIDQrWMmD2knMd0LlYmxaAnTnif2OdkOmku0LKMj6m1v4RK/4hrYNMOBQJDvFPuQap1BSf8fWH1YE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651631; c=relaxed/simple;
	bh=IvRY5e/yPZYk0k2RN7X4moMnf4jLrTjK3TRZkEyUwg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KejvSPmp7KIGyngnlDHNYK1AmeB+G7MRLZLkRjmbLafa+qw+ajggqs8K+6eYWqPJWdtaXgOwovvALk+NxuJdWRwsEWIFZpZffU3NX4QBQu2kweO7wXJXSYJYwJBC3d85AfcHEdWLljbJJV2MibkFAMK/GwSg8jA/Jm5rcVuLIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aCcS57sg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLa3ZI032158;
	Wed, 23 Oct 2024 02:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TARusI4IDj/kdMHvGCC6LY
	kTuP3tlp9cBoAfUt+RrHk=; b=aCcS57sgR46xOdaIQxig20nyHb306NTUmpg0qp
	wLJ37eVnx8ChMYBCl4dCWHHeNcbXnoBk2cIru3CAY0jq3O/I3805F4zqKb0VyLcd
	enB/t+HsVnGjRnhh0lRjpJP9VNcXvDF/B0FZ+RvpsH9E/oyG0DNnRn6DQ9VZL5qw
	wTqAFmmwYYuW3o67FVhvlHJzU2HSF4milAC8to7KOqyvVWq3rbg/aytHrbSBCKI8
	h2IJBD+CVyt7Ief9Ij22yrP9h7b9ZD9fkkQYhQtKaSh99z+Y8QXK0rPZeeuaJS7o
	xIeNjS7tTFWhDp6mR0SaUycBls22l/secmtkbnSG4wYXTk/w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3vrktx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 02:47:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N2l55Y019197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 02:47:05 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 19:47:04 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v3 0/4] wifi: ath12k: Add new features to ACPI
Date: Wed, 23 Oct 2024 10:45:47 +0800
Message-ID: <20241023024551.18966-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-GUID: Jc0fMD49_sRi_jXFzu5zSvA01UAL3Tjr
X-Proofpoint-ORIG-GUID: Jc0fMD49_sRi_jXFzu5zSvA01UAL3Tjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=831 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230014

By reading ACPI tables, implement a method to obtain the ACPI functions
Bitmap, enable or disable specific features based on ACPI Bitflags and
download board data files based on ACPI board data filename extensions.

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


base-commit: cd8aa3af7491a1f7a5b81e53dbe62a38433c2d4b
-- 
2.34.1


