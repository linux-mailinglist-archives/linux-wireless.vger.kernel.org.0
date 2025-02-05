Return-Path: <linux-wireless+bounces-18542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B4A29810
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 18:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A261884808
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDAD1FCD0D;
	Wed,  5 Feb 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afgJxHA/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB21FC0F5
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777956; cv=none; b=Axw04rKVRy7kVX5SgDduFAWxi/n+D/BVVXy5/WvMI0lcSindX+s6OJN03cP98ac2Yi13N51D5rqqksDZu8GpfW4MkcEVEpjSDLGZ4zikO5McLjpeBSwfqjLv3SJjMVqUOjo48A6T99Pf9/o12pB7k/iFyXLQJ6iSHd41E/xmINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777956; c=relaxed/simple;
	bh=o5ClkUrThNYAc0v6zXTFmtMO5zefMK+5TJMO4QkntYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OIswWC/ScD62GGgAsxF8YNZVqi2n4tx9flEriIifJgoSd8xC36tZNYNXC7+T2E24mHo3dV+alFU1kP5dQVmQpHfcYH3dCfrIzoHG37O223elOWddu5cdtEVj/xO/auCjic0kAHZyB6bDe18VWWguKnubUR55a5UyEXQ2HM6r1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afgJxHA/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GNdvK025753
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 17:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HRC1vhtVhyB3PMgCoDL5JiSYTfGPZzjBdDKpqY5lzFs=; b=afgJxHA/MGvf6vzi
	nl7/ptqLv35/AoB63bSDtJUIDwAy+SXXB2/pQAPXDvEL9NHyhknnIKBMCs2cb/NO
	9lghlxD+E1YdHDdlDT0KCbZcsEZACpTASbZN9wGI5mnAwsN/r3jjFVS0GSaLxOr/
	D2W2T9oBEVvuoRjGvwsOgwDjZxB6SKUldMpy1ZvlC1urLEoPhk5vcCJrwFz2cAEs
	jEN0vN8h5RNhgK8DtSMGdVC+j3kUDyKOpwGZBNto4LrNdAOSLGrYeDyfnm96n23g
	0PVg5c8/JEovTlEjhJKWrky9tfNcc51OYL2UMf++yjxUuot0XZDCnAjkX7nI0DUY
	gQEv5w==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mbfh878j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 17:52:33 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6f2b386136aso883997b3.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 09:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738777952; x=1739382752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRC1vhtVhyB3PMgCoDL5JiSYTfGPZzjBdDKpqY5lzFs=;
        b=SO/HHUJqvJb/yBHXVpVEdtDN1QrjGUerFSYE4tjsTgRK8XqyR0+Dn6OlcPT0h0xJRx
         l30qAlUytA04MDAGi/HMvNTsVc++sRTqK3FpwGC7+GrJtQzteP8ukZZMq8W2WSeV14CI
         CkEFfk38VZJPMHGiNz0i8vIlaSPCHbW3qi4tVN/QDX3U6r5k+agjduPP0vjQe7Z+HZXy
         BwCn6064WwIEa2JQziFe7kyZ48rL1InZrRkTJo95Coeu3Yypx8IKSlaPiq/xtVUCF3ie
         NWx9wMXy9snhfyKBoxzXRVRATofxA0D38i7YrXMdUqfY2onvXysge8u8+DnNLwqAvmX+
         BPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi/2j5/TsW5gGBmNhex0DmjTD6SHqhoqHlUHeGQu15T3al19twanWSntgbtCw7xJ3/caScF2qlX4/YHPSYKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MHFLCpIUT9ARsSfm2irjE5JJ7XiugP0EC4Sravu3SgSYM1I/
	Fd7krOulkfWTz3n1SoEDDT68WvYEydA9z+x0qjd4RemRHWLXbW3uNV5JUxdHzo3sHvU974xBFF4
	eE5SpcQRBpzA+UgJDzthzs3Wr4xcIiXRYEG5QsULyMgBKoI05BUPKHiCv7wHCTrTCESGy72aCIw
	==
X-Gm-Gg: ASbGncsvs5y7rX4Y5LoXfESCOZ428vNgsXCYkNoPbMimJ3SOLsUlgsVK1qgsZhqVUHS
	tIaZbnIlOnctTfIlTVRFMjPnmK8+FhxaxBGbwMEzl3E2DA6zMlJMphmKSSGDoTpk8bGV1UbyVdJ
	6zc+XqB+7Knu89Vj32rDME9AW8Mo30A6W4r1ArRBcO4oD5oZYNjsc5ewnnMtGsARsGhGAoTrNtU
	xgKEWR74no23Yv+jB8LVfNZ32UgPwQoOpLsvH56V8g9z+GHqVL2iKt0SppJZDU7El7xzLFnjfsk
	BBHZ0LMpOwKMb+lHPUp/Zfm9YDIkkWwVVvkEDJbjTPzbztqm2Sf4LSOHDs9WIbW6t/xd5A==
X-Received: by 2002:a05:690c:6a03:b0:6ef:8c41:dee0 with SMTP id 00721157ae682-6f989ef9080mr39021477b3.20.1738777952247;
        Wed, 05 Feb 2025 09:52:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKD06DARGKWXQmYUVGJll8I/Kn+glXt6liGCBOXu1uORDrUPjFkQIate0mlx6BdjwIMWaojA==
X-Received: by 2002:a05:690c:6a03:b0:6ef:8c41:dee0 with SMTP id 00721157ae682-6f989ef9080mr39021227b3.20.1738777951821;
        Wed, 05 Feb 2025 09:52:31 -0800 (PST)
Received: from [192.168.69.158] (c-98-35-147-9.hsd1.ca.comcast.net. [98.35.147.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f979b7f38esm8049107b3.42.2025.02.05.09.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 09:52:31 -0800 (PST)
Message-ID: <009d0777-8da1-4211-a510-a65e4274861f@oss.qualcomm.com>
Date: Wed, 5 Feb 2025 09:52:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA
 beacon generation
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
 <20250203214448.1978156-3-aloka.dixit@oss.qualcomm.com>
 <db16febb-a58e-4a60-ab1a-212c30fb5313@oss.qualcomm.com>
 <a4809256-5806-4e1c-a12c-d5d2a6c0be44@oss.qualcomm.com>
 <15632e7a-fd47-4940-91d7-1b75d51ae43e@oss.qualcomm.com>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <15632e7a-fd47-4940-91d7-1b75d51ae43e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YpJI_ypuZQ7ILnniJdeg2KCoMpJmKZnl
X-Proofpoint-ORIG-GUID: YpJI_ypuZQ7ILnniJdeg2KCoMpJmKZnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=676 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050137

On 2/4/2025 7:58 PM, Aditya Kumar Singh wrote:
> On 2/4/25 23:58, Aloka Dixit wrote:
>> On 2/3/2025 8:41 PM, Aditya Kumar Singh wrote:
>>> On 2/4/25 03:14, Aloka Dixit wrote:
>>>> Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
>>>> a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
>>>> or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
>>>> the same pointer. Instead store the pointer and pass it to the
>>>> latter two functions.
>>>>
>>>
>>> Same, Is this tested? Perhaps you forgot to add "Tested-on:" tag?
>>>
>>>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>>>> ---
>>>
>>>
>>
>> No, only ath12k patches are tested hence no tag here for ath11k.
>> This patch doesn't change handling functionally and I confirmed that 
>> all places using 'tx_arvif' first do NULL check because the refactored 
>> function can return NULL. Functions ath11k_mac_setup_bcn_tmpl_mbssid() 
>> and ath11k_mac_setup_bcn_tmpl_ema() always receive a non-NULL value 
>> now because the caller ath11k_mac_setup_bcn_tmpl() sets 'tx_arvif = 
>> arvif' whenever applicable.
> 
> Okay so in that case "No functionality change. Compile tested only." 
> line should be there in commit text?
> 


Sure, let me know any other comments, will send all together in a new 
version.

