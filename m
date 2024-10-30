Return-Path: <linux-wireless+bounces-14753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0CB9B6E2C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 21:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D11B214AE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B301EBA1B;
	Wed, 30 Oct 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z5bPi4aG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FB19CC24;
	Wed, 30 Oct 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321742; cv=none; b=drH6NdO4McTZObjSGjXiur1DyxSCQoAqzj6mHnr2aJYEAzt1gjK/sBSLBUXufkOYeJd3yFJScL3tEoTNj/Srood1qX/CgqyX+Ocfpvxn1+pJ1cLSPZqjEX/CJEqNhaiqlmY7iGvhjBf8c0QaO+IkfMF8q5U73tZdEAi9IKQNDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321742; c=relaxed/simple;
	bh=UTtlS48Hah5u7GdMzBlAhIwEqhmJZ1vHStfGamKkCnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D0g1hVaRc7HuvEdJxqmX0DMMKxtzN4ZiSDX392Jd5AL+JN53ZYPOzT9DP8pkvrgldnQ+CtVW9Z/V4HxE4eFVzrjmTBIeem9tCNyJJSxEyNDFZpt861V5HobqJ6XpjMU1qG4s0HmU1D15JpVSRsxrEeC30+cmgQiLFkDjSky1eTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z5bPi4aG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UCFS7l002341;
	Wed, 30 Oct 2024 20:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cq83RRr5iVH8Pk8KHhiMY95wpAhRPW9zl0sq+dBSCfY=; b=Z5bPi4aGSnSZvzRD
	LfUZwu4p29jNuqJ5JNeKOoQPes8Mg9QPIa07XPCmbrmwvrKDi8LZup0jdZZwCDom
	Lw5XD4i3eZ+5kmlCEcs+2VZr4/DVG44E0FFNR1lp26nLs1m1fmjLMa8ohba89uDb
	s6f7J6+WMR0LXbL8rg1+whyTwJn4tOAlie1H8m53XIWpjgkd0LmpHarBCfc0sLfi
	tCFZKzF0LPloa8bunSDwnlElW2UUYXXHuFIHIc7pggk3fNW3vMcJ4sGwparSYYTI
	L7nhTOHTQZ+/u07FhKDlpaW6LcEf2GNv44P4f2FHH2rs5HD4cT4fuhHgeo9gXQd/
	Rcnh1g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmn59c63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 20:55:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UKtVEa015633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 20:55:31 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 13:55:30 -0700
Message-ID: <eb39e027-7ab4-4062-a895-cac28d37a8a6@quicinc.com>
Date: Wed, 30 Oct 2024 13:55:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtw89: 8852a: remove redundant else statement
To: Colin Ian King <colin.i.king@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241030131416.3091954-1-colin.i.king@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241030131416.3091954-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YeftvneLpOBtWqNLKq3MR592dcrfa5bE
X-Proofpoint-GUID: YeftvneLpOBtWqNLKq3MR592dcrfa5bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=733
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300164

On 10/30/2024 6:14 AM, Colin Ian King wrote:
> The cascaded if statements covers all 16 bit values in the comparisons
> of dgain and the last else statement is not reachable and hence
> dead code. Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> index 9db8713ac99b..f3568c4d0af6 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> @@ -2248,8 +2248,6 @@ static s8 _dpk_dgain_mapping(struct rtw89_dev *rtwdev, u16 dgain)
>  		offset = -9;
>  	else if (dgain <= 0x155)

should you drop the test and unconditionally return -12 here?

>  		offset = -12;
> -	else
> -		offset = 0x0;
>  
>  	return offset;
>  }


