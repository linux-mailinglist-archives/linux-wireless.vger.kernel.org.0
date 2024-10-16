Return-Path: <linux-wireless+bounces-14032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5519A0165
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9220283D12
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC11494DA;
	Wed, 16 Oct 2024 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iT1RMR+w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4060B8A
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060012; cv=none; b=CzDGrsV8TF2GeVQe0nImlz5D3vLcE86RLaSDdNoRsvWMuuZt5xL7k92fPDAYES6ajMq2PKbDt4ZRTyxvVpZgKjwlm7T5GYeYf0zox+CdaJuf38HJg8mj5gPkbo9t36MmHBDhUtxl4eknzMzE1ygfgAt8dxbHKoBmnpb2CJfpyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060012; c=relaxed/simple;
	bh=3PZuR+NCOWZTk7pHUzCeE9rHNF1litpUTrS4OwbXlg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lQjThTE3CioGUr+F3TbE4dkrdSqJ/N6dEwuXg9A+TvQ6W5P+4iftXFJT3Y//x2luojx92kozI1KTHNo1CY3fP2BZ/dBPwc8clXcVYZnTkpntvuiuQRTth4QW200y4+ShhwCgBqEFfcgT09frru6PdJZUWOqiV1jnIM5fYkxLSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iT1RMR+w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G60G5P007419;
	Wed, 16 Oct 2024 06:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nH9zU1xKm7V58WPec/Zmbz
	DY+qNbOSNWp3wH+4m9xZg=; b=iT1RMR+wz3eZcARwFXsZFYAIHAoH2FtaI08jzy
	Mi/8fDwMjc5+sU0JsSjY+9hjT/hCu9zH080RXKidhcf4OcDWh7CWlVxcHTgT17c2
	o+Wgajcy1DpDMxFUcvQxGzCbSg8HeIpUH5/gICrVm/38lV+WVKWTY3mbulC1qjKa
	WPthNARld7l368SrDgPhe/fhzcfx1wKOSZxvrCHgNJ4dnsYcT0ZAGxeA7RCY+t2K
	7lCGFnF+R/DjYr3MMqaRYG0MLNBp+ahNk5a+B2Wuz7JisYvIf2X6uk3jN8OHlsmH
	7WavBOHkql3kn68130qasGokPwgpLktw1Xkb9P4hAfE2pDhg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mh53erg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:26:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6Qd4L004891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:26:39 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:26:38 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Support Pager, Counter, SoC, Transmit Rate Stats
Date: Wed, 16 Oct 2024 11:56:13 +0530
Message-ID: <20241016062617.2726252-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bDWXgOfvLzj3VryVQOYG8QRVe7Lli8ym
X-Proofpoint-ORIG-GUID: bDWXgOfvLzj3VryVQOYG8QRVe7Lli8ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=784
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160040

Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
These stat types give downlink pager stats, counter and TPC stats, SoC
common stats and Transmit PER rate stats, respectively.

Depends-on:
Depends-on:
[PATCH v3] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/ath12k/20241014065259.3968727-1-quic_rdevanat@quicinc.com/

[PATCH v3 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Link: https://lore.kernel.org/ath12k/20241014070610.3982173-1-quic_rdevanat@quicinc.com/

[PATCH v3 0/2] wifi: ath12k: Support AST and Puncture Stats
Link: https://lore.kernel.org/ath12k/20241014071720.3991199-1-quic_rdevanat@quicinc.com/

[PATCH] wifi: ath12k: Support MBSSID Control Frame Stats
Link: https://lore.kernel.org/ath12k/20241005112651.3379404-1-quic_rdevanat@quicinc.com/

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Downlink Pager Stats
  wifi: ath12k: Support phy counter and TPC stats
  wifi: ath12k: Support SoC Common Stats
  wifi: ath12k: Support Transmit PER Rate Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 625 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 201 ++++++
 2 files changed, 826 insertions(+)


base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
prerequisite-patch-id: d2dd6093ab264e75918406abce52bb9ee8199b7e
prerequisite-patch-id: fcd0ce1adcc63e80c95e4636bd4614bd5b732ffa
prerequisite-patch-id: a6303524834f6e01b2ae1469ee437d586dd5d522
prerequisite-patch-id: 1b0f9e702388d0121427f42e7b6a2bc090b62c80
prerequisite-patch-id: 00097b59822c40089419d22b97f109c26b7f0a10
prerequisite-patch-id: d3c55f51a5dbb58d547fe1c6b8a3ce10313bae36
-- 
2.25.1


