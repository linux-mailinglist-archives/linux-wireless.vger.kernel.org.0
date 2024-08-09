Return-Path: <linux-wireless+bounces-11158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA994C8A5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 04:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86516B20DC3
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21D179BF;
	Fri,  9 Aug 2024 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ps+EMDGV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFA168B7
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723171886; cv=none; b=GuwpU0V2QDFJ3AHQ2GOseSJtLyRUO4Z0n/SBD19cAV98l67Z+Q540YTeBtkWUhjYqk2dFtze72cHxHEHW6xQlqsC76QStLh+SedXe5b3bO6uJrrZ/Xjig9ehleIa2E11kbhUsMU2i6dF61SA/dRCKfcO7JfnK7YNRDI3R9i3rU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723171886; c=relaxed/simple;
	bh=zgOwcelN2OOsml6RDzN0V2UXMsx8ubslpg/rJPPSb1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cr0hDCrqCy9u1aGo78YfU82ReIoQeWPe2CZzqdF3cEtk9i0t/scPC0nhm3Lc53nuWvRAJbzmPwk9nNHcw4BQOgXCryljhj4M5JAylFRF8nGJxKcpBwUs17J1+JrNNpRxMI9zO/UpIzkfv5qxdXP7Zv/JUlh2L/MovYt19OKY+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ps+EMDGV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4791kQKs006827;
	Fri, 9 Aug 2024 02:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MatuQViqmeLAQYZVnqC/H0
	roPpOjQdJYAd8IwyUywNg=; b=Ps+EMDGV3uX8J2Fto85Upsh5SxdHBITJ0FCRmP
	cKDJcyFphgoPexWsAzuJeThpNuvp9ZcSY0vSXa5m6EeWTxZ6JrejE7kCpH/w7gvo
	Q3smjjD7z1N5XrgDQenC+0tpjRe4Bh4JBD+opG25aRa8rNp0QSN+OEydnfpYX6JR
	XMMqL1bGExdOFUgGlUzyOsdZdlsCduphrcv7MAFwevzIo1KQYspdWGw7ETCXfsj7
	TA+WD5/3Sl/BtyjshSpTf7uCyO3dAq19ekSZ8WiwWwRTxzggz6XMu/Pwesahp9Bz
	poVsB05Nki+XwzI6MF5ld9BC24ydw4mk9jbfq9GCdNEM31jQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vuwat88f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 02:51:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4792pJWN032340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 02:51:19 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 8 Aug 2024 19:51:18 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: Add new features to ACPI
Date: Fri, 9 Aug 2024 10:50:51 +0800
Message-ID: <20240809025055.6495-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mEarZNM052aUh6RXabF0yT63TQZOo6sG
X-Proofpoint-GUID: mEarZNM052aUh6RXabF0yT63TQZOo6sG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=815 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090020

By reading ACPI tables, implement a method to obtain the ACPI functions
Bitmap, enable or disable specific features based on ACPI Bitflags and
download board data files based on ACPI board data filename extensions.

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


base-commit: 805781bdcbc4dd736770542e1d8da80d05a2e121
-- 
2.34.1


