Return-Path: <linux-wireless+bounces-27490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BAFB866F2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C1F58878C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313512D3A70;
	Thu, 18 Sep 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KH28pdFF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A582D29C8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220936; cv=none; b=imOxIKzOjgG8MhDN/xstzndR72IYs3rAMxtIAX+cjE6YFGpxW135/g9nqH+FE+vOUlOTBMiHL99qdIP8ERthFlvZC4KXvJSnVyqLAhLqb4zeUeVOOowUNE/RRbhb9yKiwsLsQnd7RfTsxZNaaIzAg1He7uSQ0AMeGAJOWD89I6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220936; c=relaxed/simple;
	bh=po+vLPdEwz+nRrn33wQ6Gz1tHmjdtWHriulevSWkdgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIx3xyvHjCSRXmP4xUq3wN+Z2KtwhKdh/5G6TWqiTzp+gg9H7lpILm2XYo3c9RsxFHs/7h7R8OZcT8Z4FRecqsLinJceY1qERsr/O2bPkeWbO5cXuxNDqVV9DCJaKsoZheKmmg1Hps/RcisvrsT4i9ZtZ7NrCjUurioku136nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KH28pdFF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIGFRC029580
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 18:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nF1fA0zbp7Djqf2UTk7dkerj+IhERcStYJUK4pvZ96Y=; b=KH28pdFFlHijuxsQ
	Tkqdw1reTQqEDndBc+MUD9qCFuM2XNpbvqD4c2uEhhH2V4OCR919S5v1UB7AQEy5
	3RlVlVzpTBlZBZONRaTU+84KuVpp9SAY40yGm11mLbRM+bgbzopewjHgb0LbM7Ya
	FGdvtXNzsSTxKCxYO6qfrRFKwN8VwBRaNcPsdcqePqFsn1WGtNZVRw5MqexVIaE/
	iARYmzkEdCwMMREiX/9LTzrhlVHScA/zUXa9hLhVecVVL/hE33NyS+UkgoQRZ4Lw
	tdQryztVonOH63nY8jL4OttMdwwXTOVb/VIThGwyw36RIhVMGDrER0/sPyJn89d8
	9H/keQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0yjk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 18:42:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so1935248b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 11:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758220933; x=1758825733;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nF1fA0zbp7Djqf2UTk7dkerj+IhERcStYJUK4pvZ96Y=;
        b=KCtKe/DQ20gc4fDktdciNnzZsgildM/4OrkBaB5ea0Vwn6loDZ2aiJVTc+DEX4UDp7
         dfSgrCDMUHeOxGBvYp4aSG57Sthb4KqnawwSIzul5agbhf/HsveRjHDgnH28ZOovBhe8
         wU/ThdYykFD+mbhdL8tmVYAFngRErEP/wGeneu5CGloTYaHnO/N9AQpBFcp1jaf21XuM
         S9Baqkze5Oxz72b0YJ5l58xIA0vPJe2mUYTE/ykgIsPUdADnGjgDwIvXzbog1m7M6ygD
         /18VVuyaYuiPgbl+G03i7n3a+1P9YEPWNB2zgA8J1b1atxFKUhCE7iyXC3hr8inpE8oI
         fLmA==
X-Forwarded-Encrypted: i=1; AJvYcCUKMZaGNZcfToALZ6zC5o+nCHArr9apXDqWAAzwhESzDF5445pmQ5VPYwKT3jfA2lCoH+eU9wEK6xLV/MpB0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0snjzoFY+JV0a9wyXn5Hc/ktVdVI5Ho4YUsxOpYKmciBM+x8d
	fcr14PCrYmd0TTPhPZ8RYaSo6Ge3/uWjFCuBOtHjRaJbJE6b/qjVGdT4xejrZwq3eMKrzfUzdkm
	LIYXDP/CKpbEej9TCb6nPOMO7xut4ArZL7BBvNbU3XslZrSwmvouA713HYY2TJnc3TNkEy+dZcp
	M03A==
X-Gm-Gg: ASbGncsBG1ZmtkdRgfw5jWBw1xP82U4IM1RN/J6nHbRvz+orQFB+2sx9AfFD2x/7XD8
	655JUlF8RLyvRNfRzIbK5P1kg3y9Ksl0zqmFcaT7apHj7ib6sDxAozuG/Os/JFgcIE7duSBGh32
	4fOiHAcjtOdCTiJL48wsWgqInEFrRFF/QIKvpHwZNKhQBLYq+rsYrsvZP9kTJ3iHpnGBwxth/0Y
	wj487jUYSLoV2D1p9gTuNYaeJM+uRfmIQH9opZHLPiR+ArSpAZDoajAqo7qq3CAVzOIowCAOMOE
	pIyLS5CKoU8ClXuwofhs7CyOv8+2Sg/nW7IA3Jdo78S6jvyJunaHZFfUZyHZm+QkuTf2Qauf6gA
	BExz69TAh/Cl96wjYby2wjlZK/vW12Pm9oxAs
X-Received: by 2002:a05:6a00:3cc9:b0:776:8b9d:85ad with SMTP id d2e1a72fcca58-77e4e8ae21dmr394530b3a.19.1758220932896;
        Thu, 18 Sep 2025 11:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzBPxPNDF/BcchRmyd2ICCvlhe8W1SbwWFUAF0xA+HbKxZJwRAh+LwrobiAdxKNso5yJHRKQ==
X-Received: by 2002:a05:6a00:3cc9:b0:776:8b9d:85ad with SMTP id d2e1a72fcca58-77e4e8ae21dmr394497b3a.19.1758220932404;
        Thu, 18 Sep 2025 11:42:12 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40601sm3020533b3a.87.2025.09.18.11.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:42:12 -0700 (PDT)
Message-ID: <eb3a2ef9-3f93-48be-b6d4-28eeeba84f04@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 11:42:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] ath10k: remove gpio number assignment
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250808151822.536879-1-arnd@kernel.org>
 <20250808151822.536879-17-arnd@kernel.org>
 <27c1274c-e021-ba69-175d-a1271c33498b@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <27c1274c-e021-ba69-175d-a1271c33498b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GBO8ZnI-PYm8hvjTdVM3FgsrhnBP9EG1
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cc5285 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=FtxLtjK2MU5K6IsP0WQA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: GBO8ZnI-PYm8hvjTdVM3FgsrhnBP9EG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+JSLm6+eBYSe
 DPurtppqMyua1f0YA/l5FqBEsRD05o/bi7boaOauYsWTsSn4vHxOmA1L3LV61DyQoR1uGCIiSyT
 zL59BUtuxa+kQRMVaZjVCbD14XNzpbBj13jszNpQqr6VLP/J+TDugqSBpBpufverA5T0iGnoSMk
 RlZMP4GGd8Dh5aAlVt5aFieEKHZ4R0rPgbEPCiAWTE6bzRLjG7tOfy0JFulFNXcPWG+tyytpED2
 aXe7P+RiM9U2qGGAd0CcaO5OUebG8orKihD0RsZO4cr+WN8wQHQIPoKpvFqK13Ge3Kpe9UdzkAq
 efBeWtHVzByj+cOlSmRPIr6t655VptiKkE2ZoYrMyI2PS6r/+XQulnGu5FhNJTZcZ2EmM8OsrUv
 no4kvuca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/2025 10:22 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 8/8/2025 8:48 PM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The leds-gpio traditionally takes a global gpio number in its platform
>> data, but the number assigned here is not actually such a number but
>> only meant to be used internally to this driver.
>>
>> As part of the kernel-wide cleanup of the old gpiolib interfaces, the
>> 'gpio' number field is going away, so to keep ath10k building, move
>> the assignment into a private structure instead.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/net/wireless/ath/ath10k/leds.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> wifi tag is missing in the patch title.
> 

I'll fix this when I apply the patch

