Return-Path: <linux-wireless+bounces-14907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C091E9BC46F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 05:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DD61F21D31
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 04:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B831D545;
	Tue,  5 Nov 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bk1R0Ayn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61476817
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782387; cv=none; b=JWH4zFQ17LGgKoU8YhSuBGlWdSaZ4ovrMfsRQIGJsaeTUT0i0IRWvmiXACDZvk8DnxGOsKI+t14qqSgjXtl0cjTrtz+y+lHeqvbUsfwhA05SwFnysTs+MWltQN+gDncyHxfLsKW87F7zcdmfV9uBJFPZ8X5ulPrZTlHLud5zg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782387; c=relaxed/simple;
	bh=1IP8LNzPaBfb5E8vrNg57Ld6aoRtJI57jgiqv07io4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GvbxcPbgC2/7l2Jo7wW65jvC78grq4qO6xiAxqCBvScisje3rDLEieAWr5y3jt5jc6ac7EDQQagxpFFbp9FFEWAM/UOMxDIVUpeVp4sdNtVT/CEY008VCPi3WQJkamtUydfCEo4p51qry/mqbbl59AT2551xX8cWWMUcGFkXNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bk1R0Ayn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LIj9q012130;
	Tue, 5 Nov 2024 04:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GhOIK0o10F+Z0TDxjdoohBKRTg4qeTp1vINVLgiL1FQ=; b=bk1R0AynVjsBaXjA
	bZ0ThQMHqgDx4V7huJDiQDVJvArJczvu9wzTqpxW78sDCHLWrkVcVfUK2HwYciVm
	4WTgnEjUkupjcLiMtyK9EIJmAv813aSjTmXk0tEQgW2buSrl9DSrdMK5hnrrRydZ
	nTiNPF34brsR3s+k0VE5gPSb0k2G50DkmWNY6BiqO3jj/Q356GPn9v2rR0+nmScF
	XcZkEOUcpnzy+4q9QY6l9fU+UhNnTZazUGytXbhidZSayjfgiFLTLV8d3NQdYkWG
	5gFwAj3s+9NiIrAODRkfz1doiT0/qNSXIhAHjuapVLuk+uf2wBPWyaG7mpxNeEfV
	WHczEA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd11xc3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 04:53:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A54r0O8025838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 04:53:00 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 20:52:59 -0800
Message-ID: <1149edbc-6440-4d4b-b792-2dce5be9a13a@quicinc.com>
Date: Tue, 5 Nov 2024 10:22:37 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] wifi: ath12k: Support Pager, Counter, SoC,
 Transmit Rate Stats
To: <ath12k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20241105041822.2039214-1-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <20241105041822.2039214-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7Gqd_rhOTFAigZ9JiBmXYq4fRSz4pCva
X-Proofpoint-ORIG-GUID: 7Gqd_rhOTFAigZ9JiBmXYq4fRSz4pCva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=989
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050033



On 11/5/2024 9:48 AM, Roopni Devanathan wrote:
> Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
> These stat types give downlink pager stats, counter and TPC stats, SoC
> common stats and Transmit PER rate stats, respectively.
> 
> -v2:
>  - Removed dependencies. No change in code.
> 
> Dinesh Karthikeyan (4):
>   wifi: ath12k: Support Downlink Pager Stats
>   wifi: ath12k: Support phy counter and TPC stats
>   wifi: ath12k: Support SoC Common Stats
>   wifi: ath12k: Support Transmit PER Rate Stats
> 
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 627 +++++++++++++++++-
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 200 +++++-
>  2 files changed, 824 insertions(+), 3 deletions(-)
> 
> 
> base-commit: e7e2957f403ba4655199f2ba9920c1a015a7be44

Apologies, seems like there are compilation errors in this version. Please
ignore this series. I'll fix them and re-spin an incremented version.

