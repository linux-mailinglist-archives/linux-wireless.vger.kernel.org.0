Return-Path: <linux-wireless+bounces-26450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50D1B2BAB2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 09:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F27BBE62
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF02848A4;
	Tue, 19 Aug 2025 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYbwKzUw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC928489E
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588404; cv=none; b=fLFx//i+V8NMh+5awwUh7D9AnXvRo4EIEgXAwtRE03O4oTdtp9iNqLNIeOlBj/NosM2gqF+VErqKz9p24v0MC5JZphbcpveXrmKlr0UskUHgIN9GyJ2M/IFJjUwTz6WUqk9n2Wm0sPIB1O0heJDe4C9/uoudh05JALFx6RIUx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588404; c=relaxed/simple;
	bh=Tj7vwO1kZ4Axx9czPqHop9i3vZMHCxOM6b95IoZVIIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJcpTXLzoA5K7BaICgD/o2ZN1UBzvXn2JMINf0+HDV4iSlnBuZ5x/IRb2yURYqunmRgTrPiX9f14Yu4vcQvttg0tkzTskRBXoIdmPNGxWfMd8N/355h/qQnXcGhsREMouhWilzprMssKvqytysusgoE8wlP+q9aHb8Ab6oFlVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYbwKzUw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J23fC9023991
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 07:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qcRh7foPygOroCMWDQ1NQA55X8vj3i+Vh6ZiklXfPo4=; b=RYbwKzUwRrmywSX/
	8A4VfGjhdH+pruNnW+iBsYNQJglxCTERjGg+7nXlZqIGKgBy6qEykq29n02CFZAd
	AZqE3vaymEZ1+UJPnxT8NW26/wrfvCGOng36PK9eJjaMqh2lWmmu4OchTLgjxCnm
	qf/XCBhtNkBItWLHgL3iwnl7eSH6G2ctOGUwhpSaEGSc+fhLYfrVMQtS/G5lk9dH
	lfkPG6v3yX6iJGSj5uJH7Td7SxOhFn2M8Jd6s8oh2GRwfnL81Pa6T3V1Owu5G6lv
	B7SeD8qoV6zMWhDanx8x3lvNsEqr9h/MUJsch0nf27nzlLrNq2pwPxyfNoVXJby9
	4pkEQQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjyfmg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 07:26:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ebafe0aso4242727b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 00:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588400; x=1756193200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcRh7foPygOroCMWDQ1NQA55X8vj3i+Vh6ZiklXfPo4=;
        b=Xk+dlqY2lir8SSC2H3h0XUaMHJwc+6wqeXHY7uWSTXfhPJYCnXxCENXTCKXJKj1vC1
         9sL4m9DoDxQtcjKDELHY3hZU0tvZ+GCrTe8FHLGrCiWYHW8KfAQ5RX+h43INXJRHA4Ez
         9jrTm6+wO9TIQt16qxcuwD0k27MfH+dj05Lt1gbNmVBpsysn5R+kE/ivIqFtiQ77Xc7j
         WrFM2AgfO2IPSQivwiquwUwdK0qBG16i7XFFG3p9pRvfsX3l4luLTqmcfVZ/wo7wvXxN
         4a/hFKIvkENG0Lud9M6Tz6AT32UiAGGFS0ObZ86RLEqfZrE1umdxKa5bMFZ6FLJmXpDo
         iZww==
X-Forwarded-Encrypted: i=1; AJvYcCWEPK3Dz6lVfCAY8jNWqNfddADFac9TNawjob3gvCEuxG5jKITWjsp/Sgca4RThlGwmzsnGnd5Z7B8x82TIKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxstWf0NrQUj4gtxS7cSaqnkY1ra0VwoI7/BZVrH4vAwhJVQCHf
	ZluHdHxCpzb3NKdOiqUsW4Js1KXc655vQMn533rGPNyd8HRZWRp0+KxPH+m8eSlo015wUcnMIMM
	881dvoCEIlggCDc6m+05vIBYa4b8/iwFIwDB4xN/GMsOxGcyD6+H2auvJkYS5I4YS1Pz4yw==
X-Gm-Gg: ASbGncuGHK1Pc1NZe39oCPnwoLWeqXw4gFjJ/YbfRP6xyItJm69bZM3pRuC/Lttm/4p
	UtHuxyH875POWt4NRP4gqyqfJkj4tHJKdD0WQG2Hjb0xgb0DolLMz4Jb/lgfwIesAcbzi+h7+9b
	vKA3CifteKND/oWcnM9HkP57xD2Hjh/T/EkemqR0RsjsKaLp4511T9c8JbzcRmEMRYKAbd+T2oT
	s42GRrodlk69A+Sbhi+8LUZDfVz2hS2vjx1QfJVP1S8U7MYoo8OuOS9aS5fUBzNukw4jCSA/cxx
	tJLm+fK5H3MvOffZKDNXVVzEJo7ckyHZWSQntztGf07+RlXCVjvtvXS59LIA+9K0LpBGyayu6wt
	o50psVCAr18tXS3o6MHVfOS5N0EhkbjaUgEwW
X-Received: by 2002:a05:6a20:6a08:b0:240:30c:276a with SMTP id adf61e73a8af0-2430d4753damr2032464637.39.1755588400261;
        Tue, 19 Aug 2025 00:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzseiVb89NiRC6C6yIK3eckisUcl6OaJcZKhsacw6pcx+RGiMXSxrapg1QR3zJ9Mo/cVVDMQ==
X-Received: by 2002:a05:6a20:6a08:b0:240:30c:276a with SMTP id adf61e73a8af0-2430d4753damr2032438637.39.1755588399820;
        Tue, 19 Aug 2025 00:26:39 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d13d312sm1637841b3a.49.2025.08.19.00.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:26:39 -0700 (PDT)
Message-ID: <ff8287fc-7122-42e7-b6ab-550576b5d599@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 15:26:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: REO status on PPC does not work
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
 <aKQg5vLUplzMUMlU@FUE-ALEWI-WINX>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <aKQg5vLUplzMUMlU@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0KMuiyKBjfChrVswTHiv9nH-xnEA9c_W
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a42731 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=cCZxINV-pdffXXtfpT0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 0KMuiyKBjfChrVswTHiv9nH-xnEA9c_W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfXwThHxVGKLQWR
 2x0AinhYzBwF8tcRDSRVOrRitAa6BohFYH6yLrE6SHYJzeKqBgKXBsndQc/DAvvan4O0bRvhxxW
 bI8SZUvHo7m7Rs2A6RqyC7sfjoiwRoifPqxCri+Z1/j+fBXR/mnHOTud1UtDIS5rfUBztyWA+dR
 4LW2K8dEvJDvCRkQe/4MrI9KFM0ajyvRHMFpPAEYpI0oPPD65XqLY4rg4l4BJuE+Ym+CF3EXPZW
 h4sBky6SrRo1Ib8iFFBdM8PQzb6XptHLYYOjhuGq5OiH9/vDfFEUowGmjzcz6u8bR3vFBlGEQGX
 X9F3w5/tZSKTSuFPbODCEKonIbV6thDiBSftj/SXk+DlJup09YuKj72/3LI82SFA5HqIzjkuJ+c
 i7mehITD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028



On 8/19/2025 2:59 PM, Alexander Wilhelm wrote:
> Am Tue, Aug 19, 2025 at 02:38:38PM +0800 schrieb Baochen Qiang:
>>
>>
>> On 8/15/2025 4:13 PM, Alexander Wilhelm wrote:
>>> Hello devs,
>>>
>>> I'm currently working on getting the 'ath12k' driver running on a big endian
>>> PowerPC platform and have encountered the following issue.
>>>
>>> In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
>>> by inspecting memory that the hardware has previously written via DMA.
>>> Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
>>> reads the value of 'hp_addr' for the destination ring (in my case, always with
>>> ID 21). On the big endian platform, this value is consistently 0, which prevents
>>> the REO status from being updated.
>>
>> This does not seem an endian issue to me, because either of them we should get a value
>> other than 0.
> 
> Really? I always assumed the value remains 0 until the firmware writes something
> to memory and moves the head pointer of the SRNG ring buffer. By the way, I've

correct!

> already implemented the missing endianness conversions for reading from and
> writing to ring buffer pointers like this one:
> 
>     hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);

I was actually meaning that, when hp get updated by firmware, either with or without
le32_to_cpu conversion, we should get a value other than 0.

So in your cause I am suspecting that hardware/firmware has never sent any REO status to
host.

> 
>>> Interestingly, DMA read/write accesses work fine for other rings, just not for
>>> this one. What makes the REO status ring so special? I couldn’t find anything in
>>> the initialization routine that would explain the difference.
>>>
>>> Could anyone give me a hint on what I should be looking for?
>>>
>>>
>> What hardware are you using? WCN7850 or QCN9274?
> 
> I'm using QCN9274-based dualmac modules.

sure

> >
> Best regards
> Alexander Wilhelm

so did you see any obvious issue?

