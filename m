Return-Path: <linux-wireless+bounces-20179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76152A5CB0F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D7717ACB0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968CF9D6;
	Tue, 11 Mar 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bVQC1W7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD533CA
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711549; cv=none; b=JtjHtcXWqdz3svJjLib/EdO0bEcOPV5lX3MPv/7+K4gUroObcK2JYGD3kXbABmhx+cb11OUc1Mq0xcRCXEDbsIlzSg+r7D1fApGzs3N3yjOzoVGjgbhGac3hywuU7Zjab3yJhxB54bHOaCB+Z93HvSrO7akHkjGqPphWWaPxKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711549; c=relaxed/simple;
	bh=+JTmRPoe9rq3Z4AiPu7Wh/kWljD0ng5xmB0ycz2nFV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lwoBQsLWOLc+BdUGa5bPPVwWKtvPB1i25lJ6KpYEQnP/MzbxavplSPO1nEsvueqBlQ85j5y4OIf0UhQkFPBWAbVnZkzBUKGSZk7qVuwkwR+nZ+2ZPfXbLBifVyaoSjwsBO0KmLehxTVJa4rIH+4DGkeCaAhav2wQh+25fcYM52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bVQC1W7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BFdIXA031608
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 16:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3g93QI/9e/9KODrRLKXGs/+j5hmHTgWZHXAv9B57BMM=; b=bVQC1W7L4W2f0gSL
	aBtfFDQZkgmUZixkrLCUAPewEC6g+czVQa61PJcxLEZqyjsN5UyDFhjzhug4CXeH
	aF2ald9nulF7RMcuSOQh7x2tanoS7iUkFSLZROgVxf3Ea427slDd8p5vQckUoRpr
	n+Yc0CmvmV1JbDCsSrhnv9eh9zZeuQlpeNuoHFbZ0vjXEpb6o3BI6C8763VtnOLu
	boppqcKVoDPq2xfxCjVTas1RBi9Ppa8REsjHMPyEEUIdURjsY+tHsPDCWOeYg6Zi
	Zj2WLrj74Y05/JxJIxTAoIjxkgCQinE6Y3pW1h8CihG+CpYKVsrUTaREXvNuZR9E
	qyfsjA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah3kspwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 16:45:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224192ff68bso87245785ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 09:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711546; x=1742316346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g93QI/9e/9KODrRLKXGs/+j5hmHTgWZHXAv9B57BMM=;
        b=KYUOYry+Z/Ct+gCKSksVU7rCcww8Xcio6VGAZD1wYoNwdLfofbBsRPYKviw+QCqMj5
         tL8VgT/KeTH4QGFGFknlm+f1GaXNeTenKuLEjXUwXQ8hDk6zMno8u5/qcyjtE62KrCiH
         KqGjJT0R6fYI3XEVHEG46Fjy1G+JV3MqE2NM5NW5JesFg5Tlh8OWtvU7Ps8YZnKjId5b
         6H17NAy4FnLq7ITYtO6xfr0j2a4MOHpEn4Mwa2bokoa4m5do7+puXMdM3+t8GrfMUZAK
         +tyzr5CzdmlDLupchamS7s1YWKqwYTHiJh7w+N0X8MF4IggFzVKGlOlm5MBlo5EPlHyg
         kICw==
X-Forwarded-Encrypted: i=1; AJvYcCX8V4hGLmn4Lf9U5RhKf6eeHXd0FWccg4GzYdBaIKXVKlyxgM5PiyIziJt7dVFXgtIyTWaiVLKzzdO103mOsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwNMuq8WFxUz5fu96dLMfAphzb2KvepYm6FrIiLa68Nxj/N8L
	602N3HtmDEHB781WxU9OoWTdouha2NbF1H/X47hqzRLp2nlwLOFeUR2P/VCemPKGJsGqRBbZ3oX
	SUifjzAnSk/vYjy4aTQERxqem5g7Sd+/QucQxg+bumqypm6hW2URL/q1AFwZS7pAuLA==
X-Gm-Gg: ASbGnctV6ODmbbXHnubNfOcA47kYORpOZFLow2T2/T51iwr9hfc9m1yR7a75WjOWaEd
	4iLhBPcbEzfm7ym+jfMvcjr1iQOoOcdhJ5HguFvJNTAsOBoaTph7XfkkI1QX+Sei2Gj6yAPYQ8y
	AWXFHvR5pZ17uT1jPD+uwP8N1PG4qy5ksEYb8+Ecb4gRmj8GBHtOAEB5Vij6VzHeHNBwiuj+fth
	+0JRaX3x86DkOMyMM0jnmWi2GcnAumZZHDHjddg6WwYt2bizJNwix9dOMM5NDr2F215vs4lqaxR
	Hocc+yon/6Q3GoSw+1oYc8Suf8rVcK6TSb15tJ00NZi/Dzw+V1Ech9J4NsXHDo9Y4L+hpu3y8H+
	5K+sy
X-Received: by 2002:a17:902:f70c:b0:223:49cb:5eaa with SMTP id d9443c01a7336-22593183d83mr62245305ad.35.1741711546428;
        Tue, 11 Mar 2025 09:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMKT0bhq9gObWNi1A7qYtgXk99hHQyFPCQuZU4Ev+zmdxvZYZAV0O9EZcj15+XH7XREyEbxQ==
X-Received: by 2002:a17:902:f70c:b0:223:49cb:5eaa with SMTP id d9443c01a7336-22593183d83mr62245035ad.35.1741711546091;
        Tue, 11 Mar 2025 09:45:46 -0700 (PDT)
Received: from [192.168.69.142] (c-98-35-147-9.hsd1.ca.comcast.net. [98.35.147.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91c50sm100408765ad.185.2025.03.11.09.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:45:45 -0700 (PDT)
Message-ID: <8da45052-def5-40fd-9701-7599e8fd5bda@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 09:45:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath12k: pass link_conf for tx_arvif
 retrieval
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
 <20250310200237.652950-4-aloka.dixit@oss.qualcomm.com>
 <289cca50-b559-4b7f-bc89-e089d7bdf6e0@oss.qualcomm.com>
 <b9ccf604-800e-4e4e-bf35-62d97cd1d90a@oss.qualcomm.com>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <b9ccf604-800e-4e4e-bf35-62d97cd1d90a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MhWWMOhAeLaPADyHPeWa26eigqnLYrYK
X-Authority-Analysis: v=2.4 cv=MJiamNZl c=1 sm=1 tr=0 ts=67d068bb cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=UlYobBNIKLIdKoAhXwLdVw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=92TBJxoUzZZWgJSFfrcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: MhWWMOhAeLaPADyHPeWa26eigqnLYrYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110106

On 3/10/2025 4:18 PM, Jeff Johnson wrote:
> On 3/10/2025 1:06 PM, Aloka Dixit wrote:
>> On 3/10/2025 1:02 PM, Aloka Dixit wrote:
>>> Three out of four callers to ath12k_mac_get_tx_arvif() have
>>> link_conf pointer already set for other operations. Pass it
>>> as a parameter. Modify ath12k_control_beaconing() to set
>>> link_conf first.
>>>
>>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>>> ---
>>>    drivers/net/wireless/ath/ath12k/mac.c | 31 +++++++++++++++------------
>>>    1 file changed, 17 insertions(+), 14 deletions(-)
>>>
>>
>> Forgot to add tested on tag:
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Will send the driver changes again with the tag if required once
>> nl80211/mac80211 review completes.
> 
> If Johannes accepts the first two patches I can add this to the ath12k patch.
> 
> Note, however, that you forgot the wireless-next subject prefix tag ;)
> 
> /jeff


Yeah, I see a nice table with warnings now,
will take care of it once the technical review is done :-)

