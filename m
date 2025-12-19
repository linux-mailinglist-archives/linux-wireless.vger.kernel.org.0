Return-Path: <linux-wireless+bounces-29929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3447CD07BE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D1630322A2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415AB33BBA9;
	Fri, 19 Dec 2025 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XAIIUyll";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HI8HIX9t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF133B6FD
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157159; cv=none; b=VVETVzbrJBOzKdUpy/b/OvMbnWh58pyT8CJ4X52/bHEwIQTMbdiWtgic3XYzVB5fmj21RD7O1STnSideffIH1hIXggjjEgDq1/GTrqoDfOFe50O8yBdpeX2TFCZZegIqw+I4BNEGqR0nbiNPZkMk2Jq+JBWHueANNRppZrcIImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157159; c=relaxed/simple;
	bh=/JuuJ80/2JmzLdAERQXscK3usPl8e3+MS+OHtghLXZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFmOL2nCfxxdbsS33fYmGSJfgBrinO+ebOnTc7Zw25CfspAVQ2VIkCCafrt6eMXAoGrJ5xu3v7ro2K0u/lgtr94GXlzup67Z29dWKLXvw6gaXOP4pYcUTVo5AQ3mmtFBnilV01z83jnofBZ2WBXQ/kjAfnngn9kXNf5OMZHhS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XAIIUyll; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HI8HIX9t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBl1ds1772623
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bx22M6CNp92NOPWcL8dLNXSRkv/cXb7NVqM7jST7eB0=; b=XAIIUyllsyu2sTCd
	nwSai7RADuUT17NsQCVYC3KLTpUdRiNr/cM6ArBb7BM/oyuVznsDlsHg9tOxA3O+
	UU7drEtMoBs6eghsoHo2pJfr7zj7CQNAv4YvkrqObmRtwOjgEJh692IXCbGc8egV
	2aRy4g1vWcD+Yl9w4n5FB4bhNzEnHOTeebgfV5tNTip/zrWGcM4rqLSOp0ZZzZBj
	uTvKDsiRF81LmJWXHWGSSsjqn58qK49T1oOrYUmX3o0fhIPZw7OJ5lXyTHIbfdMY
	fz8PgrJHLDdpJbgqQPR2HLcZ5E1F4GqFR26DUc8cqKaoPegQo5WTWl7SNFRSg7de
	FWDbZQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2bk2cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:12:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62da7602a0so2026370a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766157153; x=1766761953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx22M6CNp92NOPWcL8dLNXSRkv/cXb7NVqM7jST7eB0=;
        b=HI8HIX9t2Pq+Kyakyo0bu6x4CydVPp4WYW5fFtiXy4uzceq+PYmRGAxMOM/iIAu/ya
         pqx/4k5sG5pK3GCBYXTf7MOPA4U4irMAA0Luu10M5XxbCvTNSuhzaPG7qmLGStNMWdJE
         7Ui/uODVhuaqtTn9k6dH1/1MPiCO1sBtfR6zAcEoYY0Y34lsVS55aAR1XLcj5elczsoC
         JeIb6tfUHMvb/Xq2JMhBQKpIHTsTu5Gly3mudidL8VmCzEG+09VorB7WpI2RxCLzIdwC
         29LmdjgKze7lftotKk3kRHFtzA+p2f38sRzXcAdLJNMLPcmmabY9bxwz+VvxMhQbL/G9
         7H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766157153; x=1766761953;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx22M6CNp92NOPWcL8dLNXSRkv/cXb7NVqM7jST7eB0=;
        b=EiRYqL8/2iDw0Aq+rWFGr/ucyI0MaMQPVnsT1lZxSFeLtN9ViH0u2sIjTq2oS8H9hG
         /CsT/nviNVaMw+WhRgdZYSN4gkPrU1PjaAWTdqyKUl+lKzbR/NUb331GzaVrh5Ak51Cu
         CY9NmYuBAeKmpJGidxYygsZBsuucLfqu7AHA4wIeTRjRsr/0vcIaAG/Ug0HGvxE2N9GI
         ix66WKrYslE+X8G1y7mFDEU8rhLtPm669j8wL3ZpnYLr07dZCIYwAzBB8hskp86kPlNA
         l4okLINS2f1ZVTfN7QhqT6qR4hTxQ/D/QPDsYZhy3e+IFm5JH/yNrHVyXlr2W7foscH9
         wH6w==
X-Gm-Message-State: AOJu0YyegmRljTwIQrGC16JzOYX9Z3/oot9EXxzIoawYrBrGEvdmy75h
	Gn1fAoeQURgZCJXl8aUNd+Wm42caJPfdaLuJ1LzbgCf8j+eVvB41nIt0h4KpC8eXWhNSqdnsPnH
	ZY4y9zQKzT3/XT2vlVFiQ89Gkt/Zyne5wrBAY8gRCv62nvGmIbfOsZXf1/E3q6aQ9HlmQ/w==
X-Gm-Gg: AY/fxX6nE+P3id5CdPuz20EE7nz1/GoEf7bqngw1hXFjy18QNtN9A++nzv5L9bIunWf
	4+46PjHnMWWvK6lQRFFsGmopMEXRW05x0vJEjpHlQwrb+2HeronRv8u1VafZDlXU9ITspr8BXK3
	zPN62VBRCl/vuc59UozFLlD8GaRsiyKXYZBc8o9pCfmJdzBk55v+Ig5/Eq/B5QOiUFNdpCCeGaz
	f6Qv+DolcizLqlIL2h2nSzjnGgqKrzmD2dhmWY+zLl1dbxcRHa2F59tfveD9016dwtLvlbw5/Xn
	+pdHjhY2LS4kvUjSif2xxBXU/6r+YHSQLLYkiaj9RjOCuoD1mDNVZuHKWxYs3Xs4twr2pYHXILY
	MbB0bbopG2/wyheAjfs/Vy1yoJaDX1YRldQsiMBOw5ba1+yqzystR6eweFQjW8iYn9vaTpA==
X-Received: by 2002:a05:7022:5f1c:b0:11b:99a2:9082 with SMTP id a92af1059eb24-121722ab1eemr2157095c88.15.1766157152908;
        Fri, 19 Dec 2025 07:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3KNdKC5rw4p+eO5yo5suj6yGyxYbcXm7RK3HyaksW4UV/ZbKlcbBL/BPML/WSS5sJ1rIbzg==
X-Received: by 2002:a05:7022:5f1c:b0:11b:99a2:9082 with SMTP id a92af1059eb24-121722ab1eemr2157077c88.15.1766157152330;
        Fri, 19 Dec 2025 07:12:32 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm9323370c88.5.2025.12.19.07.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 07:12:32 -0800 (PST)
Message-ID: <72d6e9fa-fa28-4079-851e-00905a7b0dda@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 07:12:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wifi-next] wifi: ath10k: sdio: Use pm_sleep_ptr instead of
 #ifdef CONFIG_PM_SLEEP
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20251217111951.3309170-4-u.kleine-koenig@baylibre.com>
 <dcd0c9e1-66ae-473b-ad37-5d028dc1bc16@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dcd0c9e1-66ae-473b-ad37-5d028dc1bc16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I4bPM2lV-3hoAcvX0SIpU2ghAI6Tc1jY
X-Proofpoint-ORIG-GUID: I4bPM2lV-3hoAcvX0SIpU2ghAI6Tc1jY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyNyBTYWx0ZWRfX8sTNfzUCxm3n
 RyBzFWdpsHJqHLd2e/12IckIHAiybutge6gjBvwsvmtrHdfgVl5ixLh+iOE83olboGBxKTzJxwI
 HmyhFnoH9M2wse5133KXXVIpez5wdZ87/6pXTcPrH3Qt6W8xUKEMSoFx7NfLV1U0s0cHJsOl7aC
 pQLNSBdJvI/V+A7tISRv3uUptHFZ7MWPInpwgZRTClx5CVxK8biUqHkdTIrgvSXSP6Xb2fJC3Gr
 5NYXmu2SArCUbMSSArJlVhP2wmbGgI3vQBG7jqBcEx4qMwFYXGMiOuF3ENzViRELVNXsPhtPnMc
 qPVgUI+L3rOJD7yjc2Um2G58WG/EcyJWDr8Y2rOTx5D9l+RzoNCmoWBAZShqGGXYccTLuyheBBu
 b4MXn9xtjAYZMhoOAgJn5fOHESUyBcwC0hbKaPLP0NBKiHjPSKrp7NuuAh/xWh6BQv8I9DSauli
 s2oirqLIS103geJxpMw==
X-Authority-Analysis: v=2.4 cv=WYwBqkhX c=1 sm=1 tr=0 ts=69456b61 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=UX4oRcM6ZsYirrnbdSkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190127

On 12/19/2025 2:32 AM, Baochen Qiang wrote:
> 
> 
> On 12/17/2025 7:19 PM, Uwe Kleine-König wrote:
>> This increases build coverage and removes an ugly #ifdef block.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>> ---
>> Hello,
>>
>> I found the patch opportunity while looking in this driver for a different
>> reason.
>>
>> Best regards
>> Uwe
>>
>>  drivers/net/wireless/ath/ath10k/sdio.c | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
>> index c06d50db40b8..3efe744c0c96 100644
>> --- a/drivers/net/wireless/ath/ath10k/sdio.c
>> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
>> @@ -2136,8 +2136,6 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
>>  #endif
>>  };
>>  
>> -#ifdef CONFIG_PM_SLEEP
>> -
>>  /* Empty handlers so that mmc subsystem doesn't remove us entirely during
>>   * suspend. We instead follow cfg80211 suspend/resume handlers.
>>   */
>> @@ -2175,14 +2173,6 @@ static int ath10k_sdio_pm_resume(struct device *device)
>>  static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
>>  			 ath10k_sdio_pm_resume);
>>  
>> -#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
>> -
>> -#else
>> -
>> -#define ATH10K_SDIO_PM_OPS NULL
>> -
>> -#endif /* CONFIG_PM_SLEEP */
>> -
>>  static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
>>  {
>>  	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
>> @@ -2668,7 +2658,7 @@ static struct sdio_driver ath10k_sdio_driver = {
>>  	.probe = ath10k_sdio_probe,
>>  	.remove = ath10k_sdio_remove,
>>  	.drv = {
>> -		.pm = ATH10K_SDIO_PM_OPS,
>> +		.pm = pm_sleep_ptr(&ath10k_sdio_pm_ops),
>>  	},
>>  };
>>  module_sdio_driver(ath10k_sdio_driver);
>>
> 
> won't this cause defined-but-not-used warnings if CONFIG_PM_SLEEP not enabled?

no because SIMPLE_DEV_PM_OPS() adds __maybe_unused to the dev_pm_ops



