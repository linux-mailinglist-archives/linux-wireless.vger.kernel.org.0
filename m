Return-Path: <linux-wireless+bounces-24922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A96AFC810
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5C51BC4017
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1A269D18;
	Tue,  8 Jul 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3k1vUVj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B0226D17
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969754; cv=none; b=mhlbuUbREPKdQ9Hzc9BpoW9hbpD3Iah33B4okxUEnFTdEo3u7iC+B8/Wx7PZgEj7mB/uqOZxR/dbMd9jfa2xNvejT6sSAILLgGf2AggxICucWMdE8UNF0Z43lMldl1fIfmr8TRWeOQV0YQnm4Y/e9ZrF481s3RcXwt1LIQmJTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969754; c=relaxed/simple;
	bh=4ItLoeTx3HRyKDPaO+sh4Kd3sq4cOgELPmOoot4c30Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukLc2kJG2SlzRyMYQEraP0IAUSt9XaccchhWlKT2bHnX9LyHwsLD4bfJrzppt9juvEyNdSsRvp0Ajk9Zdpq3MgENDxajriPRJkWFIVZ88rdo1SafR9Ilxya96dWO9gUycYXK+/RbtrmrScaih8z3sNrKI0u3vFSa3mpzfuP/isg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3k1vUVj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAYZv029345
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 10:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wAz8ZIHuo/SWeC7W3wizcPsD4EK5ykNZLoU6WzbK4q8=; b=Z3k1vUVja7wSnnnH
	IketGHiTgcMn3mY3jYohCNO+NLu0OEc70r83fThGNsYDQTR0ehReQXLYWJ8uGIt2
	WmaltGpHUiwLkIAIcNIQG+g67x6KooEIKbNfiHsE2of5ftzRhgUX4ru+7Sah8v0M
	zyvO1FcZ4trf1AvEQLHhcDIZCo+g3H1/uJOvK/edJEF5rB+JFDKm94Gn6BVkVWv/
	4tdYnf6ojHJ+cx3C3ACaoS4BYnU3ozlXQGHxamRdv2Hlk3aAuv4gO2u+g+sBs6uC
	/2vMCceBDTCaZZt15NJziT0oeKr4GQgLUy7aQkUVI5XQ+LP3w5/YIqfCGBSA52O8
	YztW0g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv4xvuvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 10:15:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31315427249so3834042a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 03:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969749; x=1752574549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAz8ZIHuo/SWeC7W3wizcPsD4EK5ykNZLoU6WzbK4q8=;
        b=BqM10qbftpUi06G5+LHBgNrLC5/KTPGxyhnDW8E6uQWe9g1hMWUR2HZ5q8872+VJ6u
         7AJ+pRYpxeZy/wSodI3I2HCGrJsGRiBqncdowu/CK+nrRTm9tW2NVNxBh6VtkXlCtpzC
         A7z4+FkzLBB8KWPY9+xZM0moEtC8fKHcNxIB4Khm9s7PHNI+7EdHjRHD1f6T2jnt98J1
         yy4ZvQBcNEe/9auDkmKt7UxCg7RB88+e3pYsUFe9HxnCsxMnLIHrXQE0B7vKV9cLeCkN
         3Voxc/SqeaqjHACLZDJQBmwQMa6fNcTDixVajDFvsZhtDNYhFX8yVw5gDkxMN46WJeWq
         VgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Lgd5de05rMvSLeR7MR6P56yESPn3oCELDYnRs6vg1s1R1mCyNOW3i4zX7y9ortKhuVhZ4Ooq1t7Y9wZs3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLdzqgJM6Ac3xVwJlfDvH/kub2VoQs0TRcaldyzQpib0X5DkN
	pQuZA25l7Kk+7gpYjftDWCoblkR08ylGCyrr5uLPyyoq5EhPd3lwQAguFHy3m4Yp4EVLzm0PDWm
	UC+kJ6wbAv6El8jys7ZTJeiG0g4gDsl9zrQ9qARLC768/6AKoPmYxfhpY1D010d29gAd5kA==
X-Gm-Gg: ASbGncvy2QXiChwzyl7ZNmbEFXRCqr2ye7TPQNXutAVNX9UQIElW81Azll4drCRX8bV
	wypEx7qncQGZZB2RyPSF6QWoCsjmV49yWRcuER8+nkkyl87nwjnnMcHqr5D/lxFnlTy+R19AxkO
	7LwxxY9OsQDt4Yebh24vkp3bmhTaS6CXKKnBivted2gEnCqXHdnzBnjKolZFgdot7Fz4LAfcCqu
	j1SBIvXzZ8k37eKt15Mhc3PLWGlaXPNfSvK2uJNZnjJOhdX7+1PtpMUlWy2k0c/3HU7Z8d4THHe
	CTaA/rGKYiTUqOo6xMFdAM0oewhsAE0WKSkmuX3EAvcpMMT3z7Ge
X-Received: by 2002:a17:90a:634a:b0:311:d258:3473 with SMTP id 98e67ed59e1d1-31c21cfbe1dmr2713725a91.13.1751969748728;
        Tue, 08 Jul 2025 03:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxrinOt6UxxB4i1n+mV0391ziMXD2TDdWIyM6jJWyQXxor+uM7US8wRj4S5OLlgpGL8Qo77g==
X-Received: by 2002:a17:90a:634a:b0:311:d258:3473 with SMTP id 98e67ed59e1d1-31c21cfbe1dmr2713703a91.13.1751969748239;
        Tue, 08 Jul 2025 03:15:48 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21d6797csm1746635a91.14.2025.07.08.03.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:15:47 -0700 (PDT)
Message-ID: <b72b3635-1c09-444f-98f5-30fcc219b297@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:45:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bus: mhi: keep device context through suspend cycles
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-4-usama.anjum@collabora.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250630074330.253867-4-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4NCBTYWx0ZWRfX6C1u23G3kgtI
 b3cyfbxkese2+Uod99NE8Rhr4z8xPdULjd43WTsSxxMMt3798te4R5jwfi/m5UQENZ83Z8QQ9JT
 O+/2eq9EuAxm2+x/bru33kovLnmFFRsNzKmksLJ/Hk9EuskyBJwuaTs+Z4U1/s+t0v6p80VMyf1
 vIweycONBpM3vVl9ku8g4E8KmTd8aDY9M0rx1WDBDhmLquNmp7x3FPkdMJBfsrg1xPhR28PIIaB
 DAgeOIXmaC8eITrh6jcTUNwa3jaJjk2jr9G4+jKjRnoao7+l5VyAQy2dme5tOeS60w54YPX208M
 4tZ0iWGFWxeV4Omo+Lux5Bh+27X8kQDVdTDoprlyZZ5mbfeo16aT6slEtZC12jcp/8w/gegxY4o
 rh8VdHpeTadrBDEFTO/sbZ60ZxcFCHY0lC2ab+ix2/ZNExvhu4+xGMKZMCXaLnx1IZkn9kSE
X-Proofpoint-ORIG-GUID: 3Tx4p21oND8QCCOhz4cA9l2kBZnoYzfe
X-Authority-Analysis: v=2.4 cv=DNCP4zNb c=1 sm=1 tr=0 ts=686cefd6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=bcI8x_0Kv5OOx9b6aR4A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: 3Tx4p21oND8QCCOhz4cA9l2kBZnoYzfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080084



On 6/30/2025 1:13 PM, Muhammad Usama Anjum wrote:
> Don't deinitialize the device context while going into suspend or
> hibernation cycles. Otherwise the resume may fail if at resume time, the
> memory pressure is high and no dma memory is available.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/bus/mhi/host/init.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 2e0f18c939e68..8f56e73fdc42e 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1133,9 +1133,11 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>   
>   	mutex_lock(&mhi_cntrl->pm_mutex);
>   
> -	ret = mhi_init_dev_ctxt(mhi_cntrl);
mhi init dev ctxt also initializes the ring pointers to base value,
I think we should take care of them also ?

- Krishna Chaitanya.
> -	if (ret)
> -		goto error_dev_ctxt;
> +	if (!mhi_cntrl->mhi_ctxt) {
> +		ret = mhi_init_dev_ctxt(mhi_cntrl);
> +		if (ret)
> +			goto error_dev_ctxt;
> +	}
>   
>   	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
>   	if (ret) {
> @@ -1212,8 +1214,6 @@ void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
>   {
>   	mhi_cntrl->bhi = NULL;
>   	mhi_cntrl->bhie = NULL;
> -
> -	__mhi_deinit_dev_ctxt(mhi_cntrl);
>   }
>   
>   void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
> @@ -1234,6 +1234,7 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>   	}
>   
>   	mhi_deinit_dev_ctxt(mhi_cntrl);
> +	__mhi_deinit_dev_ctxt(mhi_cntrl);
>   }
>   EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>   

