Return-Path: <linux-wireless+bounces-23816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313E7AD0A12
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 00:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B67189012E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD923C8BE;
	Fri,  6 Jun 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7oNf6tq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F623C4FC
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749250456; cv=none; b=Ok0CBxPI+4WONCOD3/3qosG1LJrCKwxHDr0H4IDFf8P1FV1k8G7yOfp1rru2zOtoF+3e2zvPwipoeEEbK7GNeid7INwJKrwkowDGbpVXTd3mzYBWxL1rdPZLPXbWU5HwAwr/7ONMFLkqviOP9/qX6bfLkFqLHwUWRCP7jUUKkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749250456; c=relaxed/simple;
	bh=CYaOVSZHgCgQeyFhssusXVgCU+6murm+3ajiI10JjNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxoKSSTP82AdevXVBvJUugxJd1q+9cRJ00jYw8T+gWg48OdY67gClPtj3klO+G+YlT8H5JIFPkymjyoDTSgT3NP9Py0tgFwqmdeXvIdFE4PMX37/VcxW5Gm/T4wjKxF6akjXcMBPlDlFgHbTr6mf1I0032G0Wljahy9OHuFfTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7oNf6tq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F9IFI032612
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 22:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sl3cJSO556t99BKg1aWFVJRWy81EW91Y2ANloEryh/U=; b=d7oNf6tqRPCPZ5h+
	6JSl4y0FSo/SCQSZnfTpcWbvmwrNfFeod4jaTGg9jB+m9rQ7CQvPKp/arz4ws1gr
	vBmSn6kg3kmUoXyw56Z2VtwGNyi9OB7et6U2RxaXiCyfPbD2WEEppR0SqUP4P8CN
	gCauUOLA/rQ8ilCsLmWdElhUnM2nAFQyL7lkJiUcFDNsUjdPI6aoL9e5+jhyDY2R
	5FRBCT+dUya7wZxo9hG6o3YM7RbVYRAyOqJ3mlfiE24uokwPvdRBNgMZla0tmDjN
	7n72ZYBMe0/MCdDKvcguaxIt2kPTYoqeKYNsD5iE5HK78smknvuaJTqp54iBM6Bm
	uKNEcg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8tdy0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 22:54:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso1969607b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 15:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749250453; x=1749855253;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl3cJSO556t99BKg1aWFVJRWy81EW91Y2ANloEryh/U=;
        b=Sqabeb55whuVxjbqOVuLDOLrTOGJLE2rNbCwrvwm1bD24yeFYoAzPbm96I+yfP3AWX
         vQ/Bbth3UELU0o4LjjZXpOwcqxktOYdAs4zkDRrhhmE6ianLGCZzOr6dv1K4HtqWXq0j
         VzF8fcNI/QGS1Y9rZfiWlFSG7zaopXHTxn1UJ1mizrhBjqjjvvonAeP8AmTDscOpIB3+
         blmdh/YZ6DbomSU+4Vm7/AHAvoOmDIvEn3ZLcqQmxFZtoatzR7yX0KCSMnByhvHcecGr
         E2YBPXnUk7kzReJVk6vmeLyU7kblEY+47O2iu4Hb2XOSqjPU+Q8TFnuA+v5b+cNWilH9
         ddbA==
X-Forwarded-Encrypted: i=1; AJvYcCWUPQ1L6LEKATRlp3UBWDFKW6AITSgcjtadwFnv6d6hLnWPzos4MHq5S5tQuejDKSIwyAlh/B/78iVLkOA+tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySe6SKHPYG9EJVXzezElI+/bqb6iB1eJzLeDfPcGq5whKcDyfG
	o6fNjUswto0Fw4KI3+ztzfnSkly/x0Mr9RIkgAFqkX9YbOI5ph3T8i+TyDGM6E+3rj5Mn+WKY6V
	RmkRrmrNlTTIu2SKqSRQQ4q2LyrpiAAV4cs9d9chHk8fICPVuPluCWp/TDE0Lmb1KezD33Q==
X-Gm-Gg: ASbGncvYnXTpN+ZsMPStsx7SMOsiH0HvIzDtNPWuR3EXJGifkzIfGIeqFIm6/wGsPx9
	vPETzpaT4iAUn4nO/ZELngRDnJgngESwia1V2hcaGe0EfuuN4vTDOXhGRbvP4Yu/44yhcZ3l59d
	TM3PGab41/DLfyB2cHUOk/1oSlfYwGsjJnZ/S1Yh0IwG5SExRN9hv2ribtqRwhmSZ8qGPuAgoRl
	2jXJLLneZF7VvLSJFem8yKyuMtHrQlp56F9sbjEaJ9s8okX525XusIJuaiKvCqwiANVtva+BenB
	fT5HjA3v9MP9BE2e2Pu32ueHNUiwYlYu3f5OyuDbklgN1eUOAM/6veihqVMCBRojsliCBfgrmBn
	N16tx
X-Received: by 2002:a05:6a20:1604:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-21ee2618e34mr6041670637.39.1749250452894;
        Fri, 06 Jun 2025 15:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLmDC7Od/6RiuEM3cH00xevyfsgBqjmx7Yt3RaJn9wcOt1rzlfEJKJ1gY2ysIYP5uLwPQOXA==
X-Received: by 2002:a05:6a20:1604:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-21ee2618e34mr6041652637.39.1749250452524;
        Fri, 06 Jun 2025 15:54:12 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b10c05esm1781855b3a.180.2025.06.06.15.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 15:54:12 -0700 (PDT)
Message-ID: <9ab0e15e-c85c-435b-9dba-c78d958d37a7@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 15:54:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: Drop of_get_property() call
To: Rob Herring <robh@kernel.org>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250314233831.2535170-1-robh@kernel.org>
 <CAOiHx=mr+MFE_7Krue4BPrtvtyJW0pWUBXCrqbViVH5oOTT2Hw@mail.gmail.com>
 <CAL_Jsq+L2W-=4m2c2zAKNAP9vsrbZkOBHUYqPevcdM9L_3xHtA@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAL_Jsq+L2W-=4m2c2zAKNAP9vsrbZkOBHUYqPevcdM9L_3xHtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=68437195 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=rT-OEoWXBDPQ62C3PGIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: LKg7sBa7PoiBm8lKLMJJtKzDy72Qc81s
X-Proofpoint-GUID: LKg7sBa7PoiBm8lKLMJJtKzDy72Qc81s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5MiBTYWx0ZWRfXwtJJ8iGu1Xb+
 zAiDNgtvzDvZbACjw9TRMEg9xwp5rhCONLLvkV4Tqan0icslVplk+q0wuHu8MOxqXYJ8XkU9pXB
 oGNcbK+lBKes3hoPewVtYMlwBXZBvBPV9Opg04PSXA+DTKQRuUpORg71R+cyCAAu6JPJ2btUamT
 q/n36wl21o7fzlBfNnAHdXB6HIzIWacGRRCliVg+NsNb0kuTLZ20iH4TzqikCAC5Y41zj5dl6oD
 zBiBr6EC9SEoDUEikbred2VpYyQX1jfh3YGDcN/U14jItQA6aDxl45pW1D+RmCHRjfNI3CqCFqk
 X5shBv7hMoG9wHt0GXI3rqh/rai7ec10MTpWHHMklbyg+U+xDndTC73XW8T2cOr79EXFYO94fOQ
 1vtn4FvKPtmeHPuhBZaCp7uinTqBm4fB/67HE6Z3cDK1ey+fuhH+pcxJg9zmc5gx9GhGAUaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=810 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060192

On 3/17/2025 10:19 AM, Rob Herring wrote:
> On Sat, Mar 15, 2025 at 5:07 AM Jonas Gorski <jonas.gorski@gmail.com> wrote:
>> of_property_read_u8_array() returns 0 on success, but
>> of_property_read_variable_u8_array() returns the number of elements
>> read on success, so this check needs to be ret < 0 now.
> 
> Indeed. Thanks for catching that.

cleaning up patchwork. was there ever a v3?

