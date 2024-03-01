Return-Path: <linux-wireless+bounces-4302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81F86E672
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315B41F29DF3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C2037701;
	Fri,  1 Mar 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D/1LtdOw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E32F3E
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312002; cv=none; b=Y7UPqXLLY1IwdjPJ0wnZlMzPM02iQGdsNIrSaxd+JKd40dZWSJ7eqaGiCKPANi95rxyRPeS4w7WzWD5+fGhjufEmvjCuvXT+3oeIIGWKcSma4n8PDL7F3t5zoXFvUhW84+c5Ak3q/dghK6lUqnQZZf/oEs9ixm4xTNoigtvjxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312002; c=relaxed/simple;
	bh=x29LZAp7d38sGoPY3cRrexJU86X5m5F02452CzcwZ9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m2eh/HBIaQvaKqffIwIJ2amPWKKibm1/KHpojNqiT6U6dpPr8WJpOEWffZYtUT7XIKsSZGTXXb8HlAlPajZBbg0D+ZoLmndUo8BTBiw21A7NehU5i7gCliapChu7XPvgXkau5tNi+KkJt1oVpLtnVq3MtMiDCpwwZIUMRhuKEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D/1LtdOw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421F1HWv011155;
	Fri, 1 Mar 2024 16:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gSI7a+FME0r5JfS4mRlk0m3zVoz17Jebk108aGve7yY=; b=D/
	1LtdOwt/q5kRjHFOSXSxtp4OkTIEGgpIX93cHAw4OJ0rp/rma+QYp9ycAH1pSX+g
	rqBP/qrMveMQ8f/cUI1BvvxdFAMP8AQ0QZwIwJDn7HYnEQb4myyX4eYDsjpWt782
	6sB2f9ZEBrc7KkcBcEAFBenrOFuEHmSnnbULNu9cZYUkIkY42dnefxb9/R3Ugg2V
	B62s1wH40G1CV1QkqCjrJQgkJQzbM8ZKqDqi5SCEikuzcSfXiPG0ev/ySM7Sckhs
	rW9sYSycN9MOg3YMPEz5wlDULd1lmosynkdZUqPS3q+9humEzFdhZS0HD7wHrEK0
	UlJa0rncrYzwVIBgciSw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkh9rg8n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 16:53:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421GrFLO020600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 16:53:15 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 08:53:15 -0800
Message-ID: <6a91daf9-76ea-4379-8b12-1b9cb23b3869@quicinc.com>
Date: Fri, 1 Mar 2024 08:53:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: remove reserve member of wbm completion
 structure
Content-Language: en-US
To: <quic_tmariyap@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240301091936.12054-1-quic_tmariyap@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240301091936.12054-1-quic_tmariyap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EPY_dc2vQcVFAaJkaDEmy_gLL8kYu42q
X-Proofpoint-ORIG-GUID: EPY_dc2vQcVFAaJkaDEmy_gLL8kYu42q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_17,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010140

On 3/1/2024 1:19 AM, quic_tmariyap@quicinc.com wrote:
> From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> 
> In tx completion, status desc obtained from offsetting the address
> from wbm ring. Having reserved 8 bytes in status desc offsets the
> address twice and read the values from the incorrect address.
> So, removing the reserved 8 bytes from wbm completion structure.

Why not instead remove the addition of HTT_TX_WBM_COMP_STATUS_OFFSET in
ath12k_dp_tx_process_htt_tx_complete()?

That would remove an unnecessary operation in the data path.

> 
> Also this patch is applicable for WCN7850.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index eb2dd408e081..d01fc0b0c9a5 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -387,7 +387,6 @@ struct ath12k_dp {
>  #define HTT_TX_WBM_COMP_INFO2_ACK_RSSI		GENMASK(31, 24)
>  
>  struct htt_tx_wbm_completion {
> -	__le32 rsvd0[2];
>  	__le32 info0;
>  	__le32 info1;
>  	__le32 info2;


