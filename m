Return-Path: <linux-wireless+bounces-24782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F4EAF6799
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 03:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A526A3AD3E4
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 01:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC323774;
	Thu,  3 Jul 2025 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdFRRABi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166117996
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507953; cv=none; b=Z4oN8JUveRj9Zih8YKUEpQHWKe/wQaXypiNz6O6gbpMphaq2Xyw+piMjCPxuxdojEA9UdJyL5E6/y9BYlCK3JjTvA1knVWqS4C1NhMgHFeSKelB8FmqCFPtc+DQWCsQRhswoWtuyS0lRjJ7xAMcklnlkEUOP9EDSkbT+cB33IPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507953; c=relaxed/simple;
	bh=HWvWupoVOUpxIVdmgPcGZapk7ubPy7BmqzGl82+G7oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SX0VmKbAoN7kJsVWw1mw5aeezwmWQcmVgdY+/EBhzLr8eCKeJalbzeDk/Idl6ty9CgkFNPsnQaAUpTc5ETQS4Gzx7kJMwp/TYx1rNzfTMeq8afXRRAmL548V3QRjDuxz7QTnXzPIrApXcYcPdJvOMX+99Hev45lcSx4m7Hd0vpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KdFRRABi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Nel6e028664
	for <linux-wireless@vger.kernel.org>; Thu, 3 Jul 2025 01:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BLk20dvf/JzTQp3p5RGp6IdlyZiyxeKpevcy7m6Fu5c=; b=KdFRRABiqaelYO9h
	VB7lhgFrWTYQfNViFRaotOMOHThR4Sh6lZzaXDhIpXzGJSgBlOKkgfJuRvF+RsQ8
	Fpj7kgEbXjs2B/zrRtgvoEAYYeCW+JxbBRcVKTrSX6722rYERAvQOdWuYVBnL/45
	2wBqQUaFwwRf8TSZgGDwbfYahF2qutfudGG4tLkUqnzFCYkt5IhdJ+L/S5vxn1up
	ud9VN9jGVEqnXZvFcbg9RvF6p7QOEUusJA12gICiUZrz+eQHgfXaWk3VfvLhHOI6
	cERCQV7MADw//NL9OEXJwW+hbNzlBeGwWO6Y1WhjnOnVdh5mOYxsAbbvKW2wm46q
	J36L/g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bvxsh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Jul 2025 01:59:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235f77f86f6so46545495ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 18:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751507948; x=1752112748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLk20dvf/JzTQp3p5RGp6IdlyZiyxeKpevcy7m6Fu5c=;
        b=J8y8LbikJ61KvHQIzBfLGpNivhh8VlJKpmzibUQcWPE+wqVPAQXlMFpkQqqVEXqoVX
         qfOYE8mEog8Wj6o47PX4mY6oZeqHRa0T8KbezuiOn+hJkBFKji4DMiSkNULCmcqKmaY8
         kamSQl4q9Ftilx6Cc+MeNO4UQWCntnIjICEP2avog6/T122pqY/lL1uMjReneSThP6WB
         CO9jfsWf587TsWWOMnX/sk4Iw0gAI5z3PiGsJVeCDVDQLr/KFctgKZVtK6WDOBc2RZz5
         XLebT+9kDXQSsnr24zsdA7Mwsp6m+DroqmcvoE9yukNGTtSZ0VZA/6Gmwv/NAKPRr24/
         CmyA==
X-Forwarded-Encrypted: i=1; AJvYcCU9FA0a0RxRzTgPFQiVBHHrbXJYkiI8AMorgrw3QGdCtx/TVHMSNYmtO6fTxOL559+axYsSEf/4BrhQA9hpqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywDc+NZwm/syQ2klTCSEHkP8OkNM3oW9G2CsTJLXdAGPSSUOgb
	uIpF1JBcfic3+YPPxbxZpABd6YQidtgjPLPPzHNU22nVWG30ZVCZJcJXfGq9v92IgJeQKouY1oC
	11Et9IEXbQX2McEp7lF42lWZuym27FvRJo1j3zl0ASuqI5k7s0iUsRo+eb3rReZsb4DCi2w==
X-Gm-Gg: ASbGncvC41a8IL55eo0gwxueZJsAcmJWByybpP1gAb2AXWzZPUIkuKip6mPmOoQdFjE
	ts4vwjveqR1Kig2Dqc1Z+a8mtSYU8gI7EwBaeVB+it3luhS+wB5UcY69mmln0wedl6s/hcOkvyX
	RD10wsS7QiZdTy26UZb3RrwTM1FBANIz6/uiZsJ9eE+jts3EBcSdFPD/iWUAzA5oc0ZBF6OdhD+
	b5YCMm5S/8MQZbfYq7GbUYdr4UutYFCrOx2pykuE3s0Gj920hKgqkmbnn8v/wQh3X5kkp3ogMUP
	c88tjxUzgAiqsj4uTM0XTe7CtuFtWCqnnj5TB8+nZAF02VYjvZ+++O5hDEPL9xGnRK5As8y7vW0
	wWwKT9dMLqwlzNzU=
X-Received: by 2002:a17:902:e747:b0:236:7165:6ecf with SMTP id d9443c01a7336-23c6e570620mr92655665ad.38.1751507948052;
        Wed, 02 Jul 2025 18:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjV6F4zIrWa0LJM5H7lesl+BJIP2s5KAmtJeAQvLyKOvf6L5XBeXUE/9AgT3s1eusgbYs4MA==
X-Received: by 2002:a17:902:e747:b0:236:7165:6ecf with SMTP id d9443c01a7336-23c6e570620mr92655235ad.38.1751507947568;
        Wed, 02 Jul 2025 18:59:07 -0700 (PDT)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7ab2sm138723935ad.177.2025.07.02.18.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 18:59:07 -0700 (PDT)
Message-ID: <8b9eb6f4-6f0c-458d-b1e6-a1893c35b81d@oss.qualcomm.com>
Date: Thu, 3 Jul 2025 09:59:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
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
 <20250630074330.253867-3-usama.anjum@collabora.com>
 <5f2a900a-3c8e-4b16-bd91-500af7d0315e@oss.qualcomm.com>
 <29ba0afa-9a1b-40f9-a174-d03902ea5d3f@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <29ba0afa-9a1b-40f9-a174-d03902ea5d3f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ms-WovOVrNsFrQAr5Ux5Wv-kxTWOaml1
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=6865e3ed cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=unw2bX-B-0ReeQHatd8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: ms-WovOVrNsFrQAr5Ux5Wv-kxTWOaml1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAxNCBTYWx0ZWRfXxkG2YzLDZXZw
 xpluBXVjrqptmvBYVp5Zhe5Y0wK4UoVxtBq7uh6BWoGir0kj9gvGF+FBRegvGsAg1c0rBxKpkNb
 0SOi/ZYt5yjAGSDT16lschKHLEJ9+pfc2MHw8HbFfYipjBRxcfBRTmdbMgL98BGrvbMg9ojd2uf
 dG4tYpi70qPl/t86UxaEE/rauyqfsdZGKZBhjGYF7bh8iriz7KAY6IiJbbIblLbiAqyfYelGofQ
 ZAaOhd31FDqoNPn0Aq7ECeR1ifmCw0QWbmZNUEJ1RoS2jyNoOa7eHcsooUy0zZzhPm/yB9N2vEe
 zRLJVklKGV6CPRucM7DrX7lhl9jfzVsXuyEGQILhZfOiUs9NH8iExXI93OJooYdutvVrpiOwtDG
 QwVURF8rrS/uTJPScwkmy73tEksb45n7KCY421KMkwNYXdOCQQ+sRcD5aEbPN+pNQ/QJGIJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030014



On 7/3/2025 12:12 AM, Muhammad Usama Anjum wrote:
> Thank you for reviewing.
> 
> On 7/2/25 8:50 AM, Baochen Qiang wrote:
>>
>>
>> On 6/30/2025 3:43 PM, Muhammad Usama Anjum wrote:
>>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>>> deallocated and there is high possibility that we'll not be able to get
>>> the same memory allocated from dma when there is high memory pressure.
>>>
>>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>
>>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/core.c | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>> index 4488e4cdc5e9e..bc4930fe6a367 100644
>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>  	mutex_unlock(&ab->core_lock);
>>>  
>>>  	ath11k_dp_free(ab);
>>> -	ath11k_hal_srng_deinit(ab);
>>>  
>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>  
>>> -	ret = ath11k_hal_srng_init(ab);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>
>> while I agree there is no need of a dealloc/realloc, we can not simply remove calling the
>> _deinit()/_init() pair. At least the memset() cleanup to hal parameters (e.g.
> Why do is it being done in the resume handler? Shouldn't those parameters be cleaned up
> in resume handler? So when device wakes up, its state is already correct.
> 

Hmm... not quite understand your question. Can you elaborate?

> I'm not sure why it worked every time when I tested it on my device.
> 
>> avail_blk_resource, current_blk_index and num_shadow_reg_configured etc.) inside the
>> _init() needs to be kept as the later operation needs a clean state of them.
> So should we just memset these 3?

more than them I think. We need to take care of all entries in hal since current code is
memset them all.

> 
> 
>>
>>>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>>  
>>>  	ret = ath11k_core_qmi_firmware_ready(ab);
>>
>> the _deinit() is still getting called in case ath11k_core_qmi_firmware_ready() fails,
>> making it a little odd since there is no _init() anymore with this change, though this is
>> the way of current logic (I mean the hal is currently deinit in the error path).
>>
>> Thinking it more, if we hit the error path, seems the only way is to remove ath11k module.
>> In that case the _deinit() would be called again in ath11k_pci_remove(), leading to issues
>> (at least I see a double free of hal->srng_config). But this is another topic which can be
>> fixed in a separate patch.
> 
> I don't think this is the problem as HAL is already initialized when before the system has
> suspended. So by removing deinit() and init() pairs, the HAL still remains initialized. Or
> maybe I've missed something?

Yeah, it is OK in normal path. However in error path we face issues.

> 
>  
> 
> 


