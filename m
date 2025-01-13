Return-Path: <linux-wireless+bounces-17406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74288A0B12F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F5165F85
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4A2343A1;
	Mon, 13 Jan 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HdW/RfpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8F234970
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757248; cv=none; b=HcazXsn2iB1VrgPnLOX+My0KRuUfVJppAQqYZaKrjABpCmFUIhAeVUFxay0m7OjFdvc9BkuZ8dqxSGivNZgJOUVsM2T/IDdmiRdiZe8feVPsTiGhDxBD/PIzrh9S31k44i4SvGAWahG8hE26ntabXYH22iJZ+wZwDhzqcyWJpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757248; c=relaxed/simple;
	bh=ZvXNjkObedH+LLy0wIIbvuvh0KM0DN7fszUvg2nZ9Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XpSHN7CVPtpoZbfqgOM+SPxOMjoNaXU3thQQbsi5Y7TGbYGcd6bLui3jN5QnBwTjIIbro0a+gvx2WFlKsNj0aRHmxpm8nzYqp53SbJby83eCDOuFv0gZU6YT2Gis4b9J7C+yC8z7cZOr+BrqA/WZYieOnjyH45BPgQkn9dKFvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HdW/RfpA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D4WZEN007773;
	Mon, 13 Jan 2025 08:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Hhw5FdPcylu7DJ+Cu9qntkjqgKQe/3tRzTHVwMP7nY=; b=HdW/RfpAHeKchv3h
	QWV2+vJAt/jUWyzUtfyESIMM94K83MyvBneYfzpXvszgIJp1XWEgua6L6uCH529X
	1xF3a4iEEskKR/kRy6Bansc8YKA6shpesxC8UXL13aYZWIU7o9uFizqpC6OjTxSh
	Mz8C/h8uu6MDmJtaA3jBRuLJjM5ok54H6ZKc3TQSkn62ON8GPlKt5L3fwWe7Fq/y
	wmbET3OBRM1SKhs89dTSgPXraFKZNlrlJj1Uyx/VVtixbPfnaWFxV2OWZiaXilQP
	wdkKa1iMqo09MmdVblmtSRljF94hcMEPCTvAckIKqVZP71MPnAde4ibAE4PTrmje
	vaiI9Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444uw6ggbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 08:34:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D8Y4XC020568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 08:34:04 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 Jan
 2025 00:34:02 -0800
Message-ID: <552fd4f9-7787-456a-b6d7-de7b96fa60e4@quicinc.com>
Date: Mon, 13 Jan 2025 14:03:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and
 receive rate HTT stats
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20250113071758.19589-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xTEorYVU1j_cS-LzgRL7_dK8WfMZZTgp
X-Proofpoint-ORIG-GUID: xTEorYVU1j_cS-LzgRL7_dK8WfMZZTgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=658
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130072

On 1/13/25 12:47, Lingbo Kong wrote:
> Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
> Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
> Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.
> 
> v4:
> 1.used tab(s) to align the = to match the existing code
> 
> v3:
> 1.Rebase again to 48322e474f04
> 
> v2:
> 1.use TAB to be consistent with existing code
> 
> Lingbo Kong (3):
>    wifi: ath12k: Dump PDEV transmit rate HTT stats
>    wifi: ath12k: Dump PDEV receive rate HTT stats
>    wifi: ath12k: Dump additional PDEV receive rate HTT stats
> 
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 500 ++++++++++++++++++
>   .../wireless/ath/ath12k/debugfs_htt_stats.h   | 182 +++++++
>   2 files changed, 682 insertions(+)
> 

* drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c: 2025 copyright 
missing
* drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h: 2025 copyright 
missing

No need to respin just because of this.

-- 
Aditya

