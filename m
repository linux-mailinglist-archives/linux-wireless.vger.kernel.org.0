Return-Path: <linux-wireless+bounces-29270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEAC7EF32
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 05:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23E0C4E1A9A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 04:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D926FDA8;
	Mon, 24 Nov 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VtcruqT7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eUcWfF2D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86FB4F5E0
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958937; cv=none; b=lCGPgIw3kqufQbhPxqT+Oq7tnx8WtSbv7fBh2rnJVTtarpqyDGbjSrsx1OEe1EnqxLP50kqWJYv3rfa4W7oq37sMZVM6AS2eQquLXFugnMhWl+JcoXbgPucyyeDkZL0HUYVlFl4+aVT7CwNJA65c+3aRMr7qnh/HHfMRkQ9YxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958937; c=relaxed/simple;
	bh=UCqyxtwDvPSUWDVaJ4qE7cq5opg/RqGKH9A2GXuDCXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcNROtGPLNIzl3x+GgH005/NWxwxJ/4l/DzUhNVN+13y+/aZcurRWrTiYZZyhimU6vpY5N3GTc6HE0PfQNWgCgJhb3/9xbzS9XCNnip4MdcIHddoMcOxJPxAcNkYK5omgBvn8fGx3lUZI29fouwVXnP3JvlIbDhjgMh2poxNBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtcruqT7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eUcWfF2D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ANKe0cj2092743
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 04:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FbevJm9Pl3kJnjnGfCoLXbP0BZc5/opBkecns7ZWoDg=; b=VtcruqT7GUhmrvhY
	d+hQQ36kDUhN4Sk1qVJh9M5UWbvI+YyFyH1dIraDHmbVfObeTWWn3e4WTH64j+B4
	ALwtKWEf9HvcGf9TkCTwYZO64rXhEmnM7WS9Z0yI6tswyIisf/FW+x/KixUFvkR4
	Vw+QVQtyUMi0IoMnAMjwZM3OIRY9ISDpVArWSZx2i3afBT7hVUV+eTcJCen9j158
	8oTlRAyvR2aqrUQKUV2X2Hn/lNPh0Paltbz3eKLgZrz/H62ms7AJtQqS9gmQY1OZ
	GQD3i9EUtmm+yWaKMilkXS8Hud2nCQTiggTpfax246kvtoxKJ5NbOUY+k8GyAolK
	EECnFg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak68dumg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 04:35:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ba92341f38so3948296b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 20:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763958933; x=1764563733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbevJm9Pl3kJnjnGfCoLXbP0BZc5/opBkecns7ZWoDg=;
        b=eUcWfF2D16yP+X15KhPfTM/b48aH91CtPDA2lQeegfVLYVAzRX0a3a6u7i+a+CWtSz
         ojxYeF0mqIsVMSzyRDoZFAn3Lz4DAy4mfcP6dMcFFpcgHZLkCm0axj9t4/lcB7Bf0W6s
         fQliHuFsF8+zG8qQzoWy7jWi2pzKxLP7XhbTNp6/ylrbGFkcfRFly0CnjSNTCbBwUZzo
         wMUZkQVjTzzCK6wRMKObrczmlkbJcYpKgi1MZQGqr8pxl+yqbRADpVvbeyi0/wOiIFrT
         9fC4FfEWdmI+WcjRjNkqpcocVZJT145prxlHmcekw099+ruOD/bVGQMaVeJZ3y5aqjs+
         /lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958933; x=1764563733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbevJm9Pl3kJnjnGfCoLXbP0BZc5/opBkecns7ZWoDg=;
        b=LH9cWdrXhIgE202P92Xo9hCjCUtNTLLoQGOsLFq6tFJCGcOw5F+d/+WsjupsaJG183
         vQK7GdrAWVTHUgO1LqjXxIm2kw1yvlMkndYSo4S+hVGL67OedrLisiL74d/1JGBI/8GY
         jUBkoQT2jvLuHxa9NWWgjjMRC5D8/lZ9ti1nDMbdJl59kvonm+eNIlF3js1ZJgwG/Rtk
         jjAFV+Qmst+4JGbBcjdysotuW7fyTXuUL+AF6Hz+VmRievRNiKsisd0b3yxVmm9ySEqJ
         rK8JjeuKHXTYVqgvigg9aS0jFpEMP/+Rc75ZnXW8hPT8uwGJ5kwbkZ2RMXRyDW27rTRe
         XRtA==
X-Forwarded-Encrypted: i=1; AJvYcCXcA0Wnc3cRjladZYwhv/3bvZBpiANZuL9e+ccMEUbSz8qWv1ms90lVcp7pr5Uv5pqZL1YZlBSyl28/DwKSjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZj+GiZTj2FpaHSizWt2vh+JuH31/f16AEPa8izWqjg1UanupH
	+RCtlmLEnHcirJQ6eSCN8BlIEtm26RKbKh/7bfnu4LBDkTi7Rr7y8UjQRqB06ZTbQg2p1irwiUZ
	Vx0R0FyaTyR+xoP3DAzTKoHNnwabuSr0K/QV56ASlkvBtD7ai/ftTz3eJ72e2+vMuh/Bcyg==
X-Gm-Gg: ASbGncsxtNVTsMm2qPBG72zHe9cY6H5PyqN47tWRNG7LzhnemxowhhhBThnrqkAXs6N
	d9YnNo/O4EA+TeuWCvzofe08p4ME2yN8TAszgo6SeobGuar5hCxUd2IulpqfGKn52aSdF2SRxeW
	iYireMMPkck1uFMrK7lnjWXVHu7iTBMSxT6kRr9kRlsTab8qgkWYI9PqNOJQzDzNbQ02/6fmH0d
	E8lrRFWHDNuCa4Z19h9L9zBDdgy82p1cOFlnI41OE+pmEJTFWJ0EUkbS66gP+pDjljlUHngao+t
	AT/tbwmRqGSVSkEN4Bb4Pg8o6hoM29cXy0QtuV2HVJXSmjJNixF1q4DIbVPgm3zvWko2BoLXuN6
	NDo1W6hpvQ+y2PJHOi2ei4jodj296wQ+/H6BjvExHKbfAMIVVb4gZ7yI=
X-Received: by 2002:a05:6a00:17a0:b0:7a4:f552:b522 with SMTP id d2e1a72fcca58-7c58e7faec0mr10370146b3a.27.1763958933415;
        Sun, 23 Nov 2025 20:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1TK3dBRe8KyaC2l7J9pUqlzawaSjUB3R3uVMfDfBbRZBBa0WJwB4JlBuZvCe41gv63ZDpNA==
X-Received: by 2002:a05:6a00:17a0:b0:7a4:f552:b522 with SMTP id d2e1a72fcca58-7c58e7faec0mr10370125b3a.27.1763958932900;
        Sun, 23 Nov 2025 20:35:32 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed0751dfsm12921765b3a.6.2025.11.23.20.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 20:35:32 -0800 (PST)
Message-ID: <cf3ff4c8-7884-5c07-11ae-29f169be76a2@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 10:05:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
Content-Language: en-US
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        =?UTF-8?Q?Pawe=c5=82_Owoc?= <frut3k7@gmail.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_yuzha@quicinc.com
References: <3f355c8a-5bf2-4a74-9b35-daa8ae479736@oss.qualcomm.com>
 <CAKEyCaD4=qeQZYYOv4BTrqUJkZa+jnea1b3BL434X1iGMA-_xg@mail.gmail.com>
 <35c554a3-efdd-425c-ac34-858a927bbe15@oss.qualcomm.com>
 <e7e4058e-6f95-444f-b843-d942496dcf07@dd-wrt.com>
 <4a91f85b-12cd-42b6-854f-6e9574392791@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <4a91f85b-12cd-42b6-854f-6e9574392791@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDAzOCBTYWx0ZWRfXyTVxPza4HUrJ
 TvzH6NlPRLeP1Db4tPxz6GlIaayIrhQSjHN5Lia9fPOlCKaIXdCveeezoMM/k+oOkS4+OHvRBMo
 +KtH3t0yXzHJHi3vy+O9e0h4jjeuN4/fM6OPBdi+WDQ4/Zn0SQtqRE1n+vIQ1o/74Gh1V6HD/a9
 H+hWaRGTiwAFsRjb4c950bf7XpZz4fjXiipPDoD+4s26ks86JnvLZTVGmI+EO8cB7X1k3nyKhqc
 Pm5qjLQDGJ5bEOLY9qlHRepQ59kt9gHL4+H3Vacd5GINP84vR5XsPxRu1R6zui2IWABPtRk15bx
 8j7N5T/z/0Oc9C05oT7LESCvRVjN/4ydCEee3QwM+htvOX87u3h3DMmYbD6HISxra5jLRvBVTvD
 zZhXCot1eEwSiFhgGx8Ww2nO3FruxA==
X-Proofpoint-GUID: 4TVsNoDEI_-88yNATG2HMuE6V7XZN93I
X-Proofpoint-ORIG-GUID: 4TVsNoDEI_-88yNATG2HMuE6V7XZN93I
X-Authority-Analysis: v=2.4 cv=UsBu9uwB c=1 sm=1 tr=0 ts=6923e096 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=KjjK3oRhKhDB2nV3eXUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_02,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240038



On 11/24/2025 6:39 AM, Yu Zhang(Yuriy) wrote:
> 
> 
> On 11/22/2025 6:17 PM, Sebastian Gottschall wrote:
>> Am 22.11.2025 um 08:55 schrieb Yu Zhang(Yuriy):
>>
>>>
>>>
>>> On 11/21/2025 4:41 PM, Paweł Owoc wrote:
>>>> On Fri, Nov 21, 2025 at 6:00 AM Yu Zhang(Yuriy)
>>>> <yu.zhang@oss.qualcomm.com> wrote:
>>>>>
>>>>> hi,
>>>>>
>>>>>   From your log/calltrace, I didn’t see any errors related to MU EDCA;
>>>>> what I saw were related to SMPS. Did you also add changes related to SMPS?
>>>>>
>>>>> Yuriy
>>>>
>>>> Hi Yuriy,
>>>>
>>>> Thanks for your reply. The ath11k driver is version 6.14.12.
>>>> Everything works if I remove the mu_edca setting without any other changes.
>>>>
>>>> The problem doesn't occur with the newer IPQ8074 firmware, version 2.12-01460,
>>>> which hasn't been publicly released.
>>>
>>> So the newer IPQ8074 firmware fixed this issue, great.
>>>
>>>>
>>>> More details: https://github.com/openwrt/openwrt/issues/20702
>>>>
>>>> Regards,
>> the point is what he mentions that these newer firmwares arent available public. i 
>> provided openwrt these images for testing
>> so he is asking if or when qualcomm does release newer firmwares to the public repositories
>>
>> Sebastian
>>
>>>
>>>
>>>
> 
> hi, Jeff and Vasanthakumar
> 
> When will release the newer IPQ8074 firmware 2.12-01460?

I guess the issue has to be addressed with the current firmware binaries as well.

@Pawel, can you pls share the debug log with debug_mask=0x73 (AHB|WMI|MAC|BOOT|QMI)?

Vasanth

