Return-Path: <linux-wireless+bounces-29588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3862CACDA6
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 11:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C18D302C4DD
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E422DAFCC;
	Mon,  8 Dec 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rp1DHBk7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMgtCoIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DF2D9ECA
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189558; cv=none; b=ur0foVTQtPPqdcOrZLpx1TzxxDcf0Q8zVfWw6ijZGjx0uHDT/vRNS6xhn9edzwP5RnDcGXqDK1dZV68KVLVKaBQ870qb6fH084TDcyNqyZqt7Z/YyrtWF7VJ+HCMmnwmawgF/d4ygctVqfzABmq6cljXVtMstmDEH5JWlE2DXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189558; c=relaxed/simple;
	bh=CFdVGbAK5X4m8wQ3xQyQNHxuchIc/pQWBeMbX79bX/g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cKlli/wCDFimiwsKwMMJIzMoejfFXSHaN8yIke1MlsNk6IHEoE3Tu4QufvnK9ecmYmVactsbf+BMCmS9apj7kkUIj81KCT1LdxHan8SFSrbDUpf3Md/gMYnlDQmVVHts6C081NjmPSDftCJKUH6C2UQ+JZ+YyztebCprUm5uHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rp1DHBk7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMgtCoIt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B88vmJG4184817
	for <linux-wireless@vger.kernel.org>; Mon, 8 Dec 2025 10:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ulpUzcOI0DOsr/m9KEAJ8744zQ8VdOfiauSWUgs8hgE=; b=Rp1DHBk7C2eRzrSv
	NORUK12i3AKIdww5kyw6l+rY4yA/6xy2fKPt/vXsTvikhjBXM7GqjwH6R9IYgjMd
	zmnb6pREVZgkC9D1e3P7Cr4vJSMjdHZzcscKmPkcw/DIV0G3fbBafiOlr1qAnBc1
	q96YrCyfvhc54EuYMeCMfme1BBAk28/kXRXsc4+5h05g7BRRGDWZrn8B91YBfWw7
	LWy3nlLFNUUqWO1ksXEYS+itZ7x54IHC6NpcX/QA50YmAR1xghCSdbroQ6uv00bZ
	j7tBp27r/27FHOhZEbRJZSPNHwvUkjidQJqtgl+21mGYPE9ZAAJnTKgSZAmg1Z4b
	ZfHk0Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awume893k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 10:25:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso6948083a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765189555; x=1765794355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulpUzcOI0DOsr/m9KEAJ8744zQ8VdOfiauSWUgs8hgE=;
        b=TMgtCoItgdSnSRdlPYeVnG8HwHiGD6NPQZWO3QSOeMlFxRgXR454Rj5E0NIVwwb8VD
         7XhLYmOIZaO6BxgaswRgKRUqTDePYoph8zByqU3O4iIz78h1NL9uhcCevSUSX78+M0+B
         6YSiFGVyukTy+MdNGnCRzqyJtkL2g8MUyFBVwOWopQD0RxvIBG5Sc+7jVS6IFuCwEHqe
         L55xXMjVir+Z/jQ8ja+M7u72aQL1lLqkMunvM+1cszY2wgmVxIyeQKkwZ/NZUF0XadSH
         bjIzmYoGe2ARs6WucA2k5Chln5m+E77jB7RZryv7HD5+EI9Y935PNrLE1gmXwn4RIPNr
         OaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765189555; x=1765794355;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulpUzcOI0DOsr/m9KEAJ8744zQ8VdOfiauSWUgs8hgE=;
        b=WWpLe4wGjGH8ommcdQeeA3WePwuBj55td/9IzHctOW8t4hJIr9kygqjMVR67qfAeAc
         FnE6wQj9rP72AdRbdI06nytbeuhlleY3H0N2KMo9inUi3P0Q/4igH9kmUYvsB7vVzeOj
         XIy6s6ThLUrzzj8X8W+/ztGI+ALhOGMM5feEWUUrikmSJ6OjDCmzlzdMjBC6Ln971ive
         7TLW3hnAEOoFRh1s91CxHjm2nVamj1M9JpKPO1NlO9Z7PFbueIgY2gxtTjBxK7LV65Sx
         +mZ61W0G4xIm6vKVAKZnLbsr6hBrljUnK9Tt/QUiOHvwyA0+N9gDcOufqHH9rBb2AtIq
         69kw==
X-Gm-Message-State: AOJu0YzkXNkU6g3nA+DMBLpQhAP5ifYCpxsGdK8Y86uq1749/h25MTMm
	nXENTe3qPYPMXrLyN/5aXmmNTE+0WdUx/yt2DSgAQfdagCxBT0k/xJqVu2bwxO/6TMBqNFFitur
	YKmogbhLLDDgfj8O/VouBjFr/2bXwg0xjXgbCrKXnWfXYAEvaRH5CCRkwZVY5LR+lblTpyw==
X-Gm-Gg: ASbGnctcc9wXrdGKtr0+PxLewDTs77jyoRDmUOjnAt816EQjY8KNkNVCqMDtN9Q37QR
	q6MXyPI1ZIuhW509MfUeDw8GDyBj2/8iY9ZhXzb16neK2KN6XgKsxv0XFhrc/YkBrHEsP6c1I5k
	mWkarmUBpmGolR9sfpiMhwzo8xgf2h86yzIKCGxJARGXeJ8Oirf1iNS+LfencFE3qyjRKYWJd+T
	o8cVP+2OfuMteksUQNNNvdeUdKSyMPnnoFFEj8MzqxGLCjq3twDc5+D2sP4YQrXwqP5yCeKEZA8
	AZe1Wb9ns7wc9KBdkQzoBf6FxQY44BHwGZWUk/8tapIRrds05Xdpb5E8g3G+QFgXjWxFisX1n87
	MDiVsEE6mEr7i/Hxe86WVsJYCxK36v49vUCiveUUfeoKFdVaaXjJ2Hv4=
X-Received: by 2002:a05:6a21:85:b0:366:19e9:f43 with SMTP id adf61e73a8af0-36619e91026mr4486321637.6.1765189555525;
        Mon, 08 Dec 2025 02:25:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHi4NgRf4xCP5w/2kWJWdtK5tmc7qqJ+20GvzzvL4l1ADN7TyD9p63Q+t6ddAUDt4M0XxPXQ==
X-Received: by 2002:a05:6a21:85:b0:366:19e9:f43 with SMTP id adf61e73a8af0-36619e91026mr4486301637.6.1765189555057;
        Mon, 08 Dec 2025 02:25:55 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817395ccsm11711435a12.5.2025.12.08.02.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 02:25:54 -0800 (PST)
Message-ID: <cbf3e828-77c9-8291-1328-7e876a8843d1@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 15:55:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB
 region
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
 <01a05a49-ae5f-a3ec-7685-02a5f7cb9652@oss.qualcomm.com>
In-Reply-To: <01a05a49-ae5f-a3ec-7685-02a5f7cb9652@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA4OCBTYWx0ZWRfX+WqOW1+8Mcl5
 JzJMXnTC2YuBEOugx/UR+fu2UlWvZIlf2ePLNgDTo1EZ1X4lZc1ZWEGuxY178sFdPJfFypP6Yvr
 rNUFBRU4lAvuBqs2g3PD4qKBssAHqKoKOqH0wzHVIR9JiBZeZ46VqwkJD9oDWIFqveQpMk6OXFH
 jpZbzFdvFqI3Fbn+w64V9nLyF6fIYjpe/8vYUDmEuePoer5vQLm95whZmlUyTi8sB7xniFYZgV4
 2wKF0GSEaKi1VVJUu5O2sVpzPLvwklqj9A3/5BCS+joDjJAwTi6iT1BeJfbYq0xQK+uRcTq3Swd
 ShbIUGwL+f218/WoMjsK0dUOrvHM1lnrBXCvQr4N0WlKij7xJ0SLX2yJlWFLQw/8w42oz32RDmZ
 xJkDMO/T6aiO+hCOjbsgHdU79i8j1w==
X-Proofpoint-GUID: PL6w1n5Tr9kj8XknTSux5pGZc0LcRIQx
X-Proofpoint-ORIG-GUID: PL6w1n5Tr9kj8XknTSux5pGZc0LcRIQx
X-Authority-Analysis: v=2.4 cv=SvadKfO0 c=1 sm=1 tr=0 ts=6936a7b4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=cJq7uKxvQhbKIWGweLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080088



On 12/8/2025 3:38 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 12/6/2025 11:28 PM, Alexandru Gagniuc wrote:
>> Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
>> assumes that:
>>    1. firmware will make a HOST_DDR_REGION_TYPE request, and
>>    2. this request is processed before CALDB_MEM_REGION_TYPE
>>
>> In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
>> after the host region.
>>
>> However, if the HOST_DDR_REGION_TYPE request is not made, or the
> 
> AFAICT, this is highly unlikely as HOST_DDR_REGION_TYPE will always be before
> CALDB_MEM_REGION_TYPE. >
>> reserved-memory node is not present, then res.start and res.end are 0,
>> and host_ddr_sz remains uninitialized. The physical address should
>> fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
>>
>> resource_size(&res) returns 1 for an empty resource, and thus the if
>> clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
>> is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
>>
>> Use "if (res.end > res.start)" for the predicate, which correctly
>> falls back to ATH11K_QMI_CALDB_ADDRESS.
>>
>> Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for 
>> "memory-region"")
>>
>> Cc: stable@vger.kernel.org # v6.18
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index aea56c38bf8f3..6cc26d1c1e2a4 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -2054,7 +2054,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>>                   return ret;
>>               }
>> -            if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
>> +            if (resource_size(&res) < ab->qmi.target_mem[i].size) {
>>                   ath11k_dbg(ab, ATH11K_DBG_QMI,
>>                          "fail to assign memory of sz\n");
>>                   return -EINVAL;
>> @@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>>               }
>>               if (ath11k_core_coldboot_cal_support(ab)) {
>> -                if (resource_size(&res)) {
>> +                if (res.end > res.start) {
>>                       ab->qmi.target_mem[idx].paddr =
>>                               res.start + host_ddr_sz;
>>                       ab->qmi.target_mem[idx].iaddr =
> 
> The rest looks good.
> 
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> 

Well, since CALDB_MEM_REGION_TYPE will always come only after HOST_DDR_REGION_TYPE we'll 
not be running into this issue in real deployment with ath11k firmware binaries available 
in public.


