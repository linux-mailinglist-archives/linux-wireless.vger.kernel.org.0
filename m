Return-Path: <linux-wireless+bounces-27240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E54B533CF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F84F1897EC0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 13:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF81DBB3A;
	Thu, 11 Sep 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxLDMuV9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265613B284
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597594; cv=none; b=H8Ah+SIl9QwEbMcwkhJDpd+fxH2hQBYSP+mUqXAWJ8BqEblqPCtiZSFyfH16+0YotZEXYHQ8+Jqtp3sM3lcS6p5SYFF6RhrKWzHZFBKJ1Y8apG9va4ejA9PetQoaK68tRLZZ3f69qXYHsnOfegOpAroIBhhdT+AjFk2XbbswlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597594; c=relaxed/simple;
	bh=WjFo8g5y2nU+Gq2jaOzKn8mNGBYu5wn8U5UZevQUnn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asRazBuxFm3vKU3FydZL3ZIAgK1loaYz3ZB+NwKPNPFMEDBHyqCR9GbejjqtUoR8eYchG1Y2J1RY0rTxXg9pFB4KtZLxx4c/R0btGTMexs6Jp96SkTNEi73asTVah8QmCNv8czxNT1aemjQ40qig53A0WS/XWZ45Ra1PGJcjuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WxLDMuV9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDSmpk019094
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 13:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mfb/bEWWfebGlVXlbCvCHlsRh+BoP9p5BYKu3ymw4Q0=; b=WxLDMuV9TGB4FphJ
	/ubRieHF+w6Hbq95rsoLdyjolwWGsthJvTLFd3wr9gvgupXNGpdirrc1FrsvGwRZ
	Qg8Q0/YdRLT6UvYWVV+4zURZD+z2YTfG5I3DC4Fy/1eyo9Ge/SyFlCF50pCnpFu8
	2iCNdsBHLO5earsQORJKx4Sy0h1IjP4aFOLAWFyHwosjVCHI8pVlujQP+q07UkFt
	MAmDLxb+40m6peCkbI95iPtT/wkqFSudzwFIrvtIB3LgT08pSkgz31/TRJr4cA8p
	FFNCvujemaYnrgq3JlzMbe2GzADfch/b2Cbf0uiblSFeCLA1mONP6930kPdVA3wr
	8+WdkQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphsjcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 13:33:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737e673so1119976a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 06:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597590; x=1758202390;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfb/bEWWfebGlVXlbCvCHlsRh+BoP9p5BYKu3ymw4Q0=;
        b=kuQ3z12Q+2mrsQQOsVxM/wA8ndmJY+b/tlSsTkKgZ3B+NKwBVUkxgXaFEQM101Jxfe
         1BMrJhDAJZ5UCxoDKMN42mmspZFswIhbRBVAOyHQtK8ZfvaOoiTXfPh8zZkJ8Dcn2Z1C
         qr8dxt8HSb6hmZ8igmVs4cDGTgswG0U6s3DBDifZX7iF9MgNXoQxtK7UsP78rto15gZS
         9gHEX4wdh5//6C+TGxx4oR+pJK3MZNs4b6h1xnLDuhF8eP7pkBC2we7P/jo8+ZFfSy+T
         U2Jv7lHsgblSNrYQ2xZEENh+smYxTvlgz5NvTvMRj5EZzSqBpHgZ0vnqUuJI4S2oplDU
         EyVQ==
X-Gm-Message-State: AOJu0Yw00QEUeYk/lPyCmTvme0Ow6NGhzL9jY9sq5Ly+a24DvrvzdoKb
	wjuMP0WbdIadN0+3a8TyK9TCUxRTWnPNmLYtijC4w55iYyVcCBqEf0vPWvlcGgdrRr6fiIeRk4i
	3Cu0scygFsRlaGiFxEWlvZFYPz77t9UjJV0qQSgTCkq3mk7i54oeEfmTUO0tRdwb+E6UVyI01en
	S/0g==
X-Gm-Gg: ASbGncsAgdOS7wvGc1Xr0JZSgpuCuaiNzy+XCJ1cXEqDcp5NnByEWc4YBXsh9ytK6vN
	tEYnaMI+lja46YLmOxaMCU6AjstuAGj+4FDXDNFUQlwf0ksEB+ogKcYQAte4HG2daibCcIzuCJb
	5h3E67mNOExzWEzg6seW/pwMDO/nxpFCUtK9SFzQtWvecDnDaXcUDKlweG8gL9okgeokKS9rWY8
	JQkKBCIofUqUe4CQ9W4sSO39s20IhczvliUf3l43BTlMXqMNr7f64EvII/OlNv4rWN9vsA76pup
	Qv2vWfhrUkNL9Vs4dgw8MWjyKC/OxkdMI+SJ1/nOU3Jqhp7f3OBIMvhfHOIhbrXrQIRVQNxhm+l
	eejdn9lSSGxcXkm/FgBFTT/uRJY+cMnAWV6qQ
X-Received: by 2002:a17:902:dac3:b0:24a:fc8d:894c with SMTP id d9443c01a7336-2516d81824fmr259400545ad.1.1757597589287;
        Thu, 11 Sep 2025 06:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5gFsPlK7S/E682V/zEbf1qAqKozriy2aQWGfZa4hVT2KfGYUkoMJ6DHUywD+nm4BqBZoMIg==
X-Received: by 2002:a17:902:dac3:b0:24a:fc8d:894c with SMTP id d9443c01a7336-2516d81824fmr259400175ad.1.1757597588594;
        Thu, 11 Sep 2025 06:33:08 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b30619dsm19620455ad.141.2025.09.11.06.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:33:08 -0700 (PDT)
Message-ID: <5ed9147e-fc4c-4328-9ba1-7b871170481c@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 06:33:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: cfg80211: Fix "no buffer space available"
 error in nl80211_get_station() for MLO
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20250905124800.1448493-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <a83d883d0f251c08de7dfe7f2b3e7ab890a9b1df.camel@sipsolutions.net>
 <CAD1Z1JJqgVdXHiggeBuQvqwOSHzrzuYZRw3khey9v3oy+xN5pw@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAD1Z1JJqgVdXHiggeBuQvqwOSHzrzuYZRw3khey9v3oy+xN5pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c2cf97 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=kD4sTvn9sZURAWMP:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=stkexhm8AAAA:8 a=A1avYxSei9jLoB8cXdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=D0TqAXdIGyEA:10 a=xa8LZTUigIcA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: VgrUCXy3P0EXBdpQEHj4FFZqlF2S6_1R
X-Proofpoint-ORIG-GUID: VgrUCXy3P0EXBdpQEHj4FFZqlF2S6_1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX542C1RBKXWFo
 28ekMo8gN8hgyJxiZtwgjeS06LtKJiZ0zmV0Mgq9lq3WJjBbYE5ETM816OMi9zHTq31Lbg/UaLA
 aeMA5H+MloQga/1vP3nGJfSVkHRDiLFELaRplC8jzEUCDkEXreYqLjAYWym15NTrwaorRd/Vcum
 k/H+HWwAhsorUf2C2L4SQkvvxrwPyq9mSPq5WmVpeDWKAbZpl/u4zvQmEadb1WTYT/WtYQGWIoc
 OH/vcgbQwrz585MEBqCbgzFy/LrSM6FaS8+gNcabQtT97CAtVSWpbsCSHRaR36dATZ0uu/gw4pJ
 qMEQoAMm/irRrydgIb3RgCDroQwbMRnM5E9QVEd+8Gng7TtdhS/b21misI6aEWJzmTurp07LXbe
 E6iStlKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On 9/10/2025 11:37 PM, Nithyanantham Paramasivam wrote:
> Hi Johannes,
> 
> I agree with your thoughts.
> 
> From what I observed, a large sk_buff around 32 KB is allocated and
> passed to nl80211_dump_station(). However, this buffer size isn’t
> sufficient to accommodate all 16 links(max) when full station
> statistics are included.
> 
> I also agree that splitting the dump per link within a station is a
> good approach. I’ll explore this further and come back.
> 
> Thanks again for the feedback.
> 
> Best regards,
> Nithy

Reminder:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

> On Wed, Sep 10, 2025 at 2:04 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>> On Fri, 2025-09-05 at 18:18 +0530, Nithyanantham Paramasivam wrote:
>>> Currently, nl80211_get_station() allocates a fixed buffer size using
>>> NLMSG_DEFAULT_SIZE. In multi-link scenarios - particularly when the
>>> number of links exceeds two - this buffer size is often insufficient
>>> to accommodate complete station statistics, resulting in "no buffer
>>> space available" errors.
>>>
>>> To address this, modify nl80211_get_station() to return only
>>> accumulated station statistics and exclude per link stats.
>>>
>>> Pass a new flag (link_stats) to nl80211_send_station() to control
>>> the inclusion of per link statistics. This allows retaining
>>> detailed output with per link data in dump commands, while
>>> excluding it from other commands where it is not needed.
>>
>> I guess I'll apply the patch for now since it makes things _better_, but
>> I'm really not convinced that it's actually sufficient, and I'm very
>> tempted to throw in another patch to make it always false for 6.17.
>> Convince me not to? I'll reason below:
>>
>> It seems to me that with many links, even for dump you could easily need
>> more space than the size available for a single dump message just like
>> with get, since there's no fundamental difference between the two. So it
>> seems to me that not only should it be opt-in from userspace to retrieve
>> the data during dump, but also there should be the ability to split the
>> dump not only on a per-STA basis but also per-link within the STA, which
>> requires some logic adjustments on both sides (hence the opt-in.)
>>
>> Especially if we start seeing more links and/or more data for each link,
>> this will otherwise become an issue even in dumps.
>>
>> johannes
> 


