Return-Path: <linux-wireless+bounces-28487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA1C2A5AE
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 08:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B653A67D3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC712BE658;
	Mon,  3 Nov 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HOQZKHdk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LK4z+5gO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552D29D282
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155456; cv=none; b=XZFGyr8NCbpS9ru+KlPuKk2LQ7BZuJrRA3JB3rU6cvnIZwhl+n8Xwi4rN78HZfC2+QGLYkKB9MuDSBcauO8XZfetUgWfX4+TR2RtfFV2dpC7FMJlHCJkW/FZLzbWD2bKGz2SXB0zj3ndG1/5OtIu+/JW8gX4YKEN5kaYyRUVsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155456; c=relaxed/simple;
	bh=MfZR+LskpRTC4y8CB9iwSU/ZE+amtfzDSPNjwSCYW+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keyCdyXtmXDjG/Y8Y/cvSfPPGOjx0e1RmO+HgLL944nHsEVagCcGWwrb9K+/NqTjVLl+k/XNgIrNYVtV1CtFVY4dgTAFKdzw2LBdVulLd5FtcXev+cc3FecLxRJ4Y65FA+6zM3lO0fIYXCF6ovA9Rt91tFOYWUoaiwXPKHNSo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HOQZKHdk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LK4z+5gO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A368V012269714
	for <linux-wireless@vger.kernel.org>; Mon, 3 Nov 2025 07:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3JXCgZLgZt59euN+7SYtL4D7oNSh6Gr61wJkEKqtQ8=; b=HOQZKHdkBaAoj4gT
	aHCPWykKvtRYa6t+42YS0My/FrLRB98mZe+PeakIbvw0LL8iqHuD0SoWAd+R+TzK
	Ppju3v2zGVsZD2oeK5lUIJwRJGQaAlKNfReWruKsCYkhyov6EUisWRUanAUOnuIp
	8W5n9VQEtrVWd29+6Cgi/4wmgYzExE3OcAylVMRaeV5AAfbD9GoXSq3RTKtxwrZC
	HuzknQ5IFBeCTtpE4tDjs99AxKeD6EdoJsgT7QWRmLTwN3r685gBylkl4s4HoMYX
	4Ko/Ph09lmXFye1xp2HzDQ69lLRpbQQPKy5g3CaM8Uoa+ZR0bJ6oh0TfxbyrnLGz
	5Njtcw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6pv787df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 07:37:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28eb14e3cafso75600465ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 23:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762155453; x=1762760253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L3JXCgZLgZt59euN+7SYtL4D7oNSh6Gr61wJkEKqtQ8=;
        b=LK4z+5gObgQtlvmS5gx1TYDXzQyP4xZ+y8wOkIjZey+ai6JItRjhsevEI4P08ok12A
         TZSKLfbdN9LgI+pVYHnw4p8davjfx9REh9TTptHg4YQo2wIhOOUkmPoH9Odnu6doFgX0
         Wm/Ek3GPIDTytFhoJRxDz5wcmpJrGw5GrsMc35zl0NtePaSnZrd0dzjcY8k1cEy4Gx7d
         Li4ls5ynCGD8lZ5vqwyis/NCjQ1lRYPVj+uZOOlibh+TtyIf43grSP0WASw/BMIfKTA0
         QiEYhrPeQ5Kgs6i+b1Witdz3x/e50fUgYXsMVCmeyz0+Nkl66KOxW3zYHHoBPaTZ6dky
         fG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155453; x=1762760253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3JXCgZLgZt59euN+7SYtL4D7oNSh6Gr61wJkEKqtQ8=;
        b=EDxNGtPj6FXu4XeLOnntML4HHxQuwuOVn9vyl/qAH2msVXK7x1wh3zfqwjh3k1a+OQ
         Ms4SPl/12FwAkKSF/9sRzyOrEV914eiZXkK2KXZvwISXjitqrZ1fVmP5Ou8S0biLe05m
         I565Qa1qT0ZLFi2QOJlfhQQa3NHRiZFsYqr6vU0Iv5pAwHZWApw/sN44SoCWH3SfUjpF
         nQK5Hh27PHY0ZezZ/MTizqm+OhDvdTOR32EVTlVmI1hxBmilum0rjjwcsAP/w3vmCdlw
         x2g7+qfxXYpMHVSBfR0jZ8mVc95zSw6c4hxMXs/EAKnu3QsCDgLvOMsj0y3XcLzjqz7p
         1SQw==
X-Forwarded-Encrypted: i=1; AJvYcCUME9bPMoGAFQT6n+4A0IRRgNXekMoQOtUyxnhQJSrmWxyrpqREccY98Pqgo03JKuoZzJM6ViIMeIvclZFPxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOJ6vx2wf9NXCusMPgVdS7Uf3Q/t0cxC02dIDXTx62NT8PnqE
	ku8IJeQuU5AjSuQnakZRHJeHGl7KPCxpT7dDu4fU3X7Hq/8II0Na/X8IZGC6Xn1NseQfYt3Nf9f
	37O3GTW5OVsux+oH8EUV9VNKDSeCkDNElw0LHTYCx4v6dFv6f1TrLqt6eOIVjl+Ge/2aKnQ==
X-Gm-Gg: ASbGncuwFsmpx6tqd8u0yLdfh5gN/0/1elPZepdnuShWVjnHwtHTqC0wcAghGlxYpWA
	l7a3dBihHd/Wc5QTuMpEHn86lXZLPLT1FhIg42Fw9o7Vze77zAaT0Z/mEGdZBlSHbsi06LFa/aX
	c0aiHT52IqtexeC1xvInU0BM/pM991fARz8Fqi1NW6Yv2y9keIqrkvnZ8O57atgJmZLc5hHCcgL
	eyLm0wA/yFKDTgDhX7adF638DI1oJuvyDgc0A6KFZXQ9y6iuarEPUuJd+tVCftLWZe/NbdBMtpP
	KJg80BqBiWlJ7qaaOB9Bbdh9f1pvxg4MtU/M10hsMewodonmqmZnmcxhO7JISUL2ERKrSoI4/gg
	nQvcTFRlGkkZEdBD3l+aUJfg=
X-Received: by 2002:a17:903:2302:b0:295:557e:746f with SMTP id d9443c01a7336-295557e7a25mr96007425ad.32.1762155452798;
        Sun, 02 Nov 2025 23:37:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGoYjUzwXxifSe05+L8+ZuGbe6Sp1Ukl+bahFZYvc6hkeGLR5aBvmkwawKJdsuKjuz39BQ2A==
X-Received: by 2002:a17:903:2302:b0:295:557e:746f with SMTP id d9443c01a7336-295557e7a25mr96007145ad.32.1762155452329;
        Sun, 02 Nov 2025 23:37:32 -0800 (PST)
Received: from [10.231.195.211] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ea51sm108400405ad.57.2025.11.02.23.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 23:37:31 -0800 (PST)
Message-ID: <dbb7c7ae-1c8e-4b7e-bbb5-a7866d173468@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 15:37:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
 <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
 <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
 <5d0e6d7b-d127-46be-8985-9be33a490aa0@oss.qualcomm.com>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <5d0e6d7b-d127-46be-8985-9be33a490aa0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hqGm5OPHGZ9zTiRc3LahfxzHNVfwK05U
X-Authority-Analysis: v=2.4 cv=A7dh/qWG c=1 sm=1 tr=0 ts=69085bbd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iy63uO9faCoK6JyWAJUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: hqGm5OPHGZ9zTiRc3LahfxzHNVfwK05U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3MCBTYWx0ZWRfX4WA8AQOpT6wB
 /4iuB1DsZPr6/xwSh2+6iJwW7nLXwM1KbfQPH73l2e8MO1kquG50laDdajDLdq+SQHIrv+53QZB
 NFFk3rqxdbLWQp5dlNnxrzhsVRA58yi8uv4wfjEj4Ka5V1R3rjU8FFIs4yipMO8dWxLcEndn1Sh
 zY3OPfV2J81cCT5kXdaEmz1TINNEPuYlEUBcCjMokU3XAansaaR2mPDkwnsPOoChA4Lu1pIsdm3
 6XAgxETl06rPnIuU0CP6v4efNfmXR0QIdEHyIePYHM/y+Q0QXnUTPHmKViGyokVS3TDRk8iub64
 B112bYj0jiCXzuDBAmM+pON48JSveYZ9/3PHCAmbSOFwZptZo/5vTN+JKmdSYdGICQm7thcFhp0
 cl6JoUR0Z6Q+kUVo9pLiqa616t9j9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030070



On 11/3/2025 11:14 AM, Baochen Qiang wrote:
> 
> 
> On 11/2/2025 5:21 PM, Yu Zhang(Yuriy) wrote:
>>
>>
>> On 10/31/2025 10:43 AM, Baochen Qiang wrote:
>>>
>>>
>>> On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:
>>>
>>>> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>>>>                ar = ab->pdevs[i].ar;
>>>>                cfr = &ar->cfr;
>>>>    +            ath11k_cfr_debug_unregister(ar);
>>>>                ath11k_cfr_ring_free(ar);
>>>>                  spin_lock_bh(&cfr->lut_lock);
>>>> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>>>>            }
>>>>              cfr->lut_num = num_lut_entries;
>>>> +
>>>> +        ath11k_cfr_debug_register(ar);
>>>>        }
>>>>          return 0;
>>>
>>> miss _debug_unregister() in the error handling?
>>>
>>>
>> The documention for debugfs_create_file() tells us:
>>   * NOTE: it's expected that most callers should _ignore_ the errors returned
>>   * by this function. Other debugfs functions handle the fact that the "dentry"
>>   * passed to them could be an error and they don't crash in that case.
>>   * Drivers should generally work fine even if debugfs fails to init anyway.
>>
>> So IMO any failure to create the file should be ignored.
> 
> Maybe I was not clear ...
> 
> I was not meaning the error check on ath11k_cfr_debug_register() or debugfs_create_file(),
> but was meaning that in the err handling below it, _debug_unregistered needs to be added:
> 

Got it，Thanks, will update.

> 		cfr->lut_num = num_lut_entries;
> +
> +               ath11k_cfr_debug_register(ar);
> 	}
> 
> 	return 0;
> 
> err:
> 	for (i = i - 1; i >= 0; i--) {
> 		ar = ab->pdevs[i].ar;
> 		cfr = &ar->cfr;
> 
> +		ath11k_cfr_debug_unregister()
> 		ath11k_cfr_ring_free(ar);
> 
> 		spin_lock_bh(&cfr->lut_lock);
> 		kfree(cfr->lut);
> 		cfr->lut = NULL;
> 		spin_unlock_bh(&cfr->lut_lock);
> 	}
> 	return ret;
> }
> 
>>
>>


