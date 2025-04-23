Return-Path: <linux-wireless+bounces-21937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CBA99775
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 20:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA221460505
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C01EFF93;
	Wed, 23 Apr 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzLZkDzF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C228B50C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431563; cv=none; b=sZC/hWP9dstZ0sc9S80+1gc1lZGEJCv6ngny2SDMvyHLjq81T48i/iSJ6Q+Pktxyd8GxIYYg8PwAMfHt9H82ivqOlbx2sM24LpldB2MZ4GLtgAPUb1+9vBFnOYh17c3Bw5rtQhX9vqKhF2dTN4EF0F9+E2JvcJn2UYe4sDNMqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431563; c=relaxed/simple;
	bh=+sZPVtVlSFQLAyBPuIDI8PsMq/i8uNZ0PcmkYsFTrrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ea78S664Bgqy41PoT+9Lq83mwiT2/lv7wzdO2CJSbIwao02d8T7/ZIQ47yXPuCrV63qzv37VOP948KnfXfe0x6/Z7NkRsdV2zbOsgXnlZEtBQAI6HdKZ3UYUCNUuoEExvzrX5Vz0of/aErZ/vpzRIlHk9W4hOT8mMWo0EcQIUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzLZkDzF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAYlqG024116
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 18:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BaE3ugE5vPzSinlOeagCJcB8zCB5MqDkxFqSX7SGm5E=; b=MzLZkDzF6Gd/ZMYv
	VKlitnGJYzKA7e/Kw4n31LTEjugRCsbvh/w6VHFU4Nu7Wt4xVpKxorocveN/+YKT
	EFyp9sovYvLOrXzNGJ4hpMLIgdS+F1hsbw9ry+IypidI3wDHU8ze3oMVB6p9jPnS
	oIMzx6ohZ6c/wFK6Es6Qqp4wJ7+g5uHwL1Gc6/+43SKLI8B8kJItjcfaBhP471Wd
	nYDuG6gVbGl1Bw0DnCqHuLEQJYOUbQ6sBKpBzJO2GDM4CQGVoOiIXltjgNT0NV90
	XtAJfz/RZnNxhyBkvNtgVElKuURrcAivmd5U/7UvGhiSLcBP1KirhQNQVrrNPHrm
	3WXR9A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3b0np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 18:06:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736b22717f1so757509b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 11:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431560; x=1746036360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaE3ugE5vPzSinlOeagCJcB8zCB5MqDkxFqSX7SGm5E=;
        b=qGn34fykfT18pO7f43uaQH/0u0GNIt2Si0Sdy/0QHS3hnjrFImsHz3TTyzjrBqWYzu
         kxWmDhgTafOWHtCkclsMZk6aAsO0p6EjDC76sTMnrVWPS88om/bAuH1orfYnoJqkNjU9
         b7ZAv4rq83VSQw7dJ/9ngYw1Ew//J8uhvErc8Hv2sZsSZh8ng5WsAmMHDtqqaXEM2u9G
         P0p4HF/ubjiCn1T3YAn1ET6NTvsnPLB9IYZaYFqyABvhPrPxHKoF8MZk5azXa3hQrBhO
         wJjr2rtlbaJgWUii98sqXMg+CbgPiv29r2Xa6xb2lBGR04qhYMqQlaxn/8IYt+H6uzOn
         aUlw==
X-Forwarded-Encrypted: i=1; AJvYcCU8myHGXXHzLhVJwFSwSyhasXle2cBjO7wNEvw6hZdGKg2K22CfxSSDZr9K3GfpLoNA46aaZ6xOH3fzaoPo6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35RqB/Gb2Ccorhks+lWjpblHi51xfjUETAvPTF/b2kVIL6CkN
	NfixiNWmsuta47y45YKI9rQOnrZBwdlacfti+35LZaD36hng14ljaD9xPdu9IFwJbhpIJUr+73M
	SFOOxeTOeeQHfJR6iciYCGHbq/T+S9dRrTvAgX0F3rNPGyPusVOJCy2TvbYOMPn12nGNKtRdHUA
	==
X-Gm-Gg: ASbGnct/47jC1VWWDRWBfB4t1DrtLwq3Awki7kOL53LHGcgJzd5mjuIv2HsSuEuk4mF
	HfiDTWyAMCN4hcOMoZ77b+uv4NMWGlERnDDJD7NCK/iZcGjs9+7Vs4zcr9jomHatqLj49kZS0oE
	B76mM/FwpZm6DiNIWIwyqHUPhJtxOHa8SE15fN/kAC49UIlSL5gmsLHQ580j8BnGrfCWk/2RpEf
	FMzuhNXsL5MWzyhG9SfZM7y8jXbzMBlfl1V84wcxgZDX9uzgjpQpoh07c3XLU/NPjj548DDTJ7E
	bxfObpSyp9H0tgZlQJccx7vWD1b7buFaLabBN/5MLjd2soOlVHXfDo6HDcZFGdhROsm8jdsm+E3
	wJNAM
X-Received: by 2002:a05:6a20:7350:b0:1f2:f1a8:70ca with SMTP id adf61e73a8af0-204428732fdmr222594637.5.1745431560163;
        Wed, 23 Apr 2025 11:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMrARP/m9bsGTLL17jz8nZcyUaPfX9EbmJw5sWgd+pENLjq2lyoM/AdSZbE+MxuS5BlOOl4w==
X-Received: by 2002:a05:6a20:7350:b0:1f2:f1a8:70ca with SMTP id adf61e73a8af0-204428732fdmr222551637.5.1745431559766;
        Wed, 23 Apr 2025 11:05:59 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13a4084sm9362325a12.32.2025.04.23.11.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 11:05:59 -0700 (PDT)
Message-ID: <99d239c6-e276-4a16-b7db-6e1f8ecc0bf6@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 11:05:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be
 installed in hardware
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        ath12k@lists.infradead.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <202504220128.2KvxCzaG-lkp@intel.com>
 <47ea4e64-cd87-4c42-a20d-f663f197e44c@oss.qualcomm.com>
 <aAhEc8yrW4vcrE7J@rli9-mobl>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aAhEc8yrW4vcrE7J@rli9-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OokC7tu-0v2EzBsju6iULvtXGGToqnG5
X-Proofpoint-GUID: OokC7tu-0v2EzBsju6iULvtXGGToqnG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEyNyBTYWx0ZWRfX4wnKcryiV4GI 1MVrAzxAQ39tcgGheQiqJjhtJSowrjWuugmntMFRPzDDuQqOY/yeME9aNXa2h09aabAsKR8pIXN oR09hmGkOC3AwiBrtX6sZ3HnYmxRHPP4JYSpcXfYEn0GEl/dCibCA55gYvF8H5RQ5FukMT1vX6T
 4/qKl4C2+Xy/Hq75stI1Ixu3zFGHZJrAFbm1LaZBRKQrS19LpfsRvoXtUTShJWMWxu/SsFFIttx ydxvsjKPHULEMFCjU9z/F2NBE26IYh1PtIyfRGBwVh+LmBYqXdTVh9S8oBL1z+H1r38LaDo6ca3 xDCp6SGZiVAuNVBXIsJH+BH1vTUV5Ll+Kos4swEVZM5Lx9oFF4jJRmGLmRMzEqctxaqTPOY7IHc
 Hg0egJX3/aJCZF7p2/BYLnnrWhcuGb6WxD0tLio31jwuTSOJ2JGH8+cNa1PFNnBr7dqfEvDY
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=68092c09 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=mHkUAZ6zn0caESaBz8IA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_10,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=443 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230127

On 4/22/2025 6:37 PM, Philip Li wrote:
> On Mon, Apr 21, 2025 at 11:44:46AM -0700, Jeff Johnson wrote:
>> On 4/21/2025 10:16 AM, kernel test robot wrote:
>>> Hi Karthikeyan,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on d33705bb41ff786b537f8ed50a187a474db111c1]
>>
>> lkp@intel.com folks:
>> This patch contains the following footer:
>>
>> base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
>> Depends-on: <20250421111505.3633992-1-karthikeyan.kathirvel@oss.qualcomm.com>
>>
>> Is there a different mechanism needed to tell the robot about the dependency?
> 
> Sorry for confusion, for now if there's base-commit specified, the bot would
> only consider it as the base and apply the patch. And actually, if there's
> a dependency specified by link, the bot so far can't recognize it well.
> 
> BTW: for this case, does it mean the patch need be applied on this "Depends-on"
> patch, and this "Depends-on" patch is on top of the base-commit?

In this case the Depends-on patch is applied on top of the base patch, and
then the actual patch is applied on top of that.

/jeff

