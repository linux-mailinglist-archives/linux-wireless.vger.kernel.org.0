Return-Path: <linux-wireless+bounces-25456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41972B05547
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96947A1AD1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F85231A55;
	Tue, 15 Jul 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpovGloe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639612AE99
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569200; cv=none; b=OBesImTZ7NlCHQXe5a0+1MmUss3NyqlJ/Ek8h8kX7F4ValtpstslYnW1R+z6R1vFJK/h3dY2dHd3PmbdZVuZxhnA79OxFU7f11huFqtULOu8ZhHBj2/qWrjiGyFeZUNtv95rTfcmuCwPIXZqZAtesZzTG7zPKA/YfL8hGIKzFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569200; c=relaxed/simple;
	bh=6IvxMxbsmdncvujhH23aBPX1W3KDzxwmGqrWTl7y278=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvDkIeKgZjC5pUjOq7sXTvCQXKTQQyDIdOZj9VbfIDjNmAwTb0YeCgCin2i1Ba69YViGOKIrMC+/wDEXNDpkHsG9E/KA6o7V9N8VYnUfeYwoQjCEtRC9J4oIDxgdax9LGORLrUn7Jy6rBZ0YK0pr3dR/lDp/wlKk1bI49o+8Pqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jpovGloe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F72IeD024672
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 08:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iIdTqC2ho4Gd3Ra56yCnIRYu+dnbkEnLUGfKaG5vvHc=; b=jpovGloeAGlEB0t+
	eNj+CkSIRALkQ8qO6jss+OjDoPISrJ5ipK/AbwkjyzFWM34QpJ7kZkrympT9E23D
	0WdrFVr/yN61CuuyQjyJ4UIOTek6tbFaR22VIrs/lEmwvkfDknusHm8wbulEWKMT
	NuUy0t8Wy9cUjkEiM9Bfi093amGrXmGK/C/bY3Dy7R2pUiVyibd1XFgcu5KnDdAy
	D4Pktz4ww/ZzNJyainYxMsNabr3kSpzIEFGx0OYwWmAtdIlQ3kB8L3BN/+QZPbaK
	bAE/LisTZDkYz5Ok/w4VMkgNDuQtnHPGKIbjPhbnyNv8DgT7rehq0mcKm/BUFXH3
	NXxDVg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug37ykue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 08:46:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so8019462a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 01:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569196; x=1753173996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIdTqC2ho4Gd3Ra56yCnIRYu+dnbkEnLUGfKaG5vvHc=;
        b=b4w9llEeyF+qOXgP3gQ1UCYoP2Fx3QQLLzWihz9Uu5Y6tycgINh+VbXQb4r5dkGt8K
         BFwwW5ckosBEuyzHcGPsFbxIgxlVcQj0tcqBlX3IaOimFdk70+dUUhkYxUSigVAdVcX3
         z4LJhg118T7fUj9oksgy3DPFk1cHxQ/XR1wgDVj8pBVhuXS4WAKCeIoFuo6CNA4x+7Wg
         P3Q9tMOgQBjzMhoWcvaz4NDSY/yQ33x03b4YUs9yjZFYb2J+v4qJP+wtohTMUxiMfirC
         xdnXq4llzUleG+ua1x42xr5cr7jkKe6gzXyha0LBXJnJegqg8VBcMh6HI5IDPpNPnZXc
         nnPA==
X-Gm-Message-State: AOJu0Yy+hR/78MVccFRgTYQ39YuMnuHsUYv0nQIiC15URVopjq4W+Dca
	S6rhEtbsgEzSbV7BcyHlQ6uEXuES3YA2lVAp+Wjb3Tm+4Zoa0rBmCW1YUy1iYTaOI8TBeEclj0l
	wOQpwmdQuKvVLzgNJEY9fRtrUlhhgsk7xr2oOM3ZoEEnaZZAr270WXHZURzlICq4jnGw+T1JEk9
	Y6Kw==
X-Gm-Gg: ASbGncvj9w7x3KtUEKPoanbTlm8kVh7bcelGW9LeGfzLG+LGbeYftt5e8B5IMYjb5bi
	ap8aP6qVVOlMPagsg3Iq+d3gKScvbo4CA1vNr3qtoI0sDVQzmKHmxa82PqVQdWm5iscZWMdZuGK
	iLPjNG171EOdEXNKJ4BwP9v40MEEB37r/FQiWgCk1j5NMnNx26T8tbBVl5Y6Mq+dNPdVL+1Amen
	P77lfLE/NIAPpEDWSDvqjYhKoc3G55RJAZMTAf9cHOSvLbhd+uoZ6aW2gIFwrK61UqIDlKsSg4A
	BJMfdsd0XayI+hC8F0zt3gEwz6ayX6fJ0IUGpCL0Hn8viBdaw9MyWIH+86U+C2WKiAmUYBYjtVy
	3l/RkgkMFphbRvjhuUpZ6wxQpgnwlzrq6
X-Received: by 2002:a17:90b:4b8b:b0:31c:3669:3bd8 with SMTP id 98e67ed59e1d1-31c4f5732f9mr24190141a91.21.1752569195611;
        Tue, 15 Jul 2025 01:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Pn5LT7S1QbgX0fLVomQ7Y4YBSA0MzX1tJAsXnFcUVXCFRxQQpd5F9K8Y7Nx/AVPMELZ2mA==
X-Received: by 2002:a17:90b:4b8b:b0:31c:3669:3bd8 with SMTP id 98e67ed59e1d1-31c4f5732f9mr24190108a91.21.1752569195004;
        Tue, 15 Jul 2025 01:46:35 -0700 (PDT)
Received: from [10.133.33.219] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435bba5sm103634305ad.230.2025.07.15.01.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 01:46:34 -0700 (PDT)
Message-ID: <4cd5dd38-0389-41e1-abe1-5dfd55e7cf6c@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 16:46:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disconnection triggered by Puncture advertisement
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
References: <e80d5786-b1c1-46f5-b723-e6197e2d06e9@oss.qualcomm.com>
 <e713c376c01a81dd21d928e5d84bd3a1ae9e6613.camel@sipsolutions.net>
 <652c3aa7-dee6-470c-b5dc-638198990192@oss.qualcomm.com>
 <253456e43cba4c721047076ff32dde8851b1ac32.camel@sipsolutions.net>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <253456e43cba4c721047076ff32dde8851b1ac32.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3OSBTYWx0ZWRfXyxn67NulfTPD
 CPeIrzNOaP1ONd+UwIlJhO+mZk+sAn86SZvDYFJRHicp+jDIe2CCgnie/skJm0qA7uFqcEPv5GH
 Rv1eNthOzK/I73VmrLFIBqVmG4hJ4NZom2jP8G4+tgWOcLAey1FbXIfzfxq+6cm2hNWQ1BQUIaz
 f98nmTii2pVMjiBsMm9h/YmhNReAmG+yms0HEuNWqdijQk+USrZBmZ4J608qYqjx+xcwrAtDa53
 dKIlxtMSCi+xIT+cD6lRkSE2sJ0T3fjniRbAS9wgWCKVuizh1Nfe4GwkjufDMRy66BouesJkp3g
 qY3NZu3+mF5cxtQNMhZwNfFBc6wE4vE8eoJliCawopmVT6ggYH6qUrlMvGsDnci4CdJyqIR+do/
 nuMHgFebYXht62pGYQP5Tn87H2w1tgGCWhKfx+0crrEel4nRoZ53Si2jJJzClsmW//nq4x9C
X-Proofpoint-GUID: 8XGb-6bRB8xKug8y4tBFlvm2auQxC2HU
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6876156d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=YS2sY3leG1O5olZsh5AA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 8XGb-6bRB8xKug8y4tBFlvm2auQxC2HU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150079



On 7/14/2025 6:23 PM, Johannes Berg wrote:
> On Mon, 2025-07-14 at 18:09 +0800, Baochen Qiang wrote:
>>>> This 'punctured' is suddenly (I mean even 'EHT Operation' was not seen in previous
>>>> beacons)
>>>
>>> Pretty sure there must've been EHT operation before, otherwise we
>>> couldn't connect with EHT, and you had multi-link.
>>
>> Sorry for misleading, I was not clear. I was trying to say 'EHT Operation Parameters' in
>> beacon was always 0 AFTER AssocResp, until this sudden 'punctured' frame.
>>
>> Of course 'EHT operation' was always seen in the beacon frames.
> 
> Right, OK.
> 
> [snip]
> 
> AP information:
> 
>>         Tag: HT Information (802.11n D1.10)
>>             Tag Number: HT Information (802.11n D1.10) (61)
>>             Tag length: 22
>>             Primary Channel: 36
>>             HT Information Subset (1 of 3): 0x05
>>                 .... ..01 = Secondary channel offset: Secondary channel is above the
>> primary channel (0x1)
>>                 .... .1.. = Supported channel width: Channel of any width supported
> 
> So HT is 40 MHz, that's of course fine.
> 
>>         Tag: VHT Operation
>>             Tag Number: VHT Operation (192)
>>             Tag length: 5
>>             VHT Operation Info
>>                 Channel Width: 80 MHz, 160 MHz or 80+80 MHz BSS Bandwidth (1)
>>                 Channel Center Segment 0: 42
>>                 Channel Center Segment 1: 0
> 
> VHT is 80 MHz (the 160 thing there is misleading) if the primary channel
> is 36 and the overall center is 42:
> 
> | 36 | 40 | 44 | 48 |
>           42
> 
>>         Ext Tag: HE Operation
>>             Ext Tag length: 6 (Tag len: 7)
>>             Ext Tag Number: HE Operation (36)
>>             HE Operation Parameters: 0x003ff4
>>                 .... .... .... .... .... .100 = Default PE Duration: 4
>>                 .... .... .... .... .... 0... = TWT Required: Not required
>>                 .... .... ..11 1111 1111 .... = TXOP Duration RTS Threshold: 1023
>>                 .... .... .0.. .... .... .... = VHT Operation Information Present: False
>>                 .... .... 0... .... .... .... = Co-Hosted BSS: False
>>                 .... ...0 .... .... .... .... = ER SU Disable: False
>>                 .... ..0. .... .... .... .... = 6 GHz Operation Information Present: False
>>                 0000 00.. .... .... .... .... = Reserved: 0x00
>>             BSS Color Information: 0x36
>>             Basic HE-MCS and NSS Set: 0xfffc
> 
> He doesn't say anything but it actually cannot unless it were on 6 GHz,
> so that's fine.
> 
> 
> So yeah, the AP is misbehaving. Now you might argue that as we have EHT
> we shouldn't care? Dunno. But basically we don't want to initially
> _connect_ to such an AP that's confusing itself with puncturing ... we'd
> connect with HE since there it says no puncturing. But while maintaining
> the connection because of the code structure it suddenly looks like it
> "lost" EHT because the EHT was not well-implemented and we ignore it ...
> 
>>> I don't know. I have a feeling that perhaps the AP is misbehaving and
>>> setting HE operation to 80 MHz as well (which is invalid if EHT
>>
>> So what's the expected bandwidth in HE Operation? 40 MHz or less?
> 
> Whatever narrowing of the bandwidth is needed to not include the
> subchannels disabled by puncturing. Could be 40, or could perhaps even
> be 20 if the puncturing bitmap was 0x2 instead of 0x8.
> 
> After all, an HE client knows nothing about puncturing, so it will
> always use the full bandwidth advertised, if something is punctured in
> the HE part of the channel that's the entirely wrong thing for it to do.
> 
> Btw, this is also covered by the spec (I have P802.11be/D7.0 at hand
> right now):
> 
> 35.15.1 Basic EHT BSS operation
> [...]
> If a BSS operating channel width is announced in the EHT Operation
> element, then an EHT AP shall announce the BSS operating channel
> width(s) to non-EHT non-AP STAs with the following restrictions:
> 
> - [...]
> - If the Disabled Subchannel Bitmap subfield in the EHT Operation
>   element is present, the announced BSS operating channel width(s) to
>   non-EHT non-AP STAs is the maximum width including the primary channel
>   without covering any punctured 20 MHz subchannel indicated in the
>   Disabled Subchannel Bitmap subfield in the EHT Operation element as
>   defined in 35.15.2 (Preamble puncturing operation).
> 

Thank you Johannes, really great explanation and I totally agree with your opinion!

> johannes


