Return-Path: <linux-wireless+bounces-10507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5D93C157
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86391C21E3A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB48197A99;
	Thu, 25 Jul 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OwIDGNLJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47416C69D
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908872; cv=none; b=qD1wmOSsfLqpqxtDnWU5l1DJTxNjzYSnzBAf6uYZ6zLG6tiFU2YfjK+Mnbs+fz/k77q8eFUQznavUz39PrDyDcuJQ1anNMczSfhFhqvBdwcUZZkbxDUfXgumgozVO3ysS1WmULxBC70qF92wWd6l6i1IHLXxlXIp5cwFnmlB3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908872; c=relaxed/simple;
	bh=rCsLlbFDJW1HwKPNLLjb8ytKAuYqLXenhmAAk0HCs4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRhayUAENoHT21UfH8JLoSg61+BKlMf3VnC6Usm91FsEjkO/HLAAf+5xft4gwddzSuv8ahGyppDnzXK2s9GPiKADZSz7rfg1JmTDMjqnXMwxo2YK0E0AWGGKb1YES+THd7Si53KTWdUHVQFNyoaAfjoUf0xJr0bnFuPZ+j0yQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OwIDGNLJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P8OAkP010205;
	Thu, 25 Jul 2024 12:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8oJs4jKM64Bb4UIhzhy5Q7DGSrTTbVldln+tr59H8Do=; b=OwIDGNLJG62YEiy2
	/XyuEPcfjKX8iqZbVY4yOdsVM2Iww4w/rR5w4yzdbhYXreSjc9EHvmtA3TBCs9mB
	LwQPf5MvTjE6h0GL7SRoNj9zh53KH2sioizujPM6Qk3f4rUArhqeJCzpgn8flwNR
	UIRrUEoZlol/iLwrpAbyvF4OD1jRPlgrD0wlGWKiL2xwFXQj4+imhphZKWDVyNIP
	8A6wwCNv8aSUfrgjqGcDXKPJV4ppfpPoD9xPSpgJSRwWnlKIdttDKCbx6nZzkorL
	qnF61/SE+e2ekU1sdjikM9ORCkff1wUAHt2w8hTbRgT4MO5dLFbwYUQRhSpI0pcZ
	A8Dvwg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5auw5mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PC11et005910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:01 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 05:01:00 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 01/11] wifi: ath12k: remove unused variable monitor_present
Date: Thu, 25 Jul 2024 20:00:25 +0800
Message-ID: <20240725120035.493-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Pypnw9picooE8oSSx9Ew2ac1m9KfxUXG
X-Proofpoint-GUID: Pypnw9picooE8oSSx9Ew2ac1m9KfxUXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=807
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250082

From: Kang Yang <quic_kangyang@quicinc.com>

Variable monitor_present is never used. So delete it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cdfd43a7321a..00c96d839a77 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -555,7 +555,6 @@ struct ath12k {
 	u32 chan_tx_pwr;
 	u32 num_stations;
 	u32 max_num_stations;
-	bool monitor_present;
 	/* To synchronize concurrent synchronous mac80211 callback operations,
 	 * concurrent debugfs configuration and concurrent FW statistics events.
 	 */
-- 
2.34.1


