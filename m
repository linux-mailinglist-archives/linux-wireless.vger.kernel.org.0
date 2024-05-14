Return-Path: <linux-wireless+bounces-7646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB98C57C3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 16:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0491F2271D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7458E139589;
	Tue, 14 May 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rlcb3pBT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30D6D1A7
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696107; cv=none; b=q3yVxJ2itoXYWcbVFqODTAgrM5UwAoD3tvAR7u1WI8RIJ3nuMX6NBEGLnk4VPJbZtrM36p9/MYXMm17+xXYRQPWCj2gRU6r2WXu/o7zeOvhvTJFPly3pqWWFuQ3XwE2f+cObkNeg0OIAL3zUiFfUwZuOZqsfu9VDA7wrGSuIur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696107; c=relaxed/simple;
	bh=63TGRItVqxAMSsgXgaUdugHPbHm+vEnmBYctB9kpC8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WS3YWT4GSeSPT4UJ34MnE7HxTt9k6JMr7ed+Sk7Z5obT+QTKpVemAcEtZF67nMkPSELnHpg7rvCYuJhMOObeMRouGPu02KgmRQ+DeGLDD2fPH0X01hEtGX5jHlrRIaZguOfASwff1E4JpzCFPxfJLRrxxbV8ZmGeV8N3KssBLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rlcb3pBT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44E7v3dl003261;
	Tue, 14 May 2024 14:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9TVr8WF8f64mUjwTGcREmUEzVhnHI6tAsqIWHFL1frU=; b=Rl
	cb3pBTl1oXZ95NdV6CwNPH+fySVlQLvMamGHznfPUl9ceEQG6A/Fw8XMlKgU5fe4
	BCG4p6tz+EOilI8EpQ+FeZfAvdhfJHM8oUW3wfKRjDY3FdsuQ2w3kmR5ajG/mezB
	NiHMB/PGmfBpmmiEn0NNckpdi0f8Vf3n7Vb7jp106fKMbIbq5S+qGm6peLrbIcAr
	0bF1bIAJGBACD48bEaUT0EJZDx048LXvf13sJYYhpFtmuQkJhRbE0u/jqUY3E2zp
	L3Z/RjvZH5+BU3qYhyPvJvA77WBiHZVaZdRc+dwYV/Lz3Br2zoXInmHy2aXKueEJ
	STo0LhB5o3u+Ck4APYpQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3j28k3w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:15:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44EEF1RP014665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:15:01 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 07:15:00 -0700
Message-ID: <df076b8c-dcb7-47b4-bf2b-b56def3464d1@quicinc.com>
Date: Tue, 14 May 2024 07:14:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: use correct MAX_RADIOS
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240514063412.3483723-1-quic_periyasa@quicinc.com>
 <20240514063412.3483723-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240514063412.3483723-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bX8_iBHu_UKMtf5_m_4eyX3iKqzl5JoH
X-Proofpoint-GUID: bX8_iBHu_UKMtf5_m_4eyX3iKqzl5JoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_07,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=710
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140101

On 5/13/2024 11:34 PM, Karthikeyan Periyasamy wrote:
> The current value of the MAX_RADIOS definition is 3. This is incorrect
> because no device supports more than 2 radios.
> 
> An incorrect MAX_RADIOS value can lead to:
>  - unnecessary memory allocation for pdev related entities.
>  - invalid pdev id validation.
>  - Misconceptions for code readers.
> 
> Therefore, modify the MAX_RADIOS definition as 2.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


