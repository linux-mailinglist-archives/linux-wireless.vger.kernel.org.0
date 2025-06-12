Return-Path: <linux-wireless+bounces-24028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C4AD662E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 05:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91233AA39F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF813C8E8;
	Thu, 12 Jun 2025 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m1nuZ1JF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B234C85;
	Thu, 12 Jun 2025 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749699019; cv=none; b=MYwMjx+IpWtr9ib1Tnbe3Hqk8OUDLp0CjVDOj1POLFSVUyz+YjRzTCbYmpZ89SMtCUkSgY+5saWWj7jiPf7sjObTPbzwJ5Z5KWEA/Hdc9FCmP3zf1sbNwNKK11XdVcz5szdeZRGlASo578JcqJ4sCENq3F92wOEy7gh/fMPU+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749699019; c=relaxed/simple;
	bh=sFhafIeYVorT4nFAM40q5kN48XlN0gqFyb4x3LxYvIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mWETbsAg/h6vAacderbewsuUHa1xwX5D+UcFhGKjsOXxUT8/BXxS4GgZn0lf/rT03AJIjGHeJWCUc4d1dEJIJRpCaa/JXkKkRcsmTAjEgRf7Ogj6aH7PiaA4jVgE9Ol7ROss+ifNO1hEkv9PoA9BZduaodguFqaWw7mjKEvt4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m1nuZ1JF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKE0fR009047;
	Thu, 12 Jun 2025 03:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUCmIkuG3LMH9a7Icoxvvg0hF5IF+P9HedQ3RXmEk+I=; b=m1nuZ1JFEVSb0OjI
	Dv1fkcYzgmmuFlzCQAAWvGJT4I46NpLUXtNvy+pN3Kw7YGaGizjTRkI5p2hy/+oi
	mDfkUE8LL9N/r3BaGqVlo6OvVBHk979np+pWEEjmTkhrVk+OLQUIoS5KCiH0Ng7B
	B4a+hpVVFvl735RQiRUBB00uEqU/nUHEJ8UNNjiIyPdNs995jKuqbAfRQDAHc7pC
	eFO9ipVjKl/+Cpu807L+ddDbkveNouJbKOabiHOclHcTJ2rW/3+8hSSPbLZgprAx
	4bjJXw2cIBwwHvSWTfigSSpNMXNpp1nEHRCjtz4GsXmne15BVCO8+iwd6tPKwqww
	lRjX3Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47753bu2ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 03:30:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C3U9jW020405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 03:30:09 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Jun
 2025 20:30:07 -0700
Message-ID: <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
Date: Thu, 12 Jun 2025 11:30:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250529035708.3136232-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAyNSBTYWx0ZWRfX3wyDGGnaofmx
 fCo3ClQLviBvchRWtsKcgrwJkJYr/9SZFTyvooh367ldIQBIWgxYd2rKax7BSVR6dvzffqEPKgU
 +GDa7xlulMdg2SwyM0SAeq6H9G29tTeQT1YlJJwW/VMS5zhoDJPliT8JXmEQNTf632Iqi8DSbcT
 Qwx5F3XMU4GdXfhDDb04MMactXsJp+tFlqjnkXQHg8tv182GUdcvy2BBwio5tfIgSEM055sSUkL
 0llFbPdyhNq9GFZt/v/t0VNafnfDc9rOpiKXBqqDaY4D6KRwyWOSBle2s9ZUfL7jgeqQuGFPmfi
 3TgauskYBs3yoSZvB7CK19lthXpa2Enob5y0RBIBo3Kxx5+aUoGMk/96D9gjouv4YR8Qmo98iyK
 dQdBwOcjWPLna39sAYoOQF+Ytd3khLVlsu+ZQmArQY22u2BcRpbJQnJT2QwRyIK5eKRFO0N+
X-Proofpoint-GUID: q-cGVvltXL7RH_HEyrWg0cT_9zScCsWN
X-Proofpoint-ORIG-GUID: q-cGVvltXL7RH_HEyrWg0cT_9zScCsWN
X-Authority-Analysis: v=2.4 cv=SqOQ6OO0 c=1 sm=1 tr=0 ts=684a49c2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=cm27Pg_UAAAA:8
 a=jT8QrNtKxUptj30f8HwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_02,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120025



On 5/29/2025 11:56 AM, Sergey Senozhatsky wrote:
> ath11k_hal_srng_deinit() frees rdp and wrp which are used
> by srng lists.  Mark srng lists as not-initialized.  This
> makes sense, for instance, when device fails to resume
> and the driver calls ath11k_hal_srng_deinit() from
> ath11k_core_reconfigure_on_crash().

Did you see any issue without your change?

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
> 
> v2: fixed subject line and updated commit message
> 
>  drivers/net/wireless/ath/ath11k/hal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index 8cb1505a5a0c..cab11a35f911 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
>  void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  {
>  	struct ath11k_hal *hal = &ab->hal;
> +	int i;
> +
> +	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
> +		ab->hal.srng_list[i].initialized = 0;

With this flag reset, srng stats would not be dumped in ath11k_hal_dump_srng_stats().

>  
>  	ath11k_hal_unregister_srng_key(ab);
>  	ath11k_hal_free_cont_rdp(ab);


