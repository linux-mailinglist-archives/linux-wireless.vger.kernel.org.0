Return-Path: <linux-wireless+bounces-17773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF06A17996
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05669188BDC6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87061BE23F;
	Tue, 21 Jan 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MSMT6ocJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7F1BD9CF
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449627; cv=none; b=OQ1gC4MasEvP5TsfWq29lCQydU5QkeEEbduf1EH6F0u841JYpCJRVOV7U34u+Xx1RxA7Xjo5CrPsKt1Cs56PEI4wI7Cf0r3qEbSViDe/UkqLlk2ZHKgk628nhdTluXffRjpbreOJ8o7DdfD2xIeERuxKG29qTU2SbBTblHUGvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449627; c=relaxed/simple;
	bh=emjD1oeZJ8298wHBN2rgGcUuUESW0jqYdkq9GfQR73A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L2Yl5FORnT05x3XCFlepy9D0wMu0gx0clSReEgjhNEVtzSyOsqHOme8NOzZkB3zI+FsruGvEhpLB4XgAv7NpVwK7QgLjKjNMvtdZi38Yrsg0Z8KIhbX54LbmIBx2CsjDzzyofbqOc3K0n5djaiD7AFS6QtTzu+g8FuiZ07I4CKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MSMT6ocJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8Yq05021243;
	Tue, 21 Jan 2025 08:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FxwHosu5EHHWe+1t1iq/g+ZUE0hsaNPNud9AmIZfvIw=; b=MSMT6ocJ/YGE1S91
	ILPXaeZ3yjb38D3USaVO5gZ46bejYjrPXxqf0NoU+9HtywBmef3AApYsAMKTTYZx
	VJAIGULPUhKaxYSsdEryZ12blfYs07/tCprOXdsFQpmUl8nnlRppiTMXxBC9XVXP
	b29fc3dMmDwMcqi1RJ4O0FAzIPjV1SLYtL3vX7JLhJFy7DWuEAy+9gN96UXdtKyz
	4T/U0vNEZF+kR6zi2x25UU9N1RkRBiqwVRixf6z4LCGHNXsxfpfEzFtbrQy3m9be
	mdBTMdNYvJRsGKzs7GA1kZEZ73ZOKR4YRS1wbBm+5rrcJpzTfpe1z8OmJc8AajX8
	3IkhFw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a7nt84e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 08:53:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L8recx019110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 08:53:40 GMT
Received: from [10.216.5.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 00:53:39 -0800
Message-ID: <7bf33a7e-c77c-a99f-bffe-2501f0971b2e@quicinc.com>
Date: Tue, 21 Jan 2025 14:23:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: add support of station average signal
 strength
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250117172819.3357534-1-nico.escande@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250117172819.3357534-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LiEixLcghfOGp1IaXfdhLekU0M7XznZ_
X-Proofpoint-GUID: LiEixLcghfOGp1IaXfdhLekU0M7XznZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=760
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210072



On 1/17/2025 10:58 PM, Nicolas Escande wrote:
> This adds support for reporting to the kernel the average rssi. This is
> done the same way as it was done in ath11k. A simple ewma (with the same
> parameters) is updated with each rssi update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h   | 5 +++++
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
>   drivers/net/wireless/ath/ath12k/mac.c    | 5 +++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index ee595794a7aee..9408d8a528580 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1,3 +1,4 @@
> +

???

Always ensure a clean checkpatch run.

Vasanth

