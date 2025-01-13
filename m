Return-Path: <linux-wireless+bounces-17434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A0FA0BFF7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6AD16A197
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3D1D318B;
	Mon, 13 Jan 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2d0/PN9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFD1CEEA8
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793284; cv=none; b=g/57vmQ9NI0J0j5oKRMc7+CN5MacHp/b9UOWnF3yIa7dHisnoSsa0r05ExJSgkCTMt8o97+CRK5pb9kZIWb7d9caOyc5fL620COxyDzc9tLaqL9JIeH3O0JNjInpM3KoD7WEHFAj58U3RxPR7sikv76KhwQz7VT9+VaHAB14qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793284; c=relaxed/simple;
	bh=hzFpbShNWG884/yzqiJiZa8Gw6Hbs6HbAQBb2sAQklw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjKoVIhX3fKqz+CHdegYj8CTE531W7Y/xhWqLHbFJ1Ic7dFb7ADHRVDL8HQ0yLWfZ88ZvOhM9hF/FrYv92U+uV2A1wVpGSUe4j2o9/mMXRgWRw0tRYN1uqgdWjm8n8Hkiw5WZzNjUwOzrRBqeh93xjcRMDnOJ2bpHGBfRVCAZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2d0/PN9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE6hFE032015
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GB9Yag0S92fnwFyhY9apzQbP5Nbl8pTmCWw4QvepSAc=; b=k2d0/PN9SUm+ECam
	Oz8wGxFnQkSCJXGREVcvlKg8OzcpaMsdrYuzyJvqB3/lcQdO54XL/dbmeijiTQyn
	8O0WZrkuJEyhoewnIY1QkowU9zTLOXFLvyXefFgGICM24ySf47N2L3lDkn5Jf2AS
	PCk/17LREeNeztJMDhOAQ/VvoN1bDDa+YMr6+RRthwVIpG8BCIl3YhXmrPG7vCk7
	WXqfjlV34chOJvsvaP/EJsRipaCbNtOZs7UhMEG1Fvx9BgBafnGxXsCB0vSwBHyt
	c11+6mv+s+X/tbQzSAJdsvPDBQLrW3ZnMgsAtxZczh1kbrk8KEqnue9lRaaO3BDc
	IRh5pg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44549w8mt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:34:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216266cc0acso88905365ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 10:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736793275; x=1737398075;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GB9Yag0S92fnwFyhY9apzQbP5Nbl8pTmCWw4QvepSAc=;
        b=BqZuK6tvPHgh4NROfd8jdEwqtQsqyzMpJ8dyEjpoRVaS5Yd1GRDfbiydiq1A4pDRQI
         m88TwsSME0Pud1vDjVXhnJ/wOLX3AnBRpD5wTAhB75uA0d+OmKzW0mK+S/aHZCqVr3xX
         MU+EO3bcXwWlOo7EADLSPi8zlclw94NUFlvxFt5rZAcfiRQSasB7VuxtlOrahgbxKbpd
         f1sRvDEXobr5mzpC3prRR+PKUDi0iZp3MRTmcTzNgDIinpaIIsGIAedM3b6ioTITcAFH
         ZK8bd9BhAIu/IQJ+ABuJ5fYzw33j7H3SO4RI604PJKCP4eDMi0tCeMexq33ozyfHqi9Q
         e6+A==
X-Gm-Message-State: AOJu0YypNi0a1lN1/YMOk97gT9lvJaU1hwkBmkXsfWkAXwE6bhf+vgzY
	U2YFQsZKTRJXya4btSS7+8P2wiZmeb4sVGirDezSVNQnBx5YtAnipP7e9PtJOsry4NOxHmwp2b2
	jkdPikMZSqJrdlvMn4NoY5v8kRfUTufwAv8dyY+XWMpyDo+WEQWgI6g1kOkXALmIenA==
X-Gm-Gg: ASbGncsvSUsZdRi3uHq2dt8rSh+98OpqEOPst5gQz9i/3iTgW6LiaJfddNzIenHTY+0
	wMx4/O4TwUgVRvrOKMDhfOeEwr2V1QrUojL2S3OKtPi1VZIVEfsz+H9agHHeFSlC9UNMByDfEZw
	fAPAaI8e5NPHslxk4xgR8EWwJbPVk5fY/mCOnqRCDdSTYsi8CvQoKcoZMjAVkJHVcMLIOL017IW
	Re8p7cPnAbi662om/9CX0fFJr8xSHyAhr3/ed2jgi3anOANilmEHHftHfZPQnyO8yE5HrOb90a9
	V8vkINzb1gGnracrOaVapPTLKiBU6bjSZifpn2Bxeao7a41/oQ==
X-Received: by 2002:a05:6a20:c896:b0:1e1:ad7:3282 with SMTP id adf61e73a8af0-1e8b13d1ed6mr23260284637.7.1736793274624;
        Mon, 13 Jan 2025 10:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVmLbJjKIXrU5OizlvLle+AriLedokFWRNIHyrvXHi3TC80JLv+9f9ICoPLpMe2ANKiddz4g==
X-Received: by 2002:a05:6a20:c896:b0:1e1:ad7:3282 with SMTP id adf61e73a8af0-1e8b13d1ed6mr23260251637.7.1736793274232;
        Mon, 13 Jan 2025 10:34:34 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40681b3dsm6185368b3a.153.2025.01.13.10.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 10:34:33 -0800 (PST)
Message-ID: <afd212a9-093f-4b03-ad84-0436bd99358f@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 10:34:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] wifi: ath12k: Add API to print s8 arrays in HTT
 stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113071144.3397293-1-quic_rdevanat@quicinc.com>
 <20250113071144.3397293-5-quic_rdevanat@quicinc.com>
 <1e1b5159-3f4f-4876-9e31-11a1f5b3584c@quicinc.com>
 <7d31615e-d5b3-40db-8de1-554918c18212@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7d31615e-d5b3-40db-8de1-554918c18212@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gg2e42wNUKDvMV4-0uvHSF_XbthigSpZ
X-Proofpoint-GUID: Gg2e42wNUKDvMV4-0uvHSF_XbthigSpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130149

On 1/13/2025 12:37 AM, Roopni Devanathan wrote:
> 
> 
> On 1/13/2025 1:50 PM, Aditya Kumar Singh wrote:
>> On 1/13/25 12:41, Roopni Devanathan wrote:
>>> Currently, print_array_to_buf() is used to print arrays to HTT
>>> stats buffer. This function supports printing only arrays with
>>> 32-bit unsigned integers. Add print_array_to_buf_s8(), which
>>> implements print_array_to_buf()'s functionality to all the
>>> arrays with 8-bit signed integers.
>>>
>>> Sample output:
>>> rx_ul_mumimo_target_rssi: user_0  =  0:-128, 1:-128, 2:-128, 3:-128
>>> rx_ul_mumimo_target_rssi: user_1  =  0:-128, 1:-128, 2:-128, 3:-128
>>> rx_ul_mumimo_target_rssi: user_2  =  0:-128, 1:-128, 2:-128, 3:-128
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>>
>>> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
>>> ---
>>>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 28 +++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>>> index 77c51269669f..92935134735a 100644
>>> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>>> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>>> @@ -48,6 +48,34 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
>>>                       footer);
>>>   }
>>>   +static u32
>>> +print_array_to_buf_s8(u8 *buf, u32 offset, const char *header, u32 stats_index,
>>> +              const s8 *array, u32 array_len, const char *footer)
>>
>>
>> Who is the user of this new function? I don't see it called from
>> anywhere. At least have 1 caller to it in this patch?
>>
>> Or else this patch fails to compile with W=1
>>
>> drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:52:1: error: 'print_array_to_buf_s8' defined but not used [-Werror=unused-function]
>> 52 | print_array_to_buf_s8(u8 *buf, u32 offset, const char *header, u32 stats_index,
>> | ^~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
> 
> This new function is called in patch "[PATCH v3 5/6] wifi: ath12k: Support Uplink MUMIMO Trigger Stats".
> If we are facing this warning, we'd have to merge this patch with patch 5/6.
> Jeff, Aditya, can you please confirm if doing that is okay?
> 

yes, please squash those patches


