Return-Path: <linux-wireless+bounces-30668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DCD105D1
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 03:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672DA300F9C2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 02:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271D3A1B5;
	Mon, 12 Jan 2026 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9qjzfWA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L+j/xx0Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24A158538
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185478; cv=none; b=Qz28tePn5m6Z9XKxqRjBWK2XYj9gTagBB5x/AUzbUvXGwT6BVga3JCI2xxObyEd+NrqFqVq3G4HSP2//ZssS76WAkRPjsoG6IH/4cdVxx+35u3st4RG5zZAXUkWOxq3/2KkfkzvPAlsaErrrbZL2TDbGoDVWqILVsUrxfubn4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185478; c=relaxed/simple;
	bh=UgnRh5CwZu7XN53bSn5JDOXZpUeqdFOx1H5wQXlr5qA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Yj9MQXJfC5v3OCRSxC3/oSH/31VTjScDROYpVjGF299B8KnSb3SVPUKztSWmKwz61BNHZcOjNGKQi2nGLzW5BA8wuCIv8dDyN2lOwMz24zUYj7uyjst/uNC75XMLowypGSB9sHgiUoxFuF2oaoJl4x8sj3KsTorBA9fmIZiRqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9qjzfWA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L+j/xx0Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNcgjh3286906
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 02:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RpZHmAZwx23mQwU3yrd93bhptxxau31kfd3yNO9dnis=; b=f9qjzfWAnm21A2Rg
	iChFU1n9Yd42IZ3yG2NFa3oTauctVDGvzOZDpGC6fEZG+3CVMgJr9IfAxbqThZ2C
	n7ZS9nuhDg+VWFbzOsAK+Ud1VODy17L/Un3JvwzvrDsoTnCBMWWC4P/g3WuJzMfO
	YYOm6uJhCEjrNC0ZqirEZHfIAJPKVuqjeV2/+eVgKLKHYxerr/VcNdrxbse4FcLU
	ewAPuwh+/lAu0mogtybyJ4lOSE/cxSotLa5KtDG8IqSIAPoA25yAD1bWzHw/jyIO
	IFgp5oE9+NHf/Cxahar631Ax/Nq6PFiDE/l68Gzi9NFkg7QONddwxHM3NJIprJxo
	q/nEDw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkntujnjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 02:37:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7fc82eff4adso4013471b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 18:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768185476; x=1768790276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RpZHmAZwx23mQwU3yrd93bhptxxau31kfd3yNO9dnis=;
        b=L+j/xx0Ygsrlq64F2S4N+0nerNHcEqUIk64OL+jXoCjpyTleMr/BKneUoHGRbCGV5S
         EhN2ugemdjOq0SrR3MhJAv9q6hzFCZZZm17qNry//ttzaIXHDe7gzw2sKynn3vt9kcNk
         y4vLRd/tFUELodp6Co0m9nA7WReh6xVglZ1avPhlp4a+aVRikIh/fnFvQVX6++eDLI2F
         hHYMuU/Bd3Ngg8nIT7hlezT1+2HvU4Bm1Zw2a6KB0d9MCGAJKtV5h4Qyc7orJjP2mOCz
         bMFgUNwcYxC5mSCQxemypPhH6VHPf7LvDCH3I7Da+zdkOkM5iyI7KYy8q2+RDKBdkLDt
         OZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768185476; x=1768790276;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpZHmAZwx23mQwU3yrd93bhptxxau31kfd3yNO9dnis=;
        b=MpbEdLFbV3Twwn7ZtURIhZH69L6Lp9Txw6UtAGFVtqA2PaIgL4MRN7HJFqAQ6wyW+i
         pP7GYzgvt0OnEZToDhPQfqzkDCk1omACYQJtxsSX07tHtTG1xgeotIcr+6XOHwAsCXJl
         acsffd4IeaJ8WjXjHBKJbKcRf8zEwH5SrS+xg7o4qv0j0sVp/lHSDFY6odwmGcLRKlQ1
         5sqlXz5K2Fwh+bqj6vvsd0N8s2nhqRqzaKuXjM6bD7gn0iYbZvFfEQlB48Rs86oHKk3D
         B/uP5IUg7NFkVG++u33ICtKpNzNMXfqcTmuAGjAjqxW/TS/X7egSNIRJbL7UANfjiEgn
         xZzg==
X-Forwarded-Encrypted: i=1; AJvYcCUZtcK1ShPqWfkZ8sfZWjM89CkHm3BPAGGWwlAXIJtS+v6aMhWCXDJ+E+nbSeHVCLlw/hm0EflkMWEpNSpJqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1uXKUYj3Dg81Ndd2RJRGaQYC+v8B04Gwzu44V0HiQOu6CNt8
	Xkl+HTaqRFW8x0Pry/+hArNwKRIr4YIPL8H0NpSMD6CPdmEzgDdA4HBoafAEzMM6bfjDb7SQQkH
	VVS5IQoOumAtxQy0BF6YrlbJeCsU9t9u71N/zrpENZ80RIQ9FQO7t+xoyK51KgxPl5D452A==
X-Gm-Gg: AY/fxX63BEw43jcNdTxSKSREyEYB3JKi9LDoprsDzOp9S7f57JPfSFuIQ71cK8dW1TH
	0ZfaRPmGVCbuiKjJpehl2LwUOS0MPq0qe6LLt+YWJ4Sjr6Qt+t2QoEmRMUBunyc3V+JGSZF3w/r
	dx9U9pHsm4SiwASC8n2uj7NkC4Dlzjriimxt1ZSX9YSZBJdedsYzfZlPiC9q2nn98VA3isiog0C
	XXhYwYZ3qlrhP+Drmd0+NN2j5J1BSFcSlnVWQ+bmoJaZ5a36N4HrniCg7vJTz40JqorJrMNYIdM
	/dNyyTmBfdQbJfQvaKbe+ARymBfQEfIC16BEpOT3AZ3+BPvyizWYCyyFraPPNZBRXkwQ6TlVGqC
	BsOGQ4Q9w2URlOYjGG9XFEsvks2tc1aHa7Ye9NUgXsDkWZb+unmdgQkWeL5bLjDgWz5Kr+GMMOz
	15zRavvA==
X-Received: by 2002:a05:6a00:1256:b0:81f:57db:a459 with SMTP id d2e1a72fcca58-81f57dba50dmr1419738b3a.29.1768185475930;
        Sun, 11 Jan 2026 18:37:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHesLILmPoHaQoC4X/cA+EUPFjnnrCyEGFwU/qaVTXdzYOj8jv4W+kfOrJFIV3djtSq8t/GrA==
X-Received: by 2002:a05:6a00:1256:b0:81f:57db:a459 with SMTP id d2e1a72fcca58-81f57dba50dmr1419718b3a.29.1768185475369;
        Sun, 11 Jan 2026 18:37:55 -0800 (PST)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e6c8199f4sm4245748b3a.68.2026.01.11.18.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 18:37:55 -0800 (PST)
Message-ID: <c63b4cc0-3157-432c-a83b-c638e8c8d665@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 10:37:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
To: Ilya K <me@0upti.me>, tiwai@suse.de
Cc: ath11k@lists.infradead.org, jeff.johnson@oss.qualcomm.com,
        linux-wireless@vger.kernel.org, mpearson-lenovo@squebb.ca
References: <875xaypnkz.wl-tiwai@suse.de>
 <b410fa3f-0241-4805-afb0-efb950e04bd2@0upti.me>
 <09b6b13b-2b88-49b2-b865-f70996708c01@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <09b6b13b-2b88-49b2-b865-f70996708c01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDAyMCBTYWx0ZWRfX3auGX4VBtHIj
 IN92w2y+Rkp0EeMvkf/e7rjTonYlbN4rMwY/0pbIJpqEIzjaa08wAhBXui3w3clxJp7ucUXzRMv
 wNVjLr1JfacoMTqldjG8ktQp72UBg4f0BiT7G4N6165JITeHpRSz4BjUncZvF1QqY3qEHANPGhY
 j26i0MkF1+lTyj4kowEK1dQ8Z2qebK0vTjhBML8WzqnTNJn8qKLSfyYTJlUQ7/5+1sCtXZPh2T8
 M2tPfjNlYWJm7bmWVnUeMFGpqaSWeWxjGygRlzwE/1339HDCmDFL4WHhYvJtaRC0Ozu0AGHLjsO
 OqjHlgT/hVpSeboztc2QaV+0H7Oab9Ky1XPUVkUWctTI+EHHn0pXZrJvPGSmL1Km0BHzzrHYdw1
 MFIE/BEx5MJYCTu1B2bkBl+7G3e51hlOzClD4AogozwdaUYGqUN3NSM0RQ+1I/i1Ex7+H1io8lV
 SyOLhZrmJiLn3AQeRVw==
X-Authority-Analysis: v=2.4 cv=R6AO2NRX c=1 sm=1 tr=0 ts=69645e84 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QvldmTvwu3qAk1I6jywA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: DO9xmtTkKgkGAUcgBd5JzUBrgbtxpH0L
X-Proofpoint-GUID: DO9xmtTkKgkGAUcgBd5JzUBrgbtxpH0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_09,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120020



On 1/12/2026 10:35 AM, Baochen Qiang wrote:
> 
> 
> On 1/11/2026 6:47 PM, Ilya K wrote:
>> Hey folks,
>>
>> Sorry for bumping an old-ish thread, but I've had the same issue on a T13 Gen3 machine as well (model 21CG), and there seems to be no better solution in sight.
>>
>> Also, here's another instance of what I'm pretty sure is the same issue: https://lore.kernel.org/ath11k/6268b094-5a40-40d8-8461-9c9b0f9e1ae3@oss.qualcomm.com/T/#t
>>
>> Can this get landed at least as a temporary workaround? Also, should I submit the 21CG quirk as a separate patch?
> 
> I had an off list discussion with Takashi, and based on the logs collected I don't think
> this is not a suspend/resume issue, or even this is not a STA side issue.

my bad:

s/this is not/this is/

> 
> Before we conclude whether your issue is the same or not, can you please describe your
> issue in detail? specifically is it an unexpected wakeup or is it reconnection failure
> after a normal wakeup?
> 


