Return-Path: <linux-wireless+bounces-24896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48095AFC02F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 03:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9301726BE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 01:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B81FE45A;
	Tue,  8 Jul 2025 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kgFVotnK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE41EFFB7
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939048; cv=none; b=Escid5vDkzLedK5MFzHshkbZ1Yuld1E4pj+eFHUsSX+LarIckxf762A2pKTFdfB36FEAA6K/o1KeXxMed0artPe+hyLYP5mrHmRPzPczlKMYMrBWgeR81ayAsajp32JzHl5HOukxTnib8I/ntPdgk+OURGWM4G9fqpSvHLU5b4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939048; c=relaxed/simple;
	bh=ITnGl44Ugo75QxOk/V8xMNfq2AqSpn/y/RhZTD6rxqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3Ln4rN860IheNDIybzi6EoSJZJXQT2AYMuxh+UrpATvMmN0FjmXBr3ikJ4J2Gcyiaeudyzv8+amujyIi8r7DM5uQkK6rl4HB81fDJ07MTUGwPZtIw+ufXU+dcnOO4PYbCe34OicVppEMzPrsFAVmToqyHHdPRIUBiCdSKcq+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kgFVotnK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567JWFLX013480
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 01:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yl777uk8TYoa7yrfsLRZl56fRfsxTMHbE+ZHD3LEddY=; b=kgFVotnK2ssORDpg
	gLmjlCNYd4OFkuzOzbKRe8qqIBJLkn0j1WXGhNafywS1pWNGb5KE7DBoxfB1wnFW
	qjJByEcVos5+h05YWtLnduwG3JTKiOt6iJd/KYDNiER5Cce2+vgMhbuEFHUAPmYH
	Ix/kilkpPjssem6CaACpmD22o4+1ipsjZe9tjF9m61Ml7cBl2qzNsvYSu99HC6Tv
	eHuQ40rqmsVnD8PlvlvNKircE5KhWBjsJJbgEFJsxzGracJK5JihALuIkN2XTpgm
	69UmRXZceNIpswksCsWYk0veDSaTs8SFlouKfjgcs4yGQqXZTC8Ji1c+2y54G0UM
	HB9MkQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucmt2hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 01:43:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313f8835f29so6256181a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 18:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751939037; x=1752543837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl777uk8TYoa7yrfsLRZl56fRfsxTMHbE+ZHD3LEddY=;
        b=vJTERh4EnxwMM1FZIuItB9GxsnuTT4ULT6fUZ/GM3TS3Xq4ZtztQDfdPUi5aREksXx
         Vb7K5DmETD2oPmtfGrHrYg65d+4Tnlab9c9aBpWawug+cIOPXyEDAAAh+6HYdzbN5Iwu
         3EZaUWR6F7UIQubWLuFdnyy2kT1EZyZAVcVrlJJxd9BLsBqwls7Zc5BX2NhpA6dB1lfq
         toVnxltNFc8h3Z57ssGZT9bWomK15SCE2ngUouehRyDmDEC+1Gs1+I9OwoO8lZ71penH
         oYyEBVCm8gD7eashifJ+AWeppj//diRGycLNnAvkzZTWIBcEP8yYGqXmxTlCvPkTYZvu
         sGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuUBX4Slpu2mOMZ0t+sioAij5Ad2LCuiwYS11juKJc+mqAJhYJVcW1Mt7lERQH43qGkzirF146P170SJMdxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGePomGABx2oTMRbviDgCdd3IK0Gx8fRDJl6nNBh2+WQ/oexk+
	e2LWQFx5tVKbeV5ZK3+nVCN/NC5XVBiUMt946xZ3ZQtIvNVIuGJsrf7QLF1N9qO6OMjPqUQtFvD
	u/lU5kci/vD7WHMKugkn7GQHf44pp9u1IBU+spZoQ1xG++bcs1CjV5XEnva+/KsM/ZpROVuwfg4
	Evsmdf
X-Gm-Gg: ASbGncsdyGXBePjlo1TLSg7pj0oW8Td9kNph1rF2ujxwCowu/pFbXlqoxHh5n97Qkze
	IcDyN5yEqefxf6NxGIuwrYt2ICWxy6B+huk2JEV1tnqmAToT6ewMmpnO2oKadOOIS95ESMNTFUq
	YMpwWCoIbPMHM7eQ2v9jrIRMj297wJo7bt3eZitVVLNLeuw69arORFP9V71CrViq015mQPHSmHF
	iSoq6bMFUKnSElwpNg7RRMm+lY4Lrauyufa2P3ZjqNpD/VgjoxScD2wrnv3oUBb8Wgo/tIWuJF8
	A/waTJNL+Ic+4d73CduGJFb0SLlqtt6Wz7/+ZEY9aQZdZjCIavaWYCN3DO7uRy1fxLoetDK2KWb
	K2oEeAEsHhavivg0=
X-Received: by 2002:a17:90b:1f83:b0:311:df4b:4b94 with SMTP id 98e67ed59e1d1-31aac432a89mr19916280a91.4.1751939036591;
        Mon, 07 Jul 2025 18:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhKVpmGrrRXQtES7O9YfBq82/o7OuEhVZMyofryc6rLrPXsT448ckzR8EZfAtTqPI4xY9GZg==
X-Received: by 2002:a17:90b:1f83:b0:311:df4b:4b94 with SMTP id 98e67ed59e1d1-31aac432a89mr19916248a91.4.1751939036125;
        Mon, 07 Jul 2025 18:43:56 -0700 (PDT)
Received: from [10.133.33.177] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c220bc5basm642199a91.42.2025.07.07.18.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 18:43:55 -0700 (PDT)
Message-ID: <fdb9f1e7-bf8f-4018-b0ac-ac8a70d9b8ec@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 09:43:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
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
 <20250630074330.253867-3-usama.anjum@collabora.com>
 <5f2a900a-3c8e-4b16-bd91-500af7d0315e@oss.qualcomm.com>
 <29ba0afa-9a1b-40f9-a174-d03902ea5d3f@collabora.com>
 <8b9eb6f4-6f0c-458d-b1e6-a1893c35b81d@oss.qualcomm.com>
 <a92b3d96-0c19-49c2-ad8b-ad31dec973c3@collabora.com>
 <7b8ea9ba-02ef-4676-a4d3-d088920283c3@oss.qualcomm.com>
 <9eba0149-290d-4010-8791-d4d8d8be3786@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <9eba0149-290d-4010-8791-d4d8d8be3786@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686c77de cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7V90euPs39zsmW6lzs8A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: pJjh2D2oTJLIqwhKGhAubnbrV4FrtvjM
X-Proofpoint-ORIG-GUID: pJjh2D2oTJLIqwhKGhAubnbrV4FrtvjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAxMiBTYWx0ZWRfX1pbl6Unudoa7
 fgWXfasQ3NIZSe2QsLUzyNwuB6I+OZn/4g+yZkJ69qU6HgsbFqMAaCm5qmYVbSHD1SKGZKOz4uI
 duiPC/yPXf82jUG3MvNLJRuHJl29wxMpCOjpEbBSXUTifLYzhAZgTOeM6WDWuFEpZRI5aMjrfZI
 z7n0st3TZPJnK7UDW9JJvZ3MsEEidgQZGCsPwC2zU2NaVY6+Dx9fe3Bn9/fsEdhBvvH+kvAz1V3
 PebMtjj56b7Jd3trV0SfgoFPIEAnqs8sY5VM1MqxfFI2L3wSN7ffzSUDErIdYfG3TCV1S1KJBkT
 QjYPVB1CiWhFjguoieZipndPYYhRjuGdtBZDWln9koQUb1RAfHDIn5Q2aRhxvm64Hq/3PNz2ebd
 WtJ8LdyTMZmACRWJJfxZaFn8IpAbEaOYuUFFj6FjsA139UxVEq+1yLQ5CGN4l1jc5g8KrsOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080012



On 7/7/2025 9:11 PM, Muhammad Usama Anjum wrote:
>>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>> index 4488e4cdc5e9e..bc4930fe6a367 100644
>>>>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>>>>>  	mutex_unlock(&ab->core_lock);
>>>>>>>  
>>>>>>>  	ath11k_dp_free(ab);
>>>>>>> -	ath11k_hal_srng_deinit(ab);
>>>>>>>  
>>>>>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>>>>>  
>>>>>>> -	ret = ath11k_hal_srng_init(ab);
>>>>>>> -	if (ret)
>>>>>>> -		return ret;
>>>>>>> -
>>>>>> while I agree there is no need of a dealloc/realloc, we can not simply remove calling the
>>>>>> _deinit()/_init() pair. At least the memset() cleanup to hal parameters (e.g.
>>>>> Why do is it being done in the resume handler? Shouldn't those parameters be cleaned up
>>>>> in resume handler? So when device wakes up, its state is already correct.
>>>>>
>>>> Hmm... not quite understand your question. Can you elaborate?
>>> I'm trying to understand the possibility of cleanup of hal in suspend handler. For example:
>>> * The driver has been loaded and has been working fine.
>>> * The user called suspend. So all devices would be suspended.
>>> * In suspend handler of the ath11k, we should do the necessary cleanups of the states
>>>   like hal.
>>> * When the device would resume after long time, the hal would have the correct state
>>>   already. So we'll not need to deinit and init again.
>> The hal cleanup is not only needed by suspend/resume, but also a step of reset/recover
>> process. So If we are moving the cleanup to suspend handler, similar stuff needs to be
>> done for reset/recover as well.
> It makes sense.
> 
> So clearing the hal structure completely other than ab->hal.srn_config doesn't seem
> right. I've also tested it and it crashes the whole system.
> 
> On contrary, with only the current patch applied, there is no abnormality.
> 
> num_shadow_reg_configured and avail_blk_resource are non-zero. If I make them 0,
> driver still keeps on working.
> 
> 	ab->hal.num_shadow_reg_configured = 0;
> 	ab->hal.avail_blk_resource = 0;
> 	ab->hal.current_blk_index = 0;
> 
> As you have suggested setting these 3 to zero, is there any other variable in hal
> structure which should be set to zero?

IMO srng_config, rdp, wrp and srng_key may keep unchanged through suspend/reset, all other
fields should be cleared/reinitialized.


