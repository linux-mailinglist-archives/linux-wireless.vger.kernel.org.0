Return-Path: <linux-wireless+bounces-26279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746CAB21972
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 01:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3253AF001
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 23:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F41D61BC;
	Mon, 11 Aug 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UfYdKDzC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2C1F4297
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955297; cv=none; b=BBJWSID/lofTOZS4vsrmRG3NnsP3ahit+98A0TbyNRui6xci+Kbcjvg6mUYzoA9YYyZDu6ESErw/XrVN3BhHGhZKZRz9isnYGyOlfvXp4lop3Ko0AzvBVwSjPVXUPp1JfkUnMwqnPZjJqIRLX1XsehRZOVuUVFZOMJbj0Lfr0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955297; c=relaxed/simple;
	bh=Sd0n99XhVVD6HmJrir4qoWLGZpM1P0+XkKs7NuY8Cgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6D2HVgXwd6wc2B5lnxkIQyl0mVznV5nHYuCzNvCIaHVYmGXw35ajuirqRRyvV/q0xstbiNQWLrr3BweBTCOQZGc5zwhO3VuD3hSHCLpC9rbvQfFM3cb8BiqaVcGPzHZXDqjGUcN/VW7lXCj2OOjVWWigugfJVHkCvS3dcpcHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UfYdKDzC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGvkPF029237
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 23:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dGsgGPBgImInUSa/S/a/bgy2SN3F+qWPRbzs8M9qZRg=; b=UfYdKDzCVDorIY0f
	xZNFXRoF5OdEb2TIZvoEbG+JXGHeCs8yC3cGXVZjXV/DkqNoQxnzv65xisMCazu3
	2qPgnQNf5jWSzy77dWrYzEdtuOgsKksWeSQ1loWAER/fS3KbPbe2SAWupUEmpoc0
	rcHpjsbhZdutypSSa7OaAV8C8JeLMuD06levYT6geCAsouvg0yYI/WYMJ0qCSRgh
	joZBpsG7HQYGOeORFuNv57+esVD9V0VkWogsU7tlLSXRv10RjK1UEkkeMbz8lRHz
	cHPFU37LyUZcUZSfca6WlCsJDLQKkwNa04q8bWlfqxIQ+l4gIXh7gXc9wBRRv6lF
	ukYgaQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygme2b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 23:34:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bf2f8ba3aso3964379b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 16:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754955294; x=1755560094;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGsgGPBgImInUSa/S/a/bgy2SN3F+qWPRbzs8M9qZRg=;
        b=UJXS+WAX/hrfPHvYRWhvKMwUZlRadraMTgI0ByhjWv9dX4jgmsGwlVakzca8UCyBsY
         OpJayePPWu7EuVtzVPXtjf6rGNLJUS71oOXvHq5zpFnWvluBRaG4NVf1i7vwmnzYvddA
         S2i3V9FS7yAayOs5Qi8EDoBl4UDde4zcr3SbsUuuTZOoWDygmUCp+qrSL9UsR6c2vRWF
         g9VOZ3gJLuBd20/6+QgafhoepHvrrQh179xezwDq7Q8LOPV98frks6ULrK3x4eYPbh5m
         0Zly69XtNO+nXT6Vh5u6dyjrxOa5NErFUH+gkr2URBtN2HBizNu/KHHpHzkMeSe/GloL
         QOTQ==
X-Gm-Message-State: AOJu0YyNPoBsFZS6w+rxRz3KoLPQJkZ1heE/4cJ0Vj3CUrO+5ov8w/yi
	J0gOLaW1NQ6tm9l/gXS9r0jNJd9nlPc3pqwaWakrTlLMXHu+adp+GkAGnV464ictfdPmioRDnVu
	iWSPPkvUx+lb6WO8HCOt/jpLrWKgRiwd7ZFYKjTI9a6+jMoOFTvuW6jBV+andv65KsAqs9g==
X-Gm-Gg: ASbGnctH5wSlJwrLKVxf8KyL+2ZbH0IW3AymgUG6URHiYEfkVLiPLOZsmTWlVT7/08k
	4+sildNeCu+KTP/yTROReUltdomUtEUTCwXkHdIxnXjBxhgcC9zzunKZzvZb0gb5/HB3pzdxgGx
	hLQNY7/9T9tAlXTGQEXMXKIY7nOxMFyh+8qXg0Ur4VhBPUUnwvh4L7T/JPDX/ylsm/JdjxtpB9Z
	AeC17IMooqPxuPdJD3dP2/D4vQ1/sg1ZQMx2gElSeZZ3UXnIdmPSZTOQE9TPus4O5bJ2IY5/6T1
	vRLK0CjCrXl5KfVDL+mHMIvBk0b42ppNKLz7nD7PXu3UWvu6gm/KywNyJDoPQdiEzb5+RHNfswl
	Nr+n0YsqbjWjZ7h3PTnIc7GnX2RRxhUcr
X-Received: by 2002:a17:903:2392:b0:237:e3bc:7691 with SMTP id d9443c01a7336-242fc351ad6mr23924405ad.13.1754955294204;
        Mon, 11 Aug 2025 16:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcAf6wG5Jrq1BlaBArK3/b+PZCCmoqHFiS1lwy/yi8xLa5GpCpUXgaZCTQAjPMSBzhPwNRzA==
X-Received: by 2002:a17:903:2392:b0:237:e3bc:7691 with SMTP id d9443c01a7336-242fc351ad6mr23924115ad.13.1754955293808;
        Mon, 11 Aug 2025 16:34:53 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef674bsm281745595ad.17.2025.08.11.16.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 16:34:52 -0700 (PDT)
Message-ID: <5b769b75-df2a-4dba-a41b-198851b61b9c@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 16:34:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via DISABLE_KEY"
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Steffen Moser <lists@steffen-moser.de>
References: <20250117191455.3395145-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250117191455.3395145-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX0OOafVwFGph3
 M7c3FjHZ0i7U9TxR/lt8aJdezTZqA0tSeG0uZ1GYIc2N2OfByfCIYf5HGrgN/TgUqBKAlfnxBre
 nKgKKTlZbiV6fYjnsgTEzpFSuoIYoUoi3cPyvu8vl+MMODF7llw8bn4MLlhafzuSJH3vKS8ER+K
 6NZRcTQiRCAFycvs6Tvpglju8BumXKlDfnyot7j60GohvyNmGXEOJnEjQtvD6ESj3G9vLuX576u
 3NTdyyrDtrtnRXaCxsOhTocfvEf89p3V71/DSlv5+AKK9ll8amB30kpCBEI15o1kJKa7QGwf1ui
 KNIQ6p2U0gqGlehbouFs8NvSdl0M8rX+B6WQzXbdpDADwKjQYq/LAeRcmPeuNoHBl+rN7c6bM6g
 HY4i7qfs
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689a7e1f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=qC_FGOx9AAAA:8
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=WobwCshsJSUAwqENw7MA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=fsdK_YakeE02zTmptMdW:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: ZZiVTZfZMZRgRvlBzl0oUYNrzqLzwx-K
X-Proofpoint-ORIG-GUID: ZZiVTZfZMZRgRvlBzl0oUYNrzqLzwx-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 1/17/2025 11:14 AM, Nicolas Escande wrote:
> This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
> 
> This as been reported by multiple people [0] that with this commit,
> broadcast packets were not being delivered after GTK exchange.
> Qualcomm seems to have a similar patch [1] confirming the issue.
> 
> [0] https://lore.kernel.org/linux-wireless/Z2Q9POuV-6MIdzRf@pilgrim/
> [1] https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-the-keys-properly-when-DISABLE_K.patch
> 
> Fixes: 436a4e886598 ("ath11k: clear the keys properly via DISABLE_KEY")
> Reported-by: Steffen Moser <lists@steffen-moser.de>
> Closes: https://lore.kernel.org/linux-wireless/c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---

Can you please check if this alternative addresses the issue:
[PATCH ath-current v4] wifi: ath11k: fix group data packet drops during rekey
https://msgid.link/20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com

Any Tested-on/Tested-by tags would be appreciated!

/jeff

