Return-Path: <linux-wireless+bounces-13324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3107D98AAE8
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA65C1F21B33
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919A18E354;
	Mon, 30 Sep 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QKju5Dgv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B8273FD
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716654; cv=none; b=FH7ztIM58DRNWNTIK/AgjjNBjOmbWOcgHGcGjmZcYSpGGHBaXrfj3DU5pX2DxqWEIBh2pnhf/g7aT9v/ksuQSdwFKtJsMGnsXc1/06ZtwJucy8BO0KVY5G2oTh4sHio4sQ/GZEIprA0gl26/ShYjwC0kvZeW5RYqVXPcy2zO7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716654; c=relaxed/simple;
	bh=GzM2MdFtG3GtJKJMBnFoRu8uQnh2VSNDddX3lJWMbTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmLIH7QOqmB3a6/GWWBSqa1JicN62B7HrDrnbMup6WZGxBjMckyAYNoiZf8e5QNUqLMa/aKFIi1aVbpSZC1p9NCGp6wOq8loQcKlREKx0ruRkM2IqSSAmlgS9kRCucwEklL2qjd9HF5KLcklLZ6+IYxPhsv3wJ7f1xIF86VkMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QKju5Dgv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBLli3005873;
	Mon, 30 Sep 2024 17:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UQkpw8wl8PMhl5l0x8gdmy
	tVTNmheeG3TMV0WW4kSSU=; b=QKju5DgvIWjALYGB9Svkqwo4cXX9e+7tx7EBxN
	mlU4otuK6UW6wl9lfchpPdsd18HmSSGDwNSFbbxEA7lD/1zROGwhjpU9BFXIjHfj
	SeTsEiFIU42fRYazvPn9atGvNLt0RQOSRrPHvUt9awsqf/UosifrFH/7+sdiLZwQ
	yfnqReN+StHdKRWt6G8/MBOyKLW5d+rrWDSBxYbT8LJZl4QH/ZmASJ3KtxjMFWlu
	YKvabdsPwHsYw7EIvkuRtDXNP4aH8YC+/7S5Nz1vtgcLzKdt5Cie+JFVN218ouRm
	UAlq8QAZgffGdP6JeOLNdC+ZZz2PvnD5ihM7pOu2tKRsam5w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x94hdh3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:17:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UHHMd2015810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:17:22 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 10:17:20 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Date: Mon, 30 Sep 2024 22:47:03 +0530
Message-ID: <20240930171705.596703-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: 52cmEs87gT4FetidLk-uYNjD22lMmGtH
X-Proofpoint-ORIG-GUID: 52cmEs87gT4FetidLk-uYNjD22lMmGtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=615 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300124

Add support to request HTT stats type 49 and 51 from firmware. These
stats give scheduled algorithm stats and BE OFDMA rate of pdev, respectively.

Depends-on:
[PATCH] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/linux-wireless/20240730035154.3723773-1-quic_rdevanat@quicinc.com/

[PATCH 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/linux-wireless/20240913082949.573482-4-quic_rdevanat@quicinc.com/T/

[PATCH] wifi: ath12k: Support Pdev OBSS Stats
Link: https://lore.kernel.org/linux-wireless/20240919101812.941145-1-quic_rdevanat@quicinc.com/

[PATCH] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/linux-wireless/20240926051110.2477814-1-quic_rdevanat@quicinc.com/

Pradeep Kumar Chitrapu (1):
  wifi: ath12k: Support BE OFDMA Pdev Rate Stats

Sidhanta Sahu (1):
  wifi: ath12k: Support Pdev Scheduled Algorithm Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 161 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  59 +++++++
 2 files changed, 220 insertions(+)


base-commit: ced1f8bd64cda4e0c1df0890d1041cc6b18d5c77
prerequisite-patch-id: 970109034faa25a7630720c0da29c875e821f9ec
prerequisite-patch-id: 0bda913781a634c055869a033aa9b34d10825a20
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 121409543edef60c5f6144dd7ae3a615a78520f7
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
prerequisite-patch-id: 0537ae604d2617e42bef13bfb791aad4d11bf6e1
prerequisite-patch-id: da5a4e5cc3097994bfcba4b37680c90b0675ccf9
-- 
2.25.1


