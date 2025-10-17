Return-Path: <linux-wireless+bounces-28035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC15BEA75C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5AEB5896B7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575CE257437;
	Fri, 17 Oct 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtAt1Kef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BF231C9F
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716666; cv=none; b=Hkd7dWs4jvkOZmE0bLoNBiCmFSNX1xRpGXJGb/R2yRaPOWC9Iu16t461n5BmwQFOlPBvozJLUnp2buHfpvZQGPSBoC0y6tGXB7yOmvV04oeA9NoCd6JXwPgu1oyixZOTkrITjwUmjyWW2AWUrt5SGD3Uq2eFIDgX5LBFN58/u1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716666; c=relaxed/simple;
	bh=1z8mFPc+g7yAQ/45ZUryZ9zAoZA5Kq2Um1llUPtHebc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIlW7uc5wSdGo6QcZxVvFaKFX0YeFWhklkSLW68B1RZ7n5liQsgcNKAx59r3bI0KUAbGQmHI24cw71uvMVFAqCgZ0jGoTM6e2xHb7AH5kVdV/7olS03H9ck5o855qSREqqqP6x7KKslnVXisrDZLrQQWhBUYWcRyOrCQCSDMFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GtAt1Kef; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7oXDg025253
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 15:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GA/XjYdGjZ7tzpUjYOV5X8f91ozwneXQxXQ9c7C3ybg=; b=GtAt1Kefag9lGI6W
	Y7+UMD4gK2sEnhYr4bxvc50x/7GdpfhBWJqZjlL7CfGPoBbYAwm7RSpgwFnMjIYl
	Ab4kHiP0EsQ64P0MhXtRlMruwvJtIWGwdhjd/i0PIyDfsAVjT6v7BUuF44cadJbF
	MRIVfkZPqc7bM85sydhJQYSHkzFoukZNkV3pnuycXnI2nUPrgGLM9Zjikwxl0rY+
	BuWr/dB1u5c9XJaoMAArJbhcFbn+g4MznrbP2GYckqiRmpEvzzxZWl8tlUfckHTd
	c2HOMxquKS7xKDaJOpRwS0whJ51DGiEo+JUpoY6Fdtx+v4yySGJxQHXjBzwfOBAr
	pe0dTA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkmt63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 15:57:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso2080439b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 08:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716662; x=1761321462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GA/XjYdGjZ7tzpUjYOV5X8f91ozwneXQxXQ9c7C3ybg=;
        b=WiUgthUpABu0kB3ny7Mzt9pjdmI8eVmLkLEL8mo2W3UpU9mJN3W4r7lhMHo9Sgqees
         DmX5TEjHj6Aa9jfKeGqhkfkmnvnFFxwhuE0agq4WaQIhypCZ9SNvV6QJUlRTpYj9h/o9
         qouWff0UWLt83chgTGOWee3I3rWr7eboueblgUrs3pNn+M8kYsqJJM9zvidrQ4i/Gf0q
         /pEUsGa0QTVeWVdCtUPmthR0jjkUpvFCfkrv7wkHWBtDroRwwGJBFxmdve0XsPuocHzT
         jD+fTDayPXL2bT53zTuEs4cjA/a1FeVitcnG7PXRVb9+JcqkF6WqqSi1OSG7+GwQ4aub
         03dA==
X-Gm-Message-State: AOJu0YwNVzf/GjHTlq05WyDUBcHN07Dad/mKGh2K8eDErZZ+A/ekaaqS
	d574MlzkQTivvcYoDWEympvxliJRLYYWMCM4QstAEOyvNPLa+PhZ/tXev2DG3dk5rTIl9m6+Ku+
	euRWPFRA8rj7/yywzYE1R5nReSGMshsz2nKJar7FWhIs3sAyAAQoTXYn54hWIkkcrUTownQ==
X-Gm-Gg: ASbGnctuHKh/abz7ZOC6Atm7DX0yONHsD8rbTvaaVrSqHwXda+cO9AmM36N7NKjQW4j
	kmNcXSeKsS1UBMemsHECyFI0C883LQaZVWg1aE+EFMWM5DzFsidWGdSXBTo6rCXT6Acu87QiiCp
	3+8k2eBxI4NVd9Uq/1/g39b6aeukzf0HTgQ5S9kUMexn4GOWdxLcR0gaMZ+yHok53qVTISfmrG9
	W0P9DE+4Fp2KYiMyyaKpt+FRAzs42stjEg0Su5Gb6nnC3hVFhJj8WT41TXC1r0kLC4ynA8DHc2W
	imrMWmsy7N7tr97mx+bPZbvcY0QGyWzGXYzaJELw3TnjcG3THK7VVrYiThrzOIqzjPf7Ij0pEMe
	qPNVJn7d6EcLItdWrMo7ozYm46I1ndIVpXqq9Dm7W1AOEOSdvERSIZetnEmMyDtjr9S0PACQ=
X-Received: by 2002:a05:6a00:3a05:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-7a220a83474mr4870544b3a.11.1760716662321;
        Fri, 17 Oct 2025 08:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEG0kQQyBJokWPqPUpBDr+VClTQlOa2zZV29zqtuleUAhDclL+l5xJ+z+cpPiams7RTcEdAg==
X-Received: by 2002:a05:6a00:3a05:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-7a220a83474mr4870521b3a.11.1760716661866;
        Fri, 17 Oct 2025 08:57:41 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b065ac2sm26007964b3a.16.2025.10.17.08.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 08:57:41 -0700 (PDT)
Message-ID: <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 08:57:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
To: Klaus Kudielka <klaus.kudielka@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        regressions@lists.linux.dev
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
 <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X0kB2m5o9F6GgDt1h2jxoUfmsSyqf3Hl
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f26777 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=CbrLfc9WufdjtirxkE8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: X0kB2m5o9F6GgDt1h2jxoUfmsSyqf3Hl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5xuxrQe6/TQn
 e4Jo4eW3wXsjQELKL2Xob2vple1uTVn2bHm3YfiOuOXCiIqfjl3M40v62qttuqswI6+dkIHqdaZ
 yWEc3c6a2QZDiVGxxkuivh0nf2TcLHc2/Zf6WQAPbbCVjnYpdEzBzURAIv2eIR3hUeozg0INW2R
 3/q0m9dKJP9LOooJCZ0OXGaiNsWJJL4rjy7CcvcJoTy63AR0Gmceo8rrCR26VcOe6xgx4AISemF
 ZSgMixjcuWQdhI8nnb2Clcf4+Bzeox6CqnRmaZKX9i3cI3c8eJvlidXy9LPjwyILglSqGIibNod
 tX27FMLLplvYE5uLyHQtiozzN8HEML9nyygkLDW/MbWgzWTfkgEVHM/fYNr7ibM38i5IHgESNG9
 SrUAVTM4T3ospvJ8OZzjFKDNandfiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/17/2025 8:37 AM, Klaus Kudielka wrote:
> On Thu, 2025-09-18 at 16:47 -0700, Jeff Johnson wrote:
>>
>> On Mon, 11 Aug 2025 17:26:45 +0800, Baochen Qiang wrote:
>>> Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
>>> failing") works around the failure in waiting for the service ready
>>> message by active polling. Note the polling is triggered after initial
>>> wait timeout, which means that the wait-till-timeout can not be avoided
>>> even the message is ready.
>>>
>>> A possible fix is to do polling once before wait as well, however this
>>> can not handle the race that the message arrives right after polling.
>>> So the solution is to do periodic polling until timeout.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] wifi: ath10k: avoid unnecessary wait for service ready message
>>       commit: 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a
>>
>> Best regards,
> 
> 
> Unfortunately, this particular commit completely breaks the ath10k driver in my setup.
> 
> 
> Hardware:
> - Turris Omnia (arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)
> - Wifi card (output from lspci): Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter

This issue was previously reported with that particular chipset.
This is currently being tracked at:
https://bugzilla.kernel.org/show_bug.cgi?id=220671

It may be useful to supply your information as a separate record to that bug.

/jeff


