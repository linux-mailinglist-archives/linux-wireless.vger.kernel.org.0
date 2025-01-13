Return-Path: <linux-wireless+bounces-17388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DDA0AFA9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7466188706F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F436231A28;
	Mon, 13 Jan 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Imq6CI71"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12B231A3A
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752329; cv=none; b=d/udIozdmUBwBzZzOcm9J+yVNcos5/TrlZgCNg0xSPa0WzDtd1XDxA3G6Arl5vXDqG5DXtS7mpwLL3FmRQm27Be48S8yERqFUHT9X7F6/JUStOyeK5+JKZQrFaz57sy02MmIYdi/tVdQg/xiERs8tLt2D5+obf+gKmxw0VOJSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752329; c=relaxed/simple;
	bh=XiNvhSaixhvgoiIo/TKefmeKVJDWqL/XsPnAzZJH5vU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WgSDgIYzNhh2qLR/DzpAprXicGWgpU+gsMTPUptw7VTHzDPGbMGk7WWwYLky8Nf1zslkEWiHoIuA4uYDH9xKcAgaH4HPuYsONiFFQDD/KpYkxtIW8fSyXzUWvehFwlCiZORjmvZr0RNHJk9JbetW6FlBc5TCRq+ksyNpOkhIhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Imq6CI71; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CMj5v8023300;
	Mon, 13 Jan 2025 07:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5oNnFvbYDC964ruS7cbZcr
	wpa9Cv6vpGbOuCaUK1RHI=; b=Imq6CI71QSE/MkEs76GlAgapbrvO1RNBcZbDIL
	vQRe5KrriahkbpJt0KtBNEODbSIPmS+qrQcJfbciY0fxWSkhVMs5R/AoCYp/ZttW
	wj/z3eToG8g0917bkbViyH9b79pOKc0zhqxSNKrJ5lC7og8Tu3ed6mZBlTqoMPU+
	iH3pmHKCPHjDsLpOAm7Evq0XNXp+8m7+TSszS5VoXJVL+hsNyDIWutXNBui0Hhsr
	R1/fRHfHzFpP9ZDDa57cnutNa0MaQBgNBQakbk7gx0gokYe4Jg8LZ2WyBZ+cZnEy
	oLoIRB7vTXzrJBUuROkzp0fqnwuC0gFXAx2hz95gn/IER+uQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444f5bhdjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:12:04 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7C46N006260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:12:04 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:12:02 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v3 0/6] wifi: ath12k: Support Sounding, Latency, Trigger, FSE stats
Date: Mon, 13 Jan 2025 12:41:38 +0530
Message-ID: <20250113071144.3397293-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: VME797TL6Cck81yE-bHg3MnCW4UEuaye
X-Proofpoint-ORIG-GUID: VME797TL6Cck81yE-bHg3MnCW4UEuaye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=837 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130060

Add support to request HTT stats type 22, 25, 26, 27 and 28 from
firmware. These stats give sounding stats, latency stats, trigger stats
for uplink OFDMA and MUMIMO and FSE stats, respectively.

v3:
 - Rebased on ToT.
 - Removed patch dependencies.
v2:
 - Added line breaks where necessary, as pointed out by Kalle.
 - Modified the use of pointer arithmetic print_array_to_buf_s8().
 - Modified commit logs, as suggested by Kalle. 


Dinesh Karthikeyan (5):
  wifi: ath12k: Support Sounding Stats
  wifi: ath12k: Support Latency Stats
  wifi: ath12k: Support Uplink OFDMA Trigger Stats
  wifi: ath12k: Support Uplink MUMIMO Trigger Stats
  wifi: ath12k: Support Received FSE Stats

Roopni Devanathan (1):
  wifi: ath12k: Add API to print s8 arrays in HTT stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 736 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 269 ++++++-
 2 files changed, 970 insertions(+), 35 deletions(-)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.25.1


